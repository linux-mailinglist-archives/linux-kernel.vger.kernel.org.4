Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85127643055
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiLES20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C020F4C;
        Mon,  5 Dec 2022 10:25:20 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxO9X2l+NSMIa+UXWRtNon92nJUOuEG19bHKS0C3hqM=;
        b=AkI6Fm8uuKmVhqpe4D89X8yAzq9ylfQzP3ePmqhE1y88xc/CEtBZ7GZaSX92EukNR2Z43M
        sRFpariWf8QcZ+cppOUo0xfFiQ0q/kDMRakB3TpeFUVpwBPq1gBY7r4F1+R9P6D2JpV8F6
        mievp5ML2OeahPW9rzN6hOx2uWHV/e0Fo7ujtalM91+DYzw0w5ohClSJZGGZeVZvVoKctr
        7LBF4xQFIFl/XIjLMHQaZS+tLHWfMXjvt/+jcvAOWQ1H9ZaLiVEUzHKYL9W0Q6PWGJJe0O
        nPlsUqqrdUjRglboglNiVbgSYLbAXoyFEJfCKGi/+j7LBb0zlC9ZBKAbhMOGIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxO9X2l+NSMIa+UXWRtNon92nJUOuEG19bHKS0C3hqM=;
        b=iZdrdJPnM2KSQ3Fx+lofnifEwE4knESkimXbnbQWkAHXDierjc5Ag5CKVpUFKvx+hcgmxK
        8nhN9Ajesz9qg3Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide new domain id allocation functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.396497163@linutronix.de>
References: <20221124230314.396497163@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471856.4906.2335401782851498492.tip-bot2@tip-bot2>
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

Commit-ID:     f2480e7dacdcd9aab25641346ae53b7ff03777fc
Gitweb:        https://git.kernel.org/tip/f2480e7dacdcd9aab25641346ae53b7ff03777fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

genirq/msi: Provide new domain id allocation functions

Provide two sorts of interfaces to handle the different use cases:

  - msi_domain_alloc_irqs_range():

	Handles a caller defined precise range

  - msi_domain_alloc_irqs_all():

	Allocates all interrupts associated to a domain by scanning the
    	allocated MSI descriptors

The latter is useful for the existing PCI/MSI support which does not have
range information available.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.396497163@linutronix.de

---
 include/linux/msi.h |  18 ++--
 kernel/irq/msi.c    | 175 +++++++++++++++++++++++++++++++++----------
 2 files changed, 146 insertions(+), 47 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 74cb0a9..611707d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -383,8 +383,8 @@ struct msi_domain_info;
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare and @set_desc are callbacks used by
- * msi_domain_alloc/free_irqs().
+ * @msi_check, @msi_prepare and @set_desc are callbacks used by the
+ * msi_domain_alloc/free_irqs*() variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
  * default allocation/free functions (__msi_domain_alloc/free_irqs). This
@@ -392,11 +392,6 @@ struct msi_domain_info;
  * be wrapped into the regular irq domains concepts by mere mortals.  This
  * allows to universally use msi_domain_alloc/free_irqs without having to
  * special case XEN all over the place.
- *
- * Contrary to other operations @domain_alloc_irqs and @domain_free_irqs
- * are set to the default implementation if NULL and even when
- * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
- * because these callbacks are obviously mandatory.
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -496,14 +491,21 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device 
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
+
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
+int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last);
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last);
+int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs);
+
+
 void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
-
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c1ac780..f857295 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -24,11 +24,14 @@
  * @domid:	ID of the domain on which management operations should be done
  * @first:	First (hardware) slot index to operate on
  * @last:	Last (hardware) slot index to operate on
+ * @nirqs:	The number of Linux interrupts to allocate. Can be larger
+ *		than the range due to PCI/multi-MSI.
  */
 struct msi_ctrl {
 	unsigned int			domid;
 	unsigned int			first;
 	unsigned int			last;
+	unsigned int			nirqs;
 };
 
 /* Invalid Xarray index which is outside of any searchable range */
@@ -36,6 +39,7 @@ struct msi_ctrl {
 /* The maximum domain size */
 #define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
 
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
 static inline int msi_sysfs_create_group(struct device *dev);
 
 
@@ -544,8 +548,6 @@ static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *d
 static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc) { }
 #endif /* !CONFIG_SYSFS */
 
-static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
-
 static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int domid)
 {
 	struct irq_domain *domain;
@@ -723,7 +725,6 @@ static struct msi_domain_ops msi_domain_ops_default = {
 	.msi_init		= msi_domain_ops_init,
 	.msi_prepare		= msi_domain_ops_prepare,
 	.set_desc		= msi_domain_ops_set_desc,
-	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
 };
 
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -735,9 +736,6 @@ static void msi_domain_update_dom_ops(struct msi_domain_info *info)
 		return;
 	}
 
