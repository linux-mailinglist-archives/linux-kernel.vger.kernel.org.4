Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF85663316A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiKVAh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiKVAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:37:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B273AC758E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077423; x=1700613423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43F3BI4HZ1o7zLhMgPgev7UwWC1JI2ewMMrjPJKUpH4=;
  b=XfU2rGYLqqp+rd7MBpWxOlxXqHtxoRGUWCG2SWX/YRtN+zbyDSdZdnbH
   5IdB92YZIZEW7fi2ybPY2ht+lgL1RIyNxRFYZ89PpVFq091MK3qc1S4Uq
   Q8IkGFTh/12UwKRFG0L7kwnDruTA40AD6bbH9+XH4FVmT9iXJahCWkHFX
   51PLo8ZQWLwaFGbVekxSAH21dTuZ5O2O/6oU9riIgYvrziaSaeeCo7DnB
   T5eXRIV0Cr2dV1Q5N0RztcNCoY8dSQgW7fv0zZYoVEhmyzw7sQH2UvrdY
   hISAnumpgbdUS5+JULhQ+xSsJtxQwCFYj/s/iwL1MoUXxhEqmASRV6Qjl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311325683"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="311325683"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018448"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018448"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:37:02 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] iommu/vt-d: Use real field for indication of first level
Date:   Tue, 22 Nov 2022 08:29:49 +0800
Message-Id: <20221122002949.148140-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122002949.148140-1-baolu.lu@linux.intel.com>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dmar_domain uses bit field members to indicate the behaviors. Add
a bit field for using first level and remove the flags member to avoid
duplication.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20221118132451.114406-8-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 15 +++++----------
 drivers/iommu/intel/iommu.c | 25 ++++++++++---------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 251a609fdce3..7b7234689cb4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -515,14 +515,6 @@ struct context_entry {
 	u64 hi;
 };
 
-/*
- * When VT-d works in the scalable mode, it allows DMA translation to
- * happen through either first level or second level page table. This
- * bit marks that the DMA translation for the domain goes through the
- * first level page table, otherwise, it goes through the second level.
- */
-#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
-
 struct iommu_domain_info {
 	struct intel_iommu *iommu;
 	unsigned int refcnt;		/* Refcount of devices per iommu */
@@ -539,6 +531,11 @@ struct dmar_domain {
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
+	u8 use_first_level:1;		/* DMA translation for the domain goes
+					 * through the first level page table,
+					 * otherwise, goes through the second
+					 * level.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
@@ -548,8 +545,6 @@ struct dmar_domain {
 
 	/* adjusted guest address width, 0 is level 2 30-bit */
 	int		agaw;
-
-	int		flags;		/* flags to find out type of domain */
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3a05cfbc252a..cd71194fe7a6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -383,11 +383,6 @@ static inline int domain_type_is_si(struct dmar_domain *domain)
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
-static inline bool domain_use_first_level(struct dmar_domain *domain)
-{
-	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL;
-}
-
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -501,7 +496,7 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
 		if (iommu != skip) {
-			if (domain && domain_use_first_level(domain)) {
+			if (domain && domain->use_first_level) {
 				if (!cap_fl1gp_support(iommu->cap))
 					mask = 0x1;
 			} else {
@@ -579,7 +574,7 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	 * paging and 57-bits with 5-level paging). Hence, skip bit
 	 * [N-1].
 	 */
-	if (domain_use_first_level(domain))
+	if (domain->use_first_level)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
 	else
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
@@ -947,7 +942,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
-			if (domain_use_first_level(domain))
+			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
@@ -1498,7 +1493,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (ih)
 		ih = 1 << 6;
 
-	if (domain_use_first_level(domain)) {
+	if (domain->use_first_level) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
@@ -1552,7 +1547,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 	 * It's a non-present to present mapping. Only flush if caching mode
 	 * and second level.
 	 */
-	if (cap_caching_mode(iommu->cap) && !domain_use_first_level(domain))
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
 		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
@@ -1568,7 +1563,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		struct intel_iommu *iommu = info->iommu;
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
-		if (domain_use_first_level(dmar_domain))
+		if (dmar_domain->use_first_level)
 			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
@@ -1741,7 +1736,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
-		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
+		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	spin_lock_init(&domain->lock);
@@ -2173,7 +2168,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
-	if (domain_use_first_level(domain)) {
+	if (domain->use_first_level) {
 		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 		if (prot & DMA_PTE_WRITE)
 			attr |= DMA_FL_PTE_DIRTY;
@@ -2443,7 +2438,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
-		else if (domain_use_first_level(domain))
+		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
 					PASID_RID2PASID);
 		else
@@ -4410,7 +4405,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 	 * Second level page table supports per-PTE snoop control. The
 	 * iommu_map() interface will handle this by setting SNP bit.
 	 */
-	if (!domain_use_first_level(domain)) {
+	if (!domain->use_first_level) {
 		domain->set_pte_snp = true;
 		return;
 	}
-- 
2.34.1

