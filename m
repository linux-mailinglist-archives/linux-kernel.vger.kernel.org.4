Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47704680D28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjA3MKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjA3MJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:09:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D710ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080540; x=1706616540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3S3eY9RQtpuSlzP+O7igbYJtQsWXUsgyYbzOFDO/FQ=;
  b=t1p5Q3nX2xJdNFTPbSAmnMIRMxixvDg7ihMFqzC7p55j/opyaKzPnTFb
   iZg4gDFvmOyy00SK6+u8XCfznhAo0yO5+nF4ZKUkeg3dKl/s0y7+B0oeP
   qRCQpWJe2ZwfKS/LJnTdwdb2pC0jfDYejOoJucFIsaC2OAYfRpV7LA9wq
   3z2d+AxEZbdb1lwv9Ac30JWghiZ1owDqtDwO2gEf2F2+QU3WHy9lMLig7
   KpRyXna7KQqDZJQ95yS25OVNb86i4kdDI6dTt2mnnRcRzQvUHZ2pb4TLe
   h/u0EUumYqbnobB+WfRpDkXHiKT8Q+yEL63u/58D63373k5YbFXCK8QX3
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="134605344"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:48 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/8] ASoC: mchp-spdifrx: add runtime pm support
Date:   Mon, 30 Jan 2023 14:06:46 +0200
Message-ID: <20230130120647.638049-8-claudiu.beznea@microchip.com>
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

Add runtime PM support for Microchip SPDIFRX driver. On runtime suspend
the clocks are disabled and regmap is set in caching mode. On runtime
resume the clocks are enabled and regmap is synced with the device.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 210 ++++++++++++++++++++++++++-------
 1 file changed, 166 insertions(+), 44 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 46fff31321f3..796d4ec2b2b1 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/spinlock.h>
 
@@ -192,6 +193,43 @@ static bool mchp_spdifrx_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool mchp_spdifrx_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SPDIFRX_IMR:
+	case SPDIFRX_ISR:
+	case SPDIFRX_RSR:
+	case SPDIFRX_CHSR(0, 0):
+	case SPDIFRX_CHSR(0, 1):
+	case SPDIFRX_CHSR(0, 2):
+	case SPDIFRX_CHSR(0, 3):
+	case SPDIFRX_CHSR(0, 4):
+	case SPDIFRX_CHSR(0, 5):
+	case SPDIFRX_CHUD(0, 0):
+	case SPDIFRX_CHUD(0, 1):
+	case SPDIFRX_CHUD(0, 2):
+	case SPDIFRX_CHUD(0, 3):
+	case SPDIFRX_CHUD(0, 4):
+	case SPDIFRX_CHUD(0, 5):
+	case SPDIFRX_CHSR(1, 0):
+	case SPDIFRX_CHSR(1, 1):
+	case SPDIFRX_CHSR(1, 2):
+	case SPDIFRX_CHSR(1, 3):
+	case SPDIFRX_CHSR(1, 4):
+	case SPDIFRX_CHSR(1, 5):
+	case SPDIFRX_CHUD(1, 0):
+	case SPDIFRX_CHUD(1, 1):
+	case SPDIFRX_CHUD(1, 2):
+	case SPDIFRX_CHUD(1, 3):
+	case SPDIFRX_CHUD(1, 4):
+	case SPDIFRX_CHUD(1, 5):
+	case SPDIFRX_VERSION:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config mchp_spdifrx_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -200,6 +238,8 @@ static const struct regmap_config mchp_spdifrx_regmap_config = {
 	.readable_reg = mchp_spdifrx_readable_reg,
 	.writeable_reg = mchp_spdifrx_writeable_reg,
 	.precious_reg = mchp_spdifrx_precious_reg,
+	.volatile_reg = mchp_spdifrx_volatile_reg,
+	.cache_type = REGCACHE_FLAT,
 };
 
 #define SPDIFRX_GCLK_RATIO_MIN	(12 * 64)
@@ -236,7 +276,6 @@ struct mchp_spdifrx_dev {
 	struct clk				*pclk;
 	struct clk				*gclk;
 	unsigned int				trigger_enabled;
-	unsigned int				gclk_enabled:1;
 };
 
 static void mchp_spdifrx_channel_status_read(struct mchp_spdifrx_dev *dev,
@@ -405,16 +444,17 @@ static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
 		goto unlock;
 	}
 
