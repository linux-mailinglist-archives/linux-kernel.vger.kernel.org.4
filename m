Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA966738D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFURuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjFURtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:49:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9FE1731;
        Wed, 21 Jun 2023 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369785; x=1718905785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UcbQzh/QfOhvEjVYIh628xUqEPTf7XQWOJPKRRENFlQ=;
  b=AvEmWQPFlSEaJHw05r1oH/rLykS+/0cVsbEtzYbzd6/VZMqin5X7htSf
   h+9jcYEIbRc4nK80aIpA3enD0WxT79cZ06F6WQBKfOn4DrVf1anm+u5YX
   1V5cg18pcx9qiPJJkXSVcm4a3wIe2KHA8/vBNySKIGT3EksPdpjpPAant
   kHanXyEGozh239wRSn+ziprWzEPvIpUOLARMlciAhwIaUu+ggWm95FN+1
   3Sp9L52o6E7kuJCeBw7PMQ/a0Tf9J+hI0D+MqNuRPINVUpB1LpPUCtgGB
   0QWBRWQJV02Jl3q6qibmJ8SeHwCNPDVunVDCCXa7tyoV362QbFKgMm8Za
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389819298"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389819298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691928085"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="691928085"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 10:49:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 73CD9195; Wed, 21 Jun 2023 20:49:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/5] gpiolib: Make gpiochip_hierarchy_add_domain() return domain
Date:   Wed, 21 Jun 2023 20:49:39 +0300
Message-Id: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

As a preparatory patch and for the sake of consistency, make
gpiochip_hierarchy_add_domain() return IRQ domain. While at it,
rename it to gpiochip_hierarchy_create_domain() to show
the change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0d25d9d439a2..058deaa1aa36 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1289,12 +1289,14 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
 		ops->free = irq_domain_free_irqs_common;
 }
 
-static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
+static struct irq_domain *gpiochip_hierarchy_create_domain(struct gpio_chip *gc)
 {
+	struct irq_domain *domain;
+
 	if (!gc->irq.child_to_parent_hwirq ||
 	    !gc->irq.fwnode) {
 		chip_err(gc, "missing irqdomain vital data\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (!gc->irq.child_offset_to_irq)
@@ -1306,7 +1308,7 @@ static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
 
 	gpiochip_hierarchy_setup_domain_ops(&gc->irq.child_irq_domain_ops);
 
-	gc->irq.domain = irq_domain_create_hierarchy(
+	domain = irq_domain_create_hierarchy(
 		gc->irq.parent_domain,
 		0,
 		gc->ngpio,
@@ -1314,12 +1316,12 @@ static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
 		&gc->irq.child_irq_domain_ops,
 		gc);
 
-	if (!gc->irq.domain)
-		return -ENOMEM;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
 
 	gpiochip_set_hierarchical_irqchip(gc, gc->irq.chip);
 
-	return 0;
+	return domain;
 }
 
 static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
@@ -1363,9 +1365,9 @@ EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_fourcell);
 
 #else
 
-static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
+static struct irq_domain *gpiochip_hierarchy_create_domain(struct gpio_chip *gc)
 {
-	return -EINVAL;
+	return ERR_PTR(-EINVAL);
 }
 
 static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
@@ -1664,9 +1666,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 
 	/* If a parent irqdomain is provided, let's build a hierarchy */
 	if (gpiochip_hierarchy_is_hierarchical(gc)) {
-		int ret = gpiochip_hierarchy_add_domain(gc);
-		if (ret)
-			return ret;
+		gc->irq.domain = gpiochip_hierarchy_create_domain(gc);
+		if (IS_ERR(gc->irq.domain))
+			return PTR_ERR(gc->irq.domain);
 	} else {
 		gc->irq.domain = irq_domain_create_simple(fwnode,
 			gc->ngpio,
-- 
2.40.0.1.gaa8946217a0b

