Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD46CFE39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjC3I3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjC3I3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:29:16 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352A18C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:29:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VezocA0_1680164951;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VezocA0_1680164951)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:12 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] erofs: move several xattr helpers into xattr.c
Date:   Thu, 30 Mar 2023 16:29:03 +0800
Message-Id: <20230330082910.125374-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move xattrblock_addr() and xattrblock_offset() helpers into xattr.c,
as they are not used outside of xattr.c.

inlinexattr_header_size() has only one caller, and thus make it inlined
into the caller directly.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 48 +++++++++++++++++++++++++++++-------------------
 fs/erofs/xattr.h | 23 -----------------------
 2 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 459caa3cd65d..9ccd57581bc7 100644
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
@@ -562,20 +574,18 @@ static int shared_listxattr(struct listxattr_iter *it)
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
index f7a21aaa9755..a65158cba14f 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -13,29 +13,6 @@
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
-#ifdef CONFIG_EROFS_FS_XATTR
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
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
-- 
2.19.1.6.gb485710b

