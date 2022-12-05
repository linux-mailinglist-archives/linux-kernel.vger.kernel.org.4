Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C664301E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiLES0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiLESZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AB20BFE;
        Mon,  5 Dec 2022 10:25:15 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mH4gWlzl61S5lQe5dNP/FWwwu5ar8+UBW9VGxShd/fM=;
        b=yOVF5JUtCPpgTiyXO09bQHE2yquvoWa9ef8SVdaaktNcUzCk0POU/MEAD+tmh8j7eIWeoJ
        JeDLNHY8nkEItmZXnvlj6qLsJvo+vN9pZEsLa7kIIJq8r5eW+PKLbOf4GSD7gkttE24vHZ
        EAHjn76gig/ATqdiDTUJX2Wol0ziUf6QW/kgl9hMJA+qvlgQs7jLw4j/fdM10oTEWG3Vu6
        w6fWfFFFwyzOhJle7assbDguzXblvJMf7yTG/67r5LIRP6QyhkkBA8c8U1t3rbsf0UgtMM
        CUxLOoOzEdP8kxW6MtpizfBn4EfbeI7p6pSOsDJly9Skg1x32ZrjrxAfEZ0Ydw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mH4gWlzl61S5lQe5dNP/FWwwu5ar8+UBW9VGxShd/fM=;
        b=JEGUDgw1QvXujEOAkfl1zuxcWGsuW/LJPOXpVnJP393Lu1cMpxpxCweuJ0+kpxUE+R2nNl
        ZKSto7hJHH6d6vAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Split MSI-X descriptor setup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.616292598@linutronix.de>
References: <20221124232326.616292598@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471218.4906.3891744610081938568.tip-bot2@tip-bot2>
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

Commit-ID:     4b844ea1a6bab042be5644a4e88e2fc19bbe853f
Gitweb:        https://git.kernel.org/tip/4b844ea1a6bab042be5644a4e88e2fc19bbe853f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:03 +01:00

PCI/MSI: Split MSI-X descriptor setup

The upcoming mechanism to allocate MSI-X vectors after enabling MSI-X needs
to share some of the MSI-X descriptor setup.

The regular descriptor setup on enable has the following code flow:

    1) Allocate descriptor
    2) Setup descriptor with PCI specific data
    3) Insert descriptor
    4) Allocate interrupts which in turn scans the inserted
       descriptors

This cannot be easily changed because the PCI/MSI code needs to handle the
legacy architecture specific allocation model and the irq domain model
where quite some domains have the assumption that the above flow is how it
works.

Ideally the code flow should look like this:

   1) Invoke allocation at the MSI core
   2) MSI core allocates descriptor
   3) MSI core calls back into the irq domain which fills in
      the domain specific parts

This could be done for underlying parent MSI domains which support
post-enable allocation/free but that would create significantly different
code pathes for MSI/MSI-X enable.

Though for dynamic allocation which wants to share the allocation code with
the upcoming PCI/IMS support it's the right thing to do.

Split the MSI-X descriptor setup into the preallocation part which just sets
the index and fills in the horrible hack of virtual IRQs and the real PCI
specific MSI-X setup part which solely depends on the index in the
descriptor. This allows to provide a common dynamic allocation interface at
the MSI core level for both PCI/MSI-X and PCI/IMS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.616292598@linutronix.de

---
 drivers/pci/msi/msi.c | 72 ++++++++++++++++++++++++++----------------
 drivers/pci/msi/msi.h |  2 +-
 2 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index b8d74df..1f71662 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -569,34 +569,56 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
 	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 }
 
