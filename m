Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7666E2E69
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDOCCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjDOCCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:02:38 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CEE4C22;
        Fri, 14 Apr 2023 19:02:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f80e173ecso1839407b3.0;
        Fri, 14 Apr 2023 19:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681524155; x=1684116155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2uBMdFyxdhtrqhapu2ahRDY229JhTGTzNiLljociWc=;
        b=aJNwoASB5bWAsVbxFKyU5Z7xWt7+8gnjHA6RzsQsn3iYQGFs3qa0zsWpGTGvgz6xtF
         SQRe1oTCIsbIA1FmkQ7mKm39akFzx1ci0l/CPh8VTOGAB/MPRUmn1EOTqKvOsOyLA0Gd
         b6hNkcz7aXHLH0mUiQvnnABYlGFUdunxmuJng0ws+HY6Kz9vBNex42OQ1jth3MH6RnQk
         XxXWVvrFa5JVIQIOoriPL5tq8MTaxrMkehRiW9Ogg19Jbcib1bcRouRywEdWMY+aHot+
         W3MVXWc5FUgER7u7IPcoVCvYDI5uRE8+G3ctfhPLg0FwcYSKjF1xl0e1/hnyRIWi9+QJ
         PaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681524155; x=1684116155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2uBMdFyxdhtrqhapu2ahRDY229JhTGTzNiLljociWc=;
        b=UHQQ5qqX966Fqso4/aK65JtMJDo76QkGoK1qcFe/CBpy4BCE53wFT93J8+1kc5b2C6
         mB71vOOps3YMMKICBBreaK9FvJ4boBSQ49e5eSFHMD4MRKJPAvxxWJcVxV8xyNE9YvbP
         dFe4MPayl8SrDo1Fa2QyewsKiOMZ0DGx/KSReOT4v+T3ZIAIQEfxSS/ESX6WX+uSFYtD
         Qf45AJc16K3y5tKz9/ttVvudzIpvP7PXSPjQRyu65L6rf+ATDfDufof2GccWpCZgMYxj
         kAsoNgqDgxWVoqRFnryrff4Wk+pY3sgROLcvTYZQXeURQQRdSjEPmEun1lcuRlngryC1
         uJaQ==
X-Gm-Message-State: AAQBX9cGVp634a3iLPtfLDYNJk6u+e4tgykEj4ehv3Q7edH6hTwn6wnm
        23niS6ZXtpfzcT9JPE8CJXU=
X-Google-Smtp-Source: AKy350arxCF/jjwyFRLPpO093Ounwgfa0rWQZyPpoYuUEXWFwSxdXhvRTlxIkcZz5adcebIYBQMl8A==
X-Received: by 2002:a81:5d7:0:b0:54f:44c9:95d1 with SMTP id 206-20020a8105d7000000b0054f44c995d1mr4024852ywf.0.1681524155530;
        Fri, 14 Apr 2023 19:02:35 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id 68-20020a810a47000000b00545a081847fsm1593607ywk.15.2023.04.14.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 19:02:35 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 2/5] Input: add driver for Focaltech FTS touchscreen
Date:   Fri, 14 Apr 2023 21:02:19 -0500
Message-Id: <20230415020222.216232-3-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
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

The Focaltech FTS driver supports several variants of focaltech
touchscreens found in ~2018 era smartphones including variants found on
the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
This driver is loosely based on the original driver from Focaltech
but has been simplified and largely reworked.

Co-developed-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 MAINTAINERS                                   |   8 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ec4ce64f66d..1a3ea61e1f52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8028,6 +8028,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/joystick/fsia6b.c
 
+FOCALTECH FTS5452 TOUCHSCREEN DRIVER
+M:	Joel Selvaraj <joelselvaraj.oss@gmail.com>
+M:	Caleb Connolly <caleb@connolly.tech>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
+F:	drivers/input/touchscreen/focaltech_fts5452.c
+
 FOCUSRITE SCARLETT GEN 2/3 MIXER DRIVER
 M:	Geoffrey D. Bennett <g@b4.vu>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 1feecd7ed3cb..11af91504969 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -388,6 +388,18 @@ config TOUCHSCREEN_EXC3000
 	  To compile this driver as a module, choose M here: the
 	  module will be called exc3000.
 
