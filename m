Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20446730B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjFNXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbjFNXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:18:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940AE11C;
        Wed, 14 Jun 2023 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686784682; x=1718320682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFD2RmHp6VjqlL6UdN87B/4X3j8u5LDczmhuyuUCg2c=;
  b=Uj3hTEYLHLDZdM7FsOo/XfRF1mYhstRcf8MAX3w1P/EC6n8z2znDPCPl
   BzRAj9HDoxSzmk/m2AS+7GUTu7vPPrNAdV/qhvOhyKqkcJRVTXvx/aoeM
   XRtuGvWdZjl7ACy1FC/NYvp/E2nz1pwl0x4KijfOt1qqJ6UtLG60QcJ3y
   kvHVLJITBkT6UfXBucHkC8lwK22TvBsLMRQvRWTmZfKyL6UyieXMtaAHu
   MKMNNcxR+tCE7AeOQhZYOqKBhIL7MkLtGVRgAQvOQgVJbe/Glm6ydTA+d
   G5XzV+VI0g1e2dOwfSyysTUIf9bfgeGb8b8QoF/OmA9pB+HagPExGg4be
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424648039"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="424648039"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 16:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715387933"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715387933"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 16:14:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB42630C; Thu, 15 Jun 2023 02:14:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/4] gpio: aggregator: Set up a parser of delay line parameters
Date:   Thu, 15 Jun 2023 02:14:45 +0300
Message-Id: <20230614231446.3687-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggregator mode can also handle properties of the platform,
that do not belong to the GPIO controller itself. One of such
a property is a signal delay line. Set up a parser to support it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-aggregator.c | 70 +++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index a74a8d86caf3..ed11aa56bc51 100644
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
@@ -423,6 +424,51 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
 	return gpiod_to_irq(fwd->descs[offset]);
 }
 
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
@@ -430,6 +476,7 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
  * @descs: Array containing the GPIO descriptors to forward to.
  *         This array must contain @ngpios entries, and must not be deallocated
  *         before the forwarder has been destroyed again.
+ * @delay_line: True if the pins have an external delay line.
  *
  * This function creates a new gpiochip, which forwards all GPIO operations to
  * the passed GPIO descriptors.
@@ -439,7 +486,8 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
  */
 static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 						unsigned int ngpios,
-						struct gpio_desc *descs[])
+						struct gpio_desc *descs[],
+						bool delay_line)
 {
 	const char *label = dev_name(dev);
 	struct gpiochip_fwd *fwd;
@@ -492,6 +540,12 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	else
 		spin_lock_init(&fwd->slock);
 
+	if (delay_line) {
+		error = gpiochip_fwd_setup_delay_line(dev, chip, fwd);
+		if (error)
+			return ERR_PTR(error);
+	}
+
 	error = devm_gpiochip_add_data(dev, chip, fwd);
 	if (error)
 		return ERR_PTR(error);
@@ -509,6 +563,7 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_desc **descs;
 	struct gpiochip_fwd *fwd;
+	bool delay_line;
 	int i, n;
 
 	n = gpiod_count(dev, NULL);
@@ -525,7 +580,9 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 			return PTR_ERR(descs[i]);
 	}
 
-	fwd = gpiochip_fwd_create(dev, n, descs);
+	delay_line = fwnode_device_is_compatible(dev_fwnode(dev), "gpio-delay");
+
+	fwd = gpiochip_fwd_create(dev, n, descs, delay_line);
 	if (IS_ERR(fwd))
 		return PTR_ERR(fwd);
 
@@ -534,6 +591,15 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpio_aggregator_dt_ids[] = {
+	/*
+	 * The GPIO delay provides a way to configure platform specific delays
+	 * for GPIO ramp-up or ramp-down delays. This can serve the following
+	 * purposes:
+	 * - Open-drain output using an RC filter
+	 */
+	{
+		.compatible = "gpio-delay",
+	},
 	/*
 	 * Add GPIO-operated devices controlled from userspace below,
 	 * or use "driver_override" in sysfs.
-- 
2.40.0.1.gaa8946217a0b

