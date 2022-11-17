Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B962DF25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiKQPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiKQPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D63E7818E;
        Thu, 17 Nov 2022 07:08:12 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRoTJJ8dM3yOguRGoxKI7R7uM7nh9vP2NcFmiPHiqD0=;
        b=XRl/jWSTF9Vxg8kc2CfRJnub9A/+zV9ujVUXQAu4DMtMbrp7hZ0jJfUYYVv/yYExxJo5EN
        2mLB557WS21lFFrkjGDGsgr+eCZXHml4y/7kVOuA4ixe5NpP71MJoE1wDLKRzW+jycPt6m
        QCnjvUn7hdThu8W3FNBOkcmFGhjoCZqPWzACXujtX+2QzyFREjeFXzy6Q5OscI2UUP07ha
        hSR/W1Q02tmgLp/l775FELzfkYc5oOS9pD0z8/tNmgjfTNkE48z9CWmu24uDKUn69Pgg8X
        BCpT3j2PgPeQ3diQwHsljH+S1KChqUPOPwyx0XRla84lwouhxYrUAcCLqj03Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRoTJJ8dM3yOguRGoxKI7R7uM7nh9vP2NcFmiPHiqD0=;
        b=Zg69COPdqEIRXnVkSNQ0kQ8y1cOZijm5WGP2vcjdyHx2yMd451Rzkt/RCCckNZ/WiKC1Nf
        m+54xWJwlytPZ4Dw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_alloc_irq_vectors() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.870888193@linutronix.de>
References: <20221111122014.870888193@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768997.4906.10468352470672453485.tip-bot2@tip-bot2>
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

Commit-ID:     5c0997dc33ac24b7dc0124c2fc1caa37ae39461a
Gitweb:        https://git.kernel.org/tip/5c0997dc33ac24b7dc0124c2fc1caa37ae39461a
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Move pci_alloc_irq_vectors() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Make pci_alloc_irq_vectors() a real function instead of wrapper and add
proper kernel doc to it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.870888193@linutronix.de


---
 drivers/pci/msi/api.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/pci.h   | 15 +++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index d480505..1714905 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -90,3 +90,36 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
+
+/**
+ * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
+ * @dev:      the PCI device to operate on
+ * @min_vecs: minimum required number of vectors (must be >= 1)
+ * @max_vecs: maximum desired number of vectors
+ * @flags:    One or more of:
+ *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
+ *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
+ *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
+ *                               and only if @min_vecs == 1
+ *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
+ *                               the vectors around available CPUs
+ *
+ * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
+ * vector allocation has a higher precedence over plain MSI, which has a
+ * higher precedence over legacy INTx emulation.
+ *
+ * Upon a successful allocation, the caller should use pci_irq_vector()
+ * to get the Linux IRQ number to be passed to request_threaded_irq().
+ * The driver must call pci_free_irq_vectors() on cleanup.
+ *
+ * Return: number of allocated vectors (which might be smaller than
+ * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
+ * available, other errnos otherwise.
+ */
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4..243e48f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1553,6 +1553,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags);
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
@@ -1586,6 +1588,13 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		return 1;
 	return -ENOSPC;
 }
+static inline int
+pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		      unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
 
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
@@ -1898,15 +1907,13 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 {
 	return -ENOSPC;
 }
-#endif /* CONFIG_PCI */
-
 static inline int
 pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		      unsigned int max_vecs, unsigned int flags)
 {
-	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
-					      NULL);
+	return -ENOSPC;
 }
+#endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
 
