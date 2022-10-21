Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDADB606EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJUEPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJUEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:15:00 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB6F41D28;
        Thu, 20 Oct 2022 21:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6BgPlHLizPsoWGqys3UewIm2SNj5wKeMaAvtqrmxhPWlEYKSWTzb8v8eLAFVXFdeQwIK8z6XhBlCc5kYKsnfcWkplpFvFw5ujEuf0LpaTDOc5TD5Pew+HoiM+F3X9Z/5JNSMubRiuL/mQ7dCBNKRH8vO35RMTpXDA8HJqo01h8dlaQfOPFyjULskz+fCQovFk0/hi/9kQFdgbA2fBrvKS+LhBLYuRq5oXpiI4achnHYilW5XDOo0lFJ9YzqaIXNj26IgLiq9M71qlzOeJDFuvRenXHIxi+0SB9WPCFRIMaTGzdzqIrZkuuzpKiT0y3pwPngFSvD+13XSbEhoqUt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvxEeqqwY7dac6HsGnLTQI13mhd7JygOFElQG9WC7TA=;
 b=JGMA4uELXPfKtKwhnZSsweTF1Lmram4d72gXZcx18oRhboR+SuwK/VNR3yDn0jQTuGIT+/eddO9PZ7i5fJI+Q5Mcin0lRTm0J9+CW/v2idclBFlEhlBV7QvJDDvx4gzs0HPLcQBEPihf8d1CoJ6XkJ6a2p1Oqk/WmToMfkmyxGS9h2CYgpEwyCgHqQ5I832EAO1RKkteVYJ86mqKHZfTrpPMnBJ+Xbzsl4QzAcbv6/f0BxifsQAm9GVIIhNHYvNw75PF5RcTMVZzOJI8uFUvSb7nVocdiUKX5IUZh+GCkGU5SaZfs/vkHjqTpkd8dmSKV7Db+AsAY+tiAOUZ6rzLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvxEeqqwY7dac6HsGnLTQI13mhd7JygOFElQG9WC7TA=;
 b=GLlyIUk0+woEaGrxBmLttbLtFrobOapHqhh2ZAgx/RyN6iaRuX14EI9KbE0/ZLLO/BqB2UvCSrnEjxEJ306zlsk+lKHO1GAaYkb1Hs2Gr8Lx6uhPeJKMXaOAV4ZWzrAEASfvXPAXc99HUPLN8UFDdFDgB3kukrZ4OvtADRiaXaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 5/7] remoteproc: imx_rproc: support i.MX8QM
