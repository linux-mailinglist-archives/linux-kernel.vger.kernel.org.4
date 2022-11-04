Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0A6190C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKDGLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKDGKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:10:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE429367;
        Thu,  3 Nov 2022 23:10:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2458205pjs.4;
        Thu, 03 Nov 2022 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz3SxtBsg329L+3fRZS9MYteoJhzga8XhsBAQr3LWvc=;
        b=Ruzp+sbx3l3D0LY8ZrkEtOhqSqzNEGZZhjEn7RrR+eiTLQRB/s9ZOULcIF1So2tulI
         jamvz+Y8M7yGw1cLUGBbOClP8sHExevgHsx8bT9GnAi5eEtFx4/kzKnQreP0wpPqP8OH
         Lsc6p/xs+eLlrFKUpldHaDudajoua/QsW2XFlBQdUEUYYryZzppCl016K4bNY8xW8D46
         bZJx1a6kY1lJHf3GmvoCO2n5rFnaOqN8JvB/BHjAATPsYIXxg2lZIM8qiM9EcMJ6qeO2
         MgpDY8UUHCbtCyxym3awOV56LDo40Te7SzWq9ac+GEkSm/EjNLLPUcJbwxA4U+9g81GV
         UW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz3SxtBsg329L+3fRZS9MYteoJhzga8XhsBAQr3LWvc=;
        b=OZHg1vEO2yp8zdWG1dGDFODPxO5OHoH7B/WGzdvGvzpHK5OaIbsQdf2d2u1IKs11r7
         E+qAUvxTKQ0ECpCRWDQ3p/K/RRZ2Uhieb/nmN+ugPfHEjsYQX+nTi3HhdoFfuMtAD/Tn
         IfxJ4cgrD6PHURheosTurX9DYYKy1Sy34NE8GgqDffGHKpwfXbkVZjcScz5h2KeA8Nj/
         CgURcPh28XMWxizwgXtX3OSL27ap2zGq7k4yJ4/Io29hQ0lSuQeQEMXq9rZ7/Vzgl/uc
         u/HRr1YN5eKZbRI/KUxTGlMUZ61eyCVvleKGFrgZ/Ivcwi4S0tGhJK+uAhpMZXxzZ6Tj
         kP4w==
X-Gm-Message-State: ACrzQf2vEn58Je3pFZ7KEnEXgcdMYnDaWd5NhhAphJx5VVsXylLuY9yq
        x83nqUFMOX9S+3qNGSjYqBw=
X-Google-Smtp-Source: AMsMyM5Z1Bg6zvy47FTBq2SK6m6jaOV7nAaWMlEyzwu33RoZwJg7cuJTj91r2nYhR3N0PZJx09bHmw==
X-Received: by 2002:a17:90a:24b:b0:213:9da2:5c98 with SMTP id t11-20020a17090a024b00b002139da25c98mr35329803pje.123.1667542230785;
        Thu, 03 Nov 2022 23:10:30 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79ac5000000b0056bfd4a2702sm1791411pfp.45.2022.11.03.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:10:30 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] gpiolib: add support for software nodes
Date:   Thu,  3 Nov 2022 23:10:16 -0700
Message-Id: <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
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
  GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc).
- name of the software node representing gpiochip must match label of
  the gpiochip, as we use it to locate gpiochip structure at runtime.

const struct software_node gpio_bank_b_node = {
	.name = "B",
};

