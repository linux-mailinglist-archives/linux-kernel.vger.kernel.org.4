Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F498623387
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiKITbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKITa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:30:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EB27917;
        Wed,  9 Nov 2022 11:30:56 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i3so17611097pfc.11;
        Wed, 09 Nov 2022 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AGc3emho2rw8bHzX4XM873wewr02G0nK1D2GVmf5H0=;
        b=accBbSpLQtPccYSWR2w1V1yxh2trznItH90eP3VzdlI1w5OWua8DNFpYHXYPksM1jC
         aW/b9AdWIVzFpM7Vb32hWwDia+jGVbE6QL26dqdLHfbywgPhByH39KRrByeqBBUdZr0c
         M6bw/E16xkJswLtSYebYCYKhDquc+RJMwV7u7uVlxbifg6FqxRM4iilraZS5opRc9E+U
         uHsVnelaIS1KceMpiqN9YsFqP1e9a+Xrpzod8sM2Fn0PuKRY4NYGxDzTfYOfZr9ADgPo
         OOuw9+0jY7grLbmqpjBLJZDiKO2lPPicshlI5piKdTmL2e/N3hsd1e7vgUR9H+wPWQZU
         eCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AGc3emho2rw8bHzX4XM873wewr02G0nK1D2GVmf5H0=;
        b=YVQ1FjIE6QOWhhmQFV9K1c00w/lrLO0LdEASeQH0OZwdviQser0YILMX2YjBveC2F+
         gp/cbdRGUephryJrovpg8ZmXl9qj8z6PtQ2r25hGiLYmx/Dzu6yipPMMmo4MCeNlsp2I
         +K1bzuaDY8U8AvT7wFVnDOG3SAsevFCcBBhC/LiFDOOJfBgirvaxUZ80y8JCt89mwvKm
         rNTdysWTQ0iyeFCCMwjDru7dSSwe5z88SeLjyOYcmIc8Tra7imBZNLRZSqq2xhTthQDn
         DtLU/J4lSFSlHGnhtplmT9v+QqMaRqrDOyuzZ+Ejwb7ito0GOo/ZqoHKYJQktLNd27Zq
         GXqA==
X-Gm-Message-State: ACrzQf1xzX3jvKkbprDFZ0mhDLv3dOiLBDFNC2Ft5koynpew7FOl2jJy
        P77K6m8fLHFWdoO8W+i27vQ=
X-Google-Smtp-Source: AMsMyM4jFe2pq2XxKCz+HJEZnxNPJWwtl7Gt8Kt0ILaiymk77OOVQllTz4UPsYL4GAXiMdxCW3RLtA==
X-Received: by 2002:a63:fc0b:0:b0:46f:87a8:97aa with SMTP id j11-20020a63fc0b000000b0046f87a897aamr52329196pgi.234.1668022255736;
        Wed, 09 Nov 2022 11:30:55 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186ac4b21cfsm9567462plg.230.2022.11.09.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:30:55 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 4/6] gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
Date:   Wed,  9 Nov 2022 11:30:42 -0800
Message-Id: <20221031-gpiolib-swnode-v3-4-0282162b0fa4@gmail.com>
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

There is no need for the generic parts of GPIOLIB to be aware of
implementation details of ACPI-bases lookups.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 51 ++++++++++++++++++++++++++++++++++++++-------
 drivers/gpio/gpiolib-acpi.h | 46 +++-------------------------------------
 drivers/gpio/gpiolib.c      |  8 ++-----
 3 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d51bf2a3203d..1bc386032ca8 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -89,6 +89,30 @@ struct acpi_gpio_chip {
 	struct list_head deferred_req_irqs_list_entry;
 };
 
+/**
+ * struct acpi_gpio_info - ACPI GPIO specific information
+ * @adev: reference to ACPI device which consumes GPIO resource
+ * @flags: GPIO initialization flags
+ * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
+ * @pin_config: pin bias as provided by ACPI
+ * @polarity: interrupt polarity as provided by ACPI
+ * @triggering: triggering type as provided by ACPI
+ * @wake_capable: wake capability as provided by ACPI
+ * @debounce: debounce timeout as provided by ACPI
+ * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
+ */
+struct acpi_gpio_info {
+	struct acpi_device *adev;
+	enum gpiod_flags flags;
+	bool gpioint;
+	int pin_config;
+	int polarity;
+	int triggering;
+	bool wake_capable;
+	unsigned int debounce;
+	unsigned int quirks;
+};
+
 /*
  * For GPIO chips which call acpi_gpiochip_request_interrupts() before late_init
  * (so builtin drivers) we register the ACPI GpioInt IRQ handlers from a
@@ -670,8 +694,8 @@ __acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
 	return ret;
 }
 
-int
-acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
+static int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
+				        struct acpi_gpio_info *info)
 {
 	struct device *dev = &info->adev->dev;
 	enum gpiod_flags old = *flags;
@@ -690,8 +714,8 @@ acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *inf
 	return ret;
 }
 
-int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
-					struct acpi_gpio_info *info)
+static int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
+					       struct acpi_gpio_info *info)
 {
 	switch (info->pin_config) {
 	case ACPI_PIN_CONFIG_PULLUP:
@@ -1005,7 +1029,8 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
  * @propname: Property name of the GPIO
  * @index: index of GpioIo/GpioInt resource (starting from %0)
- * @info: info pointer to fill in (optional)
+ * @lflags: bitmask of gpio_lookup_flags GPIO_* values
+ * @dflags: gpiod initialization flags
  *
  * If @fwnode is an ACPI device object, call acpi_get_gpiod_by_index() for it.
  * Otherwise (i.e. it is a data-only non-device object), use the property-based
@@ -1017,15 +1042,25 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  */
 struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 				      const char *propname, int index,
