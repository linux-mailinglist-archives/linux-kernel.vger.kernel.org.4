Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C195B5EC6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiI0Ou2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiI0Otf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232E7968A;
        Tue, 27 Sep 2022 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290056; x=1695826056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukOdzELifqcnXw/bosHJZLdsOJjTP4tM401DI/ki8bI=;
  b=Q4n6Qqa5VvO0+Gg1o8mBCPoUztuVd6inowYSl7h7vIoLoTgB7WG2Uj0l
   Wqd+5BlLsOXVoUW3z3ADnAXjRkJx9msq4La+SMMzC52n5hyRxrHgrxKQY
   EVmJBDNVJ+yeswygj0WYc4a4Mo1ggN9bHM+tpXlQpMu+dmOlTqu7LjoHR
   imX7n8loaykBwTdiYayjAzFbUZwe96kY5mBeoZWBKgA3HZiZeBBumfvN8
   AT1dV2CAn30QHwYEiDysGsJ/RyfKY7m7keiYbZjQybeSercmWWuNTUNH3
   WOUIMoZ0DqlPpc+3d1LS57uYtrBa0AT/p9i+RYjjqX1hsMVNh6/k67sux
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365377050"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="365377050"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="796788525"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="796788525"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2022 07:47:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B0FE1265; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 5/8] pwm: lpss: Use device_get_match_data to get device data
Date:   Tue, 27 Sep 2022 17:47:20 +0300
Message-Id: <20220927144723.9655-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

