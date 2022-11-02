Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53382617271
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKBXZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKBXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:24:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43210FCE;
        Wed,  2 Nov 2022 16:20:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k22so91424pfd.3;
        Wed, 02 Nov 2022 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS1e+43uL+FT/xkdxSFm6nee4mo2YYL1lmvIqpiOoFU=;
        b=eNAW09APtQMwcF8srtLQ4v8T0sRnvgNmfHGFMZdDwC5B5NONfljMrDCUSdXxhZxwAS
         Si8f5RiURn8L/pDIk4NbK0PLKvOa7/cphvsv2PAk05tU/zHdSrErO4Tn9/5HTvSAEtg4
         lloTdn1gVPlq+FLxaAtcBdz2Q+90hZULEalsqBD79E7eNlFV8N1Qp16tg64WEBLNN27y
         +ezxfpXb6N0KSdbh3UxwH8EnTRlBfNmcRVbvdyC5A1qYNNtqFT/IKBzoMMB12zEXybfD
         GRRF3owJwOlceGHIY33m7J39WzvkUNZl+dSZqvRpG/1vDqeJ2BtCDUSYLqHi3rgFbUxA
         ZSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS1e+43uL+FT/xkdxSFm6nee4mo2YYL1lmvIqpiOoFU=;
        b=p8E/kToKpD1qANu8dEtojRKzFj+lhiPJvzcUHjNH6uqizoMAeLFosrNn+SKjwMYV9D
         hNy5stvv8m2dWC3111S21oj0UwAVHQ7ZIhQMooTXP3li09U0LmZLL7jyxmXNoD56GTsn
         /rhxXQ0A7xrtM4k2BxHmAMyvtPH/ChQuho5u3qHEVfFgwxG7akRLa4/IE0zOS9wy1Xug
         uTCJ/KyRAzDJ+b2iJxTm1kGtc3GgZ65U8QUKYN06/DxAvQ/RZEhOebD/RShxH+HqitAa
         hCeYym06nthUTTei70/3MB8nDCZ6tZL3cn+1GVPpdo5E4fJHc9EerLqEWiP4P101uOe8
         w6OA==
X-Gm-Message-State: ACrzQf1DtFU/8AHXL2KShovBESCE8+KwipQqZeBFZeHK40M8ucXsLszR
        uTFZEKBsJChCapaHI4FMWoI=
X-Google-Smtp-Source: AMsMyM4yOyeidT69MU0rVlgLhd+AuM79JodeBGbGUxHzsG5/nuu+7RMKT3vHWbJdgXDu52dKfwjQsQ==
X-Received: by 2002:a63:f903:0:b0:46f:1b5:b4fd with SMTP id h3-20020a63f903000000b0046f01b5b4fdmr23233195pgi.544.1667431212859;
        Wed, 02 Nov 2022 16:20:12 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b00186e2123506sm8842073pll.300.2022.11.02.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:20:12 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: tlv320aic3x: switch to using gpiod API
Date:   Wed,  2 Nov 2022 16:20:04 -0700
Message-Id: <20221102232004.1721864-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
References: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

The driver still tries to support shared reset lines, by first trying to
allocate the reset GPIO normally, and then non-exclusively, although the
utility of such support is questionable, toggling reset line from one
driver/instance will result in all chips being reset, potentially at an
inopportune moment.

Note that this change depends on commit fbbbcd177a27 ("gpiolib: of: add
quirk for locating reset lines with legacy bindings") to translate
request for "reset" GPIO to the legacy name "gpio-reset" in case when
proper name is not used.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c | 108 ++++++++++++---------------------
 1 file changed, 39 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 9b2bb99cc165..56e795a00e22 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -32,12 +32,12 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -56,8 +56,6 @@ static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
 	"DRVDD",	/* ADC Analog and Output Driver Voltage */
 };
 
