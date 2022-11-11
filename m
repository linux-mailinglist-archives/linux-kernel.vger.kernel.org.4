Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6D626487
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiKKWUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiKKWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:19:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5AC9FC0;
        Fri, 11 Nov 2022 14:19:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 130so5989853pfu.8;
        Fri, 11 Nov 2022 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APhmU9DPCCcS9xfuWfJUzV8D2prFRAJPsvhz8PUvWOQ=;
        b=C3vq+MXHtCk2Pcvwlj6k2vvKcv+QfgD+DfDJ1L+pUEyu6NOCtnHXchHKzTmmliSSUx
         /IuW5TfJ8KfAzsBP4XQ8NKVSVwOtoA9Wx16+zWDr4RbwYbpfAZ2ekQDi3c9H45E8ow7d
         IR7s001MM9uy141YypME70W8USDQ8MR7iqbbJYhEt6sxm9PYNPr55+gaQM9kA+ov6jW3
         0fCd+MYPWN5YJp9LSmoU1tqdx+FmKMg2ot3aXdBO+2UaoVVR48Aw+XspWWeaMq0qd35z
         EhiXIs052Ss6eUC83KTc0Pr+zI5ZUDFRPg2zEDk8/emQsjN1gM60exD9e04BBBshu+8H
         ypsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APhmU9DPCCcS9xfuWfJUzV8D2prFRAJPsvhz8PUvWOQ=;
        b=jrk+FRX+OxO3zmeKWJeKJeGAzo0QNkEqhT8HxfX9YlRDln/t4CWhuHEwrh5pfFYe/6
         HV9PBnXNs2AQBZosFfQ70OS3vG9zhh5FoB3Z54MFD4wkBs4s4nKwnSCbZgA7aOTqNpR2
         PLpGxaIs69ybcPwSjAIfwV4XcVu1ZOe0nI5pi0Lv9pG9nAHDnzLPZ78KMq6dUkpif6VU
         WUc4c8NRtKFgk2tRlfaBVG/ot/mJjlWAYRUSiIcOP/35QIDOoZMXHwWAIobDExlsiUXY
         wYuOexebO/l03zyIGL/Gqv/OhIc+E/XpHWSPiiUvlm9/m8h0ooSwK775iNQrfBpvkJF1
         /7Bw==
X-Gm-Message-State: ANoB5pnnbBXzkffwyFSbQmJjozySOwk/p4/E9S7xakoe6nGTldq7u5JS
        zx8oTsK73gI86oL09KFwTU2wMzg6zfE=
X-Google-Smtp-Source: AA0mqf4fWQnDW+jXdMmM5yE0Fo1u+GyKG4mv8VcdVXcLUDPoDKd92s4GH+GDdtNRijDpUQzBh9LeeA==
X-Received: by 2002:a62:f212:0:b0:561:5c6:62f9 with SMTP id m18-20020a62f212000000b0056105c662f9mr4592018pfh.56.1668205160828;
        Fri, 11 Nov 2022 14:19:20 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm2201109pls.125.2022.11.11.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:19:20 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 5/6] gpiolib: consolidate GPIO lookups
Date:   Fri, 11 Nov 2022 14:19:07 -0800
Message-Id: <20221031-gpiolib-swnode-v4-5-6c1671890027@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
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

Ensure that all paths to obtain/look up GPIOD from generic
consumer-visible APIs go through the new gpiod_find_and_request()
helper, so that we can easily extend it with support for new firmware
mechanisms.

The only exception is OF-specific [devm_]gpiod_get_from_of_node() API
that is still being used by a couple of drivers and will be removed as
soon as patches converting them to use generic fwnode/device APIs are
accepted.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c |  39 ---------
 drivers/gpio/gpiolib-acpi.h |  10 ---
 drivers/gpio/gpiolib.c      | 204 +++++++++++++++++---------------------------
 3 files changed, 76 insertions(+), 177 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 1bc386032ca8..bed0380c5136 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1024,45 +1024,6 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 	return desc;
 }
 
