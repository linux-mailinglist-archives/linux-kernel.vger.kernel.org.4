Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27D372C26F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbjFLLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbjFLLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:05:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57E3A27D;
        Mon, 12 Jun 2023 03:53:42 -0700 (PDT)
X-UUID: 635b3bb2090f11eeb20a276fd37b9834-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o1IddyGWhlyZ8P0XVN0pv+4DSnRH4ZFumydBdekLqhA=;
        b=kN14xLsUz9V7qdnBGd82CObcw6XRQAJ5LmLN6MeeyLN0faEt/yCRbrfJq7b+GmuBgXc6Hsbp7MwRkKBc59EOe0yHo0an796btQPhnKaJus6Zlf090kK0U5IPM/ewIiHRhmKis9bC8QDdwdmmYd6bkqhyJd2Or9YpxphEQtFnrq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:87346d40-f711-40f0-8b6b-7e471db2f36c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:e0965a3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 635b3bb2090f11eeb20a276fd37b9834-20230612
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1062071874; Mon, 12 Jun 2023 18:53:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 18:53:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 18:53:38 +0800
From:   Maso Hunag <maso.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH 4/7] ASoC: mediatek: mt79xx: support etdm in platform driver
Date:   Mon, 12 Jun 2023 18:52:47 +0800
Message-ID: <20230612105250.15441-5-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230612105250.15441-1-maso.huang@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maso Huang <maso.huang@mediatek.com>

Add mt79xx etdm dai driver support.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c | 421 ++++++++++++++++++++
 1 file changed, 421 insertions(+)
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c

