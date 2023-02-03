Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40151688E43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCDxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjBCDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:53:10 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0148233CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:53:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Van4Hcy_1675396385;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Van4Hcy_1675396385)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:53:06 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] erofs: call erofs_map_dev() inside erofs_map_blocks()
Date:   Fri,  3 Feb 2023 11:53:03 +0800
Message-Id: <20230203035303.35082-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
References: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now erofs_map_blocks() is always followed by erofs_map_dev().
Make erofs_map_dev() called inside erofs_map_blocks() to reduce code
duplication.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 21 ++++++++++-----------
 fs/erofs/fscache.c  | 20 ++------------------
 fs/erofs/internal.h |  3 ++-
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 32e66d29968f..cbe7a6d6846d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -116,7 +116,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return 0;
 }
 
-int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map,
+		     struct erofs_map_dev *mdev)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -188,8 +189,14 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 out_unlock:
 	erofs_put_metabuf(&buf);
 out:
-	if (!err)
+	if (!err) {
 		map->m_llen = map->m_plen;
+		*mdev = (struct erofs_map_dev) {
+			.m_deviceid = map->m_deviceid,
+			.m_pa = map->m_pa,
+		};
+		err = erofs_map_dev(sb, mdev);
+	}
 	trace_erofs_map_blocks_exit(inode, map, EROFS_GET_BLOCKS_RAW, err);
 	return err;
 }
@@ -253,15 +260,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_la = offset;
 	map.m_llen = length;
 
-	ret = erofs_map_blocks(inode, &map);
-	if (ret < 0)
-		return ret;
-
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(inode->i_sb, &mdev);
+	ret = erofs_map_blocks(inode, &map, &mdev);
 	if (ret)
 		return ret;
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7f1ef2ffc4db..140ccacc1043 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -229,7 +229,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	int ret;
 
 	map.m_la = pos;
-	ret = erofs_map_blocks(inode, &map);
+	ret = erofs_map_blocks(inode, &map, &mdev);
 	if (ret)
 		return ret;
 
@@ -270,14 +270,6 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
 	DBG_BUGON(!count || count % PAGE_SIZE);
 
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(sb, &mdev);
-	if (ret)
-		return ret;
-
 	req = erofs_fscache_req_chain(primary, count);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -377,15 +369,7 @@ static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
 	struct file *realfile;
 	int ret;
 
-	ret = erofs_map_blocks(inode, &map);
-	if (ret)
-		return ret;
-
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(inode->i_sb, &mdev);
+	ret = erofs_map_blocks(inode, &map, &mdev);
 	if (ret)
 		return ret;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 323c2c775023..c54dec32a868 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -502,7 +502,8 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
-int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map,
+		     struct erofs_map_dev *mdev);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-- 
2.19.1.6.gb485710b

