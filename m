Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D2742547
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF2ME7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjF2MEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:04:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446263584;
        Thu, 29 Jun 2023 05:04:51 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QsHDC4S6JzTkrF;
        Thu, 29 Jun 2023 20:03:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:04:49 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v5 RFC 2/6] page_pool: unify frag_count handling in page_pool_is_last_frag()
Date:   Thu, 29 Jun 2023 20:02:22 +0800
Message-ID: <20230629120226.14854-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230629120226.14854-1-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when page_pool_create() is called with
PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
allowed to be called under the below constraints:
1. page_pool_fragment_page() need to be called to setup
   page->pp_frag_count immediately.
2. page_pool_defrag_page() often need to be called to drain
   the page->pp_frag_count when there is no more user will
   be holding on to that page.

Those constraints exist in order to support a page to be
split into multi frags.

And those constraints have some overhead because of the
cache line dirtying/bouncing and atomic update.

Those constraints are unavoidable for case when we need a
page to be split into more than one frag, but there is also
case that we want to avoid the above constraints and their
overhead when a page can't be split as it can only hold a big
frag as requested by user, depending on different use cases:
use case 1: allocate page without page splitting.
use case 2: allocate page with page splitting.
use case 3: allocate page with or without page splitting
            depending on the frag size.

Currently page pool only provide page_pool_alloc_pages() and
page_pool_alloc_frag() API to enable the 1 & 2 separately,
so we can not use a combination of 1 & 2 to enable 3, it is
not possible yet because of the per page_pool flag
PP_FLAG_PAGE_FRAG.

So in order to allow allocating unsplit page without the
overhead of split page while still allow allocating split
page we need to remove the per page_pool flag in
page_pool_is_last_frag(), as best as I can think of, it seems
there are two methods as below:
1. Add per page flag/bit to indicate a page is split or
   not, which means we might need to update that flag/bit
   everytime the page is recycled, dirtying the cache line
   of 'struct page' for use case 1.
2. Unify the page->pp_frag_count handling for both split and
   unsplit page by assuming all pages in the page pool is split
   into a big frag initially.

As page pool already supports use case 1 without dirtying the
cache line of 'struct page' whenever a page is recyclable, we
need to support the above use case 3 with minimal overhead,
especially not adding any noticeable overhead for use case 1,
and we are already doing an optimization by not updating
pp_frag_count in page_pool_defrag_page() for the last frag
user, this patch chooses to unify the pp_frag_count handling
to support the above use case 3.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h | 49 ++++++++++++++++++++++++++++++-----------
 net/core/page_pool.c    |  8 +++++++
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 83bd13491105..bbbdd584cb7f 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -323,7 +323,8 @@ void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
  */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
-	atomic_long_set(&page->pp_frag_count, nr);
+	if (!PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
+		atomic_long_set(&page->pp_frag_count, nr);
 }
 
 static inline long page_pool_defrag_page(struct page *page, long nr)
@@ -331,19 +332,43 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
 	long ret;
 
 	/* If nr == pp_frag_count then we have cleared all remaining
-	 * references to the page. No need to actually overwrite it, instead
-	 * we can leave this to be overwritten by the calling function.
+	 * references to the page:
+	 * 1. 'n == 1': no need to actually overwrite it.
+	 * 2. 'n != 1': overwrite it with one, which is the rare case
+	 *              for frag draining.
 	 *
-	 * The main advantage to doing this is that an atomic_read is
-	 * generally a much cheaper operation than an atomic update,
-	 * especially when dealing with a page that may be partitioned
-	 * into only 2 or 3 pieces.
+	 * The main advantage to doing this is that not only we avoid a
+	 * atomic update, as an atomic_read is generally a much cheaper
+	 * operation than an atomic update, especially when dealing with
+	 * a page that may be partitioned into only 2 or 3 pieces; but
+	 * also unify the frag and non-frag handling by ensuring all
+	 * pages have been split into one big frag initially, and only
+	 * overwrite it when the page is split into more than one frag.
 	 */
-	if (atomic_long_read(&page->pp_frag_count) == nr)
+	if (atomic_long_read(&page->pp_frag_count) == nr) {
+		/* As we have ensured nr is always one for constant case
+		 * using the BUILD_BUG_ON(), only need to handle the
+		 * non-constant case here for frag count draining, which
+		 * is a rare case.
+		 */
+		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
+		if (!__builtin_constant_p(nr))
+			atomic_long_set(&page->pp_frag_count, 1);
+
 		return 0;
+	}
 
 	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
 	WARN_ON(ret < 0);
+
+	/* We are the last user here too, reset frag count back to 1 to
+	 * ensure all pages have been split into one big frag initially,
+	 * this should be the rare case when the last two frag users call
+	 * page_pool_defrag_page() currently.
+	 */
+	if (unlikely(!ret))
+		atomic_long_set(&page->pp_frag_count, 1);
+
 	return ret;
 }
 
@@ -352,12 +377,10 @@ static inline bool page_pool_is_last_frag(struct page_pool *pool,
 {
 	/* We assume we are the last frag user that is still holding
 	 * on to the page if:
-	 * 1. Fragments aren't enabled.
-	 * 2. We are running in 32-bit arch with 64-bit DMA.
-	 * 3. page_pool_defrag_page() indicate we are the last user.
+	 * 1. We are running in 32-bit arch with 64-bit DMA.
+	 * 2. page_pool_defrag_page() indicate we are the last user.
 	 */
-	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
-	       PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
+	return PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
 	       (page_pool_defrag_page(page, 1) == 0);
 }
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9c4118c62997..69e3c5175236 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -352,6 +352,14 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 {
 	page->pp = pool;
 	page->pp_magic |= PP_SIGNATURE;
+
+	/* Ensuring all pages have been split into one big frag initially:
+	 * page_pool_set_pp_info() is only called once for every page when it
+	 * is allocated from the page allocator and page_pool_fragment_page()
+	 * is dirtying the same cache line as the page->pp_magic above, so
+	 * the overhead is negligible.
+	 */
+	page_pool_fragment_page(page, 1);
 	if (pool->p.init_callback)
 		pool->p.init_callback(page, pool->p.init_arg);
 }
-- 
2.33.0

