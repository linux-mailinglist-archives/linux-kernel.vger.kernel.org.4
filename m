Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D362DF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiKQPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbiKQPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0D391E3;
        Thu, 17 Nov 2022 07:08:31 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+m9S7ndn05IG4//0WovboMWPYNCLThWa+tMtJVVl3g=;
        b=i6OqWxICJSDfYrR1F/6w1QZglM7rODbnVWb8aM3CimZpp4nTVMkbDkuRl7/vUh4lzsNyAW
        oXG9CJ3c6013dNfBi30pZjxnqFeC7xkkko13E9BDUzEVoMMLwrXhQxq0SR/uphQqJiHDEZ
        3gQHJ2TJxhdMadMqR64m3lhvnpA+clzjaQCDoYY6LKFEekcfYH9lmCOmTHr78s++HRsSyN
        pGdkt1r37G0Mhx/avRqPieMgsCKjjVvbDXH8uzDkMZ78fYgQ9dFr4KtaPPfYFiaHxnxTB6
        iTgnxk8U7AnSA/Knf50NKAQ5wYqwy2Teyv2hsrYh2PqXrOi/cCApglBaEbWUyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+m9S7ndn05IG4//0WovboMWPYNCLThWa+tMtJVVl3g=;
        b=RbFdkCMuXxlKsJEuBocklvYHjtWWnDWnbqeoGrZ944/07Sq56byMTPexCes/x5yppfW7E7
        B11SxfAhGOeNzDAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Remove filter from msi_free_descs_free_range()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122013.888850936@linutronix.de>
References: <20221111122013.888850936@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770851.4906.16694225027340647627.tip-bot2@tip-bot2>
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

Commit-ID:     2f2940d168236a92df524a1bd99fc7b0325918b5
Gitweb:        https://git.kernel.org/tip/2f2940d168236a92df524a1bd99fc7b0325918b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

genirq/msi: Remove filter from msi_free_descs_free_range()

When a range of descriptors is freed then all of them are not associated to
a linux interrupt. Remove the filter and add a warning to the free function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122013.888850936@linutronix.de

---
 drivers/base/platform-msi.c |  2 +-
 include/linux/msi.h         |  5 ++---
 kernel/irq/msi.c            | 19 ++++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 12b0441..dddafa1 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -325,7 +325,7 @@ void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int vir
 
 	msi_lock_descs(data->dev);
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, virq, virq + nr_irqs - 1);
+	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
 	msi_unlock_descs(data->dev);
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index fc918a6..969ce46 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -247,8 +247,7 @@ static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 #endif /* CONFIG_PCI_MSI */
 
 int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
-			      unsigned int first_index, unsigned int last_index);
+void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
  * msi_free_msi_descs - Free MSI descriptors of a device
@@ -256,7 +255,7 @@ void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
  */
 static inline void msi_free_msi_descs(struct device *dev)
 {
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, MSI_MAX_INDEX);
+	msi_free_msi_descs_range(dev, 0, MSI_MAX_INDEX);
 }
 
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index bba6359..1ca4846 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -120,7 +120,7 @@ static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsi
 fail_mem:
 	ret = -ENOMEM;
 fail:
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, index, last);
+	msi_free_msi_descs_range(dev, index, last);
 	return ret;
 }
 
@@ -141,12 +141,11 @@ static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 /**
  * msi_free_msi_descs_range - Free MSI descriptors of a device
  * @dev:		Device to free the descriptors
- * @filter:		Descriptor state filter
  * @first_index:	Index to start freeing from
  * @last_index:		Last index to be freed
  */
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
-			      unsigned int first_index, unsigned int last_index)
+void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
+			      unsigned int last_index)
 {
 	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_desc *desc;
@@ -155,10 +154,12 @@ void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	xa_for_each_range(xa, idx, desc, first_index, last_index) {
-		if (msi_desc_match(desc, filter)) {
-			xa_erase(xa, idx);
-			msi_free_desc(desc);
-		}
+		xa_erase(xa, idx);
+
+		/* Leak the descriptor when it is still referenced */
+		if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
+			continue;
+		msi_free_desc(desc);
 	}
 }
 
@@ -739,7 +740,7 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 fail:
 	for (--virq; virq >= virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, virq_base + nvec - 1);
+	msi_free_msi_descs_range(dev, virq_base, virq_base + nvec - 1);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
