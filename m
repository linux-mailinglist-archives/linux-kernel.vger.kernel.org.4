Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEC763B1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiK1TAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiK1TAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:00:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD425280;
        Mon, 28 Nov 2022 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669662047; x=1701198047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mUQHV/DcKFfPtd53tvm4FTuNIbAukvui9T3fDp+KlAc=;
  b=cDbhoIZPo1m0xawMQXLbmewSWDUKr8XK9OICb6mF7C5rSBBrmi53Aj3m
   dyx7wgq/obQ8+j1FEjILEb9qo5x1iWWjzxUoSbCgGGAHJxjjxAxSeY104
   NBE0BzuPmMRYHWMitM0s8glQ1u87xCMbdWDVPE8LN58epWX7z94aE8iWD
   fsJNJ88uFygia4vZsry60Ck9Np9WYHGeUwHW3cqW1MMk62DelO9IHN6O9
   qJLYk7YA+4Za8PZ2VjMZHaKtRJeKrfkeBWRfBkxjq3ZNoiLEsgGcf7ZzB
   b/eJODpF4yxN63doZFPVaX3DQnJcUgXKlpxxFGTphzOZDYmjZKqUXQAZa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313628916"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313628916"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712083610"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="712083610"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 11:00:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3DE3D10E; Mon, 28 Nov 2022 21:00:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] gpiolib: Provide to_gpio_device() helper
Date:   Mon, 28 Nov 2022 21:00:54 +0200
Message-Id: <20221128190055.6350-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide to_gpio_device() helper which can be utilized in the existing
and future code.

While at it, make sure it becomes no-op at compilation time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: made helper static inline (Bart)
 drivers/gpio/gpiolib.c | 2 +-
 drivers/gpio/gpiolib.h | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a11480634213..ccd47da4ec66 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -548,7 +548,7 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 
 static void gpiodevice_release(struct device *dev)
 {
-	struct gpio_device *gdev = container_of(dev, struct gpio_device, dev);
+	struct gpio_device *gdev = to_gpio_device(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpio_lock, flags);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d900ecdbac46..e443c1023a37 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -20,9 +20,9 @@
 
 /**
  * struct gpio_device - internal state container for GPIO devices
- * @id: numerical ID number for the GPIO chip
  * @dev: the GPIO device struct
  * @chrdev: character device for the GPIO device
+ * @id: numerical ID number for the GPIO chip
  * @mockdev: class device used by the deprecated sysfs interface (may be
  * NULL)
  * @owner: helps prevent removal of modules exporting active GPIOs
@@ -47,9 +47,9 @@
  * userspace.
  */
 struct gpio_device {
-	int			id;
 	struct device		dev;
 	struct cdev		chrdev;
+	int			id;
 	struct device		*mockdev;
 	struct module		*owner;
 	struct gpio_chip	*chip;
@@ -72,6 +72,11 @@ struct gpio_device {
 #endif
 };
 
+static inline struct gpio_device *to_gpio_device(struct device *dev)
+{
+	return container_of(dev, struct gpio_device, dev);
+}
+
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
-- 
2.35.1

