Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74E64841D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLIOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLIOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:49:12 -0500
X-Greylist: delayed 298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 06:49:10 PST
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789131FAA;
        Fri,  9 Dec 2022 06:49:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 28D3A7D482;
        Fri,  9 Dec 2022 17:24:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595847;
        bh=S9DrQne1XCh9YtjhIIRDivuh9VFioCiStmBWaDH4OrA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UeCFxQbhSymt9ZV/VchYVbXGbiS/eFnzl0yLDfEXBKo4r4EhAwDKnCP1yVGgPaBnt
         AsyrY1fUci2yL4rzpEUMWqROtZpyHiwWVSbNDszasqi8s8NgACvY4dBudRFjeL9DJO
         liZYOA/fezwOX1yzANbO8Yf4ztdJ73eRhMv44rxLJWDLMNGEgHNLSKxSC0KKbUVKHn
         RAvmxe/BMT393HTawD422T6BPHdqcSC7ZBnKF1QhawTq8mpF3yRWaSR2B1e/GKTnm3
         aD3MttKWVziCuDEkkPAwbKYTRO6A1AfK2zqCdXvhCQHS/rFkacAAYG96mJiDVKbTEc
         rnyNIkk5Uad1g==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:03 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 07/21] block, blksnap: init() and exit() functions
Date:   Fri, 9 Dec 2022 15:23:17 +0100
Message-ID: <20221209142331.26395-8-sergei.shtepa@veeam.com>
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

Contains callback functions for loading and unloading the module. The
module parameters and other mandatory declarations for the kernel module
are also defined.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/main.c    | 164 ++++++++++++++++++++++++++++++++
 drivers/block/blksnap/params.h  |  12 +++
 drivers/block/blksnap/version.h |  10 ++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h
 create mode 100644 drivers/block/blksnap/version.h

