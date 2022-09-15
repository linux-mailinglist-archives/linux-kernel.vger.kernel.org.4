Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0AC5B97E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiIOJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIOJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:41 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35E97ED1;
        Thu, 15 Sep 2022 02:45:38 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235134; bh=jeVhB+g+ZfwSKgqzqq2K42knlfYbiLjCGGvelbPU2ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Tn6rpmeS5yrwDUpxBMBDBSigM+4HhWHdqYcUUn1wO6dfIMymL0ny6WsVL54wiPjQy
         bIjG7SbcWkZ7s6d7vd1psTrThA1pLC041B5z/io8Bf0xpKVM/bE72942YeXIo0n/d2
         T7PDrGmEcf4FSbx/TkQ3PJo8u67VhfzF54DBJh9Q=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matt Flax <flatmax@flatmax.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH v2 04/11] ASoC: cs42l42: Split probe() and remove() into stages
Date:   Thu, 15 Sep 2022 11:44:37 +0200
Message-Id: <20220915094444.11434-5-povik+lin@cutebit.org>
In-Reply-To: <20220915094444.11434-1-povik+lin@cutebit.org>
References: <20220915094444.11434-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

To prepare for adding SoundWire the probe must be split into three
parts:

1) The bus-specific probe
2) Common bus-agnostic probe steps
3) Initialization of the peripheral registers

Step (3) must be separate because on SoundWire devices the probe must
enable power supplies and release reset so that the peripheral can be
enumerated by the bus, but it isn't possible to access registers until
enumeration has completed.

The call to devm_snd_soc_register_component() must be done at stage (2)
so that it can EPROBE_DEFER if necessary. In SoundWire systems stage (3)
is not a probe event so a deferral at this stage would not result in
re-probing dependencies.

A new init_done flag indicates that the chip has been identified and
initialized. This is used to prevent cs42l42_remove(), cs42l42_suspend(),
cs42l42_restore() and cs42l42_irq_thread() from attempting register
accesses if the chip was not successfully initialized. Although this
cannot happen on I2C, because the entire probe would fail, it is
possible on SoundWire if probe succeeds but the cs42l42 is never
enumerated.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 127 +++++++++++++++++++++++++------------
 sound/soc/codecs/cs42l42.h |   2 +
 2 files changed, 87 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 11cb659f03e0..427b29db2252 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1627,7 +1627,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	int report = 0;
 
 	mutex_lock(&cs42l42->irq_lock);
-	if (cs42l42->suspended) {
+	if (cs42l42->suspended || !cs42l42->init_done) {
 		mutex_unlock(&cs42l42->irq_lock);
 		return IRQ_NONE;
 	}
@@ -2199,28 +2199,13 @@ static int __maybe_unused cs42l42_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
+static int cs42l42_common_probe(struct cs42l42_private *cs42l42)
 {
-	struct cs42l42_private *cs42l42;
-	int ret, i, devid;
-	unsigned int reg;
-
-	cs42l42 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l42_private),
-			       GFP_KERNEL);
-	if (!cs42l42)
-		return -ENOMEM;
+	int ret, i;
 
-	cs42l42->dev = &i2c_client->dev;
-	i2c_set_clientdata(i2c_client, cs42l42);
+	dev_set_drvdata(cs42l42->dev, cs42l42);
 	mutex_init(&cs42l42->irq_lock);
 
-	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
-	if (IS_ERR(cs42l42->regmap)) {
-		ret = PTR_ERR(cs42l42->regmap);
-		dev_err(cs42l42->dev, "regmap_init() failed: %d\n", ret);
-		return ret;
-	}
-
 	BUILD_BUG_ON(ARRAY_SIZE(cs42l42_supply_names) != ARRAY_SIZE(cs42l42->supplies));
 	for (i = 0; i < ARRAY_SIZE(cs42l42->supplies); i++)
 		cs42l42->supplies[i].supply = cs42l42_supply_names[i];
@@ -2257,20 +2242,44 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
 	/* Request IRQ if one was specified */
