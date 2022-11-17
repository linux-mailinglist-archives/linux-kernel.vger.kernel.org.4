Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0C62D910
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiKQLJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiKQLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EE69DEA;
        Thu, 17 Nov 2022 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683294; x=1700219294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ozLU2nu1r74X7A+30A92Kia7Sm7wFG1fM/nv/pGjLco=;
  b=KsmephcQBHc2JuRbkPzilXlr0ownOD869HdRe1oQQE/bikFHgjxg5LPV
   W/50bSln3EgBuOOuRWJttOrvqJgNWiPxHW3Ms1A0897wvYutR8sxBAu7X
   44GvzDnyeIe6v0VnzU5wKZ7L9x3eHwvTB/WuWEIYeYdcaUuS7P5eHF0Hm
   jSCGwawsIYZC9AhBPvqFaRBjRftccuP3eq4kcpA9ZNG2L6CG0pxAQO+mH
   bv/uYiami2ZhJ1a1bn1W20p/TlXknrYKHxV/3e2f3Wwurr4Vc7AigkAm7
   TQuzVK/wtqJr2EH44APJ9IqwJ68UBFEGUGbS+vIoNVxkZgtlq9c4/6aJ2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313971564"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="313971564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639763983"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="639763983"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2022 03:08:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E0E83B5; Thu, 17 Nov 2022 13:08:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 4/7] pwm: lpss: Allow other drivers to enable PWM LPSS
Date:   Thu, 17 Nov 2022 13:08:03 +0200
Message-Id: <20221117110806.65470-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The PWM LPSS device can be embedded in another device.
In order to enable it, allow that drivers to probe
a corresponding device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss.h                        | 22 +--------------
 .../linux/platform_data/x86}/pwm-lpss.h       | 28 ++++---------------
 2 files changed, 6 insertions(+), 44 deletions(-)
 copy {drivers/pwm => include/linux/platform_data/x86}/pwm-lpss.h (53%)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 4ce6daa46ca8..bf841250385f 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -13,7 +13,7 @@
 #include <linux/pwm.h>
 #include <linux/types.h>
 
-struct device;
+#include <linux/platform_data/x86/pwm-lpss.h>
 
 #define LPSS_MAX_PWMS			4
 
@@ -23,29 +23,9 @@ struct pwm_lpss_chip {
 	const struct pwm_lpss_boardinfo *info;
 };
 
-struct pwm_lpss_boardinfo {
-	unsigned long clk_rate;
-	unsigned int npwm;
-	unsigned long base_unit_bits;
-	/*
-	 * Some versions of the IP may stuck in the state machine if enable
-	 * bit is not set, and hence update bit will show busy status till
-	 * the reset. For the rest it may be otherwise.
-	 */
-	bool bypass;
-	/*
-	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
-	 * messes with the PWM0 controllers state,
-	 */
-	bool other_devices_aml_touches_pwm_regs;
-};
-
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
-				     const struct pwm_lpss_boardinfo *info);
-
 #endif	/* __PWM_LPSS_H */
diff --git a/drivers/pwm/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
similarity index 53%
copy from drivers/pwm/pwm-lpss.h
copy to include/linux/platform_data/x86/pwm-lpss.h
index 4ce6daa46ca8..296bd837ddbb 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -1,27 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Intel Low Power Subsystem PWM controller driver
- *
- * Copyright (C) 2014, Intel Corporation
- *
- * Derived from the original pwm-lpss.c
- */
+/* Intel Low Power Subsystem PWM controller driver */
 
-#ifndef __PWM_LPSS_H
-#define __PWM_LPSS_H
+#ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
+#define __PLATFORM_DATA_X86_PWM_LPSS_H
 
-#include <linux/pwm.h>
 #include <linux/types.h>
 
 struct device;
 
-#define LPSS_MAX_PWMS			4
-
-struct pwm_lpss_chip {
-	struct pwm_chip chip;
-	void __iomem *regs;
-	const struct pwm_lpss_boardinfo *info;
-};
+struct pwm_lpss_chip;
 
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
@@ -40,12 +27,7 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
-extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
-
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
-#endif	/* __PWM_LPSS_H */
+#endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

