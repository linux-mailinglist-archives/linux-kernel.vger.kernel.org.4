Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7E62B2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPFif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiKPFi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC382F3AE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b21so15441428plc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv8IbBpLkdekGE7AGRon9TYjB5CPxoZZsopxc+3pauE=;
        b=O9LU0JS8vCLzMrJ6zb77qaHvNYgKNqhBG+WIauQj6WG9zYSAm6dnNrs0cHutUfSh9x
         qzRtZnolhIfOD+aFB7tYYIJZzjAkg8T7aYSZSpFTkBuWQG0ftQo7X/u4gN23aJKyjsIk
         Po6VVr4pFEZ722hTx+CNArXH84MNDnnCV9NHuBQpViFkLpX1/ZCvHZ/0krO/pLf9mbBv
         eG6qWg0hFRbrUljZ5nCIsdTCogtWg7nNsdtLQO8bfyvccDmgj4FUb1eRWUnARowRsUZg
         I66K77RF09CTR7/VgRQxIV2EiBtxZY7yNtd1hqSIWWHYi+5vb392Dk95uyVYJLY3kRqs
         8SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv8IbBpLkdekGE7AGRon9TYjB5CPxoZZsopxc+3pauE=;
        b=NelaDgCM1RFmIINtS0tVJ1dlGwMqghpot/nQin5+jWMJ7OEL9BkR2q1IC1XK20o8bZ
         RtekgeYkz/Y81YDBOvD8W2ctLGtE3GzESw8yvuOO8etu6bFhtlBFuHbxdWDKUQ46Ubre
         SXMd0ld07ZvaZARUmzFhk8hH3oVxCRg5G8HtLSKKJsxWRgtF2FTSwW92xIl3TkR/UXtL
         /XFhzjxN5uuzlKsbfHLdaKUY5/cFJ05sP5h0yjSWnhUHPbSG4h0n69SnNi8XewU8ibOW
         jyvTL3IzCDHK4VZwlT6RG3+E/mdQ3hNyczY7wo1AhpAZuG392OLudM+SXnv48ScKf2Kl
         K9FA==
X-Gm-Message-State: ANoB5plW8ep5V9Qc15HSUj8mIuUA7n4eQPTDIUYGH5BkOAi0WU5h937c
        OEa7/kMJKS1l4Jst4Sub1Eo=
X-Google-Smtp-Source: AA0mqf7WoMoXlq9y8GdxWgoMyn/khFjjuSj+m8WTDJSLDonfOrPV3r49GVlLtLExyuhQWHMJ69EHvA==
X-Received: by 2002:a17:90a:7e87:b0:212:f810:a846 with SMTP id j7-20020a17090a7e8700b00212f810a846mr2131715pjl.71.1668577101886;
        Tue, 15 Nov 2022 21:38:21 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:21 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 01/11] ASoC: ak5386: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:07 -0800
Message-Id: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 sound/soc/codecs/ak5386.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index 0c5e00679c7d..0562890b5dc7 100644
--- a/sound/soc/codecs/ak5386.c
+++ b/sound/soc/codecs/ak5386.c
@@ -6,11 +6,12 @@
  * (c) 2013 Daniel Mack <zonque@gmail.com>
  */
 
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
-#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
@@ -21,7 +22,7 @@ static const char * const supply_names[] = {
 };
 
 struct ak5386_priv {
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
@@ -111,8 +112,8 @@ static int ak5386_hw_params(struct snd_pcm_substream *substream,
 	 * the AK5386 in power-down mode (PDN pin = “L”).
 	 */
 
-	if (gpio_is_valid(priv->reset_gpio))
-		gpio_set_value(priv->reset_gpio, 1);
+	if (priv->reset_gpio)
+		gpiod_set_value(priv->reset_gpio, 0);
 
 	return 0;
 }
@@ -123,8 +124,8 @@ static int ak5386_hw_free(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct ak5386_priv *priv = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(priv->reset_gpio))
-		gpio_set_value(priv->reset_gpio, 0);
+	if (priv->reset_gpio)
+		gpiod_set_value(priv->reset_gpio, 1);
 
 	return 0;
 }
@@ -168,7 +169,6 @@ static int ak5386_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->reset_gpio = -EINVAL;
 	dev_set_drvdata(dev, priv);
 
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
@@ -179,15 +179,13 @@ static int ak5386_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (of_match_device(of_match_ptr(ak5386_dt_ids), dev))
-		priv->reset_gpio = of_get_named_gpio(dev->of_node,
-						      "reset-gpio", 0);
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						   GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(priv->reset_gpio);
+	if (ret)
+		return ret;
 
-	if (gpio_is_valid(priv->reset_gpio))
-		if (devm_gpio_request_one(dev, priv->reset_gpio,
-					  GPIOF_OUT_INIT_LOW,
-					  "AK5386 Reset"))
-			priv->reset_gpio = -EINVAL;
+	gpiod_set_consumer_name(priv->reset_gpio, "AK5386 Reset");
 
 	return devm_snd_soc_register_component(dev, &soc_component_ak5386,
 				      &ak5386_dai, 1);
-- 
2.38.1.431.g37b22c650d-goog

