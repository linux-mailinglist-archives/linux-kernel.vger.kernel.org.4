Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0772C273
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbjFLLGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbjFLLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:05:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7DA5F5;
        Mon, 12 Jun 2023 03:53:50 -0700 (PDT)
X-UUID: 662e340c090f11ee9cb5633481061a41-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F0WroRpL4W87LvpySauy6LPtn4uVC4FIwATNDea+xmI=;
        b=sC6138fGOtc7eg4Y6nXSR0LRcXKw0jXTBY0JUuKIPEpHJFleZmxD+SsM+LCjeNKFdTBdMu3FHlr8rSh6LlueUX9FnqlAQq3CXdSwXvQPxiDLFjv7CC1I6Bnj9bb5PCc9wnnwSUHuEAfjcVLGrNjI6OkbZrvRsg+fOruWN0DrfiI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:5fd0b786-73c2-44aa-b233-b3e02eaf522b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-55
X-CID-META: VersionHash:cb9a4e1,CLOUDID:84c7293e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 662e340c090f11ee9cb5633481061a41-20230612
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 879636390; Mon, 12 Jun 2023 18:53:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 18:53:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 18:53:42 +0800
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
Subject: [PATCH 5/7] ASoC: mediatek: mt79xx: add machine driver with wm8960
Date:   Mon, 12 Jun 2023 18:52:48 +0800
Message-ID: <20230612105250.15441-6-maso.huang@mediatek.com>
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

Add support for mt79xx board with wm8960.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/Kconfig                |  10 ++
 sound/soc/mediatek/mt79xx/Makefile        |   1 +
 sound/soc/mediatek/mt79xx/mt79xx-wm8960.c | 185 ++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-wm8960.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 192546078d5e..bf641af72210 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -64,6 +64,16 @@ config SND_SOC_MT79XX
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT79XX_WM8960
+	tristate "ASoc Audio driver for MT79XX with WM8960 codec"
+	depends on SND_SOC_MT79XX && I2C
+	select SND_SOC_WM8960
+	help
+	  This adds support for ASoC machine driver for MediaTek MT79XX
+	  boards with the WM8960 codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8173
 	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/mt79xx/Makefile b/sound/soc/mediatek/mt79xx/Makefile
index 984b20ae8819..c910ee88d930 100644
--- a/sound/soc/mediatek/mt79xx/Makefile
+++ b/sound/soc/mediatek/mt79xx/Makefile
@@ -7,3 +7,4 @@ snd-soc-mt79xx-afe-objs := \
 	mt79xx-dai-etdm.o
 
 obj-$(CONFIG_SND_SOC_MT79XX) += snd-soc-mt79xx-afe.o
+obj-$(CONFIG_SND_SOC_MT79XX_WM8960) += mt79xx-wm8960.o
diff --git a/sound/soc/mediatek/mt79xx/mt79xx-wm8960.c b/sound/soc/mediatek/mt79xx/mt79xx-wm8960.c
new file mode 100644
index 000000000000..d1a01a2bb6ae
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-wm8960.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt79xx-wm8960.c  --  MT79xx-WM8960 ALSA SoC machine driver
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include "mt79xx-afe-common.h"
+
+struct mt79xx_wm8960_priv {
+	struct device_node *platform_node;
+	struct device_node *codec_node;
+};
+
+static const struct snd_soc_dapm_widget mt79xx_wm8960_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
+};
+
+static const struct snd_kcontrol_new mt79xx_wm8960_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("AMIC"),
+};
+
+SND_SOC_DAILINK_DEFS(playback,
+	DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture,
+	DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(codec,
+	DAILINK_COMP_ARRAY(COMP_CPU("ETDM")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm8960-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link mt79xx_wm8960_dai_links[] = {
+	/* FE */
+	{
+		.name = "wm8960-playback",
+		.stream_name = "wm8960-playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
+			    SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback),
+	},
+	{
+		.name = "wm8960-capture",
+		.stream_name = "wm8960-capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
+			    SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture),
+	},
+	/* BE */
+	{
+		.name = "wm8960-codec",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS |
+			SND_SOC_DAIFMT_GATED,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(codec),
+	},
+};
+
+static struct snd_soc_card mt79xx_wm8960_card = {
+	.name = "mt79xx-wm8960",
+	.owner = THIS_MODULE,
+	.dai_link = mt79xx_wm8960_dai_links,
+	.num_links = ARRAY_SIZE(mt79xx_wm8960_dai_links),
+	.controls = mt79xx_wm8960_controls,
+	.num_controls = ARRAY_SIZE(mt79xx_wm8960_controls),
+	.dapm_widgets = mt79xx_wm8960_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt79xx_wm8960_widgets),
+};
+
+static int mt79xx_wm8960_machine_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt79xx_wm8960_card;
+	struct snd_soc_dai_link *dai_link;
+	struct mt79xx_wm8960_priv *priv;
+	int ret, i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->platform_node = of_parse_phandle(pdev->dev.of_node,
+					       "mediatek,platform", 0);
+	if (!priv->platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platforms->name)
+			continue;
+		dai_link->platforms->of_node = priv->platform_node;
+	}
+
+	card->dev = &pdev->dev;
+
+	priv->codec_node = of_parse_phandle(pdev->dev.of_node,
+					    "mediatek,audio-codec", 0);
+	if (!priv->codec_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		of_node_put(priv->platform_node);
+		return -EINVAL;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->codecs->name)
+			continue;
+		dai_link->codecs->of_node = priv->codec_node;
+	}
+
+	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
+		goto err_of_node_put;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+			__func__, ret);
+		goto err_of_node_put;
+	}
+
+err_of_node_put:
+	of_node_put(priv->codec_node);
+	of_node_put(priv->platform_node);
+	return ret;
+}
+
+static int mt79xx_wm8960_machine_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct mt79xx_wm8960_priv *priv = snd_soc_card_get_drvdata(card);
+
+	of_node_put(priv->codec_node);
+	of_node_put(priv->platform_node);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mt79xx_wm8960_machine_dt_match[] = {
+	{.compatible = "mediatek,mt79xx-wm8960-machine",},
+	{}
+};
+#endif
+
+static struct platform_driver mt79xx_wm8960_machine = {
+	.driver = {
+		.name = "mt79xx-wm8960",
+#ifdef CONFIG_OF
+		.of_match_table = mt79xx_wm8960_machine_dt_match,
+#endif
+	},
+	.probe = mt79xx_wm8960_machine_probe,
+	.remove = mt79xx_wm8960_machine_remove,
+};
+
+module_platform_driver(mt79xx_wm8960_machine);
+
+/* Module information */
+MODULE_DESCRIPTION("MT79xx WM8960 ALSA SoC machine driver");
+MODULE_AUTHOR("Vic Wu <vic.wu@mediatek.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("mt79xx wm8960 soc card");
-- 
2.18.0

