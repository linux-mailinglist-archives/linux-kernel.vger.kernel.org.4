Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1726C5EBACD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiI0Gg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiI0GgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:36:20 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD236051E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:36:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VQqcSYY_1664260568;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQqcSYY_1664260568)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 14:36:13 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: clean up unnecessary code and comments
Date:   Tue, 27 Sep 2022 14:36:06 +0800
Message-Id: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some conditional macros and comments are useless.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 --
 fs/erofs/namei.c    | 11 +----------
 fs/erofs/xattr.h    |  2 --
 fs/erofs/zmap.c     |  3 +--
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a6333c283e3d..0318530bc78a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -196,7 +196,6 @@ enum {
 	EROFS_ZIP_CACHE_READAROUND
 };
 
-#ifdef CONFIG_EROFS_FS_ZIP
 #define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
 
 /* basic unit of the workstation of a super_block */
@@ -236,7 +235,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	return atomic_cond_read_relaxed(&grp->refcount,
 					VAL != EROFS_LOCKED_MAGIC);
 }
-#endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
 #define LOG_BLOCK_SIZE		PAGE_SHIFT
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index fd75506799c4..afbb80d4e2f1 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -185,7 +185,6 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	if (IS_ERR(de))
 		return PTR_ERR(de);
 
-	/* the target page has been mapped */
 	if (ndirents)
 		de = find_target_dirent(&qn, (u8 *)de, EROFS_BLKSIZ, ndirents);
 
@@ -197,9 +196,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	return PTR_ERR_OR_ZERO(de);
 }
 
-/* NOTE: i_mutex is already held by vfs */
-static struct dentry *erofs_lookup(struct inode *dir,
-				   struct dentry *dentry,
+static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 				   unsigned int flags)
 {
 	int err;
@@ -207,17 +204,11 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	unsigned int d_type;
 	struct inode *inode;
 
-	DBG_BUGON(!d_really_is_negative(dentry));
-	/* dentry must be unhashed in lookup, no need to worry about */
-	DBG_BUGON(!d_unhashed(dentry));
-
 	trace_erofs_lookup(dir, dentry, flags);
 
-	/* file name exceeds fs limit */
 	if (dentry->d_name.len > EROFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	/* false uninitialized warnings on gcc 4.8.x */
 	err = erofs_namei(dir, &dentry->d_name, &nid, &d_type);
 
 	if (err == -ENOENT) {
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 332462c59f11..0a43c9ee9f8f 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -39,9 +39,7 @@ static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
-#ifdef CONFIG_EROFS_FS_SECURITY
 extern const struct xattr_handler erofs_xattr_security_handler;
-#endif
 
 static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
 {
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ccdddb755be8..0a2e41adc78a 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -743,8 +743,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	return err;
 }
 
-int z_erofs_map_blocks_iter(struct inode *inode,
-			    struct erofs_map_blocks *map,
+int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-- 
2.24.4

