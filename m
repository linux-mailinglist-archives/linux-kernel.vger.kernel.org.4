Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EB5B3A03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiIINzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIINyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:45 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75613DE7;
        Fri,  9 Sep 2022 06:54:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662731678; bh=3F4QbMqp6l9QZioHVn/KgiCbwDPR/8+6ELF1xKWbFwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PZfTVeo4R7YdzxnCJz/v4LXugXHghTacQ1Qhe/a7ygP3/husc40Wco5utr/Ec9qsk
         VZQ95lY8QgFjYOVIxOX6qwvL8I20+6qEjGSkiYGiMaa1YAXra1XGa4CD8SW8idYk+n
         iwa1IUnucLQZGsanSuTRURw5YFrDWBNHQszbS0HQ=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 03/10] ASoC: cs42l42: Use cs42l42->dev instead of &i2c_client->dev
Date:   Fri,  9 Sep 2022 15:53:27 +0200
Message-Id: <20220909135334.98220-4-povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-1-povik+lin@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

In preparation for splitting cs42l42_i2c_probe() into multiple functions
replace use of &i2c_client->dev with cs42l42->dev. This reduces diff
clutter in the patch that splits the function.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 0048ce977645..8e0dc14c55e0 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2217,7 +2217,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
 	if (IS_ERR(cs42l42->regmap)) {
 		ret = PTR_ERR(cs42l42->regmap);
-		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		dev_err(cs42l42->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -2225,11 +2225,11 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	for (i = 0; i < ARRAY_SIZE(cs42l42->supplies); i++)
 		cs42l42->supplies[i].supply = cs42l42_supply_names[i];
 
-	ret = devm_regulator_bulk_get(&i2c_client->dev,
+	ret = devm_regulator_bulk_get(cs42l42->dev,
 				      ARRAY_SIZE(cs42l42->supplies),
 				      cs42l42->supplies);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev,
+		dev_err(cs42l42->dev,
 			"Failed to request supplies: %d\n", ret);
 		return ret;
 	}
@@ -2237,13 +2237,13 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
 				    cs42l42->supplies);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev,
+		dev_err(cs42l42->dev,
 			"Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
 	/* Reset the Device */
-	cs42l42->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
+	cs42l42->reset_gpio = devm_gpiod_get_optional(cs42l42->dev,
 		"reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs42l42->reset_gpio)) {
 		ret = PTR_ERR(cs42l42->reset_gpio);
@@ -2251,7 +2251,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	}
 
 	if (cs42l42->reset_gpio) {
-		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
+		dev_dbg(cs42l42->dev, "Found reset GPIO\n");
 		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
@@ -2265,7 +2265,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 		if (ret == -EPROBE_DEFER) {
 			goto err_disable_noirq;
 		} else if (ret != 0) {
-			dev_err(&i2c_client->dev,
+			dev_err(cs42l42->dev,
 				"Failed to request IRQ: %d\n", ret);
 			goto err_disable_noirq;
 		}
@@ -2275,13 +2275,13 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	devid = cirrus_read_device_id(cs42l42->regmap, CS42L42_DEVID_AB);
 	if (devid < 0) {
 		ret = devid;
-		dev_err(&i2c_client->dev, "Failed to read device ID: %d\n", ret);
+		dev_err(cs42l42->dev, "Failed to read device ID: %d\n", ret);
 		goto err_disable;
 	}
 
 	if (devid != CS42L42_CHIP_ID) {
 		ret = -ENODEV;
-		dev_err(&i2c_client->dev,
+		dev_err(cs42l42->dev,
 			"CS42L42 Device ID (%X). Expected %X\n",
 			devid, CS42L42_CHIP_ID);
 		goto err_disable;
@@ -2289,11 +2289,11 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 
 	ret = regmap_read(cs42l42->regmap, CS42L42_REVID, &reg);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
+		dev_err(cs42l42->dev, "Get Revision ID failed\n");
 		goto err_shutdown;
 	}
 
-	dev_info(&i2c_client->dev,
+	dev_info(cs42l42->dev,
 		 "Cirrus Logic CS42L42, Revision: %02X\n", reg & 0xFF);
 
 	/* Power up the codec */
@@ -2313,7 +2313,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 			(1 << CS42L42_ADC_PDN_SHIFT) |
 			(0 << CS42L42_PDN_ALL_SHIFT));
 
-	ret = cs42l42_handle_device_data(&i2c_client->dev, cs42l42);
+	ret = cs42l42_handle_device_data(cs42l42->dev, cs42l42);
 	if (ret != 0)
 		goto err_shutdown;
 
@@ -2324,7 +2324,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	cs42l42_set_interrupt_masks(cs42l42);
 
 	/* Register codec for machine driver */
-	ret = devm_snd_soc_register_component(&i2c_client->dev,
+	ret = devm_snd_soc_register_component(cs42l42->dev,
 			&soc_component_dev_cs42l42, &cs42l42_dai, 1);
 	if (ret < 0)
 		goto err_shutdown;
-- 
2.33.0

