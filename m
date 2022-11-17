Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA61A62DF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiKQPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbiKQPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051F769FD;
        Thu, 17 Nov 2022 07:08:07 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIXi7qlf2sjL+XQchJkYJMSc/35mijKkna5of7IdO2M=;
        b=L0DiCIdhq364+BfXGz5Ilv4wH+d3uQjhf8jgSTu2W0AFCWXyFSKZOCWu5xxyIxNU2rJxIp
        EhGYmOvmbW1J4W/EX5ncj1ozBFobYzSXtHSbLrdAadq1xdeYe29JQDmMvStPrgf+CSqYFd
        aDPj4DGxKDYUNBIXweKXCecO2SED6l3I98ApTN/OA1PuxLuLNf7IIld9t0yr3n/3IglbaR
        sy4Yfv/Yfat7wvXeBLcSlwa0p/kcLV7kJH3Z6jqROcf/JRF8jU06C4NfVB14lbk0VSu0jt
        +HJLNERFyomXRDdIQt293GNVCrTPamGuoAkxOqWUK+FuaheyrsohRx+851RiVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIXi7qlf2sjL+XQchJkYJMSc/35mijKkna5of7IdO2M=;
        b=gwRK05bbh/GHlZJdlT0s4E9CdXMTEmw7r8G1crMxoXNqi1sGdNKjTf2HeaiRqfQN1wIdWK
        d8f0BJUDFfUIpEAg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_disable_msix() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.156785224@linutronix.de>
References: <20221111122015.156785224@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768420.4906.2668705686163796794.tip-bot2@tip-bot2>
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

Commit-ID:     18e1926b8c8b7c2249c24057d5f836c578e29f08
Gitweb:        https://git.kernel.org/tip/18e1926b8c8b7c2249c24057d5f836c578e29f08
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_disable_msix() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_disable_msix() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.156785224@linutronix.de


---
 drivers/pci/msi/api.c | 24 ++++++++++++++++++++++++
 drivers/pci/msi/msi.c | 14 +-------------
 drivers/pci/msi/msi.h |  1 +
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 83ea38f..20a580b 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -112,6 +112,30 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 EXPORT_SYMBOL(pci_enable_msix_range);
 
 /**
+ * pci_disable_msix() - Disable MSI-X interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to disable MSI-X interrupt mode on device,
+ * free earlier-allocated interrupt vectors, and restore INTx.
+ * The PCI device Linux IRQ (@dev->irq) is restored to its default pin
+ * assertion IRQ. This is the cleanup pair of pci_enable_msix_range().
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ */
+void pci_disable_msix(struct pci_dev *dev)
+{
+	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
+		return;
+
+	msi_lock_descs(&dev->dev);
+	pci_msix_shutdown(dev);
+	pci_free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
+}
+EXPORT_SYMBOL(pci_disable_msix);
+
+/**
  * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
  * @dev:      the PCI device to operate on
  * @min_vecs: minimum required number of vectors (must be >= 1)
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 1226d66..6fa90d0 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -736,7 +736,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 	return msix_capability_init(dev, entries, nvec, affd);
 }
 
-static void pci_msix_shutdown(struct pci_dev *dev)
+void pci_msix_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
 
@@ -758,18 +758,6 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	pcibios_alloc_irq(dev);
 }
 
-void pci_disable_msix(struct pci_dev *dev)
-{
-	if (!pci_msi_enable || !dev || !dev->msix_enabled)
-		return;
-
-	msi_lock_descs(&dev->dev);
-	pci_msix_shutdown(dev);
-	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
-}
-EXPORT_SYMBOL(pci_disable_msix);
-
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 			   struct irq_affinity *affd)
 {
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 8c4a528..77e2587 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -86,6 +86,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
+void pci_msix_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
