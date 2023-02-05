Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4968AF8C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBELaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBELaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:30:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A465B1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:58 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqpnL/aOlXK8Sq7p0d/QNBEV+TTbDlmRM2nfv5WeT80=;
        b=MuJIwxLAh4p8QXMc9tsgvAaW1PYiHZp7VYsUZzKJGIxngRyp2SoPUMZlAf91H4bW+Mc++e
        +I4k3eVlkrqVj0X+4hijzrpOeznusQa2HrvZSueT6WVcxiAMioBDbfTZZr9W34KWb9MPPp
        WbjGoDTiE7SnEBwm2a9dEIISSDUZswg3VWJjK7wndkp976+j7CUMIKI3QyLLJw0239o7pK
        YjtIl25idQidcDUUuGknn33d5Cw7MElQYxgTvF3ayUMVuvrEQmRNWfEvlaSbZlJnjN/xln
        1t9SxZdAk/BotmGn2JJFAsozJvUduiiHpcXkvPLuH2jZi7h9b76dU7CWDGqD7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqpnL/aOlXK8Sq7p0d/QNBEV+TTbDlmRM2nfv5WeT80=;
        b=kn2/TIkurk0DS1UiEm1my243NobN9evGQ/P9xePyokybtm3RZducJeMX/R4trN8yY6joqA
        Nts/BA5/Db4n/PCA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Move over to core ipi-mux
Cc:     Marc Zyngier <maz@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Hector Martin <marcan@marcan.st>, tglx@linutronix.de
In-Reply-To: <20230103141221.772261-10-apatel@ventanamicro.com>
References: <20230103141221.772261-10-apatel@ventanamicro.com>
MIME-Version: 1.0
Message-ID: <167559659394.4906.2628096463274673932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c19f897194288ec286bb52001b9ee9551876a614
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c19f897194288ec286bb52001b9ee9551876a614
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 03 Jan 2023 19:42:21 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 10:58:18 

irqchip/apple-aic: Move over to core ipi-mux

Now that the complexity of the AIC IPI mux has been copied into
the core code for the benefit of the riscv architecture,
shrink the AIC driver by the same amount by using that infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Acked-by: Hector Martin <marcan@marcan.st>
Link: https://lore.kernel.org/r/20230103141221.772261-10-apatel@ventanamicro.com
---
 drivers/irqchip/Kconfig         |   1 +-
 drivers/irqchip/irq-apple-aic.c | 161 +------------------------------
 2 files changed, 9 insertions(+), 153 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c..cbf5047 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -658,6 +658,7 @@ config APPLE_AIC
 	bool "Apple Interrupt Controller (AIC)"
 	depends on ARM64
 	depends on ARCH_APPLE || COMPILE_TEST
