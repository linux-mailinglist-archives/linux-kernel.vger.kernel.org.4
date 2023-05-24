Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB970EF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjEXHZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbjEXHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:24:53 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D0131
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:24:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjNA1iG_1684913076;
Received: from localhost(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0VjNA1iG_1684913076)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 15:24:37 +0800
From:   Du Rui <durui@linux.alibaba.com>
To:     dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Du Rui <durui@linux.alibaba.com>,
        Yuan Yifan <yuanyifan@linux.alibaba.com>,
        Liu Lanzheng <liulz@linux.alibaba.com>
Subject: [RFC PATCH v2] dm overlaybd: targets mapping OverlayBD image
Date:   Wed, 24 May 2023 15:24:06 +0800
Message-Id: <7c9c8f719835b10cb20fd1ae7733d2a609cf035a.1684912947.git.durui@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OverlayBD is a generic layering block-level image format, which is design
for container, secure container and applicable to virtual machine,
published in USENIX ATC '20
https://www.usenix.org/system/files/atc20-li-huiba.pdf

OverlayBD already has a ContainerD non-core sub-project implementation
in userspace, as an accelerated container image service
https://github.com/containerd/accelerated-container-image

It could be much more efficient when do decompressing and mapping works
in the kernel with the framework of device-mapper, in many circumstances,
such as secure container runtime, mobile-devices, etc.

This patch contains a module, dm-overlaybd, provides two kinds of targets
dm-zfile and dm-lsmt, to expose a group of block-devices contains
OverlayBD image as a overlaid read-only block-device.

Signed-off-by: Du Rui <durui@linux.alibaba.com>
Signed-off-by: Yuan Yifan <yuanyifan@linux.alibaba.com>
Signed-off-by: Liu Lanzheng <liulz@linux.alibaba.com>
---

v2 Changed:
- Fix some bugs.

 .../device-mapper/dm-overlaybd.rst            |  71 +++
 drivers/md/Kconfig                            |   2 +
 drivers/md/Makefile                           |   1 +
 drivers/md/overlaybd/Kconfig                  |  37 ++
 drivers/md/overlaybd/Makefile                 |   4 +
 drivers/md/overlaybd/dm-lsmt.c                | 162 +++++
 drivers/md/overlaybd/dm-lsmtformat.c          | 574 ++++++++++++++++++
 drivers/md/overlaybd/dm-ovbd-blkfile.c        | 134 ++++
 drivers/md/overlaybd/dm-ovbd.c                |  45 ++
 drivers/md/overlaybd/dm-ovbd.h                |  45 ++
 drivers/md/overlaybd/dm-zfile.c               | 154 +++++
 drivers/md/overlaybd/dm-zfileformat.c         | 441 ++++++++++++++
 drivers/md/overlaybd/ovbd.tgz                 | Bin 0 -> 10853 bytes
 13 files changed, 1670 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-overlaybd.rst
 create mode 100644 drivers/md/overlaybd/Kconfig
 create mode 100644 drivers/md/overlaybd/Makefile
 create mode 100644 drivers/md/overlaybd/dm-lsmt.c
 create mode 100644 drivers/md/overlaybd/dm-lsmtformat.c
 create mode 100644 drivers/md/overlaybd/dm-ovbd-blkfile.c
 create mode 100644 drivers/md/overlaybd/dm-ovbd.c
 create mode 100644 drivers/md/overlaybd/dm-ovbd.h
 create mode 100644 drivers/md/overlaybd/dm-zfile.c
 create mode 100644 drivers/md/overlaybd/dm-zfileformat.c
 create mode 100644 drivers/md/overlaybd/ovbd.tgz

diff --git a/Documentation/admin-guide/device-mapper/dm-overlaybd.rst b/Documentation/admin-guide/device-mapper/dm-overlaybd.rst
new file mode 100644
index 000000000000..ad48cc7b57c7
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/dm-overlaybd.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+dm-overlaybd
+============
+
+The device-mapper OverlayBD (dm-overlaybd) module allows merge block-devices
+contains OverlayBD format layers, into read-only OverlayBD block device.
+
+The OverlayBD is a block-device based container images system, based on
+random-readable compressed format ZFile, and multi-layer overlay block-device
+format LSMTFile.
+
+The following targets are provided by dm-overlaybd
+--------------------------------------------------
+
+- dm-zfile
+- dm-lsmt
+
+
+dm-zfile Table parameters
+-------------------------
+  <dev path> <ZFile size>
+
+Parameters:
+
+    <dev path>:
+        Full pathname to the underlying block-device,
+    <ZFile size>:
+        ZFile data length, in unit of byte.
+
+Examples:
+
+ZFile format data laying on /dev/vda, the ZFile length is 658971539,
+the table should be like:
+
+zfile_decompressed /dev/vdb 658971539
+
+
+dm-lsmt Table parameters
+------------------------
+  <baselayer dev path> <baselayer LSMTFile size>
+  [<upperlayer dev path> <upperlayer LSMTFile size>]
+
+Mandatory parameters:
+
+    <baselayer dev path>:
+        Full pathname to the underlying block-device, usually is a mapped
+        ZFile device.
+    <baselayer LSMTFile size>:
+        ZFile data length, in unit of byte.
+
+
+Optional parameter:
+
+    <upperlayer dev path> <upperlayer LSMTFile size>:
+        Multi-layer LSMTFile could overlay as stack, just like container
+        images.
+        The upper layers also described in table as optional parameters.
+        Each layer should tell the Full pathname of underlying block-device,
+        and a file size described LSMTFile data length in unit of byte.
+
+
+Examples:
+
+The base layer is mapped by dm-zfile in /dev/mapper/lsmt_base, and one upper
+layer is /dev/mapper/lsmt_upper that described changes from base layer.
+Assume that base layer LSMTFile length is 1,006,923,776 bytes, and upper layer is
+682,206,208 bytes.
+
+merged /dev/mapper/lsmt_base 1006923776 /dev/mapper/lsmt_upper 1006923776
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index b0a22e99bade..4ae4fb628712 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -656,4 +656,6 @@ config DM_AUDIT
 	  Enables audit logging of several security relevant events in the
 	  particular device-mapper targets, especially the integrity target.
 
+source "drivers/md/overlaybd/Kconfig"
+
 endif # MD
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 84291e38dca8..01b6da500a6a 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
 obj-$(CONFIG_SECURITY_LOADPIN_VERITY)	+= dm-verity-loadpin.o
