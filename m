Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154A62DF06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiKQPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiKQPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:07:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25064140A6;
        Thu, 17 Nov 2022 07:07:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhN45R8XDsYS+qO3ag3gg15R4teB4dZBCZ4VjNt75NQ=;
        b=s7yf8arwgITZ+tpC0ECzwtFwNBX4DEfYCpikBid0Sb//wQgGIPcSblk8wGA4RkTHnANNtb
        aLmbM/RqTrWg59E6Nr14jPHsTTE0TzRRXrzCbwUz/FL+vKdSlflXU+MMkkH3jUQ0c8ZbgU
        37l4tjPvKaa48uvFmVCq5Y0WRMb3v5q15VbZBdKhKMoJS1DIoeTiTWmlOb+l+JjeB2dUxO
        3T4RGeDXuLOzFfZFpE3UbzDP9NPiXM56ywbopx4FoVp2t6c6gSkc1ZiXhxko/aTvbamZhP
        29vi8/6wR0h2UNGGyp1aGPtXDWVVbpwP5ROPHZ3BAGyRLywOnIAj+UTsCydxPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhN45R8XDsYS+qO3ag3gg15R4teB4dZBCZ4VjNt75NQ=;
        b=DQMm/RG7n421u5EgyiyraN+0SipsYp3s3+O/boKfD87b6JapebYmC5fytR6ozhlE27LKcG
        RIZU+Xlgdkh3gUDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Remove redundant msi_check() callback
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.749446904@linutronix.de>
References: <20221111122015.749446904@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767291.4906.5832389984277922977.tip-bot2@tip-bot2>
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

Commit-ID:     9c03b2589da2b2b259a960f2a325731f6b38d115
Gitweb:        https://git.kernel.org/tip/9c03b2589da2b2b259a960f2a325731f6b38d115
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

PCI/MSI: Remove redundant msi_check() callback

All these sanity checks are now done _before_ any allocation work
happens. No point in doing it twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.749446904@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 48 +------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 666ed21..dea2e8c 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -64,51 +64,6 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
-static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
-{
-	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
-}
-
-/**
- * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
- *			      for @dev
- * @domain:	The interrupt domain to check
- * @info:	The domain info for verification
- * @dev:	The device to check
- *
- * Returns:
- *  0 if the functionality is supported
- *  1 if Multi MSI is requested, but the domain does not support it
- *  -ENOTSUPP otherwise
- */
-static int pci_msi_domain_check_cap(struct irq_domain *domain,
-				    struct msi_domain_info *info,
-				    struct device *dev)
-{
-	struct msi_desc *desc = msi_first_desc(dev, MSI_DESC_ALL);
-
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) &&
-	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
-		return 1;
-
-	if (desc->pci.msi_attrib.is_msix) {
-		if (!(info->flags & MSI_FLAG_PCI_MSIX))
-			return -ENOTSUPP;
-
-		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
-			unsigned int idx = 0;
-
-			/* Check for gaps in the entry indices */
-			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
-				if (desc->msi_index != idx++)
-					return -ENOTSUPP;
-			}
-		}
-	}
-	return 0;
-}
-
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
@@ -118,7 +73,6 @@ static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 
 static struct msi_domain_ops pci_msi_domain_ops_default = {
 	.set_desc	= pci_msi_domain_set_desc,
-	.msi_check	= pci_msi_domain_check_cap,
 };
 
 static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -130,8 +84,6 @@ static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
 	} else {
 		if (ops->set_desc == NULL)
 			ops->set_desc = pci_msi_domain_set_desc;
-		if (ops->msi_check == NULL)
-			ops->msi_check = pci_msi_domain_check_cap;
 	}
 }
 