-				      struct acpi_gpio_info *info)
+				      unsigned long *lflags,
+				      enum gpiod_flags *dflags)
 {
+	struct acpi_gpio_info info;
 	struct acpi_device *adev;
+	struct gpio_desc *desc;
 
 	adev = to_acpi_device_node(fwnode);
 	if (adev)
-		return acpi_get_gpiod_by_index(adev, propname, index, info);
+		desc = acpi_get_gpiod_by_index(adev, propname, index, &info);
+	else
+		desc = acpi_get_gpiod_from_data(fwnode, propname, index, &info);
 
-	return acpi_get_gpiod_from_data(fwnode, propname, index, info);
+	if (!IS_ERR(desc)) {
+		acpi_gpio_update_gpiod_flags(dflags, &info);
+		acpi_gpio_update_gpiod_lookup_flags(lflags, &info);
+	}
+
+	return desc;
 }
 
 /**
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index bd1f9b92ea9e..8880615327ac 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -22,30 +22,6 @@ struct gpio_chip;
 struct gpio_desc;
 struct gpio_device;
 
-/**
- * struct acpi_gpio_info - ACPI GPIO specific information
- * @adev: reference to ACPI device which consumes GPIO resource
- * @flags: GPIO initialization flags
- * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
- * @pin_config: pin bias as provided by ACPI
- * @polarity: interrupt polarity as provided by ACPI
- * @triggering: triggering type as provided by ACPI
- * @wake_capable: wake capability as provided by ACPI
- * @debounce: debounce timeout as provided by ACPI
- * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
- */
-struct acpi_gpio_info {
-	struct acpi_device *adev;
-	enum gpiod_flags flags;
-	bool gpioint;
-	int pin_config;
-	int polarity;
-	int triggering;
-	bool wake_capable;
-	unsigned int debounce;
-	unsigned int quirks;
-};
-
 #ifdef CONFIG_ACPI
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
@@ -55,11 +31,6 @@ void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
-int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
-				 struct acpi_gpio_info *info);
-int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
-					struct acpi_gpio_info *info);
-
 struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 const char *con_id,
 				 unsigned int idx,
@@ -67,7 +38,8 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 unsigned long *lookupflags);
 struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 				      const char *propname, int index,
-				      struct acpi_gpio_info *info);
+				      unsigned long *lflags,
+				      enum gpiod_flags *dflags);
 
 int acpi_gpio_count(struct device *dev, const char *con_id);
 #else
@@ -82,18 +54,6 @@ acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 static inline void
 acpi_gpiochip_free_interrupts(struct gpio_chip *chip) { }
 
-static inline int
-acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
-{
-	return 0;
-}
-static inline int
-acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
-				    struct acpi_gpio_info *info)
-{
-	return 0;
-}
-
 static inline struct gpio_desc *
 acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
 	       unsigned int idx, enum gpiod_flags *dflags,
@@ -103,7 +63,7 @@ acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
 }
 static inline struct gpio_desc *
 acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
-		    int index, struct acpi_gpio_info *info)
+		    int index, unsigned long *lflags, enum gpiod_flags *dflags)
 {
 	return ERR_PTR(-ENXIO);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index eebcdaca5e06..f0a7a59ac630 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3838,14 +3838,10 @@ static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 					      label);
 		return desc;
 	} else if (is_acpi_node(fwnode)) {
-		struct acpi_gpio_info info;
-
-		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
+		desc = acpi_node_get_gpiod(fwnode, propname, index,
+					   &lflags, &dflags);
 		if (IS_ERR(desc))
 			return desc;
-
-		acpi_gpio_update_gpiod_flags(&dflags, &info);
-		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
 	} else {
 		return ERR_PTR(-EINVAL);
 	}

-- 
b4 0.11.0-dev-28747
