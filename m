Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED5714BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjE2OY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE2OYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:24:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749BAA0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:24:21 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QVHmh030kzLmPC;
        Mon, 29 May 2023 22:22:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 22:24:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH -next] mm: page_alloc: simplify has_managed_dma()
Date:   Mon, 29 May 2023 22:40:22 +0800
Message-ID: <20230529144022.42927-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ZONE_DMA should only exists on Node 0, only check NODE_DATA(0)
is enough, so simplify has_managed_dma() and make it inline.

Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mmzone.h | 21 +++++++++++----------
 mm/page_alloc.c        | 15 ---------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5a7ada0413da..48e9fd8eccb4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1503,16 +1503,6 @@ static inline int is_highmem(struct zone *zone)
 	return is_highmem_idx(zone_idx(zone));
 }
 
-#ifdef CONFIG_ZONE_DMA
-bool has_managed_dma(void);
-#else
-static inline bool has_managed_dma(void)
-{
-	return false;
-}
-#endif
-
-
 #ifndef CONFIG_NUMA
 
 extern struct pglist_data contig_page_data;
@@ -1527,6 +1517,17 @@ static inline struct pglist_data *NODE_DATA(int nid)
 
 #endif /* !CONFIG_NUMA */
 
+static inline bool has_managed_dma(void)
+{
+#ifdef CONFIG_ZONE_DMA
+	struct zone *zone = NODE_DATA(0)->node_zones + ZONE_DMA;
+
+	if (managed_zone(zone))
+		return true;
+#endif
+	return false;
+}
+
 extern struct pglist_data *first_online_pgdat(void);
 extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
 extern struct zone *next_zone(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e671c747892f..e847b39939b8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6613,18 +6613,3 @@ bool put_page_back_buddy(struct page *page)
 	return ret;
 }
 #endif
-
-#ifdef CONFIG_ZONE_DMA
-bool has_managed_dma(void)
-{
-	struct pglist_data *pgdat;
-
-	for_each_online_pgdat(pgdat) {
-		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
-
-		if (managed_zone(zone))
-			return true;
-	}
-	return false;
-}
-#endif /* CONFIG_ZONE_DMA */
-- 
2.35.3

