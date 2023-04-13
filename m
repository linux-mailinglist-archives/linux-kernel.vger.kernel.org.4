Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2126E0A12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjDMJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:22:51 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B82E9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:22:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vg-sT3G_1681377761;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg-sT3G_1681377761)
          by smtp.aliyun-inc.com;
          Thu, 13 Apr 2023 17:22:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: get rid of z_erofs_fill_inode()
Date:   Thu, 13 Apr 2023 17:22:41 +0800
Message-Id: <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
References: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
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

Prior to big pclusters, non-compact compression indexes could have
empty headers.

Let's just avoid the legacy path since it can be handled properly
as a specific compression header with z_erofs_fill_inode_lazy() too.

Tested with erofs-utils exist versions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fix up build errors without compression.

 fs/erofs/inode.c    | 12 ++++++++----
 fs/erofs/internal.h |  2 --
 fs/erofs/zmap.c     | 18 ------------------
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7ca9aafb7471..e196d453291b 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -291,11 +291,15 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+#ifdef CONFIG_EROFS_FS_ZIP
 		if (!erofs_is_fscache_mode(inode->i_sb) &&
-		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
-			err = z_erofs_fill_inode(inode);
-		else
-			err = -EOPNOTSUPP;
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
+			inode->i_mapping->a_ops = &z_erofs_aops;
+			err = 0;
+			goto out_unlock;
+		}
+#endif
+		err = -EOPNOTSUPP;
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f675050af2bb..f1268cb6a37c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -522,7 +522,6 @@ int erofs_try_to_free_cached_page(struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
-int z_erofs_fill_inode(struct inode *inode);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 #else
@@ -542,7 +541,6 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
-static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7ca108c3834c..14c21284d019 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,24 +7,6 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
-int z_erofs_fill_inode(struct inode *inode)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
-	if (!erofs_sb_has_big_pcluster(sbi) &&
-	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
-		vi->z_advise = 0;
-		vi->z_algorithmtype[0] = 0;
-		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = inode->i_sb->s_blocksize_bits;
-		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-	}
-	inode->i_mapping->a_ops = &z_erofs_aops;
-	return 0;
-}
-
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
-- 
2.24.4

