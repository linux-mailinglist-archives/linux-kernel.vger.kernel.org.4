Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F36616901
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKBQba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiKBQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:30 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E902DA9F;
        Wed,  2 Nov 2022 09:27:08 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 466F441CB2;
        Wed,  2 Nov 2022 11:52:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404327;
        bh=7Gy2FlvL/wsrYyYUvsUavGTs6YWl0W4OQ5X0fITrOMM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Hc8/l/DvPHWVlKyIV7mr+y/cQA8a5xbBOpD6qvnVSEKHtmkQa7PP6f69zCN8kjNWG
         e1VkhHeMD6Gzv4h2WfLBCKm7AL7T3chUNlj70kpMutAjxEJw9ujydcXnvRtnrDUWjt
         EeNbZASMp0kpd5zLVus4VUZ8ObKr5DJXlE385HCUTP7g4meSMF4M3W1iEIkLsXHcq3
         oqezaZTAk7ioYsvNaxjX54pJBBNolR1HgyGLitHPqpxKrGGCURBCF0tyxc91KY3N8h
         mqqK34QYUbXRUjMnt9s5uGzyAlpCLV1awjSkqmzrus8mH/plWDqD7Ie0luuKD6mpei
         R7F1r41zml69Q==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:28 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 09/17] lock, blksnap: buffer in memory for the minimum data storage unit
Date:   Wed, 2 Nov 2022 16:50:53 +0100
Message-ID: <20221102155101.4550-10-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221102155101.4550-1-sergei.shtepa@veeam.com>
References: <20221102155101.4550-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155666726A
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct diff_buffer describes a buffer in memory for the minimum data
storage block of the original block device (struct chunk).
Buffer allocation and release functions allow to reduce the number of
allocations and releases of a large number of memory pages.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/diff_buffer.c | 132 ++++++++++++++++++++++++++++
 drivers/block/blksnap/diff_buffer.h |  75 ++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h

