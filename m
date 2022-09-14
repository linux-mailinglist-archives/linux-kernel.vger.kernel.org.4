Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481795B8A18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiINOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiINOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:14:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC5410F6;
        Wed, 14 Sep 2022 07:14:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so14581530pjh.3;
        Wed, 14 Sep 2022 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oIEob1ZiIx5fsygiet7+nmwPOGiHlT4qbURIwP17aWE=;
        b=E4vK2AaaR9jzvzQMZSqpFaa46k11q0SWvM9z4Aihfq4jdaYMqQtd1n4kuoQO6X/H5V
         v4oeRv82+KtBROYhDvkX/gWFba6ziRdqE6+hMv0dMyG7jjxJjU/xP0BPcpF/Xk2RwPA4
         Wmexf3/Su/VboCc7Xs/Qmra5HxYwDLCaaw1A2RaY9uaLPyTxvAR/se2avYM1Jm/vYBJO
         clj8D0iiFFlxfwQdqa2jH7yEsemwxoEFoUAre+0qjQXH0qeQQUN9V0dNN7vS06NfUAQM
         3ciDKKbw+CKoWHcKjGNSDZEujWYUCZlFUzw7H/cEnpuKqYNBujdO8q93tn+AvcstQkoM
         QMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oIEob1ZiIx5fsygiet7+nmwPOGiHlT4qbURIwP17aWE=;
        b=Plmil9SaM/zq2PM0fdYUv2qRH5KiRykTlk7Qve6ZIzZB1mRFSrQhYs0Xbt/2lRFU4k
         rQ1G8PZYbI+X2cZiQG5FViR8W9qJEIPJD8GM0XWXmYkamaUrnvwPZNviHpbx4h9i3vRV
         hLKpbNeWfBebvaRcOADJNZS26VFz7DnIriloc35fT+vcUcWyXEWHhoYFYXtDlcNTkyNM
         N2Sd01jyeslEeov6layNWu2zheiRXXclioiKWsSkoOskaXPUR7dMnWAlOCoqujWTU67Q
         NY1dc1ZGKpV/6PtixM1y9f8FdKPFnBIwA2RDucFWe+99p1jxJViCztafBTv+8Qm4zpCO
         6ByQ==
X-Gm-Message-State: ACrzQf2G9n6SdgC/EGOQIsYLXKv3vyjM4IATHtyuDBAZIq7uQxOPSQCS
        udhowBG2jWV+lAvdk6G9nA5YV2eImqGCrg==
X-Google-Smtp-Source: AMsMyM7TOnJiUg2Rd8uz05n07Tj/B0wG9s/NUEVXmZhj4kvwrbuiLySzc/MxsGBRm2uAdkF+61+TSg==
X-Received: by 2002:a17:90b:3847:b0:203:1ef6:ce1 with SMTP id nl7-20020a17090b384700b002031ef60ce1mr2530309pjb.113.1663164872633;
        Wed, 14 Sep 2022 07:14:32 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017839e5abfasm6480624plh.263.2022.09.14.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:14:31 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Input: auo-pixcir-ts - drop support for platform data
Date:   Wed, 14 Sep 2022 07:14:24 -0700
Message-Id: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

Currently there are no users of auo_pixcir_ts_platdata in the mainline, and
having it (with legacy gpio numbers) prevents us from converting the driver
to gpiod API, so let's drop it.

If, in the future, someone wants to use this driver on non-device tree,
non-ACPI system, they should use static device properties instead of
platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/auo-pixcir-ts.c | 118 ++++++++++------------
 include/linux/input/auo-pixcir-ts.h       |  44 --------
 2 files changed, 56 insertions(+), 106 deletions(-)
 delete mode 100644 include/linux/input/auo-pixcir-ts.h

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index c33e63ca6142..a51d66ebff2b 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -20,7 +20,6 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <linux/input/auo-pixcir-ts.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
@@ -69,6 +68,16 @@
 #define AUO_PIXCIR_INT_RELEASE		(1 << 4)
 #define AUO_PIXCIR_INT_ENABLE		(1 << 3)
 #define AUO_PIXCIR_INT_POL_HIGH		(1 << 2)
+
+/*
+ * Interrupt modes:
+ * periodical:		interrupt is asserted periodicaly
+ * compare coordinates:	interrupt is asserted when coordinates change
+ * indicate touch:	interrupt is asserted during touch
+ */
+#define AUO_PIXCIR_INT_PERIODICAL	0x00
+#define AUO_PIXCIR_INT_COMP_COORD	0x01
+#define AUO_PIXCIR_INT_TOUCH_IND	0x02
 #define AUO_PIXCIR_INT_MODE_MASK	0x03
 
 /*
@@ -103,10 +112,14 @@
 struct auo_pixcir_ts {
 	struct i2c_client	*client;
 	struct input_dev	*input;
-	const struct auo_pixcir_ts_platdata *pdata;
+	int			gpio_int;
+	int			gpio_rst;
 	char			phys[32];
 
-	/* special handling for touch_indicate interupt mode */
+	unsigned int		x_max;
+	unsigned int		y_max;
+
+	/* special handling for touch_indicate interrupt mode */
 	bool			touch_ind_mode;
 
 	wait_queue_head_t	wait;
