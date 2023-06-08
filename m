Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C5727EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjFHLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjFHLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:30:39 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F232726
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:30:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkeDeVy_1686223822;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkeDeVy_1686223822)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 19:30:23 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] erofs: unify xattr_iter structures
Date:   Thu,  8 Jun 2023 19:30:17 +0800
Message-Id: <20230608113020.66626-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
References: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify xattr_iter/listxattr_iter/getxattr_iter structures into
erofs_xattr_iter structure.

This is in preparation for the following further cleanup.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 154 ++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 88 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d9aaa8016eea..e9bc81846722 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -7,17 +7,27 @@
 #include <linux/security.h>
 #include "xattr.h"
 
-struct xattr_iter {
+struct erofs_xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
 	erofs_off_t pos;
 	void *kaddr;
+
+	char *buffer;
+	int buffer_size, buffer_ofs;
+
+	/* getxattr */
+	int index, infix_len;
+	struct qstr name;
+
+	/* listxattr */
+	struct dentry *dentry;
 };
 
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct xattr_iter it;
+	struct erofs_xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
 	struct super_block *sb = inode->i_sb;
@@ -121,15 +131,15 @@ static int erofs_init_inode_xattrs(struct inode *inode)
  *                            and need to be handled
  */
 struct xattr_iter_handlers {
-	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
-	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
+	int (*entry)(struct erofs_xattr_iter *it, struct erofs_xattr_entry *entry);
+	int (*name)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
 		    unsigned int len);
-	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
-	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
+	int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int value_sz);
+	void (*value)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
 		      unsigned int len);
 };
 
-static int inline_xattr_iter_begin(struct xattr_iter *it,
+static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
 				   struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -154,7 +164,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
  * Regardless of success or failure, `xattr_foreach' will end up with
  * `pos' pointing to the next xattr item rather than an arbitrary position.
  */
-static int xattr_foreach(struct xattr_iter *it,
+static int xattr_foreach(struct erofs_xattr_iter *it,
 			 const struct xattr_iter_handlers *op,
 			 unsigned int *tlimit)
 {
@@ -257,18 +267,10 @@ static int xattr_foreach(struct xattr_iter *it,
 	return err < 0 ? err : 0;
 }
 
-struct getxattr_iter {
-	struct xattr_iter it;
-
-	char *buffer;
-	int buffer_size, index, infix_len;
-	struct qstr name;
-};
-
-static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
 				       struct erofs_xattr_entry *entry)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
+	struct erofs_sb_info *sbi = EROFS_SB(it->sb);
 	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
 		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
@@ -286,11 +288,9 @@ static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
 	return 0;
 }
 
-static int xattr_entrymatch(struct xattr_iter *_it,
+static int xattr_entrymatch(struct erofs_xattr_iter *it,
 			    struct erofs_xattr_entry *entry)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	/* should also match the infix for long name prefixes */
 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
 		return erofs_xattr_long_entrymatch(it, entry);
@@ -302,32 +302,27 @@ static int xattr_entrymatch(struct xattr_iter *_it,
 	return 0;
 }
 
-static int xattr_namematch(struct xattr_iter *_it,
+static int xattr_namematch(struct erofs_xattr_iter *it,
 			   unsigned int processed, char *buf, unsigned int len)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
 		return -ENOATTR;
 	return 0;
 }
 
-static int xattr_checkbuffer(struct xattr_iter *_it,
+static int xattr_checkbuffer(struct erofs_xattr_iter *it,
 			     unsigned int value_sz)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 	int err = it->buffer_size < value_sz ? -ERANGE : 0;
 
 	it->buffer_size = value_sz;
 	return !it->buffer ? 1 : err;
 }
 
-static void xattr_copyvalue(struct xattr_iter *_it,
+static void xattr_copyvalue(struct erofs_xattr_iter *it,
 			    unsigned int processed,
 			    char *buf, unsigned int len)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	memcpy(it->buffer + processed, buf, len);
 }
 
@@ -338,41 +333,41 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
 	.value = xattr_copyvalue
 };
 
-static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
+static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 {
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(&it->it, inode);
+	ret = inline_xattr_iter_begin(it, inode);
 	if (ret < 0)
 		return ret;
 
 	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
+		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
 		if (ret != -ENOATTR)
 			break;
 	}
 	return ret ? ret : it->buffer_size;
 }
 
-static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
+static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = it->it.sb;
+	struct super_block *const sb = it->sb;
 	unsigned int i, xsid;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
-		it->it.pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
-				       xsid * sizeof(__u32);
-		it->it.kaddr = erofs_bread(&it->it.buf,
-				erofs_blknr(sb, it->it.pos), EROFS_KMAP);
-		if (IS_ERR(it->it.kaddr))
-			return PTR_ERR(it->it.kaddr);
-
-		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
+		it->pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
+				    xsid * sizeof(__u32);
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
 			break;
 	}