diff --git a/drivers/block/blksnap/diff_buffer.c b/drivers/block/blksnap/diff_buffer.c
new file mode 100644
index 000000000000..b24dc7b71e2f
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-buffer: " fmt
+#include "params.h"
+#include "diff_buffer.h"
+#include "diff_area.h"
+
+static void diff_buffer_free(struct diff_buffer *diff_buffer)
+{
+	size_t inx = 0;
+
+	if (unlikely(!diff_buffer))
+		return;
+
+	for (inx = 0; inx < diff_buffer->page_count; inx++) {
+		struct page *page = diff_buffer->pages[inx];
+
+		if (page)
+			__free_page(page);
+	}
+
+	kfree(diff_buffer);
+}
+
+static struct diff_buffer *
+diff_buffer_new(size_t page_count, size_t buffer_size, gfp_t gfp_mask)
+{
+	struct diff_buffer *diff_buffer;
+	size_t inx = 0;
+	struct page *page;
+
+	if (unlikely(page_count <= 0))
+		return NULL;
+
+	/*
+	 * In case of overflow, it is better to get a null pointer
+	 * than a pointer to some memory area. Therefore + 1.
+	 */
+	diff_buffer = kzalloc(sizeof(struct diff_buffer) +
+				      (page_count + 1) * sizeof(struct page *),
+			      gfp_mask);
+	if (!diff_buffer)
+		return NULL;
+
+	INIT_LIST_HEAD(&diff_buffer->link);
+	diff_buffer->size = buffer_size;
+	diff_buffer->page_count = page_count;
+
+	for (inx = 0; inx < page_count; inx++) {
+		page = alloc_page(gfp_mask);
+		if (!page)
+			goto fail;
+
+		diff_buffer->pages[inx] = page;
+	}
+	return diff_buffer;
+fail:
+	diff_buffer_free(diff_buffer);
+	return NULL;
+}
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area,
+				     const bool is_nowait)
+{
+	struct diff_buffer *diff_buffer = NULL;
+	sector_t chunk_sectors;
+	size_t page_count;
+	size_t buffer_size;
+
+	spin_lock(&diff_area->free_diff_buffers_lock);
+	diff_buffer = list_first_entry_or_null(&diff_area->free_diff_buffers,
+					       struct diff_buffer, link);
+	if (diff_buffer) {
+		list_del(&diff_buffer->link);
+		atomic_dec(&diff_area->free_diff_buffers_count);
+	}
+	spin_unlock(&diff_area->free_diff_buffers_lock);
+
+	/* Return free buffer if it was found in a pool */
+	if (diff_buffer)
+		return diff_buffer;
+
+	/* Allocate new buffer */
+	chunk_sectors = diff_area_chunk_sectors(diff_area);
+	page_count = round_up(chunk_sectors, PAGE_SECTORS) / PAGE_SECTORS;
+	buffer_size = chunk_sectors << SECTOR_SHIFT;
+
+	diff_buffer =
+		diff_buffer_new(page_count, buffer_size,
+				is_nowait ? (GFP_NOIO | GFP_NOWAIT) : GFP_NOIO);
+	if (unlikely(!diff_buffer)) {
+		if (is_nowait)
+			return ERR_PTR(-EAGAIN);
+		else
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return diff_buffer;
+}
+
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer)
+{
+	if (atomic_read(&diff_area->free_diff_buffers_count) >
+	    free_diff_buffer_pool_size) {
+		diff_buffer_free(diff_buffer);
+		return;
+	}
+	spin_lock(&diff_area->free_diff_buffers_lock);
+	list_add_tail(&diff_buffer->link, &diff_area->free_diff_buffers);
+	atomic_inc(&diff_area->free_diff_buffers_count);
+	spin_unlock(&diff_area->free_diff_buffers_lock);
+}
+
+void diff_buffer_cleanup(struct diff_area *diff_area)
+{
+	struct diff_buffer *diff_buffer = NULL;
+
+	do {
+		spin_lock(&diff_area->free_diff_buffers_lock);
+		diff_buffer =
+			list_first_entry_or_null(&diff_area->free_diff_buffers,
+						 struct diff_buffer, link);
+		if (diff_buffer) {
+			list_del(&diff_buffer->link);
+			atomic_dec(&diff_area->free_diff_buffers_count);
+		}
+		spin_unlock(&diff_area->free_diff_buffers_lock);
+
+		if (diff_buffer)
+			diff_buffer_free(diff_buffer);
+	} while (diff_buffer);
+}
diff --git a/drivers/block/blksnap/diff_buffer.h b/drivers/block/blksnap/diff_buffer.h
new file mode 100644
index 000000000000..d1ff80452552
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_DIFF_BUFFER_H
+#define __BLK_SNAP_DIFF_BUFFER_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+
+struct diff_area;
+
+/**
+ * struct diff_buffer - Difference buffer.
+ * @link:
+ *	The list header allows to create a pool of the diff_buffer structures.
+ * @size:
+ *	Count of bytes in the buffer.
+ * @page_count:
+ *	The number of pages reserved for the buffer.
+ * @pages:
+ *	An array of pointers to pages.
+ *
+ * Describes the memory buffer for a chunk in the memory.
+ */
+struct diff_buffer {
+	struct list_head link;
+	size_t size;
+	size_t page_count;
+	struct page *pages[0];
+};
+
+/**
+ * struct diff_buffer_iter - Iterator for &struct diff_buffer.
+ * @page:
+ *      A pointer to the current page.
+ * @offset:
+ *      The offset in bytes in the current page.
+ * @bytes:
+ *      The number of bytes that can be read or written from the current page.
+ *
+ * It is convenient to use when copying data from or to &struct bio_vec.
+ */
+struct diff_buffer_iter {
+	struct page *page;
+	size_t offset;
+	size_t bytes;
+};
+
+static inline bool diff_buffer_iter_get(struct diff_buffer *diff_buffer,
+					size_t buff_offset,
+					struct diff_buffer_iter *iter)
+{
+	if (diff_buffer->size <= buff_offset)
+		return false;
+
+	iter->page = diff_buffer->pages[buff_offset >> PAGE_SHIFT];
+	iter->offset = (size_t)(buff_offset & (PAGE_SIZE - 1));
+	/*
+	 * The size cannot exceed the size of the page, taking into account
+	 * the offset in this page.
+	 * But at the same time it is unacceptable to go beyond the allocated
+	 * buffer.
+	 */
+	iter->bytes = min_t(size_t, (PAGE_SIZE - iter->offset),
+			    (diff_buffer->size - buff_offset));
+
+	return true;
+};
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area,
+				     const bool is_nowait);
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer);
+void diff_buffer_cleanup(struct diff_area *diff_area);
+#endif /* __BLK_SNAP_DIFF_BUFFER_H */
-- 
2.20.1

