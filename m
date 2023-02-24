Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6736A19FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBXKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjBXKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C3199FD;
        Fri, 24 Feb 2023 02:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A4D4B81C26;
        Fri, 24 Feb 2023 10:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B5AFC4339C;
        Fri, 24 Feb 2023 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677234012;
        bh=VnLtkglp3UnUU9u4EKcAonXEcxfijAMELL6pnB49Dkk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Plt6w6Q9bMzmPgQHO7F71NMIWKyKLVSdK3uUKKBcgVtCn6h1PcYWJEyBhFX9/68jP
         +3SroqslC1qhaDYHLMRC1isroKdHmndd5Rmto75b8Zh1GIPYwhvCxWoqdphKQbU4/N
         4exQVskbT53lav7MTKBmlSd/URvPM6u+9rHDGvwNMUxtg7S70yVmp5Kao4ZV5IIGhp
         BbKJu3MbmNvKjoPmOhlBhzORfpnOio5vnNVJZqLYZQ7Lf6UzDZiF7ge036fDmB5lQo
         HLol677g34TQJFzifLgAsRdtDzBMctOtdEvOy6bkACcaEq0ynXzI0tsA27sRus2KlY
         bhOBPeIzFv15g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA5C6FA8E;
        Fri, 24 Feb 2023 10:20:11 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Fri, 24 Feb 2023 11:20:07 +0100
Subject: [PATCH RFC 2/4] input: apple_z2: Add a driver for Apple Z2
 touchscreens
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-z2-for-ml-v1-2-028f2b85dc15@gmail.com>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
In-Reply-To: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677234010; l=15302;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=hUln/Rf+07RhC5s9pVDOQiCkXm4Scsmq4ZWYYgCjVI8=;
 b=N6rjR8JCTUZWJyPRG9brUdMJYg/ta4f059FWJsyZGzgYnpUSRSSLuuxjneYMtv8HarFP8sten
 hQVPb30ZdsmCMuQtOadB9Q2kLgkcNoniRgnbkQtVFHu1d0naOAuJ3kV
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Adds a driver for Apple touchscreens using the Z2 protocol.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/input/touchscreen/Kconfig    |  13 +
 drivers/input/touchscreen/Makefile   |   1 +
 drivers/input/touchscreen/apple_z2.c | 465 +++++++++++++++++++++++++++++++++++
 3 files changed, 479 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 68d99a112e14..76aeea837ab9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -103,6 +103,19 @@ config TOUCHSCREEN_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called resistive-adc-touch.ko.
 
+config TOUCHSCREEN_APPLE_Z2
+	tristate "Apple Z2 touchscreens"
+	default ARCH_APPLE
+	depends on SPI && INPUT && OF
+	help
+	  Say Y here if you have an Apple device with
+	  a touchscreen or a touchbar.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called apple_z2.
+
 config TOUCHSCREEN_AR1021_I2C
 	tristate "Microchip AR1020/1021 i2c touchscreen"
 	depends on I2C && OF
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 4968c370479a..d885b2c4e3a6 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADC)		+= resistive-adc-touch.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
+obj-$(CONFIG_TOUCHSCREEN_APPLE_Z2)	+= apple_z2.o
 obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchscreen/apple_z2.c
