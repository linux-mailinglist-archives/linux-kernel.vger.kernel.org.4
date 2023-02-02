Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7DF688039
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBBOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjBBOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:33:33 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF358B319;
        Thu,  2 Feb 2023 06:33:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m2so6462561ejb.8;
        Thu, 02 Feb 2023 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BouysRvMXXKpWc/jTXsO5Cksblbk/hdxbGtkII6MiNk=;
        b=mektjHVNBYl0DwnmNo5L6NA+g2gJr+d9bGqTjsIdjKxkY6IfsABzvQeLSvUFNZdflo
         4c8dRrV7++zTi11W3jhbqo1h24Rn3Qk0w+mUA/2IozZ5RxBjCqr4JMHMdpUiKuFbdyHY
         qyF+eNCxyG4TgruxWQHTy7BlqunGeUQlaGck7PkyDxVfNtdjsnlUdkRHzlc0XaShlwPw
         F7dKZX4UFH/BLAj+nZMmo29pYSKVwRA/ZhSIaLDso4WoeVNiQfo6BqlEAVWWw5o4JUMR
         TX6kO7D7V0mtiN6Z6e/pI4Ns/vf4Ea6W5IChy3KQP8vnBt+Lyg5ctQ5BcfUng5YfHyMl
         cOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BouysRvMXXKpWc/jTXsO5Cksblbk/hdxbGtkII6MiNk=;
        b=jq9lmVu1ZUaEki+S0LVd+d65Tluu0H8srYtN2a0yn5eL1B3x45qYP3h11svISTq3/2
         B5A2S0/cIN5yrQtz0Wes3iWvV6bdbLu4kgoULfMMGkF9PS46CDRvi+cCsKhJpkWHSO1x
         /NN4mOzQ32qOWnsjNcrGQAqi4T5vfi6CSvxnU88ZZt7naG2RLUYQuCVMSRefeFA8gq4G
         TysGp2xSZOtCAxPUSO8+SaBZBq6add2O0Ague+gs2JwG8ffrHhewzGf7UHoLHq2+Ljo6
         CrRrK+cBEKTF2TiJxJFThpH8sBsIedC2hMfpxiJ4SgCKTUweliSx8RQgjMXFJiBxYK1I
         X0oQ==
X-Gm-Message-State: AO0yUKXrKQIMQFv6KXyS5rSL0bB9o/kYERGMW6fT4uGdwKogYv00asLr
        iy1vIZR62x1ZuAl8Y8wxu9mAdych3cmroA==
X-Google-Smtp-Source: AK7set+EQK8d10iniAr6KH8ExUCw/2PL0xr7iTO4pIxYZFYdbKGZtMUHbeKAAl5Y8ppeaSTMEIjmww==
X-Received: by 2002:a17:907:6f1b:b0:889:b6ae:75fe with SMTP id sy27-20020a1709076f1b00b00889b6ae75femr6250009ejc.61.1675348398308;
        Thu, 02 Feb 2023 06:33:18 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709066d9100b0087856bd9dbbsm11814237ejt.97.2023.02.02.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:33:17 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv2 4/4] wiegand: add Wiegand GPIO bit-banged controller driver
Date:   Thu,  2 Feb 2023 15:33:05 +0100
Message-Id: <20230202143305.21789-5-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202143305.21789-1-m.zatovic1@gmail.com>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
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

This controller formats the data to a Wiegand format and bit-bangs
the message on devicetree defined GPIO lines.

Several attributes need to be defined in the devicetree in order
for this driver to work, namely the data-hi-gpios, data-lo-gpios,
pulse-len, frame-gap and interval-len. These attributes are
documented in the devicetree bindings documentation files.

The driver creates a dev file for writing messages on the bus.
It also creates a sysfs file to control the payload length of
messages(in bits). If a message is shorter than the set payload
length, it will be discarded. On the other hand, if a message is
longer, the additional bits will be stripped off.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 MAINTAINERS                                   |   2 +
 drivers/wiegand/Kconfig                       |   8 +
 drivers/wiegand/Makefile                      |   1 +
 drivers/wiegand/wiegand-gpio.c                | 324 ++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 drivers/wiegand/wiegand-gpio.c

diff --git a/Documentation/ABI/testing/sysfs-driver-wiegand-gpio b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
new file mode 100644
index 000000000000..be2246880a83
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
@@ -0,0 +1,9 @@
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
+Date:		January 2023
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:
+		Read/set the payload length of messages sent by Wiegand GPIO
+		bit-banging controller in bits. The default value is 26, as
+		that is the most widely-used length of Wiegand messages.
+		Controller will only send messages of at least the set length
+		and it will strip off bits of longer messages.
diff --git a/MAINTAINERS b/MAINTAINERS
index 54d61d95a1ba..1c6f242aa250 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22438,7 +22438,9 @@ F:	include/linux/wiegand.h
 WIEGAND GPIO BITBANG DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
+F:	drivers/wiegand/wiegand-gpio.c
 
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
index fc99575bc3cc..9a8f705d4646 100644
--- a/drivers/wiegand/Kconfig
+++ b/drivers/wiegand/Kconfig
@@ -18,3 +18,11 @@ config WIEGAND
 	  are initially pulled up. When a bit of value 0 is being transmitted,
 	  the D0 line is pulled down. Similarly, when a bit of value 1 is being
 	  transmitted, the D1 line is pulled down.
