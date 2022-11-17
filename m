Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14C62DF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiKQPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiKQPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA1C74CD3;
        Thu, 17 Nov 2022 07:08:00 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNMZbiEYQH9X4IQCzLRwhDqmPwiMGrE/kmQ0eUwzr5Q=;
        b=ZTHUUbWZlxpfHhDzESjRF5g4LMT8jhwxTgSjrqSpiVooUC6hTykT7mXg/PaCtsHFBaEhJp
        E7wgysyMlMYVKvSpvwq5SfC9yeMaCD6QFl9/frhjJluKnOtVU6/LYTTbUszRavi2Kj7OeT
        1iie5SlTde10skY+w2XNi5j0Uj8zRggQe7rqd13rsRPn7g2Cb5q7PR/UBs3j7G96AlbwvO
        +7FXkt3zeEg3KnyKxBX5XaJMRPip0GKCyjQ1LyI09uInxRaHs7gdb1VrIP/F0R31JEYRqq
        cBZMdJ5IkCu0eHQR8p4y/mr12doJN6lJKePafugf7Fv8uV229BPxaeR3C/j2ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNMZbiEYQH9X4IQCzLRwhDqmPwiMGrE/kmQ0eUwzr5Q=;
        b=WZf+X5rALrAG7TWFYECZr+LLv59kFf/1c2UhjNIPYgMJRxwdI+cxuK3TtQenCQO9H4J6Ge
        9LjlLWpzdsl+EPBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Sanitize MSI-X checks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.516946468@linutronix.de>
References: <20221111122015.516946468@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767748.4906.3113945352157433278.tip-bot2@tip-bot2>
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

Commit-ID:     bab65e48cb064d67b488efb6888c06fd977a8245
Gitweb:        https://git.kernel.org/tip/bab65e48cb064d67b488efb6888c06fd977a8245
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

PCI/MSI: Sanitize MSI-X checks

There is no point in doing the same sanity checks over and over in a loop
during MSI-X enablement. Put them in front of the loop and return early
when they fail.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.516946468@linutronix.de

---
 drivers/pci/msi/msi.c | 65 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 380e651..794ec97 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -721,47 +721,31 @@ out_disable:
 	return ret;
 }
 
-static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, struct irq_affinity *affd, int flags)
+static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int hwsize)
 {
-	int nr_entries;
 	int i, j;
 
-	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
-		return -EINVAL;
+	if (!entries)
+		return true;
 
-	nr_entries = pci_msix_vec_count(dev);
-	if (nr_entries < 0)
-		return nr_entries;
-	if (nvec > nr_entries && !(flags & PCI_IRQ_VIRTUAL))
-		return nr_entries;
+	for (i = 0; i < nvec; i++) {
+		/* Entry within hardware limit? */
+		if (entries[i].entry >= hwsize)
+			return false;
 
-	if (entries) {
-		/* Check for any invalid entries */
-		for (i = 0; i < nvec; i++) {
-			if (entries[i].entry >= nr_entries)
-				return -EINVAL;		/* invalid entry */
-			for (j = i + 1; j < nvec; j++) {
-				if (entries[i].entry == entries[j].entry)
-					return -EINVAL;	/* duplicate entry */
-			}
+		/* Check for duplicate entries */
+		for (j = i + 1; j < nvec; j++) {
+			if (entries[i].entry == entries[j].entry)
+				return false;
 		}
 	}
-
-	/* Check whether driver already requested for MSI IRQ */
-	if (dev->msi_enabled) {
-		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
-		return -EINVAL;
-	}
-	return msix_capability_init(dev, entries, nvec, affd);
+	return true;
 }
 
-int __pci_enable_msix_range(struct pci_dev *dev,
-			    struct msix_entry *entries, int minvec,
-			    int maxvec, struct irq_affinity *affd,
-			    int flags)
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
+			    int maxvec, struct irq_affinity *affd, int flags)
 {
-	int rc, nvec = maxvec;
+	int hwsize, rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
@@ -774,6 +758,23 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
+	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	hwsize = pci_msix_vec_count(dev);
+	if (hwsize < 0)
+		return hwsize;
+
+	if (!pci_msix_validate_entries(entries, nvec, hwsize))
+		return -EINVAL;
+
+	/* PCI_IRQ_VIRTUAL is a horrible hack! */
+	if (nvec > hwsize && !(flags & PCI_IRQ_VIRTUAL))
+		nvec = hwsize;
+
+	if (nvec < minvec)
+		return -ENOSPC;
+
 	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
@@ -785,7 +786,7 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
+		rc = msix_capability_init(dev, entries, nvec, affd);
 		if (rc == 0)
 			return nvec;
 
