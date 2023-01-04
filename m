Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963365D46D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjADNhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbjADNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:36:46 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9F3AF19;
        Wed,  4 Jan 2023 05:34:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so82546613ejm.8;
        Wed, 04 Jan 2023 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMopO2WsrkBqiEuMwNNAMu84VnckfcWrRMZJCRK68yE=;
        b=Z4FDjrXOO7sHjfLUd77H9EjU/ZurHQXGZwD/ITrbA1HidNKHhP6QPKMIv+PdoaN3gi
         bqPJYvaWGJXJaQM3kH3IKkRWaaqec0eekjfprMSmgSrkAMrVht40bhqAttlnziUO6Luq
         HMKxz7oUHre2pOOSjM4sdkV0y8cOLtjO+7vVS9RgDRWmnQer3cTU5aNKC4mGeMJSxOef
         is6kKd08jMaChEkEsN69ex0eJa1miUohy7jw6iS4of9RGlCfrBiBwKgp9T6Qsi4UhW06
         X2p/ySn2exldqBWdxCbXYOISHlAaBCZWM4XZkVpI1fepas2ueW2mY8vEpjwZQQKvvmq4
         +okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMopO2WsrkBqiEuMwNNAMu84VnckfcWrRMZJCRK68yE=;
        b=U/roQcpp00TQQ5/IKhrY3f9h/WR9fp+lQw0Ga9866gl6576+drgo8CC56QT4NXfsGy
         VBKV59HvLtMov7Qtonnla2vKdxPDb7NRsMuYXxXDyBgwWq2RDHVIq6tx1CbBECaGww+3
         PQKrHhxlRcQI8SAJTIHI5iNzVJOQdjAUevYxRI2aII/ayj9KVGV97hKErQ86rtB6sXSZ
         COq/MD5RDoy3bvv0xSqtXIWUVDjtv/Ubk61GTVoPZiIgPz91ntfbiiTPDkrYe65VxgWf
         jad0iCMFAO1Q1zjf1BYuQrrEuw+mcKsWDVVEt8TWil6cZScBQoTuQhI3HOen/aL0zr4j
         m/Gg==
X-Gm-Message-State: AFqh2kqeE7H/LClyV8wIzgLt9Xup7jozAUL4eu8Wkfzp/hO6cWcrtJMJ
        yw/EqygPdHPKe/w1SjPhyAWfB0DsflxvSw==
X-Google-Smtp-Source: AMrXdXvP4HyUq3APhFYUyKKEjHzdqKsKa62dYEXO+od9WrXOKz37oTJ57DdNCNrcNmoH9E1mELedkg==
X-Received: by 2002:a17:907:8b89:b0:7c1:6f86:eeb with SMTP id tb9-20020a1709078b8900b007c16f860eebmr37521210ejc.7.1672839277012;
        Wed, 04 Jan 2023 05:34:37 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id sb20-20020a170906edd400b0073dbaeb50f6sm15211659ejb.169.2023.01.04.05.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:34:36 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCH 3/3] wiegand: add Wiegand GPIO bit-banged controller driver
Date:   Wed,  4 Jan 2023 14:34:14 +0100
Message-Id: <20230104133414.39305-4-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104133414.39305-1-m.zatovic1@gmail.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This controller formats the data to a Wiegand format - appends
checksum if one of the defined formats is used - and bit-bangs
the message on devicetree defined GPIO lines.

Several attributes need to be defined in the devicetree in order
for this driver to work, namely the data-hi-gpios, data-lo-gpios,
pulse-len, frame-gap and interval-len. These attributes are
documented in the devicetree binding documentation file.

The driver creates a dev file for writing messages on the bus.
It also creates two sysfs files to control the format and payload
length of messages. Defined formats are 26, 36 and 37-bit, meaning
the payloads for these formats are 24, 34 and 35 bit respectively,
as two bits are allocated for checksum. A custom format is also
supported and it is set by writing 0 to the format sysfs file.
Custom format does not calculate and append checksum to messages -
they are bit-banged as inputted.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../ABI/testing/sysfs-driver-wiegand-gpio     |  17 +
 MAINTAINERS                                   |   2 +
 drivers/Kconfig                               |   2 +
 drivers/wiegand/Kconfig                       |   8 +
 drivers/wiegand/Makefile                      |   1 +
 drivers/wiegand/wiegand-gpio.c                | 471 ++++++++++++++++++
 6 files changed, 501 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand-gpio.c

