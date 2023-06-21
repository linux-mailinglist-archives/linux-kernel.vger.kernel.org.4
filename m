Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA2738D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjFURtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFURtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:49:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87503E41;
        Wed, 21 Jun 2023 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369785; x=1718905785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YP5QjbCjQUTAvk5hMhdqtzeImdCvYuUXEySMOpba5Mw=;
  b=OqmVu7Q66+2sbiw2uQOy4m1b+D4DTg8mDzR5TYCxv6YOwgIpvSvoEIA0
   oX3DTqBEhgnDc6gPAfc50xfXega4/2Vap0rLMqsL56jjt0vWwrf+ZweIF
   e6zOHKYT4Uof0b35TmjrIehw1NvKVWGQQQK4eUuNFYhspzHFo12qhT7o3
   g0TEyOSZ30liOzwvt5pcKZPzgh2XiQeoGWYkxepMIobsTaZ/AiRJRnTsm
   4qO5sNI9kimHdqHgpE2t8uW1BTABoXKDQmweX2FTta4A2nbdBIj/GUstI
   QQ0uamSvtKPom7f918GGZRbp8o6YCOv/mAgI03TVLwbzxHY4GkrAucbno
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389819294"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389819294"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691928084"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="691928084"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 10:49:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B3902C7; Wed, 21 Jun 2023 20:49:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/5] gpiolib: Split out gpiochip_irqchip_add_allocated_domain() helper
Date:   Wed, 21 Jun 2023 20:49:42 +0300
Message-Id: <20230621174943.30302-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com>
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpiochip_irqchip_add_allocated_domain() can be used
in another place in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0e40f9a44519..59d87e60b108 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1635,6 +1635,28 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
 	}
 }
 
+static int gpiochip_irqchip_add_allocated_domain(struct gpio_chip *gc,
+						 struct irq_domain *domain,
+						 bool allocated_externally)
+{
+	if (!domain)
+		return -EINVAL;
+
+	gc->to_irq = gpiochip_to_irq;
+	gc->irq.domain = domain;
+	gc->irq.domain_is_allocated_externally = allocated_externally;
+
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.initialized before adding irqdomain.
+	 */
+	barrier();
+
+	gc->irq.initialized = true;
+
+	return 0;
+}
+
 /**
  * gpiochip_add_irqchip() - adds an IRQ chip to a GPIO chip
  * @gc: the GPIO chip to add the IRQ chip to
@@ -1788,22 +1810,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain)
 {
-	if (!domain)
-		return -EINVAL;
-
-	gc->to_irq = gpiochip_to_irq;
-	gc->irq.domain = domain;
-	gc->irq.domain_is_allocated_externally = true;
-
-	/*
-	 * Using barrier() here to prevent compiler from reordering
-	 * gc->irq.initialized before adding irqdomain.
-	 */
-	barrier();
-
-	gc->irq.initialized = true;
-
-	return 0;
+	return gpiochip_irqchip_add_allocated_domain(gc, domain, true);
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
 
-- 
2.40.0.1.gaa8946217a0b

