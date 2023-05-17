Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52297066B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjEQLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjEQLa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:30:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31EB30C8;
        Wed, 17 May 2023 04:30:55 -0700 (PDT)
X-UUID: 2633e60af4a411edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OXa4ipj5zRw2bVBNxgQx3ZtVKWlGRcCu0Y2bi/aJ5mI=;
        b=oLYkwVK+LKgONlLVW6qm6ywX7/ZPMGf8uMboANpKA4GMl/luoQTSGA9pn+FiisDM/QWTRgPiF2zEQtOQE/gmS7R0dYdCY9pKS40QUgGhiS1TzXzg8kPS3ROnteqAtj8VESOdIOe4mnvi9Kfeiaok8vdiFbgWnKvbAXgb5M/kSSI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:7155b7c0-5598-4fba-b8e0-9d1d2ddde3e1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:7155b7c0-5598-4fba-b8e0-9d1d2ddde3e1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:23261e6c-2f20-4998-991c-3b78627e4938,B
        ulkID:230517191538ZCOF3FIX,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 2633e60af4a411edb20a276fd37b9834-20230517
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 624748910; Wed, 17 May 2023 19:15:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 19:15:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 19:15:35 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/5] ASoC: mediatek: mt8188: separate ADDA playback dai from capture dai
Date:   Wed, 17 May 2023 19:15:30 +0800
Message-ID: <20230517111534.32630-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230517111534.32630-1-trevor.wu@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8188 will support SOF. In SOF, be_hw_params_fixup callback are used to
configure BE hardware parameters. However, playback and capture stream
share the same callback function in which it can't know the stream type.

It's possible to require different paremters for playback and capture
stream, so separate them into two dais for SOF usage.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |  3 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   | 76 ++++++++++---------
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 34 +++++++--
 3 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-common.h b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
