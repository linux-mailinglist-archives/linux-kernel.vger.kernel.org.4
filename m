Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651C62DF01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbiKQPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiKQPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:07:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9F140A6;
        Thu, 17 Nov 2022 07:07:53 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNmQEcEjGzxFCaQveibqJYQwGgBrqlyIcsFyeRFOUc4=;
        b=uv04DabORtBeXcnJJ3ROYUdj9aSgLMClMv0lkN/cCSV5LyiZ0cSJZzJ8rXrEz8dPr/w3kh
        n7GTuaje6khIpSf58sqLGlICRfyuAXgT5Bz391TYgBXlJVLo1xyYb69bA8VDrkIbmvByNz
        ULl32Dg6S2kxDFNZDFU8VOd19uB1Vk5rzJYJGG4r/K5rchhhgD1kQh6sTp//Zv51YzPd46
        Vl+m43ScXdqztv/dnR5CvYnK7Tc1rYfZn63t9asY54nsJrQFzcgLws5csvcwWKxvnCKT4J
        Yp2SwTaHkNcnYjgL9faYoE4qTb4I85WifTht9iIvSZtvOkx91L5hWb5BgG8ayg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNmQEcEjGzxFCaQveibqJYQwGgBrqlyIcsFyeRFOUc4=;
        b=JPSFDf0yt6efXnHjchIlkmkc26QQ5XWT/iokX5v4QnVzuc+T8LTxlFZrdfDC3AXDpSwfWC
        cofgYlQj/pHr/0BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.865042356@linutronix.de>
References: <20221111122015.865042356@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767063.4906.3559414491432257536.tip-bot2@tip-bot2>
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

Commit-ID:     d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
Gitweb:        https://git.kernel.org/tip/d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS

Now that the PCI/MSI core code does early checking for multi-MSI support
X86_IRQ_ALLOC_CONTIGUOUS_VECTORS is not required anymore.

Remove the flag and rely on MSI_FLAG_MULTI_PCI_MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122015.865042356@linutronix.de

---
 arch/x86/include/asm/irqdomain.h    |  4 +---
 arch/x86/kernel/apic/msi.c          |  6 ++----
 arch/x86/kernel/apic/vector.c       |  4 ----
 drivers/iommu/amd/iommu.c           |  7 -------
 drivers/iommu/intel/irq_remapping.c |  7 -------
 drivers/pci/controller/pci-hyperv.c | 15 +--------------
 6 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index 125c23b..30c325c 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -7,9 +7,7 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 enum {
-	/* Allocate contiguous CPU vectors */
-	X86_IRQ_ALLOC_CONTIGUOUS_VECTORS		= 0x1,
-	X86_IRQ_ALLOC_LEGACY				= 0x2,
+	X86_IRQ_ALLOC_LEGACY				= 0x1,
 };
 
 extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 7517eb0..248a6a5 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -161,12 +161,10 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
 	init_irq_alloc_info(arg, NULL);
-	if (to_pci_dev(dev)->msix_enabled) {
+	if (to_pci_dev(dev)->msix_enabled)
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
-	} else {
+	else
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
-		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-	}
 
 	return 0;
 }
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3e6f6b4..c1efebd 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -539,10 +539,6 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if (disable_apic)
 		return -ENXIO;
 
-	/* Currently vector allocator can't guarantee contiguous allocations */
-	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
-		return -ENOSYS;
-
 	/*
 	 * Catch any attempt to touch the cascade interrupt on a PIC
 	 * equipped system.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8ece864..72dfe57 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3297,13 +3297,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
-	/*
-	 * With IRQ remapping enabled, don't need contiguous CPU vectors
-	 * to support multiple MSI interrupts.
-	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
 	sbdf = get_devid(info);
 	if (sbdf < 0)
 		return -EINVAL;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0b80a27..a914eba 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1337,13 +1337,6 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
-	/*
-	 * With IRQ remapping enabled, don't need contiguous CPU vectors
-	 * to support multiple MSI interrupts.
-	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ba64284..1dee55d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -611,20 +611,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
 	return cfg->vector;
 }
 
-static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
-			  int nvec, msi_alloc_info_t *info)
-{
-	int ret = pci_msi_prepare(domain, dev, nvec, info);
-
-	/*
-	 * By using the interrupt remapper in the hypervisor IOMMU, contiguous
-	 * CPU vectors is not needed for multi-MSI
-	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
-	return ret;
-}
+#define hv_msi_prepare		pci_msi_prepare
 
 /**
  * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