new file mode 100644
index 000000000000..06f1d864a137
--- /dev/null
+++ b/drivers/input/touchscreen/apple_z2.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple Z2 touchscreen driver
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+
+#define Z2_NUM_FINGERS_OFFSET 16
+#define Z2_FINGERS_OFFSET 24
+#define Z2_TOUCH_STARTED 3
+#define Z2_TOUCH_MOVED 4
+#define Z2_CMD_READ_INTERRUPT_DATA 0xEB
+#define Z2_HBPP_CMD_BLOB 0x3001
+#define Z2_FW_MAGIC 0x5746325A
+#define LOAD_COMMAND_INIT_PAYLOAD 0
+#define LOAD_COMMAND_SEND_BLOB 1
+#define LOAD_COMMAND_SEND_CALIBRATION 2
+
+struct apple_z2 {
+	struct spi_device *spidev;
+	struct gpio_desc *cs_gpio;
+	struct gpio_desc *reset_gpio;
+	struct input_dev *input_dev;
+	struct completion boot_irq;
+	int booted;
+	int counter;
+	int y_size;
+	const char *fw_name;
+	const char *cal_blob;
+	int cal_size;
+};
+
+struct z2_finger {
+	u8 finger;
+	u8 state;
+	__le16 unknown2;
+	__le16 abs_x;
+	__le16 abs_y;
+	__le16 rel_x;
+	__le16 rel_y;
+	__le16 tool_major;
+	__le16 tool_minor;
+	__le16 orientation;
+	__le16 touch_major;
+	__le16 touch_minor;
+	__le16 unused[2];
+	__le16 pressure;
+	__le16 multi;
+} __packed;
+
+struct z2_hbpp_blob_hdr {
+	u16 cmd;
+	u16 len;
+	u32 addr;
+	u16 checksum;
+} __packed;
+
+struct z2_fw_hdr {
+	u32 magic;
+	u32 version;
+} __packed;
+
+struct z2_read_interrupt_cmd {
+	u8 cmd;
+	u8 counter;
+	u8 unused[12];
+	__le16 checksum;
+} __packed;
+
+static void apple_z2_parse_touches(struct apple_z2 *z2, char *msg, size_t msg_len)
+{
+	int i;
+	int nfingers;
+	int slot;
+	int slot_valid;
+	struct z2_finger *fingers;
+
+	if (msg_len <= Z2_NUM_FINGERS_OFFSET)
+		return;
+	nfingers = msg[Z2_NUM_FINGERS_OFFSET];
+	fingers = (struct z2_finger *)(msg + Z2_FINGERS_OFFSET);
+	for (i = 0; i < nfingers; i++) {
+		slot = input_mt_get_slot_by_key(z2->input_dev, fingers[i].finger);
+		if (slot < 0) {
+			dev_warn(&z2->spidev->dev, "unable to get slot for finger");
+			continue;
+		}
+		slot_valid = fingers[i].state == Z2_TOUCH_STARTED ||
+			fingers[i].state == Z2_TOUCH_MOVED;
+		input_mt_slot(z2->input_dev, slot);
+		input_mt_report_slot_state(z2->input_dev, MT_TOOL_FINGER, slot_valid);
+		if (!slot_valid)
+			continue;
+		input_report_abs(z2->input_dev, ABS_MT_POSITION_X,
+				 le16_to_cpu(fingers[i].abs_x));
+		input_report_abs(z2->input_dev, ABS_MT_POSITION_Y,
+				 z2->y_size - le16_to_cpu(fingers[i].abs_y));
+		input_report_abs(z2->input_dev, ABS_MT_WIDTH_MAJOR,
+				 le16_to_cpu(fingers[i].tool_major));
+		input_report_abs(z2->input_dev, ABS_MT_WIDTH_MINOR,
+				 le16_to_cpu(fingers[i].tool_minor));
+		input_report_abs(z2->input_dev, ABS_MT_ORIENTATION,
+				 le16_to_cpu(fingers[i].orientation));
+		input_report_abs(z2->input_dev, ABS_MT_TOUCH_MAJOR,
+				 le16_to_cpu(fingers[i].touch_major));
+		input_report_abs(z2->input_dev, ABS_MT_TOUCH_MINOR,
+				 le16_to_cpu(fingers[i].touch_minor));
+	}
+	input_mt_sync_frame(z2->input_dev);
+	input_sync(z2->input_dev);
+}
+
+static int apple_z2_spi_sync(struct apple_z2 *z2, struct spi_message *msg)
+{
+	int err;
+	gpiod_direction_output(z2->cs_gpio, 0);
+	usleep_range(1000, 2000);
+	err = spi_sync(z2->spidev, msg);
+	usleep_range(1000, 2000);
+	gpiod_direction_output(z2->cs_gpio, 1);
+	return err;
+}
+
+static int apple_z2_read_packet(struct apple_z2 *z2)
+{
+	struct spi_message msg;
+	struct spi_transfer xfer;
+	struct z2_read_interrupt_cmd len_cmd;
+	char len_rx[16];
+	size_t pkt_len;
+	char *pkt_rx;
+	int err = 0;
+
+	spi_message_init(&msg);
+	memset(&xfer, 0, sizeof(xfer));
+	memset(&len_cmd, 0, sizeof(len_cmd));
+	len_cmd.cmd = Z2_CMD_READ_INTERRUPT_DATA;
+	len_cmd.counter = z2->counter + 1;
+	len_cmd.checksum = cpu_to_le16(Z2_CMD_READ_INTERRUPT_DATA + 1 + z2->counter);
+	z2->counter = 1 - z2->counter;
+	xfer.tx_buf = &len_cmd;
+	xfer.rx_buf = len_rx;
+	xfer.len = sizeof(len_cmd);
+	spi_message_add_tail(&xfer, &msg);
+	err = apple_z2_spi_sync(z2, &msg);
+	if (err)
+		return err;
+
+	pkt_len = ((len_rx[1] | len_rx[2] << 8) + 8) & (-4);
+	pkt_rx = kzalloc(pkt_len, GFP_KERNEL);
+	if (!pkt_rx)
+		return -ENOMEM;
+
+	spi_message_init(&msg);
+	xfer.rx_buf = pkt_rx;
+	xfer.len = pkt_len;
+	spi_message_add_tail(&xfer, &msg);
+	err = apple_z2_spi_sync(z2, &msg);
+
+	if (!err)
+		apple_z2_parse_touches(z2, pkt_rx + 5, pkt_len - 5);
+
+	kfree(pkt_rx);
+	return err;
+}
+
+static irqreturn_t apple_z2_irq(int irq, void *data)
+{
+	struct spi_device *spi = data;
+	struct apple_z2 *z2 = spi_get_drvdata(spi);
+
+	if (!z2->booted)
+		complete(&z2->boot_irq);
+	else
+		apple_z2_read_packet(z2);
+
+	return IRQ_HANDLED;
+}
+
+
+// Return value must be freed with kfree
+static char *apple_z2_build_cal_blob(struct apple_z2 *z2, u32 address, u32 *size)
+{
+	u16 len_words = (z2->cal_size + 3) / 4;
+	u32 checksum = 0;
+	u16 checksum_hdr = 0;
+	char *data;
+	int i;
+	struct z2_hbpp_blob_hdr *hdr;
+
+	*size = z2->cal_size + sizeof(struct z2_hbpp_blob_hdr) + 4;
+
+	data = kzalloc(*size, GFP_KERNEL);
+	hdr = (struct z2_hbpp_blob_hdr *)data;
+	hdr->cmd = Z2_HBPP_CMD_BLOB;
+	hdr->len = len_words;
+	hdr->addr = address;
+
+	for (i = 2; i < 8; i++)
+		checksum_hdr += data[i];
+
+	hdr->checksum = checksum_hdr;
+	memcpy(data + 10, z2->cal_blob, z2->cal_size);
+
+	for (i = 0; i < z2->cal_size; i++)
+		checksum += z2->cal_blob[i];
+
+	*(u32 *)(data + z2->cal_size + 10) = checksum;
+
+	return data;
+}
+
+static int apple_z2_send_firmware_blob(struct apple_z2 *z2, const char *data, u32 size, u8 bpw)
+{
+	struct spi_message msg;
+	struct spi_transfer blob_xfer, ack_xfer;
+	char int_ack[] = {0x1a, 0xa1};
+	char ack_rsp[] = {0, 0};
+	int err;
+
+	spi_message_init(&msg);
+	memset(&blob_xfer, 0, sizeof(blob_xfer));
+	memset(&ack_xfer, 0, sizeof(ack_xfer));
+	blob_xfer.tx_buf = data;
+	blob_xfer.len = size;
+	blob_xfer.bits_per_word = bpw;
+	spi_message_add_tail(&blob_xfer, &msg);
+	ack_xfer.tx_buf = int_ack;
+	ack_xfer.rx_buf = ack_rsp;
+	ack_xfer.len = 2;
+	spi_message_add_tail(&ack_xfer, &msg);
+	reinit_completion(&z2->boot_irq);
+	err = apple_z2_spi_sync(z2, &msg);
+	if (err)
+		return err;
+	wait_for_completion_timeout(&z2->boot_irq, msecs_to_jiffies(20));
+	return 0;
+}
+
+static int apple_z2_upload_firmware(struct apple_z2 *z2)
+{
+	const struct firmware *fw;
+	struct z2_fw_hdr *fw_hdr;
+	size_t fw_idx = sizeof(struct z2_fw_hdr);
+	int err;
+	u32 load_cmd;
+	u32 size;
+	u32 address;
+	char *data;
+
+	err = request_firmware(&fw, z2->fw_name, &z2->spidev->dev);
+	if (err)
+		return dev_err_probe(&z2->spidev->dev, err, "unable to load firmware");
+
+	fw_hdr = (struct z2_fw_hdr *)fw->data;
+	if (fw_hdr->magic != Z2_FW_MAGIC || fw_hdr->version != 1)
+		return dev_err_probe(&z2->spidev->dev, -EINVAL, "invalid firmware header");
+
+	while (fw_idx < fw->size) {
+		if (fw->size - fw_idx < 8) {
+			err = dev_err_probe(&z2->spidev->dev, -EINVAL, "firmware malformed");
+			goto error;
+		}
+
+		load_cmd = *(u32 *)(fw->data + fw_idx);
+		fw_idx += 4;
+		if (load_cmd == LOAD_COMMAND_INIT_PAYLOAD || load_cmd == LOAD_COMMAND_SEND_BLOB) {
+			size = *(u32 *)(fw->data + fw_idx);
+			fw_idx += 4;
+			if (fw->size - fw_idx < size) {
+				err = dev_err_probe(&z2->spidev->dev,
+						     -EINVAL, "firmware malformed");
+				goto error;
+			}
+			err = apple_z2_send_firmware_blob(z2, fw->data + fw_idx,
+							  size, load_cmd == LOAD_COMMAND_SEND_BLOB ? 16 : 8);
+			if (err)
+				goto error;
+			fw_idx += size;
+		} else if (load_cmd == 2) {
+			address = *(u32 *)(fw->data + fw_idx);
+			fw_idx += 4;
+			data = apple_z2_build_cal_blob(z2, address, &size);
+			err = apple_z2_send_firmware_blob(z2, data, size, 16);
+			kfree(data);
+			if (err)
+				goto error;
+		} else {
+			err = dev_err_probe(&z2->spidev->dev, -EINVAL, "firmware malformed");
+			goto error;
+		}
+		if (fw_idx % 4 != 0)
+			fw_idx += 4 - (fw_idx % 4);
+	}
+
+
+	z2->booted = 1;
+	apple_z2_read_packet(z2);
+ error:
+	release_firmware(fw);
+	return err;
+}
+
+static int apple_z2_boot(struct apple_z2 *z2)
+{
+	int err;
+	enable_irq(z2->spidev->irq);
+	gpiod_direction_output(z2->reset_gpio, 1);
+	wait_for_completion_timeout(&z2->boot_irq, msecs_to_jiffies(20));
+	err = apple_z2_upload_firmware(z2);
+	if (err) { // Boot failed, let's put the device into reset just in case.
+		gpiod_direction_output(z2->reset_gpio, 0);
+		disable_irq(z2->spidev->irq);
+	}
+	return err;
+}
+
+static int apple_z2_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct apple_z2 *z2;
+	int err;
+	int x_size;
+	const char *device_name;
+
+	z2 = devm_kzalloc(dev, sizeof(*z2), GFP_KERNEL);
+	if (!z2)
+		return -ENOMEM;
+
+	z2->spidev = spi;
+	init_completion(&z2->boot_irq);
+	spi_set_drvdata(spi, z2);
+
+	z2->cs_gpio = devm_gpiod_get_index(dev, "cs", 0, 0);
+	if (IS_ERR(z2->cs_gpio))
+		return dev_err_probe(dev, PTR_ERR(z2->cs_gpio), "unable to get cs");
+
+	z2->reset_gpio = devm_gpiod_get_index(dev, "reset", 0, 0);
+	if (IS_ERR(z2->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(z2->reset_gpio), "unable to get reset");
+
+	err = devm_request_threaded_irq(dev, z2->spidev->irq, NULL,
+					apple_z2_irq, IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					"apple-z2-irq", spi);
+	if (err < 0)
+		return dev_err_probe(dev, z2->spidev->irq, "unable to request irq");
+
+	err = device_property_read_u32(dev, "touchscreen-size-x", &x_size);
+	if (err)
+		return dev_err_probe(dev, err, "unable to get touchscreen size");
+
+	err = device_property_read_u32(dev, "touchscreen-size-y", &z2->y_size);
+	if (err)
+		return dev_err_probe(dev, err, "unable to get touchscreen size");
+
+	err = device_property_read_string(dev, "apple,z2-device-name", &device_name);
+	if (err)
+		return dev_err_probe(dev, err, "unable to get device name");
+
+	err = device_property_read_string(dev, "firmware-name", &z2->fw_name);
+	if (err)
+		return dev_err_probe(dev, err, "unable to get firmware name");
+
+	z2->cal_blob = of_get_property(dev->of_node, "apple,z2-cal-blob", &z2->cal_size);
+	if (!z2->cal_blob)
+		return dev_err_probe(dev, -EINVAL, "unable to get calibration");
+
+	z2->input_dev = devm_input_allocate_device(dev);
+	if (!z2->input_dev)
+		return -ENOMEM;
+	z2->input_dev->name = device_name;
+	z2->input_dev->phys = "apple_z2";
+	z2->input_dev->dev.parent = dev;
+	z2->input_dev->id.bustype = BUS_SPI;
+	input_set_abs_params(z2->input_dev, ABS_MT_POSITION_X, 0, x_size, 0, 0);
+	input_abs_set_res(z2->input_dev, ABS_MT_POSITION_X, 1);
+	input_set_abs_params(z2->input_dev, ABS_MT_POSITION_Y, 0, z2->y_size, 0, 0);
+	input_abs_set_res(z2->input_dev, ABS_MT_POSITION_Y, 1);
+	input_set_abs_params(z2->input_dev, ABS_MT_WIDTH_MAJOR, 0, 65535, 0, 0);
+	input_set_abs_params(z2->input_dev, ABS_MT_WIDTH_MINOR, 0, 65535, 0, 0);
+	input_set_abs_params(z2->input_dev, ABS_MT_TOUCH_MAJOR, 0, 65535, 0, 0);
+	input_set_abs_params(z2->input_dev, ABS_MT_TOUCH_MINOR, 0, 65535, 0, 0);
+	input_set_abs_params(z2->input_dev, ABS_MT_ORIENTATION, -32768, 32767, 0, 0);
+	input_mt_init_slots(z2->input_dev, 256, INPUT_MT_DIRECT);
+
+	err = input_register_device(z2->input_dev);
+	if (err < 0)
+		return dev_err_probe(dev, err, "unable to register input device");
+
+
+	// Reset the device on probe
+	gpiod_direction_output(z2->reset_gpio, 0);
+	usleep_range(5000, 10000);
+	return apple_z2_boot(z2);
+}
+
+static void apple_z2_remove(struct spi_device *spi)
+{
+	struct apple_z2 *z2 = spi_get_drvdata(spi);
+
+	disable_irq(z2->spidev->irq);
+	gpiod_direction_output(z2->reset_gpio, 0);
+}
+
+static void apple_z2_shutdown(struct spi_device *spi)
+{
+	struct apple_z2 *z2 = spi_get_drvdata(spi);
+
+	disable_irq(z2->spidev->irq);
+	gpiod_direction_output(z2->reset_gpio, 0);
+}
+
+static int apple_z2_suspend(struct device *dev)
+{
+	apple_z2_shutdown(to_spi_device(dev));
+	return 0;
+}
+
+static int apple_z2_resume(struct device *dev)
+{
+	struct apple_z2 *z2 = spi_get_drvdata(to_spi_device(dev));
+
+	return apple_z2_boot(z2);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(apple_z2_pm, apple_z2_suspend, apple_z2_resume);
+
+static const struct of_device_id apple_z2_of_match[] = {
+	{ .compatible = "apple,z2-touchscreen" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, apple_z2_of_match);
+
+static struct spi_device_id apple_z2_of_id[] = {
+	{ .name = "z2-touchscreen" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, apple_z2_of_id);
+
+static struct spi_driver apple_z2_driver = {
+	.driver = {
+		.name	= "apple-z2",
+		.pm	= pm_sleep_ptr(&apple_z2_pm),
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(apple_z2_of_match),
+	},
+
+	.id_table       = apple_z2_of_id,
+	.probe		= apple_z2_probe,
+	.remove		= apple_z2_remove,
+	.shutdown	= apple_z2_shutdown,
+};
+
+module_spi_driver(apple_z2_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("apple/mtfw-*.bin");

-- 
Git-137.1)

