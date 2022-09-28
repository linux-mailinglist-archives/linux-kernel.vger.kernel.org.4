Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917E65EDDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiI1Nhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiI1NhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:37:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF78F97D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:37:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664372240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ns2FzbqQYbRPmeLxgvEQ4fBtD1KvBy8BZNI0bKQM3l0=;
        b=DbQovCzItR7W7d9hkl95clj7e4TWtH6MSoo9G95wC7pmJNVurIYyjiVDFDuKan87ZqPOou
        krbe7GKS/e+B6oSD+O2DaOBBV5HG+2n7UaxeeQmnNLEOgMiQEStDrAFff48Pt403d/ALJL
        nKmbSRm+I53BkvrDaJ43dRiJ5hi973tm21gfivjjC+JBb5DUMmZML6CxMHQ5bB/EtBrCbe
        kxLFzc4TCJT3dU0e67j3Wu01ZVUJIMEZXzQzQX51w9IyeA8LY2E7kSa2M8Z0p+kfLWTF51
        TxvlUfmj2JZErLFS5hVlm4nqQyCOqPiO655lvbU0C9fDVee2MDvV3h7utnHxbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664372240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ns2FzbqQYbRPmeLxgvEQ4fBtD1KvBy8BZNI0bKQM3l0=;
        b=dDEimUf/axSJ1WNA3v3MD2ytLW4RVPPKNak4epEbw/1k7epvZpFCHpsCIcWf9gVBQQnjFE
        DZOs9wzwcKzfbjDw==
From:   "irqchip-bot for Sander Vanheule" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/realtek-rtl: use parent interrupts
Cc:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C5f901a82eaa9d97cadf6e9b73a894a92f3f83b7c=2E16636?=
 =?utf-8?q?17425=2Egit=2Esander=40svanheule=2Enet=3E?=
References: =?utf-8?q?=3C5f901a82eaa9d97cadf6e9b73a894a92f3f83b7c=2E166361?=
 =?utf-8?q?7425=2Egit=2Esander=40svanheule=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <166437223886.401.17126968057051862009.tip-bot2@tip-bot2>
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

Commit-ID:     9070f1ce31c5027821d5f37e9ca8dfb23158e457
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9070f1ce31c5027821d5f37e9ca8dfb23158e457
Author:        Sander Vanheule <sander@svanheule.net>
AuthorDate:    Mon, 19 Sep 2022 22:24:43 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 28 Sep 2022 14:17:10 +01:00

irqchip/realtek-rtl: use parent interrupts

The interrupt-map property for "realtek,rtl-intc" has been deprecated in
favor of a list of parent interrupts. Drop the open-coded parser for
interrupt-map, and use the first parent interrupt instead. If no parent
was provided, the driver will assume that this is the first hardware
interrupt of the SoC's MIPS CPU for compatibility with the legacy binding.

All SoC interrupts were treated equally, independent of which output
they were actually routed to. This means the driver might as well route
all interrupts to the first output, and achieve the same behaviour.

Without the interrupt-map property, interrupt usage information is no
longer available at initialisation. Routing setup will now happen later,
when a hardware interrupt is mapped by the subsystem.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/5f901a82eaa9d97cadf6e9b73a894a92f3f83b7c.1663617425.git.sander@svanheule.net
---
 drivers/irqchip/irq-realtek-rtl.c | 133 +++++++++++++----------------
 1 file changed, 61 insertions(+), 72 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 160feae..2a34908 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -21,11 +21,33 @@
 #define RTL_ICTL_IRR2		0x10
 #define RTL_ICTL_IRR3		0x14
 
+#define RTL_ICTL_NUM_INPUTS	32
+
 #define REG(x)		(realtek_ictl_base + x)
 
 static DEFINE_RAW_SPINLOCK(irq_lock);
 static void __iomem *realtek_ictl_base;
 
+/*
+ * IRR0-IRR3 store 4 bits per interrupt, but Realtek uses inverted numbering,
+ * placing IRQ 31 in the first four bits. A routing value of '0' means the
+ * interrupt is left disconnected. Routing values {1..15} connect to output
+ * lines {0..14}.
+ */
+#define IRR_OFFSET(idx)		(4 * (3 - (idx * 4) / 32))
+#define IRR_SHIFT(idx)		((idx * 4) % 32)
+
+static void write_irr(void __iomem *irr0, int idx, u32 value)
+{
+	unsigned int offset = IRR_OFFSET(idx);
+	unsigned int shift = IRR_SHIFT(idx);
+	u32 irr;
+
+	irr = readl(irr0 + offset) & ~(0xf << shift);
+	irr |= (value & 0xf) << shift;
+	writel(irr, irr0 + offset);
+}
+
 static void realtek_ictl_unmask_irq(struct irq_data *i)
 {
 	unsigned long flags;
@@ -62,8 +84,14 @@ static struct irq_chip realtek_ictl_irq = {
 
 static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
+	unsigned long flags;
+
 	irq_set_chip_and_handler(irq, &realtek_ictl_irq, handle_level_irq);
 
+	raw_spin_lock_irqsave(&irq_lock, flags);
+	write_irr(REG(RTL_ICTL_IRR0), hw, 1);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+
 	return 0;
 }
 
@@ -95,89 +123,50 @@ out:
 	chained_irq_exit(chip, desc);
 }
 
