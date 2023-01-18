Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1376722CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjARQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjARQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:17:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F095925F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:12:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 180F9CE1ACF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD90C433D2;
        Wed, 18 Jan 2023 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058337;
        bh=ZaB0jPSlW+7245jsSFJeMaTfSXc84tEsHJbnVHIlhqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csPz9UFJ1L7KvneFNN/r9YdtjUi0fXBd7mkaC+LXTkEIGr3YUUEprrdIM4JvliaHi
         xpp8Vd22z/ACB/bO1WN5247vMS/WUUv6eowg3u8xNpDwUygr72s5CsL7ngxPY5n9vp
         1CvfEDWDEDO0RmOMmctjGlhzmA4FtMQkelqBPI/1wvNJCuDSl+JsD1oAq+Wy+YGJ5b
         Z5kMmO5h3+r0kMQEzIfwvxbSaDCcEcP0rhnmqKNoeoRg/t7hCOrL83WgRlB5brZMKo
         M5UmMafLXN0ScIZ3Akvm88kJwgp3X0BrHWdjTqh9a4aZZY/O/w8cXk4ZYXuOlY7n5u
         osVghm+IDOyKg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 3/5] ASoC: ux500: remove platform_data support
Date:   Wed, 18 Jan 2023 17:10:47 +0100
Message-Id: <20230118161110.521504-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118161110.521504-1-arnd@kernel.org>
References: <20230118161110.521504-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The platform data definition for ux500 sound devices was removed
six years ago after the DT conversion was completed, see commit
4b483ed0be8b ("ARM: ux500: cut some platform data").

Remove some leftover bits in the ASoC driver and just assume that
it always gets probed using DT.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/platform_data/asoc-ux500-msp.h | 20 ----------
 sound/soc/ux500/mop500.c                     |  8 ++--
 sound/soc/ux500/ux500_msp_dai.c              | 33 +--------------
 sound/soc/ux500/ux500_msp_i2s.c              | 33 +++------------
 sound/soc/ux500/ux500_msp_i2s.h              |  5 +--
 sound/soc/ux500/ux500_pcm.c                  | 42 ++------------------
 6 files changed, 15 insertions(+), 126 deletions(-)
 delete mode 100644 include/linux/platform_data/asoc-ux500-msp.h

diff --git a/include/linux/platform_data/asoc-ux500-msp.h b/include/linux/platform_data/asoc-ux500-msp.h
deleted file mode 100644
index b8d0f730dda8..000000000000
--- a/include/linux/platform_data/asoc-ux500-msp.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- */
-
-#ifndef __MSP_H
-#define __MSP_H
-
-#include <linux/platform_data/dma-ste-dma40.h>
-
-/* Platform data structure for a MSP I2S-device */
-struct msp_i2s_platform_data {
-	int id;
-	struct stedma40_chan_cfg *msp_i2s_dma_rx;
-	struct stedma40_chan_cfg *msp_i2s_dma_tx;
-};
-
-#endif
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index fdd55d772b8e..325e75e96136 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -109,11 +109,9 @@ static int mop500_probe(struct platform_device *pdev)
 
 	mop500_card.dev = &pdev->dev;
 