@@ -125,7 +138,6 @@ static int auo_pixcir_collect_data(struct auo_pixcir_ts *ts,
 				   struct auo_point_t *point)
 {
 	struct i2c_client *client = ts->client;
-	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 	uint8_t raw_coord[8];
 	uint8_t raw_area[4];
 	int i, ret;
@@ -152,8 +164,8 @@ static int auo_pixcir_collect_data(struct auo_pixcir_ts *ts,
 		point[i].coord_y =
 			raw_coord[4 * i + 3] << 8 | raw_coord[4 * i + 2];
 
-		if (point[i].coord_x > pdata->x_max ||
-		    point[i].coord_y > pdata->y_max) {
+		if (point[i].coord_x > ts->x_max ||
+		    point[i].coord_y > ts->y_max) {
 			dev_warn(&client->dev, "coordinates (%d,%d) invalid\n",
 				point[i].coord_x, point[i].coord_y);
 			point[i].coord_x = point[i].coord_y = 0;
@@ -171,7 +183,6 @@ static int auo_pixcir_collect_data(struct auo_pixcir_ts *ts,
 static irqreturn_t auo_pixcir_interrupt(int irq, void *dev_id)
 {
 	struct auo_pixcir_ts *ts = dev_id;
-	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 	struct auo_point_t point[AUO_PIXCIR_REPORT_POINTS];
 	int i;
 	int ret;
@@ -182,7 +193,7 @@ static irqreturn_t auo_pixcir_interrupt(int irq, void *dev_id)
 
 		/* check for up event in touch touch_ind_mode */
 		if (ts->touch_ind_mode) {
-			if (gpio_get_value(pdata->gpio_int) == 0) {
+			if (gpio_get_value(ts->gpio_int) == 0) {
 				input_mt_sync(ts->input);
 				input_report_key(ts->input, BTN_TOUCH, 0);
 				input_sync(ts->input);
@@ -278,11 +289,9 @@ static int auo_pixcir_power_mode(struct auo_pixcir_ts *ts, int mode)
 	return 0;
 }
 
-static int auo_pixcir_int_config(struct auo_pixcir_ts *ts,
-					   int int_setting)
+static int auo_pixcir_int_config(struct auo_pixcir_ts *ts, int int_setting)
 {
 	struct i2c_client *client = ts->client;
-	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_INT_SETTING);
@@ -304,7 +313,7 @@ static int auo_pixcir_int_config(struct auo_pixcir_ts *ts,
 		return ret;
 	}
 
-	ts->touch_ind_mode = pdata->int_setting == AUO_PIXCIR_INT_TOUCH_IND;
+	ts->touch_ind_mode = int_setting == AUO_PIXCIR_INT_TOUCH_IND;
 
 	return 0;
 }
@@ -466,49 +475,41 @@ static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops,
 			 auo_pixcir_suspend, auo_pixcir_resume);
 
 #ifdef CONFIG_OF
-static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device *dev)
+static int auo_pixcir_parse_dt(struct device *dev, struct auo_pixcir_ts *ts)
 {
-	struct auo_pixcir_ts_platdata *pdata;
 	struct device_node *np = dev->of_node;
 
 	if (!np)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	pdata->gpio_int = of_get_gpio(np, 0);
-	if (!gpio_is_valid(pdata->gpio_int)) {
+	ts->gpio_int = of_get_gpio(np, 0);
+	if (!gpio_is_valid(ts->gpio_int)) {
 		dev_err(dev, "failed to get interrupt gpio\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	pdata->gpio_rst = of_get_gpio(np, 1);
-	if (!gpio_is_valid(pdata->gpio_rst)) {
+	ts->gpio_rst = of_get_gpio(np, 1);
+	if (!gpio_is_valid(ts->gpio_rst)) {
 		dev_err(dev, "failed to get reset gpio\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
+	if (of_property_read_u32(np, "x-size", &ts->x_max)) {
 		dev_err(dev, "failed to get x-size property\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	if (of_property_read_u32(np, "y-size", &pdata->y_max)) {
+	if (of_property_read_u32(np, "y-size", &ts->y_max)) {
 		dev_err(dev, "failed to get y-size property\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	/* default to asserting the interrupt when the screen is touched */
-	pdata->int_setting = AUO_PIXCIR_INT_TOUCH_IND;
-
-	return pdata;
+	return 0;
 }
 #else
-static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device *dev)
+static int auo_pixcir_parse_dt(struct device *dev, struct auo_pixcir_ts *ts)
 {
-	return ERR_PTR(-EINVAL);
+	return -EINVAL;
 }
 #endif
 
@@ -516,27 +517,18 @@ static void auo_pixcir_reset(void *data)
 {
 	struct auo_pixcir_ts *ts = data;
 
-	gpio_set_value(ts->pdata->gpio_rst, 0);
+	gpio_set_value(ts->gpio_rst, 0);
 }
 
 static int auo_pixcir_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
-	const struct auo_pixcir_ts_platdata *pdata;
 	struct auo_pixcir_ts *ts;
 	struct input_dev *input_dev;
 	int version;
 	int error;
 
-	pdata = dev_get_platdata(&client->dev);
-	if (!pdata) {
-		pdata = auo_pixcir_parse_dt(&client->dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-	}
-
-	ts = devm_kzalloc(&client->dev,
-			  sizeof(struct auo_pixcir_ts), GFP_KERNEL);
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
@@ -546,7 +538,6 @@ static int auo_pixcir_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	ts->pdata = pdata;
 	ts->client = client;
 	ts->input = input_dev;
 	ts->touch_ind_mode = 0;
@@ -556,6 +547,10 @@ static int auo_pixcir_probe(struct i2c_client *client,
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
 
+	error = auo_pixcir_parse_dt(&client->dev, ts);
+	if (error)
+		return error;
+
 	input_dev->name = "AUO-Pixcir touchscreen";
 	input_dev->phys = ts->phys;
 	input_dev->id.bustype = BUS_I2C;
@@ -569,36 +564,34 @@ static int auo_pixcir_probe(struct i2c_client *client,
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 
 	/* For single touch */
-	input_set_abs_params(input_dev, ABS_X, 0, pdata->x_max, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, pdata->y_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, ts->x_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, ts->y_max, 0, 0);
 
 	/* For multi touch */
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
-			     pdata->x_max, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
-			     pdata->y_max, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
-			     AUO_PIXCIR_MAX_AREA, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
-			     AUO_PIXCIR_MAX_AREA, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, ts->x_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, ts->y_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+			     0, AUO_PIXCIR_MAX_AREA, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
+			     0, AUO_PIXCIR_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
 
 	input_set_drvdata(ts->input, ts);
 
-	error = devm_gpio_request_one(&client->dev, pdata->gpio_int,
+	error = devm_gpio_request_one(&client->dev, ts->gpio_int,
 				      GPIOF_DIR_IN, "auo_pixcir_ts_int");
 	if (error) {
 		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_int, error);
+			ts->gpio_int, error);
 		return error;
 	}
 
-	error = devm_gpio_request_one(&client->dev, pdata->gpio_rst,
+	error = devm_gpio_request_one(&client->dev, ts->gpio_rst,
 				      GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
 				      "auo_pixcir_ts_rst");
 	if (error) {
 		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_rst, error);
+			ts->gpio_rst, error);
 		return error;
 	}
 
@@ -619,7 +612,8 @@ static int auo_pixcir_probe(struct i2c_client *client,
 
 	dev_info(&client->dev, "firmware version 0x%X\n", version);
 
-	error = auo_pixcir_int_config(ts, pdata->int_setting);
+	/* default to asserting the interrupt when the screen is touched */
+	error = auo_pixcir_int_config(ts, AUO_PIXCIR_INT_TOUCH_IND);
 	if (error)
 		return error;
 
diff --git a/include/linux/input/auo-pixcir-ts.h b/include/linux/input/auo-pixcir-ts.h
deleted file mode 100644
index ed0776997a7a..000000000000
--- a/include/linux/input/auo-pixcir-ts.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Driver for AUO in-cell touchscreens
- *
- * Copyright (c) 2011 Heiko Stuebner <heiko@sntech.de>
- *
- * based on auo_touch.h from Dell Streak kernel
- *
- * Copyright (c) 2008 QUALCOMM Incorporated.
- * Copyright (c) 2008 QUALCOMM USA, INC.
- */
-
-#ifndef __AUO_PIXCIR_TS_H__
-#define __AUO_PIXCIR_TS_H__
-
-/*
- * Interrupt modes:
- * periodical:		interrupt is asserted periodicaly
- * compare coordinates:	interrupt is asserted when coordinates change
- * indicate touch:	interrupt is asserted during touch
- */
-#define AUO_PIXCIR_INT_PERIODICAL	0x00
-#define AUO_PIXCIR_INT_COMP_COORD	0x01
-#define AUO_PIXCIR_INT_TOUCH_IND	0x02
-
-/*
- * @gpio_int		interrupt gpio
- * @int_setting		one of AUO_PIXCIR_INT_*
- * @init_hw		hardwarespecific init
- * @exit_hw		hardwarespecific shutdown
- * @x_max		x-resolution
- * @y_max		y-resolution
- */
-struct auo_pixcir_ts_platdata {
-	int gpio_int;
-	int gpio_rst;
-
-	int int_setting;
-
-	unsigned int x_max;
-	unsigned int y_max;
-};
-
-#endif
-- 
2.37.2.789.g6183377224-goog

