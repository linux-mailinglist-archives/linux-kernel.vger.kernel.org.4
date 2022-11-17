Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3156662DF28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiKQPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbiKQPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B57818A;
        Thu, 17 Nov 2022 07:08:13 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8fznCxP69SuETyZQr8yT0c6IRwKcMNYv4criYjZ8wY=;
        b=S2yPESZyE0llRuqtDeRhcnn5iF89KHEbZ3r5n+IdltXV7IwQKhDi+1gAJfuo7WxJaVkiyD
        cxRjxO7YWVJ+0miNAfFeybLkNeShEgu6odNkCOkDE4EvT2BBunbPBCa0f5g5wk6+SkL4lu
        BNEshV26jWJk8uCde5auMHF+Wb792ot02TslWZgzJPZKKVtfikIfaUrj3GpFTjpMeIi6mt
        QsNsaSyUUc8OkGjF1BB2l9BAZ/SkmZqX8ypH3qluvD55KwMvC0GjChGmqLHA+0WAtjU8Wr
        /ZjimohHSzNfEW3E5KQ7f4xfJQHwa213myKqnPDoI1mkC3Phte9yICdChvgUwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8fznCxP69SuETyZQr8yT0c6IRwKcMNYv4criYjZ8wY=;
        b=9bl+jeNZbz3m6/rr7LNNwluoyrRwM6VKrue/uT86ioHU+CnykZGcX+JP4Y3yc3ENgOBeGp
        8xe79xTQmfoIXoDw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_enable_msix_range() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.813792885@linutronix.de>
References: <20221111122014.813792885@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769108.4906.5050605228102293608.tip-bot2@tip-bot2>
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

Commit-ID:     be7496c1ef47e1ba8c4b389ee23178fcf066cc4e
Gitweb:        https://git.kernel.org/tip/be7496c1ef47e1ba8c4b389ee23178fcf066cc4e
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Move pci_enable_msix_range() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_enable_msix_range() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.813792885@linutronix.de


---
 drivers/pci/msi/api.c | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/msi/msi.c | 30 ++++--------------------------
 drivers/pci/msi/msi.h |  3 +++
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 63d7f8f..d480505 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -58,3 +58,35 @@ void pci_disable_msi(struct pci_dev *dev)
 	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
+
+/**
+ * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
+ * @dev:     the PCI device to operate on
+ * @entries: input/output parameter, array of MSI-X configuration entries
+ * @minvec:  minimum required number of MSI-X vectors
+ * @maxvec:  maximum desired number of MSI-X vectors
+ *
+ * Legacy device driver API to enable MSI-X interrupt mode on device and
+ * configure its MSI-X capability structure as appropriate.  The passed
+ * @entries array must have each of its members "entry" field set to a
+ * desired (valid) MSI-X vector number, where the range of valid MSI-X
+ * vector numbers can be queried through pci_msix_vec_count().  If
+ * successful, the driver must invoke pci_disable_msix() on cleanup.
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ *
+ * Return: number of MSI-X vectors allocated (which might be smaller
+ * than @maxvecs), where Linux IRQ numbers for such allocated vectors
+ * are saved back in the @entries array elements' "vector" field. Return
+ * -ENOSPC if less than @minvecs interrupt vectors are available.
+ * Return -EINVAL if one of the passed @entries members "entry" field
+ * was invalid or a duplicate, or if plain MSI interrupts mode was
+ * earlier enabled on device. Return other errnos otherwise.
+ */
+int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			  int minvec, int maxvec)
+{
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
+}
+EXPORT_SYMBOL(pci_enable_msix_range);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 98f07ad..6700ef1 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -844,10 +844,10 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	}
 }
 
-static int __pci_enable_msix_range(struct pci_dev *dev,
-				   struct msix_entry *entries, int minvec,
-				   int maxvec, struct irq_affinity *affd,
-				   int flags)
+int __pci_enable_msix_range(struct pci_dev *dev,
+			    struct msix_entry *entries, int minvec,
+			    int maxvec, struct irq_affinity *affd,
+			    int flags)
 {
 	int rc, nvec = maxvec;
 
@@ -887,28 +887,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 }
 
 /**
- * pci_enable_msix_range - configure device's MSI-X capability structure
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @entries: pointer to an array of MSI-X entries
- * @minvec: minimum number of MSI-X IRQs requested
- * @maxvec: maximum number of MSI-X IRQs requested
- *
- * Setup the MSI-X capability structure of device function with a maximum
- * possible number of interrupts in the range between @minvec and @maxvec
- * upon its software driver call to request for MSI-X mode enabled on its
- * hardware device function. It returns a negative errno if an error occurs.
- * If it succeeds, it returns the actual number of interrupts allocated and
- * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X interrupts.
- **/
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-		int minvec, int maxvec)
-{
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
-}
-EXPORT_SYMBOL(pci_enable_msix_range);
-
-/**
  * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
  * @dev:		PCI device to operate on
  * @min_vecs:		minimum number of vectors required (must be >= 1)
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 00bb98d..8c4a528 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -88,8 +88,11 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
+			    int maxvec,  struct irq_affinity *affd, int flags);
 
 /* Legacy (!IRQDOMAIN) fallbacks */
+
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
