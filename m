Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A896626B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjAINRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjAINR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:17:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0BB1D8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/kf0DxFdguPmHIWJJ8f7BwrjcToHapHXB0vUMgax44e0NJZaQmEU4smhJbf+DRakWF/7odRp2hX9Wv8D57K1wVNJyCYhI8pu+BgTA6udzHME292Xo4kRCe2ppfMwHENE7pOAIdc7RTMYCc0lMEuzhAd3JEqHozGTVBsQqyh7iIp/7isOQbNcCvtBtHPIykQQVWR8DZHfrDsUNxOdOaXft8V7Cy31AhGQPyoy0v6LmVgd178If5dIEr5EWoq3SV86U+9Q+asioF5Jg0VtUUZAlgFtU5Nmo4xV3WErtORuRLWP6XwjbV+lpo0KbM3UK03g2DNPnT5E3lfiUtEy4IgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFJJv7o355mKu4mAMJbAgFIqJG+NRGxHnZ0Vm69X1wM=;
 b=K6itUB3VbQLJkNKMlTm0isfNf83ksGrNGSU0tomFQRAbMEEkpm791ItoBOJJ38f6crp8Swi020E7L2NaxFdzjEyiQaj5ZJgTs0zMtV4bQY2acrLqp5qxldLaUF4yr9oTNtjg08tTHggeuGs0uvpKAPMls5ZfGrzsJIjXNaveHyz6ZuZfwsomrWE5DTdlNJ2LKlLg/4Ao2VqDPdIRhNq2uj2hza0Ldq+GVen/Sp5wvs/or9CA4SFvlOAVjC/vARJNzKiyIjBoBiJYN34O5y3CDPiyZRXeDBtrR116POVBTaTar+lmPTX8PsghjFDppZIsSuW7QxlrP2zjLlR8zIcDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFJJv7o355mKu4mAMJbAgFIqJG+NRGxHnZ0Vm69X1wM=;
 b=AkXBUwgW6lwdGbIocicersJrsB154kk/qRIAVDxbUVDFBYwYzQgPoGXNH1KA6pwnie/KxrjSvCdC0nDdaFXgfFRY5MIHcrKZgIpi2R/O8W2hmbHXDe2IZDCFBRZuPFn4PXwRcXdlIjSyBjiwODTbmSPwiRHDg9nMiup5NWPGyKI=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:17:24 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::dc) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 13:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 13:17:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:23 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 9 Jan 2023 07:17:14 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] ASoC: amd: acp: Refactor i2s clocks programming sequence
Date:   Mon, 9 Jan 2023 18:51:02 +0530
Message-ID: <20230109132104.1259479-4-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 297f1a71-26a1-42d9-f48c-08daf243d939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23H0CkNC/3hSfVb8okQmxAtiNEZdkxTDQTQgE/P9aJ8ErogqPGeoRrO77kne9qXpqkrKTdAim1qmoNaQOGf3SEQTpbeIeyMBFhcTvTtMVnNnrCt2y/qgRUJYCo7Ar3szX5bAcZWeLfZH893eZvb4UVw7cgA/dZhQeKIzQWU3Uv4xdjWIyOeHW93CRjQd7lI80pzuYCsRICBqWCmjaTH6Zb+/vXZkDnFcRUPDJ97Z7PN5g9WIo83kCjJJRxCvuN2DotyYKBiwD60hc7K/PEaGn1tIaIazCmR+zt4ekmhXSDnazqsjJzTtC9rc2xk7uEliULnPCQfXLLjaUW+ji5JT5zp9HEWKqJdkcfi5pp2Efz0lYYon45YohkBtJ/a8ueegFnzSruey595IzTJcFXDAjxT7bHpeWJC/iVOjPE6Zl24ekKbwx/fO7HAIawBqoPVVdIc8FDrapuliY0izSfuEnAPp5p8JKKEQerko7q//HpUiPxfO+eMB1ibZUtcl3QNZRtnn2bN5m6jVMt5brN+jdeAxDODucbBX2dy1EE2ubzucwHxtg/Pb0bG0f2JJOsnMRKiD0RJwo6sKGFP9pJMcI/Cs9B0DsmJjAaTpqtUVjQqSf6gng5DxOajxl5jRFtzuTWf1FQhQmxq1LkIZHIyahMsNjHqkWHg+fXYFCFov4HWyH15Bpb738jRe4KAlUzE3W8vmgepUOiVHEiiu4w6srQrYxCLEPkPA9Zf/qYuoc2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(8936002)(5660300002)(36756003)(41300700001)(6666004)(70586007)(70206006)(8676002)(316002)(7696005)(110136005)(54906003)(4326008)(40480700001)(26005)(478600001)(186003)(336012)(2616005)(1076003)(426003)(86362001)(47076005)(36860700001)(83380400001)(40460700003)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:17:24.6749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297f1a71-26a1-42d9-f48c-08daf243d939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor i2s clock values based on hw_params and use srate and
bclk_ratio variables in clock enable API instead hard-code values.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 169 ++++++++++++++++------------
 1 file changed, 94 insertions(+), 75 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 75beb6e41e99..88c194902157 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -54,10 +54,11 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int acp_clk_enable(struct acp_card_drvdata *drvdata)
