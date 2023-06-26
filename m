Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6A73D5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjFZCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjFZCgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:36:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAAFE4C;
        Sun, 25 Jun 2023 19:35:45 -0700 (PDT)
X-UUID: 22afeae813ca11eeb20a276fd37b9834-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RLTg13z0bWZRW9UF2KgfOyMBiFgfIAzSDo5g8D5zKOY=;
        b=n29cd8ZWCxLVxfJVkOmSu9+JzuN1HrLyB2KOeWasVsbFA4yNR0Rs/DZnqFo418m1pbJC5KVGBYCzvWqu7sfzTUD60D3f2yEfeMBo5l2r13VPkP634+XTSSi1+2PBPqzqX378XQNGdu8xe7l5ciHlrDfOh2/P3WcWsmRgIafeiB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:7419d3c9-5aec-46d2-b44a-dfaedb268866,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:20ff6f3f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 22afeae813ca11eeb20a276fd37b9834-20230626
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1937958133; Mon, 26 Jun 2023 10:35:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 10:35:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 10:35:36 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v2 5/7] ASoC: mediatek: mt7986: add machine driver with wm8960
Date:   Mon, 26 Jun 2023 10:34:59 +0800
Message-ID: <20230626023501.11120-6-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230626023501.11120-1-maso.huang@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mt7986 board with wm8960.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/Kconfig                |  10 ++
 sound/soc/mediatek/mt7986/Makefile        |   1 +
 sound/soc/mediatek/mt7986/mt7986-wm8960.c | 184 ++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-wm8960.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 558827755a8d..8d1bc8814486 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -64,6 +64,16 @@ config SND_SOC_MT7986
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT7986_WM8960
+	tristate "ASoc Audio driver for MT7986 with WM8960 codec"
+	depends on SND_SOC_MT7986 && I2C
+	select SND_SOC_WM8960
+	help
+	  This adds support for ASoC machine driver for MediaTek MT7986
+	  boards with the WM8960 codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8173
 	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/mt7986/Makefile b/sound/soc/mediatek/mt7986/Makefile
index 7c0ece616198..4d75e116f246 100644
--- a/sound/soc/mediatek/mt7986/Makefile
+++ b/sound/soc/mediatek/mt7986/Makefile
@@ -7,3 +7,4 @@ snd-soc-mt7986-afe-objs := \
 	mt7986-dai-etdm.o
 
 obj-$(CONFIG_SND_SOC_MT7986) += snd-soc-mt7986-afe.o
+obj-$(CONFIG_SND_SOC_MT7986_WM8960) += mt7986-wm8960.o
diff --git a/sound/soc/mediatek/mt7986/mt7986-wm8960.c b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
new file mode 100644
index 000000000000..a880fcb8662e
--- /dev/null
+++ b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt7986-wm8960.c  --  MT7986-WM8960 ALSA SoC machine driver
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include "mt7986-afe-common.h"
+
+struct mt7986_wm8960_priv {
+	struct device_node *platform_node;
+	struct device_node *codec_node;
+};
+
+static const struct snd_soc_dapm_widget mt7986_wm8960_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
+};
+
+static const struct snd_kcontrol_new mt7986_wm8960_controls[] = {
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
+static struct snd_soc_dai_link mt7986_wm8960_dai_links[] = {
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
+static struct snd_soc_card mt7986_wm8960_card = {
+	.name = "mt7986-wm8960",
+	.owner = THIS_MODULE,
+	.dai_link = mt7986_wm8960_dai_links,
+	.num_links = ARRAY_SIZE(mt7986_wm8960_dai_links),
+	.controls = mt7986_wm8960_controls,
+	.num_controls = ARRAY_SIZE(mt7986_wm8960_controls),
+	.dapm_widgets = mt7986_wm8960_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt7986_wm8960_widgets),
+};
+
+static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt7986_wm8960_card;
+	struct snd_soc_dai_link *dai_link;
+	struct mt7986_wm8960_priv *priv;
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
+static void mt7986_wm8960_machine_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct mt7986_wm8960_priv *priv = snd_soc_card_get_drvdata(card);
+
+	of_node_put(priv->codec_node);
+	of_node_put(priv->platform_node);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mt7986_wm8960_machine_dt_match[] = {
+	{.compatible = "mediatek,mt7986-wm8960-machine",},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mt7986_wm8960_machine_dt_match);
+#endif
+
+static struct platform_driver mt7986_wm8960_machine = {
+	.driver = {
+		.name = "mt7986-wm8960",
+#ifdef CONFIG_OF
+		.of_match_table = mt7986_wm8960_machine_dt_match,
+#endif
+	},
+	.probe = mt7986_wm8960_machine_probe,
+	.remove_new = mt7986_wm8960_machine_remove,
+};
+
+module_platform_driver(mt7986_wm8960_machine);
+
+/* Module information */
+MODULE_DESCRIPTION("MT7986 WM8960 ALSA SoC machine driver");
+MODULE_AUTHOR("Vic Wu <vic.wu@mediatek.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("mt7986 wm8960 soc card");
-- 
2.18.0