-/**
- * acpi_node_get_gpiod() - get a GPIO descriptor from ACPI resources
- * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
- * @propname: Property name of the GPIO
- * @index: index of GpioIo/GpioInt resource (starting from %0)
- * @lflags: bitmask of gpio_lookup_flags GPIO_* values
- * @dflags: gpiod initialization flags
- *
- * If @fwnode is an ACPI device object, call acpi_get_gpiod_by_index() for it.
- * Otherwise (i.e. it is a data-only non-device object), use the property-based
- * GPIO lookup to get to the GPIO resource with the relevant information and use
- * that to obtain the GPIO descriptor to return.
- *
- * If the GPIO cannot be translated or there is an error an ERR_PTR is
- * returned.
- */
-struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
-				      const char *propname, int index,
-				      unsigned long *lflags,
-				      enum gpiod_flags *dflags)
-{
-	struct acpi_gpio_info info;
-	struct acpi_device *adev;
-	struct gpio_desc *desc;
-
-	adev = to_acpi_device_node(fwnode);
-	if (adev)
-		desc = acpi_get_gpiod_by_index(adev, propname, index, &info);
-	else
-		desc = acpi_get_gpiod_from_data(fwnode, propname, index, &info);
-
-	if (!IS_ERR(desc)) {
-		acpi_gpio_update_gpiod_flags(dflags, &info);
-		acpi_gpio_update_gpiod_lookup_flags(lflags, &info);
-	}
-
-	return desc;
-}
-
 /**
  * acpi_dev_gpio_irq_wake_get_by() - Find GpioInt and translate it to Linux IRQ number
  * @adev: pointer to a ACPI device to get IRQ from
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 8880615327ac..9475f99a9694 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -36,10 +36,6 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 unsigned int idx,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags);
-struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
-				      const char *propname, int index,
-				      unsigned long *lflags,
-				      enum gpiod_flags *dflags);
 
 int acpi_gpio_count(struct device *dev, const char *con_id);
 #else
@@ -61,12 +57,6 @@ acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline struct gpio_desc *
-acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
-		    int index, unsigned long *lflags, enum gpiod_flags *dflags)
-{
-	return ERR_PTR(-ENXIO);
-}
 static inline int acpi_gpio_count(struct device *dev, const char *con_id)
 {
 	return -ENODEV;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b213f5f93ae0..7f739096c4cf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -366,7 +366,7 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 {
 	struct gpio_device *gdev = chip->gpiodev;
-	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
+	const struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	const char **names;
 	int ret, i;
 	int count;
@@ -3853,58 +3853,84 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	return count;
 }
 
-/**
- * fwnode_get_named_gpiod - obtain a GPIO from firmware node
- * @fwnode:	handle of the firmware node
- * @propname:	name of the firmware property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * This function can be used for drivers that get their configuration
- * from opaque firmware.
- *
- * The function properly finds the corresponding GPIO using whatever is the
- * underlying firmware interface and then makes sure that the GPIO
- * descriptor is requested before it is returned to the caller.
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-						const char *propname, int index,
-						enum gpiod_flags dflags,
-						const char *label)
+static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
+					      struct device *consumer,
+					      const char *con_id,
+					      unsigned int idx,
+					      enum gpiod_flags *flags,
+					      unsigned long *lookupflags)
 {
-	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	struct gpio_desc *desc = ERR_PTR(-ENODEV);
-	int ret;
+	struct gpio_desc *desc = ERR_PTR(-ENOENT);
 
 	if (is_of_node(fwnode)) {
-		desc = gpiod_get_from_of_node(to_of_node(fwnode),
-					      propname, index,
-					      dflags,
-					      label);
-		return desc;
+		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n",
+			fwnode, con_id);
+		desc = of_find_gpio(to_of_node(fwnode), con_id, idx, lookupflags);
 	} else if (is_acpi_node(fwnode)) {
-		desc = acpi_node_get_gpiod(fwnode, propname, index,
-					   &lflags, &dflags);
-		if (IS_ERR(desc))
-			return desc;
-	} else {
-		return ERR_PTR(-EINVAL);
+		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
+			fwnode, con_id);
+		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
 	}
 
-	/* Currently only ACPI takes this path */
+	return desc;
+}
+
+static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
+						struct fwnode_handle *fwnode,
+						const char *con_id,
+						unsigned int idx,
+						enum gpiod_flags flags,
+						const char *label,
+						bool platform_lookup_allowed)
+{
+	struct gpio_desc *desc = ERR_PTR(-ENOENT);
+	unsigned long lookupflags;
+	int ret;
+
+	if (!IS_ERR_OR_NULL(fwnode))
+		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
+					    &flags, &lookupflags);
+
+	if (gpiod_not_found(desc) && platform_lookup_allowed) {
+		/*
+		 * Either we are not using DT or ACPI, or their lookup did not
+		 * return a result. In that case, use platform lookup as a
+		 * fallback.
+		 */
+		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
+		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
+	}
+
+	if (IS_ERR(desc)) {
+		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
+		return desc;
+	}
+
+	/*
+	 * If a connection label was passed use that, else attempt to use
+	 * the device name as label
+	 */
 	ret = gpiod_request(desc, label);
