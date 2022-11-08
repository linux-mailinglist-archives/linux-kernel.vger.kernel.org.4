Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A9621612
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiKHOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiKHOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:22:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E854B0D;
        Tue,  8 Nov 2022 06:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917327; x=1699453327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3WwHPrGYys4CM9wArmF05npxQAsVuUHXIQrsJgDTthA=;
  b=ZN261CEaHOZHPI3HLUxY/UrppgnZgBuZlNn6VI7quBnUwrN+lgWzoSpV
   BeD07CBevYXyfrgUE7VivGWGNRJLLlZ/v5wCpU5Hs6lL8WaIvG4JYgqTo
   XQdd6VhQnJxjLgQv1pxZ08nM+l6aknOuwLSFmRwB5A8u5aejyA2aIr5AS
   qbbPGgsbBKb+Xbk2JHquK5RkHr5La0WZ/CjBSmd9gJaOJSrem6mBoOlhK
   Je0++cTO4vurwqRM/5P12zDOvgCrSt9MBrjffd7lnGpILcHYrW3u+87A5
   cAoydPJl9VgeiAIoHmhrrTPlYSDAHKf/oSON+xzOm9rKTOyeHgbC1xYPM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298219278"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298219278"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699938289"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="699938289"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 06:22:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D7B92B7; Tue,  8 Nov 2022 16:22:27 +0200 (EET)
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
Subject: [PATCH v2 3/6] pwm: lpss: Include headers we are direct user of
Date:   Tue,  8 Nov 2022 16:22:23 +0200
Message-Id: <20221108142226.63161-4-andriy.shevchenko@linux.intel.com>
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

For the sake of integrity, include headers we are direct user of.

While at it, move the struct pwm_lpss_chip to be after
the struct pwm_lpss_boardinfo as the former uses pointer
to the latter.

Replace device.h with a forward declaration in order to improve
the compilation time due to reducing overhead of device.h parsing
with entire train of dependencies.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

