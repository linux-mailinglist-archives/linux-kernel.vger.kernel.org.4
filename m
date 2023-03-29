Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B76CD1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjC2Ft5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2Ftw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:49:52 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2D2698
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:49:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VevZ2.Q_1680068978;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VevZ2.Q_1680068978)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 13:49:46 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LMKL <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: tidy up EROFS on-disk naming
Date:   Wed, 29 Mar 2023 13:49:35 +0800
Message-Id: <20230329054935.78763-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Get rid of all "vle" (variable-length extents) expressions
   since they only expand overall name lengths unnecessarily;
 - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
 - Move on-disk directory definitions ahead of compression.

No actual logical change.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  84 +++++++++++++++-----------------
 fs/erofs/zmap.c     | 116 ++++++++++++++++++++++----------------------
 2 files changed, 95 insertions(+), 105 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 44876a97cabd..ce87225bec7c 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -82,32 +82,27 @@ struct erofs_super_block {
 };
 
 /*
- * erofs inode datalayout (i_format in on-disk inode):
+ * EROFS inode datalayout (i_format in on-disk inode):
  * 0 - uncompressed flat inode without tail-packing inline data:
- * inode, [xattrs], ... | ... | no-holed data
  * 1 - compressed inode with non-compact indexes:
- * inode, [xattrs], [map_header], extents ... | ...
  * 2 - uncompressed flat inode with tail-packing inline data:
- * inode, [xattrs], tailpacking data, ... | ... | no-holed data
  * 3 - compressed inode with compact indexes:
- * inode, [xattrs], map_header, extents ... | ...
  * 4 - chunk-based inode with (optional) multi-device support:
- * inode, [xattrs], chunk indexes ... | ...
  * 5~7 - reserved
  */
 enum {
 	EROFS_INODE_FLAT_PLAIN			= 0,
-	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_COMPRESSED_FULL		= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
-	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_COMPRESSED_COMPACT		= 3,
 	EROFS_INODE_CHUNK_BASED			= 4,
 	EROFS_INODE_DATALAYOUT_MAX
 };
 
 static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 {
-	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
-		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	return datamode == EROFS_INODE_COMPRESSED_COMPACT ||
+		datamode == EROFS_INODE_COMPRESSED_FULL;
 }
 
 /* bit definitions of inode i_format */
@@ -268,6 +263,22 @@ struct erofs_inode_chunk_index {
 	__le32 blkaddr;		/* start block address of this inode chunk */
 };
 
+/* dirent sorts in alphabet order, thus we can do binary search */
+struct erofs_dirent {
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
+} __packed;
+
+/*
+ * EROFS file types should match generic FT_* types and
+ * it seems no need to add BUILD_BUG_ONs since potential
+ * unmatchness will break other fses as well...
+ */
+
+#define EROFS_NAME_LEN      255
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -337,10 +348,8 @@ struct z_erofs_map_header {
 	__u8	h_clusterbits;
 };
 
-#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
-
 /*
- * Fixed-sized output compression on-disk logical cluster type:
+ * On-disk logical cluster type:
  *    0   - literal (uncompressed) lcluster
  *    1,3 - compressed lcluster (for HEAD lclusters)
  *    2   - compressed lcluster (for NONHEAD lclusters)
@@ -364,27 +373,27 @@ struct z_erofs_map_header {
  *        di_u.delta[1] = distance to the next HEAD lcluster
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
-	Z_EROFS_VLE_CLUSTER_TYPE_MAX
+	Z_EROFS_LCLUSTER_TYPE_PLAIN	= 0,
+	Z_EROFS_LCLUSTER_TYPE_HEAD1	= 1,
+	Z_EROFS_LCLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_LCLUSTER_TYPE_HEAD2	= 3,
+	Z_EROFS_LCLUSTER_TYPE_MAX
 };
 
-#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
-#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
+#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
+#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
-#define Z_EROFS_VLE_DI_PARTIAL_REF		(1 << 15)
+#define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
 
 /*
  * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
  * compressed block count of a compressed extent (in logical clusters, aka.
  * block count of a pcluster).
  */
-#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+#define Z_EROFS_LI_D0_CBLKCNT		(1 << 11)
 
