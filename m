Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527AB5F0757
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiI3JO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiI3JOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:14:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3940152669
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:14:12 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf4GS592nzpVbm;
        Fri, 30 Sep 2022 17:11:12 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 17:14:10 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
Subject: [PATCH v5 1/2] squashfs: add the mount parameter theads=<single|multi|percpu>
Date:   Fri, 30 Sep 2022 17:14:05 +0800
Message-ID: <20220930091406.50869-2-nixiaoming@huawei.com>
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

Squashfs supports three decompression concurrency modes:
	Single-thread mode: concurrent reads are blocked and the memory
		overhead is small.
	Multi-thread mode/percpu mode: reduces concurrent read blocking but
		increases memory overhead.

The corresponding schema must be fixed at compile time. During mounting,
the concurrent decompression mode cannot be adjusted based on file read
blocking.

The mount parameter theads=<single|multi|percpu> is added to select
the concurrent decompression mode of a single SquashFS file system
image.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/squashfs/Kconfig                     | 39 +++++++++++++++++++++----
 fs/squashfs/block.c                     |  2 +-
 fs/squashfs/decompressor.c              |  2 +-
 fs/squashfs/decompressor_multi.c        | 16 +++++++----
 fs/squashfs/decompressor_multi_percpu.c | 23 ++++++++++-----
 fs/squashfs/decompressor_single.c       | 15 +++++++---
 fs/squashfs/squashfs.h                  | 23 +++++++++++----
 fs/squashfs/squashfs_fs_sb.h            |  3 +-
 fs/squashfs/super.c                     | 50 +++++++++++++++++++++++++++++++--
 9 files changed, 141 insertions(+), 32 deletions(-)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 916e78fabcaa..218bacdd4298 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -54,9 +54,36 @@ config SQUASHFS_FILE_DIRECT
 
 endchoice
 
+config SQUASHFS_DECOMP_SINGLE
+	depends on SQUASHFS
+	def_bool n
+
+config SQUASHFS_DECOMP_MULTI
+	depends on SQUASHFS
+	def_bool n
+
+config SQUASHFS_DECOMP_MULTI_PERCPU
+	depends on SQUASHFS
+	def_bool n
+
+config SQUASHFS_CHOICE_DECOMP_BY_MOUNT
+	bool "Select the parallel decompression mode during mount"
+	depends on SQUASHFS
+	default n
+	select SQUASHFS_DECOMP_SINGLE
+	select SQUASHFS_DECOMP_MULTI
+	select SQUASHFS_DECOMP_MULTI_PERCPU
+	help
+	  Compile all parallel decompression modes and specify the
+	  decompression mode by setting "threads=" during mount.
+	    threads=<single|multi|percpu>
+
+	  default Decompressor parallelisation is SQUASHFS_DECOMP_SINGLE
+
 choice
-	prompt "Decompressor parallelisation options"
+	prompt "Select decompression parallel mode at compile time"
 	depends on SQUASHFS
+	depends on !SQUASHFS_CHOICE_DECOMP_BY_MOUNT
 	help
 	  Squashfs now supports three parallelisation options for
 	  decompression.  Each one exhibits various trade-offs between
@@ -64,15 +91,17 @@ choice
 
 	  If in doubt, select "Single threaded compression"
 
-config SQUASHFS_DECOMP_SINGLE
+config SQUASHFS_COMPILE_DECOMP_SINGLE
 	bool "Single threaded compression"
+	select SQUASHFS_DECOMP_SINGLE
 	help
 	  Traditionally Squashfs has used single-threaded decompression.
 	  Only one block (data or metadata) can be decompressed at any
 	  one time.  This limits CPU and memory usage to a minimum.
 
-config SQUASHFS_DECOMP_MULTI
+config SQUASHFS_COMPILE_DECOMP_MULTI
 	bool "Use multiple decompressors for parallel I/O"
+	select SQUASHFS_DECOMP_MULTI
 	help
 	  By default Squashfs uses a single decompressor but it gives
 	  poor performance on parallel I/O workloads when using multiple CPU
