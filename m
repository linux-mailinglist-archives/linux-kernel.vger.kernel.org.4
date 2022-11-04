Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37FE6190BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiKDGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKDGKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:10:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4929342;
        Thu,  3 Nov 2022 23:10:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e129so3567810pgc.9;
        Thu, 03 Nov 2022 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2/aVQ0pMiGyvsxYh3JvcOH3C/8mHWBmqc26g+70UqY=;
        b=EuGPyG06evvdLIq7DCUkREdSdsmfXSS2DqkyqHCmHJBk4jtg3BgUwPIB287GilRWuq
         S7ZMfZRi2Rk+oYayJxiCrvSgyPviSjyvjI9XMKi49eVUxLbjq5tVG/oKuKxFfZ+jmYll
         c3VsOhKT1dYgPMui09dDcTnqu1aMW1ti8NqbyTV6QnlU5EJ6lgfcY0RNPNPXnqPILM+E
         wEIHbsqIvYJfbTEmk3srvwSvzCvsHfjAqKjHdClQWK4hAS7CeH37AX+9Ew0rbB64wcVi
         wDwN8oBxKgvsd33J6dNAttl23wXFhYtnt6UcJ6etFikv06DA/Wkr2ktWad5yE307AFa1
         PR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2/aVQ0pMiGyvsxYh3JvcOH3C/8mHWBmqc26g+70UqY=;
        b=nidHMFXM4FwrPq9EJBRxu5Gwyl+P5QRZcoM+3swUHivMeeLdiJYvOxlQ+/DAJW621G
         bPQurNEoWpgc+B1Sf6SoQcEJvPzuIyvxONg80aYJkBonJmXtaMeptyrQeRaJAmZJ3E3b
         XwoJeAHTiWEXW87Ze7Ohv2aRYisK4UXXFe46mlqhWbG73M2ezfSIPDlDUWhIC+NZcFsm
         8e+LbUN3YIGQCZV9y69zJl4Gea+u41zFS6dysyPS74sA/9r8OTRGU3Oyi48i1erCyJin
         3Y1+BVJ537XSakIHHbeqwJoM0JusBeP49H8t1e6i5rbOZeFgVEiyG9zACiNN2uqKlO31
         7R0w==
X-Gm-Message-State: ACrzQf2xP3Mfr2st60E0d8SaRMRiZiGFEddJxRHimrAJlS65bemK1jZj
        /Ic1Cxll9kGrcXvSrZYjctgnZUQrhj4=
X-Google-Smtp-Source: AMsMyM4Xk/WfThtJCg+gf2/ER+SintXyzxSQPqF4lS+NEW33Ua6QoayP2unbg42aiJWOTOfyw7UU2A==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id bj6-20020a056a02018600b0043125fbf1femr29925755pgb.130.1667542227622;
        Thu, 03 Nov 2022 23:10:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79ac5000000b0056bfd4a2702sm1791411pfp.45.2022.11.03.23.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:10:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
Date:   Thu,  3 Nov 2022 23:10:14 -0700
Message-Id: <20221031-gpiolib-swnode-v1-4-a0ab48d229c7@gmail.com>
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

There is no need for the generic parts of GPIOLIB to be aware of
implementation details of ACPI-bases lookups.

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
