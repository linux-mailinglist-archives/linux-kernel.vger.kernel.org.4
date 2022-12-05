Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBC64305B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiLES2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiLESZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5F21258;
        Mon,  5 Dec 2022 10:25:22 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYMdxOjrmMzCmM4u/uAuk2BiIOk27UYvmrRTh6VQeCI=;
        b=fOd054/VkzJw/MJbTA3HytfzBZFuAINUo/RX/ncXPzc6y8bw4vJvW/1NSieQTIplIUTGWL
        rb3GiaCOotX51SUt7CENTIbg0lhHti+lgQnnNsVoB28zN159It1oog3tk5KNRQJHsExeuA
        ke5zYGfHFhtr3XLO7IGhCihwmymnUMazz/3ZGFOurGItR4y0mC4YtkVsdWSVfwoqrPsyu+
        u7IHHdGvKV0a1/eoff0aqylIc6y8iCaSIJdB3E+kdr7E0SVb7kzQRs2BKuZW0JdF/i5L62
        kdEOZomLRZWl8dgWAdTnsta4VgzqX7j2rblA1sMCWWgvKawgpwscAnQRACE7Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYMdxOjrmMzCmM4u/uAuk2BiIOk27UYvmrRTh6VQeCI=;
        b=y102esKNDLoEcdT2R3oA59AKQGjqtEYuhOWVmRfwZmnjMkJHJiHHGvbQ/5O4wdXC2y7qfD
        Gcwdk6Fr4XWOjRCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Move xarray into a separate struct and
 create an array
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.864887773@linutronix.de>
References: <20221124230313.864887773@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472071.4906.6714377473651545960.tip-bot2@tip-bot2>
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

Commit-ID:     f1139f905bd2d8bec59be0c1404b592279ae0ac9
Gitweb:        https://git.kernel.org/tip/f1139f905bd2d8bec59be0c1404b592279ae0ac9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Move xarray into a separate struct and create an array

The upcoming support for multiple MSI domains per device requires storage
for the MSI descriptors and in a second step storage for the irqdomain
pointers.

Move the xarray into a separate data structure msi_dev_domain and create an
array with size 1 in msi_device_data, which can be expanded later when the
support for per device domains is implemented.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.864887773@linutronix.de

---
 include/linux/msi.h     | 13 +++++++++++--
 include/linux/msi_api.h |  8 ++++++++
 kernel/irq/msi.c        | 32 ++++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9f72494..f7b9c41 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -173,19 +173,28 @@ enum msi_desc_filter {
 	MSI_DESC_ASSOCIATED,
 };
 
+
+/**
+ * struct msi_dev_domain - The internals of MSI domain info per device
+ * @store:		Xarray for storing MSI descriptor pointers
+ */
+struct msi_dev_domain {
+	struct xarray		store;
+};
+
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
  * @platform_data:	Platform-MSI specific data
  * @mutex:		Mutex protecting the MSI descriptor store
- * @__store:		Xarray for storing MSI descriptor pointers
+ * @__domains:		Internal data for per device MSI domains
  * @__iter_idx:		Index to search the next entry for iterators
  */
 struct msi_device_data {
 	unsigned long			properties;
 	struct platform_msi_priv_data	*platform_data;
 	struct mutex			mutex;
-	struct xarray			__store;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
 	unsigned long			__iter_idx;
 };
 
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 57d27cf..4dbbce6 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -10,6 +10,14 @@
 
 struct device;
 
+/*
+ * Per device interrupt domain related constants.
+ */
+enum msi_domain_ids {
+	MSI_DEFAULT_DOMAIN,
+	MSI_MAX_DEVICE_IRQDOMAINS,
+};
+
 unsigned int msi_get_virq(struct device *dev, unsigned int index);
 
 #endif
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5939dc6..c2bc94e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -60,10 +60,11 @@ static void msi_free_desc(struct msi_desc *desc)
 
 static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
 {
+	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
 	int ret;
 
 	desc->msi_index = index;
-	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
+	ret = xa_insert(xa, index, desc, GFP_KERNEL);
 	if (ret)
 		msi_free_desc(desc);
 	return ret;
@@ -147,7 +148,7 @@ static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
 			      unsigned int last_index)
 {
-	struct xarray *xa = &dev->msi.data->__store;
+	struct xarray *xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
 	struct msi_desc *desc;
 	unsigned long idx;
 
@@ -179,9 +180,12 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static void msi_device_data_release(struct device *dev, void *res)
 {
 	struct msi_device_data *md = res;
+	int i;
 
-	WARN_ON_ONCE(!xa_empty(&md->__store));
-	xa_destroy(&md->__store);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++) {
+		WARN_ON_ONCE(!xa_empty(&md->__domains[i].store));
+		xa_destroy(&md->__domains[i].store);
+	}
 	dev->msi.data = NULL;
 }
 
@@ -198,7 +202,7 @@ static void msi_device_data_release(struct device *dev, void *res)
 int msi_setup_device_data(struct device *dev)
 {
 	struct msi_device_data *md;
-	int ret;
+	int ret, i;
 
 	if (dev->msi.data)
 		return 0;
@@ -213,7 +217,9 @@ int msi_setup_device_data(struct device *dev)
 		return ret;
 	}
 
-	xa_init(&md->__store);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
+		xa_init(&md->__domains[i].store);
+
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);
@@ -236,7 +242,7 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
  */
 void msi_unlock_descs(struct device *dev)
 {
-	/* Invalidate the index wich was cached by the iterator */
+	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx = MSI_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
@@ -244,9 +250,10 @@ EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
 static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_desc_filter filter)
 {
+	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
 	struct msi_desc *desc;
 
-	xa_for_each_start(&md->__store, md->__iter_idx, desc, md->__iter_idx) {
+	xa_for_each_start(xa, md->__iter_idx, desc, md->__iter_idx) {
 		if (msi_desc_match(desc, filter))
 			return desc;
 	}
@@ -320,6 +327,7 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
 	unsigned int ret = 0;
+	struct xarray *xa;
 	bool pcimsi;
 
 	if (!dev->msi.data)
@@ -328,7 +336,8 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index)
 	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
 
 	msi_lock_descs(dev);
-	desc = xa_load(&dev->msi.data->__store, pcimsi ? 0 : index);
+	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
 		 * PCI-MSI has only one descriptor for multiple interrupts.
@@ -707,6 +716,7 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	struct msi_desc *desc;
+	struct xarray *xa;
 	int ret, virq;
 
 	msi_lock_descs(dev);
@@ -714,8 +724,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 	if (ret)
 		goto unlock;
 
+	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+
 	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = xa_load(&dev->msi.data->__store, virq);
+		desc = xa_load(xa, virq);
 		desc->irq = virq;
 
 		ops->set_desc(arg, desc);
