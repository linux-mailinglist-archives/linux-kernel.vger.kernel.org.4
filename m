Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408CE608F20
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJVTNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJVTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:13:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E4176528;
        Sat, 22 Oct 2022 12:13:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so4135191wmb.3;
        Sat, 22 Oct 2022 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sPt5LhdSPbmHbCI/F5fllfjWNuHx3h7BJXRdhgq+ww=;
        b=TcEFIEw1IcZkvaWUlSnkl690ojgTj1hiRXGPsjPaVVc6zw184pMmmHbj07Tp5pvLTA
         67khVzyRZEhPzQAgNd0t7KkAcX0A1Nm2F9ofSr1g483aROoSOVbpudPy/da9lUK5VMFh
         d25YAOGi6N13tUBNnaImRLm5zaM7iv6VyO43G1ya3XwyTY+pvMUZtNCOSF79lhaukOWZ
         QBef+zHsmzeFyIV793PLQqD6/c2/MFjTQOYGjmpPDqgvYKbURRHaPa3tE1G6hhucuqLj
         byy6089lrreBJ8xq7Xfq7GCZzNhIBiCOcSUtkR/JzQuS2v1lolh5vAoCC+LJ4AR/eW3s
         yJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sPt5LhdSPbmHbCI/F5fllfjWNuHx3h7BJXRdhgq+ww=;
        b=iz6T95hStXwlIY9x+pVx+q1BD1AjxJgIIqXUVzK7khaSSs6I7h0MJjiC4RcX4Kz+iR
         QUjEl50eFjvUXVXzxiuywahRlX9duhbsBSB2fmO3GK3NVJv8u3CwDrkhelDwBHbPeNUq
         Do9xz69S1jsdBgz0TEkvT20v6chh7ZAqpqM/DZ2jJ18d7teaFErDIiXxC2igSAb7V7G4
         IUYmbaqih7i5N6jx63CVSQSYXc/QGdwIAj2qS2jhzuXwXsCxjMREAo1TQVOgSmLpBf3h
         sxi1EjHF+pZgSsJey1hAV5ayTKIEomYDOV1QDjAJoZSyATrETk2SJGo1iQZXiPMl+3KV
         fosA==
X-Gm-Message-State: ACrzQf3URhJEKpnvz3/7p80RpV1BA0vqBGAwUm/Hr1SETsBmzL1l6MC1
        qsHjoDQi+fGrqgMxVb5ixaE=
X-Google-Smtp-Source: AMsMyM4I3isW/aW/LqZVhBuPMvrNWlUEe//S3cV8ZJaOePvl4Ijegx2Rq3iohpP80+71uynroC3IhQ==
X-Received: by 2002:a05:600c:54f2:b0:3c6:bd60:5390 with SMTP id jb18-20020a05600c54f200b003c6bd605390mr37811960wmb.206.1666466003147;
        Sat, 22 Oct 2022 12:13:23 -0700 (PDT)
Received: from localhost (94.197.1.68.threembb.co.uk. [94.197.1.68])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000188a00b0022e344a63c7sm22684240wri.92.2022.10.22.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:13:22 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/9] ASoC: jz4740-i2s: Convert to regmap API
Date:   Sat, 22 Oct 2022 20:13:01 +0100
Message-Id: <20221022191308.82348-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using regmap for accessing the AIC registers makes the driver a
little easier to read, and later refactors can take advantage of
regmap APIs to further simplify the driver.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 106 ++++++++++++----------------------
 2 files changed, 39 insertions(+), 68 deletions(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index e72f826062e9..dd3b4507fbe6 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -3,6 +3,7 @@ config SND_JZ4740_SOC_I2S
 	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 83cb81999c6f..f3c0d7c0415e 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <linux/clk.h>
@@ -96,7 +97,7 @@ struct i2s_soc_info {
 };
 
 struct jz4740_i2s {
-	void __iomem *base;
+	struct regmap *regmap;
 
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
@@ -107,31 +108,10 @@ struct jz4740_i2s {
 	const struct i2s_soc_info *soc_info;
 };
 
-static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
-	unsigned int reg)
-{
-	return readl(i2s->base + reg);
-}
-
-static inline void jz4740_i2s_write(const struct jz4740_i2s *i2s,
-	unsigned int reg, uint32_t value)
-{
-	writel(value, i2s->base + reg);
-}
-
-static inline void jz4740_i2s_set_bits(const struct jz4740_i2s *i2s,
-	unsigned int reg, uint32_t bits)
-{
-	uint32_t value = jz4740_i2s_read(i2s, reg);
-	value |= bits;
-	jz4740_i2s_write(i2s, reg, value);
-}
-
 static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf;
 	int ret;
 
 	/*
@@ -141,9 +121,9 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	 */
 	if (!i2s->soc_info->shared_fifo_flush) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
 		else
-			jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_RFLUSH);
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_RFLUSH);
 	}
 
 	if (snd_soc_dai_active(dai))
