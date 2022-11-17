Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B943362DAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbiKQMeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiKQMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:33:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19981742E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668688396; x=1700224396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LrOFW9Vh6X7OMwaap7k/XBm9i91mJbYjMGPAIkdigpQ=;
  b=z8DrCgBkGj84PyeeAlnSjhcu/fUn982e61zZIvJ5+XeAapbsQHajyL/M
   MYk5SHgN6zbFRTqhrDvjXWzMjxehXCWUhWOcI5tIbrtbIGjF+6KX15tHR
   4m3Eq64CTVFhmen8VYQEMyiqpJ8umrKeKFSvb4cncHdsV8C4xuSBrVlc7
   7w9SlFq8n08s9tZK6HpBuRmAbUjj2UwR/7r/uSDOL92o0R0ZgBIT3wD+V
   wmvpB9NS3Wg3ohPykeuwoUxsaMs2xo/bU/BR3JUr+fAhXxYXUcPe41UEP
   2YTb0ki3V+2aJyAn380SlJ5/eilALtg0v52u8JIv4iAHwLbie9y5JLdVp
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="200202331"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 05:33:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 05:33:11 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 05:33:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] ASoC: mchp-spdiftx: add runtime pm support
Date:   Thu, 17 Nov 2022 14:37:49 +0200
Message-ID: <20221117123750.291911-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221117123750.291911-1-claudiu.beznea@microchip.com>
References: <20221117123750.291911-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support for Microchip SPDIFTX driver. The runtime PM
APIs disables/enables IP's clock and enables/disable caching for
regmap.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 116 ++++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 30 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 4e231cec9045..ec454e64d85c 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #include <sound/asoundef.h>
@@ -175,6 +176,7 @@ static const struct regmap_config mchp_spdiftx_regmap_config = {
 	.readable_reg = mchp_spdiftx_readable_reg,
 	.writeable_reg = mchp_spdiftx_writeable_reg,
 	.precious_reg = mchp_spdiftx_precious_reg,
+	.cache_type = REGCACHE_FLAT,
 };
 
 #define SPDIFTX_GCLK_RATIO	128
@@ -196,7 +198,6 @@ struct mchp_spdiftx_dev {
 	struct clk				*pclk;
 	struct clk				*gclk;
 	unsigned int				fmt;
-	unsigned int				gclk_enabled:1;
 };
 
 static inline int mchp_spdiftx_is_running(struct mchp_spdiftx_dev *dev)
@@ -486,10 +487,9 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 	mchp_spdiftx_channel_status_write(dev);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
-	if (dev->gclk_enabled) {
-		clk_disable_unprepare(dev->gclk);
-		dev->gclk_enabled = 0;
-	}
+	/* GCLK is enabled by runtime PM. */
+	clk_disable_unprepare(dev->gclk);
+
 	ret = clk_set_rate(dev->gclk, params_rate(params) *
 				      SPDIFTX_GCLK_RATIO);
 	if (ret) {
@@ -503,7 +503,7 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 		dev_err(dev->dev, "unable to enable gclk: %d\n", ret);
 		return ret;
 	}
-	dev->gclk_enabled = 1;
+
 	dev_dbg(dev->dev, "%s(): GCLK set to %d\n", __func__,
 		params_rate(params) * SPDIFTX_GCLK_RATIO);
 
