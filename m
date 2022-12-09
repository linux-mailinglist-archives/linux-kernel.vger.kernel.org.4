Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F069648490
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLIPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiLIPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:04:11 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A52537E4;
        Fri,  9 Dec 2022 07:04:09 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 3FAB17D486;
        Fri,  9 Dec 2022 17:24:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595857;
        bh=qXJS6b5W+6kTzHMYXY0QFvS9NxiZiaRMn5fNDU2O+ig=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GRsksFHbyuGNn35otv1LQd8Cqp9GtpgVfpvJ3WgOGKeJiLSW77z19fG+VexEP4O8g
         tjI0BRdTFSoQq9k+ZaPee+5qRJ1+e4/dKR9Iq7IanRQkmCj87GtZDVRVE8OZnWD7Lp
         hI+OQk0WOtCX3YzSUJb45Nrt4R4oLmELm6PJbfRn60a9EJkx4XSxz3x10rrdczj2oP
         tiX6r+aup88Xerngbc4MS3FCG0Cs1e++AfOwryg11bjv7siZpfWWdGMn3JNHXWcGhE
         KoqOWrqrwkglZwjc3261bZU2xCqEsOZ1HA0HCBq1S992nvV6scJ2E1C5/cPBawDDAL
         eVbj4BaITHnmQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:15 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 14/21] block, blksnap: storage for storing difference blocks
Date:   Fri, 9 Dec 2022 15:23:24 +0100
Message-ID: <20221209142331.26395-15-sergei.shtepa@veeam.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides management of regions of block devices available for storing
difference blocks of a snapshot. Contains lists of free and already
occupied regions.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/diff_storage.c | 317 +++++++++++++++++++++++++++
 drivers/block/blksnap/diff_storage.h |  93 ++++++++
 2 files changed, 410 insertions(+)
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h

