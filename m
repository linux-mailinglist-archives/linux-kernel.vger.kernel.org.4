Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684D16220C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKIA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKIA1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:27:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A061762;
        Tue,  8 Nov 2022 16:27:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id io19so15622383plb.8;
        Tue, 08 Nov 2022 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlcf6K0fvrpHjK0WpwcdporIi8K80mxmLgEaAmXhKG8=;
        b=ps5AbPS9Okyf/Gs9daJxzryher8XSwbIjH41tljfk0O6Mi13Uukh1jsyVoHAIzlLeh
         Qnpdm0UKb1GDQQCHTOctt/WbtHMp2tKSikxHcDsTfkMih4rwp3GrMhNzYHFKWMF0rJ9n
         tK5DgGPZwa3Va2K7umQEO+e3ETdRC3n59n2tXDYR3CbWTugBAvxikBkLOJUCnQ/EPee6
         D/LzOonOLkoK6m9R5Z4aUM3lwX5H/dqsDZhUhnxrtZbev93y+NuMPsiKAumiQ4VY+Xr6
         BKmYAqOckk6l58yLO/7sAwr5tHjET1+TInmC/nW1Jg/fLkM0A7J7hL1KhE+qwsjQmMBD
         hzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlcf6K0fvrpHjK0WpwcdporIi8K80mxmLgEaAmXhKG8=;
        b=RVjWy1Uk4jCpxKqdR2cLOuDzHCTHmfsLoIDocJ7D0Y+LItJsNkyBdS8dttqJEL26z4
         l8r/c2yNP5MkUZ8lqGjaAEdLPBJdeW4XNrTDA0dUzif6JZMklR8oy7dRHcRbM384NW90
         d3oFqmHa+RfwSz2rWTCnhcJBBahPwGIVLmTJ7u2vNY/+y4Qoc0S9TFKm5Am1Hp0AE3HG
         uF8o+paIl5yCL2tomaX6DqoCSCgyyKHFjKUTeVF+X/CXqvQXQ3kt2uxnRqelp087ddcC
         u5y1IeZ9VhnjvAgURHFAn8v6cr0NW9aBry+813NTtW757VMTGfvMDvc9huiZtApPP0DL
         7l5g==
X-Gm-Message-State: ACrzQf2tqIOg6N7ssOaTQWP1HaxWzBIgHo6wKrjFDxzB1FUb+Z6eI7Lv
        x0vBwL9ZD5Vq9CGZu6lDAv9QAivn4Co=
X-Google-Smtp-Source: AMsMyM5ErGzcRzxNW3hkneESQO9FOl/N8MqlS4MwBnpOQtlyr7i6Gssov+ct/g0GqOL9KFIQfHvSlQ==
X-Received: by 2002:a17:902:db12:b0:187:4736:f780 with SMTP id m18-20020a170902db1200b001874736f780mr36661880plx.145.1667953624844;
        Tue, 08 Nov 2022 16:27:04 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id i65-20020a626d44000000b0056bd737fdf3sm6907324pfc.123.2022.11.08.16.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:27:04 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] gpiolib: consolidate GPIO lookups
Date:   Tue,  8 Nov 2022 16:26:50 -0800
Message-Id: <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
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
 drivers/gpio/gpiolib.c      | 207 +++++++++++++++++---------------------------
 3 files changed, 81 insertions(+), 175 deletions(-)

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
index f0a7a59ac630..c33ffdd47667 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3801,58 +3801,89 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
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
+	struct gpio_desc *desc;
 
+	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%pfw'\n",
+		con_id, fwnode);
+
+	/* Using device tree? */
 	if (is_of_node(fwnode)) {
-		desc = gpiod_get_from_of_node(to_of_node(fwnode),
-					      propname, index,
-					      dflags,
-					      label);
-		return desc;
+		dev_dbg(consumer, "using device tree for GPIO lookup\n");
+		desc = of_find_gpio(to_of_node(fwnode),
+				    con_id, idx, lookupflags);
 	} else if (is_acpi_node(fwnode)) {
-		desc = acpi_node_get_gpiod(fwnode, propname, index,
-					   &lflags, &dflags);
-		if (IS_ERR(desc))
-			return desc;
+		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
+		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
 	} else {
-		return ERR_PTR(-EINVAL);
+		desc = ERR_PTR(-ENOENT);
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
@@ -3885,29 +3916,13 @@ static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
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
+	return gpiod_find_and_request(NULL, fwnode, con_id, index, flags, label,
+				      false);
 }
 EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
 
@@ -4061,72 +4076,12 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
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
+	return gpiod_find_and_request(dev, fwnode, con_id, idx, flags, label,
+				      true);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_index);
 

-- 
b4 0.11.0-dev-28747
