Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB3616905
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiKBQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiKBQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:31 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D52DAAC;
        Wed,  2 Nov 2022 09:27:08 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id D90DC41125;
        Wed,  2 Nov 2022 11:51:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404315;
        bh=InslHg7ScO9XFeU1F9li3sV7u1rT7H5TXAku+ss1xpM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QzmtkkadfC+Ov7KBPF1GbYbc9KcwZ8G3ixD9mxWyn0YjDVgew2tiTq97ZuzHG82SH
         ybh4nx+2zADbOF1dec/UNVDni12MCL7S2dHYu+cb/1PUjm6FFhT0hqhqUfGQQ9BoCW
         11jM93/4I8GNOD1T4c7iwMLxztvXIU6myHetgLjKWBI6/8eJhYpvaBRfsrL3M9RCEd
         eHBY6mZIlRBPIYF8xCUgsx/iXFEGESSx6L/IVeVcGZswMnx1wC9pwnSKUR8ZG2jqz0
         aqT6/QKAyj2LyTF8XrSzqiyOv8UGYhPRDqEEMLv4wNs0bF//qKMhfYr0uDybsZLXUj
         Am4rfWDsXe+LA==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:16 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 02/17] block, blksnap: header file of the module interface
Date:   Wed, 2 Nov 2022 16:50:46 +0100
Message-ID: <20221102155101.4550-3-sergei.shtepa@veeam.com>
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

The header file contains a set of declarations, structures and control
requests (ioctl) that allows to manage the module from the user space.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 include/uapi/linux/blksnap.h | 467 +++++++++++++++++++++++++++++++++++
 1 file changed, 467 insertions(+)
 create mode 100644 include/uapi/linux/blksnap.h

