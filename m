Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8C68E8CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBHHQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBHHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:16:45 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF33400D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:16:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbAhOmj_1675840589;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbAhOmj_1675840589)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 15:16:29 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] erofs: unify anonymous inodes for blob
Date:   Wed,  8 Feb 2023 15:16:28 +0800
Message-Id: <c7430379f7ec2ae1c6ba98bb3a37a70b7fad2325.1675840368.git.jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1675840368.git.jefflexu@linux.alibaba.com>
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
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

Currently there're two anonymous inodes (inode and anon_inode in struct
erofs_fscache) for each blob.  The former was introduced as the
address_space of page cache for bootstrap.

The latter was initially introduced as both the address_space of page
cache and also a sentinel in the shared domain.  Since now the management
of cookies in share domain has been decoupled with the anonymous inode,
there's no need to maintain an extra anonymous inode.  Let's unify these
two anonymous inodes.

Besides, in non-share-domain mode only bootstrap will allocate anonymous
inode.  To simplify the implementation, always allocate anonymous inode
for both bootstrap and data blobs.  Similarly release anonymous inodes
for data blobs when .put_super() is called, or we'll get "VFS: Busy
inodes after unmount." warning.

Also remove the redundant set_nlink() when initializing the anonymous
inode, since i_nlink has already been initialized to 1 when the inode
gets allocated.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 70 ++++++++++++++++-----------------------------
 fs/erofs/internal.h |  6 ++--
 fs/erofs/super.c    |  2 ++
 3 files changed, 28 insertions(+), 50 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 2f5930e177cc..8353a5fe8c71 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -424,12 +424,12 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 
 static
 struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
-						   char *name,
-						   unsigned int flags)
+					struct super_block *isb, char *name)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -445,33 +445,27 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 		ret = -EINVAL;
 		goto err;
 	}
-
 	fscache_use_cookie(cookie, false);
-	ctx->cookie = cookie;
-
-	if (flags & EROFS_REG_COOKIE_NEED_INODE) {
-		struct inode *const inode = new_inode(sb);
-
-		if (!inode) {
-			erofs_err(sb, "failed to get anon inode for %s", name);
-			ret = -ENOMEM;
-			goto err_cookie;
-		}
-
-		set_nlink(inode, 1);
-		inode->i_size = OFFSET_MAX;
-		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-		inode->i_private = ctx;
 
-		ctx->inode = inode;
+	inode = new_inode(isb);
+	if (!inode) {
+		erofs_err(sb, "failed to get anon inode for %s", name);
+		ret = -ENOMEM;
+		goto err_cookie;
 	}
 
+	inode->i_size = OFFSET_MAX;
+	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	inode->i_private = ctx;
+
+	ctx->cookie = cookie;
+	ctx->inode = inode;
 	return ctx;
 
 err_cookie:
-	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
-	fscache_relinquish_cookie(ctx->cookie, false);
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
 err:
 	kfree(ctx);
 	return ERR_PTR(ret);
@@ -482,46 +476,31 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
-	iput(ctx->anon_inode);
 	kfree(ctx->name);
 	kfree(ctx);
 }
 
 static
 struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
-						       char *name,
-						       unsigned int flags)
+						       char *name)
 {
-	int err;
-	struct inode *inode;
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 
-	ctx = erofs_fscache_acquire_cookie(sb, name, flags);
+	ctx = erofs_fscache_acquire_cookie(sb, erofs_pseudo_mnt->mnt_sb, name);
 	if (IS_ERR(ctx))
 		return ctx;
 
 	ctx->name = kstrdup(name, GFP_KERNEL);
 	if (!ctx->name) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
-	if (!inode) {
-		err = -ENOMEM;
-		goto out;
+		erofs_fscache_relinquish_cookie(ctx);
+		return ERR_PTR(-ENOMEM);
 	}
 
+	refcount_inc(&domain->ref);
 	ctx->domain = domain;
-	ctx->anon_inode = inode;
 	list_add(&ctx->node, &erofs_domain_cookies_list);
-	inode->i_private = ctx;
-	refcount_inc(&domain->ref);
 	return ctx;
-out:
-	erofs_fscache_relinquish_cookie(ctx);
-	return ERR_PTR(err);
 }
 
 static
@@ -546,7 +525,7 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 		mutex_unlock(&erofs_domain_cookies_lock);
 		return ctx;
 	}
-	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
+	ctx = erofs_fscache_domain_init_cookie(sb, name);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
 }
@@ -557,7 +536,7 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 {
 	if (EROFS_SB(sb)->domain_id)
 		return erofs_domain_register_cookie(sb, name, flags);
-	return erofs_fscache_acquire_cookie(sb, name, flags);
+	return erofs_fscache_acquire_cookie(sb, sb, name);
 }
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
@@ -585,7 +564,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
-	unsigned int flags;
+	unsigned int flags = 0;
 
 	if (sbi->domain_id)
 		ret = erofs_fscache_register_domain(sb);
@@ -604,7 +583,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	 *
 	 * Acquired domain/volume will be relinquished in kill_sb() on error.
 	 */
-	flags = EROFS_REG_COOKIE_NEED_INODE;
 	if (sbi->domain_id)
 		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
 	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8358cf5f731e..125e4aa8d295 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -107,8 +107,7 @@ struct erofs_domain {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
-	struct inode *inode;
-	struct inode *anon_inode;
+	struct inode *inode;	/* anonymous indoe for the blob */
 
 	/* used for share domain mode */
 	struct erofs_domain *domain;
@@ -450,8 +449,7 @@ extern const struct file_operations erofs_dir_fops;
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 /* flags for erofs_fscache_register_cookie() */
-#define EROFS_REG_COOKIE_NEED_INODE	1
-#define EROFS_REG_COOKIE_NEED_NOEXIST	2
+#define EROFS_REG_COOKIE_NEED_NOEXIST	1
 
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 715efa94eed4..19b1ae79cec4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -968,6 +968,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
 #endif
+	erofs_free_dev_context(sbi->devs);
+	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
 }
 
-- 
2.19.1.6.gb485710b

