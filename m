Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60DA62DF19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiKQPJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiKQPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1287769D6;
        Thu, 17 Nov 2022 07:08:05 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hy0E4MZ6jBaGq4Jfstxom6N/KOiljZNorjKOeY3m1Ik=;
        b=aT50Ae02GBSeiKn6JOkOttAO/3VIPe489v1n1CTRIaJ+raPd5kLyRgn+C7c5Pu75YplH5Y
        qn5Dq76bzvncSDdWE7rcXi2lAniE+BgwcbDwJhqcABplMWaWIk+ml0f0Ovu+zPMl1pHKxh
        oh+3qVOlXpcHaZ8jXvOZxU4swx5Qf3pQQ5e1esSbRZvH3UkqfknuyWEqMXoCjomK4id6p/
        aPqb+vvJwyOkaCx4kOb2dYv3PX5NxFQbp5yj0H/6pvmOCv5IQ3HkCeIHIIqDCGQAXpFtIY
        q0RPnCwyLcbAThjMqfpxOfTMZVyQxM3NFxADqmI8Fh8fKNg00LkqSqm4Mh0SPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hy0E4MZ6jBaGq4Jfstxom6N/KOiljZNorjKOeY3m1Ik=;
        b=uyH0ncbzpFLQsgyaMOxwLMjy6r+etP3xJ0qjQwmf9rzVcjdtZSgoz2tD7AY8xxX1MRh4Qa
        GXjj3PB9cTTRx/CQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_irq_get_affinity() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.214792769@linutronix.de>
References: <20221111122015.214792769@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768306.4906.11479048488113384421.tip-bot2@tip-bot2>
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

Commit-ID:     be37b8428b7b7740bbbc29c17cfa2ee42b9e2d8b
Gitweb:        https://git.kernel.org/tip/be37b8428b7b7740bbbc29c17cfa2ee42b9e2d8b
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_irq_get_affinity() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_irq_get_affinity() and let its kernel-doc match rest of the
file.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.214792769@linutronix.de


---
 drivers/pci/msi/api.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/msi/msi.c | 38 +-------------------------------------
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 20a580b..93ddc55 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/irq.h>
 
 #include "msi.h"
 
@@ -251,6 +252,48 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 EXPORT_SYMBOL(pci_irq_vector);
 
 /**
+ * pci_irq_get_affinity() - Get a device interrupt vector affinity
+ * @dev: the PCI device to operate on
+ * @nr:  device-relative interrupt vector index (0-based); has different
+ *       meanings, depending on interrupt mode
+ *         MSI-X        the index in the MSI-X vector table
+ *         MSI          the index of the enabled MSI vectors
+ *         INTx         must be 0
+ *
+ * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
+ * the MSI(-X) vector was allocated without explicit affinity
+ * requirements (e.g., by pci_enable_msi(), pci_enable_msix_range(), or
+ * pci_alloc_irq_vectors() without the %PCI_IRQ_AFFINITY flag). Return a
+ * generic set of CPU IDs representing all possible CPUs available
+ * during system boot if the device is in legacy INTx mode.
+ */
+const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
+{
+	int idx, irq = pci_irq_vector(dev, nr);
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(irq <= 0))
+		return NULL;
+
+	desc = irq_get_msi_desc(irq);
+	/* Non-MSI does not have the information handy */
+	if (!desc)
+		return cpu_possible_mask;
+
+	/* MSI[X] interrupts can be allocated without affinity descriptor */
+	if (!desc->affinity)
+		return NULL;
+
+	/*
+	 * MSI has a mask array in the descriptor.
+	 * MSI-X has a single mask.
+	 */
+	idx = dev->msi_enabled ? nr : 0;
+	return &desc->affinity[idx].mask;
+}
+EXPORT_SYMBOL(pci_irq_get_affinity);
+
+/**
  * pci_free_irq_vectors() - Free previously allocated IRQs for a device
  * @dev: the PCI device to operate on
  *
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6fa90d0..d78646d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -854,44 +854,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 	}
 }
 
-/**
- * pci_irq_get_affinity - return the affinity of a particular MSI vector
- * @dev:	PCI device to operate on
- * @nr:		device-relative interrupt vector index (0-based).
- *
- * @nr has the following meanings depending on the interrupt mode:
- *   MSI-X:	The index in the MSI-X vector table
- *   MSI:	The index of the enabled MSI vectors
- *   INTx:	Must be 0
- *
- * Return: A cpumask pointer or NULL if @nr is out of range
- */
-const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
-{
-	int idx, irq = pci_irq_vector(dev, nr);
-	struct msi_desc *desc;
-
-	if (WARN_ON_ONCE(irq <= 0))
-		return NULL;
-
-	desc = irq_get_msi_desc(irq);
-	/* Non-MSI does not have the information handy */
-	if (!desc)
-		return cpu_possible_mask;
-
-	/* MSI[X] interrupts can be allocated without affinity descriptor */
-	if (!desc->affinity)
-		return NULL;
-
-	/*
-	 * MSI has a mask array in the descriptor.
-	 * MSI-X has a single mask.
-	 */
-	idx = dev->msi_enabled ? nr : 0;
-	return &desc->affinity[idx].mask;
-}
-EXPORT_SYMBOL(pci_irq_get_affinity);
-
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