@@ -523,10 +523,6 @@ static int mchp_spdiftx_hw_free(struct snd_pcm_substream *substream,
 
 	regmap_write(dev->regmap, SPDIFTX_IDR,
 		     SPDIFTX_IR_TXUDR | SPDIFTX_IR_TXOVR);
-	if (dev->gclk_enabled) {
-		clk_disable_unprepare(dev->gclk);
-		dev->gclk_enabled = 0;
-	}
 
 	return regmap_write(dev->regmap, SPDIFTX_CR,
 			    SPDIFTX_CR_SWRST | SPDIFTX_CR_FCLR);
@@ -709,17 +705,9 @@ static struct snd_kcontrol_new mchp_spdiftx_ctrls[] = {
 static int mchp_spdiftx_dai_probe(struct snd_soc_dai *dai)
 {
 	struct mchp_spdiftx_dev *dev = snd_soc_dai_get_drvdata(dai);
-	int ret;
 
 	snd_soc_dai_init_dma_data(dai, &dev->playback, NULL);
 
-	ret = clk_prepare_enable(dev->pclk);
-	if (ret) {
-		dev_err(dev->dev,
-			"failed to enable the peripheral clock: %d\n", ret);
-		return ret;
-	}
-
 	/* Add controls */
 	snd_soc_add_dai_controls(dai, mchp_spdiftx_ctrls,
 				 ARRAY_SIZE(mchp_spdiftx_ctrls));
@@ -727,19 +715,9 @@ static int mchp_spdiftx_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int mchp_spdiftx_dai_remove(struct snd_soc_dai *dai)
-{
-	struct mchp_spdiftx_dev *dev = snd_soc_dai_get_drvdata(dai);
-
-	clk_disable_unprepare(dev->pclk);
-
-	return 0;
-}
-
 static struct snd_soc_dai_driver mchp_spdiftx_dai = {
 	.name = "mchp-spdiftx",
 	.probe	= mchp_spdiftx_dai_probe,
-	.remove	= mchp_spdiftx_dai_remove,
 	.playback = {
 		.stream_name = "S/PDIF Playback",
 		.channels_min = 1,
@@ -763,6 +741,54 @@ static const struct of_device_id mchp_spdiftx_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mchp_spdiftx_dt_ids);
 
+static int mchp_spdiftx_runtime_suspend(struct device *dev)
+{
+	struct mchp_spdiftx_dev *spdiftx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdiftx->regmap, true);
+
+	clk_disable_unprepare(spdiftx->gclk);
+	clk_disable_unprepare(spdiftx->pclk);
+
+	return 0;
+}
+
+static int mchp_spdiftx_runtime_resume(struct device *dev)
+{
+	struct mchp_spdiftx_dev *spdiftx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(spdiftx->pclk);
+	if (ret) {
+		dev_err(spdiftx->dev,
+			"failed to enable the peripheral clock: %d\n", ret);
+		return ret;
+	}
+	ret = clk_prepare_enable(spdiftx->gclk);
+	if (ret) {
+		dev_err(spdiftx->dev,
+			"failed to enable generic clock: %d\n", ret);
+		goto disable_pclk;
+	}
+
+	regcache_cache_only(spdiftx->regmap, false);
+	regcache_mark_dirty(spdiftx->regmap);
+	ret = regcache_sync(spdiftx->regmap);
+	if (ret) {
+		regcache_cache_only(spdiftx->regmap, true);
+		clk_disable_unprepare(spdiftx->gclk);
+disable_pclk:
+		clk_disable_unprepare(spdiftx->pclk);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops mchp_spdiftx_pm_ops = {
+	RUNTIME_PM_OPS(mchp_spdiftx_runtime_suspend, mchp_spdiftx_runtime_resume,
+		       NULL)
+};
+
 static int mchp_spdiftx_probe(struct platform_device *pdev)
 {
 	struct mchp_spdiftx_dev *dev;
@@ -827,29 +853,59 @@ static int mchp_spdiftx_probe(struct platform_device *pdev)
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
 
+	pm_runtime_enable(dev->dev);
+	if (!pm_runtime_enabled(dev->dev)) {
+		err = mchp_spdiftx_runtime_resume(dev->dev);
+		if (err)
+			return err;
+	}
+
 	dev->playback.addr = (dma_addr_t)mem->start + SPDIFTX_CDR;
 	dev->playback.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	err = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register PMC: %d\n", err);
-		return err;
+		goto pm_runtime_suspend;
 	}
 
 	err = devm_snd_soc_register_component(&pdev->dev,
 					      &mchp_spdiftx_component,
 					      &mchp_spdiftx_dai, 1);
-	if (err)
+	if (err) {
 		dev_err(&pdev->dev, "failed to register component: %d\n", err);
+		goto pm_runtime_suspend;
+	}
+
+	return 0;
+
+pm_runtime_suspend:
+	if (!pm_runtime_status_suspended(dev->dev))
+		mchp_spdiftx_runtime_suspend(dev->dev);
+	pm_runtime_disable(dev->dev);
 
 	return err;
 }
 
+static int mchp_spdiftx_remove(struct platform_device *pdev)
+{
+	struct mchp_spdiftx_dev *dev = platform_get_drvdata(pdev);
+
+	if (!pm_runtime_status_suspended(dev->dev))
+		mchp_spdiftx_runtime_suspend(dev->dev);
+
+	pm_runtime_disable(dev->dev);
+
+	return 0;
+}
+
 static struct platform_driver mchp_spdiftx_driver = {
 	.probe	= mchp_spdiftx_probe,
+	.remove = mchp_spdiftx_remove,
 	.driver	= {
 		.name	= "mchp_spdiftx",
 		.of_match_table = of_match_ptr(mchp_spdiftx_dt_ids),
+		.pm = pm_ptr(&mchp_spdiftx_pm_ops)
 	},
 };
 
-- 
2.34.1

