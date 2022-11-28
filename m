Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB663A420
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiK1JG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiK1JGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:06:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600F178A7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p12so9529168plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6mvHVs7Emq3x8O+6oK7btk4FzaW3Q9LW/n9YIaMeEY=;
        b=aByivIjPectLrfW7PJXAKPBbF9CLRob7SfyWRzgeeaRgkZ5fbyjzDKES1vf+sI8ePP
         nlobNUu993/691YL35O5WEg87gefC5w9TvH3sAfV/4nsJq1MOfkuWt8yyn44d3rfr2ML
         TZlPB7cUR5XVg/bAQ9vnqrdgc2v20LOf4MBnf73zgKmfAZV6EDwphTNETPLkXoAsRx27
         Q2jLgaZcEn6nljMAjg/FBdpZPjouD8UJaTcFPcvlZ6bi9BSlHwQLOKs5yzV5AX8XBqgD
         M2atmyJfSwfyVhQHXchpnq2v9TyYbWfsXF09Ku21JocGu6eDkPNc/QQE1e6iDWwbJvF4
         G8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6mvHVs7Emq3x8O+6oK7btk4FzaW3Q9LW/n9YIaMeEY=;
        b=VzQ3v5bDUysSfEp0NFBP6hSSXYpB4SBzV1nZQ6hy+moJceYP+z5hOiJWb9wSN4Yd+Q
         H287p9aIiGGBMTr6VsYl036252NlldjQC2FjGkTt5jrQENiPYj058HEH8K1n66n+x75C
         zYvS1aF9/38hyYBb5cdSzcTEOmr6BcYqQ1nTK/W/6XIzdZRVEdL4E3k1+BwPxSdV0anN
         j0gc4cuezITakjInDfcXOy1YIBJ/k+TIMY8A+rMGDRCYd2L3VXUdcIhjgBRofwXNiTwX
         WGAl5N76db8tV2pDcwjY/nDuuIv1H7R8f+SLzQLxaqTW/NlhxJ7mlZNNDBpF1wZAw6vi
         ibig==
X-Gm-Message-State: ANoB5plRhFCc5fhXHjxyBh66SMMc7/C0YTIC1Cg4WqxDbzA79rnsMvHM
        PZkk5fqQUnNThT4i6/WAdrzSCw+W85AcQg==
X-Google-Smtp-Source: AA0mqf4a+//HfA9gq2RRbe/0i1+4Up2BVqGPmop8u7/7Zz1BDChPhAJGPm4CBcLk5FzdMo6IqyWhgw==
X-Received: by 2002:a17:90b:394c:b0:213:1935:9744 with SMTP id oe12-20020a17090b394c00b0021319359744mr53565330pjb.207.1669626376866;
        Mon, 28 Nov 2022 01:06:16 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001811a197797sm8269268plg.194.2022.11.28.01.06.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:06:16 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>,
        xiongping1 <xiongping1@xiaomi.com>
Subject: [PATCH 1/5] f2fs: record total data blocks allocated since mount
Date:   Mon, 28 Nov 2022 16:58:55 +0800
Message-Id: <20221128085859.5295-2-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
References: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiongping1 <xiongping1@xiaomi.com>

Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fs/f2fs/Kconfig     |  7 +++++++
 fs/f2fs/Makefile    |  1 +
 fs/f2fs/block_age.c | 28 ++++++++++++++++++++++++++++
 fs/f2fs/debug.c     |  7 +++++++
 fs/f2fs/f2fs.h      | 15 +++++++++++++++
 fs/f2fs/segment.c   |  4 ++++
 fs/f2fs/super.c     |  4 ++++
 7 files changed, 66 insertions(+)
 create mode 100644 fs/f2fs/block_age.c

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 03ef087537c7..84915f9c6bc8 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -150,3 +150,10 @@ config F2FS_UNFAIR_RWSEM
 	help
 	  Use unfair rw_semaphore, if system configured IO priority by block
 	  cgroup.
