Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984545FBFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJLEvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLEvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:51:09 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06356792C1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:51:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VS-GD.8_1665550256;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VS-GD.8_1665550256)
          by smtp.aliyun-inc.com;
          Wed, 12 Oct 2022 12:51:01 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: shouldn't churn the mapping page for duplicated copies
Date:   Wed, 12 Oct 2022 12:50:56 +0800
Message-Id: <20221012045056.13421-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If other duplicated copies exist in one decompression shot, should
leave the old page as is rather than replace it with the new duplicated
one.  Otherwise, the following cold path to deal with duplicated copies
will use the invalid bvec.  It impacts compressed data deduplication.

Also, shift the onlinepage EIO bit to avoid touching the signed bit.

Fixes: 267f2492c8f7 ("erofs: introduce multi-reference pclusters (fully-referenced)")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 8 +++-----
 fs/erofs/zdata.h | 6 +++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..8d6ff8bcffdd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -887,15 +887,13 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 
 	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK)) {
 		unsigned int pgnr;
-		struct page *oldpage;
 
 		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
 		DBG_BUGON(pgnr >= be->nr_pages);
-		oldpage = be->decompressed_pages[pgnr];
-		be->decompressed_pages[pgnr] = bvec->page;
-
-		if (!oldpage)
+		if (!be->decompressed_pages[pgnr]) {
+			be->decompressed_pages[pgnr] = bvec->page;
 			return;
+		}
 	}
 
 	/* (cold path) one pcluster is requested multiple times */
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index e7f04c4fbb81..d98c95212985 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -126,10 +126,10 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 }
 
 /*
- * bit 31: I/O error occurred on this page
- * bit 0 - 30: remaining parts to complete this page
+ * bit 30: I/O error occurred on this page
+ * bit 0 - 29: remaining parts to complete this page
  */
-#define Z_EROFS_PAGE_EIO			(1 << 31)
+#define Z_EROFS_PAGE_EIO			(1 << 30)
 
 static inline void z_erofs_onlinepage_init(struct page *page)
 {
-- 
2.24.4