@@ -394,7 +389,7 @@ int erofs_getxattr(struct inode *inode, int index,
 		   void *buffer, size_t buffer_size)
 {
 	int ret;
-	struct getxattr_iter it;
+	struct erofs_xattr_iter it;
 
 	if (!name)
 		return -EINVAL;
@@ -404,22 +399,21 @@ int erofs_getxattr(struct inode *inode, int index,
 		return ret;
 
 	it.index = index;
-	it.name.len = strlen(name);
+	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
-	it.it.sb = inode->i_sb;
-	it.it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.it.buf, it.it.sb);
-	it.name.name = name;
-
+	it.sb = inode->i_sb;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sb);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
 
 	ret = inline_getxattr(inode, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(inode, &it);
-	erofs_put_metabuf(&it.it.buf);
+	erofs_put_metabuf(&it.buf);
 	return ret;
 }
 
@@ -465,25 +459,15 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
-struct listxattr_iter {
-	struct xattr_iter it;
-
-	struct dentry *dentry;
-	char *buffer;
-	int buffer_size, buffer_ofs;
-};
-
-static int xattr_entrylist(struct xattr_iter *_it,
+static int xattr_entrylist(struct erofs_xattr_iter *it,
 			   struct erofs_xattr_entry *entry)
 {
-	struct listxattr_iter *it =
-		container_of(_it, struct listxattr_iter, it);
 	unsigned int base_index = entry->e_name_index;
 	unsigned int prefix_len, infix_len = 0;
 	const char *prefix, *infix = NULL;
 
 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
-		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
+		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
@@ -515,23 +499,17 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	return 0;
 }
 
-static int xattr_namelist(struct xattr_iter *_it,
+static int xattr_namelist(struct erofs_xattr_iter *it,
 			  unsigned int processed, char *buf, unsigned int len)
 {
-	struct listxattr_iter *it =
-		container_of(_it, struct listxattr_iter, it);
-
 	memcpy(it->buffer + it->buffer_ofs, buf, len);
 	it->buffer_ofs += len;
 	return 0;
 }
 
-static int xattr_skipvalue(struct xattr_iter *_it,
+static int xattr_skipvalue(struct erofs_xattr_iter *it,
 			   unsigned int value_sz)
 {
-	struct listxattr_iter *it =
-		container_of(_it, struct listxattr_iter, it);
-
 	it->buffer[it->buffer_ofs++] = '\0';
 	return 1;
 }
@@ -543,42 +521,42 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
 	.value = NULL
 };
 
-static int inline_listxattr(struct listxattr_iter *it)
+static int inline_listxattr(struct erofs_xattr_iter *it)
 {
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(&it->it, d_inode(it->dentry));
+	ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
 	if (ret < 0)
 		return ret;
 
 	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
+		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
 		if (ret)
 			break;
 	}
 	return ret ? ret : it->buffer_ofs;
 }
 
-static int shared_listxattr(struct listxattr_iter *it)
+static int shared_listxattr(struct erofs_xattr_iter *it)
 {
 	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = it->it.sb;
+	struct super_block *const sb = it->sb;
 	unsigned int i, xsid;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
-		it->it.pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
-				       xsid * sizeof(__u32);
-		it->it.kaddr = erofs_bread(&it->it.buf,
-				erofs_blknr(sb, it->it.pos), EROFS_KMAP);
-		if (IS_ERR(it->it.kaddr))
-			return PTR_ERR(it->it.kaddr);
-
-		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
+		it->pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
+				    xsid * sizeof(__u32);
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
 		if (ret)
 			break;
 	}
@@ -589,7 +567,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 			char *buffer, size_t buffer_size)
 {
 	int ret;
-	struct listxattr_iter it;
+	struct erofs_xattr_iter it;
 
 	ret = erofs_init_inode_xattrs(d_inode(dentry));
 	if (ret == -ENOATTR)
@@ -597,9 +575,9 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	if (ret)
 		return ret;
 
-	it.it.sb = dentry->d_sb;
-	it.it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.it.buf, it.it.sb);
+	it.sb = dentry->d_sb;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sb);
 	it.dentry = dentry;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
@@ -608,7 +586,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	ret = inline_listxattr(&it);
 	if (ret >= 0 || ret == -ENOATTR)
 		ret = shared_listxattr(&it);
-	erofs_put_metabuf(&it.it.buf);
+	erofs_put_metabuf(&it.buf);
 	return ret;
 }
 
-- 
2.19.1.6.gb485710b

