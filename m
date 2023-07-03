Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99BA7462D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGCSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGCSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B7E76;
        Mon,  3 Jul 2023 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410347; x=1719946347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7xZnxo000Bh+G3CFWHwe0fIvv2SjEV0r+jJ4dVpi6k=;
  b=bTdK96CiPn+H/CtK0ouYngV++CwKeVhc6dfbIUD7PAyyisTxOOH9nywL
   GzNAoSu673XfWI6NMMPCtQYTYBUyXKvWiyoWtTVV5m4FnlgQLCDwMqrRX
   Hja6qbGGbD7nP/rjzj5cIi/gQZhSSYThKbr+tRiLCfcLLi79ljJv49Hck
   M90xV5UywJLf0Or8XjeaqdzIlwwXG4SZUMyybjZ/QkOPNwR1ZKaM7K8rt
   JQiAmMib1r6kW766l0WdABs8Ov94wAMfZ4smxGFBWMrUrQ86QWD/cOlfl
   cDnMbQfeCQ3+G3969PE+Q3HRKBJ2OHY9Jq6gmIABUk+yBGk75NRoRnjpm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362986963"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362986963"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721860809"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721860809"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 11:52:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 44AD517C; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 03/12] HID: cp2112: Make irq_chip immutable
Date:   Mon,  3 Jul 2023 21:52:13 +0300
Message-Id: <20230703185222.50554-4-andriy.shevchenko@linux.intel.com>
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

Since recently, the kernel is nagging about mutable irq_chips:

   "not an immutable chip, please consider fixing it!"

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 37ccf4714ad1..51399b231d36 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -164,7 +164,6 @@ struct cp2112_device {
 	atomic_t read_avail;
 	atomic_t xfer_avail;
 	struct gpio_chip gc;
-	struct irq_chip irq;
 	u8 *in_out_buffer;
 	struct mutex lock;
 
@@ -1079,16 +1078,20 @@ static void cp2112_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	__clear_bit(d->hwirq, &dev->irq_mask);
+	__clear_bit(hwirq, &dev->irq_mask);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void cp2112_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	__set_bit(d->hwirq, &dev->irq_mask);
+	gpiochip_enable_irq(gc, hwirq);
+	__set_bit(hwirq, &dev->irq_mask);
 }
 
 static void cp2112_gpio_poll_callback(struct work_struct *work)
@@ -1174,6 +1177,7 @@ static void cp2112_gpio_irq_shutdown(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
+	cp2112_gpio_irq_mask(d);
 	cancel_delayed_work_sync(&dev->gpio_poll_worker);
 }
 
@@ -1227,6 +1231,18 @@ static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
 	return ret;
 }
 
+static const struct irq_chip cp2112_gpio_irqchip = {
+	.name = "cp2112-gpio",
+	.irq_startup = cp2112_gpio_irq_startup,
+	.irq_shutdown = cp2112_gpio_irq_shutdown,
+	.irq_ack = cp2112_gpio_irq_ack,
+	.irq_mask = cp2112_gpio_irq_mask,
+	.irq_unmask = cp2112_gpio_irq_unmask,
+	.irq_set_type = cp2112_gpio_irq_type,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct cp2112_device *dev;
@@ -1336,17 +1352,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->gc.can_sleep		= 1;
 	dev->gc.parent			= &hdev->dev;
 
-	dev->irq.name = "cp2112-gpio";
-	dev->irq.irq_startup = cp2112_gpio_irq_startup;
-	dev->irq.irq_shutdown = cp2112_gpio_irq_shutdown;
-	dev->irq.irq_ack = cp2112_gpio_irq_ack;
-	dev->irq.irq_mask = cp2112_gpio_irq_mask;
-	dev->irq.irq_unmask = cp2112_gpio_irq_unmask;
-	dev->irq.irq_set_type = cp2112_gpio_irq_type;
-	dev->irq.flags = IRQCHIP_MASK_ON_SUSPEND;
-
 	girq = &dev->gc.irq;
-	girq->chip = &dev->irq;
+	gpio_irq_chip_set_chip(girq, &cp2112_gpio_irqchip);
 	/* The event comes from the outside so no parent handler */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.40.0.1.gaa8946217a0b

