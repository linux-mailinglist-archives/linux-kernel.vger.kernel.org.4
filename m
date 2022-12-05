Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921F64305A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiLES2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLESZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4321253;
        Mon,  5 Dec 2022 10:25:21 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPx1+HzEba2jw7vNeGkFY7DoJKahwcGEQKsGGExIih0=;
        b=pyMkelfM/DofC1aD33sOjiMipa5aXr2vzeAr8I25zUqyFzCIM0IiuUqTaZE7uPyLpPcZqN
        39EBCgFEK1UngrOuHJDGcsXVzCNaNCD9TEloa1r/0EVlVcI+ydfSxvdTMVyFz7ipAE7CaD
        FvvF77P2VGF8uIfHXlsuKqmCQ9gjXz8NaTQasY1OugeaeugGnlhak+UkoD90nOI2sCVdzB
        yts9M2soUd4eyuouPkeAW/bGOFfvVy/q7M1FaywLmiPTU5MKnPGFzWnzhdedpFD2Irbinw
        pfj+Nn8JofLiJt38fT3sRqFaFAoIotXWiJSBWJznB0Y6s78EhM4udrvgZC2zpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPx1+HzEba2jw7vNeGkFY7DoJKahwcGEQKsGGExIih0=;
        b=cbZtKZpWhvs6EurcoQ//ktTf0wvVtavY91mq11Opu+fain/b8ieZhHaUKsRd2lKhCxoNGj
        nuPSMhJOATFYYzDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make MSI descriptor iterators device domain aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.985498981@linutronix.de>
References: <20221124230313.985498981@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472023.4906.16856424953692028095.tip-bot2@tip-bot2>
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

Commit-ID:     94ff94cfea2827e287a42781a47f37c9ef82186b
Gitweb:        https://git.kernel.org/tip/94ff94cfea2827e287a42781a47f37c9ef82186b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Make MSI descriptor iterators device domain aware

To support multiple MSI interrupt domains per device it is necessary to
segment the xarray MSI descriptor storage. Each domain gets up to
MSI_MAX_INDEX entries.

Change the iterators so they operate with domain ids and take the domain
offsets into account.

The publicly available iterators which are mostly used in legacy
implementations and the PCI/MSI core default to MSI_DEFAULT_DOMAIN (0)
which is the id for the existing "global" domains.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.985498981@linutronix.de

---
 include/linux/msi.h | 48 ++++++++++++++++++++++++++++++++++++++------
 kernel/irq/msi.c    | 35 +++++++++++++++++++++-----------
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index fdbc80d..764a4e8 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -206,11 +206,48 @@ int msi_setup_device_data(struct device *dev);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter);
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
+				       enum msi_desc_filter filter);
 
 /**
- * msi_for_each_desc - Iterate the MSI descriptors
+ * msi_first_desc - Get the first MSI descriptor of the default irqdomain
+ * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
+ *
+ * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
+ * must be invoked before the call.
+ *
+ * Return: Pointer to the first MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+static inline struct msi_desc *msi_first_desc(struct device *dev,
+					      enum msi_desc_filter filter)
+{
+	return msi_domain_first_desc(dev, MSI_DEFAULT_DOMAIN, filter);
+}
+
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter);
+
+/**
+ * msi_domain_for_each_desc - Iterate the MSI descriptors in a specific domain
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @domid:	The id of the interrupt domain which should be walked.
+ * @filter:	Filter for descriptor selection
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_domain_for_each_desc(desc, dev, domid, filter)			\
+	for ((desc) = msi_domain_first_desc((dev), (domid), (filter)); (desc);	\
+	     (desc) = msi_next_desc((dev), (domid), (filter)))
+
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors in the default irqdomain
  *
  * @desc:	struct msi_desc pointer used as iterator
  * @dev:	struct device pointer - device to iterate
@@ -221,9 +258,8 @@ struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
  *    pair.
  *  - It is safe to remove a retrieved MSI descriptor in the loop.
  */
-#define msi_for_each_desc(desc, dev, filter)			\
-	for ((desc) = msi_first_desc((dev), (filter)); (desc);	\
-	     (desc) = msi_next_desc((dev), (filter)))
+#define msi_for_each_desc(desc, dev, filter)					\
+	msi_domain_for_each_desc((desc), (dev), MSI_DEFAULT_DOMAIN, (filter))
 
 #define msi_desc_to_dev(desc)		((desc)->dev)
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index de65acc..ec08d1f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,8 +19,14 @@
 
 #include "internals.h"
 
+/* Invalid Xarray index which is outside of any searchable range */
+#define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
+/* The maximum domain size */
+#define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
+
 static inline int msi_sysfs_create_group(struct device *dev);
 
+
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
@@ -252,27 +258,29 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
 void msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index which was cached by the iterator */
-	dev->msi.data->__iter_idx = MSI_MAX_INDEX;
+	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
-static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_desc_filter filter)
+static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned int domid,
+				      enum msi_desc_filter filter)
 {
-	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
+	struct xarray *xa = &md->__domains[domid].store;
 	struct msi_desc *desc;
 
 	xa_for_each_start(xa, md->__iter_idx, desc, md->__iter_idx) {
 		if (msi_desc_match(desc, filter))
 			return desc;
 	}
-	md->__iter_idx = MSI_MAX_INDEX;
+	md->__iter_idx = MSI_XA_MAX_INDEX;
 	return NULL;
 }
 
 /**
- * msi_first_desc - Get the first MSI descriptor of a device
+ * msi_domain_first_desc - Get the first MSI descriptor of an irqdomain associated to a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Descriptor state filter
  *
  * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
@@ -281,23 +289,25 @@ static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_desc_
  * Return: Pointer to the first MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter)
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
+				       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md = dev->msi.data;
 
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
 	lockdep_assert_held(&md->mutex);
 
 	md->__iter_idx = 0;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
-EXPORT_SYMBOL_GPL(msi_first_desc);
+EXPORT_SYMBOL_GPL(msi_domain_first_desc);
 
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Descriptor state filter
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
@@ -308,11 +318,12 @@ EXPORT_SYMBOL_GPL(msi_first_desc);
  * Return: Pointer to the next MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter)
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md = dev->msi.data;
 
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
 	lockdep_assert_held(&md->mutex);
@@ -321,7 +332,7 @@ struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter)
 		return NULL;
 
 	md->__iter_idx++;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
 EXPORT_SYMBOL_GPL(msi_next_desc);
 
