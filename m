Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6862D909
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiKQLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiKQLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317095C74F;
        Thu, 17 Nov 2022 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683282; x=1700219282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RK+XGHZ2BELVVYkxCYeGM6RfxC8qsuOPoluHIaCRq2s=;
  b=R+iJ5Cvo2Mki1IeRdhrlzG7Eu5NnQ6aEVYbVUCy5L5fXluZerCkwd8+r
   9GKChPwrLeju5+dy0T2TNJEOYx4hEipV+XDBKjJ0Y7f0USWzipBfXaYwX
   UkePNZBJsMYmb3KNSvaUhyz/VEgNbkbvogjM5YktSTtS/4jz5MkIv0h7f
   aFgZK/vLqxrZ+GVl9qBX18+VPsvA//poqAN2x5IdiyR1tzvkEt1pdVft4
   VtFdOdTwItiEwicb61V/M7J+H6dYr9wXUQbY3q2MRYYXN0QA3dQYC+qJd
   JFk7bSukzzWKIinkCLEsPpQi6Q4EodErZSImjf8b6hPLRt9rSDUN9BSIr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314638732"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314638732"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617572346"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="617572346"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2022 03:07:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99CDF2B7; Thu, 17 Nov 2022 13:08:24 +0200 (EET)
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
Subject: [PATCH v5 7/7] pinctrl: intel: Enumerate PWM device when community has a capability
Date:   Thu, 17 Nov 2022 13:08:06 +0200
Message-Id: <20221117110806.65470-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the Communities may have PWM capability. In such cases,
enumerate the PWM device via respective driver. A user is still
responsible for setting correct pin muxing for the line that
needs to output the signal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 52ecd66ce357..d74c8b650aa7 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -21,6 +21,8 @@
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
+#include <linux/platform_data/x86/pwm-lpss.h>
+
 #include "../core.h"
 #include "pinctrl-intel.h"
 
@@ -46,6 +48,8 @@
 #define PADOWN_MASK(p)			(GENMASK(3, 0) << PADOWN_SHIFT(p))
 #define PADOWN_GPP(p)			((p) / 8)
 
+#define PWMC				0x204
+
 /* Offset from pad_regs */
 #define PADCFG0				0x000
 #define PADCFG0_RXEVCFG_SHIFT		25
@@ -1499,6 +1503,27 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
 	return 0;
 }
 
+static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
+				   struct intel_community *community)
+{
+	static const struct pwm_lpss_boardinfo info = {
+		.clk_rate = 19200000,
+		.npwm = 1,
+		.base_unit_bits = 22,
+		.bypass = true,
+	};
+	struct pwm_lpss_chip *pwm;
+
+	if (!(community->features & PINCTRL_FEATURE_PWM))
+		return 0;
+
+	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
+		return 0;
+
+	pwm = devm_pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
+	return PTR_ERR_OR_ZERO(pwm);
+}
+
 static int intel_pinctrl_probe(struct platform_device *pdev,
 			       const struct intel_pinctrl_soc_data *soc_data)
 {
@@ -1584,6 +1609,10 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
 			ret = intel_pinctrl_add_padgroups_by_size(pctrl, community);
 		if (ret)
 			return ret;
+
+		ret = intel_pinctrl_probe_pwm(pctrl, community);
+		if (ret)
+			return ret;
 	}
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.35.1

