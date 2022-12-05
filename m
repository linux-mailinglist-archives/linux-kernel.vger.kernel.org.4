Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC5643049
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiLES2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5120F7A;
        Mon,  5 Dec 2022 10:25:20 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJrrHyg4sXLGdrkbGJ1IPkHazqtz1E9P+9OoJFqsHQI=;
        b=tE5GblDAO/usO9576hpI2Xs6w+xAGpLabAQhbtywFamMMNGLuWmnzFcXCCC0I3H0/CYUi4
        Cv2fQNBKryy50mxvTMRP61qnKgvWQLwbH95zlJ5SGwKLFMqI93rDQw/gW8Z2XYNxUkJ+5s
        4GqGm09BR7mngD1FOpac7vEyPAIhW8ke96HhoroXO+ikI6L9L9dSkKj4iqrZoa5nLQFqLy
        B3RVykBYQWq70u+dBhE4OQuGv7i0bIQwM9NbXLW5eFFtwfm7lOsJDZSc8iTQxqnbpBvdJY
        JIOP1Xzt/7HmwMkUPJ9jNXPuqEcCVaUcmzDkODNMppnMKFbFwgKLXxQ4kxgb9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJrrHyg4sXLGdrkbGJ1IPkHazqtz1E9P+9OoJFqsHQI=;
        b=Bx11QJ4Si0/t0SQz2hAf2npW9UNZU0uDnDj0NlGjGZvKDr/tCMkJXkHHRiqQLNOvcf15hF
        QFVCSkLBMpwVQTDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide new domain id based interfaces
 for freeing interrupts
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.337844751@linutronix.de>
References: <20221124230314.337844751@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471878.4906.4045436780799669198.tip-bot2@tip-bot2>
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

Commit-ID:     4cd5f4403f283766f73749c4c936801f58ffe77a
Gitweb:        https://git.kernel.org/tip/4cd5f4403f283766f73749c4c936801f58ffe77a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

genirq/msi: Provide new domain id based interfaces for freeing interrupts

Provide two sorts of interfaces to handle the different use cases:

  - msi_domain_free_irqs_range():

	Handles a caller defined precise range

  - msi_domain_free_irqs_all():

	Frees all interrupts associated to a domain

The latter is useful for device teardown and to handle the legacy MSI support
which does not have any range information available.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.337844751@linutronix.de

---
 include/linux/msi.h |   9 +++-
 kernel/irq/msi.c    | 142 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 23172d6..74cb0a9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -498,6 +498,15 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+
+void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last);
+void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last);
+
+void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
+void msi_domain_free_irqs_all(struct device *dev, unsigned int domid);
+
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
 struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 64a4cc8..c1ac780 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -545,7 +545,25 @@ static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *de
 #endif /* !CONFIG_SYSFS */
 
 static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
-static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+
+static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int domid)
+{
+	struct irq_domain *domain;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return NULL;
+
+	domain = dev->msi.data->__domains[domid].domain;
+	if (!domain)
+		return NULL;
+
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
+		return NULL;
+
+	return domain;
+}
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
@@ -706,7 +724,6 @@ static struct msi_domain_ops msi_domain_ops_default = {
 	.msi_prepare		= msi_domain_ops_prepare,
 	.set_desc		= msi_domain_ops_set_desc,
 	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
-	.domain_free_irqs	= __msi_domain_free_irqs,
 };
 
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -720,8 +737,6 @@ static void msi_domain_update_dom_ops(struct msi_domain_info *info)
 
 	if (ops->domain_alloc_irqs == NULL)
 		ops->domain_alloc_irqs = msi_domain_ops_default.domain_alloc_irqs;
-	if (ops->domain_free_irqs == NULL)
-		ops->domain_free_irqs = msi_domain_ops_default.domain_free_irqs;
 
 	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
 		return;
@@ -1073,15 +1088,21 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nve
 	return ret;
 }
 
-static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
+				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
+	unsigned long idx;
 	int i;
 
-	/* Only handle MSI entries which have an interrupt associated */
-	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
+		/* Only handle MSI entries which have an interrupt associated */
+		if (!msi_desc_match(desc, MSI_DESC_ASSOCIATED))
+			continue;
+
 		/* Make sure all interrupts are deactivated */
 		for (i = 0; i < desc->nvec_used; i++) {
 			irqd = irq_domain_get_irq_data(domain, desc->irq + i);
@@ -1096,11 +1117,99 @@ static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev
 	}
 }
 
-static void msi_domain_free_msi_descs(struct msi_domain_info *info,
-				      struct device *dev)
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl)
 {
+	struct msi_domain_info *info;
+	struct msi_domain_ops *ops;
+	struct irq_domain *domain;
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return;
+
+	domain = msi_get_device_domain(dev, ctrl->domid);
+	if (!domain)
+		return;
+
+	info = domain->host_data;
+	ops = info->ops;
+
+	if (ops->domain_free_irqs)
+		ops->domain_free_irqs(domain, dev);
+	else
+		__msi_domain_free_irqs(dev, domain, ctrl);
+
+	if (ops->msi_post_free)
+		ops->msi_post_free(domain, dev);
+
 	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
-		msi_free_msi_descs(dev);
+		msi_domain_free_descs(dev, ctrl);
+}
+
+/**
+ * msi_domain_free_irqs_range_locked - Free a range of interrupts from a MSI interrupt domain
+ *				       associated to @dev with msi_lock held
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to free (inclusive)
+ * @last:	Last index to free (inclusive)
+ */
+void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= domid,
+		.first	= first,
+		.last	= last,
+	};
+	msi_domain_free_locked(dev, &ctrl);
+}
+
+/**
+ * msi_domain_free_irqs_range - Free a range of interrupts from a MSI interrupt domain
+ *				associated to @dev
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to free (inclusive)
+ * @last:	Last index to free (inclusive)
+ */
+void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_range_locked(dev, domid, first, last);
+	msi_unlock_descs(dev);
+}
+
+/**
+ * msi_domain_free_irqs_all_locked - Free all interrupts from a MSI interrupt domain
+ *				     associated to a device
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	The id of the domain to operate on
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation.
+ */
+void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
+{
+	msi_domain_free_irqs_range_locked(dev, domid, 0, MSI_MAX_INDEX);
+}
+
+/**
+ * msi_domain_free_irqs_all - Free all interrupts from a MSI interrupt domain
+ *			      associated to a device
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	The id of the domain to operate on
+ */
+void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_all_locked(dev, domid);
+	msi_unlock_descs(dev);
 }
 
 /**
@@ -1115,18 +1224,7 @@ static void msi_domain_free_msi_descs(struct msi_domain_info *info,
  */
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
 {
-	struct msi_domain_info *info = domain->host_data;
-	struct msi_domain_ops *ops = info->ops;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
-		return;
-
-	ops->domain_free_irqs(domain, dev);
-	if (ops->msi_post_free)
-		ops->msi_post_free(domain, dev);
-	msi_domain_free_msi_descs(info, dev);
+	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, 0, MSI_MAX_INDEX);
 }
 
 /**
