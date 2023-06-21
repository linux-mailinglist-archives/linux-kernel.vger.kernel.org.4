Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795B2738D96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjFURtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFURtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:49:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3811718;
        Wed, 21 Jun 2023 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369781; x=1718905781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdcUcjY6P739bulIvEkWeV/vSYtThvEuSEz95gNk9Zw=;
  b=XJObtDWvvw/ga0sMmuK91gESfw48jbl9XYWALd1P5jcGqzSXLngK03LW
   3qV/PBFX3pFHXgi0WgBiasPutU8LwxfJb9gZWz4oMAu0oTYj4lAdzk2KT
   F1FzFELyxqWKydkKAyzX0DiNUyH6rN7f0gSwBX8tOARLjq6Bm1oQF1Xr7
   jmzz38slUaPmuN1GhNUDUs1EXO+PTYf8sI8jaY2r0OI4rQX/JvTY+fRbL
   cuWUbjkmTfPcUJpRldllAVWW0gEfuVhJNfXyZyxCc5x+YEL7ZI85qJ/U2
   4xIvof1bm37ag46Jmioh8d0IIooEMH4bp4OWKqHZ5CNzVJ3O2DK1L1qts
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389819283"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389819283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691928082"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="691928082"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 10:49:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D689193; Wed, 21 Jun 2023 20:49:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/5] gpiolib: Factor out gpiochip_simple_create_domain()
Date:   Wed, 21 Jun 2023 20:49:40 +0300
Message-Id: <20230621174943.30302-2-andriy.shevchenko@linux.intel.com>
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

As a preparatory patch and for the sake of consistency,
factor out gpiochip_simple_create_domain().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 058deaa1aa36..fac1124d5016 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1444,6 +1444,19 @@ static const struct irq_domain_ops gpiochip_domain_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
+static struct irq_domain *gpiochip_simple_create_domain(struct gpio_chip *gc)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
+	struct irq_domain *domain;
+
+	domain = irq_domain_create_simple(fwnode, gc->ngpio, gc->irq.first,
+					  &gpiochip_domain_ops, gc);
+	if (!domain)
+		return ERR_PTR(-EINVAL);
+
+	return domain;
+}
+
 /*
  * TODO: move these activate/deactivate in under the hierarchicial
  * irqchip implementation as static once SPMI and SSBI (all external
@@ -1670,13 +1683,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 		if (IS_ERR(gc->irq.domain))
 			return PTR_ERR(gc->irq.domain);
 	} else {
-		gc->irq.domain = irq_domain_create_simple(fwnode,
-			gc->ngpio,
-			gc->irq.first,
-			&gpiochip_domain_ops,
-			gc);
-		if (!gc->irq.domain)
-			return -EINVAL;
+		gc->irq.domain = gpiochip_simple_create_domain(gc);
+		if (IS_ERR(gc->irq.domain))
+			return PTR_ERR(gc->irq.domain);
 	}
 
 	if (gc->irq.parent_handler) {
-- 
2.40.0.1.gaa8946217a0b

