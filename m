Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D258D5B8A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiINOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiINOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:14:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E960F5F8D;
        Wed, 14 Sep 2022 07:14:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a80so6481275pfa.4;
        Wed, 14 Sep 2022 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bAdGrYEmkmvhtXoA2Nr4gmu6DhEMvOCOQQto+Y0rKro=;
        b=RQqHlOsbOD+e1GokuAbBhPA2En2nAB4l8+ioE1KNw6tmPFUf7IdYNKILmcF8+kUjF4
         npb+6aSPSGO3wf+jOZMRyOCuBUfDujUA1uck/5mzJsTXEvsslCbyVkYH1u+U4GW3l6Pc
         G5r+BIfK23wDn8fosrvUMRC1KA4Zkqfjt9UaTguVS0fDQOl9zpjk+lnbJ2AfrtK1/MoA
         j7rglwTl4WuB2sK73adZwyCBeMcJ5cDKCXBzcI56yDxyz/RTQWTwbKezfF+Ii3mcWU29
         EKiEWmctE7rZwC4qza1PX4cZ9hT2kk98PIUfyZxyAAS9LxnAljW/J8Lv9fnWpvFOxMUe
         Q1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bAdGrYEmkmvhtXoA2Nr4gmu6DhEMvOCOQQto+Y0rKro=;
        b=DfJdgrgreuT/iuXxCXxlmqLkDeFelQKxCfi+/Bn83T+3nmGIcqowCTnDNK9p4+IZCE
         0duKiXyyDNPQzSHbG+Tpgv/ukw7JtmNIFWe3BtBs1Hz9btXUo6kEm6j56nR9C5zwZnpr
         5SoKF2ZISV1ytnctjxXgCWQBj3r2NjFFQPFaXo2EeMyh+IH+bRoW1JAlX07EEnqPa8PZ
         W5s9efwVO2QHhCcuPwD+Fk8ZwX6MLucMKbtXanc/68GKytshdrjWFhZwjjGxdv7jNBzA
         WZ9BZvmDyW5YWOr2qIb1ClVXpP7PdDkvOn14+ol1UOtFfxMf9cdApLX0o/6F4pqPj74q
         xP4g==
X-Gm-Message-State: ACgBeo1E3xBLhrVfJJitLFbx5P1uJg6l2PREoopyK6N7JAvQ5OSWpQhy
        eOw9v0dL1oHaSCpyQOCjz0QNoqU4idfEEA==
X-Google-Smtp-Source: AA6agR5NCfuAQgOSxu39xQi5zNQ29mwMGp0YsL8eC/T4av6L8C70qRP1sZPIWosw8LwICdR4RNAxmg==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id d6-20020a056a00244600b005285da90cc7mr38622170pfj.51.1663164874098;
        Wed, 14 Sep 2022 07:14:34 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017839e5abfasm6480624plh.263.2022.09.14.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:14:33 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Input: auo-pixcir-ts - switch to using gpiod API
Date:   Wed, 14 Sep 2022 07:14:25 -0700
Message-Id: <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the driver to gpiod API and drops uses of of_get_gpio() API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/auo-pixcir-ts.c | 47 ++++++++++-------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index a51d66ebff2b..c3bce9fb2c94 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -10,6 +10,7 @@
  * Copyright (c) 2008 QUALCOMM USA, INC.
  */
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -19,9 +20,8 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 /*
  * Coordinate calculation:
@@ -112,8 +112,8 @@
 struct auo_pixcir_ts {
 	struct i2c_client	*client;
 	struct input_dev	*input;
-	int			gpio_int;
-	int			gpio_rst;
+	struct gpio_desc	*gpio_int;
+	struct gpio_desc	*gpio_rst;
 	char			phys[32];
 
 	unsigned int		x_max;
@@ -193,7 +193,7 @@ static irqreturn_t auo_pixcir_interrupt(int irq, void *dev_id)
 
 		/* check for up event in touch touch_ind_mode */
 		if (ts->touch_ind_mode) {
-			if (gpio_get_value(ts->gpio_int) == 0) {
+			if (gpiod_get_value_cansleep(ts->gpio_int) == 0) {
 				input_mt_sync(ts->input);
 				input_report_key(ts->input, BTN_TOUCH, 0);
 				input_sync(ts->input);
@@ -482,18 +482,6 @@ static int auo_pixcir_parse_dt(struct device *dev, struct auo_pixcir_ts *ts)
 	if (!np)
 		return -ENOENT;
 
-	ts->gpio_int = of_get_gpio(np, 0);
-	if (!gpio_is_valid(ts->gpio_int)) {
-		dev_err(dev, "failed to get interrupt gpio\n");
-		return -EINVAL;
-	}
-
-	ts->gpio_rst = of_get_gpio(np, 1);
-	if (!gpio_is_valid(ts->gpio_rst)) {
-		dev_err(dev, "failed to get reset gpio\n");
-		return -EINVAL;
-	}
-
 	if (of_property_read_u32(np, "x-size", &ts->x_max)) {
 		dev_err(dev, "failed to get x-size property\n");
 		return -EINVAL;
@@ -517,7 +505,7 @@ static void auo_pixcir_reset(void *data)
 {
 	struct auo_pixcir_ts *ts = data;
 
-	gpio_set_value(ts->gpio_rst, 0);
+	gpiod_set_value_cansleep(ts->gpio_rst, 1);
 }
 
 static int auo_pixcir_probe(struct i2c_client *client,
@@ -578,23 +566,28 @@ static int auo_pixcir_probe(struct i2c_client *client,
 
 	input_set_drvdata(ts->input, ts);
 
-	error = devm_gpio_request_one(&client->dev, ts->gpio_int,
-				      GPIOF_DIR_IN, "auo_pixcir_ts_int");
+	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
+	error = PTR_ERR_OR_ZERO(ts->gpio_int);
 	if (error) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			ts->gpio_int, error);
+		dev_err(&client->dev,
+			"request of int gpio failed: %d\n", error);
 		return error;
 	}
 
-	error = devm_gpio_request_one(&client->dev, ts->gpio_rst,
-				      GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
-				      "auo_pixcir_ts_rst");
+	gpiod_set_consumer_name(ts->gpio_int, "auo_pixcir_ts_int");
+
+	/* Take the chip out of reset */
+	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
+					    GPIOD_OUT_LOW);
+	error = PTR_ERR_OR_ZERO(ts->gpio_rst);
 	if (error) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			ts->gpio_rst, error);
+		dev_err(&client->dev,
+			"request of reset gpio failed: %d\n", error);
 		return error;
 	}
 
+	gpiod_set_consumer_name(ts->gpio_rst, "auo_pixcir_ts_rst");
+
 	error = devm_add_action_or_reset(&client->dev, auo_pixcir_reset, ts);
 	if (error) {
 		dev_err(&client->dev, "failed to register reset action, %d\n",
-- 
2.37.2.789.g6183377224-goog