diff --git a/drivers/block/blksnap/main.c b/drivers/block/blksnap/main.c
new file mode 100644
index 000000000000..a7939efc6497
--- /dev/null
+++ b/drivers/block/blksnap/main.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <uapi/linux/blksnap.h>
+#include "version.h"
+#include "params.h"
+#include "ctrl.h"
+#include "sysfs.h"
+#include "snapimage.h"
+#include "snapshot.h"
+#include "tracker.h"
+#include "diff_io.h"
+
+static int __init blk_snap_init(void)
+{
+	int result;
+
+	pr_info("Loading\n");
+	pr_debug("Version: %s\n", VERSION_STR);
+	pr_debug("tracking_block_minimum_shift: %d\n",
+		 tracking_block_minimum_shift);
+	pr_debug("tracking_block_maximum_count: %d\n",
+		 tracking_block_maximum_count);
+	pr_debug("chunk_minimum_shift: %d\n", chunk_minimum_shift);
+	pr_debug("chunk_maximum_count: %d\n", chunk_maximum_count);
+	pr_debug("chunk_maximum_in_cache: %d\n", chunk_maximum_in_cache);
+	pr_debug("free_diff_buffer_pool_size: %d\n",
+		 free_diff_buffer_pool_size);
+	pr_debug("diff_storage_minimum: %d\n", diff_storage_minimum);
+
+	result = diff_io_init();
+	if (result)
+		return result;
+
+	result = snapimage_init();
+	if (result)
+		return result;
+
+	result = tracker_init();
+	if (result)
+		return result;
+
+	result = ctrl_init();
+	if (result)
+		return result;
+
+	result = sysfs_initialize();
+	return result;
+}
+
+static void __exit blk_snap_exit(void)
+{
+	pr_info("Unloading module\n");
+
+	sysfs_finalize();
+	ctrl_done();
+
+	diff_io_done();
+	snapshot_done();
+	snapimage_done();
+	tracker_done();
+
+	pr_info("Module was unloaded\n");
+}
+
+module_init(blk_snap_init);
+module_exit(blk_snap_exit);
+
+/*
+ * The power of 2 for minimum tracking block size.
+ * If we make the tracking block size small, we will get detailed information
+ * about the changes, but the size of the change tracker table will be too
+ * large, which will lead to inefficient memory usage.
+ */
+int tracking_block_minimum_shift = 16;
+
+/*
+ * The maximum number of tracking blocks.
+ * A table is created to store information about the status of all tracking
+ * blocks in RAM. So, if the size of the tracking block is small, then the size
+ * of the table turns out to be large and memory is consumed inefficiently.
+ * As the size of the block device grows, the size of the tracking block
+ * size should also grow. For this purpose, the limit of the maximum
+ * number of block size is set.
+ */
+int tracking_block_maximum_count = 2097152;
+
+/*
+ * The power of 2 for minimum chunk size.
+ * The size of the chunk depends on how much data will be copied to the
+ * difference storage when at least one sector of the block device is changed.
+ * If the size is small, then small I/O units will be generated, which will
+ * reduce performance. Too large a chunk size will lead to inefficient use of
+ * the difference storage.
+ */
+int chunk_minimum_shift = 18;
+
+/*
+ * The maximum number of chunks.
+ * To store information about the state of all the chunks, a table is created
+ * in RAM. So, if the size of the chunk is small, then the size of the table
+ * turns out to be large and memory is consumed inefficiently.
+ * As the size of the block device grows, the size of the chunk should also
+ * grow. For this purpose, the maximum number of chunks is set.
+ */
+int chunk_maximum_count = 2097152;
+
+/*
+ * The maximum number of chunks in memory cache.
+ * Since reading and writing to snapshots is performed in large chunks,
+ * a cache is implemented to optimize reading small portions of data
+ * from the snapshot image. As the number of chunks in the cache
+ * increases, memory consumption also increases.
+ * The minimum recommended value is four.
+ */
+int chunk_maximum_in_cache = 32;
+
+/*
+ * The size of the pool of preallocated difference buffers.
+ * A buffer can be allocated for each chunk. After use, this buffer is not
+ * released immediately, but is sent to the pool of free buffers.
+ * However, if there are too many free buffers in the pool, then these free
+ * buffers will be released immediately.
+ */
+int free_diff_buffer_pool_size = 128;
+
+/*
+ * The minimum allowable size of the difference storage in sectors.
+ * The difference storage is a part of the disk space allocated for storing
+ * snapshot data. If there is less free space in the storage than the minimum,
+ * an event is generated about the lack of free space.
+ */
+int diff_storage_minimum = 2097152;
+
+module_param_named(tracking_block_minimum_shift, tracking_block_minimum_shift,
+		   int, 0644);
+MODULE_PARM_DESC(tracking_block_minimum_shift,
+		 "The power of 2 for minimum tracking block size");
+module_param_named(tracking_block_maximum_count, tracking_block_maximum_count,
+		   int, 0644);
+MODULE_PARM_DESC(tracking_block_maximum_count,
+		 "The maximum number of tracking blocks");
+module_param_named(chunk_minimum_shift, chunk_minimum_shift, int, 0644);
+MODULE_PARM_DESC(chunk_minimum_shift,
+		 "The power of 2 for minimum chunk size");
+module_param_named(chunk_maximum_count, chunk_maximum_count, int, 0644);
+MODULE_PARM_DESC(chunk_maximum_count,
+		 "The maximum number of chunks");
+module_param_named(chunk_maximum_in_cache, chunk_maximum_in_cache, int, 0644);
+MODULE_PARM_DESC(chunk_maximum_in_cache,
+		 "The maximum number of chunks in memory cache");
+module_param_named(free_diff_buffer_pool_size, free_diff_buffer_pool_size, int,
+		   0644);
+MODULE_PARM_DESC(free_diff_buffer_pool_size,
+		 "The size of the pool of preallocated difference buffers");
+module_param_named(diff_storage_minimum, diff_storage_minimum, int, 0644);
+MODULE_PARM_DESC(diff_storage_minimum,
+	"The minimum allowable size of the difference storage in sectors");
+
+MODULE_DESCRIPTION("Block Device Snapshots Module");
+MODULE_VERSION(VERSION_STR);
+MODULE_AUTHOR("Veeam Software Group GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/block/blksnap/params.h b/drivers/block/blksnap/params.h
new file mode 100644
index 000000000000..9181797545c4
--- /dev/null
+++ b/drivers/block/blksnap/params.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_PARAMS_H
+#define __BLK_SNAP_PARAMS_H
+
+extern int tracking_block_minimum_shift;
+extern int tracking_block_maximum_count;
+extern int chunk_minimum_shift;
+extern int chunk_maximum_count;
+extern int chunk_maximum_in_cache;
+extern int free_diff_buffer_pool_size;
+extern int diff_storage_minimum;
+#endif /* __BLK_SNAP_PARAMS_H */
diff --git a/drivers/block/blksnap/version.h b/drivers/block/blksnap/version.h
new file mode 100644
index 000000000000..fc9d97c9f814
--- /dev/null
+++ b/drivers/block/blksnap/version.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_VERSION_H
+#define __BLK_SNAP_VERSION_H
+
+#define VERSION_MAJOR 1
+#define VERSION_MINOR 0
+#define VERSION_REVISION 0
+#define VERSION_BUILD 0
+#define VERSION_STR "1.0.0.0"
+#endif /* __BLK_SNAP_VERSION_H */
-- 
2.20.1

