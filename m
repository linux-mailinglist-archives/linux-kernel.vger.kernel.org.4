Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96326472A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiLHPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiLHPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9897DAD31C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1794961F80
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BFC433D6;
        Thu,  8 Dec 2022 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512460;
        bh=nggGQMhecchLPKWMCGZApD7iuvqknklG7XXG/izo1E0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVfTPEjvPrAob54oD28xbqfxnEkExQ44o94SxaSzngIePiCmnOsdqFSWIOzatmYie
         XwEa1RBy9xmFPSs7Swhu8rOlCP4oWSPXhzhs2+Qbvy3mDq/+u9Ntay/AUNQeQ02juO
         Lyt2KPEyYm1rbG8aiApWu8Ck3N1BqMcNxYGfI5qeqQi1LuB8bKksfcfVwNB/q8zkcE
         UJD+IQRuVcey5oXkyx/12/RFzUeRaf4Y2ngJLDyQ06REh09pPET6BmBRusjnps1yT0
         NCkNy/99/v5NI8Bapq2ZDG/NCQxlhu9KN6+p5qUb1n71Y2Z5WLn4Ms59k8JfRAZIep
         sWeHf7AIyVLIQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 19/26] habanalabs: remove support to export dmabuf from handle
Date:   Thu,  8 Dec 2022 17:13:43 +0200
Message-Id: <20221208151350.1833823-19-ogabbay@kernel.org>
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

The API to the user which allows exporting DMA buffer from handle is
deprecated here. It was never used as it is relevant only for Gaudi2,
and the user stack has yet to add support for dmabuf in Gaudi2.

Looking forward, a modified API to export DMA buffer for ASICs that
supports virtual memory will be added.

