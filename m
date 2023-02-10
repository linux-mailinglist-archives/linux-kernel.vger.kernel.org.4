Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D7692AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBJW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBJW6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:58:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6053A0BB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676069914; x=1707605914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V62zNsOgOFRg0pqcZAWx+q0H//GVFp2Mbu6WcKQSqMg=;
  b=Si6z9YVVpr8rTMigVpymJdFlL9DS8infrzCoZ3RsDKFTbyYjiqdkzdT6
   Afv53zbSzxVmDTwanki5QkuYMtaltxAVeeM9BvxBM9LEyzIGJ9w3J39w9
   /KisHds9F18g/kt5KOqc2OTOiZMCbeOqhynL66xKDnFzVmLlRGG339ZOV
   JDtVTdZBgFjBoe5g8gmRNdgdi1TtJWaIoMnQUuCT8NQHgUev56ta7LTiv
   q+lbfdc95ritZKjI1+y95X/oNdL3UZvjMPy8svzz+KBJAkLt3Q9FPcC6h
   /upygdZsbjTlbw35ZAoIsLZ5vgz8YXHlWoV8GiRsgTYRyfPMmNo/x1oVE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310179496"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310179496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="777093503"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="777093503"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 14:58:33 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Date:   Fri, 10 Feb 2023 15:02:06 -0800
Message-Id: <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Custom allocator feature was introduced to support VT-d's virtual
command, an enlightened interface designed for VMs to allocate PASIDs
from the host.

