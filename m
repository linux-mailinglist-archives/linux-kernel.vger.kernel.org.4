Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818D65CBED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjADCkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjADCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:40:30 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5F101C5;
        Tue,  3 Jan 2023 18:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djAkmSxf+mUq37aXdFH8tG/6fI/5+5L0DNP2bQDoEvGtM5RcKyuMavy6c9WXFBlx2OesI8iE/d3b49qIPqeCoi2HI7bas0AmK5Y47tdOdn4MDvrGtWCJbRsiAvgQtknEV/J+gud5yemwXjmtj2hj+d+DTsKXL96Q4AMPwFkERjoKSBNSaslm3aaAnrJ8ohaS5ft/iCPcISbMFGWeArVwexpVaLexapVGF6Re4xiDhR+t17WrIpR+3GaScBpFsPYE4Wg6JHHqj+oUYBmT1lmlVJueLubRVfrGIz0NXma0hqXMJYHeFIh2CoqDlOSdpAaS0ODbzh21w5djnrN1NzMq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3y6KMuIVDUyZ64JhbuWhFOA97lWgpV16TqELUOln24=;
 b=TyxaQkxVV8dr3/sH77GYjvGEEfPTilgvB2ve01efEQXTIU7ugNVvYk0TOqZpxX1U5972QEO84XqhGKK3sQZZouoI4REhW7GIzyUdBRsN2UU0yJ2vnpEO6oUo7D/L7K61OHsDWOF9JbhBlbhbsuMEpSZ0Ba0pTFqy5SgvPOzUFFwZ01eZBL6bYK9q2oCkHei0kjiyUVE6D6yo/givFmu9E04Hj3B+1gxQHOSwWS93MwOIDfscy2NSyVZcBIv1TBhZtcGawx8QQ7QsasLZeWv5VJ8GsUrxMIRxKfRkwujfbAWSvSIqtqo9S0I3t8SvuB8jYPhYIIS3pHet9COR+OQlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3y6KMuIVDUyZ64JhbuWhFOA97lWgpV16TqELUOln24=;
 b=eHgLRMCJOL2d+ZhL6MahS4XWMu9U14yMxDelkP+hioY2edtxHcc5+ziSdGrGsATflKZqqhH9faK2TehnWEFAhjP+0H9mhV9RXKKyRyqL9FfIauMNDPgURZrIzwEo9qYPyXFkRQtvn7KZooXGkDdNq5fHeLYWwXOmFmk0uST+oL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 02:40:26 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.018; Wed, 4 Jan 2023
 02:40:26 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 2/3] ASoC: fsl_xcvr: Add support for i.MX93 platform
