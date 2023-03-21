Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31676C335A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjCUNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjCUNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:52:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2124989B;
        Tue, 21 Mar 2023 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679406776; x=1710942776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vRtWISRYp6eq3qtKs90frTmSpRak5mes5ShFcbgo/vQ=;
  b=Ea0tm683u4K+SlHUFecLkZNdyi4tmDJJyrNYqZj0Fn7Mpg8ZjUH8TrEY
   dcEelyL5sbeym7o/7MmXtQiza8brkPdLv3jm2+8xINnbbQQ+6mNzGsW/f
   9WCC85rEpkJzOs4m28yXoy9wuEhU516tosI4uKcsIxa4tAIMUWfd5mi89
   WmYOJIQLoN1z6sCwNlsIrCXbyDEX1VVvkwuOqQ1xFOfJzC5t3c0yWb+r+
   UK087trJ4ahxSOKgvidafhpzCpQc6N2YRdJhoZBZDyquKj1aY6aAH9B/G
   aT19p1NbWnWn9OJdnCIP7cFmqUoJzfp489H//5c/mVGk2nS5k9zrKYPfM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="338980342"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="338980342"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="927410577"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="927410577"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2023 06:52:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2AD2E3DD; Tue, 21 Mar 2023 15:53:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: Move gpiochip_get_data() upper in the code
Date:   Tue, 21 Mar 2023 15:53:31 +0200
Message-Id: <20230321135332.73190-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Move gpiochip_get_data() upper in the code as a preparation
for further refactoring.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 62114d69bcea..2bfc474d99c3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -681,6 +681,19 @@ static void gpiochip_setup_devs(void)
 	}
 }
 
+/**
+ * gpiochip_get_data() - get per-subdriver data for the chip
+ * @gc: GPIO chip
+ *
+ * Returns:
+ * The per-subdriver data for the chip.
+ */
+void *gpiochip_get_data(struct gpio_chip *gc)
+{
+	return gc->gpiodev->data;
+}
+EXPORT_SYMBOL_GPL(gpiochip_get_data);
+
 int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
@@ -939,19 +952,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 }
 EXPORT_SYMBOL_GPL(gpiochip_add_data_with_key);
 
-/**
- * gpiochip_get_data() - get per-subdriver data for the chip
- * @gc: GPIO chip
- *
- * Returns:
- * The per-subdriver data for the chip.
- */
-void *gpiochip_get_data(struct gpio_chip *gc)
-{
-	return gc->gpiodev->data;
-}
-EXPORT_SYMBOL_GPL(gpiochip_get_data);
-
 /**
  * gpiochip_remove() - unregister a gpio_chip
  * @gc: the chip to unregister
-- 
2.40.0.1.gaa8946217a0b

