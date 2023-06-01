Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DC71909C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjFACn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFACnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:43:55 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1F8E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:43:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vk-3FxL_1685587430;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vk-3FxL_1685587430)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 10:43:50 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] erofs: enhance erofs_xattr_iter_fixup() helper
Date:   Thu,  1 Jun 2023 10:43:43 +0800
Message-Id: <20230601024347.108469-3-jefflexu@linux.alibaba.com>
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

Enhance erofs_xattr_iter_fixup() helper so that it could be reused in
the situation where it.ofs could not span the block boundary.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 73 ++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d9e041d27a35..0fd574e94c8b 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -29,6 +29,24 @@ struct xattr_iter {
 	unsigned int ofs;
 };
 
+static inline int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
+{
+	if (it->ofs < it->sb->s_blocksize)
+		return 0;
+
+	if (nospan && it->ofs != it->sb->s_blocksize) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	it->blkaddr += erofs_blknr(it->sb, it->ofs);
+	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
+	it->ofs = erofs_blkoff(it->sb, it->ofs);
+	return 0;
+}
+
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -80,6 +98,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 		goto out_unlock;
 	}
 
+	it.sb = sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
 	erofs_init_metabuf(&it.buf, sb);
 	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
@@ -106,18 +125,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= sb->s_blocksize) {
-			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != sb->s_blocksize);
-
-			it.kaddr = erofs_bread(&it.buf, ++it.blkaddr, EROFS_KMAP);
-			if (IS_ERR(it.kaddr)) {
-				kfree(vi->xattr_shared_xattrs);
-				vi->xattr_shared_xattrs = NULL;
-				ret = PTR_ERR(it.kaddr);
-				goto out_unlock;
-			}
-			it.ofs = 0;
+		ret = erofs_xattr_iter_fixup(&it, true);
+		if (ret) {
+			kfree(vi->xattr_shared_xattrs);
+			vi->xattr_shared_xattrs = NULL;
+			goto out_unlock;
 		}
 		vi->xattr_shared_xattrs[i] =
 			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
@@ -150,19 +162,6 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static inline int xattr_iter_fixup(struct xattr_iter *it)
-{
-	if (it->ofs < it->sb->s_blocksize)
-		return 0;
-
-	it->blkaddr += erofs_blknr(it->sb, it->ofs);
-	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	it->ofs = erofs_blkoff(it->sb, it->ofs);
-	return 0;
-}
-
 static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
@@ -199,7 +198,7 @@ static int xattr_foreach(struct xattr_iter *it,
 	int err;
 
 	/* 0. fixup blkaddr, ofs, ipage */
-	err = xattr_iter_fixup(it);
+	err = erofs_xattr_iter_fixup(it, false);
 	if (err)
 		return err;
 
@@ -234,14 +233,9 @@ static int xattr_foreach(struct xattr_iter *it,
 	processed = 0;
 
 	while (processed < entry.e_name_len) {
-		if (it->ofs >= it->sb->s_blocksize) {
-			DBG_BUGON(it->ofs > it->sb->s_blocksize);
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
-		}
+		err = erofs_xattr_iter_fixup(it, true);
+		if (err)
+			goto out;
 
 		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      entry.e_name_len - processed);
@@ -269,14 +263,9 @@ static int xattr_foreach(struct xattr_iter *it,
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= it->sb->s_blocksize) {
-			DBG_BUGON(it->ofs > it->sb->s_blocksize);
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
-		}
+		err = erofs_xattr_iter_fixup(it, true);
+		if (err)
+			goto out;
 
 		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      value_sz - processed);
-- 
2.19.1.6.gb485710b

