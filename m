Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5F6D5148
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjDCTY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDCTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:24:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DC42D61;
        Mon,  3 Apr 2023 12:24:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 333JOYr0126980;
        Mon, 3 Apr 2023 14:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680549874;
        bh=lWWl+d3nWMAemXud+JhzKn1WOyt54pVHPHZSkI85Z8A=;
        h=From:To:CC:Subject:Date;
        b=lWT7V/E8lz7Ew0QaceyYfiufCjE7ib4MaqNHZk/WXjFkkqvWYiMYNh163I4B+rd1o
         QjgSRd0zB0Z5GJI+r+KEtf28MbZxEW5HKfFrXJaW0ACbxHBNMoTufd2uyIVIUMvIO1
         FYhxZfk88sWNq48+F7vz2Ncth1miwc/AUFLlzTU4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 333JOYXr105647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Apr 2023 14:24:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 3
 Apr 2023 14:24:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 3 Apr 2023 14:24:34 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 333JOXH9047746;
        Mon, 3 Apr 2023 14:24:33 -0500
From:   Andrew Davis <afd@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
Date:   Mon, 3 Apr 2023 14:24:33 -0500
Message-ID: <20230403192433.26648-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new export type exposes to userspace the SRAM area as a DMA-BUF Heap,
this allows for allocations of DMA-BUFs that can be consumed by various
DMA-BUF supporting devices.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Use existing DT flags, if both pool(device usable) and export(userspace
   usable) properties are in the SRAM node then export as a DMA-BUF Heap
 - Rebase on 6.3-rc5

 drivers/misc/Kconfig         |   7 +
 drivers/misc/Makefile        |   1 +
 drivers/misc/sram-dma-heap.c | 245 +++++++++++++++++++++++++++++++++++
 drivers/misc/sram.c          |   6 +
 drivers/misc/sram.h          |  16 +++
 5 files changed, 275 insertions(+)
 create mode 100644 drivers/misc/sram-dma-heap.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 433aa41977852..8b4c111a6493b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -448,6 +448,13 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config SRAM_DMA_HEAP
+	bool "Export on-chip SRAM pools using DMA-Heaps"
+	depends on DMABUF_HEAPS && SRAM
+	help
+	  This driver allows the export of on-chip SRAM marked as both pool
+	  and exportable to userspace using the DMA-Heaps interface.
+
 config DW_XDATA_PCIE
 	depends on PCI
 	tristate "Synopsys DesignWare xData PCIe driver"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 56de43943cd51..bbdc64aa8af1a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
