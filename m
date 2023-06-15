Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B105F731A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjFONvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344520AbjFONv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:51:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CC1FCC;
        Thu, 15 Jun 2023 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837086; x=1718373086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHlnlkHPA91wHreN8tHin7Ou/hR9tUoGjail7ciaYAg=;
  b=NhS0s/bIZhaQWXCZy+jj/xWffXnF8ZTDClYNIfXM0nEZBYbvgPq0qCIc
   VNpgiXLnoU2zZgqNuRF0fFYJ2wQm9lOVBdQ5/PX7/o+HvK27sg538C6cF
   6NdDcQa9lt+GVOlDktBiJkGeDry1dpZNsxf/69kxVetpAzx4D7D3feZY8
   J7fghV3JLBIR/XApDWYUD54bovHTvj+GQcaGMSIxVWU+rqC9VqRlsSWU5
   cCt216fSls732Fl+f7yprtTgM/CgV50xsPhnWHzNhrUb38eiqwAumoJND
   OP3zv8tLSnVk2PlXn6Kg9WNBrksEHzRxvXC2syH54g6TA0ATd/Xhv47yc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361404921"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361404921"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802338785"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802338785"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 06:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E3BA192; Thu, 15 Jun 2023 16:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 1/5] gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
Date:   Thu, 15 Jun 2023 16:20:19 +0300
Message-Id: <20230615132023.13801-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They stop the driver being used with ACPI PRP0001 and are something
I want to avoid being cut and paste into new drivers. Also include
mod_devicetable.h as we struct of_device_id is defined in there.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