+
+config WIEGAND_GPIO
+	tristate "GPIO-based wiegand master (write only)"
+	depends on WIEGAND
+	help
+	  This GPIO bitbanging Wiegand controller uses the libgpiod library to
+	  utilize GPIO lines for sending Wiegand data. Userspace may access
+	  the Wiegand GPIO interface via a dev entry.
diff --git a/drivers/wiegand/Makefile b/drivers/wiegand/Makefile
index d17ecb722c6e..ddf697e21088 100644
--- a/drivers/wiegand/Makefile
+++ b/drivers/wiegand/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_WIEGAND)			+= wiegand.o
+obj-$(CONFIG_WIEGAND_GPIO)		+= wiegand-gpio.o
diff --git a/drivers/wiegand/wiegand-gpio.c b/drivers/wiegand/wiegand-gpio.c
new file mode 100644
index 000000000000..fc4e7e0e988a
--- /dev/null
+++ b/drivers/wiegand/wiegand-gpio.c
@@ -0,0 +1,324 @@
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
+					size_t size, unsigned long max)
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
+/*
+ * Attribute file for setting payload length of Wiegand messages.
+ */
+ssize_t payload_len_show(struct device *dev, struct device_attribute *attr,
+								 char *buf)
+{
+	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
+							dev->driver_data;
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return sysfs_emit(buf, "%u\n", ctlr->payload_len);
+}
+
+ssize_t payload_len_store(struct device *dev, struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
+							dev->driver_data;
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return store_ulong(&(ctlr->payload_len), buf, count,
+						WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+DEVICE_ATTR_RW(payload_len);
+
+/*
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low at the same time.
+ */
+void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value,
+								bool last)
+{
+	u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
+	u32 interval_len = wiegand_gpio->ctlr->interval_len;
+	u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
+	struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi
+					: wiegand_gpio->gpio_data_lo;
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
+static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio,
+								u16 bitlen)
+{
+	size_t i;
+	bool bit_value, is_last_bit;
+
+	for (i = 0; i < bitlen; i++) {
+		bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8)))
+									& 0x01);
+		is_last_bit = (i + 1) == bitlen;
+		wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
+	}
+
+	return 0;
+}
+
+static ssize_t wiegand_gpio_get_user_data(struct wiegand_gpio *wiegand_gpio,
+					char __user const *buf, size_t len)
+{
+	size_t rc;
+
+	if (len > WIEGAND_MAX_PAYLEN_BYTES)
+		return -EBADMSG;
+
+	rc = copy_from_user(&wiegand_gpio->data[0], buf,
+						WIEGAND_MAX_PAYLEN_BYTES);
+	if (rc < 0)
+		return rc;
+
+	return len;
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
+static ssize_t wiegand_gpio_fwrite(struct file *filp, char __user const *buf,
+						size_t len, loff_t *offset)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio *wiegand_gpio = info->dev;
+	u32 msg_length = wiegand_gpio->ctlr->payload_len;
+	int rc;
+
+	if (buf == NULL || len == 0 || len * 8 < msg_length)
+		return -EINVAL;
+
+	rc = wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
+	if (rc < 0)
+		return rc;
+
+	wiegand_gpio_write_by_bits(wiegand_gpio, msg_length);
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
+				(filp->f_flags & O_ACCMODE) == O_RDWR) {
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
+/* This function is used by device drivers */
+int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message,
+								u8 msg_bitlen)
+{
+	struct wiegand_controller *ctlr = dev->controller;
+	struct wiegand_gpio *wiegand_gpio = wiegand_master_get_devdata(ctlr);
+	u8 msg_bytelength = (msg_bitlen % 8) ?
+				(msg_bitlen / 8) + 1 : (msg_bitlen / 8);
+
+	memcpy(wiegand_gpio->data, message, msg_bytelength);
+	wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
+
+	return 0;
+}
+
+static int wiegand_gpio_request(struct device *dev,
+					struct wiegand_gpio *wiegand_gpio)
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
+	master->payload_len = 26; /* set standard 26-bit format */
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
+	status = devm_wiegand_register_master(dev, master);
+	if (status) {
+		dev_err(wiegand_gpio->dev, "failed to register master\n");
+		return status;
+	}
+
+	wiegand_gpio->misc_dev.name = kasprintf(GFP_KERNEL, "wiegand-gpio%u",
+							master->bus_num);
+	wiegand_gpio->misc_dev.minor = MISC_DYNAMIC_MINOR;
+	wiegand_gpio->misc_dev.fops = &wiegand_gpio->fops;
+
+	status = misc_register(&wiegand_gpio->misc_dev);
+	if (status) {
+		dev_err(wiegand_gpio->dev, "couldn't register misc device\n");
+		return status;
+	}
+	wiegand_gpio->misc_dev.parent = wiegand_gpio->dev;
+
+	device_create_file(dev, &dev_attr_payload_len);
+
+	return status;
+}
+
+static int wiegand_gpio_remove(struct platform_device *device)
+{
+	struct wiegand_gpio *wiegand_gpio = platform_get_drvdata(device);
+
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
2.39.1

