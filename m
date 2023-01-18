Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534AD6722C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjARQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjARQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:15:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DB58661;
        Wed, 18 Jan 2023 08:11:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B629D618C4;
        Wed, 18 Jan 2023 16:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52746C433F0;
        Wed, 18 Jan 2023 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058276;
        bh=9lsf4Rm2C5XkHcvH4f3NT1A03Z7ddyEqH7Ndpj9WVgQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i3OjmvfJjrkOXSvvqNgnEwsRYksBPCnCC9hmz2oWHToSKf12DPIRywVZxRy+j/S5z
         3UpnDj96kUM//uubhRWA83wDFKzQ8D2oRtbnlrIzemF9jOsmWR0BGdp3k9ZzZsuhmg
         Yq8DpJzAYze99A9hkmYg1qhWdaOB6/SBEV8eByE5FbhiowKat4fvsgW4hFlPUss2ic
         /e3pvEr/xwE810fWpINZiNBGJSmd8RXe48GQrdqGjv4hg7SO8PX1n/Dt0N+tiwu1NK
         sScI5I2xKUlSFd5C5+zdqam1QkrXPaB/oIKMc1+o88EKQGORcT4N2IFL+ZNr5ZOPWR
         3q34Q2PIOJklA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
Date:   Wed, 18 Jan 2023 17:10:45 +0100
Message-Id: <20230118161110.521504-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

This data is no longer passed by the platform code, so
there is no point passing it down at all.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/platform_data/asoc-s3c.h |  6 ------
 sound/soc/samsung/dma.h                |  2 +-
 sound/soc/samsung/dmaengine.c          |  3 +--
 sound/soc/samsung/i2s.c                | 21 +++------------------
 sound/soc/samsung/pcm.c                | 11 +----------
 sound/soc/samsung/spdif.c              |  9 +--------
 6 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index f9c00f839e9f..84874433cf21 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -30,7 +30,6 @@ struct samsung_i2s_type {
 #define QUIRK_SUPPORTS_IDMA	(1 << 5)
 	/* Quirks of the I2S controller */
 	u32 quirks;
-	dma_addr_t idma_addr;
 };
 
 /**
@@ -39,10 +38,5 @@ struct samsung_i2s_type {
  */
 struct s3c_audio_pdata {
 	int (*cfg_gpio)(struct platform_device *);
-	dma_filter_fn dma_filter;
-	void *dma_playback;
-	void *dma_capture;
-	void *dma_play_sec;
-	void *dma_capture_mic;
 	struct samsung_i2s_type type;
 };
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 7b5d4556e0fd..bd0faf84972e 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -12,7 +12,7 @@
  * @tx, @rx arguments can be NULL if the DMA channel names are "tx", "rx",
  * otherwise actual DMA channel names must be passed to this function.
  */
-int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
+int samsung_asoc_dma_platform_register(struct device *dev,
 				       const char *tx, const char *rx,
 				       struct device *dma_dev);
 #endif /* _SAMSUNG_DMA_H */
diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 2802789a323e..900953ee3786 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -14,7 +14,7 @@
 
 #include "dma.h"
 
-int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
+int samsung_asoc_dma_platform_register(struct device *dev,
 				       const char *tx, const char *rx,
 				       struct device *dma_dev)
 {
@@ -25,7 +25,6 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 		return -ENOMEM;
 
 	pcm_conf->prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
-	pcm_conf->compat_filter_fn = filter;
 	pcm_conf->dma_dev = dma_dev;
 
 	pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9505200f3d11..052c263c126a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -79,7 +79,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data dma_playback;
 	struct snd_dmaengine_dai_dma_data dma_capture;
 	struct snd_dmaengine_dai_dma_data idma_playback;
-	dma_filter_fn filter;
 
 	struct samsung_i2s_priv *priv;
 };
@@ -1431,13 +1430,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->lock);
 	spin_lock_init(&priv->pcm_lock);
 
-	if (!np) {
-		pri_dai->dma_playback.filter_data = i2s_pdata->dma_playback;
-		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
-		pri_dai->filter = i2s_pdata->dma_filter;
-
-		idma_addr = i2s_pdata->type.idma_addr;
-	} else {
+	if (np) {
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
 			if (priv->quirks & QUIRK_SUPPORTS_IDMA) {
@@ -1475,8 +1468,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (priv->quirks & QUIRK_PRI_6CHAN)
 		pri_dai->drv->playback.channels_max = 6;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
-						 "tx", "rx", NULL);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, "tx", "rx", NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
@@ -1485,12 +1477,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
-
-		if (!np) {
-			sec_dai->dma_playback.filter_data = i2s_pdata->dma_play_sec;
-			sec_dai->filter = i2s_pdata->dma_filter;
-		}
-
 		sec_dai->dma_playback.addr_width = 4;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
@@ -1502,8 +1488,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			goto err_disable_clk;
 
 		ret = samsung_asoc_dma_platform_register(&priv->pdev_sec->dev,
-						sec_dai->filter, "tx-sec", NULL,
-						&pdev->dev);
+						"tx-sec", NULL, &pdev->dev);
 		if (ret < 0)
 			goto err_del_sec;
 
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index e859252ae5e6..2f3a99de6434 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -489,7 +489,6 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 	struct s3c_pcm_info *pcm;
 	struct resource *mem_res;
 	struct s3c_audio_pdata *pcm_pdata;
-	dma_filter_fn filter;
 	int ret;
 
 	/* Check for valid device index */
@@ -542,18 +541,10 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 	s3c_pcm_stereo_in[pdev->id].addr = mem_res->start + S3C_PCM_RXFIFO;
 	s3c_pcm_stereo_out[pdev->id].addr = mem_res->start + S3C_PCM_TXFIFO;
 
-	filter = NULL;
-	if (pcm_pdata) {
-		s3c_pcm_stereo_in[pdev->id].filter_data = pcm_pdata->dma_capture;
-		s3c_pcm_stereo_out[pdev->id].filter_data = pcm_pdata->dma_playback;
-		filter = pcm_pdata->dma_filter;
-	}
-
 	pcm->dma_capture = &s3c_pcm_stereo_in[pdev->id];
 	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
-						 NULL, NULL, NULL);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err_dis_pclk;
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 7d815e237e5c..beabcadd7d1d 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -363,7 +363,6 @@ static int spdif_probe(struct platform_device *pdev)
 	struct s3c_audio_pdata *spdif_pdata;
 	struct resource *mem_res;
 	struct samsung_spdif_info *spdif;
-	dma_filter_fn filter;
 	int ret;
 
 	spdif_pdata = pdev->dev.platform_data;
@@ -424,15 +423,9 @@ static int spdif_probe(struct platform_device *pdev)
 
 	spdif_stereo_out.addr_width = 2;
 	spdif_stereo_out.addr = mem_res->start + DATA_OUTBUF;
-	filter = NULL;
-	if (spdif_pdata) {
-		spdif_stereo_out.filter_data = spdif_pdata->dma_playback;
-		filter = spdif_pdata->dma_filter;
-	}
 	spdif->dma_playback = &spdif_stereo_out;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
-						 NULL, NULL, NULL);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DMA: %d\n", ret);
 		goto err4;
-- 
2.39.0

