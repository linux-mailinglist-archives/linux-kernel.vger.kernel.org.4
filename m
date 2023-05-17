Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECF7066C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjEQLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjEQLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:33:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C9183;
        Wed, 17 May 2023 04:33:43 -0700 (PDT)
X-UUID: 26661972f4a411edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CVyzVA40tuzeVe+KRUH+YweZtdLrOsOuB+50+LXGXEU=;
        b=Bi0bqUvSZo2OJGm7yrCbdgeKG8Vq6CpUlob/1B4BCMtKpUveoLxOfLRw2WdBeDK22sAWmDCL5nNHmO+Mm/c+kSZnK/uC9O51VmFZjLpzRSmHxHFIDOVP2HY8O3MOg/DVMWAmb+VeKczDssKn5MMuyeMxDTW0M8KrkROIeLgh1/U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:d7dbed48-a267-4fc2-b8af-448a0beeba98,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:24261e6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 26661972f4a411edb20a276fd37b9834-20230517
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 301675458; Wed, 17 May 2023 19:15:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 19:15:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 19:15:36 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 4/5] ASoC: mediatek: mt8188-mt6359: support new board with nau88255
Date:   Wed, 17 May 2023 19:15:33 +0800
Message-ID: <20230517111534.32630-5-trevor.wu@mediatek.com>
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

This patch adds multiple i2s codecs support including NAU88L25,
MAX98390, and the dumb amp like NAU8318 usage. In addition, dmic-codec
is also added to skip the beginning pop noise.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                |   4 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 267 +++++++++++++++++++++-
 2 files changed, 270 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 4baac72677d9..4ea012342b52 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -225,6 +225,10 @@ config SND_SOC_MT8188_MT6359
 	depends on SND_SOC_MT8188 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_DMIC
+	select SND_SOC_MAX98390
+	select SND_SOC_NAU8315
+	select SND_SOC_NAU8825
 	help
 	  This adds support for ASoC machine driver for MediaTek MT8188
 	  boards with the MT6359 and other I2S audio codecs.
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 6c3f36e2fffd..15fce2741f01 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -6,6 +6,7 @@
  * Author: Trevor Wu <trevor.wu@mediatek.com>
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
@@ -13,10 +14,25 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "mt8188-afe-common.h"
+#include "../../codecs/nau8825.h"
 #include "../../codecs/mt6359.h"
 #include "../common/mtk-afe-platform-driver.h"
 #include "../common/mtk-soundcard-driver.h"
 
