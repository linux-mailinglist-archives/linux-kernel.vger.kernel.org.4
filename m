Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB45FE769
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJNDLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJNDK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:10:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0CB10FB;
        Thu, 13 Oct 2022 20:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWzmdqbOJkW1zQOh09QqcUUyciJzlGYz435JV8uOhGVCXxrQwLcAuKnz/8NZHd167g6pMsWeaVv7cGe8KxyHpVInfpYe2m7Ek3Pe+i3iI87NW5mP92P/X2O02Fkbij4H14l/sgrZw4R1WIkHimUkJAG2trOF5EPFR7nEgEFzuBH6TVBA91C5rIyFcW4rTZXYVcOIWffMkLOzyBUdOw6EdF1f/rqQTdcYUW/lWQj0Xw6Uo8pw3VbNpZzKFb/XWeHQhI7gJwpNgvWhplcoOCCQFDk3FKTzljVyx+YZ/hYIK9QYtwmKasKH8gjxhGzugZrCah/Yg+UvOpL+MGQlcaCRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvxEeqqwY7dac6HsGnLTQI13mhd7JygOFElQG9WC7TA=;
 b=iGqhO3Qw8vZSCZCzb7RoYX8OkMdu4HyjTNF2BQ1V/LTFYFpZnxl57kKW4/+uXcBgiheVph3up7YebnSOfb3YB8VgsEYkeKHbfNpUh8piKW8VgMbaHyFA0k/bl9lR57wtSJHPwM/SVyn7gfw/M7tnMJhoPkeVim6p4QpXT9JQCFmycH7tHR6qUiKY3f8+WBSns5SgA3IS5FfgEL8AWb9lVz8YsfoTX74RoYhjdq0Nic6Doxjftmmvt4iGlWOh4PObBVkudKDg915tFmQu8e6ruYKYYXHn5kwW9wp4emYwB7RBr3ZDJxt6E3lbtRzNbkVoZU3bvae0KEK5E/YZADD3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvxEeqqwY7dac6HsGnLTQI13mhd7JygOFElQG9WC7TA=;
 b=LT5DjC/LgEuc6qpXyDU4hJoFtgUel4Ek/AJ8LXmcRne/gdftqFRUQTLeo5W6ajuLRu9N5CctSS/Fo4E7+Higr+d+tIZIlCX9k8e1STCN/Ro9s8REamwFM6xfKQR547swVwv4QSez8FxVtMsy0IVL1Xar+cMZxBgDXgaaoFI7+1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 5/7] remoteproc: imx_rproc: support i.MX8QM
