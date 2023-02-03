Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F184B688E27
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBCDrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBCDr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:47:28 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08511721C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:47:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VamyQoO_1675396042;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VamyQoO_1675396042)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:47:23 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com, houtao1@huawei.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] erofs: simplify the name collision checking in share domain mode
Date:   Fri,  3 Feb 2023 11:47:20 +0800
Message-Id: <20230203034720.24619-3-jefflexu@linux.alibaba.com>
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

When share domain is enabled, data blobs can be shared among filesystem
instances in the same domain for data deduplication, while bootstrap
blobs are always dedicated to the corresponding filesystem instance, and
have no need to be shared.

In the initial implementation of share domain (commit 7d41963759fe
("erofs: Support sharing cookies in the same domain")), bootstrap blobs
are also in the share domain, and thus can be referenced by the
following filesystem instances.  In this case, mounting twice with the
same fsid and domain_id will trigger warning in sysfs.  Commit
27f2a2dcc626 ("erofs: check the uniqueness of fsid in shared domain in
advance") fixes this by introducing the name collision checking.

This patch attempts to fix the above issue in another simpler way.
Since the bootstrap blobs have no need to be shared, move them out of
the share domain, so that one bootstrap blob can not be referenced by
other filesystem instances.  Attempt to mount twice with the same fsid
and domain_id will fail with info of duplicate cookies, which is
consistent with the behavior in non-share-domain mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 38 +++++++++-----------------------------
 fs/erofs/internal.h |  9 ++-------
 fs/erofs/super.c    |  2 +-
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 2eb42bbc56a4..d47b04dfdc48 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -656,8 +656,7 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 static
 struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
-						   char *name,
-						   unsigned int flags)
+						   char *name)
 {
 	struct inode *inode;
 	struct erofs_fscache *ctx;
@@ -668,18 +667,12 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 	spin_lock(&psb->s_inode_list_lock);
 	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
 		ctx = inode->i_private;
-		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
-			continue;
-		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
+		if (ctx && ctx->domain == domain && !strcmp(ctx->name, name)) {
 			igrab(inode);
-		} else {
-			erofs_err(sb, "%s already exists in domain %s", name,
-				  domain->domain_id);
-			ctx = ERR_PTR(-EEXIST);
+			spin_unlock(&psb->s_inode_list_lock);
+			mutex_unlock(&erofs_domain_cookies_lock);
+			return ctx;
 		}
-		spin_unlock(&psb->s_inode_list_lock);
-		mutex_unlock(&erofs_domain_cookies_lock);
-		return ctx;
 	}
 	spin_unlock(&psb->s_inode_list_lock);
 	ctx = erofs_fscache_domain_init_cookie(sb, name);
@@ -688,11 +681,10 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 }
 
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						    char *name,
-						    unsigned int flags)
+						    char *name)
 {
 	if (EROFS_SB(sb)->domain_id)
-		return erofs_domain_register_cookie(sb, name, flags);
+		return erofs_domain_register_cookie(sb, name);
 	return erofs_fscache_acquire_cookie(sb, sb, name);
 }
 
@@ -724,7 +716,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
-	unsigned int flags = 0;
 
 	if (sbi->domain_id)
 		ret = erofs_fscache_register_domain(sb);
@@ -733,19 +724,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	if (ret)
 		return ret;
 
-	/*
-	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
-	 * the primary data blob (aka fsid) is unique in the shared domain.
-	 *
-	 * For non-shared-domain case, fscache_acquire_volume() invoked by
-	 * erofs_fscache_register_volume() has already guaranteed
-	 * the uniqueness of primary data blob.
-	 *
-	 * Acquired domain/volume will be relinquished in kill_sb() on error.
-	 */
-	if (sbi->domain_id)
-		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
-	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
+	/* acquired domain/volume will be relinquished in kill_sb() on error */
+	fscache = erofs_fscache_acquire_cookie(sb, sb, sbi->fsid);
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6080e382ed7e..a63a9e951fe0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -629,9 +629,6 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
-/* flags for erofs_fscache_register_cookie() */
-#define EROFS_REG_COOKIE_NEED_NOEXIST	1
-
 /* fscache.c */
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int __init erofs_fscache_init(void);
@@ -641,8 +638,7 @@ int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						    char *name,
-						    unsigned int flags);
+						    char *name);
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
@@ -659,8 +655,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
 static inline
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name,
-						     unsigned int flags)
+						     char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b06d29beed4e..ed4e373b0816 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -245,7 +245,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
+		fscache = erofs_fscache_register_cookie(sb, dif->path);
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
-- 
2.19.1.6.gb485710b

