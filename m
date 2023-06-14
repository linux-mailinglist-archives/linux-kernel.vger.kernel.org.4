Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC0712E08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbjEZUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjEZUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:15:13 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B87189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:15:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN4F_1685132107;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN4F_1685132107)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:08 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/6] erofs: avoid on-stack pagepool directly passed by arguments
Date:   Sat, 27 May 2023 04:14:55 +0800
Message-Id: <20230526201459.128169-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
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

On-stack pagepool is used so that short-lived temporary pages could be
shared within a single I/O request (e.g. among multiple pclusters).

Moving the remaining frontend-related uses into
z_erofs_decompress_frontend to avoid too many arguments.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 64 +++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 59dc2537af00..a67f4ac19c48 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -240,13 +240,14 @@ static void z_erofs_bvec_iter_begin(struct z_erofs_bvec_iter *iter,
 
 static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 				struct z_erofs_bvec *bvec,
-				struct page **candidate_bvpage)
+				struct page **candidate_bvpage,
+				struct page **pagepool)
 {
 	if (iter->cur >= iter->nr) {
 		struct page *nextpage = *candidate_bvpage;
 
 		if (!nextpage) {
-			nextpage = alloc_page(GFP_NOFS);
+			nextpage = erofs_allocpage(pagepool, GFP_NOFS);
 			if (!nextpage)
 				return -ENOMEM;
 			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
@@ -549,6 +550,7 @@ struct z_erofs_decompress_frontend {
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
+	struct page *pagepool;
 	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl, *tailpcl;
 	z_erofs_next_pcluster_t owned_head;
@@ -583,8 +585,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 	return false;
 }
 
-static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
-			       struct page **pagepool)
+static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -625,7 +626,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			 * succeeds or fallback to in-place I/O instead
 			 * to avoid any direct reclaim.
 			 */
-			newpage = erofs_allocpage(pagepool, gfp);
+			newpage = erofs_allocpage(&fe->pagepool, gfp);
 			if (!newpage)
 				continue;
 			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
@@ -638,7 +639,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		if (page)
 			put_page(page);
 		else if (newpage)
-			erofs_pagepool_add(pagepool, newpage);
+			erofs_pagepool_add(&fe->pagepool, newpage);
 	}
 
 	/*
@@ -736,7 +737,8 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 		    !fe->candidate_bvpage)
 			fe->candidate_bvpage = bvec->page;
 	}
-	ret = z_erofs_bvec_enqueue(&fe->biter, bvec, &fe->candidate_bvpage);
+	ret = z_erofs_bvec_enqueue(&fe->biter, bvec, &fe->candidate_bvpage,
+				   &fe->pagepool);
 	fe->pcl->vcnt += (ret >= 0);
 	return ret;
 }
@@ -961,7 +963,7 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page, struct page **pagepool)
+				struct page *page)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
@@ -1019,7 +1021,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
-		z_erofs_bind_cache(fe, pagepool);
+		z_erofs_bind_cache(fe);
 	}
 hitted:
 	/*
@@ -1662,7 +1664,6 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 }
 
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
-				 struct page **pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg, bool readahead)
 {
@@ -1725,8 +1726,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		do {
 			struct page *page;
 
-			page = pickup_page_for_submission(pcl, i++, pagepool,
-							  mc);
+			page = pickup_page_for_submission(pcl, i++,
+					&f->pagepool, mc);
 			if (!page)
 				continue;
 
@@ -1791,16 +1792,16 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     struct page **pagepool, bool force_fg, bool ra)
+			     bool force_fg, bool ra)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, pagepool, io, &force_fg, ra);
+	z_erofs_submit_queue(f, io, &force_fg, ra);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
-	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
+	z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
 
 	if (!force_fg)
 		return;
@@ -1809,7 +1810,7 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
 	wait_for_completion_io(&io[JQ_SUBMIT].u.done);
 
 	/* handle synchronous decompress queue in the caller context */
-	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
+	z_erofs_decompress_queue(&io[JQ_SUBMIT], &f->pagepool);
 }
 
 /*
@@ -1817,8 +1818,7 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
  * approximate readmore strategies as a start.
  */
 static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
-				      struct readahead_control *rac,
-				      struct page **pagepool, bool backmost)
+		struct readahead_control *rac, bool backmost)
 {
 	struct inode *inode = f->inode;
 	struct erofs_map_blocks *map = &f->map;
@@ -1860,7 +1860,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page)) {
 				unlock_page(page);
 			} else {
-				err = z_erofs_do_read_page(f, page, pagepool);
+				err = z_erofs_do_read_page(f, page);
 				if (err)
 					erofs_err(inode->i_sb,
 						  "readmore error at page %lu @ nid %llu",
@@ -1881,27 +1881,24 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	struct inode *const inode = page->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *pagepool = NULL;
 	int err;
 
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	z_erofs_pcluster_readmore(&f, NULL, &pagepool, true);
-	err = z_erofs_do_read_page(&f, page, &pagepool);
-	z_erofs_pcluster_readmore(&f, NULL, &pagepool, false);
-
+	z_erofs_pcluster_readmore(&f, NULL, true);
+	err = z_erofs_do_read_page(&f, page);
+	z_erofs_pcluster_readmore(&f, NULL, false);
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, &pagepool, z_erofs_is_sync_decompress(sbi, 0),
-			 false);
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
 
 	erofs_put_metabuf(&f.map.buf);
-	erofs_release_pages(&pagepool);
+	erofs_release_pages(&f.pagepool);
 	return err;
 }
 
@@ -1910,12 +1907,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *pagepool = NULL, *head = NULL, *page;
+	struct page *head = NULL, *page;
 	unsigned int nr_pages;
 
 	f.headoffset = readahead_pos(rac);
 
-	z_erofs_pcluster_readmore(&f, rac, &pagepool, true);
+	z_erofs_pcluster_readmore(&f, rac, true);
 	nr_pages = readahead_count(rac);
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
@@ -1931,20 +1928,19 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		/* traversal in reverse order */
 		head = (void *)page_private(page);
 
-		err = z_erofs_do_read_page(&f, page, &pagepool);
+		err = z_erofs_do_read_page(&f, page);
 		if (err)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-	z_erofs_pcluster_readmore(&f, rac, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, rac, false);
 	(void)z_erofs_collector_end(&f);
 
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_is_sync_decompress(sbi, nr_pages), true);
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
-	erofs_release_pages(&pagepool);
+	erofs_release_pages(&f.pagepool);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.24.4

