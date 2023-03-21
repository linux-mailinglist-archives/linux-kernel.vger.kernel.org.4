Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A96C3372
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCUNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCUNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:54:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34094FCD8;
        Tue, 21 Mar 2023 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679406839; x=1710942839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ghqHSYYR9HkUFWf0Y7Mfj7c4+87GevTnsySVxln5WI=;
  b=CMFrIPzf6Inu55SPI4rE+3V4VJ4WEZ0+CQcPYObqyQRXGwGGFY3459LY
   6DIM9PNUoxL9r3/N1qDNMKGSi4mRI/hFowN7kscvwj/YbUvF5lQyw4Cjz
   rbPbSxHNJSUmfSR3f1sIU0Xuo7NatJnTVOYkA9R4hl9qSy/fQpcw4LvO7
   7X7oiGgM9+G0fs4xwG8UY137PJYDFHD2DsOFDBv8TPpFBbaLW5rWc6omw
   vvDBufdG++ei1fpYs4sPQEI7kfgxe3p2ySwY44J6fAsMV7lIQ8zt0K0nD
   zOe5fAjT5+BEUsIDmaysRuc52ELR4OLO0VIGSmk5ndG4Q8LYrREy9wKeo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319333155"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319333155"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="713999591"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="713999591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2023 06:53:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 028C64FF; Tue, 21 Mar 2023 15:54:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpiolib: Check array_info for NULL only once in gpiod_get_array()
Date:   Tue, 21 Mar 2023 15:54:12 +0200
Message-Id: <20230321135412.73240-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230321135412.73240-1-andriy.shevchenko@linux.intel.com>
References: <20230321135412.73240-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_get_array() has a long if-else-if branching where each of them
tests for the same variable to be not NULL. Instead, check for NULL
before even going to that flow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3e94990f1f90..ee24428c5fe3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4294,7 +4294,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 	if (!descs)
 		return ERR_PTR(-ENOMEM);
 
-	for (descs->ndescs = 0; descs->ndescs < count; ) {
+	for (descs->ndescs = 0; descs->ndescs < count; descs->ndescs++) {
 		desc = gpiod_get_index(dev, con_id, descs->ndescs, flags);
 		if (IS_ERR(desc)) {
 			gpiod_put_array(descs);
@@ -4339,8 +4339,13 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 				   count - descs->ndescs);
 			descs->info = array_info;
 		}
+
+		/* If there is no cache for fast bitmap processing path, continue */
+		if (!array_info)
+			continue;
+
 		/* Unmark array members which don't belong to the 'fast' chip */
-		if (array_info && array_info->chip != gc) {
+		if (array_info->chip != gc) {
 			__clear_bit(descs->ndescs, array_info->get_mask);
 			__clear_bit(descs->ndescs, array_info->set_mask);
 		}
@@ -4348,8 +4353,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 		 * Detect array members which belong to the 'fast' chip
 		 * but their pins are not in hardware order.
 		 */
-		else if (array_info &&
-			   gpio_chip_hwgpio(desc) != descs->ndescs) {
+		else if (gpio_chip_hwgpio(desc) != descs->ndescs) {
 			/*
 			 * Don't use fast path if all array members processed so
 			 * far belong to the same chip as this one but its pin
@@ -4363,7 +4367,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 				__clear_bit(descs->ndescs,
 					    array_info->set_mask);
 			}
-		} else if (array_info) {
+		} else {
 			/* Exclude open drain or open source from fast output */
 			if (gpiochip_line_is_open_drain(gc, descs->ndescs) ||
 			    gpiochip_line_is_open_source(gc, descs->ndescs))
@@ -4374,8 +4378,6 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 				__set_bit(descs->ndescs,
 					  array_info->invert_mask);
 		}
-
-		descs->ndescs++;
 	}
 	if (array_info)
 		dev_dbg(dev,
-- 
2.40.0.1.gaa8946217a0b

