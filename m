Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C032064B562
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiLMMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiLMMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:45:59 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917ED1D2;
        Tue, 13 Dec 2022 04:45:58 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p54fU-0002GH-NI; Tue, 13 Dec 2022 13:45:56 +0100
Date:   Tue, 13 Dec 2022 12:45:42 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/2] init: move block device helpers from init/do_mounts.c
Message-ID: <Y5hz9nuq7tECYcyt@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In init/do_mounts.c there are helper functions devt_from_partuuid,
devt_from_partlabel and devt_from_devname. In order to make these
functions available to other users, move them to block/bdev.c.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/bdev.c           | 166 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  15 ++++
 init/do_mounts.c       | 166 +----------------------------------------
 3 files changed, 183 insertions(+), 164 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index d699ecdb3260..92e3e5c81337 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1092,3 +1092,169 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 	blkdev_put_no_open(bdev);
 }
+
+struct uuidcmp {
+	const char *uuid;
+	int len;
+};
+
+/**
+ * match_dev_by_uuid - callback for finding a partition using its uuid
+ * @dev:	device passed in by the caller
+ * @data:	opaque pointer to the desired struct uuidcmp to match
+ *
+ * Returns 1 if the device matches, and 0 otherwise.
+ */
+static int match_dev_by_uuid(struct device *dev, const void *data)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	const struct uuidcmp *cmp = data;
+
+	if (!bdev->bd_meta_info ||
+	    strncasecmp(cmp->uuid, bdev->bd_meta_info->uuid, cmp->len))
+		return 0;
+	return 1;
+}
+
+/**
+ * devt_from_partuuid - looks up the dev_t of a partition by its UUID
+ * @uuid_str:	char array containing ascii UUID
+ *
+ * The function will return the first partition which contains a matching
+ * UUID value in its partition_meta_info struct.  This does not search
+ * by filesystem UUIDs.
+ *
+ * If @uuid_str is followed by a "/PARTNROFF=%d", then the number will be
+ * extracted and used as an offset from the partition identified by the UUID.
+ *
+ * Returns the matching dev_t on success or 0 on failure.
+ */
+dev_t devt_from_partuuid(const char *uuid_str, int *root_wait)
+{
+	struct uuidcmp cmp;
+	struct device *dev = NULL;
+	dev_t devt = 0;
+	int offset = 0;
+	char *slash;
+
+	cmp.uuid = uuid_str;
+
+	slash = strchr(uuid_str, '/');
+	/* Check for optional partition number offset attributes. */
+	if (slash) {
+		char c = 0;
+
+		/* Explicitly fail on poor PARTUUID syntax. */
+		if (sscanf(slash + 1, "PARTNROFF=%d%c", &offset, &c) != 1)
+			goto clear_root_wait;
+		cmp.len = slash - uuid_str;
+	} else {
+		cmp.len = strlen(uuid_str);
+	}
+
+	if (!cmp.len)
+		goto clear_root_wait;
+
+	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
+	if (!dev)
+		return 0;
+
+	if (offset) {
+		/*
+		 * Attempt to find the requested partition by adding an offset
+		 * to the partition number found by UUID.
+		 */
+		devt = part_devt(dev_to_disk(dev),
+				 dev_to_bdev(dev)->bd_partno + offset);
+	} else {
+		devt = dev->devt;
+	}
+
+	put_device(dev);
+	return devt;
+
+clear_root_wait:
+	pr_err("VFS: PARTUUID= is invalid.\n"
+	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
+	if (root_wait && *root_wait) {
+		pr_err("Disabling rootwait; root= is invalid.\n");
+		*root_wait = 0;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devt_from_partuuid);
+
+/**
+ * match_dev_by_label - callback for finding a partition using its label
+ * @dev:	device passed in by the caller
+ * @data:	opaque pointer to the label to match
+ *
+ * Returns 1 if the device matches, and 0 otherwise.
+ */
+static int match_dev_by_label(struct device *dev, const void *data)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	const char *label = data;
+
+	if (!bdev->bd_meta_info || strcmp(label, bdev->bd_meta_info->volname))
+		return 0;
+	return 1;
+}
+
+dev_t devt_from_partlabel(const char *label)
+{
+	struct device *dev;
+	dev_t devt = 0;
+
+	dev = class_find_device(&block_class, NULL, label, &match_dev_by_label);
+	if (dev) {
+		devt = dev->devt;
+		put_device(dev);
+	}
+
+	return devt;
+}
+EXPORT_SYMBOL_GPL(devt_from_partlabel);
+
+dev_t devt_from_devname(const char *name)
+{
+	dev_t devt = 0;
+	int part;
+	char s[32];
+	char *p;
+
+	if (strlen(name) > 31)
+		return 0;
+	strcpy(s, name);
+	for (p = s; *p; p++) {
+		if (*p == '/')
+			*p = '!';
+	}
+
+	devt = blk_lookup_devt(s, 0);
+	if (devt)
+		return devt;
+
+	/*
+	 * Try non-existent, but valid partition, which may only exist after
+	 * opening the device, like partitioned md devices.
+	 */
+	while (p > s && isdigit(p[-1]))
+		p--;
+	if (p == s || !*p || *p == '0')
+		return 0;
+
+	/* try disk name without <part number> */
+	part = simple_strtoul(p, NULL, 10);
+	*p = '\0';
+	devt = blk_lookup_devt(s, part);
+	if (devt)
+		return devt;
+
+	/* try disk name without p<part number> */
+	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
+		return 0;
+	p[-1] = '\0';
+	return blk_lookup_devt(s, part);
+}
+EXPORT_SYMBOL_GPL(devt_from_devname);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fb27dfaaaf85..b45cdcdccc6d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1494,6 +1494,9 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
 		loff_t lend);
 
 #ifdef CONFIG_BLOCK
