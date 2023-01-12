Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC166787D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjALPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbjALPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:03:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9D11445;
        Thu, 12 Jan 2023 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673535071; x=1705071071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=13YRSR/zsRqqgjhYpJm174uRo/KGZCssmqWBQJ2Mzeo=;
  b=Q6zJ4l8RHg41JBfvvcqZkEt8ggwE3UZ52Wv9NSz36TpFaNs//I1H3Y7O
   6i/XRfnrmZaYrdQIArNfW375pvNgUB+MDqdFZCmtySdj5WRDaejzyUgg4
   B75HpaO4s/J8KclrB30qZ3/aCSkf6vmZRw1CAyfux3+gZEPNQcpfTZhr0
   DkdMPcrQgIudxtx8uaaAMF82Yj750ffWGioXFLNbRUCF305070v3rAly6
   5tDTN0ZaNl+Iw4bHabCBaAk3AWUilqCjVt9uExAngsDX/z53hvkYYii4L
   avXXwS6KvkjIPPzJoY//sTYRVE3l4XR2hnVVeA4GeArJHfs4jm0+GHDYh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="303417279"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="303417279"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659810256"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659810256"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 06:51:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E8D02130; Thu, 12 Jan 2023 16:51:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only user
Date:   Thu, 12 Jan 2023 16:51:40 +0200
Message-Id: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library for OF is the only user for enum of_gpio_flags.
Move it there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 15 +++++++++++++++
 include/linux/of_gpio.h   | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index edc769d2d338..72d8a3da31e3 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -23,6 +23,21 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 
+/*
+ * This is Linux-specific flags. By default controllers' and Linux' mapping
+ * match, but GPIO controllers are free to translate their own flags to
+ * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
+ */
+enum of_gpio_flags {
+	OF_GPIO_ACTIVE_LOW = 0x1,
+	OF_GPIO_SINGLE_ENDED = 0x2,
+	OF_GPIO_OPEN_DRAIN = 0x4,
+	OF_GPIO_TRANSITORY = 0x8,
+	OF_GPIO_PULL_UP = 0x10,
+	OF_GPIO_PULL_DOWN = 0x20,
+	OF_GPIO_PULL_DISABLE = 0x40,
+};
+
 /**
  * of_gpio_named_count() - Count GPIOs for a device
  * @np:		device node to count GPIOs for
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 935225caf70d..5d58b3b0a97e 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -17,21 +17,6 @@
 
 struct device_node;
 
-/*
- * This is Linux-specific flags. By default controllers' and Linux' mapping
- * match, but GPIO controllers are free to translate their own flags to
- * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
- */
-enum of_gpio_flags {
-	OF_GPIO_ACTIVE_LOW = 0x1,
-	OF_GPIO_SINGLE_ENDED = 0x2,
-	OF_GPIO_OPEN_DRAIN = 0x4,
-	OF_GPIO_TRANSITORY = 0x8,
-	OF_GPIO_PULL_UP = 0x10,
-	OF_GPIO_PULL_DOWN = 0x20,
-	OF_GPIO_PULL_DISABLE = 0x40,
-};
-
 #ifdef CONFIG_OF_GPIO
 
 #include <linux/container_of.h>
-- 
2.39.0