-	if (ret)
-		return ERR_PTR(ret);
+	if (ret) {
+		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
+			return ERR_PTR(ret);
+
+		/*
+		 * This happens when there are several consumers for
+		 * the same GPIO line: we just return here without
+		 * further initialization. It is a bit of a hack.
+		 * This is necessary to support fixed regulators.
+		 *
+		 * FIXME: Make this more sane and safe.
+		 */
+		dev_info(consumer,
+			 "nonexclusive access to GPIO for %s\n", con_id);
+		return desc;
+	}
 
-	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
+	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (ret < 0) {
+		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
 		gpiod_put(desc);
 		return ERR_PTR(ret);
 	}
@@ -3937,29 +3963,12 @@ static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
  * In case of error an ERR_PTR() is returned.
  */
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
-					 const char *con_id, int index,
+					 const char *con_id,
+					 int index,
 					 enum gpiod_flags flags,
 					 const char *label)
 {
-	struct gpio_desc *desc;
-	char prop_name[32]; /* 32 is max size of property name */
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id)
-			snprintf(prop_name, sizeof(prop_name), "%s-%s",
-					    con_id, gpio_suffixes[i]);
-		else
-			snprintf(prop_name, sizeof(prop_name), "%s",
-					    gpio_suffixes[i]);
-
-		desc = fwnode_get_named_gpiod(fwnode, prop_name, index, flags,
-					      label);
-		if (!gpiod_not_found(desc))
-			break;
-	}
-
-	return desc;
+	return gpiod_find_and_request(NULL, fwnode, con_id, index, flags, label, false);
 }
 EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
 
@@ -4113,72 +4122,11 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 					       unsigned int idx,
 					       enum gpiod_flags flags)
 {
-	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	struct gpio_desc *desc = NULL;
-	int ret;
-	/* Maybe we have a device name, maybe not */
-	const char *devname = dev ? dev_name(dev) : "?";
 	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
+	const char *devname = dev ? dev_name(dev) : "?";
+	const char *label = con_id ?: devname;
 
-	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
-
-	/* Using device tree? */
-	if (is_of_node(fwnode)) {
-		dev_dbg(dev, "using device tree for GPIO lookup\n");
-		desc = of_find_gpio(to_of_node(fwnode),
-				    con_id, idx, &lookupflags);
-	} else if (is_acpi_node(fwnode)) {
-		dev_dbg(dev, "using ACPI for GPIO lookup\n");
-		desc = acpi_find_gpio(fwnode,
-				      con_id, idx, &flags, &lookupflags);
-	}
-
-	/*
-	 * Either we are not using DT or ACPI, or their lookup did not return
-	 * a result. In that case, use platform lookup as a fallback.
-	 */
-	if (!desc || gpiod_not_found(desc)) {
-		dev_dbg(dev, "using lookup tables for GPIO lookup\n");
-		desc = gpiod_find(dev, con_id, idx, &lookupflags);
-	}
-
-	if (IS_ERR(desc)) {
-		dev_dbg(dev, "No GPIO consumer %s found\n", con_id);
-		return desc;
-	}
-
-	/*
-	 * If a connection label was passed use that, else attempt to use
-	 * the device name as label
-	 */
-	ret = gpiod_request(desc, con_id ?: devname);
-	if (ret) {
-		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
-			return ERR_PTR(ret);
-
-		/*
-		 * This happens when there are several consumers for
-		 * the same GPIO line: we just return here without
-		 * further initialization. It is a bit of a hack.
-		 * This is necessary to support fixed regulators.
-		 *
-		 * FIXME: Make this more sane and safe.
-		 */
-		dev_info(dev, "nonexclusive access to GPIO for %s\n", con_id ?: devname);
-		return desc;
-	}
-
-	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
-	if (ret < 0) {
-		dev_dbg(dev, "setup of GPIO %s failed\n", con_id);
-		gpiod_put(desc);
-		return ERR_PTR(ret);
-	}
-
-	blocking_notifier_call_chain(&desc->gdev->notifier,
-				     GPIOLINE_CHANGED_REQUESTED, desc);
-
-	return desc;
+	return gpiod_find_and_request(dev, fwnode, con_id, idx, flags, label, true);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_index);
 

-- 
b4 0.11.0-dev-28747
