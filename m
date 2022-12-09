Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6826484B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLIPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiLIPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:09:23 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D8984B62
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:09:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 608F17D478;
        Fri,  9 Dec 2022 17:24:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595852;
        bh=7+i79PQnYHIRNgXxZzG17OBZ+fFuR4wpRtbUle891Ho=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mDYejeZnbCXM7rep+dmCcJ16cj3NT0PsbcWvPQVUCjM+ygy9dYmdVM/Bc2llWVbu7
         Zt5lV03BtGY3WmUUS75yI/1PpB+ama5NvHbIHtpLJkjH977G+bvK9X5gIwwUtZQW+8
         Yo+YQA2v8en6rhYU4RjVB7feOCNS3DoZZtBsEWRBB3WSz2n8FxsME59aZNJ1iOoFYl
         p7AHvjLPfQzBr6XxHg/lRQ+/tgwV++3dFNssmzUR1yZ9rtT7kToUF9QdXKkhXWrpvV
         SMQf8BYNtluyEMRJDqYjO2tbNN2wVskNIAQgVgv/v90UsRnJGvx0BDIwpSM7wBo+5c
         qBbbqaa4mg8zg==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:10 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 11/21] block, blksnap: minimum data storage unit of the original block device
Date:   Fri, 9 Dec 2022 15:23:21 +0100
Message-ID: <20221209142331.26395-12-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct chunk describes the minimum data storage unit of the original
block device. Functions for working with these minimal blocks implement
algorithms for reading and writing blocks.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/chunk.c | 345 ++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/chunk.h | 139 ++++++++++++++
 2 files changed, 484 insertions(+)
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h

