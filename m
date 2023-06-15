Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481BA730FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbjFOGrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbjFOGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:46:36 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C11FC7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:44:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vl9PPnE_1686811462;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vl9PPnE_1686811462)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 14:44:23 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: clean up zmap.c
Date:   Thu, 15 Jun 2023 14:44:21 +0800
Message-Id: <20230615064421.103178-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230615063219.87466-1-hsiangkao@linux.alibaba.com>
References: <20230615063219.87466-1-hsiangkao@linux.alibaba.com>
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

Several trivial cleanups which aren't quite necessary to split:

 - Rename lcluster load functions as well as justify full indexes
   since they are typically used for global deduplication for
   compressed data;

 - Avoid unnecessary lines, comments for simplicity.

No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fix a build error of `lcn` in z_erofs_extent_lookback(). 

 fs/erofs/zmap.c | 69 +++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 920fb4dbc731..1909ddafd9c7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -22,8 +22,8 @@ struct z_erofs_maprecorder {
 	bool partialref;
 };
 
-static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					 unsigned long lcn)
+static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
+				      unsigned long lcn)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -226,8 +226,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					    unsigned long lcn, bool lookahead)
+static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
+					 unsigned long lcn, bool lookahead)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -277,23 +277,23 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					  unsigned int lcn, bool lookahead)
+static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
+					   unsigned int lcn, bool lookahead)
 {
-	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
-
-	if (datamode == EROFS_INODE_COMPRESSED_FULL)
-		return legacy_load_cluster_from_disk(m, lcn);
-
-	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
-		return compacted_load_cluster_from_disk(m, lcn, lookahead);
-
-	return -EINVAL;
+	switch (EROFS_I(m->inode)->datalayout) {
+	case EROFS_INODE_COMPRESSED_FULL:
+		return z_erofs_load_full_lcluster(m, lcn);
+	case EROFS_INODE_COMPRESSED_COMPACT:
+		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
+	struct super_block *sb = m->inode->i_sb;
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 
@@ -301,21 +301,15 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		unsigned long lcn = m->lcn - lookback_distance;
 		int err;
 
-		/* load extent head logical cluster if needed */
-		err = z_erofs_load_cluster_from_disk(m, lcn, false);
+		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 		if (err)
 			return err;
 
 		switch (m->type) {
 		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-			if (!m->delta[0]) {
-				erofs_err(m->inode->i_sb,
-					  "invalid lookback distance 0 @ nid %llu",
-					  vi->nid);
-				DBG_BUGON(1);
-				return -EFSCORRUPTED;
-			}
 			lookback_distance = m->delta[0];
+			if (!lookback_distance)
+				goto err_bogus;
 			continue;
 		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
 		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
@@ -324,16 +318,15 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
 		default:
-			erofs_err(m->inode->i_sb,
-				  "unknown type %u @ lcn %lu of nid %llu",
+			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
 				  m->type, lcn, vi->nid);
 			DBG_BUGON(1);
 			return -EOPNOTSUPP;
 		}
 	}
-
-	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
-		  vi->nid);
+err_bogus:
+	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
+		  lookback_distance, m->lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
@@ -365,7 +358,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if (m->compressedblks)
 		goto out;
 
-	err = z_erofs_load_cluster_from_disk(m, lcn, false);
+	err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 	if (err)
 		return err;
 
@@ -397,9 +390,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 			break;
 		fallthrough;
 	default:
-		erofs_err(m->inode->i_sb,
-			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
-			  lcn, vi->nid);
+		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
+			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -407,9 +399,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
-	erofs_err(m->inode->i_sb,
-		  "bogus CBLKCNT @ lcn %lu of nid %llu",
-		  lcn, vi->nid);
+	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
@@ -430,7 +420,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return 0;
 		}
 
-		err = z_erofs_load_cluster_from_disk(m, lcn, true);
+		err = z_erofs_load_lcluster_from_disk(m, lcn, true);
 		if (err)
 			return err;
 
@@ -477,7 +467,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
+	err = z_erofs_load_lcluster_from_disk(&m, initial_lcn, false);
 	if (err)
 		goto unmap_out;
 
@@ -535,8 +525,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
-		if (fragment &&
-		    vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
+		if (fragment && vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
 			vi->z_fragmentoff |= (u64)m.pblk << 32;
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
-- 
2.24.4

