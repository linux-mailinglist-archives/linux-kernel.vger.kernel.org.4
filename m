Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA36162DF12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiKQPIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiKQPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5041574CE8;
        Thu, 17 Nov 2022 07:08:01 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tx4ytzsvlMXjsB+aNEPmV2SnCJ1bcA+v/PBZwrMr5k=;
        b=MMkjmz27VwT41D2pLh66+qfJAnSanG/sg3mHktu7wPNvx+bCeCmgXfa0KbNZ2tfQ6Q6PLW
        8nc93n//P8XX68k6L7GzFQigtsSUOSu/5ItQRcTK9FEdr6w3yKrxczS9xHN92egJWyNEcU
        ZZQjQK0APR3s5st0iJNsWTNzekLRHB1VAep9nJtAhMfJ6H1I7OgCUO26CgaX+oe431lUSE
        XXZU4tt3hjUlyEGq6Moo/aZ8JGDPGZHnK9Y5U7tW/pPUUzeIUAnIEIXlVpNbGP7UeuPV1g
        umncd7grzPBN2fqYhelW7Bu11qyUV2YI0Xlg/ywti+kD7OqKqyUSKKjKzAyF4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tx4ytzsvlMXjsB+aNEPmV2SnCJ1bcA+v/PBZwrMr5k=;
        b=KC2PZ+/O+8AD5Xb23eu5a9wbY4l0NMDxCDTl5LpSFkP3XMvlonb0tp7FyKT4QOnYpFerVe
        LBSNATVm0p80/TDw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Reorder functions in msi.c
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.459089736@linutronix.de>
References: <20221111122015.459089736@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767860.4906.18144489970793804842.tip-bot2@tip-bot2>
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

Commit-ID:     12910ffd189e23d8996e0d19b723518accf57b76
Gitweb:        https://git.kernel.org/tip/12910ffd189e23d8996e0d19b723518accf57b76
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Reorder functions in msi.c

There is no way to navigate msi.c without banging the head against the wall
every now and then because MSI and MSI-X specific functions are
intermingled and the code flow is completely non-obvious.

Reorder everthing so common helpers, MSI and MSI-X specific functions are
grouped together.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.459089736@linutronix.de

---
 drivers/pci/msi/msi.c | 639 ++++++++++++++++++++---------------------
 1 file changed, 326 insertions(+), 313 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index a5d168c..380e651 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -16,6 +16,97 @@
 int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
+/**
+ * pci_msi_supported - check whether MSI may be enabled on a device
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ * @nvec: how many MSIs have been requested?
+ *
+ * Look at global flags, the device itself, and its parent buses
+ * to determine if MSI/-X are supported for the device. If MSI/-X is
+ * supported return 1, else return 0.
+ **/
+static int pci_msi_supported(struct pci_dev *dev, int nvec)
+{
+	struct pci_bus *bus;
+
+	/* MSI must be globally enabled and supported by the device */
+	if (!pci_msi_enable)
+		return 0;
+
+	if (!dev || dev->no_msi)
+		return 0;
+
+	/*
+	 * You can't ask to have 0 or less MSIs configured.
+	 *  a) it's stupid ..
+	 *  b) the list manipulation code assumes nvec >= 1.
+	 */
+	if (nvec < 1)
+		return 0;
+
+	/*
+	 * Any bridge which does NOT route MSI transactions from its
+	 * secondary bus to its primary bus must set NO_MSI flag on
+	 * the secondary pci_bus.
+	 *
+	 * The NO_MSI flag can either be set directly by:
+	 * - arch-specific PCI host bus controller drivers (deprecated)
+	 * - quirks for specific PCI bridges
+	 *
+	 * or indirectly by platform-specific PCI host bridge drivers by
+	 * advertising the 'msi_domain' property, which results in
+	 * the NO_MSI flag when no MSI domain is found for this bridge
+	 * at probe time.
+	 */
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return 0;
+
+	return 1;
+}
+
+static void pcim_msi_release(void *pcidev)
+{
+	struct pci_dev *dev = pcidev;
+
+	dev->is_msi_managed = false;
+	pci_free_irq_vectors(dev);
+}
+
+/*
+ * Needs to be separate from pcim_release to prevent an ordering problem
+ * vs. msi_device_data_release() in the MSI core code.
+ */
+static int pcim_setup_msi_release(struct pci_dev *dev)
+{
+	int ret;
+
+	if (!pci_is_managed(dev) || dev->is_msi_managed)
+		return 0;
+
+	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
+	if (!ret)
+		dev->is_msi_managed = true;
+	return ret;
+}
+
+/*
+ * Ordering vs. devres: msi device data has to be installed first so that
+ * pcim_msi_release() is invoked before it on device release.
+ */
+static int pci_setup_msi_context(struct pci_dev *dev)
+{
+	int ret = msi_setup_device_data(&dev->dev);
+
+	if (!ret)
+		ret = pcim_setup_msi_release(dev);
+	return ret;
+}
+
+/*
+ * Helper functions for mask/unmask and MSI message handling
+ */
+
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
 	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