+obj-$(CONFIG_SRAM_DMA_HEAP)	+= sram-dma-heap.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
new file mode 100644
index 0000000000000..c511f4ac1280e
--- /dev/null
+++ b/drivers/misc/sram-dma-heap.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SRAM DMA-Heap userspace exporter
+ *
+ * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+
+#include "sram.h"
+
+struct sram_dma_heap {
+	struct dma_heap *heap;
+	struct gen_pool *pool;
+};
+
+struct sram_dma_heap_buffer {
+	struct gen_pool *pool;
+	struct list_head attachments;
+	struct mutex attachments_lock;
+	unsigned long len;
+	void *vaddr;
+	phys_addr_t paddr;
+};
+
+struct dma_heap_attachment {
+	struct device *dev;
+	struct sg_table *table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heap_attachment *a;
+	struct sg_table *table;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		kfree(a);
+		return -ENOMEM;
+	}
+	if (sg_alloc_table(table, 1, GFP_KERNEL)) {
+		kfree(table);
+		kfree(a);
+		return -ENOMEM;
+	}
+	sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(buffer->paddr)), buffer->len, 0);
+
+	a->table = table;
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->list);
+
+	attachment->priv = a;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_add(&a->list, &buffer->attachments);
+	mutex_unlock(&buffer->attachments_lock);
+
+	return 0;
+}
+
+static void dma_heap_detatch(struct dma_buf *dmabuf,
+			     struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heap_attachment *a = attachment->priv;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->attachments_lock);
+
+	sg_free_table(a->table);
+	kfree(a->table);
+	kfree(a);
+}
+
+static struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+					     enum dma_data_direction direction)
+{
+	struct dma_heap_attachment *a = attachment->priv;
+	struct sg_table *table = a->table;
+
+	/*
+	 * As this heap is backed by uncached SRAM memory we do not need to
+	 * perform any sync operations on the buffer before allowing device
+	 * domain access. For this reason we use SKIP_CPU_SYNC and also do
+	 * not use or provide begin/end_cpu_access() dma-buf functions.
+	 */
+	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
+			      direction, DMA_ATTR_SKIP_CPU_SYNC))
+		return ERR_PTR(-ENOMEM);
+
+	return table;
+}
+
+static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
+			   direction, DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
+	kfree(buffer);
+}
+
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	int ret;
+
+	/* SRAM mappings are not cached */
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+	ret = vm_iomap_memory(vma, buffer->paddr, buffer->len);
+	if (ret)
+		pr_err("Could not map buffer to userspace\n");
+
+	return ret;
+}
+
+static int dma_heap_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	iosys_map_set_vaddr(map, buffer->vaddr);
+
+	return 0;
+}
+
+static const struct dma_buf_ops sram_dma_heap_buf_ops = {
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detatch,
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.release = dma_heap_dma_buf_release,
+	.mmap = dma_heap_mmap,
+	.vmap = dma_heap_vmap,
+};
+
+struct dma_buf *sram_dma_heap_allocate(struct dma_heap *heap,
+				       unsigned long len,
+				       unsigned long fd_flags,
+				       unsigned long heap_flags)
+{
+	struct sram_dma_heap *sram_dma_heap = dma_heap_get_drvdata(heap);
+	struct sram_dma_heap_buffer *buffer;
+
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	buffer->pool = sram_dma_heap->pool;
+	INIT_LIST_HEAD(&buffer->attachments);
+	mutex_init(&buffer->attachments_lock);
+	buffer->len = len;
+
+	buffer->vaddr = (void *)gen_pool_alloc(buffer->pool, buffer->len);
+	if (!buffer->vaddr) {
+		ret = -ENOMEM;
+		goto free_buffer;
+	}
+
+	buffer->paddr = gen_pool_virt_to_phys(buffer->pool, (unsigned long)buffer->vaddr);
+	if (buffer->paddr == -1) {
+		ret = -ENOMEM;
+		goto free_pool;
+	}
+
+	/* create the dmabuf */
+	exp_info.exp_name = dma_heap_get_name(heap);
+	exp_info.ops = &sram_dma_heap_buf_ops;
+	exp_info.size = buffer->len;
+	exp_info.flags = fd_flags;
+	exp_info.priv = buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pool;
+	}
+
+	return dmabuf;
+
+free_pool:
+	gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
+free_buffer:
+	kfree(buffer);
+
+	return ERR_PTR(ret);
+}
+
+static struct dma_heap_ops sram_dma_heap_ops = {
+	.allocate = sram_dma_heap_allocate,
+};
+
+int sram_add_dma_heap(struct sram_dev *sram,
+		      struct sram_reserve *block,
+		      phys_addr_t start,
+		      struct sram_partition *part)
+{
+	struct sram_dma_heap *sram_dma_heap;
+	struct dma_heap_export_info exp_info;
+
+	dev_info(sram->dev, "Exporting SRAM Heap '%s'\n", block->label);
+
+	sram_dma_heap = kzalloc(sizeof(*sram_dma_heap), GFP_KERNEL);
+	if (!sram_dma_heap)
+		return -ENOMEM;
+	sram_dma_heap->pool = part->pool;
+
+	exp_info.name = kasprintf(GFP_KERNEL, "sram_%s", block->label);
+	exp_info.ops = &sram_dma_heap_ops;
+	exp_info.priv = sram_dma_heap;
+	sram_dma_heap->heap = dma_heap_add(&exp_info);
+	if (IS_ERR(sram_dma_heap->heap)) {
+		int ret = PTR_ERR(sram_dma_heap->heap);
+		kfree(sram_dma_heap);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f0e7f02605eb3..13dcab2062fac 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -120,6 +120,12 @@ static int sram_add_partition(struct sram_dev *sram, struct sram_reserve *block,
 		ret = sram_add_pool(sram, block, start, part);
 		if (ret)
 			return ret;
+
+		if (block->export) {
+			ret = sram_add_dma_heap(sram, block, start, part);
+			if (ret)
+				return ret;
+		}
 	}
 	if (block->export) {
 		ret = sram_add_export(sram, block, start, part);
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index d2058d8c8f1d2..7687c32c09226 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -61,4 +61,20 @@ static inline int sram_add_protect_exec(struct sram_partition *part)
 	return -ENODEV;
 }
 #endif /* CONFIG_SRAM_EXEC */
+
+#ifdef CONFIG_SRAM_DMA_HEAP
+int sram_add_dma_heap(struct sram_dev *sram,
+		      struct sram_reserve *block,
+		      phys_addr_t start,
+		      struct sram_partition *part);
+#else
+static inline int sram_add_dma_heap(struct sram_dev *sram,
+				    struct sram_reserve *block,
+				    phys_addr_t start,
+				    struct sram_partition *part)
+{
+	return 0;
+}
+#endif /* CONFIG_SRAM_DMA_HEAP */
+
 #endif /* __SRAM_H */
-- 
2.39.2

