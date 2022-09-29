Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50D5EEDBB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiI2GQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiI2GQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:16:06 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50077.outbound.protection.outlook.com [40.107.5.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744112DEB7;
        Wed, 28 Sep 2022 23:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/9HFats6ZAre2Mc2geqptKFvU4wL0YGIyEv2lL/YDaIHI9wU/nfuVhXMNsESIgkHGOpdSNJt7kBF+Za2S6zML4hVK4pswdD6eTzEBHGyURgio4Sm8vFinyiebOuoc3ArhKEIqeo13lRR382zZqaKfYbWGvg6Wj8n5IYOL/NiLsp3C9kp+HWXeg8HG0omVFkjeVsJXRMzEzWDfVXiLrqcOu6UzWuqKS6Qn8/sFs2qNZ/e3n+pgKv/MQSzqhtfjzuHG7DnKixurtDUrcQTi27Ak5g7p9rk+ItOfSO0z8XCKe1Z8GCa2ZE9jEv/U2ZArgWtOHztcfxRjupCQa/PW8Ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCd02oQAg3c5RDm4dNUiBlHsyeWswp35ia489iHLRhM=;
 b=BayZ9mHUfl4ShI9S1x6lZ4UW1AzhHpXjDWbtHZc9W81t+uL1dPZm+pbKFdudT2oAf2SBWvDx64RwrXqs6zadW2Fe7qLhjCs8TJDoz8L5vPwUY+spqh2byJfLYR3bcZBNkd4xHf2vEFRtp44r31lLnxeiPz1nqNLFH1zvY6ZAeWRjweAmsJHSUAUSDoGd1+FIuPgp+3lCr6PHC9s/g472qyeWWFxCbIFAXRJsEef4Ve9F7D0bXEtfZAebs0RCS7qOq5pwR4ko9ztuDkjAlR5/JhejX3JXeyoKmzMz7ahxiu8yT7jAPtA4+8bGXc/2pMKCmzn0CbhBwXPIxFCBaS87OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCd02oQAg3c5RDm4dNUiBlHsyeWswp35ia489iHLRhM=;
 b=TKqugqgwnQHb6SjADLY5w1e9CH1Mzk1z9nKZZMXp3wvSjfUbVjwjNhT+cNzNuqUb6ASDeUW1HBv7XNQON7S2bGc+4+RwAmFr4V8dGoFdvn1E+TMG8C9Qm2/pQ0dxlgP8mM7DGzyVWGS4lVB/2V92RRBiC6esAD2AYYGJLFd5fjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8221.eurprd04.prod.outlook.com (2603:10a6:102:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 06:15:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:15:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 5/7] remoteproc: imx_rproc: support i.MX8QM
Date:   Thu, 29 Sep 2022 14:17:02 +0800
Message-Id: <20220929061704.1571746-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: a15b5d5c-3568-444e-a385-08daa1e21341
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECvVhqLnaDlBs2rLjrSY9jINRTjHKvsOVih8dIpUe1HuZzEIiBtxl0iOLYJIpfeQvMLffIubidqPcUQPAJpwfVpb/XkXE146dQ32SiYLCf932ph2JdIlHkMpPi4dhpdTsodimDVzWrEPnLipp3tdQ29aZMweMadNivUTW0/YDWoHfnAsUcaKfaHHWUkgtrMVhME0G5NYCnf6nnAsCwzRtjy83dDomRuxLvl+cF8nZ8ly999FjU47/BnLo+H0Lm64/K1rJtnAStJ5HYjYq+cfmtFmdQCVDZocOB0afX/Nnebhs4gplDOEVHL/PUAxQsrIRsE2hlUhKs//rer6O0yJ0GdygpCNiceZN+q5vqt1orkmKbkB+NMDFGWoHUGaMicKQER+i9nDzqlHFhMPpn+yJ/d28Y5cuT7kktBs2gSXdoyPY3r1ACpHJb7s9mRy3miOnKeTV6RnIB903xNJS06xVypGYsUtc31hbpfCGIUG/iOFIwabdPDYfRGJ13KT4Smp4q1VX1uZiMwZn7douVXSQnaVinJP0yV58/OGqDSnB6r/hMuXsx3/zEMEMzFlYRTdd8TSxctmLelvRFUfmX6704f8LR8O6gjDrZ2XUoAQ8IU5mYW/MJ9JTuXEgRvalxVNA4GWaI8uiSQzRBPc1fz12Kj4BvFfooMtYymL7fSwiBdOkhbd6BDPQb4dysHwvEZzMx7Ofwos9Jmj0viB+fjaxW+xxfUYgqayEKdHoTkPqQPke7xrOgOJwp5WmHdUGrNwZPmM34MysN8cYQhZSiMLRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(26005)(7416002)(5660300002)(66556008)(66476007)(6506007)(6666004)(41300700001)(8676002)(4326008)(86362001)(38100700002)(38350700002)(2906002)(2616005)(1076003)(186003)(83380400001)(6486002)(478600001)(52116002)(6512007)(8936002)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGXGyLLjRiXXb8Pc0IFILxwiiPOj4R345pBiHaCHM3/CvbVKoVqx9hVLco3o?=
 =?us-ascii?Q?vNtTw2nrX23BWXX2nERyDXJoGFpOHfaRDTThvkVhzgiLTD+jKsexK/AAE2h3?=
 =?us-ascii?Q?hg9U/YmfP4/f/71uQUlk78NL9H5u/2DFaokjyZFGZMTsj8JpZgtbhVRN1Nmn?=
 =?us-ascii?Q?/BVWQElqUnKXXmzSWk3gDbblNbEaR/xok1omh50IePzFqAvvJIrCfHhvYxEb?=
 =?us-ascii?Q?c5SLG5j1j8x3N8tbupdi5r3qMrUenVkr7asxpXWIvQ2SXnh3/N7rNHiy6+gk?=
 =?us-ascii?Q?8u6FJ5VklevvqaorEiChPjUiQwyEBlBRtNEDwFuKpCSgXOxcu2uv7fqEjlYd?=
 =?us-ascii?Q?DsL5Mi2OVusGgsa3La3Wdna6AR2Xhac/cmKeQwBcicoi7DxjQ/o+4PXNQ4qm?=
 =?us-ascii?Q?usJcko6spVFbB+CU6q1wkOrF6Gi4SR2bDBwmy6jmfJwLmm9ItgBsphsQPnIM?=
 =?us-ascii?Q?uBFxvin2MAD9tShyJ6dOP44RvNOb+07xv7Mo/vXAisBOcNfmajly5HcSXPuK?=
 =?us-ascii?Q?OnW2mc1yRWuIbc7iWL4zYIZmvsMU0c3YktipOf9q5DSd1kM3ReLnOk9xg47Z?=
 =?us-ascii?Q?XLgGdhnH40bwspSHGqPVZG1MkFsblnc82oJ7WbNz5Q9UwpG4cWyeGn1Fh6ms?=
 =?us-ascii?Q?H4RNBpTCxGloqPhIUPk6UmfXLz8B5an6iFPipfHPWFpGF0wkvkcZOnf3Q42V?=
 =?us-ascii?Q?IJbNtFUznwF2BHPitxWf3kQyysYNW3vrV/2ybRewxs4G+zZQzHB6NEDbKkx1?=
 =?us-ascii?Q?zJhAbY+YRLit7LAkjP8d7ApRysZNC85w1IamyVXSqR+iBKtgcNCCLE7RKV7o?=
 =?us-ascii?Q?YrG3O42eixdiDHm3FavW6s4Cz6wsKzpg447VuuZb9mKjh/4MaVX9bS22o+Az?=
 =?us-ascii?Q?2lNszlGxx/u/4udeIoZL0fLyDjVBpFVeYy6sUvPjm/1QT4TdGSawtGFbH8WN?=
 =?us-ascii?Q?iabXnTtSNhXXOYu5p+T68IvnbHrUv96K00ZPb3FRCd6q8Sqknd71M/H02Fh6?=
 =?us-ascii?Q?bKwFTPllIN+sqhcOadLdT/V+nPZla1JNrhNgrVCJ8qU0ZPjglzEMjc8w3TtP?=
 =?us-ascii?Q?JX4NlTfOADeb0Q12ApicP9TCbF9AZ7uKj12pA8XXgSHIz1OXVS6nB5vLxCIg?=
 =?us-ascii?Q?DcRghyqzdJV/LNKC5WP3gcfrDZibkfQ4ksZvwI3mt/Xl30jQg8Q2tCAykT6p?=
 =?us-ascii?Q?qFsgzA91BZiA2bOf+KRY/Z5oHkr4+lNQoBsNbA/TyVp7vxaGWcJaRICpUwO5?=
 =?us-ascii?Q?JMhMY6Wd8AM7wxHl/V5fnrRA/LtXlJ6G80d/kN8XHiVTPcyzBHEOO8igRfZ9?=
 =?us-ascii?Q?BDPnnKGinfN1lQd0HioXp0I6IaQo12xQayv8jo11I9fBjlChnXtPfu2tDw+/?=
 =?us-ascii?Q?IZY1p19ClK8Zwnb0qfEmaQKjv/QtZQleDjE/I5uD6PZsgqEmcY0TcWSZmJdt?=
 =?us-ascii?Q?oMZ4WE3upWmA12Ajyb5EPwfrFRejAmsd3GIKYMqqXenLyxfqJhBTjj9fIixT?=
 =?us-ascii?Q?eew91cngNfl42koITpxVWWFZp3LfljP8Tf21RgMQXIK7uj7O7uWTSLZQFBv8?=
 =?us-ascii?Q?oAYinPLJv27l3xbikAgTR45KLbvoDHnuSQiAG8rq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b5d5c-3568-444e-a385-08daa1e21341
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:15:58.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOsTdDh8M2ldiZKzYXyphoxl6rnj9PjH4r0JSP7vuAmHrxJR3L8uLtx5V3EzI6F4B/xxywMhLl3+dCIEQTjG3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8221
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
M4 cores, the two cores runs independently and they has different resource
id, different start address from SCFW view.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7d2e11aed0aa..8175c4c9aa22 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2017 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -75,10 +76,13 @@ struct imx_rproc_mem {
 	size_t size;
 };
 
-/* att flags */
+/* att flags: lower 16 bits specifying core, higher 16 bits for flags  */
 /* M4 own area. Can be mapped at probe */
-#define ATT_OWN		BIT(1)
-#define ATT_IOMEM	BIT(2)
+#define ATT_OWN         BIT(31)
+#define ATT_IOMEM       BIT(30)
+
+#define ATT_CORE_MASK   0xffff
+#define ATT_CORE(I)     BIT((I))
 
 static int imx_rproc_detach_pd(struct rproc *rproc);
 
@@ -101,6 +105,7 @@ struct imx_rproc {
 	u32				rsrc_id;	/* resource id */
 	u32				entry;		/* cpu start address */
 	int                             num_pd;
+	u32				core_index;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
 };
@@ -131,6 +136,19 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
 	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
+	/* dev addr , sys addr  , size      , flags */
+	{ 0x08000000, 0x08000000, 0x10000000, 0},
+	/* TCML */
+	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(0)},
+	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(1)},
+	/* TCMU */
+	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(0)},
+	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(1)},
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
 	{ 0x08000000, 0x08000000, 0x10000000, 0 },
 	/* TCML/U */
@@ -281,6 +299,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.method		= IMX_RPROC_MMIO,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
+	.att            = imx_rproc_att_imx8qm,
+	.att_size       = ARRAY_SIZE(imx_rproc_att_imx8qm),
+	.method         = IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
 	.att		= imx_rproc_att_imx8qxp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
@@ -397,6 +421,17 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	for (i = 0; i < dcfg->att_size; i++) {
 		const struct imx_rproc_att *att = &dcfg->att[i];
 
+		/*
+		 * Ignore entries not belong to current core:
+		 * i.MX8QM has dual general M4_[0,1] cores, M4_0's own entries
+		 * has "ATT_CORE(0) & BIT(0)" true, M4_1's own entries has
+		 * "ATT_CORE(1) & BIT(1)" true.
+		 */
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->core_index)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (da >= att->da && da + len < att->da + att->size) {
 			unsigned int offset = da - att->da;
 
@@ -844,6 +879,11 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			return ret;
 		}
 
+		if (priv->rsrc_id == IMX_SC_R_M4_1_PID0)
+			priv->core_index = 1;
+		else
+			priv->core_index = 0;
+
 		/*
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
@@ -1040,6 +1080,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.37.1