+/*
+ * Maxim MAX98390
+ */
+#define MAX98390_CODEC_DAI     "max98390-aif1"
+#define MAX98390_DEV0_NAME     "max98390.0-0038" /* rear right */
+#define MAX98390_DEV1_NAME     "max98390.0-0039" /* rear left */
+#define MAX98390_DEV2_NAME     "max98390.0-003a" /* front right */
+#define MAX98390_DEV3_NAME     "max98390.0-003b" /* front left */
+
+/*
+ * Nau88l25
+ */
+#define NAU8825_CODEC_DAI  "nau8825-hifi"
+
 /* FE */
 SND_SOC_DAILINK_DEFS(playback2,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
@@ -143,12 +159,15 @@ SND_SOC_DAILINK_DEFS(pcm1,
 SND_SOC_DAILINK_DEFS(ul_src,
 		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC")),
 		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif1")),
+						   "mt6359-snd-codec-aif1"),
+					COMP_CODEC("dmic-codec",
+						   "dmic-hifi")),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 struct mt8188_mt6359_priv {
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
+	struct snd_soc_jack headset_jack;
 };
 
 static struct snd_soc_jack_pin mt8188_hdmi_jack_pins[] = {
@@ -165,11 +184,50 @@ static struct snd_soc_jack_pin mt8188_dp_jack_pins[] = {
 	},
 };
 
+static struct snd_soc_jack_pin nau8825_jack_pins[] = {
+	{
+		.pin    = "Headphone",
+		.mask   = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin    = "Headset Mic",
+		.mask   = SND_JACK_MICROPHONE,
+	},
+};
+
 struct mt8188_card_data {
 	const char *name;
 	unsigned long quirk;
 };
 
+static const struct snd_kcontrol_new mt8188_dumb_spk_kcontrols[] = {
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+static const struct snd_soc_dapm_widget mt8188_dumb_spk_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_kcontrol_new mt8188_dual_spk_kcontrols[] = {
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+};
+
+static const struct snd_soc_dapm_widget mt8188_dual_spk_widgets[] = {
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+};
+
+static const struct snd_kcontrol_new mt8188_rear_spk_kcontrols[] = {
+	SOC_DAPM_PIN_SWITCH("Rear Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Rear Right Spk"),
+};
+
+static const struct snd_soc_dapm_widget mt8188_rear_spk_widgets[] = {
+	SND_SOC_DAPM_SPK("Rear Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Rear Right Spk", NULL),
+};
+
 static const struct snd_soc_dapm_widget mt8188_mt6359_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -451,6 +509,174 @@ static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static int mt8188_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret = 0;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_dumb_spk_widgets,
+					ARRAY_SIZE(mt8188_dumb_spk_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Dumb Speaker dapm, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8188_dumb_spk_kcontrols,
+					ARRAY_SIZE(mt8188_dumb_spk_kcontrols));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Dumb card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int mt8188_max98390_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int bit_width = params_width(params);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai;
+	int i;
+
+	snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0xf, 4, bit_width);
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		if (!strcmp(codec_dai->component->name, MAX98390_DEV0_NAME))
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x8, 0x3, 4, bit_width);
+
+		if (!strcmp(codec_dai->component->name, MAX98390_DEV1_NAME))
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x4, 0x3, 4, bit_width);
+
+		if (!strcmp(codec_dai->component->name, MAX98390_DEV2_NAME))
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x2, 0x3, 4, bit_width);
+
+		if (!strcmp(codec_dai->component->name, MAX98390_DEV3_NAME))
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x1, 0x3, 4, bit_width);
+	}
+	return 0;
+}
+
+static const struct snd_soc_ops mt8188_max98390_ops = {
+	.hw_params = mt8188_max98390_hw_params,
+};
+
+static int mt8188_max98390_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	/* add regular speakers dapm route */
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_dual_spk_widgets,
+					ARRAY_SIZE(mt8188_dual_spk_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Left/Right Speaker widget, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8188_dual_spk_kcontrols,
+					ARRAY_SIZE(mt8188_dual_spk_kcontrols));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Left/Right card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	if (rtd->dai_link->num_codecs <= 2)
+		return ret;
+
+	/* add widgets/controls/dapm for rear speakers */
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_rear_spk_widgets,
+					ARRAY_SIZE(mt8188_rear_spk_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Rear Speaker widget, ret %d\n", ret);
+		/* Don't need to add routes if widget addition failed */
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8188_rear_spk_kcontrols,
+					ARRAY_SIZE(mt8188_rear_spk_kcontrols));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Rear card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int mt8188_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8188_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_jack *jack = &priv->headset_jack;
+	int ret;
+
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 jack,
+					 nau8825_jack_pins,
+					 ARRAY_SIZE(nau8825_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	ret = snd_soc_component_set_jack(component, jack, NULL);
+
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+};
+
+static void mt8188_nau8825_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
+static int mt8188_nau8825_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	unsigned int rate = params_rate(params);
+	unsigned int bit_width = params_width(params);
+	int clk_freq, ret;
+
+	clk_freq = rate * 2 * bit_width;
+
+	/* Configure clock for codec */
+	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_BLK, 0,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set BCLK clock %d\n", ret);
+		return ret;
+	}
+
+	/* Configure pll for codec */
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, clk_freq,
+				  params_rate(params) * 256);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set BCLK: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_ops mt8188_nau8825_ops = {
+	.hw_params = mt8188_nau8825_hw_params,
+};
 static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 	/* FE */
 	[DAI_LINK_DL2_FE] = {
@@ -726,6 +952,9 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 	struct mt8188_card_data *card_data;
 	struct snd_soc_dai_link *dai_link;
 	bool init_mt6359 = false;
+	bool init_nau8825 = false;
+	bool init_max98390 = false;
+	bool init_dumb = false;
 	int ret, i;
 
 	card_data = (struct mt8188_card_data *)of_device_get_match_data(&pdev->dev);
@@ -776,6 +1005,34 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 				dai_link->init = mt8188_mt6359_init;
 				init_mt6359 = true;
 			}
+		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM2_OUT_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM1_IN_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
+			if (!strcmp(dai_link->codecs->dai_name, MAX98390_CODEC_DAI)) {
+				dai_link->ops = &mt8188_max98390_ops;
+				if (init_max98390)
+					continue;
+
+				dai_link->init = mt8188_max98390_codec_init;
+				init_max98390 = true;
+			} else if (!strcmp(dai_link->codecs->dai_name, NAU8825_CODEC_DAI)) {
+				dai_link->ops = &mt8188_nau8825_ops;
+				if (init_nau8825)
+					continue;
+
+				dai_link->init = mt8188_nau8825_codec_init;
+				dai_link->exit = mt8188_nau8825_codec_exit;
+				init_nau8825 = true;
+			} else {
+				if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai")) {
+					if (init_dumb)
+						continue;
+
+					dai_link->init = mt8188_dumb_amp_init;
+					init_dumb = true;
+				}
+			}
 		}
 	}
 
@@ -795,11 +1052,19 @@ static struct mt8188_card_data mt8188_evb_card = {
 	.name = "mt8188_mt6359",
 };
 
+static struct mt8188_card_data mt8188_nau8825_card = {
+	.name = "mt8188_nau8825",
+};
+
 static const struct of_device_id mt8188_mt6359_dt_match[] = {
 	{
 		.compatible = "mediatek,mt8188-mt6359-evb",
 		.data = &mt8188_evb_card,
 	},
+	{
+		.compatible = "mediatek,mt8188-nau8825",
+		.data = &mt8188_nau8825_card,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
-- 
2.18.0