const struct property_entry simone_key_enter_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
	PROPERTY_ENTRY_STRING("label", "enter"),
	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
	{ }
};

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpiolib-swnode.c | 106 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-swnode.h |  13 ++++++
 drivers/gpio/gpiolib.c        |  35 +++++++++++++-
 4 files changed, 153 insertions(+), 2 deletions(-)

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
index 000000000000..d005ce0b986d
--- /dev/null
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Software Node helpers for the GPIO API
+ *
+ * Copyright 2022 Google LLC
+ */
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+
+#include "gpiolib.h"
+#include "gpiolib-swnode.h"
+
+static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
+struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
+				   const char *con_id, unsigned int idx,
+				   unsigned long *flags)
+{
+	const struct software_node *chip_node;
+	const struct software_node *swnode;
+	struct fwnode_reference_args args;
+	struct gpio_chip *chip;
+	struct gpio_desc *desc;
+	char prop_name[32]; /* 32 is max size of property name */
+	int error;
+
+	swnode = to_software_node(fwnode);
+	if (!swnode)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Note we do not need to try both -gpios and -gpio suffixes,
+	 * as, unlike OF and ACPI, we can fix software nodes to conform
+	 * to the proper binding.
+	 */
+	if (con_id)
+		snprintf(prop_name, sizeof(prop_name), "%s-gpios", con_id);
+	else
+		strscpy(prop_name, "gpios", sizeof(prop_name));
+
+	/*
+	 * We expect all swnode-described GPIOs have GPIO number and
+	 * polarity arguments, hence nargs is set to 2.
+	 */
+	error = fwnode_property_get_reference_args(fwnode, prop_name, NULL,
+						   2, idx, &args);
+	if (error) {
+		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
+			__func__, prop_name, fwnode, idx);
+		return ERR_PTR(error);
+	}
+
+	chip_node = to_software_node(args.fwnode);
+	if (!chip_node || !chip_node->name)
+		return ERR_PTR(-EINVAL);
+
+	chip = gpiochip_find((void *)chip_node->name,
+			     swnode_gpiochip_match_name);
+	if (!chip)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	desc = gpiochip_get_desc(chip, args.args[0]);
+	*flags = args.args[1]; /* We expect native GPIO flags */
+
+	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
+		 __func__, prop_name, fwnode, idx, PTR_ERR_OR_ZERO(desc));
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
+int swnode_gpio_count(struct fwnode_handle *fwnode, const char *con_id)
+{
+	struct fwnode_reference_args args;
+	char prop_name[32];
+	int count;
+
+	if (con_id)
+		snprintf(prop_name, sizeof(prop_name), "%s-gpios", con_id);
+	else
+		strscpy(prop_name, "gpios", sizeof(prop_name));
+
+	/*
+	 * This is not very efficient, but GPIO lists usually have only
+	 * 1 or 2 entries.
+	 */
+	count = 0;
+	while (fwnode_property_get_reference_args(fwnode, prop_name, NULL,
+						  0, count, &args) == 0)
+		count++;
+
+	return count ? count : -ENOENT;
+}
diff --git a/drivers/gpio/gpiolib-swnode.h b/drivers/gpio/gpiolib-swnode.h
new file mode 100644
index 000000000000..afd51c9b6e34
--- /dev/null
+++ b/drivers/gpio/gpiolib-swnode.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef GPIOLIB_SWNODE_H
+#define GPIOLIB_SWNODE_H
+
+struct fwnode_handle;
+
+struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
+				   const char *con_id, unsigned int idx,
+				   unsigned long *flags);
+int swnode_gpio_count(struct fwnode_handle *fwnode, const char *con_id);
+
+#endif /* GPIOLIB_SWNODE_H */
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 79aaba693c4f..b9976485587d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -26,6 +26,7 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 #include "gpiolib-acpi.h"
+#include "gpiolib-swnode.h"
 #include "gpiolib-cdev.h"
 #include "gpiolib-sysfs.h"
 
@@ -3813,6 +3814,19 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%s'\n",
 		con_id, fwnode_get_name(fwnode));
 
+	/*
+	 * First look up GPIO in the secondary software node in case
+	 * it was used to store updated properties.
+	 */
+	if (is_software_node(fwnode->secondary)) {
+		dev_dbg(consumer,
+			"using secondary software node for GPIO lookup\n");
+		desc = swnode_find_gpio(fwnode->secondary,
+					con_id, idx, lookupflags);
+		if (!gpiod_not_found(desc))
+			return desc;
+	}
+
 	/* Using device tree? */
 	if (is_of_node(fwnode)) {
 		dev_dbg(consumer, "using device tree for GPIO lookup\n");
@@ -3821,6 +3835,9 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	} else if (is_acpi_node(fwnode)) {
 		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
 		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
+	} else if (is_software_node(fwnode)) {
+		dev_dbg(consumer, "using software node for GPIO lookup\n");
+		desc = swnode_find_gpio(fwnode, con_id, idx, lookupflags);
 	}
 
 	return desc;
@@ -3933,13 +3950,27 @@ EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
  */
 int gpiod_count(struct device *dev, const char *con_id)
 {
-	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
-	int count = -ENOENT;
+	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
+	int count;
+
+	/*
+	 * First look up GPIO in the secondary software node in case
+	 * it was used to store updated properties.
+	 */
+	if (!IS_ERR_OR_NULL(fwnode) && is_software_node(fwnode->secondary)) {
+		count = swnode_gpio_count(fwnode->secondary, con_id);
+		if (count > 0)
+			return count;
+	}
 
 	if (is_of_node(fwnode))
 		count = of_gpio_get_count(dev, con_id);
 	else if (is_acpi_node(fwnode))
 		count = acpi_gpio_count(dev, con_id);
+	else if (is_software_node(fwnode))
+		count = swnode_gpio_count(fwnode, con_id);
+	else
+		count = -ENOENT;
 
 	if (count < 0)
 		count = platform_gpio_count(dev, con_id);

-- 
b4 0.11.0-dev-28747
