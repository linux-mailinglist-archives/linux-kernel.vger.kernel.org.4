Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4844562DF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiKQPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiKQPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F97818F;
        Thu, 17 Nov 2022 07:08:14 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peJq8Ks1dEw3XWuTUsuDaZpzNCb022fzg98JsheBEA0=;
        b=K53tl4K/CgjdNQE9WUi2XoL8BGSBhN3P5brdpY8Xxp7PLsC/Vf7mTaLwQfM7Q6E4E7wdgx
        08RbhEcfV4OAWV24WRFvSNX6gPeue7OLmkyDzeDBtYx8Sck0HEuxg5hajKHc6Wyzgg1/WK
        GaPqEpG3dx3ARR1sTTf+ioXsvD6FaL+7QqKmApugj+wm0QJRIgOdjDanyHy6m0h/vNoI+u
        BrTcRds1xRxktK14uUTPCyGAApe70yYaVLTUw/nnOUkiIpvB8LWKUwa+iNhFBGT7RzmZ04
        PcILAeYQnYFy92mJN51bZeakNt9hRjEzqFgIbliiTCcG3SSIhdzDG0uyTV+tZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peJq8Ks1dEw3XWuTUsuDaZpzNCb022fzg98JsheBEA0=;
        b=XVrFIr+pAAW0IQ4q8a8zzeMiYifvFe3wa89sKStz/9GtOfggywpazY5JJbLOcX5blWHzUd
        9lisITNEgwq3DkAQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_enable_msi() API to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.755178149@linutronix.de>
References: <20221111122014.755178149@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769215.4906.1971584986944692969.tip-bot2@tip-bot2>
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

Commit-ID:     bbda3407982211123caadbfdee23594647bd4516
Gitweb:        https://git.kernel.org/tip/bbda3407982211123caadbfdee23594647bd4516
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Move pci_enable_msi() API to api.c

To disentangle the maze in msi.c all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_enable_msi() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.755178149@linutronix.de


---
 drivers/pci/msi/api.c | 23 +++++++++++++++++++++++
 drivers/pci/msi/msi.c | 14 ++------------
 drivers/pci/msi/msi.h |  1 +
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 7485942..63d7f8f 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -13,6 +13,29 @@
 #include "msi.h"
 
 /**
+ * pci_enable_msi() - Enable MSI interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to enable MSI interrupts mode on device and
+ * allocate a single interrupt vector. On success, the allocated vector
+ * Linux IRQ will be saved at @dev->irq. The driver must invoke
+ * pci_disable_msi() on cleanup.
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int pci_enable_msi(struct pci_dev *dev)
+{
+	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_msi);
+
+/**
  * pci_disable_msi() - Disable MSI interrupt mode on device
  * @dev: the PCI device to operate on
  *
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 4a1300b..98f07ad 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -790,8 +790,8 @@ void pci_disable_msix(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
-static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-				  struct irq_affinity *affd)
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
+			   struct irq_affinity *affd)
 {
 	int nvec;
 	int rc;
@@ -844,16 +844,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	}
 }
 
-/* deprecated, don't use */
-int pci_enable_msi(struct pci_dev *dev)
-{
-	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
-	if (rc < 0)
-		return rc;
-	return 0;
-}
-EXPORT_SYMBOL(pci_enable_msi);
-
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
 				   int maxvec, struct irq_affinity *affd,
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 6348792..00bb98d 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -87,6 +87,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 
 /* Legacy (!IRQDOMAIN) fallbacks */
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
