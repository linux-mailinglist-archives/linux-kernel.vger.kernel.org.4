Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4636472A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLHPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiLHPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0699F3E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E74661F7D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D674C433B5;
        Thu,  8 Dec 2022 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512464;
        bh=zTmncM0WxJ5kdI/AaCxtRQosZClPsUDSPGCXdWDYCjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6mqwmoF20NyV8UTjI5S2Jf8S9ynQfH5OaTxtoukHI3DvSdML6c5L7XOawTdR9m8R
         7bbXd8wDmKX+kQkRM1LzXVCLjfvuwhB28tgxZcqLudelIIk5l9xdicPr469YL/qSvM
         AQIFYLU/C11ZQB5eq8yCiERyMuTC3bzCSYn0DdIh+d4Sv2xZJkFieOSilpT4lfn6DV
         451jKkzEs+uReKIc7Hw1C6AwDkgqxow/jJzFpHYxXM8kRdnpaH7VgTsx2DBStgDt1z
         SZ6ejS3++cuTwjNvNuH9PM43bQSf3BXGDutytacPSKsHtakx6v3xuZZh2cnC31KPt2
         epH+SPzakJQIA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 22/26] habanalabs: fix dmabuf to export only required size
Date:   Thu,  8 Dec 2022 17:13:46 +0200
Message-Id: <20221208151350.1833823-22-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch fixes a bug that was found in the dmabuf flow.
Bug description as found on Gaudi2 device:
1. User allocates 4MB of device memory
    - Note that although the allocation size was 4MB the HMMU allocated
      a full page of 768MB to back the request.
    - The user gets a memory handle that points to a single page (768MB)
    - Mapping the handle, the user gets virtual address to the start of
      the page.
2. User exports the buffer
3. User registers the exported buffer in the importer. This flow has
   a callback to the exporter which in turn converts the phys_page_pack
   to an SG list for the importer. This SG list is of single entry of
   size 768MB. However, the size that was passed to the importer was
   only 4MB.

The solution for this is to make sure the importer gets exposure only
to the exported size.

