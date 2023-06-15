Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF06731A72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbjFONvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343567AbjFONvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:51:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC11BDB;
        Thu, 15 Jun 2023 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837081; x=1718373081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m1IxT8Tqx2Xt34NPHZ0FTzyvORZk2opPVHLCk2AQe2Q=;
  b=h8wkNM8ultuahNJM4vyepIO0733nK4fLVi5NBzHxuc7NUnTs8fdjwbEZ
   hfYwG98kg60oFjUg6l4iR2pCYPSJP7xNaCHlAn6c7+mmCBpjW/Mr1LKB2
   9goeH04/v99qj/zrOnNgoT7B1O+++OfsLhcVOPY1y65h7mqHs1exilRnK
   NP/ITUmSmP+BNS34oWMhHWqsB8/xGLfOc1/kGwDm9tOQhpchs46ZZOGkO
   xotKqPPtIkc5PwTfB3YyE13cbzJGSCt5cDOZWOO4ZbnbBZ89a12Sb407b
   xF2yRNunnJCP4ANkTmlDS5xP246Ai/uBktaRg5Fepvy5QvMKZugf5NMls
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361404873"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361404873"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802338784"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802338784"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 06:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E1A5677; Thu, 15 Jun 2023 16:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 3/5] gpio: aggregator: Prevent collisions between DT and user device IDs
Date:   Thu, 15 Jun 2023 16:20:21 +0300
Message-Id: <20230615132023.13801-4-andriy.shevchenko@linux.intel.com>
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

In case we have a device instantiated via DT or other means than
via new_device sysfs node, the collision with the latter is possible.
Prevent such collisions by allocating user instantiated devices with
higher IDs, currently set to 1024.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-aggregator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 4a470dd8b75d..8892cb37ad79 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -26,6 +26,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 
+#define AGGREGATOR_MIN_DEVID 1024
 #define AGGREGATOR_MAX_GPIOS 512
 
 /*
@@ -135,7 +136,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	}
 
 	mutex_lock(&gpio_aggregator_lock);
-	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&gpio_aggregator_idr, aggr, AGGREGATOR_MIN_DEVID, 0, GFP_KERNEL);
 	mutex_unlock(&gpio_aggregator_lock);
 
 	if (id < 0) {
-- 
2.40.0.1.gaa8946217a0b

