Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2A6168F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiKBQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKBQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:28 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7502D75C;
        Wed,  2 Nov 2022 09:27:05 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 0262C41D77;
        Wed,  2 Nov 2022 11:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404338;
        bh=DUHalpEJClPnpUKh0xw3vx+4yBGzYsEG7KWDWrX9V/I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jg+rItAXVYpPhZSlka67KhnoWehUhi1AZTaZR1yxr3HzpJyAK3o7Fa88xIwc3me3k
         KJJxGMkXtfhrtqmXi9ZY8JpocCX/TFPKK5zDcNJdaDNRiQmzyPs+HPYdx9Arx3qljs
         KU5KbBzw4sdbxL0pPj2AqxwUdi/dpRcFjkl0P3a9DYN2jDGQksT9rRTU6dDoDEa/B8
         3NUxAXW7w9+akTVwSPzOdjcmEny8lZ9PVCkIeUhGUt89cYXBSEfGnGvFS+OuVG4LSO
         ooSy20w8t5awgYJNyClusUxC+beNTkwFTivOML6a30CRfHTiFJi+kaWKSEOqdAVZTg
         JmJrs9QhfsgAQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:38 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 15/17] block, blksnap: snapshot
Date:   Wed, 2 Nov 2022 16:50:59 +0100
Message-ID: <20221102155101.4550-16-sergei.shtepa@veeam.com>
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

The struck snapshot combines block devices, for which a snapshot is
created, block devices of their snapshot images, as well as a difference
storage.
There may be several snapshots at the same time, but they should not
contain common block devices. This can be used for cases when backup is
scheduled once an hour for some block devices, and once a day for
others, and once a week for others. In this case, it is possible that
three snapshots are used at the same time.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/snapshot.c | 654 +++++++++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h |  78 ++++
 2 files changed, 732 insertions(+)
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h

