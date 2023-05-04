Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285336F77D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEDVLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEDVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:11:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2011814376
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:11:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 220EF12FC;
        Thu,  4 May 2023 14:11:47 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDD3B3F67D;
        Thu,  4 May 2023 14:11:01 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, jgg@nvidia.com
Cc:     will@kernel.org, schnelle@linux.ibm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu: Use flush queue capability
Date:   Thu,  4 May 2023 22:10:56 +0100
Message-Id: <1c552d99e8ba452bdac48209fa74c0bdd52fd9d9.1683233867.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>
References: <cover.1683233867.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It remains really handy to have distinct DMA domain types within core
code for the sake of default domain policy selection, but we can now
hide that detail from drivers by using the new capability instead.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

Note that IOMMU_DOMAIN_ALLOC_FLAGS would go away again with the
proposed domain_alloc_paging() interface design.
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 +--
 drivers/iommu/dma-iommu.c                   | 3 ++-
 drivers/iommu/intel/iommu.c                 | 1 -
 drivers/iommu/iommu.c                       | 3 ++-
 include/linux/iommu.h                       | 1 +
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d65a7e81df4..1ed9c4ed5db9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2024,7 +2024,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_DMA_FQ &&
 	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 7f4ee365912c..a86acd76c1df 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -856,8 +856,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	struct arm_smmu_domain *smmu_domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_IDENTITY) {
-		if (using_legacy_binding ||
-		    (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_DMA_FQ))
+		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
 			return NULL;
 	}
 	/*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a9f0b0bddbd..c4bdd2587daf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -586,7 +586,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		goto done_unlock;
 
 	/* If the FQ fails we can simply fall back to strict mode */
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
+	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
 		domain->type = IOMMU_DOMAIN_DMA;
 
 	ret = iova_reserve_iommu_regions(dev, domain);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ff923298f8ed..8096273b034c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4064,7 +4064,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	case IOMMU_DOMAIN_BLOCKED:
 		return &blocking_domain;
 	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_DMA_FQ:
 	case IOMMU_DOMAIN_UNMANAGED:
 		dmar_domain = alloc_domain(type);
 		if (!dmar_domain) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..7078bf4a8ec8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1980,11 +1980,12 @@ static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type)
 {
 	struct iommu_domain *domain;
+	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	domain = bus->iommu_ops->domain_alloc(type);
+	domain = bus->iommu_ops->domain_alloc(alloc_type);
 	if (!domain)
 		return NULL;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b7180d6edae..d31642596675 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -65,6 +65,7 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
  * This are the possible domain-types
  *
-- 
2.39.2.101.g768bb238c484.dirty

