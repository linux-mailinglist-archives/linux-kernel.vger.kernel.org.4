Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F02729316
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbjFII11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbjFII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:26:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8930EC;
        Fri,  9 Jun 2023 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299163; x=1717835163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qAYVBXdl5GPI2VnNJdr1EfODyAMusq9BtjJGbz/NqZE=;
  b=WEpz45GWGJvKb/5Qw+eTQipmYMCeK8Cvxsr/1ccAwwsmA+HzTbC/PBVd
   wJphektzHAdhHtbXdleEWsQze2yswAEP3dhiIzEPOtXTLNkJ2WPZf2zds
   o4q2EOHw4PKLwvY/7s3QesQu4UdZh7x3vpRFRp2nZ8cOTsiM9oTRO7fYT
   H7R1s/kixWUQr239d/hi9GGB6ZucNcAkZ7JnSdpJFMDfqOYFUgtC+Xfwp
   1EXkiGxF3ROE6WPCL8l996zRFy1mdnaXuBxWnRYcIzMOd0opbO7NtpCA7
   XGCBpvPhVfcGULINXVk5jKE5Kza+9wcA8gAY/UDT3FMtkGTJOTDD+Z+NA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342222298"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342222298"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713424278"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713424278"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:25:59 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 09A2918636;
        Fri,  9 Jun 2023 13:55:59 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 016C1B6; Fri,  9 Jun 2023 13:55:58 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/4] pinctrl: intel: refine irq_set_type hook
Date:   Fri,  9 Jun 2023 13:55:37 +0530
Message-Id: <20230609082539.24311-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230609082539.24311-1-raag.jadav@intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable for common shift operation
inside ->irq_set_type() hook and improve readability.
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

