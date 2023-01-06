Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF36465FA62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjAFDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjAFDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:41:55 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CA16A0FB;
        Thu,  5 Jan 2023 19:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipvAQX1eb1gnyCrJSO5X3tAYVuN3Yf+hiwgAV2ZoNQzExEY0vjrXDVAUXzqJ9RU1OniZdy5sPrewgln8J5I4hWjpor7bvj3PQFI7Y7mfMZQ0xpKJpsjxDazbYKPiDTyRorGd0iX3at9wfTWogJBxzxBcAwCDNOKgQPSvh5gdI+8TSGd5Yifi6FghlXTsSbR/dtoRrt3bwHNhEOQRL1dQ7sQawFb8e0a2XsbVuoNhbftOkV3BmY4RBtxQGZ0iFLt2o2gPi4czzdOAZkgQ2YbabG4v+PyO+CfcBLURl90huJ4iSmC39eaI4RUphctHeuZ9zqyTfSaprX9D5Ed2Wmuu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lc5MM1T8vUGaBjaF/rjasRhwDWKTZxJI6RGsmSNl7M=;
 b=Ckfup+3lhBy2INkHNIGaoit6FKFs85EqpVapuPnWDDEBJ3wY62NTsqS+kAdPb8CZ6ZMnwr24qJzFHTuk9CeYO4QQ9OhARtQeJLqg6ZiVwakqOLabmKVKwmqyP/QfvhtnSQQ9U+dc+ypfgtUTS3cmK296bYMP5kJsnsiFrfBXUkDeaRybFjRDSEai8P+l+VlZfaFX2tXWcDkkJvRccW6Aqj11iBWBYd1RDqFEJIKSoeBxcq6iqPrxDF6/WsIqiO5dMoN/yRBIRBRFzYo9h0h1XTnZQBmBy28dqlc7j8qlg28pwsGI/X3vzX8LH2pY8W0/b4+XXEew9Wf0X8IA0v0THg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lc5MM1T8vUGaBjaF/rjasRhwDWKTZxJI6RGsmSNl7M=;
 b=FfYtzZd302JtFxaUbdlwWmIxm3AhEegPph9/NxtrJwECvHsUpSXqM8mYbSo43WX0UQjXcHaxfvXBI7ryjH6wdqlS2q4jRNJywbrKzUvNqrjD1pgxGV/pgE2w0dsxJOspEl+isPPfMOYZ0xNeW7dvbk/Fzj+p0SGl+zkJe8HB9Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:41:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:41:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] remoteproc: imx_rproc: add devtype
