Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04672DD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbjFMIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjFMIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:51:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0CC0;
        Tue, 13 Jun 2023 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686646293; x=1718182293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QsnfKD0vrMxrGMgDPsYUSV+TjEAJfQkDBuxj7dIOTYA=;
  b=dd2Zf4/S7gvLJ3WcHarlrFW9x3M0OnUnrd+ExJNjjtxJZfK1iW/D7fYo
   6wlMBznzWvAR25rGlUHZh0dheVIzUCE0YOdB5OrZGNA/HZ4TSZyCOgMg2
   wzkLmLb7Y/gJk5OT3a5nzfRQWYTnSvGZ+0oD3v9T+ImgNIx7f4S05X1CL
   wVy1/R6QN8lmTNz4WRfktIhQbdqp7Jm9DC1YtE6KQ5RY693gKM6JJA6qq
   VS3wcHqbsMZtRzG4be+F8ZV1Uhomd9ZJAw8O39r+8azKl1hLAFImH6mU2
   7DhBNmvXkPVpYS3q5mn07YqvNyxM2ZQwEB+DnCLGMIsxLFluGiLehQMWW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386664947"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="386664947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824305096"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="824305096"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 01:51:29 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 7123C19742;
        Tue, 13 Jun 2023 14:21:28 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 6C1E01C6; Tue, 13 Jun 2023 14:21:28 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Date:   Tue, 13 Jun 2023 14:20:53 +0530
Message-Id: <20230613085054.10976-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613085054.10976-1-raag.jadav@intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable for common shift operation
in ->irq_set_type() hook and improve readability.
While at it, simplify if-else-if chain and save a few bytes.

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

