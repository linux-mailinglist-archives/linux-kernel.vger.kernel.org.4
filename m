Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311762DF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiKQPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiKQPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EB774CE5;
        Thu, 17 Nov 2022 07:07:59 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcmMTDwhnaQQDnjreSFcEJhXe5wKANWvkUnc3Ky9kuQ=;
        b=2XUpKKJU6E8jWHSCQF9vIwZOwUheDTmJ6YmAK+Z5GxXeZ2X7FROMHRX456hYjN7WLRrnvm
        n7K83ZYEJJjm4LfSgbyr1MfzEcS/4h/eqmXd3bFwLZviqBEnrR59bVqcbI4YjuvKLb4Oi/
        1is1Jghs9HebwsaAXmjCEiL2MecJpxPYk7tS0tniySKpQV/j3LY5LGMCR4ae2nCze3akNm
        K8OfGBGB+bsskiGX1OYUMMu1UJ0l054dafcOBuoHrJmtmAwBBUNLWacKZnMLed/nRQX7yb
        Lwbz4kOG9DREllc2z1HioiUw8YyZv7BLh+OlZ8a1IWdxaatYZNFHPd4eifyDmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcmMTDwhnaQQDnjreSFcEJhXe5wKANWvkUnc3Ky9kuQ=;
        b=5Vtm2Dhr2e2GaD7lzmCDGvCTgEyQzlk1WKJMiAJEi2cvyp8zLFJDlGc9gNEhs5v+q01a3u
        V4BeeWeWna3L/1Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Reject multi-MSI early
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.574339988@linutronix.de>
References: <20221111122015.574339988@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767633.4906.12501148304122264760.tip-bot2@tip-bot2>
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

Commit-ID:     d2a463b297415ca6dd4d60bb1c867dd7c931587b
Gitweb:        https://git.kernel.org/tip/d2a463b297415ca6dd4d60bb1c867dd7c931587b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

PCI/MSI: Reject multi-MSI early

When hierarchical MSI interrupt domains are enabled then there is no point
to do tons of work and detect the missing support for multi-MSI late in the
allocation path.

Just query the domain feature flags right away. The query function is going
to be used for other purposes later and has a mode argument which influences
the result:

  ALLOW_LEGACY returns true when:
     - there is no irq domain attached (legacy support)
     - there is a irq domain attached which has the feature flag set

  DENY_LEGACY returns only true when:
     - there is a irq domain attached which has the feature flag set

This allows to use the function universally without ifdeffery in the
calling code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.574339988@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 22 ++++++++++++++++++++++
 drivers/pci/msi/msi.c       |  4 ++++
 drivers/pci/msi/msi.h       |  9 +++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index edd0cc2..666ed21 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -187,6 +187,28 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
+/**
+ * pci_msi_domain_supports - Check for support of a particular feature flag
+ * @pdev:		The PCI device to operate on
+ * @feature_mask:	The feature mask to check for (full match)
+ * @mode:		If ALLOW_LEGACY this grants the feature when there is no irq domain
+ *			associated to the device. If DENY_LEGACY the lack of an irq domain
+ *			makes the feature unsupported
+ */
+bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
+			     enum support_mode mode)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_hierarchy(domain))
+		return mode == ALLOW_LEGACY;
+	info = domain->host_data;
+	return (info->flags & feature_mask) == feature_mask;
+}
+
 /*
  * Users of the generic MSI infrastructure expect a device to have a single ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices with
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 794ec97..bc84647 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -347,6 +347,10 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	struct msi_desc *entry;
 	int ret;
 
+	/* Reject multi-MSI early on irq domain enabled architectures */
+	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
+		return 1;
+
 	/*
 	 * Disable MSI during setup in the hardware, but mark it enabled
 	 * so that setup code can evaluate it.
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 8170ef2..9d75b6f 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -97,6 +97,15 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 void __pci_restore_msi_state(struct pci_dev *dev);
 void __pci_restore_msix_state(struct pci_dev *dev);
 
+/* irq_domain related functionality */
+
+enum support_mode {
+	ALLOW_LEGACY,
+	DENY_LEGACY,
+};
+
+bool pci_msi_domain_supports(struct pci_dev *dev, unsigned int feature_mask, enum support_mode mode);
+
 /* Legacy (!IRQDOMAIN) fallbacks */
 
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
