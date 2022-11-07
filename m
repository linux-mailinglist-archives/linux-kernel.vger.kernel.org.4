Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694D061F883
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiKGQKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiKGQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:10:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E0413FBE;
        Mon,  7 Nov 2022 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667837410; x=1699373410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ob2VcCD8eQ1INAspt4Ij3GP7vl0BcLPuHM41kGRdqME=;
  b=gPV4zWBuSiQIcYQUcRggBpU+pUC+f5u+9OlIDhTC82vgN7Rw9v4cOueW
   vXVMqieMyOltjxggqFxyE+whEc6NuTOnP9YP6GahSBL5s+cmRMj1QOBD8
   OBCJI3qbhYYaRAd4FqcH4u/ACcK/OUjokQWBotfLzNvezp8QVikQbllzp
   MYnCGBNdjpLPJ/T4xnKLD+dRzw3bOFBRSFF2ZMWNFzjRrfgk9T25z+aTR
   wWF2BStZK6JOS6Mn119K16ERnYVIPHIJKyDdvTvbMS7jCdneRxlRnOV2T
   FLwRwA8cPLmIFr55f+cHl24unT730sBWjUWyOHJFymeaE6LTdgpdh0fQR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312215920"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312215920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="613910899"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="613910899"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 08:10:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F0074D0; Mon,  7 Nov 2022 18:10:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] gpiolib: of: Integrate of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
Date:   Mon,  7 Nov 2022 18:10:27 +0200
Message-Id: <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to complete fwnode switch, integrate
of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 42 -------------------------------
 drivers/gpio/gpiolib-of.h |  5 ----
 drivers/gpio/gpiolib.c    | 52 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 000020eb78d8..4be3c21aa718 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -112,24 +112,6 @@ static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 	return gpiochip_get_desc(chip, ret);
 }
 
-/**
- * of_gpio_need_valid_mask() - figure out if the OF GPIO driver needs
- * to set the .valid_mask
- * @gc: the target gpio_chip
- *
- * Return: true if the valid mask needs to be set
- */
-bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
-{
-	int size;
-	const struct device_node *np = gc->of_node;
-
-	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
-	if (size > 0 && size % 2 == 0)
-		return true;
-	return false;
-}
-
 /*
  * Overrides stated polarity of a gpio line and warns when there is a
  * discrepancy.
@@ -989,28 +971,6 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 }
 EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
 
-static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
-{
-	int len, i;
-	u32 start, count;
-	struct device_node *np = chip->of_node;
-
-	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
-	if (len < 0 || len % 2 != 0)
-		return;
-
-	for (i = 0; i < len; i += 2) {
-		of_property_read_u32_index(np, "gpio-reserved-ranges",
-					   i, &start);
-		of_property_read_u32_index(np, "gpio-reserved-ranges",
-					   i + 1, &count);
-		if (start >= chip->ngpio || start + count > chip->ngpio)
-			continue;
-
-		bitmap_clear(chip->valid_mask, start, count);
-	}
-};
-
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
@@ -1119,8 +1079,6 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (chip->of_gpio_n_cells > MAX_PHANDLE_ARGS)
 		return -EINVAL;
 
-	of_gpiochip_init_valid_mask(chip);
-
 	ret = of_gpiochip_add_pin_range(chip);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 1b5df39a952e..2a2f7d17fa7e 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -23,7 +23,6 @@ struct gpio_desc *of_find_gpio(struct device *dev,
 int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
-bool of_gpio_need_valid_mask(const struct gpio_chip *gc);
 void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device *dev,
@@ -39,10 +38,6 @@ static inline int of_gpio_get_count(struct device *dev, const char *con_id)
 {
 	return 0;
 }
-static inline bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
-{
-	return false;
-}
 static inline void of_gpio_dev_init(struct gpio_chip *gc,
 				    struct gpio_device *gdev)
 {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8faedca6b14..2ab7b7949171 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -445,9 +445,20 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
 	return p;
 }
 
+static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
+{
+	int size;
+
+	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
+	if (size > 0 && size % 2 == 0)
+		return size;
+
+	return 0;
+}
+
 static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
 {
-	if (!(of_gpio_need_valid_mask(gc) || gc->init_valid_mask))
+	if (!(gpiochip_count_reserved_ranges(gc) || gc->init_valid_mask))
 		return 0;
 
 	gc->valid_mask = gpiochip_allocate_mask(gc);
@@ -457,8 +468,47 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
 	return 0;
 }
 
+static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc, unsigned int sz)
+{
+	u32 *ranges;
+	int ret;
+
+	ranges = kmalloc_array(sz, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, sz);
+	if (ret) {
+		kfree(ranges);
+		return ret;
+	}
+
+	while (sz) {
+		u32 count = ranges[--sz];
+		u32 start = ranges[--sz];
+
+		if (start >= gc->ngpio || start + count > gc->ngpio)
+			continue;
+
+		bitmap_clear(gc->valid_mask, start, count);
+	}
+
+	kfree(ranges);
+	return 0;
+}
+
 static int gpiochip_init_valid_mask(struct gpio_chip *gc)
 {
+	unsigned int sz;
+	int ret;
+
+	sz = gpiochip_count_reserved_ranges(gc);
+	if (sz) {
+		ret = gpiochip_apply_reserved_ranges(gc, sz);
+		if (ret)
+			return ret;
+	}
+
 	if (gc->init_valid_mask)
 		return gc->init_valid_mask(gc,
 					   gc->valid_mask,
-- 
2.35.1

