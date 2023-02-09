Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA02690075
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBIGhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBIGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:37:21 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336740BF3;
        Wed,  8 Feb 2023 22:37:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOMCFvI9qUGGU4Y8UR+B2q6iukw2ZSQSWIqmGgmKQAE/WiaRuLeouZQG8Izk/1yzPgh+9GIvu6d0s8IhE/YzM78COj+KSbxbMrQ2oYr33uP571pPVm+l8OcvbGZw0qgVcfe3XU6byrwcCMpGI+RvsBAT8Jw5t1FzslOfefPaR7YkXX1Xf1HgTSTG3W2x5iMweRbBl0l5tiNZYQdX0WsTgAd+Lq5r3eIt5U7zwMSAmO57FBnZFZLaneG9UpCTDT/v2GLUAQJLNxAZwyPrXIpIjQ3UTWYsntBA+EqeOo+LA602PcbaonM+tABgV19QNVOCKB78LMxkWNvtqq1K0Vv3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jMqA5XJa5/YY3j6FEZkYZbyHMuRyhgPXNAMk8eUlhI=;
 b=U5mfU4e4HrzIvVa6qf2zxaDqmijwt4AlmMRqdsa3GjhKHIGHxOmOcw4J+SnlXQ15fhq+adupC2GR7P6HpLB2JDYEEmaB020rX5y47aw8fP6mkRpXdPb/MOw0XokkDRiQJ/5PmzcFnidPIdz2T+qjrvg+EZpsD4g+4kNRQzHvATycH+ed+vMQi1vDUYixfxnaUOi4/9bKNzEpsPjG3HGcnPSjCZA2fDOYGR/kZHWXdf+Vbp15omNhnTle57dufz4W9avn5akhFsukIsnWqh4aFZ9Rup/cS5L2cXArPAtJeXdS5/ypEotiM1Qw70In/HAbstr0rJJ9iiFEy66ZhYk8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jMqA5XJa5/YY3j6FEZkYZbyHMuRyhgPXNAMk8eUlhI=;
 b=ZeHciiqHKKsN3eOR35BD4AWwk30wzgQyxaq8wiruyG785QWBi5+jkHvuzN3NN+q/iiBzAotBt/46hLfieVYPCS4C5hvByLFjNqxjyuWaBoPNREyfioVJXd//kSxfgTVtNDGo6xdFWOTgPLoZAXpuxFbCxNRPaMX3eyHCEQjcEUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/6] remoteproc: imx_rproc: add devtype
