Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8313620A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiKHHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiKHHli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1F9E3B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893296; x=1699429296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=La92Ayvnwa0vkurcX0IYDOYl3Lt67lg9NIa8NEWq5NA=;
  b=G+7AjoCKQFEjdQPGcDZB4tpVzH4bOEWyOWQpCDvileCjgebTeeBb+Eeb
   cWcbMGYGe1GYZ0s//BUegxZszDYWGMGQMRsIjO9I8y08q4e9QGM+hyra+
   2yrNc8yg+BXFxrDUYa/KA6IdAvJ4Mrbd5BZbzY0DBFkdUg3A/yc6mFv4u
   TGiESVNIjZK8a2JSf/wd2SsHcEb5QTGVAKQNUyvFIXRJ5DqQe97QNyTHu
   pZf0MGVsZExBG6TwQ/igQE6k0Rl8f27TTrLdL2RHALK+dIbIhOX2Tal63
   jcnoOCULo1NAQxyg15uw1HPaMpN3CUubj7iS4tp/aInfvXLW1PQIZAb2z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309340034"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309340034"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821988"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821988"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:17 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 8/8] iommu/vt-d: Use real field for indication of first level
Date:   Tue,  8 Nov 2022 15:34:08 +0800
Message-Id: <20221108073408.1005721-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
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

The dmar_domain uses bit field members to indicate the behaviors. Add
a bit field for using first level and remove the flags member to avoid
duplication.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index f8f6092ea23c..ccefa3b52240 100644
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
-			if (domain_use_first_level(domain)) {
+			if (domain->use_first_level) {
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 				if (iommu_is_dma_domain(&domain->domain))
 					pteval |= DMA_FL_PTE_ACCESS;
@@ -1536,7 +1531,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (ih)
 		ih = 1 << 6;
 
-	if (domain_use_first_level(domain)) {
+	if (domain->use_first_level) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
@@ -1590,7 +1585,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 	 * It's a non-present to present mapping. Only flush if caching mode
 	 * and second level.
 	 */
-	if (cap_caching_mode(iommu->cap) && !domain_use_first_level(domain))
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
 		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
@@ -1606,7 +1601,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		struct intel_iommu *iommu = info->iommu;
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
-		if (domain_use_first_level(dmar_domain))
+		if (dmar_domain->use_first_level)
 			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
@@ -1779,7 +1774,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
-		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
+		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	spin_lock_init(&domain->lock);
@@ -2212,7 +2207,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
-	if (domain_use_first_level(domain)) {
+	if (domain->use_first_level) {
 		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 		if (prot & DMA_PTE_WRITE)
 			attr |= DMA_FL_PTE_DIRTY;
@@ -2482,7 +2477,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
-		else if (domain_use_first_level(domain))
+		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
 					PASID_RID2PASID);
 		else
@@ -4422,7 +4417,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
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

