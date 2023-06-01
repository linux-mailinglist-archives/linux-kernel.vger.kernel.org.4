Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7630171909B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjFACn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFACny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:43:54 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98012C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:43:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vk-8yUv_1685587428;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vk-8yUv_1685587428)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 10:43:49 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] erofs: convert erofs_read_metabuf() to erofs_bread() for xattr
Date:   Thu,  1 Jun 2023 10:43:42 +0800
Message-Id: <20230601024347.108469-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
References: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
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

buf->inode is constant once initialized during erofs_buf's lifetime.
Thus call erofs_init_metabuf() and erofs_bread() separately to avoid
the repetition of assigning buf->inode when iterating xattrs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index bbfe7ce170d2..d9e041d27a35 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -81,11 +81,12 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, sb);
 	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
+	it.kaddr = erofs_bread(&it.buf, it.blkaddr, EROFS_KMAP);
 	if (IS_ERR(it.kaddr)) {
 		ret = PTR_ERR(it.kaddr);
 		goto out_unlock;
@@ -109,8 +110,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != sb->s_blocksize);
 
-			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
-						      EROFS_KMAP);
+			it.kaddr = erofs_bread(&it.buf, ++it.blkaddr, EROFS_KMAP);
 			if (IS_ERR(it.kaddr)) {
 				kfree(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -156,8 +156,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 		return 0;
 
 	it->blkaddr += erofs_blknr(it->sb, it->ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
-				       EROFS_KMAP);
+	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	it->ofs = erofs_blkoff(it->sb, it->ofs);
@@ -181,8 +180,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 	it->blkaddr = erofs_blknr(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
-				       EROFS_KMAP);
+	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
@@ -403,8 +401,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 		xsid = vi->xattr_shared_xattrs[i];
 		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
 		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
-						  it->it.blkaddr, EROFS_KMAP);
+		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 
@@ -444,13 +441,14 @@ int erofs_getxattr(struct inode *inode, int index,
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
+	it.it.sb = inode->i_sb;
 	it.it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.it.buf, it.it.sb);
 	it.name.name = name;
 
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 
-	it.it.sb = inode->i_sb;
 	ret = inline_getxattr(inode, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(inode, &it);
@@ -608,8 +606,7 @@ static int shared_listxattr(struct listxattr_iter *it)
 		xsid = vi->xattr_shared_xattrs[i];
 		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
 		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
-						  it->it.blkaddr, EROFS_KMAP);
+		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 
@@ -632,14 +629,14 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	if (ret)
 		return ret;
 
+	it.it.sb = dentry->d_sb;
 	it.it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.it.buf, it.it.sb);
 	it.dentry = dentry;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
-	it.it.sb = dentry->d_sb;
-
 	ret = inline_listxattr(&it);
 	if (ret >= 0 || ret == -ENOATTR)
 		ret = shared_listxattr(&it);
-- 
2.19.1.6.gb485710b

