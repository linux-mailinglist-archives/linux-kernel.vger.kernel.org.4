Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B255FECF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJNLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJNLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:10:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A573CC800
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:10:27 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221014111026epoutp030980a343c2452c600d5b25f50177308e~d6wDpMlJm1260612606epoutp03R
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:10:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221014111026epoutp030980a343c2452c600d5b25f50177308e~d6wDpMlJm1260612606epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665745826;
        bh=GlsBDX1Xi5F1q3jm3rSzlWAbbze0DTUaqvH5QPdWxjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6o+MIPoEzOLlnygehv6yEWNM4Wx2QKViJRYnkXUHcMCXzx0VGc8lwi3mEm3hIzT4
         VgGUeE2M26TVqlBCL7XTMUNsk6mNBTYhAtIkqwewveyAjtcwltUjK+jqmhFpCsCbeM
         f3IXOd7oMZ85gAMg74J5CHKS2wrwDZ/jM/zgQys4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221014111025epcas5p33454cac9eb221db79700a97069879c83~d6wC17uOx0195101951epcas5p3H;
        Fri, 14 Oct 2022 11:10:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MpkFW2sxpz4x9Py; Fri, 14 Oct
        2022 11:10:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.4E.56352.E9349436; Fri, 14 Oct 2022 20:10:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300~d6daR6xQz3049930499epcas5p4j;
        Fri, 14 Oct 2022 10:49:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221014104904epsmtrp298b6903ee5f33d84ebce31bbbe1bc06c~d6daP7brU0248602486epsmtrp28;
        Fri, 14 Oct 2022 10:49:04 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-4a-6349439e61df
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.2C.18644.0AE39436; Fri, 14 Oct 2022 19:49:04 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221014104902epsmtip1c754c02f30e375a080e53f21eddc2281~d6dYAt4lC2736727367epsmtip1d;
        Fri, 14 Oct 2022 10:49:02 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
Date:   Fri, 14 Oct 2022 15:51:49 +0530
Message-Id: <20221014102151.108539-5-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014102151.108539-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmpu48Z89kg8VLRCwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMnlseBQfCK9q+32RqYNzn3sXIySEhYCKxqKOFEcQWEtjNKHF0t2cXIxeQ
        /YlRYkn3JnYI5zOjRNP28ywwHSe+rmGESOxilPh8fg9UVSuTxM8z08FmsQmYSqya08gKkhAR
        aGKSaHszkQXEYRbYyChx+thDJpAqYQFHiab1/ewgNouAqsTWV/1AHRwcvAK2EtM/CkOsk5dY
        veEAM4jNKWAn8bylCWyohMBCDonHT6+yQxS5SBxs7mCEsIUlXh3fAhWXkvj8bi8bhJ0vMe1j
        M5RdIdH2cQMThG0vceDKHBaQvcwCmhLrd+lDhGUlpp5aB1bCLMAn0fv7CVQ5r8SOeTC2qsT6
        5Zug1kpL7Lu+lxFkjISAh0TDjDRIoExklFjf+4VpAqPcLIQNCxgZVzFKphYU56anFpsWGOel
        lsMjLTk/dxMjOJFqee9gfPTgg94hRiYOxkOMEhzMSiK8r5U8k4V4UxIrq1KL8uOLSnNSiw8x
        mgKDbyKzlGhyPjCV55XEG5pYGpiYmZmZWBqbGSqJ8y6eoZUsJJCeWJKanZpakFoE08fEwSnV
        wOTy57R+4qs5HML1956LVwd+slkoetly4fO38135fj2bmtbVcXqq1yTPClcu92v3WKxmN9/X
        nrGqqKR5VYjGHyfxzv8vFFXuXzmyd/Fi0zTWZzY3DBlrNeqnTc0VWbDXfcfiiMBAW+cDDQki
        uZ/8Yj95HUvvesbmPElfO+kgd+QPrnlXDq07U/VU4HyY1N3/iyoPBPtn6zu6msqbrVY5Pr3s
        w3KTnPffGJTbn5vcaT8Z7SL276yQnHaj1804vbaX2+Z8P3p+onz2GQ6+Y+v8r+z+wzc5YNW5
        +gK2FfdSjO5777i9eHsIc+cCOy7B2cIsb+XqZhRMPMK1n4v1xbK98l1r1JkneW1JzONovq4S
        81yJpTgj0VCLuag4EQBAQADjLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO4CO89kg709xhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK6PnlkfBgfCKtu83mRoY97l3MXJySAiYSJz4uoax
        i5GLQ0hgB6PE7c/TWCAS0hLT+/ewQdjCEiv/PWeHKGpmkjjZu4IRJMEmYCqxak4jK0hCRGAC
        UOLdMbBuZoGtjBJTPxuB2MICjhJN6/vZQWwWAVWJra/6gRo4OHgFbCWmfxSGWCAvsXrDAWYQ
        m1PATuJ5SxMriC0EVPL8/DvGCYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BIe6ltYOxj2rPugdYmTiYDzEKMHBrCTC+1rJM1mINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGprBtKTfPcn33OsmaUaTzxXLy969Hi9tWy0Ss8VpnnVz1
        8MqpoPj2Toagq4yh4arvhIMPPNoU6+vKtosxiX353sd1jgySoa5zPm9izqmUeJbALdOaKCh8
        2DX66m5Jvj16v6TOPfP0OnbT/ry0k+63mo92HzhWZHxvPnM7//u8+XL/0303FD4xzJ7o1Xxh
        /oW39yr/3o/W8N+xXaXZR0lgX5Prs6zZ26ee43k/Iz3v28Jjco+D429a2r/dY33x8O+fjhMy
        7wrtXvqrff/LGQcOqKfaVG+1641KzM/6OMeI9fnz5XO0lkgtnhhk9oh9P5Pb9EM+9jo+Twql
        9b6s553Omr/Ve8XS/4sNDD5MkovP4FFiKc5INNRiLipOBABI5RM25AIAAA==
