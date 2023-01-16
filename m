Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D066CFAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjAPTnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjAPTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:43:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E452B638;
        Mon, 16 Jan 2023 11:43:27 -0800 (PST)
Date:   Mon, 16 Jan 2023 19:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673898206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yivz0yGHpuFw1Nb83xWznhX3sQ8SnxbpXgvCv3wBb1A=;
        b=Jiz6sB8vxnmgcQuR8YAemKRpB/3+9FWUODDCk5njZi/Sl4XgHBO9TpyduRUzun5FIwkb3I
        CWSmQyx2xOhSd1p9OQ7gCyNomFvMSO15Zn5yPxDXVT9ItGD7wjTepWA0JBnz3HLCcnG3KW
        37EYe02F/jU36s99Wq1nJcw/Y/ckpOFkL/+Vwzi2npB153zedHP8Kjp/CCtHmT924XV/77
        VIP+jucueTR+Wh8drSM/gu2GfDqfVcRdf/DcK3CTbSFY/Q6Pj9aPFsU83lEYP76cWYRALt
        VIbu0ksKGkZa17O3zHtFbMhZ2x7VAoiLRnMgumUm3ezF73KVzbABajVF8qe+lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673898206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yivz0yGHpuFw1Nb83xWznhX3sQ8SnxbpXgvCv3wBb1A=;
        b=uKeVYlf+rToDffqmSuuarCGhr96xMa9Un2mCLTn8Euq57YmUug44+WZ2++lNTtDAhATnJx
        F/t7NKkCIuiPCaBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pci/xen: Fixup fallout from the PCI/MSI overhaul
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <871qnunycr.ffs@tglx>
References: <871qnunycr.ffs@tglx>
MIME-Version: 1.0
Message-ID: <167389820565.4906.13957061566790292505.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6c796996ee7033bcbbc3cd733513eb43f8160f5e
Gitweb:        https://git.kernel.org/tip/6c796996ee7033bcbbc3cd733513eb43f8160f5e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 16 Jan 2023 19:11:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Jan 2023 20:40:44 +01:00

x86/pci/xen: Fixup fallout from the PCI/MSI overhaul

David reported that the recent PCI/MSI rework results in MSI descriptor
leakage under XEN.

This is caused by:

  1) The missing MSI_FLAG_FREE_MSI_DESCS flag in the XEN MSI domain info,
     which is required now that PCI/MSI delegates descriptor freeing to
     the core MSI code.

  2) Not disassociating the interrupts on teardown, by setting the
     msi_desc::irq to 0. This was not required before because the teardown
     was unconditional and did not check whether a MSI descriptor was still
     connected to a Linux interrupt.

On further inspection it came to light that the MSI_FLAG_DEV_SYSFS is
missing in the XEN MSI domain info as well to restore the pre 6.2 status
quo.

Add the missing MSI flags and disassociate the MSI descriptor from the
Linux interrupt in the XEN specific teardown function.

Fixes: b2bdda205c0c ("PCI/MSI: Let the MSI core free descriptors")
Fixes: 2f2940d16823 ("genirq/msi: Remove filter from msi_free_descs_free_range()")
Fixes: ffd84485e6be ("PCI/MSI: Let the irq code handle sysfs groups")
Reported-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/871qnunycr.ffs@tglx
---
 arch/x86/pci/xen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 7905504..8babce7 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -392,6 +392,7 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_ASSOCIATED) {
 		for (i = 0; i < msidesc->nvec_used; i++)
 			xen_destroy_irq(msidesc->irq + i);
+		msidesc->irq = 0;
 	}
 }
 
@@ -433,7 +434,7 @@ static struct msi_domain_ops xen_pci_msi_domain_ops = {
 };
 
 static struct msi_domain_info xen_pci_msi_domain_info = {
-	.flags			= MSI_FLAG_PCI_MSIX,
+	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
 	.ops			= &xen_pci_msi_domain_ops,
 };
 