@@ -163,15 +254,8 @@ void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 }
 EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 
-void pci_free_msi_irqs(struct pci_dev *dev)
-{
-	pci_msi_teardown_msi_irqs(dev);
 
-	if (dev->msix_base) {
-		iounmap(dev->msix_base);
-		dev->msix_base = NULL;
-	}
-}
+/* PCI/MSI specific functionality */
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
@@ -190,111 +274,6 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
-/*
- * Architecture override returns true when the PCI MSI message should be
- * written by the generic restore function.
- */
-bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	return true;
-}
-
-void __pci_restore_msi_state(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-	u16 control;
-
-	if (!dev->msi_enabled)
-		return;
-
-	entry = irq_get_msi_desc(dev->irq);
-
-	pci_intx_for_msi(dev, 0);
-	pci_msi_set_enable(dev, 0);
-	if (arch_restore_msi_irqs(dev))
-		__pci_write_msi_msg(entry, &entry->msg);
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	pci_msi_update_mask(entry, 0, 0);
-	control &= ~PCI_MSI_FLAGS_QSIZE;
-	control |= (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
-}
-
-static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
-{
-	u16 ctrl;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	ctrl &= ~clear;
-	ctrl |= set;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
-}
-
-void __pci_restore_msix_state(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-	bool write_msg;
-
-	if (!dev->msix_enabled)
-		return;
-
-	/* route the table */
-	pci_intx_for_msi(dev, 0);
-	pci_msix_clear_and_set_ctrl(dev, 0,
-				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
-
-	write_msg = arch_restore_msi_irqs(dev);
-
-	msi_lock_descs(&dev->dev);
-	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (write_msg)
-			__pci_write_msi_msg(entry, &entry->msg);
-		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
-	}
-	msi_unlock_descs(&dev->dev);
-
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
-}
-
-static void pcim_msi_release(void *pcidev)
-{
-	struct pci_dev *dev = pcidev;
-
-	dev->is_msi_managed = false;
-	pci_free_irq_vectors(dev);
-}
-
-/*
- * Needs to be separate from pcim_release to prevent an ordering problem
- * vs. msi_device_data_release() in the MSI core code.
- */
-static int pcim_setup_msi_release(struct pci_dev *dev)
-{
-	int ret;
-
-	if (!pci_is_managed(dev) || dev->is_msi_managed)
-		return 0;
-
-	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
-	if (!ret)
-		dev->is_msi_managed = true;
-	return ret;
-}
-
-/*
- * Ordering vs. devres: msi device data has to be installed first so that
- * pcim_msi_release() is invoked before it on device release.
- */
-static int pci_setup_msi_context(struct pci_dev *dev)
-{
-	int ret = msi_setup_device_data(&dev->dev);
-
-	if (!ret)
-		ret = pcim_setup_msi_release(dev);
-	return ret;
-}
-
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
@@ -415,45 +394,188 @@ unlock:
 	return ret;
 }
 
-static void __iomem *msix_map_region(struct pci_dev *dev,
-				     unsigned int nr_entries)
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
+			   struct irq_affinity *affd)
 {
-	resource_size_t phys_addr;
-	u32 table_offset;
-	unsigned long flags;
-	u8 bir;
+	int nvec;
+	int rc;
 
-	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
-			      &table_offset);
-	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
-	flags = pci_resource_flags(dev, bir);
-	if (!flags || (flags & IORESOURCE_UNSET))
-		return NULL;
+	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
+		return -EINVAL;
 
-	table_offset &= PCI_MSIX_TABLE_OFFSET;
-	phys_addr = pci_resource_start(dev, bir) + table_offset;
+	/* Check whether driver already requested MSI-X IRQs */
+	if (dev->msix_enabled) {
+		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
+		return -EINVAL;
+	}
 
