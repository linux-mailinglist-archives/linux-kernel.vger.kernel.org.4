Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9F70B3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 05:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEVDkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 23:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEVDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 23:39:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF6B9;
        Sun, 21 May 2023 20:39:28 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QPjH42sWXz18KbB;
        Mon, 22 May 2023 11:14:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 11:19:06 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net] page_pool: fix inconsistency for page_pool_ring_[un]lock()
Date:   Mon, 22 May 2023 11:17:14 +0800
Message-ID: <20230522031714.5089-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

page_pool_ring_[un]lock() use in_softirq() to decide which
spin lock variant to use, and when they are called in the
context with in_softirq() being false, spin_lock_bh() is
called in page_pool_ring_lock() while spin_unlock() is
called in page_pool_ring_unlock(), because spin_lock_bh()
has disabled the softirq in page_pool_ring_lock(), which
causes inconsistency for spin lock pair calling.

This patch fixes it by returning in_softirq state from
page_pool_producer_lock(), and use it to decide which
spin lock variant to use in page_pool_producer_unlock().

As pool->ring has both producer and consumer lock, so
rename it to page_pool_producer_[un]lock() to reflect
the actual usage. Also move them to page_pool.c as they
are only used there, and remove the 'inline' as the
compiler may have better idea to do inlining or not.

Fixes: 7886244736a4 ("net: page_pool: Add bulk support for ptr_ring")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool.h | 18 ------------------
 net/core/page_pool.c    | 28 ++++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index c8ec2f34722b..126f9e294389 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -399,22 +399,4 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
-static inline void page_pool_ring_lock(struct page_pool *pool)
-	__acquires(&pool->ring.producer_lock)
-{
-	if (in_softirq())
-		spin_lock(&pool->ring.producer_lock);
-	else
-		spin_lock_bh(&pool->ring.producer_lock);
-}
-
-static inline void page_pool_ring_unlock(struct page_pool *pool)
-	__releases(&pool->ring.producer_lock)
-{
-	if (in_softirq())
-		spin_unlock(&pool->ring.producer_lock);
-	else
-		spin_unlock_bh(&pool->ring.producer_lock);
-}
-
 #endif /* _NET_PAGE_POOL_H */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e212e9d7edcb..a3e12a61d456 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -134,6 +134,29 @@ EXPORT_SYMBOL(page_pool_ethtool_stats_get);
 #define recycle_stat_add(pool, __stat, val)
 #endif
 
+static bool page_pool_producer_lock(struct page_pool *pool)
+	__acquires(&pool->ring.producer_lock)
+{
+	bool in_softirq = in_softirq();
+
+	if (in_softirq)
+		spin_lock(&pool->ring.producer_lock);
+	else
+		spin_lock_bh(&pool->ring.producer_lock);
+
+	return in_softirq;
+}
+
+static void page_pool_producer_unlock(struct page_pool *pool,
+				      bool in_softirq)
+	__releases(&pool->ring.producer_lock)
+{
+	if (in_softirq)
+		spin_unlock(&pool->ring.producer_lock);
+	else
+		spin_unlock_bh(&pool->ring.producer_lock);
+}
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
@@ -617,6 +640,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count)
 {
 	int i, bulk_len = 0;
+	bool in_softirq;
 
 	for (i = 0; i < count; i++) {
 		struct page *page = virt_to_head_page(data[i]);
@@ -635,7 +659,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		return;
 
 	/* Bulk producer into ptr_ring page_pool cache */
-	page_pool_ring_lock(pool);
+	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, data[i])) {
 			/* ring full */
@@ -644,7 +668,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		}
 	}
 	recycle_stat_add(pool, ring, i);
-	page_pool_ring_unlock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages was return into ptr_ring */
 	if (likely(i == bulk_len))
-- 
2.33.0

