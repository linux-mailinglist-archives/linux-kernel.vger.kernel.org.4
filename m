Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B466A575
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAMVx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjAMVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:53:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0FF8A200;
        Fri, 13 Jan 2023 13:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646819; x=1705182819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/1Cne1W4AwpoRsJk54/v3XiqpKeXDprBTs8fqxisP4=;
  b=CajFBfOJewbuH4eEMbrabrbzrvkQx9IR0lg3S7M6Uv69y4etNILhrNw/
   IHkTgjYC3pnTz9lmgHDRTtt7dD5d7nOSS2YMi2MTrYVK6fu4wFfykbWus
   mGtRMjqCGdJgEYwzZfIsvK1a1WO2rAVOp8lAP6t8E78j/3O/rIt6WPIzM
   bUpGJih/qh4pX5wuSxSGypA3IcTB5Fk5tK7qeB/synoVRY1otu1SArvHX
   fMRWjeV0RyVQhvlVD4LaUefhy85+INrKMxOO2uLu7Y64VPUP1e2+fUC0t
   j18viFjWm1H/t4BWPQbwUnkTEFaU5cuCNBrnWQFR10JR4ZEf1F6zD5mau
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351343122"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351343122"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766170869"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="766170869"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 13:53:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77F46130; Fri, 13 Jan 2023 23:53:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 3/4] pinctrl: bcm2835: Switch to use ->add_pin_ranges()
Date:   Fri, 13 Jan 2023 23:53:51 +0200
Message-Id: <20230113215352.44272-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, while the ->add_pin_ranges() shouldn't be used by DT drivers,
this one requires it to support quite old firmware descriptions that
do not have gpio-ranges property.

The change allows to clean up GPIO library from OF specifics.
There is no functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index c7cdccdb4332..8e2551a08c37 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -358,9 +358,9 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
-					   struct device_node *np)
+static int bcm2835_add_pin_ranges_fallback(struct gpio_chip *gc)
 {
+	struct device_node *np = dev_of_node(gc->parent);
 	struct pinctrl_dev *pctldev = of_pinctrl_get(np);
 
 	if (!pctldev)
@@ -386,7 +386,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2835_NUM_GPIOS,
 	.can_sleep = false,
-	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
+	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
 };
 
 static const struct gpio_chip bcm2711_gpio_chip = {
@@ -403,7 +403,7 @@ static const struct gpio_chip bcm2711_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2711_NUM_GPIOS,
 	.can_sleep = false,
-	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
+	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
 };
 
 static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
-- 
2.39.0