-	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
-}
+	if (maxvec < minvec)
+		return -ERANGE;
 
-static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
-				struct msix_entry *entries, int nvec,
-				struct irq_affinity_desc *masks)
-{
-	int ret = 0, i, vec_count = pci_msix_vec_count(dev);
-	struct irq_affinity_desc *curmsk;
-	struct msi_desc desc;
-	void __iomem *addr;
+	if (WARN_ON_ONCE(dev->msi_enabled))
+		return -EINVAL;
 
-	memset(&desc, 0, sizeof(desc));
+	nvec = pci_msi_vec_count(dev);
+	if (nvec < 0)
+		return nvec;
+	if (nvec < minvec)
+		return -ENOSPC;
 
-	desc.nvec_used			= 1;
-	desc.pci.msi_attrib.is_msix	= 1;
-	desc.pci.msi_attrib.is_64	= 1;
-	desc.pci.msi_attrib.default_irq	= dev->irq;
-	desc.pci.mask_base		= base;
+	if (nvec > maxvec)
+		nvec = maxvec;
 
-	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
+	rc = pci_setup_msi_context(dev);
+	if (rc)
+		return rc;
+
+	for (;;) {
+		if (affd) {
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
+			if (nvec < minvec)
+				return -ENOSPC;
+		}
+
+		rc = msi_capability_init(dev, nvec, affd);
+		if (rc == 0)
+			return nvec;
+
+		if (rc < 0)
+			return rc;
+		if (rc < minvec)
+			return -ENOSPC;
+
+		nvec = rc;
+	}
+}
+
+/**
+ * pci_msi_vec_count - Return the number of MSI vectors a device can send
+ * @dev: device to report about
+ *
+ * This function returns the number of MSI vectors a device requested via
+ * Multiple Message Capable register. It returns a negative errno if the
+ * device is not capable sending MSI interrupts. Otherwise, the call succeeds
+ * and returns a power of two, up to a maximum of 2^5 (32), according to the
+ * MSI specification.
+ **/
+int pci_msi_vec_count(struct pci_dev *dev)
+{
+	int ret;
+	u16 msgctl;
+
+	if (!dev->msi_cap)
+		return -EINVAL;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
+	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_msi_vec_count);
+
+/*
+ * Architecture override returns true when the PCI MSI message should be
+ * written by the generic restore function.
+ */
+bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
+{
+	return true;
+}
+
+void __pci_restore_msi_state(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+	u16 control;
+
+	if (!dev->msi_enabled)
+		return;
+
+	entry = irq_get_msi_desc(dev->irq);
+
+	pci_intx_for_msi(dev, 0);
+	pci_msi_set_enable(dev, 0);
+	if (arch_restore_msi_irqs(dev))
+		__pci_write_msi_msg(entry, &entry->msg);
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	pci_msi_update_mask(entry, 0, 0);
+	control &= ~PCI_MSI_FLAGS_QSIZE;
+	control |= (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
+}
+
+void pci_msi_shutdown(struct pci_dev *dev)
+{
+	struct msi_desc *desc;
+
+	if (!pci_msi_enable || !dev || !dev->msi_enabled)
+		return;
+
+	pci_msi_set_enable(dev, 0);
+	pci_intx_for_msi(dev, 1);
+	dev->msi_enabled = 0;
+
+	/* Return the device with MSI unmasked as initial states */
+	desc = msi_first_desc(&dev->dev, MSI_DESC_ALL);
+	if (!WARN_ON_ONCE(!desc))
+		pci_msi_unmask(desc, msi_multi_mask(desc));
+
+	/* Restore dev->irq to its default pin-assertion IRQ */
+	dev->irq = desc->pci.msi_attrib.default_irq;
+	pcibios_alloc_irq(dev);
+}
+
+/* PCI/MSI-X specific functionality */
+
+static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
+{
+	u16 ctrl;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~clear;
+	ctrl |= set;
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
+static void __iomem *msix_map_region(struct pci_dev *dev,
+				     unsigned int nr_entries)
+{
+	resource_size_t phys_addr;
+	u32 table_offset;
+	unsigned long flags;
+	u8 bir;
+
+	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
+			      &table_offset);
+	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	flags = pci_resource_flags(dev, bir);
+	if (!flags || (flags & IORESOURCE_UNSET))
+		return NULL;
+
+	table_offset &= PCI_MSIX_TABLE_OFFSET;
+	phys_addr = pci_resource_start(dev, bir) + table_offset;
+
+	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
+}
+
+static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
+				struct msix_entry *entries, int nvec,
+				struct irq_affinity_desc *masks)
+{
+	int ret = 0, i, vec_count = pci_msix_vec_count(dev);
+	struct irq_affinity_desc *curmsk;
+	struct msi_desc desc;
+	void __iomem *addr;
+
+	memset(&desc, 0, sizeof(desc));
+
+	desc.nvec_used			= 1;
+	desc.pci.msi_attrib.is_msix	= 1;
+	desc.pci.msi_attrib.is_64	= 1;
+	desc.pci.msi_attrib.default_irq	= dev->irq;
+	desc.pci.mask_base		= base;
+
+	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
 		desc.msi_index = entries ? entries[i].entry : i;
 		desc.affinity = masks ? curmsk : NULL;
 		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
@@ -599,101 +721,6 @@ out_disable:
 	return ret;
 }
 
