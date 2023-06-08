Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8917284D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjFHQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjFHQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:23:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869702D72;
        Thu,  8 Jun 2023 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686241377; x=1717777377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0EWXB2OkiFb2hh+8AxZy+RiHPeZQVtYstodxAyYGW94=;
  b=ib3NjQA9e0047FXHvdxmTUdGmpTyIrzcTtSFt06oE3BaHwj0csg+bO+p
   0eq/dBQAqZsi5Khnrvc5USVxIGdKP+zPmSrbfc6zIPqzZONoHMlCcAaxe
   tvqLiRmVZZttp89pyROkpeOJgBrf0mjTskSwOXY6GgE5OmmzGklzerVO/
   cn08LblaUwGiHchoBVTjuvMhI0KXekufmDTZi0Z0jJYYVIbK3XhlIfYBO
   tZd25pUmpbymFbYQHXqQsiyjwc8htFbEy5w1WktnK0B7+5yf0BnIPgnpl
   2Yg48r8puu8jx5blBQb3m8Sm9TNUqzeXJ+lUc9/8WXehU1rEMkjFGyIlI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385701292"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="385701292"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884252675"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884252675"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2023 09:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45B8C1B4; Thu,  8 Jun 2023 19:21:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Stein <linux@ew.tq-group.com>
Subject: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay support for individual output pins
Date:   Thu,  8 Jun 2023 19:21:30 +0300
Message-Id: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggregator mode can also handle properties of the platform, that
do not belong to the GPIO controller itself. One of such a property
is signal delay line. Intdoduce support of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I don't like the idea of gpio-delay or similar. We have already GPIO
aggregator that incorporates the GPIO proxy / forwarder functionality.

This one is RFC because:
1) just compile tested;
2) has obvious issues with CONFIG_OF_GPIO;
3) contains ~5 patches in a single change for now;
4) requires additional work with blocking sysfs for this;
5) requires some DT bindings work;
6) ...whatever I forgot...

Any comments are appreciated, and tests are esp. welcome!

 drivers/gpio/gpio-aggregator.c | 84 ++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 20a686f12df7..802d123f0188 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -10,12 +10,14 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -239,6 +241,11 @@ static void __exit gpio_aggregator_remove_all(void)
  *  GPIO Forwarder
  */
 
+struct gpiochip_fwd_timing {
+	unsigned long ramp_up_us;
+	unsigned long ramp_down_us;
+};
+
 struct gpiochip_fwd {
 	struct gpio_chip chip;
 	struct gpio_desc **descs;
@@ -246,6 +253,7 @@ struct gpiochip_fwd {
 		struct mutex mlock;	/* protects tmp[] if can_sleep */
 		spinlock_t slock;	/* protects tmp[] if !can_sleep */
 	};
+	struct gpiochip_fwd_timing *delay_timings;
 	unsigned long tmp[];		/* values and descs for multiple ops */
 };
 
@@ -333,11 +341,28 @@ static int gpio_fwd_get_multiple_locked(struct gpio_chip *chip,
 static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	const struct gpiochip_fwd_timing *delay_timings;
+	struct gpio_desc *desc = fwd->descs[offset];
+	bool is_active_low = gpiod_is_active_low(desc);
+	bool ramp_up;
 
-	if (chip->can_sleep)
-		gpiod_set_value_cansleep(fwd->descs[offset], value);
-	else
-		gpiod_set_value(fwd->descs[offset], value);
+	delay_timings = &fwd->delay_timings[offset];
+	ramp_up = (!is_active_low && value) || (is_active_low && !value);
+	if (chip->can_sleep) {
+		gpiod_set_value_cansleep(desc, value);
+
+		if (ramp_up && delay_timings->ramp_up_us)
+			fsleep(delay_timings->ramp_up_us);
+		if (!ramp_up && delay_timings->ramp_down_us)
+			fsleep(delay_timings->ramp_down_us);
+	} else {
+		gpiod_set_value(desc, value);
+
+		if (ramp_up && delay_timings->ramp_up_us)
+			udelay(delay_timings->ramp_up_us);
+		if (!ramp_up && delay_timings->ramp_down_us)
+			udelay(delay_timings->ramp_down_us);
+	}
 }
 
 static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