-static LIST_HEAD(reset_list);
-
 struct aic3x_priv;
 
 struct aic3x_disable_nb {
@@ -80,9 +78,9 @@ struct aic3x_priv {
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
 	unsigned int slot_width;
-	struct list_head list;
 	int master;
-	int gpio_reset;
+	struct gpio_desc *gpio_reset;
+	bool shared_reset;
 	int power;
 	u16 model;
 
@@ -1369,8 +1367,8 @@ static int aic3x_regulator_event(struct notifier_block *nb,
 		 * Put codec to reset and require cache sync as at least one
 		 * of the supplies was disabled
 		 */
-		if (gpio_is_valid(aic3x->gpio_reset))
-			gpio_set_value(aic3x->gpio_reset, 0);
+		if (aic3x->gpio_reset)
+			gpiod_set_value(aic3x->gpio_reset, 1);
 		regcache_mark_dirty(aic3x->regmap);
 	}
 
@@ -1390,9 +1388,9 @@ static int aic3x_set_power(struct snd_soc_component *component, int power)
 			goto out;
 		aic3x->power = 1;
 
-		if (gpio_is_valid(aic3x->gpio_reset)) {
+		if (aic3x->gpio_reset) {
 			udelay(1);
-			gpio_set_value(aic3x->gpio_reset, 1);
+			gpiod_set_value(aic3x->gpio_reset, 0);
 		}
 
 		/* Sync reg_cache with the hardware */
@@ -1598,19 +1596,6 @@ static int aic3x_init(struct snd_soc_component *component)
 	return 0;
 }
 
-static bool aic3x_is_shared_reset(struct aic3x_priv *aic3x)
-{
-	struct aic3x_priv *a;
-
-	list_for_each_entry(a, &reset_list, list) {
-		if (gpio_is_valid(aic3x->gpio_reset) &&
-		    aic3x->gpio_reset == a->gpio_reset)
-			return true;
-	}
-
-	return false;
-}
-
 static int aic3x_component_probe(struct snd_soc_component *component)
 {
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
@@ -1775,19 +1760,6 @@ int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver
 		if (!ai3x_setup)
 			return -ENOMEM;
 
-		ret = of_get_named_gpio(np, "reset-gpios", 0);
-		if (ret >= 0) {
-			aic3x->gpio_reset = ret;
-		} else {
-			ret = of_get_named_gpio(np, "gpio-reset", 0);
-			if (ret > 0) {
-				dev_warn(dev, "Using deprecated property \"gpio-reset\", please update your DT");
-				aic3x->gpio_reset = ret;
-			} else {
-				aic3x->gpio_reset = -1;
-			}
-		}
-
 		if (of_property_read_u32_array(np, "ai3x-gpio-func",
 					ai3x_setup->gpio_func, 2) >= 0) {
 			aic3x->setup = ai3x_setup;
@@ -1812,29 +1784,43 @@ int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver
 		} else {
 			aic3x->micbias_vg = AIC3X_MICBIAS_OFF;
 		}
-
-	} else {
-		aic3x->gpio_reset = -1;
 	}
 
 	aic3x->model = driver_data;
 
-	if (gpio_is_valid(aic3x->gpio_reset) &&
-	    !aic3x_is_shared_reset(aic3x)) {
-		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
-		if (ret != 0)
-			goto err;
-		gpio_direction_output(aic3x->gpio_reset, 0);
+	aic3x->gpio_reset = devm_gpiod_get_optional(dev, "reset",
+						    GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(aic3x->gpio_reset);
+	if (ret) {
+		if (ret != -EBUSY)
+			return ret;
+
+		/*
+		 * Apparently there are setups where the codec is sharing
+		 * its reset line. Try to get it non-exclusively, although
+		 * the utility of this is unclear: how do we make sure that
+		 * resetting one chip will not disturb the others that share
+		 * the same line?
+		 */
+		aic3x->gpio_reset = devm_gpiod_get(dev, "reset",
+				GPIOD_ASIS | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+		ret = PTR_ERR_OR_ZERO(aic3x->gpio_reset);
+		if (ret)
+			return ret;
+
+		aic3x->shared_reset = true;
 	}
 
+	gpiod_set_consumer_name(aic3x->gpio_reset, "tlv320aic3x reset");
+
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		aic3x->supplies[i].supply = aic3x_supply_names[i];
 
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(aic3x->supplies),
 				      aic3x->supplies);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(dev, "Failed to request supplies: %d\n", ret);
-		goto err_gpio;
+		return ret;
 	}
 
 	aic3x_configure_ocmv(dev, aic3x);
@@ -1843,26 +1829,14 @@ int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver
 		ret = regmap_register_patch(aic3x->regmap, aic3007_class_d,
 					    ARRAY_SIZE(aic3007_class_d));
 		if (ret != 0)
-			dev_err(dev, "Failed to init class D: %d\n",
-				ret);
+			dev_err(dev, "Failed to init class D: %d\n", ret);
 	}
 
 	ret = devm_snd_soc_register_component(dev, &soc_component_dev_aic3x, &aic3x_dai, 1);
-
-	if (ret != 0)
-		goto err_gpio;
-
-	INIT_LIST_HEAD(&aic3x->list);
-	list_add(&aic3x->list, &reset_list);
+	if (ret)
+		return ret;
 
 	return 0;
-
-err_gpio:
-	if (gpio_is_valid(aic3x->gpio_reset) &&
-	    !aic3x_is_shared_reset(aic3x))
-		gpio_free(aic3x->gpio_reset);
-err:
-	return ret;
 }
 EXPORT_SYMBOL(aic3x_probe);
 
@@ -1870,13 +1844,9 @@ void aic3x_remove(struct device *dev)
 {
 	struct aic3x_priv *aic3x = dev_get_drvdata(dev);
 
-	list_del(&aic3x->list);
-
-	if (gpio_is_valid(aic3x->gpio_reset) &&
-	    !aic3x_is_shared_reset(aic3x)) {
-		gpio_set_value(aic3x->gpio_reset, 0);
-		gpio_free(aic3x->gpio_reset);
-	}
+	/* Leave the codec in reset state */
+	if (aic3x->gpio_reset && !aic3x->shared_reset)
+		gpiod_set_value(aic3x->gpio_reset, 1);
 }
 EXPORT_SYMBOL(aic3x_remove);
 
-- 
2.38.1.273.g43a17bfeac-goog

