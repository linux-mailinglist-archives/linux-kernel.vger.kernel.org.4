Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEC6472A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLHPPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLHPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50DABA3A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6257CE24B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9F6C433D6;
        Thu,  8 Dec 2022 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512463;
        bh=dlRx9Apop/1V4GBplL5fbslH6PpSxBLjSz/W4nhyK/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx8oWSPVbymJEIxO33pkweRGTuUHn+Fy2p7Pr/grfSVEL7m0ZnbUssDPVnC+GW5I9
         En0ASp45ky+QZvrCNoDURD2BJhqkN/P3vLl+ryV7/mnwICIUfbsnG6T6GJjV8HJxD6
         82T88TazCDTgAohGiK8JvRsUQE7o6YETd5Z6vEA+od/pkGC7MtgMCZm+FwBnyxLIPL
         OHQZ/rO2Vj8YshAoMOe4MdoBfeFWs6koK8yFj5C5C92VwIw3jDySWHVBvperkipw34
         YpFLRFtA7EWt9NWBMvueZxaneQjnolCY+v4zdeQ5goIlAic98ATePa13Qf4tzDoaJS
         CrLbCEQSFBqRA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 21/26] habanalabs: modify export dmabuf API
Date:   Thu,  8 Dec 2022 17:13:45 +0200
Message-Id: <20221208151350.1833823-21-ogabbay@kernel.org>
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

A previous commit deprecated the option to export from handle, leaving
the code with no support for devices with virtual memory.