diff --git a/include/uapi/linux/blksnap.h b/include/uapi/linux/blksnap.h
new file mode 100644
index 000000000000..56102c22fef8
--- /dev/null
+++ b/include/uapi/linux/blksnap.h
@@ -0,0 +1,467 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_BLK_SNAP_H
+#define _UAPI_LINUX_BLK_SNAP_H
+
+#include <linux/types.h>
+
+#define BLK_SNAP_CTL "/dev/blksnap"
+#define BLK_SNAP_IMAGE_NAME "blksnap-image"
+#define BLK_SNAP 'V'
+
+enum blk_snap_ioctl {
+	/*
+	 * Service controls
+	 */
+	blk_snap_ioctl_version,
+	/*
+	 * Contols for tracking
+	 */
+	blk_snap_ioctl_tracker_remove,
+	blk_snap_ioctl_tracker_collect,
+	blk_snap_ioctl_tracker_read_cbt_map,
+	blk_snap_ioctl_tracker_mark_dirty_blocks,
+	/*
+	 * Snapshot contols
+	 */
+	blk_snap_ioctl_snapshot_create,
+	blk_snap_ioctl_snapshot_destroy,
+	blk_snap_ioctl_snapshot_append_storage,
+	blk_snap_ioctl_snapshot_take,
+	blk_snap_ioctl_snapshot_collect,
+	blk_snap_ioctl_snapshot_collect_images,
+	blk_snap_ioctl_snapshot_wait_event,
+};
+
+/**
+ * struct blk_snap_version - Result for the &IOCTL_BLK_SNAP_VERSION control.
+ * @major:
+ *	Version major part.
+ * @minor:
+ *	Version minor part.
+ * @revision:
+ *	Revision number.
+ * @build:
+ *	Build number. Should be zero.
+ */
+struct blk_snap_version {
+	__u16 major;
+	__u16 minor;
+	__u16 revision;
+	__u16 build;
+};
+
+/**
+ * IOCTL_BLK_SNAP_VERSION - Get module version.
+ *
+ * Linking the product behavior to the version code does not seem to be a very
+ * good idea. Version is only for logs.
+ */
+#define IOCTL_BLK_SNAP_VERSION                                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_version, struct blk_snap_version)
+
+/*
+ * The main functionality of the module is change block tracking (CBT).
+ * Next, a number of ioctls will describe the interface for the CBT mechanism.
+ */
+
+/**
+ * struct blk_snap_dev - Block device ID.
+ * @mj:
+ *	Device ID major part.
+ * @mn:
+ *	Device ID minor part.
+ *
+ * In user space and in kernel space, block devices are encoded differently.
+ * We need to enter our own type to guarantee the correct transmission of the
+ * major and minor parts.
+ */
+struct blk_snap_dev {
+	__u32 mj;
+	__u32 mn;
+};
+
+/**
+ * struct blk_snap_tracker_remove - Input argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_REMOVE control.
+ * @dev_id:
+ *	Device ID.
+ */
+struct blk_snap_tracker_remove {
+	struct blk_snap_dev dev_id;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_REMOVE - Remove a device from tracking.
+ *
+ * Removes the device from tracking changes.
+ * Adding a device for tracking is performed when creating a snapshot
+ * that includes this device.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_REMOVE                                          \
+	_IOW(BLK_SNAP, blk_snap_ioctl_tracker_remove,                          \
+	     struct blk_snap_tracker_remove)
+
+struct blk_snap_uuid {
+	__u8 b[16];
+};
+
+/**
+ * struct blk_snap_cbt_info - Information about change tracking for a block
+ *	device.
+ * @dev_id:
+ *	Device ID.
+ * @blk_size:
+ *	Block size in bytes.
+ * @device_capacity:
+ *	Device capacity in bytes.
+ * @blk_count:
+ *	Number of blocks.
+ * @generation_id:
+ *	Unique identification number of change tracking generation.
+ * @snap_number:
+ *	Current changes number.
+ */
+struct blk_snap_cbt_info {
+	struct blk_snap_dev dev_id;
+	__u32 blk_size;
+	__u64 device_capacity;
+	__u32 blk_count;
+	struct blk_snap_uuid generation_id;
+	__u8 snap_number;
+};
+/**
+ * struct blk_snap_tracker_collect - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_COLLECT control.
+ * @count:
+ *	Size of @cbt_info_array in the number of &struct blk_snap_cbt_info.
+ *	If @cbt_info_array has not enough space, it will contain the required
+ *	size of the array.
+ * @cbt_info_array:
+ *	Pointer to the array for output.
+ */
+struct blk_snap_tracker_collect {
+	__u32 count;
+	struct blk_snap_cbt_info *cbt_info_array;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_COLLECT - Collect all tracked devices.
+ *
+ * Getting information about all devices under tracking.
+ * This ioctl returns the same information that the module outputs
+ * to sysfs for each device under tracking.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_COLLECT                                         \
+	_IOW(BLK_SNAP, blk_snap_ioctl_tracker_collect,                         \
+	     struct blk_snap_tracker_collect)
+
+/**
+ * struct blk_snap_tracker_read_cbt_bitmap - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP control.
+ * @dev_id:
+ *	Device ID.
+ * @offset:
+ *	Offset from the beginning of the CBT bitmap in bytes.
+ * @length:
+ *	Size of @buff in bytes.
+ * @buff:
+ *	Pointer to the buffer for output.
+ */
+struct blk_snap_tracker_read_cbt_bitmap {
+	struct blk_snap_dev dev_id;
+	__u32 offset;
+	__u32 length;
+	__u8 *buff;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP - Read the CBT map.
+ *
+ * This ioctl allows to read the table of changes. Sysfs also has a file that
+ * allows to read this table.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP                                    \
+	_IOR(BLK_SNAP, blk_snap_ioctl_tracker_read_cbt_map,                    \
+	     struct blk_snap_tracker_read_cbt_bitmap)
+
+/**
+ * struct blk_snap_block_range - Element of array for
+ *	&struct blk_snap_tracker_mark_dirty_blocks.
+ * @sector_offset:
+ *	Offset from the beginning of the disk in sectors.
+ * @sector_count:
+ *	Number of sectors.
+ */
+struct blk_snap_block_range {
+	__u64 sector_offset;
+	__u64 sector_count;
+};
+/**
+ * struct blk_snap_tracker_mark_dirty_blocks - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS control.
+ * @dev_id:
+ *	Device ID.
+ * @count:
+ *	Size of @dirty_blocks_array in the number of
+ *	&struct blk_snap_block_range.
+ * @dirty_blocks_array:
+ *	Pointer to the array of &struct blk_snap_block_range.
+ */
+struct blk_snap_tracker_mark_dirty_blocks {
+	struct blk_snap_dev dev_id;
+	__u32 count;
+	struct blk_snap_block_range *dirty_blocks_array;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS - Set dirty blocks in the CBT map.
+ *
+ * There are cases when some blocks need to be marked as changed.
+ * This ioctl allows to do this.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS                               \
+	_IOR(BLK_SNAP, blk_snap_ioctl_tracker_mark_dirty_blocks,               \
+	     struct blk_snap_tracker_mark_dirty_blocks)
+
+/*
+ * Next, there will be a description of the interface for working with
+ * snapshots.
+ */
+
+/**
+ * struct blk_snap_snapshot_create - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_CREATE control.
+ * @count:
+ *	Size of @dev_id_array in the number of &struct blk_snap_dev.
+ * @dev_id_array:
+ *	Pointer to the array of &struct blk_snap_dev.
+ * @id:
+ *	Return ID of the created snapshot.
+ */
+struct blk_snap_snapshot_create {
+	__u32 count;
+	struct blk_snap_dev *dev_id_array;
+	struct blk_snap_uuid id;
+};
+/**
+ * This ioctl creates a snapshot structure in the memory and allocates an
+ * identifier for it. Further interaction with the snapshot is possible by
+ * this identifier.
+ * Several snapshots can be created at the same time, but with the condition
+ * that one block device can only be included in one snapshot.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_CREATE                                         \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_create,                         \
+	     struct blk_snap_snapshot_create)
+
+/**
+ * struct blk_snap_snapshot_destroy - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_DESTROY control.
+ * @id:
+ *	Snapshot ID.
+ */
+struct blk_snap_snapshot_destroy {
+	struct blk_snap_uuid id;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_DESTROY - Release and destroy the snapshot.
+ *
+ * Destroys all snapshot structures and releases all its allocated resources.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_DESTROY                                        \
+	_IOR(BLK_SNAP, blk_snap_ioctl_snapshot_destroy,                        \
+	     struct blk_snap_snapshot_destroy)
+
+/**
+ * struct blk_snap_snapshot_append_storage - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE control.
+ * @id:
+ *	Snapshot ID.
+ * @dev_id:
+ *	Device ID.
+ * @count:
+ *	Size of @ranges in the number of &struct blk_snap_block_range.
+ * @ranges:
+ *	Pointer to the array of &struct blk_snap_block_range.
+ */
+struct blk_snap_snapshot_append_storage {
+	struct blk_snap_uuid id;
+	struct blk_snap_dev dev_id;
+	__u32 count;
+	struct blk_snap_block_range *ranges;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE - Append storage to the difference
+ *	storage of the snapshot.
+ *
+ * The snapshot difference storage can be set either before or after creating
+ * the snapshot images. This allows to dynamically expand the difference
+ * storage while holding the snapshot.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_append_storage,                 \
+	     struct blk_snap_snapshot_append_storage)
+
+/**
+ * struct blk_snap_snapshot_take - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_TAKE control.
+ * @id:
+ *	Snapshot ID.
+ */
+struct blk_snap_snapshot_take {
+	struct blk_snap_uuid id;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_TAKE - Take snapshot.
+ *
+ * This ioctl creates snapshot images of block devices and switches CBT tables.
+ * The snapshot must be created before this call, and the areas of block
+ * devices should be added to the difference storage.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_TAKE                                           \
+	_IOR(BLK_SNAP, blk_snap_ioctl_snapshot_take,                           \
+	     struct blk_snap_snapshot_take)
+
+/**
+ * struct blk_snap_snapshot_collect - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_COLLECT control.
+ * @count:
+ *	Size of @ids in the number of 16-byte UUID.
+ *	If @ids has not enough space, it will contain the required
+ *      size of the array.
+ * @ids:
+ *	Pointer to the array with the snapshot ID for output. If the pointer is
+ *	zero, the ioctl returns the number of active snapshots in &count.
+ *
+ */
+struct blk_snap_snapshot_collect {
+	__u32 count;
+	struct blk_snap_uuid *ids;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_COLLECT - Get collection of created snapshots.
+ *
+ * This information can also be obtained from files from sysfs.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT                                        \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_collect,                        \
+	     struct blk_snap_snapshot_collect)
+/**
+ * struct blk_snap_image_info - Associates the original device in the snapshot
+ *	and the corresponding snapshot image.
+ * @orig_dev_id:
+ *	Device ID.
+ * @image_dev_id:
+ *	Image ID.
+ */
+struct blk_snap_image_info {
+	struct blk_snap_dev orig_dev_id;
+	struct blk_snap_dev image_dev_id;
+};
+/**
+ * struct blk_snap_snapshot_collect_images - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES control.
+ * @id:
+ *	Snapshot ID.
+ * @count:
+ *	Size of @image_info_array in the number of &struct blk_snap_image_info.
+ *	If @image_info_array has not enough space, it will contain the required
+ *      size of the array.
+ * @image_info_array:
+ *	Pointer to the array for output.
+ */
+struct blk_snap_snapshot_collect_images {
+	struct blk_snap_uuid id;
+	__u32 count;
+	struct blk_snap_image_info *image_info_array;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES - Get a collection of devices and
+ *	their snapshot images.
+ *
+ * While holding the snapshot, this ioctl allows you to get a table of
+ * correspondences of the original devices and their snapshot images.
+ * This information can also be obtained from files from sysfs.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_collect_images,                 \
+	     struct blk_snap_snapshot_collect_images)
+
+enum blk_snap_event_codes {
+	/**
+	 * Low free space in difference storage event.
+	 *
+	 * If the free space in the difference storage is reduced to the
+	 * specified limit, the module generates this event.
+	 */
+	blk_snap_event_code_low_free_space,
+	/**
+	 * Snapshot image is corrupted event.
+	 *
+	 * If a chunk could not be allocated when trying to save data to the
+	 * difference storage, this event is generated.
+	 * However, this does not mean that the backup process was interrupted
+	 * with an error. If the snapshot image has been read to the end by
+	 * this time, the backup process is considered successful.
+	 */
+	blk_snap_event_code_corrupted,
+};
+
+/**
+ * struct blk_snap_snapshot_event - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT control.
+ * @id:
+ *	Snapshot ID.
+ * @timeout_ms:
+ *	Timeout for waiting in milliseconds.
+ * @time_label:
+ *	Timestamp of the received event.
+ * @code:
+ *	Code of the received event.
+ * @data:
+ *	The received event body.
+ */
+struct blk_snap_snapshot_event {
+	struct blk_snap_uuid id;
+	__u32 timeout_ms;
+	__u32 code;
+	__s64 time_label;
+	__u8 data[4096 - 32];
+};
+static_assert(
+	sizeof(struct blk_snap_snapshot_event) == 4096,
+	"The size struct blk_snap_snapshot_event should be equal to the size of the page.");
+
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT - Wait and get the event from the
+ *	snapshot.
+ *
+ * While holding the snapshot, the kernel module can transmit information about
+ * changes in its state in the form of events to the user level.
+ * It is very important to receive these events as quickly as possible, so the
+ * user's thread is in the state of interruptable sleep.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT                                     \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_wait_event,                     \
+	     struct blk_snap_snapshot_event)
+
+/**
+ * struct blk_snap_event_low_free_space - Data for the
+ *	&blk_snap_event_code_low_free_space event.
+ * @requested_nr_sect:
+ *	The required number of sectors.
+ */
+struct blk_snap_event_low_free_space {
+	__u64 requested_nr_sect;
+};
+
+/**
+ * struct blk_snap_event_corrupted - Data for the
+ *	&blk_snap_event_code_corrupted event.
+ * @orig_dev_id:
+ *	Device ID.
+ * @err_code:
+ *	Error code.
+ */
+struct blk_snap_event_corrupted {
+	struct blk_snap_dev orig_dev_id;
+	__s32 err_code;
+};
+
+#endif /* _UAPI_LINUX_BLK_SNAP_H */
-- 
2.20.1

