Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A95F9EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJJMwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJJMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:52:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D252E53;
        Mon, 10 Oct 2022 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665406328; x=1696942328;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=3zHevgQOY48FMYBp2kdOdzu7Asoft6NnnDPXhDghaMo=;
  b=AU/RM2n0xP80UGd0O53/q+rPzSk8hBWU4iLnLhzDMXACwnfUyyKz+Zcz
   mvOuW6WERssPEJeXwnEzqunNGMSQLml8ddl9xainzKKmc9kZl9UfjnS8W
   beZ8VgLXiq7tjDKjSPxHFWMkVtfC5HMMAt/tvrQ4EMRq3uvbmylV3HAOh
   MS6Sxgk4oCjeYGSQvkhc6QG14+ZrLGWJORz0L9HlEHbV5HPGyLFCjK4BD
   vk5nShlVEB0OZDU3n3Zf/XQxymzJnMtN/6mzg7RfOoy+0N9kG4fo/ttIL
   HHLa1rXtzlucTaUNBYgnoTWK6qhY/e/MDbJHyXrPjSPydciQ4ASNAV9zp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366181071"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366181071"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628266212"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628266212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2022 05:52:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97D1430B; Mon, 10 Oct 2022 15:52:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] pinctrl: cy8c95x0: Implement ->gpio_request_enable() and ->gpio_set_direction()
Date:   Mon, 10 Oct 2022 15:52:21 +0300
Message-Id: <20221010125221.28275-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010125221.28275-1-andriy.shevchenko@linux.intel.com>
References: <20221010125221.28275-1-andriy.shevchenko@linux.intel.com>
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

Without ->gpio_request_enable() and ->gpio_set_direction()
callbacks it's not possible to mux GPIO via standard GPIO
interfaces (like `gpioget` or `gpioset` tools in user space).

Implement those functions to fill the above mentioned gap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 112 +++++++++++++++++------------
 1 file changed, 68 insertions(+), 44 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 33eba7ad87f4..b44b36be54b3 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -21,9 +21,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
 /* Fast access registers */
@@ -551,36 +552,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 
 static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
 {
-	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
-	u8 port = cypress_get_port(chip, off);
-	u8 bit = cypress_get_pin_mask(chip, off);
-	int ret;
-
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret)
-		goto out;
-
-	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, bit);
-	if (ret)
-		goto out;
-
-	if (test_bit(off, chip->push_pull)) {
-		/*
-		 * Disable driving the pin by forcing it to HighZ. Only setting the
-		 * direction register isn't sufficient in Push-Pull mode.
-		 */
-		ret = regmap_write_bits(chip->regmap, CY8C95X0_DRV_HIZ, bit, bit);
-		if (ret)
-			goto out;
-
-		__clear_bit(off, chip->push_pull);
-	}
-
-out:
-	mutex_unlock(&chip->i2c_lock);
-
-	return ret;
+	return pinctrl_gpio_direction_input(gc->base + off);
 }
 
 static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
@@ -597,19 +569,7 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 	if (ret)
 		return ret;
 
-	mutex_lock(&chip->i2c_lock);
-	/* Select port... */
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret)
-		goto out;
-
-	/* ...then direction */
-	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, 0);
-
-out:
-	mutex_unlock(&chip->i2c_lock);
-
-	return ret;
+	return pinctrl_gpio_direction_output(gc->base + off);
 }
 
 static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int off)
@@ -850,6 +810,8 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 {
 	struct gpio_chip *gc = &chip->gpio_chip;
 
+	gc->request = gpiochip_generic_request;
+	gc->free = gpiochip_generic_free;
 	gc->direction_input  = cy8c95x0_gpio_direction_input;
 	gc->direction_output = cy8c95x0_gpio_direction_output;
 	gc->get = cy8c95x0_gpio_get_value;
@@ -1173,11 +1135,73 @@ static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 	return ret;
 }
 
+static int cy8c95x0_gpio_request_enable(struct pinctrl_dev *pctldev,
+					struct pinctrl_gpio_range *range,
+					unsigned int pin)
+{
+	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
+	int ret;
+
+	mutex_lock(&chip->i2c_lock);
+	ret = cy8c95x0_set_mode(chip, pin, false);
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
+}
+
+static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
+				     unsigned int pin, bool input)
+{
+	u8 port = cypress_get_port(chip, pin);
+	u8 bit = cypress_get_pin_mask(chip, pin);
+	int ret;
+
+	/* Select port... */
+	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
+	if (ret)
+		return ret;
+
+	/* ...then direction */
+	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, input ? bit : 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable driving the pin by forcing it to HighZ. Only setting
+	 * the direction register isn't sufficient in Push-Pull mode.
+	 */
+	if (input && test_bit(pin, chip->push_pull)) {
+		ret = regmap_write_bits(chip->regmap, CY8C95X0_DRV_HIZ, bit, bit);
+		if (ret)
+			return ret;
+
+		__clear_bit(pin, chip->push_pull);
+	}
+
+	return 0;
+}
+
+static int cy8c95x0_gpio_set_direction(struct pinctrl_dev *pctldev,
+				       struct pinctrl_gpio_range *range,
+				       unsigned int pin, bool input)
+{
+	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
+	int ret;
+
+	mutex_lock(&chip->i2c_lock);
+	ret = cy8c95x0_pinmux_direction(chip, pin, input);
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
+}
+
 static const struct pinmux_ops cy8c95x0_pmxops = {
 	.get_functions_count = cy8c95x0_get_functions_count,
 	.get_function_name = cy8c95x0_get_function_name,
 	.get_function_groups = cy8c95x0_get_function_groups,
 	.set_mux = cy8c95x0_set_mux,
+	.gpio_request_enable = cy8c95x0_gpio_request_enable,
+	.gpio_set_direction = cy8c95x0_gpio_set_direction,
 	.strict = true,
 };
 
-- 
2.35.1

