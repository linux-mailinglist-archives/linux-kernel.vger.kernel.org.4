Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01016680D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjA3MJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjA3MIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:08:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8410ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080503; x=1706616503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/tEkZndHLSFZQ+dXZe20waQvOgf9abYz/CSFTYQntc=;
  b=Ru3RGxAu9IaGSbDzdAnDTUGZHA1NoIuZ1GBmHN+gAzslbwRludE+shSt
   53E17j0gaNBjdQSDOXGDFfBvHK8JbcxPOPZJxpiib6TEtbkiTT69Td8i4
   HpL/HL6oVhdgG0bRcoTwELoTTnYHjFR+jBYY1l6FReYqd0rmbhDeuSy4w
   Ga/1PwA21MkFq/KYyBWogmfAT6ZlKNevCTQ6izjBaCKSj/YgFlF4z32fL
   VPVjKzC5pszahhHgJWdB403z2krHX7N75fr4Ja4hb2oDjeAFvYfb8EHb9
   RDju49mgPyOgEkFKGvTQvF8n85qsDygkIRjwRIp1w+RCi69G70VR2poCp
   w==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="194432936"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:24 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/8] ASoC: mchp-spdifrx: fix controls which rely on rsr register
Date:   Mon, 30 Jan 2023 14:06:40 +0200
Message-ID: <20230130120647.638049-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130120647.638049-1-claudiu.beznea@microchip.com>
References: <20230130120647.638049-1-claudiu.beznea@microchip.com>
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

The SPDIFRX block is clocked by 2 clocks: peripheral and generic clocks.
Peripheral clock feeds user interface (registers) and generic clock feeds
the receiver.

To enable the receiver the generic clock needs to be enabled and also the
ENABLE bit of MCHP_SPDIFRX_MR register need to be set.

The signal control exported by mchp-spdifrx driver reports wrong status
when the receiver is disabled. This can happen when requesting the signal
and the capture was not previously started. To solve this the receiver
needs to be enabled (by enabling generic clock and setting ENABLE bit of
MR register) before reading the signal status.

As with this fix there are 2 paths now that need to control the generic
clock and ENABLE bit of SPDIFRX_MR register (one path though controls, one
path though configuration) a mutex has been introduced. We can't rely on
subsystem locking as the controls are protected by
struct snd_card::controls_rwsem semaphore and configuration is protected
by a different lock (embedded in snd_pcm_stream_lock_irq()).

The introduction of mutex is also extended to other controls which rely on
SPDIFRX_RSR.ULOCK bit as it has been discovered experimentally that having
both clocks enabled but not the receiver (through ENABLE bit of SPDIFRX.MR)
leads to inconsistent values of SPDIFRX_RSR.ULOCK. Thus on some controls we
rely on software state (dev->trigger_enabled protected by mutex) to
retrieve proper values.

Fixes: ef265c55c1ac ("ASoC: mchp-spdifrx: add driver for SPDIF RX")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 192 ++++++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 50 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index ec0705cc40fa..2d86e0ec930f 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -233,11 +233,13 @@ struct mchp_spdifrx_dev {
 	struct mchp_spdifrx_mixer_control	control;
 	spinlock_t				blockend_lock;	/* protect access to blockend_refcount */
 	int					blockend_refcount;
+	struct mutex				mlock;
 	struct device				*dev;
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
 	unsigned int				fmt;
+	unsigned int				trigger_enabled;
 	unsigned int				gclk_enabled:1;
 };
 
