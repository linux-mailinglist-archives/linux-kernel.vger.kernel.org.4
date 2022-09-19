Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47425BD19F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiISP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiISP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:59:27 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7253204C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:25 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k9so15019335ils.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gXED57WKwVckRdQHbwT2Eq6sa7aYhI4W+2TJa3JDciU=;
        b=Mf1sBOPNqNg/sKZp2k/opTsjg5aLh8aokxFtkl9Y56d9Q62K2hEgRvMoPz9sxbY5dp
         apChXkmJxwM5/z8VqJqyaLXqF04qDq0De9EYs+s9zMBIjEEu1kSYEgEn3Wa1kMlUyccX
         N0TvWQz0ecUKmg3Cuc/frUPAweu2gIZnm803g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gXED57WKwVckRdQHbwT2Eq6sa7aYhI4W+2TJa3JDciU=;
        b=NBya9OGyfsx33j7Bt8JBig3FmRA/jgk5jtACUL80pjH4p42RiqZZUbJz7yyIir7b62
         kaCah7Lm0JrNr1HBopBv6O3eCpix0rTNT/fL514oT/S2EVOeHum2SRnBmUPlAKTAZEul
         2yaDFi96scLvBbp9Qr+pCbFKppHlCuPyOouMHdQYZNg5Uzuu6KkD/Sko51IgUU7PhVid
         WMCtO47fxTHxtbQzh+37vECMjymdajAsoTgSHWSIRr5ycLy0Ovw+Ofy442vq8YYkdeeE
         A1Q+OWOxB/AQbDsKkhU8jv+b5yvqGVLz+oHqAIGynNQ3ch2b4/NacTUkC2TuTo5UTIPj
         FfNA==
X-Gm-Message-State: ACrzQf2Lq3mw5ljFFrh4ctWmqrXQ/JinYPyYMZkeJXwCSNu2tZyu9Ro4
        JsSlMFdgYpyc4yjCawap3uCw5A==
X-Google-Smtp-Source: AMsMyM7c7Kxuux7MVeUl6bcD7vQjd9LVs5yY0daMec3JRJLy/jJIpBqjLIQVjwgBWZqzrNB0WDf3rw==
X-Received: by 2002:a92:c60e:0:b0:2f4:c4eb:86a3 with SMTP id p14-20020a92c60e000000b002f4c4eb86a3mr7596822ilm.193.1663603164782;
        Mon, 19 Sep 2022 08:59:24 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:24 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/13] gpiolib: acpi: Add wake_capable variants of acpi_dev_gpio_irq_get
Date:   Mon, 19 Sep 2022 09:59:07 -0600
Message-Id: <20220919095504.v4.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220919155916.1044219-1-rrangel@chromium.org>
References: <20220919155916.1044219-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI spec defines the SharedAndWake and ExclusiveAndWake share type
keywords. This is an indication that the GPIO IRQ can also be used as a
wake source. This change exposes the wake_capable bit so drivers can
correctly enable wake functionality instead of making an assumption.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v4:
- Added Reviewed-by
- Reformatted with 96 char limit

Changes in v3:
- Kept `acpi_dev_gpio_irq_get_by` unchanged to avoid having to touch
  unrelated drivers.
- Converted wake_capable parameter to bool.

Changes in v2:
- Fixed call site in mlxbf_gige_probe

 drivers/gpio/gpiolib-acpi.c | 15 ++++++++++++---
 drivers/gpio/gpiolib-acpi.h |  2 ++
 include/linux/acpi.h        | 21 +++++++++++++++++----
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 9be1376f9a627f..1f2ade475b36cb 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -741,6 +741,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		lookup->info.pin_config = agpio->pin_config;
 		lookup->info.debounce = agpio->debounce_timeout;
 		lookup->info.gpioint = gpioint;
+		lookup->info.wake_capable = agpio->wake_capable == ACPI_WAKE_CAPABLE;
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
@@ -987,10 +988,11 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 }
 
 /**
- * acpi_dev_gpio_irq_get_by() - Find GpioInt and translate it to Linux IRQ number
+ * acpi_dev_gpio_irq_wake_get_by() - Find GpioInt and translate it to Linux IRQ number
  * @adev: pointer to a ACPI device to get IRQ from
  * @name: optional name of GpioInt resource
  * @index: index of GpioInt resource (starting from %0)
+ * @wake_capable: Set to true if the IRQ is wake capable
  *
  * If the device has one or more GpioInt resources, this function can be
  * used to translate from the GPIO offset in the resource to the Linux IRQ
@@ -1002,9 +1004,13 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
  * The function takes optional @name parameter. If the resource has a property
  * name, then only those will be taken into account.
  *
+ * The GPIO is considered wake capable if the GpioInt resource specifies
+ * SharedAndWake or ExclusiveAndWake.
+ *
  * Return: Linux IRQ number (> %0) on success, negative errno on failure.
  */
-int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index)
+int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
+				  bool *wake_capable)
 {
 	int idx, i;
 	unsigned int irq_flags;
@@ -1061,13 +1067,16 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
 				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
 			}
 
+			if (wake_capable)
+				*wake_capable = info.wake_capable;
+
 			return irq;
 		}
 
 	}
 	return -ENOENT;
 }
-EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get_by);
+EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_wake_get_by);
 
 static acpi_status
 acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index e476558d947136..1ac6816839dbce 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -18,6 +18,7 @@ struct acpi_device;
  * @pin_config: pin bias as provided by ACPI
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
+ * @wake_capable: wake capability as provided by ACPI
  * @debounce: debounce timeout as provided by ACPI
  * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
  */
@@ -28,6 +29,7 @@ struct acpi_gpio_info {
 	int pin_config;
 	int polarity;
 	int triggering;
+	bool wake_capable;
 	unsigned int debounce;
 	unsigned int quirks;
 };
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc5479..cd7371a5f2839b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1202,7 +1202,8 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio);
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio);
-int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index);
+int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
+				  bool *wake_capable);
 #else
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 					      struct acpi_resource_gpio **agpio)
@@ -1214,16 +1215,28 @@ static inline bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 {
 	return false;
 }
-static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
-					   const char *name, int index)
+static inline int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name,
+						int index, bool *wake_capable)
 {
 	return -ENXIO;
 }
 #endif
 
+static inline int acpi_dev_gpio_irq_wake_get(struct acpi_device *adev, int index,
+					     bool *wake_capable)
+{
+	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, wake_capable);
+}
+
+static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name,
+					   int index)
+{
+	return acpi_dev_gpio_irq_wake_get_by(adev, name, index, NULL);
+}
+
 static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
-	return acpi_dev_gpio_irq_get_by(adev, NULL, index);
+	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, NULL);
 }
 
 /* Device properties */
-- 
2.37.3.968.ga6b4b080e4-goog

