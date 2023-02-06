Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF368BFD9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBFORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjBFORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:17:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CEF227A6;
        Mon,  6 Feb 2023 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675693011; x=1707229011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rkMn+pXxQ+KKju55X4C3pa/suoqSDKrEPHgqwNgVWTQ=;
  b=K45G6x52p2EYve27n4pDIMWBT7ftGSQs11yEjSskVewIqB5mFxMJ08lU
   FGKLhMtu8WwQbzAxOuS1tEjV3XE8UbQVUympUWxn1rCGuYidIvgBrqX+B
   pDSESxErYZqLSEELsdw88Z1c3z67RvkEzCCQlsjLOGzJjhgryZRQnZx5z
   /sqyOhmQA3toGw51INWAL7O0fL3ODLEqjrEoJuQeV5amxTVkrCDm/PmjQ
   VlJPrYY9afXAJX/E6ZZXhfRTjhVsu9swbZhKzEnkh0y4X3ha4HWVPpjVj
   xI8gJuGRuL455PlHa66UzRswEJR5yMpHglCftiCHZtPwtfIM3OxbBl5Ao
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="415431790"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="415431790"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 06:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="666500603"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666500603"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 06:16:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 427F3241; Mon,  6 Feb 2023 16:17:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jim Minter <jimminter@microsoft.com>
Subject: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be in Direct IRQ mode
Date:   Mon,  6 Feb 2023 16:15:59 +0200
Message-Id: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

If the firmware mangled the register contents too much,
check the saved value for the Direct IRQ mode. If it
matches, we will restore the pin state.

Reported-by: Jim Minter <jimminter@microsoft.com>
Fixes: 6989ea4881c8 ("pinctrl: intel: Save and restore pins in "direct IRQ" mode")
Tested-by: Jim Minter <jimminter@microsoft.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Jim, this is a bit simplified version than what you tested. But it shouldn't
be a functional changes. Anyway, it would be nice if you have a chance to give
this a try.

Linus, I don't expect more to come for this cycle, feel free to apply directly.

 drivers/pinctrl/intel/pinctrl-intel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index cc3aaba24188..e49f271de936 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1709,6 +1709,12 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 EXPORT_SYMBOL_GPL(intel_pinctrl_get_soc_data);
 
 #ifdef CONFIG_PM_SLEEP
+static bool __intel_gpio_is_direct_irq(u32 value)
+{
+	return (value & PADCFG0_GPIROUTIOXAPIC) && (value & PADCFG0_GPIOTXDIS) &&
+	       (__intel_gpio_get_gpio_mode(value) == PADCFG0_PMODE_GPIO);
+}
+
 static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl, unsigned int pin)
 {
 	const struct pin_desc *pd = pin_desc_get(pctrl->pctldev, pin);
@@ -1742,8 +1748,7 @@ static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl, unsigned int
 	 * See https://bugzilla.kernel.org/show_bug.cgi?id=214749.
 	 */
 	value = readl(intel_get_padcfg(pctrl, pin, PADCFG0));
-	if ((value & PADCFG0_GPIROUTIOXAPIC) && (value & PADCFG0_GPIOTXDIS) &&
-	    (__intel_gpio_get_gpio_mode(value) == PADCFG0_PMODE_GPIO))
+	if (__intel_gpio_is_direct_irq(value))
 		return true;
 
 	return false;
@@ -1873,7 +1878,12 @@ int intel_pinctrl_resume_noirq(struct device *dev)
 	for (i = 0; i < pctrl->soc->npins; i++) {
 		const struct pinctrl_pin_desc *desc = &pctrl->soc->pins[i];
 
-		if (!intel_pinctrl_should_save(pctrl, desc->number))
+		if (!(intel_pinctrl_should_save(pctrl, desc->number) ||
+		      /*
+		       * If the firmware mangled the register contents too much,
+		       * check the saved value for the Direct IRQ mode.
+		       */
+		      __intel_gpio_is_direct_irq(pads[i].padcfg0)))
 			continue;
 
 		intel_restore_padcfg(pctrl, desc->number, PADCFG0, pads[i].padcfg0);
-- 
2.39.1