X-CMS-MailID: 20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a soundcard driver for FSD audio interface to bridge the
CPU DAI of samsung I2S with the codec and platform driver.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 sound/soc/samsung/Kconfig    |  12 ++
 sound/soc/samsung/Makefile   |   2 +
 sound/soc/samsung/fsd-card.c | 349 +++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 sound/soc/samsung/fsd-card.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 2a61e620cd3b..344503522bd3 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -239,4 +239,16 @@ config SND_SOC_SAMSUNG_MIDAS_WM1811
 	help
 	  Say Y if you want to add support for SoC audio on the Midas boards.
 
+config SND_SOC_TESLA_FSD
+	tristate "SoC I2S Audio support for Tesla FSD board"
+	depends on SND_SOC_SAMSUNG
+	select SND_SIMPLE_CARD_UTILS
+	select SND_SAMSUNG_I2S
+	help
+	  Say Y if you want to add support for SOC audio on the FSD board.
+	  This will select the SND_SIMPLE_CARD_UTILS to use the dummy
+	  codec driver, incase the codec node is not specified in the device
+	  tree. This sound card driver uses Samsung I2S controller as CPU
+	  and platform DAI.
+
 endif #SND_SOC_SAMSUNG
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 398e843f388c..0dad88fdb1a8 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -43,6 +43,7 @@ snd-soc-arndale-objs := arndale.o
 snd-soc-tm2-wm5110-objs := tm2_wm5110.o
 snd-soc-aries-wm8994-objs := aries_wm8994.o
 snd-soc-midas-wm1811-objs := midas_wm1811.o
