Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D573D26A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjFYQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjFYQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3119AB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e109525d6so182664966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710546; x=1690302546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIYC5RHCUmHOYXB4rEzcPmseZLQl8WhYPFeXh6HSghs=;
        b=xH3FhA04qFZBGJXE48A4RzYemkesixHL9/B3HxrhIRp3eF67XxCcL9xfgwALWocg0u
         +xW6afSWOw0xhBojG/J8RAT/NxKmqFfz4Z1+43w2Dt29MaGVcoenrxDDgcc0hWJbYvvT
         28eSQlO6pOMDcZ0l6nu6sgQCxjYtM0PrScnmYCCCOLsgiUjwGjN6cSJfxzCru47GPxyl
         lMixvzjIGsXJSdMxobecCT/KR1DGpg7fg35SvpGhuOM9HqLMMkwSTb2YjpEq7dn60XN3
         061RBK3XGX9n0OurOehnpqa/nMUNqRzXuWnVfU7ReWtd+uK1R85bR/cIN7VhV82n8a0h
         3zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710546; x=1690302546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIYC5RHCUmHOYXB4rEzcPmseZLQl8WhYPFeXh6HSghs=;
        b=jm8SINtlazh81TzRxnDmT4Rc9wYT8o1bMbhpApgLkxonH6UUDy8ZgVBKuXDC+p2nVm
         O6aYUfV63SbpeeKhMYL0kXhwV3ian9CircZM+NMwXHcXUrn51brsSiGXGfJNH1Qci9g2
         oSOh158O6L8R4GaDDvcUOi8ccxSCyBbq1bjBdSc5tUxraKYy90khYuP0TExdp//q6Ok6
         0UEe1SAhFkalQSzjqU1gzFux/m2Hxu5zdB+gPsnVyiDvljvz4wZN15KjdcOODmY8+7ke
         vPB9nklnh6x4TQgLBqDc/UcFqTGLsHonEqxNjG/Nbm78M7A5aObOJjx5rii5LVcyUR2w
         tW0Q==
X-Gm-Message-State: AC+VfDzn+QMAi4WIwoldPSncMi7MSpQ+7rIzycNrY4KnlZuQKgjcvOw1
        yRFOsf7Ov+tgHTfwm2VXtwZ4xw==
X-Google-Smtp-Source: ACHHUZ6Z8vfrrWRs60MAbbV1HqtZg+S0t3M8PVFYy/Jx41q9RFtvBflzgocooaRSSpWSbzEQVmBLJA==
X-Received: by 2002:a17:907:360a:b0:982:a022:a540 with SMTP id bk10-20020a170907360a00b00982a022a540mr27049924ejc.11.1687710546129;
        Sun, 25 Jun 2023 09:29:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:29:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 23/24] Input: bu21013_ts - Use local 'client->dev' variable in probe()
Date:   Sun, 25 Jun 2023 18:28:16 +0200
Message-Id: <20230625162817.100397-24-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dev' is shorter and simpler than '&client->dev' and in few cases it
allows to skip line wrapping. Probe function uses '&client->dev' a lot,
so this improves readability slightly.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Changes since v3:
1. Correct suggested-by tag.

Changes since v2:
1. New patch
---
 drivers/input/touchscreen/bu21013_ts.c | 61 ++++++++++++--------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index f811677a59f7..652439a79e21 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -410,31 +410,32 @@ static int bu21013_probe(struct i2c_client *client)
 	struct input_dev *in_dev;
 	struct input_absinfo *info;
 	u32 max_x = 0, max_y = 0;
+	struct device *dev = &client->dev;
 	int error;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&client->dev, "i2c smbus byte data not supported\n");
+		dev_err(dev, "i2c smbus byte data not supported\n");
 		return -EIO;
 	}
 
 	if (!client->irq) {
-		dev_err(&client->dev, "No IRQ set up\n");
+		dev_err(dev, "No IRQ set up\n");
 		return -EINVAL;
 	}
 
-	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
 	ts->client = client;
 
-	ts->x_flip = device_property_read_bool(&client->dev, "rohm,flip-x");
-	ts->y_flip = device_property_read_bool(&client->dev, "rohm,flip-y");
+	ts->x_flip = device_property_read_bool(dev, "rohm,flip-x");
+	ts->y_flip = device_property_read_bool(dev, "rohm,flip-y");
 
-	in_dev = devm_input_allocate_device(&client->dev);
+	in_dev = devm_input_allocate_device(dev);
 	if (!in_dev) {
-		dev_err(&client->dev, "device memory alloc failed\n");
+		dev_err(dev, "device memory alloc failed\n");
 		return -ENOMEM;
 	}
 	ts->in_dev = in_dev;
@@ -444,8 +445,8 @@ static int bu21013_probe(struct i2c_client *client)
 	in_dev->name = DRIVER_TP;
 	in_dev->id.bustype = BUS_I2C;
 
