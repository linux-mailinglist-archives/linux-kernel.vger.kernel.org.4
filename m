Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E462DF17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiKQPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiKQPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C3769D1;
        Thu, 17 Nov 2022 07:08:03 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2kBJebQj7kIYpQvHl0FnIhQc0TUB05J3PiocqV+L+k=;
        b=JdO0xiH8aU60GSUSfRpO1N3pJ4segIpRWv7ic3+gPWOJj/g4RwR3d76m9np0GGuTST6FUH
        4rINq0y7CpmOPqtufir8u0bRH4e/ZSs0wfarFMlTfgVZ10zimadsrEmaeA7tt7ee2n460e
        iyfqhS7yWO/Wwb/agW/T1TMIgTJuRQJVKt4hF2379Ewfbapb3g1I8hj2O+8YAEGHPnT/s2
        hk5Q5TZZSlLc+IJ2pAeqMECCQO9bjxZ4DZjnTWeYDsiEgqIQ7SgQfQ5QVZFr0ef6ZTMHlj
        Nqom3EiwgP/qcL3XfBWUxB5EcmGc6O5LTSDPmBzarFGR+9bF4lTD+vgUAlSR2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2kBJebQj7kIYpQvHl0FnIhQc0TUB05J3PiocqV+L+k=;
        b=3KeZgJq+UDYBTy/jKfciyZo72khebD9uAzeV/216vtoz4wG4uB9gj+b4OyKejHDEhpxZIh
        QO11fxfsF5jOxyAw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_msi_restore_state() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.331584998@linutronix.de>
References: <20221111122015.331584998@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768083.4906.11598878615645361438.tip-bot2@tip-bot2>
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

Commit-ID:     57127da98bc87688324cc2d29927b340d7754701
Gitweb:        https://git.kernel.org/tip/57127da98bc87688324cc2d29927b340d7754701
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_msi_restore_state() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.
    
Move pci_msi_enabled() and add kernel-doc for the function.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.331584998@linutronix.de


---
 drivers/pci/msi/api.c | 15 +++++++++++++++
 drivers/pci/msi/msi.c | 11 ++---------
 drivers/pci/msi/msi.h |  2 ++
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 49ae3a3..6c3ad48 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -309,6 +309,21 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_free_irq_vectors);
 
 /**
+ * pci_restore_msi_state() - Restore cached MSI(-X) state on device
+ * @dev: the PCI device to operate on
+ *
+ * Write the Linux-cached MSI(-X) state back on device. This is
+ * typically useful upon system resume, or after an error-recovery PCI
+ * adapter reset.
+ */
+void pci_restore_msi_state(struct pci_dev *dev)
+{
+	__pci_restore_msi_state(dev);
+	__pci_restore_msix_state(dev);
+}
+EXPORT_SYMBOL_GPL(pci_restore_msi_state);
+
+/**
  * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
  *
  * Return: true if MSI has not been globally disabled through ACPI FADT,
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 59c33bc..a5d168c 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -199,7 +199,7 @@ bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return true;
 }
 
-static void __pci_restore_msi_state(struct pci_dev *dev)
+void __pci_restore_msi_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	u16 control;
@@ -231,7 +231,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
 	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
 }
 
-static void __pci_restore_msix_state(struct pci_dev *dev)
+void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	bool write_msg;
@@ -257,13 +257,6 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
-void pci_restore_msi_state(struct pci_dev *dev)
-{
-	__pci_restore_msi_state(dev);
-	__pci_restore_msix_state(dev);
-}
-EXPORT_SYMBOL_GPL(pci_restore_msi_state);
-
 static void pcim_msi_release(void *pcidev)
 {
 	struct pci_dev *dev = pcidev;
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index f3f4ede..8170ef2 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -94,6 +94,8 @@ void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
 			    int maxvec,  struct irq_affinity *affd, int flags);
+void __pci_restore_msi_state(struct pci_dev *dev);
+void __pci_restore_msix_state(struct pci_dev *dev);
 
 /* Legacy (!IRQDOMAIN) fallbacks */
 
