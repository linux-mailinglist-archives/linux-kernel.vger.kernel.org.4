Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77E7112C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjEYRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjEYRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:46:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79BE410B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:46:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF881042;
        Thu, 25 May 2023 10:47:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D1233F6C4;
        Thu, 25 May 2023 10:46:35 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@infradead.org
Cc:     m.szyprowski@samsung.com, iommu@lists.linux.dev,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
Subject: [PATCH] dma-mapping: Name SG DMA flag helpers consistently
Date:   Thu, 25 May 2023 18:46:31 +0100
Message-Id: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
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

sg_is_dma_bus_address() is inconsistent with the naming pattern of its
corresponding setters and its own kerneldoc, so take the majority vote
and rename it sg_dma_is_bus_address() (and fix up the missing
underscores in the kerneldoc too). This gives us a nice clear pattern
where SG DMA flags are SG_DMA_<NAME>, and the helpers for acting on them
are sg_dma_<action>_<name>().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c   | 8 ++++----
 drivers/iommu/iommu.c       | 2 +-
 include/linux/scatterlist.h | 8 ++++----
 kernel/dma/direct.c         | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a9f0b0bddbd..b8bba4aa196f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1080,7 +1080,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
-		if (sg_is_dma_bus_address(s)) {
+		if (sg_dma_is_bus_address(s)) {
 			if (i > 0)
 				cur = sg_next(cur);
 
@@ -1136,7 +1136,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_is_dma_bus_address(s)) {
+		if (sg_dma_is_bus_address(s)) {
 			sg_dma_unmark_bus_address(s);
 		} else {
 			if (sg_dma_address(s) != DMA_MAPPING_ERROR)
@@ -1329,7 +1329,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	 * just have to be determined.
 	 */
 	for_each_sg(sg, tmp, nents, i) {
-		if (sg_is_dma_bus_address(tmp)) {
+		if (sg_dma_is_bus_address(tmp)) {
 			sg_dma_unmark_bus_address(tmp);
 			continue;
 		}
@@ -1343,7 +1343,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 
 	nents -= i;
 	for_each_sg(tmp, tmp, nents, i) {
-		if (sg_is_dma_bus_address(tmp)) {
+		if (sg_dma_is_bus_address(tmp)) {
 			sg_dma_unmark_bus_address(tmp);
 			continue;
 		}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..eb620552967b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2567,7 +2567,7 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			len = 0;
 		}
 
-		if (sg_is_dma_bus_address(sg))
+		if (sg_dma_is_bus_address(sg))
 			goto next;
 
 		if (len) {
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 375a5e90d86a..d1ed52d083da 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -259,7 +259,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 #define SG_DMA_BUS_ADDRESS (1 << 0)
 
 /**
- * sg_dma_is_bus address - Return whether a given segment was marked
+ * sg_dma_is_bus_address - Return whether a given segment was marked
  *			   as a bus address
  * @sg:		 SG entry
  *
@@ -267,13 +267,13 @@ static inline void sg_unmark_end(struct scatterlist *sg)
  *   Returns true if sg_dma_mark_bus_address() has been called on
  *   this segment.
  **/
-static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
+static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
 {
 	return sg->dma_flags & SG_DMA_BUS_ADDRESS;
 }
 
 /**
- * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
+ * sg_dma_mark_bus_address - Mark the scatterlist entry as a bus address
  * @sg:		 SG entry
  *
  * Description:
@@ -301,7 +301,7 @@ static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
 
 #else
 
-static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
+static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
 {
 	return false;
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5595d1d5cdcc..d29cade048db 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -463,7 +463,7 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_is_dma_bus_address(sg))
+		if (sg_dma_is_bus_address(sg))
 			sg_dma_unmark_bus_address(sg);
 		else
 			dma_direct_unmap_page(dev, sg->dma_address,
-- 
2.39.2.101.g768bb238c484.dirty

