Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871BD64846E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiLIO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLIO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:59:10 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C8265;
        Fri,  9 Dec 2022 06:59:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 3EC417D484;
        Fri,  9 Dec 2022 17:24:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595843;
        bh=PlwM9+pDZPZhN1ifwlRdCTd9PQ+6LbQtpg/bSCFWDwQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=K7hutDI9PLAbLCY1rpCjd/9GVnGtcfKLWV7V3Or7PlQLn8h3IdXBAt/uyKS/c4NWj
         tvy0SbWi/PrZP/yVGDdfoYd2vu0K97FNu40mukBG+OWvN7YU2ptGJOwUHjwmgzeCZ3
         OZivTSztdUkRNJBP/eJQKkhHHU3VKZ2eOoUA5z0daofoWS+6ULzSXP9Zkmthd6+H3L
         BR3S3HhhnjZVyEGlNodT8u9cSB6eCBa4vNefeuPn/wcYAoO7E/KuFajWB5ZwJyCcP0
         KhqTfoAWRvInVYVhrgXDgurYstijIsggYFq3CQheVi9AmYdKb/Y3VVm0y1o9EDUp/x
         b9PSFhd0p+tIQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:00 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 05/21] block, blksnap: header file of the module interface
Date:   Fri, 9 Dec 2022 15:23:15 +0100
Message-ID: <20221209142331.26395-6-sergei.shtepa@veeam.com>
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

The header file contains a set of declarations, structures and control
requests (ioctl) that allows to manage the module from the user space.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 include/uapi/linux/blksnap.h | 549 +++++++++++++++++++++++++++++++++++
 1 file changed, 549 insertions(+)
 create mode 100644 include/uapi/linux/blksnap.h