Date:   Fri, 21 Oct 2022 12:15:24 +0800
Message-Id: <20221021041526.3696483-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
References: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: adcf1da4-8204-458e-ce10-08dab31abceb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaTbs+hORplqdsLepUynknwDb835qMC6PKTgIxj1J2EhjykTHQ0mYbYXUaPuaCodpwYaUaTPHiFVh8oaP/tVwqZOpMZuvnKY8bQg6uVVYo8yKaCJsUBHAfDEBy6stEhB/vlMuveGgSGWztJl6b8QcoCZJBDytVUA3M3bphOp4Oov+WIKLAq1Dfc9xh0C6jYHhzhZmnjYxQyoqu9IEWPB/JdRZBNpyHFt67y23u6QkGDA8Cxy3AG9qn1BbXhoBUOO4OdJ0tYH/Wxz8Aso1TSoViYMOFolnnxDBtoWZBdEFuY3kz8HaxHepEueZb7TP5BP/1itVRnu5PTVqyiNOzJex1ZgmTjOycwmIrMQKu0Y2YcYEEYXIu7RALBZIE9ndfkZ3e+qRRM0FGAJ8vwLACpv4SveR30gaUbkDYRIE2t2m5keBZvfv5Cx6rILihbx57xLKcTSB/BnSuJAqonBARJWlq+isegnt2QqNiH2PwohKu+JE1cF4xrjZFQZ4zFvpWEjUlPP2bv32CzBXYKzmtcM8lEc1j4+00B6D75fBiqjjeuiPS//2soTAts7f6keSC1N4Jh/NTcKNRwxsOeEN8OIukP7yMUk9DHWjMPVez/Vb+XDSquhAYEXACVa4iW5nnpGC7OsMw99G7OQYSc6u2N577Y/Nr0RYIKaDuINVGlq0P8hzd1gQUj5FPlH3pgN2qQZLyE9nz7bmLyFbQzJluHUGJ/uld0EpzoJI+G+xbehW1uwaST1/hF7wwQwOxreAjhIVymf/SvaouzMTyADOfL7aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(66476007)(66556008)(8676002)(66946007)(86362001)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1M68zbrcHdNzp0e7t7GWPvPlGkc7EPHnt76lJ8ZW2oDF92D0EG1qVH5rtt1?=
 =?us-ascii?Q?EKtLiNoHNitcGLIlhIc2ar+GV/VSMIkJNzH/R6gmgQHNKDbo52L03HDxv8O2?=
 =?us-ascii?Q?I6GvpPYn+BIDz5J+GF7BDvB1m/UGqRKNo2IxPQSW3UWdoIqVFsWzvqSYaNOk?=
 =?us-ascii?Q?VrTWCaP/SSodts9b2fayw2vp8s39R2SmE1v1YUmWorQInUnuAX/Kqb/9DS4Z?=
 =?us-ascii?Q?ViXzvQw1WKhLpvsVqzYvZ1YoOYi8bsPajURi9YaZnE3U51adDIHSf5+w/5Dp?=
 =?us-ascii?Q?Y4XQxA6eppjIhGY0IKRhNJMi1laP9Jmsx8hO7VjKi3OsQp4q9xAR7mffl3Bi?=
 =?us-ascii?Q?b2CaOs6R8ntEsTnGkF3i/qH/yR8J16cyMGAVEuHAvm1x1I2g/I9dmkW93JgX?=
 =?us-ascii?Q?ABsnUEP343fLMNmDg7Vo33qJFLp/CAAwm0nkZ9QQokcMtEJDPzf9a5RlI/MB?=
 =?us-ascii?Q?W2IURyPL68xGiK6W0BFDubD0BhTYYQMcsxjg6td0fmrAUYdWltfEdNtLY30q?=
 =?us-ascii?Q?CGoK2NgWx0B0gakdVI+BkJt0Mnfrny2RI9PxxYilJ5QUMQSjEjM8Ila8BPbT?=
 =?us-ascii?Q?WxHSKioRwITGmwswlYqGJJxAsi25Qln6nE0pNMrbzz8GizA3HHz2JfeNsE3q?=
 =?us-ascii?Q?N1vMLgNvZ2zrlKtQLsX1Dce+FJfZb+Jc+hoNrE1l+0tY1/uK59Jx6ngEMoGW?=
 =?us-ascii?Q?lm403SSGAuFHHazuZiUjvx1OBl7PEAOGzZE4f4K1MU7FiqSV+lQQkDYse+7o?=
 =?us-ascii?Q?cwDzV/db2Cyq80/+vPON0QQw/8YtVgFjQaj28OI9HyeTCPcfGHvBXHWw3rXN?=
 =?us-ascii?Q?QxeAv7/iIIzGq+fJlQghx8/oUgaGZj8zRF+ka3zWwFRwFkgfgmEnFFcdOqvH?=
 =?us-ascii?Q?O52Aot+wKaGI/U0dyWs+gu9WWqh8UwG4SAx0EmbzWzc0TVqj3GNHG1mEX9yu?=
 =?us-ascii?Q?yGpUwm8NVXoNoIUXK1gpfuHFlIRaOHQaT1rPzih4vvh9ur38cbGKkDS9sK5h?=
 =?us-ascii?Q?WHyNrCg4EJ2V+J5P4sXRL8Dkws2nejzzgl4dK5F2PiK92ijaFuC+IwSGRCUJ?=
 =?us-ascii?Q?5qp0FRsiRxc+oMDp31q56g2jmxPvKJQss1gpVLa7Y4SKXucw0SBrFEz+7Rsl?=
 =?us-ascii?Q?569NIMDKtO34ZmW4tEypRNW+2B43TgFwEV0tsG3Livr/WxDSyKwKo8xBK/Eo?=
 =?us-ascii?Q?emntA+tOtlZmgiwKv7Ui9Wp9RCicPfhZ8KUqjRMNtJZFuiZp+buSt2bxF2lp?=
 =?us-ascii?Q?qMCCEBtRs2R1gMOHF/MNXXBl5WkxNv/qsdcGZ1yb3H/viX4j4IJkr4JfHCV9?=
 =?us-ascii?Q?dJYKfVOYXRuFKbuxGFqPbkOaTjLBRUgzCBIcebwGwLyU37beRXTkwkzNor1A?=
 =?us-ascii?Q?bVciRDVUaTgOqdNkiPiiXnbJSzzLCua1f9WI/PXVLtEkdliJSRMKWUWa+RrX?=
 =?us-ascii?Q?yJYbWTnhBz+iRKUlJGM7+t3GJ7eVmrgEWavuyNbPw5zGB0PT0RutYkkV/y/0?=
 =?us-ascii?Q?lJZ/nm2ENasUpqlbJbipqCHqorgwe76PG7u+3Mv6IlcF7HsA0KeWaHEPD5ld?=
 =?us-ascii?Q?Eo86wD/kQxqUYpgT0UYNqLdP/MKL379xxGqHJYa8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcf1da4-8204-458e-ce10-08dab31abceb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:24.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xypJeGeW3ZZ0chpVkCcS6CnJoXJw4U2VMLYtYKlxYrCIJ8sPubJ+IyDRbQaLI9DIBXWnEs0CDqiP855zn+mOBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
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
M4 cores, the two cores runs independently and they have different resource
id, different start address from SCFW view.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 372cb4a346b0..917e6db39572 100644
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
 
@@ -852,6 +887,11 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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
@@ -1048,6 +1088,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.37.1