-	if (i2c_client->irq) {
-		ret = request_threaded_irq(i2c_client->irq,
+	if (cs42l42->irq) {
+		ret = request_threaded_irq(cs42l42->irq,
 					   NULL, cs42l42_irq_thread,
 					   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 					   "cs42l42", cs42l42);
-		if (ret == -EPROBE_DEFER) {
-			goto err_disable_noirq;
-		} else if (ret != 0) {
+		if (ret) {
 			dev_err_probe(cs42l42->dev, ret,
 				"Failed to request IRQ\n");
 			goto err_disable_noirq;
 		}
 	}
 
+	/* Register codec now so it can EPROBE_DEFER */
+	ret = devm_snd_soc_register_component(cs42l42->dev,
+					      &soc_component_dev_cs42l42,
+					      &cs42l42_dai, 1);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	if (cs42l42->irq)
+		free_irq(cs42l42->irq, cs42l42);
+
+err_disable_noirq:
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+err_disable_noreset:
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+
+	return ret;
+}
+
+static int cs42l42_init(struct cs42l42_private *cs42l42)
+{
+	unsigned int reg;
+	int devid, ret;
+
 	/* initialize codec */
 	devid = cirrus_read_device_id(cs42l42->regmap, CS42L42_DEVID_AB);
 	if (devid < 0) {
@@ -2320,15 +2329,15 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	/* Setup headset detection */
 	cs42l42_setup_hs_type_detect(cs42l42);
 
+	/*
+	 * Set init_done before unmasking interrupts so any triggered
+	 * immediately will be handled.
+	 */
+	cs42l42->init_done = true;
+
 	/* Mask/Unmask Interrupts */
 	cs42l42_set_interrupt_masks(cs42l42);
 
-	/* Register codec for machine driver */
-	ret = devm_snd_soc_register_component(cs42l42->dev,
-			&soc_component_dev_cs42l42, &cs42l42_dai, 1);
-	if (ret < 0)
-		goto err_shutdown;
-
 	return 0;
 
 err_shutdown:
@@ -2337,34 +2346,68 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
 
 err_disable:
-	if (i2c_client->irq)
-		free_irq(i2c_client->irq, cs42l42);
+	if (cs42l42->irq)
+		free_irq(cs42l42->irq, cs42l42);
 
-err_disable_noirq:
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
-err_disable_noreset:
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
 				cs42l42->supplies);
 	return ret;
 }
 
-static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
+static void cs42l42_common_remove(struct cs42l42_private *cs42l42)
 {
-	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
-
-	if (i2c_client->irq)
-		free_irq(i2c_client->irq, cs42l42);
+	if (cs42l42->irq)
+		free_irq(cs42l42->irq, cs42l42);
 
 	/*
 	 * The driver might not have control of reset and power supplies,
 	 * so ensure that the chip internals are powered down.
 	 */
-	regmap_write(cs42l42->regmap, CS42L42_CODEC_INT_MASK, 0xff);
-	regmap_write(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK, 0xff);
-	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
+	if (cs42l42->init_done) {
+		regmap_write(cs42l42->regmap, CS42L42_CODEC_INT_MASK, 0xff);
+		regmap_write(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK, 0xff);
+		regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
+	}
 
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+}
+
+static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct device *dev = &i2c_client->dev;
+	struct cs42l42_private *cs42l42;
+	struct regmap *regmap;
+	int ret;
+
+	cs42l42 = devm_kzalloc(dev, sizeof(struct cs42l42_private), GFP_KERNEL);
+	if (!cs42l42)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	cs42l42->dev = dev;
+	cs42l42->regmap = regmap;
+	cs42l42->irq = i2c_client->irq;
+
+	ret = cs42l42_common_probe(cs42l42);
+	if (ret)
+		return ret;
+
+	return cs42l42_init(cs42l42);
+}
+
+static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&i2c_client->dev);
+
+	cs42l42_common_remove(cs42l42);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index b4ba1467c558..a8e0d5b414a5 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -29,6 +29,7 @@ struct  cs42l42_private {
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
 	struct mutex irq_lock;
+	int irq;
 	int pll_config;
 	u32 sclk;
 	u32 srate;
@@ -46,6 +47,7 @@ struct  cs42l42_private {
 	u8 stream_use;
 	bool hp_adc_up_pending;
 	bool suspended;
+	bool init_done;
 };
 
 #endif /* __CS42L42_H__ */
-- 
2.33.0