+dev_t devt_from_partuuid(const char *uuid_str, int *root_wait);
+dev_t devt_from_partlabel(const char *label);
+dev_t devt_from_devname(const char *name);
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
@@ -1502,6 +1505,18 @@ void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
 #else
+static inline dev_t devt_from_partuuid(const char *uuid_str, int *root_wait)
+{
+	return MKDEV(0, 0);
+}
+static inline dev_t devt_from_partlabel(const char *label);
+{
+	return MKDEV(0, 0);
+}
+static inline dev_t devt_from_devname(const char *name);
+{
+	return MKDEV(0, 0);
+}
 static inline void invalidate_bdev(struct block_device *bdev)
 {
 }
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..d55e34994f18 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/blkdev.h>
 #include <linux/ctype.h>
 #include <linux/fd.h>
 #include <linux/tty.h>
@@ -60,169 +61,6 @@ static int __init readwrite(char *str)
 __setup("ro", readonly);
 __setup("rw", readwrite);
 
-#ifdef CONFIG_BLOCK
-struct uuidcmp {
-	const char *uuid;
-	int len;
-};
-
-/**
- * match_dev_by_uuid - callback for finding a partition using its uuid
- * @dev:	device passed in by the caller
- * @data:	opaque pointer to the desired struct uuidcmp to match
- *
- * Returns 1 if the device matches, and 0 otherwise.
- */
-static int match_dev_by_uuid(struct device *dev, const void *data)
-{
-	struct block_device *bdev = dev_to_bdev(dev);
-	const struct uuidcmp *cmp = data;
-
-	if (!bdev->bd_meta_info ||
-	    strncasecmp(cmp->uuid, bdev->bd_meta_info->uuid, cmp->len))
-		return 0;
-	return 1;
-}
-
-/**
- * devt_from_partuuid - looks up the dev_t of a partition by its UUID
- * @uuid_str:	char array containing ascii UUID
- *
- * The function will return the first partition which contains a matching
- * UUID value in its partition_meta_info struct.  This does not search
- * by filesystem UUIDs.
- *
- * If @uuid_str is followed by a "/PARTNROFF=%d", then the number will be
- * extracted and used as an offset from the partition identified by the UUID.
- *
- * Returns the matching dev_t on success or 0 on failure.
- */
-static dev_t devt_from_partuuid(const char *uuid_str)
-{
-	struct uuidcmp cmp;
-	struct device *dev = NULL;
-	dev_t devt = 0;
-	int offset = 0;
-	char *slash;
-
-	cmp.uuid = uuid_str;
-
-	slash = strchr(uuid_str, '/');
-	/* Check for optional partition number offset attributes. */
-	if (slash) {
-		char c = 0;
-
-		/* Explicitly fail on poor PARTUUID syntax. */
-		if (sscanf(slash + 1, "PARTNROFF=%d%c", &offset, &c) != 1)
-			goto clear_root_wait;
-		cmp.len = slash - uuid_str;
-	} else {
-		cmp.len = strlen(uuid_str);
-	}
-
-	if (!cmp.len)
-		goto clear_root_wait;
-
-	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
-	if (!dev)
-		return 0;
-
-	if (offset) {
-		/*
-		 * Attempt to find the requested partition by adding an offset
-		 * to the partition number found by UUID.
-		 */
-		devt = part_devt(dev_to_disk(dev),
-				 dev_to_bdev(dev)->bd_partno + offset);
-	} else {
-		devt = dev->devt;
-	}
-
-	put_device(dev);
-	return devt;
-
-clear_root_wait:
-	pr_err("VFS: PARTUUID= is invalid.\n"
-	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
-	if (root_wait)
-		pr_err("Disabling rootwait; root= is invalid.\n");
-	root_wait = 0;
-	return 0;
-}
-
-/**
- * match_dev_by_label - callback for finding a partition using its label
- * @dev:	device passed in by the caller
- * @data:	opaque pointer to the label to match
- *
- * Returns 1 if the device matches, and 0 otherwise.
- */
-static int match_dev_by_label(struct device *dev, const void *data)
-{
-	struct block_device *bdev = dev_to_bdev(dev);
-	const char *label = data;
-
-	if (!bdev->bd_meta_info || strcmp(label, bdev->bd_meta_info->volname))
-		return 0;
-	return 1;
-}
-
-static dev_t devt_from_partlabel(const char *label)
-{
-	struct device *dev;
-	dev_t devt = 0;
-
-	dev = class_find_device(&block_class, NULL, label, &match_dev_by_label);
-	if (dev) {
-		devt = dev->devt;
-		put_device(dev);
-	}
-
-	return devt;
-}
-
-static dev_t devt_from_devname(const char *name)
-{
-	dev_t devt = 0;
-	int part;
-	char s[32];
-	char *p;
-
-	if (strlen(name) > 31)
-		return 0;
-	strcpy(s, name);
-	for (p = s; *p; p++) {
-		if (*p == '/')
-			*p = '!';
-	}
-
-	devt = blk_lookup_devt(s, 0);
-	if (devt)
-		return devt;
-
-	/*
-	 * Try non-existent, but valid partition, which may only exist after
-	 * opening the device, like partitioned md devices.
-	 */
-	while (p > s && isdigit(p[-1]))
-		p--;
-	if (p == s || !*p || *p == '0')
-		return 0;
-
-	/* try disk name without <part number> */
-	part = simple_strtoul(p, NULL, 10);
-	*p = '\0';
-	devt = blk_lookup_devt(s, part);
-	if (devt)
-		return devt;
-
-	/* try disk name without p<part number> */
-	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-		return 0;
-	p[-1] = '\0';
-	return blk_lookup_devt(s, part);
-}
-#endif /* CONFIG_BLOCK */
 
 static dev_t devt_from_devnum(const char *name)
 {
@@ -284,7 +122,7 @@ dev_t name_to_dev_t(const char *name)
 		return Root_RAM0;
 #ifdef CONFIG_BLOCK
 	if (strncmp(name, "PARTUUID=", 9) == 0)
-		return devt_from_partuuid(name + 9);
+		return devt_from_partuuid(name + 9, &root_wait);
 	if (strncmp(name, "PARTLABEL=", 10) == 0)
 		return devt_from_partlabel(name + 10);
 	if (strncmp(name, "/dev/", 5) == 0)
-- 
2.39.0

