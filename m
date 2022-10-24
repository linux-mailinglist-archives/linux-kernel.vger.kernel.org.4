Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49360B493
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJXRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiJXRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:51:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C119175797;
        Mon, 24 Oct 2022 09:28:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so12272565edc.9;
        Mon, 24 Oct 2022 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuuxhzs/aIhIqoMyyHUJsNskai4TPJcigxLTHW2Ibj0=;
        b=QR6kv6mN5/KcKDRd1q5RnMA8dJQn7mxgxHa/5u4UnlmnDNF6rr/SavzOjuFg/KZvT0
         6h1Xq+IU93rC+IqPe0QNdvq9ZthjdyaQ0iwDgaXillVY+0hiPaZylhexWK8qpPeHuqTV
         dG2gr2+tZ+KGBTKAPhZDWmkXKIeVkPoenlKL2TaAfgqggB7LUaFHMx1opI0kCdKPSg0I
         pFMTjqL5WDMuTz5LFsuXOib5kDczTsq1aRcrlU9pkKErKAdWc/9XqP3AK9KgBVvJRqZc
         Ws9Rko+NdnZnqHEmKJtYHWiOx5Ag3RYmgbGGa+UGUOUF1mL+iHIFdpu5Lm9TspQTtKPu
         PW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wuuxhzs/aIhIqoMyyHUJsNskai4TPJcigxLTHW2Ibj0=;
        b=jw3sxp/Zn9x5IjNBTWncZ5Yrzw2GyA1HUTdLOkJrw907Axmo1AUa4aGkcu7kDwtA/W
         Bysr9p+fQO8PHUjfK96ZY+yAPw+tsyqB7HkCb5+Fsq1ZxTHUSsyzIXVWmwlARSiOE6r3
         a70uhkzif/p+Tu+856rpsVB0mZCRR5yoONzvzzA6QVMRCMapGwgYI6256wk1Tvpf58B1
         4j6VAhGLcvaxeZ/niyANl/pz+jxRHv8p7PfkZovVnRpIgtNlEVZN+a7hPeLqclJaU+Fx
         S7+wMuP1eR+P4X040rtuFpNQtr3YL/sZhHFhTEo0NmbHMPk4UO4C56eB3XMUxGKrrGUc
         W6wg==
X-Gm-Message-State: ACrzQf0NWD8nDVF0J2CAdFjEb2DaYkZH3gejjwjiK7JMqZWKjCPuaciG
        vpHBlolpn+kiQzP3rGc9K9U=
X-Google-Smtp-Source: AMsMyM7VE7WjNaTz8DekLp5+mDOEGdFC+JUFiCbLuvpZfhacSDPo4xBMHGJKx0LyCNRa42m+Y1NTHQ==
X-Received: by 2002:a05:6402:1d4a:b0:461:d375:7927 with SMTP id dz10-20020a0564021d4a00b00461d3757927mr4351796edb.18.1666628822842;
        Mon, 24 Oct 2022 09:27:02 -0700 (PDT)
Received: from 1974459598.wifi.kn.vutbr.cz (nat-kn.net.vutbr.cz. [147.229.117.40])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709064d4e00b0078dd4c89781sm108186ejv.35.2022.10.24.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:27:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, jeffrey.l.hugo@gmail.com,
        Michael.Srba@seznam.cz, gregkh@linuxfoundation.org,
        elder@linaro.org, hemantk@codeaurora.org, mani@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv3 PATCH 2/2] bus: add bit banged Wiegand bus driver
Date:   Mon, 24 Oct 2022 18:26:50 +0200
Message-Id: <20221024162650.36587-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024162650.36587-1-m.zatovic1@gmail.com>
References: <20221024162650.36587-1-m.zatovic1@gmail.com>
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

This patch adds a bit banged Wiegand bus driver. The communication
is realized over two GPIO lines defined in the devicetree.
The parameters specific for the bus such as the pulse duration
are also configured in the devicetree, while format and payload
length of messages are configured via sysfs files. The driver
currently supports 4 formats - 26, 36 and 37-bit and a custom
length format. The 26, 36 and 37-bit formats automatically
append the checksum as specified in the Wiegand protocol.
It is up to the user to append or discard the checksum bits
using the custom format. A user can use this driver to write
directly to the bus using a device file. Drivers for devices
communicating via Wiegand can utilize the API functions to
write on the bus or set a message format.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-wiegand |  20 +
 MAINTAINERS                                 |   8 +
 drivers/bus/Kconfig                         |   7 +
 drivers/bus/Makefile                        |   1 +
 drivers/bus/wiegand.c                       | 509 ++++++++++++++++++++
 include/linux/wiegand.h                     |  58 +++
 6 files changed, 603 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wiegand
 create mode 100644 drivers/bus/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/Documentation/ABI/testing/sysfs-bus-wiegand b/Documentation/ABI/testing/sysfs-bus-wiegand
