Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0836484B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiLIPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiLIPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:09:25 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305284DC9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:09:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id B906ECB7A7;
        Fri,  9 Dec 2022 17:24:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595860;
        bh=AIVeG33ZUk9fK37ESqFDAZ6HQksN5wK2lIAyq37DHHg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kUqEeXnoD3pAk8h5Jjl1UILraQwhWcC0ARfJKZvrLrGqaz1fX5LxOBLb9zyrGAwUg
         gf+AT9iiNVTEfhoCTKnQFD8IZ6tVhRDWWVSF+uYpiAS9Q/ciMyfoPfDa0gRdOMg/k0
         OohgXPaJGm639+AKtQGCFGAKVtq30aanwYKCE3BFRYsANFeGMge6nEiSjWPxem4UoR
         ZvqDejgksmFL1Z8goXejhHNpaP7GabjTrfpBZ2GgLrw/eAu2yqHUB7WKNUgQf22QcW
         DT0LW5SfyyXZiZjgiFuTu1ambRJrPl7KmX1X7UXBQKhdlPRuxDlFK8lTVOKq6GNF4o
         RmR3QhKMNuVzg==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:18 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 16/21] block, blksnap: owner of information about overwritten blocks of the original block device
Date:   Fri, 9 Dec 2022 15:23:26 +0100
Message-ID: <20221209142331.26395-17-sergei.shtepa@veeam.com>
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

This is perhaps the key component of the module. It stores information
about the modified blocks of the original device and the location of the
regions where these blocks are stored in the difference storage.
This information allows to restore the state of the block device at the
time of taking the snapshot and represent the snapshot image as a block
device.
When reading from a snapshot, if the block on the original device has
not yet been changed since the snapshot was taken, then the data is read
from the original block device. If the data on the original block device
has been overwritten, then the block is read from the difference
storage. Reads and writes are performed with minimal data storage blocks
(struct chunk).

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/diff_area.c | 655 ++++++++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h | 177 ++++++++
 2 files changed, 832 insertions(+)
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h

