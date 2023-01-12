Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE408667BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbjALQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjALQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:44:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026DBE14;
        Thu, 12 Jan 2023 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541513; x=1705077513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4BOtLkvp4AVdkK2zPygGM6fUB1lerPp5K/6FblR5a3Q=;
  b=R5vyJ2Bagf28KdcLpfMWEKK5BjBZkusDsNjni2ghCRQUqfVKwfjpxcrs
   TXkCSRImEkmjOPXH5Yp9jW+F+y6U1od1pg3zAns3M7aRI8Ef3F11TmAXF
   aYLg5QnZvFTTrAeCqQn672iYh9ccv9tTe6+n8KaiRWlAntvdW1D8vNiwP
   eXVrVtYyVIBc19iZKZRSEVORw7nZ18sNdco5+2ZUr8Az8cK4haiLTVQBq
   6Sn1OB+ZIh5g9ovU8p+r2z2MptqvQyVp35o2SgUOUiQt2xxPGd0sEbeAi
   D22IRZrUzrggCcKD9Pnn0MBjOTyEcqjOOsx6WaXaW+gzxjnXxe8g7htZx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304132472"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304132472"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:38:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="635446946"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="635446946"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2023 08:37:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B8AE0130; Thu, 12 Jan 2023 18:38:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] gpiolib: of: Remove no more used ->of_gpio_ranges_fallback()
Date:   Thu, 12 Jan 2023 18:38:25 +0200
Message-Id: <20230112163825.72983-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112163825.72983-1-andriy.shevchenko@linux.intel.com>
References: <20230112163825.72983-1-andriy.shevchenko@linux.intel.com>
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

Since the only one and last user of the ->of_gpio_ranges_fallback()
gone, remove the callback completely. New platforms must use the
gpio-ranges property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c   |  5 -----
 include/linux/gpio/driver.h | 11 -----------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 72d8a3da31e3..266352b1a966 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -980,11 +980,6 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 	if (!np)
 		return 0;
 
-	if (!of_property_read_bool(np, "gpio-ranges") &&
-	    chip->of_gpio_ranges_fallback) {
-		return chip->of_gpio_ranges_fallback(chip, np);
-	}
-
 	group_names = of_find_property(np, group_names_propname, NULL);
 
 	for (;; index++) {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index ddc7a14a274f..29c283919f8a 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -522,17 +522,6 @@ struct gpio_chip {
 	int (*of_xlate)(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags);
 
-	/**
-	 * @of_gpio_ranges_fallback:
-	 *
-	 * Optional hook for the case that no gpio-ranges property is defined
-	 * within the device tree node "np" (usually DT before introduction
-	 * of gpio-ranges). So this callback is helpful to provide the
-	 * necessary backward compatibility for the pin ranges.
-	 */
-	int (*of_gpio_ranges_fallback)(struct gpio_chip *gc,
-				       struct device_node *np);
-
 #endif /* CONFIG_OF_GPIO */
 };
 
-- 
2.39.0