new file mode 100644
index 000000000000..1f989e360d53
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-wiegand
@@ -0,0 +1,20 @@
+What:		/sys/devices/platform/.../wiegand-attributes/format
+Date:		October 2022
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:    Sets a format of Wiegand communication. Currently supported
+        formats are 26, 36 and 37 bits. These formats automatically add
+        checksums to the first and last bits of a message. To set a custom
+        format, 0 needs to be written here. Custom format writes an amount of
+        bits defined by payload_len(see below) and it does not add checksums so
+        the user is responsible for that.
+Users:		any user space application which wants to communicate using Wiegand
+
+What:		/sys/devices/platform/.../wiegand-attributes/payload_len
+Date:		October 2022
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:    Depends on format attribute - using one of the standard formats
+        the payload_len attribute file becomes read-only and it contains the
+        number of bits of a message without the checksum bits(e.g. 24 for
+        26-bit format). Using a custom format makes this file writable for
+        configuring the Wiegand message length in bits.
+Users:		any user space application which wants to communicate using Wiegand
diff --git a/MAINTAINERS b/MAINTAINERS
index ca063a504026..30aadc8e664d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22138,6 +22138,14 @@ L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-sd3078.c

+WIEGAND BUS DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-wiegand
+F:	Documentation/devicetree/bindings/bus/wiegand.yaml
+F:	drivers/bus/wiegand.c
+F:	include/linux/wiegand.h
+
 WIIMOTE HID DRIVER
 M:	David Rheinsberg <david.rheinsberg@gmail.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..1b7dd3dcad72 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -241,6 +241,13 @@ config VEXPRESS_CONFIG
 	  Platform configuration infrastructure for the ARM Ltd.
 	  Versatile Express.

+config WIEGAND
+      tristate "Wiegand bus via GPIOs"
+      depends on OF_GPIO
+      help
+        Wiegand Protocol is a low level 2-wire serial protocol. This
+        enables the support of the bus.
+
 config DA8XX_MSTPRI
 	bool "TI da8xx master peripheral priority driver"
 	depends on ARCH_DAVINCI_DA8XX
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index d90eed189a65..ed64d1fde1b7 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
+obj-$(CONFIG_WIEGAND)		+= wiegand.o

 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o

