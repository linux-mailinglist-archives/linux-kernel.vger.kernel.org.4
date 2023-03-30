Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850E86CFE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjC3I3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjC3I3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:29:19 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35375B92
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:29:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vezs-DU_1680164954;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vezs-DU_1680164954)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:15 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] erofs: introduce erofs_xattr_iter_fixup_aligned() helper
Date:   Thu, 30 Mar 2023 16:29:06 +0800
Message-Id: <20230330082910.125374-5-jefflexu@linux.alibaba.com>
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

Introduce erofs_xattr_iter_fixup_aligned() helper where
it.ofs <= EROFS_BLKSIZ is mandatory.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 76 ++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d76b74ece2e5..f77d938613cc 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -29,6 +29,25 @@ struct xattr_iter {
 	unsigned int ofs;
 };
 
+static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
+{
+	if (it->ofs < it->sb->s_blocksize)
+		return 0;
+
+	it->blkaddr += erofs_blknr(it->sb, it->ofs);
+	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr, EROFS_KMAP);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
+	it->ofs = erofs_blkoff(it->sb, it->ofs);
+	return 0;
+}
+
+static inline int erofs_xattr_iter_fixup_aligned(struct xattr_iter *it)
+{
+	DBG_BUGON(it->ofs > it->sb->s_blocksize);
+	return erofs_xattr_iter_fixup(it);
+}
+
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -80,6 +99,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 		goto out_unlock;
 	}
 
+	it.sb = sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
 	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
@@ -105,19 +125,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= sb->s_blocksize) {
-			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != sb->s_blocksize);
-
-			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
-						      EROFS_KMAP);
-			if (IS_ERR(it.kaddr)) {
-				kfree(vi->xattr_shared_xattrs);
-				vi->xattr_shared_xattrs = NULL;
-				ret = PTR_ERR(it.kaddr);
-				goto out_unlock;
-			}
-			it.ofs = 0;
+		ret = erofs_xattr_iter_fixup_aligned(&it);
+		if (ret) {
+			kfree(vi->xattr_shared_xattrs);
+			vi->xattr_shared_xattrs = NULL;
+			goto out_unlock;
 		}
 		vi->xattr_shared_xattrs[i] =
 			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
@@ -150,20 +162,6 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static inline int xattr_iter_fixup(struct xattr_iter *it)
-{
-	if (it->ofs < it->sb->s_blocksize)
-		return 0;
-
-	it->blkaddr += erofs_blknr(it->sb, it->ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
-				       EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	it->ofs = erofs_blkoff(it->sb, it->ofs);
-	return 0;
-}
-
 static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
@@ -201,7 +199,7 @@ static int xattr_foreach(struct xattr_iter *it,
 	int err;
 
 	/* 0. fixup blkaddr, ofs, ipage */
-	err = xattr_iter_fixup(it);
+	err = erofs_xattr_iter_fixup(it);
 	if (err)
 		return err;
 
@@ -236,14 +234,9 @@ static int xattr_foreach(struct xattr_iter *it,
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
+		err = erofs_xattr_iter_fixup_aligned(it);
+		if (err)
+			goto out;
 
 		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      entry.e_name_len - processed);
@@ -271,14 +264,9 @@ static int xattr_foreach(struct xattr_iter *it,
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
+		err = erofs_xattr_iter_fixup_aligned(it);
+		if (err)
+			goto out;
 
 		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      value_sz - processed);
-- 
2.19.1.6.gb485710b