@@ -85,8 +114,9 @@ config SQUASHFS_DECOMP_MULTI
 	  decompressors per core.  It dynamically allocates decompressors
 	  on a demand basis.
 
-config SQUASHFS_DECOMP_MULTI_PERCPU
+config SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU
 	bool "Use percpu multiple decompressors for parallel I/O"
+	select SQUASHFS_DECOMP_MULTI_PERCPU
 	help
 	  By default Squashfs uses a single decompressor but it gives
 	  poor performance on parallel I/O workloads when using multiple CPU
@@ -95,7 +125,6 @@ config SQUASHFS_DECOMP_MULTI_PERCPU
 	  This decompressor implementation uses a maximum of one
 	  decompressor per core.  It uses percpu variables to ensure
 	  decompression is load-balanced across the cores.
-
 endchoice
 
 config SQUASHFS_XATTR
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 833aca92301f..bed3bb8b27fa 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -216,7 +216,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 			res = -EIO;
 			goto out_free_bio;
 		}
-		res = squashfs_decompress(msblk, bio, offset, length, output);
+		res = msblk->thread_ops->decompress(msblk, bio, offset, length, output);
 	} else {
 		res = copy_bio_to_actor(bio, output, offset, length);
 	}
diff --git a/fs/squashfs/decompressor.c b/fs/squashfs/decompressor.c
index d57bef91ab08..8893cb9b4198 100644
--- a/fs/squashfs/decompressor.c
+++ b/fs/squashfs/decompressor.c
@@ -134,7 +134,7 @@ void *squashfs_decompressor_setup(struct super_block *sb, unsigned short flags)
 	if (IS_ERR(comp_opts))
 		return comp_opts;
 
-	stream = squashfs_decompressor_create(msblk, comp_opts);
+	stream = msblk->thread_ops->create(msblk, comp_opts);
 	if (IS_ERR(stream))
 		kfree(comp_opts);
 
diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
index db9f12a3ea05..eb25432bd149 100644
--- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -29,12 +29,11 @@
 #define MAX_DECOMPRESSOR	(num_online_cpus() * 2)
 
 
-int squashfs_max_decompressors(void)
+static int squashfs_max_decompressors(void)
 {
 	return MAX_DECOMPRESSOR;
 }
 
-
 struct squashfs_stream {
 	void			*comp_opts;
 	struct list_head	strm_list;
@@ -59,7 +58,7 @@ static void put_decomp_stream(struct decomp_stream *decomp_strm,
 	wake_up(&stream->wait);
 }
 
-void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 				void *comp_opts)
 {
 	struct squashfs_stream *stream;
@@ -103,7 +102,7 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 }
 
 
-void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
 	struct squashfs_stream *stream = msblk->stream;
 	if (stream) {
@@ -180,7 +179,7 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 }
 
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 			int offset, int length,
 			struct squashfs_page_actor *output)
 {
@@ -195,3 +194,10 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 			msblk->decompressor->name);
 	return res;
 }
+
+const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi = {
+	.create = squashfs_decompressor_create,
+	.destroy = squashfs_decompressor_destroy,
+	.decompress = squashfs_decompress,
+	.max_decompressors = squashfs_max_decompressors,
+};
diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index b881b9283b7f..1dfadf76ed9a 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -25,7 +25,7 @@ struct squashfs_stream {
 	local_lock_t	lock;
 };
 
-void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
 	struct squashfs_stream *stream;
@@ -59,7 +59,7 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 	return ERR_PTR(err);
 }
 
-void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
@@ -75,19 +75,21 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 	int offset, int length, struct squashfs_page_actor *output)
 {
 	struct squashfs_stream *stream;
+	struct squashfs_stream __percpu *percpu =
+			(struct squashfs_stream __percpu *) msblk->stream;
 	int res;
 
-	local_lock(&msblk->stream->lock);
-	stream = this_cpu_ptr(msblk->stream);
+	local_lock(&percpu->lock);
+	stream = this_cpu_ptr(percpu);
 
 	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
 					      offset, length, output);
 