diff --git a/include/uapi/linux/blksnap.h b/include/uapi/linux/blksnap.h
new file mode 100644
index 000000000000..970ed5c42cf1
--- /dev/null
+++ b/include/uapi/linux/blksnap.h
@@ -0,0 +1,549 @@
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
+	 * Change tracking controls
+	 */
+	blk_snap_ioctl_tracker_remove,
+	blk_snap_ioctl_tracker_collect,
+	blk_snap_ioctl_tracker_read_cbt_map,
+	blk_snap_ioctl_tracker_mark_dirty_blocks,
+	/*
+	 * Snapshot controls
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
+ * DOC: Service controls
+ */
+
+/**
+ * struct blk_snap_version - Module version.
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
+ * define IOCTL_BLK_SNAP_VERSION - Get module version.
+ *
+ * The version may increase when the API changes. But linking the user space
+ * behavior to the version code does not seem to be a good idea.
+ * To ensure backward compatibility, API changes should be made by adding new
+ * ioctl without changing the behavior of existing ones. The version should be
+ * used for logs.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
+ */
+#define IOCTL_BLK_SNAP_VERSION                                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_version, struct blk_snap_version)
+
+/**
+ * DOC: Interface for the change tracking mechanism
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
+
+/**
+ * define IOCTL_BLK_SNAP_TRACKER_REMOVE - Remove a device from tracking.
+ *
+ * Removes the device from tracking changes. Adding a device for tracking is
+ * performed when creating a snapshot that includes this block device.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_REMOVE                                          \
+	_IOW(BLK_SNAP, blk_snap_ioctl_tracker_remove,                          \
+	     struct blk_snap_tracker_remove)
+
+/**
+ * struct blk_snap_uuid - Unique 16-byte identifier.
+ * @b:
+ *	An array of 16 bytes.
+ */
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
+ *	Unique identifier of change tracking generation.
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
+
+/**
+ * struct blk_snap_tracker_collect - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_COLLECT control.
+ * @count:
+ *	Size of &blk_snap_tracker_collect.cbt_info_array.
+ * @cbt_info_array:
+ *	Pointer to the array for output.
+ */
+struct blk_snap_tracker_collect {
+	__u32 count;
+	struct blk_snap_cbt_info *cbt_info_array;
+};
+
+/**
+ * define IOCTL_BLK_SNAP_TRACKER_COLLECT - Collect all tracked devices.
+ *
+ * Getting information about all devices under tracking.
+ *
+ * If in &blk_snap_tracker_collect.count is less than required to
+ * store the &blk_snap_tracker_collect.cbt_info_array, the array is not filled,
+ * and the ioctl returns the required count for
+ * &blk_snap_tracker_collect.cbt_info_array.
+ *
+ * So, it is recommended to call the ioctl twice. The first call with an null
+ * pointer &blk_snap_tracker_collect.cbt_info_array and a zero value in
+ * &blk_snap_tracker_collect.count. It will set the required array size in
+ * &blk_snap_tracker_collect.count. The second call with a pointer
+ * &blk_snap_tracker_collect.cbt_info_array to an array of the required size
+ * will allow to get information about the tracked block devices.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
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
+
+/**
+ * define IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP - Read the CBT map.
+ *
+ * Allows to read the table of changes.
+ *
+ * The size of the table can be quite large. Thus, the table is read in a loop,
+ * in each cycle of which the next offset is set to
+ * &blk_snap_tracker_read_cbt_bitmap.offset.
+ *
+ * Return: a count of bytes read if succeeded, negative errno otherwise.
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
+
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
+
+/**
+ * define IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS - Set dirty blocks in the
+ *	CBT map.
+ *
+ * There are cases when some blocks need to be marked as changed.
+ * This ioctl allows to do this.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS                               \
+	_IOR(BLK_SNAP, blk_snap_ioctl_tracker_mark_dirty_blocks,               \
+	     struct blk_snap_tracker_mark_dirty_blocks)
+
+/**
+ * DOC: Interface for managing snapshots
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
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_CREATE - Create snapshot.
+ *
+ * Creates a snapshot structure in the memory and allocates an identifier for
+ * it. Further interaction with the snapshot is possible by this identifier.
+ * A snapshot is created for several block devices at once.
+ * Several snapshots can be created at the same time, but with the condition
+ * that one block device can only be included in one snapshot.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
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
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_DESTROY - Release and destroy the snapshot.
+ *
+ * Destroys snapshot with &blk_snap_snapshot_destroy.id. This leads to the
+ * deletion of all block device images of the snapshot. The difference storage
+ * is being released. But the change tracker keeps tracking.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
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
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE - Append storage to the
+ *	difference storage of the snapshot.
+ *
+ * The snapshot difference storage can be set either before or after creating
+ * the snapshot images. This allows to dynamically expand the difference
+ * storage while holding the snapshot.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
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
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_TAKE - Take snapshot.
+ *
+ * Creates snapshot images of block devices and switches change trackers tables.
+ * The snapshot must be created before this call, and the areas of block
+ * devices should be added to the difference storage.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_TAKE                                           \
+	_IOR(BLK_SNAP, blk_snap_ioctl_snapshot_take,                           \
+	     struct blk_snap_snapshot_take)
+
+/**
+ * struct blk_snap_snapshot_collect - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_COLLECT control.
+ * @count:
+ *	Size of &blk_snap_snapshot_collect.ids in the number of 16-byte UUID.
+ * @ids:
+ *	Pointer to the array with the snapshot ID for output.
+ */
+struct blk_snap_snapshot_collect {
+	__u32 count;
+	struct blk_snap_uuid *ids;
+};
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT - Get collection of created snapshots.
+ *
+ * Multiple snapshots can be created at the same time. This allows for one
+ * system to create backups for different data with a independent schedules.
+ *
+ * If in &blk_snap_snapshot_collect.count is less than required to store the
+ * &blk_snap_snapshot_collect.ids, the array is not filled, and the ioctl
+ * returns the required count for &blk_snap_snapshot_collect.ids.
+ *
+ * So, it is recommended to call the ioctl twice. The first call with an null
+ * pointer &blk_snap_snapshot_collect.ids and a zero value in
+ * &blk_snap_snapshot_collect.count. It will set the required array size in
+ * &blk_snap_snapshot_collect.count. The second call with a pointer
+ * &blk_snap_snapshot_collect.ids to an array of the required size will allow to
+ * get collection of active snapshots.
+ *
+ * Return: 0 if succeeded, -ENODATA if there is not enough space in the array
+ * to store collection of active snapshots, or negative errno otherwise.
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
+
+/**
+ * struct blk_snap_snapshot_collect_images - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES control.
+ * @id:
+ *	Snapshot ID.
+ * @count:
+ *	Size of &image_info_array in the number of &struct blk_snap_image_info.
+ * @image_info_array:
+ *	Pointer to the array for output.
+ */
+struct blk_snap_snapshot_collect_images {
+	struct blk_snap_uuid id;
+	__u32 count;
+	struct blk_snap_image_info *image_info_array;
+};
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES - Get a collection of devices
+ *	and their snapshot images.
+ *
+ * While holding the snapshot, this ioctl allows to get a table of
+ * correspondences of the original devices and their snapshot images.
+ *
+ * If &blk_snap_snapshot_collect_images.count is less than required to store the
+ * &blk_snap_snapshot_collect_images.image_info_array, the array is not filled,
+ * and the ioctl returns the required count for
+ * &blk_snap_snapshot_collect.image_info_array.
+ *
+ * So, it is recommended to call the ioctl twice. The first call with an null
+ * pointer &blk_snap_snapshot_collect_images.image_info_array and a zero value
+ * in &blk_snap_snapshot_collect_images.count. It will set the required array
+ * size in &blk_snap_snapshot_collect_images.count. The second call with a
+ * pointer &blk_snap_snapshot_collect_images.image_info_array to an array of the
+ * required size will allow to get collection of devices and their snapshot
+ * images.
+ *
+ * Return: 0 if succeeded, -ENODATA if there is not enough space in the array
+ * to store collection of devices and their snapshot images, negative errno
+ * otherwise.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_collect_images,                 \
+	     struct blk_snap_snapshot_collect_images)
+
+/**
+ * enum blk_snap_event_codes - Variants of event codes.
+ *
+ * @blk_snap_event_code_low_free_space:
+ *	Low free space in difference storage event.
+ *	If the free space in the difference storage is reduced to the specified
+ *	limit, the module generates this event.
+ * @blk_snap_event_code_corrupted:
+ *	Snapshot image is corrupted event.
+ *	If a chunk could not be allocated when trying to save data to the
+ *	difference storage, this event is generated. However, this does not mean
+ *	that the backup process was interrupted with an error. If the snapshot
+ *	image has been read to the end by this time, the backup process is
+ *	considered successful.
+ */
+enum blk_snap_event_codes {
+	blk_snap_event_code_low_free_space,
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
+ *	Code of the received event &enum blk_snap_event_codes.
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
+static_assert(sizeof(struct blk_snap_snapshot_event) == 4096,
+	"The size struct blk_snap_snapshot_event should be equal to the size of the page.");
+
+/**
+ * define IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT - Wait and get the event from the
+ *	snapshot.
+ *
+ * While holding the snapshot, the kernel module can transmit information about
+ * changes in its state in the form of events to the user level.
+ * It is very important to receive these events as quickly as possible, so the
+ * user's thread is in the state of interruptable sleep.
+ *
+ * Return: 0 if succeeded, negative errno otherwise.
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