-struct z_erofs_vle_decompressed_index {
+struct z_erofs_lcluster_index {
 	__le16 di_advise;
 	/* where to decompress in the head lcluster */
 	__le16 di_clusterofs;
@@ -401,25 +410,8 @@ struct z_erofs_vle_decompressed_index {
 	} di_u;
 };
 
-#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
-	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
-	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
-
-/* dirent sorts in alphabet order, thus we can do binary search */
-struct erofs_dirent {
-	__le64 nid;     /* node number */
-	__le16 nameoff; /* start offset of file name */
-	__u8 file_type; /* file type */
-	__u8 reserved;  /* reserved */
-} __packed;
-
-/*
- * EROFS file types should match generic FT_* types and
- * it seems no need to add BUILD_BUG_ONs since potential
- * unmatchness will break other fses as well...
- */
-
-#define EROFS_NAME_LEN      255
+#define Z_EROFS_FULL_INDEX_ALIGN(end)	\
+	(ALIGN(end, 8) + sizeof(struct z_erofs_map_header) + 8)
 
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
@@ -436,15 +428,15 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
-	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
+	BUILD_BUG_ON(sizeof(struct z_erofs_lcluster_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
 	/* keep in sync between 2 index structures for better extendibility */
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
-		     sizeof(struct z_erofs_vle_decompressed_index));
+		     sizeof(struct z_erofs_lcluster_index));
 	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
-	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
-		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
+		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
 		     fmh != cpu_to_le64(1ULL << 63) : 0);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ecbcae9b5494..cbd3f72c83e9 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -14,7 +14,7 @@ int z_erofs_fill_inode(struct inode *inode)
 
 	if (!erofs_sb_has_big_pcluster(sbi) &&
 	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -45,11 +45,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t pos =
-		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(erofs_iloc(inode) +
-				vi->inode_isize + vi->xattr_isize) +
-		lcn * sizeof(struct z_erofs_vle_decompressed_index);
-	struct z_erofs_vle_decompressed_index *di;
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(erofs_iloc(inode) +
+			vi->inode_isize + vi->xattr_isize) +
+			lcn * sizeof(struct z_erofs_lcluster_index);
+	struct z_erofs_lcluster_index *di;
 	unsigned int advise, type;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
@@ -57,33 +56,33 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 
-	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
 
 	advise = le16_to_cpu(di->di_advise);
-	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
-		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
 	switch (type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
-		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 					Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
 			m->compressedblks = m->delta[0] &
-				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+				~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
-		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+		if (advise & Z_EROFS_LI_PARTIAL_REF)
 			m->partialref = true;
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
@@ -121,13 +120,13 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
 		lo = decode_compactedbits(lclusterbits, lomask,
 					  in, encodebits * i, &type);
 
-		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			return d1;
 		++d1;
 	} while (++i < vcnt);
 
-	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
-	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
+	/* vcnt - 1 (Z_EROFS_LCLUSTER_TYPE_NONHEAD) item */
+	if (!(lo & Z_EROFS_LI_D0_CBLKCNT))
 		d1 += lo - 1;
 	return d1;
 }
@@ -165,19 +164,19 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	lo = decode_compactedbits(lclusterbits, lomask,
 				  in, encodebits * i, &type);
 	m->type = type;
-	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+	if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
 
 		/* figure out lookahead_distance: delta[1] if needed */
 		if (lookahead)
 			m->delta[1] = get_compacted_la_distance(lclusterbits,
 						encodebits, vcnt, in, i);
-		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+		if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!big_pcluster) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -191,9 +190,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		 */
 		lo = decode_compactedbits(lclusterbits, lomask,
 					  in, encodebits * (i - 1), &type);
-		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			lo = 0;
-		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
+		else if (lo & Z_EROFS_LI_D0_CBLKCNT)
 			lo = 1;
 		m->delta[0] = lo + 1;
 		return 0;
@@ -207,7 +206,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 				i -= lo;
 
 			if (i >= 0)
@@ -219,10 +218,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
-				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+				if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 					--i;
-					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+					nblk += lo & ~Z_EROFS_LI_D0_CBLKCNT;
 					continue;
 				}
 				/* bigpcluster shouldn't have plain d0 == 1 */
@@ -301,10 +300,10 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+	if (datamode == EROFS_INODE_COMPRESSED_FULL)
 		return legacy_load_cluster_from_disk(m, lcn);
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
 		return compacted_load_cluster_from_disk(m, lcn, lookahead);
 
 	return -EINVAL;
@@ -326,7 +325,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			return err;
 
 		switch (m->type) {
-		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 			if (!m->delta[0]) {
 				erofs_err(m->inode->i_sb,
 					  "invalid lookback distance 0 @ nid %llu",
@@ -336,9 +335,9 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			}
 			lookback_distance = m->delta[0];
 			continue;
-		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
@@ -367,15 +366,15 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	unsigned long lcn;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
 	DBG_BUGON(m->type != m->headtype);
 
-	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
+	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
-	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 		map->m_plen = 1ULL << lclusterbits;
 		return 0;
@@ -397,19 +396,19 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	 * BUG_ON in the debugging mode only for developers to notice that.
 	 */
 	DBG_BUGON(lcn == initial_lcn &&
-		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
 	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
 		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
 		if (m->compressedblks)
@@ -453,12 +452,12 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 		if (err)
 			return err;
 
-		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			DBG_BUGON(!m->delta[1] &&
 				  m->clusterofs != 1 << lclusterbits);
-		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
 			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
 				break;
@@ -477,8 +476,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 }
 
 static int z_erofs_do_map_blocks(struct inode *inode,
-				 struct erofs_map_blocks *map,
-				 int flags)
+				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
@@ -508,9 +506,9 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	end = (m.lcn + 1ULL) << lclusterbits;
 
 	switch (m.type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -535,7 +533,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 		fallthrough;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
@@ -556,7 +554,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
 		if (fragment &&
-		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		    vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
 			vi->z_fragmentoff |= (u64)m.pblk << 32;
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
@@ -572,7 +570,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 	}
 
-	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+	if (m.headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN) {
 		if (map->m_llen > map->m_plen) {
 			DBG_BUGON(1);
 			err = -EFSCORRUPTED;
@@ -584,7 +582,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		else
 			map->m_algorithmformat =
 				Z_EROFS_COMPRESSION_SHIFTED;
-	} else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
+	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
 		map->m_algorithmformat = vi->z_algorithmtype[1];
 	} else {
 		map->m_algorithmformat = vi->z_algorithmtype[0];
@@ -673,7 +671,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto out_put_metabuf;
 	}
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
-- 
2.24.4

