Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC58A6512D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiLSTW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiLSTV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:21:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FBF14010;
        Mon, 19 Dec 2022 11:20:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14182673pjt.0;
        Mon, 19 Dec 2022 11:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLB8Nq12CEJ71SF2TAvjGUG3MmgGE6n5sA6fuDsDmSw=;
        b=XtnkeYl8x/BE5rlQ6u1adz3Oj59Bd5J3uKRVoK4EHRHAtTD+FQ0frG0+xuiO83lDsS
         6N03n1DalBQJB8Gix9pwlMjlsv+QuaaKDrE41OvXHnnk0bdIg/GumFwTdhzG7eZbNm25
         QmTNurujYPudDIQyM7zIxE5pNAmwPDyYIUGBZ1rX85E9qmAEIb4JFxFZQ203iLtQHR9A
         i6DOaxFmxkM80n3YS24/SYrOMGTenidI+s19ppg4trBBUQRp9w2nlOYgNDO0FLAaPZYv
         6LfSiGJaCfd6iEpNAjWeb/dDTIh7xcKYxFm02T1dq+1u7O0zYHZ7hlR+2XhkKNeT8QkL
         A5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLB8Nq12CEJ71SF2TAvjGUG3MmgGE6n5sA6fuDsDmSw=;
        b=D+rcOPo/YOcEV2SESVsqWLLwFzOp7r7GJAWEKKkhhB2FtjkpeXupUSQYvJY2StOV2c
         u6aw12ZleyrEnTYgPXib5O0neGsxvbu7/ta4WriDutOBX6eeZOknDZtY8FoEmDqmkEmi
         pmk64p4pHVd+fp+1LOY/eA/N1XoqJ7uE/8vkzgK6lv3jta3optKEAekMPiU7avyb3NVL
         fQSecPV0wXkp7OdBT8JH40N6R3WznEw8C5jjRQVHB+vQ5fn+uL4RRfv9qmxg/b/HPDGG
         xC8RwVJYX05Na+TggPhHYMVwlm+17qzZAWPmREVIUiW7jIjzXzd6MrwXCMYGFGWUDPbF
         aNYg==
X-Gm-Message-State: ANoB5pnrBOXXArdXIhv344aWRCirDN1oGSMtKsdExm9uOnfsg/zf4+26
        PYghLfpkDs576I/6+x/fDPg=
X-Google-Smtp-Source: AA0mqf4D9dSp5NX+0mHjAf3fAlZwWNepsKNqvYNbbEIwxw2KbFrODynsYQ41mjqZD31IHQphoQod/g==
X-Received: by 2002:a17:903:26d3:b0:18d:9214:1ae5 with SMTP id jg19-20020a17090326d300b0018d92141ae5mr39558659plb.23.1671477627454;
        Mon, 19 Dec 2022 11:20:27 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:4c62:79e:b4cd:2cbb])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001869f2120absm7488342plm.294.2022.12.19.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:20:26 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5/5] gpiolib: of: remove [devm_]gpiod_get_from_of_node() APIs
Date:   Mon, 19 Dec 2022 11:20:16 -0800
Message-Id: <20221219192016.1396950-5-dmitry.torokhov@gmail.com>
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

Now that everyone is using [devm_]fwnode_gpiod_get[_index]() APIs,
remove OF-specific [devm_]gpiod_get_from_of_node().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-devres.c | 55 -----------------------------------
 drivers/gpio/gpiolib-of.c     | 46 -----------------------------
 include/linux/gpio/consumer.h | 48 ------------------------------
 3 files changed, 149 deletions(-)

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 16a696249229..fe9ce6b19f15 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -129,61 +129,6 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_gpiod_get_index);
 
-/**
- * devm_gpiod_get_from_of_node() - obtain a GPIO from an OF node
- * @dev:	device for lifecycle management
- * @node:	handle of the OF node
- * @propname:	name of the DT property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      const struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label)
-{
-	struct gpio_desc **dr;
-	struct gpio_desc *desc;
-
-	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
-	if (IS_ERR(desc))
-		return desc;
-
-	/*
-	 * For non-exclusive GPIO descriptors, check if this descriptor is
-	 * already under resource management by this device.
-	 */
-	if (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
-		struct devres *dres;
-
-		dres = devres_find(dev, devm_gpiod_release,
-				   devm_gpiod_match, &desc);
-		if (dres)
-			return desc;
-	}
-
-	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
-			  GFP_KERNEL);
-	if (!dr) {
-		gpiod_put(desc);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	*dr = desc;
-	devres_add(dev, dr);
-
-	return desc;
-}
-EXPORT_SYMBOL_GPL(devm_gpiod_get_from_of_node);
-
 /**
  * devm_fwnode_gpiod_get_index - get a GPIO descriptor from a given node
  * @dev:	GPIO consumer
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index fdf443310442..4a47e71782f3 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -418,52 +418,6 @@ static unsigned long of_convert_gpio_flags(enum of_gpio_flags flags)
 	return lflags;
 }
 
-/**
- * gpiod_get_from_of_node() - obtain a GPIO from an OF node
- * @node:	handle of the OF node
- * @propname:	name of the DT property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
-{
-	unsigned long lflags;
-	struct gpio_desc *desc;
-	enum of_gpio_flags of_flags;
-	int ret;
-
-	desc = of_get_named_gpiod_flags(node, propname, index, &of_flags);
-	if (!desc || IS_ERR(desc))
-		return desc;
-
-	ret = gpiod_request(desc, label);
-	if (ret == -EBUSY && (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
-		return desc;
-	if (ret)
-		return ERR_PTR(ret);
-
-	lflags = of_convert_gpio_flags(of_flags);
-
-	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
-	if (ret < 0) {
-		gpiod_put(desc);
-		return ERR_PTR(ret);
-	}
-
-	return desc;
-}
-EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
-
 static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 					     const char *con_id,
 					     unsigned int idx,
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 45da8f137fe5..59cb20cfac3d 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -581,54 +581,6 @@ struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 					   flags, label);
 }
 
-#if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_OF_GPIO)
-struct device_node;
-
-struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label);
-
-#else  /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
-
-struct device_node;
-
-static inline
-struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-#endif /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
-
-#ifdef CONFIG_GPIOLIB
-struct device_node;
-
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      const struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label);
-
-#else  /* CONFIG_GPIOLIB */
-
-struct device_node;
-
-static inline
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      const struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-#endif /* CONFIG_GPIOLIB */
-
 struct acpi_gpio_params {
 	unsigned int crs_entry_index;
 	unsigned int line_index;
-- 
2.39.0.314.g84b9a713c41-goog

