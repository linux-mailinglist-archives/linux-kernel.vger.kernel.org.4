Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688E66A877
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjANB6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjANB6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:58:40 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C68A200
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:58:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZWAugb_1673661494;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZWAugb_1673661494)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 09:58:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/2] erofs: cleanup erofs_iget()
Date:   Sat, 14 Jan 2023 09:58:11 +0800
Message-Id: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move inode hash function into inode.c and simplify erofs_iget().
No logic changes.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - use ino ^= nid >> sizeof(ino_t) * 8 as suggested by Jingbo.

 fs/erofs/inode.c    | 40 +++++++++++++++++++++-------------------
 fs/erofs/internal.h |  9 ---------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d3b8736fa124..f3b6782c6c53 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -308,47 +308,49 @@ static int erofs_fill_inode(struct inode *inode)
 }
 
 /*
- * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
- * we should do more for 32-bit platform to find the right inode.
+ * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
+ * so that it will fit.
  */
-static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
+static ino_t erofs_squash_ino(erofs_nid_t nid)
 {
-	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
+	ino_t ino = (ino_t)nid;
+
+	if (sizeof(ino_t) < sizeof(erofs_nid_t))
+		ino ^= nid >> sizeof(ino_t) * 8;
+	return ino;
+}
 
-	return EROFS_I(inode)->nid == nid;
+static int erofs_iget5_eq(struct inode *inode, void *opaque)
+{
+	return EROFS_I(inode)->nid == *(erofs_nid_t *)opaque;
 }
 
-static int erofs_iget_set_actor(struct inode *inode, void *opaque)
+static int erofs_iget5_set(struct inode *inode, void *opaque)
 {
 	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
 
-	inode->i_ino = erofs_inode_hash(nid);
+	inode->i_ino = erofs_squash_ino(nid);
+	EROFS_I(inode)->nid = nid;
 	return 0;
 }
 
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 {
-	const unsigned long hashval = erofs_inode_hash(nid);
 	struct inode *inode;
 
-	inode = iget5_locked(sb, hashval, erofs_ilookup_test_actor,
-		erofs_iget_set_actor, &nid);
+	inode = iget5_locked(sb, erofs_squash_ino(nid), erofs_iget5_eq,
+			     erofs_iget5_set, &nid);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
 	if (inode->i_state & I_NEW) {
-		int err;
-		struct erofs_inode *vi = EROFS_I(inode);
-
-		vi->nid = nid;
+		int err = erofs_fill_inode(inode);
 
-		err = erofs_fill_inode(inode);
-		if (!err) {
-			unlock_new_inode(inode);
-		} else {
+		if (err) {
 			iget_failed(inode);
-			inode = ERR_PTR(err);
+			return ERR_PTR(err);
 		}
+		unlock_new_inode(inode);
 	}
 	return inode;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index bb8501c0ff5b..168c21f16383 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -480,15 +480,6 @@ int erofs_map_blocks(struct inode *inode,
 		     struct erofs_map_blocks *map, int flags);
 
 /* inode.c */
-static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-{
-#if BITS_PER_LONG == 32
-	return (nid >> 32) ^ (nid & 0xffffffff);
-#else
-	return nid;
-#endif
-}
-
 extern const struct inode_operations erofs_generic_iops;
 extern const struct inode_operations erofs_symlink_iops;
 extern const struct inode_operations erofs_fast_symlink_iops;
-- 
2.24.4

