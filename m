Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958815EC962
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiI0QYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiI0QYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5EF3907;
        Tue, 27 Sep 2022 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295848; x=1695831848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukOdzELifqcnXw/bosHJZLdsOJjTP4tM401DI/ki8bI=;
  b=bzUkcsuzSGjYQ99Hch1LBSTWj7q318eKZCNx+j1NS7BIIGrCE24zWCVC
   gTCPcmuI6VhcwmDk9MiwS80JtwL4Z+2vCx3Hu6HWuAh4KoNygQeZC6GNC
   kvOUEE9smB6P1KZ2tM9fRknwFD4Glg7Iu++uAY6i3HEZVZQSw66gvEw4n
   iRfATeBfqu/9fyJkeYa+1dUqXPMoF1wwP2fjTwuClQnIh+0C/JY/+XlSS
   oOA590PFQW+8R0hzAQG/+0oHhcqUWZeoB8CnAx7ubQqB0dsPP/hSezUKw
   /ki4GAKFdrTlQe9fit95A/BVcVqzwbn3pJqHBwqT1aVLZyfmD59rZzbCo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327719509"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327719509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="763935896"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="763935896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2022 09:24:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91272265; Tue, 27 Sep 2022 19:24:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 4/7] pwm: lpss: Use device_get_match_data to get device data
Date:   Tue, 27 Sep 2022 19:24:18 +0300
Message-Id: <20220927162421.11052-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_get_match_data() in ACPI case calls similar to the
acpi_match_device(). We may simplify the code and make it
generic by replacing the latter with the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-platform.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 7bbbb7a9b578..c48c6f2b2cd8 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -7,11 +7,12 @@
  * Derived from the original pwm-lpss.c
  */
 
-#include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 
 #include "pwm-lpss.h"
 
@@ -19,16 +20,13 @@
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
 	const struct pwm_lpss_boardinfo *info;
-	const struct acpi_device_id *id;
 	struct pwm_lpss_chip *lpwm;
 	void __iomem *base;
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (!id)
+	info = device_get_match_data(&pdev->dev);
+	if (!info)
 		return -ENODEV;
 
-	info = (const struct pwm_lpss_boardinfo *)id->driver_data;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.35.1