diff --git a/Documentation/ABI/testing/sysfs-driver-wiegand-gpio b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
new file mode 100644
index 000000000000..7d651ecc0f9f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
@@ -0,0 +1,17 @@
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/format
+Date:		January 2023
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:
+		Read/set Wiegand communication format.
+		0 - custom format, payload length is specified by
+		payload_len file
+		26 - 26-bit format (24 bit payload, 2 bits checksum)
+		36 - 36-bit format (34 bit payload, 2 bits checksum)
+		37 - 37-bit format (35 bit payload, 2 bits checksum)
+
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
+Date:		January 2023
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:
+		Read/set Wiegand communication payload length. File is only
+		writable if custom format is set.
diff --git a/MAINTAINERS b/MAINTAINERS
index b6e68e92f0e3..c86d53d86f9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22431,8 +22431,10 @@ F:	drivers/hid/hid-wiimote*
 WIEGAND BUS DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 F:	drivers/bus/wiegand.c
+F:	drivers/wiegand/wiegand-gpio.c
 F:	include/linux/wiegand.h
 
 WILOCITY WIL6210 WIRELESS DRIVER
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 968bd0a6fd78..bedc5a9fecba 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -67,6 +67,8 @@ source "drivers/spi/Kconfig"
 
 source "drivers/spmi/Kconfig"
 
+source "drivers/wiegand/Kconfig"
+
 source "drivers/hsi/Kconfig"
 
 source "drivers/pps/Kconfig"
diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
new file mode 100644
index 000000000000..769809bfe650
--- /dev/null
+++ b/drivers/wiegand/Kconfig
@@ -0,0 +1,8 @@
+if WIEGAND
+
+config WIEGAND_GPIO
+        tristate "GPIO-based wiegand master (write only)"
+        help
+	  This driver uses GPIO pins to send wiegand data.
+
+endif # WIEGAND
diff --git a/drivers/wiegand/Makefile b/drivers/wiegand/Makefile
new file mode 100644
index 000000000000..da550876c408
--- /dev/null
+++ b/drivers/wiegand/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_WIEGAND_GPIO)		+= wiegand-gpio.o
diff --git a/drivers/wiegand/wiegand-gpio.c b/drivers/wiegand/wiegand-gpio.c
new file mode 100644
index 000000000000..b00383ec741e
--- /dev/null
+++ b/drivers/wiegand/wiegand-gpio.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/wiegand.h>
+
+#define WIEGAND_MAX_PAYLEN_BYTES 256
+
+struct wiegand_gpio {
+	struct device *dev;
+	struct wiegand_controller *ctlr;
+	struct miscdevice misc_dev;
+	struct mutex mutex;
+	struct gpio_desc *gpio_data_hi;
+	struct gpio_desc *gpio_data_lo;
+	struct file_operations fops;
+	u8 data[WIEGAND_MAX_PAYLEN_BYTES];
+};
+
+struct wiegand_gpio_instance {
+	struct wiegand_gpio *dev;
+	unsigned long flags;
+};
+
+static ssize_t store_ulong(u32 *val, const char *buf,
+				size_t size, unsigned long max)
+{
+	int rc;
+	u32 new;
+
+	rc = kstrtou32(buf, 0, &new);
+	if (rc)
+		return rc;
+
+	if (max != 0 && new > max)
+		return -EINVAL;
+
+	*val = new;
+	return size;
+}
+
+ssize_t format_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
+							dev->driver_data;
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return sysfs_emit(buf, "%u\n", ctlr->format);
+}
+
+/*
+ * To set a particular format, the number of bits the driver is supposed to
+ * transmit is written to the format sysfs file. For standard formats, the
+ * allowed inputs are 26, 36 and 37. To set a custom format, 0 is passed.
+ */
+ssize_t format_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	int rc;
+	unsigned long new;
+	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
+							dev->driver_data;
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	rc = kstrtoul(buf, 0, &new);
+	if (rc)
+		return rc;
+
+	switch (new) {
+	case 0:
+		ctlr->format = WIEGAND_CUSTOM;
+		break;
+	case 26:
+		ctlr->format = WIEGAND_V26;
+		ctlr->payload_len = WIEGAND_V26_PAYLEN;
+		break;
+	case 36:
+		ctlr->format = WIEGAND_V36;
+		ctlr->payload_len = WIEGAND_V36_PAYLEN;
+		break;
+	case 37:
+		ctlr->format = WIEGAND_V37;
+		ctlr->payload_len = WIEGAND_V37_PAYLEN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+/*
+ * Using a custom format, the payload_len sysfs file configures the size of
+ * messages payload in bits. When one of the standard formats is used, this
+ * file is read-only and contains the size of the message in bits without the
+ * parity bits.
+ */
+ssize_t payload_len_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
+							dev->driver_data;
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return sysfs_emit(buf, "%u\n", ctlr->payload_len);
+}
+
+ssize_t payload_len_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
+							dev->driver_data;
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	/* standard formats use fixed payload size */
+	if (ctlr->format != WIEGAND_CUSTOM)
+		return -EPERM;
+
+	return store_ulong(&(ctlr->payload_len), buf, count,
+					WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+
+DEVICE_ATTR_RW(format);
+DEVICE_ATTR_RW(payload_len);
+
+static struct attribute *wiegand_attrs[] = {
+	&dev_attr_format.attr,
+	&dev_attr_payload_len.attr,
+	NULL,
+};
+
+static struct attribute_group wiegand_group = {
+	.name = "wiegand-gpio-attributes",
+	.attrs = wiegand_attrs,
+};
+
+/*
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low at the same time.
+ */
+void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio,
+				bool value, bool last)
+{
+	u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
+	u32 interval_len = wiegand_gpio->ctlr->interval_len;
+	u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
+	struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi
+				: wiegand_gpio->gpio_data_lo;
+
+	gpiod_set_value_cansleep(gpio, 0);
+	udelay(pulse_len);
+	gpiod_set_value_cansleep(gpio, 1);
+
+	if (last)
+		udelay(frame_gap - pulse_len);
+	else
+		udelay(interval_len - pulse_len);
+}
+
+/* This function is used for writing from file in dev directory */
+static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio)
+{
+	size_t i, bitlen;
+	bool bit_value, is_last_bit;
+	enum wiegand_format format = wiegand_gpio->ctlr->format;
+	u32 payload_len = wiegand_gpio->ctlr->payload_len;
+
+	bitlen = format ? payload_len + 2 : payload_len;
+
+	for (i = 0; i < bitlen; i++) {
+		bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8)))
+									& 0x01);
+		is_last_bit = (i + 1) == bitlen;
+
+		wiegand_gpio_send_bit(wiegand_gpio, bit_value,
+				is_last_bit);
+	}
+
+	return 0;
+}
+
+static unsigned int wiegand_gpio_calc_bytes(unsigned int bits)
+{
+	if (bits % 8 != 0)
+		return (bits / 8) + 1;
+	else
+		return bits / 8;
+}
+
+static unsigned int wiegand_gpio_get_payload_size(
+						unsigned long payload_len_bits,
+						enum wiegand_format fmt)
+{
+	unsigned int rc;
+
+	if (fmt == WIEGAND_CUSTOM)
+		rc = wiegand_gpio_calc_bytes(payload_len_bits);
+	else
+		/* add 2 for parity bits */
+		rc = wiegand_gpio_calc_bytes(payload_len_bits + 2);
+
+	return rc;
+}
+
+static ssize_t wiegand_gpio_get_user_data(
+				struct wiegand_gpio *wiegand_gpio,
+				char __user const *buf, size_t len)
+{
+	size_t rc;
+	size_t num_copy;
+	unsigned char tmp[WIEGAND_MAX_PAYLEN_BYTES];
+	enum wiegand_format format = wiegand_gpio->ctlr->format;
+	u32 payload_len = wiegand_gpio->ctlr->payload_len;
+
+	if (len > WIEGAND_MAX_PAYLEN_BYTES)
+		return -EBADMSG;
+
+	num_copy = wiegand_gpio_get_payload_size(payload_len, format);
+
+	if (format == WIEGAND_CUSTOM) {
+		rc = copy_from_user(&wiegand_gpio->data[0], buf, num_copy);
+		if (rc < 0)
+			return rc;
+	} else {
+		rc = copy_from_user(tmp, buf, num_copy);
+		if (rc < 0)
+			return rc;
+		wiegand_add_parity_to_data(tmp, wiegand_gpio->data, format);
+	}
+	return num_copy;
+}
+
+static int wiegand_gpio_frelease(struct inode *ino, struct file *filp)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio *wiegand_gpio = info->dev;
+
+	mutex_lock(&wiegand_gpio->mutex);
+	info->flags = 0;
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	kfree(info);
+
+	return 0;
+}
+
+static ssize_t wiegand_gpio_fwrite(struct file *filp,
+		char __user const *buf, size_t len, loff_t *offset)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio *wiegand_gpio = info->dev;
+	u32 payload_len = wiegand_gpio->ctlr->payload_len;
+	int rc;
+
+	if (len * 8 < payload_len)
+		return -EBADMSG;
+	if (buf == NULL || len == 0)
+		return -EINVAL;
+
+	rc = wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
+	if (rc < 0)
+		return rc;
+
+	wiegand_gpio_write_by_bits(wiegand_gpio);
+
+	return len;
+}
+
+static int wiegand_gpio_fopen(struct inode *ino, struct file *filp)
+{
+	int rc;
+	struct wiegand_gpio_instance *info;
+	struct wiegand_gpio *wiegand_gpio = container_of(filp->f_op,
+							 struct wiegand_gpio,
+							 fops);
+	mutex_lock(&wiegand_gpio->mutex);
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY ||
+		(filp->f_flags & O_ACCMODE) == O_RDWR) {
+		dev_err(wiegand_gpio->dev, "Device is write only\n");
+		rc = -EIO;
+		goto err;
+	}
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	info->dev = wiegand_gpio;
+	info->flags = filp->f_flags;
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	filp->private_data = info;
+
+	return 0;
+err:
+	mutex_unlock(&wiegand_gpio->mutex);
+	return rc;
+}
+
+size_t get_bytelength(u8 bitlength)
+{
+	size_t bytelength = bitlength / 8;
+
+	if (bitlength % 8)
+		bytelength++;
+	return bytelength;
+}
+
+/* This function is used by device drivers */
+int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message)
+{
+	struct wiegand_controller *ctlr = dev->controller;
+	struct wiegand_gpio *wiegand_gpio =
+				wiegand_master_get_devdata(ctlr);
+	u8 message_bytelength;
+
+	if (ctlr->format) { /* if format is not set to custom */
+		if (ctlr->format == WIEGAND_V26)
+			message_bytelength = 4; /* 4 bytes for 26-bit format */
+		else
+			message_bytelength = 5; /* 5 bytes for 36 and 37-bit */
+	} else {
+		message_bytelength = get_bytelength(ctlr->payload_len);
+	}
+
+	if (ctlr->format == WIEGAND_CUSTOM)
+		memcpy(wiegand_gpio->data, message, message_bytelength);
+	else
+		wiegand_add_parity_to_data(message, wiegand_gpio->data,
+					   dev->controller->format);
+
+	wiegand_gpio_write_by_bits(wiegand_gpio);
+
+	return 0;
+}
+
+static int wiegand_gpio_request(struct device *dev,
+				struct wiegand_gpio *wiegand_gpio)
+{
+	/* Get GPIO lines using device tree bindings. */
+	wiegand_gpio->gpio_data_lo = devm_gpiod_get(dev, "data-lo",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand_gpio->gpio_data_lo))
+		return PTR_ERR(wiegand_gpio->gpio_data_lo);
+
+	wiegand_gpio->gpio_data_hi = devm_gpiod_get(dev, "data-hi",
+						    GPIOD_OUT_HIGH);
+	return PTR_ERR_OR_ZERO(wiegand_gpio->gpio_data_hi);
+}
+
+static int wiegand_gpio_probe(struct platform_device *device)
+{
+	int status;
+	struct wiegand_controller *master;
+	struct wiegand_gpio *wiegand_gpio;
+	struct device *dev = &device->dev;
+
+	master = devm_wiegand_alloc_master(dev, sizeof(*wiegand_gpio));
+	if (!master)
+		return -ENOMEM;
+
+	if (dev->of_node)
+		master->dev.of_node = device->dev.of_node;
+
+	if (status)
+		return status;
+
+	master->transfer_message = &wiegand_gpio_transfer_message;
+
+	wiegand_gpio = wiegand_master_get_devdata(master);
+	wiegand_gpio->ctlr = master;
+	wiegand_gpio->fops.owner = THIS_MODULE;
+	wiegand_gpio->fops.open = wiegand_gpio_fopen;
+	wiegand_gpio->fops.release = wiegand_gpio_frelease;
+	wiegand_gpio->fops.write = wiegand_gpio_fwrite;
+
+	platform_set_drvdata(device, wiegand_gpio);
+
+	master->bus_num = device->id;
+	wiegand_gpio->dev = dev;
+
+	mutex_init(&wiegand_gpio->mutex);
+
+	status = wiegand_gpio_request(dev, wiegand_gpio);
+	if (status) {
+		dev_err(wiegand_gpio->dev, "failed at requesting GPIOs\n");
+		return status;
+	}
+
+	status = gpiod_direction_output(wiegand_gpio->gpio_data_hi, 1);
+	status |= gpiod_direction_output(wiegand_gpio->gpio_data_lo, 1);
+	if (status) {
+		dev_err(wiegand_gpio->dev, "failed to set GPIOs direction\n");
+		return status;
+	}
+
+	status = sysfs_create_group(&wiegand_gpio->dev->kobj, &wiegand_group);
+	if (status < 0) {
+		dev_err(wiegand_gpio->dev, "couldn't register sysfs group\n");
+		return status;
+	}
+
+	status = devm_wiegand_register_master(dev, master);
+	if (status) {
+		dev_err(wiegand_gpio->dev, "failed to register master\n");
+		goto free_misc_group;
+	}
+
+	// set 26-bit format as default
+	wiegand_ctlr_set_format_and_paylen(master, WIEGAND_V26,
+						WIEGAND_V26_PAYLEN);
+
+	wiegand_gpio->misc_dev.name = kasprintf(GFP_KERNEL, "wiegand-gpio%u",
+							master->bus_num);
+	wiegand_gpio->misc_dev.minor = MISC_DYNAMIC_MINOR;
+	wiegand_gpio->misc_dev.fops = &wiegand_gpio->fops;
+
+	status = misc_register(&wiegand_gpio->misc_dev);
+	if (status) {
+		dev_err(wiegand_gpio->dev, "couldn't register misc device\n");
+		goto free_misc_group;
+	}
+	wiegand_gpio->misc_dev.parent = wiegand_gpio->dev;
+
+	return status;
+
+free_misc_group:
+	sysfs_remove_group(&wiegand_gpio->dev->kobj, &wiegand_group);
+	return status;
+}
+
+static int wiegand_gpio_remove(struct platform_device *device)
+{
+	struct wiegand_gpio *wiegand_gpio = platform_get_drvdata(device);
+
+	sysfs_remove_group(&wiegand_gpio->dev->kobj, &wiegand_group);
+	misc_deregister(&wiegand_gpio->misc_dev);
+
+	return 0;
+}
+
+static const struct of_device_id wiegand_gpio_dt_idtable[] = {
+	{ .compatible = "wiegand-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
+
+static struct platform_driver wiegand_gpio_driver = {
+	.driver = {
+		.name	= "wiegand-gpio",
+		.of_match_table = wiegand_gpio_dt_idtable,
+	},
+	.probe		= wiegand_gpio_probe,
+	.remove		= wiegand_gpio_remove,
+};
+
+module_platform_driver(wiegand_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
-- 
2.38.1

