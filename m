Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9725F56FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJEO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiJEO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:58:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F27644A;
        Wed,  5 Oct 2022 07:58:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u21so19175300edi.9;
        Wed, 05 Oct 2022 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cz2NKqcOvUsyVj8cGKDamLS3SuGdjUPEtX355TEPN1k=;
        b=X3rOdxmdmiUYZpe+mBlNzfdQSE86NeC+jDe4l/9zEot1Yre72e8Yn0a/ga1nmRgDih
         ak75COSLS7Qo0Cksvoj8eieU2wEC4kNdUgffdl+16Xwftu6A2NvQ2lDyKy/rE9sGnMZm
         K6AtXd4lxb/kHfB2muiqtNUnjNLWu0uAgKxq5BpXIMmxcILBp/GMQ/fx/NtZCfCspv77
         ZMRd6Td2UZGkpKAwG505+nGq5SSaaXPXL7uAZ8eiNehf3moEzav1FVmVEsOZfXkxmRDa
         cXF5AockY3+rBRdZVsC1zVRnYOiWES2+0I/EJy85VjVOVbyLV6JLVy2ITUlDg+Q1g7AX
         WqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cz2NKqcOvUsyVj8cGKDamLS3SuGdjUPEtX355TEPN1k=;
        b=q+U03sfK2/11ZnCiCftJH7LvhcjDXy7wqvN23OinQ/wUrr/13EXSWfZkOp2R+GirZA
         yUh/XhdqH0fBwv2XOh7rUkys+jM8LpHsFLUxHm4AgAJqnFFkiZhxTlw/KoSQRJcUtcaY
         DGzt6oLLLRKeqEdyMliAUfJ7NunfF2yUbDKf1H4tGEJfIuE/nEz11xKRwiHr38Nxc61H
         jf4mJk/tPF/tJX+RlGAMuCnpu4qnZpG6bMK1sho2KJoXAsYk8sz8ptElN8AbErBcdzyA
         LOfoiiBJF69VTlws0CVMcuEXCiY8MR/IPhswp5vx3/IOj+Iz6O/ureRe76EJoIH9Csdb
         3B2g==
X-Gm-Message-State: ACrzQf2yA7i7MawWorxFPToWVQa6PtRTT1I1p2Zd2BmnxcGrFENvwgbU
        LEAweUeeHi0gcWW0CKQmpc8=
X-Google-Smtp-Source: AMsMyM6NsazvFVOAPupGuNu7YfrB5l7/4cBdGM8m/PTeKFizIBYnhEDTzSyWNpc1X7pd6kd8cZBLKQ==
X-Received: by 2002:a05:6402:1a33:b0:458:a00a:80a with SMTP id be19-20020a0564021a3300b00458a00a080amr160740edb.378.1664981887103;
        Wed, 05 Oct 2022 07:58:07 -0700 (PDT)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id m5-20020a50cc05000000b004588ef795easm4023941edi.34.2022.10.05.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:58:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv2 PATCH 4/4] gpio: add Wiegand GPIO driver
Date:   Wed,  5 Oct 2022 16:57:46 +0200
Message-Id: <20221005145746.172138-4-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005145746.172138-1-m.zatovic1@gmail.com>
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
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

Wiegand GPIO driver uses GPIO lines defined in the devicetree to
transmit data following the Wiegand protocol.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../ABI/testing/sysfs-driver-gpio-wiegand     |  40 ++
 MAINTAINERS                                   |   9 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-wiegand.c                   | 492 ++++++++++++++++++
 5 files changed, 549 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-gpio-wiegand
 create mode 100644 drivers/gpio/gpio-wiegand.c

