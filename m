Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679136DBA34
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDHKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDHKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:48:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B8D332
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:48:08 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1b4tArNpnduSvij7iHX/ZEqCzrHyk8foDaMdaE1D5Gw=;
        b=Oj9WZaV2vBC5K984Evy2qeeqXtIM7XBj1r9lNMtKD628/+ygyCm4wKYCMKbNIFXzY2lx98
        Xi0agtHmRqmDmbeFUehYBBCF6V+QGsx16yqC33GJFJRNNvv9H5eGtlJ32evu+qlXM5VdHX
        YkpZ+UIjV4NTuPbjuVfZ1fgp3hztC5u5Qj5EAKt1ZYBMiM1ghIo7rdenpuzoXpiJPZWK6D
        TYi6mV8jycqXSa70HDX+WPjZ8kyHMjXGbabo/01rXblXnYzyejTAVll7Dm0zlSYzt1A5yH
        QGgtMOlj5AjeF1DDQ5KcK51fWS+PYU5gStBIjobLMFuHBs3CA0yRYQFs8t3AMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1b4tArNpnduSvij7iHX/ZEqCzrHyk8foDaMdaE1D5Gw=;
        b=G5Bg2XSHmFS0qhup46QOmSLrRYhZwGEFGZBSBG09//bp1eZxsfFHn4whTMPGgv1z0WB3DI
        69BTlEMGxMeK4FDg==
From:   "irqchip-bot for Mason Huo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-sifive-plic: Add syscore
 callbacks for hibernation
Cc:     Mason Huo <mason.huo@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Dan Carpenter <error27@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230404032908.89638-1-mason.huo@starfivetech.com>
References: <20230404032908.89638-1-mason.huo@starfivetech.com>
MIME-Version: 1.0
Message-ID: <168095071981.404.6341575327386569051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e80f0b6a2cf302b56b7d6d7ad3797aebc97fccb9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e80f0b6a2cf302b56b7d6d7ad3797aebc97fccb9
Author:        Mason Huo <mason.huo@starfivetech.com>
AuthorDate:    Tue, 04 Apr 2023 11:29:08 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 11:19:47 +01:00

irqchip/irq-sifive-plic: Add syscore callbacks for hibernation

The priority and enable registers of plic will be reset
during hibernation power cycle in poweroff mode,
add the syscore callbacks to save/restore those registers.

Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302140709.CdkxgtPi-lkp@intel.com/
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230404032908.89638-1-mason.huo@starfivetech.com
---
 drivers/irqchip/irq-sifive-plic.c | 93 +++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index ff47bd0..e148490 100644
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
+	unsigned long *prio_save;
 };
 
 struct plic_handler {
@@ -78,6 +81,7 @@ struct plic_handler {
 	 */
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
+	u32			*enable_save;
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
@@ -229,6 +233,71 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 	return IRQ_SET_MASK_OK;
 }
 
+static int plic_irq_suspend(void)
+{
+	unsigned int i, cpu;
+	u32 __iomem *reg;
+	struct plic_priv *priv;
+
+	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
+
+	for (i = 0; i < priv->nr_irqs; i++)
+		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
+			__set_bit(i, priv->prio_save);
+		else
+			__clear_bit(i, priv->prio_save);
+
+	for_each_cpu(cpu, cpu_present_mask) {
+		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		raw_spin_lock(&handler->enable_lock);
+		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
+			reg = handler->enable_base + i * sizeof(u32);
+			handler->enable_save[i] = readl(reg);
+		}
+		raw_spin_unlock(&handler->enable_lock);
+	}
+
+	return 0;
+}
+
+static void plic_irq_resume(void)
+{
+	unsigned int i, index, cpu;
+	u32 __iomem *reg;
+	struct plic_priv *priv;
+
+	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
+
+	for (i = 0; i < priv->nr_irqs; i++) {
+		index = BIT_WORD(i);
+		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
+		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
+	}
+
+	for_each_cpu(cpu, cpu_present_mask) {
+		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		raw_spin_lock(&handler->enable_lock);
+		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
+			reg = handler->enable_base + i * sizeof(u32);
+			writel(handler->enable_save[i], reg);
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
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -345,6 +414,7 @@ static int __init __plic_init(struct device_node *node,
 	u32 nr_irqs;
 	struct plic_priv *priv;
 	struct plic_handler *handler;
+	unsigned int cpu;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -363,15 +433,21 @@ static int __init __plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
+	priv->nr_irqs = nr_irqs;
+
+	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
+	if (!priv->prio_save)
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
@@ -441,6 +517,11 @@ static int __init __plic_init(struct device_node *node,
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
+
+		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+						sizeof(*handler->enable_save), GFP_KERNEL);
+		if (!handler->enable_save)
+			goto out_free_enable_reg;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -461,11 +542,19 @@ done:
 				  plic_starting_cpu, plic_dying_cpu);
 		plic_cpuhp_setup_done = true;
 	}
+	register_syscore_ops(&plic_irq_syscore_ops);
 
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
+out_free_enable_reg:
+	for_each_cpu(cpu, cpu_present_mask) {
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		kfree(handler->enable_save);
+	}
+out_free_priority_reg:
+	kfree(priv->prio_save);
 out_iounmap:
 	iounmap(priv->regs);
 out_free_priv:
