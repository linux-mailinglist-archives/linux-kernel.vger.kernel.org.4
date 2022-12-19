Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9D6512D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiLSTWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiLSTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:21:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959AD167E2;
        Mon, 19 Dec 2022 11:20:26 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w20so3401892ply.12;
        Mon, 19 Dec 2022 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3PCQixWV8YBmbSgrRSE0fpiFw7H3KtVnaiI+gLwP+g=;
        b=OOej/IS6eIu2rSAxZRB3vSyg3etxUrWIxbRZ1Wrjwi6UQjx6bwTkvQX5k26/iS8sNM
         bSIgq6R8rmcojRVV1hwjU2VVNuiYJmmKSdYSvTCoTV1/s8rZeG/VMaWDYWngb9WZVvFE
         3EuhENE9720Sdi6Y0mHVmX1fj+wkOZZAfkReiz9kPIIuK1NEieq1Tktp4wuHGx0cxNPO
         wa1iirFcwJhs8p6snwr5TO4zUBklaF6jbJCkONFyjeXG8O4YGnvpWYSVKb6d4SRaZt6A
         ACY2O1P0dShyrF7/+QV9ID9dmUdiioLTRPll+XzWCshikQmqcnbbtP6q67zOO1tk3k1H
         pjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3PCQixWV8YBmbSgrRSE0fpiFw7H3KtVnaiI+gLwP+g=;
        b=nh1Ak+/yZ6wgF2dAz/22+BtWUjiPSzKtfT2IwIUMdpHicYuOyahtZbqdwhDp3dJ5oN
         8AGYTHb/SZP/g+d6zhT3d01Sj39an15rd1cS8iZ/QmQ6yBGwWq5feMfT0fAgX+46zCE7
         Cpmg6968oyix19kE0/jH6jpQAB5IEaJBEAb+KOZ4jNpdgrHmoG8HIU7vAK7Oeozp5yRf
         dr1ZQab3vN+KIxsN3XnWKID6ZOhYVNkQVMJ//EC0b8df2doyWH18k3Gn0peAHk/ZiZxF
         QUbj4W8IlpjuAmuLw/jcxrkS/wASdvvnTHZiLnK2SNzeXINSBiPqvqiBqIwDxG0isZ3s
         Kk/A==
X-Gm-Message-State: ANoB5pkVNQiqbVfH1onXZsrZr41/BjYKqB3cAaa9pbwSufSH5wxRQRYc
        LX8+fAjXa86ovaM0T0dzqBk=
X-Google-Smtp-Source: AA0mqf4GDjtS6YzQM9TM4l+9RITiBbN+Q/X067j+GpWEvax/TwcGr8ymGc2aaEvRcW66Heh5No69Bg==
X-Received: by 2002:a17:903:1247:b0:189:acee:7aa4 with SMTP id u7-20020a170903124700b00189acee7aa4mr48097506plh.65.1671477625760;
        Mon, 19 Dec 2022 11:20:25 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:4c62:79e:b4cd:2cbb])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001869f2120absm7488342plm.294.2022.12.19.11.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:20:25 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/5] gpiolib: of: remove of_get_gpio[_flags]() and of_get_named_gpio_flags()
Date:   Mon, 19 Dec 2022 11:20:15 -0800
Message-Id: <20221219192016.1396950-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
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

There are no more users of these APIs in the mainline kernel, remove
them. This leaves of_get_named_gpio() as the only legacy OF-specific
API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 17 +++++++++++----
 include/linux/of_gpio.h   | 45 ++++-----------------------------------
 2 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6114c5b3d2ce..fdf443310442 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -365,19 +365,28 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 	return desc;
 }
 
-int of_get_named_gpio_flags(const struct device_node *np, const char *list_name,
-			    int index, enum of_gpio_flags *flags)
+/**
+ * of_get_named_gpio() - Get a GPIO number to use with GPIO API
+ * @np:		device node to get GPIO from
+ * @propname:	Name of property containing gpio specifier(s)
+ * @index:	index of the GPIO
+ *
+ * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
+ * value on the error condition.
+ */
+int of_get_named_gpio(const struct device_node *np, const char *propname,
+		      int index)
 {
 	struct gpio_desc *desc;
 
-	desc = of_get_named_gpiod_flags(np, list_name, index, flags);
+	desc = of_get_named_gpiod_flags(np, propname, index, NULL);
 
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 	else
 		return desc_to_gpio(desc);
 }
-EXPORT_SYMBOL_GPL(of_get_named_gpio_flags);
+EXPORT_SYMBOL_GPL(of_get_named_gpio);
 
 /* Converts gpio_lookup_flags into bitmask of GPIO_* values */
 static unsigned long of_convert_gpio_flags(enum of_gpio_flags flags)
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 680025c1a55b..e27a9187c0c6 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -50,8 +50,8 @@ static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
 	return container_of(gc, struct of_mm_gpio_chip, gc);
 }
 
-extern int of_get_named_gpio_flags(const struct device_node *np,
-		const char *list_name, int index, enum of_gpio_flags *flags);
+extern int of_get_named_gpio(const struct device_node *np,
+			     const char *list_name, int index);
 
 extern int of_mm_gpiochip_add_data(struct device_node *np,
 				   struct of_mm_gpio_chip *mm_gc,
@@ -68,49 +68,12 @@ extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
 #include <linux/errno.h>
 
 /* Drivers may not strictly depend on the GPIO support, so let them link. */
-static inline int of_get_named_gpio_flags(const struct device_node *np,
-		const char *list_name, int index, enum of_gpio_flags *flags)
-{
-	if (flags)
-		*flags = 0;
-
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_OF_GPIO */
-
-static inline int of_get_gpio_flags(const struct device_node *np, int index,
-		      enum of_gpio_flags *flags)
-{
-	return of_get_named_gpio_flags(np, "gpios", index, flags);
-}
-
-/**
- * of_get_named_gpio() - Get a GPIO number to use with GPIO API
- * @np:		device node to get GPIO from
- * @propname:	Name of property containing gpio specifier(s)
- * @index:	index of the GPIO
- *
- * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
- * value on the error condition.
- */
 static inline int of_get_named_gpio(const struct device_node *np,
                                    const char *propname, int index)
 {
-	return of_get_named_gpio_flags(np, propname, index, NULL);
+	return -ENOSYS;
 }
 
-/**
- * of_get_gpio() - Get a GPIO number to use with GPIO API
- * @np:		device node to get GPIO from
- * @index:	index of the GPIO
- *
- * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
- * value on the error condition.
- */
-static inline int of_get_gpio(const struct device_node *np, int index)
-{
-	return of_get_gpio_flags(np, index, NULL);
-}
+#endif /* CONFIG_OF_GPIO */
 
 #endif /* __LINUX_OF_GPIO_H */
-- 
2.39.0.314.g84b9a713c41-goog

