Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7A5EFA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiI2QUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiI2QT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:19:29 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F451E05DA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:27 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j7so945110ilu.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbifdhnu3DLGLXjvettr8aEuyeI86xUz+R1GY8PSjLs=;
        b=FtP3pMDwImt/olDyHcdPYBplAO3tprF/43+wk9yPhNSJrQyOh8SWcLlHHwRO3m4w91
         WdMRUdwAqU+t6gCO4duxOjazgYKakAuI/ekJLlM727hAzat3eGTva2+/adRvyL24S7v0
         IM7SBchSbo4Nbu/DwRItvi5LKqerp+Uzt6JKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbifdhnu3DLGLXjvettr8aEuyeI86xUz+R1GY8PSjLs=;
        b=mw/5CHtethHOPrMvoIzhd/gtdLL3zeoJHNJfm5SpBVhnI5FxgvbTMXCDMIODsXnjKm
         Gt57hHREMKui7rsBlpi6t1tdUDW87NVBQbp4QgpU/41z44vyuBfRdjtopQgpDiF3dgvi
         Hy3D6rcJLJHhmEXjI9T39X0pZPW+BRwzUp/2xg7zhIv6L81vNZRaA+eq08ND0hyvQXIw
         fP2qrYgQmn2IHT/0bHFMHFwHXFcWS4CXkkPqO1xp6I2eEGQ+I6Tu/VdC38BhWEo98Ycj
         iGoPC8cPTAOT3XhpcJ1OLQOVkXwaVBFugFyiuytYp73zOdW7TguH20xkGszxkWDflb3d
         Vc8Q==
X-Gm-Message-State: ACrzQf2SzZGFaUycB/gY0Ea6SzFE4V70cT6IkweNKwHdckDpalwwoVAY
        mJshwXCvo8celiWci8eNh0vylA==
X-Google-Smtp-Source: AMsMyM6T2cgutW5An/lwB3nwdED5XDbDjZApiPPBZPP/5w8FbCFBInJr3SDG020QFb4rq5OUHwtyUQ==
X-Received: by 2002:a05:6e02:b45:b0:2f5:85da:c388 with SMTP id f5-20020a056e020b4500b002f585dac388mr2107256ilu.87.1664468366884;
        Thu, 29 Sep 2022 09:19:26 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:26 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/13] gpiolib: acpi: Add wake_capable variants of acpi_dev_gpio_irq_get
Date:   Thu, 29 Sep 2022 10:19:09 -0600
Message-Id: <20220929093200.v6.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 9be1376f9a627f4..1f2ade475b36cb2 100644
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
index e476558d947136d..1ac6816839dbce7 100644
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
index 6f64b2f3dc54795..cd7371a5f2839bd 100644
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
2.37.3.998.g577e59143f-goog

