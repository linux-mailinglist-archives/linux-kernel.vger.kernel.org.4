Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610AF628638
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiKNQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiKNQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7215A3D;
        Mon, 14 Nov 2022 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444928; x=1699980928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bK27zP/N3caFulgZnyVlq3ehz9vA1uIH/LjAHWuGOM=;
  b=hQoUNycJ282qkPU7tEt1ipLZ87QRHJ1DlZ/JDsZc1OxQaW6jMBOWEx61
   JP/VS/IXp0CJKi4Si79oj/sYwNmiKmSjybYNmICtdblkiZgS5woSejAys
   8149ySJIXCRn4/R27dpPqiVPysF2AddKu8FlDuJODGheVNS27fqiIv4fn
   um5ROQIJXLo7j0K8uh01DglQ1NoGTbDgJ38vgdp7KC9VjJWDOeu6EktjQ
   nWLxD9Vt1rrvSDf5SOa/PGdSmJUU3PY57vbvDJyPonCcteBNp5Y1FszN9
   ExFlvMAt2YpyGPMTV6Ailr0KajWKLkrfjcNLeRTOfUVnWpy1CnBimcCJQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292417758"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292417758"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702079051"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702079051"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2022 08:55:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 346863B9; Mon, 14 Nov 2022 18:55:47 +0200 (EET)
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
Subject: [PATCH v4 7/7] pinctrl: intel: Enumerate PWM device when community has a capability
Date:   Mon, 14 Nov 2022 18:55:45 +0200
Message-Id: <20221114165545.56088-8-andriy.shevchenko@linux.intel.com>
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
index 52ecd66ce357..d61c22e9d531 100644
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
+	pwm = devm_pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
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