-	if (np) {
-		ret = mop500_of_probe(pdev, np);
-		if (ret)
-			return ret;
-	}
+	ret = mop500_of_probe(pdev, np);
+	if (ret)
+		return ret;
 
 	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
 		__func__, mop500_card.name);
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 9d99ea6d7f30..6e86efd06ec1 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
@@ -682,26 +681,6 @@ static int ux500_msp_dai_of_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int ux500_msp_dai_probe(struct snd_soc_dai *dai)
-{
-	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
-	struct msp_i2s_platform_data *pdata = dai->dev->platform_data;
-	int ret;
-
-	if (!pdata) {
-		ret = ux500_msp_dai_of_probe(dai);
-		return ret;
-	}
-
-	drvdata->msp->playback_dma_data.data_size = drvdata->slot_width;
-	drvdata->msp->capture_dma_data.data_size = drvdata->slot_width;
-
-	snd_soc_dai_init_dma_data(dai,
-				  &drvdata->msp->playback_dma_data,
-				  &drvdata->msp->capture_dma_data);
-	return 0;
-}
-
 static const struct snd_soc_dai_ops ux500_msp_dai_ops[] = {
 	{
 		.set_sysclk = ux500_msp_dai_set_dai_sysclk,
@@ -716,7 +695,7 @@ static const struct snd_soc_dai_ops ux500_msp_dai_ops[] = {
 };
 
 static struct snd_soc_dai_driver ux500_msp_dai_drv = {
-	.probe                 = ux500_msp_dai_probe,
+	.probe                 = ux500_msp_dai_of_probe,
 	.playback.channels_min = UX500_MSP_MIN_CHANNELS,
 	.playback.channels_max = UX500_MSP_MAX_CHANNELS,
 	.playback.rates        = UX500_I2S_RATES,
@@ -737,15 +716,8 @@ static const struct snd_soc_component_driver ux500_msp_component = {
 static int ux500_msp_drv_probe(struct platform_device *pdev)
 {
 	struct ux500_msp_i2s_drvdata *drvdata;
-	struct msp_i2s_platform_data *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
 	int ret = 0;
 
-	if (!pdata && !np) {
-		dev_err(&pdev->dev, "No platform data or Device Tree found\n");
-		return -ENODEV;
-	}
-
 	drvdata = devm_kzalloc(&pdev->dev,
 				sizeof(struct ux500_msp_i2s_drvdata),
 				GFP_KERNEL);
@@ -787,8 +759,7 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp,
-				pdev->dev.platform_data);
+	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp);
 	if (!drvdata->msp) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to init MSP-struct (%d)!",
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index d113411a19f8..bfca5553381f 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
 
@@ -640,18 +639,8 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 }
 
 static int ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
-				struct ux500_msp *msp,
-				struct msp_i2s_platform_data **platform_data)
+				struct ux500_msp *msp);
 {
-	struct msp_i2s_platform_data *pdata;
-
-	*platform_data = devm_kzalloc(&pdev->dev,
-				     sizeof(struct msp_i2s_platform_data),
-				     GFP_KERNEL);
-	pdata = *platform_data;
-	if (!pdata)
-		return -ENOMEM;
-
 	msp->playback_dma_data.dma_cfg = devm_kzalloc(&pdev->dev,
 					sizeof(struct stedma40_chan_cfg),
 					GFP_KERNEL);
@@ -668,11 +657,9 @@ static int ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
 }
 
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
-			struct ux500_msp **msp_p,
-			struct msp_i2s_platform_data *platform_data)
+			struct ux500_msp **msp_p)
 {
 	struct resource *res = NULL;
-	struct device_node *np = pdev->dev.of_node;
 	struct ux500_msp *msp;
 	int ret;
 
@@ -681,19 +668,9 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 	if (!msp)
 		return -ENOMEM;
 
-	if (!platform_data) {
-		if (np) {
-			ret = ux500_msp_i2s_of_init_msp(pdev, msp,
-							&platform_data);
-			if (ret)
-				return ret;
-		} else
-			return -EINVAL;
-	} else {
-		msp->playback_dma_data.dma_cfg = platform_data->msp_i2s_dma_tx;
-		msp->capture_dma_data.dma_cfg = platform_data->msp_i2s_dma_rx;
-		msp->id = platform_data->id;
-	}
+	ret = ux500_msp_i2s_of_init_msp(pdev, msp);
+	if (ret)
+		return ret;
 
 	msp->dev = &pdev->dev;
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index d45b5e2831cc..6b353423b75a 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -11,7 +11,6 @@
 #define UX500_MSP_I2S_H
 
 #include <linux/platform_device.h>
-#include <linux/platform_data/asoc-ux500-msp.h>
 
 #define MSP_INPUT_FREQ_APB 48000000
 
@@ -482,10 +481,8 @@ struct ux500_msp {
 	unsigned int f_bitclk;
 };
 
-struct msp_i2s_platform_data;
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
-			struct ux500_msp **msp_p,
-			struct msp_i2s_platform_data *platform_data);
+			struct ux500_msp **msp_p);
 void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
 			struct ux500_msp *msp);
 int ux500_msp_i2s_open(struct ux500_msp *msp, struct ux500_msp_config *config);
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index d3802e5ef196..ca87517d80c9 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -29,18 +29,6 @@
 #define UX500_PLATFORM_PERIODS_MAX		48
 #define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
 
-static const struct snd_pcm_hardware ux500_pcm_hw = {
-	.info = SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_RESUME |
-		SNDRV_PCM_INFO_PAUSE,
-	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
-	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
-	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
-	.periods_min = UX500_PLATFORM_PERIODS_MIN,
-	.periods_max = UX500_PLATFORM_PERIODS_MAX,
-};
-
 static struct dma_chan *ux500_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
 	struct snd_pcm_substream *substream)
 {
@@ -84,21 +72,12 @@ static int ux500_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 		struct dma_slave_config *slave_config)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct msp_i2s_platform_data *pdata = asoc_rtd_to_cpu(rtd, 0)->dev->platform_data;
 	struct snd_dmaengine_dai_dma_data *snd_dma_params;
-	struct ux500_msp_dma_params *ste_dma_params;
 	dma_addr_t dma_addr;
 	int ret;
 
-	if (pdata) {
-		ste_dma_params =
-			snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
-		dma_addr = ste_dma_params->tx_rx_addr;
-	} else {
-		snd_dma_params =
-			snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
-		dma_addr = snd_dma_params->addr;
-	}
+	snd_dma_params = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
+	dma_addr = snd_dma_params->addr;
 
 	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
 	if (ret)
@@ -118,13 +97,6 @@ static int ux500_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
-	.pcm_hardware = &ux500_pcm_hw,
-	.compat_request_channel = ux500_pcm_request_chan,
-	.prealloc_buffer_size = 128 * 1024,
-	.prepare_slave_config = ux500_pcm_prepare_slave_config,
-};
-
 static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
 	.compat_request_channel = ux500_pcm_request_chan,
 	.prepare_slave_config = ux500_pcm_prepare_slave_config,
@@ -132,16 +104,10 @@ static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
 
 int ux500_pcm_register_platform(struct platform_device *pdev)
 {
-	const struct snd_dmaengine_pcm_config *pcm_config;
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (np)
-		pcm_config = &ux500_dmaengine_of_pcm_config;
-	else
-		pcm_config = &ux500_dmaengine_pcm_config;
-
-	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config,
+	ret = snd_dmaengine_pcm_register(&pdev->dev,
+					 &ux500_dmaengine_of_pcm_config,
 					 SND_DMAENGINE_PCM_FLAG_COMPAT);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
-- 
2.39.0

