Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E3688E25
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjBCDrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjBCDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:47:27 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6397266A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:47:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Van6WaK_1675396042;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Van6WaK_1675396042)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:47:22 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com, houtao1@huawei.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] erofs: simplify instantiation of pseudo mount in fscache mode
Date:   Fri,  3 Feb 2023 11:47:19 +0800
Message-Id: <20230203034720.24619-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203034720.24619-1-jefflexu@linux.alibaba.com>
References: <20230203034720.24619-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a pseudo fs type dedicated to the pseudo mount of fscache
mode, so that the logic of real mount won't be messed up with that of
pseudo mount, making the implementation of fscache mode more
self-contained.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 46 +++++++++++++++++++++++++++------------------
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    | 35 +++++++---------------------------
 3 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index af6ba52bbe8b..2eb42bbc56a4 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,12 +6,13 @@
 #include <linux/fscache.h>
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
+#include <linux/pseudo_fs.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
-static struct vfsmount *erofs_pseudo_mnt;
+static struct vfsmount *erofs_pseudo_mnt __read_mostly;
 
 struct erofs_fscache_request {
 	struct erofs_fscache_request *primary;
@@ -471,10 +472,6 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
-		if (list_empty(&erofs_domain_list)) {
-			kern_unmount(erofs_pseudo_mnt);
-			erofs_pseudo_mnt = NULL;
-		}
 		mutex_unlock(&erofs_domain_list_lock);
 		fscache_relinquish_volume(domain->volume, NULL, false);
 		kfree(domain->domain_id);
@@ -526,15 +523,10 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 	}
 
 	err = erofs_fscache_register_volume(sb);
-	if (err)
-		goto out;
-
-	if (!erofs_pseudo_mnt) {
-		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
-		if (IS_ERR(erofs_pseudo_mnt)) {
-			err = PTR_ERR(erofs_pseudo_mnt);
-			goto out;
-		}
+	if (err) {
+		kfree(domain->domain_id);
+		kfree(domain);
+		return err;
 	}
 
 	domain->volume = sbi->volume;
@@ -542,10 +534,6 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 	list_add(&domain->list, &erofs_domain_list);
 	sbi->domain = domain;
 	return 0;
-out:
-	kfree(domain->domain_id);
-	kfree(domain);
-	return err;
 }
 
 static int erofs_fscache_register_domain(struct super_block *sb)
@@ -780,3 +768,25 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 	sbi->volume = NULL;
 	sbi->domain = NULL;
 }
+
+static int erofs_fc_anon_get_tree(struct fs_context *fc)
+{
+	return PTR_ERR_OR_ZERO(init_pseudo(fc, EROFS_SUPER_MAGIC));
+}
+
+int __init erofs_fscache_init(void)
+{
+	static struct file_system_type erofs_anon_fs = {
+		.name		= "erofs_anonfs",
+		.init_fs_context = erofs_fc_anon_get_tree,
+		.kill_sb	= kill_anon_super,
+	};
+
+	erofs_pseudo_mnt = kern_mount(&erofs_anon_fs);
+	return PTR_ERR_OR_ZERO(erofs_pseudo_mnt);
+}
+
+void erofs_fscache_exit(void)
+{
+	kern_unmount(erofs_pseudo_mnt);
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c3ac6d613eb1..6080e382ed7e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -634,6 +634,9 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 
 /* fscache.c */
 #ifdef CONFIG_EROFS_FS_ONDEMAND
+int __init erofs_fscache_init(void);
+void erofs_fscache_exit(void);
+
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
@@ -645,6 +648,9 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 extern const struct address_space_operations erofs_fscache_access_aops;
 extern const struct file_operations erofs_fscache_share_file_fops;
 #else
+static inline int erofs_fscache_init(void) { return 0; }
+static inline void erofs_fscache_exit(void) {}
+
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
 	return -EOPNOTSUPP;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 81aa63f34047..b06d29beed4e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -712,13 +712,6 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
-static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
-{
-	static const struct tree_descr empty_descr = {""};
-
-	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
-}
-
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -822,11 +815,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
-static int erofs_fc_anon_get_tree(struct fs_context *fc)
-{
-	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
-}
-
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
@@ -899,20 +887,10 @@ static const struct fs_context_operations erofs_context_ops = {
 	.free		= erofs_fc_free,
 };
 
-static const struct fs_context_operations erofs_anon_context_ops = {
-	.get_tree       = erofs_fc_anon_get_tree,
-};
-
 static int erofs_init_fs_context(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx;
 
-	/* pseudo mount for anon inodes */
-	if (fc->sb_flags & SB_KERNMOUNT) {
-		fc->ops = &erofs_anon_context_ops;
-		return 0;
-	}
-
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -940,12 +918,6 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
-	/* pseudo mount for anon inodes */
-	if (sb->s_flags & SB_KERNMOUNT) {
-		kill_anon_super(sb);
-		return;
-	}
-
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -1021,6 +993,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto zip_err;
 
+	err = erofs_fscache_init();
+	if (err)
+		goto fscache_err;
+
 	err = erofs_init_sysfs();
 	if (err)
 		goto sysfs_err;
@@ -1034,6 +1010,8 @@ static int __init erofs_module_init(void)
 fs_err:
 	erofs_exit_sysfs();
 sysfs_err:
+	erofs_fscache_exit();
+fscache_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
 	z_erofs_lzma_exit();
@@ -1053,6 +1031,7 @@ static void __exit erofs_module_exit(void)
 	rcu_barrier();
 
 	erofs_exit_sysfs();
+	erofs_fscache_exit();
 	z_erofs_exit_zip_subsystem();
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
-- 
2.19.1.6.gb485710b

