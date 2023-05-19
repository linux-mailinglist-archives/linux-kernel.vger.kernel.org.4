Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C037094C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjESK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjESK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:28:18 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2CE7F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:28:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vj-S2.h_1684492088;
Received: from localhost(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0Vj-S2.h_1684492088)
          by smtp.aliyun-inc.com;
          Fri, 19 May 2023 18:28:09 +0800
From:   Du Rui <durui@linux.alibaba.com>
To:     dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Du Rui <durui@linux.alibaba.com>
Subject: [RFC] dm overlaybd: targets mapping OverlayBD image
Date:   Fri, 19 May 2023 18:27:22 +0800
Message-Id: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OverlayBD is a novel layering block-level image format, which is design
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
---
 .../device-mapper/dm-overlaybd.rst            |  71 +++
 drivers/md/Kconfig                            |   2 +
 drivers/md/Makefile                           |   1 +
 drivers/md/overlaybd/Kconfig                  |  37 ++
 drivers/md/overlaybd/Makefile                 |   4 +
 drivers/md/overlaybd/dm-lsmt.c                | 162 +++++
 drivers/md/overlaybd/dm-lsmtformat.c          | 575 ++++++++++++++++++
 drivers/md/overlaybd/dm-ovbd-blkfile.c        | 134 ++++
 drivers/md/overlaybd/dm-ovbd.c                |  46 ++
 drivers/md/overlaybd/dm-ovbd.h                |  45 ++
 drivers/md/overlaybd/dm-zfile.c               | 154 +++++
 drivers/md/overlaybd/dm-zfileformat.c         | 455 ++++++++++++++
 12 files changed, 1686 insertions(+)
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
index 000000000000..9c735ee62cc2
--- /dev/null
+++ b/drivers/md/overlaybd/dm-lsmtformat.c
@@ -0,0 +1,575 @@
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
+static const u64 INVALID_OFFSET = (1UL << 50) - 1;
+static const u32 HT_SPACE = 4096;
+static const u32 ALIGNMENT4K = 4 << 10;
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
+	pr_info("create memory index done. {index_count: %lu}", n);
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
+bool is_lsmtfile(struct vfile *fp)
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
+		pr_debug("push segment %ld {offset: %lu, len: %u}", *size,
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
+	pr_debug("init capacity: %lu\n", capacity);
+	if (IS_ERR_OR_NULL(mappings)) {
+		pr_err("Failed to alloc mapping memory\n");
+		goto err_ret;
+	}
+	pr_debug("start merge indexes, layers: %lu", n);
+
+	merge_indexes(0, indexes, n, &mappings, &size, &capacity, 0,
+		      UINT64_MAX);
+	pr_info("merge done, index size: %lu", size);
+	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
+	mappings = lsmt_alloc_copy(mappings, sizeof(struct segment_mapping),
+				   &size, size);
+	ret->pbegin = mappings;
+	ret->pend = mappings + size;
+	ret->mapping = mappings;
+	pr_info("ret index done. size: %lu", size);
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
+			pr_debug("valid index %lu {offset: %lu, length: %u}",
+				 valid, p[idx].offset + 0UL, p[idx].length);
+			valid++;
+		}
+	}
+	pr_info("valid index count: %ld", valid);
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
+	pr_info("LSMT: file len is %ld\n", file_size);
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
index 000000000000..37bd3b656d40
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
+		split_count = max(4 * PAGE_SIZE, count);
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
index 000000000000..22de8cb6f609
--- /dev/null
+++ b/drivers/md/overlaybd/dm-ovbd.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include "dm-ovbd.h"
+
+static struct ovbd_context global_ovbd_context;
+
+int init_ovbd_target(void)
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
+void cleanup_ovbd_target(void)
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
index 000000000000..5e102e6b046b
--- /dev/null
+++ b/drivers/md/overlaybd/dm-zfileformat.c
@@ -0,0 +1,455 @@
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
+	struct dm_buffer *buf;
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
+	size_t start_idx, end_idx, begin, range, left, right;
+	loff_t nr;
+	size_t bs;
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
-- 
2.19.1.6.gb485710b

