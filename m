Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E144562DF20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiKQPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiKQPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AF769F5;
        Thu, 17 Nov 2022 07:08:09 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZjMnWePQEtbMBFxB0ie29NpXUSaoI74i/VpN4xx1V8=;
        b=yurlAnIuT4mfgpDwqKwuVGw5zQDjH7Yjb7vkOgAEc++ppuvS7CPrTsode2KE9FESDNGEDF
        TJe3BSPJ3W4ynH+w+J16G4AQH8Huu4yiWGWQ0gBD7dgldmGm+YGmzOY2LXImKKv+AjYd9O
        Skvx2TxE3oqq6N9tmh5ZZZhHd4Uo0Icz0iqqB3xLyGdQuwBZXW20XyTiN2iAr3Wc+iOO0p
        mbxZQMeRKC9DcLtGh6XFgL2yFZq/DSPB4764+3BqW5maVEFZjIzB+hpgcNh7UhmsYq3+/0
        JkFs7VZjLBHrPJWz5C/XGOVpB1SR5EV0rfFb7Vn9/qhVQO7KVMmnO7eQfO2NDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZjMnWePQEtbMBFxB0ie29NpXUSaoI74i/VpN4xx1V8=;
        b=gwEw2vKmRaojPFc8vXKkyNWRX8LW0q/QpWnzLcgZEPYEsIWB1GUreYVQZeH2jbZnNpLf06
        H+wdtgRjRFfRtaBw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_free_irq_vectors() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.042870570@linutronix.de>
References: <20221111122015.042870570@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768653.4906.6407407753277072388.tip-bot2@tip-bot2>
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

Commit-ID:     059f778d66ba88e1acad89a46cfb35eb8703feef
Gitweb:        https://git.kernel.org/tip/059f778d66ba88e1acad89a46cfb35eb8703feef
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_free_irq_vectors() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_free_irq_vectors() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.042870570@linutronix.de


---
 drivers/pci/msi/api.c | 15 +++++++++++++++
 drivers/pci/msi/msi.c | 13 -------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 0f1ec87..2ff2a9c 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -205,3 +205,18 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
+
+/**
+ * pci_free_irq_vectors() - Free previously allocated IRQs for a device
+ * @dev: the PCI device to operate on
+ *
+ * Undo the interrupt vector allocations and possible device MSI/MSI-X
+ * enablement earlier done through pci_alloc_irq_vectors_affinity() or
+ * pci_alloc_irq_vectors().
+ */
+void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	pci_disable_msix(dev);
+	pci_disable_msi(dev);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 38ad2fe..ed8caf5 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -887,19 +887,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 }
 
 /**
- * pci_free_irq_vectors - free previously allocated IRQs for a device
- * @dev:		PCI device to operate on
- *
- * Undoes the allocations and enabling in pci_alloc_irq_vectors().
- */
-void pci_free_irq_vectors(struct pci_dev *dev)
-{
-	pci_disable_msix(dev);
-	pci_disable_msi(dev);
-}
-EXPORT_SYMBOL(pci_free_irq_vectors);
-
-/**
  * pci_irq_get_affinity - return the affinity of a particular MSI vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).
