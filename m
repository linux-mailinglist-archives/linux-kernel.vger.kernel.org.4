Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E615713484
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjE0LlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjE0LlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:41:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1699;
        Sat, 27 May 2023 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685187660; x=1716723660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vQhV/X2uljI2SaCtDuLjSsVmNOvaJBWIYyBH8FBji0=;
  b=NZ7y2lET+XTvh2a+On+b21gdgiKJQSNv74mPf8qRTuxCVHOJ3kh9NZ/t
   0YRiX7eRVBNdykoW3erlQcBDm+ZxPvkGyUjXphv0kH9Q/mPJj2Nv0zY5S
   6FWOYOE4Sp56WB9y6qJwhl6Udba5cS02w/lpC02yektGDm63DJZm6T3Xn
   pGtor+i1AFTwP2To2RRwXE5y0EBk5fR3hOloxGBERBVfgsz85RA2bjpT1
   4eP4LSiFfBPupDSMCW/n9CPf8chEeR6AndhS6nIQo1q9cPQstpAfWbogc
   Sk3OfoEgSgoZy8rp/uQQFiL59EzBD7h6WjMWHMq8oUJWgYYBp0P2FtsxI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="420148086"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="420148086"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 04:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="699685259"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="699685259"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2023 04:40:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D4B0413; Sat, 27 May 2023 14:41:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpiolib: Unify allocation and initialization of GPIO valid mask
Date:   Sat, 27 May 2023 14:40:57 +0300
Message-Id: <20230527114057.36091-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230527114057.36091-1-andriy.shevchenko@linux.intel.com>
References: <20230527114057.36091-1-andriy.shevchenko@linux.intel.com>
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

Now that the of_gpiochip_add() doesn't use valid mask, we may
unify GPIO valid mask allocation and initialization. With this
it makes a symmetry to the similar which we done for IRQ chip.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6c8580d2454d..02bfe0f89871 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -485,18 +485,6 @@ static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
 	return 0;
 }
 
-static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
-{
-	if (!(gpiochip_count_reserved_ranges(gc) || gc->init_valid_mask))
-		return 0;
-
-	gc->valid_mask = gpiochip_allocate_mask(gc);
-	if (!gc->valid_mask)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
 {
 	struct device *dev = &gc->gpiodev->dev;
@@ -537,6 +525,13 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gc)
 {
 	int ret;
 
+	if (!(gpiochip_count_reserved_ranges(gc) || gc->init_valid_mask))
+		return 0;
+
+	gc->valid_mask = gpiochip_allocate_mask(gc);
+	if (!gc->valid_mask)
+		return -ENOMEM;
+
 	ret = gpiochip_apply_reserved_ranges(gc);
 	if (ret)
 		return ret;
@@ -863,7 +858,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_remove_from_list;
 
-	ret = gpiochip_alloc_valid_mask(gc);
+	ret = gpiochip_init_valid_mask(gc);
 	if (ret)
 		goto err_remove_from_list;
 
@@ -871,10 +866,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_free_gpiochip_mask;
 
-	ret = gpiochip_init_valid_mask(gc);
-	if (ret)
-		goto err_remove_of_chip;
-
 	for (i = 0; i < gc->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
 
-- 
2.40.0.1.gaa8946217a0b

