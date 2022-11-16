Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5962B2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKPFij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKPFi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:27 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875DEB76
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1351272pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R6sweEIHhhYpgiaCutH/nTdz9vJpXVC7DNsSKyfy1o=;
        b=SGFwQZrpZadseImNE1dV7f7/n+GBWyuP1D3KdEwcSYytRYc/wU6ISg2+8huxQTCYpQ
         +1nw2DD75F461/POGGsS8UpOsQmzz6vdtUGLbgIYDB20G1GEZ7BrqGKq57XtDCoVVvOX
         9+TBX7/WD4kbRmZUCPbs6BMMr2f/B7CD+eSsTqWWRrBAAspwygWwOw3jfPMSNNvHj6VQ
         9znQgiT8KPVzcMwy7xoTdvAbQydBM15dwl6UdxGq6udjNangnuPM6xAI/vMJBYZPZTBS
         yj3EnfXjxf4pVRO7HLqlNGkhyjTtHOwiusaCTaqpcbUjSiTLDRNCYImFcBBAAxTLis1D
         SiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R6sweEIHhhYpgiaCutH/nTdz9vJpXVC7DNsSKyfy1o=;
        b=0rq1cok1rI64Or4Ur28PWTuUm9vQxzgeRCDEQ1GD0DSLJ7qoUzcRwQPdV117UEvfRs
         MmTAbEmohBq9j715VR6JF0luWTd/XU7aLgyOh9GgUm3dFDPXHRran/aQIG4zgyoMbpow
         P7bD4QD+9OMRsAo050JdUbi06aNOzzj2xzg9z3kG7tKtkRCdjIeIhZ6KM5J9k9CAIlQ5
         j0SIOvmvMFhVh24j8rcaA51XZl3C2GRSOPnHD7gZTkMpYtdKIc/K3JIgLwbbz6uhpTMT
         4vOIIK9ECCDg3SeHuyxsYjVsz9PDU0FpbjWf+kI9CHKCUFX7MFrg4QYxqCjcn1OeoK0Y
         MfCw==
X-Gm-Message-State: ANoB5pkc3yPnP5X6sI8iSbUHZQj7zqTuGUwt9TiZG0P+7Cyf1jMmCFWa
        aU/AIOI77bvu1Q0GGVNe6h8=
X-Google-Smtp-Source: AA0mqf69nPVB/e/jNzSi6LyOuxv4aaC/+oypv7ZD7k/OeK9pMQrXeF6o1DIcht7/Hh1QXIGXKcWPEQ==
X-Received: by 2002:a17:902:b204:b0:186:a2e3:7035 with SMTP id t4-20020a170902b20400b00186a2e37035mr7435171plr.74.1668577105864;
        Tue, 15 Nov 2022 21:38:25 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:24 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 03/11] ASoC: tas5086: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:09 -0800
Message-Id: <20221116053817.2929810-3-dmitry.torokhov@gmail.com>
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
 sound/soc/codecs/tas5086.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 22143cc5afa7..66b22b800e01 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -24,14 +24,14 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -246,7 +246,7 @@ struct tas5086_private {
 	/* Current sample rate for de-emphasis control */
 	int		rate;
 	/* GPIO driving Reset pin, if any */
-	int		gpio_nreset;
+	struct gpio_desc *reset_gpio;
 	struct		regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
@@ -462,11 +462,11 @@ static int tas5086_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 
 static void tas5086_reset(struct tas5086_private *priv)
 {
-	if (gpio_is_valid(priv->gpio_nreset)) {
+	if (priv->reset_gpio) {
 		/* Reset codec - minimum assertion time is 400ns */
-		gpio_direction_output(priv->gpio_nreset, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 		udelay(1);
-		gpio_set_value(priv->gpio_nreset, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 
 		/* Codec needs ~15ms to wake up */
 		msleep(15);
@@ -867,9 +867,10 @@ static void tas5086_remove(struct snd_soc_component *component)
 {
 	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(priv->gpio_nreset))
+	if (priv->reset_gpio) {
 		/* Set codec to the reset state */
-		gpio_set_value(priv->gpio_nreset, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	}
 
 	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
 };
@@ -914,7 +915,6 @@ static int tas5086_i2c_probe(struct i2c_client *i2c)
 {
 	struct tas5086_private *priv;
 	struct device *dev = &i2c->dev;
-	int gpio_nreset = -EINVAL;
 	int i, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -940,16 +940,12 @@ static int tas5086_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, priv);
 
-	if (of_match_device(of_match_ptr(tas5086_dt_ids), dev)) {
-		struct device_node *of_node = dev->of_node;
-		gpio_nreset = of_get_named_gpio(of_node, "reset-gpio", 0);
-	}
-
-	if (gpio_is_valid(gpio_nreset))
-		if (devm_gpio_request(dev, gpio_nreset, "TAS5086 Reset"))
-			gpio_nreset = -EINVAL;
+	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(priv->reset_gpio);
+	if (ret)
+		return ret;
 
-	priv->gpio_nreset = gpio_nreset;
+	gpiod_set_consumer_name(priv->reset_gpio, "TAS5086 Reset");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
 	if (ret < 0) {
-- 
2.38.1.431.g37b22c650d-goog

