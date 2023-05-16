Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A261704E19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjEPMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjEPMuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:50:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0B18E;
        Tue, 16 May 2023 05:50:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QLGDt3xBwzqSHC;
        Tue, 16 May 2023 20:45:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:50:09 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RFC 3/3] page_pool: introduce 'struct page_pool_frag'
Date:   Tue, 16 May 2023 20:48:01 +0800
Message-ID: <20230516124801.2465-4-linyunsheng@huawei.com>
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

As page_pool_alloc_frag() can return both frag and non-frag
page now, the true size may be different for them, so introduce
'struct page_pool_frag' to return the frag info instead of
adding more function parameters and adjust the interface
accordingly.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 16 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++--
 include/net/page_pool.h                       | 18 ++++++---
 net/core/page_pool.c                          | 38 +++++++++++++------
 4 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b676496ec6d7..b7290c3bb26b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3355,15 +3355,17 @@ static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
 	struct page *p;
 
 	if (ring->page_pool) {
-		p = page_pool_dev_alloc_frag(ring->page_pool,
-					     &cb->page_offset,
-					     hns3_buf_size(ring));
-		if (unlikely(!p))
+		struct page_pool_frag *pp_frag;
+
+		pp_frag = page_pool_dev_alloc_frag(ring->page_pool,
+						   hns3_buf_size(ring));
+		if (unlikely(!pp_frag))
 			return -ENOMEM;
 
-		cb->priv = p;
-		cb->buf = page_address(p);
-		cb->dma = page_pool_get_dma_addr(p);
+		cb->priv = pp_frag->page;
+		cb->page_offset = pp_frag->offset;
+		cb->buf = page_address(pp_frag->page);
+		cb->dma = page_pool_get_dma_addr(pp_frag->page);
 		cb->type = DESC_TYPE_PP_FRAG;
 		cb->reuse_flag = 0;
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..5d42081f7ba8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1453,13 +1453,14 @@ static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 static inline void *
 mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
 {
-	struct page *page;
+	struct page_pool_frag *pp_frag;
 
-	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
-	if (!page)
+	pp_frag = page_pool_dev_alloc_frag(q->page_pool, size);
+	if (!pp_frag)
 		return NULL;
 
-	return page_address(page) + *offset;
+	*offset = pp_frag->offset;
+	return page_address(pp_frag->page) + *offset;
 }
 
 static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index d1c57c0c8f49..86e79ea87732 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -151,6 +151,12 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 
 #endif
 
+struct page_pool_frag {
+	struct page *page;
+	unsigned int offset;
+	unsigned int truesize;
+};
+
 struct page_pool {
 	struct page_pool_params p;
 
@@ -231,16 +237,16 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-				  unsigned int size, gfp_t gfp);
+struct page_pool_frag *page_pool_alloc_frag(struct page_pool *pool,
+					    unsigned int size, gfp_t gfp);
 
-static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
-						    unsigned int *offset,
-						    unsigned int size)
+static inline
+struct page_pool_frag *page_pool_dev_alloc_frag(struct page_pool *pool,
+						unsigned int size)
 {
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
 
-	return page_pool_alloc_frag(pool, offset, size, gfp);
+	return page_pool_alloc_frag(pool, size, gfp);
 }
 
 /* get the stored dma direction. A driver might decide to treat this locally and
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index aab6147f28af..83a2a85d21bf 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -28,6 +28,8 @@
 
 #define BIAS_MAX	LONG_MAX
 
+static DEFINE_PER_CPU(struct page_pool_frag, pp_frag);
+
 #ifdef CONFIG_PAGE_POOL_STATS
 /* alloc_stat_inc is intended to be used in softirq context */
 #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
@@ -694,25 +696,31 @@ static void page_pool_free_frag(struct page_pool *pool)
 	page_pool_return_page(pool, page);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool,
-				  unsigned int *offset,
-				  unsigned int size, gfp_t gfp)
+struct page_pool_frag *page_pool_alloc_frag(struct page_pool *pool,
+					    unsigned int size,
+					    gfp_t gfp)
 {
+	struct page_pool_frag *frag = this_cpu_ptr(&pp_frag);
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page = pool->frag_page;
+	struct page *page;
 
 	if (WARN_ON(PAGE_POOL_DMA_USE_PP_FRAG_COUNT))
 		return NULL;
 
 	if (unlikely(size > pool->max_frag_size)) {
-		*offset = 0;
-		return page_pool_alloc_pages(pool, gfp);
+		frag->page = page_pool_alloc_pages(pool, gfp);
+		if (unlikely(!frag->page))
+			return NULL;
+
+		frag->offset = 0;
+		frag->truesize = max_size;
+		return frag;
 	}
 
+	page = pool->frag_page;
 	size = ALIGN(size, dma_get_cache_alignment());
-	*offset = pool->frag_offset;
 
-	if (page && *offset + size > max_size) {
+	if (page && pool->frag_offset + size > max_size) {
 		page = page_pool_drain_frag(pool, page);
 		if (page) {
 			alloc_stat_inc(pool, fast);
@@ -731,16 +739,22 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 
 frag_reset:
 		pool->frag_users = 1;
-		*offset = 0;
 		pool->frag_offset = size;
 		page_pool_fragment_page(page, BIAS_MAX);
-		return page;
+		frag->page = page;
+		frag->offset = 0;
+		frag->truesize = size;
+		return frag;
 	}
 
+	frag->page = page;
+	frag->truesize = size;
+	frag->offset = pool->frag_offset;
+
 	pool->frag_users++;
-	pool->frag_offset = *offset + size;
+	pool->frag_offset += size;
 	alloc_stat_inc(pool, fast);
-	return page;
+	return frag;
 }
 EXPORT_SYMBOL(page_pool_alloc_frag);
 
-- 
2.33.0

