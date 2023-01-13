Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3F669F60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAMROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjAMRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:13:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501048B51C;
        Fri, 13 Jan 2023 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673629923; x=1705165923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4czDnVSkFSUSOJn9OForI+BzEj1U5wZMtWZ0AIG6g9Q=;
  b=HYVoq4AqX0YHOGHgr5y+jAi7BMgkNFiGwLzJxGY2r312mBVyUH6qAXDR
   LgGW8zo3kl3tnUQEIEbQ92tJ66AbAZM6N/UO8nIcKPe/VAUD8URZGAMUI
   vDqifRE5m/yXNPeGGJfR8lPMxxa63Ds5hzE/Pb4SPYp2uVel4hUCEhVE2
   DldV3YA0Wx3yel9OE4obfzMoFd+u8X3W4O3T4YvEunZSZ22hsYxC1dxeJ
   X65GQFz11Vfk1nxIIMBjEBMKg/BJq49TYRp3fanHz/YbK+p9r94E6mRQX
   QUVKWvkpKN8dJEJEDbV4sYpBoz3AwOrdZOszxTOxe32ow+ywzD5bPCSTB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322742816"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322742816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608221583"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608221583"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 09:10:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C93AE1; Fri, 13 Jan 2023 19:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] pinctrl: bcm: bcm2835: Switch to use ->add_pin_ranges()
Date:   Fri, 13 Jan 2023 19:10:50 +0200
Message-Id: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
v2: fixed compilation issues (LKP), Cc'ed to the author of original code

Btw, the commit d2b67744fd99 ("pinctrl: bcm2835: implement hook for
missing gpio-ranges") seems problematic in the fist place due to
odd of_node_put() call. I dunno how that part had been tested, or
how it's supposed to work, i.e. where is the counterpart of_node_get().
Anyway this change drops it for good.

Perhaps we can check gpio-ranges property presence inside the GPIO
library, so this ->add_pin_ranges() won't be called at all.

Also I would like to understand the dance around checking for pin
control device. The original commit lacks of comments in the non-trivial
code.

 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 7857e612a100..29f278c49103 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -358,16 +358,17 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
-					   struct device_node *np)
+static int bcm2835_add_pin_ranges_fallback(struct gpio_chip *gc)
 {
+	struct device_node *np = dev_of_node(gc->parent);
 	struct pinctrl_dev *pctldev = of_pinctrl_get(np);
 
-	of_node_put(np);
-
 	if (!pctldev)
 		return 0;
 
+	if (of_property_read_bool(np, "gpio-ranges"))
+		return 0;
+
 	gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
 			       gc->ngpio);
 
@@ -388,7 +389,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2835_NUM_GPIOS,
 	.can_sleep = false,
-	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
+	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
 };
 
 static const struct gpio_chip bcm2711_gpio_chip = {
@@ -405,7 +406,7 @@ static const struct gpio_chip bcm2711_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2711_NUM_GPIOS,
 	.can_sleep = false,
-	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
+	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
 };
 
 static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
-- 
2.39.0

