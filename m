Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A354730B64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbjFNXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjFNXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:18:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0EAC;
        Wed, 14 Jun 2023 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686784678; x=1718320678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vuq1lOeFuGO/J19m1cI+coKiG4lvz42SypGElO940fk=;
  b=IrdoCveJAy1iLer1jbF9uTZd9NS6/Ac8X+dMFilMy79k0brm/ngZI5mi
   fXpUBJ70jRZRgF86ycqMhrH+S2EukTo1W2tnYIF/dbgCQ9xMfuLaquxeN
   eCfZrqZzi1EtecLUXc8bnJRQNZPN4n6iveFRBylqOpuy4Q9MoJVrinA8V
   ZAzABqijX62omuYa2qXnMV8VuxSVdseJZ3FZRZSvBba/95XWAxgxE4ZK6
   wNGWOZ6+8QteYDsrYhS4ISPmueXeL9bxVD1hhtGe6h83oj6svT7hWsbz5
   tzDKUW39PUbYNuOl3+Iw/DfAwnUo1YjgHbN/tLBBPqVqd9md2LBCtQbal
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424648032"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="424648032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 16:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715387935"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715387935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 16:14:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E558F35F; Thu, 15 Jun 2023 02:14:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/4] gpio: aggregator: Support delay for setting up individual GPIOs
Date:   Thu, 15 Jun 2023 02:14:44 +0300
Message-Id: <20230614231446.3687-3-andriy.shevchenko@linux.intel.com>
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

In some cases the GPIO may require an additional delay after setting
its value. Add support for that into the GPIO forwarder code.

This will be fully enabled for use in the following changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-aggregator.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 1aa7455672d3..a74a8d86caf3 100644
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
 
@@ -331,6 +338,28 @@ static int gpio_fwd_get_multiple_locked(struct gpio_chip *chip,
 	return error;
 }
 
+static void gpio_fwd_delay(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	const struct gpiochip_fwd_timing *delay_timings;
+	struct gpio_desc *desc = fwd->descs[offset];
+	bool is_active_low = gpiod_is_active_low(desc);
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
@@ -339,6 +368,9 @@ static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
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

