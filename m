Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA236FE25D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjEJQYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjEJQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:23:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15147EE7;
        Wed, 10 May 2023 09:23:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so778280266b.1;
        Wed, 10 May 2023 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735780; x=1686327780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goWA+TvguPVA5aRLdsk/rQMhtaF/EgTAUtAle5S7NKw=;
        b=eVaMQSVmkIUrY2yNsMPrbDZIY4fgZZa3Ny5pDZWFrxRfaY0RgaY0BAbFfpZ926zz62
         RVJ4l9l1cE60eODgGOdqsp8VvYfr0sDegKJewvk1CaLMaMMDg8o7zbkcUQDY4iRaWMNi
         sCZIO75+qKuAIZuc+QvsAo/SEy41vzQfFts+5Kw7YXwVDCqYr1Q5TfElX6x49GGpf0OY
         fC4/1OhleBIGrUdIhcfIe65qjHtI6krXrREtSVFn1iM4G8fHFd+stKpSKU8yXWQ+FzmG
         sc7p5I5s+FlfOSkQ5ciSeutVei9zcmoJZg6qw5P4y3SxoCal/GmsnflJlG3i2GwGft6l
         +Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735780; x=1686327780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goWA+TvguPVA5aRLdsk/rQMhtaF/EgTAUtAle5S7NKw=;
        b=PYEsJmqEF0BJwcFMdClCW9E4n2kJ4lrsYiwgU2Y8dptrlGvWqaweUZfsogvmjJ+3oU
         RG6RzU2WeOMF5CEmeJhPf+W0dVS4JV3OcisietnTk/hacG7wU6lpA2VSa/uSpXTqJ0Wm
         opqRkwJvCSskWJP3kiiPn4y+z/jUONbiQa0yPKBsRjK9n8m0gg35I+1fhHunMqDfmT8f
         yFRg0OechLxK4ox/4iF/5Bl/ZqjOU+VbEtq3FkH/IVaw0fm2oGXKjF8SWBzBdUPs14cP
         zFlL5PoZq21RAkmLOZ5qNrvXHMunZGag6iaB7SZQkvNIIaHaWoUxKZVMrwhEMwCMrw8Y
         F+jw==
X-Gm-Message-State: AC+VfDyY6xPVyAAbkYS2Uuc4vE+jL4a378uIeLzsrqxUccpWIGMLdqs1
        ouY9MUPOtcm9WxhMCvxVRE4HyBNaI8Pxvaq9
X-Google-Smtp-Source: ACHHUZ4ZlrXMrkhQFsqV330zUV+j2OFdTywbBsOo4fkpaOjjz35b/52jMl5mLX0akjeVw3eU4HXY7g==
X-Received: by 2002:a17:907:1c26:b0:96a:440b:d5db with SMTP id nc38-20020a1709071c2600b0096a440bd5dbmr1175560ejc.47.1683735780059;
        Wed, 10 May 2023 09:23:00 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id m28-20020a17090677dc00b00947ed087a2csm2890149ejn.154.2023.05.10.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:22:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        beanhuo@micron.com, nipun.gupta@amd.com, linus.walleij@linaro.org,
        mwen@igalia.com, bvanassche@acm.org, arnd@arndb.de,
        ogabbay@kernel.org, linux@zary.sk,
        jacek.lawrynowicz@linux.intel.com, geert+renesas@glider.be,
        benjamin.tissoires@redhat.com, masahiroy@kernel.org,
        yangyicong@hisilicon.com, devicetree@vger.kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv4 4/4] wiegand: add Wiegand GPIO bitbanged controller driver
Date:   Wed, 10 May 2023 18:22:43 +0200
Message-Id: <20230510162243.95820-5-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162243.95820-1-m.zatovic1@gmail.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 MAINTAINERS                                   |   2 +
 drivers/wiegand/Kconfig                       |   8 +
 drivers/wiegand/Makefile                      |   1 +
 drivers/wiegand/wiegand-gpio.c                | 189 ++++++++++++++++++
 5 files changed, 209 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 drivers/wiegand/wiegand-gpio.c

