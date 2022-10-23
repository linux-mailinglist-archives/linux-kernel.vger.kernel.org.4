Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976656093ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJWOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJWOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794F61B3C;
        Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y16so1375858wrt.12;
        Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HhPHTWcHqQfajKCJskET6/mbnRPhMXC0Dz2f8v2WQ8=;
        b=gZVaHBh04DZfb/qmfq7dwyr3qKuZOs3FQOdn9ZxMeL0bFlstSXmMgTqGrszNWqScs8
         XyZj/nZ+u6kwuC7N60JXVy1HnMj9hDESqtxNQu6bhev4t1GcMK9FTCf2FFh9BgKzKEhb
         bl2T5uWN2YAK+0McuL2QWTbOtSNTCrFklPmdsmtCe8Gc9DfneYmR2B1a+bRrwiSc5J87
         bqBWkAe8quWpINKv59yMg/bINYY07bWUIiyZbFE/MYIZKexTzKl5bThbTnUKDRiTA7I8
         W7NDrgfJJgBMQ5hynFGqe6pJWAtlvLXROqxwPKO0Gn72d01Nm5qeuKDKxab1msPS0kSK
         r7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HhPHTWcHqQfajKCJskET6/mbnRPhMXC0Dz2f8v2WQ8=;
        b=DG4RduUOaha5JqAW5yjfNfYqFx8/q924QW+b4z5XU2U7RDV44035vGwaGg9Op/zbcm
         ufBbgA33Eq+SfVNxH0ymDsfa2CpFgUDOAmMudYuaMfnF+CLNq0DiRQkhUa6v8hgbcToQ
         Lydrw4vHFVPGcYXxLP/XQQeiqLA5jvOwMYfahVW//AwjsGQlXmAhSMOh0r2jG/OMvN8S
         uHltReTYReQj57WGr2T8sBAYsd2qBSXJnwTuwGhuQWi4VdzW2BZjO6FOhfFtZoyrWIgp
         2/GTMf2oBp4b7o3KqrxluOzhZx2QP5DT+zJbdMCrmtMPEQ4/RwKcqyp8e7H6nELVTEZz
         h88g==
X-Gm-Message-State: ACrzQf0U/lcjUV1/Fd8LRJ4SMdmxTCYPSb1dilwdyAdaxsqJ1xfIhEh2
        fkZ8Q01oT4PqpSRL3cjTuaM=
X-Google-Smtp-Source: AMsMyM4VNQQZcWEzymhxfNrESj0KWKIaShkanXvSU/TZtNc2y3QBUEbnmrtaR32cHpKrVTUCkyXSYA==
X-Received: by 2002:a05:6000:1446:b0:22f:5e89:d9de with SMTP id v6-20020a056000144600b0022f5e89d9demr18431864wrx.106.1666535615357;
        Sun, 23 Oct 2022 07:33:35 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b003b47e8a5d22sm5603903wmq.23.2022.10.23.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:34 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] ASoC: jz4740-i2s: Simplify using regmap fields
Date:   Sun, 23 Oct 2022 15:33:22 +0100
Message-Id: <20221023143328.160866-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
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

The differences between register fields on different SoC versions
can be abstracted away using the regmap field API. This is easier
to understand and extend than comparisons based on the version ID.
Since the version IDs are unused after this change, remove them at
the same time, and remove unused macros.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 135 +++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 58 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index f3c0d7c0415e..b0bbcd025241 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -34,8 +34,6 @@
 #define JZ_REG_AIC_CLK_DIV	0x30
 #define JZ_REG_AIC_FIFO		0x34
 
-#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_MASK (0xf << 12)
-#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_MASK (0xf <<  8)
 #define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
 #define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
 #define JZ_AIC_CONF_I2S BIT(4)
@@ -44,11 +42,6 @@
 #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
 #define JZ_AIC_CONF_ENABLE BIT(0)
 
-#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
-#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
-#define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
-#define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
-
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
@@ -76,29 +69,25 @@
 
 #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
 