-	if (dev->gclk_enabled) {
-		clk_disable_unprepare(dev->gclk);
-		dev->gclk_enabled = 0;
-	}
+	/* GCLK is enabled by runtime PM. */
+	clk_disable_unprepare(dev->gclk);
+
 	ret = clk_set_min_rate(dev->gclk, params_rate(params) *
 					  SPDIFRX_GCLK_RATIO_MIN + 1);
 	if (ret) {
 		dev_err(dev->dev,
 			"unable to set gclk min rate: rate %u * ratio %u + 1\n",
 			params_rate(params), SPDIFRX_GCLK_RATIO_MIN);
+		/* Restore runtime PM state. */
+		clk_prepare_enable(dev->gclk);
 		goto unlock;
 	}
 	ret = clk_prepare_enable(dev->gclk);
@@ -422,7 +462,6 @@ static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
 		dev_err(dev->dev, "unable to enable gclk: %d\n", ret);
 		goto unlock;
 	}
-	dev->gclk_enabled = 1;
 
 	dev_dbg(dev->dev, "GCLK range min set to %d\n",
 		params_rate(params) * SPDIFRX_GCLK_RATIO_MIN + 1);
@@ -435,24 +474,9 @@ static int mchp_spdifrx_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int mchp_spdifrx_hw_free(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
-{
-	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
-
-	mutex_lock(&dev->mlock);
-	if (dev->gclk_enabled) {
-		clk_disable_unprepare(dev->gclk);
-		dev->gclk_enabled = 0;
-	}
-	mutex_unlock(&dev->mlock);
-	return 0;
-}
-
 static const struct snd_soc_dai_ops mchp_spdifrx_dai_ops = {
 	.trigger	= mchp_spdifrx_trigger,
 	.hw_params	= mchp_spdifrx_hw_params,
-	.hw_free	= mchp_spdifrx_hw_free,
 };
 
 #define MCHP_SPDIF_RATES	SNDRV_PCM_RATE_8000_192000
@@ -486,6 +510,10 @@ static int mchp_spdifrx_cs_get(struct mchp_spdifrx_dev *dev,
 
 	mutex_lock(&dev->mlock);
 
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto unlock;
+
 	/*
 	 * We may reach this point with both clocks enabled but the receiver
 	 * still disabled. To void waiting for completion and return with
@@ -512,7 +540,7 @@ static int mchp_spdifrx_cs_get(struct mchp_spdifrx_dev *dev,
 				channel);
 			regmap_write(dev->regmap, SPDIFRX_IDR, SPDIFRX_IR_CSC(channel));
 			ret = ret ? : -ETIMEDOUT;
-			goto unlock;
+			goto pm_runtime_put;
 		} else {
 			ret = 0;
 		}
@@ -524,6 +552,9 @@ static int mchp_spdifrx_cs_get(struct mchp_spdifrx_dev *dev,
 	memcpy(uvalue->value.iec958.status, ch_stat->data,
 	       sizeof(ch_stat->data));
 
+pm_runtime_put:
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 unlock:
 	mutex_unlock(&dev->mlock);
 	return ret;
@@ -566,6 +597,10 @@ static int mchp_spdifrx_subcode_ch_get(struct mchp_spdifrx_dev *dev,
 
 	mutex_lock(&dev->mlock);
 
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto unlock;
+
 	/*
 	 * We may reach this point with both clocks enabled but the receiver
 	 * still disabled. To void waiting for completion to just timeout we
@@ -588,7 +623,7 @@ static int mchp_spdifrx_subcode_ch_get(struct mchp_spdifrx_dev *dev,
 				channel);
 			regmap_write(dev->regmap, SPDIFRX_IDR, SPDIFRX_IR_BLOCKEND);
 			ret = ret ? : -ETIMEDOUT;
-			goto unlock;
+			goto pm_runtime_put;
 		} else {
 			ret = 0;
 		}
@@ -600,6 +635,9 @@ static int mchp_spdifrx_subcode_ch_get(struct mchp_spdifrx_dev *dev,
 	memcpy(uvalue->value.iec958.subcode, user_data->data,
 	       sizeof(user_data->data));
 
+pm_runtime_put:
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 unlock:
 	mutex_unlock(&dev->mlock);
 	return ret;
@@ -641,10 +679,15 @@ static int mchp_spdifrx_ulock_get(struct snd_kcontrol *kcontrol,
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct mchp_spdifrx_mixer_control *ctrl = &dev->control;
 	u32 val;
+	int ret;
 	bool ulock_old = ctrl->ulock;
 
 	mutex_lock(&dev->mlock);
 
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto unlock;
+
 	/*
 	 * The RSR.ULOCK has wrong value if both pclk and gclk are enabled
 	 * and the receiver is disabled. Thus we take into account the
@@ -659,6 +702,9 @@ static int mchp_spdifrx_ulock_get(struct snd_kcontrol *kcontrol,
 
 	uvalue->value.integer.value[0] = ctrl->ulock;
 
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+unlock:
 	mutex_unlock(&dev->mlock);
 
 	return ulock_old != ctrl->ulock;
@@ -671,10 +717,15 @@ static int mchp_spdifrx_badf_get(struct snd_kcontrol *kcontrol,
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct mchp_spdifrx_mixer_control *ctrl = &dev->control;
 	u32 val;
+	int ret;
 	bool badf_old = ctrl->badf;
 
 	mutex_lock(&dev->mlock);
 
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto unlock;
+
 	/*
 	 * The RSR.ULOCK has wrong value if both pclk and gclk are enabled
 	 * and the receiver is disabled. Thus we take into account the
@@ -687,6 +738,9 @@ static int mchp_spdifrx_badf_get(struct snd_kcontrol *kcontrol,
 		ctrl->badf = 0;
 	}
 
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+unlock:
 	mutex_unlock(&dev->mlock);
 
 	uvalue->value.integer.value[0] = ctrl->badf;
@@ -706,16 +760,16 @@ static int mchp_spdifrx_signal_get(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&dev->mlock);
 
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto unlock;
+
 	/*
 	 * To get the signal we need to have receiver enabled. This
 	 * could be enabled also from trigger() function thus we need to
 	 * take care of not disabling the receiver when it runs.
 	 */
 	if (!dev->trigger_enabled) {
-		ret = clk_prepare_enable(dev->gclk);
-		if (ret)
-			goto unlock;
-
 		regmap_update_bits(dev->regmap, SPDIFRX_MR, SPDIFRX_MR_RXEN_MASK,
 				   SPDIFRX_MR_RXEN_ENABLE);
 
@@ -729,12 +783,13 @@ static int mchp_spdifrx_signal_get(struct snd_kcontrol *kcontrol,
 
 		regmap_update_bits(dev->regmap, SPDIFRX_MR, SPDIFRX_MR_RXEN_MASK,
 				   SPDIFRX_MR_RXEN_DISABLE);
-
-		clk_disable_unprepare(dev->gclk);
 	} else {
 		regmap_read(dev->regmap, SPDIFRX_RSR, &val);
 	}
 
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 unlock:
 	mutex_unlock(&dev->mlock);
 
@@ -765,9 +820,14 @@ static int mchp_spdifrx_rate_get(struct snd_kcontrol *kcontrol,
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
 	unsigned long rate;
 	u32 val;
+	int ret;
 
 	mutex_lock(&dev->mlock);
 
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto unlock;
+
 	/*
 	 * The RSR.ULOCK has wrong value if both pclk and gclk are enabled
 	 * and the receiver is disabled. Thus we take into account the
@@ -778,21 +838,24 @@ static int mchp_spdifrx_rate_get(struct snd_kcontrol *kcontrol,
 		/* If the receiver is not locked, ISF data is invalid. */
 		if (val & SPDIFRX_RSR_ULOCK || !(val & SPDIFRX_RSR_IFS_MASK)) {
 			ucontrol->value.integer.value[0] = 0;
-			goto unlock;
+			goto pm_runtime_put;
 		}
 	} else {
 		/* Reveicer is not locked, IFS data is invalid. */
 		ucontrol->value.integer.value[0] = 0;
-		goto unlock;
+		goto pm_runtime_put;
 	}
 
 	rate = clk_get_rate(dev->gclk);
 
 	ucontrol->value.integer.value[0] = rate / (32 * SPDIFRX_RSR_IFS(val));
 
+pm_runtime_put:
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 unlock:
 	mutex_unlock(&dev->mlock);
-	return 0;
+	return ret;
 }
 
 static struct snd_kcontrol_new mchp_spdifrx_ctrls[] = {
@@ -882,14 +945,6 @@ static int mchp_spdifrx_dai_probe(struct snd_soc_dai *dai)
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct mchp_spdifrx_mixer_control *ctrl = &dev->control;
 	int ch;
-	int err;
-
-	err = clk_prepare_enable(dev->pclk);
-	if (err) {
-		dev_err(dev->dev,
-			"failed to enable the peripheral clock: %d\n", err);
-		return err;
-	}
 
 	snd_soc_dai_init_dma_data(dai, NULL, &dev->capture);
 
@@ -922,8 +977,6 @@ static int mchp_spdifrx_dai_remove(struct snd_soc_dai *dai)
 	/* Disable interrupts */
 	regmap_write(dev->regmap, SPDIFRX_IDR, GENMASK(14, 0));
 
-	clk_disable_unprepare(dev->pclk);
-
 	return 0;
 }
 
@@ -954,6 +1007,48 @@ static const struct of_device_id mchp_spdifrx_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mchp_spdifrx_dt_ids);
 
+static int mchp_spdifrx_runtime_suspend(struct device *dev)
+{
+	struct mchp_spdifrx_dev *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, true);
+	clk_disable_unprepare(spdifrx->gclk);
+	clk_disable_unprepare(spdifrx->pclk);
+
+	return 0;
+}
+
+static int mchp_spdifrx_runtime_resume(struct device *dev)
+{
+	struct mchp_spdifrx_dev *spdifrx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(spdifrx->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(spdifrx->gclk);
+	if (ret)
+		goto disable_pclk;
+
+	regcache_cache_only(spdifrx->regmap, false);
+	regcache_mark_dirty(spdifrx->regmap);
+	ret = regcache_sync(spdifrx->regmap);
+	if (ret) {
+		regcache_cache_only(spdifrx->regmap, true);
+		clk_disable_unprepare(spdifrx->gclk);
+disable_pclk:
+		clk_disable_unprepare(spdifrx->pclk);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops mchp_spdifrx_pm_ops = {
+	RUNTIME_PM_OPS(mchp_spdifrx_runtime_suspend, mchp_spdifrx_runtime_resume,
+		       NULL)
+};
+
 static int mchp_spdifrx_probe(struct platform_device *pdev)
 {
 	struct mchp_spdifrx_dev *dev;
@@ -1022,13 +1117,20 @@ static int mchp_spdifrx_probe(struct platform_device *pdev)
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
 
+	pm_runtime_enable(dev->dev);
+	if (!pm_runtime_enabled(dev->dev)) {
+		err = mchp_spdifrx_runtime_resume(dev->dev);
+		if (err)
+			goto pm_runtime_disable;
+	}
+
 	dev->capture.addr	= (dma_addr_t)mem->start + SPDIFRX_RHR;
 	dev->capture.maxburst	= 1;
 
 	err = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register PCM: %d\n", err);
-		return err;
+		goto pm_runtime_suspend;
 	}
 
 	err = devm_snd_soc_register_component(&pdev->dev,
@@ -1036,20 +1138,40 @@ static int mchp_spdifrx_probe(struct platform_device *pdev)
 					      &mchp_spdifrx_dai, 1);
 	if (err) {
 		dev_err(&pdev->dev, "fail to register dai\n");
-		return err;
+		goto pm_runtime_suspend;
 	}
 
 	regmap_read(regmap, SPDIFRX_VERSION, &vers);
 	dev_info(&pdev->dev, "hw version: %#lx\n", vers & SPDIFRX_VERSION_MASK);
 
 	return 0;
+
+pm_runtime_suspend:
+	if (!pm_runtime_status_suspended(dev->dev))
+		mchp_spdifrx_runtime_suspend(dev->dev);
+pm_runtime_disable:
+	pm_runtime_disable(dev->dev);
+	return err;
+}
+
+static int mchp_spdifrx_remove(struct platform_device *pdev)
+{
+	struct mchp_spdifrx_dev *dev = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(dev->dev);
+	if (!pm_runtime_status_suspended(dev->dev))
+		mchp_spdifrx_runtime_suspend(dev->dev);
+
+	return 0;
 }
 
 static struct platform_driver mchp_spdifrx_driver = {
 	.probe	= mchp_spdifrx_probe,
+	.remove = mchp_spdifrx_remove,
 	.driver	= {
 		.name	= "mchp_spdifrx",
 		.of_match_table = of_match_ptr(mchp_spdifrx_dt_ids),
+		.pm	= pm_ptr(&mchp_spdifrx_pm_ops),
 	},
 };
 
-- 
2.34.1

