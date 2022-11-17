Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327B62DF21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiKQPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiKQPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389678183;
        Thu, 17 Nov 2022 07:08:10 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xamiVN6rdjVmmUq9ItI2dWlOuwoZZx7ivCh4DhuLGQ=;
        b=awe/BtJX/P14nLiQHKo7ILknRdpc0YW7GD0Po00TGvr03ByqV/ussdF4ZCiwrkUmO3lR42
        /pcmOY/rYeGbFMll4Ihqq5b9K6DhdO8tG6IMo6MQsYc3KU1P0E1bHfYBriY9WJRIsB+lxC
        GArJXBIpLBTmH7uzlVd+ZgtsqRFV6FxIeNMLtIfo3rNiOiuyVWNyIGeRUrVoy+Xrj8Htg/
        z5gjKRCrAohZ6dA1GWwmvorGsv9VWLhDwqdUrrkiVUZfCWckYxPfCk9PADddZXI9Zwuaqe
        rKyq99W9Jj2hW2QaKl3mwCCo2AWUv+f8HwhJkICr7Pf9xctFUHZ3oeYuqYYN4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xamiVN6rdjVmmUq9ItI2dWlOuwoZZx7ivCh4DhuLGQ=;
        b=S/JAb82uRaNZQoP8+sbotQ2hvAGdskC3XDDmhzGfh7Iv/AwNCbw7X3fPWAgrRvUxI6dLoP
        GbquAug3HURMRfBQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_irq_vector() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.984490384@linutronix.de>
References: <20221111122014.984490384@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768767.4906.17637889018493385153.tip-bot2@tip-bot2>
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

Commit-ID:     017239c8db209307d2acfc0f9a3b104c39f911b3
Gitweb:        https://git.kernel.org/tip/017239c8db209307d2acfc0f9a3b104c39f911b3
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_irq_vector() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_irq_vector() and let its kernel-doc match the rest of the file.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.984490384@linutronix.de


---
 drivers/pci/msi/api.c | 23 +++++++++++++++++++++++
 drivers/pci/msi/msi.c | 24 ------------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 8546749..0f1ec87 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -182,3 +182,26 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	return nvecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+
+/**
+ * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
+ * @dev: the PCI device to operate on
+ * @nr:  device-relative interrupt vector index (0-based); has different
+ *       meanings, depending on interrupt mode
+ *         MSI-X        the index in the MSI-X vector table
+ *         MSI          the index of the enabled MSI vectors
+ *         INTx         must be 0
+ *
+ * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
+ */
+int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
+{
+	unsigned int irq;
+
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
+
+	irq = msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
+}
+EXPORT_SYMBOL(pci_irq_vector);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index a028774..38ad2fe 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -900,30 +900,6 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_free_irq_vectors);
 
 /**
- * pci_irq_vector - return Linux IRQ number of a device vector
- * @dev:	PCI device to operate on
- * @nr:		Interrupt vector index (0-based)
- *
- * @nr has the following meanings depending on the interrupt mode:
- *   MSI-X:	The index in the MSI-X vector table
- *   MSI:	The index of the enabled MSI vectors
- *   INTx:	Must be 0
- *
- * Return: The Linux interrupt number or -EINVAl if @nr is out of range.
- */
-int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
-{
-	unsigned int irq;
-
-	if (!dev->msi_enabled && !dev->msix_enabled)
-		return !nr ? dev->irq : -EINVAL;
-
-	irq = msi_get_virq(&dev->dev, nr);
-	return irq ? irq : -EINVAL;
-}
-EXPORT_SYMBOL(pci_irq_vector);
-
-/**
  * pci_irq_get_affinity - return the affinity of a particular MSI vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).
