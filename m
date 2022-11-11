Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6788562619C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiKKSnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiKKSnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:43:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AE13EA9;
        Fri, 11 Nov 2022 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668192194; x=1699728194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JkhCDlfC4G8PjgtwMiU9aSAo1nZwhhcu2HF+orAPBSg=;
  b=gsjHtjmWvXeeprcIBLz/WLRt8JQDlgkavbk3uRq11VuZJk/vszGaerg6
   nJfXwoTLFkb46z9KEMCgPXKNBiZ14Xr01lQwyBwbxGuBPBinQxeQYiYkY
   8b3Wl7z2NNIMJcft9FSNHv18uh42fAoeTJwrnwx3lRJaVD6bAWZhaQmJH
   slkAkzJCDV9LrvVP2OW7l/5xYORxj8GEOiY/9KAOc+fFpDOq9oNChmIbV
   t1dRQ969oVQSAEO5i/TzEabspnu784esnOY1FYryoTDtWg2U7O67BiJrZ
   6PNfSncVrCFr4eVe3E26hAkhYa0h8JevjQfm79amF1INsJGq0TV6zYfeD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="299162196"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="299162196"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="812517804"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="812517804"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2022 10:43:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5394B4B5; Fri, 11 Nov 2022 20:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 6/6] pinctrl: intel: Enumerate PWM device when community has a capability
Date:   Fri, 11 Nov 2022 20:43:28 +0200
Message-Id: <20221111184328.58108-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
References: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
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
enumerate the PWM device via respective driver. User is still
responsible for setting correct pin muxing for the line that
needs to output the signal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 52ecd66ce357..3ebdf5589bd6 100644
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
@@ -1499,6 +1503,30 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
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
+	pwm = pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
+	if (IS_ERR(pwm))
+		return PTR_ERR(pwm);
+
+	return 0;
+}
+
 static int intel_pinctrl_probe(struct platform_device *pdev,
 			       const struct intel_pinctrl_soc_data *soc_data)
 {
@@ -1584,6 +1612,10 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
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