diff --git a/Documentation/ABI/testing/sysfs-driver-gpio-wiegand b/Documentation/ABI/testing/sysfs-driver-gpio-wiegand
new file mode 100644
index 000000000000..efcce06968ef
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-gpio-wiegand
@@ -0,0 +1,40 @@
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/format
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
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
+Date:		October 2022
+Contact:	Martin Zaťovič <sampaio.ime@gmail.com>
+Description:    Depends on format attribute - using one of the standard formats
+        the payload_len attribute file becomes read-only and it contains the
+        number of bits of a message without the checksum bits(e.g. 24 for
+        26-bit format). Using a custom format makes this file writable for
+        configuring the Wiegand message length in bits.
+Users:		any user space application which wants to communicate using Wiegand
+
+What: /sys/devices/platform/.../wiegand-gpio-attributes/pulse_len
+Date:       October 2022
+Contact:    Martin Zaťovič
+Description:    Length of the low pulse in usecs; defaults to 50us.
+Users:		any user space application which wants to communicate using Wiegand
+
+What: /sys/devices/platform/.../wiegand-gpio-attributes/interval_len
+Date:       October 2022
+Contact:    Martin Zaťovič
+Description:    Length of the whole bit(both the pulse and the high phase) in
+        usecs; defaults to 2000us
+Users:		any user space application which wants to communicate using Wiegand
+
+What: /sys/devices/platform/.../wiegand-gpio-attributes/frame_gap
+Date:       October 2022
+Contact:    Martin Zaťovič
+Description:    Length of the last bit of a frame(both the pulse and the high
+        phase) in usecs; defaults to interval_len
+Users:		any user space application which wants to communicate using Wiegand
diff --git a/MAINTAINERS b/MAINTAINERS
index 8656ab794786..43b21bd5333a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21960,6 +21960,15 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-wiimote*
 
+WIEGAND DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/bus/wiegand.yaml
+F:	Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
+F:	drivers/bus/wiegand.c
+F:	drivers/gpio/gpio-wiegand.c
+F:	include/linux/wiegand.h
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0642f579196f..3cd57e28df19 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -703,6 +703,13 @@ config GPIO_VX855
 	  Additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config GPIO_WIEGAND
+    tristate "Wiegand GPIO support"
+    depends on WIEGAND
+    help
+      This enables the GPIO module for Wiegand protocol communication.
+      The Wiegand bus driver has to be enabled first.
+
 config GPIO_WCD934X
 	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
 	depends on MFD_WCD934X && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a0985d30f51b..09024e291cc4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -173,6 +173,7 @@ obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
 obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
+obj-$(CONFIG_GPIO_WIEGAND)		+= gpio-wiegand.o
 obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
 obj-$(CONFIG_GPIO_WM831X)		+= gpio-wm831x.o
 obj-$(CONFIG_GPIO_WM8350)		+= gpio-wm8350.o
