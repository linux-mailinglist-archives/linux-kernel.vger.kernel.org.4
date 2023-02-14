Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E7695956
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjBNGk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBNGks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:40:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E64215
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676356845; x=1707892845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYiUzwXcIESW9CC9W0uKX6ksKTTJosh7MEJivRzpXXw=;
  b=ZnPdm4GEmvn7F6Bu9FQCGXs2Nx8GYkFO/CXzkYhRXH1Y0Wt8yYpVbYVV
   ZrPIGD4JDr3W6rP6LjNAdDKZugX2z8EHU6mkuRhsN7RcDhDqXnkmIK0Cy
   nnqgHrokKEOALmODy2dDjWGKtmlXbJvok3pcCjbWjH9QrmeKphW/mhLpJ
   un3JUjz6F78mcgwQSrV9z6M4Zjlx6d3MHalt5K+F6eOV9cV/ORvgTvGsb
   4119E+z86GSpalafhXRQIRolbyXlFQ+/G4gF0K7Eib2pXg2oto9SMllPf
   bTv4j929HB2lvI8GFdTUFD1S/dL3BzIjvyMoOD6Eg993v5KhsfY9CA/F7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333229960"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333229960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="811907118"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="811907118"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2023 22:40:36 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Date:   Mon, 13 Feb 2023 22:44:14 -0800
Message-Id: <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no use anymore, delete it all.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v2:
	- fix compile issue w/o CONFIG_IOMMU_SVA
	- consolidate INVALID_IOASID w/ IOMMU_PASID_INVALID
---
 Documentation/x86/sva.rst   |   2 +-
 arch/x86/kernel/traps.c     |   5 +-
 drivers/dma/idxd/device.c   |   8 +-
 drivers/dma/idxd/idxd.h     |   1 -
 drivers/dma/idxd/init.c     |   2 +-
 drivers/dma/idxd/irq.c      |   2 +-
 drivers/iommu/intel/dmar.c  |   4 +-
 drivers/iommu/intel/iommu.c |   2 +-
 drivers/iommu/intel/iommu.h |   1 -
 drivers/iommu/intel/svm.c   |   3 +-
 drivers/iommu/ioasid.c      | 422 ------------------------------------
 drivers/iommu/iommu-sva.c   |   2 +-
 drivers/iommu/iommu-sva.h   |   1 -
 include/linux/ioasid.h      |  83 -------
 include/linux/iommu.h       |  11 +-
 include/linux/sched/mm.h    |   4 +-
 include/uapi/linux/iommu.h  |   1 +
 mm/init-mm.c                |   4 +-
 18 files changed, 29 insertions(+), 529 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 2e9b8b0f9a0f..33cb05005982 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -107,7 +107,7 @@ process share the same page tables, thus the same MSR value.
 PASID Life Cycle Management
 ===========================
 
-PASID is initialized as INVALID_IOASID (-1) when a process is created.
+PASID is initialized as IOMMU_PASID_INVALID (-1) when a process is created.
 
 Only processes that access SVA-capable devices need to have a PASID
 allocated. This allocation happens when a process opens/binds an SVA-capable
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d317dc3d06a3..d6fb03ebf548 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -40,7 +40,10 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
-#include <linux/ioasid.h>
+
+#ifdef CONFIG_IOMMU_SVA
+#include <linux/iommu.h>
+#endif
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 29dbb0f52e18..125652a8bb29 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1194,7 +1194,7 @@ static void idxd_device_set_perm_entry(struct idxd_device *idxd,
 {
 	union msix_perm mperm;
 
-	if (ie->pasid == INVALID_IOASID)
+	if (ie->pasid == IOMMU_PASID_INVALID)
 		return;
 
 	mperm.bits = 0;
@@ -1224,7 +1224,7 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	idxd_device_clear_perm_entry(idxd, ie);
 	ie->vector = -1;
 	ie->int_handle = INVALID_INT_HANDLE;
-	ie->pasid = INVALID_IOASID;
+	ie->pasid = IOMMU_PASID_INVALID;
 }
 
 int idxd_wq_request_irq(struct idxd_wq *wq)
@@ -1240,7 +1240,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 
 	ie = &wq->ie;
 	ie->vector = pci_irq_vector(pdev, ie->id);
-	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : INVALID_IOASID;
+	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : IOMMU_PASID_INVALID;
 	idxd_device_set_perm_entry(idxd, ie);
 
 	rc = request_threaded_irq(ie->vector, NULL, idxd_wq_thread, 0, "idxd-portal", ie);
@@ -1265,7 +1265,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 	free_irq(ie->vector, ie);
 err_irq:
 	idxd_device_clear_perm_entry(idxd, ie);
-	ie->pasid = INVALID_IOASID;
+	ie->pasid = IOMMU_PASID_INVALID;
 	return rc;
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 417e602a46b6..dd2a6ed8949b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -10,7 +10,6 @@
 #include <linux/cdev.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
-#include <linux/ioasid.h>
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
 #include <linux/iommu.h>
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 529ea09c9094..f30eef701970 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -105,7 +105,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 		ie = idxd_get_ie(idxd, msix_idx);
 		ie->id = msix_idx;
 		ie->int_handle = INVALID_INT_HANDLE;
-		ie->pasid = INVALID_IOASID;
+		ie->pasid = IOMMU_PASID_INVALID;
 
 		spin_lock_init(&ie->list_lock);
 		init_llist_head(&ie->pending_llist);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index aa314ebec587..242f1f0b9f09 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -80,7 +80,7 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
 	desc.opcode = DSA_OPCODE_DRAIN;
 	desc.priv = 1;
 
-	if (ie->pasid != INVALID_IOASID)
+	if (ie->pasid != IOMMU_PASID_INVALID)
 		desc.pasid = ie->pasid;
 	desc.int_handle = ie->int_handle;
 	portal = idxd_wq_portal_addr(wq);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index bf0bfe5ba7a7..c567f94b66c7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1933,7 +1933,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		return 0;
 	}
 
