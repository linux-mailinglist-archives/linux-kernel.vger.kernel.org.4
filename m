Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47045643734
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiLEVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiLEVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5052CDCE;
        Mon,  5 Dec 2022 13:41:54 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOKdQI8M8t6WJHJO+B39vBYrrB/8oLcsEUKbwJ9vke8=;
        b=QTkwLRpdIU6Vo0vl/EGiJNvKbyRtJKNvtRM11R1RgwcUPcuLpXhi3Ec7xZnZq1rNrksoc2
        dYF3WyTZOgJCE8R7L2Zu9ngeYTq4T/C3Nx/Dy7PRldOt+5TyChJS7q/hk1DL4hsRdIYhwZ
        fLx28CQ8jyBnIEtIy0jXoYAwRWZCoM5blzWvwsfX+usG2RteVnfMPrlvpr/oD2QxWAtevs
        88kWL6BmHj7DtthvzHVNfKDFybltJsbC+tOur0EZ4QFhIiCsxodOPx71GtSt9CAF9YLD8e
        G4OUQfQzXyExouDv2wDJLbR3vtEQAjfvbhi8esCSLBEHEEjWxZw2m0wwknxncQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOKdQI8M8t6WJHJO+B39vBYrrB/8oLcsEUKbwJ9vke8=;
        b=KrQnD3SbFpnMCjLbiFK4fmLn/ow3pyBloZMlccrNMZ3Mqz9JbAPEogFllS/Vpplo7MAgBD
        IzKJFSPedd3gytDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic/vector: Provide MSI parent domain
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.034672592@linutronix.de>
References: <20221124232326.034672592@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650929.4906.14876612209867274001.tip-bot2@tip-bot2>
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

Commit-ID:     b6d5fc3a5245c65f7c83440460a1566d09cc9038
Gitweb:        https://git.kernel.org/tip/b6d5fc3a5245c65f7c83440460a1566d09cc9038
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:33 +01:00

x86/apic/vector: Provide MSI parent domain

Enable MSI parent domain support in the x86 vector domain and fixup the
checks in the iommu implementations to check whether device::msi::domain is
the default MSI parent domain. That keeps the existing logic to protect
e.g. devices behind VMD working.

The interrupt remap PCI/MSI code still works because the underlying vector
domain still provides the same functionality.

None of the other x86 PCI/MSI, e.g. XEN and HyperV, implementations are
affected either. They still work the same way both at the low level and the
PCI/MSI implementations they provide.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.034672592@linutronix.de

---
 arch/x86/include/asm/msi.h          |   6 +-
 arch/x86/include/asm/pci.h          |   1 +-
 arch/x86/kernel/apic/msi.c          | 176 +++++++++++++++++++--------
 drivers/iommu/amd/iommu.c           |   2 +-
 drivers/iommu/intel/irq_remapping.c |   2 +-
 5 files changed, 138 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index d71c7e8..7702958 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -62,4 +62,10 @@ typedef struct x86_msi_addr_hi {
 struct msi_msg;
 u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
 
+#define X86_VECTOR_MSI_FLAGS_SUPPORTED					\
+	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
+
+#define X86_VECTOR_MSI_FLAGS_REQUIRED					\
+	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index c4789de..b40c462 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -92,6 +92,7 @@ void pcibios_scan_root(int bus);
 struct irq_routing_table *pcibios_get_irq_routing_table(void);
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
+bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev);
 
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 71c8751..db96bfc 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -142,67 +142,131 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	return ret;
 }
 
-/*
- * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI or MSI-X Capability Structure.
+/**
+ * pci_dev_has_default_msi_parent_domain - Check whether the device has the default
+ *					   MSI parent domain associated
+ * @dev:	Pointer to the PCI device
  */
-static struct irq_chip pci_msi_controller = {
-	.name			= "PCI-MSI",
-	.irq_unmask		= pci_msi_unmask_irq,
-	.irq_mask		= pci_msi_mask_irq,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_affinity	= msi_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_AFFINITY_PRE_STARTUP,
-};
-
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
-		    msi_alloc_info_t *arg)
+bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev)
 {
-	init_irq_alloc_info(arg, NULL);
-	if (to_pci_dev(dev)->msix_enabled)
-		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
-	else
-		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
+	struct irq_domain *domain = dev_get_msi_domain(&dev->dev);
 
-	return 0;
+	if (!domain)
+		domain = dev_get_msi_domain(&dev->bus->dev);
+	if (!domain)
+		return false;
+
+	return domain == x86_vector_domain;
 }
-EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
-};
+/**
+ * x86_msi_prepare - Setup of msi_alloc_info_t for allocations
+ * @domain:	The domain for which this setup happens
+ * @dev:	The device for which interrupts are allocated
+ * @nvec:	The number of vectors to allocate
+ * @alloc:	The allocation info structure to initialize
+ *
+ * This function is to be used for all types of MSI domains above the x86
+ * vector domain and any intermediates. It is always invoked from the
+ * top level interrupt domain. The domain specific allocation
+ * functionality is determined via the @domain's bus token which allows to
+ * map the X86 specific allocation type.
+ */
+static int x86_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *alloc)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	init_irq_alloc_info(alloc, NULL);
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
+		return 0;
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
 
-static struct msi_domain_info pci_msi_domain_info = {
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX | MSI_FLAG_NOMASK_QUIRK,
+/**
+ * x86_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain should be created
+ * @domain:		The (root) domain providing this callback
+ * @real_parent:	The real parent domain of the to initialize domain
+ * @info:		The domain info for the to initialize domain
+ *
+ * This function is to be used for all types of MSI domains above the x86
+ * vector domain and any intermediates. The domain specific functionality
+ * is determined via the @real_parent.
+ */
+static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+
+	/* MSI parent domain specific settings */
+	switch (real_parent->bus_token) {
+	case DOMAIN_BUS_ANY:
+		/* Only the vector domain can have the ANY token */
+		if (WARN_ON_ONCE(domain != real_parent))
+			return false;
+		info->chip->irq_set_affinity = msi_set_affinity;
+		/* See msi_set_affinity() for the gory details */
+		info->flags |= MSI_FLAG_NOMASK_QUIRK;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
 
-	.ops		= &pci_msi_domain_ops,
-	.chip		= &pci_msi_controller,
-	.handler	= handle_edge_irq,
-	.handler_name	= "edge",
+	/* Is the target supported? */
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&= pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|= X86_VECTOR_MSI_FLAGS_REQUIRED;
+
+	/* This is always invoked from the top level MSI domain! */
+	info->ops->msi_prepare		= x86_msi_prepare;
+
+	info->chip->irq_ack		= irq_chip_ack_parent;
+	info->chip->irq_retrigger	= irq_chip_retrigger_hierarchy;
+	info->chip->flags		|= IRQCHIP_SKIP_SET_WAKE |
+					   IRQCHIP_AFFINITY_PRE_STARTUP;
+
+	info->handler			= handle_edge_irq;
+	info->handler_name		= "edge";
+
+	return true;
+}
+
+static const struct msi_parent_ops x86_vector_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED,
+	.init_dev_msi_info	= x86_init_dev_msi_info,
 };
 
 struct irq_domain * __init native_create_pci_msi_domain(void)
 {
-	struct fwnode_handle *fn;
-	struct irq_domain *d;
-
 	if (disable_apic)
 		return NULL;
 
-	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
-	if (!fn)
-		return NULL;
-
-	d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-				      x86_vector_domain);
-	if (!d) {
-		irq_domain_free_fwnode(fn);
-		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
-	}
-	return d;
+	x86_vector_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	x86_vector_domain->msi_parent_ops = &x86_vector_msi_parent_ops;
+	return x86_vector_domain;
 }
 
 void __init x86_create_pci_msi_domain(void)
@@ -210,7 +274,25 @@ void __init x86_create_pci_msi_domain(void)
 	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
+/* Keep around for hyperV and the remap code below */
+int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
+{
+	init_irq_alloc_info(arg, NULL);
+
+	if (to_pci_dev(dev)->msix_enabled)
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
+	else
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_msi_prepare);
+
 #ifdef CONFIG_IRQ_REMAP
+static struct msi_domain_ops pci_msi_domain_ops = {
+	.msi_prepare	= pci_msi_prepare,
+};
+
 static struct irq_chip pci_msi_ir_controller = {
 	.name			= "IR-PCI-MSI",
 	.irq_unmask		= pci_msi_unmask_irq,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 72dfe57..67e209c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -812,7 +812,7 @@ static void
 amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
 {
 	if (!irq_remapping_enabled || !dev_is_pci(dev) ||
-	    pci_dev_has_special_msi_domain(to_pci_dev(dev)))
+	    !pci_dev_has_default_msi_parent_domain(to_pci_dev(dev)))
 		return;
 
 	dev_set_msi_domain(dev, iommu->msi_domain);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a914eba..08bbf08 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1107,7 +1107,7 @@ error:
  */
 void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
 {
-	if (!irq_remapping_enabled || pci_dev_has_special_msi_domain(info->dev))
+	if (!irq_remapping_enabled || !pci_dev_has_default_msi_parent_domain(info->dev))
 		return;
 
 	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