diff --git a/sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c b/sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c
new file mode 100644
index 000000000000..9a5cc7ce1eae
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek ALSA SoC Audio DAI eTDM Control
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt79xx-afe-clk.h"
+#include "mt79xx-afe-common.h"
+#include "mt79xx-reg.h"
+
+enum {
+	HOPPING_CLK = 0,
+	APLL_CLK = 1,
+};
+
+enum {
+	MTK_DAI_ETDM_FORMAT_I2S = 0,
+	MTK_DAI_ETDM_FORMAT_DSPA = 4,
+	MTK_DAI_ETDM_FORMAT_DSPB = 5,
+};
+
+enum {
+	ETDM_IN5 = 2,
+	ETDM_OUT5 = 10,
+};
+
+enum {
+	MTK_ETDM_RATE_8K = 0,
+	MTK_ETDM_RATE_12K = 1,
+	MTK_ETDM_RATE_16K = 2,
+	MTK_ETDM_RATE_24K = 3,
+	MTK_ETDM_RATE_32K = 4,
+	MTK_ETDM_RATE_48K = 5,
+	MTK_ETDM_RATE_96K = 7,
+	MTK_ETDM_RATE_192K = 9,
+	MTK_ETDM_RATE_11K = 16,
+	MTK_ETDM_RATE_22K = 17,
+	MTK_ETDM_RATE_44K = 18,
+	MTK_ETDM_RATE_88K = 19,
+	MTK_ETDM_RATE_176K = 20,
+};
+
+struct mtk_dai_etdm_priv {
+	bool bck_inv;
+	bool lrck_inv;
+	bool slave_mode;
+	unsigned int format;
+};
+
+static unsigned int mt79xx_etdm_rate_transform(struct device *dev,
+					unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_ETDM_RATE_8K;
+	case 11025:
+		return MTK_ETDM_RATE_11K;
+	case 12000:
+		return MTK_ETDM_RATE_12K;
+	case 16000:
+		return MTK_ETDM_RATE_16K;
+	case 22050:
+		return MTK_ETDM_RATE_22K;
+	case 24000:
+		return MTK_ETDM_RATE_24K;
+	case 32000:
+		return MTK_ETDM_RATE_32K;
+	case 44100:
+		return MTK_ETDM_RATE_44K;
+	case 48000:
+		return MTK_ETDM_RATE_48K;
+	case 88200:
+		return MTK_ETDM_RATE_88K;
+	case 96000:
+		return MTK_ETDM_RATE_96K;
+	case 176400:
+		return MTK_ETDM_RATE_176K;
+	case 192000:
+		return MTK_ETDM_RATE_192K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, use %d!!!\n",
+			 __func__, rate, MTK_ETDM_RATE_48K);
+		return MTK_ETDM_RATE_48K;
+	}
+}
+
+static int get_etdm_wlen(unsigned int bitwidth)
+{
+	return bitwidth <= 16 ? 16 : 32;
+}
+
+/* dai component */
+/* interconnection */
+
+static const struct snd_kcontrol_new o124_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I032_Switch", AFE_CONN124_1, 0, 1, 0),
+};
+
+static const struct snd_kcontrol_new o125_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I033_Switch", AFE_CONN125_1, 1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_etdm_widgets[] = {
+
+	/* DL */
+	SND_SOC_DAPM_MIXER("I150", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I151", SND_SOC_NOPM, 0, 0, NULL, 0),
+	/* UL */
+	SND_SOC_DAPM_MIXER("O124", SND_SOC_NOPM, 0, 0,
+			   o124_mix, ARRAY_SIZE(o124_mix)),
+	SND_SOC_DAPM_MIXER("O125", SND_SOC_NOPM, 0, 0,
+			   o125_mix, ARRAY_SIZE(o125_mix)),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_etdm_routes[] = {
+	{"I150", NULL, "ETDM Capture"},
+	{"I151", NULL, "ETDM Capture"},
+	{"ETDM Playback", NULL, "O124"},
+	{"ETDM Playback", NULL, "O125"},
+	{"O124", "I032_Switch", "I032"},
+	{"O125", "I033_Switch", "I033"},
+};
+
+/* dai ops */
+static int mtk_dai_etdm_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	mt79xx_afe_enable_clock(afe);
+
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_OUT5_PDN_MASK,
+			   0);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_IN5_PDN_MASK,
+			   0);
+
+	return 0;
+}
+
+static void mtk_dai_etdm_shutdown(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_OUT5_PDN_MASK,
+			   CLK_OUT5_PDN);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_IN5_PDN_MASK,
+			   CLK_IN5_PDN);
+
+	mt79xx_afe_disable_clock(afe);
+}
+
+static unsigned int get_etdm_ch_fixup(unsigned int channels)
+{
+	if (channels > 16)
+		return 24;
+	else if (channels > 8)
+		return 16;
+	else if (channels > 4)
+		return 8;
+	else if (channels > 2)
+		return 4;
+	else
+		return 2;
+}
+
+static int mtk_dai_etdm_config(struct mtk_base_afe *afe,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *dai,
+			       int stream)
+{
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	unsigned int rate = params_rate(params);
+	unsigned int etdm_rate = mt79xx_etdm_rate_transform(afe->dev, rate);
+	unsigned int afe_rate = mt79xx_afe_rate_transform(afe->dev, rate);
+	unsigned int channels = params_channels(params);
+	unsigned int bit_width = params_width(params);
+	unsigned int wlen = get_etdm_wlen(bit_width);
+	unsigned int val = 0;
+	unsigned int mask = 0;
+
+	dev_dbg(afe->dev, "%s(), stream %d, rate %u, bitwidth %u\n",
+		 __func__, stream, rate, bit_width);
+
+	/* CON0 */
+	mask |= ETDM_BIT_LEN_MASK;
+	val |= ETDM_BIT_LEN(bit_width);
+	mask |= ETDM_WRD_LEN_MASK;
+	val |= ETDM_WRD_LEN(wlen);
+	mask |= ETDM_FMT_MASK;
+	val |= ETDM_FMT(etdm_data->format);
+	mask |= ETDM_CH_NUM_MASK;
+	val |= ETDM_CH_NUM(get_etdm_ch_fixup(channels));
+	mask |= RELATCH_SRC_MASK;
+	val |= RELATCH_SRC(APLL_CLK);
+
+	switch (stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		/* set ETDM_OUT5_CON0 */
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON0, mask, val);
+
+		/* set ETDM_OUT5_CON4 */
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON4,
+				   OUT_RELATCH_MASK, OUT_RELATCH(afe_rate));
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON4,
+				   OUT_CLK_SRC_MASK, OUT_CLK_SRC(APLL_CLK));
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON4,
+				   OUT_SEL_FS_MASK, OUT_SEL_FS(etdm_rate));
+
+		/* set ETDM_OUT5_CON5 */
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON5,
+				   ETDM_CLK_DIV_MASK, ETDM_CLK_DIV);
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		/* set ETDM_IN5_CON0 */
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON0, mask, val);
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON0,
+				   ETDM_SYNC_MASK, ETDM_SYNC);
+
+		/* set ETDM_IN5_CON2 */
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON2,
+				   IN_CLK_SRC_MASK, IN_CLK_SRC(APLL_CLK));
+
+		/* set ETDM_IN5_CON3 */
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON3,
+				   IN_SEL_FS_MASK, IN_SEL_FS(etdm_rate));
+
+		/* set ETDM_IN5_CON4 */
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON4,
+				   IN_RELATCH_MASK, IN_RELATCH(afe_rate));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_PLAYBACK);
+	mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_CAPTURE);
+
+	return 0;
+}
+
+static int mtk_dai_etdm_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(afe->dev, "%s(), cmd %d, dai id %d\n", __func__, cmd, dai->id);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON0, ETDM_EN_MASK,
+				   ETDM_EN);
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON0, ETDM_EN_MASK,
+				   ETDM_EN);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		regmap_update_bits(afe->regmap, ETDM_IN5_CON0, ETDM_EN_MASK,
+				   0);
+		regmap_update_bits(afe->regmap, ETDM_OUT5_CON0, ETDM_EN_MASK,
+				   0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_dai_etdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_etdm_priv *etdm_data;
+	void *priv_data;
+
+	switch (dai->id) {
+	case MT79XX_DAI_ETDM:
+		break;
+	default:
+		dev_warn(afe->dev, "%s(), id %d not support\n",
+			 __func__, dai->id);
+		return -EINVAL;
+	}
+
+	priv_data = devm_kzalloc(afe->dev, sizeof(struct mtk_dai_etdm_priv),
+				 GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	afe_priv->dai_priv[dai->id] = priv_data;
+	etdm_data = afe_priv->dai_priv[dai->id];
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		etdm_data->format = MTK_DAI_ETDM_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		etdm_data->format = MTK_DAI_ETDM_FORMAT_DSPA;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		etdm_data->format = MTK_DAI_ETDM_FORMAT_DSPB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		etdm_data->bck_inv = false;
+		etdm_data->lrck_inv = false;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		etdm_data->bck_inv = false;
+		etdm_data->lrck_inv = true;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		etdm_data->bck_inv = true;
+		etdm_data->lrck_inv = false;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		etdm_data->bck_inv = true;
+		etdm_data->lrck_inv = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		etdm_data->slave_mode = true;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		etdm_data->slave_mode = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_etdm_ops = {
+	.startup = mtk_dai_etdm_startup,
+	.shutdown = mtk_dai_etdm_shutdown,
+	.hw_params = mtk_dai_etdm_hw_params,
+	.trigger = mtk_dai_etdm_trigger,
+	.set_fmt = mtk_dai_etdm_set_fmt,
+};
+
+/* dai driver */
+#define MTK_ETDM_RATES (SNDRV_PCM_RATE_8000_48000 |\
+			SNDRV_PCM_RATE_88200 |\
+			SNDRV_PCM_RATE_96000 |\
+			SNDRV_PCM_RATE_176400 |\
+			SNDRV_PCM_RATE_192000)
+
+#define MTK_ETDM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE |\
+			  SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_etdm_driver[] = {
+	{
+		.name = "ETDM",
+		.id = MT79XX_DAI_ETDM,
+		.capture = {
+			.stream_name = "ETDM Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ETDM_RATES,
+			.formats = MTK_ETDM_FORMATS,
+		},
+		.playback = {
+			.stream_name = "ETDM Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ETDM_RATES,
+			.formats = MTK_ETDM_FORMATS,
+		},
+		.ops = &mtk_dai_etdm_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+};
+
+int mt79xx_dai_etdm_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_etdm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_etdm_driver);
+
+	dai->dapm_widgets = mtk_dai_etdm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_etdm_widgets);
+	dai->dapm_routes = mtk_dai_etdm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_etdm_routes);
+
+	return 0;
+}
-- 
2.18.0

