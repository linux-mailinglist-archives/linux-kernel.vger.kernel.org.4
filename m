Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04687653C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLVHiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiLVHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:38:03 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8362409A;
        Wed, 21 Dec 2022 23:38:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiLcFOZow0D5s2aHm+VI9oHPyKcLXtfo7LvHqFNkhcZFEvVFm+uX7d0Pj25A1ktWAcE9xiq0kndpA+aiVGd+6Wz3DF7JrmlCNtvGtDAmXZhOFnTsYE+d/juPOUFcrdP4gbqqjAjYUP9yZdmbbg2GpyRlRcojfRlsoWUV2hiD3g/0NWM/9NwCW0sluKKyXrV89SbhxJV8890phsJL0LKF6HWiBhSVViBnU+1uS2wNATuxLwmwAgEUD1DgcU1lNAn1y3OBNzOzl/octqErjr1r8VLIn5ygIPGksbzN8acEvSDI3RGmnzbuASAYRUI1/oW598BRdMqdT8bSks1ndPb3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTIJoQWtRyLBQTe1IJoxbVbAHkrH+mVi3NXehFbfKj4=;
 b=KIrKDvx/lVfOCjfXPkmA2Op+w90QVKHgmenQq+VsV3bV+ZGtpYlGQAX9q274V9gOGziEQXqJVgT6j9IDgo1uz2URcupU7WZnaQustpeElwPKq6AfyYa+9FdqJPNAVIH8nb4RHshJvrNOLCkQc2rCivgTr96Q/Ln6Xckbyr8IzG6kHzjHn26F2/3Y1JCKSZkpeMeaV7kwbEGychYxmTUmcTjEXFuuOflTFc8Jo5yp3LwguojbbkZ0h14pISVnm7KRUUG8zBEWETfpsSm2LVfZh9ckJvDNyXgY1V1w3rd+390w/1KiuaGF2xfw+tbR6USArsIGaXknLRQVvMk8vREZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTIJoQWtRyLBQTe1IJoxbVbAHkrH+mVi3NXehFbfKj4=;
 b=Y9gHmyACGhyqdlGksOLUEVPXG0DBT0RNSrVayerU1UXuk7x3yLmdjTNZrGQsdMHRzZ6g8rv45BDLdnFSWbOf70ik6bY9rhT2KfxntWQMpI0JaExqrhF/GhqZIHfd45q6PWhmg8vJ+ywmyncGnxSd7xfl3A9eYnjBPk5x3VDk0yQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 07:37:59 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 07:37:59 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 2/3] ASoC: fsl_xcvr: Add support for i.MX93 platform
