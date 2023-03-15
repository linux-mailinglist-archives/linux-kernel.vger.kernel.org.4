Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A9D6BAAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjCOIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCOIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:21:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028E25E05;
        Wed, 15 Mar 2023 01:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfxTuw+SF7olATn/OFRmT8g7Jb0oDR/pJnfjqqyzCuTBYRfr8H1cyrI2FnUydM3v+uzWj+ZIEEVIrUKkD73vuo6kKn1HthqutrFA0ilYUON95I1G9r7TITHZ2JqjM4opyEpUvwXDykUOXxwHd2JnluabT6w1ZD1BDHKnR7qjtPbx20mZ3DqHU8CzEwra1tWwKOUSkRDFGQ27pYsVeFyBF2FTZ/SzPvnTWYDoB9vLt/uywk9PS3d0PcH3bzDeUhuClMTg3tPRtQmNaTH731eCSFJ6VniBTy173xxUaOpHQMqR1UrdbC1TAa0sGl4Fh9Xl+zLNdE9Ei8yb9gd+9mMCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZhRency8aOyahpSY6tslS3NcjDRB3GkWL+ZSLnF9qY=;
 b=EwksV4P1l7bIpqBkXdVFFvS8ZQc9bt2x4wZGDNK6B1SKA3Kd2bbfwy+zRRvP7deyqeIod+Xg+nu3pJk4cmpOwYGRJr3SnLA1jO0aeB0/lXz7sBEfz0Ot7oIXIE1M87n9EA4nFhxqmRZQ/n7GGk+OeqvMsC3hepZPFOVT32OhjfVgmrmGi5O2wexFmGjkTcJFfPCtTbElYxQ/TCfsEZho0ObgvJqjMYE2A06ewWSmo/n5y8oAk0Q0BeVI9hd2ufOXE+sZqwhbjIIomicgzoxB6HZNqt9KnLhvyqrvnbSylplQd+PKYyVN4NLskEjG2Ax3GkEkf5MW0yfY07F4rmUciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZhRency8aOyahpSY6tslS3NcjDRB3GkWL+ZSLnF9qY=;
 b=pDVVtnW0EWtqABlFtMhveoY0cfirI96fZmcq9b/VYkPx/LPP8mBjWks07+JcJn1RMZa46A5WYLec1u2iO40j9hSxMKKD/R5pU7TLO9TNYdJ7b3Kj9Vr6qbcDl/ryIF4yj7qMT557Mu9N0p3ZLYqfQgr1bx1RY0C4g7ylFRaGZ+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB8779.eurprd08.prod.outlook.com (2603:10a6:20b:5be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 08:21:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e%7]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 08:21:10 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 1/2] rtc: pcf8523: fix coding-style issues