+snd-soc-fsd-objs := fsd-card.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -68,3 +69,4 @@ obj-$(CONFIG_SND_SOC_ARNDALE) += snd-soc-arndale.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_TM2_WM5110) += snd-soc-tm2-wm5110.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_ARIES_WM8994) += snd-soc-aries-wm8994.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_MIDAS_WM1811) += snd-soc-midas-wm1811.o
+obj-$(CONFIG_SND_SOC_TESLA_FSD) += snd-soc-fsd.o
diff --git a/sound/soc/samsung/fsd-card.c b/sound/soc/samsung/fsd-card.c
new file mode 100644
index 000000000000..806a4d3b99fd
--- /dev/null
+++ b/sound/soc/samsung/fsd-card.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALSA SoC Audio Layer - FSD Soundcard driver
+ *
+ * Copyright (c) 2022 Samsung Electronics Co. Ltd.
+ *	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
+ */
+
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/simple_card_utils.h>
+
+#include "i2s.h"
+#include "i2s-regs.h"
+
+#define FSD_PREFIX		"tesla,"
+#define FSD_DAI_SRC_PCLK	3
+#define FSD_DAI_RFS_192		192
+#define FSD_DAI_BFS_48		48
+#define FSD_DAI_BFS_96		96
+#define FSD_DAI_BFS_192		192
+
+struct fsd_card_priv {
+	struct snd_soc_card card;
+	struct snd_soc_dai_link *dai_link;
+	u32 tdm_slots;
+	u32 tdm_slot_width;
+};
+
+static unsigned int fsd_card_get_rfs(unsigned int rate)
+{
+	return FSD_DAI_RFS_192;
+}
+
+static unsigned int fsd_card_get_bfs(unsigned int channels)
+{
+	switch (channels) {
+	case 1:
+	case 2:
+		return FSD_DAI_BFS_48;
+	case 3:
+	case 4:
+		return FSD_DAI_BFS_96;
+	case 5:
+	case 6:
+	case 7:
+	case 8:
+		return FSD_DAI_BFS_192;
+	default:
+		return FSD_DAI_BFS_48;
+	}
+}
+
+static unsigned int fsd_card_get_psr(unsigned int rate)
+{
+	switch (rate) {
+	case 8000:	return 43;
+	case 11025:	return 31;
+	case 16000:	return 21;
+	case 22050:	return 16;
+	case 32000:	return 11;
+	case 44100:	return 8;
+	case 48000:	return 7;
+	case 64000:	return 5;
+	case 88200:	return 4;
+	case 96000:	return 4;
+	case 192000:	return 2;
+	default:	return 1;
+	}
+}
+
+static int fsd_card_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd	= substream->private_data;
+	struct snd_soc_card *card	= rtd->card;
+	struct snd_soc_dai *cpu_dai	= asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai_link *link	= rtd->dai_link;
+	struct fsd_card_priv *priv	= snd_soc_card_get_drvdata(card);
+	unsigned int rfs, bfs, psr;
+	int ret = 0, cdclk_dir;
+
+	rfs = fsd_card_get_rfs(params_rate(params));
+	bfs = fsd_card_get_bfs(params_channels(params));
+	psr = fsd_card_get_psr(params_rate(params));
+
+	/* Configure the Root Clock Source */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
+					false, FSD_DAI_SRC_PCLK);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set OPCLK: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_RCLKSRC_0,
+					false, false);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set RCLKSRC: %d\n", ret);
+		goto err;
+	}
+
+	/* Set CPU DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, link->dai_fmt);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set DAIFMT: %d\n", ret);
+		goto err;
+	}
+
+	if (link->dai_fmt & SND_SOC_DAIFMT_CBC_CFC) {
+		cdclk_dir = SND_SOC_CLOCK_OUT;
+	} else if (link->dai_fmt & SND_SOC_DAIFMT_CBP_CFP) {
+		cdclk_dir = SND_SOC_CLOCK_IN;
+	} else {
+		dev_err(card->dev, "Missing Clock Master information\n");
+		goto err;
+	}
+
+	/* Set Clock Source for CDCLK */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
+					rfs, cdclk_dir);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set CDCLK: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_RCLK, psr);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set PSR: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_BCLK, bfs);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set BCLK: %d\n", ret);
+		goto err;
+	}
+
+	if (priv->tdm_slots) {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, false, false,
+				priv->tdm_slots, priv->tdm_slot_width);
+		if (ret < 0) {
+			dev_err(card->dev,
+				"Failed to configure in TDM mode:%d\n", ret);
+			goto err;
+		}
+	}
+
+err:
+	return ret;
+}
+
+static const struct snd_soc_ops fsd_card_ops = {
+	.hw_params	= fsd_card_hw_params,
+};
+
+static struct fsd_card_priv *fsd_card_parse_of(struct snd_soc_card *card)
+{
+	struct fsd_card_priv *priv;
+	struct snd_soc_dai_link *link;
+	struct device *dev = card->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *np, *cpu_node, *codec_node;
+	struct snd_soc_dai_link_component *dlc;
+	int ret, id = 0, num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	if (of_property_read_bool(dev->of_node, "widgets")) {
+		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	/* Add DAPM routes to the card */
+	if (of_property_read_bool(node, "audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	num_links = of_get_child_count(node);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->dai_link = devm_kzalloc(dev, num_links * sizeof(*priv->dai_link),
+								GFP_KERNEL);
+	if (!priv->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	priv->tdm_slots = 0;
+	priv->tdm_slot_width = 0;
+
+	snd_soc_of_parse_tdm_slot(node, NULL, NULL, &priv->tdm_slots,
+			&priv->tdm_slot_width);
+
+	link = priv->dai_link;
+
+	for_each_child_of_node(node, np) {
+		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc)
+			return ERR_PTR(-ENOMEM);
+
+		link->id		= id;
+		link->cpus		= &dlc[0];
+		link->platforms		= &dlc[1];
+		link->num_cpus		= 1;
+		link->num_codecs	= 1;
+		link->num_platforms	= 1;
+
+		cpu_node = of_get_child_by_name(np, "cpu");
+		if (!cpu_node) {
+			dev_err(dev, "Missing CPU/Codec node\n");
+			ret = -EINVAL;
+			goto err_cpu_node;
+		}
+
+		ret = snd_soc_of_get_dai_link_cpus(dev, cpu_node, link);
+		if (ret < 0) {
+			dev_err(dev, "Error Parsing CPU DAI name\n");
+			goto err_cpu_name;
+		}
+
+		link->platforms->of_node = link->cpus->of_node;
+
+		codec_node = of_get_child_by_name(np, "codec");
+		if (codec_node) {
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec_node,
+					link);
+			if (ret < 0) {
+				dev_err(dev, "Error Parsing Codec DAI name\n");
+				goto err_codec_name;
+			}
+		} else {
+			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
+			if (!dlc) {
+				ret = -ENOMEM;
+				goto err_cpu_name;
+			}
+
+			link->codecs = dlc;
+
+			link->codecs->dai_name = "snd-soc-dummy-dai";
+			link->codecs->name = "snd-soc-dummy";
+			link->dynamic = 1;
+
+			snd_soc_dai_link_set_capabilities(link);
+			link->ignore_suspend = 1;
+			link->nonatomic = 1;
+		}
+
+		ret = asoc_simple_parse_daifmt(dev, np, codec_node,
+					FSD_PREFIX, &link->dai_fmt);
+		if (ret)
+			link->dai_fmt = SND_SOC_DAIFMT_NB_NF |
+					SND_SOC_DAIFMT_CBC_CFC |
+					SND_SOC_DAIFMT_I2S;
+
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "Error Parsing link name\n");
+			goto err_codec_name;
+		}
+
+		link->stream_name = link->name;
+		link->ops = &fsd_card_ops;
+
+		link++;
+		id++;
+
+		of_node_put(cpu_node);
+		of_node_put(codec_node);
+	}
+
+	card->dai_link = priv->dai_link;
+	card->num_links = num_links;
+
+	return priv;
+
+err_codec_name:
+	of_node_put(codec_node);
+err_cpu_name:
+	of_node_put(cpu_node);
+err_cpu_node:
+	of_node_put(np);
+	return ERR_PTR(ret);
+}
+
+static int fsd_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct snd_soc_card *card;
+	struct fsd_card_priv *fsd_priv;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	card->dev	= dev;
+	fsd_priv	= fsd_card_parse_of(card);
+
+	if (IS_ERR(fsd_priv)) {
+		dev_err(&pdev->dev, "Error Parsing DAI Link: %ld\n",
+				PTR_ERR(fsd_priv));
+		return PTR_ERR(fsd_priv);
+	}
+
+	snd_soc_card_set_drvdata(card, fsd_priv);
+
+	return devm_snd_soc_register_card(&pdev->dev, card);
+}
+
+static const struct of_device_id fsd_device_id[] = {
+	{ .compatible = "tesla,fsd-card" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fsd_device_id);
+
+static struct platform_driver fsd_platform_driver = {
+	.driver = {
+		.name = "fsd-card",
+		.of_match_table = of_match_ptr(fsd_device_id),
+	},
+	.probe = fsd_platform_probe,
+};
+module_platform_driver(fsd_platform_driver);
+
+MODULE_AUTHOR("Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>");
+MODULE_DESCRIPTION("FSD ASoC Soundcard Driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

