Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB66484CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLIPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLIPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:14:05 -0500
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB521A;
        Fri,  9 Dec 2022 07:14:00 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 2825740146;
        Fri,  9 Dec 2022 09:24:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1670595863;
        bh=im+w6TFFUmSJqppmsyFr2VcbjR+mLxWai5qUPgx56QI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=f444DIIK3s64yVPnNXf/X3enK/X3oB7uTHbitZ7ZrZFfQVrL6bKV/NMc67ASwjsoO
         tjKpbBru7p9FN9ibyIGUaZvazUygKQRFlIo/O8ZLgvI1Sbha/tatbH7PyuGNw9PuW8
         2U8fhE++GZK372qJfsB32HnzbYVKIioZ70aJ3bUHFhovIdvWvba0wI0ZmEDHIgS2YO
         QlROm5U+fHbBWKeS2Sja9tJ2cjjPcx5VapuGATn8HXIQMn5fDIDTKq1PL+E8RjkJYI
         PMbvBl/3BmH+sUdBol0Uif5sGnIlLrLbbzpPX+h3xJu9ovUTf16iD85oajJoMLSYvD
         juLTC1PO+lxOQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:20 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 17/21] block, blksnap: snapshot image block device
Date:   Fri, 9 Dec 2022 15:23:27 +0100
Message-ID: <20221209142331.26395-18-sergei.shtepa@veeam.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides the operation of block devices of snapshot images. Read and
write operations are redirected to the regions of difference blocks for
block device (struct diff_area).

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/snapimage.c | 275 ++++++++++++++++++++++++++++++
 drivers/block/blksnap/snapimage.h |  69 ++++++++
 2 files changed, 344 insertions(+)
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h

