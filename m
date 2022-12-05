Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD73643726
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiLEVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiLEVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877B2BB29;
        Mon,  5 Dec 2022 13:41:54 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHxcETksPX5G/wP4tY+IQ8UMOJgTTZYAWZsOy2a9/WE=;
        b=uOO77zgg4dvJnmgkPaf1F2GPErlw5pg9sQa1JxNeN4mW/VGPoxSH1s6Jqi+4yV24dtfMb7
        GkecGFMLEj/LQvhkzr9NY/so+P+vevVRS0/u409Ze/7Bjf4HWwOTIlNkoaWzfW41oQbl0l
        CZaP/RTQKi3QnwE+17goyj/RRaz67GrRjFLiORAhCGH+ESxa/24DdIiqgtyjTkCpxyMjJ6
        APWLCKNipYF3+u2kaikp+6eBgVhjXC8EcfNQlo9su8JL3iSe/UuUX36GepC5cfyz4GZUSe
        JP0hls5X8cKjvfFNcHyUgloIUylExCldbrr9JdrqqoyzMWWhgioxUF7UkzP2rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHxcETksPX5G/wP4tY+IQ8UMOJgTTZYAWZsOy2a9/WE=;
        b=1IGSvYZK3YOB9y5r3eqcLVlbSu5tH1FxLqWjh3kVMnlm9GmlEkF9y1tijXG5l8zpqvrrCX
        Is80mUfSIXpu+XBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/amd: Switch to MSI base domains
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.209212272@linutronix.de>
References: <20221124232326.209212272@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650885.4906.17251699860800142413.tip-bot2@tip-bot2>
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

Commit-ID:     cc7594ffadde77e2825faf1c576230530c829bc3
Gitweb:        https://git.kernel.org/tip/cc7594ffadde77e2825faf1c576230530c829bc3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:33 +01:00

iommu/amd: Switch to MSI base domains

Remove the global PCI/MSI irqdomain implementation and provide the required
MSI parent ops so the PCI/MSI code can detect the new parent and setup per
device domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.209212272@linutronix.de

---
 arch/x86/kernel/apic/msi.c          |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 19 +++++++++++++------
 include/linux/irqdomain_defs.h      |  1 +
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index a8dccb0..d198da3 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -218,6 +218,7 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
 	case DOMAIN_BUS_DMAR:
+	case DOMAIN_BUS_AMDVI:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1d0a70c..3d68419 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -734,7 +734,6 @@ struct amd_iommu {
 	u8 max_counters;
 #ifdef CONFIG_IRQ_REMAP
 	struct irq_domain *ir_domain;
-	struct irq_domain *msi_domain;
 
 	struct amd_irte_ops *irte_ops;
 #endif
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 67e209c..7caccd8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -815,7 +815,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
 	    !pci_dev_has_default_msi_parent_domain(to_pci_dev(dev)))
 		return;
 
-	dev_set_msi_domain(dev, iommu->msi_domain);
+	dev_set_msi_domain(dev, iommu->ir_domain);
 }
 
 #else /* CONFIG_IRQ_REMAP */
@@ -3648,6 +3648,12 @@ static struct irq_chip amd_ir_chip = {
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
 };
 
+static const struct msi_parent_ops amdvi_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "IR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
 	struct fwnode_handle *fn;
@@ -3655,16 +3661,17 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	fn = irq_domain_alloc_named_id_fwnode("AMD-IR", iommu->index);
 	if (!fn)
 		return -ENOMEM;
-	iommu->ir_domain = irq_domain_create_tree(fn, &amd_ir_domain_ops, iommu);
+	iommu->ir_domain = irq_domain_create_hierarchy(arch_get_ir_parent_domain(), 0, 0,
+						       fn, &amd_ir_domain_ops, iommu);
 	if (!iommu->ir_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
 	}
 
-	iommu->ir_domain->parent = arch_get_ir_parent_domain();
-	iommu->msi_domain = arch_create_remap_msi_irq_domain(iommu->ir_domain,
-							     "AMD-IR-MSI",
-							     iommu->index);
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
+	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
+
 	return 0;
 }
 
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 3a09396..0b2d8a8 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -24,6 +24,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_DEVICE_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
 	DOMAIN_BUS_DMAR,
+	DOMAIN_BUS_AMDVI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