Date:   Wed,  4 Jan 2023 10:39:52 +0800
Message-Id: <20230104023953.2973362-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104023953.2973362-1-chancel.liu@nxp.com>
References: <20230104023953.2973362-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d0ab61-151a-45e2-daad-08daedfd0907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeRYWm6yCnW75Q69CwVfg4Fmx77gJOLbJoIUZuGJNOTvlv5E78B9mDXyy1WeF96k+DdRTR5MzpJ1pO7lCWTHOy7zX+Tn6cpJcrVdpKGXaDyoyaM6otnNfCvqYz07vLGsZ44Bv9CTac4VAVgdko3RoEjvvX1WbOI12EuxX32W/AUhY12tRWpCShH/eoQQ/oR18G+LV2Hva/xFhF14v7KeHn9UFtxH7Oq6xig5R3q5ZXddVVHEfCRRQPQJu3SyVpzzKXGWXmXt2fbeu15497+mNrMU2NyJPwguVtUC2bo4b9gKnCQ/lkBOc3aC0ns69uw1qukNwoQ8qabo+mwRFMgH2sJu0/sWreUN6ZGwgytwhH3dzSIqQis8rYuRoZ+hofssaEmSfmDbh+RO2INiRggIIkRqmNYUuI0GP9mJXvsju+Wrgto7nSzI0ak5JJzu/TXPtysZ/b257VMx/4AJecqBL2konWY/iCDwMpqTOoWzYse74dALFsIh2jqXonilb17AERQ9iOcfCsHWpH78THTIkKtTz02pXAWwgZXPxUBfl7oZPThYOHEU74Bf7HY+pGrosQb+wA+885mIfyCzihRenoohZJXgM9uWGXDEoB86CzbSg6WlA44JPcQoERI24qLSHwO/PiwDjtsn3kD6hhwAuy9GHSrC2ZmmOFDJIbYrRWoEk1XFrOEUTMDwtDorHIb+cGwlqcP0q2HB25irCamkCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(8936002)(7416002)(41300700001)(8676002)(4326008)(66476007)(5660300002)(66946007)(66556008)(44832011)(316002)(2906002)(6506007)(52116002)(6512007)(6486002)(26005)(186003)(478600001)(6666004)(86362001)(1076003)(2616005)(83380400001)(921005)(38350700002)(38100700002)(36756003)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R7W3ur3UOz8EEivsVyeVNrMrAYtovWnP8l5EnXJp2sWIdAx5h1WbnOakYZpp?=
 =?us-ascii?Q?HPinjV/l5I2WjowW2eXRoTVOhJJQU3iV5sDRJlox29E1GLlYvJyVO0YYB4pD?=
 =?us-ascii?Q?YkClbecwHZWfSQFt1N+G+K69GXbiOwzmmozf+PkN0HJjcEDTj0zndtaDYkgy?=
 =?us-ascii?Q?rjax77F1iDWFPYmmo0PI15SmhAxhRp5rUDNzbZwbB5cZrI6PcFAKk4a9YPwi?=
 =?us-ascii?Q?oje/6A+LHMRUSvPTroy9l95Uvbqit1lwUvPJ9WyUDKanhLVWdkM9vNaGm1O9?=
 =?us-ascii?Q?xONYTddiNNBMRkICOANpUBUl/zqYHVWL0gJ31hrgW1yPItw3qHEBCLB7OEcl?=
 =?us-ascii?Q?2lEtZn5PTKGH23fd+8Y0B+Q8XFExF4J/vZLUgc8ItOpIg7BvfthLNqonBmn2?=
 =?us-ascii?Q?BakNslZujogsBng8thehpE3+D0k/Ku70v1pWgZRJBw0h/JzLMyzC/cgpKMX9?=
 =?us-ascii?Q?ENSU/Rc/RYOsH81s0/7Fp9KaVc/0Ta2llsqTRSjNqmEWTT6TraxU5oLJBJYn?=
 =?us-ascii?Q?4WWChM/+auzYJTwIWtP96VkrJaUqtpH9m9BNlMx8zv4iHuYmTIFgLQZUn02A?=
 =?us-ascii?Q?RlSam0dnIUBP0/AtebWURb3ttD8IMkk3iFAwkzJSlNTZ39CENTeJwPOfy8k8?=
 =?us-ascii?Q?lfEMUduqhH6WDYpd2DbFlFokv6opi9QdUYrOJwOTAYv6WoYYr21bSAPD/UZx?=
 =?us-ascii?Q?MGWWJkvBkVcxoO2RNMUHCwq/4JI70LLS7McK9sm8UWwYU2sJF4olgMfpKRA/?=
 =?us-ascii?Q?Iha3gwLlfKJz65AqsgFjQU9gMEEagJJV8DzvoUwa/0cv/OgNIzrRyoDUuIBQ?=
 =?us-ascii?Q?tkcqPNFGqzJg6zJXb+YJenUVQ9yxYr1ClZD/u8j4JqlIUfSGCspl5sBKe+r+?=
 =?us-ascii?Q?xSd8HF8IcG04iKDY2UaSyJI3sorNfZZVi8cYO4dfnfdi51VJRb7VoUVru1nb?=
 =?us-ascii?Q?iMXLzE81Dk2zrfibSO6jZ+9ZtikK4o3gahEJnbBd89TVSXiL9FCj7S5OVz1v?=
 =?us-ascii?Q?woqsmQqkyZImpSY/g0FujkMXxFEOyEAcT3laJKmCvD/BYD7BjQlQiNahER4G?=
 =?us-ascii?Q?hBzRZEaHWZn5G96a3BmoAC4CU4yNdEGpT/nhAkrJh7OQrCl1ERurK3ALXvc0?=
 =?us-ascii?Q?T/JYFxiui4hfhCdAgsWUV7uMZipAyJDV9kJqL45edRtWYheW4Q5UrQaVuiq+?=
 =?us-ascii?Q?KSwMPSVULyCjE3+cbqPXqB4q3agprLwdcskVMPm4MA4IZh8QXTR4ryljIfGZ?=
 =?us-ascii?Q?b5/A6TFu4MBuordCe9IdEgfoHqQThylhh/MHBtndULoGssDa3YbmscTGE7Iz?=
 =?us-ascii?Q?/0buszhJgtxSxUh6XmljuYqfSRpZBErCyBa3xsGLYQYiIr8VykczAy6hamOn?=
 =?us-ascii?Q?oTP2n21hzxA/KfdGS4vDmgLfXzUDOpPpsQjqEmwleZ5lKtx4226PCHjfm5dw?=
 =?us-ascii?Q?RdnNYi/W7bzHW1AWw8OHO0rW0BndjYtl9rCAefL6PLnwvsrhUn1JtjibY43Z?=
 =?us-ascii?Q?ogmQdkSc3BcQ+IdIAOdCZRDHdvuvZ594e2cO+Pilhlo01B8pmieRScwzJz1m?=
 =?us-ascii?Q?TUnoakFFGZzmJIUTv2baDiBFKkSAZmsOGqzoJww+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d0ab61-151a-45e2-daad-08daedfd0907
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 02:40:26.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVeFtGhNWew4PH+Fc4SF7AGt8c1gloIlNILNtjU6553cxjgTUnye4rv0BJHzAmCsPA9GPtAe99vVK8nRlh67gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
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

