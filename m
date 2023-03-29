Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C16CD3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC2IEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjC2IE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:04:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42702109
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:04:27 -0700 (PDT)
X-UUID: 507ebc2cce0811edb6b9f13eb10bd0fe-20230329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=E0T0Nt++F0LJaHY91+B3o38cJeCTneBvrK1430ulA6g=;
        b=QOdSgFekf7oX018+le1rpcaVCAvIEPXObgO2L/9aguBNNwEkTrOq1XfGtDy3J5erYDdnNKtIpqX96wAYoBCVFo04Sg48ABWS63Iyebtm4d3AZ4NovQ7w5pGHW0R/X/lhU71xuZkrB14PbhFrQ6pkapmPQoL+vGoaRzYT+x8rLU0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:9e770a60-a8e7-44aa-ad1a-a0cd6d87cc06,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:a54544f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 507ebc2cce0811edb6b9f13eb10bd0fe-20230329
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1639613718; Wed, 29 Mar 2023 16:04:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 29 Mar 2023 16:04:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 29 Mar 2023 16:04:20 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8186: Move some prints to debug level
Date:   Wed, 29 Mar 2023 16:04:18 +0800
Message-ID: <20230329080418.1100-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many log messages scattered throughout the mt8186 sound
drivers, and they are frequently triggered.

To avoid spamming the console, move these messages to the debug level.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c   | 26 +++++++++----------
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c   |  4 +--
 .../mt8186/mt8186-mt6366-da7219-max98357.c    |  2 +-
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     |  6 ++---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
index eda913fa147a..20b9f5d810ec 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -85,7 +85,7 @@ int mt8186_afe_gpio_init(struct device *dev)
 							     aud_gpios[i].name);
 		if (IS_ERR(aud_gpios[i].gpioctrl)) {
 			ret = PTR_ERR(aud_gpios[i].gpioctrl);
-			dev_info(dev, "%s(), pinctrl_lookup_state %s fail, ret %d\n",
+			dev_dbg(dev, "%s(), pinctrl_lookup_state %s fail, ret %d\n",
 				 __func__, aud_gpios[i].name, ret);
 		} else {
 			aud_gpios[i].gpio_prepare = true;
@@ -108,13 +108,13 @@ static int mt8186_afe_gpio_select(struct device *dev,
 	int ret = 0;
 
 	if (type < 0 || type >= MT8186_AFE_GPIO_GPIO_NUM) {
-		dev_err(dev, "%s(), error, invalid gpio type %d\n",
+		dev_dbg(dev, "%s(), error, invalid gpio type %d\n",
 			__func__, type);
 		return -EINVAL;
 	}
 
 	if (!aud_gpios[type].gpio_prepare) {
-		dev_err(dev, "%s(), error, gpio type %d not prepared\n",
+		dev_dbg(dev, "%s(), error, gpio type %d not prepared\n",
 			__func__, type);
 		return -EIO;
 	}
@@ -122,7 +122,7 @@ static int mt8186_afe_gpio_select(struct device *dev,
 	ret = pinctrl_select_state(aud_pinctrl,
 				   aud_gpios[type].gpioctrl);
 	if (ret) {
-		dev_err(dev, "%s(), error, can not set gpio type %d\n",
+		dev_dbg(dev, "%s(), error, can not set gpio type %d\n",
 			__func__, type);
 		return ret;
 	}
@@ -137,25 +137,25 @@ static int mt8186_afe_gpio_adda_dl(struct device *dev, bool enable)
 	if (enable) {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI CLK ON select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MOSI CLK ON select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI DAT ON select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MOSI DAT ON select fail!\n", __func__);
 			return ret;
 		}
 	} else {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI DAT OFF select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MOSI DAT OFF select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI CLK ON select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MOSI CLK ON select fail!\n", __func__);
 			return ret;
 		}
 	}
@@ -170,25 +170,25 @@ static int mt8186_afe_gpio_adda_ul(struct device *dev, bool enable)
 	if (enable) {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MISO CLK ON select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MISO CLK ON select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MISO DAT ON select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MISO DAT ON select fail!\n", __func__);
 			return ret;
 		}
 	} else {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MISO DAT OFF select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MISO DAT OFF select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MISO CLK OFF select fail!\n", __func__);
+			dev_dbg(dev, "%s(), MISO CLK OFF select fail!\n", __func__);
 			return ret;
 		}
 	}
@@ -230,7 +230,7 @@ int mt8186_afe_gpio_request(struct device *dev, bool enable,
 		sel = enable ? MT8186_AFE_GPIO_PCM_ON : MT8186_AFE_GPIO_PCM_OFF;
 		break;
 	default:
-		dev_err(dev, "%s(), invalid dai %d\n", __func__, dai);
+		dev_dbg(dev, "%s(), invalid dai %d\n", __func__, dai);
 		goto unlock;
 	}
 
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index 094402470dc2..247ab8df941f 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -110,7 +110,7 @@ static unsigned int adda_dl_rate_transform(struct mtk_base_afe *afe,
 	case 192000:
 		return MTK_AFE_ADDA_DL_RATE_192K;
 	default:
-		dev_info(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
+		dev_dbg(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
 			 __func__, rate);
 	}
 
@@ -134,7 +134,7 @@ static unsigned int adda_ul_rate_transform(struct mtk_base_afe *afe,
 	case 192000:
 		return MTK_AFE_ADDA_UL_RATE_192K;
 	default:
-		dev_info(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
+		dev_dbg(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
 			 __func__, rate);
 	}
 
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index 970b980a81e6..cdf54d1eb50d 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -1061,7 +1061,7 @@ static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
 		card->name = card->topology_shortname;
 		sof_on = 1;
 	} else {
-		dev_info(&pdev->dev, "Probe without adsp\n");
+		dev_dbg(&pdev->dev, "Probe without adsp\n");
 	}
 
 	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index b333950aa3c3..7538274641fd 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -95,7 +95,7 @@ static int dmic_set(struct snd_kcontrol *kcontrol,
 	priv->dmic_switch = ucontrol->value.integer.value[0];
 	if (priv->dmic_sel) {
 		gpiod_set_value(priv->dmic_sel, priv->dmic_switch);
-		dev_info(dapm->card->dev, "dmic_set_value %d\n",
+		dev_dbg(dapm->card->dev, "dmic_set_value %d\n",
 			 priv->dmic_switch);
 	}
 	return 0;
@@ -139,7 +139,7 @@ static int primary_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	if (!priv->dmic_sel) {
-		dev_info(card->dev, "dmic_sel is null\n");
+		dev_dbg(card->dev, "dmic_sel is null\n");
 		return 0;
 	}
 
@@ -1152,7 +1152,7 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 		card->name = card->topology_shortname;
 		sof_on = 1;
 	} else {
-		dev_info(&pdev->dev, "Probe without adsp\n");
+		dev_dbg(&pdev->dev, "Probe without adsp\n");
 	}
 
 	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
-- 
2.18.0