As we remove/withdraw the VT-d virtual command feature, the sole user
of custom allocator, we can safely remove the custom allocator as well.
Effectively, this will return IOASID core to the original simple global
namespace allocator.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 293 ++---------------------------------------
 include/linux/ioasid.h |  28 ----
 2 files changed, 9 insertions(+), 312 deletions(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index a786c034907c..85715e171db2 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -16,246 +16,7 @@ struct ioasid_data {
 	void *private;
 	struct rcu_head rcu;
 };
-
-/*
- * struct ioasid_allocator_data - Internal data structure to hold information
- * about an allocator. There are two types of allocators:
- *
- * - Default allocator always has its own XArray to track the IOASIDs allocated.
- * - Custom allocators may share allocation helpers with different private data.
- *   Custom allocators that share the same helper functions also share the same
- *   XArray.
- * Rules:
- * 1. Default allocator is always available, not dynamically registered. This is
- *    to prevent race conditions with early boot code that want to register
- *    custom allocators or allocate IOASIDs.
- * 2. Custom allocators take precedence over the default allocator.
- * 3. When all custom allocators sharing the same helper functions are
- *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
- *    freed. Otherwise, outstanding IOASIDs will be lost and orphaned.
- * 4. When switching between custom allocators sharing the same helper
- *    functions, outstanding IOASIDs are preserved.
- * 5. When switching between custom allocator and default allocator, all IOASIDs
- *    must be freed to ensure unadulterated space for the new allocator.
- *
- * @ops:	allocator helper functions and its data
- * @list:	registered custom allocators
- * @slist:	allocators share the same ops but different data
- * @flags:	attributes of the allocator
- * @xa:		xarray holds the IOASID space
- * @rcu:	used for kfree_rcu when unregistering allocator
- */
-struct ioasid_allocator_data {
-	struct ioasid_allocator_ops *ops;
-	struct list_head list;
-	struct list_head slist;
-#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track results */
-	unsigned long flags;
-	struct xarray xa;
-	struct rcu_head rcu;
-};
-
-static DEFINE_SPINLOCK(ioasid_allocator_lock);
-static LIST_HEAD(allocators_list);
-
-static ioasid_t default_alloc(ioasid_t min, ioasid_t max, void *opaque);
-static void default_free(ioasid_t ioasid, void *opaque);
-
-static struct ioasid_allocator_ops default_ops = {
-	.alloc = default_alloc,
-	.free = default_free,
-};
-
-static struct ioasid_allocator_data default_allocator = {
-	.ops = &default_ops,
-	.flags = 0,
-	.xa = XARRAY_INIT(ioasid_xa, XA_FLAGS_ALLOC),
-};
-
-static struct ioasid_allocator_data *active_allocator = &default_allocator;
-
-static ioasid_t default_alloc(ioasid_t min, ioasid_t max, void *opaque)
-{
-	ioasid_t id;
-
-	if (xa_alloc(&default_allocator.xa, &id, opaque, XA_LIMIT(min, max), GFP_ATOMIC)) {
-		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
-		return INVALID_IOASID;
-	}
-
-	return id;
-}
-
-static void default_free(ioasid_t ioasid, void *opaque)
-{
-	struct ioasid_data *ioasid_data;
-
-	ioasid_data = xa_erase(&default_allocator.xa, ioasid);
-	kfree_rcu(ioasid_data, rcu);
-}
-
-/* Allocate and initialize a new custom allocator with its helper functions */
-static struct ioasid_allocator_data *ioasid_alloc_allocator(struct ioasid_allocator_ops *ops)
-{
-	struct ioasid_allocator_data *ia_data;
-
-	ia_data = kzalloc(sizeof(*ia_data), GFP_ATOMIC);
-	if (!ia_data)
-		return NULL;
-
-	xa_init_flags(&ia_data->xa, XA_FLAGS_ALLOC);
-	INIT_LIST_HEAD(&ia_data->slist);
-	ia_data->flags |= IOASID_ALLOCATOR_CUSTOM;
-	ia_data->ops = ops;
-
-	/* For tracking custom allocators that share the same ops */
-	list_add_tail(&ops->list, &ia_data->slist);
-
-	return ia_data;
-}
-
-static bool use_same_ops(struct ioasid_allocator_ops *a, struct ioasid_allocator_ops *b)
-{
-	return (a->free == b->free) && (a->alloc == b->alloc);
-}
-
-/**
- * ioasid_register_allocator - register a custom allocator
- * @ops: the custom allocator ops to be registered
- *
- * Custom allocators take precedence over the default xarray based allocator.
- * Private data associated with the IOASID allocated by the custom allocators
- * are managed by IOASID framework similar to data stored in xa by default
- * allocator.
- *
- * There can be multiple allocators registered but only one is active. In case
- * of runtime removal of a custom allocator, the next one is activated based
- * on the registration ordering.
- *
- * Multiple allocators can share the same alloc() function, in this case the
- * IOASID space is shared.
- */
-int ioasid_register_allocator(struct ioasid_allocator_ops *ops)
-{
-	struct ioasid_allocator_data *ia_data;
-	struct ioasid_allocator_data *pallocator;
-	int ret = 0;
-
-	spin_lock(&ioasid_allocator_lock);
-
-	ia_data = ioasid_alloc_allocator(ops);
-	if (!ia_data) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	/*
-	 * No particular preference, we activate the first one and keep
-	 * the later registered allocators in a list in case the first one gets
-	 * removed due to hotplug.
-	 */
-	if (list_empty(&allocators_list)) {
-		WARN_ON(active_allocator != &default_allocator);
-		/* Use this new allocator if default is not active */
-		if (xa_empty(&active_allocator->xa)) {
-			rcu_assign_pointer(active_allocator, ia_data);
-			list_add_tail(&ia_data->list, &allocators_list);
-			goto out_unlock;
-		}
-		pr_warn("Default allocator active with outstanding IOASID\n");
-		ret = -EAGAIN;
-		goto out_free;
-	}
-
-	/* Check if the allocator is already registered */
-	list_for_each_entry(pallocator, &allocators_list, list) {
-		if (pallocator->ops == ops) {
-			pr_err("IOASID allocator already registered\n");
-			ret = -EEXIST;
-			goto out_free;
-		} else if (use_same_ops(pallocator->ops, ops)) {
-			/*
-			 * If the new allocator shares the same ops,
-			 * then they will share the same IOASID space.
-			 * We should put them under the same xarray.
-			 */
-			list_add_tail(&ops->list, &pallocator->slist);
-			goto out_free;
-		}
-	}
-	list_add_tail(&ia_data->list, &allocators_list);
-
-	spin_unlock(&ioasid_allocator_lock);
-	return 0;
-out_free:
-	kfree(ia_data);
-out_unlock:
-	spin_unlock(&ioasid_allocator_lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ioasid_register_allocator);
-
-/**
- * ioasid_unregister_allocator - Remove a custom IOASID allocator ops
- * @ops: the custom allocator to be removed
- *
- * Remove an allocator from the list, activate the next allocator in
- * the order it was registered. Or revert to default allocator if all
- * custom allocators are unregistered without outstanding IOASIDs.
- */
-void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
-{
-	struct ioasid_allocator_data *pallocator;
-	struct ioasid_allocator_ops *sops;
-
-	spin_lock(&ioasid_allocator_lock);
-	if (list_empty(&allocators_list)) {
-		pr_warn("No custom IOASID allocators active!\n");
-		goto exit_unlock;
-	}
-
-	list_for_each_entry(pallocator, &allocators_list, list) {
-		if (!use_same_ops(pallocator->ops, ops))
-			continue;
-
-		if (list_is_singular(&pallocator->slist)) {
-			/* No shared helper functions */
-			list_del(&pallocator->list);
-			/*
-			 * All IOASIDs should have been freed before
-			 * the last allocator that shares the same ops
-			 * is unregistered.
-			 */
-			WARN_ON(!xa_empty(&pallocator->xa));
-			if (list_empty(&allocators_list)) {
-				pr_info("No custom IOASID allocators, switch to default.\n");
-				rcu_assign_pointer(active_allocator, &default_allocator);
-			} else if (pallocator == active_allocator) {
-				rcu_assign_pointer(active_allocator,
-						list_first_entry(&allocators_list,
-								struct ioasid_allocator_data, list));
-				pr_info("IOASID allocator changed");
-			}
-			kfree_rcu(pallocator, rcu);
-			break;
-		}
-		/*
-		 * Find the matching shared ops to delete,
-		 * but keep outstanding IOASIDs
-		 */
-		list_for_each_entry(sops, &pallocator->slist, list) {
-			if (sops == ops) {
-				list_del(&ops->list);
-				break;
-			}
-		}
-		break;
-	}
-
-exit_unlock:
-	spin_unlock(&ioasid_allocator_lock);
-}
-EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
 
 /**
  * ioasid_set_data - Set private data for an allocated ioasid
@@ -270,13 +31,13 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
 
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	xa_lock(&ioasid_xa);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		rcu_assign_pointer(ioasid_data->private, data);
 	else
 		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
+	xa_unlock(&ioasid_xa);
 
 	/*
 	 * Wait for readers to stop accessing the old private data, so the
@@ -305,7 +66,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private)
 {
 	struct ioasid_data *data;
-	void *adata;
 	ioasid_t id;
 
 	data = kzalloc(sizeof(*data), GFP_ATOMIC);
@@ -314,32 +74,13 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
-
-	/*
-	 * Custom allocator needs allocator data to perform platform specific
-	 * operations.
-	 */
-	spin_lock(&ioasid_allocator_lock);
-	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
-	id = active_allocator->ops->alloc(min, max, adata);
-	if (id == INVALID_IOASID) {
-		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
-		goto exit_free;
-	}
-
-	if ((active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) &&
-	     xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(id, id), GFP_ATOMIC)) {
-		/* Custom allocator needs framework to store and track allocation results */
-		pr_err("Failed to alloc ioasid from %d\n", id);
-		active_allocator->ops->free(id, active_allocator->ops->pdata);
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_ATOMIC)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
 		goto exit_free;
 	}
 	data->id = id;
