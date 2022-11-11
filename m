Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79199626482
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiKKWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiKKWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:19:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A6659F;
        Fri, 11 Nov 2022 14:19:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y13so5998310pfp.7;
        Fri, 11 Nov 2022 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx7cuLL3+0qRhgMYucvbk77J8l2k/sPl8YHWPWSFSw8=;
        b=G4iZsMpuI3nEGriXixkODoP02isRkQh2sxoomdWZNs0K6nNdhTMskVO8cMKpAqERqw
         ufEwL02k6KprcVMdwU5XrKtO7iKZ88xyBBdF9kAjTuuTW2KetiSHTmEbNg2Q9O31mrnw
         VTBNHNqp7jHeGo38JC5lFzDeHkUtKU4NSLVXI45JygOQorDfmR3YpInyMCHyOKgLlwa2
         4twbJxK37/GJoYrTzUj/+zf1Af11xNgH2huxWgVCUhnywsrHVw2V+9lBrcR6fDxdE9iP
         4UJlNb9du52KvJBWR6hYa848GtOp2PqBEBWSDVsdnrJymOmBMjWnZCinMSVDbwz7w1Py
         mI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx7cuLL3+0qRhgMYucvbk77J8l2k/sPl8YHWPWSFSw8=;
        b=hWhJXy9bfpwCHhH5tVf8jVPVNq5l1nWGRXAbsCXL7bO0LflVcZpg05HCqPC9hb3/sX
         pFWjhABS7sa8zvY07bFTL6URfbaNcYgmqk/uaAkrMI8VHzyGIKl5pNw0PMKpS1BjgsiR
         OpqV10YZ374Z1tCaXp7ygnvE5Fr1jXu/SyQ21daKlP3rINIXYct+6BIB1LffqlPk1VUT
         dqEM6PsTWKwzNghxgGwdnXKsheS46XA4ZxLLn2/GS10tHmEBZJhJVVml3AQFSyqie0/C
         2+p4f3aoRw9z/L12DDe4ZvRmET42W235MegnG0JKSTPmlx4jlQJ4cRXPlppnHWzllXNN
         iJCw==
X-Gm-Message-State: ANoB5plcD0ZBy28uNoUyv2Simc5OfvlDXM+9OTVBh+zRUiG6PugIKxjK
        vdBDXlv0VO+gzbYZD09WPctN5OjHtWE=
X-Google-Smtp-Source: AA0mqf5Is0TzQtncpQZb1CVimdOL5Z1cCNQ2/l6SPRGnPTYgn2XLOx2m7iucPJ0hfKB9bv/h6JLrEQ==
X-Received: by 2002:a63:221a:0:b0:464:3985:3c63 with SMTP id i26-20020a63221a000000b0046439853c63mr3396128pgi.141.1668205155875;
        Fri, 11 Nov 2022 14:19:15 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm2201109pls.125.2022.11.11.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:19:15 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 2/6] gpiolib: acpi: change acpi_find_gpio() to accept firmware node
Date:   Fri, 11 Nov 2022 14:19:04 -0800
Message-Id: <20221031-gpiolib-swnode-v4-2-6c1671890027@gmail.com>
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

In preparation of switching all ACPI-based GPIO lookups to go through
acpi_find_gpio() let's change it to accept device node as its argument
as we do not always have access to device structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++++--
 drivers/gpio/gpiolib-acpi.h | 4 ++--
 drivers/gpio/gpiolib.c      | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 064ba5150fd4..ccb74e208989 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -906,18 +906,22 @@ static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 	return con_id == NULL;
 }
 
-struct gpio_desc *acpi_find_gpio(struct device *dev,
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 const char *con_id,
 				 unsigned int idx,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev;
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
 	int i;
 
+	adev = to_acpi_device_node(fwnode);
+	if (!adev)
+		return ERR_PTR(-ENODEV);
+
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id) {
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 01e0cb480a00..bd1f9b92ea9e 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -60,7 +60,7 @@ int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
 int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 					struct acpi_gpio_info *info);
 
-struct gpio_desc *acpi_find_gpio(struct device *dev,
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 const char *con_id,
 				 unsigned int idx,
 				 enum gpiod_flags *dflags,
@@ -95,7 +95,7 @@ acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 }
 
 static inline struct gpio_desc *
-acpi_find_gpio(struct device *dev, const char *con_id,
+acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
 	       unsigned int idx, enum gpiod_flags *dflags,
 	       unsigned long *lookupflags)
 {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a80fc8abb03f..e874bb0ef685 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4133,7 +4133,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 				    con_id, idx, &lookupflags);
 	} else if (is_acpi_node(fwnode)) {
 		dev_dbg(dev, "using ACPI for GPIO lookup\n");
-		desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
+		desc = acpi_find_gpio(fwnode,
+				      con_id, idx, &flags, &lookupflags);
 	}
 
 	/*

-- 
b4 0.11.0-dev-28747
