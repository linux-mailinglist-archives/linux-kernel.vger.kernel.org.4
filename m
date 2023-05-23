Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3509170D5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjEWHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjEWHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285941A6;
        Tue, 23 May 2023 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RkTK03q0KBGmTu4V94YVC/fxxfp+DdgNwog7XQQ9cFY=; b=Rcbz2UFgL6qjbaulUaNQFa8ri7
        uc2zhiBAbObnusWxCSeZVCyRjbxZUBVRZhSjPusoFBTW7xeP4DKcogSVfx2t2y1/feW0/AEpZe2RR
        KYGhLovzums16xhg28Gu5FVkol1gHOticSfZgWx47Pqa75MKvhUMajt+GnlfKT6bZhpZA/ur7Hn/d
        vkhyEGAe98/YICWk3X/0w3j1lwt1YIHCWD0NLZ+aPIhPXspCMwR809WUI1yeloXSHewhUXsxJ/E2Q
        ice1U5WYTEungvjAl9u1rU5/qgIoImJcdN51fFlL4xwaArm1/d3Q9Yas64RvJHPgY+pZfV2EoMb5l
        FRE2w1wA==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Mip-009GzK-13;
        Tue, 23 May 2023 07:46:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 15/24] block: move the code to do early boot lookup of block devices to block/
Date:   Tue, 23 May 2023 09:45:26 +0200
Message-Id: <20230523074535.249802-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new block/early-lookup.c to keep the early block device lookup
code instead of having this code sit with the early mount code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../admin-guide/kernel-parameters.txt         |   2 +-
 block/Makefile                                |   2 +-
 block/early-lookup.c                          | 224 ++++++++++++++++++
 init/do_mounts.c                              | 219 -----------------
 4 files changed, 226 insertions(+), 221 deletions(-)
 create mode 100644 block/early-lookup.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f08b83e62c6222..3f8cf6dc7de887 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5452,7 +5452,7 @@
 			port and the regular usb controller gets disabled.
 
 	root=		[KNL] Root filesystem
-			See early_lookup_bdev comment in init/do_mounts.c.
+			See early_lookup_bdev comment in block/early-lookup.c
 
 	rootdelay=	[KNL] Delay (in seconds) to pause before attempting to
 			mount the root filesystem
