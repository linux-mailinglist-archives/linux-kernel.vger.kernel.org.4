Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F636ACE9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCFT4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCFTzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F169238;
        Mon,  6 Mar 2023 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132541; x=1709668541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dt4pdLMszFVaAbdqwI08UXnnW0vBxyo1Sqmq45vpnHo=;
  b=f+3A19+Sb1OHKZkOqtkN6wV8qFdXllCAYLRw2MPd1v98muXw5HMOfJTn
   qBT0tuwqpF4pWrYRhzD8otAeR55A7uYAfnS4EYrk/XLt8pE7TCqYllvzX
   1WUHIIQXcXlq3tSPLBpEauCAy0wFYx4VhaLvez6DNMiqLiOZK66sB2xdo
   eGKq7mtUJ2N31g1c0mFgjjCyDCDMk+zF1uvML5yiSzmIbJ/AM2rjXq3v/
   FmZ/MeGZJHmToWnGtVxSr9TGvncDE2DWHUZbq/qB+9ULTCxn+hcoc6Jsf
   f7cVQjKfvyo09tqrdL4GZCJpsL8OrL5FHNTN68VXqb3A7IzpNEPsYIgr0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398240789"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398240789"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="819423558"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="819423558"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2023 11:55:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A2E93CB; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 05/16] gpiolib: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:45 +0200
Message-Id: <20230306195556.55475-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
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

There are a few helpers available to convert a boolean variable
to the dedicated string literals depending on the application.
Use them in the driver.

While at, utilize specifier field for padding the strings where
it's required.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-sysfs.c |  3 ++-
 drivers/gpio/gpiolib.c       | 13 ++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index c1cbf71329f0..54dc53b74dc4 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -82,7 +83,7 @@ static ssize_t direction_show(struct device *dev,
 
 	mutex_unlock(&data->mutex);
 
-	return sysfs_emit(buf, "%s\n", value ? "out" : "in");
+	return sysfs_emit(buf, "%s\n", str_out_in(value));
 }
 
 static ssize_t direction_store(struct device *dev,
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 700195a1faae..b554ad435245 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
@@ -4198,6 +4199,8 @@ EXPORT_SYMBOL_GPL(gpiod_get_index_optional);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 	      unsigned long lflags, enum gpiod_flags dflags)
 {
+	bool out = dflags & GPIOD_FLAGS_BIT_DIR_OUT;
+	bool hi = dflags & GPIOD_FLAGS_BIT_DIR_VAL;
 	struct gpio_chip *gc;
 	struct gpio_desc *local_desc;
 	int hwnum;
@@ -4218,10 +4221,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	/* Mark GPIO as hogged so it can be identified and removed later */
 	set_bit(FLAG_IS_HOGGED, &desc->flags);
 
-	gpiod_info(desc, "hogged as %s%s\n",
-		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
-		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
-		  (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
+	gpiod_info(desc, "hogged as %s/%s\n", str_output_input(out), out ? str_high_low(hi) : "?");
 
 	return 0;
 }
@@ -4509,10 +4509,9 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 			value = gpio_chip_get_value(gc, desc);
 			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
 			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
-			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
+			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %-3.3s %-2.2s %s%s\n",
 				   gpio, desc->name ?: "", desc->label,
-				   is_out ? "out" : "in ",
-				   value >= 0 ? (value ? "hi" : "lo") : "?  ",
+				   str_out_in(is_out), value < 0 ? "?" : str_hi_lo(value),
 				   is_irq ? "IRQ " : "",
 				   active_low ? "ACTIVE LOW" : "");
 		} else if (desc->name) {
-- 
2.39.1