Date:   Thu, 22 Dec 2022 15:36:17 +0800
Message-Id: <20221222073618.1064415-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222073618.1064415-1-chancel.liu@nxp.com>
References: <20221222073618.1064415-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 79333c58-fa25-429a-115c-08dae3ef732a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcdh9HVBuGFseqv/9kYpa/2aX55CAxs7x1UFdzGBVNWDD4psE6OWk1ql4UwhJonV9o52WKb4dyFoiqQccJPiLUT5Y4S8DOqWt7xHfeHl12bv7+ihWJqkLg9fsUqz18RaYP1erhLqvEVjveREEHRb2EDbUDfi90Ya+Dasz9TNZoMI5reGoZr0JwTxBQOiApusgnsBgJ/lFY3Np4cbMh7rqG+s4eFAo25qhMIaN9qfWCu9rSUsWtw1gAY5M5JK9Zzggr5UF3D8JR1CLUqBw/lEFbSRNvOmkJIy7FpGdQkRlDwB5/pA5AKghsmqjb8zxjiCiUgj7UtozwY+5+9HGQ4iD2Pmp+ClWDWHg86BJxLknRo+pLa2q/GfjomaBBdF4JqZAqM/e99CsxR//J+2LldvlCc566TPAGhJU0zVq2QGYkWvscykId5EOIJ0ByNHKWkjlwG8ev8R/upZHYqLz/fg59DA3JiKIqFoOFs8KpfsqEhLRFm3ymcZHNNLOW1oyZmFcH/7bQlYRb6tTfgor0BhB+ryxYhIA81Pxe1ws5Z3uwScfVmKpcg0McCS5IST69n1HmPyKh7VtmxnB8onnS20QRfmHPYnaFsLYLcZkvOpqrQjS4Wi5cPxjpKl7uqc1I+Xrb/V3ng5tkEDkmQAmPikzy8eDyF61gBLwAQWuzDPnJ5nzNXOGnJLOOAOI3YoR7IUjz6OTgn3nu9hiv4FOIUyRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(30864003)(41300700001)(2906002)(8936002)(4326008)(66476007)(66946007)(66556008)(44832011)(7416002)(86362001)(8676002)(316002)(5660300002)(921005)(6506007)(186003)(6512007)(26005)(38100700002)(38350700002)(52116002)(6666004)(36756003)(83380400001)(2616005)(1076003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ratTS7yIDP+leMdQImZw6C8HdY5JF+Mbhm8J0OYICjsTEEsTEhDp6gsLk9Qh?=
 =?us-ascii?Q?h59smHOyk5XtPoACAACNj1jDsdHbcFGCcN1JDbXEfXhvHlMqgPdETkc5Pm5Q?=
 =?us-ascii?Q?48QK0pnQiFV074p4L3sAJ0A7Ip1Jy945WCt1fygijnWiXk0BBDymiJmRTJUP?=
 =?us-ascii?Q?jmsuZ1PlegrhSLCfu4MIva00Ly7imeDqKnztf+PsrEgUDnjMkU+w0WwaLvgB?=
 =?us-ascii?Q?S04PBPi2VPhE/CQQRe5v8cjiXdNQZ8LtA8yfZBkU4KdAI7xniG8W0dkIU8fm?=
 =?us-ascii?Q?DtCccXc+I+uO2OKmUDI46Iwj1C98IxMP0gHG0vsQN6YDZp0+2dYhmmcA/Hwm?=
 =?us-ascii?Q?m1QVAEnV3BkHdTbWW91s28aIn5QmRcQD0qFrSmKkK6vnS0hYvv3qonPsgXXG?=
 =?us-ascii?Q?5vPMQ39/iKpv/p1HNCAkyl8uqJfi1eYtcYLfUeftVF+VP7+LlYb3JQHuGWze?=
 =?us-ascii?Q?5bv3z3jNDPH+OI3u+cbd7eniVqSnHvFq/dFFbjg6XWany7DYkbPNKANU+A4r?=
 =?us-ascii?Q?mjVZ+CsqTqensoTw/IDP2guFWxTGtilM6F1HX3LeZiyRNqIe//K0+I1AKzkF?=
 =?us-ascii?Q?9Hf7mxQqkwJN1Unyhx4skTDy3lYrZ+VrD7wseW4A3fGq7TkCBhA6+CTEtbGk?=
 =?us-ascii?Q?96YEverSuRbOUBP64mt1I7dhW/yuY7umMIAUAcNGJl4sK5vq8mfJwxteO2lj?=
 =?us-ascii?Q?vv5mCEw2ErERQhKAd1JI5bw7F/Pw4H+o9TIDy5OArGB0YSH8McZRhaiKZ8a0?=
 =?us-ascii?Q?RLMkhIwKIAHlr20s6AHjHBKA4jEIICy7hEj5JnpvZKduSrIBR8LDSPcn7Ht6?=
 =?us-ascii?Q?e1PlhkaHN+xLtuH9b30be5DcI0T7RVNTzGqMajVwNmjARnzS2Q54pmTxgXtL?=
 =?us-ascii?Q?BreXp4mH0Sg8b/IA2iu4Q59mW56tRphDh0LCvSXf+oQx6StKFqrd26bBjle3?=
 =?us-ascii?Q?wmLdJGfghtKaXPbnskY9xvbWvcKfjqjThGCMD2xpMIs7zEP5EwBwq3sbazE4?=
 =?us-ascii?Q?dqk4iMUCcDWgb8GsGFDYsihTNORdgPGBaAh4osE9NfoWaL2FqG2r9RfqBhQG?=
 =?us-ascii?Q?ExSjSEN1jTNtuFDQnI2e+5LUOTHQ7LMer95I/kfTZ8159k3RtZbbm1dvROhN?=
 =?us-ascii?Q?C/ROmHzTKXbjKeKjAKNLJDwkf6eXLjzrs3Vv9SnLK/s5ii5wV3LggvZbgd44?=
 =?us-ascii?Q?twWPCzhDFP0hvrYPsCt/Kamef4wTtfbAsOI6c/IPlm6ANpSLG64iKerGKhIv?=
 =?us-ascii?Q?fbKd0HfrqY43THg0cO/moBLQVxCStgikjxHrn97+pYN24tjdBpy5qxrYzRSR?=
 =?us-ascii?Q?sEc07wRJLFByLTyVImZSS+Oy2/EJE0ggRmWyKPB60sUFxGZvn/VB9xKLDfQQ?=
 =?us-ascii?Q?iUySLzsXC0olaxaM8QGBAmSrZx9Fm4Xex+L96Y058oRRsSw45UnntUTj/rTS?=
 =?us-ascii?Q?gPkWVvm8Y4CwllHk+LnW0zjB+gBY49wUYiLFllSIJVMgd/jwr+0Em2Zc4zMf?=
 =?us-ascii?Q?H2Rk0dAvjSJGEWhHSXuqNmutPq4i36gCkK1CEGIZfFSXNNXMKRy5+9U0DQN6?=
 =?us-ascii?Q?izy24eTy/4oIPUrEYVVtot+bve4HZw4uVDs48j4H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79333c58-fa25-429a-115c-08dae3ef732a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 07:37:59.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HO/HGo7bCjEqATCq10mpPPXlUcV2vy/GZRR+nmufB3BqiTn5RBrzusSb47N9knuYcKV/UYnRVCnPOxR2LWk4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string and specific soc data to support XCVR on i.MX93