-/**
- * pci_msi_supported - check whether MSI may be enabled on a device
- * @dev: pointer to the pci_dev data structure of MSI device function
- * @nvec: how many MSIs have been requested?
- *
- * Look at global flags, the device itself, and its parent buses
- * to determine if MSI/-X are supported for the device. If MSI/-X is
- * supported return 1, else return 0.
- **/
-static int pci_msi_supported(struct pci_dev *dev, int nvec)
-{
-	struct pci_bus *bus;
-
-	/* MSI must be globally enabled and supported by the device */
-	if (!pci_msi_enable)
-		return 0;
-
-	if (!dev || dev->no_msi)
-		return 0;
-
-	/*
-	 * You can't ask to have 0 or less MSIs configured.
-	 *  a) it's stupid ..
-	 *  b) the list manipulation code assumes nvec >= 1.
-	 */
-	if (nvec < 1)
-		return 0;
-
-	/*
-	 * Any bridge which does NOT route MSI transactions from its
-	 * secondary bus to its primary bus must set NO_MSI flag on
-	 * the secondary pci_bus.
-	 *
-	 * The NO_MSI flag can either be set directly by:
-	 * - arch-specific PCI host bus controller drivers (deprecated)
-	 * - quirks for specific PCI bridges
-	 *
-	 * or indirectly by platform-specific PCI host bridge drivers by
-	 * advertising the 'msi_domain' property, which results in
-	 * the NO_MSI flag when no MSI domain is found for this bridge
-	 * at probe time.
-	 */
-	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return 0;
-
-	return 1;
-}
-
-/**
- * pci_msi_vec_count - Return the number of MSI vectors a device can send
- * @dev: device to report about
- *
- * This function returns the number of MSI vectors a device requested via
- * Multiple Message Capable register. It returns a negative errno if the
- * device is not capable sending MSI interrupts. Otherwise, the call succeeds
- * and returns a power of two, up to a maximum of 2^5 (32), according to the
- * MSI specification.
- **/
-int pci_msi_vec_count(struct pci_dev *dev)
-{
-	int ret;
-	u16 msgctl;
-
-	if (!dev->msi_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
-	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
-
-	return ret;
-}
-EXPORT_SYMBOL(pci_msi_vec_count);
-
-void pci_msi_shutdown(struct pci_dev *dev)
-{
-	struct msi_desc *desc;
-
-	if (!pci_msi_enable || !dev || !dev->msi_enabled)
-		return;
-
-	pci_msi_set_enable(dev, 0);
-	pci_intx_for_msi(dev, 1);
-	dev->msi_enabled = 0;
-
-	/* Return the device with MSI unmasked as initial states */
-	desc = msi_first_desc(&dev->dev, MSI_DESC_ALL);
-	if (!WARN_ON_ONCE(!desc))
-		pci_msi_unmask(desc, msi_multi_mask(desc));
-
-	/* Restore dev->irq to its default pin-assertion IRQ */
-	dev->irq = desc->pci.msi_attrib.default_irq;
-	pcibios_alloc_irq(dev);
-}
-
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 			     int nvec, struct irq_affinity *affd, int flags)
 {
@@ -729,57 +756,23 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 	return msix_capability_init(dev, entries, nvec, affd);
 }
 
