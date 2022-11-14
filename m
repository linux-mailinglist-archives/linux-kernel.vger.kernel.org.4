Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1D628634
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiKNQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiKNQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A37F5B3;
        Mon, 14 Nov 2022 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444926; x=1699980926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBRMuBSSbtGLeszkWGLvZmNwu94+mL8SqSvJtb11lV8=;
  b=Fy1XPPeavFvP2CdGL3Z2yUglJkDmjs9JnmIaAf205oiovXRmC4d0kS1G
   9kCErMm4TvhgjNVLb8J3C0MBwYPwfpum8dbOsGcMXDT6K5H6p6t3p2C36
   dBs2s/VMdgGzoom0kKoIHmei3XwEvyOfCrLm+/MXfPB8fE6qapUMWrOt3
   d2XiShnFr/hzcckuhbD9nciD76DHDb9COngD2WJgUGPT7j0FRKlrkiP99
   02C+q9VHGcaKEspAzw343W30ZzKlvox4HOpBR4vnzq+xw3DKzpO7uWpTP
   NGqGN3iMf8cbv1xxUnvXjXDUXrG9Nt7/z7K0GudD72ewBbM8sGzLv+AdX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295382826"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295382826"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727593540"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727593540"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 08:55:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0633B32E; Mon, 14 Nov 2022 18:55:47 +0200 (EET)
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
Subject: [PATCH v4 3/7] pwm: lpss: Include headers we are the direct user of
Date:   Mon, 14 Nov 2022 18:55:41 +0200
Message-Id: <20221114165545.56088-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of integrity, include headers we are the direct
user of.

Replace the inclusion of device.h by a forward declaration
of struct device plus a (cheaper) of types.h as device.h is
an expensive include (measured in compiler effort).

While at it, move the struct pwm_lpss_chip to be after
the struct pwm_lpss_boardinfo as the former uses pointer
to the latter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 2c746c51b883..4561d229b27d 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -10,16 +10,12 @@
 #ifndef __PWM_LPSS_H
 #define __PWM_LPSS_H
 
-#include <linux/device.h>
 #include <linux/pwm.h>
+#include <linux/types.h>
 
-#define LPSS_MAX_PWMS			4
+struct device;
 
-struct pwm_lpss_chip {
-	struct pwm_chip chip;
-	void __iomem *regs;
-	const struct pwm_lpss_boardinfo *info;
-};
+#define LPSS_MAX_PWMS			4
 
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
@@ -43,6 +39,12 @@ extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
 
+struct pwm_lpss_chip {
+	struct pwm_chip chip;
+	void __iomem *regs;
+	const struct pwm_lpss_boardinfo *info;
+};
+
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
-- 
2.35.1