index eb7e57c239bd..1304d685a306 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-common.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
@@ -39,7 +39,7 @@ enum {
 	MT8188_AFE_MEMIF_END,
 	MT8188_AFE_MEMIF_NUM = (MT8188_AFE_MEMIF_END - MT8188_AFE_MEMIF_START),
 	MT8188_AFE_IO_START = MT8188_AFE_MEMIF_END,
-	MT8188_AFE_IO_ADDA = MT8188_AFE_IO_START,
+	MT8188_AFE_IO_DL_SRC = MT8188_AFE_IO_START,
 	MT8188_AFE_IO_DMIC_IN,
 	MT8188_AFE_IO_DPTX,
 	MT8188_AFE_IO_ETDM_START,
@@ -52,6 +52,7 @@ enum {
 	MT8188_AFE_IO_ETDM_NUM =
 		(MT8188_AFE_IO_ETDM_END - MT8188_AFE_IO_ETDM_START),
 	MT8188_AFE_IO_PCM = MT8188_AFE_IO_ETDM_END,
+	MT8188_AFE_IO_UL_SRC,
 	MT8188_AFE_IO_END,
 	MT8188_AFE_IO_NUM = (MT8188_AFE_IO_END - MT8188_AFE_IO_START),
 	MT8188_DAI_END = MT8188_AFE_IO_END,
diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
index fed9f927e623..9a6673a6f28a 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
@@ -53,8 +53,7 @@ enum {
 };
 
 struct mtk_dai_adda_priv {
-	unsigned int dl_rate;
-	unsigned int ul_rate;
+	bool hires_required;
 };
 
 static unsigned int afe_adda_dl_rate_transform(struct mtk_base_afe *afe,
@@ -241,42 +240,35 @@ static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int mtk_afe_adc_hires_connect(struct snd_soc_dapm_widget *source,
-				     struct snd_soc_dapm_widget *sink)
+static struct mtk_dai_adda_priv *get_adda_priv_by_name(struct mtk_base_afe *afe,
+						       const char *name)
 {
-	struct snd_soc_dapm_widget *w = source;
-	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_adda_priv *adda_priv;
-
-	adda_priv = afe_priv->dai_priv[MT8188_AFE_IO_ADDA];
 
-	if (!adda_priv) {
-		dev_err(afe->dev, "%s adda_priv == NULL", __func__);
-		return 0;
-	}
-
-	return !!(adda_priv->ul_rate > ADDA_HIRES_THRES);
+	if (strstr(name, "aud_adc_hires"))
+		return afe_priv->dai_priv[MT8188_AFE_IO_UL_SRC];
+	else if (strstr(name, "aud_dac_hires"))
+		return afe_priv->dai_priv[MT8188_AFE_IO_DL_SRC];
+	else
+		return NULL;
 }
 
-static int mtk_afe_dac_hires_connect(struct snd_soc_dapm_widget *source,
-				     struct snd_soc_dapm_widget *sink)
+static int mtk_afe_adda_hires_connect(struct snd_soc_dapm_widget *source,
+				      struct snd_soc_dapm_widget *sink)
 {
 	struct snd_soc_dapm_widget *w = source;
 	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
-	struct mt8188_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_dai_adda_priv *adda_priv;
 
-	adda_priv = afe_priv->dai_priv[MT8188_AFE_IO_ADDA];
+	adda_priv = get_adda_priv_by_name(afe, w->name);
 
 	if (!adda_priv) {
-		dev_err(afe->dev, "%s adda_priv == NULL", __func__);
+		dev_dbg(afe->dev, "adda_priv == NULL");
 		return 0;
 	}
 
-	return !!(adda_priv->dl_rate > ADDA_HIRES_THRES);
+	return (adda_priv->hires_required) ? 1 : 0;
 }
 
 static const struct snd_kcontrol_new mtk_dai_adda_o176_mix[] = {
@@ -361,7 +353,7 @@ static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
 	{"ADDA Capture", NULL, "ADDA Capture Enable"},
 	{"ADDA Capture", NULL, "ADDA_MTKAIF_CFG"},
 	{"ADDA Capture", NULL, "aud_adc"},
-	{"ADDA Capture", NULL, "aud_adc_hires", mtk_afe_adc_hires_connect},
+	{"ADDA Capture", NULL, "aud_adc_hires", mtk_afe_adda_hires_connect},
 
 	{"I168", NULL, "ADDA Capture"},
 	{"I169", NULL, "ADDA Capture"},
@@ -369,7 +361,7 @@ static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
 	{"ADDA Playback", NULL, "ADDA Enable"},
 	{"ADDA Playback", NULL, "ADDA Playback Enable"},
 	{"ADDA Playback", NULL, "aud_dac"},
-	{"ADDA Playback", NULL, "aud_dac_hires", mtk_afe_dac_hires_connect},
+	{"ADDA Playback", NULL, "aud_dac_hires", mtk_afe_adda_hires_connect},
 
 	{"DL_GAIN", NULL, "O176"},
 	{"DL_GAIN", NULL, "O177"},
@@ -503,13 +495,15 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %u\n",
 		__func__, id, substream->stream, rate);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adda_priv->dl_rate = rate;
+	if (rate > ADDA_HIRES_THRES)
+		adda_priv->hires_required = 1;
+	else
+		adda_priv->hires_required = 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		ret = mtk_dai_da_configure(afe, rate, id);
-	} else {
-		adda_priv->ul_rate = rate;
+	else
 		ret = mtk_dai_ad_configure(afe, rate, id);
-	}
 
 	return ret;
 }
@@ -536,8 +530,8 @@ static const struct snd_soc_dai_ops mtk_dai_adda_ops = {
 
 static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
 	{
-		.name = "ADDA",
-		.id = MT8188_AFE_IO_ADDA,
+		.name = "DL_SRC",
+		.id = MT8188_AFE_IO_DL_SRC,
 		.playback = {
 			.stream_name = "ADDA Playback",
 			.channels_min = 1,
@@ -545,6 +539,11 @@ static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
 			.rates = MTK_ADDA_PLAYBACK_RATES,
 			.formats = MTK_ADDA_FORMATS,
 		},
+		.ops = &mtk_dai_adda_ops,
+	},
+	{
+		.name = "UL_SRC",
+		.id = MT8188_AFE_IO_UL_SRC,
 		.capture = {
 			.stream_name = "ADDA Capture",
 			.channels_min = 1,
@@ -560,13 +559,18 @@ static int init_adda_priv_data(struct mtk_base_afe *afe)
 {
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_dai_adda_priv *adda_priv;
+	int adda_dai_list[] = {MT8188_AFE_IO_DL_SRC, MT8188_AFE_IO_UL_SRC};
+	int i;
 
-	adda_priv = devm_kzalloc(afe->dev, sizeof(struct mtk_dai_adda_priv),
-				 GFP_KERNEL);
-	if (!adda_priv)
-		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(adda_dai_list); i++) {
+		adda_priv = devm_kzalloc(afe->dev,
+					 sizeof(struct mtk_dai_adda_priv),
+					 GFP_KERNEL);
+		if (!adda_priv)
+			return -ENOMEM;
 
-	afe_priv->dai_priv[MT8188_AFE_IO_ADDA] = adda_priv;
+		afe_priv->dai_priv[adda_dai_list[i]] = adda_priv;
+	}
 
 	return 0;
 }
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 919d74ea1934..833bc362dad2 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -99,8 +99,8 @@ SND_SOC_DAILINK_DEFS(capture10,
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 /* BE */
-SND_SOC_DAILINK_DEFS(adda,
-		     DAILINK_COMP_ARRAY(COMP_CPU("ADDA")),
+SND_SOC_DAILINK_DEFS(dl_src,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL_SRC")),
 		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
 						   "mt6359-snd-codec-aif1")),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
@@ -140,6 +140,12 @@ SND_SOC_DAILINK_DEFS(pcm1,
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
+SND_SOC_DAILINK_DEFS(ul_src,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif1")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 struct mt8188_mt6359_priv {
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
@@ -345,7 +351,7 @@ enum {
 	DAI_LINK_UL8_FE,
 	DAI_LINK_UL9_FE,
 	DAI_LINK_UL10_FE,
-	DAI_LINK_ADDA_BE,
+	DAI_LINK_DL_SRC_BE,
 	DAI_LINK_DPTX_BE,
 	DAI_LINK_ETDM1_IN_BE,
 	DAI_LINK_ETDM2_IN_BE,
@@ -353,6 +359,7 @@ enum {
 	DAI_LINK_ETDM2_OUT_BE,
 	DAI_LINK_ETDM3_OUT_BE,
 	DAI_LINK_PCM1_BE,
+	DAI_LINK_UL_SRC_BE,
 };
 
 static int mt8188_dptx_hw_params(struct snd_pcm_substream *substream,
@@ -604,13 +611,11 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		SND_SOC_DAILINK_REG(capture10),
 	},
 	/* BE */
-	[DAI_LINK_ADDA_BE] = {
-		.name = "ADDA_BE",
+	[DAI_LINK_DL_SRC_BE] = {
+		.name = "DL_SRC_BE",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
-		.dpcm_capture = 1,
-		.init = mt8188_mt6359_init,
-		SND_SOC_DAILINK_REG(adda),
+		SND_SOC_DAILINK_REG(dl_src),
 	},
 	[DAI_LINK_DPTX_BE] = {
 		.name = "DPTX_BE",
@@ -676,6 +681,12 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		.dpcm_capture = 1,
 		SND_SOC_DAILINK_REG(pcm1),
 	},
+	[DAI_LINK_UL_SRC_BE] = {
+		.name = "UL_SRC_BE",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(ul_src),
+	},
 };
 
 static struct snd_soc_card mt8188_mt6359_soc_card = {
@@ -695,6 +706,7 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 	struct mt8188_mt6359_priv *priv;
 	struct mt8188_card_data *card_data;
 	struct snd_soc_dai_link *dai_link;
+	bool init_mt6359 = false;
 	int ret, i;
 
 	card_data = (struct mt8188_card_data *)of_device_get_match_data(&pdev->dev);
@@ -739,6 +751,12 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
 			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
 				dai_link->init = mt8188_hdmi_codec_init;
+		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC_BE") == 0) {
+			if (!init_mt6359) {
+				dai_link->init = mt8188_mt6359_init;
+				init_mt6359 = true;
+			}
 		}
 	}
 
-- 
2.18.0

