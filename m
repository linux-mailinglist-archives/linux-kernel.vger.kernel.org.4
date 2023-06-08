Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E08727809
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjFHHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjFHHBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:01:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4C2D70;
        Thu,  8 Jun 2023 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686207684; x=1717743684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GyImhG9c1FMHW0obFlLkeCzK7gcrJ3l5Zu4ckVFH3As=;
  b=emH37cJ2XPKiGEF/IGk9gtZRNoNa/5irDLAdeAhJAURFQUNHhqANoKdq
   4SOq6cnKZbjfYMPvrBE7VQSKeLEQCp380eWzd+9m9FDYPEYF2mkCAbrpE
   r0R161eChu0PctMcMGTEqABrSzLUzKdzcF3vujY22LxoK0vPRm7s2xrxN
   rAMSCn+4A4ayoN7SxxOTYg3v2KxYWZNswROHnCGLUMaRcI3Uwh0UR/7QO
   4tqPLISk+S0NbYu1D9KoZRWfyu1cF/mb/oH/kS+whui3c+wpQXIUYhmuH
   6qJ8YsTbDy/p2Rz0zpgoySV8fbdv/fgE4cpW77k6i9gXjGA+eoCeuhZBP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359696350"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="359696350"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709867971"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709867971"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 00:01:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 125001AA15;
        Thu,  8 Jun 2023 12:31:07 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 0CDC51E1; Thu,  8 Jun 2023 12:31:07 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/4] pinctrl: intel: optimize irq_set_type hook
Date:   Thu,  8 Jun 2023 12:30:15 +0530
Message-Id: <20230608070017.28072-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608070017.28072-1-raag.jadav@intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable for common shift operation
inside ->irq_set_type() hook and save a few bytes.
While at it, simplify if-else-if chain.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-16 (-16)
Function                                     old     new   delta
intel_gpio_irq_type                          317     301     -16
Total: Before=10469, After=10453, chg -0.15%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index e8adf2580321..3f78066b1837 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1128,8 +1128,8 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned int pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), NULL, NULL);
 	unsigned long flags;
+	u32 value, rxevcfg;
 	void __iomem *reg;
-	u32 value;
 
 	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
 	if (!reg)
@@ -1150,23 +1150,24 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	intel_gpio_set_gpio_mode(reg);
 
 	value = readl(reg);
-
 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
 
 	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
-		value |= PADCFG0_RXEVCFG_EDGE_BOTH << PADCFG0_RXEVCFG_SHIFT;
+		rxevcfg = PADCFG0_RXEVCFG_EDGE_BOTH;
 	} else if (type & IRQ_TYPE_EDGE_FALLING) {
-		value |= PADCFG0_RXEVCFG_EDGE << PADCFG0_RXEVCFG_SHIFT;
-		value |= PADCFG0_RXINV;
+		rxevcfg = PADCFG0_RXEVCFG_EDGE;
 	} else if (type & IRQ_TYPE_EDGE_RISING) {
-		value |= PADCFG0_RXEVCFG_EDGE << PADCFG0_RXEVCFG_SHIFT;
+		rxevcfg = PADCFG0_RXEVCFG_EDGE;
 	} else if (type & IRQ_TYPE_LEVEL_MASK) {
-		if (type & IRQ_TYPE_LEVEL_LOW)
-			value |= PADCFG0_RXINV;
+		rxevcfg = PADCFG0_RXEVCFG_LEVEL;
 	} else {
-		value |= PADCFG0_RXEVCFG_DISABLED << PADCFG0_RXEVCFG_SHIFT;
+		rxevcfg = PADCFG0_RXEVCFG_DISABLED;
 	}
 
+	if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW)
+		value |= PADCFG0_RXINV;
+
+	value |= rxevcfg << PADCFG0_RXEVCFG_SHIFT;
 	writel(value, reg);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
-- 
2.17.1

