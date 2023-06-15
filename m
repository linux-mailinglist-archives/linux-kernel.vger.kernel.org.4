Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA222731934
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFOMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjFOMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:50:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE77212B;
        Thu, 15 Jun 2023 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686833439; x=1718369439;
  h=from:to:cc:subject:date:message-id;
  bh=MOJCO9RuzR2EgnjwVGgZIJ+GDP91WXDJ30kFlVyK9qI=;
  b=Au1JLVPCtaK+YKbYTMm9nfidqSks1f+C/L1BOWq27Vd67phK3EUQ0+xy
   W3uM4VUPrQf6t+xjT3lGYzFzr3pKRs+umAQyew8Pbim6ISHaNK9IlMrSZ
   yW+s4RvpbDB9RlFb2pB/nxGWo6YluRWuizdszQsvMnCjlge+sdUaMTk6Z
   vb3u4dNUyr7jK199DJrSdRxaNb5S9wX0RMzuqqqWnmSIcTZsQaMG8IUM+
   fkXVWmWYZuysRDmexc4ea0g0Wzh1vCM+6+27yyR5/0UTPBiHLoXjZCR5A
   df6Fhq21Da6ie38jH+F8eYmTjDFBeBRUjb+T66I3nsr45xwQNm9f7ux8K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387372783"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="387372783"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 05:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802325045"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802325045"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 05:50:36 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 659BD1973D;
        Thu, 15 Jun 2023 18:20:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 5EFF1186; Thu, 15 Jun 2023 18:20:35 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Date:   Thu, 15 Jun 2023 18:20:22 +0530
Message-Id: <20230615125022.27421-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine ->irq_set_type() hook and improve its readability by:

- Reducing scope of spinlock by moving unneeded operations out of it.
- Dropping redundant PADCFG0_RXEVCFG_SHIFT and including it directly
  into PADCFG0_RXEVCFG_* definitions.
- Utilizing temporary variables for common operations.
- Simplifying if-else-if chain.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 45 ++++++++++++++-------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index e8adf2580321..036eae74c479 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -55,12 +55,11 @@
 
 /* Offset from pad_regs */
 #define PADCFG0				0x000
-#define PADCFG0_RXEVCFG_SHIFT		25
 #define PADCFG0_RXEVCFG_MASK		GENMASK(26, 25)
-#define PADCFG0_RXEVCFG_LEVEL		0
-#define PADCFG0_RXEVCFG_EDGE		1
-#define PADCFG0_RXEVCFG_DISABLED	2
-#define PADCFG0_RXEVCFG_EDGE_BOTH	3
+#define PADCFG0_RXEVCFG_LEVEL		(0 << 25)
+#define PADCFG0_RXEVCFG_EDGE		(1 << 25)
+#define PADCFG0_RXEVCFG_DISABLED	(2 << 25)
+#define PADCFG0_RXEVCFG_EDGE_BOTH	(3 << 25)
 #define PADCFG0_PREGFRXSEL		BIT(24)
 #define PADCFG0_RXINV			BIT(23)
 #define PADCFG0_GPIROUTIOXAPIC		BIT(20)
@@ -1127,9 +1126,9 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned int pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), NULL, NULL);
+	u32 rxevcfg, rxinv, value;
 	unsigned long flags;
 	void __iomem *reg;
-	u32 value;
 
 	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
 	if (!reg)
@@ -1145,28 +1144,32 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 		return -EPERM;
 	}
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
-
-	intel_gpio_set_gpio_mode(reg);
-
-	value = readl(reg);
-
-	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
-
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
+		rxinv = PADCFG0_RXINV;
+	else
+		rxinv = 0;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+	intel_gpio_set_gpio_mode(reg);
+
+	value = readl(reg);
+
+	value = (value & ~PADCFG0_RXINV) | rxinv;
+	value = (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;
+
 	writel(value, reg);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)

base-commit: e95433c367e681dc6d4613706bd74f483a25acd8
-- 
2.17.1

