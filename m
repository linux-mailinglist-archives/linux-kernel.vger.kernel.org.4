Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817156168FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiKBQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiKBQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:29 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACAD2DA9C;
        Wed,  2 Nov 2022 09:27:07 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 633E441D17;
        Wed,  2 Nov 2022 11:51:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404316;
        bh=w5IVIx1cFvNanxCecaOgQKbY/61Rr8KhLqtnqybF5SQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=or4MkTzIzvKgO5mq8TK1gheuqVfXm+cLCll3K9d25aTTOtcHNZAb2y4tL3qE+WU1e
         zP5OvqvKebt6OX0Sn+08GIk9ckb8sl+gMPBusrYsOhD0N27Tvhl9yT+Zu2LwEFGu9y
         /UuMDHK7uSX34nMECBPuvEpgWdr3D/6diYzMdK8E+v0rCOJfpRmvro6sdKfMUQwM0f
         Drq9m7mZHyEHjtovxG/fPl+h/OfafJOfDKmwcqJyrPivPRq6i4fj8EINucmYH5ZreA
         rq7J4m4/O7/g++D97llv4j0BM2ocuVYgHtW7duPDQ9Obp3m8PCgHI3ZUITqJHRlAnp
         c5tXNs4oy7xgg==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:18 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 03/17] block, blksnap: module management interface functions
Date:   Wed, 2 Nov 2022 16:50:47 +0100
Message-ID: <20221102155101.4550-4-sergei.shtepa@veeam.com>
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

Implementation of module management interface functions. At this level,
the input and output parameters are converted and the corresponding
subsystems of the module are called.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/ctrl.c | 408 +++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/ctrl.h |   9 +
 2 files changed, 417 insertions(+)
 create mode 100644 drivers/block/blksnap/ctrl.c
 create mode 100644 drivers/block/blksnap/ctrl.h

