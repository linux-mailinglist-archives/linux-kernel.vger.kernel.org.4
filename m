Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A336722CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjARQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjARQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:17:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F655CFFC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E602CE1BD5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA7C433EF;
        Wed, 18 Jan 2023 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058347;
        bh=48FuYf73j5irAdfV5OvRijOa2+RnLc2iiO0dv0dASHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHJYhgtVQnVdtM3GXH1PlDVa63tAXRgp+hPGoN+O2xX7XSgRNjW10imB20sRpRP81
         ZyC+8sw4Oh1XbZzjHJMa5fs3h3r/j5TuQlHqO1aK85whjbAB5OoI88FP6tyr4KNgKB
         fa1BOFWvzOv5wDNPohWXJWO/mFhvHj7vHdOSKD2B/Vw4qRxvEl4wWwBpTIBGKX25Ih
         0cOuV5Bv4PAkAlf/Ymr7340gcFZsZD0QaM44fUR7BT7f7bUUXo5AsZ3rd6TRGYP689
         bWqSoAHItZRc2sahS2zRxyEYsj+g59xwFASryHSFXKMiIp2R69MSVwUvO1RYb/fStF
         wMPnAPKeVRPKA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ASoC: ux500: remove stedma40 references
Date:   Wed, 18 Jan 2023 17:10:48 +0100
Message-Id: <20230118161110.521504-4-arnd@kernel.org>
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

ux500_pcm_request_chan() is never called because the dma channels
are already set up from DT. Remove this, along with the
ux500_msp_dma_params structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ux500/ux500_msp_dai.c |  4 +--
 sound/soc/ux500/ux500_msp_i2s.c | 41 +------------------------------
 sound/soc/ux500/ux500_msp_i2s.h |  9 +------
 sound/soc/ux500/ux500_pcm.c     | 43 +--------------------------------
 4 files changed, 5 insertions(+), 92 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 6e86efd06ec1..6fb1a5c207bc 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -670,8 +670,8 @@ static int ux500_msp_dai_of_probe(struct snd_soc_dai *dai)
 	if (!capture_dma_data)
 		return -ENOMEM;
 
-	playback_dma_data->addr = drvdata->msp->playback_dma_data.tx_rx_addr;
-	capture_dma_data->addr = drvdata->msp->capture_dma_data.tx_rx_addr;
+	playback_dma_data->addr = drvdata->msp->tx_rx_addr;
+	capture_dma_data->addr = drvdata->msp->tx_rx_addr;
 
 	playback_dma_data->maxburst = 4;
 	capture_dma_data->maxburst = 4;
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index bfca5553381f..fbfeefa418ca 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -360,20 +360,6 @@ static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
 				__func__, status);
 	}
 
-	/* Make sure the correct DMA-directions are configured */
-	if ((config->direction & MSP_DIR_RX) &&
-			!msp->capture_dma_data.dma_cfg) {
-		dev_err(msp->dev, "%s: ERROR: MSP RX-mode is not configured!",
-			__func__);
-		return -EINVAL;
-	}
-	if ((config->direction == MSP_DIR_TX) &&
-			!msp->playback_dma_data.dma_cfg) {
-		dev_err(msp->dev, "%s: ERROR: MSP TX-mode is not configured!",
-			__func__);
-		return -EINVAL;
-	}
-
 	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
 	if (config->direction & MSP_DIR_RX)
 		reg_val_DMACR |= RX_DMA_ENABLE;
@@ -638,40 +624,17 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 
 }
 
-static int ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
-				struct ux500_msp *msp);
-{
-	msp->playback_dma_data.dma_cfg = devm_kzalloc(&pdev->dev,
-					sizeof(struct stedma40_chan_cfg),
-					GFP_KERNEL);
-	if (!msp->playback_dma_data.dma_cfg)
-		return -ENOMEM;
-
-	msp->capture_dma_data.dma_cfg = devm_kzalloc(&pdev->dev,
-					sizeof(struct stedma40_chan_cfg),
-					GFP_KERNEL);
-	if (!msp->capture_dma_data.dma_cfg)
-		return -ENOMEM;
-
-	return 0;
-}
-
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 			struct ux500_msp **msp_p)
 {
 	struct resource *res = NULL;
 	struct ux500_msp *msp;
-	int ret;
 
 	*msp_p = devm_kzalloc(&pdev->dev, sizeof(struct ux500_msp), GFP_KERNEL);
 	msp = *msp_p;
 	if (!msp)
 		return -ENOMEM;
 
-	ret = ux500_msp_i2s_of_init_msp(pdev, msp);
-	if (ret)
-		return ret;
-
 	msp->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -681,9 +644,7 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	msp->playback_dma_data.tx_rx_addr = res->start + MSP_DR;
-	msp->capture_dma_data.tx_rx_addr = res->start + MSP_DR;
-
+	msp->tx_rx_addr = res->start + MSP_DR;
 	msp->registers = devm_ioremap(&pdev->dev, res->start,
 				      resource_size(res));
 	if (msp->registers == NULL) {
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 6b353423b75a..69d4ebc409fc 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -462,18 +462,11 @@ struct ux500_msp_config {
 	unsigned int iodelay;
 };
 
-struct ux500_msp_dma_params {
-	unsigned int data_size;
-	dma_addr_t tx_rx_addr;
-	struct stedma40_chan_cfg *dma_cfg;
-};
-
 struct ux500_msp {
 	int id;
 	void __iomem *registers;
 	struct device *dev;
-	struct ux500_msp_dma_params playback_dma_data;
-	struct ux500_msp_dma_params capture_dma_data;
+	dma_addr_t tx_rx_addr;
 	enum msp_state msp_state;
 	int def_elem_len;
 	unsigned int dir_busy;
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index ca87517d80c9..53b5649cfdda 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -13,7 +13,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/slab.h>
-#include <linux/platform_data/dma-ste-dma40.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -29,44 +28,6 @@
 #define UX500_PLATFORM_PERIODS_MAX		48
 #define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
 
-static struct dma_chan *ux500_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
-	struct snd_pcm_substream *substream)
-{
-	struct snd_soc_dai *dai = asoc_rtd_to_cpu(rtd, 0);
-	u16 per_data_width, mem_data_width;
-	struct stedma40_chan_cfg *dma_cfg;
-	struct ux500_msp_dma_params *dma_params;
-
-	dma_params = snd_soc_dai_get_dma_data(dai, substream);
-	dma_cfg = dma_params->dma_cfg;
-
-	mem_data_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	switch (dma_params->data_size) {
-	case 32:
-		per_data_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	case 16:
-		per_data_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case 8:
-		per_data_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-	default:
-		per_data_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	}
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dma_cfg->src_info.data_width = mem_data_width;
-		dma_cfg->dst_info.data_width = per_data_width;
-	} else {
-		dma_cfg->src_info.data_width = per_data_width;
-		dma_cfg->dst_info.data_width = mem_data_width;
-	}
-
-	return snd_dmaengine_pcm_request_channel(stedma40_filter, dma_cfg);
-}
-
 static int ux500_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct dma_slave_config *slave_config)
@@ -98,7 +59,6 @@ static int ux500_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
-	.compat_request_channel = ux500_pcm_request_chan,
 	.prepare_slave_config = ux500_pcm_prepare_slave_config,
 };
 
@@ -107,8 +67,7 @@ int ux500_pcm_register_platform(struct platform_device *pdev)
 	int ret;
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev,
-					 &ux500_dmaengine_of_pcm_config,
-					 SND_DMAENGINE_PCM_FLAG_COMPAT);
+					 &ux500_dmaengine_of_pcm_config, 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
-- 
2.39.0

