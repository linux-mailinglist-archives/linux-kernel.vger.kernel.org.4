Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D94638F87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYSLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:11:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFFE31DD6;
        Fri, 25 Nov 2022 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669399897; x=1700935897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gC1O2EpjM7tKecxBRtq3dHXj7LrD8+1bUGKq3WhcNRs=;
  b=dQ9FRFthbgcahnZiDc3I0fY+bFVaqUi5g3lt+ihLVp9YdRtx+nTuzkUP
   TephxamY0Bax4kHlHpMx6gIbw6MHsfM/Cd/vyeCK/fCEkbKPama7S9kAv
   jL91oaCs4ziwy/nEJOQPAHf294boOK/g4cDrDnrXbmwJfjrOvX55F1aff
   u4Z9wdx0VDDjAseL7bnNFlOu589aNw1q4a7ffNediR6OHZY+bjTEr0Eg/
   Yo3Tfuu7Uh1VSzYEBLRf3nXrtczNbSgYNEGgrBEcbe8LG1sDt+lVxeyqM
   L3wD0kDrW5fb8mJzhX78SQOKPTUnUYi3ZFVGNAiHAjiV/l6N6ZF8pTxHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="341426383"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="341426383"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 10:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="642762582"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="642762582"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2022 10:11:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00A77128; Fri, 25 Nov 2022 20:12:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] gpiolib: Provide to_gpio_device() helper
Date:   Fri, 25 Nov 2022 20:11:57 +0200
Message-Id: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpio/gpiolib.c | 2 +-
 drivers/gpio/gpiolib.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 119c9c3a2a50..9b935288db9d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 
 static void gpiodevice_release(struct device *dev)
 {
-	struct gpio_device *gdev = container_of(dev, struct gpio_device, dev);
+	struct gpio_device *gdev = to_gpio_device(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpio_lock, flags);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d900ecdbac46..027674025561 100644
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
@@ -72,6 +72,8 @@ struct gpio_device {
 #endif
 };
 
+#define to_gpio_device(_dev_)	container_of(_dev_, struct gpio_device, dev)
+
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
-- 
2.35.1

