Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C256DBA3B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDHKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjDHKue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:50:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AFA11EA0
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:49:38 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kgWak1i0mIV7qLJxTAwEXpDoMYPgTeJAnVbzOuIMqg=;
        b=XwgMiTJHJlKOScPsgdnjyM5plyhNorCxjDMeCLQK61zlBTK2i8pMofZSTL3Umrz15GtgZs
        Y/CflIDm833JxfcOUEBMAjaiXmuPa6CiaCitPWpniNeP3WD+6QEurlSOMScly+tx7EK/zx
        4ZTtiYthwRRF6/sIZJGYxDGLFsbvbzW8NkfmjocVMvA3x4iLK794zONbm773vFRFwsRWYT
        WK1liCeDJTg7k/XFP80Lyae0cLPp9Xmwh7CpWSDZNI1wuK0JviT0FY1Ic/4ZqQTH65hy5n
        OoVNLB2JvhW6wXrOm2QLuvUy4y2oIqv/cgtJX81qJylCXs3C7e4bsZgCvNvl7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kgWak1i0mIV7qLJxTAwEXpDoMYPgTeJAnVbzOuIMqg=;
        b=qbdG7j/rBIqgtWpeFcD5AgcPXC5qJ2FCEGKSWBc56nnLGFX+sCNDdvJ9DPrtuU4nieKph4
        N3AX24Sd/x1NwWDA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Drop support for board files
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230315130218.3212033-1-maz@kernel.org>
References: <20230315130218.3212033-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168095072174.404.8151744605918524188.tip-bot2@tip-bot2>
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

Commit-ID:     dee234032e767b3d6823fe122517770757306f04
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dee234032e767b3d6823fe122517770757306f04
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 15 Mar 2023 13:02:18 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 10:50:04 +01:00

irqchip/gic: Drop support for board files

With the last non-OF, non-ACPI user of the GIC being removed in
e73307b9ebc4 ("ARM: cns3xxx: remove entire platform"), we can finally
drop the entry point and do some minor cleanup.

We also make the driver depend on CONFIG_OF, which is required
even when CONFIG_ACPI is selected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230315130218.3212033-1-maz@kernel.org
---
 drivers/irqchip/Kconfig         |  1 +-
 drivers/irqchip/irq-gic.c       | 60 +-------------------------------
 include/linux/irqchip/arm-gic.h |  6 +---
 3 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7dc990e..b744fd9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -7,6 +7,7 @@ config IRQCHIP
 
 config ARM_GIC
 	bool
+	depends on OF
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 95e3d2a..412196a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1081,10 +1081,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
-{
-}
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -1167,11 +1163,6 @@ static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
 	.free = irq_domain_free_irqs_top,
 };
 
-static const struct irq_domain_ops gic_irq_domain_ops = {
-	.map = gic_irq_domain_map,
-	.unmap = gic_irq_domain_unmap,
-};
-
 static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
@@ -1219,30 +1210,9 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (handle) {		/* DT/ACPI */
-		gic->domain = irq_domain_create_linear(handle, gic_irqs,
-						       &gic_irq_domain_hierarchy_ops,
-						       gic);
-	} else {		/* Legacy support */
-		/*
-		 * For primary GICs, skip over SGIs.
-		 * No secondary GIC support whatsoever.
-		 */
-		int irq_base;
-
-		gic_irqs -= 16; /* calculate # of irqs to allocate */
-
-		irq_base = irq_alloc_descs(16, 16, gic_irqs,
-					   numa_node_id());
-		if (irq_base < 0) {
-			WARN(1, "Cannot allocate irq_descs @ IRQ16, assuming pre-allocated\n");
-			irq_base = 16;
-		}
-
-		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
-						    16, &gic_irq_domain_ops, gic);
-	}
-
+	gic->domain = irq_domain_create_linear(handle, gic_irqs,
+					       &gic_irq_domain_hierarchy_ops,
+					       gic);
 	if (WARN_ON(!gic->domain)) {
 		ret = -ENODEV;
 		goto error;
@@ -1297,23 +1267,6 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 	return ret;
 }
 
-void __init gic_init(void __iomem *dist_base, void __iomem *cpu_base)
-{
-	struct gic_chip_data *gic;
-
-	/*
-	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
-	 * bother with these...
-	 */
-	static_branch_disable(&supports_deactivate_key);
-
-	gic = &gic_data[0];
-	gic->raw_dist_base = dist_base;
-	gic->raw_cpu_base = cpu_base;
-
-	__gic_init_bases(gic, NULL);
-}
-
 static void gic_teardown(struct gic_chip_data *gic)
 {
 	if (WARN_ON(!gic))
@@ -1325,7 +1278,6 @@ static void gic_teardown(struct gic_chip_data *gic)
 		iounmap(gic->raw_cpu_base);
 }
 
-#ifdef CONFIG_OF
 static int gic_cnt __initdata;
 static bool gicv2_force_probe;
 
@@ -1570,12 +1522,6 @@ IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
-#else
-int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
-{
-	return -ENOTSUPP;
-}
-#endif
 
 #ifdef CONFIG_ACPI
 static struct
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 5686711..2223f95 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -151,12 +151,6 @@ int gic_of_init(struct device_node *node, struct device_node *parent);
  */
 int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
 
-/*
- * Legacy platforms not converted to DT yet must use this to init
- * their GIC
- */
-void gic_init(void __iomem *dist , void __iomem *cpu);
-
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
