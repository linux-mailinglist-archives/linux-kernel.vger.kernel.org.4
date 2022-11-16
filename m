Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E961162B2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiKPFio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKPFi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so15447672pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEUFbdVypOtyoH064OjwzyJ2ZvEG5EnyjXzOQihafjo=;
        b=b5/F1lcFrypyG5b3jZd+tIci2jDxqkerWT178BAUcRicXkw95dBFxRknwrsZMS5Qud
         MlaVJs2wquHY4clWTApR5ZADFFvP/rBfGGjMXoynix7py8419JTe18a4QU3ldzp2e42Q
         snQtuSlystcc2T7vWhP4LZ5Id/pkAsturPEbM21KtqDB66Q5yrGIVhQE5h0/XF9atu2b
         /viTKRsIgxeAFGKq2MKvzP3a5zDdh5uIv8BnGJlIt66+NkLlvfgaDCbbJZ3LBxTIGUrx
         Q4M4eXC+8RU/oLEVmQgsyKM6/CmwkPOoVFpU+cxPL+MfceYAsUS/byeTNadVgiOQVpr9
         1OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEUFbdVypOtyoH064OjwzyJ2ZvEG5EnyjXzOQihafjo=;
        b=QOp25vNCzHwh63B4JI0KbCn+P9Pp32+UnFaD0U56L8KLc643noldCKGQ40dYFwdRIm
         O22Wy8TfSNlLhIpRKHOaOOOEMLkN7Yyh3d3cmO5oHJtTtNu/89cJl5169UylfAMqhng2
         eqvk5pLTGLThG9lDOobhuPYIs2Y2o83kE9Ueiv5DLXaNlpaK+Fdre46obB5Q8lQe/fSB
         IZmQKnNZ+/yNU0MIy7G/HVyUU+XGx+EmBXsvpML8G8V2QiRlxn5CIUbWogWN+2Yfw3b+
         /UwSN2tYVNQkH/9Ns6nSwOUn3PjQQqet7ET8pv6vUqiggwT9Bq5V2G6fovhKcYfHBaQl
         yoGA==
X-Gm-Message-State: ANoB5pnPfGZ0ogiUIOTArpZaNa/C6Vylp8zyJi1Sv2GZHTNrvjhWvniK
        CuS3gAwHX9EaUzmdEkZrh+q47BW8x6M=
X-Google-Smtp-Source: AA0mqf5z79P1swqzv8dzeNZZJOFB+xE8MMujTBBZYIu2jV3tvbzH4zWATe4F3ROm4HqVKvHQzeUozw==
X-Received: by 2002:a17:902:e846:b0:186:94b8:5980 with SMTP id t6-20020a170902e84600b0018694b85980mr7764409plg.113.1668577103864;
        Tue, 15 Nov 2022 21:38:23 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:23 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 02/11] ASoC: max98373: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:08 -0800
Message-Id: <20221116053817.2929810-2-dmitry.torokhov@gmail.com>
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
 sound/soc/codecs/max98373-i2c.c | 39 +++++++++++++++++++--------------
 sound/soc/codecs/max98373.c     | 18 ---------------
 sound/soc/codecs/max98373.h     |  1 -
 3 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 3e04c7f0cce4..969cdca83bc1 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -3,12 +3,12 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -520,14 +520,13 @@ static int max98373_i2c_probe(struct i2c_client *i2c)
 	int ret = 0;
 	int reg = 0;
 	int i;
-	struct max98373_priv *max98373 = NULL;
+	struct max98373_priv *max98373;
+	struct gpio_desc *reset_gpio;
 
 	max98373 = devm_kzalloc(&i2c->dev, sizeof(*max98373), GFP_KERNEL);
+	if (!max98373)
+		return -ENOMEM;
 
-	if (!max98373) {
-		ret = -ENOMEM;
-		return ret;
-	}
 	i2c_set_clientdata(i2c, max98373);
 
 	/* update interleave mode info */
@@ -557,17 +556,23 @@ static int max98373_i2c_probe(struct i2c_client *i2c)
 	max98373_slot_config(&i2c->dev, max98373);
 
 	/* Power on device */
-	if (gpio_is_valid(max98373->reset_gpio)) {
-		ret = devm_gpio_request(&i2c->dev, max98373->reset_gpio,
-					"MAX98373_RESET");
-		if (ret) {
-			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
-				__func__, max98373->reset_gpio);
-			return -EINVAL;
-		}
-		gpio_direction_output(max98373->reset_gpio, 0);
+	/* Acquire and assert reset line */
+	reset_gpio = devm_gpiod_get_optional(&i2c->dev, "maxim,reset",
+					     GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(reset_gpio);
+	if (ret) {
+		dev_err(&i2c->dev, "%s: Failed to request reset gpio: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	gpiod_set_consumer_name(reset_gpio, "MAX98373_RESET");
+
+	if (reset_gpio) {
+		/* Keep line asserted to reset device */
 		msleep(50);
-		gpio_direction_output(max98373->reset_gpio, 1);
+		/* Deassert reset line */
+		gpiod_set_value_cansleep(reset_gpio, 0);
 		msleep(20);
 	}
 
diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index f90a6a7ba83b..401546c1084e 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -12,9 +12,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98373.h"
 
@@ -478,21 +475,6 @@ void max98373_slot_config(struct device *dev,
 		max98373->i_slot = value & 0xF;
 	else
 		max98373->i_slot = 1;
-	if (dev->of_node) {
-		max98373->reset_gpio = of_get_named_gpio(dev->of_node,
-						"maxim,reset-gpio", 0);
-		if (!gpio_is_valid(max98373->reset_gpio)) {
-			dev_err(dev, "Looking up %s property in node %s failed %d\n",
-				"maxim,reset-gpio", dev->of_node->full_name,
-				max98373->reset_gpio);
-		} else {
-			dev_dbg(dev, "maxim,reset-gpio=%d",
-				max98373->reset_gpio);
-		}
-	} else {
-		/* this makes reset_gpio as invalid */
-		max98373->reset_gpio = -1;
-	}
 
 	if (!device_property_read_u32(dev, "maxim,spkfb-slot-no", &value))
 		max98373->spkfb_slot = value & 0xF;
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index e1810b3b1620..7b259789e1be 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -213,7 +213,6 @@ struct max98373_cache {
 
 struct max98373_priv {
 	struct regmap *regmap;
-	int reset_gpio;
 	unsigned int v_slot;
 	unsigned int i_slot;
 	unsigned int spkfb_slot;
-- 
2.38.1.431.g37b22c650d-goog