-#define JZ_AIC_CLK_DIV_MASK 0xf
-#define I2SDIV_DV_SHIFT 0
-#define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
-#define I2SDIV_IDV_SHIFT 8
-#define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
-
-enum jz47xx_i2s_version {
-	JZ_I2S_JZ4740,
-	JZ_I2S_JZ4760,
-	JZ_I2S_JZ4770,
-	JZ_I2S_JZ4780,
-};
-
 struct i2s_soc_info {
-	enum jz47xx_i2s_version version;
 	struct snd_soc_dai_driver *dai;
 
+	struct reg_field field_rx_fifo_thresh;
+	struct reg_field field_tx_fifo_thresh;
+	struct reg_field field_i2sdiv_capture;
+	struct reg_field field_i2sdiv_playback;
+
 	bool shared_fifo_flush;
 };
 
 struct jz4740_i2s {
 	struct regmap *regmap;
 
+	struct regmap_field *field_rx_fifo_thresh;
+	struct regmap_field *field_tx_fifo_thresh;
+	struct regmap_field *field_i2sdiv_capture;
+	struct regmap_field *field_i2sdiv_playback;
+
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
 
@@ -239,12 +228,12 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	struct regmap_field *div_field;
 	unsigned int sample_size;
-	uint32_t ctrl, div_reg;
+	uint32_t ctrl;
 	int div;
 
 	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
-	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
 
 	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
 
@@ -267,23 +256,16 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		else
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
 
-		div_reg &= ~I2SDIV_DV_MASK;
-		div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
+		div_field = i2s->field_i2sdiv_playback;
 	} else {
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
 
-		if (i2s->soc_info->version >= JZ_I2S_JZ4770) {
-			div_reg &= ~I2SDIV_IDV_MASK;
-			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
-		} else {
-			div_reg &= ~I2SDIV_DV_MASK;
-			div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
-		}
+		div_field = i2s->field_i2sdiv_capture;
 	}
 
 	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
-	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
+	regmap_field_write(div_field, div - 1);
 
 	return 0;
 }
@@ -356,7 +338,6 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf;
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk_aic);
@@ -366,22 +347,14 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	if (i2s->soc_info->version >= JZ_I2S_JZ4760) {
-		conf = (7 << JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-			(8 << JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
-			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
-			JZ_AIC_CONF_I2S |
-			JZ_AIC_CONF_INTERNAL_CODEC;
-	} else {
-		conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-			(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
-			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
-			JZ_AIC_CONF_I2S |
-			JZ_AIC_CONF_INTERNAL_CODEC;
-	}
-
 	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
-	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
+
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
+		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
+		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
+
+	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
+	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
 
 	return 0;
 }
@@ -426,14 +399,20 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 };
 
 static const struct i2s_soc_info jz4740_i2s_soc_info = {
-	.version = JZ_I2S_JZ4740,
-	.dai = &jz4740_i2s_dai,
-	.shared_fifo_flush = true,
+	.dai			= &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 12, 15),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.shared_fifo_flush	= true,
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
-	.version = JZ_I2S_JZ4760,
-	.dai = &jz4740_i2s_dai,
+	.dai			= &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
@@ -455,13 +434,19 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 };
 
 static const struct i2s_soc_info jz4770_i2s_soc_info = {
-	.version = JZ_I2S_JZ4770,
-	.dai = &jz4770_i2s_dai,
+	.dai			= &jz4770_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
-	.version = JZ_I2S_JZ4780,
-	.dai = &jz4770_i2s_dai,
+	.dai			= &jz4770_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
@@ -480,6 +465,36 @@ static const struct of_device_id jz4740_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 
+static int jz4740_i2s_init_regmap_fields(struct device *dev,
+					 struct jz4740_i2s *i2s)
+{
+	i2s->field_rx_fifo_thresh =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_rx_fifo_thresh);
+	if (IS_ERR(i2s->field_rx_fifo_thresh))
+		return PTR_ERR(i2s->field_rx_fifo_thresh);
+
+	i2s->field_tx_fifo_thresh =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_tx_fifo_thresh);
+	if (IS_ERR(i2s->field_tx_fifo_thresh))
+		return PTR_ERR(i2s->field_tx_fifo_thresh);
+
+	i2s->field_i2sdiv_capture =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_i2sdiv_capture);
+	if (IS_ERR(i2s->field_i2sdiv_capture))
+		return PTR_ERR(i2s->field_i2sdiv_capture);
+
+	i2s->field_i2sdiv_playback =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_i2sdiv_playback);
+	if (IS_ERR(i2s->field_i2sdiv_playback))
+		return PTR_ERR(i2s->field_i2sdiv_playback);
+
+	return 0;
+}
+
 static const struct regmap_config jz4740_i2s_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -524,6 +539,10 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (IS_ERR(i2s->regmap))
 		return PTR_ERR(i2s->regmap);
 
+	ret = jz4740_i2s_init_regmap_fields(dev, i2s);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, i2s);
 
 	ret = devm_snd_soc_register_component(dev, &jz4740_i2s_component,
-- 
2.38.1