This commit modifies the export API in a way that unifies the uAPI to
user address for both cases (i.e. with and without MMU support) and add
the actual support for devices with virtual memory.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |   9 +
 drivers/misc/habanalabs/common/memory.c     | 219 +++++++++++++++++---
 include/uapi/misc/habanalabs.h              |  21 +-
 3 files changed, 218 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e68928b59c1e..ef5a765f3313 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1744,6 +1744,9 @@ struct hl_cs_counters_atomic {
  * struct hl_dmabuf_priv - a dma-buf private object.
  * @dmabuf: pointer to dma-buf object.
  * @ctx: pointer to the dma-buf owner's context.
+ * @phys_pg_pack: pointer to physical page pack if the dma-buf was exported
+ *                where virtual memory is supported.
+ * @memhash_hnode: pointer to the memhash node. this object holds the export count.
  * @device_address: physical address of the device's memory. Relevant only
  *                  if phys_pg_pack is NULL (dma-buf was exported from address).
  *                  The total size can be taken from the dmabuf object.
@@ -1751,6 +1754,8 @@ struct hl_cs_counters_atomic {
 struct hl_dmabuf_priv {
 	struct dma_buf			*dmabuf;
 	struct hl_ctx			*ctx;
+	struct hl_vm_phys_pg_pack	*phys_pg_pack;
+	struct hl_vm_hash_node		*memhash_hnode;
 	uint64_t			device_address;
 };
 
@@ -2078,12 +2083,16 @@ struct hl_cs_parser {
  *				hl_userptr).
  * @node: node to hang on the hash table in context object.
  * @vaddr: key virtual address.
+ * @handle: memory handle for device memory allocation.
  * @ptr: value pointer (hl_vm_phys_pg_list or hl_userptr).
+ * @export_cnt: number of exports from within the VA block.
  */
 struct hl_vm_hash_node {
 	struct hlist_node	node;
 	u64			vaddr;
+	u64			handle;
 	void			*ptr;
+	int			export_cnt;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e3b2e882b037..c7c27ffa6309 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -19,7 +19,9 @@ MODULE_IMPORT_NS(DMA_BUF);
 #define HL_MMU_DEBUG	0
 
 /* use small pages for supporting non-pow2 (32M/40M/48M) DRAM phys page sizes */
-#define DRAM_POOL_PAGE_SIZE SZ_8M
+#define DRAM_POOL_PAGE_SIZE	SZ_8M
+
+#define MEM_HANDLE_INVALID	ULONG_MAX
 
 static int allocate_timestamps_buffers(struct hl_fpriv *hpriv,
 			struct hl_mem_in *args, u64 *handle);
@@ -1234,6 +1236,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 
 	hnode->ptr = vm_type;
 	hnode->vaddr = ret_vaddr;
+	hnode->handle = is_userptr ? MEM_HANDLE_INVALID : handle;
 
 	mutex_lock(&ctx->mem_hash_lock);
 	hash_add(ctx->mem_hash, &hnode->node, ret_vaddr);
@@ -1307,6 +1310,12 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		return -EINVAL;
 	}
 
+	if (hnode->export_cnt) {
+		mutex_unlock(&ctx->mem_hash_lock);
+		dev_err(hdev->dev, "failed to unmap %#llx, memory is exported\n", vaddr);
+		return -EINVAL;
+	}
+
 	hash_del(&hnode->node);
 	mutex_unlock(&ctx->mem_hash_lock);
 
@@ -1694,19 +1703,29 @@ static struct sg_table *hl_map_dmabuf(struct dma_buf_attachment *attachment,
 					enum dma_data_direction dir)
 {
 	struct dma_buf *dma_buf = attachment->dmabuf;
+	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct hl_dmabuf_priv *hl_dmabuf;
 	struct hl_device *hdev;
 	struct sg_table *sgt;
 
 	hl_dmabuf = dma_buf->priv;
 	hdev = hl_dmabuf->ctx->hdev;
+	phys_pg_pack = hl_dmabuf->phys_pg_pack;
 
 	if (!attachment->peer2peer) {
 		dev_dbg(hdev->dev, "Failed to map dmabuf because p2p is disabled\n");
 		return ERR_PTR(-EPERM);
 	}
 
-	sgt = alloc_sgt_from_device_pages(hdev,
+	if (phys_pg_pack)
+		sgt = alloc_sgt_from_device_pages(hdev,
+						phys_pg_pack->pages,
+						phys_pg_pack->npages,
+						phys_pg_pack->page_size,
+						attachment->dev,
+						dir);
+	else
+		sgt = alloc_sgt_from_device_pages(hdev,
 						&hl_dmabuf->device_address,
 						1,
 						hl_dmabuf->dmabuf->size,
@@ -1747,8 +1766,15 @@ static void hl_unmap_dmabuf(struct dma_buf_attachment *attachment,
 static void hl_release_dmabuf(struct dma_buf *dmabuf)
 {
 	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
+	struct hl_ctx *ctx = hl_dmabuf->ctx;
+
+	if (hl_dmabuf->memhash_hnode) {
+		mutex_lock(&ctx->mem_hash_lock);
+		hl_dmabuf->memhash_hnode->export_cnt--;
+		mutex_unlock(&ctx->mem_hash_lock);
+	}
 
-	hl_ctx_put(hl_dmabuf->ctx);
+	hl_ctx_put(ctx);
 	kfree(hl_dmabuf);
 }
 
@@ -1797,11 +1823,8 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	return rc;
 }
 
-static int validate_export_params(struct hl_device *hdev, u64 device_addr, u64 size)
+static int validate_export_params_common(struct hl_device *hdev, u64 device_addr, u64 size)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 bar_address;
-
 	if (!IS_ALIGNED(device_addr, PAGE_SIZE)) {
 		dev_dbg(hdev->dev,
 			"exported device memory address 0x%llx should be aligned to 0x%lx\n",
@@ -1816,6 +1839,19 @@ static int validate_export_params(struct hl_device *hdev, u64 device_addr, u64 s
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int validate_export_params_no_mmu(struct hl_device *hdev, u64 device_addr, u64 size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 bar_address;
+	int rc;
+
+	rc = validate_export_params_common(hdev, device_addr, size);
+	if (rc)
+		return rc;
+
 	if (device_addr < prop->dram_user_base_address ||
 				(device_addr + size) > prop->dram_end_address ||
 				(device_addr + size) < device_addr) {
@@ -1838,12 +1874,115 @@ static int validate_export_params(struct hl_device *hdev, u64 device_addr, u64 s
 	return 0;
 }
 
+static int validate_export_params(struct hl_device *hdev, u64 device_addr, u64 size, u64 offset,
+					struct hl_vm_phys_pg_pack *phys_pg_pack)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 bar_address;
+	int i, rc;
+
+	rc = validate_export_params_common(hdev, device_addr, size);
+	if (rc)
+		return rc;
+
+	if ((offset + size) > phys_pg_pack->total_size) {
+		dev_dbg(hdev->dev, "offset %#llx and size %#llx exceed total map size %#llx\n",
+				offset, size, phys_pg_pack->total_size);
+		return -EINVAL;
+	}
+
+	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
+
+		bar_address = hdev->dram_pci_bar_start +
+					(phys_pg_pack->pages[i] - prop->dram_base_address);
+
+		if ((bar_address + phys_pg_pack->page_size) >
+				(hdev->dram_pci_bar_start + prop->dram_pci_bar_size) ||
+				(bar_address + phys_pg_pack->page_size) < bar_address) {
+			dev_dbg(hdev->dev,
+				"DRAM memory range 0x%llx (+0x%x) is outside of PCI BAR boundaries\n",
+					phys_pg_pack->pages[i],
+					phys_pg_pack->page_size);
+
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static struct hl_vm_hash_node *memhash_node_export_get(struct hl_ctx *ctx, u64 addr)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct hl_vm_hash_node *hnode;
+
+	/* get the memory handle */
+	mutex_lock(&ctx->mem_hash_lock);
+	hash_for_each_possible(ctx->mem_hash, hnode, node, (unsigned long)addr)
+		if (addr == hnode->vaddr)
+			break;
+
+	if (!hnode) {
+		mutex_unlock(&ctx->mem_hash_lock);
+		dev_dbg(hdev->dev, "map address %#llx not found\n", addr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (upper_32_bits(hnode->handle)) {
+		mutex_unlock(&ctx->mem_hash_lock);
+		dev_dbg(hdev->dev, "invalid handle %#llx for map address %#llx\n",
+				hnode->handle, addr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * node found, increase export count so this memory cannot be unmapped
+	 * and the hash node cannot be deleted.
+	 */
+	hnode->export_cnt++;
+	mutex_unlock(&ctx->mem_hash_lock);
+
+	return hnode;
+}
+
+static void memhash_node_export_put(struct hl_ctx *ctx, struct hl_vm_hash_node *hnode)
+{
+	mutex_lock(&ctx->mem_hash_lock);
+	hnode->export_cnt--;
+	mutex_unlock(&ctx->mem_hash_lock);
+}
+
+static struct hl_vm_phys_pg_pack *get_phys_pg_pack_from_hash_node(struct hl_device *hdev,
+							struct hl_vm_hash_node *hnode)
+{
+	struct hl_vm_phys_pg_pack *phys_pg_pack;
+	struct hl_vm *vm = &hdev->vm;
+
+	spin_lock(&vm->idr_lock);
+	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, (u32) hnode->handle);
+	if (!phys_pg_pack) {
+		spin_unlock(&vm->idr_lock);
+		dev_dbg(hdev->dev, "no match for handle 0x%x\n", (u32) hnode->handle);
+		return ERR_PTR(-EINVAL);
+	}
+
+	spin_unlock(&vm->idr_lock);
+
+	if (phys_pg_pack->vm_type != VM_TYPE_PHYS_PACK) {
+		dev_dbg(hdev->dev, "handle 0x%llx does not represent DRAM memory\n", hnode->handle);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return phys_pg_pack;
+}
+
 /**
  * export_dmabuf_from_addr() - export a dma-buf object for the given memory
  *                             address and size.
  * @ctx: pointer to the context structure.
- * @device_addr:  device memory physical address.
- * @size: size of device memory.
+ * @addr: device address.
+ * @size: size of device memory to export.
+ * @offset: the offset into the buffer from which to start exporting
  * @flags: DMA-BUF file/FD flags.
  * @dmabuf_fd: pointer to result FD that represents the dma-buf object.
  *
@@ -1853,37 +1992,66 @@ static int validate_export_params(struct hl_device *hdev, u64 device_addr, u64 s
  *
  * Return: 0 on success, non-zero for failure.
  */
-static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
-					u64 size, int flags, int *dmabuf_fd)
+static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 addr, u64 size, u64 offset,
+					int flags, int *dmabuf_fd)
 {
-	struct hl_dmabuf_priv *hl_dmabuf;
-	struct hl_device *hdev = ctx->hdev;
+	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
+	struct hl_vm_hash_node *hnode = NULL;
 	struct asic_fixed_properties *prop;
+	struct hl_dmabuf_priv *hl_dmabuf;
+	struct hl_device *hdev;
+	u64 export_addr;
 	int rc;
 
+	hdev = ctx->hdev;
 	prop = &hdev->asic_prop;
 
-	if (prop->dram_supports_virtual_memory) {
-		dev_dbg(hdev->dev, "Export not supported for devices with virtual memory\n");
-		return -EOPNOTSUPP;
+	/* offset must be 0 in devices without virtual memory support */
+	if (!prop->dram_supports_virtual_memory && offset) {
+		dev_dbg(hdev->dev, "offset is not allowed in device without virtual memory\n");
+		return -EINVAL;
 	}
 
-	rc = validate_export_params(hdev, device_addr, size);
-	if (rc)
-		return rc;
+	export_addr = addr + offset;
 
 	hl_dmabuf = kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
 	if (!hl_dmabuf)
 		return -ENOMEM;
 
-	hl_dmabuf->device_address = device_addr;
+	if (prop->dram_supports_virtual_memory) {
+		hnode = memhash_node_export_get(ctx, addr);
+		if (IS_ERR(hnode)) {
+			rc = PTR_ERR(hnode);
+			goto err_free_dmabuf_wrapper;
+		}
+		phys_pg_pack = get_phys_pg_pack_from_hash_node(hdev, hnode);
+		if (IS_ERR(phys_pg_pack)) {
+			rc = PTR_ERR(phys_pg_pack);
+			goto dec_memhash_export_cnt;
+		}
+		rc = validate_export_params(hdev, export_addr, size, offset, phys_pg_pack);
+		if (rc)
+			goto dec_memhash_export_cnt;
+
+		hl_dmabuf->phys_pg_pack = phys_pg_pack;
+		hl_dmabuf->memhash_hnode = hnode;
+	} else {
+		rc = validate_export_params_no_mmu(hdev, export_addr, size);
+		if (rc)
+			goto err_free_dmabuf_wrapper;
+	}
+
+	hl_dmabuf->device_address = export_addr;
 
 	rc = export_dmabuf(ctx, hl_dmabuf, size, flags, dmabuf_fd);
 	if (rc)
-		goto err_free_dmabuf_wrapper;
+		goto dec_memhash_export_cnt;
 
 	return 0;
 
+dec_memhash_export_cnt:
+	if (prop->dram_supports_virtual_memory)
+		memhash_node_export_put(ctx, hnode);
 err_free_dmabuf_wrapper:
 	kfree(hl_dmabuf);
 	return rc;
@@ -2160,10 +2328,11 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	case HL_MEM_OP_EXPORT_DMABUF_FD:
 		rc = export_dmabuf_from_addr(ctx,
-					args->in.export_dmabuf_fd.handle,
-					args->in.export_dmabuf_fd.mem_size,
-					args->in.flags,
-					&dmabuf_fd);
+				args->in.export_dmabuf_fd.addr,
+				args->in.export_dmabuf_fd.mem_size,
+				args->in.export_dmabuf_fd.offset,
+				args->in.flags,
+				&dmabuf_fd);
 		memset(args, 0, sizeof(*args));
 		args->out.fd = dmabuf_fd;
 		break;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 3b995e841eb8..c67d18901c1d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1851,15 +1851,24 @@ struct hl_mem_in {
 		/**
 		 * structure for exporting DMABUF object (used with
 		 * the HL_MEM_OP_EXPORT_DMABUF_FD op)
-		 * @handle: handle returned from HL_MEM_OP_ALLOC.
-		 *          in Gaudi, where we don't have MMU for the device memory, the
-		 *          driver expects a physical address (instead of a handle) in the
-		 *          device memory space.
-		 * @mem_size: size of memory allocation. Relevant only for GAUDI
+		 * @addr: for Gaudi1, the driver expects a physical address
+		 *        inside the device's DRAM. this is because in Gaudi1
+		 *        we don't have MMU that covers the device's DRAM.
+		 *        for all other ASICs, the driver expects a device
+		 *        virtual address that represents the start address of
+		 *        a mapped DRAM memory area inside the device.
+		 *        the address must be the same as was received from the
+		 *        driver during a previous HL_MEM_OP_MAP operation.
+		 * @mem_size: size of memory to export.
+		 * @offset: for Gaudi1, this value must be 0. For all other ASICs,
+		 *          the driver expects an offset inside of the memory area
+		 *          describe by addr. the offset represents the start
+		 *          address of that the exported dma-buf object describes.
 		 */
 		struct {
-			__u64 handle;
+			__u64 addr;
 			__u64 mem_size;
+			__u64 offset;
 		} export_dmabuf_fd;
 	};
 
-- 
2.25.1

