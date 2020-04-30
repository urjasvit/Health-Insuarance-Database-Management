library(DBI)
library(RMySQL)
library(dbConnect)

#connecting to MySQL database
mydb <- dbConnect(MySQL(), user='urja', password='password', dbname='insurance', host='localhost')

#Listing tables in Insurance database
dbListTables(mydb)

#retriving data from claims table
rs <- dbSendQuery(mydb,"select * from claims")
data <- fetch(rs)

#retriving data from claims table
rs1 <- dbSendQuery(mydb,"select * from policyholdercycle")
data1 <- fetch(rs1)

#plotting histograms of fetched data
temp= data %>% group_by(Claim_status) %>% summarise(Claimed= sum(Amount_claimed))
ggplot(temp)+ geom_bar(aes(Claim_status,Claimed), stat = "identity",fill="steelblue") + theme_light()

temp2= data1 %>% group_by(Type_of_cycle) %>% summarise(Total_amount= sum(Amount_of_installmentcycle))
ggplot(temp2)+ geom_bar(aes(Type_of_cycle,Total_amount), stat = "identity",fill="steelblue") + theme_light()
