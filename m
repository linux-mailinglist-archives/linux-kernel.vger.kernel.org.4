Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D50643716
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiLEVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiLEVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387042B62C;
        Mon,  5 Dec 2022 13:41:54 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9F5YqJ+18TRULn54q8S9KUU8aieeGGOayC7bQNTDk8=;
        b=2TsNm8RaQCCs4L+AYKliFIExahTlQi+k/8wbY0yul+8y7wXujNnaXqZ/AZ5je9z8naSH8M
        J00ywqDpHg+YJFcUsPsK8egOXRwihygJiQlgqyR7VXhRkTR5GuqAbnMeUUce73lv2buhGS
        ZEi6Xzm6imTZ1w9Q9/GxhnTRLoK9gTfURPPuazCD/xogUg/X3Zhi5VxSKTgLgT6gT6sfKY
        KVEr/W/pUg5Rtw6fJLfBIHUN3PumlytKc4Y93A5w722Mp4p0Vy2pxrax0Wo4yUw5j3eTsP
        mxTA+tPr+iP1cbLN7Ix3fNHJ6kOaS9TZLRAaiSXS95Wv3Gw6LPiKkMJHDwRsTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9F5YqJ+18TRULn54q8S9KUU8aieeGGOayC7bQNTDk8=;
        b=XMq7lChAFbWMw0LN/DATNFmuIP1Su/L2QwG5A4/p/9fugsc+J6/5glTQaKCcSbIWdFd9fg
        Exm3C715pc8RUvDw==
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
Message-ID: <167027650870.4906.11537796116279991707.tip-bot2@tip-bot2>
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

Commit-ID:     4d5a4ccc519ab0a62e220dc8dcd8bc1c5f8fee10
Gitweb:        https://git.kernel.org/tip/4d5a4ccc519ab0a62e220dc8dcd8bc1c5f8fee10
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:33 +01:00

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
