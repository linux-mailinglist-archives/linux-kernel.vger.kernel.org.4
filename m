Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C380A643027
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiLES0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiLESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902A20BDA;
        Mon,  5 Dec 2022 10:25:17 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxYZp75+n1m4oe1u+WV4gWWwd8DXVGrrB+Ur6R0YEuE=;
        b=r5nIwLiVBKUAjyg0jHg2agw+DMH9AgTE4aB06Y/90NNLvk9yJK6biooHAeuFnPenEDN9Hl
        EzXxI5AmpUbHB1dmkyxmip4qqlFw6S43VcRLHNUUonO7FwGIgjV4Vk4sUOQ7BhujhHjNmC
        MoDmk94svRWJeia+PVJ4dFsT/sQ7CcVvQ2JD3txNlRLyEf3GbHaYMdazQY/NXbQZpjFep7
        McaUdP9xD45XgXolr3UGNQeYsqCCth/0i/vRPpoJ/GQPFTGgUp90QU59nNDE0d5Spid+NX
        RFGBGenOiYblRZDUY4kELVTYkRhm7rhxar9lwyXWvbpLAfBc3WkEsbCZhCs8qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxYZp75+n1m4oe1u+WV4gWWwd8DXVGrrB+Ur6R0YEuE=;
        b=ydJVw5THFSeNDIqf1+NtGtbK28BkA+eWLfbj0EuFSrf/OCDIco9cGFN9tVOepHnGqV2bsH
        EMX9Y8O1IVAW29BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/vt-d: Switch to MSI parent domains
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.151226317@linutronix.de>
References: <20221124232326.151226317@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471406.4906.5560609467786500456.tip-bot2@tip-bot2>
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

Commit-ID:     01290527cfe8bb5aa8bb6c29ba5f3493d75652ca
Gitweb:        https://git.kernel.org/tip/01290527cfe8bb5aa8bb6c29ba5f3493d75652ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:02 +01:00

iommu/vt-d: Switch to MSI parent domains

Remove the global PCI/MSI irqdomain implementation and provide the required
MSI parent ops so the PCI/MSI code can detect the new parent and setup per
device domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.151226317@linutronix.de

---
 arch/x86/kernel/apic/msi.c          |  2 ++
 drivers/iommu/intel/iommu.h         |  1 -
 drivers/iommu/intel/irq_remapping.c | 27 ++++++++++++---------------
 include/linux/irqdomain_defs.h      |  1 +
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index db96bfc..a8dccb0 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -217,6 +217,8 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		/* See msi_set_affinity() for the gory details */
 		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
+	case DOMAIN_BUS_DMAR:
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92023df..6eadb86 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -600,7 +600,6 @@ struct intel_iommu {
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
-	struct irq_domain *ir_msi_domain;
 #endif
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 08bbf08..6fab407 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,6 +82,7 @@ static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
+static const struct msi_parent_ops dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -230,7 +231,7 @@ static struct irq_domain *map_dev_to_ir(struct pci_dev *dev)
 {
 	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
 
-	return drhd ? drhd->iommu->ir_msi_domain : NULL;
+	return drhd ? drhd->iommu->ir_domain : NULL;
 }
 
 static int clear_entries(struct irq_2_iommu *irq_iommu)
@@ -573,10 +574,10 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_fwnode;
 	}
-	iommu->ir_msi_domain =
-		arch_create_remap_msi_irq_domain(iommu->ir_domain,
-						 "INTEL-IR-MSI",
-						 iommu->seq_id);
+
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
+	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -620,9 +621,6 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	return 0;
 
 out_free_ir_domain:
-	if (iommu->ir_msi_domain)
-		irq_domain_remove(iommu->ir_msi_domain);
-	iommu->ir_msi_domain = NULL;
 	irq_domain_remove(iommu->ir_domain);
 	iommu->ir_domain = NULL;
 out_free_fwnode:
@@ -644,13 +642,6 @@ static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 	struct fwnode_handle *fn;
 
 	if (iommu && iommu->ir_table) {
-		if (iommu->ir_msi_domain) {
-			fn = iommu->ir_msi_domain->fwnode;
-
-			irq_domain_remove(iommu->ir_msi_domain);
-			irq_domain_free_fwnode(fn);
-			iommu->ir_msi_domain = NULL;
-		}
 		if (iommu->ir_domain) {
 			fn = iommu->ir_domain->fwnode;
 
@@ -1437,6 +1428,12 @@ static const struct irq_domain_ops intel_ir_domain_ops = {
 	.deactivate = intel_irq_remapping_deactivate,
 };
 
+static const struct msi_parent_ops dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "IR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index b3f4b7e..3a09396 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -23,6 +23,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_VMD_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
+	DOMAIN_BUS_DMAR,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
