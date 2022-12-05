Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D19643030
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiLES0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiLESZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649A209A5;
        Mon,  5 Dec 2022 10:25:17 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtKHZ74nPCKhwCfX/AIwrExnVYjr6fc6kAlNCjlmqnk=;
        b=CVB/uqRJXb/3w27cQKUTzudgFgCJ6nNoVagJtTaZAY9Qq5RNIYZt74JVqQajKo+V4HmWMg
        mHuUHG7gcI2hSPG8L4HgZIbnSQQXFd/pNcubx1BDE4Awl6Io4lxto0LkzfN96mV1aOWzia
        r1AjyfoJRYj3iTdi/lfHVqjn4GO/Q8YC/PkbbgpZyWahLfF/RP+CmSb/99jIekg/MfjkWu
        dsTdBigeEOCzLwmUWdHQGFezGcFTttkPiQPOeHWEaADKtaxb35xFlsQ28FRh6qwIn0XYaS
        hKWUS4hOK8HlqkR7uDCa4fITKD6CqWd/PSs9aUlTXKagBHy1opGU2rydwv9/5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtKHZ74nPCKhwCfX/AIwrExnVYjr6fc6kAlNCjlmqnk=;
        b=nhbQxHaCRMrNEkGmN7OIk8p3XDMH/KCHPVpWcISA9IOMaHzeGHkya4ylw57KCjWKzLyFjo
        gDB/QvDUJ8rJPEDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic/msi: Remove arch_create_remap_msi_irq_domain()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.267353814@linutronix.de>
References: <20221124232326.267353814@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471361.4906.8042825607190869798.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3d81f920bf95dbf2911a87b9ca7e0167525ea325
Gitweb:        https://git.kernel.org/tip/3d81f920bf95dbf2911a87b9ca7e0167525ea325
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:03 +01:00

x86/apic/msi: Remove arch_create_remap_msi_irq_domain()

and related code which is not longer required now that the interrupt remap
code has been converted to MSI parent domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.267353814@linutronix.de

---
 arch/x86/include/asm/irq_remapping.h |  4 +---
 arch/x86/kernel/apic/msi.c           | 42 +---------------------------
 2 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 7cc4943..7a2ed15 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,10 +44,6 @@ extern int irq_remapping_reenable(int);
 extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
 
-/* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
-extern struct irq_domain *
-arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int id);
-
 /* Get parent irqdomain for interrupt remapping irqdomain */
 static inline struct irq_domain *arch_get_ir_parent_domain(void)
 {
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index d198da3..682f51a 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -277,7 +277,7 @@ void __init x86_create_pci_msi_domain(void)
 	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
-/* Keep around for hyperV and the remap code below */
+/* Keep around for hyperV */
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
@@ -291,46 +291,6 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 }
 EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-#ifdef CONFIG_IRQ_REMAP
-static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
-};
-
-static struct irq_chip pci_msi_ir_controller = {
-	.name			= "IR-PCI-MSI",
-	.irq_unmask		= pci_msi_unmask_irq,
-	.irq_mask		= pci_msi_mask_irq,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_AFFINITY_PRE_STARTUP,
-};
-
-static struct msi_domain_info pci_msi_ir_domain_info = {
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
-	.ops		= &pci_msi_domain_ops,
-	.chip		= &pci_msi_ir_controller,
-	.handler	= handle_edge_irq,
-	.handler_name	= "edge",
-};
-
-struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
-						    const char *name, int id)
-{
-	struct fwnode_handle *fn;
-	struct irq_domain *d;
-
-	fn = irq_domain_alloc_named_id_fwnode(name, id);
-	if (!fn)
-		return NULL;
-	d = pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
-	if (!d)
-		irq_domain_free_fwnode(fn);
-	return d;
-}
-#endif
-
 #ifdef CONFIG_DMAR_TABLE
 /*
  * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the