-
-	spin_unlock(&ioasid_allocator_lock);
 	return id;
 exit_free:
-	spin_unlock(&ioasid_allocator_lock);
 	kfree(data);
 	return INVALID_IOASID;
 }
@@ -353,22 +94,8 @@ void ioasid_free(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
 
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (!ioasid_data) {
-		pr_err("Trying to free unknown IOASID %u\n", ioasid);
-		goto exit_unlock;
-	}
-
-	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
-	/* Custom allocator needs additional steps to free the xa element */
-	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
-		ioasid_data = xa_erase(&active_allocator->xa, ioasid);
-		kfree_rcu(ioasid_data, rcu);
-	}
-
-exit_unlock:
-	spin_unlock(&ioasid_allocator_lock);
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
+	kfree_rcu(ioasid_data, rcu);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
@@ -391,11 +118,9 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 {
 	void *priv;
 	struct ioasid_data *ioasid_data;
-	struct ioasid_allocator_data *idata;
 
 	rcu_read_lock();
-	idata = rcu_dereference(active_allocator);
-	ioasid_data = xa_load(&idata->xa, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (!ioasid_data) {
 		priv = ERR_PTR(-ENOENT);
 		goto unlock;
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index af1c9d62e642..fdfa70857227 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -7,28 +7,11 @@
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
-typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
-typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
 struct ioasid_set {
 	int dummy;
 };
 
-/**
- * struct ioasid_allocator_ops - IOASID allocator helper functions and data
- *
- * @alloc:	helper function to allocate IOASID
- * @free:	helper function to free IOASID
- * @list:	for tracking ops that share helper functions but not data
- * @pdata:	data belong to the allocator, provided when calling alloc()
- */
-struct ioasid_allocator_ops {
-	ioasid_alloc_fn_t alloc;
-	ioasid_free_fn_t free;
-	struct list_head list;
-	void *pdata;
-};
-
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
@@ -37,8 +20,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 void ioasid_free(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
-int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
-void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
 static inline bool pasid_valid(ioasid_t ioasid)
 {
@@ -60,15 +41,6 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	return NULL;
 }
 
-static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
-{
-	return -ENOTSUPP;
-}
-
-static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator)
-{
-}
-
 static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 {
 	return -ENOTSUPP;
-- 
2.25.1

