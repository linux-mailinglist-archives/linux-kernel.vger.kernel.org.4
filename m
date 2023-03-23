Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205956C5B27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCWAKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCWAKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:10:32 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29B32CDF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:10:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeS0V1H_1679530190;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeS0V1H_1679530190)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 08:09:50 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] erofs: move several xattr helpers into xattr.c
Date:   Thu, 23 Mar 2023 08:09:42 +0800
Message-Id: <20230323000949.57608-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
References: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several xattr helpers not used outside xattr.c, thus move them
into xattr.c as a cleanup.

inlinexattr_header_size() has only one caller, and thus make it inlined
into the caller directly.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 73 +++++++++++++++++++++++++++++++++---------------
 fs/erofs/xattr.h | 56 -------------------------------------
 2 files changed, 51 insertions(+), 78 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 459caa3cd65d..760ec864a39c 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -7,6 +7,19 @@
 #include <linux/security.h>
 #include "xattr.h"
 
+static inline erofs_blk_t erofs_xattr_blkaddr(struct super_block *sb,
+					      unsigned int xattr_id)
+{
+	return EROFS_SB(sb)->xattr_blkaddr +
+	       erofs_blknr(sb, xattr_id * sizeof(__u32));
+}
+
+static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
+					      unsigned int xattr_id)
+{
+	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
+}
+
 struct xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
@@ -157,7 +170,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	struct erofs_inode *const vi = EROFS_I(inode);
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 
-	xattr_header_sz = inlinexattr_header_size(inode);
+	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
+			  sizeof(u32) * vi->xattr_shared_count;
 	if (xattr_header_sz >= vi->xattr_isize) {
 		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
 		return -ENOATTR;
@@ -351,20 +365,18 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
 static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = inode->i_sb;
-	unsigned int i;
+	struct super_block *const sb = it->it.sb;
+	unsigned int i, xsid;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		erofs_blk_t blkaddr =
-			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
-
-		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
-						  EROFS_KMAP);
+		xsid = vi->xattr_shared_xattrs[i];
+		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
+		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
+		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
+						  it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
-		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
@@ -383,9 +395,8 @@ static bool erofs_xattr_trusted_list(struct dentry *dentry)
 	return capable(CAP_SYS_ADMIN);
 }
 
-int erofs_getxattr(struct inode *inode, int index,
-		   const char *name,
-		   void *buffer, size_t buffer_size)
+static int erofs_getxattr(struct inode *inode, int index, const char *name,
+			  void *buffer, size_t buffer_size)
 {
 	int ret;
 	struct getxattr_iter it;
@@ -473,6 +484,26 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
+static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
+{
+	static const struct xattr_handler *xattr_handler_map[] = {
+		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
+			&posix_acl_access_xattr_handler,
+		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
+			&posix_acl_default_xattr_handler,
+#endif
+		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
+#ifdef CONFIG_EROFS_FS_SECURITY
+		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
+#endif
+	};
+
+	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
+		xattr_handler_map[idx] : NULL;
+}
+
 struct listxattr_iter {
 	struct xattr_iter it;
 
@@ -562,20 +593,18 @@ static int shared_listxattr(struct listxattr_iter *it)
 {
 	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = inode->i_sb;
-	unsigned int i;
+	struct super_block *const sb = it->it.sb;
+	unsigned int i, xsid;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		erofs_blk_t blkaddr =
-			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
-
-		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
-						  EROFS_KMAP);
+		xsid = vi->xattr_shared_xattrs[i];
+		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
+		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
+		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
+						  it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
-		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
 		if (ret)
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index f7a21aaa9755..cc9ef97dbf8e 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -13,66 +13,10 @@
 /* Attribute not found */
 #define ENOATTR         ENODATA
 
-static inline unsigned int inlinexattr_header_size(struct inode *inode)
-{
-	return sizeof(struct erofs_xattr_ibody_header) +
-		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
-}
-
-static inline erofs_blk_t xattrblock_addr(struct super_block *sb,
-					  unsigned int xattr_id)
-{
 #ifdef CONFIG_EROFS_FS_XATTR
-	return EROFS_SB(sb)->xattr_blkaddr +
-		xattr_id * sizeof(__u32) / sb->s_blocksize;
-#else
-	return 0;
-#endif
-}
-
-static inline unsigned int xattrblock_offset(struct super_block *sb,
-					     unsigned int xattr_id)
-{
-	return (xattr_id * sizeof(__u32)) % sb->s_blocksize;
-}
-
-#ifdef CONFIG_EROFS_FS_XATTR
-extern const struct xattr_handler erofs_xattr_user_handler;
-extern const struct xattr_handler erofs_xattr_trusted_handler;
-extern const struct xattr_handler erofs_xattr_security_handler;
-
-static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
-{
-	static const struct xattr_handler *xattr_handler_map[] = {
-		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
-			&posix_acl_access_xattr_handler,
-		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
-			&posix_acl_default_xattr_handler,
-#endif
-		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
-#ifdef CONFIG_EROFS_FS_SECURITY
-		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
-#endif
-	};
-
-	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
-		xattr_handler_map[idx] : NULL;
-}
-
 extern const struct xattr_handler *erofs_xattr_handlers[];
-
-int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
-static inline int erofs_getxattr(struct inode *inode, int index,
-				 const char *name, void *buffer,
-				 size_t buffer_size)
-{
-	return -EOPNOTSUPP;
-}
-
 #define erofs_listxattr (NULL)
 #define erofs_xattr_handlers (NULL)
 #endif	/* !CONFIG_EROFS_FS_XATTR */
-- 
2.19.1.6.gb485710b