diff --git a/drivers/bus/wiegand.c b/drivers/bus/wiegand.c
new file mode 100644
index 000000000000..7de42e9f41eb
--- /dev/null
+++ b/drivers/bus/wiegand.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Wiegand write-only bus driver
+ *
+ * This driver implements a GPIOs bit-banged bus following the Wiegand
+ * protocol. It is used to communicate with various peripherals such as
+ * card readers or fingerprint sensors.
+ */
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
+struct wiegand_device *wiegand_glob;
+struct wiegand_instance *wiegand_instance_glob;
+
+struct wiegand_device {
+	struct device *dev;
+	struct miscdevice *misc_dev;
+	struct mutex mutex;
+	struct gpio_desc *gpio_data_hi;
+	struct gpio_desc *gpio_data_lo;
+	struct wiegand_setup setup;
+	u8 data[WIEGAND_MAX_PAYLEN_BYTES];
+};
+
+struct wiegand_instance {
+	struct wiegand_device *dev;
+	unsigned long flags;
+};
+
+static const struct wiegand_setup WIEGAND_SETUP = {
+	.pulse_len	= 50,
+	.interval_len	= 2000,
+	.frame_gap	= 2000,
+	.format		= WIEGAND_V26,
+	.payload_len	= 24,
+};
+
+int wiegand_calc_parity8(u8 v)
+{
+	v = (v >> 4) ^ (v & ((1 << 4)-1));
+	v = (v >> 2) ^ (v & ((1 << 2)-1));
+	v = (v >> 1) ^ (v & ((1 << 1)-1));
+	return v;
+}
+
+void wiegand_add_parity_to_data(unsigned char *tmp, u8 *data,
+						enum wiegand_format fmt)
+{
+	switch (fmt) {
+	case WIEGAND_V26:
+		data[0] = (tmp[0] >> 1) | (wiegand_calc_parity8(
+						tmp[0] ^ (tmp[1] & 0xf0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (!wiegand_calc_parity8(
+						(tmp[1] & 0x0f) ^ tmp[2]) << 6);
+		break;
+	case WIEGAND_V36:
+		tmp[4] &= 0xc0;
+
+		data[0] = (tmp[0] >> 1) | (wiegand_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0x80)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+			(!wiegand_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 4);
+		break;
+	case WIEGAND_V37:
+		tmp[4] &= 0xe0;
+
+		data[0] = (tmp[0] >> 1) | (wiegand_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0xc0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+				(!wiegand_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 3);
+		break;
+	default:
+		WARN_ON(fmt != WIEGAND_V37 &&
+			fmt != WIEGAND_V36 &&
+			fmt != WIEGAND_V26);
+	}
+}
+
+/*
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low ar the same time.
+ */
+void wiegand_send_bit(struct wiegand_device *wiegand,
+				bool value, bool last)
+{
+	struct wiegand_setup *setup = &wiegand->setup;
+	struct gpio_desc *gpio = value ? wiegand->gpio_data_hi
+				: wiegand->gpio_data_lo;
+
+	gpiod_set_value_cansleep(gpio, 0);
+	udelay(setup->pulse_len);
+	gpiod_set_value_cansleep(gpio, 1);
+
+	if (last)
+		udelay(setup->frame_gap - setup->pulse_len);
+	else
+		udelay(setup->interval_len - setup->pulse_len);
+}
+
+/* This function is used for custom format */
+static int wiegand_write_by_bits(struct wiegand_device *wiegand,
+				size_t len)
+{
+	size_t i, bitlen;
+	bool bit_value, is_last_bit;
+	struct wiegand_setup *setup = &wiegand->setup;
+
+	bitlen = setup->format ? setup->payload_len + 2 : setup->payload_len;
+
+	for (i = 0; i < bitlen; i++) {
+		bit_value = ((wiegand->data[i / 8] >> (7 - (i % 8)))
+									& 0x01);
+		is_last_bit = (i + 1) == bitlen;
+
+		wiegand_send_bit(wiegand, (bool)bit_value,
+				is_last_bit);
+	}
+
+	return 0;
+}
+
+static unsigned int wiegand_calc_bytes(unsigned int bits)
+{
+	if (bits % 8 != 0)
+		return (bits / 8) + 1;
+	else
+		return bits / 8;
+}
+
+static unsigned int wiegand_get_payload_size(
+						unsigned long payload_len_bits,
+						enum wiegand_format fmt)
+{
+	unsigned int ret;
+
+	if (fmt == WIEGAND_CUSTOM)
+		ret = wiegand_calc_bytes(payload_len_bits);
+	else
+		/* add 2 for parity bits */
+		ret = wiegand_calc_bytes(payload_len_bits + 2);
+
+	return ret;
+}
+
+static ssize_t wiegand_get_user_data(
+				struct wiegand_device *wiegand,
+				char __user const *buf, size_t len)
+{
+	size_t rc;
+	size_t num_copy;
+	unsigned char tmp[WIEGAND_MAX_PAYLEN_BYTES];
+	struct wiegand_setup *setup = &wiegand->setup;
+
+	num_copy = wiegand_get_payload_size(setup->payload_len,
+								setup->format);
+
+	if (setup->format == WIEGAND_CUSTOM) {
+		rc = copy_from_user(&wiegand->data[0], buf, num_copy);
+		if (rc < 0)
+			return rc;
+	} else {
+		rc = copy_from_user(tmp, buf, num_copy);
+		if (rc < 0)
+			return rc;
+		wiegand_add_parity_to_data(tmp, wiegand->data,
+								setup->format);
+	}
+	return num_copy;
+}
+
+static int wiegand_release(struct inode *ino, struct file *filp)
+{
+	struct wiegand_instance *info = filp->private_data;
+	struct wiegand_device *wiegand = info->dev;
+
+	kfree(wiegand);
+	kfree(info);
+
+	return 0;
+}
+
+ssize_t wiegand_write(struct wiegand_device *wiegand, const char *buf, size_t len)
+{
+	int rc;
+
+	strcpy(wiegand->data, buf);
+
+	if (len * 8 < wiegand->setup.payload_len)
+		return -EBADMSG;
+	if (buf == NULL || len == 0)
+		return -EINVAL;
+
+	rc = wiegand_write_by_bits(wiegand, len);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(wiegand_write);
+
+static ssize_t wiegand_write_from_file(struct file *filp,
+		char __user const *buf, size_t len, loff_t *offset)
+{
+	struct wiegand_instance *info = filp->private_data;
+	struct wiegand_device *wiegand = info->dev;
+	int rc;
+
+	if (len * 8 < wiegand->setup.payload_len)
+		return -EBADMSG;
+	if (buf == NULL || len == 0)
+		return -EINVAL;
+
+	wiegand_get_user_data(wiegand, buf, len);
+	rc = wiegand_write_by_bits(wiegand, len);
+
+	return len;
+}
+
+static int wiegand_open(struct inode *ino, struct file *filp)
+{
+	struct wiegand_device *wiegand;
+	struct wiegand_instance *info;
+	int rc;
+
+	wiegand = wiegand_glob;
+
+	mutex_lock(&wiegand->mutex);
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY ||
+		(filp->f_flags & O_ACCMODE) == O_RDWR) {
+		dev_err(wiegand->dev, "Device is write only\n");
+		rc = -EIO;
+		goto err;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	gpiod_direction_output(wiegand->gpio_data_hi, 1);
+	gpiod_direction_output(wiegand->gpio_data_lo, 1);
+
+	info->dev = wiegand;
+	info->flags = filp->f_flags;
+	wiegand_instance_glob = info;
+
+	mutex_unlock(&wiegand->mutex);
+
+	filp->private_data = info;
+
+	return 0;
+err:
+	mutex_unlock(&wiegand->mutex);
+
+	return rc;
+}
+
+const struct file_operations wiegand_fops = {
+	.owner		= THIS_MODULE,
+	.open		= wiegand_open,
+	.release	= wiegand_release,
+	.write		= wiegand_write_from_file,
+};
+
+static struct miscdevice wiegand_misc_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "wiegand-bus",
+	.fops = &wiegand_fops,
+};
+
+static ssize_t store_uint(unsigned int *val, const char *buf,
+				size_t size, unsigned long max)
+{
+	int ret;
+	unsigned long new;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
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
+	struct wiegand_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", device->setup.format);
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
+	int ret;
+	unsigned long new;
+	enum wiegand_format *val;
+	struct wiegand_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	val = &(device->setup.format);
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
+
+	switch (new) {
+	case 0:
+		*val = WIEGAND_CUSTOM;
+		break;
+	case 26:
+		*val = WIEGAND_V26;
+		device->setup.payload_len = WIEGAND_V26_PAYLEN;
+		break;
+	case 36:
+		*val = WIEGAND_V36;
+		device->setup.payload_len = WIEGAND_V36_PAYLEN;
+		break;
+	case 37:
+		*val = WIEGAND_V37;
+		device->setup.payload_len = WIEGAND_V37_PAYLEN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+void wiegand_set_format(struct wiegand_device *wiegand, enum wiegand_format fmt)
+{
+	wiegand->setup.format = fmt;
+}
+EXPORT_SYMBOL_GPL(wiegand_set_format);
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
+	struct wiegand_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", device->setup.pulse_len);
+}
+
+ssize_t payload_len_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wiegand_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	/* standard formats use fixed payload size */
+	if (device->setup.format != WIEGAND_CUSTOM)
+		return -EPERM;
+
+	return store_uint(&(device->setup.payload_len), buf, count,
+					WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+
+void wiegand_set_payload_len(struct wiegand_device *wiegand, u32 paylen)
+{
+	wiegand->setup.payload_len = paylen;
+}
+EXPORT_SYMBOL_GPL(wiegand_set_payload_len);
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
+	.name = "wiegand-attributes",
+	.attrs = wiegand_attrs,
+};
+
+static int wiegand_dev_probe(struct platform_device *device)
+{
+	int rc;
+	struct wiegand_device *wiegand;
+
+	wiegand = devm_kzalloc(&device->dev, sizeof(*wiegand), GFP_KERNEL);
+	if (!wiegand)
+		return -ENOMEM;
+
+	wiegand->dev = &device->dev;
+	wiegand->misc_dev = &wiegand_misc_device;
+
+	wiegand_glob = wiegand;
+
+	memcpy(&wiegand->setup, &WIEGAND_SETUP,
+			sizeof(struct wiegand_setup));
+
+	/* Get GPIO lines using device tree bindings. */
+	wiegand->gpio_data_lo = devm_gpiod_get(wiegand->dev,
+			"data-lo", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand->gpio_data_lo)) {
+		dev_err(wiegand->dev,
+			"Failed to get data-lo pin.\n");
+		return PTR_ERR(wiegand->gpio_data_lo);
+	}
+	wiegand->gpio_data_hi = devm_gpiod_get(wiegand->dev,
+			"data-hi", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand->gpio_data_hi)) {
+		dev_err(wiegand->dev,
+			"Failed to get data-hi pin.\n");
+		return PTR_ERR(wiegand->gpio_data_hi);
+	}
+
+	of_property_read_u32(wiegand->dev->of_node, "pulse-len",
+					&wiegand->setup.pulse_len);
+	of_property_read_u32(wiegand->dev->of_node, "interval-len", &wiegand->setup.interval_len);
+	of_property_read_u32(wiegand->dev->of_node, "frame-gap", &wiegand->setup.frame_gap);
+
+	rc = sysfs_create_group(&wiegand->dev->kobj, &wiegand_group);
+	if (rc < 0) {
+		dev_err(wiegand->dev, "Couldn't register sysfs group\n");
+		return rc;
+	}
+
+	mutex_init(&wiegand->mutex);
+
+	rc = misc_register(&wiegand_misc_device);
+	dev_info(wiegand->dev, "miscdevice prob registered, rc=%d\n", rc);
+	wiegand->misc_dev->parent = wiegand->dev;
+
+	dev_set_drvdata(&device->dev, wiegand);
+
+	return 0;
+}
+
+static int wiegand_dev_remove(struct platform_device *device)
+{
+	struct wiegand_device *wiegand = dev_get_drvdata(&device->dev);
+
+	sysfs_remove_group(&wiegand->dev->kobj, &wiegand_group);
+
+	misc_deregister(&wiegand_misc_device);
+	kfree(wiegand_instance_glob);
+	kfree(wiegand);
+
+	return 0;
+}
+
+static const struct of_device_id wiegand_dt_idtable[] = {
+	{ .compatible = "wiegand", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wiegand_dt_idtable);
+
+static struct platform_driver wiegand_driver = {
+	.probe		= wiegand_dev_probe,
+	.remove		= wiegand_dev_remove,
+	.driver		= {
+		.name		= "wiegand",
+		.of_match_table = wiegand_dt_idtable,
+	},
+};
+
+module_platform_driver(wiegand_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
+
diff --git a/include/linux/wiegand.h b/include/linux/wiegand.h
new file mode 100644
index 000000000000..2b2dece48643
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+
+#define WIEGAND_MAX_PAYLEN_BYTES 256
+#define WIEGAND_MAX_MODULES 1
+
+struct wiegand_device;
+struct wiegand_instance;
+
+/* The used wiegand format; when data does not end at octet boundaries, the
+ * lower bits of the last octet will be ignored and only the upper ones will be
+ * used.
+ */
+enum wiegand_format {
+	WIEGAND_V26 = 26,
+	WIEGAND_V36 = 36,
+	WIEGAND_V37 = 37,
+	WIEGAND_CUSTOM = 0,
+};
+
+enum wiegand_paylen {
+	WIEGAND_V26_PAYLEN = 24,
+	WIEGAND_V36_PAYLEN = 34,
+	WIEGAND_V37_PAYLEN = 35,
+};
+
+/**
+ * struct wiegand_setup - Wiegand communication attributes
+ * @pulse_len: length of the low pulse in usec; defaults to 50us, set via
+ *	devicetree
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in
+ *	usec; defaults to 2000us, set via devicetree
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high
+ *	phase) in usec; defaults to interval_len, set via devicetree
+ * @format: the used wiegand format, set via sysfs file
+ * @payload_len: payload of wiegand message in bits, set via sysfs file
+ */
+struct wiegand_setup {
+	u32		pulse_len;
+	u32		interval_len;
+	u32		frame_gap;
+	u32		payload_len;
+	enum wiegand_format	format;
+};
+
+extern ssize_t wiegand_write(struct wiegand_device *wiegand,
+						const char *buf, size_t len);
+extern void wiegand_set_format(struct wiegand_device *wiegand,
+						enum wiegand_format fmt);
+extern void wiegand_set_payload_len(
+		struct wiegand_device *wiegand_gpio, u32 paylen);
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
--
2.37.3