diff --git a/drivers/block/blksnap/chunk.c b/drivers/block/blksnap/chunk.c
new file mode 100644
index 000000000000..563a6b1612d3
--- /dev/null
+++ b/drivers/block/blksnap/chunk.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-chunk: " fmt
+
+#include <linux/slab.h>
+#include <linux/dm-io.h>
+#include <linux/sched/mm.h>
+#include "params.h"
+#include "chunk.h"
+#include "diff_io.h"
+#include "diff_buffer.h"
+#include "diff_area.h"
+#include "diff_storage.h"
+
+void chunk_diff_buffer_release(struct chunk *chunk)
+{
+	if (unlikely(!chunk->diff_buffer))
+		return;
+
+	chunk_state_unset(chunk, CHUNK_ST_BUFFER_READY);
+	diff_buffer_release(chunk->diff_area, chunk->diff_buffer);
+	chunk->diff_buffer = NULL;
+}
+
+void chunk_store_failed(struct chunk *chunk, int error)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+
+	chunk_state_set(chunk, CHUNK_ST_FAILED);
+	chunk_diff_buffer_release(chunk);
+	diff_storage_free_region(chunk->diff_region);
+	chunk->diff_region = NULL;
+
+	up(&chunk->lock);
+	if (error)
+		diff_area_set_corrupted(diff_area, error);
+};
+
+int chunk_schedule_storing(struct chunk *chunk, bool is_nowait)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+
+	if (WARN(!list_is_first(&chunk->cache_link, &chunk->cache_link),
+		 "The chunk already in the cache"))
+		return -EINVAL;
+
+	if (!chunk->diff_region) {
+		struct diff_region *diff_region;
+
+		diff_region = diff_storage_new_region(
+			diff_area->diff_storage,
+			diff_area_chunk_sectors(diff_area));
+		if (IS_ERR(diff_region)) {
+			pr_debug("Cannot get store for chunk #%ld\n",
+				 chunk->number);
+			return PTR_ERR(diff_region);
+		}
+
+		chunk->diff_region = diff_region;
+	}
+
+	return chunk_async_store_diff(chunk, is_nowait);
+}
+
+void chunk_schedule_caching(struct chunk *chunk)
+{
+	int in_cache_count = 0;
+	struct diff_area *diff_area = chunk->diff_area;
+
+	might_sleep();
+
+	spin_lock(&diff_area->caches_lock);
+
+	/*
+	 * The locked chunk cannot be in the cache.
+	 * If the check reveals that the chunk is in the cache, then something
+	 * is wrong in the algorithm.
+	 */
+	if (WARN(!list_is_first(&chunk->cache_link, &chunk->cache_link),
+		 "The chunk already in the cache")) {
+		spin_unlock(&diff_area->caches_lock);
+
+		chunk_store_failed(chunk, 0);
+		return;
+	}
+
+	if (chunk_state_check(chunk, CHUNK_ST_DIRTY)) {
+		list_add_tail(&chunk->cache_link,
+			      &diff_area->write_cache_queue);
+		in_cache_count =
+			atomic_inc_return(&diff_area->write_cache_count);
+	} else {
+		list_add_tail(&chunk->cache_link, &diff_area->read_cache_queue);
+		in_cache_count =
+			atomic_inc_return(&diff_area->read_cache_count);
+	}
+	spin_unlock(&diff_area->caches_lock);
+
+	up(&chunk->lock);
+
+	/* Initiate the cache clearing process */
+	if ((in_cache_count > chunk_maximum_in_cache) &&
+	    !diff_area_is_corrupted(diff_area))
+		queue_work(system_wq, &diff_area->cache_release_work);
+}
+
+static void chunk_notify_load(void *ctx)
+{
+	struct chunk *chunk = ctx;
+	int error = chunk->diff_io->error;
+
+	diff_io_free(chunk->diff_io);
+	chunk->diff_io = NULL;
+
+	might_sleep();
+
+	if (unlikely(error)) {
+		chunk_store_failed(chunk, error);
+		goto out;
+	}
+
+	if (unlikely(chunk_state_check(chunk, CHUNK_ST_FAILED))) {
+		pr_err("Chunk in a failed state\n");
+		up(&chunk->lock);
+		goto out;
+	}
+
+	if (chunk_state_check(chunk, CHUNK_ST_LOADING)) {
+		int ret;
+		unsigned int current_flag;
+
+		chunk_state_unset(chunk, CHUNK_ST_LOADING);
+		chunk_state_set(chunk, CHUNK_ST_BUFFER_READY);
+
+		current_flag = memalloc_noio_save();
+		ret = chunk_schedule_storing(chunk, false);
+		memalloc_noio_restore(current_flag);
+		if (ret)
+			chunk_store_failed(chunk, ret);
+		goto out;
+	}
+
+	pr_err("invalid chunk state 0x%x\n", atomic_read(&chunk->state));
+	up(&chunk->lock);
+out:
+	atomic_dec(&chunk->diff_area->pending_io_count);
+}
+
+static void chunk_notify_store(void *ctx)
+{
+	struct chunk *chunk = ctx;
+	int error = chunk->diff_io->error;
+
+	diff_io_free(chunk->diff_io);
+	chunk->diff_io = NULL;
+
+	might_sleep();
+
+	if (unlikely(error)) {
+		chunk_store_failed(chunk, error);
+		goto out;
+	}
+
+	if (unlikely(chunk_state_check(chunk, CHUNK_ST_FAILED))) {
+		pr_err("Chunk in a failed state\n");
+		chunk_store_failed(chunk, 0);
+		goto out;
+	}
+	if (chunk_state_check(chunk, CHUNK_ST_STORING)) {
+		chunk_state_unset(chunk, CHUNK_ST_STORING);
+		chunk_state_set(chunk, CHUNK_ST_STORE_READY);
+
+		if (chunk_state_check(chunk, CHUNK_ST_DIRTY)) {
+			/*
+			 * The chunk marked "dirty" was stored in the difference
+			 * storage. Now it is processed in the same way as any
+			 * other stored chunks.
+			 * Therefore, the "dirty" mark can be removed.
+			 */
+			chunk_state_unset(chunk, CHUNK_ST_DIRTY);
+			chunk_diff_buffer_release(chunk);
+		} else {
+			unsigned int current_flag;
+
+			current_flag = memalloc_noio_save();
+			chunk_schedule_caching(chunk);
+			memalloc_noio_restore(current_flag);
+			goto out;
+		}
+	} else
+		pr_err("invalid chunk state 0x%x\n", atomic_read(&chunk->state));
+	up(&chunk->lock);
+out:
+	atomic_dec(&chunk->diff_area->pending_io_count);
+}
+
+struct chunk *chunk_alloc(struct diff_area *diff_area, unsigned long number)
+{
+	struct chunk *chunk;
+
+	chunk = kzalloc(sizeof(struct chunk), GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	INIT_LIST_HEAD(&chunk->cache_link);
+	sema_init(&chunk->lock, 1);
+	chunk->diff_area = diff_area;
+	chunk->number = number;
+	atomic_set(&chunk->state, 0);
+
+	return chunk;
+}
+
+void chunk_free(struct chunk *chunk)
+{
+	if (unlikely(!chunk))
+		return;
+
+	down(&chunk->lock);
+	chunk_diff_buffer_release(chunk);
+	diff_storage_free_region(chunk->diff_region);
+	chunk_state_set(chunk, CHUNK_ST_FAILED);
+	up(&chunk->lock);
+
+	kfree(chunk);
+}
+
+/*
+ * Starts asynchronous storing of a chunk to the  difference storage.
+ */
+int chunk_async_store_diff(struct chunk *chunk, bool is_nowait)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region *region = chunk->diff_region;
+
+	if (WARN(!list_is_first(&chunk->cache_link, &chunk->cache_link),
+		 "The chunk already in the cache"))
+		return -EINVAL;
+
+	diff_io = diff_io_new_async_write(chunk_notify_store, chunk, is_nowait);
+	if (unlikely(!diff_io)) {
+		if (is_nowait)
+			return -EAGAIN;
+		else
+			return -ENOMEM;
+	}
+
+	WARN_ON(chunk->diff_io);
+	chunk->diff_io = diff_io;
+	chunk_state_set(chunk, CHUNK_ST_STORING);
+	atomic_inc(&chunk->diff_area->pending_io_count);
+
+	ret = diff_io_do(chunk->diff_io, region, chunk->diff_buffer, is_nowait);
+	if (ret) {
+		atomic_dec(&chunk->diff_area->pending_io_count);
+		diff_io_free(chunk->diff_io);
+		chunk->diff_io = NULL;
+	}
+
+	return ret;
+}
+
+/*
+ * Starts asynchronous loading of a chunk from the original block device.
+ */
+int chunk_async_load_orig(struct chunk *chunk, const bool is_nowait)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region region = {
+		.bdev = chunk->diff_area->orig_bdev,
+		.sector = (sector_t)(chunk->number) *
+			  diff_area_chunk_sectors(chunk->diff_area),
+		.count = chunk->sector_count,
+	};
+
+	diff_io = diff_io_new_async_read(chunk_notify_load, chunk, is_nowait);
+	if (unlikely(!diff_io)) {
+		if (is_nowait)
+			return -EAGAIN;
+		else
+			return -ENOMEM;
+	}
+
+	WARN_ON(chunk->diff_io);
+	chunk->diff_io = diff_io;
+	chunk_state_set(chunk, CHUNK_ST_LOADING);
+	atomic_inc(&chunk->diff_area->pending_io_count);
+
+	ret = diff_io_do(chunk->diff_io, &region, chunk->diff_buffer, is_nowait);
+	if (ret) {
+		atomic_dec(&chunk->diff_area->pending_io_count);
+		diff_io_free(chunk->diff_io);
+		chunk->diff_io = NULL;
+	}
+	return ret;
+}
+
+/*
+ * Performs synchronous loading of a chunk from the original block device.
+ */
+int chunk_load_orig(struct chunk *chunk)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region region = {
+		.bdev = chunk->diff_area->orig_bdev,
+		.sector = (sector_t)(chunk->number) *
+			  diff_area_chunk_sectors(chunk->diff_area),
+		.count = chunk->sector_count,
+	};
+
+	diff_io = diff_io_new_sync_read();
+	if (unlikely(!diff_io))
+		return -ENOMEM;
+
+	ret = diff_io_do(diff_io, &region, chunk->diff_buffer, false);
+	if (!ret)
+		ret = diff_io->error;
+
+	diff_io_free(diff_io);
+	return ret;
+}
+
+/*
+ * Performs synchronous loading of a chunk from the difference storage.
+ */
+int chunk_load_diff(struct chunk *chunk)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region *region = chunk->diff_region;
+
+	diff_io = diff_io_new_sync_read();
+	if (unlikely(!diff_io))
+		return -ENOMEM;
+
+	ret = diff_io_do(diff_io, region, chunk->diff_buffer, false);
+	if (!ret)
+		ret = diff_io->error;
+
+	diff_io_free(diff_io);
+
+	return ret;
+}
diff --git a/drivers/block/blksnap/chunk.h b/drivers/block/blksnap/chunk.h
new file mode 100644
index 000000000000..6f2350930095
--- /dev/null
+++ b/drivers/block/blksnap/chunk.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_CHUNK_H
+#define __BLK_SNAP_CHUNK_H
+
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+#include <linux/rwsem.h>
+#include <linux/atomic.h>
+
+struct diff_area;
+struct diff_region;
+struct diff_io;
+
+/**
+ * enum chunk_st - Possible states for a chunk.
+ *
+ * @CHUNK_ST_FAILED:
+ *	An error occurred while processing the chunk data.
+ * @CHUNK_ST_DIRTY:
+ *	The chunk is in the dirty state. The chunk is marked dirty in case
+ *	there was a write operation to the snapshot image.
+ *	The flag is removed when the data of the chunk is stored in the
+ *	difference storage.
+ * @CHUNK_ST_BUFFER_READY:
+ *	The data of the chunk is ready to be read from the RAM buffer.
+ *	The flag is removed when a chunk is removed from the cache and its
+ *	buffer is released.
+ * @CHUNK_ST_STORE_READY:
+ *	The data of the chunk has been written to the difference storage.
+ *	The flag cannot be removed.
+ * @CHUNK_ST_LOADING:
+ *	The data is being read from the original block device.
+ *	The flag is replaced with the CHUNK_ST_BUFFER_READY flag.
+ * @CHUNK_ST_STORING:
+ *	The data is being saved to the difference storage.
+ *	The flag is replaced with the CHUNK_ST_STORE_READY flag.
+ *
+ * Chunks life circle.
+ * Copy-on-write when writing to original:
+ *	0 -> LOADING -> BUFFER_READY -> BUFFER_READY | STORING ->
+ *	BUFFER_READY | STORE_READY -> STORE_READY
+ * Write to snapshot image:
+ *	0 -> LOADING -> BUFFER_READY | DIRTY -> DIRTY | STORING ->
+ *	BUFFER_READY | STORE_READY -> STORE_READY
+ */
+enum chunk_st {
+	CHUNK_ST_FAILED = (1 << 0),
+	CHUNK_ST_DIRTY = (1 << 1),
+	CHUNK_ST_BUFFER_READY = (1 << 2),
+	CHUNK_ST_STORE_READY = (1 << 3),
+	CHUNK_ST_LOADING = (1 << 4),
+	CHUNK_ST_STORING = (1 << 5),
+};
+
+/**
+ * struct chunk - Minimum data storage unit.
+ *
+ * @cache_link:
+ *	The list header allows to create caches of chunks.
+ * @diff_area:
+ *	Pointer to the difference area - the storage of changes for a specific device.
+ * @number:
+ *	Sequential number of the chunk.
+ * @sector_count:
+ *	Number of sectors in the current chunk. This is especially true
+ *	for the	last chunk.
+ * @lock:
+ *	Binary semaphore. Syncs access to the chunks fields: state,
+ *	diff_buffer, diff_region and diff_io.
+ * @state:
+ *	Defines the state of a chunk. May contain CHUNK_ST_* bits.
+ * @diff_buffer:
+ *	Pointer to &struct diff_buffer. Describes a buffer in the memory
+ *	for storing the chunk data.
+ * @diff_region:
+ *	Pointer to &struct diff_region. Describes a copy of the chunk data
+ *	on the difference storage.
+ * @diff_io:
+ *	Provides I/O operations for a chunk.
+ *
+ * This structure describes the block of data that the module operates
+ * with when executing the copy-on-write algorithm and when performing I/O
+ * to snapshot images.
+ *
+ * If the data of the chunk has been changed or has just been read, then
+ * the chunk gets into cache.
+ *
+ * The semaphore is blocked for writing if there is no actual data in the
+ * buffer, since a block of data is being read from the original device or
+ * from a diff storage. If data is being read from or written to the
+ * diff_buffer, the semaphore must be locked.
+ */
+struct chunk {
+	struct list_head cache_link;
+	struct diff_area *diff_area;
+
+	unsigned long number;
+	sector_t sector_count;
+
+	struct semaphore lock;
+
+	atomic_t state;
+	struct diff_buffer *diff_buffer;
+	struct diff_region *diff_region;
+	struct diff_io *diff_io;
+};
+
+static inline void chunk_state_set(struct chunk *chunk, int st)
+{
+	atomic_or(st, &chunk->state);
+};
+
+static inline void chunk_state_unset(struct chunk *chunk, int st)
+{
+	atomic_and(~st, &chunk->state);
+};
+
+static inline bool chunk_state_check(struct chunk *chunk, int st)
+{
+	return !!(atomic_read(&chunk->state) & st);
+};
+
+struct chunk *chunk_alloc(struct diff_area *diff_area, unsigned long number);
+void chunk_free(struct chunk *chunk);
+
+int chunk_schedule_storing(struct chunk *chunk, bool is_nowait);
+void chunk_diff_buffer_release(struct chunk *chunk);
+void chunk_store_failed(struct chunk *chunk, int error);
+
+void chunk_schedule_caching(struct chunk *chunk);
+
+/* Asynchronous operations are used to implement the COW algorithm. */
+int chunk_async_store_diff(struct chunk *chunk, bool is_nowait);
+int chunk_async_load_orig(struct chunk *chunk, const bool is_nowait);
+
+/* Synchronous operations are used to implement reading and writing to the snapshot image. */
+int chunk_load_orig(struct chunk *chunk);
+int chunk_load_diff(struct chunk *chunk);
+#endif /* __BLK_SNAP_CHUNK_H */
-- 
2.20.1

