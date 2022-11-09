Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0638762338D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiKITbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKITbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:31:03 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4B2A956;
        Wed,  9 Nov 2022 11:31:00 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so18075816pli.0;
        Wed, 09 Nov 2022 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzRmVyZjNLOkQVNMRdyPxVXGBGg/HG7r2x/54f2F8u4=;
        b=prVeqri7KEgFKB9KvY6lzuQWL6mbuTlild1ZL4LVUN8dcHGbqjDoBeJ99W5Pw2E5xa
         I+ZoEK7T51p7pApRAge8S2/uAGhu5qeY5+FAwy2A827TOV/ShpIzV9rqGhjxWyAMARrW
         0iJMi6ufXpyNG7GYbV60YEmAbwe46lv4c6ybEUY6FFZfTaYi4bR5gvdsNS8c9g16Zh9K
         preLcD51ltqgTtbpdmV6vhw3DHV8+coQCjmo2M6QLRxHbqsDjimF5DjyBe8zaLahw5sQ
         mtFOKCiiqaX1A+Z5gq0E8NdU8IPgohSXXQjTz/0fVBrBgZiDMklEDbBfYtZSHNUIcJJU
         pflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzRmVyZjNLOkQVNMRdyPxVXGBGg/HG7r2x/54f2F8u4=;
        b=BfE/l3/Siy2f4V+sKrBzUINfVx9WsGKel3BhPncK+jyGdGyR+0wUxtz4uZMPA3hcBR
         2KdIfxiikVNT3IQ8g9HUrhMidvb7I3KEfDoJOabm8VRIbu5YYJoGlKD/no8xktZP+wI+
         gp+wZPrycGV1sjkB/z93rBB9KfjFov4l8TLDejQjTtPZKVbLlbAQ3AWSIXhx2tA06Ym5
         OknmEQsVxpOeVlLzPV5iMEzIhw/nGI2ClIwi7BpZphCevumhlcp8M4BEHZzPQng/Ton/
         L3XDg2yNSOvCdOoTBUK/66x6zJSQgwGOF48JqnxdYoQbm3OyrwuvgUazcA7ypYbzIIrT
         nKtg==
X-Gm-Message-State: ANoB5pkGbxkUpv6bpw5nM6TaD2BxVxbyouNjV/zTyD1Wq+aHlwVXevZw
        FKeTGWhga5L3ytLe9X5Uv+A=
X-Google-Smtp-Source: AA0mqf6+kTefudacE11UKxxQWLdEcqaG2Mtxb2mIa0LXz2wkvqZhe+w/zwi/q96Nvh6m0wzBIuWl8g==
X-Received: by 2002:a17:902:e5c7:b0:188:71b1:8f0e with SMTP id u7-20020a170902e5c700b0018871b18f0emr24939783plf.27.1668022259728;
        Wed, 09 Nov 2022 11:30:59 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186ac4b21cfsm9567462plg.230.2022.11.09.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:30:59 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 6/6] gpiolib: add support for software nodes
Date:   Wed,  9 Nov 2022 11:30:44 -0800
Message-Id: <20221031-gpiolib-swnode-v3-6-0282162b0fa4@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that static device properties understand notion of child nodes and
references, let's teach gpiolib to handle them:

- GPIOs are represented as a references to software nodes representing
  gpiochip
- references must have 2 arguments - GPIO number within the chip and
  GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc)
- a new PROPERTY_ENTRY_GPIO() macro is supplied to ensure the above
- name of the software node representing gpiochip must match label of
  the gpiochip, as we use it to locate gpiochip structure at runtime

The following illustrates use of software nodes to describe a "System"
button that is currently specified via use of gpio_keys_platform_data
in arch/mips/alchemy/board-mtx1.c. It follows bindings specified in
Documentation/devicetree/bindings/input/gpio-keys.yaml.

static const struct software_node mxt1_gpiochip2_node = {
	.name = "alchemy-gpio2",
};

static const struct property_entry mtx1_gpio_button_props[] = {
	PROPERTY_ENTRY_U32("linux,code", BTN_0),
	PROPERTY_ENTRY_STRING("label", "System button"),
	PROPERTY_ENTRY_GPIO("gpios", &mxt1_gpiochip2_node, 7, GPIO_ACTIVE_LOW),
	{ }
};

Similarly, arch/arm/mach-tegra/board-paz00.c can be converted to:

static const struct software_node tegra_gpiochip_node = {
	.name = "tegra-gpio",
};

static struct property_entry wifi_rfkill_prop[] __initdata = {
	PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
	PROPERTY_ENTRY_STRING("type", "wlan"),
	PROPERTY_ENTRY_GPIO("reset-gpios",
			    &tegra_gpiochip_node, 25, GPIO_ACTIVE_HIGH);
	PROPERTY_ENTRY_GPIO("shutdown-gpios",
			    &tegra_gpiochip_node, 85, GPIO_ACTIVE_HIGH);
	{ },
};

static struct platform_device wifi_rfkill_device = {
	.name	= "rfkill_gpio",
	.id	= -1,
};

...

	software_node_register(&tegra_gpiochip_node);
	device_create_managed_software_node(&wifi_rfkill_device.dev,
					    wifi_rfkill_prop, NULL);

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpiolib-swnode.c | 123 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-swnode.h |  14 +++++
 drivers/gpio/gpiolib.c        |   7 +++
 include/linux/gpio/property.h |  11 ++++
 5 files changed, 156 insertions(+)

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 8629e9eaf79e..010587025fc8 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 obj-$(CONFIG_GPIO_CDEV)		+= gpiolib-cdev.o
 obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
 obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