Date:   Thu,  9 Feb 2023 14:38:13 +0800
Message-Id: <20230209063816.2782206-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9b1509-9a05-4bfa-05ff-08db0a681571
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUhghTfdTNRz73TiK5AMCSmdlLIb0oAJ/6WU4zICLauQRhdu1GXIKWirJRrLvzo6MjQNKARkudFC1SAqq/M46ANZxgiV7S3fUGtbBPKMZ8L6mF1kZZ004cUpewUuGMr+Skw4vNUgnn7s/RTmtikLZ+bLjfouwIdQ460nyDr/WH0BB8i/pR3WehSwotOCqmO8a0wtRDSPA1K30v5tUjhwSrUR8Edq+A/gNSQGqg5RTPQSuDFNKRCQINW+x6kCrIAcXL23D+9kGaKZRXblIrtBj2wa7bix/2y9gD+fNiGOYSojo+KITpjwbhv3uShaPTN9mmXtfTe7CozIfQPtJQoM87v/jbl3JNKrsnaa1AfhXSw/J7zRW7Ju+bXa6IuC7jBEnfHqWidVNkEqjpHyUUdPjGr7AiGvjgE3mDKIr14Z3HlhSHY/iu6csuuI9VKaMq03AS8BF5oP3IiJhRXZ/jDT+hzD1sqvgx2UP3KI1/o+WUkNkZWUGg2UUejkh0yNIot+gQnQa+0+wNQc9YJXKf7dg13bNEx0pmpke8DrINQv4LT5uiGbZBaN7AZJccN8SpkKPpI72inJPhTQlfaGvTI9SF8LHXVqPVFVh9g8wPqhOEuLzlsZdn6sMt2Zoc9JHvvzyIJWlTaCRzFcyRiW+coePSg9/wwaMnZXU5KO9Da4VE9sA/w7PmtoDukstKZtp/I8NxNA0pM/o7A8OUW5HKvBdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ri4l06YnxKv1/Dw6FXzMl+IO6lu8lGP/AyxRN48JWV+V+lAGnlC+PI3MdDjO?=
 =?us-ascii?Q?hFnkti2Zkcytr4LFOwq6GK3nIJZg46T2h29WBxzHlW/iUcKqJmsM5eg+GYns?=
 =?us-ascii?Q?lMaa0BNV1jTsYAC6TxDRJfzIvbkzv/M1OFgNuIOdqviC0D+yNWhydfXIPUaK?=
 =?us-ascii?Q?pF85DbcSJYHbaYYKSkvjYla6QgiGpmXrQz4Y2v6fu4pu9vscAVdaFPZX6kJf?=
 =?us-ascii?Q?Gq1q35JQkq6WAUChJMtIoCxpPimaZ2bq5rC1AD4Xj5+oBt5BR2eIqfqLjmD+?=
 =?us-ascii?Q?wLp1oReprPnvYqsVeA+lJf3PaTF7FD4veEimIdFNgyDAEe5gOROKK+lNTf2v?=
 =?us-ascii?Q?fzNTQHlpD87qORonwk7oLHOXxVycE/hsAoHQs1dnzB3gqQ8SPimM8b0MaXXN?=
 =?us-ascii?Q?YsWUKbFnoyZtmXnqXS46Ruaobl5O34FiLhf0LkJ4TidiIKFVp1RWoPgaHu39?=
 =?us-ascii?Q?W4stwkzYQ+MghBakdH9873beuja5vf61z57E9E/LoITR+iSGpWcixJstV73f?=
 =?us-ascii?Q?nMum10ExXtOryx5gObi1xbme8dOzJ7yPLsp642m64nlDJY/9Id12Yfn4LTW+?=
 =?us-ascii?Q?aNhP7nV/wi+4fgmk3xenDuVrDYvy/QxVLSFdxIb3hwfdHIw4p1LR8mMAdpE/?=
 =?us-ascii?Q?A/QP8EmJlF0/7QgWTARYFsxXVbTo8kp3Uy2iUWZ9YH3Egm1SebpoAE8mU42q?=
 =?us-ascii?Q?melC92zF0vWvd2QUBkY1d1M8BF7lwda1LaOSw8yerW0CcajZ4Vn1GR1TlH+9?=
 =?us-ascii?Q?M4J6iQC4GiSok+UA5dQuT0zwEXyfdQrFPZQHbhq340HNdjXwE6OP4vCBQXg7?=
 =?us-ascii?Q?sOPmQXicH3nxMleBa9JsEej9EhruXVH2Iv9xFY5Mvz+JAavzx0PLjqEfPwfb?=
 =?us-ascii?Q?2QwLz4gf/YUtHpCs1rct+ifgV6lOacMD2qJdKvay3WOah9cBkGAoL5oZiUz7?=
 =?us-ascii?Q?DbhHftyM158zgXKoyrAcJ8cxAnOl4Mzk603aVfXnJapOvyYcweSFdImcpfdB?=
 =?us-ascii?Q?JAP0h+6miFKVA7ucWylBo+Zf8ovVAhijWadqeTrdV1euKoZ/uYcl9NM7JHG8?=
 =?us-ascii?Q?nihlglui1DoHfxVJUQM4uUZ+k3CV48/99SokpMDpk8HdjAbEgvEHOEu0v8Mf?=
 =?us-ascii?Q?1SpqYkgRwDNYJ/E+4WVmtpEpF2Us51raGGMTSADNsJWjjgN0OnvN+qe4YAkb?=
 =?us-ascii?Q?enHFcQJra7FxwyJ4twXoLlQ9dOGCF2/hM9altc7yuhW9z0D9EfxkkQOHAwRk?=
 =?us-ascii?Q?C0RJ/teqmPe8WgKSuElHBNH3EyMXkTqIVPD+qfhqbumsxTQfRrYCcpty8xz1?=
 =?us-ascii?Q?5klc2LmPmET9WB3cnIjtIDxGi91yOIBqI2/lMM7igOWfJNTGADFww7ml4CYl?=
 =?us-ascii?Q?uDVxvFQpmzqknPrixxMVOpH93nZUFvH2Cg4AzAZ5e9SoNugGF5GyUB9bnQDI?=
 =?us-ascii?Q?LrGA7oVDh6fp6zP59EQm92opXOiHOZMXY1AQ7eq5LdJ56J5DOno4W1YROiu0?=
 =?us-ascii?Q?7AR5ejw5mxIK+PT3bviJwepbl/RlzNaFjT30Crj23TGFU4AcXneXfHUXWVvW?=
 =?us-ascii?Q?tiTrI8y26s9DT2ymKo5dfOPbStQ+KbXQ+Gkzi+BP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9b1509-9a05-4bfa-05ff-08db0a681571
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:15.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPN+ZacM+HFzh0yuW1E8frzTIF3Zx0OH2unh/oh2XgpGoyM14V6Q6eLG7wbANi0s0pWjS1lzwARsvvjyjcGuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8M and i.MX93 devtype which will be used when parsing the
firmware.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 3 +++
 drivers/remoteproc/imx_rproc.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 6bc2f988fd4c..13199e593b47 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -289,6 +289,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mn = {
 	.att		= imx_rproc_att_imx8mn,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8mn),
 	.method		= IMX_RPROC_SMC,
+	.devtype	= IMX_RPROC_IMX8M,
 };
 
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
@@ -299,6 +300,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.att		= imx_rproc_att_imx8mq,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8mq),
 	.method		= IMX_RPROC_MMIO,
+	.devtype	= IMX_RPROC_IMX8M,
 };
 
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
@@ -349,6 +351,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
 	.att		= imx_rproc_att_imx93,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx93),
 	.method		= IMX_RPROC_SMC,
+	.devtype	= IMX_RPROC_IMX93,
 };
 
 static int imx_rproc_start(struct rproc *rproc)
diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
index 1c7e2127c758..572732f6e2c6 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -26,6 +26,12 @@ enum imx_rproc_method {
 	IMX_RPROC_SCU_API,
 };
 
+enum imx_rproc_devtype {
+	IMX_RPROC_ANY,
+	IMX_RPROC_IMX8M,
+	IMX_RPROC_IMX93,
+};
+
 struct imx_rproc_dcfg {
 	u32				src_reg;
 	u32				src_mask;
@@ -34,6 +40,7 @@ struct imx_rproc_dcfg {
 	const struct imx_rproc_att	*att;
 	size_t				att_size;
 	enum imx_rproc_method		method;
+	enum imx_rproc_devtype		devtype;
 };
 
 #endif /* _IMX_RPROC_H */
-- 
2.37.1

