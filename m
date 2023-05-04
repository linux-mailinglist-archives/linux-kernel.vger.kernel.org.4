Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78C6F77D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEDVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:11:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09BF71493C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:11:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB242F4;
        Thu,  4 May 2023 14:11:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D76B13F67D;
        Thu,  4 May 2023 14:11:00 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, jgg@nvidia.com
Cc:     will@kernel.org, schnelle@linux.ibm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu: Add a capability for flush queue support
Date:   Thu,  4 May 2023 22:10:55 +0100
Message-Id: <f0086a93dbccb92622e1ace775846d81c1c4b174.1683233867.git.robin.murphy@arm.com>
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

Passing a special type to domain_alloc to indirectly query whether flush
queues are a worthwhile optimisation with the given driver is a bit
clunky, and looking increasingly anachronistic. Let's put that into an
explicit capability instead.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c                   | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 +
 drivers/iommu/intel/iommu.c                 | 1 +
 include/linux/iommu.h                       | 5 +++++
 5 files changed, 10 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4a314647d1f7..9b7bd6bed664 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2293,6 +2293,8 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return amdr_ivrs_remap_support;
 	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fd83fb75722..6d65a7e81df4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2008,6 +2008,7 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 		/* Assume that a coherent TCU implies coherent TBUs */
 		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
 	case IOMMU_CAP_NOEXEC:
+	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	default:
 		return false;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6e0813b26fb6..7f4ee365912c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1325,6 +1325,7 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK ||
 			device_get_dma_attr(dev) == DEV_DMA_COHERENT;
 	case IOMMU_CAP_NOEXEC:
+	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	default:
 		return false;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b871a6afd803..ff923298f8ed 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4369,6 +4369,7 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
+	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	case IOMMU_CAP_PRE_BOOT_PROTECTION:
 		return dmar_platform_optin();
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da1060..1b7180d6edae 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,6 +127,11 @@ enum iommu_cap {
 	 * this device.
 	 */
 	IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
+	/*
+	 * IOMMU driver does not issue TLB maintenance during .unmap, so can
+	 * usefully support the non-strict DMA flush queue.
+	 */
+	IOMMU_CAP_DEFERRED_FLUSH,
 };
 
 /* These are the possible reserved region types */
-- 
2.39.2.101.g768bb238c484.dirty