-	device_property_read_u32(&client->dev, "rohm,touch-max-x", &max_x);
-	device_property_read_u32(&client->dev, "rohm,touch-max-y", &max_y);
+	device_property_read_u32(dev, "rohm,touch-max-x", &max_x);
+	device_property_read_u32(dev, "rohm,touch-max-y", &max_y);
 
 	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0, max_x, 0, 0);
 	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
@@ -454,14 +455,14 @@ static int bu21013_probe(struct i2c_client *client)
 
 	/* Adjust for the legacy "flip" properties, if present */
 	if (!ts->props.invert_x &&
-	    device_property_read_bool(&client->dev, "rohm,flip-x")) {
+	    device_property_read_bool(dev, "rohm,flip-x")) {
 		info = &in_dev->absinfo[ABS_MT_POSITION_X];
 		info->maximum -= info->minimum;
 		info->minimum = 0;
 	}
 
 	if (!ts->props.invert_y &&
-	    device_property_read_bool(&client->dev, "rohm,flip-y")) {
+	    device_property_read_bool(dev, "rohm,flip-y")) {
 		info = &in_dev->absinfo[ABS_MT_POSITION_Y];
 		info->maximum -= info->minimum;
 		info->minimum = 0;
@@ -471,50 +472,46 @@ static int bu21013_probe(struct i2c_client *client)
 				    INPUT_MT_DIRECT | INPUT_MT_TRACK |
 					INPUT_MT_DROP_UNUSED);
 	if (error) {
-		dev_err(&client->dev, "failed to initialize MT slots");
+		dev_err(dev, "failed to initialize MT slots");
 		return error;
 	}
 
-	ts->regulator = devm_regulator_get(&client->dev, "avdd");
+	ts->regulator = devm_regulator_get(dev, "avdd");
 	if (IS_ERR(ts->regulator)) {
-		dev_err(&client->dev, "regulator_get failed\n");
+		dev_err(dev, "regulator_get failed\n");
 		return PTR_ERR(ts->regulator);
 	}
 
 	error = regulator_enable(ts->regulator);
 	if (error) {
-		dev_err(&client->dev, "regulator enable failed\n");
+		dev_err(dev, "regulator enable failed\n");
 		return error;
 	}
 
-	error = devm_add_action_or_reset(&client->dev, bu21013_power_off, ts);
+	error = devm_add_action_or_reset(dev, bu21013_power_off, ts);
 	if (error) {
-		dev_err(&client->dev, "failed to install power off handler\n");
+		dev_err(dev, "failed to install power off handler\n");
 		return error;
 	}
 
 	/* Named "CS" on the chip, DT binding is "reset" */
-	ts->cs_gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
+	ts->cs_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->cs_gpiod))
-		return dev_err_probe(&client->dev, PTR_ERR(ts->cs_gpiod),
-				     "failed to get CS GPIO\n");
+		return dev_err_probe(dev, PTR_ERR(ts->cs_gpiod), "failed to get CS GPIO\n");
 
 	gpiod_set_consumer_name(ts->cs_gpiod, "BU21013 CS");
 
-	error = devm_add_action_or_reset(&client->dev,
-					 bu21013_disable_chip, ts);
+	error = devm_add_action_or_reset(dev, bu21013_disable_chip, ts);
 	if (error) {
-		dev_err(&client->dev,
-			"failed to install chip disable handler\n");
+		dev_err(dev, "failed to install chip disable handler\n");
 		return error;
 	}
 
 	/* Named "INT" on the chip, DT binding is "touch" */
-	ts->int_gpiod = devm_gpiod_get_optional(&client->dev,
-						"touch", GPIOD_IN);
+	ts->int_gpiod = devm_gpiod_get_optional(dev, "touch", GPIOD_IN);
 	error = PTR_ERR_OR_ZERO(ts->int_gpiod);
 	if (error)
-		return dev_err_probe(&client->dev, error, "failed to get INT GPIO\n");
+		return dev_err_probe(dev, error, "failed to get INT GPIO\n");
 
 	if (ts->int_gpiod)
 		gpiod_set_consumer_name(ts->int_gpiod, "BU21013 INT");
@@ -522,22 +519,20 @@ static int bu21013_probe(struct i2c_client *client)
 	/* configure the touch panel controller */
 	error = bu21013_init_chip(ts);
 	if (error) {
-		dev_err(&client->dev, "error in bu21013 config\n");
+		dev_err(dev, "error in bu21013 config\n");
 		return error;
 	}
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, bu21013_gpio_irq,
+	error = devm_request_threaded_irq(dev, client->irq, NULL, bu21013_gpio_irq,
 					  IRQF_ONESHOT, DRIVER_TP, ts);
 	if (error) {
-		dev_err(&client->dev, "request irq %d failed\n",
-			client->irq);
+		dev_err(dev, "request irq %d failed\n", client->irq);
 		return error;
 	}
 
 	error = input_register_device(in_dev);
 	if (error) {
-		dev_err(&client->dev, "failed to register input device\n");
+		dev_err(dev, "failed to register input device\n");
 		return error;
 	}
 
-- 
2.34.1

