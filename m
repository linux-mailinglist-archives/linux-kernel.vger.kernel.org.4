Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C675C03F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiIUQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiIUQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:19:32 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC71ABF2D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:03:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 207so6370101pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WRBW2mcaW8+vq4yiHKY35m1Azs9z2RcONx9gHz7vf2U=;
        b=VO4cs48ZFpEYZaKH/qDgmC15+Cy7PkP8Q+OnAIp5BxL8et2TZ4/axXYXBTu9PM83Hj
         X+n+cGoEAsRvSLLrluQaShmzaFmqc3bXhQq2Kdre5XX2H/jN3hmwbI42tIqfIm++/Mya
         EMWhewuhv5ako3Xe4dAr8UOWWMaWevb6RXbCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WRBW2mcaW8+vq4yiHKY35m1Azs9z2RcONx9gHz7vf2U=;
        b=OXS2deZdZ9t6Gfs4Ughox+8tX3ZYMKzYi0EJ0913xgMjPjnxUf3n5oBJm6cyprTecH
         XyUB+CH8+fXUIUqxXsr0ljRQjLzq4pCpNsFcH+U8NAAcrELn0F+SxCT31yUhkWTnO8ik
         GXedcLSH7WyXYxAaskb7+CSYvRE0ac4TAaR4YMff6KYn9QggwHojK+c2rsjyaIhibKwP
         VfnGugnS+GBJ+dfb5SnXr9XEyttX46ZMuQyYdtyI9/Y+gqM9mPJIcUH9Zj0ram5ZRsWB
         o6ZQsjStK4Cm8/9NmCem0PJXVa9STm/c3PiZe7//S7cF9f8Rzj/rNwM7Kz7UfPh9z78M
         OdwA==
X-Gm-Message-State: ACrzQf32Qwceed6sdRQh2zISdLhjB1IK7y2yEFusGXKQQaEBHS8a7K+I
        BkdLgNr7DKpuxbs+LsfkWcCbMt7YWQ9MaA==
X-Google-Smtp-Source: AMsMyM5VPyvR6DQIqZsmpPS/DoMS/CArQiSDJLVISllh+W2lBYZzsvjugS90olTzlvJDy+CVhZc1Xw==
X-Received: by 2002:a05:6e02:1ba7:b0:2f5:be22:6ba9 with SMTP id n7-20020a056e021ba700b002f5be226ba9mr6594196ili.295.1663775535297;
        Wed, 21 Sep 2022 08:52:15 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:14 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/13] gpiolib: acpi: Add wake_capable variants of acpi_dev_gpio_irq_get
Date:   Wed, 21 Sep 2022 09:51:57 -0600
Message-Id: <20220921094736.v5.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

(no changes since v4)

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