+
+config F2FS_FS_DATA_SEPARATION
+	bool "F2FS hot/cold data separation feature"
+	depends on F2FS_FS
+	help
+	  Enable data blocks separation according to block update frequency.
+
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 8a7322d229e4..70d8f0e23b46 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -10,3 +10,4 @@ f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_FS_VERITY) += verity.o
 f2fs-$(CONFIG_F2FS_FS_COMPRESSION) += compress.o
 f2fs-$(CONFIG_F2FS_IOSTAT) += iostat.o
+f2fs-$(CONFIG_F2FS_FS_DATA_SEPARATION) += block_age.o
diff --git a/fs/f2fs/block_age.c b/fs/f2fs/block_age.c
new file mode 100644
index 000000000000..1e8711a03959
--- /dev/null
+++ b/fs/f2fs/block_age.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/f2fs/block_age.c
+ *
+ * Copyright (c) 2022 xiaomi Co., Ltd.
+ *             http://www.xiaomi.com/
+ */
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "segment.h"
+
+static inline void f2fs_inc_data_block_alloc(struct f2fs_sb_info *sbi)
+{
+	atomic64_inc(&sbi->total_data_alloc);
+}
+
+void f2fs_init_block_age_info(struct f2fs_sb_info *sbi)
+{
+	atomic64_set(&sbi->total_data_alloc, 0);
+}
+
+void f2fs_inc_block_alloc_count(struct f2fs_sb_info *sbi, int type)
+{
+	if (IS_DATASEG(type))
+		f2fs_inc_data_block_alloc(sbi);
+}
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a216dcdf6941..d24abdac20bb 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -81,6 +81,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ext_tree = atomic_read(&sbi->total_ext_tree);
 	si->zombie_tree = atomic_read(&sbi->total_zombie_tree);
 	si->ext_node = atomic_read(&sbi->total_ext_node);
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	si->total_data_blocks_alloc = atomic64_read(&sbi->total_data_alloc);
+#endif
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
 	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
@@ -373,6 +376,10 @@ static int stat_show(struct seq_file *s, void *v)
 			seq_printf(s, "Utilization: %u%% (%u valid blocks)\n",
 				si->utilization, si->valid_count);
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+		seq_printf(s, "  - Data Block Allocated: %llu\n",
+			   si->total_data_blocks_alloc);
+#endif
 		seq_printf(s, "  - Node: %u (Inode: %u, ",
 			   si->valid_node_count, si->valid_inode_count);
 		seq_printf(s, "Other: %u)\n  - Data: %u\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..686f09846de4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1807,6 +1807,10 @@ struct f2fs_sb_info {
 	u64 sectors_written_start;
 	u64 kbytes_written;
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	atomic64_t total_data_alloc;
+#endif
+
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
 
@@ -3858,6 +3862,9 @@ struct f2fs_stat_info {
 	int main_area_segs, main_area_sections, main_area_zones;
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	unsigned long long total_data_blocks_alloc;
+#endif
 	int ext_tree, zombie_tree, ext_node;
 	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_imeta;
 	int ndirty_data, ndirty_qdata;
@@ -4166,6 +4173,14 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_extent_cache(void);
 void f2fs_destroy_extent_cache(void);
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+/*
+ * block_age.c
+ */
+void f2fs_init_block_age_info(struct f2fs_sb_info *sbi);
+void f2fs_inc_block_alloc_count(struct f2fs_sb_info *sbi, int type);
+#endif
+
 /*
  * sysfs.c
  */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..0cf022fd3560 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3280,6 +3280,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	f2fs_inc_block_alloc_count(sbi, type);
+#endif
+
 	up_write(&sit_i->sentry_lock);
 
 	if (page && IS_NODESEG(type)) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..bf799d92282a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4475,6 +4475,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_join_shrinker(sbi);
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	f2fs_init_block_age_info(sbi);
+#endif
+
 	f2fs_tuning_parameters(sbi);
 
 	f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
-- 
2.36.1