-	local_unlock(&msblk->stream->lock);
+	local_unlock(&percpu->lock);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
@@ -96,7 +98,14 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 	return res;
 }
 
-int squashfs_max_decompressors(void)
+static int squashfs_max_decompressors(void)
 {
 	return num_possible_cpus();
 }
+
+const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu = {
+	.create = squashfs_decompressor_create,
+	.destroy = squashfs_decompressor_destroy,
+	.decompress = squashfs_decompress,
+	.max_decompressors = squashfs_max_decompressors,
+};
diff --git a/fs/squashfs/decompressor_single.c b/fs/squashfs/decompressor_single.c
index 4eb3d083d45e..6f161887710b 100644
--- a/fs/squashfs/decompressor_single.c
+++ b/fs/squashfs/decompressor_single.c
@@ -24,7 +24,7 @@ struct squashfs_stream {
 	struct mutex	mutex;
 };
 
-void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
 	struct squashfs_stream *stream;
@@ -49,7 +49,7 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 	return ERR_PTR(err);
 }
 
-void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
 	struct squashfs_stream *stream = msblk->stream;
 
@@ -59,7 +59,7 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 			int offset, int length,
 			struct squashfs_page_actor *output)
 {
@@ -78,7 +78,14 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 	return res;
 }
 
-int squashfs_max_decompressors(void)
+static int squashfs_max_decompressors(void)
 {
 	return 1;
 }
+
+const struct squashfs_decompressor_thread_ops squashfs_decompressor_single = {
+	.create = squashfs_decompressor_create,
+	.destroy = squashfs_decompressor_destroy,
+	.decompress = squashfs_decompress,
+	.max_decompressors = squashfs_max_decompressors,
+};
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 9783e01c8100..a6164fdf9435 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -38,11 +38,24 @@ extern const struct squashfs_decompressor *squashfs_lookup_decompressor(int);
 extern void *squashfs_decompressor_setup(struct super_block *, unsigned short);
 
 /* decompressor_xxx.c */
