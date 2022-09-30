Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CA5F0756
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiI3JO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiI3JOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:14:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3843152667
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:14:12 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf4F622VdzWh7Q;
        Fri, 30 Sep 2022 17:10:02 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 17:14:11 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
Subject: [PATCH v5 2/2] squashfs: Allows users to configure the number of  decompression threads
Date:   Fri, 30 Sep 2022 17:14:06 +0800
Message-ID: <20220930091406.50869-3-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220930091406.50869-1-nixiaoming@huawei.com>
References: <20220916083604.33408-1-nixiaoming@huawei.com>
 <20220930091406.50869-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of threads in the decompressor_multi.c file is fixed
and cannot be adjusted according to user needs.
Therefore, the mount parameter needs to be added to allow users to
configure the number of threads as required. The upper limit is
num_online_cpus() * 2.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/squashfs/Kconfig              | 16 ++++++++--
 fs/squashfs/decompressor_multi.c |  4 +--
 fs/squashfs/squashfs_fs_sb.h     |  1 +
 fs/squashfs/super.c              | 63 +++++++++++++++++++++++++++++++++-------
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 218bacdd4298..60fc98bdf421 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -73,11 +73,10 @@ config SQUASHFS_CHOICE_DECOMP_BY_MOUNT
 	select SQUASHFS_DECOMP_SINGLE
 	select SQUASHFS_DECOMP_MULTI
 	select SQUASHFS_DECOMP_MULTI_PERCPU
+	select SQUASHFS_MOUNT_DECOMP_THREADS
 	help
 	  Compile all parallel decompression modes and specify the
 	  decompression mode by setting "threads=" during mount.
-	    threads=<single|multi|percpu>
-
 	  default Decompressor parallelisation is SQUASHFS_DECOMP_SINGLE
 
 choice
@@ -127,6 +126,19 @@ config SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU
 	  decompression is load-balanced across the cores.
 endchoice
 
+config SQUASHFS_MOUNT_DECOMP_THREADS
+	bool "Add the mount parameter 'threads=' for squashfs"
+	depends on SQUASHFS
+	depends on SQUASHFS_DECOMP_MULTI
+	default n
+	help
+	  Use threads= to set the decompression parallel mode and the number of threads.
+	  If SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
+	      threads=<single|multi|percpu|1|2|3|...>
+	  else
+	      threads=<2|3|...>
+	  The upper limit is num_online_cpus() * 2.
+
 config SQUASHFS_XATTR
 	bool "Squashfs XATTR support"
 	depends on SQUASHFS
diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
index eb25432bd149..416c53eedbd1 100644
--- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -144,7 +144,7 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 		 * If there is no available decomp and already full,
 		 * let's wait for releasing decomp from other users.
 		 */
-		if (stream->avail_decomp >= MAX_DECOMPRESSOR)
+		if (stream->avail_decomp >= msblk->max_thread_num)
 			goto wait;
 
 		/* Let's allocate new decomp */
@@ -160,7 +160,7 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 		}
 
 		stream->avail_decomp++;
-		WARN_ON(stream->avail_decomp > MAX_DECOMPRESSOR);
+		WARN_ON(stream->avail_decomp > msblk->max_thread_num);
 
 		mutex_unlock(&stream->mutex);
 		break;
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index f1e5dad8ae0a..659082e9e51d 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -67,5 +67,6 @@ struct squashfs_sb_info {
 	unsigned int				ids;
 	bool					panic_on_errors;
 	const struct squashfs_decompressor_thread_ops *thread_ops;
+	int					max_thread_num;
 };
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 6ba6fb90b391..920449e1675f 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -53,6 +53,7 @@ enum squashfs_param {
 struct squashfs_mount_opts {
 	enum Opt_errors errors;
 	const struct squashfs_decompressor_thread_ops *thread_ops;
+	int thread_num;
 };
 
 static const struct constant_table squashfs_param_errors[] = {
@@ -67,7 +68,8 @@ static const struct fs_parameter_spec squashfs_fs_parameters[] = {
 	{}
 };
 
-static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_opts *opts)
+
+static int squashfs_parse_param_threads_str(const char *str, struct squashfs_mount_opts *opts)
 {
 #ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
 	if (strcmp(str, "single") == 0) {
@@ -86,6 +88,42 @@ static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_o
 	return -EINVAL;
 }
 
+static int squashfs_parse_param_threads_num(const char *str, struct squashfs_mount_opts *opts)
+{
+#ifdef CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS
+	int ret;
+	unsigned long num;
+
+	ret = kstrtoul(str, 0, &num);
+	if (ret != 0)
+		return -EINVAL;
+	if (num > 1) {
+		opts->thread_ops = &squashfs_decompressor_multi;
+		if (num > opts->thread_ops->max_decompressors())
+			return -EINVAL;
+		opts->thread_num = (int)num;
+		return 0;
+	}
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+	if (num == 1) {
+		opts->thread_ops = &squashfs_decompressor_single;
+		opts->thread_num = 1;
+		return 0;
+	}
+#endif
+#endif /* !CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS */
+	return -EINVAL;
+}
+
+static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_opts *opts)
+{
+	int ret = squashfs_parse_param_threads_str(str, opts);
+
+	if (ret == 0)
+		return ret;
+	return squashfs_parse_param_threads_num(str, opts);
+}
+
 static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct squashfs_mount_opts *opts = fc->fs_private;
@@ -194,6 +232,11 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed_mount;
 	}
 	msblk->thread_ops = opts->thread_ops;
+	if (opts->thread_num == 0) {
+		msblk->max_thread_num = msblk->thread_ops->max_decompressors();
+	} else {
+		msblk->max_thread_num = opts->thread_num;
+	}
 
 	/* Check the MAJOR & MINOR versions and lookup compression type */
 	msblk->decompressor = supported_squashfs_filesystem(
@@ -279,7 +322,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Allocate read_page block */
 	msblk->read_page = squashfs_cache_init("data",
-		msblk->thread_ops->max_decompressors(), msblk->block_size);
+		msblk->max_thread_num, msblk->block_size);
 	if (msblk->read_page == NULL) {
 		errorf(fc, "Failed to allocate read_page block");
 		goto failed_mount;
@@ -463,18 +506,17 @@ static int squashfs_show_options(struct seq_file *s, struct dentry *root)
 		seq_puts(s, ",errors=continue");
 
 #ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
-	if (msblk->thread_ops == &squashfs_decompressor_single) {
-		seq_puts(s, ",threads=single");
-		return 0;
-	}
-	if (msblk->thread_ops == &squashfs_decompressor_multi) {
-		seq_puts(s, ",threads=multi");
-		return 0;
-	}
 	if (msblk->thread_ops == &squashfs_decompressor_percpu) {
 		seq_puts(s, ",threads=percpu");
 		return 0;
 	}
+	if (msblk->thread_ops == &squashfs_decompressor_single) {
+		seq_puts(s, ",threads=single");
+		return 0;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS
+	seq_printf(s, ",threads=%d", msblk->max_thread_num);
 #endif
 	return 0;
 }
@@ -490,6 +532,7 @@ static int squashfs_init_fs_context(struct fs_context *fc)
 #ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
 	opts->thread_ops = &squashfs_decompressor_single;
 #endif
+	opts->thread_num = 0;
 	fc->fs_private = opts;
 	fc->ops = &squashfs_context_ops;
 	return 0;
-- 
2.12.3

