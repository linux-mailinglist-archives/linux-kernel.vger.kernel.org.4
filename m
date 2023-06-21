Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80130738D99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFURts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjFURtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:49:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F81733;
        Wed, 21 Jun 2023 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369782; x=1718905782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N75xiFEB2l7sDxs1N2ykos/S0hCXGE4VnACWdbw7VI8=;
  b=Zqlqvaks/91GNYVJOgsnKR0T7jdDpb9cPmH1rnvkxcgM2YwhYeoYo9NB
   rTPYS4Xpx1TNH48vXOExYsDsBQ+/4Eg9ho4OS/xShY/BbNc67HsDjYV0U
   ZsuzVntAnsPBMquD0439gGBqw9pZKII458BXMGOUgOA7CJzZacqxi+KkQ
   gedDk4CVwiJ2cF1ntt6OK81QszzwPFUTkwA7y7Xqnv7G4wkp+DzAXg2KD
   kHlcr/OKzZHDZfjnAROPa+eBU/zPaIHga/UrVJZn7Gg84Orh5IGFZSS2P
   CHQtNqmhBxkeGakdEd6Yv5urzybaELouc8V3j5HGoVbWjYvz3KhdlYh6i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389819289"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389819289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691928081"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="691928081"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 10:49:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8FCDA1FD; Wed, 21 Jun 2023 20:49:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 5/5] gpiolib: Replace open coded gpiochip_irqchip_add_allocated_domain()
Date:   Wed, 21 Jun 2023 20:49:43 +0300
Message-Id: <20230621174943.30302-5-andriy.shevchenko@linux.intel.com>
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

Replace open coded variant of gpiochip_irqchip_add_allocated_domain()
in gpiochip_add_irqchip().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 59d87e60b108..bc8b9d6afe0e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1642,6 +1642,9 @@ static int gpiochip_irqchip_add_allocated_domain(struct gpio_chip *gc,
 	if (!domain)
 		return -EINVAL;
 
+	if (gc->to_irq)
+		chip_warn(gc, "to_irq is redefined in %s and you shouldn't rely on it\n", __func__);
+
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
 	gc->irq.domain_is_allocated_externally = allocated_externally;
@@ -1672,6 +1675,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	struct irq_domain *domain;
 	unsigned int type;
 	unsigned int i;
+	int ret;
 
 	if (!irqchip)
 		return 0;
@@ -1692,10 +1696,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 		 "%pfw: Ignoring %u default trigger\n", fwnode, type))
 		type = IRQ_TYPE_NONE;
 
-	if (gc->to_irq)
-		chip_warn(gc, "to_irq is redefined in %s and you shouldn't rely on it\n", __func__);
-
-	gc->to_irq = gpiochip_to_irq;
 	gc->irq.default_type = type;
 	gc->irq.lock_key = lock_key;
 	gc->irq.request_key = request_key;
@@ -1708,7 +1708,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	}
 	if (IS_ERR(domain))
 		return PTR_ERR(domain);
-	gc->irq.domain = domain;
 
 	if (gc->irq.parent_handler) {
 		for (i = 0; i < gc->irq.num_parents; i++) {
@@ -1732,14 +1731,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 
 	gpiochip_set_irq_hooks(gc);
 
-	/*
-	 * Using barrier() here to prevent compiler from reordering
-	 * gc->irq.initialized before initialization of above
-	 * GPIO chip irq members.
-	 */
-	barrier();
-
-	gc->irq.initialized = true;
+	ret = gpiochip_irqchip_add_allocated_domain(gc, domain, false);
+	if (ret)
+		return ret;
 
 	acpi_gpiochip_request_interrupts(gc);
 
-- 
2.40.0.1.gaa8946217a0b