+static int acp_clk_enable(struct acp_card_drvdata *drvdata,
+			  unsigned int srate, unsigned int bclk_ratio)
 {
-	clk_set_rate(drvdata->wclk, 48000);
-	clk_set_rate(drvdata->bclk, 48000 * 64);
+	clk_set_rate(drvdata->wclk, srate);
+	clk_set_rate(drvdata->bclk, srate * bclk_ratio);
 
 	return clk_prepare_enable(drvdata->wclk);
 }
@@ -86,27 +87,6 @@ static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != RT5682)
 		return -EINVAL;
 
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL2, RT5682_PLL2_S_MCLK,
-				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
-	if (ret < 0) {
-		dev_err(rtd->dev, "Failed to set codec PLL: %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL2,
-				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		dev_err(rtd->dev, "Failed to set codec SYSCLK: %d\n", ret);
-		return ret;
-	}
-
-	/* Set tdm/i2s1 master bclk ratio */
-	ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
-	if (ret < 0) {
-		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
-		return ret;
-	}
-
 	drvdata->wclk = clk_get(component->dev, "rt5682-dai-wclk");
 	drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
 
@@ -161,16 +141,6 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &constraints_rates);
 
-	if (strcmp(codec_dai->name, "rt5682s-aif1") && strcmp(codec_dai->name, "rt5682s-aif2")) {
-		if (!drvdata->soc_mclk) {
-			ret = acp_clk_enable(drvdata);
-			if (ret < 0) {
-				dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
 	return ret;
 }
 
@@ -193,7 +163,11 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int ret;
-	unsigned int fmt;
+	unsigned int fmt, srate, ch, format;
+
+	srate = params_rate(params);
+	ch = params_channels(params);
+	format = 8 * params_format(params);
 
 	if (drvdata->soc_mclk)
 		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
@@ -212,6 +186,35 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL2, RT5682_PLL2_S_MCLK,
+				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set codec PLL: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL2,
+				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set codec SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	/* Set tdm/i2s1 master bclk ratio */
+	ret = snd_soc_dai_set_bclk_ratio(codec_dai, ch * format);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
+		return ret;
+	}
+
+	if (!drvdata->soc_mclk) {
+		ret = acp_clk_enable(drvdata, srate, ch * format);
+		if (ret < 0) {
+			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -244,27 +247,6 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != RT5682S)
 		return -EINVAL;
 
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
-				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
-	if (ret < 0) {
-		dev_err(rtd->dev, "Failed to set codec PLL: %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682S_SCLK_S_PLL2,
-				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		dev_err(rtd->dev, "Failed to set codec SYSCLK: %d\n", ret);
-		return ret;
-	}
-
-	/* Set tdm/i2s1 master bclk ratio */
-	ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
-	if (ret < 0) {
-		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
-		return ret;
-	}
-
 	if (!drvdata->soc_mclk) {
 		drvdata->wclk = clk_get(component->dev, "rt5682-dai-wclk");
 		drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
@@ -303,7 +285,11 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int ret;
-	unsigned int fmt;
+	unsigned int fmt, srate, ch, format;
+
+	srate = params_rate(params);
+	ch = params_channels(params);
+	format = 8 * params_format(params);
 
 	if (drvdata->soc_mclk)
 		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
@@ -322,6 +308,30 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
+				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set codec PLL: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682S_SCLK_S_PLL2,
+				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set codec SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	/* Set tdm/i2s1 master bclk ratio */
+	ret = snd_soc_dai_set_bclk_ratio(codec_dai, ch * format);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
+		return ret;
+	}
+
+	clk_set_rate(drvdata->wclk, srate);
+	clk_set_rate(drvdata->bclk, srate * ch * format);
+
 	return 0;
 }
 
@@ -397,10 +407,12 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	int srate, i, ret = 0;
-	unsigned int fmt;
+	int i, ret = 0;
+	unsigned int fmt, srate, ch, format;
 
 	srate = params_rate(params);
+	ch = params_channels(params);
+	format = 8 * params_format(params);
 
 	if (drvdata->amp_codec_id != RT1019)
 		return -EINVAL;
@@ -421,7 +433,7 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 			continue;
 
 		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
-					  64 * srate, 256 * srate);
+					  ch * format * srate, 256 * srate);
 		if (ret < 0)
 			return ret;
 