+	select GENERIC_IRQ_IPI_MUX
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index ae3437f..eabb3b9 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -292,7 +292,6 @@ struct aic_irq_chip {
 	void __iomem *base;
 	void __iomem *event;
 	struct irq_domain *hw_domain;
-	struct irq_domain *ipi_domain;
 	struct {
 		cpumask_t aff;
 	} *fiq_aff[AIC_NR_FIQ];
@@ -307,9 +306,6 @@ struct aic_irq_chip {
 
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
 
-static DEFINE_PER_CPU(atomic_t, aic_vipi_flag);
-static DEFINE_PER_CPU(atomic_t, aic_vipi_enable);
-
 static struct aic_irq_chip *aic_irqc;
 
 static void aic_handle_ipi(struct pt_regs *regs);
@@ -751,98 +747,8 @@ static void aic_ipi_send_fast(int cpu)
 	isb();
 }
 
-static void aic_ipi_mask(struct irq_data *d)
-{
-	u32 irq_bit = BIT(irqd_to_hwirq(d));
-
-	/* No specific ordering requirements needed here. */
-	atomic_andnot(irq_bit, this_cpu_ptr(&aic_vipi_enable));
-}
-
-static void aic_ipi_unmask(struct irq_data *d)
-{
-	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
-	u32 irq_bit = BIT(irqd_to_hwirq(d));
-
-	atomic_or(irq_bit, this_cpu_ptr(&aic_vipi_enable));
-
-	/*
-	 * The atomic_or() above must complete before the atomic_read()
-	 * below to avoid racing aic_ipi_send_mask().
-	 */
-	smp_mb__after_atomic();
-
-	/*
-	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
-	 * No barriers needed here since this is a self-IPI.
-	 */
-	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
-		if (static_branch_likely(&use_fast_ipi))
-			aic_ipi_send_fast(smp_processor_id());
-		else
-			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
-	}
-}
-
-static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
-{
-	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
-	u32 irq_bit = BIT(irqd_to_hwirq(d));
-	u32 send = 0;
-	int cpu;
-	unsigned long pending;
-
-	for_each_cpu(cpu, mask) {
-		/*
-		 * This sequence is the mirror of the one in aic_ipi_unmask();
-		 * see the comment there. Additionally, release semantics
-		 * ensure that the vIPI flag set is ordered after any shared
-		 * memory accesses that precede it. This therefore also pairs
-		 * with the atomic_fetch_andnot in aic_handle_ipi().
-		 */
-		pending = atomic_fetch_or_release(irq_bit, per_cpu_ptr(&aic_vipi_flag, cpu));
-
-		/*
-		 * The atomic_fetch_or_release() above must complete before the
-		 * atomic_read() below to avoid racing aic_ipi_unmask().
-		 */
-		smp_mb__after_atomic();
-
-		if (!(pending & irq_bit) &&
-		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
-			if (static_branch_likely(&use_fast_ipi))
-				aic_ipi_send_fast(cpu);
-			else
-				send |= AIC_IPI_SEND_CPU(cpu);
-		}
-	}
-
-	/*
-	 * The flag writes must complete before the physical IPI is issued
-	 * to another CPU. This is implied by the control dependency on
-	 * the result of atomic_read_acquire() above, which is itself
-	 * already ordered after the vIPI flag write.
-	 */
-	if (send)
-		aic_ic_write(ic, AIC_IPI_SEND, send);
-}
-
-static struct irq_chip ipi_chip = {
-	.name = "AIC-IPI",
-	.irq_mask = aic_ipi_mask,
-	.irq_unmask = aic_ipi_unmask,
-	.ipi_send_mask = aic_ipi_send_mask,
-};
-
-/*
- * IPI IRQ domain
- */
-
 static void aic_handle_ipi(struct pt_regs *regs)
 {
-	int i;
-	unsigned long enabled, firing;
-
 	/*
 	 * Ack the IPI. We need to order this after the AIC event read, but
 	 * that is enforced by normal MMIO ordering guarantees.
@@ -857,27 +763,7 @@ static void aic_handle_ipi(struct pt_regs *regs)
 		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
 	}
 
-	/*
-	 * The mask read does not need to be ordered. Only we can change
-	 * our own mask anyway, so no races are possible here, as long as
-	 * we are properly in the interrupt handler (which is covered by
-	 * the barrier that is part of the top-level AIC handler's readl()).
-	 */
-	enabled = atomic_read(this_cpu_ptr(&aic_vipi_enable));
-
-	/*
-	 * Clear the IPIs we are about to handle. This pairs with the
-	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
-	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
-	 * before IPI handling code (to avoid races handling vIPIs before they
-	 * are signaled). The former is taken care of by the release semantics
-	 * of the write portion, while the latter is taken care of by the
-	 * acquire semantics of the read portion.
-	 */
-	firing = atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & enabled;
-
-	for_each_set_bit(i, &firing, AIC_NR_SWIPI)
-		generic_handle_domain_irq(aic_irqc->ipi_domain, i);
+	ipi_mux_process();
 
 	/*
 	 * No ordering needed here; at worst this just changes the timing of
@@ -887,55 +773,24 @@ static void aic_handle_ipi(struct pt_regs *regs)
 		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
 }
 
-static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs, void *args)
+static void aic_ipi_send_single(unsigned int cpu)
 {
-	int i;
-
-	for (i = 0; i < nr_irqs; i++) {
-		irq_set_percpu_devid(virq + i);
-		irq_domain_set_info(d, virq + i, i, &ipi_chip, d->host_data,
-				    handle_percpu_devid_irq, NULL, NULL);
-	}
-
-	return 0;
-}
-
-static void aic_ipi_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
-{
-	/* Not freeing IPIs */
+	if (static_branch_likely(&use_fast_ipi))
+		aic_ipi_send_fast(cpu);
+	else
+		aic_ic_write(aic_irqc, AIC_IPI_SEND, AIC_IPI_SEND_CPU(cpu));
 }
 
-static const struct irq_domain_ops aic_ipi_domain_ops = {
-	.alloc = aic_ipi_alloc,
-	.free = aic_ipi_free,
-};
-
 static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
 {
-	struct irq_domain *ipi_domain;
 	int base_ipi;
 
-	ipi_domain = irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWIPI,
-					      &aic_ipi_domain_ops, irqc);
-	if (WARN_ON(!ipi_domain))
-		return -ENODEV;
-
-	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
-	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, AIC_NR_SWIPI,
-					   NUMA_NO_NODE, NULL, false, NULL);
-
-	if (WARN_ON(!base_ipi)) {
-		irq_domain_remove(ipi_domain);
+	base_ipi = ipi_mux_create(AIC_NR_SWIPI, aic_ipi_send_single);
+	if (WARN_ON(base_ipi <= 0))
 		return -ENODEV;
-	}
 
 	set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
 
-	irqc->ipi_domain = ipi_domain;
-
 	return 0;
 }
 
