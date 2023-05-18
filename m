Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255B870782A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjERCqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjERCqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:46:01 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FC135
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:45:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Viut.Db_1684377956;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Viut.Db_1684377956)
          by smtp.aliyun-inc.com;
          Thu, 18 May 2023 10:45:57 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] erofs: unify inline/share xattr iterators for listxattr/getxattr
Date:   Thu, 18 May 2023 10:45:50 +0800
Message-Id: <20230518024551.123990-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make inline_getxattr() and inline_listxattr() unified as
iter_inline_xattr(), shared_getxattr() and shared_listxattr() unified as
iter_shared_xattr().

After the unification, both iter_inline_xattr() and iter_shared_xattr()
return 0 on success, and negative error on failure.

One thing worth noting is that, the logic of returning it->buffer_ofs
when there's no shared xattrs in shared_listxattr() is moved to
erofs_listxattr() to make the unification possible.  The only difference
is that, semantically the old behavior will return ENOATTR rather than
it->buffer_ofs if ENOATTR encountered when listxattr is parsing upon a
specific shared xattr, while now the new behavior will return
it->buffer_ofs in this case.  This is not an issue, as listxattr upon a
specific xattr won't return ENOATTR.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 211 ++++++++++++++++++-----------------------------
 1 file changed, 80 insertions(+), 131 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 87d76ccea692..435146628eed 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -7,19 +7,6 @@
 #include <linux/security.h>
 #include "xattr.h"
 
-static inline erofs_blk_t erofs_xattr_blkaddr(struct super_block *sb,
-					      unsigned int xattr_id)
-{
-	return EROFS_SB(sb)->xattr_blkaddr +
-	       erofs_blknr(sb, xattr_id * sizeof(__u32));
-}
-
-static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
-					      unsigned int xattr_id)
-{
-	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
-}
-
 struct erofs_xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
@@ -33,6 +20,8 @@ struct erofs_xattr_iter {
 	int index, infix_len;
 	struct qstr name;
 	struct dentry *dentry;
+	struct inode *inode;
+	bool getxattr;
 };
 
 static inline int erofs_xattr_iter_fixup(struct erofs_xattr_iter *it)
