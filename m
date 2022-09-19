Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC525BD5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiISUZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiISUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:24:54 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A8B868
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:24:51 -0700 (PDT)
Received: from terra.. (unknown [109.129.72.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 35B06321015;
        Mon, 19 Sep 2022 22:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1663619089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTvoszGGE0SrsaxXxob5teOYTKcu0Z+oIwsuQvqOHy0=;
        b=At53TygOmcacOcCpAczBDoE9qG8fXK+1uEFnzJT+rgBOyfa0I3eEJf8c9dHUx4qKzAwrA0
        K7u6b2zxAGdbtGVbYBPjr7cGN3eVqDYpA2hg/bNG/7+2wKqTQ20B3Do9isFCc7zhN0LsAc
        9VcTqH9n4x6r9/dLEH8L22ifD2PLIfnONLc8/86XNfIQLbDmjYAmIVP8uFGwloOK3xYCsg
        QTDgNQbkmes87OUaZrJV+qgBZ4Cc2hjowlwNcnoCFNnh4cN2xUpu1LPg7OEfzKkmkqUqRG
        FRGZPCCTwQzFVZpp8FALovMJ67f4p/V5OllAn31lIbXji8wBAG3+vmCJ2TIVPQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 3/3] irqchip/realtek-rtl: use parent interrupts
Date:   Mon, 19 Sep 2022 22:24:43 +0200
Message-Id: <5f901a82eaa9d97cadf6e9b73a894a92f3f83b7c.1663617425.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663617425.git.sander@svanheule.net>
References: <cover.1663617425.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-realtek-rtl.c | 133 ++++++++++++++----------------
 1 file changed, 61 insertions(+), 72 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 160feae0ded7..2a349082af81 100644
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
 
@@ -95,89 +123,50 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
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
-- 
2.37.3