diff --git a/drivers/block/blksnap/snapimage.c b/drivers/block/blksnap/snapimage.c
new file mode 100644
index 000000000000..d7fd1a12e3a9
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-snapimage: " fmt
+
+#include <linux/slab.h>
+#include <linux/cdrom.h>
+#include <linux/blk-mq.h>
+#include <uapi/linux/blksnap.h>
+#include "snapimage.h"
+#include "diff_area.h"
+#include "chunk.h"
+#include "cbt_map.h"
+
+#define NR_SNAPIMAGE_DEVT	(1 << MINORBITS)
+
+static unsigned int _major;
+static DEFINE_IDA(snapimage_devt_ida);
+
+static int snapimage_kthread_worker_fn(void *param);
+
+static inline void snapimage_stop_worker(struct snapimage *snapimage)
+{
+	kthread_stop(snapimage->worker);
+	put_task_struct(snapimage->worker);
+}
+
+static inline int snapimage_start_worker(struct snapimage *snapimage)
+{
+	struct task_struct *task;
+
+	spin_lock_init(&snapimage->queue_lock);
+	bio_list_init(&snapimage->queue);
+
+	task = kthread_create(snapimage_kthread_worker_fn,
+			      snapimage,
+			      BLK_SNAP_IMAGE_NAME "%d",
+			      MINOR(snapimage->image_dev_id));
+	if (IS_ERR(task))
+		return -ENOMEM;
+
+	snapimage->worker = get_task_struct(task);
+	set_user_nice(task, MAX_NICE);
+	task->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+	wake_up_process(task);
+
+	return 0;
+}
+
+static void snapimage_process_bio(struct snapimage *snapimage, struct bio *bio)
+{
+
+	struct diff_area_image_ctx io_ctx;
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+	sector_t pos = bio->bi_iter.bi_sector;
+
+	diff_area_throttling_io(snapimage->diff_area);
+	diff_area_image_ctx_init(&io_ctx, snapimage->diff_area,
+				 op_is_write(bio_op(bio)));
+	bio_for_each_segment(bvec, bio, iter) {
+		blk_status_t st;
+
+		st = diff_area_image_io(&io_ctx, &bvec, &pos);
+		if (unlikely(st != BLK_STS_OK))
+			break;
+	}
+	diff_area_image_ctx_done(&io_ctx);
+	bio_endio(bio);
+}
+
+static inline struct bio *get_bio_from_queue(struct snapimage *snapimage)
+{
+	struct bio *bio;
+
+	spin_lock(&snapimage->queue_lock);
+	bio = bio_list_pop(&snapimage->queue);
+	spin_unlock(&snapimage->queue_lock);
+
+	return bio;
+}
+
+static int snapimage_kthread_worker_fn(void *param)
+{
+	struct snapimage *snapimage = param;
+	struct bio *bio;
+	int ret = 0;
+
+	while (!kthread_should_stop()) {
+		bio = get_bio_from_queue(snapimage);
+		if (!bio) {
+			schedule_timeout_interruptible(HZ / 100);
+			continue;
+		}
+
+		snapimage_process_bio(snapimage, bio);
+	}
+
+	while ((bio = get_bio_from_queue(snapimage)))
+		snapimage_process_bio(snapimage, bio);
+
+	return ret;
+}
+
+static void snapimage_submit_bio(struct bio *bio)
+{
+	struct snapimage *snapimage = bio->bi_bdev->bd_disk->private_data;
+	gfp_t gfp = GFP_NOIO;
+
+	if (bio->bi_opf & REQ_NOWAIT)
+		gfp |= GFP_NOWAIT;
+	if (snapimage->is_ready) {
+		spin_lock(&snapimage->queue_lock);
+		bio_list_add(&snapimage->queue, bio);
+		spin_unlock(&snapimage->queue_lock);
+
+		wake_up_process(snapimage->worker);
+	} else
+		bio_io_error(bio);
+}
+
+const struct block_device_operations bd_ops = {
+	.owner = THIS_MODULE,
+	.submit_bio = snapimage_submit_bio
+};
+
+void snapimage_free(struct snapimage *snapimage)
+{
+	pr_info("Snapshot image disk [%u:%u] delete\n",
+		MAJOR(snapimage->image_dev_id), MINOR(snapimage->image_dev_id));
+
+	blk_mq_freeze_queue(snapimage->disk->queue);
+	snapimage->is_ready = false;
+	blk_mq_unfreeze_queue(snapimage->disk->queue);
+
+	snapimage_stop_worker(snapimage);
+
+	del_gendisk(snapimage->disk);
+	put_disk(snapimage->disk);
+
+	diff_area_put(snapimage->diff_area);
+	cbt_map_put(snapimage->cbt_map);
+
+	ida_free(&snapimage_devt_ida, MINOR(snapimage->image_dev_id));
+	kfree(snapimage);
+}
+
+struct snapimage *snapimage_create(struct diff_area *diff_area,
+				   struct cbt_map *cbt_map)
+{
+	int ret = 0;
+	int minor;
+	struct snapimage *snapimage = NULL;
+	struct gendisk *disk;
+
+	snapimage = kzalloc(sizeof(struct snapimage), GFP_KERNEL);
+	if (snapimage == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	minor = ida_alloc_range(&snapimage_devt_ida, 0, NR_SNAPIMAGE_DEVT - 1,
+				GFP_KERNEL);
+	if (minor < 0) {
+		ret = minor;
+		pr_err("Failed to allocate minor for snapshot image device. errno=%d\n",
+		       abs(ret));
+		goto fail_free_image;
+	}
+
+	snapimage->is_ready = true;
+	snapimage->capacity = cbt_map->device_capacity;
+	snapimage->image_dev_id = MKDEV(_major, minor);
+	pr_info("Create snapshot image device [%u:%u] for original device [%u:%u]\n",
+		MAJOR(snapimage->image_dev_id),
+		MINOR(snapimage->image_dev_id),
+		MAJOR(diff_area->orig_bdev->bd_dev),
+		MINOR(diff_area->orig_bdev->bd_dev));
+
+	ret = snapimage_start_worker(snapimage);
+	if (ret) {
+		pr_err("Failed to start worker thread. errno=%d\n", abs(ret));
+		goto fail_free_minor;
+	}
+
+	disk = blk_alloc_disk(NUMA_NO_NODE);
+	if (!disk) {
+		pr_err("Failed to allocate disk\n");
+		ret = -ENOMEM;
+		goto fail_free_worker;
+	}
+	snapimage->disk = disk;
+
+	blk_queue_max_hw_sectors(disk->queue, BLK_DEF_MAX_SECTORS);
+	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, disk->queue);
+
+	if (snprintf(disk->disk_name, DISK_NAME_LEN, "%s%d",
+		     BLK_SNAP_IMAGE_NAME, minor) < 0) {
+		pr_err("Unable to set disk name for snapshot image device: invalid minor %u\n",
+		       minor);
+		ret = -EINVAL;
+		goto fail_cleanup_disk;
+	}
+	pr_debug("Snapshot image disk name [%s]\n", disk->disk_name);
+
+	disk->flags = 0;
+#ifdef GENHD_FL_NO_PART_SCAN
+	disk->flags |= GENHD_FL_NO_PART_SCAN;
+#else
+	disk->flags |= GENHD_FL_NO_PART;
+#endif
+	disk->major = _major;
+	disk->first_minor = minor;
+	disk->minors = 1; /* One disk has only one partition */
+
+	disk->fops = &bd_ops;
+	disk->private_data = snapimage;
+
+	set_capacity(disk, snapimage->capacity);
+	pr_debug("Snapshot image device capacity %lld bytes\n",
+		 (u64)(snapimage->capacity << SECTOR_SHIFT));
+
+	diff_area_get(diff_area);
+	snapimage->diff_area = diff_area;
+	cbt_map_get(cbt_map);
+	snapimage->cbt_map = cbt_map;
+
+	pr_debug("Add device [%d:%d]",
+		MAJOR(snapimage->image_dev_id), MINOR(snapimage->image_dev_id));
+	ret = add_disk(disk);
+	if (ret) {
+		pr_err("Failed to add disk [%s] for snapshot image device\n",
+		       disk->disk_name);
+		goto fail_cleanup_disk;
+	}
+
+	wake_up_process(snapimage->worker);
+
+	return snapimage;
+
+fail_cleanup_disk:
+	put_disk(disk);
+fail_free_worker:
+	snapimage_stop_worker(snapimage);
+fail_free_minor:
+	ida_free(&snapimage_devt_ida, minor);
+fail_free_image:
+	kfree(snapimage);
+
+	return ERR_PTR(ret);
+}
+
+int snapimage_init(void)
+{
+	int ret = 0;
+
+	ret = register_blkdev(0, BLK_SNAP_IMAGE_NAME);
+	if (ret < 0) {
+		pr_err("Failed to register snapshot image block device\n");
+		return ret;
+	}
+
+	_major = ret;
+	pr_info("Snapshot image block device major %d was registered\n",
+		_major);
+
+	return 0;
+}
+
+void snapimage_done(void)
+{
+	unregister_blkdev(_major, BLK_SNAP_IMAGE_NAME);
+	pr_info("Snapshot image block device [%d] was unregistered\n", _major);
+}
+
+int snapimage_major(void)
+{
+	return _major;
+}
diff --git a/drivers/block/blksnap/snapimage.h b/drivers/block/blksnap/snapimage.h
new file mode 100644
index 000000000000..91e7bc004ee2
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_SNAPIMAGE_H
+#define __BLK_SNAP_SNAPIMAGE_H
+
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/kthread.h>
+
+struct diff_area;
+struct cbt_map;
+
+/**
+ * struct snapimage - Snapshot image block device.
+ *
+ * @image_dev_id:
+ *	ID of the snapshot image block device.
+ * @capacity:
+ *	The size of the snapshot image in sectors must be equal to the size
+ *	of the original device at the time of taking the snapshot.
+ * @is_ready:
+ *	The flag means that the snapshot image is ready for processing
+ *	I/O units.
+ * @worker:
+ *	A pointer to the &struct task of the worker thread that process I/O
+ *      units.
+ * @queue_lock:
+ *      Lock for &queue.
+ * @queue:
+ *	A queue of I/O units waiting to be processed.
+ * @disk:
+ *	A pointer to the &struct gendisk for the image block device.
+ * @diff_area:
+ *	A pointer to the owned &struct diff_area.
+ * @cbt_map:
+ *	A pointer to the owned &struct cbt_map.
+ *
+ * The snapshot image is presented in the system as a block device. But
+ * when reading or writing a snapshot image, the data is redirected to
+ * the original block device or to the block device of the difference storage.
+ *
+ * The module does not prohibit reading and writing data to the snapshot
+ * from different threads in parallel. To avoid the problem with simultaneous
+ * access, it is enough to open the snapshot image block device with the
+ * FMODE_EXCL parameter.
+ */
+struct snapimage {
+	dev_t image_dev_id;
+	sector_t capacity;
+	bool is_ready;
+
+	struct task_struct *worker;
+	spinlock_t queue_lock;
+	struct bio_list queue;
+
+	struct gendisk *disk;
+
+	struct diff_area *diff_area;
+	struct cbt_map *cbt_map;
+};
+
+int snapimage_init(void);
+void snapimage_done(void);
+int snapimage_major(void);
+
+void snapimage_free(struct snapimage *snapimage);
+struct snapimage *snapimage_create(struct diff_area *diff_area,
+				   struct cbt_map *cbt_map);
+#endif /* __BLK_SNAP_SNAPIMAGE_H */
-- 
2.20.1