@@ -171,30 +160,6 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
-				   struct inode *inode)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	unsigned int xattr_header_sz, inline_xattr_ofs;
-
-	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
-			  sizeof(u32) * vi->xattr_shared_count;
-	if (xattr_header_sz >= vi->xattr_isize) {
-		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
-		return -ENOATTR;
-	}
-
-	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
-
-	it->blkaddr = erofs_blknr(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
-				       EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	return vi->xattr_isize - xattr_header_sz;
-}
-
 /*
  * Regardless of success or failure, `xattr_foreach' will end up with
  * `ofs' pointing to the next xattr item rather than an arbitrary position.
@@ -356,46 +321,6 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
 	.value = xattr_copyvalue
 };
 
-static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
-{
-	int ret;
-	unsigned int remaining;
-
-	ret = inline_xattr_iter_begin(it, inode);
-	if (ret < 0)
-		return ret;
-
-	remaining = ret;
-	while (remaining) {
-		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
-		if (ret != -ENOATTR)
-			break;
-	}
-	return ret ? ret : it->buffer_ofs;
-}
-
-static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = it->sb;
-	unsigned int i, xsid;
-	int ret = -ENOATTR;
-
-	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		xsid = vi->xattr_shared_xattrs[i];
-		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->ofs = erofs_xattr_blkoff(sb, xsid);
-		it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr, EROFS_KMAP);
-		if (IS_ERR(it->kaddr))
-			return PTR_ERR(it->kaddr);
-
-		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
-		if (ret != -ENOATTR)
-			break;
-	}
-	return ret ? ret : it->buffer_ofs;
-}
-
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
 	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
@@ -406,38 +331,6 @@ static bool erofs_xattr_trusted_list(struct dentry *dentry)
 	return capable(CAP_SYS_ADMIN);
 }
 
-int erofs_getxattr(struct inode *inode, int index,
-		   const char *name,
-		   void *buffer, size_t buffer_size)
-{
-	int ret;
-	struct erofs_xattr_iter it;
-
-	if (!name)
-		return -EINVAL;
-	if (strlen(name) > EROFS_NAME_LEN)
-		return -ERANGE;
-
-	ret = erofs_init_inode_xattrs(inode);
-	if (ret)
-		return ret;
-
-	it = (struct erofs_xattr_iter) {
-		.buf	     = __EROFS_BUF_INITIALIZER,
-		.sb	     = inode->i_sb,
-		.name	     = QSTR_INIT(name, strlen(name)),
-		.index	     = index,
-		.buffer	     = buffer,
-		.buffer_size = buffer_size,
-	};
-
-	ret = inline_getxattr(inode, &it);
-	if (ret == -ENOATTR)
-		ret = shared_getxattr(inode, &it);
-	erofs_put_metabuf(&it.buf);
-	return ret;
-}
-
 static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, void *buffer, size_t size)
@@ -542,45 +435,97 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
 	.value = NULL
 };
 
-static int inline_listxattr(struct erofs_xattr_iter *it)
+static int erofs_iter_inline_xattr(struct erofs_xattr_iter *it)
 {
+	struct erofs_inode *const vi = EROFS_I(it->inode);
+	const struct xattr_iter_handlers *op;
+	unsigned int xattr_header_sz, remaining;
+	erofs_off_t pos;
 	int ret;
-	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
-	if (ret < 0)
-		return ret;
+	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
+			  sizeof(u32) * vi->xattr_shared_count;
+	if (xattr_header_sz >= vi->xattr_isize) {
+		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
+		return -ENOATTR;
+	}
+
+	pos = erofs_iloc(it->inode) + vi->inode_isize + xattr_header_sz;
+	it->blkaddr = erofs_blknr(it->sb, pos);
+	it->ofs = erofs_blkoff(it->sb, pos);
+	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr, EROFS_KMAP);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
+
+	remaining = vi->xattr_isize - xattr_header_sz;
+	op = it->getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 
-	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
-		if (ret)
+		ret = xattr_foreach(it, op, &remaining);
+		if ((it->getxattr && ret != -ENOATTR) || (!it->getxattr && ret))
 			break;
 	}
-	return ret ? ret : it->buffer_ofs;
+	return ret;
 }
 
-static int shared_listxattr(struct erofs_xattr_iter *it)
+static int erofs_iter_shared_xattr(struct erofs_xattr_iter *it)
 {
-	struct inode *const inode = d_inode(it->dentry);
-	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_inode *const vi = EROFS_I(it->inode);
 	struct super_block *const sb = it->sb;
+	const struct xattr_iter_handlers *op;
 	unsigned int i, xsid;
-	int ret = 0;
+	int ret = -ENOATTR;
+
+	op = it->getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
-		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->ofs = erofs_xattr_blkoff(sb, xsid);
+		it->blkaddr = EROFS_SB(sb)->xattr_blkaddr +
+			      erofs_blknr(sb, xsid * sizeof(__u32));
+		it->ofs = erofs_blkoff(sb, xsid * sizeof(__u32));
 		it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
-		if (ret)
+		ret = xattr_foreach(it, op, NULL);
+		if ((it->getxattr && ret != -ENOATTR) || (!it->getxattr && ret))
 			break;
 	}
-	return ret ? ret : it->buffer_ofs;
+	return ret;
+}
+
+int erofs_getxattr(struct inode *inode, int index,
+		   const char *name,
+		   void *buffer, size_t buffer_size)
+{
+	int ret;
+	struct erofs_xattr_iter it;
+
+	if (!name)
+		return -EINVAL;
+	if (strlen(name) > EROFS_NAME_LEN)
+		return -ERANGE;
+
+	ret = erofs_init_inode_xattrs(inode);
+	if (ret)
+		return ret;
+
+	it = (struct erofs_xattr_iter) {
+		.buf	     = __EROFS_BUF_INITIALIZER,
+		.sb	     = inode->i_sb,
+		.inode	     = inode,
+		.name	     = QSTR_INIT(name, strlen(name)),
+		.index	     = index,
+		.buffer	     = buffer,
+		.buffer_size = buffer_size,
+		.getxattr    = true,
+	};
+
+	ret = erofs_iter_inline_xattr(&it);
+	if (ret == -ENOATTR)
+		ret = erofs_iter_shared_xattr(&it);
+	erofs_put_metabuf(&it.buf);
+	return ret ? ret : it.buffer_ofs;
 }
 
 ssize_t erofs_listxattr(struct dentry *dentry,
@@ -599,15 +544,19 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 		.buf	     = __EROFS_BUF_INITIALIZER,
 		.sb	     = dentry->d_sb,
 		.dentry	     = dentry,
+		.inode	     = d_inode(dentry),
 		.buffer	     = buffer,
 		.buffer_size = buffer_size,
+		.getxattr    = false,
 	};
 
-	ret = inline_listxattr(&it);
-	if (ret >= 0 || ret == -ENOATTR)
-		ret = shared_listxattr(&it);
+	ret = erofs_iter_inline_xattr(&it);
+	if (!ret || ret == -ENOATTR)
+		ret = erofs_iter_shared_xattr(&it);
+	if (ret == -ENOATTR)
+		ret = 0;
 	erofs_put_metabuf(&it.buf);
-	return ret;
+	return ret ? ret : it.buffer_ofs;
 }
 
 void erofs_xattr_prefixes_cleanup(struct super_block *sb)
-- 
2.19.1.6.gb485710b

