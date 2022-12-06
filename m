Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE3643CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLFGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLFGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:04:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9856F26563
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CD22B81600
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A2FC433C1;
        Tue,  6 Dec 2022 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670306640;
        bh=a2DXxzn2tCMHvMeAX4+C+K/btZTLZZOQGTh6c8Fnjn0=;
        h=From:To:Cc:Subject:Date:From;
        b=uEVXx1qSx6SIB5uOnJZGJ71z0f97sOlkVleCJS5JphJVp6nSU77fnzTFVUGe8IYHn
         7svbYWpi6P3MnX1Glr3LTC5+xhfr3S348ZcpCtlQPOU9YAn43Ygo64jB6whsfyyjni
         H6/0Mf3b/A2UeOrDYhqyjAIlYaWh6y72Hs3z/fkDN33/6Ndrac3DT68MVSInHM19+M
         wAFrE67i2S05y04kbqZxPURgbvPo+DjNAibW2ymkTyfnoE78m/QiMs0765nMDChEGq
         aBW2jefgTZDVCeQYog/Ayx/nk9WAeuAsI1IFbmix68HGFwxtZPFmcwWFG4BIHj3Or7
         P8px9rwoXv5nA==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH v2] erofs: clean up cached I/O strategies
Date:   Tue,  6 Dec 2022 14:03:52 +0800
Message-Id: <20221206060352.152830-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

After commit 4c7e42552b3a ("erofs: remove useless cache strategy of
DELAYEDALLOC"), only one cached I/O allocation strategy is supported:

  When cached I/O is preferred, page allocation is applied without
  direct reclaim.  If allocation fails, fall back to inplace I/O.

Let's get rid of z_erofs_cache_alloctype.  No logical changes.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fold in Yue Hu's fix:
   https://lore.kernel.org/r/20221206053633.4251-1-zbestahu@gmail.com

 fs/erofs/zdata.c | 77 +++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b792d424d774..b66c16473273 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -175,16 +175,6 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/* how to allocate cached pages for a pcluster */
-enum z_erofs_cache_alloctype {
-	DONTALLOC,	/* don't allocate any cached pages */
-	/*
-	 * try to use cached I/O if page allocation succeeds or fallback
-	 * to in-place I/O instead to avoid any direct reclaim.
-	 */
-	TRYALLOC,
-};
-
 /*
  * tagged pointer with 1-bit tag for all compressed pages
  * tag 0 - the page is just found with an extra page reference
@@ -292,12 +282,29 @@ struct z_erofs_decompress_frontend {
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
 
+static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
+{
+	unsigned int cachestrategy = EROFS_I_SB(fe->inode)->opt.cache_strategy;
+
+	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
+		return false;
+
+	if (fe->backmost)
+		return true;
+
+	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
+	    fe->map.m_la < fe->headoffset)
+		return true;
+
+	return false;
+}
+
 static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
-			       enum z_erofs_cache_alloctype type,
 			       struct page **pagepool)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
+	bool shouldalloc = z_erofs_should_alloc_cache(fe);
 	bool standalone = true;
 	/*
 	 * optimistic allocation without direct reclaim since inplace I/O
@@ -326,18 +333,19 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
-			switch (type) {
-			case TRYALLOC:
-				newpage = erofs_allocpage(pagepool, gfp);
-				if (!newpage)
-					continue;
-				set_page_private(newpage,
-						 Z_EROFS_PREALLOCATED_PAGE);
-				t = tag_compressed_page_justfound(newpage);
-				break;
-			default:        /* DONTALLOC */
+			if (!shouldalloc)
 				continue;
-			}
+
+			/*
+			 * try to use cached I/O if page allocation
+			 * succeeds or fallback to in-place I/O instead
+			 * to avoid any direct reclaim.
+			 */
+			newpage = erofs_allocpage(pagepool, gfp);
+			if (!newpage)
+				continue;
+			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
+			t = tag_compressed_page_justfound(newpage);
 		}
 
 		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
@@ -637,20 +645,6 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	return true;
 }
 
-static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
-				       unsigned int cachestrategy,
-				       erofs_off_t la)
-{
-	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
-		return false;
-
-	if (fe->backmost)
-		return true;
-
-	return cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
-		la < fe->headoffset;
-}
-
 static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 				 struct page *page, unsigned int pageofs,
 				 unsigned int len)
@@ -687,12 +681,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page, struct page **pagepool)
 {
 	struct inode *const inode = fe->inode;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-
-	enum z_erofs_cache_alloctype cache_strategy;
 	unsigned int cur, end, spiltted;
 	int err = 0;
 
@@ -746,13 +737,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
-		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
-					       map->m_la))
-			cache_strategy = TRYALLOC;
-		else
-			cache_strategy = DONTALLOC;
-
-		z_erofs_bind_cache(fe, cache_strategy, pagepool);
+		z_erofs_bind_cache(fe, pagepool);
 	}
 hitted:
 	/*
-- 
2.30.2