platform. XCVR IP on i.MX93 is cut to SPDIF only by removing external
PHY.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 155 +++++++++++++++++++++++++++------------
 sound/soc/fsl/fsl_xcvr.h |   7 ++
 2 files changed, 114 insertions(+), 48 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 2a6802fb2a8b..c87ae864df77 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -21,6 +21,7 @@
 
 struct fsl_xcvr_soc_data {
 	const char *fw_name;
+	bool spdif_only;
 };
 
 struct fsl_xcvr {
@@ -261,6 +262,9 @@ static int fsl_xcvr_en_phy_pll(struct fsl_xcvr *xcvr, u32 freq, bool tx)
 	u32 i, div = 0, log2;
 	int ret;
 
+	if (xcvr->soc_data->spdif_only)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(fsl_xcvr_pll_cfg); i++) {
 		if (fsl_xcvr_pll_cfg[i].fout % freq == 0) {
 			div = fsl_xcvr_pll_cfg[i].fout / freq;
@@ -353,6 +357,7 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 	struct device *dev = &xcvr->pdev->dev;
 	int ret;
 
+	freq = xcvr->soc_data->spdif_only ? freq / 10 : freq;
 	clk_disable_unprepare(xcvr->phy_clk);
 	ret = clk_set_rate(xcvr->phy_clk, freq);
 	if (ret < 0) {
@@ -365,6 +370,8 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 		return ret;
 	}
 
+	if (xcvr->soc_data->spdif_only)
+		return 0;
 	/* Release AI interface from reset */
 	ret = regmap_write(xcvr->regmap, FSL_XCVR_PHY_AI_CTRL_SET,
 			   FSL_XCVR_PHY_AI_CTRL_AI_RESETN);
@@ -547,10 +554,12 @@ static int fsl_xcvr_startup(struct snd_pcm_substream *substream,
 
 	xcvr->streams |= BIT(substream->stream);
 
-	/* Disable XCVR controls if there is stream started */
-	fsl_xcvr_activate_ctl(dai, fsl_xcvr_mode_kctl.name, false);
-	fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name, false);
-	fsl_xcvr_activate_ctl(dai, fsl_xcvr_earc_capds_kctl.name, false);
+	if (!xcvr->soc_data->spdif_only) {
+		/* Disable XCVR controls if there is stream started */
+		fsl_xcvr_activate_ctl(dai, fsl_xcvr_mode_kctl.name, false);
+		fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name, false);
+		fsl_xcvr_activate_ctl(dai, fsl_xcvr_earc_capds_kctl.name, false);
+	}
 
 	return 0;
 }
@@ -567,12 +576,13 @@ static void fsl_xcvr_shutdown(struct snd_pcm_substream *substream,
 
 	/* Enable XCVR controls if there is no stream started */
 	if (!xcvr->streams) {
-		fsl_xcvr_activate_ctl(dai, fsl_xcvr_mode_kctl.name, true);
-		fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name,
-				      (xcvr->mode == FSL_XCVR_MODE_ARC));
-		fsl_xcvr_activate_ctl(dai, fsl_xcvr_earc_capds_kctl.name,
-				      (xcvr->mode == FSL_XCVR_MODE_EARC));
-
+		if (!xcvr->soc_data->spdif_only) {
+			fsl_xcvr_activate_ctl(dai, fsl_xcvr_mode_kctl.name, true);
+			fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name,
+						(xcvr->mode == FSL_XCVR_MODE_ARC));
+			fsl_xcvr_activate_ctl(dai, fsl_xcvr_earc_capds_kctl.name,
+						(xcvr->mode == FSL_XCVR_MODE_EARC));
+		}
 		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
 					 FSL_XCVR_IRQ_EARC_ALL, 0);
 		if (ret < 0) {
@@ -673,7 +683,10 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 					dev_err(dai->dev, "Failed to stop DATA_TX: %d\n", ret);
 					return ret;
 				}
