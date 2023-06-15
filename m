Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7F731A73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjFONvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjFONvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:51:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464C1BDB;
        Thu, 15 Jun 2023 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837083; x=1718373083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05ajh+nMpM5e9Do3hT1hquzqCJRfHJXHSX3q930HuGo=;
  b=cdQlKSKpBav0QUR3UdR7Ec8VDICodqQINEhDllUFtDN3EJ0gdjlckZ/9
   wnfS0UmRk5x3r7Obhc2CMv4PZ0IO4cd9i6NMWUGbYOTTcpGlxPMa3brT6
   VmsEnRCsLTg8EsML/93VTcPsxsxpFYONkct2jbYkkNJI6RJLTkPotjN84
   lvv2B16iJirt/Q6KlBaiROzAYhw+TPa6U1JY0dFjY0FkBPFWQ5fEJ9U6N
   k7CiMFWlmqcRVJvYuhA3vqGDbYbWKjjQCYWy7VA+s8wvTZfXRL0lulb/8
   dkvC3xZgNpoRQys9otBX3haV+0uZ0rEL5jjMjjYiuL6zB3r1HcZ5GJ6Yg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361404890"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361404890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802338783"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802338783"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 06:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5695866C; Thu, 15 Jun 2023 16:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 2/5] gpio: aggregator: Support delay for setting up individual GPIOs
Date:   Thu, 15 Jun 2023 16:20:20 +0300
Message-Id: <20230615132023.13801-3-andriy.shevchenko@linux.intel.com>
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

In some cases the GPIO may require an additional delay after setting
its value. Add support for that into the GPIO forwarder code.

This will be fully enabled for use in the following changes.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-aggregator.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 1aa7455672d3..4a470dd8b75d 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -10,6 +10,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -240,6 +241,11 @@ static void __exit gpio_aggregator_remove_all(void)
  *  GPIO Forwarder
  */
 
+struct gpiochip_fwd_timing {
+	u32 ramp_up_us;
+	u32 ramp_down_us;
+};
+
 struct gpiochip_fwd {
 	struct gpio_chip chip;
 	struct gpio_desc **descs;
@@ -247,6 +253,7 @@ struct gpiochip_fwd {
 		struct mutex mlock;	/* protects tmp[] if can_sleep */
 		spinlock_t slock;	/* protects tmp[] if !can_sleep */
 	};
+	struct gpiochip_fwd_timing *delay_timings;
 	unsigned long tmp[];		/* values and descs for multiple ops */
 };
 
@@ -331,6 +338,27 @@ static int gpio_fwd_get_multiple_locked(struct gpio_chip *chip,
 	return error;
 }
 
+static void gpio_fwd_delay(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	const struct gpiochip_fwd_timing *delay_timings;
+	bool is_active_low = gpiod_is_active_low(fwd->descs[offset]);
+	u32 delay_us;
+
+	delay_timings = &fwd->delay_timings[offset];
+	if ((!is_active_low && value) || (is_active_low && !value))
+		delay_us = delay_timings->ramp_up_us;
+	else
+		delay_us = delay_timings->ramp_down_us;
+	if (!delay_us)
+		return;
+
+	if (chip->can_sleep)
+		fsleep(delay_us);
+	else
+		udelay(delay_us);
+}
+
 static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
@@ -339,6 +367,9 @@ static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
 		gpiod_set_value_cansleep(fwd->descs[offset], value);
 	else
 		gpiod_set_value(fwd->descs[offset], value);
+
+	if (fwd->delay_timings)
+		gpio_fwd_delay(chip, offset, value);
 }
 
 static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
-- 
2.40.0.1.gaa8946217a0b

