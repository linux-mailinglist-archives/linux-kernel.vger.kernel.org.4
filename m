Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40D695955
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjBNGkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjBNGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:40:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F443C33
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676356844; x=1707892844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xWbK0oYD1pJF3gY8G4yOVrEqNZdGE9E1wZowc1Q2vI=;
  b=MleS4G7hI2IclfV4mqjMUSB1VqbICeeVM4ALrDUlTP1/VrvvAXWY2u7H
   KpstGPziwfFmIR3hoAV9QzMlvpeeV1Kop/ID7PnltevHeQo2CF2Ol3yaL
   TBr76U8pfIo43PWLuLCV687+UKX4mMWF5qyp2WRhQAPt9h/mTf5QJPv+N
   e4PtAaSO1UZhSkQO7nroFmZtNuUX5BpIJokK8m20n/cHfkjca0jOJNIXl
   ALHQvLuL1pMSnyWCBe7Rec9eDXVMcY9vNnsyVR/qnMthqCPL+aWasCRFH
   ecSLTRQONKiAl4cVRMIgUI8QhGS35Q+SIgJ8pp+VoQYupfx8ANFLS9Ul4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333229950"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333229950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="811907115"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="811907115"
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
Subject: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Date:   Mon, 13 Feb 2023 22:44:13 -0800
Message-Id: <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Instead SVA drivers can use a simple global IDA to allocate PASIDs for
each mm_struct.

Future work would be to allow drivers using the SVA APIs to reserve global
PASIDs from this IDA for their internal use, eg with the DMA API PASID
support.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v2: minor fixes
	- let idxd driver use iommu.h for ioasid_t
	- return 0 after mm_pasid_set()
---
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/iommu/iommu-sva.c | 53 +++++++++++----------------------------
 drivers/iommu/iommu-sva.h |  3 ---
 include/linux/sched/mm.h  |  8 +-----
 4 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ced8d283d98..417e602a46b6 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -13,6 +13,7 @@
 #include <linux/ioasid.h>
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
+#include <linux/iommu.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..8fb6f1867af3 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,24 +9,11 @@
 #include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DECLARE_IOASID_SET(iommu_sva_pasid);
+static DEFINE_IDA(iommu_global_pasid_ida);
 
-/**
- * iommu_sva_alloc_pasid - Allocate a PASID for the mm
- * @mm: the mm
- * @min: minimum PASID value (inclusive)
- * @max: maximum PASID value (inclusive)
- *
- * Try to allocate a PASID for this mm, or take a reference to the existing one
- * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid and will be available for the lifetime of the mm.
- *
- * Returns 0 on success and < 0 on error.
- */
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
-	int ret = 0;
-	ioasid_t pasid;
+	int ret;
 
 	if (min == INVALID_IOASID || max == INVALID_IOASID ||
 	    min == 0 || max < min)
@@ -37,39 +24,29 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (pasid_valid(mm->pasid)) {
 		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
+		else
+			ret = 0;
 		goto out;
 	}
 
-	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
-		ret = -ENOMEM;
-	else
-		mm_pasid_set(mm, pasid);
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+	if (ret < min)
+		goto out;
+	mm_pasid_set(mm, ret);
+	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
-/* ioasid_find getter() requires a void * argument */
-static bool __mmget_not_zero(void *mm)
+void mm_pasid_drop(struct mm_struct *mm)
 {
-	return mmget_not_zero(mm);
-}
+	pr_alert("%s %d", __func__, mm->pasid);
+	if (likely(!pasid_valid(mm->pasid)))
+		return;
 
-/**
- * iommu_sva_find() - Find mm associated to the given PASID
- * @pasid: Process Address Space ID assigned to the mm
- *
- * On success a reference to the mm is taken, and must be released with mmput().
- *
- * Returns the mm corresponding to this PASID, or an error if not found.
- */
-struct mm_struct *iommu_sva_find(ioasid_t pasid)
-{
-	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
+	ida_free(&iommu_global_pasid_ida, mm->pasid);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_find);
 
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 7215a761b962..c22d0174ad61 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -8,9 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
-
 /* I/O Page fault */
 struct device;
 struct iommu_fault;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..cdc138086230 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -463,13 +463,7 @@ static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
 	mm->pasid = pasid;
 }
 
-static inline void mm_pasid_drop(struct mm_struct *mm)
-{
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
-}
+void mm_pasid_drop(struct mm_struct *mm);
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
-- 
2.25.1