Date:   Wed, 15 Mar 2023 09:20:20 +0100
Message-Id: <20230315082021.2104452-2-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
References: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0132.eurprd07.prod.outlook.com
 (2603:10a6:802:16::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ac1106-f2bd-47a7-4cba-08db252e3b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LY7RX+cW8+JfJ5YLB32+baPeb/AatGQkuf0pM1spIRBici2mSnEXiYQfU0AZNkHa9fgRBwNdL3UaFgsqaUw50Std9MmdssxmlG/fs4oNT8IHhQeUt335DRMY/7ixjNRHXtyweIKl5Mx2DWG6cYm9K/7QC4KtUjKmvK1DkP4jIcyY6cW8TlZKIu6vrM9x4urlgVm6+MswmUSOfTeKg1r2Lmjc7wnU44z/RnU9a8L8Ue+MQxYYp4Sd3THVZUl3lQPW7LFcpusThg3h0RbjpvD0IcUC31SHs7FFPJPtZ0PmXdQOJ2QltgvZ0mPgWkPQsd3yFDYRLzBuIrw7iS8LUH+YzpdGwgCc2pgdGGChf7nV39OYWk2f/TldouhynkLAjUtRPaChGFyTYvsV65GDtuz3RizQLHUQbifdO/rMScvvVnhF4guceSpRmlxeHlQVPVJUlUalW4vKbpSlT053TTsUvVMsfr6LU54GU79QE7HPbufkdu98TgebkS8PpcTyIdUdjsDdXNBm2DL7H2hzmpeaqg8wbTlDCDrbmKsVF6GOdhL3SjE87oDP3C627IyHEMo2uT2ZkMRbLLQBecdTsQD3ABDrQJoNGwUIC0DYCF1Y3EHqUmDMuREZEOFEfL8deOFNOEY6DBZpSTp20hS7x2/CmPtBJT3T5r599NDZ4WrZS1Rw1kBieCj1vrVdlIcHR5nJI1fA/iluOwYpSaHoCmolA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(39850400004)(376002)(451199018)(38100700002)(4326008)(38350700002)(316002)(54906003)(86362001)(8936002)(41300700001)(8676002)(66946007)(66556008)(66476007)(83380400001)(36756003)(44832011)(2616005)(478600001)(5660300002)(2906002)(6666004)(107886003)(52116002)(6486002)(6506007)(186003)(6512007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTH+X8ok1zKa87ZxA+svVqEiTgTCp2OaKUU90/fKVOs69o2ECNIwd8GdQC0q?=
 =?us-ascii?Q?w6+8ZlkfNzThYeAyaJFShEAmtGLc2hYgttBwP7vvmDRvp3QJJqH+pD5D37cq?=
 =?us-ascii?Q?ovX+4fCjRrDUXEt0IuMJ2lOumvsXPqxLmLtWfQXSW4GqsMmpT9mTFsz3eaRW?=
 =?us-ascii?Q?SIm0kVe4gno5rjuIzjH8p42DyRNlR4iKVI2ldXsmFknC4VUUIk+xFOMv+uDW?=
 =?us-ascii?Q?7wtG3Jt3nsiJZpQXf6Mcsk2eJ7eL41YpoF+NGjYM2oO/hTeuAXX+FclLTpk9?=
 =?us-ascii?Q?vuMUffNoDGbE84YbwCiGrtIcdCYyLmU8u/a1LcPCOApPJAyY/XNd2/HDJB3t?=
 =?us-ascii?Q?PKhuLzMC6FDOXbTyGI5rLlbUnyE0qzTGADm0SYtiJavFWqnEg7G2+ZIES+yT?=
 =?us-ascii?Q?fUx0wvsN33jHZNKJb9/mE2AFlurUBav2f34yixSfpeoUzx4X+KjUqMW9q9J9?=
 =?us-ascii?Q?YqTyDwl8B9t/M+IfnMrH0tDc1+C9LgXlOHCf1NKBwUP56z84JgKzIm/dUc5q?=
 =?us-ascii?Q?FzgNLPomcJu30LdilG5Tn6TaCWbsJ/eD4x9Iq83HHgKb4J5XLpREMiriAUqm?=
 =?us-ascii?Q?aOhburf/BjH8FcvJsH6ZWGR2Fe1KKjL9nYdE+xlv8EDq4K0B/rBDRGMFaJYv?=
 =?us-ascii?Q?hUj/FucF744obX8LxAFCeBa+WloY9r/OQOzgwwJxliBg8sPYgsx16q1+mOR4?=
 =?us-ascii?Q?tcywUeQBtNeuTinHrN0NubfAXqZawdDVRdKtNRRSsxJQN+iFHWcEOmLNdJPV?=
 =?us-ascii?Q?DmEnfzRF2y9fM/sALxWpGAvTyhHj2eJwGKrMJP1w74K8/ZCJr3dJMRKYNQl1?=
 =?us-ascii?Q?IpHRLOBWUT5kmgxYH9PdyC6V3qYFjbNgXHthHKk4LcQj3l8ALTPEaOYVGlmk?=
 =?us-ascii?Q?9194LqsqKnNroHCj/L8WnLcaAnVRKdDpm9B17jMlyGNdVe97dkUtuo9lyMBx?=
 =?us-ascii?Q?Zgqg4t8/6nDfUG0PmsDTDMp+adpHsD9SakKWlKQ4nXRbaTYOozrfdk0h5jUy?=
 =?us-ascii?Q?rYYwgoQAj1N4luHan6iK2o4DVrMGYNHed4oUD5NSSmF6iFmwB0toU9iCcbwS?=
 =?us-ascii?Q?j5I41c+EqI7PFV4RRs+Jj6LQaAGjHMWgbIvs96G3FdLwCAL9FdsA6EXK1cyJ?=
 =?us-ascii?Q?mgL9l3CWgXqAvHSG+hYY7beGpdWC3y0pzupv2tCoL20bCrS0QC3P/AkHkmbO?=
 =?us-ascii?Q?TvVi0jyXmWREfc4YiDpd2BEF4YC+xjk1Kw7DmXmOArON/Qyy++XURPND2RmO?=
 =?us-ascii?Q?75BjV9dEqAkQY1ZpM6WgcWnNtM0bK0wno1HsaSnKz7cfiYtC4c+0oMJh3xif?=
 =?us-ascii?Q?+4UvsrEN05HDGyEW8GeIreiZykmtw00jJHjkBh0943PFBZz12xDpaAI2CMt+?=
 =?us-ascii?Q?j+VNRByEpInAbxTuAchkxi8Qz4gEsG+IMXIdtKU68GbG4ndfoBJ3fVZDQOcy?=
 =?us-ascii?Q?exDGDuWZiEiRLRULXbLNOZOvEbLmG3yuOdSBB0R90B+NR1br4p+Wvo2HruLy?=
 =?us-ascii?Q?fmOHiyb2rgcRbssV1IxoxEAPzG3pCAAeEJtnaWddGV/Z9+rGdbOyPbHFD3gk?=
 =?us-ascii?Q?2D4jLhI6ct6yfHMEbg/ehrBqiE/rPT0brwvGRfYIXYR/6Cj2EYtWCwC2Zfrp?=
 =?us-ascii?Q?Ql3g0bKSxt3F4w5+38Vrcc4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ac1106-f2bd-47a7-4cba-08db252e3b77
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 08:21:10.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCJ1yDt/91KSfMurNP3IzqQlNqaQ2/6gKawjDHZbtnofcxI9nOwTKn/7Fyvc8ywU+xlY9OP9Jb568smfc5ksjasepBtpnlpW2qoHD1rdBe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor modifications for coding-style correctness (tabs, spaces and blank
lines before and after brackets). In total 7 errors, 3 warnings and 1
check where removed from the checkpatch output without damaging code
readability.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/rtc/rtc-pcf8523.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 2e111cdb94f7..ccb5aa690433 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -21,7 +21,7 @@
 #define PCF8523_CONTROL2_AF BIT(3)
 
 #define PCF8523_REG_CONTROL3 0x02
-#define PCF8523_CONTROL3_PM  GENMASK(7,5)
+#define PCF8523_CONTROL3_PM  GENMASK(7, 5)
 #define PCF8523_PM_STANDBY   0x7
 #define PCF8523_CONTROL3_BLF BIT(2) /* battery low bit, read-only */
 #define PCF8523_CONTROL3_BSF BIT(3)
@@ -234,8 +234,7 @@ static int pcf8523_param_get(struct device *dev, struct rtc_param *param)
 	int ret;
 	u32 value;
 
-	switch(param->param) {
-
+	switch (param->param) {
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		ret = regmap_read(pcf8523->regmap, PCF8523_REG_CONTROL3, &value);
 		if (ret < 0)
@@ -243,7 +242,7 @@ static int pcf8523_param_get(struct device *dev, struct rtc_param *param)
 
 		value = FIELD_GET(PCF8523_CONTROL3_PM, value);
 
-		switch(value) {
+		switch (value) {
 		case 0x0:
 		case 0x4:
 			param->uvalue = RTC_BSM_LEVEL;
@@ -273,7 +272,7 @@ static int pcf8523_param_set(struct device *dev, struct rtc_param *param)
 	struct pcf8523 *pcf8523 = dev_get_drvdata(dev);
 	u8 mode;
 
-	switch(param->param) {
+	switch (param->param) {
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		switch (param->uvalue) {
 		case RTC_BSM_DISABLED:
@@ -385,9 +384,9 @@ static const struct rtc_class_ops pcf8523_rtc_ops = {
 };
 
 static const struct regmap_config regmap_config = {
-        .reg_bits = 8,
-        .val_bits = 8,
-        .max_register = 0x13,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x13,
 };
 
 static int pcf8523_probe(struct i2c_client *client)
-- 
2.37.2