diff --git a/drivers/block/blksnap/diff_storage.c b/drivers/block/blksnap/diff_storage.c
new file mode 100644
index 000000000000..20e61963237d
--- /dev/null
+++ b/drivers/block/blksnap/diff_storage.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-storage: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <uapi/linux/blksnap.h>
+#include "params.h"
+#include "chunk.h"
+#include "diff_io.h"
+#include "diff_buffer.h"
+#include "diff_storage.h"
+
+/**
+ * struct storage_bdev - Information about the opened block device.
+ *
+ * @link:
+ *	Allows to combine structures into a linked list.
+ * @dev_id:
+ *	ID of the block device.
+ * @bdev:
+ *	A pointer to an open block device.
+ */
+struct storage_bdev {
+	struct list_head link;
+	dev_t dev_id;
+	struct block_device *bdev;
+};
+
+/**
+ * struct storage_block - A storage unit reserved for storing differences.
+ *
+ * @link:
+ *	Allows to combine structures into a linked list.
+ * @bdev:
+ *	A pointer to a block device.
+ * @sector:
+ *	The number of the first sector of the range of allocated space for
+ *	storing the difference.
+ * @count:
+ *	The count of sectors in the range of allocated space for storing the
+ *	difference.
+ * @used:
+ *	The count of used sectors in the range of allocated space for storing
+ *	the difference.
+ */
+struct storage_block {
+	struct list_head link;
+	struct block_device *bdev;
+	sector_t sector;
+	sector_t count;
+	sector_t used;
+};
+
+static inline void diff_storage_event_low(struct diff_storage *diff_storage)
+{
+	struct blk_snap_event_low_free_space data = {
+		.requested_nr_sect = diff_storage_minimum,
+	};
+
+	diff_storage->requested += data.requested_nr_sect;
+	pr_debug("Diff storage low free space. Portion: %llu sectors, requested: %llu\n",
+		data.requested_nr_sect, diff_storage->requested);
+	event_gen(&diff_storage->event_queue, GFP_NOIO,
+		  blk_snap_event_code_low_free_space, &data, sizeof(data));
+}
+
+struct diff_storage *diff_storage_new(void)
+{
+	struct diff_storage *diff_storage;
+
+	diff_storage = kzalloc(sizeof(struct diff_storage), GFP_KERNEL);
+	if (!diff_storage)
+		return NULL;
+
+	kref_init(&diff_storage->kref);
+	spin_lock_init(&diff_storage->lock);
+	INIT_LIST_HEAD(&diff_storage->storage_bdevs);
+	INIT_LIST_HEAD(&diff_storage->empty_blocks);
+	INIT_LIST_HEAD(&diff_storage->filled_blocks);
+
+	event_queue_init(&diff_storage->event_queue);
+	diff_storage_event_low(diff_storage);
+
+	return diff_storage;
+}
+
+static inline struct storage_block *
+first_empty_storage_block(struct diff_storage *diff_storage)
+{
+	return list_first_entry_or_null(&diff_storage->empty_blocks,
+					struct storage_block, link);
+};
+
+static inline struct storage_block *
+first_filled_storage_block(struct diff_storage *diff_storage)
+{
+	return list_first_entry_or_null(&diff_storage->filled_blocks,
+					struct storage_block, link);
+};
+
+static inline struct storage_bdev *
+first_storage_bdev(struct diff_storage *diff_storage)
+{
+	return list_first_entry_or_null(&diff_storage->storage_bdevs,
+					struct storage_bdev, link);
+};
+
+void diff_storage_free(struct kref *kref)
+{
+	struct diff_storage *diff_storage =
+		container_of(kref, struct diff_storage, kref);
+	struct storage_block *blk;
+	struct storage_bdev *storage_bdev;
+
+	while ((blk = first_empty_storage_block(diff_storage))) {
+		list_del(&blk->link);
+		kfree(blk);
+	}
+
+	while ((blk = first_filled_storage_block(diff_storage))) {
+		list_del(&blk->link);
+		kfree(blk);
+	}
+
+	while ((storage_bdev = first_storage_bdev(diff_storage))) {
+		blkdev_put(storage_bdev->bdev, FMODE_READ | FMODE_WRITE);
+		list_del(&storage_bdev->link);
+		kfree(storage_bdev);
+	}
+	event_queue_done(&diff_storage->event_queue);
+
+	kfree(diff_storage);
+}
+
+static struct block_device *
+diff_storage_bdev_by_id(struct diff_storage *diff_storage, dev_t dev_id)
+{
+	struct block_device *bdev = NULL;
+	struct storage_bdev *storage_bdev;
+
+	spin_lock(&diff_storage->lock);
+	list_for_each_entry(storage_bdev, &diff_storage->storage_bdevs, link) {
+		if (storage_bdev->dev_id == dev_id) {
+			bdev = storage_bdev->bdev;
+			break;
+		}
+	}
+	spin_unlock(&diff_storage->lock);
+
+	return bdev;
+}
+
+static inline struct block_device *
+diff_storage_add_storage_bdev(struct diff_storage *diff_storage, dev_t dev_id)
+{
+	struct block_device *bdev;
+	struct storage_bdev *storage_bdev;
+
+	bdev = blkdev_get_by_dev(dev_id, FMODE_READ | FMODE_WRITE, NULL);
+	if (IS_ERR(bdev)) {
+		pr_err("Failed to open device. errno=%d\n",
+		       abs((int)PTR_ERR(bdev)));
+		return bdev;
+	}
+
+	storage_bdev = kzalloc(sizeof(struct storage_bdev), GFP_KERNEL);
+	if (!storage_bdev) {
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage_bdev->bdev = bdev;
+	storage_bdev->dev_id = dev_id;
+	INIT_LIST_HEAD(&storage_bdev->link);
+
+	spin_lock(&diff_storage->lock);
+	list_add_tail(&storage_bdev->link, &diff_storage->storage_bdevs);
+	spin_unlock(&diff_storage->lock);
+
+	return bdev;
+}
+
+static inline int diff_storage_add_range(struct diff_storage *diff_storage,
+					 struct block_device *bdev,
+					 sector_t sector, sector_t count)
+{
+	struct storage_block *storage_block;
+
+	pr_debug("Add range to diff storage: [%u:%u] %llu:%llu\n",
+		 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev), sector, count);
+
+	storage_block = kzalloc(sizeof(struct storage_block), GFP_KERNEL);
+	if (!storage_block)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&storage_block->link);
+	storage_block->bdev = bdev;
+	storage_block->sector = sector;
+	storage_block->count = count;
+
+	spin_lock(&diff_storage->lock);
+	list_add_tail(&storage_block->link, &diff_storage->empty_blocks);
+	diff_storage->capacity += count;
+	spin_unlock(&diff_storage->lock);
+
+	return 0;
+}
+
+int diff_storage_append_block(struct diff_storage *diff_storage, dev_t dev_id,
+			      struct blk_snap_block_range __user *ranges,
+			      unsigned int range_count)
+{
+	int ret;
+	int inx;
+	struct block_device *bdev;
+	struct blk_snap_block_range range;
+	const unsigned long range_size = sizeof(struct blk_snap_block_range);
+
+	pr_debug("Append %u blocks\n", range_count);
+
+	bdev = diff_storage_bdev_by_id(diff_storage, dev_id);
+	if (!bdev) {
+		bdev = diff_storage_add_storage_bdev(diff_storage, dev_id);
+		if (IS_ERR(bdev))
+			return PTR_ERR(bdev);
+	}
+
+	for (inx = 0; inx < range_count; inx++) {
+		if (unlikely(copy_from_user(&range, ranges+inx, range_size)))
+			return -EINVAL;
+
+		ret = diff_storage_add_range(diff_storage, bdev,
+					     range.sector_offset,
+					     range.sector_count);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	if (atomic_read(&diff_storage->low_space_flag) &&
+	    (diff_storage->capacity >= diff_storage->requested))
+		atomic_set(&diff_storage->low_space_flag, 0);
+
+	return 0;
+}
+
+static inline bool is_halffull(const sector_t sectors_left)
+{
+	return sectors_left <= ((diff_storage_minimum >> 1) & ~(PAGE_SECTORS - 1));
+}
+
+struct diff_region *diff_storage_new_region(struct diff_storage *diff_storage,
+					   sector_t count)
+{
+	int ret = 0;
+	struct diff_region *diff_region;
+	sector_t sectors_left;
+
+	if (atomic_read(&diff_storage->overflow_flag))
+		return ERR_PTR(-ENOSPC);
+
+	diff_region = kzalloc(sizeof(struct diff_region), GFP_NOIO);
+	if (!diff_region)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(&diff_storage->lock);
+	do {
+		struct storage_block *storage_block;
+		sector_t available;
+
+		storage_block = first_empty_storage_block(diff_storage);
+		if (unlikely(!storage_block)) {
+			atomic_inc(&diff_storage->overflow_flag);
+			ret = -ENOSPC;
+			break;
+		}
+
+		available = storage_block->count - storage_block->used;
+		if (likely(available >= count)) {
+			diff_region->bdev = storage_block->bdev;
+			diff_region->sector =
+				storage_block->sector + storage_block->used;
+			diff_region->count = count;
+
+			storage_block->used += count;
+			diff_storage->filled += count;
+			break;
+		}
+
+		list_del(&storage_block->link);
+		list_add_tail(&storage_block->link,
+			      &diff_storage->filled_blocks);
+		/*
+		 * If there is still free space in the storage block, but
+		 * it is not enough to store a piece, then such a block is
+		 * considered used.
+		 * We believe that the storage blocks are large enough
+		 * to accommodate several pieces entirely.
+		 */
+		diff_storage->filled += available;
+	} while (1);
+	sectors_left = diff_storage->requested - diff_storage->filled;
+	spin_unlock(&diff_storage->lock);
+
+	if (ret) {
+		pr_err("Cannot get empty storage block\n");
+		diff_storage_free_region(diff_region);
+		return ERR_PTR(ret);
+	}
+
+	if (is_halffull(sectors_left) &&
+	    (atomic_inc_return(&diff_storage->low_space_flag) == 1))
+		diff_storage_event_low(diff_storage);
+
+	return diff_region;
+}
diff --git a/drivers/block/blksnap/diff_storage.h b/drivers/block/blksnap/diff_storage.h
new file mode 100644
index 000000000000..efd0525afd01
--- /dev/null
+++ b/drivers/block/blksnap/diff_storage.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_DIFF_STORAGE_H
+#define __BLK_SNAP_DIFF_STORAGE_H
+
+#include "event_queue.h"
+
+struct blk_snap_block_range;
+struct diff_region;
+
+/**
+ * struct diff_storage - Difference storage.
+ *
+ * @kref:
+ *	The reference counter.
+ * @lock:
+ *	Spinlock allows to guarantee the safety of linked lists.
+ * @storage_bdevs:
+ *	List of opened block devices. Blocks for storing snapshot data can be
+ *	located on different block devices. So, all opened block devices are
+ *	located in this list. Blocks on opened block devices are allocated for
+ *	storing the chunks data.
+ * @empty_blocks:
+ *	List of empty blocks on storage. This list can be updated while
+ *	holding a snapshot. This allows us to dynamically increase the
+ *	storage size for these snapshots.
+ * @filled_blocks:
+ *	List of filled blocks. When the blocks from the list of empty blocks are filled,
+ *	we move them to the list of filled blocks.
+ * @capacity:
+ *	Total amount of available storage space.
+ * @filled:
+ *	The number of sectors already filled in.
+ * @requested:
+ *	The number of sectors already requested from user space.
+ * @low_space_flag:
+ *	The flag is set if the number of free regions available in the
+ *	difference storage is less than the allowed minimum.
+ * @overflow_flag:
+ *	The request for a free region failed due to the absence of free
+ *	regions in the difference storage.
+ * @event_queue:
+ *	A queue of events to pass events to user space. Diff storage and its
+ *	owner can notify its snapshot about events like snapshot overflow,
+ *	low free space and snapshot terminated.
+ *
+ * The difference storage manages the regions of block devices that are used
+ * to store the data of the original block devices in the snapshot.
+ * The difference storage is created one per snapshot and is used to store
+ * data from all the original snapshot block devices. At the same time, the
+ * difference storage itself can contain regions on various block devices.
+ */
+struct diff_storage {
+	struct kref kref;
+	spinlock_t lock;
+
+	struct list_head storage_bdevs;
+	struct list_head empty_blocks;
+	struct list_head filled_blocks;
+
+	sector_t capacity;
+	sector_t filled;
+	sector_t requested;
+
+	atomic_t low_space_flag;
+	atomic_t overflow_flag;
+
+	struct event_queue event_queue;
+};
+
+struct diff_storage *diff_storage_new(void);
+void diff_storage_free(struct kref *kref);
+
+static inline void diff_storage_get(struct diff_storage *diff_storage)
+{
+	kref_get(&diff_storage->kref);
+};
+static inline void diff_storage_put(struct diff_storage *diff_storage)
+{
+	if (likely(diff_storage))
+		kref_put(&diff_storage->kref, diff_storage_free);
+};
+
+int diff_storage_append_block(struct diff_storage *diff_storage, dev_t dev_id,
+			      struct blk_snap_block_range __user *ranges,
+			      unsigned int range_count);
+struct diff_region *diff_storage_new_region(struct diff_storage *diff_storage,
+					    sector_t count);
+
+static inline void diff_storage_free_region(struct diff_region *region)
+{
+	kfree(region);
+}
+#endif /* __BLK_SNAP_DIFF_STORAGE_H */
-- 
2.20.1

