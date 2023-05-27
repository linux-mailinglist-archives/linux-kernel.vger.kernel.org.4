Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62104713482
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjE0LlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0Lk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:40:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C3412A;
        Sat, 27 May 2023 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685187657; x=1716723657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QC4EyfXO3AcM4/0Pzq8plC2mDQ7iHdK2qw8lFxVpt48=;
  b=oF4qMeDoI9PhvN9xgSmqiDN1AJpljJa1367Xs7eOkJ8LRA7jQiX2PXtZ
   LyvnDJzRN+VkrL0qcrwXB6pkTgV98CnZ2lcS+kFr4qUHubknuIBLBYC9N
   5t1Lq7azEGaAbpU07vcyfdRWOYDbhBBQj8PSH5EON7YEl3lXvvamq20er
   scpOsWE71YtWiC2tCAJ8+T/sI1/YGV33gMt4fVmlsdSQmj8YwGLVqEd/W
   8aw0F20wokPVCHfzEjSyao82prw/lqUaqwudwbjSoWttD0PlUDqrtzGo4
   ZNhtdCFWt4tDgtToiStBnwJgUHBZYuHVOPOXT6nVcghC0Pbb7y07JClpy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="420148079"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="420148079"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 04:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="699685247"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="699685247"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2023 04:40:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B293240F; Sat, 27 May 2023 14:40:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: Consolidate the allocated mask freeing APIs
Date:   Sat, 27 May 2023 14:40:56 +0300
Message-Id: <20230527114057.36091-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a common API to allocate a mask, but more than one duplicative
counterparts. Consolidate the latter into a single common API beneath.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e62db4fc85cc..6c8580d2454d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -466,6 +466,12 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
 	return p;
 }
 
+static void gpiochip_free_mask(unsigned long **p)
+{
+	bitmap_free(*p);
+	*p = NULL;
+}
+
 static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
 {
 	struct device *dev = &gc->gpiodev->dev;
@@ -545,8 +551,7 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gc)
 
 static void gpiochip_free_valid_mask(struct gpio_chip *gc)
 {
-	bitmap_free(gc->valid_mask);
-	gc->valid_mask = NULL;
+	gpiochip_free_mask(&gc->valid_mask);
 }
 
 static int gpiochip_add_pin_ranges(struct gpio_chip *gc)
@@ -1090,8 +1095,7 @@ static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gc)
 
 static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc)
 {
-	bitmap_free(gc->irq.valid_mask);
-	gc->irq.valid_mask = NULL;
+	gpiochip_free_mask(&gc->irq.valid_mask);
 }
 
 bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
-- 
2.40.0.1.gaa8946217a0b

