Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4D62B2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKPFiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKPFid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393FA100B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c2so15427937plz.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r01ypcYo+LtD9fhypz7U4KPnsRobXTNuGoo4vyNF/vc=;
        b=Hdfcb6sJtZK0d4iSfc/c+K5+0PYEPfETP19Nve63ggNiKTbV6nRrj4Vb4GfGLphU77
         JL9fPjFGZN+xuLVLnY9F8MtLwtXD10i7AxQh0kdt+xCvJCzv0IxzCLnwB3CiEO0++qQ8
         cvbX71x5YS4YX4MOl3W89daY6QxvCAdYtGF2kIJTH8YFYBTDBvWd+yEE59Z1oqf5Mgsu
         MswmnkG/O1rW5lzeLp9bQUxKADGJ05ftzgyMVFqGQ75+4mK2VU9l4bxqOZ08fz/LaIAO
         rXeBGl4jU92zG9ChdWwmYbEGZZtcxAdlkg4m7CV+U61qWVVU26rLYvH2PbRXwv+fCFMV
         dacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r01ypcYo+LtD9fhypz7U4KPnsRobXTNuGoo4vyNF/vc=;
        b=V4NOJNrxECk87eZ9Wm9hdgy2+dGEke6DaxeVSbI2WgHVhsuwQAdQztj2iEytnlQH2W
         4WKoscdGxkAA6HXfEnF8UftEdw//9Y2dWZsyxorGdTfGpWbFKk0ShRrWHaFziRU4MW5V
         K3GNH3WxkLjAE+I5jeLaD6tescLjxZJ7kTLngI99CnAb9ZvfZWUxEt3mbDMSIZ1xjb6L
         va3pFBaHKoOFEt1+XxzaL8lbPU186v2CwpbU2d/4nXslQXW81YtX/q9AKH0wc5btfBIL
         QP/1ezxkDGBXzQcyRxhYxGi7/FYfMEWpq0EiTlvrPa1B4K+Ulr2e7HBEGqBBfisVZVE8
         OvUw==
X-Gm-Message-State: ANoB5pmAx+xKG8o0XGDRrGAJlOAaXp0/5yh9cHR8N/S6qL/ygRuWsz6t
        z5pYGqFDP9oxQPgZIV6jZA0=
X-Google-Smtp-Source: AA0mqf6LzBMQD9KXFyMAhXpG5nVIjWO4CGNYGngv2AR+5vF/Q88oiCVvIcdaMKPNZkqy9cGqtNtfAQ==
X-Received: by 2002:a17:903:2789:b0:186:9b19:1dbb with SMTP id jw9-20020a170903278900b001869b191dbbmr7643358plb.59.1668577109573;
        Tue, 15 Nov 2022 21:38:29 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:28 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 05/11] ASoC: tpa6130a2: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:11 -0800
Message-Id: <20221116053817.2929810-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
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

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/tpa6130a2.c | 42 +++++++++++++++---------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 5f00bfc32917..696a27b472aa 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -9,15 +9,15 @@
 
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 
 #include "tpa6130a2.h"
@@ -32,7 +32,7 @@ struct tpa6130a2_data {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regulator *supply;
-	int power_gpio;
+	struct gpio_desc *power_gpio;
 	enum tpa_model id;
 };
 
@@ -48,8 +48,8 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 			return ret;
 		}
 		/* Power on */
-		if (data->power_gpio >= 0)
-			gpio_set_value(data->power_gpio, 1);
+		if (data->power_gpio)
+			gpiod_set_value(data->power_gpio, 1);
 
 		/* Sync registers */
 		regcache_cache_only(data->regmap, false);
@@ -58,8 +58,8 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 			dev_err(data->dev,
 				"Failed to sync registers: %d\n", ret);
 			regcache_cache_only(data->regmap, true);
-			if (data->power_gpio >= 0)
-				gpio_set_value(data->power_gpio, 0);
+			if (data->power_gpio)
+				gpiod_set_value(data->power_gpio, 0);
 			ret2 = regulator_disable(data->supply);
 			if (ret2 != 0)
 				dev_err(data->dev,
@@ -75,8 +75,8 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 		regcache_cache_only(data->regmap, true);
 
 		/* Power off */
-		if (data->power_gpio >= 0)
-			gpio_set_value(data->power_gpio, 0);
+		if (data->power_gpio)
+			gpiod_set_value(data->power_gpio, 0);
 
 		ret = regulator_disable(data->supply);
 		if (ret != 0) {
@@ -224,37 +224,29 @@ static int tpa6130a2_probe(struct i2c_client *client)
 	unsigned int version;
 	int ret;
 
-	if (!dev->of_node)
-		return -ENODEV;
-
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, data);
 	data->dev = dev;
 
 	data->regmap = devm_regmap_init_i2c(client, &tpa6130a2_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
-	data->power_gpio = of_get_named_gpio(dev->of_node, "power-gpio", 0);
+	data->power_gpio = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(data->power_gpio);
+	if (ret) {
+		dev_err(dev, "Failed to request power GPIO: %d\n", ret);
+		return ret;
+	}
 
-	i2c_set_clientdata(client, data);
+	gpiod_set_consumer_name(data->power_gpio, "tpa6130a2 enable");
 
 	id = i2c_match_id(tpa6130a2_id, client);
 	data->id = id->driver_data;
 
-	if (data->power_gpio >= 0) {
-		ret = devm_gpio_request(dev, data->power_gpio,
-					"tpa6130a2 enable");
-		if (ret < 0) {
-			dev_err(dev, "Failed to request power GPIO (%d)\n",
-				data->power_gpio);
-			return ret;
-		}
-		gpio_direction_output(data->power_gpio, 0);
-	}
-
 	switch (data->id) {
 	default:
 		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
-- 
2.38.1.431.g37b22c650d-goog

