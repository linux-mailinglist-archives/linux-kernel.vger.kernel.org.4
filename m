Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738D0600BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJQKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiJQKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:04:55 -0400
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96C219009;
        Mon, 17 Oct 2022 03:04:46 -0700 (PDT)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4MrXfL5PZYz9t00;
        Mon, 17 Oct 2022 12:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1666001082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6QfzRve5D0lCUNwNJjHMATpymf0hyMeZ/hqpUngBJ4=;
        b=R0dWi1yUTVo87yMxmXc2f7eVdsrKGna1PhMq6/UuRafit4GlBm4IgbdjRXRr80B2bxsDJM
        TQwZkU2SQf+M1LKv1i0G6EAMwuPnQrbG57TU8dd6R/xB/crX+lcffVQzN2w8fAQ/TxCvEE
        o+V7EP6ptPsYXMYA6Fp5Pm0fIVVawcF0WaCbhBBnsbQT3RnaQI933IbW0srGO1PvDi0RoF
        9CJ32WHuXu+BVS4dwo+1RSfikuFtIpIoq+3P0MZPky5FAY9+lnVz7ujnOWAcKqJj/gCEJq
        3ipDcCAni9smGHR8sS8Ns1UlB3d30b+SMsMrvXQLckm6Eqz24lIBsZMRKBqorw==
From:   Job Noorman <job@noorman.info>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Job Noorman <job@noorman.info>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v4 2/3] Input: add driver for Himax hx83112b touchscreen devices
Date:   Mon, 17 Oct 2022 12:04:07 +0200
Message-Id: <20221017100409.189293-3-job@noorman.info>
In-Reply-To: <20221017100409.189293-1-job@noorman.info>
References: <20221017100409.189293-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MrXfL5PZYz9t00
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Himax hx83112b touchscreen devices. As there
are no publicly available data sheets for these devices, the
implementation is based on the driver of the downstream Android kernel
used in the Fairphone 3. This patch is a complete rewrite, though, and
the code bears no resemblence to the original implementation.

The driver has been tested on the aforementioned phone.

Signed-off-by: Job Noorman <job@noorman.info>
---
 MAINTAINERS                                |   1 +
 drivers/input/touchscreen/Kconfig          |  11 +
 drivers/input/touchscreen/Makefile         |   1 +
 drivers/input/touchscreen/himax_hx83112b.c | 367 +++++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 drivers/input/touchscreen/himax_hx83112b.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2418bffe9187..51a03f9586f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9099,6 +9099,7 @@ M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
+F:	drivers/input/touchscreen/himax_hx83112b.c
 
 HIPPI
 M:	Jes Sorensen <jes@trained-monkey.org>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index dc90a3ea51ee..113b7dd7da2f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1379,4 +1379,15 @@ config TOUCHSCREEN_ZINITIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called zinitix.
 
+config TOUCHSCREEN_HIMAX_HX83112B
+	tristate "Himax hx83112b touchscreen driver"
+	depends on REGMAP_I2C
+	help
+	  Say Y here to enable support for Himax hx83112b touchscreens.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called himax_hx83112b.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 557f84fd2075..0f8bf79e01fe 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -116,3 +116,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
 obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
 obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
+obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
new file mode 100644
index 000000000000..6f76fe48cfdd
--- /dev/null
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Himax hx83112b touchscreens
+ *
+ * Copyright (C) 2022 Job Noorman <job@noorman.info>
+ *
+ * This code is based on "Himax Android Driver Sample Code for QCT platform":
+ *
+ * Copyright (C) 2017 Himax Corporation.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+
+#define HIMAX_ID_83112B 0x83112b
+
+#define HIMAX_MAX_POINTS 10
+
+
+#define HIMAX_REG_CFG_SET_ADDR	 0x00
+#define HIMAX_REG_CFG_INIT_READ	 0x0c
+#define HIMAX_REG_CFG_READ_VALUE 0x08
+#define HIMAX_REG_READ_EVENT	 0x30
+
+#define HIMAX_CFG_PRODUCT_ID 0x900000d0
+
+#define HIMAX_INVALID_COORD 0xffff
+
+struct himax_event_point {
+	__be16 x;
+	__be16 y;
+} __packed;
+
+struct himax_event {
+	struct himax_event_point points[HIMAX_MAX_POINTS];
+	u8 majors[HIMAX_MAX_POINTS];
+	u8 pad0[2];
+	u8 num_points;
+	u8 pad1[2];
+	u8 checksum_fix;
+} __packed;
+
+static_assert(sizeof(struct himax_event) == 56);
+
+struct himax_ts_data {
+	struct gpio_desc *gpiod_rst;
+	struct input_dev *input_dev;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct touchscreen_properties props;
+};
+
+static const struct regmap_config himax_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
+{
+	int error;
+
+	error = regmap_write(ts->regmap, HIMAX_REG_CFG_SET_ADDR, address);
+	if (error)
+		return error;
+
+	error = regmap_write(ts->regmap, HIMAX_REG_CFG_INIT_READ, 0x0);
+	if (error)
+		return error;
+
+	error = regmap_read(ts->regmap, HIMAX_REG_CFG_READ_VALUE, dst);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static void himax_reset(struct himax_ts_data *ts)
+{
+	gpiod_set_value_cansleep(ts->gpiod_rst, 1);
+
+	/* Delay copied from downstream driver */
+	msleep(20);
+	gpiod_set_value_cansleep(ts->gpiod_rst, 0);
+
+	/*
+	 * The downstream driver doesn't contain this delay but is seems safer
+	 * to include it. The range is just a guess that seems to work well.
+	 */
+	usleep_range(1000, 1100);
+}
+
+static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id)
+{
+	int error;
+
+	error = himax_read_config(ts, HIMAX_CFG_PRODUCT_ID, product_id);
+	if (error)
+		return error;
+
+	*product_id >>= 8;
+	return 0;
+}
+
+static int himax_check_product_id(struct himax_ts_data *ts)
+{
+	int error;
+	u32 product_id;
+
+	error = himax_read_product_id(ts, &product_id);
+	if (error)
+		return error;
+
+	dev_dbg(&ts->client->dev, "Product id: %x\n", product_id);
+
+	switch (product_id) {
+	case HIMAX_ID_83112B:
+		return 0;
+
+	default:
+		dev_err(&ts->client->dev,
+			"Unknown product id: %x\n", product_id);
+		return -EINVAL;
+	}
+}
+
+static int himax_input_register(struct himax_ts_data *ts)
+{
+	int error;
+
+	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
+	if (!ts->input_dev) {
+		dev_err(&ts->client->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	ts->input_dev->name = "Himax Touchscreen";
+
+	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
+	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 200, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 200, 0, 0);
+
+	touchscreen_parse_properties(ts->input_dev, true, &ts->props);
+
+	error = input_mt_init_slots(ts->input_dev, HIMAX_MAX_POINTS,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to initialize MT slots: %d\n", error);
+		return error;
+	}
+
+	error = input_register_device(ts->input_dev);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to register input device: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static u8 himax_event_get_num_points(const struct himax_event *event)
+{
+	if (event->num_points == 0xff)
+		return 0;
+	else
+		return event->num_points & 0x0f;
+}
+
+static bool himax_process_event_point(struct himax_ts_data *ts,
+				      const struct himax_event *event,
+				      int point_index)
+{
+	const struct himax_event_point *point = &event->points[point_index];
+	u16 x = be16_to_cpu(point->x);
+	u16 y = be16_to_cpu(point->y);
+	u8 w = event->majors[point_index];
+
+	if (x == HIMAX_INVALID_COORD || y == HIMAX_INVALID_COORD)
+		return false;
+
+	input_mt_slot(ts->input_dev, point_index);
+	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
+	touchscreen_report_pos(ts->input_dev, &ts->props, x, y, true);
+	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, w);
+	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, w);
+	return true;
+}
+
+static void himax_process_event(struct himax_ts_data *ts,
+				const struct himax_event *event)
+{
+	int i;
+	int num_points_left = himax_event_get_num_points(event);
+
+	for (i = 0; i < HIMAX_MAX_POINTS && num_points_left > 0; i++) {
+		if (himax_process_event_point(ts, event, i))
+			num_points_left--;
+	}
+
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
+}
+
+static bool himax_verify_checksum(struct himax_ts_data *ts,
+				  const struct himax_event *event)
+{
+	u8 *data = (u8 *)event;
+	int i;
+	u16 checksum = 0;
+
+	for (i = 0; i < sizeof(*event); i++)
+		checksum += data[i];
+
+	if ((checksum & 0x00ff) != 0) {
+		dev_err(&ts->client->dev, "Wrong event checksum: %04x\n",
+			checksum);
+		return false;
+	}
+
+	return true;
+}
+
+static int himax_handle_input(struct himax_ts_data *ts)
+{
+	int error;
+	struct himax_event event;
+
+	error = regmap_raw_read(ts->regmap, HIMAX_REG_READ_EVENT, &event,
+				sizeof(event));
+	if (error) {
+		dev_err(&ts->client->dev, "Failed to read input event: %d\n",
+			error);
+		return error;
+	}
+
+	if (!himax_verify_checksum(ts, &event)) {
+		/*
+		 * We cannot process the current event when it has an invalid
+		 * checksum but we don't consider this a fatal error.
+		 */
+		return 0;
+	}
+
+	himax_process_event(ts, &event);
+	return 0;
+}
+
+static irqreturn_t himax_irq_handler(int irq, void *dev_id)
+{
+	struct himax_ts_data *ts = dev_id;
+	int error = himax_handle_input(ts);
+
+	if (error)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int himax_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	int error;
+	struct device *dev = &client->dev;
+	struct himax_ts_data *ts;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(dev, "I2C check functionality failed\n");
+		return -ENXIO;
+	}
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, ts);
+	ts->client = client;
+
+	ts->regmap = devm_regmap_init_i2c(client, &himax_regmap_config);
+	error = PTR_ERR_OR_ZERO(ts->regmap);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to initialize regmap: %d\n", error);
+		return error;
+	}
+
+	ts->gpiod_rst = devm_gpiod_get(&ts->client->dev, "reset",
+				       GPIOD_OUT_HIGH);
+	error = PTR_ERR_OR_ZERO(ts->gpiod_rst);
+	if (error) {
+		if (error != -EPROBE_DEFER)
+			dev_err(&ts->client->dev,
+				"Failed to get reset GPIO: %d\n", error);
+		return error;
+	}
+
+	himax_reset(ts);
+
+	error = himax_check_product_id(ts);
+	if (error)
+		return error;
+
+	error = himax_input_register(ts);
+	if (error)
+		return error;
+
+	return devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					 himax_irq_handler, IRQF_ONESHOT,
+					 client->name, ts);
+}
+
+static int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	disable_irq(ts->client->irq);
+	return 0;
+}
+
+static int himax_resume(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	enable_irq(ts->client->irq);
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
+
+static const struct i2c_device_id himax_ts_id[] = {
+	{ "hx83112b", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, himax_ts_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id himax_of_match[] = {
+	{ .compatible = "himax,hx83112b" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, himax_of_match);
+#endif
+
+static struct i2c_driver himax_ts_driver = {
+	.probe = himax_probe,
+	.id_table = himax_ts_id,
+	.driver = {
+		.name = "Himax-hx83112b-TS",
+		.of_match_table = of_match_ptr(himax_of_match),
+		.pm = pm_sleep_ptr(&himax_pm_ops),
+	},
+};
+module_i2c_driver(himax_ts_driver);
+
+MODULE_AUTHOR("Job Noorman <job@noorman.info>");
+MODULE_DESCRIPTION("Himax hx83112b touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.38.0

