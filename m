Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4006E1E50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDNIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjDNIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:30:41 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937877ECD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:30:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vg2zKUI_1681461028;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg2zKUI_1681461028)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 16:30:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: sunset erofs_dbg()
Date:   Fri, 14 Apr 2023 16:30:26 +0800
Message-Id: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such debug messages are rarely used now.  Let's get rid of these,
and revert locally if they are needed for debugging.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    | 3 ---
 fs/erofs/internal.h | 2 --
 fs/erofs/namei.c    | 9 +++------
 fs/erofs/zdata.c    | 5 -----
 fs/erofs/zmap.c     | 3 ---
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e196d453291b..d70b12b81507 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -26,9 +26,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	blkaddr = erofs_blknr(sb, inode_loc);
 	*ofs = erofs_blkoff(sb, inode_loc);
 
-	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
-		  __func__, vi->nid, *ofs, blkaddr);
-
 	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f1268cb6a37c..6c8c0504032e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -31,10 +31,8 @@ __printf(3, 4) void _erofs_info(struct super_block *sb,
 #define erofs_info(sb, fmt, ...) \
 	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
 #ifdef CONFIG_EROFS_FS_DEBUG
-#define erofs_dbg(x, ...)       pr_debug(x "\n", ##__VA_ARGS__)
 #define DBG_BUGON               BUG_ON
 #else
-#define erofs_dbg(x, ...)       ((void)0)
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 43096bac4c99..d4f631d39f0f 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -205,16 +205,13 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 
 	err = erofs_namei(dir, &dentry->d_name, &nid, &d_type);
 
-	if (err == -ENOENT) {
+	if (err == -ENOENT)
 		/* negative dentry */
 		inode = NULL;
-	} else if (err) {
+	else if (err)
 		inode = ERR_PTR(err);
-	} else {
-		erofs_dbg("%s, %pd (nid %llu) found, d_type %u", __func__,
-			  dentry, nid, d_type);
+	else
 		inode = erofs_iget(dir->i_sb, nid);
-	}
 	return d_splice_alias(inode, dentry);
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 34944e400037..45f21db2303a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -979,8 +979,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	if (offset + cur < map->m_la ||
 	    offset + cur >= map->m_la + map->m_llen) {
-		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
-
 		if (z_erofs_collector_end(fe))
 			fe->backmost = false;
 		map->m_la = offset + cur;
@@ -1105,9 +1103,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		z_erofs_page_mark_eio(page);
 	z_erofs_onlinepage_endio(page);
-
-	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
-		  __func__, page, spiltted, map->m_llen);
 	return err;
 }
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14c21284d019..d37c5c89c728 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -585,9 +585,6 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 
 unmap_out:
 	erofs_unmap_metabuf(&m.map->buf);
-	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		  __func__, map->m_la, map->m_pa,
-		  map->m_llen, map->m_plen, map->m_flags);
 	return err;
 }
 
-- 
2.24.4

