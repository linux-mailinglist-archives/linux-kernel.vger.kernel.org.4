Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6A6AF109
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCGSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjCGSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:38:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E4B1A45;
        Tue,  7 Mar 2023 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678213775; x=1709749775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CSNAcNFQayClXMTySPfDcCuCcMuolxnjUNEXNEcwx0E=;
  b=P5/4ZEzHeV2coRDgN+bN239o6kHY57ZIlpXCuW3Dnh80ODxw8VVbLyrD
   IRxeJEqONaWWXYLBDruXYR0AYV1qU/5WH3SgKhCRjb5m1dn14mclud0TH
   uLHvqDU6hgncW4UA22hV9Uu6J6iqHxhku10DzsxoMWr8C+8ifxjlkX+26
   WzzhMo5gl/afl1pqwcyHyuAFkVR/9F83ur3N5GvUCKgL484BE8gmE7TNU
   FTUD3wi0KtXMuIjqUPVlPXhH+MWq8XHaIk0BbqQElXZYZiS2LVmFgk2x7
   Byv1/CjrPeljAn3XMwVxGg0FP04FZK7crosn/zX1ivCerH8CKQ8+qMD/T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316333928"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316333928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="706902045"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="706902045"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2023 10:25:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 14977154; Tue,  7 Mar 2023 20:25:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/3] gpiolib: Get rid of gpio_bus_match() forward declaration
Date:   Tue,  7 Mar 2023 20:25:56 +0200
Message-Id: <20230307182557.42215-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing specific about gpio_bus_match(), so we may
simply move it to the top of the file and get rid of forward
declaration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c7f35f0e7d15..a44a1b0f2766 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -62,7 +62,20 @@
 static DEFINE_IDA(gpio_ida);
 static dev_t gpio_devt;
 #define GPIO_DEV_MAX 256 /* 256 GPIO chip devices supported */
-static int gpio_bus_match(struct device *dev, struct device_driver *drv);
+
+static int gpio_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	/*
+	 * Only match if the fwnode doesn't already have a proper struct device
+	 * created for it.
+	 */
+	if (fwnode && fwnode->dev != dev)
+		return 0;
+	return 1;
+}
+
 static struct bus_type gpio_bus_type = {
 	.name = "gpio",
 	.match = gpio_bus_match,
@@ -4417,20 +4430,6 @@ void gpiod_put_array(struct gpio_descs *descs)
 }
 EXPORT_SYMBOL_GPL(gpiod_put_array);
 
-
-static int gpio_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-
-	/*
-	 * Only match if the fwnode doesn't already have a proper struct device
-	 * created for it.
-	 */
-	if (fwnode && fwnode->dev != dev)
-		return 0;
-	return 1;
-}
-
 static int gpio_stub_drv_probe(struct device *dev)
 {
 	/*
-- 
2.39.1