diff --git a/Documentation/ABI/testing/sysfs-driver-wiegand-gpio b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
new file mode 100644
index 000000000000..c3981972dbc8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
@@ -0,0 +1,9 @@
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
+Date:		May 2023
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:
+		Read/set the payload length of messages sent by Wiegand GPIO
+		bit-banging controller in bits. The default value is 26, as
+		that is the most widely-used message length of Wiegand messages.
+		Controller will only send messages of at least the set length
+		and it will strip off bits of longer messages.
diff --git a/MAINTAINERS b/MAINTAINERS
index 915cb36e5b2f..e828a5ec8162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22707,7 +22707,9 @@ F:	include/linux/wiegand.h
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
index 000000000000..a46421f515b1
--- /dev/null
+++ b/drivers/wiegand/wiegand-gpio.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+
+#define UP_TO_100_USEC_DEVIATION 1
+#define MORE_THAN_100_USEC_DEVIATION 3
+
+struct wiegand_gpio {
+	struct device *dev;
+	struct wiegand_controller *ctlr;
+	struct gpio_desc *data1_gpio;
+	struct gpio_desc *data0_gpio;
+};
+
+static ssize_t store_ulong(u32 *val, const char *buf, size_t size, unsigned long max)
+{
+	int rc;
+	u32 new;
+
+	rc = kstrtou32(buf, 0, &new);
+	if (rc)
+		return rc;
+
+	if (new > max)
+		return -EINVAL;
+
+	*val = new;
+	return size;
+}
+
+/*
+ * Attribute file for setting payload length of Wiegand messages.
+ */
+static ssize_t payload_len_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return sysfs_emit(buf, "%u\n", ctlr->payload_len);
+}
+
+static ssize_t payload_len_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			size_t count)
+{
+	struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return store_ulong(&(ctlr->payload_len), buf, count, WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+static DEVICE_ATTR_RW(payload_len);
+
+static struct attribute *wiegand_gpio_attrs[] = {
+	&dev_attr_payload_len.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wiegand_gpio);
+
+/*
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low at the same time.
+ */
+void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
+{
+	u32 sleep_len;
+	u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
+	u32 interval_len = wiegand_gpio->ctlr->interval_len;
+	u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
+	struct gpio_desc *gpio = value ? wiegand_gpio->data1_gpio : wiegand_gpio->data0_gpio;
+
+	gpiod_set_value_cansleep(gpio, 0);
+	udelay(pulse_len);
+	gpiod_set_value_cansleep(gpio, 1);
+
+	if (last)
+		sleep_len = frame_gap - pulse_len;
+	else
+		sleep_len = interval_len - pulse_len;
+
+	if (sleep_len < 10)
+		udelay(sleep_len);
+	else if (sleep_len < 100)
+		usleep_range(sleep_len - UP_TO_100_USEC_DEVIATION,
+			     sleep_len + UP_TO_100_USEC_DEVIATION);
+	else
+		usleep_range(sleep_len - MORE_THAN_100_USEC_DEVIATION,
+			     sleep_len + MORE_THAN_100_USEC_DEVIATION);
+}
+
+static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
+{
+	size_t i;
+	bool bit_value, is_last_bit;
+
+	for (i = 0; i < bitlen; i++) {
+		bit_value = test_bit(i, wiegand_gpio->ctlr->data_bitmap);
+		is_last_bit = (i + 1) == bitlen;
+		wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
+	}
+
+	return 0;
+}
+
+int wiegand_gpio_transfer_message(struct wiegand_controller *ctlr)
+{
+	struct wiegand_gpio *wiegand_gpio = wiegand_primary_get_devdata(ctlr);
+	u8 msg_bitlen = ctlr->payload_len;
+
+	wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
+
+	return 0;
+}
+
+static int wiegand_gpio_request(struct device *dev, struct wiegand_gpio *wiegand_gpio)
+{
+	wiegand_gpio->data0_gpio = devm_gpiod_get(dev, "data-lo", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand_gpio->data0_gpio))
+		return PTR_ERR(wiegand_gpio->data0_gpio);
+
+	wiegand_gpio->data1_gpio = devm_gpiod_get(dev, "data-hi", GPIOD_OUT_HIGH);
+	return PTR_ERR_OR_ZERO(wiegand_gpio->data1_gpio);
+}
+
+static int wiegand_gpio_probe(struct platform_device *device)
+{
+	int status = 0;
+	struct wiegand_controller *primary;
+	struct wiegand_gpio *wiegand_gpio;
+	struct device *dev = &device->dev;
+
+	primary = wiegand_alloc_controller(dev, sizeof(*wiegand_gpio), false);
+	if (!primary)
+		return -ENOMEM;
+
+	primary->transfer_message = &wiegand_gpio_transfer_message;
+	primary->payload_len = 26; // set standard 26-bit format
+
+	wiegand_gpio = wiegand_primary_get_devdata(primary);
+	wiegand_gpio->ctlr = primary;
+
+	platform_set_drvdata(device, wiegand_gpio);
+
+	primary->bus_num = device->id;
+	wiegand_gpio->dev = dev;
+
+	status = wiegand_gpio_request(dev, wiegand_gpio);
+	if (status)
+		return dev_err_probe(wiegand_gpio->dev, status, "failed at requesting GPIOs\n");
+
+	status = gpiod_direction_output(wiegand_gpio->data1_gpio, 1);
+	if (status)
+		return dev_err_probe(wiegand_gpio->dev, status, "failed to set GPIOs direction\n");
+
+	status = gpiod_direction_output(wiegand_gpio->data0_gpio, 1);
+	if (status)
+		return dev_err_probe(wiegand_gpio->dev, status, "failed to set GPIOs direction\n");
+
+	status = wiegand_register_controller(primary);
+	if (status)
+		dev_err_probe(wiegand_gpio->dev, status, "failed to register primary\n");
+	return status;
+}
+
+static const struct of_device_id wiegand_gpio_dt_idtable[] = {
+	{ .compatible = "wiegand-gpio", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
+
+static struct platform_driver wiegand_gpio_driver = {
+	.driver = {
+		.name	= "wiegand-gpio",
+		.of_match_table = wiegand_gpio_dt_idtable,
+		.dev_groups = wiegand_gpio_groups
+	},
+	.probe		= wiegand_gpio_probe
+};
+module_platform_driver(wiegand_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
-- 
2.40.0

