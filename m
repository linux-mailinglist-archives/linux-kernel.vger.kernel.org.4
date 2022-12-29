Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0A6589B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiL2Gau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiL2Gal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:30:41 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114410B59;
        Wed, 28 Dec 2022 22:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d98XnseEf7Q8lmEd/F+2VglViogC2hCz4qYhF4rR2EQcAYkLmw3xHhukJgeRbsAxA+UqXIHrux+0KwQec8WytFcBYCGpJW19+dI2i3L8IoIOYzJLY5jDSkWxQqMTWKhxzxiRVU/iRXb5HrLNDLZlMla4wT1HjLcMTJ4Lf4a9M+O3caZsZJ4PwwGeYRUvLlFy/UHzpJtYrS5VFcMJ0opsPJ8lFoLhHmlno6V/pDYcDC/zKIH6stRkqgn5iV6niM6Dj4xQ1dTfwJ+LBbLtTr81vZjFHo2hC/d9OpUu4gyx4jkVGThqUnr9Uho/DZbMm8T2T5mH9fj0X3hOyETbKNil7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3y6KMuIVDUyZ64JhbuWhFOA97lWgpV16TqELUOln24=;
 b=mZba/A5/l58lPhiQMKPLoMkghvL7rzY9twiuWHEguiTaZxXPnqq4oTwnDt9r12EPivCrxAunwQx/ELYt2SAPm9I947SGoA00MugsU88WgeKt6UnG9/n36Kp6kISHqqvPq0u5fWOuWaGb/+Bvl6dnvO5M6VpofJMVnum0MrENhjztWsMKFAB1KXTx4P1iGjVtkYcYKsdWvD03VXpzuhsEqMUp7QQcERdkbmoCvJyUBHoCtdgEmcmulLfTyAoHt8apNF12XNc79jj/wkKnpMBwmlb7ph/3/B61dWh4VhTQ36ji43ll/+oYjg6+Fu0VSH+nadIFLatZCmnswRQTJH6c8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3y6KMuIVDUyZ64JhbuWhFOA97lWgpV16TqELUOln24=;
 b=hrfS0p4mujPJS/Ihhjf6xovRsBaotX1Q42xmNGPq4CnSipefISAfOY+u3Kvkyr6kTWDedLfOBWU6m2afEGF9DHuSCGKcJ1Hl9mt5PdBUdaRcOwDyOlsE6YOeL6JqcmglYyOdxCjVt/AWON18qRqi2zIkXF0KBkR9ThoHewtpINs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 06:30:37 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 06:30:37 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 2/3] ASoC: fsl_xcvr: Add support for i.MX93 platform
