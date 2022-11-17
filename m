Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961462DF23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiKQPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiKQPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C778180;
        Thu, 17 Nov 2022 07:08:11 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wLikxPegdXcM/ihdJAq8N4YWgzWp3+cQYujDgWm1vk=;
        b=LQnSdkmWNjGgtN1YqszBxPtrfUqJEXU/l+WlYxvHBqf8P66KqsoYAsNgXzIQNRpzlSALGh
        ycyApnsfF6opGuMXL/ZsmewFfVMH8atPhGU3lw24lp7DzFzOd09LhmRQxgR2vOPZWatxCd
        ZM49hhWYOXHyVLIn/ZGFMMhlW5vYr/wHi2i/RL2zGwEwnQ8NeRoaIroLiVkW1oeEPwrjeS
        2FE/WVQy/jRHtl5jmVvnEIrnglFg9P6VYuMKDCEhenXTSm+6H/rIvj6BJAeQuAb2WM8MRO
        gPe146cWpFxxW4mKSapQqHgSAK4Krw1GCaDhJF+iS8VC0oU6T+2QX4KsQaVxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wLikxPegdXcM/ihdJAq8N4YWgzWp3+cQYujDgWm1vk=;
        b=/DFEiTWscUp2hLrydV6DX6OeBj4PQMJHG0LTBGqHi7z3FhsOsYxPylEr7Q50fV1OdAQSCP
        mfIvDPWBCRZnNRCQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.927531290@linutronix.de>
References: <20221111122014.927531290@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768882.4906.7231729097327796389.tip-bot2@tip-bot2>
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

Commit-ID:     beddb5efb43ee5b1c048e49225f75b03f8d36aac
Gitweb:        https://git.kernel.org/tip/beddb5efb43ee5b1c048e49225f75b03f8d36aac
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Move pci_alloc_irq_vectors_affinity() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_alloc_irq_vectors_affinity() and let its kernel-doc reference
pci_alloc_irq_vectors() documentation added in parent commit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.927531290@linutronix.de


---
 drivers/pci/msi/api.c | 59 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/msi/msi.c | 65 +------------------------------------------
 2 files changed, 59 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 1714905..8546749 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -123,3 +123,62 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+/**
+ * pci_alloc_irq_vectors_affinity() - Allocate multiple device interrupt
+ *                                    vectors with affinity requirements
+ * @dev:      the PCI device to operate on
+ * @min_vecs: minimum required number of vectors (must be >= 1)
+ * @max_vecs: maximum desired number of vectors
+ * @flags:    allocation flags, as in pci_alloc_irq_vectors()
+ * @affd:     affinity requirements (can be %NULL).
+ *
+ * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
+ * Check that function docs, and &struct irq_affinity, for more details.
+ */
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd)
+{
+	struct irq_affinity msi_default_affd = {0};
+	int nvecs = -ENOSPC;
+
+	if (flags & PCI_IRQ_AFFINITY) {
+		if (!affd)
+			affd = &msi_default_affd;
+	} else {
+		if (WARN_ON(affd))
+			affd = NULL;
+	}
+
+	if (flags & PCI_IRQ_MSIX) {
+		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
+						affd, flags);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	if (flags & PCI_IRQ_MSI) {
+		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	/* use legacy IRQ if allowed */
+	if (flags & PCI_IRQ_LEGACY) {
+		if (min_vecs == 1 && dev->irq) {
+			/*
+			 * Invoke the affinity spreading logic to ensure that
+			 * the device driver can adjust queue configuration
+			 * for the single interrupt case.
+			 */
+			if (affd)
+				irq_create_affinity_masks(1, affd);
+			pci_intx(dev, 1);
+			return 1;
+		}
+	}
+
+	return nvecs;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6700ef1..a028774 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -887,71 +887,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 }
 
 /**
- * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
- * @dev:		PCI device to operate on
- * @min_vecs:		minimum number of vectors required (must be >= 1)
- * @max_vecs:		maximum (desired) number of vectors
- * @flags:		flags or quirks for the allocation
- * @affd:		optional description of the affinity requirements
- *
- * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
- * vectors if available, and fall back to a single legacy vector
- * if neither is available.  Return the number of vectors allocated,
- * (which might be smaller than @max_vecs) if successful, or a negative
- * error code on error. If less than @min_vecs interrupt vectors are
- * available for @dev the function will fail with -ENOSPC.
- *
- * To get the Linux IRQ number used for a vector that can be passed to
- * request_irq() use the pci_irq_vector() helper.
- */
-int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
-				   unsigned int max_vecs, unsigned int flags,
-				   struct irq_affinity *affd)
-{
-	struct irq_affinity msi_default_affd = {0};
-	int nvecs = -ENOSPC;
-
-	if (flags & PCI_IRQ_AFFINITY) {
-		if (!affd)
-			affd = &msi_default_affd;
-	} else {
-		if (WARN_ON(affd))
-			affd = NULL;
-	}
-
-	if (flags & PCI_IRQ_MSIX) {
-		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-						affd, flags);
-		if (nvecs > 0)
-			return nvecs;
-	}
-
-	if (flags & PCI_IRQ_MSI) {
-		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
-		if (nvecs > 0)
-			return nvecs;
-	}
-
-	/* use legacy IRQ if allowed */
-	if (flags & PCI_IRQ_LEGACY) {
-		if (min_vecs == 1 && dev->irq) {
-			/*
-			 * Invoke the affinity spreading logic to ensure that
-			 * the device driver can adjust queue configuration
-			 * for the single interrupt case.
-			 */
-			if (affd)
-				irq_create_affinity_masks(1, affd);
-			pci_intx(dev, 1);
-			return 1;
-		}
-	}
-
-	return nvecs;
-}
-EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
-
-/**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
  * @dev:		PCI device to operate on
  *