diff --git a/drivers/block/blksnap/snapshot.c b/drivers/block/blksnap/snapshot.c
new file mode 100644
index 000000000000..02269df32d52
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.c
@@ -0,0 +1,654 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-snapshot: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <uapi/linux/blksnap.h>
+#include "snapshot.h"
+#include "tracker.h"
+#include "diff_storage.h"
+#include "diff_area.h"
+#include "snapimage.h"
+#include "cbt_map.h"
+
+LIST_HEAD(snapshots);
+DECLARE_RWSEM(snapshots_lock);
+
+static void snapshot_release(struct snapshot *snapshot)
+{
+	int inx;
+	unsigned int current_flag;
+
+	pr_info("Release snapshot %pUb\n", &snapshot->id);
+
+	/* Destroy all snapshot images. */
+	for (inx = 0; inx < snapshot->count; ++inx) {
+		struct snapimage *snapimage = snapshot->snapimage_array[inx];
+
+		if (snapimage)
+			snapimage_free(snapimage);
+	}
+
+	/* Flush and freeze fs on each original block device. */
+	for (inx = 0; inx < snapshot->count; ++inx) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		if (!tracker || !tracker->diff_area)
+			continue;
+
+		if (freeze_bdev(tracker->diff_area->orig_bdev))
+			pr_err("Failed to freeze device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was frozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+	}
+
+	current_flag = memalloc_noio_save();
+	tracker_lock();
+
+	/* Set tracker as available for new snapshots. */
+	for (inx = 0; inx < snapshot->count; ++inx)
+		tracker_release_snapshot(snapshot->tracker_array[inx]);
+
+	tracker_unlock();
+	memalloc_noio_restore(current_flag);
+
+	/* Thaw fs on each original block device. */
+	for (inx = 0; inx < snapshot->count; ++inx) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		if (!tracker || !tracker->diff_area)
+			continue;
+
+		if (thaw_bdev(tracker->diff_area->orig_bdev))
+			pr_err("Failed to thaw device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was unfrozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+	}
+
+	/* Destroy diff area for each tracker. */
+	for (inx = 0; inx < snapshot->count; ++inx) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		if (tracker) {
+			diff_area_put(tracker->diff_area);
+			tracker->diff_area = NULL;
+
+			tracker_put(tracker);
+			snapshot->tracker_array[inx] = NULL;
+		}
+	}
+}
+
+static void snapshot_free(struct kref *kref)
+{
+	struct snapshot *snapshot = container_of(kref, struct snapshot, kref);
+
+	snapshot_release(snapshot);
+
+	kfree(snapshot->snapimage_array);
+	kfree(snapshot->tracker_array);
+
+	diff_storage_put(snapshot->diff_storage);
+
+	kfree(snapshot);
+}
+
+static inline void snapshot_get(struct snapshot *snapshot)
+{
+	kref_get(&snapshot->kref);
+};
+static inline void snapshot_put(struct snapshot *snapshot)
+{
+	if (likely(snapshot))
+		kref_put(&snapshot->kref, snapshot_free);
+};
+
+static struct snapshot *snapshot_new(unsigned int count)
+{
+	int ret;
+	struct snapshot *snapshot = NULL;
+
+	snapshot = kzalloc(sizeof(struct snapshot), GFP_KERNEL);
+	if (!snapshot) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	snapshot->tracker_array = kcalloc(count, sizeof(void *), GFP_KERNEL);
+	if (!snapshot->tracker_array) {
+		ret = -ENOMEM;
+		goto fail_free_snapshot;
+	}
+
+	snapshot->snapimage_array = kcalloc(count, sizeof(void *), GFP_KERNEL);
+	if (!snapshot->snapimage_array) {
+		ret = -ENOMEM;
+		goto fail_free_trackers;
+	}
+
+	snapshot->diff_storage = diff_storage_new();
+	if (!snapshot->diff_storage) {
+		ret = -ENOMEM;
+		goto fail_free_snapimage;
+	}
+
+	INIT_LIST_HEAD(&snapshot->link);
+	kref_init(&snapshot->kref);
+	uuid_gen(&snapshot->id);
+	snapshot->is_taken = false;
+
+	return snapshot;
+
+fail_free_snapimage:
+	kfree(snapshot->snapimage_array);
+fail_free_trackers:
+	kfree(snapshot->tracker_array);
+fail_free_snapshot:
+	kfree(snapshot);
+fail:
+	return ERR_PTR(ret);
+}
+
+void snapshot_done(void)
+{
+	struct snapshot *snapshot;
+
+	pr_debug("Cleanup snapshots\n");
+	do {
+		down_write(&snapshots_lock);
+		snapshot = list_first_entry_or_null(&snapshots, struct snapshot,
+						    link);
+		if (snapshot)
+			list_del(&snapshot->link);
+		up_write(&snapshots_lock);
+
+		snapshot_put(snapshot);
+	} while (snapshot);
+}
+
+static inline bool blk_snap_dev_is_equal(struct blk_snap_dev *first,
+				    struct blk_snap_dev *second)
+{
+	return (first->mj == second->mj) && (first->mn == second->mn);
+}
+
+static inline int check_same_devices(struct blk_snap_dev *devices,
+				     unsigned int count)
+{
+	struct blk_snap_dev *first;
+	struct blk_snap_dev *second;
+
+	for (first = devices; first < (devices + (count - 1)); ++first) {
+		for (second = first + 1; second < (devices + count); ++second) {
+			if (blk_snap_dev_is_equal(first, second)) {
+				pr_err("Unable to create snapshot: The same device [%d:%d] was added twice.\n",
+					first->mj, first->mn);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int snapshot_create(struct blk_snap_dev *dev_id_array, unsigned int count,
+		    uuid_t *id)
+{
+	struct snapshot *snapshot = NULL;
+	int ret;
+	unsigned int inx;
+
+	pr_info("Create snapshot for devices:\n");
+	for (inx = 0; inx < count; ++inx)
+		pr_info("\t%u:%u\n", dev_id_array[inx].mj,
+			dev_id_array[inx].mn);
+
+	ret = check_same_devices(dev_id_array, count);
+	if (ret)
+		return ret;
+
+	snapshot = snapshot_new(count);
+	if (IS_ERR(snapshot)) {
+		pr_err("Unable to create snapshot: failed to allocate snapshot structure\n");
+		return PTR_ERR(snapshot);
+	}
+
+	ret = -ENODEV;
+	for (inx = 0; inx < count; ++inx) {
+		dev_t dev_id =
+			MKDEV(dev_id_array[inx].mj, dev_id_array[inx].mn);
+		struct tracker *tracker;
+
+		tracker = tracker_create_or_get(dev_id);
+		if (IS_ERR(tracker)) {
+			pr_err("Unable to create snapshot\n");
+			pr_err("Failed to add device [%u:%u] to snapshot tracking\n",
+			       MAJOR(dev_id), MINOR(dev_id));
+			ret = PTR_ERR(tracker);
+			goto fail;
+		}
+
+		snapshot->tracker_array[inx] = tracker;
+		snapshot->count++;
+	}
+
+	down_write(&snapshots_lock);
+	list_add_tail(&snapshots, &snapshot->link);
+	up_write(&snapshots_lock);
+
+	uuid_copy(id, &snapshot->id);
+	pr_info("Snapshot %pUb was created\n", &snapshot->id);
+	return 0;
+fail:
+	pr_err("Snapshot cannot be created\n");
+
+	snapshot_put(snapshot);
+	return ret;
+}
+
+static struct snapshot *snapshot_get_by_id(uuid_t *id)
+{
+	struct snapshot *snapshot = NULL;
+	struct snapshot *s;
+
+	down_read(&snapshots_lock);
+	if (list_empty(&snapshots))
+		goto out;
+
+	list_for_each_entry(s, &snapshots, link) {
+		if (uuid_equal(&s->id, id)) {
+			snapshot = s;
+			snapshot_get(snapshot);
+			break;
+		}
+	}
+out:
+	up_read(&snapshots_lock);
+	return snapshot;
+}
+
+int snapshot_destroy(uuid_t *id)
+{
+	struct snapshot *snapshot = NULL;
+
+	pr_info("Destroy snapshot %pUb\n", id);
+	down_write(&snapshots_lock);
+	if (!list_empty(&snapshots)) {
+		struct snapshot *s = NULL;
+
+		list_for_each_entry(s, &snapshots, link) {
+			if (uuid_equal(&s->id, id)) {
+				snapshot = s;
+				list_del(&snapshot->link);
+				break;
+			}
+		}
+	}
+	up_write(&snapshots_lock);
+
+	if (!snapshot) {
+		pr_err("Unable to destroy snapshot: cannot find snapshot by id %pUb\n",
+		       id);
+		return -ENODEV;
+	}
+	snapshot_put(snapshot);
+
+	return 0;
+}
+
+int snapshot_append_storage(uuid_t *id, struct blk_snap_dev dev_id,
+			    struct blk_snap_block_range __user *ranges,
+			    unsigned int range_count)
+{
+	int ret = 0;
+	struct snapshot *snapshot;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	ret = diff_storage_append_block(snapshot->diff_storage,
+					MKDEV(dev_id.mj, dev_id.mn), ranges,
+					range_count);
+	snapshot_put(snapshot);
+	return ret;
+}
+
+int snapshot_take(uuid_t *id)
+{
+	int ret = 0;
+	struct snapshot *snapshot;
+	int inx;
+	unsigned int current_flag;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	if (snapshot->is_taken) {
+		ret = -EALREADY;
+		goto out;
+	}
+
+	if (!snapshot->count) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Allocate diff area for each device in the snapshot. */
+	for (inx = 0; inx < snapshot->count; inx++) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+		struct diff_area *diff_area;
+
+		if (!tracker)
+			continue;
+
+		diff_area =
+			diff_area_new(tracker->dev_id, snapshot->diff_storage);
+		if (IS_ERR(diff_area)) {
+			ret = PTR_ERR(diff_area);
+			goto fail;
+		}
+		tracker->diff_area = diff_area;
+	}
+
+	/* Try to flush and freeze file system on each original block device. */
+	for (inx = 0; inx < snapshot->count; inx++) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		if (!tracker)
+			continue;
+
+		if (freeze_bdev(tracker->diff_area->orig_bdev))
+			pr_err("Failed to freeze device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was frozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+	}
+
+	current_flag = memalloc_noio_save();
+	tracker_lock();
+
+	/*
+	 * Take snapshot - switch CBT tables and enable COW logic
+	 * for each tracker.
+	 */
+	for (inx = 0; inx < snapshot->count; inx++) {
+		if (!snapshot->tracker_array[inx])
+			continue;
+		ret = tracker_take_snapshot(snapshot->tracker_array[inx]);
+		if (ret) {
+			pr_err("Unable to take snapshot: failed to capture snapshot %pUb\n",
+			       &snapshot->id);
+
+			break;
+		}
+	}
+
+	if (ret) {
+		while (inx--) {
+			struct tracker *tracker = snapshot->tracker_array[inx];
+
+			if (tracker)
+				tracker_release_snapshot(tracker);
+		}
+	} else
+		snapshot->is_taken = true;
+
+	tracker_unlock();
+	memalloc_noio_restore(current_flag);
+
+	/* Thaw file systems on original block devices. */
+	for (inx = 0; inx < snapshot->count; inx++) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		if (!tracker)
+			continue;
+
+		if (thaw_bdev(tracker->diff_area->orig_bdev))
+			pr_err("Failed to thaw device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was unfrozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+	}
+
+	if (ret)
+		goto fail;
+
+	pr_info("Snapshot was taken successfully\n");
+
+	/**
+	 * Sometimes a snapshot is in the state of corrupt immediately
+	 * after it is taken.
+	 */
+	for (inx = 0; inx < snapshot->count; inx++) {
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		if (!tracker)
+			continue;
+
+		if (diff_area_is_corrupted(tracker->diff_area)) {
+			pr_err("Unable to freeze devices [%u:%u]: diff area is corrupted\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+			ret = -EFAULT;
+			goto fail;
+		}
+	}
+
+	/* Create all image block devices. */
+	for (inx = 0; inx < snapshot->count; inx++) {
+		struct snapimage *snapimage;
+		struct tracker *tracker = snapshot->tracker_array[inx];
+
+		snapimage =
+			snapimage_create(tracker->diff_area, tracker->cbt_map);
+		if (IS_ERR(snapimage)) {
+			ret = PTR_ERR(snapimage);
+			pr_err("Failed to create snapshot image for device [%u:%u] with error=%d\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id),
+			       ret);
+			break;
+		}
+		snapshot->snapimage_array[inx] = snapimage;
+	}
+
+	goto out;
+fail:
+	pr_err("Unable to take snapshot: failed to capture snapshot %pUb\n",
+	       &snapshot->id);
+
+	down_write(&snapshots_lock);
+	list_del(&snapshot->link);
+	up_write(&snapshots_lock);
+	snapshot_put(snapshot);
+out:
+	snapshot_put(snapshot);
+	return ret;
+}
+
+struct event *snapshot_wait_event(uuid_t *id, unsigned long timeout_ms)
+{
+	struct snapshot *snapshot;
+	struct event *event;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return ERR_PTR(-ESRCH);
+
+	event = event_wait(&snapshot->diff_storage->event_queue, timeout_ms);
+
+	snapshot_put(snapshot);
+	return event;
+}
+
+int snapshot_collect(unsigned int *pcount, struct blk_snap_uuid __user *id_array)
+{
+	int ret = 0;
+	int inx = 0;
+	struct snapshot *s;
+
+	pr_debug("Collect snapshots\n");
+
+	down_read(&snapshots_lock);
+	if (list_empty(&snapshots))
+		goto out;
+
+	if (!id_array) {
+		list_for_each_entry(s, &snapshots, link)
+			inx++;
+		goto out;
+	}
+
+	list_for_each_entry(s, &snapshots, link) {
+		if (inx >= *pcount) {
+			ret = -ENODATA;
+			goto out;
+		}
+
+		if (copy_to_user(id_array[inx].b, &s->id.b, sizeof(uuid_t))) {
+			pr_err("Unable to collect snapshots: failed to copy data to user buffer\n");
+			goto out;
+		}
+
+		inx++;
+	}
+out:
+	up_read(&snapshots_lock);
+	*pcount = inx;
+	return ret;
+}
+
+int snapshot_collect_images(
+	uuid_t *id, struct blk_snap_image_info __user *user_image_info_array,
+	unsigned int *pcount)
+{
+	int ret = 0;
+	int inx;
+	unsigned long len;
+	struct blk_snap_image_info *image_info_array = NULL;
+	struct snapshot *snapshot;
+
+	pr_debug("Collect images for snapshots\n");
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	if (!snapshot->is_taken) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	pr_debug("Found snapshot with %d devices\n", snapshot->count);
+	if (!user_image_info_array) {
+		pr_debug(
+			"Unable to collect snapshot images: users buffer is not set\n");
+		goto out;
+	}
+
+	if (*pcount < snapshot->count) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	image_info_array =
+		kcalloc(snapshot->count, sizeof(struct blk_snap_image_info),
+			GFP_KERNEL);
+	if (!image_info_array) {
+		pr_err("Unable to collect snapshot images: not enough memory.\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (inx = 0; inx < snapshot->count; inx++) {
+		if (snapshot->tracker_array[inx]) {
+			dev_t orig_dev_id =
+				snapshot->tracker_array[inx]->dev_id;
+
+			pr_debug("Original [%u:%u]\n",
+				 MAJOR(orig_dev_id),
+				 MINOR(orig_dev_id));
+			image_info_array[inx].orig_dev_id.mj =
+				MAJOR(orig_dev_id);
+			image_info_array[inx].orig_dev_id.mn =
+				MINOR(orig_dev_id);
+		}
+
+		if (snapshot->snapimage_array[inx]) {
+			dev_t image_dev_id =
+				snapshot->snapimage_array[inx]->image_dev_id;
+
+			pr_debug("Image [%u:%u]\n",
+				 MAJOR(image_dev_id),
+				 MINOR(image_dev_id));
+			image_info_array[inx].image_dev_id.mj =
+				MAJOR(image_dev_id);
+			image_info_array[inx].image_dev_id.mn =
+				MINOR(image_dev_id);
+		}
+	}
+
+	len = copy_to_user(user_image_info_array, image_info_array,
+			   snapshot->count *
+				   sizeof(struct blk_snap_image_info));
+	if (len != 0) {
+		pr_err("Unable to collect snapshot images: failed to copy data to user buffer\n");
+		ret = -ENODATA;
+	}
+out:
+	*pcount = snapshot->count;
+
+	kfree(image_info_array);
+	snapshot_put(snapshot);
+
+	return ret;
+}
+
+int snapshot_mark_dirty_blocks(dev_t image_dev_id,
+			       struct blk_snap_block_range *block_ranges,
+			       unsigned int count)
+{
+	int ret = 0;
+	int inx = 0;
+	struct snapshot *s;
+	struct cbt_map *cbt_map = NULL;
+
+	pr_debug("Marking [%d] dirty blocks for device [%u:%u]\n", count,
+		 MAJOR(image_dev_id), MINOR(image_dev_id));
+
+	down_read(&snapshots_lock);
+	if (list_empty(&snapshots))
+		goto out;
+
+	list_for_each_entry(s, &snapshots, link) {
+		for (inx = 0; inx < s->count; inx++) {
+			if (s->snapimage_array[inx]->image_dev_id ==
+			    image_dev_id) {
+				cbt_map = s->snapimage_array[inx]->cbt_map;
+				break;
+			}
+		}
+
+		inx++;
+	}
+	if (!cbt_map) {
+		pr_err("Cannot find snapshot image device [%u:%u]\n",
+		       MAJOR(image_dev_id), MINOR(image_dev_id));
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = cbt_map_mark_dirty_blocks(cbt_map, block_ranges, count);
+	if (ret)
+		pr_err("Failed to set CBT table. errno=%d\n", abs(ret));
+out:
+	up_read(&snapshots_lock);
+
+	return ret;
+}
diff --git a/drivers/block/blksnap/snapshot.h b/drivers/block/blksnap/snapshot.h
new file mode 100644
index 000000000000..497750e7eda0
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_SNAPSHOT_H
+#define __BLK_SNAP_SNAPSHOT_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/kref.h>
+#include <linux/uuid.h>
+#include <linux/spinlock.h>
+#include <linux/rwsem.h>
+#include <linux/fs.h>
+#include "event_queue.h"
+
+struct tracker;
+struct diff_storage;
+struct snapimage;
+/**
+ * struct snapshot - Snapshot structure.
+ * @link:
+ *	The list header allows to store snapshots in a linked list.
+ * @kref:
+ *	Protects the structure from being released during the processing of
+ *	an ioctl.
+ * @id:
+ *	UUID of snapshot.
+ * @is_taken:
+ *	Flag that the snapshot was taken.
+ * @diff_storage:
+ *	A pointer to the difference storage of this snapshot.
+ * @count:
+ *	The number of block devices in the snapshot. This number
+ *	corresponds to the size of arrays of pointers to trackers
+ *	and snapshot images.
+ * @tracker_array:
+ *	Array of pointers to block device trackers.
+ * @snapimage_array:
+ *	Array of pointers to images of snapshots of block devices.
+ *
+ * A snapshot corresponds to a single backup session and provides snapshot
+ * images for multiple block devices. Several backup sessions can be
+ * performed at the same time, which means that several snapshots can
+ * exist at the same time. However, the original block device can only
+ * belong to one snapshot. Creating multiple snapshots from the same block
+ * device is not allowed.
+ *
+ * A UUID is used to identify the snapshot.
+ *
+ */
+struct snapshot {
+	struct list_head link;
+	struct kref kref;
+	uuid_t id;
+	bool is_taken;
+	struct diff_storage *diff_storage;
+	int count;
+	struct tracker **tracker_array;
+	struct snapimage **snapimage_array;
+};
+
+void snapshot_done(void);
+
+int snapshot_create(struct blk_snap_dev *dev_id_array, unsigned int count,
+		    uuid_t *id);
+int snapshot_destroy(uuid_t *id);
+int snapshot_append_storage(uuid_t *id, struct blk_snap_dev dev_id,
+			    struct blk_snap_block_range __user *ranges,
+			    unsigned int range_count);
+int snapshot_take(uuid_t *id);
+struct event *snapshot_wait_event(uuid_t *id, unsigned long timeout_ms);
+int snapshot_collect(unsigned int *pcount, struct blk_snap_uuid __user *id_array);
+int snapshot_collect_images(uuid_t *id,
+			    struct blk_snap_image_info __user *image_info_array,
+			    unsigned int *pcount);
+int snapshot_mark_dirty_blocks(dev_t image_dev_id,
+			       struct blk_snap_block_range *block_ranges,
+			       unsigned int count);
+#endif /* __BLK_SNAP_SNAPSHOT_H */
-- 
2.20.1

