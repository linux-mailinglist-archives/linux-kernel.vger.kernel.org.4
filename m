Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0A731A79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjFONvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjFONv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:51:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9EA1FC3;
        Thu, 15 Jun 2023 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837086; x=1718373086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VnFSx970LoohkoeDP4Iivoj0ONbOU2BclvXilEmqLAo=;
  b=OUFxHQd1MGs5zkXd4TAp8RLzpd1al3quzUvCpkxRgR27hRp/cMHDIHPP
   tKRSsLw/y18opTwXv5ibveeLSiEOTHQh5BqsbVVE/9H/bfafSCY9hFjlK
   VPV4noWwIV/5aDHwJ2OR+O7ue5dXlBZeFwmQPbDz69/XWANUT8Qk9Kty1
   JkN+by9ykaF/zFOBLcs8uboZPxf+5kIdgMpA2LPkaPpxbayUum3UiJU2Y
   DBI/dr+w5gurv+N+p/LDNU/juTcKBFXwZSjn2RCScQXCY5VNbFUcHkR0N
   a72+or9/cTOHs239lnElidmsbmq/M59B1xpvW5QaGw+MeY5rlEGU7G4O4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361404920"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361404920"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802338788"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802338788"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 06:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6B57C403; Thu, 15 Jun 2023 16:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 4/5] gpio: aggregator: Set up a parser of delay line parameters
Date:   Thu, 15 Jun 2023 16:20:22 +0300
Message-Id: <20230615132023.13801-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
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

The aggregator mode can also handle properties of the platform,
that do not belong to the GPIO controller itself. One of such
a property is a signal delay line. Set up a parser to support it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-aggregator.c | 72 +++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 8892cb37ad79..b944ce9e030e 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -423,6 +424,59 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
 	return gpiod_to_irq(fwd->descs[offset]);
 }
 
+/*
+ * The GPIO delay provides a way to configure platform specific delays
+ * for the GPIO ramp-up or ramp-down delays. This can serve the following
+ * purposes:
+ *   - Open-drain output using an RC filter
+ */
+#define FWD_FEATURE_DELAY		BIT(0)
+
+#ifdef CONFIG_OF_GPIO
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
+static int gpiochip_fwd_setup_delay_line(struct device *dev, struct gpio_chip *chip,
+					 struct gpiochip_fwd *fwd)
+{
+	fwd->delay_timings = devm_kcalloc(dev, chip->ngpio,
+					  sizeof(*fwd->delay_timings),
+					  GFP_KERNEL);
+	if (!fwd->delay_timings)
+		return -ENOMEM;
+
+	chip->of_xlate = gpiochip_fwd_delay_of_xlate;
+	chip->of_gpio_n_cells = 3;
+
+	return 0;
+}
+#else
+static int gpiochip_fwd_setup_delay_line(struct device *dev, struct gpio_chip *chip,
+					 struct gpiochip_fwd *fwd)
+{
+	return 0;
+}
+#endif	/* !CONFIG_OF_GPIO */
+
 /**
  * gpiochip_fwd_create() - Create a new GPIO forwarder
  * @dev: Parent device pointer
@@ -430,6 +484,7 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
  * @descs: Array containing the GPIO descriptors to forward to.
  *         This array must contain @ngpios entries, and must not be deallocated
  *         before the forwarder has been destroyed again.
+ * @features: Bitwise ORed features as defined with FWD_FEATURE_*.
  *
  * This function creates a new gpiochip, which forwards all GPIO operations to
  * the passed GPIO descriptors.
@@ -439,7 +494,8 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
  */
 static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 						unsigned int ngpios,
-						struct gpio_desc *descs[])
+						struct gpio_desc *descs[],
+						unsigned long features)
 {
 	const char *label = dev_name(dev);
 	struct gpiochip_fwd *fwd;
@@ -492,6 +548,12 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	else
 		spin_lock_init(&fwd->slock);
 
+	if (features & FWD_FEATURE_DELAY) {
+		error = gpiochip_fwd_setup_delay_line(dev, chip, fwd);
+		if (error)
+			return ERR_PTR(error);
+	}
+
 	error = devm_gpiochip_add_data(dev, chip, fwd);
 	if (error)
 		return ERR_PTR(error);
@@ -509,6 +571,7 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_desc **descs;
 	struct gpiochip_fwd *fwd;
+	unsigned long features;
 	int i, n;
 
 	n = gpiod_count(dev, NULL);
@@ -525,7 +588,8 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 			return PTR_ERR(descs[i]);
 	}
 
-	fwd = gpiochip_fwd_create(dev, n, descs);
+	features = (uintptr_t)device_get_match_data(dev);
+	fwd = gpiochip_fwd_create(dev, n, descs, features);
 	if (IS_ERR(fwd))
 		return PTR_ERR(fwd);
 
@@ -534,6 +598,10 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpio_aggregator_dt_ids[] = {
+	{
+		.compatible = "gpio-delay",
+		.data = (void *)FWD_FEATURE_DELAY,
+	},
 	/*
 	 * Add GPIO-operated devices controlled from userspace below,
 	 * or use "driver_override" in sysfs.
-- 
2.40.0.1.gaa8946217a0b

