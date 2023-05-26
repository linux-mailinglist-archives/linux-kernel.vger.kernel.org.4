Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA0712E05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbjEZUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEZUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:15:11 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF417134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:15:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN3g_1685132106;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN3g_1685132106)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:07 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/6] erofs: allocate extra bvec pages directly instead of retrying
Date:   Sat, 27 May 2023 04:14:54 +0800
Message-Id: <20230526201459.128169-2-hsiangkao@linux.alibaba.com>
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

If non-bootstrap bvecs cannot be kept in place (very rarely), an extra
short-lived page is allocated.

Let's just allocate it immediately rather than do unnecessary -EAGAIN
return first and retry as a cleanup.  Also it's unnecessary to use
__GFP_NOFAIL here since we could gracefully fail out this case instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
no change.

 fs/erofs/zdata.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1de6c84285a6..59dc2537af00 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -242,12 +242,17 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 				struct z_erofs_bvec *bvec,
 				struct page **candidate_bvpage)
 {
-	if (iter->cur == iter->nr) {
-		if (!*candidate_bvpage)
-			return -EAGAIN;
-
+	if (iter->cur >= iter->nr) {
+		struct page *nextpage = *candidate_bvpage;
+
+		if (!nextpage) {
+			nextpage = alloc_page(GFP_NOFS);
+			if (!nextpage)
+				return -ENOMEM;
+			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
+		}
 		DBG_BUGON(iter->bvset->nextpage);
-		iter->bvset->nextpage = *candidate_bvpage;
+		iter->bvset->nextpage = nextpage;
 		z_erofs_bvset_flip(iter);
 
 		iter->bvset->nextpage = NULL;
@@ -908,10 +913,8 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	z_erofs_bvec_iter_end(&fe->biter);
 	mutex_unlock(&pcl->lock);
 
-	if (fe->candidate_bvpage) {
-		DBG_BUGON(z_erofs_is_shortlived_page(fe->candidate_bvpage));
+	if (fe->candidate_bvpage)
 		fe->candidate_bvpage = NULL;
-	}
 
 	/*
 	 * if all pending pages are added, don't hold its reference
@@ -1056,24 +1059,13 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
-retry:
 	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
 					.page = page,
 					.offset = offset - map->m_la,
 					.end = end,
 				  }), exclusive);
-	/* should allocate an additional short-lived page for bvset */
-	if (err == -EAGAIN && !fe->candidate_bvpage) {
-		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
-		set_page_private(fe->candidate_bvpage,
-				 Z_EROFS_SHORTLIVED_PAGE);
-		goto retry;
-	}
-
-	if (err) {
-		DBG_BUGON(err == -EAGAIN && fe->candidate_bvpage);
+	if (err)
 		goto out;
-	}
 
 	z_erofs_onlinepage_split(page);
 	/* bump up the number of spiltted parts of a page */
-- 
2.24.4