+config TOUCHSCREEN_FOCALTECH_FTS5452
+	tristate "Focaltech FTS Touchscreen"
+	depends on I2C
+	help
+	  Say Y here to enable support for I2C connected Focaltech FTS
+	  based touch panels, including the 5452 and 8917 panels.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called focaltech_fts.
+
 config TOUCHSCREEN_FUJITSU
 	tristate "Fujitsu serial touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 159cd5136fdb..47d78c9cff21 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
 obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
+obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FTS5452)	+= focaltech_fts5452.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
diff --git a/drivers/input/touchscreen/focaltech_fts5452.c b/drivers/input/touchscreen/focaltech_fts5452.c
new file mode 100644
index 000000000000..abf8a2f271ca
--- /dev/null
+++ b/drivers/input/touchscreen/focaltech_fts5452.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FocalTech touchscreen driver.
+ *
+ * Copyright (c) 2010-2017, FocalTech Systems, Ltd., all rights reserved.
+ * Copyright (C) 2018 XiaoMi, Inc.
+ * Copyright (c) 2021 Caleb Connolly <caleb@connolly.tech>
+ * Copyright (c) 2023 Joel Selvaraj <joelselvaraj.oss@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#define FTS_REG_CHIP_ID_H		0xA3
+#define FTS_REG_CHIP_ID_L		0x9F
+
+#define FTS_MAX_POINTS_SUPPORT		10
+#define FTS_ONE_TOUCH_LEN		6
+
+#define FTS_TOUCH_X_H_OFFSET		3
+#define FTS_TOUCH_X_L_OFFSET		4
+#define FTS_TOUCH_Y_H_OFFSET		5
+#define FTS_TOUCH_Y_L_OFFSET		6
+#define FTS_TOUCH_PRESSURE_OFFSET	7
+#define FTS_TOUCH_AREA_OFFSET		8
+#define FTS_TOUCH_TYPE_OFFSET		3
+#define FTS_TOUCH_ID_OFFSET		5
+
+#define FTS_TOUCH_DOWN			0
+#define FTS_TOUCH_UP			1
+#define FTS_TOUCH_CONTACT		2
+
+#define FTS_INTERVAL_READ_REG_MS	100
+#define FTS_TIMEOUT_READ_REG_MS		2000
+
+#define FTS_DRIVER_NAME			"fts-i2c"
+
+static const u16 fts_chip_types[] = {
+	0x5452,
+	0x8719,
+};
+
+struct fts_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct regmap *regmap;
+	int irq;
+	struct regulator_bulk_data regulators[2];
+	u8 max_touch_points;
+	u8 *point_buf;
+	int point_buf_size;
+	struct gpio_desc *reset_gpio;
+	struct touchscreen_properties prop;
+};
+
+struct fts_i2c_chip_data {
+	int max_touch_points;
+};
+
+int fts_check_status(struct fts_ts_data *data)
+{
+	int error, i = 0, count = 0;
+	unsigned int val, id;
+
+	do {
+		error = regmap_read(data->regmap, FTS_REG_CHIP_ID_L, &id);
+		if (error)
+			dev_err(&data->client->dev, "I2C read failed: %d\n", error);
+
+		error = regmap_read(data->regmap, FTS_REG_CHIP_ID_H, &val);
+		if (error)
+			dev_err(&data->client->dev, "I2C read failed: %d\n", error);
+
+		id |= val << 8;
+
+		for (i = 0; i < ARRAY_SIZE(fts_chip_types); i++)
+			if (id == fts_chip_types[i])
+				return 0;
+
+		count++;
+		msleep(FTS_INTERVAL_READ_REG_MS);
+	} while ((count * FTS_INTERVAL_READ_REG_MS) < FTS_TIMEOUT_READ_REG_MS);
+
+	return -EIO;
+}
+
+static int fts_report_touch(struct fts_ts_data *data)
+{
+	struct input_dev *input_dev = data->input_dev;
+	int base;
+	unsigned int x, y, z, maj;
+	u8 slot, type;
+	int error, i = 0;
+
+	u8 *buf = data->point_buf;
+
+	memset(buf, 0, data->point_buf_size);
+
+	error = regmap_bulk_read(data->regmap, 0, buf, data->point_buf_size);
+	if (error) {
+		dev_err(&data->client->dev, "I2C read failed: %d\n", error);
+		return error;
+	}
+
+	for (i = 0; i < data->max_touch_points; i++) {
+		base = FTS_ONE_TOUCH_LEN * i;
+
+		slot = buf[base + FTS_TOUCH_ID_OFFSET] >> 4;
+		if (slot >= data->max_touch_points)
+			break;
+
+		x = ((buf[base + FTS_TOUCH_X_H_OFFSET] & 0x0F) << 8) +
+		    (buf[base + FTS_TOUCH_X_L_OFFSET] & 0xFF);
+		y = ((buf[base + FTS_TOUCH_Y_H_OFFSET] & 0x0F) << 8) +
+		    (buf[base + FTS_TOUCH_Y_L_OFFSET] & 0xFF);
+
+		z = buf[base + FTS_TOUCH_PRESSURE_OFFSET];
+		if (z == 0)
+			z = 0x3f;
+
+		maj = buf[base + FTS_TOUCH_AREA_OFFSET] >> 4;
+		if (maj == 0)
+			maj = 0x09;
+
+		type = buf[base + FTS_TOUCH_TYPE_OFFSET] >> 6;
+
+		input_mt_slot(input_dev, slot);
+		if (type == FTS_TOUCH_DOWN || type == FTS_TOUCH_CONTACT) {
+			input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, true);
+			touchscreen_report_pos(data->input_dev, &data->prop, x, y, true);
+			input_report_abs(input_dev, ABS_MT_PRESSURE, z);
+			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, maj);
+			input_report_key(data->input_dev, BTN_TOUCH, 1);
+		} else {
+			input_report_key(data->input_dev, BTN_TOUCH, 0);
+			input_mt_report_slot_inactive(input_dev);
+		}
+	}
+	input_mt_sync_frame(input_dev);
+	input_sync(input_dev);
+
+	return 0;
+}
+
+static irqreturn_t fts_ts_interrupt(int irq, void *dev_id)
+{
+	struct fts_ts_data *data = dev_id;
+
+	return fts_report_touch(data) ? IRQ_NONE : IRQ_HANDLED;
+}
+
+static void fts_power_off(void *d)
+{
+	struct fts_ts_data *data = d;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
+static int fts_start(struct fts_ts_data *data)
+{
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (error) {
+		dev_err(&data->client->dev, "failed to enable regulators\n");
+		return error;
+	}
+
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+	msleep(200);
+
+	enable_irq(data->irq);
+
+	return 0;
+}
+
+static int fts_stop(struct fts_ts_data *data)
+{
+	disable_irq(data->irq);
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+	fts_power_off(data);
+
+	return 0;
+}
+
+static int fts_input_open(struct input_dev *dev)
+{
+	struct fts_ts_data *data = input_get_drvdata(dev);
+	int error;
+
+	error = fts_start(data);
+	if (error)
+		return error;
+
+	error = fts_check_status(data);
+	if (error) {
+		dev_err(&data->client->dev, "Failed to start or unsupported chip");
+		return error;
+	}
+
+	return 0;
+}
+
+static void fts_input_close(struct input_dev *dev)
+{
+	struct fts_ts_data *data = input_get_drvdata(dev);
+
+	fts_stop(data);
+}
+
+static int fts_input_init(struct fts_ts_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct input_dev *input_dev;
+	int error = 0;
+
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	data->input_dev = input_dev;
+
+	input_dev->name = FTS_DRIVER_NAME;
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = dev;
+	input_dev->open = fts_input_open;
+	input_dev->close = fts_input_close;
+	input_set_drvdata(input_dev, data);
+
+	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(input_dev, true, &data->prop);
+	if (!data->prop.max_x || !data->prop.max_y) {
+		dev_err(dev,
+			"touchscreen-size-x and/or touchscreen-size-y not set in device properties\n");
+		return -EINVAL;
+	}
+
+	error = input_mt_init_slots(input_dev, data->max_touch_points,
+				    INPUT_MT_DIRECT);
+	if (error)
+		return error;
+
+	data->point_buf_size = (data->max_touch_points * FTS_ONE_TOUCH_LEN) + 3;
+	data->point_buf = devm_kzalloc(dev, data->point_buf_size, GFP_KERNEL);
+	if (!data->point_buf)
+		return -ENOMEM;
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(dev, "Failed to register input device\n");
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config fts_ts_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int fts_ts_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct fts_i2c_chip_data *chip_data;
+	struct fts_ts_data *data;
+	int error = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "I2C not supported");
+		return -ENODEV;
+	}
+
+	if (!client->irq) {
+		dev_err(&client->dev, "No irq specified\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	chip_data = device_get_match_data(&client->dev);
+	if (!chip_data)
+		chip_data = (const struct fts_i2c_chip_data *)id->driver_data;
+	if (!chip_data || !chip_data->max_touch_points) {
+		dev_err(&client->dev, "invalid or missing chip data\n");
+		return -EINVAL;
+	}
+	if (chip_data->max_touch_points > FTS_MAX_POINTS_SUPPORT) {
+		dev_err(&client->dev,
+			"invalid chip data, max_touch_points should be less than or equal to %d\n",
+			FTS_MAX_POINTS_SUPPORT);
+		return -EINVAL;
+	}
+	data->max_touch_points = chip_data->max_touch_points;
+
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio)) {
+		error = PTR_ERR(data->reset_gpio);
+		dev_err(&client->dev, "Failed to request reset gpio, error %d\n", error);
+		return error;
+	}
+
+	data->regmap = devm_regmap_init_i2c(client, &fts_ts_i2c_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		error = PTR_ERR(data->regmap);
+		dev_err(&client->dev, "regmap allocation failed, error %d\n", error);
+		return error;
+	}
+
+	/*
+	 * AVDD is the analog voltage supply (2.6V to 3.3V)
+	 * VDDIO is the digital voltage supply (1.8V)
+	 */
+	data->regulators[0].supply = "avdd";
+	data->regulators[1].supply = "vddio";
+	error = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
+					data->regulators);
+	if (error) {
+		dev_err(&client->dev, "Failed to get regulators %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&client->dev, fts_power_off, data);
+	if (error) {
+		dev_err(&client->dev, "failed to install power off handler\n");
+		return error;
+	}
+
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					  fts_ts_interrupt, IRQF_ONESHOT,
+					  client->name, data);
+	if (error) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
+		return error;
+	}
+
+	error = fts_input_init(data);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int fts_pm_suspend(struct device *dev)
+{
+	struct fts_ts_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->input_dev->mutex);
+
+	if (input_device_enabled(data->input_dev))
+		fts_stop(data);
+
+	mutex_unlock(&data->input_dev->mutex);
+
+	return 0;
+}
+
+static int fts_pm_resume(struct device *dev)
+{
+	struct fts_ts_data *data = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&data->input_dev->mutex);
+
+	if (input_device_enabled(data->input_dev))
+		error = fts_start(data);
+
+	mutex_unlock(&data->input_dev->mutex);
+
+	return error;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(fts_dev_pm_ops, fts_pm_suspend, fts_pm_resume);
+
+static const struct fts_i2c_chip_data fts5452_chip_data = {
+	.max_touch_points = 5,
+};
+
+static const struct fts_i2c_chip_data fts8719_chip_data = {
+	.max_touch_points = 10,
+};
+
+static const struct i2c_device_id fts_i2c_id[] = {
+	{ .name = "fts5452", .driver_data = (long)&fts5452_chip_data },
+	{ .name = "fts8719", .driver_data = (long)&fts8719_chip_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, fts_i2c_id);
+
+static const struct of_device_id fts_of_match[] = {
+	{ .compatible = "focaltech,fts5452", .data = &fts5452_chip_data },
+	{ .compatible = "focaltech,fts8719", .data = &fts8719_chip_data },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, fts_of_match);
+
+static struct i2c_driver fts_ts_driver = {
+	.probe_new = fts_ts_probe,
+	.id_table = fts_i2c_id,
+	.driver = {
+		.name = FTS_DRIVER_NAME,
+		.pm = pm_sleep_ptr(&fts_dev_pm_ops),
+		.of_match_table = fts_of_match,
+	},
+};
+module_i2c_driver(fts_ts_driver);
+
+MODULE_AUTHOR("Joel Selvaraj <joelselvaraj.oss@gmail.com>");
+MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
+MODULE_DESCRIPTION("Focaltech Touchscreen Driver");
+MODULE_LICENSE("GPL");
-- 
2.40.0