Date:   Fri,  6 Jan 2023 11:43:02 +0800
Message-Id: <20230106034305.2868740-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
References: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db7f10c-35d7-4d14-54c2-08daef97f2ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4QGogK0i9ri8FlC0+YPIgld5HNEeJwUDdkdwe9KrFeaMLzizgfx55mkYpc/sZTYfuCFWnTkpidTjkTj4IS/sw18tcUqSMTVlDqoEG/OPDgZrzdfpN7camCm5Qx2wDORKU4cpQe4V8HcsAqbEf7RL7821y4M2VZhu29dxZt1Hp+LwOGgUTTi5Zym1cXyVoNrioAeapQPszTJNg9lr6yAyZMC1TpvTuhWmYAReP8cc5uq3cSnpoWFi1qtN73KfTd9BxT5P3gYmuhUB01FA3mh2wRxjSmG91uvrCVeHvH/dZ0z4CbRTgSoRfVCHV84Ompu9qlT+p5WhJj7C3jDgAQnekxfKuWbTqYMqhsy3ePRpFbZY7SHqlUcd1/LmpOSKYXpt2sMv9eZAbXD7Qcy7GIvoQVU54g7KJIvQ8P2INYSwfKVmozBMzRWVZEuz8WuG7RbulDSwQTt3UfGxTS+ZBfL2xl6HZ0yvHVzFhEBJs/0ivlmhXu7acRNgEkWaBWdoHWjHQw05oSDosQzCbqK1buZKJ1zXXykQnVIEXyovThf2WnUe+bllNz3nx7Ba+HNFyeXFzxt+kA1JOgNUDnYP6phro9diNlpT+QSy7fEZrXlRC2hFImLUIzXcxkTowsuO5tQeYsW/9Gs+pAkYJ73s04FA1tlaO1FYucGXpZuSevDQFHWgjeYu7Ws+8qixNE8TKvJTIj73fbk/VkqCa72Kaf1Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(38350700002)(38100700002)(6512007)(86362001)(186003)(6486002)(316002)(26005)(4326008)(8676002)(66946007)(66556008)(478600001)(2616005)(1076003)(66476007)(52116002)(2906002)(6506007)(6666004)(41300700001)(7416002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDLkAeigymkDvIOY/r5FVeiaOkqwEZBs2WD0pRslphaTVdojrzP+4/RScN95?=
 =?us-ascii?Q?mIUuLuiZcg7N6TmtHQUTfPpBgke2dbcVu8GrgfHRYhXNUEDMRc5yklmlCZyE?=
 =?us-ascii?Q?uqGcpe/gnyN0iXxjyHhR7hq7YTh/uhb6RnmI4b+4N0Xux+ipYRhqhpwHnDky?=
 =?us-ascii?Q?Qac/QJb6yEqMMYmhja13sTqfEWC4fN2sW8rLLQElUi8fJ6zbtqyxZcGViExF?=
 =?us-ascii?Q?Ul/nCk9hjUFHVCGL+mJbsj+tlIS3uE7Q/L6b2s3tEi33G5fEZO1OoGfnR4U9?=
 =?us-ascii?Q?lMbN4O4QL5BIauvwdNpnxKxBYmo35Cx1HWiOUQh9uJdsP2p8afWqzmIggr3v?=
 =?us-ascii?Q?jYEmYi4lTcU+kdG7gHxEv3u4jypfr4C0ittA2KDg6bMcVBWA+0uUCSoQ57lJ?=
 =?us-ascii?Q?7nhzOPZykOCKhuwx6ICrHtP7S37dDxJz2n/cuiwFATnAWeazFNrQgC0eoDaX?=
 =?us-ascii?Q?MHcimVv2KX4ysDeog1u92KE+dfYiQOY8WymASTuUFk+zo9y8hOmpeE3ktbxM?=
 =?us-ascii?Q?hvjARDZJuuBWfffZOcqruwkuE2Z18WGpDJwdyIYgTQZwXfI9mlLuUiun3lr5?=
 =?us-ascii?Q?5B6nA8eI9U10ghjJkdyogUBZXXyhJVErJB2wiHCmBV+lU9a779ve5QICt2Ml?=
 =?us-ascii?Q?6Tft2bGIvyfpyq5riAnxfi3j+UCSSP3rbyTYfQge6+juhfUzMODYBpNuzMiz?=
 =?us-ascii?Q?zUgJ6pZAZ7jCn/W752yIOEzW0LEM6TnWFhiQclmwNcTbP5YNyObwSOdF9asD?=
 =?us-ascii?Q?YGm+GZulvdWjPhoRGpY+W/Vn/qKR+Nnx3PEdsnhoSr4sMYPMG5cEroHUnCN3?=
 =?us-ascii?Q?j/duvYHWg9lfNXJJKb8qBj+fW0qPI63Fnav2gA7xN/FW9C7xnnI3u5jSMtOC?=
 =?us-ascii?Q?POLtSQccC6Ti5yXLVP27oDsIyVRYvhmOIs10l93T9OMM/RxlxriakXUZPmP1?=
 =?us-ascii?Q?FDBbVaJIl275uMpNuYpj3OHVNAH6X/YdVrz9JPCecs91U6L5ex5ki2UKxkRo?=
 =?us-ascii?Q?pJrpbg48nKGmQPmOUdDaK/CSkPIsUgT/VU5Pf7iaiLpYTfLc7tpW7FiVWPqr?=
 =?us-ascii?Q?MQxnEYD7OlwrQtKeA9G96nLsnV+vlH3xGCme3BWvMke/PggyCNTFfzN/9pgo?=
 =?us-ascii?Q?Lw1TZsXo9wnaR02jjO33hHBdqkE7W9rylHqBm4aQcz5o8aivuCoUWzmYlK7c?=
 =?us-ascii?Q?Y4xB8DL99sxX1+WPbOcnLLcFPsR4cl/YyZTNtO2X8wobxoj4EcWnu9XBoPDJ?=
 =?us-ascii?Q?mwCzSza5O+Cuv/dvUCtyiX9ja6inSPNJDrTi8ebXcMwlDasoeMHbZGyu5fdu?=
 =?us-ascii?Q?mcPt/xAkwRCmRh9CRqwtdTAeJRXg79khehDY3Z8XMZdK+ydcZf2xKWdf/SPn?=
 =?us-ascii?Q?4BS0lVMaA8yB/097ITVHBVZsA/9GtM4ke87wEA3b9fQZ0A0L3ak54Fewjo2F?=
 =?us-ascii?Q?A8XkWiBI0WDtosQfudhs5ga3kKVjF19e+RZjsMoI7mzakIh/z31VAnewPQ/8?=
 =?us-ascii?Q?R8spv5BHcClUfAZXL/iGvZOnpdX2hSQpSEMTJrQAFHRk4//gQFwWiXUKVLnZ?=
 =?us-ascii?Q?NDHxc1Py6jE0a/jqWEdcTCH2N5Bz8Bn0JMIeavij?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db7f10c-35d7-4d14-54c2-08daef97f2ee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:41:52.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgytj/opKYnAJ/yO4pBzwTAzbusJsShgZ2sPKOS3rbsnDFAb9Y6oFbw7u4dqj4g4uYvdpB+lYwsgfnwP4UrZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
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
 drivers/remoteproc/imx_rproc.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9fc978e0393c..8a282fb67a4d 100644
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
index 1c7e2127c758..43b105ff0175 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -26,6 +26,11 @@ enum imx_rproc_method {
 	IMX_RPROC_SCU_API,
 };
 
+enum imx_rproc_devtype {
+	IMX_RPROC_IMX8M,
+	IMX_RPROC_IMX93,
+};
+
 struct imx_rproc_dcfg {
 	u32				src_reg;
 	u32				src_mask;
@@ -34,6 +39,7 @@ struct imx_rproc_dcfg {
 	const struct imx_rproc_att	*att;
 	size_t				att_size;
 	enum imx_rproc_method		method;
+	enum imx_rproc_devtype		devtype;
 };
 
 #endif /* _IMX_RPROC_H */
-- 
2.37.1