Date:   Fri, 14 Oct 2022 11:10:35 +0800
Message-Id: <20221014031037.1070424-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec8e590-f84e-4496-71d0-08daad918372
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WOPast1xJIiKqyw8oZ96tPjCuGDzvt1jitGdu1hwKgr/BkedXdsZZzo/jiGDO/kPvDkefAtGCL54/HmIHV4T3/WGsaERN6EspQjZ8jF5KQDcb51sPpl5Qkadfr2lJHzriJZgTfmwKMs0W3ApbDrkaUUy6UebgO7pXb/NaAwicF8L3T5L1GypL7VcFzgCZyA5A7zPVPZvgbGRJ8gbVTRuxqNprDT3S4F+a4IWSCGe3kZOaxIbLCCb1W82Ntg8jRpc/smPc2p9obL+Hx0A0CYWYVCzYV9d41D3IH/W2XsJklUsipx1SXUokl5PaExT8yZJma6YGM4Na5cBgZgoXUBIAmPPjZcJJYoatCU6jsauppXfPf57+d5eYXzqAOABJwADEhTNCSI7XbEI6+krSeE9O9W4dX//y45G6VsxZxZHTOE88N4OHEc5EgOs7TKYcwu7miP2M23Fh3rZKhC6Kef5vn4woiE9rj7x0oYCDFASNrjvSXHNPY09U45RupuoOWsqcr4HbRGvj9gLtlIYksmMWXBdL9Mjx061ei0FqeTPNx4B85u95jlqvz/I6ttawzKYAsM8wwznwvyHTIZoBngDa+KttJgowENhHqwa8uaJhU48HD87DJgO0ZP1X7KTSXciQZwxV5zjPOCKoeZF1Az2dpCrHhh3lCtbXvzUZzv/9bVGoOr0aXc6mvsabS4JU2TYrjZDucg6WIrn88LQffTLOkkfcgIJs5SBucGpA50AiGXGnAGB1jDCHBBTHW0hNcpvddZCqn4HKJW5pJOE+Zpxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzQtm212amkreFyK4cCyV165uac4tSu4n5r6VbwpgegcaHy/QvmcKT3vczEs?=
 =?us-ascii?Q?QFtxR7IeBah1xKqCZXY20mUV0x++aBdcbiAcsoSsvacGE75IAqQtdmgVy0pW?=
 =?us-ascii?Q?O/avw+Ua17+p1nNfnvpUfEUGParYwFaDAX5yyUKyeA2fZ2L+zSJqEr4CwYeL?=
 =?us-ascii?Q?N7MF2CXjuEbsl6kEdxYeCVfIbRojHFIudt1oKL/AqFcSyUQF1UpddFZ5F9xJ?=
 =?us-ascii?Q?P93W+xE4JCET0TcXRYimLoLtMZ4hayU7a1E8+gNzCGJc+XV/1Fi2+OODRsV4?=
 =?us-ascii?Q?qKC1U4YVq10KF81pSuX7pfw2SYwOoJMh256ckVrbCLSvyE41L7YXA7UIqsTd?=
 =?us-ascii?Q?hi4pTULJ/8PRrquEXcSr9f9MX7GUO5UK5ID61PgTulzEova/CbPc7G0GkJLu?=
 =?us-ascii?Q?0Ov5yvNY1b/FCn9k9Aji1dMoxwGwy432lOpi73e5N317V4J29xkmjq4N5P9C?=
 =?us-ascii?Q?YWe375IG7XgeGd/u8QUeiujpwjROUnSvAjcHUjD+xjihblb4JwR4/QvKMokn?=
 =?us-ascii?Q?ydKJs7VMyTSoEgukHwQEiPKEbMEszL+qRyiBrlkqbIpg8O7p5ITnxh4dVsYd?=
 =?us-ascii?Q?SXW8duNCZYMvSKOfQyKyATlSaUFtBVXAUCxE6QwfJGendC6M25kf0LWyrb6X?=
 =?us-ascii?Q?EX1mZ/XNA5K8jINY6w5nDDS58Qk0AVFTXJgbu/BS/C86JZfRNyaToO9JhZMU?=
 =?us-ascii?Q?UKvtKEnocuJROvixzkinwdC1hnxLwi77BtagUwpdXVPFFkxrkj4uyw60jHgr?=
 =?us-ascii?Q?26bbuXVBh9Sjs9B7H6Ctghlc4eIeolUpGk2RqzAVoNu+1TxUAcd8JpI+Umwe?=
 =?us-ascii?Q?99C/qkSYBdpxnUawh5GJCWPVLFaqeh+ijI5ZaHUxWlnR14xWg7ALfnopfc4F?=
 =?us-ascii?Q?pXXqG24qr11QuTg738yglZjx+rBi8vG4xfFbMm35+j9pCHtMZdxOzJxNOga3?=
 =?us-ascii?Q?cO95wOsB88qBNYLItRJVhpfFpk8X87wxxobv9xHOIcpTJiwVuhQIf0CuCUQQ?=
 =?us-ascii?Q?BZU4fRAM53o8L/g3gVqfIMr3F+NlQ1Tu/8YMwr0b9HliR7zw0fY5IqGi4Q3u?=
 =?us-ascii?Q?jpq01wSVIgU0/6ASAtfwt65+KOVLw8fYUoJQZSQD9FTIODb7yhpD+/X0ZPqJ?=
 =?us-ascii?Q?hqTKHD8qBT/UJ1cPA+cBySnRPVTPI5rcFOYdIwQJ6klhtakjC4m7e1K0nAL4?=
 =?us-ascii?Q?RYwbdh/BqSb35neYIYG5mU3JcZHChi6lilal3wZMnUgmLKwtxkSSFC3Y7u5o?=
 =?us-ascii?Q?1iOYoO+YCjGbd4Wh+hxV0KpvDqf3DvWQrUXOfGtEMaBEGp8/zw3Lv7DzOwss?=
 =?us-ascii?Q?qMLFaU6hlr64MM7aL4dZFL3OWZDsD2jeowfuUAxBuFU+pKs7i24VcHZ+D+Fx?=
 =?us-ascii?Q?GCeplie4LaARe3NjnGxTHoUBQKBucwLVAZHbBOSA5RLD6lV4f+COQFRZKZme?=
 =?us-ascii?Q?Os01Wd+C5a2etBHr8H/Aoxey5VND2+j/dpgwxL1i3MppI4W8POUaUDYdH3dL?=
 =?us-ascii?Q?7wf3/wg35HeXvkPib0fSqJESyLreuQNCXEz+cQC569fvF/aXeKZzZwQf8x/s?=
 =?us-ascii?Q?kMzCne/iBSy9D2s/GPfSgTCXqo01AKTEVEuiFwkK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8e590-f84e-4496-71d0-08daad918372
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:31.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPCRfbTEHdVqUaoKMPnrSsZqxsOir7kaZxFdljk09aEi9mno+sow2KWk47Qu+9rm8rFS4eGGM/SoTo6qNz3Vyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
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