@@ -156,16 +136,13 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	 * guard this behind the snd_soc_dai_active() check.
 	 */
 	if (i2s->soc_info->shared_fifo_flush)
-		jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
 
 	ret = clk_prepare_enable(i2s->clk_i2s);
 	if (ret)
 		return ret;
 
-	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-	conf |= JZ_AIC_CONF_ENABLE;
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-
+	regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 	return 0;
 }
 
@@ -173,14 +150,11 @@ static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf;
 
 	if (snd_soc_dai_active(dai))
 		return;
 
-	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-	conf &= ~JZ_AIC_CONF_ENABLE;
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+	regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 
 	clk_disable_unprepare(i2s->clk_i2s);
 }
@@ -189,8 +163,6 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	uint32_t ctrl;
 	uint32_t mask;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -198,38 +170,30 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	else
 		mask = JZ_AIC_CTRL_ENABLE_CAPTURE | JZ_AIC_CTRL_ENABLE_RX_DMA;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ctrl |= mask;
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ctrl &= ~mask;
+		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
-
 	return 0;
 }
 
 static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	uint32_t format = 0;
-	uint32_t conf;
-
-	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-
-	conf &= ~(JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER);
+	const unsigned int conf_mask = JZ_AIC_CONF_BIT_CLK_MASTER |
+				       JZ_AIC_CONF_SYNC_CLK_MASTER;
+	unsigned int conf = 0, format = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -265,8 +229,8 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_I2S_FMT, format);
+	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF, conf_mask, conf);
+	regmap_write(i2s->regmap, JZ_REG_AIC_I2S_FMT, format);
 
 	return 0;
 }
@@ -279,9 +243,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	uint32_t ctrl, div_reg;
 	int div;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
+	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
 
-	div_reg = jz4740_i2s_read(i2s, JZ_REG_AIC_CLK_DIV);
 	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
 
 	switch (params_format(params)) {
@@ -318,8 +282,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
 
 	return 0;
 }
@@ -356,13 +320,9 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int jz4740_i2s_suspend(struct snd_soc_component *component)
 {
 	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	uint32_t conf;
 
 	if (snd_soc_component_active(component)) {
-		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-		conf &= ~JZ_AIC_CONF_ENABLE;
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-
+		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 		clk_disable_unprepare(i2s->clk_i2s);
 	}
 
@@ -374,7 +334,6 @@ static int jz4740_i2s_suspend(struct snd_soc_component *component)
 static int jz4740_i2s_resume(struct snd_soc_component *component)
 {
 	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	uint32_t conf;
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk_aic);
@@ -388,9 +347,7 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 			return ret;
 		}
 
-		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-		conf |= JZ_AIC_CONF_ENABLE;
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 	}
 
 	return 0;
@@ -423,8 +380,8 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 			JZ_AIC_CONF_INTERNAL_CODEC;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
 
 	return 0;
 }
@@ -523,11 +480,19 @@ static const struct of_device_id jz4740_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 
+static const struct regmap_config jz4740_i2s_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= JZ_REG_AIC_FIFO,
+};
+
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
+	void __iomem *regs;
 	int ret;
 
 	i2s = devm_kzalloc(dev, sizeof(*i2s), GFP_KERNEL);
@@ -536,9 +501,9 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 
 	i2s->soc_info = device_get_match_data(dev);
 
-	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(i2s->base))
-		return PTR_ERR(i2s->base);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	i2s->playback_dma_data.maxburst = 16;
 	i2s->playback_dma_data.addr = mem->start + JZ_REG_AIC_FIFO;
@@ -554,6 +519,11 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (IS_ERR(i2s->clk_i2s))
 		return PTR_ERR(i2s->clk_i2s);
 
+	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &jz4740_i2s_regmap_config);
+	if (IS_ERR(i2s->regmap))
+		return PTR_ERR(i2s->regmap);
+
 	platform_set_drvdata(pdev, i2s);
 
 	ret = devm_snd_soc_register_component(dev, &jz4740_i2s_component,
-- 
2.38.1