@@ -431,16 +443,20 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	if (!drvdata->soc_mclk) {
+		ret = acp_clk_enable(drvdata, srate, ch * format);
+		if (ret < 0) {
+			dev_err(rtd->card->dev, "Failed to enable AMP clk: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static int acp_card_amp_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_card *card = rtd->card;
-	struct acp_card_drvdata *drvdata = card->drvdata;
-	int ret = 0;
 
 	runtime->hw.channels_max = DUAL_CHANNEL;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
@@ -448,14 +464,7 @@ static int acp_card_amp_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &constraints_rates);
 
-	if (!drvdata->soc_mclk) {
-		ret = acp_clk_enable(drvdata);
-		if (ret < 0) {
-			dev_err(rtd->card->dev, "Failed to enable AMP clk: %d\n", ret);
-			return ret;
-		}
-	}
-	return ret;
+	return 0;
 }
 
 static const struct snd_soc_ops acp_card_rt1019_ops = {
@@ -491,9 +500,13 @@ static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	unsigned int fmt;
+	unsigned int fmt, srate, ch, format;
 	int ret;
 
+	srate = params_rate(params);
+	ch = params_channels(params);
+	format = 8 * params_format(params);
+
 	if (drvdata->soc_mclk)
 		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
@@ -504,6 +517,14 @@ static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
 		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
 		return ret;
 	}
+
+	if (!drvdata->soc_mclk) {
+		ret = acp_clk_enable(drvdata, srate, ch * format);
+		if (ret < 0) {
+			dev_err(rtd->card->dev, "Failed to enable AMP clk: %d\n", ret);
+			return ret;
+		}
+	}
 	return 0;
 }
 
@@ -692,8 +713,6 @@ static int acp_rtk_set_bias_level(struct snd_soc_card *card,
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_dapm_get_bias_level(dapm) == SND_SOC_BIAS_OFF) {
-			clk_set_rate(drvdata->wclk, 48000);
-			clk_set_rate(drvdata->bclk, 48000 * 64);
 
 			/* Increase bclk's enable_count */
 			ret = clk_prepare_enable(drvdata->bclk);
-- 
2.25.1