diff --git a/drivers/gpio/gpio-wiegand.c b/drivers/gpio/gpio-wiegand.c
new file mode 100644
index 000000000000..b45e39010fd6
--- /dev/null
+++ b/drivers/gpio/gpio-wiegand.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
+#include <linux/wiegand.h>
+
+struct wiegand_gpio_device *wiegand_gpio_glob;
+
+struct wiegand_gpio_device {
+	struct device *dev;
+	struct miscdevice *misc_dev;
+	struct mutex mutex;
+	struct gpio_desc *gpio_data_hi;
+	struct gpio_desc *gpio_data_lo;
+	struct wiegand_setup setup;
+	u8 data[WIEGAND_MAX_PAYLEN_BYTES];
+};
+
+struct wiegand_gpio_instance {
+	struct wiegand_gpio_device *dev;
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
+/*
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low ar the same time.
+ */
+void wiegand_gpio_send_bit(struct wiegand_gpio_device *wiegand_gpio,
+				bool value, bool last)
+{
+	struct wiegand_setup *setup = &wiegand_gpio->setup;
+	struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi
+				: wiegand_gpio->gpio_data_lo;
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
+static int wiegand_gpio_write_by_bits(struct wiegand_gpio_device *wiegand_gpio,
+				size_t len)
+{
+	size_t i, bitlen;
+	bool bit_value, is_last_bit;
+	struct wiegand_setup *setup = &wiegand_gpio->setup;
+
+	bitlen = setup->format ? setup->payload_len + 2 : setup->payload_len;
+
+	for (i = 0; i < bitlen; i++) {
+		bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8)))
+									& 0x01);
+		is_last_bit = (i + 1) == bitlen;
+
+		wiegand_gpio_send_bit(wiegand_gpio, (bool)bit_value,
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
+	unsigned int ret;
+
+	if (fmt == WIEGAND_CUSTOM)
+		ret = wiegand_gpio_calc_bytes(payload_len_bits);
+	else
+		/* add 2 for parity bits */
+		ret = wiegand_gpio_calc_bytes(payload_len_bits + 2);
+
+	return ret;
+}
+
+static ssize_t wiegand_gpio_get_user_data(
+				struct wiegand_gpio_device *wiegand_gpio,
+				char __user const *buf, size_t len)
+{
+	size_t rc;
+	size_t num_copy;
+	unsigned char tmp[WIEGAND_MAX_PAYLEN_BYTES];
+	struct wiegand_setup *setup = &wiegand_gpio->setup;
+
+	num_copy = wiegand_gpio_get_payload_size(setup->payload_len,
+								setup->format);
+
+	if (setup->format == WIEGAND_CUSTOM) {
+		rc = copy_from_user(&wiegand_gpio->data[0], buf, num_copy);
+		if (rc < 0)
+			return rc;
+	} else {
+		rc = copy_from_user(tmp, buf, num_copy);
+		if (rc < 0)
+			return rc;
+		wiegand_gpio_add_parity_to_data(tmp, wiegand_gpio->data,
+								setup->format);
+	}
+	return num_copy;
+}
+
+static int wiegand_gpio_release(struct inode *ino, struct file *filp)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio_device *wiegand_gpio = info->dev;
+
+	mutex_lock(&wiegand_gpio->mutex);
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	kfree(info);
+
+	return 0;
+}
+
+static ssize_t wiegand_gpio_write(struct file *filp,
+		char __user const *buf, size_t len, loff_t *offset)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio_device *wiegand_gpio = info->dev;
+	int rc;
+
+	if (len * 8 < wiegand_gpio->setup.payload_len)
+		return -EBADMSG;
+	if (buf == NULL || len == 0)
+		return -EINVAL;
+
+	wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
+	rc = wiegand_gpio_write_by_bits(wiegand_gpio, len);
+
+	return len;
+}
+
+static int wiegand_gpio_open(struct inode *ino, struct file *filp)
+{
+	struct wiegand_gpio_device *wiegand_gpio;
+	struct wiegand_gpio_instance *info;
+	int rc;
+
+	wiegand_gpio = wiegand_gpio_glob;
+
+	mutex_lock(&wiegand_gpio->mutex);
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY ||
+		(filp->f_flags & O_ACCMODE) == O_RDWR) {
+		dev_err(wiegand_gpio->dev, "Device is write only\n");
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
+	gpiod_direction_output(wiegand_gpio->gpio_data_hi, 1);
+	gpiod_direction_output(wiegand_gpio->gpio_data_lo, 1);
+
+	info->dev = wiegand_gpio;
+	info->flags = filp->f_flags;
+
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	filp->private_data = info;
+
+	return 0;
+err:
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	return rc;
+}
+
+const struct file_operations wiegand_gpio_fops = {
+	.owner		= THIS_MODULE,
+	.open		= wiegand_gpio_open,
+	.release	= wiegand_gpio_release,
+	.write		= wiegand_gpio_write,
+};
+
+static struct miscdevice wiegand_misc_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "wiegand-gpio",
+	.fops = &wiegand_gpio_fops,
+};
+
+static ssize_t store_ulong(unsigned long *val, const char *buf,
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
+ssize_t pulse_len_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%lu\n", device->setup.pulse_len);
+}
+
+ssize_t pulse_len_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return store_ulong(&(device->setup.pulse_len), buf, count, 0);
+}
+
+ssize_t interval_len_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%lu\n", device->setup.pulse_len);
+}
+
+ssize_t interval_len_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return store_ulong(&(device->setup.interval_len), buf, count, 0);
+}
+
+ssize_t frame_gap_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%lu\n", device->setup.frame_gap);
+}
+
+ssize_t frame_gap_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return store_ulong(&(device->setup.frame_gap), buf, count, 0);
+}
+
+ssize_t format_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
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
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
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
+/*
+ * Using a custom format, the payload_len sysfs file configures the size of
+ * messages payload in bits. When one of the standard formats is used, this
+ * file is read-only and contains the size of the message in bits without the
+ * parity bits.
+ */
+ssize_t payload_len_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%lu\n", device->setup.pulse_len);
+}
+
+ssize_t payload_len_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	/* standard formats use fixed payload size */
+	if (device->setup.format != WIEGAND_CUSTOM)
+		return -EPERM;
+
+	return store_ulong(&(device->setup.payload_len), buf, count,
+					WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+
+DEVICE_ATTR_RW(pulse_len);
+DEVICE_ATTR_RW(interval_len);
+DEVICE_ATTR_RW(frame_gap);
+DEVICE_ATTR_RW(format);
+DEVICE_ATTR_RW(payload_len);
+
+static struct attribute *wiegand_attrs[] = {
+	&dev_attr_pulse_len.attr,
+	&dev_attr_interval_len.attr,
+	&dev_attr_frame_gap.attr,
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
+static int wiegand_gpio_dev_probe(struct device *device)
+{
+	int rc;
+	struct wiegand_gpio_device *wiegand_gpio;
+
+	wiegand_gpio = devm_kzalloc(device, sizeof(*wiegand_gpio), GFP_KERNEL);
+	if (!wiegand_gpio)
+		return -ENOMEM;
+
+	wiegand_gpio->dev = device;
+	wiegand_gpio->misc_dev = &wiegand_misc_device;
+
+	wiegand_gpio_glob = wiegand_gpio;
+
+	/* Get GPIO lines using device tree bindings. */
+	wiegand_gpio->gpio_data_lo = devm_gpiod_get(wiegand_gpio->dev,
+			"data-lo", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand_gpio->gpio_data_lo)) {
+		return dev_err_probe(wiegand_gpio->dev,
+				PTR_ERR(wiegand_gpio->gpio_data_lo),
+				"Can't get data-lo line.");
+	}
+	wiegand_gpio->gpio_data_hi = devm_gpiod_get(wiegand_gpio->dev,
+			"data-hi", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand_gpio->gpio_data_hi)) {
+		return dev_err_probe(wiegand_gpio->dev,
+				PTR_ERR(wiegand_gpio->gpio_data_hi),
+				"Can't get data-hi line.");
+	}
+
+	rc = sysfs_create_group(&wiegand_gpio->dev->kobj, &wiegand_group);
+	if (rc < 0) {
+		dev_err(wiegand_gpio->dev, "Couldn't register sysfs group\n");
+		return rc;
+	}
+
+	mutex_init(&wiegand_gpio->mutex);
+
+	misc_register(wiegand_gpio->misc_dev);
+	wiegand_gpio->misc_dev->parent = wiegand_gpio->dev;
+
+	memcpy(&wiegand_gpio->setup, &WIEGAND_SETUP,
+			sizeof(struct wiegand_setup));
+
+	dev_set_drvdata(device, wiegand_gpio);
+
+	return 0;
+}
+
+static int wiegand_gpio_dev_remove(struct device *device)
+{
+	struct wiegand_gpio_device *wiegand_gpio = dev_get_drvdata(device);
+
+	sysfs_remove_group(&wiegand_gpio->dev->kobj, &wiegand_group);
+
+	misc_deregister(&wiegand_misc_device);
+	kfree(wiegand_gpio);
+
+	return 0;
+}
+
+static const struct of_device_id wiegand_gpio_dt_idtable[] = {
+	{ .compatible = "wiegand,wiegand-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
+
+static const enum wiegand_module_id wiegand_gpio_module_table[] = {
+	WIEGAND_MODULE_GPIO,
+	0,
+};
+
+static struct wiegand_driver wiegand_gpio_driver = {
+	.driver = {
+		.name	= "wiegand-gpio",
+		.probe		= wiegand_gpio_dev_probe,
+		.remove		= wiegand_gpio_dev_remove,
+		.of_match_table = wiegand_gpio_dt_idtable,
+	},
+	.id_table = wiegand_gpio_module_table,
+};
+
+module_wiegand_driver(wiegand_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
-- 
2.37.3

