Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B525C68FE12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBIDnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 22:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjBIDnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:43:35 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B61EFD0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:43:33 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E8A7024E3F2;
        Thu,  9 Feb 2023 11:43:24 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Feb
 2023 11:43:25 +0800
Received: from ubuntu.localdomain (183.27.96.33) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Feb
 2023 11:43:24 +0800
From:   Mason Huo <mason.huo@starfivetech.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Mason Huo" <mason.huo@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH v2] irqchip/irq-sifive-plic: Add syscore callbacks for hibernation
Date:   Thu, 9 Feb 2023 11:43:22 +0800
Message-ID: <20230209034322.69943-1-mason.huo@starfivetech.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.33]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priority and enable registers of plic will be reset
during hibernation power cycle in poweroff mode,
add the syscore callbacks to save/restore those registers.

Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index ff47bd0dec45..4683e49d90ad 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -17,6 +17,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 #include <asm/smp.h>
 
 /*
@@ -67,6 +68,8 @@ struct plic_priv {
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
 	unsigned long plic_quirks;
+	unsigned int nr_irqs;
+	unsigned long *priority_reg;
 };
 
 struct plic_handler {
@@ -78,11 +81,13 @@ struct plic_handler {
 	 */
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
+	u32			*enable_reg;
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
+static struct plic_priv *priv_data;
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
 
@@ -229,6 +234,68 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 	return IRQ_SET_MASK_OK;
 }
 
+static int plic_irq_suspend(void)
+{
+	unsigned int i, cpu;
+	u32 __iomem *reg;
+
+	for (i = 0; i < priv_data->nr_irqs; i++)
+		if (readl(priv_data->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
+			__set_bit(i, priv_data->priority_reg);
+		else
+			__clear_bit(i, priv_data->priority_reg);
+
+	for_each_cpu(cpu, cpu_present_mask) {
+		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		raw_spin_lock(&handler->enable_lock);
+		for (i = 0; i < DIV_ROUND_UP(priv_data->nr_irqs, 32); i++) {
+			reg = handler->enable_base + i * sizeof(u32);
+			handler->enable_reg[i] = readl(reg);
+		}
+		raw_spin_unlock(&handler->enable_lock);
+	}
+
+	return 0;
+}
+
+static void plic_irq_resume(void)
+{
+	unsigned int i, cpu;
+	u32 __iomem *reg;
+
+	for (i = 0; i < priv_data->nr_irqs; i++)
+		writel(test_bit(i, priv_data->priority_reg),
+				priv_data->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
+
+	for_each_cpu(cpu, cpu_present_mask) {
+		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		raw_spin_lock(&handler->enable_lock);
+		for (i = 0; i < DIV_ROUND_UP(priv_data->nr_irqs, 32); i++) {
+			reg = handler->enable_base + i * sizeof(u32);
+			writel(handler->enable_reg[i], reg);
+		}
+		raw_spin_unlock(&handler->enable_lock);
+	}
+}
+
+static struct syscore_ops plic_irq_syscore_ops = {
+	.suspend	= plic_irq_suspend,
+	.resume		= plic_irq_resume,
+};
+
+static void plic_irq_pm_init(void)
+{
+	register_syscore_ops(&plic_irq_syscore_ops);
+}
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -345,12 +412,14 @@ static int __init __plic_init(struct device_node *node,
 	u32 nr_irqs;
 	struct plic_priv *priv;
 	struct plic_handler *handler;
+	unsigned int cpu;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->plic_quirks = plic_quirks;
+	priv_data = priv;
 
 	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
@@ -363,15 +432,23 @@ static int __init __plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
+	priv->nr_irqs = nr_irqs;
+
+	priv->priority_reg = kcalloc(DIV_ROUND_UP(nr_irqs,
+		sizeof(unsigned long) * 8),
+		sizeof(unsigned long), GFP_KERNEL);
+	if (!priv->priority_reg)
+		goto out_free_priority_reg;
+
 	nr_contexts = of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
-		goto out_iounmap;
+		goto out_free_priority_reg;
 
 	error = -ENOMEM;
 	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
 			&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
-		goto out_iounmap;
+		goto out_free_priority_reg;
 
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
@@ -441,6 +518,11 @@ static int __init __plic_init(struct device_node *node,
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
+
+		handler->enable_reg =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+			32, GFP_KERNEL);
+		if (!handler->enable_reg)
+			goto out_free_enable_reg;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -461,11 +543,19 @@ static int __init __plic_init(struct device_node *node,
 				  plic_starting_cpu, plic_dying_cpu);
 		plic_cpuhp_setup_done = true;
 	}
+	plic_irq_pm_init();
 
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
+out_free_enable_reg:
+	for_each_cpu(cpu, cpu_present_mask) {
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		kfree(handler->enable_reg);
+	}
+out_free_priority_reg:
+	kfree(priv->priority_reg);
 out_iounmap:
 	iounmap(priv->regs);
 out_free_priv:
-- 
2.39.0