-extern void *squashfs_decompressor_create(struct squashfs_sb_info *, void *);
-extern void squashfs_decompressor_destroy(struct squashfs_sb_info *);
-extern int squashfs_decompress(struct squashfs_sb_info *, struct bio *,
-				int, int, struct squashfs_page_actor *);
-extern int squashfs_max_decompressors(void);
+
+struct squashfs_decompressor_thread_ops {
+	void * (*create)(struct squashfs_sb_info *msblk, void *comp_opts);
+	void (*destroy)(struct squashfs_sb_info *msblk);
+	int (*decompress)(struct squashfs_sb_info *msblk, struct bio *bio,
+			  int offset, int length, struct squashfs_page_actor *output);
+	int (*max_decompressors)(void);
+};
+
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_single;
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi;
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu;
+#endif
 
 /* export.c */
 extern __le64 *squashfs_read_inode_lookup_table(struct super_block *, u64, u64,
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 1e90c2575f9b..f1e5dad8ae0a 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -53,7 +53,7 @@ struct squashfs_sb_info {
 	__le64					*xattr_id_table;
 	struct mutex				meta_index_mutex;
 	struct meta_index			*meta_index;
-	struct squashfs_stream			*stream;
+	void					*stream;
 	__le64					*inode_lookup_table;
 	u64					inode_table;
 	u64					directory_table;
@@ -66,5 +66,6 @@ struct squashfs_sb_info {
 	int					xattr_ids;
 	unsigned int				ids;
 	bool					panic_on_errors;
+	const struct squashfs_decompressor_thread_ops *thread_ops;
 };
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 32565dafa7f3..6ba6fb90b391 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -47,10 +47,12 @@ enum Opt_errors {
 
 enum squashfs_param {
 	Opt_errors,
+	Opt_threads,
 };
 
 struct squashfs_mount_opts {
 	enum Opt_errors errors;
+	const struct squashfs_decompressor_thread_ops *thread_ops;
 };
 
 static const struct constant_table squashfs_param_errors[] = {
@@ -61,9 +63,29 @@ static const struct constant_table squashfs_param_errors[] = {
 
 static const struct fs_parameter_spec squashfs_fs_parameters[] = {
 	fsparam_enum("errors", Opt_errors, squashfs_param_errors),
+	fsparam_string("threads", Opt_threads),
 	{}
 };
 
+static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_opts *opts)
+{
+#ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
+	if (strcmp(str, "single") == 0) {
+		opts->thread_ops = &squashfs_decompressor_single;
+		return 0;
+	}
+	if (strcmp(str, "multi") == 0) {
+		opts->thread_ops = &squashfs_decompressor_multi;
+		return 0;
+	}
+	if (strcmp(str, "percpu") == 0) {
+		opts->thread_ops = &squashfs_decompressor_percpu;
+		return 0;
+	}
+#endif
+	return -EINVAL;
+}
+
 static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct squashfs_mount_opts *opts = fc->fs_private;
@@ -78,6 +100,10 @@ static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *para
 	case Opt_errors:
 		opts->errors = result.uint_32;
 		break;
+	case Opt_threads:
+		if (squashfs_parse_param_threads(param->string, opts) != 0)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -167,6 +193,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			       sb->s_bdev);
 		goto failed_mount;
 	}
+	msblk->thread_ops = opts->thread_ops;
 
 	/* Check the MAJOR & MINOR versions and lookup compression type */
 	msblk->decompressor = supported_squashfs_filesystem(
@@ -252,7 +279,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Allocate read_page block */
 	msblk->read_page = squashfs_cache_init("data",
-		squashfs_max_decompressors(), msblk->block_size);
+		msblk->thread_ops->max_decompressors(), msblk->block_size);
 	if (msblk->read_page == NULL) {
 		errorf(fc, "Failed to allocate read_page block");
 		goto failed_mount;
@@ -383,7 +410,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	squashfs_cache_delete(msblk->block_cache);
 	squashfs_cache_delete(msblk->fragment_cache);
 	squashfs_cache_delete(msblk->read_page);
-	squashfs_decompressor_destroy(msblk);
+	msblk->thread_ops->destroy(msblk);
 	kfree(msblk->inode_lookup_table);
 	kfree(msblk->fragment_index);
 	kfree(msblk->id_table);
@@ -435,6 +462,20 @@ static int squashfs_show_options(struct seq_file *s, struct dentry *root)
 	else
 		seq_puts(s, ",errors=continue");
 
+#ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
+	if (msblk->thread_ops == &squashfs_decompressor_single) {
+		seq_puts(s, ",threads=single");
+		return 0;
+	}
+	if (msblk->thread_ops == &squashfs_decompressor_multi) {
+		seq_puts(s, ",threads=multi");
+		return 0;
+	}
+	if (msblk->thread_ops == &squashfs_decompressor_percpu) {
+		seq_puts(s, ",threads=percpu");
+		return 0;
+	}
+#endif
 	return 0;
 }
 
@@ -446,6 +487,9 @@ static int squashfs_init_fs_context(struct fs_context *fc)
 	if (!opts)
 		return -ENOMEM;
 
+#ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
+	opts->thread_ops = &squashfs_decompressor_single;
+#endif
 	fc->fs_private = opts;
 	fc->ops = &squashfs_context_ops;
 	return 0;
@@ -478,7 +522,7 @@ static void squashfs_put_super(struct super_block *sb)
 		squashfs_cache_delete(sbi->block_cache);
 		squashfs_cache_delete(sbi->fragment_cache);
 		squashfs_cache_delete(sbi->read_page);
-		squashfs_decompressor_destroy(sbi);
+		sbi->thread_ops->destroy(sbi);
 		kfree(sbi->id_table);
 		kfree(sbi->fragment_index);
 		kfree(sbi->meta_index);
-- 
2.12.3