diff --git a/drivers/block/blksnap/ctrl.c b/drivers/block/blksnap/ctrl.c
new file mode 100644
index 000000000000..2bb1eaafe569
--- /dev/null
+++ b/drivers/block/blksnap/ctrl.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-ctrl: " fmt
+
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <uapi/linux/blksnap.h>
+#include "ctrl.h"
+#include "params.h"
+#include "version.h"
+#include "snapshot.h"
+#include "snapimage.h"
+#include "tracker.h"
+
+static_assert(sizeof(uuid_t) == sizeof(struct blk_snap_uuid),
+	"Invalid size of struct blk_snap_uuid or uuid_t.");
+
+static int blk_snap_major;
+
+static long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg);
+
+static const struct file_operations ctrl_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = ctrl_unlocked_ioctl,
+};
+
+static const struct blk_snap_version version = {
+	.major = VERSION_MAJOR,
+	.minor = VERSION_MINOR,
+	.revision = VERSION_REVISION,
+	.build = VERSION_BUILD,
+};
+
+int get_blk_snap_major(void)
+{
+	return blk_snap_major;
+}
+
+int ctrl_init(void)
+{
+	int ret;
+
+	ret = register_chrdev(0, THIS_MODULE->name, &ctrl_fops);
+	if (ret < 0) {
+		pr_err("Failed to register a character device. errno=%d\n",
+		       abs(blk_snap_major));
+		return ret;
+	}
+
+	blk_snap_major = ret;
+	pr_info("Register control device [%d:0].\n", blk_snap_major);
+	return 0;
+}
+
+void ctrl_done(void)
+{
+	pr_info("Unregister control device\n");
+
+	unregister_chrdev(blk_snap_major, THIS_MODULE->name);
+}
+
+static int ioctl_version(unsigned long arg)
+{
+	if (copy_to_user((void *)arg, &version, sizeof(version))) {
+		pr_err("Unable to get version: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int ioctl_tracker_remove(unsigned long arg)
+{
+	struct blk_snap_tracker_remove karg;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg)) != 0) {
+		pr_err("Unable to remove device from tracking: invalid user buffer\n");
+		return -ENODATA;
+	}
+	return tracker_remove(MKDEV(karg.dev_id.mj, karg.dev_id.mn));
+}
+
+static int ioctl_tracker_collect(unsigned long arg)
+{
+	int res;
+	struct blk_snap_tracker_collect karg;
+	struct blk_snap_cbt_info *cbt_info = NULL;
+
+	pr_debug("Collecting tracking devices\n");
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to collect tracking devices: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	if (!karg.cbt_info_array) {
+		/*
+		 * If the buffer is empty, this is a request to determine
+		 * the number of trackers.
+		 */
+		res = tracker_collect(0, NULL, &karg.count);
+		if (res) {
+			pr_err("Failed to execute tracker_collect. errno=%d\n",
+			       abs(res));
+			return res;
+		}
+		if (copy_to_user((void *)arg, (void *)&karg, sizeof(karg))) {
+			pr_err("Unable to collect tracking devices: invalid user buffer for arguments\n");
+			return -ENODATA;
+		}
+		return 0;
+	}
+
+	cbt_info = kcalloc(karg.count, sizeof(struct blk_snap_cbt_info),
+			   GFP_KERNEL);
+	if (cbt_info == NULL)
+		return -ENOMEM;
+
+	res = tracker_collect(karg.count, cbt_info, &karg.count);
+	if (res) {
+		pr_err("Failed to execute tracker_collect. errno=%d\n",
+		       abs(res));
+		goto fail;
+	}
+
+	if (copy_to_user(karg.cbt_info_array, cbt_info,
+			 karg.count * sizeof(struct blk_snap_cbt_info))) {
+		pr_err("Unable to collect tracking devices: invalid user buffer for CBT info\n");
+		res = -ENODATA;
+		goto fail;
+	}
+
+	if (copy_to_user((void *)arg, (void *)&karg, sizeof(karg))) {
+		pr_err("Unable to collect tracking devices: invalid user buffer for arguments\n");
+		res = -ENODATA;
+		goto fail;
+	}
+fail:
+	kfree(cbt_info);
+
+	return res;
+}
+
+static int ioctl_tracker_read_cbt_map(unsigned long arg)
+{
+	struct blk_snap_tracker_read_cbt_bitmap karg;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to read CBT map: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return tracker_read_cbt_bitmap(MKDEV(karg.dev_id.mj, karg.dev_id.mn),
+				       karg.offset, karg.length,
+				       (char __user *)karg.buff);
+}
+
+static int ioctl_tracker_mark_dirty_blocks(unsigned long arg)
+{
+	int ret = 0;
+	struct blk_snap_tracker_mark_dirty_blocks karg;
+	struct blk_snap_block_range *dirty_blocks_array;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to mark dirty blocks: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	dirty_blocks_array = kcalloc(
+		karg.count, sizeof(struct blk_snap_block_range), GFP_KERNEL);
+	if (!dirty_blocks_array)
+		return -ENOMEM;
+
+	if (copy_from_user(dirty_blocks_array, (void *)karg.dirty_blocks_array,
+			   karg.count * sizeof(struct blk_snap_block_range))) {
+		pr_err("Unable to mark dirty blocks: invalid user buffer\n");
+		ret = -ENODATA;
+	} else {
+		if (karg.dev_id.mj == snapimage_major())
+			ret = snapshot_mark_dirty_blocks(
+				MKDEV(karg.dev_id.mj, karg.dev_id.mn),
+				dirty_blocks_array, karg.count);
+		else
+			ret = tracker_mark_dirty_blocks(
+				MKDEV(karg.dev_id.mj, karg.dev_id.mn),
+				dirty_blocks_array, karg.count);
+	}
+
+	kfree(dirty_blocks_array);
+
+	return ret;
+}
+
+static int ioctl_snapshot_create(unsigned long arg)
+{
+	int ret;
+	struct blk_snap_snapshot_create karg;
+	struct blk_snap_dev *dev_id_array = NULL;
+	uuid_t new_id;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	dev_id_array =
+		kcalloc(karg.count, sizeof(struct blk_snap_dev), GFP_KERNEL);
+	if (dev_id_array == NULL) {
+		pr_err("Unable to create snapshot: too many devices %d\n",
+		       karg.count);
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(dev_id_array, (void *)karg.dev_id_array,
+			   karg.count * sizeof(struct blk_snap_dev))) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		ret = -ENODATA;
+		goto out;
+	}
+
+	ret = snapshot_create(dev_id_array, karg.count, &new_id);
+	if (ret)
+		goto out;
+
+	export_uuid(karg.id.b, &new_id);
+	if (copy_to_user((void *)arg, &karg, sizeof(karg))) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		ret = -ENODATA;
+	}
+out:
+	kfree(dev_id_array);
+
+	return ret;
+}
+
+static int ioctl_snapshot_destroy(unsigned long arg)
+{
+	struct blk_snap_snapshot_destroy karg;
+	uuid_t id;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to destroy snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	import_uuid(&id, karg.id.b);
+	return snapshot_destroy(&id);
+}
+
+static int ioctl_snapshot_append_storage(unsigned long arg)
+{
+	struct blk_snap_snapshot_append_storage karg;
+	uuid_t id;
+
+	pr_debug("Append difference storage\n");
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to append difference storage: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	import_uuid(&id, karg.id.b);
+	return snapshot_append_storage(&id, karg.dev_id, karg.ranges,
+				       karg.count);
+}
+
+static int ioctl_snapshot_take(unsigned long arg)
+{
+	struct blk_snap_snapshot_take karg;
+	uuid_t id;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to take snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	import_uuid(&id, karg.id.b);
+	return snapshot_take(&id);
+}
+
+static int ioctl_snapshot_wait_event(unsigned long arg)
+{
+	int ret = 0;
+	struct blk_snap_snapshot_event *karg;
+	uuid_t id;
+	struct event *event;
+
+	karg = kzalloc(sizeof(struct blk_snap_snapshot_event), GFP_KERNEL);
+	if (!karg)
+		return -ENOMEM;
+
+	if (copy_from_user(karg, (void *)arg,
+			   sizeof(struct blk_snap_snapshot_event))) {
+		pr_err("Unable failed to get snapstore error code: invalid user buffer\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	import_uuid(&id, karg->id.b);
+	event = snapshot_wait_event(&id, karg->timeout_ms);
+	if (IS_ERR(event)) {
+		ret = PTR_ERR(event);
+		goto out;
+	}
+
+	pr_debug("Received event=%lld code=%d data_size=%d\n", event->time,
+		 event->code, event->data_size);
+	karg->code = event->code;
+	karg->time_label = event->time;
+
+	if (event->data_size > sizeof(karg->data)) {
+		pr_err("Event size %d is too big\n", event->data_size);
+		ret = -ENOSPC;
+		/* If we can't copy all the data, we copy only part of it. */
+	}
+	memcpy(karg->data, event->data, event->data_size);
+	event_free(event);
+
+	if (copy_to_user((void *)arg, karg,
+			 sizeof(struct blk_snap_snapshot_event))) {
+		pr_err("Unable to get snapstore error code: invalid user buffer\n");
+		ret = -EINVAL;
+	}
+out:
+	kfree(karg);
+
+	return ret;
+}
+
+static int ioctl_snapshot_collect(unsigned long arg)
+{
+	int ret;
+	struct blk_snap_snapshot_collect karg;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to collect available snapshots: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	ret = snapshot_collect(&karg.count, karg.ids);
+
+	if (copy_to_user((void *)arg, &karg, sizeof(karg))) {
+		pr_err("Unable to collect available snapshots: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
+static int ioctl_snapshot_collect_images(unsigned long arg)
+{
+	int ret;
+	struct blk_snap_snapshot_collect_images karg;
+	uuid_t id;
+
+	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
+		pr_err("Unable to collect snapshot images: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	import_uuid(&id, karg.id.b);
+	ret = snapshot_collect_images(&id, karg.image_info_array,
+				      &karg.count);
+
+	if (copy_to_user((void *)arg, &karg, sizeof(karg))) {
+		pr_err("Unable to collect snapshot images: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
+static int (*const blk_snap_ioctl_table[])(unsigned long arg) = {
+	ioctl_version,
+	ioctl_tracker_remove,
+	ioctl_tracker_collect,
+	ioctl_tracker_read_cbt_map,
+	ioctl_tracker_mark_dirty_blocks,
+	ioctl_snapshot_create,
+	ioctl_snapshot_destroy,
+	ioctl_snapshot_append_storage,
+	ioctl_snapshot_take,
+	ioctl_snapshot_collect,
+	ioctl_snapshot_collect_images,
+	ioctl_snapshot_wait_event,
+};
+
+static_assert(
+	sizeof(blk_snap_ioctl_table) ==
+	((blk_snap_ioctl_snapshot_wait_event + 1) * sizeof(void *)),
+	"The size of table blk_snap_ioctl_table does not match the enum blk_snap_ioctl.");
+
+
+static long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	int nr = _IOC_NR(cmd);
+
+	if (nr > (sizeof(blk_snap_ioctl_table) / sizeof(void *)))
+		return -ENOTTY;
+
+	if (!blk_snap_ioctl_table[nr])
+		return -ENOTTY;
+
+	return blk_snap_ioctl_table[nr](arg);
+}
diff --git a/drivers/block/blksnap/ctrl.h b/drivers/block/blksnap/ctrl.h
new file mode 100644
index 000000000000..ade3f1cf57e9
--- /dev/null
+++ b/drivers/block/blksnap/ctrl.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_CTRL_H
+#define __BLK_SNAP_CTRL_H
+
+int get_blk_snap_major(void);
+
+int ctrl_init(void);
+void ctrl_done(void);
+#endif /* __BLK_SNAP_CTRL_H */
-- 
2.20.1