-	if (pasid == INVALID_IOASID)
+	if (pasid == IOMMU_PASID_INVALID)
 		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
@@ -2014,7 +2014,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : INVALID_IOASID,
+					  pasid_present ? pasid : IOMMU_PASID_INVALID,
 					  source_id, guest_addr);
 
 		fault_index++;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a295e80fdfe8..10f657828d3a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -876,7 +876,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 		return;
 	}
 	/* For request-without-pasid, get the pasid from context entry */
-	if (intel_iommu_sm && pasid == INVALID_IOASID)
+	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
 		pasid = PASID_RID2PASID;
 
 	dir_index = pasid >> PASID_PDE_SHIFT;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6bdfbead82c4..80582e497782 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -19,7 +19,6 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
-#include <linux/ioasid.h>
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c76b66263467..b4efc541f6b3 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
 #include <linux/xarray.h>
-#include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
 
@@ -274,7 +273,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
 		return -EINVAL;
 
-	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
+	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
 		return -EINVAL;
 
 	svm = pasid_private_find(pasid);
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
deleted file mode 100644
index a786c034907c..000000000000
--- a/drivers/iommu/ioasid.c
+++ /dev/null
@@ -1,422 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * I/O Address Space ID allocator. There is one global IOASID space, split into
- * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc() and ioasid_free().
- */
-#include <linux/ioasid.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/xarray.h>
-
-struct ioasid_data {
-	ioasid_t id;
-	struct ioasid_set *set;
-	void *private;
-	struct rcu_head rcu;
-};
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
-
-/**
- * ioasid_set_data - Set private data for an allocated ioasid
- * @ioasid: the ID to set data
- * @data:   the private data
- *
- * For IOASID that is already allocated, private data can be set
- * via this API. Future lookup can be done via ioasid_find.
- */
-int ioasid_set_data(ioasid_t ioasid, void *data)
-{
-	struct ioasid_data *ioasid_data;
-	int ret = 0;
-
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		rcu_assign_pointer(ioasid_data->private, data);
-	else
-		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
-
-	/*
-	 * Wait for readers to stop accessing the old private data, so the
-	 * caller can free it.
-	 */
-	if (!ret)
-		synchronize_rcu();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ioasid_set_data);
-
-/**
- * ioasid_alloc - Allocate an IOASID
- * @set: the IOASID set
- * @min: the minimum ID (inclusive)
- * @max: the maximum ID (inclusive)
- * @private: data private to the caller
- *
- * Allocate an ID between @min and @max. The @private pointer is stored
- * internally and can be retrieved with ioasid_find().
- *
- * Return: the allocated ID on success, or %INVALID_IOASID on failure.
- */
-ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
-		      void *private)
-{
-	struct ioasid_data *data;
-	void *adata;
-	ioasid_t id;
-
-	data = kzalloc(sizeof(*data), GFP_ATOMIC);
-	if (!data)
-		return INVALID_IOASID;
-
-	data->set = set;
-	data->private = private;
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
-		goto exit_free;
-	}
-	data->id = id;
-
-	spin_unlock(&ioasid_allocator_lock);
-	return id;
-exit_free:
-	spin_unlock(&ioasid_allocator_lock);
-	kfree(data);
-	return INVALID_IOASID;
-}
-EXPORT_SYMBOL_GPL(ioasid_alloc);
-
-/**
- * ioasid_free - Free an ioasid
- * @ioasid: the ID to remove
- */
-void ioasid_free(ioasid_t ioasid)
-{
-	struct ioasid_data *ioasid_data;
-
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
-}
-EXPORT_SYMBOL_GPL(ioasid_free);
-
-/**
- * ioasid_find - Find IOASID data
- * @set: the IOASID set
- * @ioasid: the IOASID to find
- * @getter: function to call on the found object
- *
- * The optional getter function allows to take a reference to the found object
- * under the rcu lock. The function can also check if the object is still valid:
- * if @getter returns false, then the object is invalid and NULL is returned.
- *
- * If the IOASID exists, return the private pointer passed to ioasid_alloc.
- * Private data can be NULL if not set. Return an error if the IOASID is not
- * found, or if @set is not NULL and the IOASID does not belong to the set.
- */
-void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-		  bool (*getter)(void *))
-{
-	void *priv;
-	struct ioasid_data *ioasid_data;
-	struct ioasid_allocator_data *idata;
-
-	rcu_read_lock();
-	idata = rcu_dereference(active_allocator);
-	ioasid_data = xa_load(&idata->xa, ioasid);
-	if (!ioasid_data) {
-		priv = ERR_PTR(-ENOENT);
-		goto unlock;
-	}
-	if (set && ioasid_data->set != set) {
-		/* data found but does not belong to the set */
-		priv = ERR_PTR(-EACCES);
-		goto unlock;
-	}
-	/* Now IOASID and its set is verified, we can return the private data */
-	priv = rcu_dereference(ioasid_data->private);
-	if (getter && !getter(priv))
-		priv = NULL;
-unlock:
-	rcu_read_unlock();
-
-	return priv;
-}
-EXPORT_SYMBOL_GPL(ioasid_find);
-
-MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
-MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
-MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
-MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 8fb6f1867af3..5daf3353e149 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,7 +15,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 {
 	int ret;
 
-	if (min == INVALID_IOASID || max == INVALID_IOASID ||
+	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
 	    min == 0 || max < min)
 		return -EINVAL;
 
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index c22d0174ad61..54946b5a7caf 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -5,7 +5,6 @@
 #ifndef _IOMMU_SVA_H
 #define _IOMMU_SVA_H
 
-#include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
 /* I/O Page fault */
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
deleted file mode 100644
index af1c9d62e642..000000000000
--- a/include/linux/ioasid.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_IOASID_H
-#define __LINUX_IOASID_H
-
-#include <linux/types.h>
-#include <linux/errno.h>
-
-#define INVALID_IOASID ((ioasid_t)-1)
-typedef unsigned int ioasid_t;
-typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
-typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
-
-struct ioasid_set {
-	int dummy;
-};
-
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
-#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
-
-#if IS_ENABLED(CONFIG_IOASID)
-ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
-		      void *private);
-void ioasid_free(ioasid_t ioasid);
-void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-		  bool (*getter)(void *));
-int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
-void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
-int ioasid_set_data(ioasid_t ioasid, void *data);
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid != INVALID_IOASID;
-}
-
-#else /* !CONFIG_IOASID */
-static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
-				    ioasid_t max, void *private)
-{
-	return INVALID_IOASID;
-}
-
-static inline void ioasid_free(ioasid_t ioasid) { }
-
-static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-				bool (*getter)(void *))
-{
-	return NULL;
-}
-
-static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
-{
-	return -ENOTSUPP;
-}
-
-static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator)
-{
-}
-
-static inline int ioasid_set_data(ioasid_t ioasid, void *data)
-{
-	return -ENOTSUPP;
-}
-
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return false;
-}
-
-#endif /* CONFIG_IOASID */
-#endif /* __LINUX_IOASID_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa22..7cbcf37df8cd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/ioasid.h>
 #include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -192,8 +191,14 @@ enum iommu_dev_features {
 	IOMMU_DEV_FEAT_IOPF,
 };
 
