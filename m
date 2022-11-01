Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2973A614EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiKAP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKAP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:56:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC32167E8;
        Tue,  1 Nov 2022 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667318191; x=1698854191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9EMEBtyd+ncSOy04taxX8rD97/YD448iR78mVb4VTLI=;
  b=Amc1/UUZbZYYXCeYtWD7C+H1E+Dkd5JxPxMR007CkP4uPucKxkzSc1vB
   nsUJyvY1/61kXXdo01XGdUzEl+qA+Q9YgVMFBj5NKrNZs5rVO54B71wJh
   50CmP/33NsoS9XFMkAAd/5gwxqTFjXxnV6mygEwk9BCCKgQ9VGJ0dsqQ/
   XBte+/lC9xUgEgJqhL8M/qV8ywX22ddQpF1RFm/UvqE0HWlCipFS1o+aG
   5F6JNUy/jv6h/XO8LAo4V6E5whsQmatlLY+yo7/g2H1PIqSwNOquA5+Hx
   c0M4nSMqbcpJY4++s7+VUUYf60rqY8hwSZadtnCS5jh0wHpFoJ54Mz9cZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292474815"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292474815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776537934"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776537934"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 08:56:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 903364B5; Tue,  1 Nov 2022 17:56:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 6/6] pinctrl: intel: Enumerate PWM device when community has a capabilitty
Date:   Tue,  1 Nov 2022 17:56:42 +0200
Message-Id: <20221101155642.52575-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
References: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the Communities may have PWM capability. In such cases,
enumerate PWM device via respective driver. User is still responsible
for setting correct pin muxing for the line that needs to output the
signal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index e17d1318b913..fe5bf2184cbf 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -24,6 +24,8 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include <linux/platform_data/x86/pwm-lpss.h>
+
 #include "../core.h"
 #include "pinctrl-intel.h"
 
@@ -49,6 +51,8 @@
 #define PADOWN_MASK(p)			(GENMASK(3, 0) << PADOWN_SHIFT(p))
 #define PADOWN_GPP(p)			((p) / 8)
 
+#define PWMC				0x204
+
 /* Offset from pad_regs */
 #define PADCFG0				0x000
 #define PADCFG0_RXEVCFG_SHIFT		25
@@ -1494,6 +1498,27 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
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
+	pwm = pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
+	if (IS_ERR(pwm) && PTR_ERR(pwm) != -ENODEV)
+		return PTR_ERR(pwm);
+
+	return 0;
+}
+
 int intel_pinctrl_probe(struct platform_device *pdev,
 			const struct intel_pinctrl_soc_data *soc_data)
 {
@@ -1592,6 +1617,10 @@ int intel_pinctrl_probe(struct platform_device *pdev,
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