diff --git a/drivers/block/blksnap/diff_area.c b/drivers/block/blksnap/diff_area.c
new file mode 100644
index 000000000000..7fd2d66b5f47
--- /dev/null
+++ b/drivers/block/blksnap/diff_area.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-area: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <uapi/linux/blksnap.h>
+#include "params.h"
+#include "chunk.h"
+#include "diff_area.h"
+#include "diff_buffer.h"
+#include "diff_storage.h"
+#include "diff_io.h"
+
+static inline unsigned long chunk_number(struct diff_area *diff_area,
+					 sector_t sector)
+{
+	return (unsigned long)(sector >>
+			       (diff_area->chunk_shift - SECTOR_SHIFT));
+};
+
+static inline sector_t chunk_sector(struct chunk *chunk)
+{
+	return (sector_t)(chunk->number)
+	       << (chunk->diff_area->chunk_shift - SECTOR_SHIFT);
+}
+
+static inline void recalculate_last_chunk_size(struct chunk *chunk)
+{
+	sector_t capacity;
+
+	capacity = bdev_nr_sectors(chunk->diff_area->orig_bdev);
+	if (capacity > round_down(capacity, chunk->sector_count))
+		chunk->sector_count =
+			capacity - round_down(capacity, chunk->sector_count);
+}
+
+static inline unsigned long long count_by_shift(sector_t capacity,
+						unsigned long long shift)
+{
+	unsigned long long shift_sector = (shift - SECTOR_SHIFT);
+
+	return round_up(capacity, (1ull << shift_sector)) >> shift_sector;
+}
+
+static void diff_area_calculate_chunk_size(struct diff_area *diff_area)
+{
+	unsigned long long shift = chunk_minimum_shift;
+	unsigned long long count;
+	sector_t capacity;
+	sector_t min_io_sect;
+
+	min_io_sect = (sector_t)(bdev_io_min(diff_area->orig_bdev) >>
+		SECTOR_SHIFT);
+	capacity = bdev_nr_sectors(diff_area->orig_bdev);
+	pr_debug("Minimal IO block %llu sectors\n", min_io_sect);
+	pr_debug("Device capacity %llu sectors\n", capacity);
+
+	count = count_by_shift(capacity, shift);
+	pr_debug("Chunks count %llu\n", count);
+	while ((count > chunk_maximum_count) ||
+		((1ull << (shift - SECTOR_SHIFT)) < min_io_sect)) {
+		shift = shift + 1ull;
+		count = count_by_shift(capacity, shift);
+		pr_debug("Chunks count %llu\n", count);
+	}
+
+	diff_area->chunk_shift = shift;
+	diff_area->chunk_count = count;
+
+	pr_debug("The optimal chunk size was calculated as %llu bytes for device [%d:%d]\n",
+		 (1ull << diff_area->chunk_shift),
+		 MAJOR(diff_area->orig_bdev->bd_dev),
+		 MINOR(diff_area->orig_bdev->bd_dev));
+}
+
+void diff_area_free(struct kref *kref)
+{
+	unsigned long inx = 0;
+	u64 start_waiting;
+	struct chunk *chunk;
+	struct diff_area *diff_area =
+		container_of(kref, struct diff_area, kref);
+
+	might_sleep();
+	start_waiting = jiffies_64;
+	while (atomic_read(&diff_area->pending_io_count)) {
+		schedule_timeout_interruptible(1);
+		if (jiffies_64 > (start_waiting + HZ)) {
+			start_waiting = jiffies_64;
+			inx++;
+			pr_warn("Waiting for pending I/O to complete\n");
+			if (inx > 5) {
+				pr_err("Failed to complete pending I/O\n");
+				break;
+			}
+		}
+	}
+
+	atomic_set(&diff_area->corrupt_flag, 1);
+	flush_work(&diff_area->cache_release_work);
+	xa_for_each(&diff_area->chunk_map, inx, chunk)
+		chunk_free(chunk);
+	xa_destroy(&diff_area->chunk_map);
+
+	if (diff_area->orig_bdev) {
+		blkdev_put(diff_area->orig_bdev, FMODE_READ | FMODE_WRITE);
+		diff_area->orig_bdev = NULL;
+	}
+
+	/* Clean up free_diff_buffers */
+	diff_buffer_cleanup(diff_area);
+
+	kfree(diff_area);
+}
+
+static inline struct chunk *
+get_chunk_from_cache_and_write_lock(spinlock_t *caches_lock,
+				    struct list_head *cache_queue,
+				    atomic_t *cache_count)
+{
+	struct chunk *iter;
+	struct chunk *chunk = NULL;
+
+	spin_lock(caches_lock);
+	list_for_each_entry(iter, cache_queue, cache_link) {
+		if (!down_trylock(&iter->lock)) {
+			chunk = iter;
+			break;
+		}
+		/*
+		 * If it is not possible to lock a chunk for writing,
+		 * then it is currently in use, and we try to clean up the
+		 * next chunk.
+		 */
+	}
+	if (likely(chunk)) {
+		atomic_dec(cache_count);
+		list_del_init(&chunk->cache_link);
+	}
+	spin_unlock(caches_lock);
+
+	return chunk;
+}
+
+static struct chunk *
+diff_area_get_chunk_from_cache_and_write_lock(struct diff_area *diff_area)
+{
+	struct chunk *chunk;
+
+	if (atomic_read(&diff_area->read_cache_count) >
+	    chunk_maximum_in_cache) {
+		chunk = get_chunk_from_cache_and_write_lock(
+			&diff_area->caches_lock, &diff_area->read_cache_queue,
+			&diff_area->read_cache_count);
+		if (chunk)
+			return chunk;
+	}
+
+	if (atomic_read(&diff_area->write_cache_count) >
+	    chunk_maximum_in_cache) {
+		chunk = get_chunk_from_cache_and_write_lock(
+			&diff_area->caches_lock, &diff_area->write_cache_queue,
+			&diff_area->write_cache_count);
+		if (chunk)
+			return chunk;
+	}
+
+	return NULL;
+}
+
+static void diff_area_cache_release(struct diff_area *diff_area)
+{
+	struct chunk *chunk;
+
+	while (!diff_area_is_corrupted(diff_area) &&
+	       (chunk = diff_area_get_chunk_from_cache_and_write_lock(
+			diff_area))) {
+		/*
+		 * There cannot be a chunk in the cache whose buffer is
+		 * not ready.
+		 */
+		if (WARN(!chunk_state_check(chunk, CHUNK_ST_BUFFER_READY),
+			 "Cannot release empty buffer for chunk #%ld",
+			 chunk->number)) {
+			up(&chunk->lock);
+			continue;
+		}
+
+		if (chunk_state_check(chunk, CHUNK_ST_DIRTY)) {
+			int ret = chunk_schedule_storing(chunk, false);
+
+			if (ret)
+				chunk_store_failed(chunk, ret);
+		} else {
+			chunk_diff_buffer_release(chunk);
+			up(&chunk->lock);
+		}
+	}
+}
+
+static void diff_area_cache_release_work(struct work_struct *work)
+{
+	struct diff_area *diff_area =
+		container_of(work, struct diff_area, cache_release_work);
+
+	diff_area_cache_release(diff_area);
+}
+
+struct diff_area *diff_area_new(dev_t dev_id, struct diff_storage *diff_storage)
+{
+	int ret = 0;
+	struct diff_area *diff_area = NULL;
+	struct block_device *bdev;
+	unsigned long number;
+	struct chunk *chunk;
+
+	pr_debug("Open device [%u:%u]\n", MAJOR(dev_id), MINOR(dev_id));
+
+	bdev = blkdev_get_by_dev(dev_id, FMODE_READ | FMODE_WRITE, NULL);
+	if (IS_ERR(bdev)) {
+		int err = PTR_ERR(bdev);
+
+		pr_err("Failed to open device. errno=%d\n", abs(err));
+		return ERR_PTR(err);
+	}
+
+	diff_area = kzalloc(sizeof(struct diff_area), GFP_KERNEL);
+	if (!diff_area) {
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	diff_area->orig_bdev = bdev;
+	diff_area->diff_storage = diff_storage;
+
+	diff_area_calculate_chunk_size(diff_area);
+	pr_debug("Chunk size %llu in bytes\n", 1ull << diff_area->chunk_shift);
+	pr_debug("Chunk count %lu\n", diff_area->chunk_count);
+
+	kref_init(&diff_area->kref);
+	xa_init(&diff_area->chunk_map);
+
+	if (!diff_storage->capacity) {
+		pr_err("Difference storage is empty.\n");
+		pr_err("In-memory difference storage is not supported");
+		return ERR_PTR(-EFAULT);
+	}
+
+	spin_lock_init(&diff_area->caches_lock);
+	INIT_LIST_HEAD(&diff_area->read_cache_queue);
+	atomic_set(&diff_area->read_cache_count, 0);
+	INIT_LIST_HEAD(&diff_area->write_cache_queue);
+	atomic_set(&diff_area->write_cache_count, 0);
+	INIT_WORK(&diff_area->cache_release_work, diff_area_cache_release_work);
+
+	spin_lock_init(&diff_area->free_diff_buffers_lock);
+	INIT_LIST_HEAD(&diff_area->free_diff_buffers);
+	atomic_set(&diff_area->free_diff_buffers_count, 0);
+
+	atomic_set(&diff_area->corrupt_flag, 0);
+	atomic_set(&diff_area->pending_io_count, 0);
+
+	/**
+	 * Allocating all chunks in advance allows to avoid doing this in
+	 * the process of filtering bio.
+	 * In addition, the chunk structure has an rw semaphore that allows
+	 * to lock data of a single chunk.
+	 * Different threads can read, write, or dump their data to diff storage
+	 * independently of each other, provided that different chunks are used.
+	 */
+	for (number = 0; number < diff_area->chunk_count; number++) {
+		chunk = chunk_alloc(diff_area, number);
+		if (!chunk) {
+			pr_err("Failed allocate chunk\n");
+			ret = -ENOMEM;
+			break;
+		}
+		chunk->sector_count = diff_area_chunk_sectors(diff_area);
+
+		ret = xa_insert(&diff_area->chunk_map, number, chunk,
+				GFP_KERNEL);
+		if (ret) {
+			pr_err("Failed insert chunk to chunk map\n");
+			chunk_free(chunk);
+			break;
+		}
+	}
+	if (ret) {
+		diff_area_put(diff_area);
+		return ERR_PTR(ret);
+	}
+
+	recalculate_last_chunk_size(chunk);
+
+	atomic_set(&diff_area->corrupt_flag, 0);
+
+	return diff_area;
+}
+
+static void diff_area_take_chunk_from_cache(struct diff_area *diff_area,
+					    struct chunk *chunk)
+{
+	spin_lock(&diff_area->caches_lock);
+	if (!list_is_first(&chunk->cache_link, &chunk->cache_link)) {
+		list_del_init(&chunk->cache_link);
+
+		if (chunk_state_check(chunk, CHUNK_ST_DIRTY))
+			atomic_dec(&diff_area->write_cache_count);
+		else
+			atomic_dec(&diff_area->read_cache_count);
+	}
+	spin_unlock(&diff_area->caches_lock);
+}
+
+/*
+ * Implements the copy-on-write mechanism.
+ */
+int diff_area_copy(struct diff_area *diff_area, sector_t sector, sector_t count,
+		   const bool is_nowait)
+{
+	int ret = 0;
+	sector_t offset;
+	struct chunk *chunk;
+	struct diff_buffer *diff_buffer;
+	sector_t area_sect_first;
+	sector_t chunk_sectors = diff_area_chunk_sectors(diff_area);
+
+	area_sect_first = round_down(sector, chunk_sectors);
+	for (offset = area_sect_first; offset < (sector + count);
+	     offset += chunk_sectors) {
+		chunk = xa_load(&diff_area->chunk_map,
+				chunk_number(diff_area, offset));
+		if (!chunk) {
+			diff_area_set_corrupted(diff_area, -EINVAL);
+			return -EINVAL;
+		}
+		WARN_ON(chunk_number(diff_area, offset) != chunk->number);
+		if (is_nowait) {
+			if (down_trylock(&chunk->lock))
+				return -EAGAIN;
+		} else {
+			ret = down_killable(&chunk->lock);
+			if (unlikely(ret))
+				return ret;
+		}
+
+		if (chunk_state_check(chunk, CHUNK_ST_FAILED | CHUNK_ST_DIRTY |
+						     CHUNK_ST_STORE_READY)) {
+			/*
+			 * The chunk has already been:
+			 * - Failed, when the snapshot is corrupted
+			 * - Overwritten in the snapshot image
+			 * - Already stored in the diff storage
+			 */
+			up(&chunk->lock);
+			continue;
+		}
+
+		if (unlikely(chunk_state_check(
+			    chunk, CHUNK_ST_LOADING | CHUNK_ST_STORING))) {
+			pr_err("Invalid chunk state\n");
+			ret = -EFAULT;
+			goto fail_unlock_chunk;
+		}
+
+		if (chunk_state_check(chunk, CHUNK_ST_BUFFER_READY)) {
+			diff_area_take_chunk_from_cache(diff_area, chunk);
+			/*
+			 * The chunk has already been read, but now we need
+			 * to store it to diff_storage.
+			 */
+			ret = chunk_schedule_storing(chunk, is_nowait);
+			if (unlikely(ret))
+				goto fail_unlock_chunk;
+		} else {
+			diff_buffer =
+				diff_buffer_take(chunk->diff_area, is_nowait);
+			if (IS_ERR(diff_buffer)) {
+				ret = PTR_ERR(diff_buffer);
+				goto fail_unlock_chunk;
+			}
+			WARN(chunk->diff_buffer, "Chunks buffer has been lost");
+			chunk->diff_buffer = diff_buffer;
+
+			ret = chunk_async_load_orig(chunk, is_nowait);
+			if (unlikely(ret))
+				goto fail_unlock_chunk;
+		}
+	}
+
+	return ret;
+fail_unlock_chunk:
+	WARN_ON(!chunk);
+	chunk_store_failed(chunk, ret);
+	return ret;
+}
+
+int diff_area_wait(struct diff_area *diff_area, sector_t sector, sector_t count,
+		   const bool is_nowait)
+{
+	int ret = 0;
+	sector_t offset;
+	struct chunk *chunk;
+	sector_t area_sect_first;
+	sector_t chunk_sectors = diff_area_chunk_sectors(diff_area);
+
+	area_sect_first = round_down(sector, chunk_sectors);
+	for (offset = area_sect_first; offset < (sector + count);
+	     offset += chunk_sectors) {
+		chunk = xa_load(&diff_area->chunk_map,
+				chunk_number(diff_area, offset));
+		if (!chunk) {
+			diff_area_set_corrupted(diff_area, -EINVAL);
+			return -EINVAL;
+		}
+		WARN_ON(chunk_number(diff_area, offset) != chunk->number);
+		if (is_nowait) {
+			if (down_trylock(&chunk->lock))
+				return -EAGAIN;
+		} else {
+			ret = down_killable(&chunk->lock);
+			if (unlikely(ret))
+				return ret;
+		}
+
+		if (chunk_state_check(chunk, CHUNK_ST_FAILED)) {
+			/*
+			 * The chunk has already been:
+			 * - Failed, when the snapshot is corrupted
+			 * - Overwritten in the snapshot image
+			 * - Already stored in the diff storage
+			 */
+			up(&chunk->lock);
+			ret = -EFAULT;
+			break;
+		}
+
+		if (chunk_state_check(chunk, CHUNK_ST_BUFFER_READY |
+				      CHUNK_ST_DIRTY | CHUNK_ST_STORE_READY)) {
+			/*
+			 * The chunk has already been:
+			 * - Read
+			 * - Overwritten in the snapshot image
+			 * - Already stored in the diff storage
+			 */
+			up(&chunk->lock);
+			continue;
+		}
+	}
+
+	return ret;
+}
+
+static inline void diff_area_image_put_chunk(struct chunk *chunk, bool is_write)
+{
+	if (is_write) {
+		/*
+		 * Since the chunk was taken to perform writing,
+		 * we mark it as dirty.
+		 */
+		chunk_state_set(chunk, CHUNK_ST_DIRTY);
+	}
+
+	chunk_schedule_caching(chunk);
+}
+
+void diff_area_image_ctx_done(struct diff_area_image_ctx *io_ctx)
+{
+	if (!io_ctx->chunk)
+		return;
+
+	diff_area_image_put_chunk(io_ctx->chunk, io_ctx->is_write);
+}
+
+static int diff_area_load_chunk_from_storage(struct diff_area *diff_area,
+					     struct chunk *chunk)
+{
+	struct diff_buffer *diff_buffer;
+
+	diff_buffer = diff_buffer_take(diff_area, false);
+	if (IS_ERR(diff_buffer))
+		return PTR_ERR(diff_buffer);
+
+	WARN_ON(chunk->diff_buffer);
+	chunk->diff_buffer = diff_buffer;
+
+	if (chunk_state_check(chunk, CHUNK_ST_STORE_READY))
+		return chunk_load_diff(chunk);
+
+	return chunk_load_orig(chunk);
+}
+
+static struct chunk *
+diff_area_image_context_get_chunk(struct diff_area_image_ctx *io_ctx,
+				  sector_t sector)
+{
+	int ret;
+	struct chunk *chunk;
+	struct diff_area *diff_area = io_ctx->diff_area;
+	unsigned long new_chunk_number = chunk_number(diff_area, sector);
+
+	chunk = io_ctx->chunk;
+	if (chunk) {
+		if (chunk->number == new_chunk_number)
+			return chunk;
+
+		/*
+		 * If the sector falls into a new chunk, then we release
+		 * the old chunk.
+		 */
+		diff_area_image_put_chunk(chunk, io_ctx->is_write);
+		io_ctx->chunk = NULL;
+	}
+
+	/* Take a next chunk. */
+	chunk = xa_load(&diff_area->chunk_map, new_chunk_number);
+	if (unlikely(!chunk))
+		return ERR_PTR(-EINVAL);
+
+	ret = down_killable(&chunk->lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (unlikely(chunk_state_check(chunk, CHUNK_ST_FAILED))) {
+		pr_err("Chunk #%ld corrupted\n", chunk->number);
+
+		pr_debug("new_chunk_number=%ld\n", new_chunk_number);
+		pr_debug("sector=%llu\n", sector);
+		pr_debug("Chunk size %llu in bytes\n",
+		       (1ull << diff_area->chunk_shift));
+		pr_debug("Chunk count %lu\n", diff_area->chunk_count);
+
+		ret = -EIO;
+		goto fail_unlock_chunk;
+	}
+
+	/*
+	 * If there is already data in the buffer, then nothing needs to be loaded.
+	 * Otherwise, the chunk needs to be loaded from the original device or
+	 * from the difference storage.
+	 */
+	if (!chunk_state_check(chunk, CHUNK_ST_BUFFER_READY)) {
+		ret = diff_area_load_chunk_from_storage(diff_area, chunk);
+		if (unlikely(ret))
+			goto fail_unlock_chunk;
+
+		/* Set the flag that the buffer contains the required data. */
+		chunk_state_set(chunk, CHUNK_ST_BUFFER_READY);
+	} else
+		diff_area_take_chunk_from_cache(diff_area, chunk);
+
+	io_ctx->chunk = chunk;
+	return chunk;
+
+fail_unlock_chunk:
+	pr_err("Failed to load chunk #%ld\n", chunk->number);
+	up(&chunk->lock);
+	return ERR_PTR(ret);
+}
+
+static inline sector_t diff_area_chunk_start(struct diff_area *diff_area,
+					     struct chunk *chunk)
+{
+	return (sector_t)(chunk->number) << diff_area->chunk_shift;
+}
+
+/*
+ * Implements copying data from the chunk to bio_vec when reading or from
+ * bio_vec to the chunk when writing.
+ */
+blk_status_t diff_area_image_io(struct diff_area_image_ctx *io_ctx,
+				const struct bio_vec *bvec, sector_t *pos)
+{
+	unsigned int bv_len = bvec->bv_len;
+	struct iov_iter iter;
+
+	iov_iter_bvec(&iter, io_ctx->is_write ? WRITE : READ, bvec, 1, bv_len);
+
+	while (bv_len) {
+		struct diff_buffer_iter diff_buffer_iter;
+		struct chunk *chunk;
+		size_t buff_offset;
+
+		chunk = diff_area_image_context_get_chunk(io_ctx, *pos);
+		if (IS_ERR(chunk))
+			return BLK_STS_IOERR;
+
+		buff_offset = (size_t)(*pos - chunk_sector(chunk))
+				<< SECTOR_SHIFT;
+		while (bv_len &&
+		       diff_buffer_iter_get(chunk->diff_buffer, buff_offset,
+					    &diff_buffer_iter)) {
+			size_t sz;
+
+			if (io_ctx->is_write)
+				sz = copy_page_from_iter(
+					diff_buffer_iter.page,
+					diff_buffer_iter.offset,
+					diff_buffer_iter.bytes,
+					&iter);
+			else
+				sz = copy_page_to_iter(
+					diff_buffer_iter.page,
+					diff_buffer_iter.offset,
+					diff_buffer_iter.bytes,
+					&iter);
+			if (!sz)
+				return BLK_STS_IOERR;
+
+			buff_offset += sz;
+			*pos += (sz >> SECTOR_SHIFT);
+			bv_len -= sz;
+		}
+	}
+
+	return BLK_STS_OK;
+}
+
+static inline void diff_area_event_corrupted(struct diff_area *diff_area,
+					     int err_code)
+{
+	struct blk_snap_event_corrupted data = {
+		.orig_dev_id.mj = MAJOR(diff_area->orig_bdev->bd_dev),
+		.orig_dev_id.mn = MINOR(diff_area->orig_bdev->bd_dev),
+		.err_code = abs(err_code),
+	};
+
+	event_gen(&diff_area->diff_storage->event_queue, GFP_NOIO,
+		  blk_snap_event_code_corrupted, &data,
+		  sizeof(struct blk_snap_event_corrupted));
+}
+
+void diff_area_set_corrupted(struct diff_area *diff_area, int err_code)
+{
+	if (atomic_inc_return(&diff_area->corrupt_flag) != 1)
+		return;
+
+	diff_area_event_corrupted(diff_area, err_code);
+
+	pr_err("Set snapshot device is corrupted for [%u:%u] with error code %d\n",
+	       MAJOR(diff_area->orig_bdev->bd_dev),
+	       MINOR(diff_area->orig_bdev->bd_dev), abs(err_code));
+}
+
+void diff_area_throttling_io(struct diff_area *diff_area)
+{
+	u64 start_waiting;
+
+	start_waiting = jiffies_64;
+	while (atomic_read(&diff_area->pending_io_count)) {
+		schedule_timeout_interruptible(0);
+		if (jiffies_64 > (start_waiting + HZ / 10))
+			break;
+	}
+}
diff --git a/drivers/block/blksnap/diff_area.h b/drivers/block/blksnap/diff_area.h
new file mode 100644
index 000000000000..13cdbfc369fb
--- /dev/null
+++ b/drivers/block/blksnap/diff_area.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_DIFF_AREA_H
+#define __BLK_SNAP_DIFF_AREA_H
+
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/xarray.h>
+#include "event_queue.h"
+
+struct diff_storage;
+struct chunk;
+
+/**
+ * struct diff_area - Discribes the difference area for one original device.
+ * @kref:
+ *	The reference counter. The &struct diff_area can be shared between
+ *	the &struct tracker and &struct snapimage.
+ * @orig_bdev:
+ *	A pointer to the structure of an opened block device.
+ * @diff_storage:
+ *	Pointer to difference storage for storing difference data.
+ * @chunk_shift:
+ *	Power of 2 used to specify the chunk size. This allows to set different chunk sizes for
+ *	huge and small block devices.
+ * @chunk_count:
+ *	Count of chunks. The number of chunks into which the block device
+ *	is divided.
+ * @chunk_map:
+ *	A map of chunks.
+ * @caches_lock:
+ *	This spinlock guarantees consistency of the linked lists of chunk
+ *	caches.
+ * @read_cache_queue:
+ *	Queue for the read cache.
+ * @read_cache_count:
+ *	The number of chunks in the read cache.
+ * @write_cache_queue:
+ *	Queue for the write cache.
+ * @write_cache_count:
+ *	The number of chunks in the write cache.
+ * @cache_release_work:
+ *	The workqueue work item. This worker limits the number of chunks
+ *	that store their data in RAM.
+ * @free_diff_buffers_lock:
+ *	This spinlock guarantees consistency of the linked lists of
+ *	free difference buffers.
+ * @free_diff_buffers:
+ *	Linked list of free difference buffers allows to reduce the number
+ *	of buffer allocation and release operations.
+ * @free_diff_buffers_count:
+ *	The number of free difference buffers in the linked list.
+ * @corrupt_flag:
+ *	The flag is set if an error occurred in the operation of the data
+ *	saving mechanism in the diff area. In this case, an error will be
+ *	generated when reading from the snapshot image.
+ * @pending_io_count:
+ *	Counter of incomplete I/O operations. Allows to wait for all I/O
+ *	operations to be completed before releasing this structure.
+ *
+ * The &struct diff_area is created for each block device in the snapshot.
+ * It is used to save the differences between the original block device and
+ * the snapshot image. That is, when writing data to the original device,
+ * the differences are copied as chunks to the difference storage.
+ * Reading and writing from the snapshot image is also performed using
+ * &struct diff_area.
+ *
+ * The xarray has a limit on the maximum size. This can be especially
+ * noticeable on 32-bit systems. This creates a limit in the size of
+ * supported disks.
+ *
+ * For example, for a 256 TiB disk with a block size of 65536 bytes, the
+ * number of elements in the chunk map will be equal to 2 with a power of 32.
+ * Therefore, the number of chunks into which the block device is divided is
+ * limited.
+ *
+ * To provide high performance, a read cache and a write cache for chunks are
+ * used. The cache algorithm is the simplest. If the data of the chunk was
+ * read to the difference buffer, then the buffer is not released immediately,
+ * but is placed at the end of the queue. The worker thread checks the number
+ * of chunks in the queue and releases a difference buffer for the first chunk
+ * in the queue, but only if the binary semaphore of the chunk is not locked.
+ * If the read thread accesses the chunk from the cache again, it returns
+ * back to the end of the queue.
+ *
+ * The linked list of difference buffers allows to have a certain number of
+ * "hot" buffers. This allows to reduce the number of allocations and releases
+ * of memory.
+ *
+ *
+ */
+struct diff_area {
+	struct kref kref;
+
+	struct block_device *orig_bdev;
+	struct diff_storage *diff_storage;
+
+	unsigned long long chunk_shift;
+	unsigned long chunk_count;
+	struct xarray chunk_map;
+
+	spinlock_t caches_lock;
+	struct list_head read_cache_queue;
+	atomic_t read_cache_count;
+	struct list_head write_cache_queue;
+	atomic_t write_cache_count;
+	struct work_struct cache_release_work;
+
+	spinlock_t free_diff_buffers_lock;
+	struct list_head free_diff_buffers;
+	atomic_t free_diff_buffers_count;
+
+	atomic_t corrupt_flag;
+	atomic_t pending_io_count;
+};
+
+struct diff_area *diff_area_new(dev_t dev_id,
+				struct diff_storage *diff_storage);
+void diff_area_free(struct kref *kref);
+static inline void diff_area_get(struct diff_area *diff_area)
+{
+	kref_get(&diff_area->kref);
+};
+static inline void diff_area_put(struct diff_area *diff_area)
+{
+	if (likely(diff_area))
+		kref_put(&diff_area->kref, diff_area_free);
+};
+void diff_area_set_corrupted(struct diff_area *diff_area, int err_code);
+static inline bool diff_area_is_corrupted(struct diff_area *diff_area)
+{
+	return !!atomic_read(&diff_area->corrupt_flag);
+};
+static inline sector_t diff_area_chunk_sectors(struct diff_area *diff_area)
+{
+	return (sector_t)(1ull << (diff_area->chunk_shift - SECTOR_SHIFT));
+};
+int diff_area_copy(struct diff_area *diff_area, sector_t sector, sector_t count,
+		   const bool is_nowait);
+
+int diff_area_wait(struct diff_area *diff_area, sector_t sector, sector_t count,
+		   const bool is_nowait);
+/**
+ * struct diff_area_image_ctx - The context for processing an io request to
+ *	the snapshot image.
+ * @diff_area:
+ *	Pointer to &struct diff_area for the current snapshot image.
+ * @is_write:
+ *	Distinguishes between the behavior of reading or writing when
+ *	processing a request.
+ * @chunk:
+ *	Current chunk.
+ */
+struct diff_area_image_ctx {
+	struct diff_area *diff_area;
+	bool is_write;
+	struct chunk *chunk;
+};
+
+static inline void diff_area_image_ctx_init(struct diff_area_image_ctx *io_ctx,
+					    struct diff_area *diff_area,
+					    bool is_write)
+{
+	io_ctx->diff_area = diff_area;
+	io_ctx->is_write = is_write;
+	io_ctx->chunk = NULL;
+};
+void diff_area_image_ctx_done(struct diff_area_image_ctx *io_ctx);
+blk_status_t diff_area_image_io(struct diff_area_image_ctx *io_ctx,
+				const struct bio_vec *bvec, sector_t *pos);
+
+void diff_area_throttling_io(struct diff_area *diff_area);
+
+#endif /* __BLK_SNAP_DIFF_AREA_H */
-- 
2.20.1

