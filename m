Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B235FBB23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJKTI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJKTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:08:49 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC01915FD;
        Tue, 11 Oct 2022 12:08:41 -0700 (PDT)
Date:   Tue, 11 Oct 2022 19:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=protonmail3; t=1665515305; x=1665774505;
        bh=3hJxjePHfl0VF40mQXfkPfP04gOpKMmt7oaANzIhoQs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=YnzBwpUWMsDlkVzCAaaXLXoZRjwEWCUQedJ23ecTmLUuLPEQOLdKSOWlEKviwDU2E
         fIe98aO+WgwygNyqnxGqJCCYTEhurjUnRYNL+ufRm3i9ucqHbPaOzb8N/elmgL5e2T
         88XjMbrDXmUB6TfHGdwiqA9IfYk7HUwd4uSRLRCURtYt/Sl0ZwLRh48Eap+io74wTm
         BV8Yp3+zhcMYjaKZb4S19KedBZwewMKB0sGfLRZXkg+Q464AzllJaPpNDqRCrA1LoO
         S3uThStkUGN5GX51ijz7X6V8HAbE6R80/7JnCbLjaVAEUqDJotXtOUALW4i3MkrIIv
         gm3uYQLHWhOrw==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
From:   Job Noorman <job@noorman.info>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 2/3] Input: add driver for Himax hx83112b touchscreen devices
Message-ID: <20221011190729.14747-3-job@noorman.info>
In-Reply-To: <20221011190729.14747-1-job@noorman.info>
References: <20221011190729.14747-1-job@noorman.info>
Feedback-ID: 14439221:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/input/touchscreen/himax_hx83112b.c | 376 +++++++++++++++++++++
 4 files changed, 389 insertions(+)
 create mode 100644 drivers/input/touchscreen/himax_hx83112b.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2418bffe9187..51a03f9586f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9099,6 +9099,7 @@ M:=09Job Noorman <job@noorman.info>
 L:=09linux-input@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.ya=
ml
+F:=09drivers/input/touchscreen/himax_hx83112b.c

 HIPPI
 M:=09Jes Sorensen <jes@trained-monkey.org>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index dc90a3ea51ee..fd710fd8cd53 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1379,4 +1379,15 @@ config TOUCHSCREEN_ZINITIX
 =09  To compile this driver as a module, choose M here: the
 =09  module will be called zinitix.

+config TOUCHSCREEN_HIMAX_HX83112B
+=09tristate "Himax hx83112b touchscreen driver"
+=09depends on I2C
+=09help
+=09  Say Y here to enable support for Himax hx83112b touchscreens.
+
+=09  If unsure, say N.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called himax_hx83112b.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index 557f84fd2075..0f8bf79e01fe 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -116,3 +116,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)=09+=3D rohm_bu21=
023.o
 obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)=09+=3D raspberrypi-ts.o
 obj-$(CONFIG_TOUCHSCREEN_IQS5XX)=09+=3D iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)=09+=3D zinitix.o
+obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)=09+=3D himax_hx83112b.o
diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/tou=
chscreen/himax_hx83112b.c
new file mode 100644
index 000000000000..04494bf1eb2d
--- /dev/null
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Himax hx83112b touchscreens
+ *
+ * Copyright (C) 2022 Job Noorman <job@noorman.info>
+ *
+ * This code is based on "Himax Android Driver Sample Code for QCT platfor=
m":
+ *
+ * Copyright (C) 2017 Himax Corporation.
+ */
+
+#include <asm/byteorder.h>
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
+#define HIMAX_REG_CFG_SET_ADDR 0x00
+#define HIMAX_REG_CFG_INIT_READ 0x0c
+#define HIMAX_REG_CFG_READ_VALUE 0x08
+#define HIMAX_REG_READ_EVENT 0x30
+
+#define HIMAX_CFG_PRODUCT_ID 0x900000d0
+
+struct himax_event_point {
+=09__be16 x;
+=09__be16 y;
+} __packed;
+
+struct himax_event {
+=09struct himax_event_point points[HIMAX_MAX_POINTS];
+=09u8 majors[HIMAX_MAX_POINTS];
+=09u8 pad0[2];
+=09u8 num_points;
+=09u8 pad1[2];
+=09u8 checksum_fix;
+} __packed;
+
+static_assert(sizeof(struct himax_event) =3D=3D 56);
+
+struct himax_ts_data {
+=09struct gpio_desc *gpiod_rst;
+=09struct input_dev *input_dev;
+=09struct i2c_client *client;
+=09struct regmap *regmap;
+=09struct touchscreen_properties props;
+};
+
+static const struct regmap_config himax_regmap_config =3D {
+=09.reg_bits =3D 8,
+=09.val_bits =3D 32,
+=09.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
+};
+
+static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *d=
st)
+{
+=09int error =3D 0;
+
+=09error =3D regmap_write(ts->regmap, HIMAX_REG_CFG_SET_ADDR, address);
+=09if (error)
+=09=09return error;
+
+=09error =3D regmap_write(ts->regmap, HIMAX_REG_CFG_INIT_READ, 0x0);
+=09if (error)
+=09=09return error;
+
+=09return regmap_read(ts->regmap, HIMAX_REG_CFG_READ_VALUE, dst);
+}
+
+static int himax_read_input_event(struct himax_ts_data *ts,
+=09=09=09=09  struct himax_event *event)
+{
+=09return regmap_raw_read(ts->regmap, HIMAX_REG_READ_EVENT, event,
+=09=09=09       sizeof(*event));
+}
+
+static void himax_reset(struct himax_ts_data *ts)
+{
+=09gpiod_set_value(ts->gpiod_rst, 1);
+=09msleep(20);
+=09gpiod_set_value(ts->gpiod_rst, 0);
+}
+
+static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id=
)
+{
+=09int error =3D himax_read_config(ts, HIMAX_CFG_PRODUCT_ID, product_id);
+
+=09if (error)
+=09=09return error;
+
+=09*product_id >>=3D 8;
+=09return 0;
+}
+
+static int himax_check_product_id(struct himax_ts_data *ts)
+{
+=09int error;
+=09u32 product_id;
+
+=09error =3D himax_read_product_id(ts, &product_id);
+=09if (error)
+=09=09return error;
+
+=09dev_dbg(&ts->client->dev, "Product id: %x\n", product_id);
+
+=09switch (product_id) {
+=09case HIMAX_ID_83112B:
+=09=09return 0;
+
+=09default:
+=09=09return dev_err_probe(&ts->client->dev, -ENODEV,
+=09=09=09=09     "Unknown product id: %x\n", product_id);
+=09}
+}
+
+static int himax_setup_gpio(struct himax_ts_data *ts)
+{
+=09ts->gpiod_rst =3D
+=09=09devm_gpiod_get(&ts->client->dev, "reset", GPIOD_OUT_HIGH);
+=09if (IS_ERR(ts->gpiod_rst)) {
+=09=09return dev_err_probe(&ts->client->dev, PTR_ERR(ts->gpiod_rst),
+=09=09=09=09     "Failed to get reset GPIO\n");
+=09}
+
+=09return 0;
+}
+
+static int himax_input_register(struct himax_ts_data *ts)
+{
+=09int error;
+
+=09ts->input_dev =3D devm_input_allocate_device(&ts->client->dev);
+=09if (!ts->input_dev) {
+=09=09return dev_err_probe(&ts->client->dev, -ENOMEM,
+=09=09=09=09     "Failed to allocate input device\n");
+=09}
+
+=09ts->input_dev->name =3D "Himax Touchscreen";
+
+=09input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
+=09input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
+=09input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 200, 0, 0);
+=09input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 200, 0, 0);
+
+=09touchscreen_parse_properties(ts->input_dev, true, &ts->props);
+
+=09error =3D input_mt_init_slots(ts->input_dev, HIMAX_MAX_POINTS,
+=09=09=09=09    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+=09if (error) {
+=09=09return dev_err_probe(&ts->client->dev, error,
+=09=09=09=09     "Failed to initialize MT slots");
+=09}
+
+=09error =3D input_register_device(ts->input_dev);
+=09if (error) {
+=09=09return dev_err_probe(&ts->client->dev, error,
+=09=09=09=09     "Failed to register input device");
+=09}
+
+=09return 0;
+}
+
+static u8 himax_event_get_num_points(const struct himax_event *event)
+{
+=09if (event->num_points =3D=3D 0xff)
+=09=09return 0;
+=09else
+=09=09return event->num_points & 0x0f;
+}
+
+static bool himax_event_point_is_valid(const struct himax_event_point *poi=
nt)
+{
+=09return point->x !=3D 0xffff && point->y !=3D 0xffff;
+}
+
+static u16 himax_event_point_get_x(const struct himax_event_point *point)
+{
+=09return be16_to_cpu(point->x);
+}
+
+static u16 himax_event_point_get_y(const struct himax_event_point *point)
+{
+=09return be16_to_cpu(point->y);
+}
+
+static bool himax_process_event_point(struct himax_ts_data *ts,
+=09=09=09=09      const struct himax_event *event,
+=09=09=09=09      int point_index)
+{
+=09const struct himax_event_point *point =3D &event->points[point_index];
+=09u16 x =3D himax_event_point_get_x(point);
+=09u16 y =3D himax_event_point_get_y(point);
+=09u8 w =3D event->majors[point_index];
+
+=09if (!himax_event_point_is_valid(point))
+=09=09return false;
+
+=09input_mt_slot(ts->input_dev, point_index);
+=09input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
+=09touchscreen_report_pos(ts->input_dev, &ts->props, x, y, true);
+=09input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, w);
+=09input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, w);
+=09return true;
+}
+
+static void himax_process_event(struct himax_ts_data *ts,
+=09=09=09=09const struct himax_event *event)
+{
+=09int i;
+=09int num_points_left =3D himax_event_get_num_points(event);
+
+=09for (i =3D 0; i < HIMAX_MAX_POINTS && num_points_left > 0; i++) {
+=09=09if (himax_process_event_point(ts, event, i))
+=09=09=09num_points_left--;
+=09}
+
+=09input_mt_sync_frame(ts->input_dev);
+=09input_sync(ts->input_dev);
+}
+
+static bool himax_verify_checksum(struct himax_ts_data *ts,
+=09=09=09=09  const struct himax_event *event)
+{
+=09u8 *data =3D (u8 *)event;
+=09int i;
+=09u16 checksum =3D 0;
+
+=09for (i =3D 0; i < sizeof(*event); i++)
+=09=09checksum +=3D data[i];
+
+=09if ((checksum & 0x00ff) !=3D 0) {
+=09=09dev_err(&ts->client->dev, "Wrong event checksum: %04x\n",
+=09=09=09checksum);
+=09=09return false;
+=09}
+
+=09return true;
+}
+
+static void himax_handle_input(struct himax_ts_data *ts)
+{
+=09int error;
+=09struct himax_event event;
+
+=09error =3D himax_read_input_event(ts, &event);
+=09if (error) {
+=09=09dev_err(&ts->client->dev, "Failed to read input event: %d\n",
+=09=09=09error);
+=09=09return;
+=09}
+
+=09if (!himax_verify_checksum(ts, &event))
+=09=09return;
+
+=09himax_process_event(ts, &event);
+}
+
+static irqreturn_t himax_irq_handler(int irq, void *dev_id)
+{
+=09struct himax_ts_data *ts =3D dev_id;
+
+=09himax_handle_input(ts);
+=09return IRQ_HANDLED;
+}
+
+static int himax_request_irq(struct himax_ts_data *ts)
+{
+=09struct i2c_client *client =3D ts->client;
+
+=09return devm_request_threaded_irq(&client->dev, client->irq, NULL,
+=09=09=09=09=09 himax_irq_handler, IRQF_ONESHOT,
+=09=09=09=09=09 client->name, ts);
+}
+
+static int himax_probe(struct i2c_client *client,
+=09=09       const struct i2c_device_id *id)
+{
+=09int error;
+=09struct device *dev =3D &client->dev;
+=09struct himax_ts_data *ts;
+
+=09if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+=09=09return dev_err_probe(dev, -ENODEV,
+=09=09=09=09     "I2C check functionality failed\n");
+=09}
+
+=09ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+=09if (!ts)
+=09=09return -ENOMEM;
+
+=09i2c_set_clientdata(client, ts);
+=09ts->client =3D client;
+
+=09ts->regmap =3D devm_regmap_init_i2c(client, &himax_regmap_config);
+=09if (IS_ERR(ts->regmap)) {
+=09=09return dev_err_probe(&client->dev, PTR_ERR(ts->regmap),
+=09=09=09=09     "Failed to initialize regmap");
+=09}
+
+=09error =3D himax_setup_gpio(ts);
+=09if (error)
+=09=09return error;
+
+=09himax_reset(ts);
+
+=09error =3D himax_check_product_id(ts);
+=09if (error)
+=09=09return error;
+
+=09error =3D himax_input_register(ts);
+=09if (error)
+=09=09return error;
+
+=09error =3D himax_request_irq(ts);
+=09if (error)
+=09=09return error;
+
+=09return 0;
+}
+
+static int himax_suspend(struct device *dev)
+{
+=09struct himax_ts_data *ts =3D dev_get_drvdata(dev);
+
+=09disable_irq(ts->client->irq);
+=09return 0;
+}
+
+static int himax_resume(struct device *dev)
+{
+=09struct himax_ts_data *ts =3D dev_get_drvdata(dev);
+
+=09enable_irq(ts->client->irq);
+=09return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
+
+static const struct i2c_device_id himax_ts_id[] =3D {
+=09{ "hx83112b", 0 },
+=09{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i2c, himax_ts_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id himax_of_match[] =3D {
+=09{ .compatible =3D "himax,hx83112b" },
+=09{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, himax_of_match);
+#endif
+
+static struct i2c_driver himax_ts_driver =3D {
+=09.probe =3D himax_probe,
+=09.id_table =3D himax_ts_id,
+=09.driver =3D {
+=09=09.name =3D "Himax-hx83112b-TS",
+=09=09.of_match_table =3D of_match_ptr(himax_of_match),
+=09=09.pm =3D &himax_pm_ops,
+=09},
+};
+module_i2c_driver(himax_ts_driver);
+
+MODULE_AUTHOR("Job Noorman <job@noorman.info>");
+MODULE_DESCRIPTION("Himax hx83112b touchscreen driver");
+MODULE_LICENSE("GPL");
--
2.38.0