+obj-$(CONFIG_DM_OVERLAYBD)	+= overlaybd/
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
diff --git a/drivers/md/overlaybd/Kconfig b/drivers/md/overlaybd/Kconfig
new file mode 100644
index 000000000000..a602e2a2f0c7
--- /dev/null
+++ b/drivers/md/overlaybd/Kconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DM_OVERLAYBD
+	tristate "OverlayBD device mapper target"
+	select LZ4_DECOMPRESS
+	select DM_BUFIO
+	default m
+	help
+  	  Allows OverlayBD images like compressed block device loaded by
+	  device-mapper. This module will provides two targets called dm-zfile
+	  for decompressing, and dm-lsmt for block-device overlay.
+	  The OverlayBD images is now one of ContainerD on-demand image solution.
+
+if DM_OVERLAYBD
+
+	config ZFILE_READAHEAD
+		bool "OverlayBD ZFile readahead support"
+		depends on DM_OVERLAYBD
+		default y
+		help
+		  ZFile fetching compressed data with readahead feature.
+		  It will perform read-ahaead prefetching when reading compressed data.
+		  This option may improve performance reading, but will consume more
+		  memory usage, and may read data that may not be used at all.
+
+	config ZFILE_CLEANUP_CACHE
+		bool "OverlayBD ZFile compressed data cache cleanup support"
+		depends on DM_OVERLAYBD
+		default y
+		help
+		  Clean up compress data cache if block is already decompressed.
+		  If set, drop the buffer when rear end of compreessed page was read.
+		  Because VFS keeps pagecache for decompressed data, the compressed
+		  pages usually be read only once in short term. This option usually
+		  improves cache performance.
+
+endif #DM_OVERLAYBD
diff --git a/drivers/md/overlaybd/Makefile b/drivers/md/overlaybd/Makefile
new file mode 100644
index 000000000000..9967e03e6400
--- /dev/null
+++ b/drivers/md/overlaybd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DM_OVERLAYBD)	+= dm-overlaybd.o
+dm-overlaybd-y := dm-ovbd-blkfile.o dm-lsmtformat.o dm-zfileformat.o dm-lsmt.o dm-zfile.o dm-ovbd.o
\ No newline at end of file
diff --git a/drivers/md/overlaybd/dm-lsmt.c b/drivers/md/overlaybd/dm-lsmt.c
new file mode 100644
index 000000000000..c183cd471c15
--- /dev/null
+++ b/drivers/md/overlaybd/dm-lsmt.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "dm-ovbd.h"
+
+struct lsmt_dm_target {
+	struct dm_dev *dev[256];
+	struct vfile *lsmt;
+	struct vfile *bf[256];
+	unsigned int nr;
+};
+
+static int lsmt_target_map(struct dm_target *ti, struct bio *bio)
+{
+	struct lsmt_dm_target *mdt = (struct lsmt_dm_target *)ti->private;
+
+	if (!mdt) {
+		pr_err("LSMT DM Target not ready!!\n");
+		return DM_MAPIO_REQUEUE;
+	}
+
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+		return mdt->lsmt->ops->bio_remap((struct vfile *)mdt->lsmt, bio,
+						 mdt->dev, mdt->nr);
+	default:
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+}
+
+static int lsmt_target_end_io(struct dm_target *ti, struct bio *bio,
+			      blk_status_t *error)
+{
+	if (bio->bi_status != BLK_STS_OK) {
+		pr_err("DONE NOT OK %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_ENDIO_REQUEUE;
+	}
+	return DM_ENDIO_DONE;
+}
+
+static int lsmt_target_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct lsmt_dm_target *mdt;
+	const char *devname;
+	const char *tail;
+	struct dm_arg_set args = { .argc = argc, .argv = argv };
+	size_t len;
+	int ret;
+	int i;
+
+	pr_debug("\n >>in function %s\n", __func__);
+
+	if (argc < 2) {
+		pr_warn("\n Invalid no.of arguments.\n");
+		ti->error = "Invalid argument count";
+		return -EINVAL;
+	}
+
+	mdt = kmalloc(sizeof(*mdt), GFP_KERNEL);
+
+	if (!mdt) {
+		ti->error = "dm-lsmt_target: Cannot allocate context";
+		return -ENOMEM;
+	}
+
+	for (i = 0; args.argc >= 2; i++) {
+		devname = dm_shift_arg(&args);
+		tail = dm_shift_arg(&args);
+		ret = kstrtoul(tail, 10, &len);
+		if (ret < 0) {
+			pr_warn("Invalid parameter");
+			goto error_out;
+		}
+		pr_info("\nlsmt-md: load dev %s\n", devname);
+		if (dm_get_device(ti, devname, dm_table_get_mode(ti->table),
+				  &mdt->dev[i])) {
+			ti->error = "dm-lsmt_target: Device lookup failed";
+			goto bad;
+		}
+
+		if (!mdt->dev[i] || !mdt->dev[i]->bdev) {
+			pr_warn("failed to get mdt dev or bdev\n");
+			goto error_out;
+		}
+		mdt->bf[i] = open_blkdev_as_vfile(mdt->dev[i]->bdev, len);
+		pr_info("lsmt: file %d size %lu", i,
+			mdt->bf[i]->ops->len(mdt->bf[i]));
+	}
+	mdt->nr = i;
+
+	mdt->lsmt = lsmt_open_files(mdt->bf, 1);
+
+	if (!mdt->lsmt) {
+		pr_crit("Failed to open lsmt file");
+		goto error_out;
+	}
+
+	pr_info("dm-lsmt: blk size is %lu\n",
+		mdt->lsmt->ops->len((struct vfile *)mdt->lsmt));
+
+	ti->private = mdt;
+
+	pr_debug("\n>>out function %s\n", __func__);
+	return 0;
+
+error_out:
+	for (i = 0; i < mdt->nr; i++) {
+		if (mdt->bf[i])
+			mdt->bf[i]->ops->close((struct vfile *)mdt->bf[i]);
+	}
+
+	for (i = 0; i < mdt->nr; i++) {
+		if (mdt->dev[i])
+			dm_put_device(ti, mdt->dev[i]);
+	}
+bad:
+	kfree(mdt);
+	pr_debug("\n>>out function %s with error\n", __func__);
+	return -EINVAL;
+}
+
+static void lsmt_target_dtr(struct dm_target *ti)
+{
+	struct lsmt_dm_target *mdt = (struct lsmt_dm_target *)ti->private;
+	unsigned int i = 0;
+
+	pr_debug("\n<<in function %s\n", __func__);
+	if (mdt->lsmt)
+		mdt->lsmt->ops->close((struct vfile *)mdt->lsmt);
+	for (i = 0; i < mdt->nr; i++)
+		dm_put_device(ti, mdt->dev[i]);
+	kfree(mdt);
+	pr_debug("\n>>out function %s\n", __func__);
+}
+
+static struct target_type lsmt_target = {
+	.features = 0,
+	.name = "lsmt_target",
+	.version = { 1, 0, 0 },
+	.module = THIS_MODULE,
+	.ctr = lsmt_target_ctr,
+	.dtr = lsmt_target_dtr,
+	.map = lsmt_target_map,
+	.end_io = lsmt_target_end_io,
+};
+
+int init_lsmt_target(void)
+{
+	int result;
+
+	result = dm_register_target(&lsmt_target);
+	if (result < 0)
+		pr_warn("\n Error in registering target\n");
+	return 0;
+}
+
+void cleanup_lsmt_target(void)
+{
+	dm_unregister_target(&lsmt_target);
+}
diff --git a/drivers/md/overlaybd/dm-lsmtformat.c b/drivers/md/overlaybd/dm-lsmtformat.c
new file mode 100644
index 000000000000..be881f000ab8
--- /dev/null
+++ b/drivers/md/overlaybd/dm-lsmtformat.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "dm-ovbd.h"
+#include <linux/vmalloc.h>
+
+#define REVERSE_ARRAY(type, begin, back) \
+	{                                \
+		type *l = (begin);       \
+		type *r = (back);        \
+		while (l < r) {          \
+			type tmp = *l;   \
+			*l = *r;         \
+			*r = tmp;        \
+			l++;             \
+			r--;             \
+		}                        \
+	}
+
+#define UINT64_MAX 0xFFFFFFFFFFFFFFFFULL
+#define ALIGNMENT 512U
+
+#define TYPE_SEGMENT 0
+#define TYPE_SEGMENT_MAPPING 1
+#define TYPE_FILDES 2
+#define TYPE_LSMT_RO_INDEX 3
+
+#define OVBD_MAX_LAYERS 256
+
+static const u64 INVALID_OFFSET = ((u64)1 << 50) - 1;
+static const u32 HT_SPACE = 4096;
+static u64 *MAGIC0 = (u64 *)"LSMT\0\1\2";
+static const uuid_t MAGIC1 = UUID_INIT(0x657e63d2, 0x9444, 0x084c, 0xa2, 0xd2,
+				       0xc8, 0xec, 0x4f, 0xcf, 0xae, 0x8a);
+
+struct lsmt_ht {
+	u64 magic0;
+	uuid_t magic1;
+	// offset 24, 28
+	u32 size; //= sizeof(HeaderTrailer);
+	u32 flags; //= 0;
+	// offset 32, 40, 48
+	u64 index_offset; // in bytes
+	u64 index_size; // # of SegmentMappings
+	u64 virtual_size; // in bytes
+} __packed;
+
+struct segment {
+	u64 offset : 50;
+	u32 length : 14;
+};
+
+struct segment_mapping { /* 8 + 8 bytes */
+	u64 offset : 50; // offset (0.5 PB if in sector)
+	u32 length : 14;
+	u64 moffset : 55; // mapped offset (2^64 B if in sector)
+	u32 zeroed : 1; // indicating a zero-filled segment
+	u8 tag;
+} __packed;
+
+struct lsmt_ro_index {
+	const struct segment_mapping *pbegin;
+	const struct segment_mapping *pend;
+	struct segment_mapping *mapping;
+};
+
+struct lsmt_ro_file {
+	struct vfile_operations *ops;
+	bool ownership;
+	int nr;
+	struct lsmt_ht ht;
+	struct lsmt_ro_index *index;
+	struct bio_set split_set;
+	struct vfile *fp[0];
+};
+
+static size_t lsmt_len(struct vfile *fp);
+static void lsmt_close(struct vfile *ctx);
+static int lsmt_bioremap(struct vfile *ctx, struct bio *bio,
+			 struct dm_dev **dev, unsigned int nr);
+
+static struct vfile_operations lsmt_ops = { .len = lsmt_len,
+					    .blkdev = NULL,
+					    .pread = NULL,
+					    .close = lsmt_close,
+					    .bio_remap = lsmt_bioremap };
+
+static u64 segment_end(const void *s)
+{
+	return ((struct segment *)s)->offset + ((struct segment *)s)->length;
+}
+
+static void forward_offset_to(void *m, u64 x, int8_t type)
+{
+	struct segment *s = (struct segment *)m;
+	u64 delta = x - s->offset;
+
+	s->offset = x;
+	s->length -= delta;
+	if (type == TYPE_SEGMENT_MAPPING) {
+		struct segment_mapping *tmp = (struct segment_mapping *)m;
+
+		if (!tmp->zeroed)
+			tmp->moffset += delta;
+	}
+}
+
+static void backward_end_to(void *m, u64 x)
+{
+	struct segment *s = (struct segment *)m;
+
+	s->length = x - s->offset;
+}
+
+static void trim_edge(void *m, const struct segment *bound_segment, u8 type)
+{
+	if (((struct segment *)m)->offset < bound_segment->offset)
+		forward_offset_to(m, bound_segment->offset, type);
+	if (segment_end(m) > segment_end(bound_segment))
+		backward_end_to(m, segment_end(bound_segment));
+}
+
+static const struct segment_mapping *
+ro_index_lower_bound(const struct lsmt_ro_index *index, u64 offset)
+{
+	const struct segment_mapping *l = index->pbegin;
+	const struct segment_mapping *r = index->pend - 1;
+	const struct segment_mapping *pret;
+	int ret = -1;
+
+	while (l <= r) {
+		int m = ((l - index->pbegin) + (r - index->pbegin)) >> 1;
+		const struct segment_mapping *cmp = index->pbegin + m;
+
+		if (offset >= segment_end(cmp)) {
+			ret = m;
+			l = index->pbegin + (m + 1);
+		} else {
+			r = index->pbegin + (m - 1);
+		}
+	}
+	pret = index->pbegin + (ret + 1);
+	if (pret >= index->pend)
+		return index->pend;
+	else
+		return pret;
+}
+
+static int ro_index_lookup(const struct lsmt_ro_index *index,
+			   const struct segment *query_segment,
+			   struct segment_mapping *ret_mappings, size_t n)
+{
+	const struct segment_mapping *lb;
+	const struct segment_mapping *it;
+	int cnt;
+
+	if (query_segment->length == 0)
+		return 0;
+	lb = ro_index_lower_bound(index, query_segment->offset);
+	cnt = 0;
+	for (it = lb; it != index->pend; it++) {
+		if (it->offset >= segment_end(query_segment))
+			break;
+		ret_mappings[cnt++] = *it;
+		if (cnt == n)
+			break;
+	}
+	if (cnt == 0)
+		return 0;
+	trim_edge(&ret_mappings[0], query_segment, TYPE_SEGMENT_MAPPING);
+	if (cnt > 1) {
+		trim_edge(&ret_mappings[cnt - 1], query_segment,
+			  TYPE_SEGMENT_MAPPING);
+	}
+	return cnt;
+}
+
+static size_t ro_index_size(const struct lsmt_ro_index *index)
+{
+	return index->pend - index->pbegin;
+}
+
+static struct lsmt_ro_index *
+create_memory_index(const struct segment_mapping *pmappings, size_t n,
+		    u64 moffset_begin, u64 moffset_end)
+{
+	struct lsmt_ro_index *ret = NULL;
+
+	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	ret->pbegin = pmappings;
+	ret->pend = pmappings + n;
+	ret->mapping = (struct segment_mapping *)pmappings;
+	pr_info("create memory index done. {index_count: %zu}", n);
+	return ret;
+};
+
+static int lsmt_bioremap(struct vfile *ctx, struct bio *bio,
+			 struct dm_dev **dev, unsigned int nr)
+{
+	struct lsmt_ro_file *fp = (struct lsmt_ro_file *)ctx;
+	struct segment s;
+	struct segment_mapping m[16];
+	struct bio *subbio;
+	size_t i = 0;
+	int n;
+	loff_t offset = bio->bi_iter.bi_sector;
+
+	if (bio_op(bio) != REQ_OP_READ) {
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+
+	if ((offset << SECTOR_SHIFT) > fp->ht.virtual_size) {
+		pr_info("LSMT: %lld over tail %lld\n", offset,
+			fp->ht.virtual_size);
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+
+	// till here, take this bio, assume it will be submitted
+
+	// actually, split bio by segment, summit and call endio when all split bio
+	// are done
+
+	bio->bi_status = BLK_STS_OK;
+	while (true) {
+		s.offset = bio->bi_iter.bi_sector;
+		s.length = bio_sectors(bio);
+		n = ro_index_lookup(fp->index, &s, m, 16);
+		for (i = 0; i < n; ++i) {
+			s.offset = bio->bi_iter.bi_sector;
+			s.length = bio_sectors(bio);
+			if (s.offset < m[i].offset) {
+				// hole
+				if (m[i].offset - s.offset < s.length) {
+					subbio = bio_split(bio,
+							   m[i].offset - s.offset,
+							   GFP_NOIO, &fp->split_set);
+					bio_chain(subbio, bio);
+					zero_fill_bio(subbio);
+					bio_endio(subbio);
+				} else {
+					zero_fill_bio(bio);
+					bio_endio(bio);
+					return DM_MAPIO_SUBMITTED;
+				}
+			}
+			s.offset = bio->bi_iter.bi_sector;
+			s.length = bio_sectors(bio);
+			// zeroe block
+			if (m[i].zeroed) {
+				if (m[i].length < s.length) {
+					subbio = bio_split(bio, m[i].length,
+							   GFP_NOIO,
+							   &fp->split_set);
+					bio_chain(subbio, bio);
+					zero_fill_bio(subbio);
+					bio_endio(subbio);
+				} else {
+					zero_fill_bio(bio);
+					bio_endio(bio);
+					return DM_MAPIO_SUBMITTED;
+				}
+			} else {
+				bio_set_dev(bio, dev[m[i].tag]->bdev);
+				if (m[i].length < s.length) {
+					subbio = bio_split(bio, m[i].length,
+							   GFP_NOIO,
+							   &fp->split_set);
+					subbio->bi_iter.bi_sector =
+						m[i].moffset;
+					bio_chain(subbio, bio);
+					submit_bio(subbio);
+				} else {
+					bio->bi_iter.bi_sector = m[i].moffset;
+					submit_bio(bio);
+					return DM_MAPIO_SUBMITTED;
+				}
+			}
+		}
+		if (n < 16)
+			break;
+	}
+	if (s.length > 0)
+		zero_fill_bio(bio);
+	bio_endio(bio);
+	return DM_MAPIO_SUBMITTED;
+}
+
+static size_t lsmt_len(struct vfile *fp)
+{
+	return ((struct lsmt_ro_file *)fp)->ht.virtual_size;
+}
+
+static bool is_lsmtfile(struct vfile *fp)
+{
+	struct lsmt_ht ht;
+	ssize_t ret;
+
+	if (!fp)
+		return false;
+
+	pr_info("LSMT: read header(vfile: %p)", fp);
+	ret = fp->ops->pread(fp, &ht, sizeof(struct lsmt_ht), 0);
+
+	if (ret < (ssize_t)sizeof(struct lsmt_ht)) {
+		pr_err("failed to load header");
+		return NULL;
+	}
+
+	return ht.magic0 == *MAGIC0 && uuid_equal(&ht.magic1, &MAGIC1);
+}
+
+static void lsmt_close(struct vfile *ctx)
+{
+	struct lsmt_ro_file *lsmt_file = (struct lsmt_ro_file *)ctx;
+
+	if (lsmt_file->ownership)
+		for (int i = 0; i < lsmt_file->nr; i++)
+			lsmt_file->fp[i]->ops->close(lsmt_file->fp[i]);
+	vfree(lsmt_file->index->mapping);
+	kfree(lsmt_file->index);
+	bioset_exit(&lsmt_file->split_set);
+	kfree(lsmt_file);
+}
+
+static void *lsmt_alloc_copy(void *ptr, size_t bs, size_t *from_size,
+			     size_t to_size)
+{
+	void *ret = vmalloc(to_size * bs);
+
+	if (IS_ERR_OR_NULL(ret))
+		return ret;
+	memcpy(ret, ptr, *from_size * bs);
+	*from_size = to_size;
+	vfree(ptr);
+	return ret;
+}
+
+static int merge_indexes(int level, struct lsmt_ro_index **indexes, size_t n,
+			 struct segment_mapping **mappings, size_t *size,
+			 size_t *capacity, u64 start, u64 end)
+{
+	struct segment_mapping *p;
+	struct segment_mapping it;
+	const struct segment_mapping *pend;
+
+	if (level >= n)
+		return 0;
+	p = (struct segment_mapping *)ro_index_lower_bound(indexes[level],
+							   start);
+	pend = indexes[level]->pend;
+	if (p == pend) {
+		pr_debug("index=%p p=%p pend=%p", indexes[level], p, pend);
+		merge_indexes(level + 1, indexes, n, mappings, size, capacity,
+			      start, end);
+		return 0;
+	}
+	it = *p;
+	if (start > it.offset)
+		forward_offset_to(&it, start, TYPE_SEGMENT_MAPPING);
+	while (p != pend) {
+		if (end <= it.offset)
+			break;
+		if (start < it.offset)
+			merge_indexes(level + 1, indexes, n, mappings, size,
+				      capacity, start, it.offset);
+		if (end < segment_end(&it))
+			backward_end_to(&it, end);
+		if (*size == *capacity) {
+			*mappings = lsmt_alloc_copy(*mappings, sizeof(mappings),
+						    capacity, (*capacity) << 1);
+			if (*size == *capacity) {
+				pr_err("realloc failed.");
+				return -1;
+			}
+		}
+		it.tag = level;
+		(*mappings)[*size] = it;
+		(*size)++;
+		start = segment_end(p);
+		pr_debug("push segment %zd {offset: %lu, len: %u}", *size,
+			 it.offset + 0UL, it.length);
+		p++;
+		it = *p;
+	}
+	if (start < end)
+		merge_indexes(level + 1, indexes, n, mappings, size, capacity,
+			      start, end);
+	return 0;
+}
+
+static struct lsmt_ro_index *
+merge_memory_indexes(struct lsmt_ro_index **indexes, size_t n)
+{
+	size_t size = 0;
+	size_t capacity = ro_index_size(indexes[0]);
+	struct lsmt_ro_index *ret = NULL;
+	struct segment_mapping *mappings;
+
+	mappings = vmalloc(sizeof(*mappings) * capacity);
+
+	pr_debug("init capacity: %zu\n", capacity);
+	if (IS_ERR_OR_NULL(mappings)) {
+		pr_err("Failed to alloc mapping memory\n");
+		goto err_ret;
+	}
+	pr_debug("start merge indexes, layers: %zu", n);
+
+	merge_indexes(0, indexes, n, &mappings, &size, &capacity, 0,
+		      UINT64_MAX);
+	pr_info("merge done, index size: %zu", size);
+	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
+	mappings = lsmt_alloc_copy(mappings, sizeof(struct segment_mapping),
+				   &size, size);
+	ret->pbegin = mappings;
+	ret->pend = mappings + size;
+	ret->mapping = mappings;
+	pr_info("ret index done. size: %zu", size);
+	return ret;
+
+err_ret:
+	if (mappings)
+		vfree(mappings);
+	kfree(ret);
+	return NULL;
+}
+
+static ssize_t do_load_index(struct vfile *fp, struct segment_mapping *p,
+			     struct lsmt_ht *ht)
+{
+	ssize_t index_bytes = ht->index_size * sizeof(struct segment_mapping);
+	ssize_t readn;
+	size_t valid = 0;
+
+	pr_info("LSMT: loadindex off: %llu cnt: %llu", ht->index_offset,
+		ht->index_size);
+	readn = fp->ops->pread(fp, p, index_bytes, ht->index_offset);
+	if (readn < index_bytes) {
+		pr_err("failed to read index");
+		return -1;
+	}
+	for (off_t idx = 0; idx < ht->index_size; idx++) {
+		if (p[idx].offset != INVALID_OFFSET) {
+			p[valid] = p[idx];
+			p[valid].tag = 0;
+			pr_debug("valid index %zu {offset: %lu, length: %u}",
+				 valid, p[idx].offset + 0UL, p[idx].length);
+			valid++;
+		}
+	}
+	pr_info("valid index count: %zu", valid);
+	ht->index_size = valid;
+	return valid;
+}
+
+static ssize_t lsmt_load_ht(struct vfile *fp, struct lsmt_ht *ht)
+{
+	ssize_t file_size;
+	loff_t tailer_offset;
+	ssize_t ret;
+
+	if (!is_lsmtfile(fp)) {
+		pr_info("LSMT: fp is not a lsmtfile(%p)\n", fp);
+		return -1;
+	}
+	file_size = fp->ops->len(fp);
+	pr_info("LSMT: file len is %zd\n", file_size);
+	tailer_offset = file_size - HT_SPACE;
+	ret = fp->ops->pread(fp, ht, sizeof(struct lsmt_ht), tailer_offset);
+	if (ret < (ssize_t)sizeof(struct lsmt_ht)) {
+		pr_err("failed to load tailer(%p)\n", fp);
+		return -1;
+	}
+	pr_info("LSMT(%p), index_offset %llu: index_count: %llu", fp,
+		ht->index_offset, ht->index_size);
+
+	return 0;
+}
+
+static struct lsmt_ro_index *load_merge_index(struct vfile *files[], size_t n,
+					      struct lsmt_ht *ht)
+{
+	struct lsmt_ro_index **indexes;
+	struct lsmt_ro_index *pmi = NULL;
+	struct segment_mapping *p;
+	struct lsmt_ro_index *pi;
+	size_t index_bytes;
+
+	indexes = kzalloc(sizeof(**indexes) * OVBD_MAX_LAYERS, GFP_KERNEL);
+	if (n > OVBD_MAX_LAYERS) {
+		pr_err("too many indexes to merge, %d at most!",
+		       OVBD_MAX_LAYERS);
+		goto error_ret;
+	}
+	for (int i = 0; i < n; ++i) {
+		pr_info("read %d-th LSMT info", i);
+		lsmt_load_ht(files[i], ht);
+		index_bytes = ht->index_size * sizeof(struct segment_mapping);
+		if (index_bytes == 0 || index_bytes > 1024UL * 1024 * 1024)
+			goto error_ret;
+		p = vmalloc(index_bytes);
+		if (do_load_index(files[i], p, ht) == -1) {
+			vfree(p);
+			pr_err("failed to load index from %d-th file", i);
+			goto error_ret;
+		}
+		pi = create_memory_index(p, ht->index_size,
+					 HT_SPACE / ALIGNMENT,
+					 ht->index_offset / ALIGNMENT);
+		if (!pi) {
+			pr_err("failed to create memory index! ( %d-th file )",
+			       i);
+			vfree(p);
+			goto error_ret;
+		}
+		indexes[i] = pi;
+	}
+
+	pr_info("reverse index.");
+	REVERSE_ARRAY(struct vfile *, &files[0], &files[n - 1]);
+	REVERSE_ARRAY(struct lsmt_ro_index *, &indexes[0], &indexes[n - 1]);
+
+	pmi = merge_memory_indexes(indexes, n);
+
+	if (!pmi) {
+		pr_err("failed to merge indexes");
+		goto error_ret;
+	}
+	pr_debug("merge index done.");
+	kfree(indexes);
+	return pmi;
+
+error_ret:
+	kfree(indexes);
+	return NULL;
+}
+
+struct vfile *lsmt_open_files(struct vfile *zfiles[], int n)
+{
+	struct lsmt_ro_file *ret;
+	struct lsmt_ht ht;
+	struct lsmt_ro_index *idx;
+
+	pr_info("LSMT open_files, layers: %d", n);
+	ret = kzalloc(sizeof(struct vfile *) * n + sizeof(struct lsmt_ro_file),
+		      GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	idx = load_merge_index(zfiles, n, &ht);
+	if (!idx) {
+		pr_err("load merge index failed.");
+		goto error_out;
+	}
+	pr_info("Initial bio set");
+	if (bioset_init(&ret->split_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS)) {
+		pr_err("Initial bio set failed");
+		goto error_out;
+	}
+	ret->nr = n;
+	ret->index = idx;
+	ret->ownership = false;
+	ret->ops = &lsmt_ops;
+	ret->ht.virtual_size = ht.virtual_size;
+	pr_debug("ret->fp[0]: %p", &ret->fp[0]);
+	memcpy(&ret->fp[0], &zfiles[0], n * sizeof(struct vfile *));
+	return (struct vfile *)ret;
+error_out:
+	kfree(ret);
+	return NULL;
+}
diff --git a/drivers/md/overlaybd/dm-ovbd-blkfile.c b/drivers/md/overlaybd/dm-ovbd-blkfile.c
new file mode 100644
index 000000000000..19a75ce40033
--- /dev/null
+++ b/drivers/md/overlaybd/dm-ovbd-blkfile.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "dm-ovbd.h"
+#include <linux/dm-bufio.h>
+
+struct blkdev_as_vfile {
+	struct vfile_operations *ops;
+	struct block_device *blkdev;
+	loff_t len;
+	struct dm_bufio_client *c;
+};
+
+static struct block_device *blkdev_getblkdev(struct vfile *f)
+{
+	return ((struct blkdev_as_vfile *)f)->blkdev;
+}
+
+// special helper
+// access blockdev data by sync
+// copy to buffer
+static ssize_t sync_read_blkdev(struct blkdev_as_vfile *f, void *buf,
+				size_t count, loff_t offset)
+{
+	void *mem = NULL;
+	loff_t left = offset & PAGE_MASK;
+	loff_t right = (offset + count + PAGE_SIZE - 1) & PAGE_MASK;
+	loff_t i = 0;
+	size_t sg_len = 0;
+	ssize_t ret = 0;
+	int nr_pages = 0;
+	size_t dsize = f->len;
+	struct dm_buffer *dbuf = NULL;
+
+	if (right > (dsize << SECTOR_SHIFT))
+		right = (dsize << SECTOR_SHIFT);
+
+	nr_pages = (right - left + PAGE_SIZE - 1) / PAGE_SIZE;
+	dm_bufio_prefetch(f->c, left >> PAGE_SHIFT, nr_pages);
+
+	for (i = 0; i < nr_pages; i++) {
+		if (left > offset + count)
+			break;
+		sg_len = PAGE_SIZE;
+		if (left + sg_len > offset + count)
+			sg_len = offset + count - left;
+		if (offset > left)
+			sg_len = sg_len - (offset - left);
+		mem = dm_bufio_read(f->c, left >> PAGE_SHIFT, &dbuf);
+		if (IS_ERR(dbuf))
+			goto out;
+		memcpy(buf, mem + (offset - left), sg_len);
+		dm_bufio_release(dbuf);
+		buf += sg_len;
+		offset += sg_len;
+		left += PAGE_SIZE;
+		ret += sg_len;
+		count -= sg_len;
+	}
+out:
+	return ret;
+}
+
+static size_t blkdev_len(struct vfile *ctx)
+{
+	struct blkdev_as_vfile *bf = (struct blkdev_as_vfile *)ctx;
+
+	pr_debug("%s %lld\n", __func__, bf->len);
+	return bf->len;
+}
+
+static ssize_t blkdev_pread(struct vfile *ctx, void *buf, size_t count,
+			    loff_t offset)
+{
+	struct blkdev_as_vfile *bf;
+	size_t ret, tr, split_count;
+
+	bf = (struct blkdev_as_vfile *)ctx;
+	ret = 0;
+	while (count) {
+		split_count = min((size_t)(PAGE_SIZE << 2), count);
+		tr = sync_read_blkdev(bf, buf, split_count, offset);
+		if (tr < 0)
+			return tr;
+		if (tr == 0)
+			return ret;
+		ret += tr;
+		buf += tr;
+		offset += tr;
+		count -= tr;
+	}
+	return ret;
+}
+
+static void blkdev_close(struct vfile *ctx)
+{
+	struct blkdev_as_vfile *bf;
+
+	bf = (struct blkdev_as_vfile *)ctx;
+	if (ctx) {
+		dm_bufio_client_destroy(bf->c);
+		kfree(ctx);
+	}
+}
+
+static struct vfile_operations blkdev_op = {
+	.blkdev = blkdev_getblkdev,
+	.len = blkdev_len,
+	.pread = blkdev_pread,
+	.bio_remap = NULL,
+	.close = blkdev_close,
+};
+
+struct vfile *open_blkdev_as_vfile(struct block_device *blk, loff_t len)
+{
+	struct blkdev_as_vfile *ret;
+
+	if (IS_ERR(blk))
+		return NULL;
+	ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	ret->ops = &blkdev_op;
+	ret->blkdev = blk;
+	ret->c = dm_bufio_client_create(blk, 4096, 1, 0, NULL, NULL, 0);
+	if (IS_ERR(ret->c))
+		goto errout;
+	if (len == -1)
+		len = get_capacity(blk->bd_disk) << SECTOR_SHIFT;
+	ret->len = len;
+	return (struct vfile *)ret;
+errout:
+	kfree(ret);
+	return NULL;
+}
diff --git a/drivers/md/overlaybd/dm-ovbd.c b/drivers/md/overlaybd/dm-ovbd.c
new file mode 100644
index 000000000000..87aa9ec17208
--- /dev/null
+++ b/drivers/md/overlaybd/dm-ovbd.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include "dm-ovbd.h"
+
+static struct ovbd_context global_ovbd_context;
+
+static int __init init_ovbd_target(void)
+{
+	global_ovbd_context.wq =
+		alloc_workqueue("ovbd", WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND, 0);
+	if (IS_ERR(global_ovbd_context.wq))
+		return -1;
+	if (init_lsmt_target() < 0)
+		goto error_out;
+	if (init_zfile_target() < 0)
+		goto error_out;
+	pr_info("OVBD initialized");
+	return 0;
+error_out:
+	destroy_workqueue(global_ovbd_context.wq);
+	return -1;
+}
+
+static void __exit cleanup_ovbd_target(void)
+{
+	cleanup_zfile_target();
+	cleanup_lsmt_target();
+	flush_workqueue(global_ovbd_context.wq);
+	destroy_workqueue(global_ovbd_context.wq);
+	global_ovbd_context.wq = NULL;
+	pr_info("OVBD cleared");
+}
+
+struct ovbd_context *get_ovbd_context(void)
+{
+	return &global_ovbd_context;
+}
+
+module_init(init_ovbd_target);
+module_exit(cleanup_ovbd_target);
+
+MODULE_AUTHOR("Du Rui <durui@linux.alibaba.com>");
+MODULE_DESCRIPTION("DADI OverlayBD implementation as device mapper target");
+MODULE_LICENSE("GPL");
diff --git a/drivers/md/overlaybd/dm-ovbd.h b/drivers/md/overlaybd/dm-ovbd.h
new file mode 100644
index 000000000000..94f5303d7399
--- /dev/null
+++ b/drivers/md/overlaybd/dm-ovbd.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __DM_OVBD_HEADER__
+#define __DM_OVBD_HEADER__
+
+#include <linux/device-mapper.h>
+#include <linux/bio.h>
+
+struct ovbd_context {
+	struct workqueue_struct *wq;
+};
+
+struct ovbd_context *get_ovbd_context(void);
+
+int init_lsmt_target(void);
+
+void cleanup_lsmt_target(void);
+
+int init_zfile_target(void);
+
+void cleanup_zfile_target(void);
+
+struct vfile;
+
+struct vfile_operations {
+	struct block_device *(*blkdev)(struct vfile *file);
+	size_t (*len)(struct vfile *file);
+	ssize_t (*pread)(struct vfile *file, void *buffer, size_t count,
+			 loff_t offset);
+	int (*bio_remap)(struct vfile *file, struct bio *bio,
+			 struct dm_dev **devs, unsigned int nr_dev);
+	void (*close)(struct vfile *file);
+};
+
+struct vfile {
+	struct vfile_operations *ops;
+};
+
+struct vfile *open_blkdev_as_vfile(struct block_device *blk, loff_t len);
+
+struct vfile *zfile_open(struct vfile *file);
+
+struct vfile *lsmt_open_files(struct vfile *zf[], int n);
+
+#endif
diff --git a/drivers/md/overlaybd/dm-zfile.c b/drivers/md/overlaybd/dm-zfile.c
new file mode 100644
index 000000000000..f0a27014c0b7
--- /dev/null
+++ b/drivers/md/overlaybd/dm-zfile.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "dm-ovbd.h"
+
+struct zfile_dm_target {
+	struct dm_dev *dev;
+	struct vfile *zfile;
+	struct vfile *bf;
+};
+
+static int zfile_target_map(struct dm_target *ti, struct bio *bio)
+{
+	struct zfile_dm_target *mdt = (struct zfile_dm_target *)ti->private;
+
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+		return mdt->zfile->ops->bio_remap((struct vfile *)mdt->zfile,
+						  bio, &mdt->dev, 1);
+	default:
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+}
+
+static int zfile_target_end_io(struct dm_target *ti, struct bio *bio,
+			       blk_status_t *error)
+{
+	if (bio->bi_status != BLK_STS_OK) {
+		pr_err("DONE NOT OK %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_ENDIO_REQUEUE;
+	}
+	return DM_ENDIO_DONE;
+}
+
+static int zfile_target_ctr(struct dm_target *ti, unsigned int argc,
+			    char **argv)
+{
+	struct zfile_dm_target *mdt;
+	const char *devname, *tail;
+	struct dm_arg_set args = { .argc = argc, .argv = argv };
+	size_t zflen;
+	int ret;
+
+	pr_debug("\n >>in function %s\n", __func__);
+
+	if (argc < 2) {
+		pr_info("\n Invalid no.of arguments.\n");
+		ti->error = "Invalid argument count";
+		return -EINVAL;
+	}
+
+	mdt = kzalloc(sizeof(*mdt), GFP_KERNEL);
+
+	if (!mdt) {
+		ti->error = "dm-zfile_target: Cannot allocate context";
+		return -ENOMEM;
+	}
+
+	devname = dm_shift_arg(&args);
+	pr_info("\nzfile-md: load dev %s\n", devname);
+	if (dm_get_device(ti, devname, dm_table_get_mode(ti->table),
+			  &mdt->dev)) {
+		ti->error = "dm-zfile_target: Device lookup failed";
+		goto bad;
+	}
+
+	if (!mdt->dev || !mdt->dev->bdev) {
+		pr_warn("failed to get mdt dev or bdev\n");
+		goto error_out;
+	}
+
+	tail = dm_shift_arg(&args);
+	ret = kstrtoul(tail, 10, &zflen);
+	if (ret < 0) {
+		pr_warn("failed to get file length");
+		goto error_out;
+	}
+
+	mdt->bf = (struct vfile *)open_blkdev_as_vfile(mdt->dev->bdev, zflen);
+
+	if (!mdt->bf) {
+		pr_crit("Failed to open blkdev");
+		goto error_out;
+	}
+
+	mdt->zfile = zfile_open(mdt->bf);
+
+	if (!mdt->zfile) {
+		pr_crit("Failed to open zfile file");
+		goto error_out;
+	}
+
+	pr_info("zfile: size is %lu\n",
+		mdt->zfile->ops->len((struct vfile *)mdt->zfile));
+
+	ti->private = mdt;
+
+	pr_debug("\n>>out function %s\n", __func__);
+	return 0;
+
+error_out:
+	if (mdt->zfile)
+		mdt->zfile->ops->close(mdt->zfile);
+	if (mdt->bf)
+		mdt->bf->ops->close(mdt->bf);
+	if (mdt->dev)
+		dm_put_device(ti, mdt->dev);
+bad:
+	kfree(mdt);
+	pr_debug("\n>>out function %s with error\n", __func__);
+	return -EINVAL;
+}
+
+static void zfile_target_dtr(struct dm_target *ti)
+{
+	struct zfile_dm_target *mdt = (struct zfile_dm_target *)ti->private;
+
+	pr_debug("\n<<in function %s\n", __func__);
+	if (mdt->zfile)
+		mdt->zfile->ops->close((struct vfile *)mdt->zfile);
+	if (mdt->bf)
+		mdt->bf->ops->close((struct vfile *)mdt->bf);
+	dm_put_device(ti, mdt->dev);
+	kfree(mdt);
+	pr_debug("\n>>out function %s\n", __func__);
+}
+
+static struct target_type zfile_target = {
+	.features = 0,
+	.name = "zfile_target",
+	.version = { 1, 0, 0 },
+	.module = THIS_MODULE,
+	.ctr = zfile_target_ctr,
+	.dtr = zfile_target_dtr,
+	.map = zfile_target_map,
+	.end_io = zfile_target_end_io,
+};
+
+int init_zfile_target(void)
+{
+	int result;
+
+	result = dm_register_target(&zfile_target);
+	if (result < 0)
+		pr_info("\n Error in registering target\n");
+	return 0;
+}
+
+void cleanup_zfile_target(void)
+{
+	dm_unregister_target(&zfile_target);
+}
diff --git a/drivers/md/overlaybd/dm-zfileformat.c b/drivers/md/overlaybd/dm-zfileformat.c
new file mode 100644
index 000000000000..04c8153fcb0a
--- /dev/null
+++ b/drivers/md/overlaybd/dm-zfileformat.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "dm-ovbd.h"
+#include <linux/lz4.h>
+#include <linux/vmalloc.h>
+#include <linux/prefetch.h>
+#include <linux/kthread.h>
+#include <linux/uuid.h>
+#include <linux/dm-bufio.h>
+#include <linux/build_bug.h>
+
+static const u32 ZF_SPACE = 512;
+static u64 *MAGIC0 = (u64 *)"ZFile\0\1";
+static const uuid_t MAGIC1 = UUID_INIT(0x74756a69, 0x2e79, 0x7966, 0x40, 0x41,
+				       0x6c, 0x69, 0x62, 0x61, 0x62, 0x61);
+
+struct compress_options {
+	u32 block_size; // 4
+	u8 type; // 5
+	u8 level; // 6
+	u8 use_dict; // 7
+	u8 __padding0; // 8
+	u32 args; // 12
+	u32 dict_size; // 16
+	u8 verify; // 17
+	u8 __padding1[7]; //24
+} __packed;
+
+static_assert(sizeof(struct compress_options) == 24, "CO size not fit");
+
+struct zfile_ht {
+	u64 magic0; // 8
+	uuid_t magic1; // 24
+
+	// till here offset = 24
+	u32 size_ht; //= sizeof(HeaderTrailer); // 28
+	u8 __padding[4]; // 32
+	u64 flags; //= 0;                        // 40
+
+	// till here offset = 36
+	u64 index_offset; // in bytes  48
+	u64 index_size; // num of index  56
+
+	u64 vsize; // 64
+	u64 reserved_0; // 72
+
+	struct compress_options opt; // suppose to be 96
+} __packed;
+
+static_assert(sizeof(struct zfile_ht) == 96, "Header size not fit");
+
+struct jump_table {
+	u64 partial_offset : 48; // 48 bits logical offset + 16 bits partial minimum
+	uint16_t delta : 16;
+} __packed;
+
+// zfile can be treated as file with extends
+struct zfile {
+	struct vfile_operations *ops;
+	struct vfile *fp;
+	bool ownership;
+	struct block_device *blkdev;
+	struct zfile_ht header;
+	struct jump_table *jump;
+	mempool_t cmdpool;
+	struct dm_bufio_client *c;
+	struct ovbd_context *ovbd;
+};
+
+#define FLAG_SHIFT_HEADER 0
+// 1:header     0:trailer
+#define FLAG_SHIFT_TYPE 1
+// 1:data file, 0:index file
+#define FLAG_SHIFT_SEALED 2
+// 1:YES	0:NO				# skip it now.
+#define FLAG_SHIFT_HEADER_OVERWRITE 3
+
+#define PREFETCH_PAGE_NR 32
+#define CMDPOOL_SIZE 4096
+#define MAX_JUMPTABLE_SIZE (1024UL * 1024 * 1024)
+
+static size_t zfile_len(struct vfile *fp);
+static void zfile_close(struct vfile *ctx);
+static int zfile_bioremap(struct vfile *ctx, struct bio *bio, struct dm_dev **dev,
+			  unsigned int nr);
+
+static struct vfile_operations zfile_ops = { .len = zfile_len,
+					     .bio_remap = zfile_bioremap,
+					     .close = zfile_close };
+
+static u32 get_flag_bit(struct zfile_ht *ht, u32 shift)
+{
+	return ht->flags & (1 << shift);
+}
+
+static bool is_header_overwrite(struct zfile_ht *ht)
+{
+	return get_flag_bit(ht, FLAG_SHIFT_HEADER_OVERWRITE);
+}
+
+static size_t zfile_len(struct vfile *zfile)
+{
+	return ((struct zfile *)zfile)->header.vsize;
+}
+
+static void build_jump_table(u32 *jt_saved, struct zfile *zf)
+{
+	size_t i;
+
+	zf->jump = vmalloc((zf->header.index_size + 2) *
+			   sizeof(struct jump_table));
+	zf->jump[0].partial_offset = ZF_SPACE;
+	for (i = 0; i < zf->header.index_size; i++) {
+		zf->jump[i].delta = jt_saved[i];
+		zf->jump[i + 1].partial_offset =
+			zf->jump[i].partial_offset + jt_saved[i];
+	}
+}
+
+enum decompress_result {
+	ZFILE_DECOMP_ERROR = -1,
+	ZFILE_DECOMP_OK = 0,
+	ZFILE_DECOMP_NOT_READY = 1,
+};
+
+static int zf_decompress(struct zfile *zf, struct page *page, loff_t offset,
+			 bool force)
+{
+	void *dst = NULL;
+	void *src = NULL;
+	size_t idx, c_cnt;
+	loff_t begin, left, right, i;
+	int ret = 0;
+	int decomp_cnt = 0;
+	struct dm_buffer *buf = NULL;
+	void *tmp = NULL;
+
+	idx = offset >> PAGE_SHIFT;
+	begin = zf->jump[idx].partial_offset;
+	c_cnt = zf->jump[idx].delta - (zf->header.opt.verify ? sizeof(u32) : 0);
+	left = begin & PAGE_MASK;
+	right = ((begin + c_cnt) + (PAGE_SIZE - 1)) & PAGE_MASK;
+
+	if (likely(right - left == PAGE_SIZE)) {
+		if (force)
+			src = dm_bufio_read(zf->c, left >> PAGE_SHIFT, &buf);
+		else
+			src = dm_bufio_get(zf->c, left >> PAGE_SHIFT, &buf);
+		if (IS_ERR_OR_NULL(src) || IS_ERR_OR_NULL(buf)) {
+			ret = ZFILE_DECOMP_NOT_READY;
+			goto out;
+		}
+		src = src + (begin - left);
+	} else {
+		tmp = kmalloc(right - left, GFP_KERNEL);
+		for (i = left; i < right; i += PAGE_SIZE) {
+			void *d = force ? dm_bufio_read(zf->c, i >> PAGE_SHIFT,
+							&buf) :
+					  dm_bufio_get(zf->c, i >> PAGE_SHIFT,
+						       &buf);
+			if (IS_ERR_OR_NULL(d) || IS_ERR_OR_NULL(buf)) {
+				ret = ZFILE_DECOMP_NOT_READY;
+				goto out;
+			}
+			memcpy(tmp + i - left, d, PAGE_SIZE);
+			dm_bufio_release(buf);
+			buf = NULL;
+		}
+		src = tmp + (begin - left);
+	}
+
+	dst = kmap_local_page(page);
+
+	prefetchw(dst);
+
+	decomp_cnt = LZ4_decompress_fast(src, dst, PAGE_SIZE);
+
+	kunmap_local(dst);
+
+	if (decomp_cnt < 0) {
+		pr_err("Decompress error\n");
+		ret = ZFILE_DECOMP_ERROR;
+		goto out;
+	}
+
+out:
+	if (!IS_ERR_OR_NULL(buf))
+		dm_bufio_release(buf);
+	kfree(tmp);
+
+	return ret;
+}
+
+static int do_decompress(struct zfile *zf, struct bio *bio, size_t left, int nr,
+			 bool force)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+
+	bio_for_each_segment(bv, bio, iter) {
+		int ret =
+			zf_decompress(zf, bv.bv_page,
+				      (iter.bi_sector << SECTOR_SHIFT), force);
+		if (unlikely(ret != ZFILE_DECOMP_OK)) {
+			if (ret == ZFILE_DECOMP_ERROR)
+				bio_io_error(bio);
+			return ret;
+		}
+	}
+	bio_endio(bio);
+	return ZFILE_DECOMP_OK;
+}
+
+struct decompress_work {
+	struct work_struct work;
+	struct zfile *zf;
+	struct bio *bio;
+	bool force;
+};
+
+static inline void zfile_prefetch(struct zfile *zf, size_t left, size_t nr)
+{
+#ifdef ZFILE_READAHEAD
+	size_t prefetch_page = PREFETCH_PAGE_NR;
+#else
+	size_t prefetch_page = 0;
+#endif
+	dm_bufio_prefetch(zf->c, left >> PAGE_SHIFT, nr + prefetch_page);
+}
+
+static inline void zfile_cleanup_compressed_cache(struct zfile *zf, size_t left,
+						  size_t nr)
+{
+#ifdef ZFILE_CLEANUP_CACHE
+	dm_bufio_forget_buffers(zf->c, left >> PAGE_SHIFT, nr);
+#endif
+}
+
+static void decompress_fn(struct work_struct *work)
+{
+	size_t start_idx, end_idx, begin, range, left, right;
+	loff_t offset, count, nr;
+	size_t bs;
+	struct decompress_work *cmd =
+		container_of(work, struct decompress_work, work);
+
+	if (!work)
+		return;
+	offset = cmd->bio->bi_iter.bi_sector;
+	count = bio_sectors(cmd->bio);
+	bs = cmd->zf->header.opt.block_size;
+
+	start_idx = (offset << SECTOR_SHIFT) / bs;
+	end_idx = ((offset + count - 1) << SECTOR_SHIFT) / bs;
+
+	begin = cmd->zf->jump[start_idx].partial_offset;
+	range = cmd->zf->jump[end_idx].partial_offset +
+		cmd->zf->jump[end_idx].delta - begin;
+	left = begin & PAGE_MASK;
+	right = (begin + range + PAGE_SIZE - 1) & PAGE_MASK;
+	nr = (right - left) >> PAGE_SHIFT;
+
+	zfile_prefetch(cmd->zf, left, nr);
+
+	if (unlikely(do_decompress(cmd->zf, cmd->bio, left, nr, cmd->force) ==
+		     ZFILE_DECOMP_NOT_READY)) {
+		goto resubmit;
+	}
+
+	zfile_cleanup_compressed_cache(cmd->zf, left,
+				       nr - ((right > begin + range) ? 1 : 0));
+
+	mempool_free(cmd, &cmd->zf->cmdpool);
+
+	return;
+
+resubmit:
+	cmd->force = true;
+	queue_work(cmd->zf->ovbd->wq, work);
+}
+
+static int zfile_bioremap(struct vfile *ctx, struct bio *bio, struct dm_dev **dm_dev,
+			  unsigned int dev_nr)
+{
+	struct zfile *zf = (struct zfile *)ctx;
+	loff_t offset = bio->bi_iter.bi_sector;
+	size_t count = bio_sectors(bio);
+	struct decompress_work *cmd;
+
+	if (unlikely(dev_nr != 1 || !dm_dev[0])) {
+		pr_err("ZFile: nr wrong\n");
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+	if (unlikely(bio_op(bio) != REQ_OP_READ)) {
+		pr_err("ZFile: REQ not read\n");
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+	if (unlikely((offset << SECTOR_SHIFT) >= zf->header.vsize)) {
+		pr_err("ZFile: %lld over tail\n", offset);
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+	if (unlikely(((offset + count) << SECTOR_SHIFT) > zf->header.vsize)) {
+		pr_err("ZFile: %lld over tail\n", offset);
+		pr_err("DM_MAPIO_KILL %s:%d op=%d sts=%d\n", __FILE__, __LINE__,
+		       bio_op(bio), bio->bi_status);
+		return DM_MAPIO_KILL;
+	}
+
+	cmd = mempool_alloc(&zf->cmdpool, GFP_NOIO);
+	if (IS_ERR_OR_NULL(cmd))
+		return DM_MAPIO_DELAY_REQUEUE;
+
+	INIT_WORK(&cmd->work, decompress_fn);
+	cmd->bio = bio;
+	cmd->zf = zf;
+	cmd->force = false;
+
+	queue_work_on(raw_smp_processor_id(), cmd->zf->ovbd->wq, &cmd->work);
+	return DM_MAPIO_SUBMITTED;
+}
+
+static bool load_zfile_header(struct vfile *file, struct zfile_ht *ht);
+
+struct vfile *zfile_open(struct vfile *file)
+{
+	u32 *jt_saved;
+	size_t jt_size = 0;
+	struct zfile *zfile = NULL;
+	int ret = 0;
+	size_t file_size = 0;
+	loff_t tailer_offset;
+	struct block_device *bdev = file->ops->blkdev(file);
+
+	zfile = kzalloc(sizeof(*zfile), GFP_KERNEL);
+
+	if (!load_zfile_header(file, &zfile->header)) {
+		kfree(zfile);
+		return NULL;
+	}
+
+	if (!zfile)
+		goto error_out;
+	zfile->fp = file;
+
+	// should verify header
+	if (!is_header_overwrite(&zfile->header)) {
+		file_size = zfile->fp->ops->len(zfile->fp);
+		tailer_offset = file_size - ZF_SPACE;
+		pr_info("zfile: file_size=%lu tail_offset=%llu\n", file_size,
+			tailer_offset);
+		ret = zfile->fp->ops->pread(zfile->fp, &zfile->header,
+					    sizeof(struct zfile_ht),
+					    tailer_offset);
+		if (ret < (ssize_t)sizeof(struct zfile_ht)) {
+			pr_err("zfile: failed to fetch zfile tailer");
+			goto error_out;
+		}
+		pr_info("zfile: Trailer vsize=%lld index_offset=%lld index_size=%lld verify=%d",
+			zfile->header.vsize, zfile->header.index_offset,
+			zfile->header.index_size, zfile->header.opt.verify);
+	} else {
+		pr_info("zfile header overwrite: size=%lld index_offset=%lld index_size=%lld verify=%d",
+			zfile->header.vsize, zfile->header.index_offset,
+			zfile->header.index_size, zfile->header.opt.verify);
+	}
+
+	jt_size = ((u64)zfile->header.index_size) * sizeof(u32);
+	pr_info("get index_size %lu, index_offset %llu", jt_size,
+		zfile->header.index_offset);
+
+	if (jt_size == 0 || jt_size > MAX_JUMPTABLE_SIZE)
+		goto error_out;
+
+	jt_saved = vmalloc(jt_size);
+
+	ret = zfile->fp->ops->pread(zfile->fp, jt_saved, jt_size,
+				    zfile->header.index_offset);
+
+	build_jump_table(jt_saved, zfile);
+
+	vfree(jt_saved);
+
+	zfile->ops = &zfile_ops;
+
+	ret = mempool_init_kmalloc_pool(&zfile->cmdpool, CMDPOOL_SIZE,
+					sizeof(struct decompress_work));
+	if (ret)
+		goto error_out;
+
+	zfile->c = dm_bufio_client_create(bdev, PAGE_SIZE, 1, 0, NULL, NULL, 0);
+	if (IS_ERR_OR_NULL(zfile->c))
+		goto error_out;
+
+	zfile->ovbd = get_ovbd_context();
+
+	return (struct vfile *)zfile;
+
+error_out:
+	if (zfile)
+		zfile_close((struct vfile *)zfile);
+	return NULL;
+}
+
+static bool load_zfile_header(struct vfile *file, struct zfile_ht *ht)
+{
+	ssize_t ret;
+
+	if (!file)
+		return false;
+
+	ret = file->ops->pread(file, ht, sizeof(struct zfile_ht), 0);
+	if (ret < (ssize_t)sizeof(struct zfile_ht)) {
+		pr_info("zfile: failed to load header %ld", ret);
+		return false;
+	}
+	return ht->magic0 == *MAGIC0 && uuid_equal(&ht->magic1, &MAGIC1);
+}
+
+static void zfile_close(struct vfile *f)
+{
+	struct zfile *zfile = (struct zfile *)f;
+
+	pr_info("close(%p)", (void *)f);
+	if (zfile) {
+		if (zfile->jump) {
+			vfree(zfile->jump);
+			zfile->jump = NULL;
+		}
+		zfile->fp = NULL;
+		mempool_exit(&zfile->cmdpool);
+		if (!IS_ERR_OR_NULL(zfile->c))
+			dm_bufio_client_destroy(zfile->c);
+		kfree(zfile);
+	}
+}
diff --git a/drivers/md/overlaybd/ovbd.tgz b/drivers/md/overlaybd/ovbd.tgz
new file mode 100644
index 0000000000000000000000000000000000000000..07e48136629aaa4960f85438a1dc75464438c297
GIT binary patch
literal 10853
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

literal 0
HcmV?d00001

-- 
Signed-off-by: Rui Du <yuanyifan@linux.alibaba.com>
Signed-off-by: Yuan Yifan <yuanyifan@linux.alibaba.com>
Signed-off-by: Liu Lanzheng <liulz@linux.alibaba.com>

