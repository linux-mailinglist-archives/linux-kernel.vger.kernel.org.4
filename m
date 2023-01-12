Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46F666C44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbjALITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbjALIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:17:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE23724A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:17:37 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nsy6k50gwz16MZK;
        Thu, 12 Jan 2023 16:15:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 16:17:34 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 7/7] mm: swap: remove unneeded cgroup_throttle_swaprate()
Date:   Thu, 12 Jan 2023 16:30:06 +0800
Message-ID: <20230112083006.163393-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers of cgroup_throttle_swaprate() are converted to
folio_throttle_swaprate(), so make __cgroup_throttle_swaprate()
to take a folio, and drop unused cgroup_throttle_swaprate().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/swap.h | 12 ++++--------
 mm/swapfile.c        |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 209a425739a9..2674408e6d63 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -641,22 +641,18 @@ extern atomic_t zswap_stored_pages;
 #endif
 
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-extern void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
-static inline  void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
+extern void __cgroup_throttle_swaprate(struct folio *folio, gfp_t gfp_mask);
+static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp_mask)
 {
 	if (mem_cgroup_disabled())
 		return;
-	__cgroup_throttle_swaprate(page, gfp_mask);
+	__cgroup_throttle_swaprate(folio, gfp_mask);
 }
 #else
-static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
+static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp_mask)
 {
 }
 #endif
-static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
-{
-	cgroup_throttle_swaprate(&folio->page, gfp);
-}
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a5729273480e..3abf514c3f28 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3636,10 +3636,10 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 }
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
+void __cgroup_throttle_swaprate(struct folio *folio, gfp_t gfp_mask)
 {
 	struct swap_info_struct *si, *next;
-	int nid = page_to_nid(page);
+	int nid = folio_nid(folio);
 
 	if (!(gfp_mask & __GFP_IO))
 		return;
-- 
2.35.3

