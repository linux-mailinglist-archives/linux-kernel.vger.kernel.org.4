Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA287462D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGCSwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGCSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE16E64;
        Mon,  3 Jul 2023 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410351; x=1719946351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3oT3A2TkcRcs3tLyPA7LqOUifp3itwdNBboGdNimiQ=;
  b=ROspkP4EJUVMRRMfWVfx0z6phDsXwlENCBMxCjjZtjvtu2UROuwo0EG/
   DqzYG3ZURn9LL82cvm3dZhFOLCvNrIJiZ/q8EPda2rrAOallb/Sx0LP/7
   vBTaXG1ymO9hreE3Z5DbnvwNcCesXkQYwSSVLFMrLhhxfIpOHjTyXLxxI
   mbyLyE9UyCXn5rWbtP1w6gV4Dr/yZxIquKKesWdV+WQ/diUWv7642Pf60
   KQtx5ihtO3ooLc1Rbm3sBbFfDJnYYKAXyIBOFFOOg62SURuletWr1CDn+
   51vXRZsYTJKa4a64+l2JjCFuRlJ4udGiCrjDKKA0RNyLtZImyV08RNMYf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449322734"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449322734"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831912483"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831912483"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 11:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6911F1C7; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 06/12] HID: cp2112: Remove dead code
Date:   Mon,  3 Jul 2023 21:52:16 +0300
Message-Id: <20230703185222.50554-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cp2112_allocate_irq() and counterparts that seems to be
a dead code from day 1. In case somebody needs it, it can be
retrieved from Git index.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 54 ----------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 15b626359281..45cd0d2fd3fd 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -17,8 +17,6 @@
  */
 
 #include <linux/bitops.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio/machine.h>
 #include <linux/gpio/driver.h>
 #include <linux/hid.h>
 #include <linux/hidraw.h>
@@ -168,7 +166,6 @@ struct cp2112_device {
 	u8 *in_out_buffer;
 	struct mutex lock;
 
-	struct gpio_desc *desc[8];
 	bool gpio_poll;
 	struct delayed_work gpio_poll_worker;
 	unsigned long irq_mask;
@@ -1181,51 +1178,6 @@ static int cp2112_gpio_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
-					      int pin)
-{
-	int ret;
-
-	if (dev->desc[pin])
-		return -EINVAL;
-
-	dev->desc[pin] = gpiochip_request_own_desc(&dev->gc, pin,
-						   "HID/I2C:Event",
-						   GPIO_ACTIVE_HIGH,
-						   GPIOD_IN);
-	if (IS_ERR(dev->desc[pin])) {
-		dev_err(dev->gc.parent, "Failed to request GPIO\n");
-		return PTR_ERR(dev->desc[pin]);
-	}
-
-	ret = cp2112_gpio_direction_input(&dev->gc, pin);
-	if (ret < 0) {
-		dev_err(dev->gc.parent, "Failed to set GPIO to input dir\n");
-		goto err_desc;
-	}
-
-	ret = gpiochip_lock_as_irq(&dev->gc, pin);
-	if (ret) {
-		dev_err(dev->gc.parent, "Failed to lock GPIO as interrupt\n");
-		goto err_desc;
-	}
-
-	ret = gpiod_to_irq(dev->desc[pin]);
-	if (ret < 0) {
-		dev_err(dev->gc.parent, "Failed to translate GPIO to IRQ\n");
-		goto err_lock;
-	}
-
-	return ret;
-
-err_lock:
-	gpiochip_unlock_as_irq(&dev->gc, pin);
-err_desc:
-	gpiochip_free_own_desc(dev->desc[pin]);
-	dev->desc[pin] = NULL;
-	return ret;
-}
-
 static const struct irq_chip cp2112_gpio_irqchip = {
 	.name = "cp2112-gpio",
 	.irq_startup = cp2112_gpio_irq_startup,
@@ -1390,7 +1342,6 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void cp2112_remove(struct hid_device *hdev)
 {
 	struct cp2112_device *dev = hid_get_drvdata(hdev);
-	int i;
 
 	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
 	i2c_del_adapter(&dev->adap);
@@ -1400,11 +1351,6 @@ static void cp2112_remove(struct hid_device *hdev)
 		cancel_delayed_work_sync(&dev->gpio_poll_worker);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(dev->desc); i++) {
-		gpiochip_unlock_as_irq(&dev->gc, i);
-		gpiochip_free_own_desc(dev->desc[i]);
-	}
-
 	gpiochip_remove(&dev->gc);
 	/* i2c_del_adapter has finished removing all i2c devices from our
 	 * adapter. Well behaved devices should no longer call our cp2112_xfer
-- 
2.40.0.1.gaa8946217a0b

