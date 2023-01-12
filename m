Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B6667BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjALQtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjALQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:44:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69E58834;
        Thu, 12 Jan 2023 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541505; x=1705077505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=68OPSiZVY1KVbajcXwUGWj+MRV19nF/DUDmqYU0Aj6I=;
  b=Zll/R+8E+ITOdeBMGhDfdNMkYX22wjgLCWKYmyt+hOgbYklUU5dSO4VL
   Kri2Y374BRL6l5iLHu+a1VZzoNILj6nRX6hX2W9nyNGmdn38cRh19ecJg
   AdU79KTaHgw8XRGAFSixlsWHgjLYvhnOhLtODTxjytBjz+KJvKSVfHlk6
   YwMNG2ah77SRUOoexV3X6X3xbcL5eTBkj2GIR+uQytYuNYx3778Z09c/r
   hZgSQCI3NKm6B2aLuOGsKyoOVjmJM44bkrJS8TU6AftDExKwy7Q0Z2XOz
   Qge3XjP3eV/JPMdQB8Ql2xF800AKfK1ea6020fDC2Dq2TD/iEphwsZhyK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304132438"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304132438"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690193082"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="690193082"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Jan 2023 08:37:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3D71E1; Thu, 12 Jan 2023 18:38:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] pinctrl: bcm: bcm2835: Switch to use ->add_pin_ranges()
Date:   Thu, 12 Jan 2023 18:38:24 +0200
Message-Id: <20230112163825.72983-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 7857e612a100..fea1d1bcb389 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -358,16 +358,18 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
-					   struct device_node *np)
+static int bcm2835_add_pin_ranges_fallback(struct gpio_chip *gc)
 {
+	struct bcm2835_pinctrl *pc = gpiochip_get_data(gc);
+	struct device_node *np = dev_of_node(&gc->gpiodev->dev);
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
 
@@ -388,7 +390,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2835_NUM_GPIOS,
 	.can_sleep = false,
-	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
+	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
 };
 
 static const struct gpio_chip bcm2711_gpio_chip = {
@@ -405,7 +407,7 @@ static const struct gpio_chip bcm2711_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2711_NUM_GPIOS,
 	.can_sleep = false,
-	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
+	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
 };
 
 static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
-- 
2.39.0