diff --git a/block/Makefile b/block/Makefile
index b31b05390749a1..46ada9dc8bbfe2 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,7 +9,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
-			disk-events.o blk-ia-ranges.o
+			disk-events.o blk-ia-ranges.o early-lookup.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
diff --git a/block/early-lookup.c b/block/early-lookup.c
new file mode 100644
index 00000000000000..9fc30d039508af
--- /dev/null
+++ b/block/early-lookup.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Code for looking up block devices in the early boot code before mounting the
+ * root file system.  Unfortunately currently also abused in a few other places.
+ */
+#include <linux/blkdev.h>
+#include <linux/ctype.h>
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
+static int devt_from_partuuid(const char *uuid_str, dev_t *devt)
+{
+	struct uuidcmp cmp;
+	struct device *dev = NULL;
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
+			goto out_invalid;
+		cmp.len = slash - uuid_str;
+	} else {
+		cmp.len = strlen(uuid_str);
+	}
+
+	if (!cmp.len)
+		goto out_invalid;
+
+	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
+	if (!dev)
+		return -ENODEV;
+
+	if (offset) {
+		/*
+		 * Attempt to find the requested partition by adding an offset
+		 * to the partition number found by UUID.
+		 */
+		*devt = part_devt(dev_to_disk(dev),
+				  dev_to_bdev(dev)->bd_partno + offset);
+	} else {
+		*devt = dev->devt;
+	}
+
+	put_device(dev);
+	return 0;
+
+out_invalid:
+	pr_err("VFS: PARTUUID= is invalid.\n"
+	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
+	return -EINVAL;
+}
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
+static int devt_from_partlabel(const char *label, dev_t *devt)
+{
+	struct device *dev;
+
+	dev = class_find_device(&block_class, NULL, label, &match_dev_by_label);
+	if (!dev)
+		return -ENODEV;
+	*devt = dev->devt;
+	put_device(dev);
+	return 0;
+}
+
+static int devt_from_devname(const char *name, dev_t *devt)
+{
+	int part;
+	char s[32];
+	char *p;
+
+	if (strlen(name) > 31)
+		return -EINVAL;
+	strcpy(s, name);
+	for (p = s; *p; p++) {
+		if (*p == '/')
+			*p = '!';
+	}
+
+	*devt = blk_lookup_devt(s, 0);
+	if (*devt)
+		return 0;
+
+	/*
+	 * Try non-existent, but valid partition, which may only exist after
+	 * opening the device, like partitioned md devices.
+	 */
+	while (p > s && isdigit(p[-1]))
+		p--;
+	if (p == s || !*p || *p == '0')
+		return -EINVAL;
+
+	/* try disk name without <part number> */
+	part = simple_strtoul(p, NULL, 10);
+	*p = '\0';
+	*devt = blk_lookup_devt(s, part);
+	if (*devt)
+		return 0;
+
+	/* try disk name without p<part number> */
+	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
+		return -EINVAL;
+	p[-1] = '\0';
+	*devt = blk_lookup_devt(s, part);
+	if (*devt)
+		return 0;
+	return -EINVAL;
+}
+
+static int devt_from_devnum(const char *name, dev_t *devt)
+{
+	unsigned maj, min, offset;
+	char *p, dummy;
+
+	if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
+	    sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset, &dummy) == 3) {
+		*devt = MKDEV(maj, min);
+		if (maj != MAJOR(*devt) || min != MINOR(*devt))
+			return -EINVAL;
+	} else {
+		*devt = new_decode_dev(simple_strtoul(name, &p, 16));
+		if (*p)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ *	Convert a name into device number.  We accept the following variants:
+ *
+ *	1) <hex_major><hex_minor> device number in hexadecimal represents itself
+ *         no leading 0x, for example b302.
+ *	3) /dev/<disk_name> represents the device number of disk
+ *	4) /dev/<disk_name><decimal> represents the device number
+ *         of partition - device number of disk plus the partition number
+ *	5) /dev/<disk_name>p<decimal> - same as the above, that form is
+ *	   used when disk name of partitioned disk ends on a digit.
+ *	6) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+ *	   unique id of a partition if the partition table provides it.
+ *	   The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
+ *	   partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
+ *	   filled hex representation of the 32-bit "NT disk signature", and PP
+ *	   is a zero-filled hex representation of the 1-based partition number.
+ *	7) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
+ *	   a partition with a known unique id.
+ *	8) <major>:<minor> major and minor number of the device separated by
+ *	   a colon.
+ *	9) PARTLABEL=<name> with name being the GPT partition label.
+ *	   MSDOS partitions do not support labels!
+ *
+ *	If name doesn't have fall into the categories above, we return (0,0).
+ *	block_class is used to check if something is a disk name. If the disk
+ *	name contains slashes, the device name has them replaced with
+ *	bangs.
+ */
+int early_lookup_bdev(const char *name, dev_t *devt)
+{
+	if (strncmp(name, "PARTUUID=", 9) == 0)
+		return devt_from_partuuid(name + 9, devt);
+	if (strncmp(name, "PARTLABEL=", 10) == 0)
+		return devt_from_partlabel(name + 10, devt);
+	if (strncmp(name, "/dev/", 5) == 0)
+		return devt_from_devname(name + 5, devt);
+	return devt_from_devnum(name, devt);
+}
+EXPORT_SYMBOL_GPL(early_lookup_bdev);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 0b36a5f39ee8e2..780546a6cbfb6f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -59,225 +59,6 @@ static int __init readwrite(char *str)
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
-static int devt_from_partuuid(const char *uuid_str, dev_t *devt)
-{
-	struct uuidcmp cmp;
-	struct device *dev = NULL;
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
-			goto out_invalid;
-		cmp.len = slash - uuid_str;
-	} else {
-		cmp.len = strlen(uuid_str);
-	}
-
-	if (!cmp.len)
-		goto out_invalid;
-
-	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
-	if (!dev)
-		return -ENODEV;
-
-	if (offset) {
-		/*
-		 * Attempt to find the requested partition by adding an offset
-		 * to the partition number found by UUID.
-		 */
-		*devt = part_devt(dev_to_disk(dev),
-				  dev_to_bdev(dev)->bd_partno + offset);
-	} else {
-		*devt = dev->devt;
-	}
-
-	put_device(dev);
-	return 0;
-
-out_invalid:
-	pr_err("VFS: PARTUUID= is invalid.\n"
-	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
-	return -EINVAL;
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
-static int devt_from_partlabel(const char *label, dev_t *devt)
-{
-	struct device *dev;
-
-	dev = class_find_device(&block_class, NULL, label, &match_dev_by_label);
-	if (!dev)
-		return -ENODEV;
-	*devt = dev->devt;
-	put_device(dev);
-	return 0;
-}
-
-static int devt_from_devname(const char *name, dev_t *devt)
-{
-	int part;
-	char s[32];
-	char *p;
-
-	if (strlen(name) > 31)
-		return -EINVAL;
-	strcpy(s, name);
-	for (p = s; *p; p++) {
-		if (*p == '/')
-			*p = '!';
-	}
-
-	*devt = blk_lookup_devt(s, 0);
-	if (*devt)
-		return 0;
-
-	/*
-	 * Try non-existent, but valid partition, which may only exist after
-	 * opening the device, like partitioned md devices.
-	 */
-	while (p > s && isdigit(p[-1]))
-		p--;
-	if (p == s || !*p || *p == '0')
-		return -EINVAL;
-
-	/* try disk name without <part number> */
-	part = simple_strtoul(p, NULL, 10);
-	*p = '\0';
-	*devt = blk_lookup_devt(s, part);
-	if (*devt)
-		return 0;
-
-	/* try disk name without p<part number> */
-	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-		return -EINVAL;
-	p[-1] = '\0';
-	*devt = blk_lookup_devt(s, part);
-	if (*devt)
-		return 0;
-	return -EINVAL;
-}
-
-static int devt_from_devnum(const char *name, dev_t *devt)
-{
-	unsigned maj, min, offset;
-	char *p, dummy;
-
-	if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
-	    sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset, &dummy) == 3) {
-		*devt = MKDEV(maj, min);
-		if (maj != MAJOR(*devt) || min != MINOR(*devt))
-			return -EINVAL;
-	} else {
-		*devt = new_decode_dev(simple_strtoul(name, &p, 16));
-		if (*p)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-/*
- *	Convert a name into device number.  We accept the following variants:
- *
- *	1) <hex_major><hex_minor> device number in hexadecimal represents itself
- *         no leading 0x, for example b302.
- *	3) /dev/<disk_name> represents the device number of disk
- *	4) /dev/<disk_name><decimal> represents the device number
- *         of partition - device number of disk plus the partition number
- *	5) /dev/<disk_name>p<decimal> - same as the above, that form is
- *	   used when disk name of partitioned disk ends on a digit.
- *	6) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
- *	   unique id of a partition if the partition table provides it.
- *	   The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
- *	   partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
- *	   filled hex representation of the 32-bit "NT disk signature", and PP
- *	   is a zero-filled hex representation of the 1-based partition number.
- *	7) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
- *	   a partition with a known unique id.
- *	8) <major>:<minor> major and minor number of the device separated by
- *	   a colon.
- *	9) PARTLABEL=<name> with name being the GPT partition label.
- *	   MSDOS partitions do not support labels!
- *
- *	If name doesn't have fall into the categories above, we return (0,0).
- *	block_class is used to check if something is a disk name. If the disk
- *	name contains slashes, the device name has them replaced with
- *	bangs.
- */
-int early_lookup_bdev(const char *name, dev_t *devt)
-{
-	if (strncmp(name, "PARTUUID=", 9) == 0)
-		return devt_from_partuuid(name + 9, devt);
-	if (strncmp(name, "PARTLABEL=", 10) == 0)
-		return devt_from_partlabel(name + 10, devt);
-	if (strncmp(name, "/dev/", 5) == 0)
-		return devt_from_devname(name + 5, devt);
-	return devt_from_devnum(name, devt);
-}
-EXPORT_SYMBOL_GPL(early_lookup_bdev);
-#endif
-
 static int __init root_dev_setup(char *line)
 {
 	strscpy(saved_root_name, line, sizeof(saved_root_name));
-- 
2.39.2

