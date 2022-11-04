Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3B6190B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKDGKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKDGKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:10:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E116A28E36;
        Thu,  3 Nov 2022 23:10:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u6so3977862plq.12;
        Thu, 03 Nov 2022 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bbqffuj8GDPgiTExwtSV/0E3fSitJ002WmiZw+SKCw=;
        b=USWpivDglRC74Px6hvCW6cz8r58wFAGm88yHE+C+6P0tyq4Bcfl705uegGlbut0fIV
         bPr4byregreBm6NnlhcmPP1XuuGcO5Y9qUyjBuSX1V4Mc+D152+Es00EDLtwqFVvKTXM
         ONAGCRFuAT4IwPVwEqsbjYgPoyDvLWXW/AnRYVRxeUkTJFu+/GbBzc8u/NQ0zYRb8Y68
         +cdmpfTCl25exYPp0YmmYGwHFA9Sv/IFzD97s7H3lPkCEpjujmaXr4pABYTnnI7gxpli
         cuwkVeBY4AbMsYvRVzHeV+ivyt4fhwX/wmWNOeXLXKB9IrNcBVzegZtyYqcSG2od9F6h
         tluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bbqffuj8GDPgiTExwtSV/0E3fSitJ002WmiZw+SKCw=;
        b=bL9wPqXWzp1cwX/NYvjVJib5NicdhKy/5D47K133ZZMaPit5JmV3GHb/fndLO+sxbM
         kIB/fL8AlO+HT/T3k5DrLllfYBHe2st0FbLLBKtpa2+uY0+2yKtkMOp2z/YhWDcf+jnw
         kbHzfDvij5Qoi0yoVzc0/KBwEteBTiYBe3IBc/+YYZPvlOa/Jejw26a1pOaF9cwgjKKg
         vGzTiX0BIa4hklHucrpcXWD+Qt/8fyF1FoY2OmYa3kPEIMxPBsmUVcSZaJGPBkfTW3+3
         QaxlVqGL0I0Ft8o0jQIC9rJUt4FeViAAD0q3+XXo5tfdBCdWK4hTaXNPwUGh6EB3/7He
         40yg==
X-Gm-Message-State: ACrzQf0RTgV9ZtQJLR3GJwZ1tNKFyHn4T0B8LwzW6Kj9QbGFaWL78MvK
        +ZHQuR8gbG/pZiU8wG1K1QHbuX18Tyo=
X-Google-Smtp-Source: AMsMyM78QLEAJK5f93YKlQITbBw7m6d1c432NDZDxCNnKU7GiLgehaSt1CKczX/69Th/BVuncP7fjw==
X-Received: by 2002:a17:90b:4a92:b0:213:2421:5f38 with SMTP id lp18-20020a17090b4a9200b0021324215f38mr35950804pjb.10.1667542222248;
        Thu, 03 Nov 2022 23:10:22 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79ac5000000b0056bfd4a2702sm1791411pfp.45.2022.11.03.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:10:21 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] gpiolib: of: change of_find_gpio() to accept device node
Date:   Thu,  3 Nov 2022 23:10:11 -0700
Message-Id: <20221031-gpiolib-swnode-v1-1-a0ab48d229c7@gmail.com>
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

In preparation of switching all OF-based GPIO lookups to go through
of_find_gpio() let's change it to accept device node as its argument as
we do not always have access to device structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 7 +++----
 drivers/gpio/gpiolib-of.h | 4 ++--
 drivers/gpio/gpiolib.c    | 5 +++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 012e66344b56..607bf4358ff7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -605,7 +605,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	NULL
 };
 
-struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
+struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 			       unsigned int idx, unsigned long *flags)
 {
 	char prop_name[32]; /* 32 is max size of property name */
@@ -623,8 +623,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			snprintf(prop_name, sizeof(prop_name), "%s",
 				 gpio_suffixes[i]);
 
-		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
-						&of_flags);
+		desc = of_get_named_gpiod_flags(np, prop_name, idx, &of_flags);
 
 		if (!gpiod_not_found(desc))
 			break;
@@ -632,7 +631,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 	/* Properly named GPIO was not found, try workarounds */
 	for (q = of_find_gpio_quirks; gpiod_not_found(desc) && *q; q++)
-		desc = (*q)(dev->of_node, con_id, idx, &of_flags);
+		desc = (*q)(np, con_id, idx, &of_flags);
 
 	if (IS_ERR(desc))
 		return desc;
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 22d314229bbd..c44be0f285f3 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -17,7 +17,7 @@ struct gpio_desc;
 struct gpio_device;
 
 #ifdef CONFIG_OF_GPIO
-struct gpio_desc *of_find_gpio(struct device *dev,
+struct gpio_desc *of_find_gpio(struct device_node *np,
 			       const char *con_id,
 			       unsigned int idx,
 			       unsigned long *lookupflags);
@@ -31,7 +31,7 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
 					 enum gpiod_flags dflags,
 					 const char *label);
 #else
-static inline struct gpio_desc *of_find_gpio(struct device *dev,
+static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
 					     unsigned int idx,
 					     unsigned long *lookupflags)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8faedca6b14..c5a80def8be4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4070,14 +4070,15 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	int ret;
 	/* Maybe we have a device name, maybe not */
 	const char *devname = dev ? dev_name(dev) : "?";
-	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
+	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
 
 	/* Using device tree? */
 	if (is_of_node(fwnode)) {
 		dev_dbg(dev, "using device tree for GPIO lookup\n");
-		desc = of_find_gpio(dev, con_id, idx, &lookupflags);
+		desc = of_find_gpio(to_of_node(fwnode),
+				    con_id, idx, &lookupflags);
 	} else if (is_acpi_node(fwnode)) {
 		dev_dbg(dev, "using ACPI for GPIO lookup\n");
 		desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);

-- 
b4 0.11.0-dev-28747
