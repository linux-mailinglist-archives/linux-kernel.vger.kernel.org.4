Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36143643034
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiLES0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiLESZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F7520BC1;
        Mon,  5 Dec 2022 10:25:17 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwC+1zL/D6a/X+VYAXT8U8US/8yhBkTIPfnDVmQDisI=;
        b=dgJEBm62Tc+cKl3nkVm+kMKNWjA6/8mxnTbxzXPmRbhRv5pxw6xT3+dCy17X7RUysyFGmP
        w/51cI0Et8YUG2CgtX089vrQ7UHRfoNzbBNCSfdoN2P8VxS1iHilZdq9hNfGlIWBGfanHC
        wzB0xAtrsFgSjjUoVPKhA69Fj560xj5t3zloWkmec0V3DflMuyLsD8KR60w+mNM+QkK0JZ
        /F2RtVVM/Ewa0xVeXfBkPTkOUU4ecPltoyJcG7Ckgy92ZDMRHSQAjkM3e2Gwb6TccG1DRO
        09EvxLKnY1MrZ+nX8B1yw7R4SnyhgQt0fcjLlWe6JvbUpTEPi4bBA3QVlDbFIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwC+1zL/D6a/X+VYAXT8U8US/8yhBkTIPfnDVmQDisI=;
        b=LpPZn1dpRMb6IW7u++xkSDLEld2S/wydBHmYQ/fjerFNeF9e/L3gjXElSFgElh4VFF42UI
        iTSTRU+6rRb5hOAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Remove unused pci_dev_has_special_msi_domain()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.093093200@linutronix.de>
References: <20221124232326.093093200@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471428.4906.7281447313923412213.tip-bot2@tip-bot2>
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

Commit-ID:     96bd2f29f00a60245042f4c0ed85c3e27940d821
Gitweb:        https://git.kernel.org/tip/96bd2f29f00a60245042f4c0ed85c3e27940d821
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:02 +01:00

PCI/MSI: Remove unused pci_dev_has_special_msi_domain()

The check for special MSI domains like VMD which prevents the interrupt
remapping code to overwrite device::msi::domain is not longer required and
has been replaced by an x86 specific version which is aware of MSI parent
domains.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.093093200@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 21 ---------------------
 include/linux/msi.h         |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index be3d50f..4736403 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -414,24 +414,3 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
-
-/**
- * pci_dev_has_special_msi_domain - Check whether the device is handled by
- *				    a non-standard PCI-MSI domain
- * @pdev:	The PCI device to check.
- *
- * Returns: True if the device irqdomain or the bus irqdomain is
- * non-standard PCI/MSI.
- */
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
-{
-	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
-
-	if (!dom)
-		dom = dev_get_msi_domain(&pdev->bus->dev);
-
-	if (!dom)
-		return true;
-
-	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
-}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b4ab005..b5dda4b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -617,7 +617,6 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
