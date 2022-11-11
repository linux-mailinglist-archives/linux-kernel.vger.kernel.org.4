Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9862647D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiKKWTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiKKWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:19:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05596575;
        Fri, 11 Nov 2022 14:19:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso8863688pjg.5;
        Fri, 11 Nov 2022 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbF1U+/n89XohO4xIoGIR3CATloY9cnx1McB9SGbcIg=;
        b=jijVAtpnCgQZzD+WE71V69tuMFlktDgN1brOYikpY2O9S8qhyjvBqeMr9nHhaLfKTz
         OBlkTU7Xyf3/VUi3hrlKYRnluPBb3ke9PXbR+P+WBUubJSw9nOtZ7DDCjmYLtS8bDVfs
         nJN5zPLpPELCgIs2CqIJDi5BW3Hl4G6UUcoAUK8tufhQydiMEVrsHCtjwfRshCI9m8RT
         A0kP7CrHyzPEUsu+2+WL3NYi09zbYId/Y4/x7z1bdPBVfYPbxBrRtpoOZ51iUvMdiaZP
         6w+EcfCNe1xGVRsg21ItKVjaMxA23szaVjHlki/6d4uaFE4K6oz4/j9MZ8w+ucQgBf/3
         Mufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbF1U+/n89XohO4xIoGIR3CATloY9cnx1McB9SGbcIg=;
        b=npMiwc18OY7pcSonxEEhFh9dIwSWuqwU7V62OpZwuoEPHoh1GtINZlQaAufThzIAIs
         pAJX+a2V8Ecv4gyJXMjq9it9wCmJCs7fTXbyjJ5lTYWvG0wooh7ThS7cbUc4dZ7v+H+q
         mM4BiZ/PPG6fjcQdhXt9jxdwjbhLZxFC+N4KFgcSESG6Rcydl1X2ozcn8PPhkLFE70Zs
         F6mnfyUUhh0QsTbZ9m9XOAYxDh04DbcWR2SA19N6zb1TbUIAKoLVZ8TANGOyPawU+mBF
         lxKCWF1MC/wVl5N1jrxaQBvnunMmY0Ue+3ZULjCaw+oUPRmpmKTJjjvDo5g8lybNMwMc
         e8WA==
X-Gm-Message-State: ANoB5pmZ4+f+dJQoMZtoumgy+C9E/JEvJLEJ/9zkkcxxVjTOD2jfn9es
        GeHpWlDAjte/2m7nI8YGuvUsFoObRB8=
X-Google-Smtp-Source: AA0mqf6K4i/uMz7cW08FZgV5bkjY8UWFpBpyVGoH8OqtXdAfFgmHsHtYhavX3/KgWIqsbW0pdyRUqQ==
X-Received: by 2002:a17:902:b417:b0:188:4ba9:79ee with SMTP id x23-20020a170902b41700b001884ba979eemr4523501plr.83.1668205154161;
        Fri, 11 Nov 2022 14:19:14 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm2201109pls.125.2022.11.11.14.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:19:13 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 1/6] gpiolib: of: change of_find_gpio() to accept device node
Date:   Fri, 11 Nov 2022 14:19:03 -0800
Message-Id: <20221031-gpiolib-swnode-v4-1-6c1671890027@gmail.com>
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

In preparation of switching all OF-based GPIO lookups to go through
of_find_gpio() let's change it to accept device node as its argument as
we do not always have access to device structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 7 +++----
 drivers/gpio/gpiolib-of.h | 4 ++--
 drivers/gpio/gpiolib.c    | 5 +++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4be3c21aa718..596b8e21700e 100644
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
index 2a2f7d17fa7e..a6c593e6766c 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -16,7 +16,7 @@ struct gpio_desc;
 struct gpio_device;
 
 #ifdef CONFIG_OF_GPIO
-struct gpio_desc *of_find_gpio(struct device *dev,
+struct gpio_desc *of_find_gpio(struct device_node *np,
 			       const char *con_id,
 			       unsigned int idx,
 			       unsigned long *lookupflags);
@@ -25,7 +25,7 @@ void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
 void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
-static inline struct gpio_desc *of_find_gpio(struct device *dev,
+static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
 					     unsigned int idx,
 					     unsigned long *lookupflags)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 11fb7ec883e9..a80fc8abb03f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4122,14 +4122,15 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
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