@@ -353,47 +355,40 @@ static int mchp_spdifrx_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
-	u32 mr;
-	int running;
-	int ret;
-
-	regmap_read(dev->regmap, SPDIFRX_MR, &mr);
-	running = !!(mr & SPDIFRX_MR_RXEN_ENABLE);
+	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!running) {
-			mr &= ~SPDIFRX_MR_RXEN_MASK;
-			mr |= SPDIFRX_MR_RXEN_ENABLE;
-			/* enable overrun interrupts */
-			regmap_write(dev->regmap, SPDIFRX_IER,
-				     SPDIFRX_IR_OVERRUN);
-		}
+		mutex_lock(&dev->mlock);
+		/* Enable overrun interrupts */
+		regmap_write(dev->regmap, SPDIFRX_IER, SPDIFRX_IR_OVERRUN);
+
+		/* Enable receiver. */
+		regmap_update_bits(dev->regmap, SPDIFRX_MR, SPDIFRX_MR_RXEN_MASK,
+				   SPDIFRX_MR_RXEN_ENABLE);
+		dev->trigger_enabled = true;
+		mutex_unlock(&dev->mlock);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (running) {
-			mr &= ~SPDIFRX_MR_RXEN_MASK;
-			mr |= SPDIFRX_MR_RXEN_DISABLE;
-			/* disable overrun interrupts */
-			regmap_write(dev->regmap, SPDIFRX_IDR,
-				     SPDIFRX_IR_OVERRUN);
-		}
+		mutex_lock(&dev->mlock);
+		/* Disable overrun interrupts */
+		regmap_write(dev->regmap, SPDIFRX_IDR, SPDIFRX_IR_OVERRUN);
+
+		/* Disable receiver. */
+		regmap_update_bits(dev->regmap, SPDIFRX_MR, SPDIFRX_MR_RXEN_MASK,
+				   SPDIFRX_MR_RXEN_DISABLE);
+		dev->trigger_enabled = false;
+		mutex_unlock(&dev->mlock);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	ret = regmap_write(dev->regmap, SPDIFRX_MR, mr);
-	if (ret) {
-		dev_err(dev->dev, "unable to enable/disable RX: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
@@ -413,13 +408,6 @@ static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	regmap_read(dev->regmap, SPDIFRX_MR, &mr);
-
-	if (mr & SPDIFRX_MR_RXEN_ENABLE) {
-		dev_err(dev->dev, "PCM already running\n");
-		return -EBUSY;
-	}
-
 	if (params_channels(params) != SPDIFRX_CHANNELS) {
 		dev_err(dev->dev, "unsupported number of channels: %d\n",
 			params_channels(params));
@@ -445,6 +433,13 @@ static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	mutex_lock(&dev->mlock);
+	if (dev->trigger_enabled) {
+		dev_err(dev->dev, "PCM already running\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	if (dev->gclk_enabled) {
 		clk_disable_unprepare(dev->gclk);
 		dev->gclk_enabled = 0;
@@ -455,19 +450,24 @@ static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
 		dev_err(dev->dev,
 			"unable to set gclk min rate: rate %u * ratio %u + 1\n",
 			params_rate(params), SPDIFRX_GCLK_RATIO_MIN);
-		return ret;
+		goto unlock;
 	}
 	ret = clk_prepare_enable(dev->gclk);
 	if (ret) {
 		dev_err(dev->dev, "unable to enable gclk: %d\n", ret);
-		return ret;
+		goto unlock;
 	}
 	dev->gclk_enabled = 1;
 
 	dev_dbg(dev->dev, "GCLK range min set to %d\n",
 		params_rate(params) * SPDIFRX_GCLK_RATIO_MIN + 1);
 
-	return regmap_write(dev->regmap, SPDIFRX_MR, mr);
+	ret = regmap_write(dev->regmap, SPDIFRX_MR, mr);
+
+unlock:
+	mutex_unlock(&dev->mlock);
+
+	return ret;
 }
 
 static int mchp_spdifrx_hw_free(struct snd_pcm_substream *substream,
@@ -475,10 +475,12 @@ static int mchp_spdifrx_hw_free(struct snd_pcm_substream *substream,
 {
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
 
+	mutex_lock(&dev->mlock);
 	if (dev->gclk_enabled) {
 		clk_disable_unprepare(dev->gclk);
 		dev->gclk_enabled = 0;
 	}
+	mutex_unlock(&dev->mlock);
 	return 0;
 }
 
@@ -627,10 +629,24 @@ static int mchp_spdifrx_ulock_get(struct snd_kcontrol *kcontrol,
 	u32 val;
 	bool ulock_old = ctrl->ulock;
 
-	regmap_read(dev->regmap, SPDIFRX_RSR, &val);
-	ctrl->ulock = !(val & SPDIFRX_RSR_ULOCK);
+	mutex_lock(&dev->mlock);
+
+	/*
+	 * The RSR.ULOCK has wrong value if both pclk and gclk are enabled
+	 * and the receiver is disabled. Thus we take into account the
+	 * dev->trigger_enabled here to return a real status.
+	 */
+	if (dev->trigger_enabled) {
+		regmap_read(dev->regmap, SPDIFRX_RSR, &val);
+		ctrl->ulock = !(val & SPDIFRX_RSR_ULOCK);
+	} else {
+		ctrl->ulock = 0;
+	}
+
 	uvalue->value.integer.value[0] = ctrl->ulock;
 
+	mutex_unlock(&dev->mlock);
+
 	return ulock_old != ctrl->ulock;
 }
 
@@ -643,8 +659,22 @@ static int mchp_spdifrx_badf_get(struct snd_kcontrol *kcontrol,
 	u32 val;
 	bool badf_old = ctrl->badf;
 
-	regmap_read(dev->regmap, SPDIFRX_RSR, &val);
-	ctrl->badf = !!(val & SPDIFRX_RSR_BADF);
+	mutex_lock(&dev->mlock);
+
+	/*
+	 * The RSR.ULOCK has wrong value if both pclk and gclk are enabled
+	 * and the receiver is disabled. Thus we take into account the
+	 * dev->trigger_enabled here to return a real status.
+	 */
+	if (dev->trigger_enabled) {
+		regmap_read(dev->regmap, SPDIFRX_RSR, &val);
+		ctrl->badf = !!(val & SPDIFRX_RSR_BADF);
+	} else {
+		ctrl->badf = 0;
+	}
+
+	mutex_unlock(&dev->mlock);
+
 	uvalue->value.integer.value[0] = ctrl->badf;
 
 	return badf_old != ctrl->badf;
@@ -656,11 +686,48 @@ static int mchp_spdifrx_signal_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct mchp_spdifrx_mixer_control *ctrl = &dev->control;
-	u32 val;
+	u32 val = ~0U, loops = 10;
+	int ret;
 	bool signal_old = ctrl->signal;
 
-	regmap_read(dev->regmap, SPDIFRX_RSR, &val);
-	ctrl->signal = !(val & SPDIFRX_RSR_NOSIGNAL);
+	mutex_lock(&dev->mlock);
+
+	/*
+	 * To get the signal we need to have receiver enabled. This
+	 * could be enabled also from trigger() function thus we need to
+	 * take care of not disabling the receiver when it runs.
+	 */
+	if (!dev->trigger_enabled) {
+		ret = clk_prepare_enable(dev->gclk);
+		if (ret)
+			goto unlock;
+
+		regmap_update_bits(dev->regmap, SPDIFRX_MR, SPDIFRX_MR_RXEN_MASK,
+				   SPDIFRX_MR_RXEN_ENABLE);
+
+		/* Wait for RSR.ULOCK bit. */
+		while (--loops) {
+			regmap_read(dev->regmap, SPDIFRX_RSR, &val);
+			if (!(val & SPDIFRX_RSR_ULOCK))
+				break;
+			usleep_range(100, 150);
+		}
+
+		regmap_update_bits(dev->regmap, SPDIFRX_MR, SPDIFRX_MR_RXEN_MASK,
+				   SPDIFRX_MR_RXEN_DISABLE);
+
+		clk_disable_unprepare(dev->gclk);
+	} else {
+		regmap_read(dev->regmap, SPDIFRX_RSR, &val);
+	}
+
+unlock:
+	mutex_unlock(&dev->mlock);
+
+	if (!(val & SPDIFRX_RSR_ULOCK))
+		ctrl->signal = !(val & SPDIFRX_RSR_NOSIGNAL);
+	else
+		ctrl->signal = 0;
 	uvalue->value.integer.value[0] = ctrl->signal;
 
 	return signal_old != ctrl->signal;
@@ -685,18 +752,32 @@ static int mchp_spdifrx_rate_get(struct snd_kcontrol *kcontrol,
 	u32 val;
 	int rate;
 
-	regmap_read(dev->regmap, SPDIFRX_RSR, &val);
-
-	/* if the receiver is not locked, ISF data is invalid */
-	if (val & SPDIFRX_RSR_ULOCK || !(val & SPDIFRX_RSR_IFS_MASK)) {
+	mutex_lock(&dev->mlock);
+
+	/*
+	 * The RSR.ULOCK has wrong value if both pclk and gclk are enabled
+	 * and the receiver is disabled. Thus we take into account the
+	 * dev->trigger_enabled here to return a real status.
+	 */
+	if (dev->trigger_enabled) {
+		regmap_read(dev->regmap, SPDIFRX_RSR, &val);
+		/* If the receiver is not locked, ISF data is invalid. */
+		if (val & SPDIFRX_RSR_ULOCK || !(val & SPDIFRX_RSR_IFS_MASK)) {
+			ucontrol->value.integer.value[0] = 0;
+			goto unlock;
+		}
+	} else {
+		/* Reveicer is not locked, IFS data is invalid. */
 		ucontrol->value.integer.value[0] = 0;
-		return 0;
+		goto unlock;
 	}
 
 	rate = clk_get_rate(dev->gclk);
 
 	ucontrol->value.integer.value[0] = rate / (32 * SPDIFRX_RSR_IFS(val));
 
+unlock:
+	mutex_unlock(&dev->mlock);
 	return 0;
 }
 
@@ -913,7 +994,18 @@ static int mchp_spdifrx_probe(struct platform_device *pdev)
 			"failed to get the PMC generated clock: %d\n", err);
 		return err;
 	}
+
+	/*
+	 * Signal control need a valid rate on gclk. hw_params() configures
+	 * it propertly but requesting signal before any hw_params() has been
+	 * called lead to invalid value returned for signal. Thus, configure
+	 * gclk at a valid rate, here, in initialization, to simplify the
+	 * control path.
+	 */
+	clk_set_min_rate(dev->gclk, 48000 * SPDIFRX_GCLK_RATIO_MIN + 1);
+
 	spin_lock_init(&dev->blockend_lock);
+	mutex_init(&dev->mlock);
 
 	dev->dev = &pdev->dev;
 	dev->regmap = regmap;
-- 
2.34.1

