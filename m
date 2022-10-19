Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B6604BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiJSPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiJSPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5015A328
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61D9661934
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0433AC433C1;
        Wed, 19 Oct 2022 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193915;
        bh=joYAV9jX5SsD5BU7n7AFcu/9JNz4Iim9bnJVf1UY9WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnabXx6O68DCjGPEdvxcqKmhe65McaKBXGvin6ZExjUWChHcz6bMg+Vhm4K4o1Whf
         0xJjSYaudxuCF+fkS6STGLDDxVOVhsjsE/NzJ8HBG+RZs9cAQ5DPY+uMkBq2co/tzK
         HX1fcwZQrYVZ/eGNlVE9yGtV3gYu7G+fpT917ORfq7atOKaLNpTUdw0NK9JsswgjXL
         Y23PWjSSUcr7leVskx3n3mZdLQZ/wswlgRRBIQh8x4bpzvyfpk52uaPDQaC1ZGAaHu
         CavOvrh61EwXwDgyQ8gPDaezI4Dd3tVzlud2NS+iw3h632823Wf+AxjG/TwOnBxDKg
         UsbvaJ0pY5htA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/14] irqchip: remove davinci aintc driver
Date:   Wed, 19 Oct 2022 17:29:38 +0200
Message-Id: <20221019152947.3857217-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The aintc driver was used on Davinci DM3xx and DM64xx SoCs, all of
which got dropped from Linux, so this driver is orphaned as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/Kconfig             |   5 -
 drivers/irqchip/Makefile            |   1 -
 drivers/irqchip/irq-davinci-aintc.c | 163 ----------------------------
 3 files changed, 169 deletions(-)
 delete mode 100644 drivers/irqchip/irq-davinci-aintc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..c9bb2ccf4044 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -136,11 +136,6 @@ config BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
-config DAVINCI_AINTC
-	bool
-	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
-
 config DAVINCI_CP_INTC
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 87b49a10962c..ffd945fe71aa 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
-obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
diff --git a/drivers/irqchip/irq-davinci-aintc.c b/drivers/irqchip/irq-davinci-aintc.c
deleted file mode 100644
index 123eb7bfc117..000000000000
--- a/drivers/irqchip/irq-davinci-aintc.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-//
-// Copyright (C) 2006, 2019 Texas Instruments.
-//
-// Interrupt handler for DaVinci boards.
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqchip/irq-davinci-aintc.h>
-#include <linux/io.h>
-#include <linux/irqdomain.h>
-
-#include <asm/exception.h>
-
-#define DAVINCI_AINTC_FIQ_REG0		0x00
-#define DAVINCI_AINTC_FIQ_REG1		0x04
-#define DAVINCI_AINTC_IRQ_REG0		0x08
-#define DAVINCI_AINTC_IRQ_REG1		0x0c
-#define DAVINCI_AINTC_IRQ_IRQENTRY	0x14
-#define DAVINCI_AINTC_IRQ_ENT_REG0	0x18
-#define DAVINCI_AINTC_IRQ_ENT_REG1	0x1c
-#define DAVINCI_AINTC_IRQ_INCTL_REG	0x20
-#define DAVINCI_AINTC_IRQ_EABASE_REG	0x24
-#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x30
-#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x4c
-
-static void __iomem *davinci_aintc_base;
-static struct irq_domain *davinci_aintc_irq_domain;
-
-static inline void davinci_aintc_writel(unsigned long value, int offset)
-{
-	writel_relaxed(value, davinci_aintc_base + offset);
-}
-
-static inline unsigned long davinci_aintc_readl(int offset)
-{
-	return readl_relaxed(davinci_aintc_base + offset);
-}
-
-static __init void
-davinci_aintc_setup_gc(void __iomem *base,
-		       unsigned int irq_start, unsigned int num)
-{
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-
-	gc = irq_get_domain_generic_chip(davinci_aintc_irq_domain, irq_start);
-	gc->reg_base = base;
-	gc->irq_base = irq_start;
-
-	ct = gc->chip_types;
-	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
-
-	ct->regs.ack = DAVINCI_AINTC_IRQ_REG0;
-	ct->regs.mask = DAVINCI_AINTC_IRQ_ENT_REG0;
-	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
-			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
-}
-
-static asmlinkage void __exception_irq_entry
-davinci_aintc_handle_irq(struct pt_regs *regs)
-{
-	int irqnr = davinci_aintc_readl(DAVINCI_AINTC_IRQ_IRQENTRY);
-
-	/*
-	 * Use the formula for entry vector index generation from section
-	 * 8.3.3 of the manual.
-	 */
-	irqnr >>= 2;
-	irqnr -= 1;
-
-	generic_handle_domain_irq(davinci_aintc_irq_domain, irqnr);
-}
-
-/* ARM Interrupt Controller Initialization */
-void __init davinci_aintc_init(const struct davinci_aintc_config *config)
-{
-	unsigned int irq_off, reg_off, prio, shift;
-	void __iomem *req;
-	int ret, irq_base;
-	const u8 *prios;
-
-	req = request_mem_region(config->reg.start,
-				 resource_size(&config->reg),
-				 "davinci-cp-intc");
-	if (!req) {
-		pr_err("%s: register range busy\n", __func__);
-		return;
-	}
-
-	davinci_aintc_base = ioremap(config->reg.start,
-				     resource_size(&config->reg));
-	if (!davinci_aintc_base) {
-		pr_err("%s: unable to ioremap register range\n", __func__);
-		return;
-	}
-
-	/* Clear all interrupt requests */
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG1);
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
-
-	/* Disable all interrupts */
-	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_ENT_REG0);
-	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_ENT_REG1);
-
-	/* Interrupts disabled immediately, IRQ entry reflects all */
-	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_INCTL_REG);
-
-	/* we don't use the hardware vector table, just its entry addresses */
-	davinci_aintc_writel(0, DAVINCI_AINTC_IRQ_EABASE_REG);
-
-	/* Clear all interrupt requests */
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG1);
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
-	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
-
-	prios = config->prios;
-	for (reg_off = DAVINCI_AINTC_IRQ_INTPRI0_REG;
-	     reg_off <= DAVINCI_AINTC_IRQ_INTPRI7_REG; reg_off += 4) {
-		for (shift = 0, prio = 0; shift < 32; shift += 4, prios++)
-			prio |= (*prios & 0x07) << shift;
-		davinci_aintc_writel(prio, reg_off);
-	}
-
-	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (irq_base < 0) {
-		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
-		       __func__, irq_base);
-		return;
-	}
-
-	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
-						config->num_irqs, irq_base, 0,
-						&irq_domain_simple_ops, NULL);
-	if (!davinci_aintc_irq_domain) {
-		pr_err("%s: unable to create interrupt domain\n", __func__);
-		return;
-	}
-
-	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
-					     "AINTC", handle_edge_irq,
-					     IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
-	if (ret) {
-		pr_err("%s: unable to allocate generic irq chips for domain\n",
-		       __func__);
-		return;
-	}
-
-	for (irq_off = 0, reg_off = 0;
-	     irq_off < config->num_irqs;
-	     irq_off += 32, reg_off += 0x04)
-		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
-				       irq_base + irq_off, 32);
-
-	set_handle_irq(davinci_aintc_handle_irq);
-}
-- 
2.29.2