-/*
- * SoC interrupts are cascaded to MIPS CPU interrupts according to the
- * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
- * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
- * thus go into 4 IRRs. A routing value of '0' means the interrupt is left
- * disconnected. Routing values {1..15} connect to output lines {0..14}.
- */
-static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
-{
-	struct device_node *cpu_ictl;
-	const __be32 *imap;
-	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
-	int ret, i, irr_regs[] = {
-		RTL_ICTL_IRR3,
-		RTL_ICTL_IRR2,
-		RTL_ICTL_IRR1,
-		RTL_ICTL_IRR0,
-	};
-	u8 mips_irqs_set;
-
-	ret = of_property_read_u32(node, "#address-cells", &tmp);
-	if (ret || tmp)
-		return -EINVAL;
-
-	imap = of_get_property(node, "interrupt-map", &imaplen);
-	if (!imap || imaplen % 3)
-		return -EINVAL;
-
-	mips_irqs_set = 0;
-	memset(regs, 0, sizeof(regs));
-	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
-		soc_int = be32_to_cpup(imap);
-		if (soc_int > 31)
-			return -EINVAL;
-
-		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
-		if (!cpu_ictl)
-			return -EINVAL;
-		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
-		of_node_put(cpu_ictl);
-		if (ret || tmp != 1)
-			return -EINVAL;
-
-		cpu_int = be32_to_cpup(imap + 2);
-		if (cpu_int > 7 || cpu_int < 2)
-			return -EINVAL;
-
-		if (!(mips_irqs_set & BIT(cpu_int))) {
-			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
-							 domain);
-			mips_irqs_set |= BIT(cpu_int);
-		}
-
-		/* Use routing values (1..6) for CPU interrupts (2..7) */
-		regs[(soc_int * 4) / 32] |= (cpu_int - 1) << (soc_int * 4) % 32;
-		imap += 3;
-	}
-
-	for (i = 0; i < 4; i++)
-		writel(regs[i], REG(irr_regs[i]));
-
-	return 0;
-}
-
 static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
 {
+	struct of_phandle_args oirq;
 	struct irq_domain *domain;
-	int ret;
+	unsigned int soc_irq;
+	int parent_irq;
 
 	realtek_ictl_base = of_iomap(node, 0);
 	if (!realtek_ictl_base)
 		return -ENXIO;
 
-	/* Disable all cascaded interrupts */
+	/* Disable all cascaded interrupts and clear routing */
 	writel(0, REG(RTL_ICTL_GIMR));
+	for (soc_irq = 0; soc_irq < RTL_ICTL_NUM_INPUTS; soc_irq++)
+		write_irr(REG(RTL_ICTL_IRR0), soc_irq, 0);
+
+	if (WARN_ON(!of_irq_count(node))) {
+		/*
+		 * If DT contains no parent interrupts, assume MIPS CPU IRQ 2
+		 * (HW0) is connected to the first output. This is the case for
+		 * all known hardware anyway. "interrupt-map" is deprecated, so
+		 * don't bother trying to parse that.
+		 */
+		oirq.np = of_find_compatible_node(NULL, NULL, "mti,cpu-interrupt-controller");
+		oirq.args_count = 1;
+		oirq.args[0] = 2;
+
+		parent_irq = irq_create_of_mapping(&oirq);
+
+		of_node_put(oirq.np);
+	} else {
+		parent_irq = of_irq_get(node, 0);
+	}
 
-	domain = irq_domain_add_linear(node, 32, &irq_domain_ops, NULL);
+	if (parent_irq < 0)
+		return parent_irq;
+	else if (!parent_irq)
+		return -ENODEV;
 
-	ret = map_interrupts(node, domain);
-	if (ret) {
-		pr_err("invalid interrupt map\n");
-		return ret;
-	}
+	domain = irq_domain_add_linear(node, RTL_ICTL_NUM_INPUTS, &irq_domain_ops, NULL);
+	if (!domain)
+		return -ENOMEM;
+
+	irq_set_chained_handler_and_data(parent_irq, realtek_irq_dispatch, domain);
 
 	return 0;
 }
