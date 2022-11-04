Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013C6190B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKDGKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKDGK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:10:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB5BFA;
        Thu,  3 Nov 2022 23:10:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v28so3639572pfi.12;
        Thu, 03 Nov 2022 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYYciqss2h8x47THt+MGpIvKBIq3VnELKV/9J5zDz4Y=;
        b=EGq1zbBxoKvqhbPCQ6Dig8/2CDIPgcTwz2LVK8P/QSjWyyJlsd3MLn0upj7VjzSVuw
         0D7ZN47IlnQsUuy5v1F4QN1NuWT2IcrSFJh5ZnPuNj7LR5+dpIvz+Pk59MUnCCGt98VT
         r1zqbo8lAz13T3UI4earjGRWHdHpZCyggba4Q33nUy4m5yBf1tTbgtxY71Aq/QX1A05Y
         NiFmZz8q8o8kMx1sK3rDJF5fBumvd5JRqR5HU1EB3b4FbvrGtoA2XmHTMjkXLAEHNk6P
         D99clZZyiEzLTB5+ZYG8+8aLmyCJHq1BXXuZcPcLwOhdAlEzM65tWmamxcRfLjIB5hKB
         VP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYYciqss2h8x47THt+MGpIvKBIq3VnELKV/9J5zDz4Y=;
        b=AISES1IqvQjXgjabD5zYarGhe40NFXo7HccrYbVoWuQ1frYurhSjKXCcjVHn0AtAVi
         B+nepoBunbHlEnLaQ6RIKrJ8fncZNzwZklQUB14e9+sa8vFLXG8+ACd1OjxMmNB1PWOZ
         siwZuf5kRTRwTDhy970XRBZNEXWNZIjFp7oSNHEzBxgBASVUQNMw0ZRcO17IXwfMBIDa
         NN7MaqXXoqoidJhhOtbw/bCgvKZl0f5CU29Z8M5qCwcgAZB9ihlBqPi7i7RqNM4Nm8Kt
         +yb6qjMe4v0hmyKlExB4RM+qwTRz9QEZlvLZ6kl0BA5NwXNgAoSFl3R0tjlexlA/KU7R
         TogQ==
X-Gm-Message-State: ACrzQf3nGc6aR7ywIdfr7Izqtoya4nwYIVfyohgMDIiNXjoGb7CJCMVf
        J+3ziNgu0z4oiRBWdWKEx1pJoXF970U=
X-Google-Smtp-Source: AMsMyM5dIMO1BxCCYisjc9VpDbbeMK6sYOxmq6P0rmTku1dbFrz5VWosrPBiuRYq6LU56GyeSmwnug==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr29328951pgs.211.1667542224082;
        Thu, 03 Nov 2022 23:10:24 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79ac5000000b0056bfd4a2702sm1791411pfp.45.2022.11.03.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:10:23 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] gpiolib: acpi: change acpi_find_gpio() to accept firmware node
Date:   Thu,  3 Nov 2022 23:10:12 -0700
Message-Id: <20221031-gpiolib-swnode-v1-2-a0ab48d229c7@gmail.com>
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

In preparation of switching all ACPI-based GPIO lookups to go through
acpi_find_gpio() let's change it to accept device node as its argument
as we do not always have access to device structure.

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
index c5a80def8be4..eebcdaca5e06 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4081,7 +4081,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
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
