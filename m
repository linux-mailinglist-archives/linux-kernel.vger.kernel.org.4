Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756B7190A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjFACoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFACoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:44:05 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0BE128
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:43:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VjzsOKZ_1685587433;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjzsOKZ_1685587433)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 10:43:54 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] erofs: unify inline/share xattr iterators for listxattr/getxattr
Date:   Thu,  1 Jun 2023 10:43:46 +0800
Message-Id: <20230601024347.108469-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
References: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
 fs/erofs/xattr.c | 209 ++++++++++++++++++-----------------------------
 1 file changed, 78 insertions(+), 131 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 19f9bf67440c..64180e83a63e 100644
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
@@ -171,29 +158,6 @@ struct xattr_iter_handlers {
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
-	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	return vi->xattr_isize - xattr_header_sz;
-}
-
 /*
  * Regardless of success or failure, `xattr_foreach' will end up with
  * `ofs' pointing to the next xattr item rather than an arbitrary position.
@@ -355,46 +319,6 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
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
-		it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
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
@@ -405,39 +329,6 @@ static bool erofs_xattr_trusted_list(struct dentry *dentry)
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
-
-	ret = erofs_init_inode_xattrs(inode);
-	if (ret)
-		return ret;
-
-	it.index = index;
-	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
-	if (it.name.len > EROFS_NAME_LEN)
-		return -ERANGE;
-
-	it.sb = inode->i_sb;
-	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sb);
-	it.buffer = buffer;
-	it.buffer_size = buffer_size;
-	it.buffer_ofs = 0;
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
@@ -542,45 +433,98 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
 	.value = NULL
 };
 
-static int inline_listxattr(struct erofs_xattr_iter *it)
+static int erofs_iter_inline_xattr(struct erofs_xattr_iter *it,
+				   struct inode *inode, bool getxattr)
 {
+	struct erofs_inode *const vi = EROFS_I(inode);
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
+	pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
+	it->blkaddr = erofs_blknr(it->sb, pos);
+	it->ofs = erofs_blkoff(it->sb, pos);
+	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr, EROFS_KMAP);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
+
+	remaining = vi->xattr_isize - xattr_header_sz;
+	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 
-	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
-		if (ret)
+		ret = xattr_foreach(it, op, &remaining);
+		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
 			break;
 	}
-	return ret ? ret : it->buffer_ofs;
+	return ret;
 }
 
-static int shared_listxattr(struct erofs_xattr_iter *it)
+static int erofs_iter_shared_xattr(struct erofs_xattr_iter *it,
+				   struct inode *inode, bool getxattr)
 {
-	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = it->sb;
+	const struct xattr_iter_handlers *op;
 	unsigned int i, xsid;
-	int ret = 0;
+	int ret = -ENOATTR;
+
+	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
-		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->ofs = erofs_xattr_blkoff(sb, xsid);
+		it->blkaddr = EROFS_SB(sb)->xattr_blkaddr +
+			      erofs_blknr(sb, xsid * sizeof(__u32));
+		it->ofs = erofs_blkoff(sb, xsid * sizeof(__u32));
 		it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
-		if (ret)
+		ret = xattr_foreach(it, op, NULL);
+		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
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
+
+	ret = erofs_init_inode_xattrs(inode);
+	if (ret)
+		return ret;
+
+	it.index = index;
+	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
+	if (it.name.len > EROFS_NAME_LEN)
+		return -ERANGE;
+
+	it.sb = inode->i_sb;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sb);
+	it.buffer = buffer;
+	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
+
+	ret = erofs_iter_inline_xattr(&it, inode, true);
+	if (ret == -ENOATTR)
+		ret = erofs_iter_shared_xattr(&it, inode, true);
+	erofs_put_metabuf(&it.buf);
+	return ret ? ret : it.buffer_ofs;
 }
 
 ssize_t erofs_listxattr(struct dentry *dentry,
@@ -588,8 +532,9 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 {
 	int ret;
 	struct erofs_xattr_iter it;
+	struct inode *inode = d_inode(dentry);
 
-	ret = erofs_init_inode_xattrs(d_inode(dentry));
+	ret = erofs_init_inode_xattrs(inode);
 	if (ret == -ENOATTR)
 		return 0;
 	if (ret)
@@ -603,11 +548,13 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
-	ret = inline_listxattr(&it);
-	if (ret >= 0 || ret == -ENOATTR)
-		ret = shared_listxattr(&it);
+	ret = erofs_iter_inline_xattr(&it, inode, false);
+	if (!ret || ret == -ENOATTR)
+		ret = erofs_iter_shared_xattr(&it, inode, false);
+	if (ret == -ENOATTR)
+		ret = 0;
 	erofs_put_metabuf(&it.buf);
-	return ret;
+	return ret ? ret : it.buffer_ofs;
 }
 
 void erofs_xattr_prefixes_cleanup(struct super_block *sb)
-- 
2.19.1.6.gb485710b