Date:   Thu, 29 Dec 2022 14:30:08 +0800
Message-Id: <20221229063009.2396716-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229063009.2396716-1-chancel.liu@nxp.com>
References: <20221229063009.2396716-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: e42dada3-7436-43d2-2f04-08dae96632bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugma/7sxqWiZTucL4V/SEY0iUTAEE1gZK5dQnQCcoGccWknCvUu0Nw77s0WZU2ShbWRcvYRAclgRxkqUflyKZbZ0Qgf9KGYkw9viC9jIcVjmKAPYXLO72Fz1XkyFMbOOiTw4RWZTFtw4DNuOVRB5kc+6nXvNxkKd6mm8kzJ4MKgXSxBjnpDtRjix1XyuUZ9ws4EYK4yXfxFPOfr5qo8xdeldlbBwNqWabvx6fY8zQ3VCIW2fXgzl66I1ktvR7E+wMKZEq1YsOSRFWExjdIVyZRmMKKJF2Fy64UiPI5mmc1golXy7qnExS8mEg2JJHbRrbMquIDI9XSQigPzVSI8BaHrKy8TM5myFh7eLuPyzhoBJ0z8SXMLbts3Eg9HqALH2El/x/rWAmp3umA8yhdMXqNqghWEx9EjH1FEae2XbvEmG9NuRriFRVfmdVSfadyzLbXIwG/s5T0jT0oThMhi+shBrlfhu0SGP6x3uL5d8samrLmN51Bz55hkPevzulS68+jHph4QjTJPUfgRhh3EEQdC5g1VXHzZuKrNpqBm03EGbTcf4OpgDRqdJkrBrR6teD43c2X2Hn4fLmyG+nsx20u9d7SQxhz2723PukFO+ceEI7RoZfd0t643GNHwKxhmdr5CEYOZxDL06/9pAnb4VKjq7hjwE0lq3AzzA4u8us5YSkkndvqNB+cS44UFCQBcAMnigMS6siWiXMkirGVqJ+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(8936002)(8676002)(66556008)(66476007)(66946007)(4326008)(30864003)(44832011)(316002)(2906002)(83380400001)(7416002)(38350700002)(86362001)(6486002)(52116002)(478600001)(36756003)(6666004)(5660300002)(2616005)(38100700002)(6512007)(186003)(26005)(6506007)(921005)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZBLXkOAt3V3WhLq0WkGwFthpHR8eI31Tr6fryD1IGErk4ZjBsK2km5pADL7?=
 =?us-ascii?Q?u1fTmCHjRIUMcVabqO1ZwjX2emUmhzL0PfkejfPvdZt7uTfAJ7c2jdbpIEsH?=
 =?us-ascii?Q?5sVD93cC3HRqxBsuVWFYgrMybrGbkE0x1rlKJcNSNOfMT4EQNEiQuw08R6DM?=
 =?us-ascii?Q?21ahtDX3YJiS/mIEEpt/HrKjKsCuxaBtw+Ft3pOiimfw/+IRk46eE93/AGiW?=
 =?us-ascii?Q?HDxM7iY23rrqwnlvXb29rQPsKERyZexaNDLl8/uLp+eYa9AF1WFy1h6H0Iri?=
 =?us-ascii?Q?iCtIoZHO3mZwlF1xfiNJ9NU9GU3oXptHUzf5CSocFqpe1Z/Yr0Vl7I01rQPy?=
 =?us-ascii?Q?/TmVaXNl4LGQFBP3rvc1kG3c5vumHFn+oiRjx1DGebWR0XTwXh9KlCuft6+/?=
 =?us-ascii?Q?yhTIcj/+e1jLVu3H8MGD/Micc+w1v3sqLaD9zakR+W9Z5+zgPu+CSDooJdqQ?=
 =?us-ascii?Q?I3xEN8Lvuot7V1geTgTlQqhE5wK1c6GddseM51mVIFxwlkM6wX6p1b9JEBnf?=
 =?us-ascii?Q?Z9AcHPeyDdl4Ow75QJJlO5Od0nzgkE+tmu2gaxx4kjBbrsG5p9pTgkcmVplK?=
 =?us-ascii?Q?sNC57K4ldAnaTE5zNr2ndrbt1DmhOUuk20FkGxsa76ZZo8yFn5G9/PCqA9Vl?=
 =?us-ascii?Q?20J0XMGVojQq1ttBJRSlKWPhVTTst/BqWOUn8tj3HMnJSbW0fAn30G02n4BC?=
 =?us-ascii?Q?fg9KnBsRIZSozdHUGPvgaBGskARsCYCmLFgJQXJHBNJqswOkYj2l3bvR8heP?=
 =?us-ascii?Q?3sik0Oc8/etoeCTWJ9hm5QRp9Dq18ZP9IJtDbQYvMSD1kfeI2RrCx82jayAh?=
 =?us-ascii?Q?SFOOD27CAqIjbAmwNxHBjCYB4uNeaavADtPBYIbHMsN2Wt54RSLPd0es+gAZ?=
 =?us-ascii?Q?YB5OCoksLegV2Pb9zpgY16HByTBGw6XpAX7jcwAE0mrfW3u+Oueoe3phoFXW?=
 =?us-ascii?Q?ph7HtXbaaHzvwj8sdC5eCs30aoqKUumMUKWPsdI0ZIK45QuTh+GZrIz+BrVk?=
 =?us-ascii?Q?uRN03nvE7m+3knPshDjV0j/DLNO0QcnmCxHr84FluM97Hg1bS83tDDhvxsSE?=
 =?us-ascii?Q?aryAGfr+TBVx3eiJZXTApfS8jFXr+paRekVJCobUhNe/dHCbBadeTfphLLb1?=
 =?us-ascii?Q?j7cDDcXDxKbYTBOmPCGVwM7HzprANuXgfYypD9sZR72xXn+wSs5hbIqObiI0?=
 =?us-ascii?Q?2eO3/7Se3pe38cq6ZwUhwAmr8hsGh88LVSCUjJ/qIwN31z3gu1DoFmBDYEcF?=
 =?us-ascii?Q?y7Fl2Jt7nPVVlOr6iA6UCZoZJMWDQsXr/EqR2KZ/QkjZ56J6XcEp28JCb282?=
 =?us-ascii?Q?KSpzNYCJ4XOZZsglufpqwQ7IMpsvDrqJZaeV++Zc3cFGJ4K6u26p0Loq1p5E?=
 =?us-ascii?Q?yxNJ/MQibU7xVuXql0wOq8Fqcs9uW6TCz6Km5RFe2/CjjVnztnakKJXt+JyI?=
 =?us-ascii?Q?jIyKWcG+C265nEplsFz0wYiBagGua4GEbGfDjK+PkDjghVy782FYWwOSJT5C?=
 =?us-ascii?Q?Q1GoLTMdvAwOyrQ6/TQBkugV1VuPEW5Hv0UIizZVsbC2ztNuBLCTkWiQr3d0?=
 =?us-ascii?Q?+3vWeR3wsp008SxdDJbxPcy25/HMAlvDxQ2Ydsb2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42dada3-7436-43d2-2f04-08dae96632bf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 06:30:37.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNlLiviVI64JZ+ACccBP1rV1zTGNVhs4KScPcgHGSTeM1etrwkO144R3QYFX0FW66jjze3mXPMJI2/6pNJuzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
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
 sound/soc/fsl/fsl_xcvr.c | 143 ++++++++++++++++++++++++++-------------
 sound/soc/fsl/fsl_xcvr.h |   7 ++
 2 files changed, 102 insertions(+), 48 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 2a6802fb2a8b..b794158a7876 100644
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
 
@@ -1367,6 +1411,9 @@ static __maybe_unused int fsl_xcvr_runtime_resume(struct device *dev)
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