@@ -390,6 +415,28 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
 	return gpiod_to_irq(fwd->descs[offset]);
 }
 
+static int gpiochip_fwd_delay_of_xlate(struct gpio_chip *chip,
+				       const struct of_phandle_args *gpiospec,
+				       u32 *flags)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	struct gpiochip_fwd_timing *timings;
+	u32 line;
+
+	if (gpiospec->args_count != chip->of_gpio_n_cells)
+		return -EINVAL;
+
+	line = gpiospec->args[0];
+	if (line >= chip->ngpio)
+		return -EINVAL;
+
+	timings = &fwd->delay_timings[line];
+	timings->ramp_up_us = gpiospec->args[1];
+	timings->ramp_down_us = gpiospec->args[2];
+
+	return line;
+}
+
 /**
  * gpiochip_fwd_create() - Create a new GPIO forwarder
  * @dev: Parent device pointer
@@ -397,6 +444,7 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
  * @descs: Array containing the GPIO descriptors to forward to.
  *         This array must contain @ngpios entries, and must not be deallocated
  *         before the forwarder has been destroyed again.
+ * @delay: True if the pins have an external delay line.
  *
  * This function creates a new gpiochip, which forwards all GPIO operations to
  * the passed GPIO descriptors.
@@ -406,7 +454,8 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
  */
 static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 						unsigned int ngpios,
-						struct gpio_desc *descs[])
+						struct gpio_desc *descs[],
+						bool delay)
 {
 	const char *label = dev_name(dev);
 	struct gpiochip_fwd *fwd;
@@ -459,6 +508,17 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	else
 		spin_lock_init(&fwd->slock);
 
+	if (delay) {
+		fwd->delay_timings = devm_kcalloc(dev, ngpios,
+						  sizeof(*fwd->delay_timings),
+						  GFP_KERNEL);
+		if (!fwd->delay_timings)
+			return ERR_PTR(-ENOMEM);
+
+		chip->of_xlate = gpiochip_fwd_delay_of_xlate;
+		chip->of_gpio_n_cells = 3;
+	}
+
 	error = devm_gpiochip_add_data(dev, chip, fwd);
 	if (error)
 		return ERR_PTR(error);
@@ -476,6 +536,7 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_desc **descs;
 	struct gpiochip_fwd *fwd;
+	bool delay;
 	int i, n;
 
 	n = gpiod_count(dev, NULL);
@@ -492,7 +553,9 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 			return PTR_ERR(descs[i]);
 	}
 
-	fwd = gpiochip_fwd_create(dev, n, descs);
+	delay = fwnode_device_is_compatible(dev_fwnode(dev), "gpio-delay");
+
+	fwd = gpiochip_fwd_create(dev, n, descs, delay);
 	if (IS_ERR(fwd))
 		return PTR_ERR(fwd);
 
@@ -500,23 +563,24 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id gpio_aggregator_dt_ids[] = {
 	/*
 	 * Add GPIO-operated devices controlled from userspace below,
-	 * or use "driver_override" in sysfs
+	 * or use "driver_override" in sysfs.
 	 */
+	{
+		.compatible = "gpio-delay",
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, gpio_aggregator_dt_ids);
-#endif
 
 static struct platform_driver gpio_aggregator_driver = {
 	.probe = gpio_aggregator_probe,
 	.driver = {
 		.name = DRV_NAME,
 		.groups = gpio_aggregator_groups,
-		.of_match_table = of_match_ptr(gpio_aggregator_dt_ids),
+		.of_match_table = gpio_aggregator_dt_ids,
 	},
 };
 
-- 
2.40.0.1.gaa8946217a0b

