Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621516B2D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCIS5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCIS5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:57:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894699648;
        Thu,  9 Mar 2023 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678388261; x=1709924261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c5dTu2CZvuq1hBNYCmGy0MCK7h9+S2ynqISd2D698T8=;
  b=dWAoyBH0bFvjKoKdsJ4ht5NlViYoUfh8zz2SEdzWpCmzizP8oBVSgkL4
   mjf0sTKYihidfa8P1cUxl0N9d9lL6G0DC7fEBr2HzsAOMW9MYMynwBdHs
   R5JC4D4cIJRm8ZX1WfFnMqeRRhExqDU2/59qxzW6urR6H9qoXG544bbda
   Yhpw9u0FTdUXohA9iTupnJTSTrnV8eRmjaoihTjgvfXTrhWKpHKLmX3JY
   DpWEooSmxXScLDbuD5dN0+l0I3QSeDcfkkaMep2/r3mcOTmij7QvswJgb
   VnM0yRxcT7VkY8vAYy0S35tGzZIMmgEXSDmwopptkpBs9J3QobzW+zFw4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401387672"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="401387672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="766543583"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="766543583"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2023 10:57:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 561B2143; Thu,  9 Mar 2023 20:58:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: Use IRQ hardware number getter instead of direct access
Date:   Thu,  9 Mar 2023 20:58:19 +0200
Message-Id: <20230309185819.85050-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ framework provides special type and getter to transform
the Linux IRQ to the hardware pin. Use that type and getter
function instead of direct access.

While at it, amend an indentation in a couple of places.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e47e462b14ed..72e907134bac 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1216,7 +1216,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	if (ret)
 		return ret;
 
-	chip_dbg(gc, "allocate IRQ %d, hwirq %lu\n", irq,  hwirq);
+	chip_dbg(gc, "allocate IRQ %d, hwirq %lu\n", irq, hwirq);
 
 	ret = girq->child_to_parent_hwirq(gc, hwirq, type,
 					  &parent_hwirq, &parent_type);
@@ -1384,8 +1384,7 @@ static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
  * gpiochip by assigning the gpiochip as chip data, and using the irqchip
  * stored inside the gpiochip.
  */
-int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
-		     irq_hw_number_t hwirq)
+int gpiochip_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwirq)
 {
 	struct gpio_chip *gc = d->host_data;
 	int ret = 0;
@@ -1461,8 +1460,9 @@ int gpiochip_irq_domain_activate(struct irq_domain *domain,
 				 struct irq_data *data, bool reserve)
 {
 	struct gpio_chip *gc = domain->host_data;
+	unsigned int hwirq = irqd_to_hwirq(data);
 
-	return gpiochip_lock_as_irq(gc, data->hwirq);
+	return gpiochip_lock_as_irq(gc, hwirq);
 }
 EXPORT_SYMBOL_GPL(gpiochip_irq_domain_activate);
 
@@ -1479,8 +1479,9 @@ void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
 				    struct irq_data *data)
 {
 	struct gpio_chip *gc = domain->host_data;
+	unsigned int hwirq = irqd_to_hwirq(data);
 
-	return gpiochip_unlock_as_irq(gc, data->hwirq);
+	return gpiochip_unlock_as_irq(gc, hwirq);
 }
 EXPORT_SYMBOL_GPL(gpiochip_irq_domain_deactivate);
 
@@ -1520,33 +1521,37 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 int gpiochip_irq_reqres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
 
-	return gpiochip_reqres_irq(gc, d->hwirq);
+	return gpiochip_reqres_irq(gc, hwirq);
 }
 EXPORT_SYMBOL(gpiochip_irq_reqres);
 
 void gpiochip_irq_relres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
 
-	gpiochip_relres_irq(gc, d->hwirq);
+	gpiochip_relres_irq(gc, hwirq);
 }
 EXPORT_SYMBOL(gpiochip_irq_relres);
 
 static void gpiochip_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
 
 	if (gc->irq.irq_mask)
 		gc->irq.irq_mask(d);
-	gpiochip_disable_irq(gc, d->hwirq);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void gpiochip_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
 
-	gpiochip_enable_irq(gc, d->hwirq);
+	gpiochip_enable_irq(gc, hwirq);
 	if (gc->irq.irq_unmask)
 		gc->irq.irq_unmask(d);
 }
@@ -1554,17 +1559,19 @@ static void gpiochip_irq_unmask(struct irq_data *d)
 static void gpiochip_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
 
-	gpiochip_enable_irq(gc, d->hwirq);
+	gpiochip_enable_irq(gc, hwirq);
 	gc->irq.irq_enable(d);
 }
 
 static void gpiochip_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
 
 	gc->irq.irq_disable(d);
-	gpiochip_disable_irq(gc, d->hwirq);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
-- 
2.39.1