-#define IOMMU_PASID_INVALID	(-1U)
-
+//#define IOMMU_PASID_INVALID	(-1U)
+typedef unsigned int ioasid_t;
+#ifdef CONFIG_IOMMU_SVA
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != IOMMU_PASID_INVALID;
+}
+#endif
 #ifdef CONFIG_IOMMU_API
 
 /**
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index cdc138086230..4c52835d3359 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
+#include <uapi/linux/iommu.h>
 
 /*
  * Routines for handling mm_structs
@@ -454,7 +454,7 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
-	mm->pasid = INVALID_IOASID;
+	mm->pasid = IOMMU_PASID_INVALID;
 }
 
 /* Associate a PASID with an mm_struct: */
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 65d8b0234f69..a95f07f0c98c 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -157,5 +157,6 @@ struct iommu_page_response {
 	__u32	grpid;
 	__u32	code;
 };
+#define IOMMU_PASID_INVALID	(-1U)
 
 #endif /* _UAPI_IOMMU_H */
diff --git a/mm/init-mm.c b/mm/init-mm.c
index c9327abb771c..a084039f55d8 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -10,7 +10,7 @@
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
-#include <linux/ioasid.h>
+#include <linux/iommu.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
@@ -40,7 +40,7 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
-	.pasid		= INVALID_IOASID,
+	.pasid		= IOMMU_PASID_INVALID,
 #endif
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.25.1