-void pci_msix_shutdown(struct pci_dev *dev)
-{
-	struct msi_desc *desc;
-
-	if (!pci_msi_enable || !dev || !dev->msix_enabled)
-		return;
-
-	if (pci_dev_is_disconnected(dev)) {
-		dev->msix_enabled = 0;
-		return;
-	}
-
-	/* Return the device with MSI-X masked as initial states */
-	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
-		pci_msix_mask(desc);
-
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
-	pci_intx_for_msi(dev, 1);
-	dev->msix_enabled = 0;
-	pcibios_alloc_irq(dev);
-}
-
-int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-			   struct irq_affinity *affd)
+int __pci_enable_msix_range(struct pci_dev *dev,
+			    struct msix_entry *entries, int minvec,
+			    int maxvec, struct irq_affinity *affd,
+			    int flags)
 {
-	int nvec;
-	int rc;
-
-	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
-		return -EINVAL;
-
-	/* Check whether driver already requested MSI-X IRQs */
-	if (dev->msix_enabled) {
-		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
-		return -EINVAL;
-	}
+	int rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	if (WARN_ON_ONCE(dev->msi_enabled))
+	if (dev->msi_enabled) {
+		pci_info(dev, "can't enable MSI-X (MSI already enabled)\n");
 		return -EINVAL;
+	}
 
-	nvec = pci_msi_vec_count(dev);
-	if (nvec < 0)
-		return nvec;
-	if (nvec < minvec)
-		return -ENOSPC;
-
-	if (nvec > maxvec)
-		nvec = maxvec;
+	if (WARN_ON_ONCE(dev->msix_enabled))
+		return -EINVAL;
 
 	rc = pci_setup_msi_context(dev);
 	if (rc)
@@ -792,7 +785,7 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 				return -ENOSPC;
 		}
 
-		rc = msi_capability_init(dev, nvec, affd);
+		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
 		if (rc == 0)
 			return nvec;
 
@@ -805,48 +798,68 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	}
 }
 
-int __pci_enable_msix_range(struct pci_dev *dev,
-			    struct msix_entry *entries, int minvec,
-			    int maxvec, struct irq_affinity *affd,
-			    int flags)
+void __pci_restore_msix_state(struct pci_dev *dev)
 {
-	int rc, nvec = maxvec;
+	struct msi_desc *entry;
+	bool write_msg;
 
-	if (maxvec < minvec)
-		return -ERANGE;
+	if (!dev->msix_enabled)
+		return;
 
-	if (dev->msi_enabled) {
-		pci_info(dev, "can't enable MSI-X (MSI already enabled)\n");
-		return -EINVAL;
+	/* route the table */
+	pci_intx_for_msi(dev, 0);
+	pci_msix_clear_and_set_ctrl(dev, 0,
+				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
+
+	write_msg = arch_restore_msi_irqs(dev);
+
+	msi_lock_descs(&dev->dev);
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+		if (write_msg)
+			__pci_write_msi_msg(entry, &entry->msg);
+		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
 	}
+	msi_unlock_descs(&dev->dev);
 
-	if (WARN_ON_ONCE(dev->msix_enabled))
-		return -EINVAL;
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
+}
 
-	rc = pci_setup_msi_context(dev);
-	if (rc)
-		return rc;
+void pci_msix_shutdown(struct pci_dev *dev)
+{
+	struct msi_desc *desc;
 
-	for (;;) {
-		if (affd) {
-			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
-			if (nvec < minvec)
-				return -ENOSPC;
-		}
+	if (!pci_msi_enable || !dev || !dev->msix_enabled)
+		return;
 
-		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
-		if (rc == 0)
-			return nvec;
+	if (pci_dev_is_disconnected(dev)) {
+		dev->msix_enabled = 0;
+		return;
+	}
 
-		if (rc < 0)
-			return rc;
-		if (rc < minvec)
-			return -ENOSPC;
+	/* Return the device with MSI-X masked as initial states */
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
+		pci_msix_mask(desc);
 
-		nvec = rc;
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_intx_for_msi(dev, 1);
+	dev->msix_enabled = 0;
+	pcibios_alloc_irq(dev);
+}
+
+/* Common interfaces */
+
+void pci_free_msi_irqs(struct pci_dev *dev)
+{
+	pci_msi_teardown_msi_irqs(dev);
+
+	if (dev->msix_base) {
+		iounmap(dev->msix_base);
+		dev->msix_base = NULL;
 	}
 }
 
+/* Misc. infrastructure */
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
