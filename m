Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46C62161F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiKHOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiKHOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:22:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C254B1D;
        Tue,  8 Nov 2022 06:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917330; x=1699453330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyYkmlrH3FTwJFyY/NU3XVwDT0lsgxH2Rn0Y02epYKs=;
  b=G1+TTT565RKy1lMiBsTNmEHn5iMOuM8unZyEpMe+MWemIzobWOPfbfC8
   Sf+QGiIRCuaIvGJmctei9VJl8rRomJCnx25omWEVtZ+HWykVCsqtb0dm7
   eMSH658/teUTWEwbdD2q8QMKHFAH7p4LsjevAGxPN7qI/0ZNPWxnl0dI0
   OC8+Pe6UxF6Wd26EcUDhOb2ZE7D5I4/jC+97KpvSzKjtZ0kdvfiAp/hye
   03gtvqqoeQPMVhL1/VbyHojmli/bBXKf+N1PDa9w03hgiztobDtSUrgBO
   2BaqU96GIKZyr4nzdzMwGdB5PFUL0LEomCDapyxOtqcr+yYrvtODfRGjF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298219291"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298219291"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="761506504"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="761506504"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2022 06:22:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9945657A; Tue,  8 Nov 2022 16:22:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 6/6] pinctrl: intel: Enumerate PWM device when community has a capabilitty
Date:   Tue,  8 Nov 2022 16:22:26 +0200
Message-Id: <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
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

Some of the Communities may have PWM capability. In such cases,
enumerate PWM device via respective driver. User is still responsible
for setting correct pin muxing for the line that needs to output the
signal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 6e630e87fed6..6b685ff7041f 100644
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
@@ -1502,6 +1506,27 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
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
 static int intel_pinctrl_probe(struct platform_device *pdev,
 			       const struct intel_pinctrl_soc_data *soc_data)
 {
@@ -1588,6 +1613,10 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
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

