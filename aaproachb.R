install.packages("tm")
install.packages("quanteda")
install.packages("qdap")
library(stringi)
library(quanteda)
library(readr)
library(tm)
library(qdap)
library(xlsx)
library(readxl)
#load corpus


setwd("E:/Texas A&M")
Digital_Software_1 <- read_xlsx("music_22_excel.xlsx")
#View(Digital_Software_1)
file_dictionary2 <- read_excel("file_dictionary2.xlsx")
Digital_Software_1 <- data.frame(Digital_Software_1,stringsAsFactors = FALSE)
Dictionary.dataframe <- data.frame(file_dictionary2)

Exclusivelist <- Dictionary.dataframe$Words[1:19]
Certainlist <- Dictionary.dataframe$X__1[1:30]
positive_emotionlist  <- Dictionary.dataframe$X__3[1:263]
negative_emotionlist <- Dictionary.dataframe$X__6
Exclusivelist <- as.list(Exclusivelist)
Certainlist <- as.list(Certainlist)
positive_emotionlist <- as.list(positive_emotionlist)
negative_emotionlist <- as.list(negative_emotionlist)
myDict <- dictionary(list(Exclusive = Exclusivelist, certain=Certainlist, 
                          positive_emotion=positive_emotionlist, 
                          negative_emotion=negative_emotionlist))
#not requires
#Dictionary_source <- VectorSource(file_dictionary2)
#Dictionary_corpus <- VCorpus(Dictionary_source)
#Dictionary_tdm <- TermDocumentMatrix(Dictionary_corpus)
#Dictionary_matrix <- as.matrix(Dictionary_tdm)
##
#vector of reviews
reviews <- Digital_Software_1$review_body
gsub("[^[:alnum:][:space:]]","",reviews)
#gsub("[^a-zA-Z0-9]","'" , reviews ,ignore.case = TRUE)
#reviews <- gsub("''","" , reviews,ignore.case = TRUE)
reviews <- tolower(reviews)
reviews <- removePunctuation(reviews)
reviews <- removeNumbers(reviews)
reviews <- stripWhitespace(reviews)
#reviews_source <- VectorSource(reviews)
#review_corpus <- VCorpus(reviews_source)
#clean_corpus <- function(corpus){
# corpus <- tm_map(corpus, stripWhitespace)
#corpus <- tm_map(corpus, removePunctuation)
#corpus <- tm_map(corpus, content_transformer(tolower))
#corpus <- tm_map(corpus, removeNumbers)
#return(corpus)
#}
#clean_corp <- clean_corpus(review_corpus)
#reviews_tdm <- TermDocumentMatrix(review_corpus)
#reviews_dtm <- DocumentTermMatrix(review_corpus)
#reviews_m <- as.matrix(reviews_dtm)
#dim(reviews_m)
toks <- tokens(reviews)
dtm<-dfm(toks)
####
#dict_token <- tokens_lookup(toks,myDict, nomatch = "_unmatched")
dict_dtm <- dfm_lookup(dtm,myDict, nomatch = "_unmatched")
dict_matrix <-as.matrix(dict_dtm)
write.csv(dict_matrix, "E:/Texas A&M/sew4.xlsx")


