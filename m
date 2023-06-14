Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4869730B74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjFNXTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjFNXSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:18:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F307271C;
        Wed, 14 Jun 2023 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686784693; x=1718320693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZHl2n4pQk9SJY0+lqSTvrEjOmrphzRUODe48oQg0/w=;
  b=BC48ERjpXXAUNTTLtd6W2kFGmDFTukZ4hrdw2BLBCmjlueqJauZFvJUp
   asSHF3ZYiVw4BrQrZ0cJPtKe1O8XtdAiUYCNHvvrZmRvx5aAaPyyepnU3
   0OUk3Fjm4RNGUDRAfHSn6bz8eo/mVqf0tYOjNOL33QeRu0wldNd89UyMc
   k+/uo1xXRahJZeF7zEnrn+kZ/FRhcuCTalbusDeJmsvSZ9n5nM5ZScXlA
   OaolWnLxwnKmOU9uWH3i5dNYwc1R3OliETYDQJgx4GYj5FRRlZagbQkkt
   w7HBKkUo7OzG5DxUpvlaolkynwYF0Wawo7WYas7UlgPS2gdQyIC5rpwf+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424648059"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="424648059"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 16:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715387936"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715387936"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 16:14:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB4E9133; Thu, 15 Jun 2023 02:14:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/4] gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
Date:   Thu, 15 Jun 2023 02:14:43 +0300
Message-Id: <20230614231446.3687-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They stop the driver being used with ACPI PRP0001 and are something
I want to avoid being cut and paste into new drivers. Also include
mod_devicetable.h as we struct of_device_id is defined in there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-aggregator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 20a686f12df7..1aa7455672d3 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -12,6 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
@@ -500,23 +501,21 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id gpio_aggregator_dt_ids[] = {
 	/*
 	 * Add GPIO-operated devices controlled from userspace below,
-	 * or use "driver_override" in sysfs
+	 * or use "driver_override" in sysfs.
 	 */
 	{}
 };
 MODULE_DEVICE_TABLE(of, gpio_aggregator_dt_ids);
-#endif
 
 static struct platform_driver gpio_aggregator_driver = {
 	.probe = gpio_aggregator_probe,
 	.driver = {
 		.name = DRV_NAME,
 		.groups = gpio_aggregator_groups,
-		.of_match_table = of_match_ptr(gpio_aggregator_dt_ids),
+		.of_match_table = gpio_aggregator_dt_ids,
 	},
 };
 
-- 
2.40.0.1.gaa8946217a0b