Until the new API will be ready- exporting DMA buffer will not be
supported for ASICs with virtual memory.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |   5 -
 drivers/misc/habanalabs/common/memory.c     | 143 ++------------------
 2 files changed, 9 insertions(+), 139 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 893ebcba170b..e68928b59c1e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1744,8 +1744,6 @@ struct hl_cs_counters_atomic {
  * struct hl_dmabuf_priv - a dma-buf private object.
  * @dmabuf: pointer to dma-buf object.
  * @ctx: pointer to the dma-buf owner's context.
- * @phys_pg_pack: pointer to physical page pack if the dma-buf was exported for
- *                memory allocation handle.
  * @device_address: physical address of the device's memory. Relevant only
  *                  if phys_pg_pack is NULL (dma-buf was exported from address).
  *                  The total size can be taken from the dmabuf object.
@@ -1753,7 +1751,6 @@ struct hl_cs_counters_atomic {
 struct hl_dmabuf_priv {
 	struct dma_buf			*dmabuf;
 	struct hl_ctx			*ctx;
-	struct hl_vm_phys_pg_pack	*phys_pg_pack;
 	uint64_t			device_address;
 };
 
@@ -2117,7 +2114,6 @@ struct hl_vm_hw_block_list_node {
  * @node: used to attach to deletion list that is used when all the allocations are cleared
  *        at the teardown of the context.
  * @mapping_cnt: number of shared mappings.
- * @exporting_cnt: number of dma-buf exporting.
  * @asid: the context related to this list.
  * @page_size: size of each page in the pack.
  * @flags: HL_MEM_* flags related to this list.
@@ -2133,7 +2129,6 @@ struct hl_vm_phys_pg_pack {
 	u64			total_size;
 	struct list_head	node;
 	atomic_t		mapping_cnt;
-	u32			exporting_cnt;
 	u32			asid;
 	u32			page_size;
 	u32			flags;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 7c5c18be294a..864a8a1c6067 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -371,12 +371,6 @@ static int free_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args)
 		return -EINVAL;
 	}
 
-	if (phys_pg_pack->exporting_cnt) {
-		spin_unlock(&vm->idr_lock);
-		dev_dbg(hdev->dev, "handle %u is exported, cannot free\n", handle);
-		return -EINVAL;
-	}
-
 	/* must remove from idr before the freeing of the physical pages as the refcount of the pool
 	 * is also the trigger of the idr destroy
 	 */
@@ -1700,29 +1694,19 @@ static struct sg_table *hl_map_dmabuf(struct dma_buf_attachment *attachment,
 					enum dma_data_direction dir)
 {
 	struct dma_buf *dma_buf = attachment->dmabuf;
-	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct hl_dmabuf_priv *hl_dmabuf;
 	struct hl_device *hdev;
 	struct sg_table *sgt;
 
 	hl_dmabuf = dma_buf->priv;
 	hdev = hl_dmabuf->ctx->hdev;
-	phys_pg_pack = hl_dmabuf->phys_pg_pack;
 
 	if (!attachment->peer2peer) {
 		dev_dbg(hdev->dev, "Failed to map dmabuf because p2p is disabled\n");
 		return ERR_PTR(-EPERM);
 	}
 
-	if (phys_pg_pack)
-		sgt = alloc_sgt_from_device_pages(hdev,
-						phys_pg_pack->pages,
-						phys_pg_pack->npages,
-						phys_pg_pack->page_size,
-						attachment->dev,
-						dir);
-	else
-		sgt = alloc_sgt_from_device_pages(hdev,
+	sgt = alloc_sgt_from_device_pages(hdev,
 						&hl_dmabuf->device_address,
 						1,
 						hl_dmabuf->dmabuf->size,
@@ -1763,18 +1747,8 @@ static void hl_unmap_dmabuf(struct dma_buf_attachment *attachment,
 static void hl_release_dmabuf(struct dma_buf *dmabuf)
 {
 	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
-	struct hl_ctx *ctx = hl_dmabuf->ctx;
-	struct hl_device *hdev = ctx->hdev;
-	struct hl_vm *vm = &hdev->vm;
-
-	if (hl_dmabuf->phys_pg_pack) {
-		spin_lock(&vm->idr_lock);
-		hl_dmabuf->phys_pg_pack->exporting_cnt--;
-		spin_unlock(&vm->idr_lock);
-	}
 
 	hl_ctx_put(hl_dmabuf->ctx);
-
 	kfree(hl_dmabuf);
 }
 
@@ -1785,7 +1759,7 @@ static const struct dma_buf_ops habanalabs_dmabuf_ops = {
 	.release = hl_release_dmabuf,
 };
 
-static int export_dmabuf_common(struct hl_ctx *ctx,
+static int export_dmabuf(struct hl_ctx *ctx,
 				struct hl_dmabuf_priv *hl_dmabuf,
 				u64 total_size, int flags, int *dmabuf_fd)
 {
@@ -1849,6 +1823,11 @@ static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
 
 	prop = &hdev->asic_prop;
 
+	if (prop->dram_supports_virtual_memory) {
+		dev_dbg(hdev->dev, "Export not supported for devices with virtual memory\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!IS_ALIGNED(device_addr, PAGE_SIZE)) {
 		dev_dbg(hdev->dev,
 			"exported device memory address 0x%llx should be aligned to 0x%lx\n",
@@ -1890,99 +1869,7 @@ static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
 
 	hl_dmabuf->device_address = device_addr;
 
-	rc = export_dmabuf_common(ctx, hl_dmabuf, size, flags, dmabuf_fd);
-	if (rc)
-		goto err_free_dmabuf_wrapper;
-
-	return 0;
-
-err_free_dmabuf_wrapper:
-	kfree(hl_dmabuf);
-	return rc;
-}
-
-/**
- * export_dmabuf_from_handle() - export a dma-buf object for the given memory
- *                               handle.
- * @ctx: pointer to the context structure.
- * @handle: device memory allocation handle.
- * @flags: DMA-BUF file/FD flags.
- * @dmabuf_fd: pointer to result FD that represents the dma-buf object.
- *
- * Create and export a dma-buf object for an existing memory allocation inside
- * the device memory, and return a FD which is associated with the dma-buf
- * object.
- *
- * Return: 0 on success, non-zero for failure.
- */
-static int export_dmabuf_from_handle(struct hl_ctx *ctx, u64 handle, int flags,
-					int *dmabuf_fd)
-{
-	struct hl_vm_phys_pg_pack *phys_pg_pack;
-	struct hl_dmabuf_priv *hl_dmabuf;
-	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop;
-	struct hl_vm *vm = &hdev->vm;
-	u64 bar_address;
-	int rc, i;
-
-	prop = &hdev->asic_prop;
-
-	if (upper_32_bits(handle)) {
-		dev_dbg(hdev->dev, "no match for handle 0x%llx\n", handle);
-		return -EINVAL;
-	}
-
-	spin_lock(&vm->idr_lock);
-
-	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, (u32) handle);
-	if (!phys_pg_pack) {
-		spin_unlock(&vm->idr_lock);
-		dev_dbg(hdev->dev, "no match for handle 0x%x\n", (u32) handle);
-		return -EINVAL;
-	}
-
-	/* increment now to avoid freeing device memory while exporting */
-	phys_pg_pack->exporting_cnt++;
-
-	spin_unlock(&vm->idr_lock);
-
-	if (phys_pg_pack->vm_type != VM_TYPE_PHYS_PACK) {
-		dev_dbg(hdev->dev, "handle 0x%llx does not represent DRAM memory\n", handle);
-		rc = -EINVAL;
-		goto err_dec_exporting_cnt;
-	}
-
-	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
-
-		bar_address = hdev->dram_pci_bar_start +
-						(phys_pg_pack->pages[i] -
-						prop->dram_base_address);
-
-		if (bar_address + phys_pg_pack->page_size >
-			hdev->dram_pci_bar_start + prop->dram_pci_bar_size ||
-			bar_address + phys_pg_pack->page_size < bar_address) {
-
-			dev_dbg(hdev->dev,
-				"DRAM memory range 0x%llx (+0x%x) is outside of PCI BAR boundaries\n",
-				phys_pg_pack->pages[i],
-				phys_pg_pack->page_size);
-
-			rc = -EINVAL;
-			goto err_dec_exporting_cnt;
-		}
-	}
-
-	hl_dmabuf = kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
-	if (!hl_dmabuf) {
-		rc = -ENOMEM;
-		goto err_dec_exporting_cnt;
-	}
-
-	hl_dmabuf->phys_pg_pack = phys_pg_pack;
-
-	rc = export_dmabuf_common(ctx, hl_dmabuf, phys_pg_pack->total_size,
-				flags, dmabuf_fd);
+	rc = export_dmabuf(ctx, hl_dmabuf, size, flags, dmabuf_fd);
 	if (rc)
 		goto err_free_dmabuf_wrapper;
 
@@ -1990,12 +1877,6 @@ static int export_dmabuf_from_handle(struct hl_ctx *ctx, u64 handle, int flags,
 
 err_free_dmabuf_wrapper:
 	kfree(hl_dmabuf);
-
-err_dec_exporting_cnt:
-	spin_lock(&vm->idr_lock);
-	phys_pg_pack->exporting_cnt--;
-	spin_unlock(&vm->idr_lock);
-
 	return rc;
 }
 
@@ -2269,13 +2150,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_MEM_OP_EXPORT_DMABUF_FD:
-		if (hdev->asic_prop.dram_supports_virtual_memory)
-			rc = export_dmabuf_from_handle(ctx,
-					args->in.export_dmabuf_fd.handle,
-					args->in.flags,
-					&dmabuf_fd);
-		else
-			rc = export_dmabuf_from_addr(ctx,
+		rc = export_dmabuf_from_addr(ctx,
 					args->in.export_dmabuf_fd.handle,
 					args->in.export_dmabuf_fd.mem_size,
 					args->in.flags,
-- 
2.25.1