+obj-$(CONFIG_GPIOLIB)		+= gpiolib-swnode.o
 
 # Device drivers. Generally keep list sorted alphabetically
 obj-$(CONFIG_GPIO_REGMAP)	+= gpio-regmap.o
diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
new file mode 100644
index 000000000000..dd9ccac214d1
--- /dev/null
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Software Node helpers for the GPIO API
+ *
+ * Copyright 2022 Google LLC
+ */
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/string.h>
+
+#include "gpiolib.h"
+#include "gpiolib-swnode.h"
+
+static void swnode_format_propname(const char *con_id, char *propname,
+				   size_t max_size)
+{
+	/*
+	 * Note we do not need to try both -gpios and -gpio suffixes,
+	 * as, unlike OF and ACPI, we can fix software nodes to conform
+	 * to the proper binding.
+	 */
+	if (con_id)
+		snprintf(propname, max_size, "%s-gpios", con_id);
+	else
+		strscpy(propname, "gpios", max_size);
+}
+
+static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
+static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
+{
+	const struct software_node *chip_node;
+	struct gpio_chip *chip;
+
+	chip_node = to_software_node(fwnode);
+	if (!chip_node || !chip_node->name)
+		return ERR_PTR(-EINVAL);
+
+	chip = gpiochip_find((void *)chip_node->name, swnode_gpiochip_match_name);
+	return chip ?: ERR_PTR(-EPROBE_DEFER);
+}
+
+struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
+				   const char *con_id, unsigned int idx,
+				   unsigned long *flags)
+{
+	const struct software_node *swnode;
+	struct fwnode_reference_args args;
+	struct gpio_chip *chip;
+	struct gpio_desc *desc;
+	char propname[32]; /* 32 is max size of property name */
+	int error;
+
+	swnode = to_software_node(fwnode);
+	if (!swnode)
+		return ERR_PTR(-EINVAL);
+
+	swnode_format_propname(con_id, propname, sizeof(propname));
+
+	/*
+	 * We expect all swnode-described GPIOs have GPIO number and
+	 * polarity arguments, hence nargs is set to 2.
+	 */
+	error = fwnode_property_get_reference_args(fwnode, propname, NULL, 2, idx, &args);
+	if (error) {
+		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
+			__func__, propname, fwnode, idx);
+		return ERR_PTR(error);
+	}
+
+	chip = swnode_get_chip(args.fwnode);
+	fwnode_handle_put(args.fwnode);
+	if (IS_ERR(chip))
+		return ERR_CAST(chip);
+
+	desc = gpiochip_get_desc(chip, args.args[0]);
+	*flags = args.args[1]; /* We expect native GPIO flags */
+
+	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
+		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));
+
+	return desc;
+}
+
+/**
+ * swnode_gpio_count - count the GPIOs associated with a device / function
+ * @fwnode:	firmware node of the GPIO consumer, can be %NULL for
+ *		system-global GPIOs
+ * @con_id:	function within the GPIO consumer
+ *
+ * Return:
+ * The number of GPIOs associated with a device / function or %-ENOENT,
+ * if no GPIO has been assigned to the requested function.
+ */
+int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
+{
+	struct fwnode_reference_args args;
+	char propname[32];
+	int count;
+
+	swnode_format_propname(con_id, propname, sizeof(propname));
+
+	/*
+	 * This is not very efficient, but GPIO lists usually have only
+	 * 1 or 2 entries.
+	 */
+	count = 0;
+	while (fwnode_property_get_reference_args(fwnode, propname, NULL, 0,
+						  count, &args) == 0) {
+		fwnode_handle_put(args.fwnode);
+		count++;
+	}
+
+	return count ?: -ENOENT;
+}
diff --git a/drivers/gpio/gpiolib-swnode.h b/drivers/gpio/gpiolib-swnode.h
new file mode 100644
index 000000000000..af849e56f6bc
--- /dev/null
+++ b/drivers/gpio/gpiolib-swnode.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef GPIOLIB_SWNODE_H
+#define GPIOLIB_SWNODE_H
+
+struct fwnode_handle;
+struct gpio_desc;
+
+struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
+				   const char *con_id, unsigned int idx,
+				   unsigned long *flags);
+int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
+
+#endif /* GPIOLIB_SWNODE_H */
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b1a57fdd96b6..2f4150bf411a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -26,6 +26,7 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 #include "gpiolib-acpi.h"
+#include "gpiolib-swnode.h"
 #include "gpiolib-cdev.h"
 #include "gpiolib-sysfs.h"
 
@@ -3818,6 +3819,10 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
 			fwnode, con_id);
 		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
+	} else if (is_software_node(fwnode)) {
+		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n",
+			fwnode, con_id);
+		desc = swnode_find_gpio(fwnode, con_id, idx, lookupflags);
 	}
 
 	return desc;
@@ -3935,6 +3940,8 @@ int gpiod_count(struct device *dev, const char *con_id)
 		count = of_gpio_get_count(dev, con_id);
 	else if (is_acpi_node(fwnode))
 		count = acpi_gpio_count(dev, con_id);
+	else if (is_software_node(fwnode))
+		count = swnode_gpio_count(fwnode, con_id);
 
 	if (count < 0)
 		count = platform_gpio_count(dev, con_id);
diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
new file mode 100644
index 000000000000..6c75c8bd44a0
--- /dev/null
+++ b/include/linux/gpio/property.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+#ifndef __LINUX_GPIO_PROPERTY_H
+#define __LINUX_GPIO_PROPERTY_H
+
+#include <dt-bindings/gpio/gpio.h> /* for GPIO_* flags */
+#include <linux/property.h>
+
+#define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
+	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
+
+#endif /* __LINUX_GPIO_PROPERTY_H */

-- 
b4 0.11.0-dev-28747