-static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
-				struct msix_entry *entries, int nvec,
-				struct irq_affinity_desc *masks)
+/**
+ * msix_prepare_msi_desc - Prepare a half initialized MSI descriptor for operation
+ * @dev:	The PCI device for which the descriptor is prepared
+ * @desc:	The MSI descriptor for preparation
+ *
+ * This is separate from msix_setup_msi_descs() below to handle dynamic
+ * allocations for MSI-X after initial enablement.
+ *
+ * Ideally the whole MSI-X setup would work that way, but there is no way to
+ * support this for the legacy arch_setup_msi_irqs() mechanism and for the
+ * fake irq domains like the x86 XEN one. Sigh...
+ *
+ * The descriptor is zeroed and only @desc::msi_index and @desc::affinity
+ * are set. When called from msix_setup_msi_descs() then the is_virtual
+ * attribute is initialized as well.
+ *
+ * Fill in the rest.
+ */
+void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
+{
+	desc->nvec_used				= 1;
+	desc->pci.msi_attrib.is_msix		= 1;
+	desc->pci.msi_attrib.is_64		= 1;
+	desc->pci.msi_attrib.default_irq	= dev->irq;
+	desc->pci.mask_base			= dev->msix_base;
+	desc->pci.msi_attrib.can_mask		= !pci_msi_ignore_mask &&
+						  !desc->pci.msi_attrib.is_virtual;
+
+	if (desc->pci.msi_attrib.can_mask) {
+		void __iomem *addr = pci_msix_desc_addr(desc);
+
+		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	}
+}
+
+static int msix_setup_msi_descs(struct pci_dev *dev, struct msix_entry *entries,
+				int nvec, struct irq_affinity_desc *masks)
 {
 	int ret = 0, i, vec_count = pci_msix_vec_count(dev);
 	struct irq_affinity_desc *curmsk;
 	struct msi_desc desc;
-	void __iomem *addr;
 
 	memset(&desc, 0, sizeof(desc));
 
-	desc.nvec_used			= 1;
-	desc.pci.msi_attrib.is_msix	= 1;
-	desc.pci.msi_attrib.is_64	= 1;
-	desc.pci.msi_attrib.default_irq	= dev->irq;
-	desc.pci.mask_base		= base;
-
 	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
 		desc.msi_index = entries ? entries[i].entry : i;
 		desc.affinity = masks ? curmsk : NULL;
 		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
-		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
-					       !desc.pci.msi_attrib.is_virtual;
 
-		if (desc.pci.msi_attrib.can_mask) {
-			addr = pci_msix_desc_addr(&desc);
-			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
-		}
+		msix_prepare_msi_desc(dev, &desc);
 
 		ret = msi_insert_msi_desc(&dev->dev, &desc);
 		if (ret)
@@ -629,9 +651,8 @@ static void msix_mask_all(void __iomem *base, int tsize)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
-static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
-				 struct msix_entry *entries, int nvec,
-				 struct irq_affinity *affd)
+static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
+				 int nvec, struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
 	int ret;
@@ -640,7 +661,7 @@ static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
 		masks = irq_create_affinity_masks(nvec, affd);
 
 	msi_lock_descs(&dev->dev);
-	ret = msix_setup_msi_descs(dev, base, entries, nvec, masks);
+	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
 		goto out_free;
 
@@ -678,7 +699,6 @@ out_unlock:
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	void __iomem *base;
 	int ret, tsize;
 	u16 control;
 
@@ -696,15 +716,13 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	tsize = msix_table_size(control);
-	base = msix_map_region(dev, tsize);
-	if (!base) {
+	dev->msix_base = msix_map_region(dev, tsize);
+	if (!dev->msix_base) {
 		ret = -ENOMEM;
 		goto out_disable;
 	}
 
-	dev->msix_base = base;
-
-	ret = msix_setup_interrupts(dev, base, entries, nvec, affd);
+	ret = msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
 		goto out_disable;
 
@@ -719,7 +737,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	 * which takes the MSI-X mask bits into account even
 	 * when MSI-X is disabled, which prevents MSI delivery.
 	 */
-	msix_mask_all(base, tsize);
+	msix_mask_all(dev->msix_base, tsize);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 74408cc..ee53cf0 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -84,6 +84,8 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
 
+void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc);
+
 /* Subsystem variables */
 extern int pci_msi_enable;
 
