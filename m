Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D12628633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiKNQzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiKNQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB431116D;
        Mon, 14 Nov 2022 08:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444927; x=1699980927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tc2JPC4Ucwzjez+ObJHFyVfZGmoZxVkh4qEL5MEhM04=;
  b=TfvqZO61wfG0TAKVUd38J5+CSC778/UdQ+Nj5fjr+ANz8hZd5pMRbBSf
   uyiVc1KgiI0h7GLsHEFRAKO4n6gBrLG8W3+/zrwcxsSRe6H6Xz20uFINi
   60SW5UwTTm8w6QOr54Xqt5cz4khqAYW8KsHh8GiXUMjd5ZU+IdVwMUVJ8
   3bOt8UV5J9vcBN+E59cil+Xjg+qNBUHCcwbClfuJk8+mdwax0EGxzv8IZ
   QZjFomdrySiR9RPOy4Hyj8siGaWpUN2vtx24GQQFTmzTgaKCPMhji5kpt
   zXXYVG/dYcgGnmsmRL3woml8ZUS2A6dDG7TP09TU4hJFBWetf6BsGQYbQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292417751"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292417751"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702079043"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702079043"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2022 08:55:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C7B8348; Mon, 14 Nov 2022 18:55:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 4/7] pwm: lpss: Allow other drivers to enable PWM LPSS
Date:   Mon, 14 Nov 2022 18:55:42 +0200
Message-Id: <20221114165545.56088-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
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

The PWM LPSS device can be embedded in another device.
In order to enable it, allow that drivers to probe
a corresponding device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.h                        | 22 +--------------
 .../linux/platform_data/x86}/pwm-lpss.h       | 28 ++++---------------
 2 files changed, 6 insertions(+), 44 deletions(-)
 copy {drivers/pwm => include/linux/platform_data/x86}/pwm-lpss.h (53%)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 4561d229b27d..b721532c6c3c 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -13,27 +13,10 @@
 #include <linux/pwm.h>
 #include <linux/types.h>
 
-struct device;
+#include <linux/platform_data/x86/pwm-lpss.h>
 
 #define LPSS_MAX_PWMS			4
 
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
@@ -45,7 +28,4 @@ struct pwm_lpss_chip {
 	const struct pwm_lpss_boardinfo *info;
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
-				     const struct pwm_lpss_boardinfo *info);
-
 #endif	/* __PWM_LPSS_H */
diff --git a/drivers/pwm/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
similarity index 53%
copy from drivers/pwm/pwm-lpss.h
copy to include/linux/platform_data/x86/pwm-lpss.h
index 4561d229b27d..296bd837ddbb 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -1,21 +1,14 @@
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
+struct pwm_lpss_chip;
 
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
@@ -34,18 +27,7 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
-extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
-
-struct pwm_lpss_chip {
-	struct pwm_chip chip;
-	void __iomem *regs;
-	const struct pwm_lpss_boardinfo *info;
-};
-
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
-#endif	/* __PWM_LPSS_H */
+#endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

