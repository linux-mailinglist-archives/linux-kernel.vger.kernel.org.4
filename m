Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57D66A572
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjAMVxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjAMVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:53:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69889BF9;
        Fri, 13 Jan 2023 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646818; x=1705182818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mauPY81Xtcz+rmaZWIXeWEYO5Sk4VsNtM/vWELEMpbQ=;
  b=daOVOUbFkaf/B8j55E12+MQ0Xon3UGfDMHOTxdMJJiG4wwOwemr3uJh4
   QZi7SvNoDWE8dMM9lnpOwYpu2AUMNtrP3mPrXUDuZVkK6RY2LCYDSbVEY
   r4GFzZEY2Ec/UBjUviE88oogAjlSZYuGCuSvYl2/gtIPkTzQtbkHeg0pt
   yJoSECF81hhvccvt84Ydz1fOxiZeqP+SJuHSonXtTAVuFt0uA1kM3Tcix
   FuFroGQMG4Zkc72rKwEva5As72XbhzV+jUmUpj34XclRo2XP0r73J7UHD
   R7MVPj6nO4MpUns7uwfPXA/t0pl/RWbBBIF3MKzKH8zFkLdrPPEN4Qav4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351343138"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351343138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766170870"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="766170870"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 13:53:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8BFD931D; Fri, 13 Jan 2023 23:53:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 4/4] Revert "gpiolib: of: Introduce hook for missing gpio-ranges"
Date:   Fri, 13 Jan 2023 23:53:52 +0200
Message-Id: <20230113215352.44272-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

