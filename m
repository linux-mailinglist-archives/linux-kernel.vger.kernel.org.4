Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496086C335B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCUNxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCUNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:53:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF94A1C7;
        Tue, 21 Mar 2023 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679406776; x=1710942776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hih2m2l9MHORIYrioILT7AecrZMqNTqBdwbA/XpbI0U=;
  b=HfGsa+WrEi4rTYNcnuMQK2txZyQgiYkcL+oNPfZe6NR2g9jPpW3Vvzsi
   a7GuV+d+KzFTV5rTqd6gaJX9r+uQrKp/ZQEHNJ87BDLW+kOsof+uzxXwW
   ptIJKKIVDym6o9WMHwuiZTM5d1BnB95mAgVApeHcJoFopcJzR40hLh33d
   PP8S2txTO7UE84rdFqRJdLKIK3GdLL7VO5JMTIuVFC0Tk2/1qgYsdUTRI
   p1Py4D7hl8hhofPoAuKQTTiKC5taBAUlV1aLNoYG+HG3lZS8QVn6h8aFx
   JYOY61e22az7YVy2Si3wRG0z6+uVs7lR/1wY6/mhd6ZB0aPHmNuObahaX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322782127"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="322782127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="745855975"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="745855975"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 06:52:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4681B4FF; Tue, 21 Mar 2023 15:53:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpiolib: Add gpiochip_set_data() helper
Date:   Tue, 21 Mar 2023 15:53:32 +0200
Message-Id: <20230321135332.73190-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230321135332.73190-1-andriy.shevchenko@linux.intel.com>
References: <20230321135332.73190-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are too many 'data' parameters here and there.

For the better maintenance keep access GPIO device data
via getter and setter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 2bfc474d99c3..51a19cbe39a4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -681,6 +681,11 @@ static void gpiochip_setup_devs(void)
 	}
 }
 
+static void gpiochip_set_data(struct gpio_chip *gc, void *data)
+{
+	gc->gpiodev->data = data;
+}
+
 /**
  * gpiochip_get_data() - get per-subdriver data for the chip
  * @gc: GPIO chip
@@ -723,7 +728,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gdev->dev.bus = &gpio_bus_type;
 	gdev->dev.parent = gc->parent;
 	gdev->chip = gc;
+
 	gc->gpiodev = gdev;
+	gpiochip_set_data(gc, data);
 
 	device_set_node(&gdev->dev, gc->fwnode);
 
@@ -790,7 +797,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	}
 
 	gdev->ngpio = gc->ngpio;
-	gdev->data = data;
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
@@ -978,9 +984,9 @@ void gpiochip_remove(struct gpio_chip *gc)
 	gpiochip_free_valid_mask(gc);
 	/*
 	 * We accept no more calls into the driver from this point, so
-	 * NULL the driver data pointer
+	 * NULL the driver data pointer.
 	 */
-	gdev->data = NULL;
+	gpiochip_set_data(gc, NULL);
 
 	spin_lock_irqsave(&gpio_lock, flags);
 	for (i = 0; i < gdev->ngpio; i++) {
-- 
2.40.0.1.gaa8946217a0b