-	if (ops->domain_alloc_irqs == NULL)
-		ops->domain_alloc_irqs = msi_domain_ops_default.domain_alloc_irqs;
-
 	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
 		return;
 
@@ -951,18 +949,19 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 	return 0;
 }
 
-static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-				   int nvec)
+static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain,
+				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
+	unsigned int vflags = 0, allocated = 0;
 	msi_alloc_info_t arg = { };
-	unsigned int vflags = 0;
 	struct msi_desc *desc;
-	int allocated = 0;
+	unsigned long idx;
 	int i, ret, virq;
 
-	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
+	ret = msi_domain_prepare_irqs(domain, dev, ctrl->nirqs, &arg);
 	if (ret)
 		return ret;
 
@@ -988,7 +987,14 @@ static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev
 			vflags |= VIRQ_NOMASK_QUIRK;
 	}
 
-	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
+		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
+			continue;
+
+		/* This should return -ECONFUSED... */
+		if (WARN_ON_ONCE(allocated >= ctrl->nirqs))
+			return -EINVAL;
+
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -1016,17 +1022,122 @@ static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev
 
 static int msi_domain_alloc_simple_msi_descs(struct device *dev,
 					     struct msi_domain_info *info,
-					     unsigned int num_descs)
+					     struct msi_ctrl *ctrl)
+{
+	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
+		return 0;
+
+	return msi_domain_add_simple_msi_descs(dev, ctrl);
+}
+
+static int __msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
+{
+	struct msi_domain_info *info;
+	struct msi_domain_ops *ops;
+	struct irq_domain *domain;
+	int ret;
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return -EINVAL;
+
+	domain = msi_get_device_domain(dev, ctrl->domid);
+	if (!domain)
+		return -ENODEV;
+
+	info = domain->host_data;
+
+	ret = msi_domain_alloc_simple_msi_descs(dev, info, ctrl);
+	if (ret)
+		return ret;
+
+	ops = info->ops;
+	if (ops->domain_alloc_irqs)
+		return ops->domain_alloc_irqs(domain, dev, ctrl->nirqs);
+
+	return __msi_domain_alloc_irqs(dev, domain, ctrl);
+}
+
+static int msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
+{
+	int ret = __msi_domain_alloc_locked(dev, ctrl);
+
+	if (ret)
+		msi_domain_free_locked(dev, ctrl);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs_range_locked - Allocate interrupts from a MSI interrupt domain
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to allocate (inclusive)
+ * @last:	Last index to allocate (inclusive)
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own descriptor
+ * allocation/free.
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl = {
-		.domid	= MSI_DEFAULT_DOMAIN,
-		.last	= num_descs - 1,
+		.domid	= domid,
+		.first	= first,
+		.last	= last,
+		.nirqs	= last + 1 - first,
 	};
 
-	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
-		return 0;
+	return msi_domain_alloc_locked(dev, &ctrl);
+}
+
+/**
+ * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt domain
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to allocate (inclusive)
+ * @last:	Last index to allocate (inclusive)
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
+{
+	int ret;
+
+	msi_lock_descs(dev);
+	ret = msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
+	msi_unlock_descs(dev);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs_all_locked - Allocate all interrupts from a MSI interrupt domain
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @nirqs:	The number of interrupts to allocate
+ *
+ * This function scans all MSI descriptors of the MSI domain and allocates interrupts
+ * for all unassigned ones. That function is to be used for MSI domain usage where
+ * the descriptor allocation is handled at the call site, e.g. PCI/MSI[X].
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= domid,
+		.first	= 0,
+		.last	= MSI_MAX_INDEX,
+		.nirqs	= nirqs,
+	};
 
-	return msi_domain_add_simple_msi_descs(dev, &ctrl);
+	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
 /**
@@ -1045,28 +1156,14 @@ static int msi_domain_alloc_simple_msi_descs(struct device *dev,
 int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
 				       int nvec)
 {
-	struct msi_domain_info *info = domain->host_data;
-	struct msi_domain_ops *ops = info->ops;
-	int ret;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain))) {
-		ret = -EINVAL;
-		goto free;
-	}
-
-	/* Frees allocated descriptors in case of failure. */
-	ret = msi_domain_alloc_simple_msi_descs(dev, info, nvec);
-	if (ret)
-		goto free;
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.first	= 0,
+		.last	= MSI_MAX_INDEX,
+		.nirqs	= nvec,
+	};
 
-	ret = ops->domain_alloc_irqs(domain, dev, nvec);
-	if (!ret)
-		return 0;
-free:
-	msi_domain_free_irqs_descs_locked(domain, dev);
-	return ret;
+	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
 /**
