Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5364303D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiLES0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiLESZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D920BCA;
        Mon,  5 Dec 2022 10:25:17 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Il/CbdHu9pPpiZtWniggttxXh3zGtyvoQhyMRC2LCcw=;
        b=Nlo4ZNv2J8ClcIlmPHx8DWGX5kIKwdu0LmFBxGI49kps2Kur32WyIHu00xdfMtqI4nrt6W
        8QBAb6fVQPxj7LyMtxRCZqNpgdmnqjqb3jsjS2DxVjaDtt//SWCbCih2peTz76JhTtZEAU
        uqjLXYBiBR3aZTdmVUqvx3SJIfnJmA9MPb8iJEIu36Kc++uvtUS3N6oQiktgd4nDhMigyv
        MwugoVpnioezZSWCcn+tNkY57RPP0pnKosYvI9CAEkauVMaz+AF2OCuTcaB/8HtcYCYddt
        VJsRGRxNKEkbXhFnPWeACCOajmNe1wJJ6+Z+FVdJgMPqBX9PVFWUxl8CYB6wcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Il/CbdHu9pPpiZtWniggttxXh3zGtyvoQhyMRC2LCcw=;
        b=6puPcduO6SzC+Vl1KbloSzQssnzHX6TlevYWm0eIReo5elLB/VI6WLH/rwGszJDcTfmQef
        2hFGtYYrkBA68yAQ==
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
Message-ID: <167026471384.4906.14147282485402173941.tip-bot2@tip-bot2>
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

Commit-ID:     eb7395d58b1c2c8d5ff76bc2b102d4300a68a67b
Gitweb:        https://git.kernel.org/tip/eb7395d58b1c2c8d5ff76bc2b102d4300a68a67b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:02 +01:00

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