This will be done by fixing the SG created by the exporter to be of
the total size of the actual exported memory requested by the user.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  2 ++
 drivers/misc/habanalabs/common/memory.c     | 35 +++++++++++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ef5a765f3313..de715c91a87e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2120,6 +2120,7 @@ struct hl_vm_hw_block_list_node {
  * @pages: the physical page array.
  * @npages: num physical pages in the pack.
  * @total_size: total size of all the pages in this list.
+ * @exported_size: buffer exported size.
  * @node: used to attach to deletion list that is used when all the allocations are cleared
  *        at the teardown of the context.
  * @mapping_cnt: number of shared mappings.
@@ -2136,6 +2137,7 @@ struct hl_vm_phys_pg_pack {
 	u64			*pages;
 	u64			npages;
 	u64			total_size;
+	u64			exported_size;
 	struct list_head	node;
 	atomic_t		mapping_cnt;
 	u32			asid;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index c7c27ffa6309..3f05bb398c70 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1548,10 +1548,10 @@ static int set_dma_sg(struct scatterlist *sg, u64 bar_address, u64 chunk_size,
 }
 
 static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64 *pages, u64 npages,
-						u64 page_size, struct device *dev,
-						enum dma_data_direction dir)
+						u64 page_size, u64 exported_size,
+						struct device *dev, enum dma_data_direction dir)
 {
-	u64 chunk_size, bar_address, dma_max_seg_size;
+	u64 chunk_size, bar_address, dma_max_seg_size, cur_size_to_export, cur_npages;
 	struct asic_fixed_properties *prop;
 	int rc, i, j, nents, cur_page;
 	struct scatterlist *sg;
@@ -1577,16 +1577,23 @@ static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64
 	if (!sgt)
 		return ERR_PTR(-ENOMEM);
 
+	/* remove export size restrictions in case not explicitly defined */
+	cur_size_to_export = exported_size ? exported_size : (npages * page_size);
+
 	/* If the size of each page is larger than the dma max segment size,
 	 * then we can't combine pages and the number of entries in the SGL
 	 * will just be the
 	 * <number of pages> * <chunks of max segment size in each page>
 	 */
-	if (page_size > dma_max_seg_size)
-		nents = npages * DIV_ROUND_UP_ULL(page_size, dma_max_seg_size);
-	else
+	if (page_size > dma_max_seg_size) {
+		/* we should limit number of pages according to the exported size */
+		cur_npages = DIV_ROUND_UP_SECTOR_T(cur_size_to_export, page_size);
+		nents = cur_npages * DIV_ROUND_UP_SECTOR_T(page_size, dma_max_seg_size);
+	} else {
+		cur_npages = npages;
+
 		/* Get number of non-contiguous chunks */
-		for (i = 1, nents = 1, chunk_size = page_size ; i < npages ; i++) {
+		for (i = 1, nents = 1, chunk_size = page_size ; i < cur_npages ; i++) {
 			if (pages[i - 1] + page_size != pages[i] ||
 					chunk_size + page_size > dma_max_seg_size) {
 				nents++;
@@ -1596,6 +1603,7 @@ static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64
 
 			chunk_size += page_size;
 		}
+	}
 
 	rc = sg_alloc_table(sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (rc)
@@ -1618,7 +1626,8 @@ static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64
 			else
 				cur_device_address += dma_max_seg_size;
 
-			chunk_size = min(size_left, dma_max_seg_size);
+			/* make sure not to export over exported size */
+			chunk_size = min3(size_left, dma_max_seg_size, cur_size_to_export);
 
 			bar_address = hdev->dram_pci_bar_start + cur_device_address;
 
@@ -1626,6 +1635,8 @@ static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64
 			if (rc)
 				goto error_unmap;
 
+			cur_size_to_export -= chunk_size;
+
 			if (size_left > dma_max_seg_size) {
 				size_left -= dma_max_seg_size;
 			} else {
@@ -1637,7 +1648,7 @@ static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64
 		/* Merge pages and put them into the scatterlist */
 		for_each_sgtable_dma_sg(sgt, sg, i) {
 			chunk_size = page_size;
-			for (j = cur_page + 1 ; j < npages ; j++) {
+			for (j = cur_page + 1 ; j < cur_npages ; j++) {
 				if (pages[j - 1] + page_size != pages[j] ||
 						chunk_size + page_size > dma_max_seg_size)
 					break;
@@ -1648,10 +1659,13 @@ static struct sg_table *alloc_sgt_from_device_pages(struct hl_device *hdev, u64
 			bar_address = hdev->dram_pci_bar_start +
 					(pages[cur_page] - prop->dram_base_address);
 
+			/* make sure not to export over exported size */
+			chunk_size = min(chunk_size, cur_size_to_export);
 			rc = set_dma_sg(sg, bar_address, chunk_size, dev, dir);
 			if (rc)
 				goto error_unmap;
 
+			cur_size_to_export -= chunk_size;
 			cur_page = j;
 		}
 	}
@@ -1722,6 +1736,7 @@ static struct sg_table *hl_map_dmabuf(struct dma_buf_attachment *attachment,
 						phys_pg_pack->pages,
 						phys_pg_pack->npages,
 						phys_pg_pack->page_size,
+						phys_pg_pack->exported_size,
 						attachment->dev,
 						dir);
 	else
@@ -1729,6 +1744,7 @@ static struct sg_table *hl_map_dmabuf(struct dma_buf_attachment *attachment,
 						&hl_dmabuf->device_address,
 						1,
 						hl_dmabuf->dmabuf->size,
+						0,
 						attachment->dev,
 						dir);
 
@@ -2033,6 +2049,7 @@ static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 addr, u64 size, u64 o
 		if (rc)
 			goto dec_memhash_export_cnt;
 
+		phys_pg_pack->exported_size = size;
 		hl_dmabuf->phys_pg_pack = phys_pg_pack;
 		hl_dmabuf->memhash_hnode = hnode;
 	} else {
-- 
2.25.1

