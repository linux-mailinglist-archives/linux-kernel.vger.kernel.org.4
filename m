Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB52626486
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiKKWT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKKWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:19:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE8764B;
        Fri, 11 Nov 2022 14:19:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i3so5973598pfc.11;
        Fri, 11 Nov 2022 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60P3J0y149EyGBoZLBStpQQvxKuOIBBd4mP4nIg9n+c=;
        b=oftPQjcwOT54O+z5jyzuqIHQhrxWZWRHQBLEjdKuk7Jv7pycZf07molaMW+Yndy0R+
         KOdh0x258EucSy7w81+twMyZPW7SXC9XcLvfsYbVWPOPmMfSHcHgEJgRByVsugt2gbms
         f5QaSh1Ka6sUTyNBWg/ukhw5I8PwvDXKr2D6ABQBNHI/cNAludgTkNg/JUETa0UrnF/S
         1s1VAveTjOM7tztgvLjYXLZBzaSsYQOk6iS21JOxfhH9rqMvFXu3jjYLQPlvEV6DFOUk
         rpo31kEuF+DCdMOdHfVHJtqzxblAmig0DU5bn3P23lrOl1DFQht9r69ImK2hK+SJg441
         /SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60P3J0y149EyGBoZLBStpQQvxKuOIBBd4mP4nIg9n+c=;
        b=NeAZTPGOhameWw8SPGaDCYTHBj0LSk0vBBd4NXIlhvJr909YSgg7f7PzkZOtuFKNuk
         GYFM+SV9MDd2rer7t4MddtGOAQXlz/k6pIrDMpSb5YL6SoiPgRcoj7EmKbBe10YczXT9
         jRfajodEOjfHqCN3XVPDr4XuElsFP5HnSJy3e5kww6aEOOjJytbPq1R5wRO1JvMnCw0z
         sNg61+z1x7ebawNPSPZL5PVeYUcEcbpQt7IUur14VlzfVkLkn2vuvdmCKMfL1djBJQr3
         mRmKOKwHLMVSz15IJhgf/NLr/Wdphr6KuLOG+OfRoFnUc3e5Sx/e2p7K+UcyWuA3rv16
         ExGQ==
X-Gm-Message-State: ANoB5pl0UjEdp6Rq/w9XAKurLHAuVPEYPBK6fdIUHrTWEOsV9bTEdEoz
        G6ZO8ITTPfqURm3NMGhxx7qE1JEI0tc=
X-Google-Smtp-Source: AA0mqf5OQl6XG+k+g95dEFnEcUdFvn4C4qMHbwi+DtQS9zX/cK50aAt5McLgFhYylXU0xnYT0c4f+g==
X-Received: by 2002:aa7:953b:0:b0:56b:6936:ddf6 with SMTP id c27-20020aa7953b000000b0056b6936ddf6mr4497717pfp.84.1668205159210;
        Fri, 11 Nov 2022 14:19:19 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm2201109pls.125.2022.11.11.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:19:18 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 4/6] gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
Date:   Fri, 11 Nov 2022 14:19:06 -0800
Message-Id: <20221031-gpiolib-swnode-v4-4-6c1671890027@gmail.com>
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
index e874bb0ef685..b213f5f93ae0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3890,14 +3890,10 @@ static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
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
