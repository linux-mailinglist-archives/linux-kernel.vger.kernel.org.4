Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7B704E18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjEPMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjEPMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:50:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1FA3;
        Tue, 16 May 2023 05:50:10 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QLGHX326zzsR9F;
        Tue, 16 May 2023 20:48:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:50:07 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC 2/3] page_pool: support non-frag page for page_pool_alloc_frag()
Date:   Tue, 16 May 2023 20:48:00 +0800
Message-ID: <20230516124801.2465-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230516124801.2465-1-linyunsheng@huawei.com>
References: <20230516124801.2465-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is performance penalty with using page frag support when
user requests a larger frag size and a page only supports one
frag user, see [1].

It seems like user may request different frag size depending
on the mtu and packet size, provide an option to allocate
non-frag page when user has requested a frag size larger than
a specific size, so that user has a unified interface for the
memory allocation with least memory utilization and performance
penalty.

1. https://lore.kernel.org/netdev/ZEU+vospFdm08IeE@localhost.localdomain/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
---
 include/net/page_pool.h |  9 +++++++++
 net/core/page_pool.c    | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 14ac46297ae4..d1c57c0c8f49 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -163,6 +163,7 @@ struct page_pool {
 	unsigned int frag_offset;
 	struct page *frag_page;
 	long frag_users;
+	unsigned int max_frag_size;
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* these stats are incremented while in softirq context */
@@ -213,6 +214,14 @@ struct page_pool {
 	u64 destroy_cnt;
 };
 
+/* Called after page_pool_create() */
+static inline void page_pool_set_max_frag_size(struct page_pool *pool,
+					       unsigned int max_frag_size)
+{
+	pool->max_frag_size = min_t(unsigned int, max_frag_size,
+				    PAGE_SIZE << pool->p.order);
+}
+
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 
 static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5d93c5dc0549..aab6147f28af 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -198,6 +198,8 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
 		get_device(pool->p.dev);
 
+	page_pool_set_max_frag_size(pool, PAGE_SIZE << pool->p.order);
+
 	return 0;
 }
 
@@ -699,10 +701,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page = pool->frag_page;
 
-	if (WARN_ON(PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
-		    size > max_size))
+	if (WARN_ON(PAGE_POOL_DMA_USE_PP_FRAG_COUNT))
 		return NULL;
 
+	if (unlikely(size > pool->max_frag_size)) {
+		*offset = 0;
+		return page_pool_alloc_pages(pool, gfp);
+	}
+
 	size = ALIGN(size, dma_get_cache_alignment());
 	*offset = pool->frag_offset;
 
-- 
2.33.0

