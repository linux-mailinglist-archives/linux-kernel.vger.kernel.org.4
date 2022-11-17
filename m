Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB762DF30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiKQPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiKQPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634BB7819C;
        Thu, 17 Nov 2022 07:08:16 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mr3m2NZDvwtvG6baiptpO+pmc2vi1+xGvYHY6P0FD5Q=;
        b=wNnrdWEJ1JqBnIeRCkr2LRuiutt2nqc8baJYfQp05feZr97u2rOUBmUspFDBCH4oLOi77R
        65Qw2WoWUc2BtL155q7p/sJCFJbe8kpQWjv3bsro02v9TDfHECKpSxNhYmCCxhl+Y1+BLE
        oB7PM40nWhJm9Jx4JK97oOEEUZWu7m0vubt+vLv017giNcQeXqrnJXWRPpIpQd4QSFRorE
        AJFe+ShjiNY2JgG8gQMDEH2DpwD4u3eb29bS9iMpNw5Xm2kc67tMDCMP2892Zb/uMlPRNE
        ChFwbqYrS4k6Nnskdft3V2InUdBg0muFwfzJ8DHo0dI8kvWgrbZBSQPUBkEFSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mr3m2NZDvwtvG6baiptpO+pmc2vi1+xGvYHY6P0FD5Q=;
        b=2Y/MJIjZa58Nbu+gEne9P/uodYMt4ZNi9A42UM+o7CtGWPsqvICUTIYwUZfx2amZWGTPUn
        4IGyM8j5GMikgTDw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move mask and unmask helpers to msi.h
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.640052354@linutronix.de>
References: <20221111122014.640052354@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769429.4906.15404794497153421507.tip-bot2@tip-bot2>
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

Commit-ID:     c93fd5266cff2afa908659c817c6aff4d5ed6283
Gitweb:        https://git.kernel.org/tip/c93fd5266cff2afa908659c817c6aff4d5ed6283
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Move mask and unmask helpers to msi.h

The upcoming support for per device MSI interrupt domains needs to share
some of the inline helpers with the MSI implementation.

Move them to the header file.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.640052354@linutronix.de


---
 drivers/pci/msi/msi.c | 61 +-------------------------------
 drivers/pci/msi/msi.h | 83 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 160af9f..5c310df 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -16,7 +16,7 @@
 static int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
-static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
+void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
 	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
 	unsigned long flags;
@@ -32,65 +32,6 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 
-static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
-{
-	pci_msi_update_mask(desc, 0, mask);
-}
-
-static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
-{
-	pci_msi_update_mask(desc, mask, 0);
-}
-
-static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
-{
-	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
-}
-
-/*
- * This internal function does not flush PCI writes to the device.  All
- * users must ensure that they read from the device before either assuming
- * that the device state is up to date, or returning out of this file.
- * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
- */
-static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
-{
-	void __iomem *desc_addr = pci_msix_desc_addr(desc);
-
-	if (desc->pci.msi_attrib.can_mask)
-		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
-}
-
-static inline void pci_msix_mask(struct msi_desc *desc)
-{
-	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
-	/* Flush write to device */
-	readl(desc->pci.mask_base);
-}
-
-static inline void pci_msix_unmask(struct msi_desc *desc)
-{
-	desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
-}
-
-static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
-{
-	if (desc->pci.msi_attrib.is_msix)
-		pci_msix_mask(desc);
-	else
-		pci_msi_mask(desc, mask);
-}
-
-static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
-{
-	if (desc->pci.msi_attrib.is_msix)
-		pci_msix_unmask(desc);
-	else
-		pci_msi_unmask(desc, mask);
-}
-
 /**
  * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
  * @data:	pointer to irqdata associated to that interrupt
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index fc92603..d8f62d9 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -8,21 +8,67 @@
 int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
 
-#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
-int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
-#else
-static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+/* Mask/unmask helpers */
+void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set);
+
+static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
 {
-	WARN_ON_ONCE(1);
-	return -ENODEV;
+	pci_msi_update_mask(desc, 0, mask);
 }
 
-static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
 {
-	WARN_ON_ONCE(1);
+	pci_msi_update_mask(desc, mask, 0);
+}
+
+static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+{
+	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
+}
+
+/*
+ * This internal function does not flush PCI writes to the device.  All
+ * users must ensure that they read from the device before either assuming
+ * that the device state is up to date, or returning out of this file.
+ * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
+ */
+static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
+{
+	void __iomem *desc_addr = pci_msix_desc_addr(desc);
+
+	if (desc->pci.msi_attrib.can_mask)
+		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+	/* Flush write to device */
+	readl(desc->pci.mask_base);
+}
+
+static inline void pci_msix_unmask(struct msi_desc *desc)
+{
+	desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (desc->pci.msi_attrib.is_msix)
+		pci_msix_mask(desc);
+	else
+		pci_msi_mask(desc, mask);
+}
+
+static inline void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (desc->pci.msi_attrib.is_msix)
+		pci_msix_unmask(desc);
+	else
+		pci_msi_unmask(desc, mask);
 }
-#endif
 
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
@@ -37,3 +83,20 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 		return 0xffffffff;
 	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
+
+/* Legacy (!IRQDOMAIN) fallbacks */
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
+int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
