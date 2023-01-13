Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97B66A09D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjAMRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjAMRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:23:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CFFA41E0;
        Fri, 13 Jan 2023 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630079; x=1705166079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8stOTJGnm5tBQ17hxvmLP0ufU3YgC/jbWgKibzqyBQ=;
  b=F5VvlyjH9/uVcSJ8isNoNBceJwIhETUNuGtaqAbsgq/tUR7Ff7hIljzb
   gHWy7YQIiTYjx0+yUPCoDR+rA0pw/i8jUQckVcaCoR/rxZEpsXnYbXQHq
   JOjd1gzntiSDm1fVDTDsChcBwwdNxT+VaPlmEKKhTe8JYjDrHs/KPXWQz
   AieiU/3fVTlagltyP2z3f2hHD5aYKNpuK6V2O1pgkKX9EwsdahITQJbae
   Vflsx4K4UxJmHg/ClP6moerC718OVjp7P9yGHdHau73Qu5Ieu4ADETNTF
   eKSo8iN4SrWCjWnc85QSouofIEOssjRJQ3Klon5fykL1FVSwl72bNdDXP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="326101567"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="326101567"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="903625125"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="903625125"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2023 09:10:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8741F92; Fri, 13 Jan 2023 19:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] Revert "gpiolib: of: Introduce hook for missing gpio-ranges"
Date:   Fri, 13 Jan 2023 19:10:51 +0200
Message-Id: <20230113171051.19309-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
References: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
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

This reverts commit 3550bba25d5587a701e6edf20e20984d2ee72c78.

No users for this one, revert it for good.
The ->add_pin_ranges() can be used instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: made it as a pure revert
 drivers/gpio/gpiolib-of.c   |  5 -----
 include/linux/gpio/driver.h | 12 ------------
 2 files changed, 17 deletions(-)

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
index ddc7a14a274f..5ab50ba3c309 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -521,18 +521,6 @@ struct gpio_chip {
 	 */
 	int (*of_xlate)(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags);
-
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

