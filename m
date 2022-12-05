Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D764304F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiLES2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34920F7D;
        Mon,  5 Dec 2022 10:25:20 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqNHL4yCJTPn4snPcicZB4ULBrgW14xmM0o2wE8Mpso=;
        b=Vo3q8/sCf96290nOLmC2Ev2Z1Q3g1bUvm2m7EK4cwTLJehzLa1kRf3c22AEerOdEFNA3IF
        4BBkjRSIeBfxdw7z55ndoDLJ0LwdiV6vwc1uM1R7QfSgSKBTNdmuYQHGjJb/OJ2Im4Cf0x
        NjShQi1+Y8Z80YGkUFanvyVUOgog7hylNci7tjMjY7k/czlqur7Q97oVKwfbuW5nCmqfDr
        KaLtwsHxph5pWTJoNVQqzNu2A/Nu2vOc87sD4KQ2ZlaI3vjrVWUOO49lSxUJkiDGO8nB4W
        6veyZeylLxnFJnU9/vLaiJJMfkDaHXTsbvHVn8qJ/jd31f2h8Yp5wp/sHT7HXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqNHL4yCJTPn4snPcicZB4ULBrgW14xmM0o2wE8Mpso=;
        b=d9XMDx+L8tJlucaEApTKgN6p2o5slCr5g1m+FfVbPYI5LscfUB+jiIcV8M8jDQ9u/oPalT
        +Xn/p5jkbNYT3KDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make msi_add_simple_msi_descs() device
 domain aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.279112474@linutronix.de>
References: <20221124230314.279112474@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471902.4906.2088786510954274973.tip-bot2@tip-bot2>
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

Commit-ID:     40742716f294449549884421170ea18356a2abe8
Gitweb:        https://git.kernel.org/tip/40742716f294449549884421170ea18356a2abe8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

genirq/msi: Make msi_add_simple_msi_descs() device domain aware

Allocating simple interrupt descriptors in the core code has to be multi
device irqdomain aware for the upcoming PCI/IMS support.

Change the interfaces to take a domain id into account. Use the internal
control struct for transport of arguments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.279112474@linutronix.de

---
 kernel/irq/msi.c | 98 +++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 33ababf..64a4cc8 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -116,39 +116,6 @@ int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 	return msi_insert_desc(dev->msi.data, desc, domid, init_desc->msi_index);
 }
 
-/**
- * msi_add_simple_msi_descs - Allocate and initialize MSI descriptors
- * @dev:	Pointer to the device for which the descriptors are allocated
- * @index:	Index for the first MSI descriptor
- * @ndesc:	Number of descriptors to allocate
- *
- * Return: 0 on success or an appropriate failure code.
- */
-static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
-{
-	unsigned int idx, last = index + ndesc - 1;
-	struct msi_desc *desc;
-	int ret;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	for (idx = index; idx <= last; idx++) {
-		desc = msi_alloc_desc(dev, 1, NULL);
-		if (!desc)
-			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, MSI_DEFAULT_DOMAIN, idx);
-		if (ret)
-			goto fail;
-	}
-	return 0;
-
-fail_mem:
-	ret = -ENOMEM;
-fail:
-	msi_free_msi_descs_range(dev, index, last);
-	return ret;
-}
-
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 {
 	switch (filter) {
@@ -166,6 +133,7 @@ static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
 {
 	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
+			 !dev->msi.data->__domains[ctrl->domid].domain ||
 			 ctrl->first > ctrl->last ||
 			 ctrl->first > MSI_MAX_INDEX ||
 			 ctrl->last > MSI_MAX_INDEX))
@@ -214,6 +182,41 @@ void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
 	msi_domain_free_descs(dev, &ctrl);
 }
 
+/**
+ * msi_domain_add_simple_msi_descs - Allocate and initialize MSI descriptors
+ * @dev:	Pointer to the device for which the descriptors are allocated
+ * @ctrl:	Allocation control struct
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static int msi_domain_add_simple_msi_descs(struct device *dev, struct msi_ctrl *ctrl)
+{
+	struct msi_desc *desc;
+	unsigned int idx;
+	int ret;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return -EINVAL;
+
+	for (idx = ctrl->first; idx <= ctrl->last; idx++) {
+		desc = msi_alloc_desc(dev, 1, NULL);
+		if (!desc)
+			goto fail_mem;
+		ret = msi_insert_desc(dev->msi.data, desc, ctrl->domid, idx);
+		if (ret)
+			goto fail;
+	}
+	return 0;
+
+fail_mem:
+	ret = -ENOMEM;
+fail:
+	msi_domain_free_descs(dev, ctrl);
+	return ret;
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;
@@ -786,16 +789,24 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.first  = virq_base,
+		.last	= virq_base + nvec - 1,
+	};
 	struct msi_desc *desc;
 	struct xarray *xa;
 	int ret, virq;
 
+	if (!msi_ctrl_valid(dev, &ctrl))
+		return -EINVAL;
+
 	msi_lock_descs(dev);
-	ret = msi_add_simple_msi_descs(dev, virq_base, nvec);
+	ret = msi_domain_add_simple_msi_descs(dev, &ctrl);
 	if (ret)
 		goto unlock;
 
-	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+	xa = &dev->msi.data->__domains[ctrl.domid].store;
 
 	for (virq = virq_base; virq < virq_base + nvec; virq++) {
 		desc = xa_load(xa, virq);
@@ -814,7 +825,7 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 fail:
 	for (--virq; virq >= virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_free_msi_descs_range(dev, virq_base, virq_base + nvec - 1);
+	msi_domain_free_descs(dev, &ctrl);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
@@ -988,14 +999,19 @@ static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev
 	return 0;
 }
 
-static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info,
-					   struct device *dev,
-					   unsigned int num_descs)
+static int msi_domain_alloc_simple_msi_descs(struct device *dev,
+					     struct msi_domain_info *info,
+					     unsigned int num_descs)
 {
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.last	= num_descs - 1,
+	};
+
 	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
 		return 0;
 
-	return msi_add_simple_msi_descs(dev, 0, num_descs);
+	return msi_domain_add_simple_msi_descs(dev, &ctrl);
 }
 
 /**
@@ -1026,7 +1042,7 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device 
 	}
 
 	/* Frees allocated descriptors in case of failure. */
-	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
+	ret = msi_domain_alloc_simple_msi_descs(dev, info, nvec);
 	if (ret)
 		goto free;
 
