Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE4738D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjFURu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFURty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:49:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7A1BC3;
        Wed, 21 Jun 2023 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369790; x=1718905790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGD3tk/qL1WcZv7h1naypCRcwmKu0ejHb+zaSupSua4=;
  b=VZZtPqFf3pVdiiAF8njYL2CJbWrufuHyp65jOfg4x60PMPSXh/pdkhSF
   FKlGqDyXiZg7YypEXuNeQU60xjTO3zar32DSi3lsxYrKJgU1/hqHUNkA8
   rM+mHyn4s3w4+79Z8c+tie2RO2DOQufUTnHtC3qRJdlkLoiUz1IBEGO8l
   B91OSM2ZTrCZIP5mA4UusHX+lUtnvEI1gg2DtOOITDhH8hO3jaHYtctEe
   Yovlizl9AtmSpU0i/AVoSasS9VucVxWVXxhGOD/geiUzG6G2ptB9J4Sq1
   8rufD7F3GAL19MTBYnC9Lg2UhQGpZRFYGTMB5YJwOTFJN4Shi6T+9vwVk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="344988562"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="344988562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888775360"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="888775360"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 10:49:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84880241; Wed, 21 Jun 2023 20:49:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/5] gpiolib: Do not assign error pointer to the GPIO IRQ chip domain
Date:   Wed, 21 Jun 2023 20:49:41 +0300
Message-Id: <20230621174943.30302-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com>
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check domain for being an error pointer before assigning it to
the GPIO IRQ chip domain.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fac1124d5016..0e40f9a44519 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1647,6 +1647,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
 	struct irq_chip *irqchip = gc->irq.chip;
+	struct irq_domain *domain;
 	unsigned int type;
 	unsigned int i;
 
@@ -1679,14 +1680,13 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 
 	/* If a parent irqdomain is provided, let's build a hierarchy */
 	if (gpiochip_hierarchy_is_hierarchical(gc)) {
-		gc->irq.domain = gpiochip_hierarchy_create_domain(gc);
-		if (IS_ERR(gc->irq.domain))
-			return PTR_ERR(gc->irq.domain);
+		domain = gpiochip_hierarchy_create_domain(gc);
 	} else {
-		gc->irq.domain = gpiochip_simple_create_domain(gc);
-		if (IS_ERR(gc->irq.domain))
-			return PTR_ERR(gc->irq.domain);
+		domain = gpiochip_simple_create_domain(gc);
 	}
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+	gc->irq.domain = domain;
 
 	if (gc->irq.parent_handler) {
 		for (i = 0; i < gc->irq.num_parents; i++) {
-- 
2.40.0.1.gaa8946217a0b