-				fallthrough;
+				if (xcvr->soc_data->spdif_only)
+					break;
+				else
+					fallthrough;
 			case FSL_XCVR_MODE_EARC:
 				/* clear ISR_CMDC_TX_EN, W1C */
 				ret = regmap_write(xcvr->regmap,
@@ -877,9 +890,13 @@ static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 
 	snd_soc_dai_init_dma_data(dai, &xcvr->dma_prms_tx, &xcvr->dma_prms_rx);
 
-	snd_soc_add_dai_controls(dai, &fsl_xcvr_mode_kctl, 1);
-	snd_soc_add_dai_controls(dai, &fsl_xcvr_arc_mode_kctl, 1);
-	snd_soc_add_dai_controls(dai, &fsl_xcvr_earc_capds_kctl, 1);
+	if (xcvr->soc_data->spdif_only)
+		xcvr->mode = FSL_XCVR_MODE_SPDIF;
+	else {
+		snd_soc_add_dai_controls(dai, &fsl_xcvr_mode_kctl, 1);
+		snd_soc_add_dai_controls(dai, &fsl_xcvr_arc_mode_kctl, 1);
+		snd_soc_add_dai_controls(dai, &fsl_xcvr_earc_capds_kctl, 1);
+	}
 	snd_soc_add_dai_controls(dai, fsl_xcvr_tx_ctls,
 				 ARRAY_SIZE(fsl_xcvr_tx_ctls));
 	snd_soc_add_dai_controls(dai, fsl_xcvr_rx_ctls,
@@ -930,10 +947,11 @@ static const struct reg_default fsl_xcvr_reg_defaults[] = {
 	{ FSL_XCVR_ISR_SET,	0x00000000 },
 	{ FSL_XCVR_ISR_CLR,	0x00000000 },
 	{ FSL_XCVR_ISR_TOG,	0x00000000 },
-	{ FSL_XCVR_RX_DPTH_CTRL,	0x00002C89 },
-	{ FSL_XCVR_RX_DPTH_CTRL_SET,	0x00002C89 },
-	{ FSL_XCVR_RX_DPTH_CTRL_CLR,	0x00002C89 },
-	{ FSL_XCVR_RX_DPTH_CTRL_TOG,	0x00002C89 },
+	{ FSL_XCVR_CLK_CTRL,	0x0000018F },
+	{ FSL_XCVR_RX_DPTH_CTRL,	0x00040CC1 },
+	{ FSL_XCVR_RX_DPTH_CTRL_SET,	0x00040CC1 },
+	{ FSL_XCVR_RX_DPTH_CTRL_CLR,	0x00040CC1 },
+	{ FSL_XCVR_RX_DPTH_CTRL_TOG,	0x00040CC1 },
 	{ FSL_XCVR_RX_DPTH_CNTR_CTRL,	0x00000000 },
 	{ FSL_XCVR_RX_DPTH_CNTR_CTRL_SET, 0x00000000 },
 	{ FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR, 0x00000000 },
@@ -966,6 +984,12 @@ static const struct reg_default fsl_xcvr_reg_defaults[] = {
 
 static bool fsl_xcvr_readable_reg(struct device *dev, unsigned int reg)
 {
+	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
+
+	if (xcvr->soc_data->spdif_only)
+		if ((reg >= FSL_XCVR_IER && reg <= FSL_XCVR_PHY_AI_RDATA) ||
+		    reg > FSL_XCVR_TX_DPTH_BCRR)
+			return false;
 	switch (reg) {
 	case FSL_XCVR_VERSION:
 	case FSL_XCVR_EXT_CTRL:
@@ -991,6 +1015,12 @@ static bool fsl_xcvr_readable_reg(struct device *dev, unsigned int reg)
 	case FSL_XCVR_RX_DPTH_CTRL_SET:
 	case FSL_XCVR_RX_DPTH_CTRL_CLR:
 	case FSL_XCVR_RX_DPTH_CTRL_TOG:
+	case FSL_XCVR_RX_CS_DATA_0:
+	case FSL_XCVR_RX_CS_DATA_1:
+	case FSL_XCVR_RX_CS_DATA_2:
+	case FSL_XCVR_RX_CS_DATA_3:
+	case FSL_XCVR_RX_CS_DATA_4:
+	case FSL_XCVR_RX_CS_DATA_5:
 	case FSL_XCVR_RX_DPTH_CNTR_CTRL:
 	case FSL_XCVR_RX_DPTH_CNTR_CTRL_SET:
 	case FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR:
@@ -1027,6 +1057,11 @@ static bool fsl_xcvr_readable_reg(struct device *dev, unsigned int reg)
 
 static bool fsl_xcvr_writeable_reg(struct device *dev, unsigned int reg)
 {
+	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
+
+	if (xcvr->soc_data->spdif_only)
+		if (reg >= FSL_XCVR_IER && reg <= FSL_XCVR_PHY_AI_RDATA)
+			return false;
 	switch (reg) {
 	case FSL_XCVR_EXT_CTRL:
 	case FSL_XCVR_EXT_IER0:
@@ -1103,32 +1138,34 @@ static irqreturn_t irq0_isr(int irq, void *devid)
 	if (isr & FSL_XCVR_IRQ_NEW_CS) {
 		dev_dbg(dev, "Received new CS block\n");
 		isr_clr |= FSL_XCVR_IRQ_NEW_CS;
-		/* Data RAM is 4KiB, last two pages: 8 and 9. Select page 8. */
-		regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL,
-				   FSL_XCVR_EXT_CTRL_PAGE_MASK,
-				   FSL_XCVR_EXT_CTRL_PAGE(8));
-
-		/* Find updated CS buffer */
-		reg_ctrl = xcvr->ram_addr + FSL_XCVR_RX_CS_CTRL_0;
-		reg_buff = xcvr->ram_addr + FSL_XCVR_RX_CS_BUFF_0;
-		memcpy_fromio(&val, reg_ctrl, sizeof(val));
-		if (!val) {
-			reg_ctrl = xcvr->ram_addr + FSL_XCVR_RX_CS_CTRL_1;
-			reg_buff = xcvr->ram_addr + FSL_XCVR_RX_CS_BUFF_1;
+		if (!xcvr->soc_data->spdif_only) {
+			/* Data RAM is 4KiB, last two pages: 8 and 9. Select page 8. */
+			regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL,
+					   FSL_XCVR_EXT_CTRL_PAGE_MASK,
+					   FSL_XCVR_EXT_CTRL_PAGE(8));
+
+			/* Find updated CS buffer */
+			reg_ctrl = xcvr->ram_addr + FSL_XCVR_RX_CS_CTRL_0;
+			reg_buff = xcvr->ram_addr + FSL_XCVR_RX_CS_BUFF_0;
 			memcpy_fromio(&val, reg_ctrl, sizeof(val));
-		}
+			if (!val) {
+				reg_ctrl = xcvr->ram_addr + FSL_XCVR_RX_CS_CTRL_1;
+				reg_buff = xcvr->ram_addr + FSL_XCVR_RX_CS_BUFF_1;
+				memcpy_fromio(&val, reg_ctrl, sizeof(val));
+			}
 
-		if (val) {
-			/* copy CS buffer */
-			memcpy_fromio(&xcvr->rx_iec958.status, reg_buff,
-				      sizeof(xcvr->rx_iec958.status));
-			for (i = 0; i < 6; i++) {
-				val = *(u32 *)(xcvr->rx_iec958.status + i*4);
-				*(u32 *)(xcvr->rx_iec958.status + i*4) =
-					bitrev32(val);
+			if (val) {
+				/* copy CS buffer */
+				memcpy_fromio(&xcvr->rx_iec958.status, reg_buff,
+					      sizeof(xcvr->rx_iec958.status));
+				for (i = 0; i < 6; i++) {
+					val = *(u32 *)(xcvr->rx_iec958.status + i*4);
+					*(u32 *)(xcvr->rx_iec958.status + i*4) =
+						bitrev32(val);
+				}
+				/* clear CS control register */
+				memset_io(reg_ctrl, 0, sizeof(val));
 			}
-			/* clear CS control register */
-			memset_io(reg_ctrl, 0, sizeof(val));
 		}
 	}
 	if (isr & FSL_XCVR_IRQ_NEW_UD) {
@@ -1168,8 +1205,13 @@ static const struct fsl_xcvr_soc_data fsl_xcvr_imx8mp_data = {
 	.fw_name = "imx/xcvr/xcvr-imx8mp.bin",
 };
 
+static const struct fsl_xcvr_soc_data fsl_xcvr_imx93_data = {
+	.spdif_only = true,
+};
+
 static const struct of_device_id fsl_xcvr_dt_ids[] = {
 	{ .compatible = "fsl,imx8mp-xcvr", .data = &fsl_xcvr_imx8mp_data },
+	{ .compatible = "fsl,imx93-xcvr", .data = &fsl_xcvr_imx93_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_xcvr_dt_ids);
@@ -1229,7 +1271,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return PTR_ERR(xcvr->regmap);
 	}
 
-	xcvr->reset = devm_reset_control_get_exclusive(dev, NULL);
+	xcvr->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(xcvr->reset)) {
 		dev_err(dev, "failed to get XCVR reset control\n");
 		return PTR_ERR(xcvr->reset);
@@ -1306,12 +1348,14 @@ static __maybe_unused int fsl_xcvr_runtime_suspend(struct device *dev)
 	if (ret < 0)
 		dev_err(dev, "Failed to clear IER0: %d\n", ret);
 
-	/* Assert M0+ reset */
-	ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL,
-				 FSL_XCVR_EXT_CTRL_CORE_RESET,
-				 FSL_XCVR_EXT_CTRL_CORE_RESET);
-	if (ret < 0)
-		dev_err(dev, "Failed to assert M0+ core: %d\n", ret);
+	if (!xcvr->soc_data->spdif_only) {
+		/* Assert M0+ reset */
+		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL,
+					FSL_XCVR_EXT_CTRL_CORE_RESET,
+					FSL_XCVR_EXT_CTRL_CORE_RESET);
+		if (ret < 0)
+			dev_err(dev, "Failed to assert M0+ core: %d\n", ret);
+	}
 
 	regcache_cache_only(xcvr->regmap, true);
 
@@ -1327,6 +1371,7 @@ static __maybe_unused int fsl_xcvr_runtime_resume(struct device *dev)
 {
 	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
 	int ret;
+	u64 rate, div;
 
 	ret = reset_control_assert(xcvr->reset);
 	if (ret < 0) {
@@ -1340,6 +1385,17 @@ static __maybe_unused int fsl_xcvr_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	/* set clk div for xcvr ip internal use */
+	if (xcvr->soc_data->spdif_only) {
+		rate = clk_get_rate(xcvr->ipg_clk);
+		div = rate / 1000000 - 1;
+		ret = regmap_write(xcvr->regmap, FSL_XCVR_CLK_CTRL, div);
+		if (ret < 0) {
+			dev_err(dev, "Error while setting CLK_CTRL: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(xcvr->pll_ipg_clk);
 	if (ret) {
 		dev_err(dev, "failed to start PLL IPG clock.\n");
@@ -1367,6 +1423,9 @@ static __maybe_unused int fsl_xcvr_runtime_resume(struct device *dev)
 		goto stop_spba_clk;
 	}
 
+	if (xcvr->soc_data->spdif_only)
+		return 0;
+
 	ret = reset_control_deassert(xcvr->reset);
 	if (ret) {
 		dev_err(dev, "failed to deassert M0+ reset.\n");
diff --git a/sound/soc/fsl/fsl_xcvr.h b/sound/soc/fsl/fsl_xcvr.h
index 4769b0fca21d..044058fc6aa2 100644
--- a/sound/soc/fsl/fsl_xcvr.h
+++ b/sound/soc/fsl/fsl_xcvr.h
@@ -49,6 +49,13 @@
 #define FSL_XCVR_RX_DPTH_CTRL_CLR	0x188
 #define FSL_XCVR_RX_DPTH_CTRL_TOG	0x18c
 
+#define FSL_XCVR_RX_CS_DATA_0		0x190
+#define FSL_XCVR_RX_CS_DATA_1		0x194
+#define FSL_XCVR_RX_CS_DATA_2		0x198
+#define FSL_XCVR_RX_CS_DATA_3		0x19C
+#define FSL_XCVR_RX_CS_DATA_4		0x1A0
+#define FSL_XCVR_RX_CS_DATA_5		0x1A4
+
 #define FSL_XCVR_RX_DPTH_CNTR_CTRL	0x1C0
 #define FSL_XCVR_RX_DPTH_CNTR_CTRL_SET	0x1C4
 #define FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR	0x1C8
-- 
2.25.1

