Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5956DAB95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjDGKor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjDGKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:44:45 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95D8A6B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:44:41 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 337AgViW016377;
        Fri, 7 Apr 2023 18:42:32 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 7 Apr 2023 18:42:28 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH] mm: introduce defer free for cma
Date:   Fri, 7 Apr 2023 18:42:11 +0800
Message-ID: <1680864131-4675-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 337AgViW016377
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Continues page blocks are expensive for the system. Introducing defer free
mechanism to buffer some which make the allocation easier. The shrinker will
ensure the page block can be reclaimed when there is memory pressure.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/cma.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/cma.h |  11 +++++
 2 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 4a978e0..ad67ae5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -153,6 +153,20 @@ static int __init cma_init_reserved_areas(void)
 }
 core_initcall(cma_init_reserved_areas);
 
+static unsigned long cma_free_get(struct cma *cma)
+{
+	unsigned long used;
+	unsigned long val;
+
+	spin_lock_irq(&cma->lock);
+	/* pages counter is smaller than sizeof(int) */
+	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
+	val = cma->count - (u64)used << cma->order_per_bit;
+	spin_unlock_irq(&cma->lock);
+
+	return val;
+}
+
 void __init cma_reserve_pages_on_error(struct cma *cma)
 {
 	cma->reserve_pages_on_error = true;
@@ -411,6 +425,46 @@ static void cma_debug_show_areas(struct cma *cma)
 static inline void cma_debug_show_areas(struct cma *cma) { }
 #endif
 
+static int cma_defer_area_fetch(struct cma *cma, unsigned long pfn,
+		unsigned long count)
+{
+	struct cma_defer_free_area *area;
+	unsigned long new_pfn;
+	int ret = -1;
+
+	if (!atomic64_read(&cma->defer_count))
+		return ret;
+	if (count <= atomic64_read(&cma->defer_count)) {
+		spin_lock_irq(&cma->lock);
+		list_for_each_entry(area, &cma->defer_free, list) {
+			/*area found for given pfn and count*/
+			if (pfn >= area->pfn && count <= area->count) {
+				list_del(&area->list);
+				/*set bits for allocated pfn*/
+				bitmap_set(cma->bitmap, pfn - cma->base_pfn, count);
+				kfree(area);
+				atomic64_sub(count, &cma->defer_count);
+				/*release the rest pfn to cma*/
+				if (!list_empty(&cma->defer_free) && (pfn == area->pfn)) {
+					new_pfn = pfn + count;
+					cma_release(cma, pfn_to_page(new_pfn), area->count - count);
+				}
+				ret = 0;
+				spin_unlock_irq(&cma->lock);
+				return ret;
+			}
+		}
+	}
+	/*no area found, release all to buddy*/
+	list_for_each_entry(area, &cma->defer_free, list) {
+		list_del(&area->list);
+		free_contig_range(area->pfn, area->count);
+		cma_clear_bitmap(cma, area->pfn, area->count);
+		kfree(area);
+	}
+	spin_unlock_irq(&cma->lock);
+	return ret;
+}
 /**
  * cma_alloc() - allocate pages from contiguous area
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -469,9 +523,11 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		spin_unlock_irq(&cma->lock);
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
+
 		mutex_lock(&cma_mutex);
-		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
-				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
+		/*search for defer area first*/
+		ret = cma_defer_area_fetch(cma, pfn, count) ? alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
+				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0)) : 0;
 		mutex_unlock(&cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
@@ -556,6 +612,8 @@ bool cma_release(struct cma *cma, const struct page *pages,
 		 unsigned long count)
 {
 	unsigned long pfn;
+	unsigned long flags;
+	struct cma_defer_free_area *defer_area;
 
 	if (!cma_pages_valid(cma, pages, count))
 		return false;
@@ -566,7 +624,21 @@ bool cma_release(struct cma *cma, const struct page *pages,
 
 	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
 
-	free_contig_range(pfn, count);
+	if (cma->batch) {
+		defer_area = kmalloc(sizeof(struct cma_defer_free_area), GFP_KERNEL);
+		if (defer_area) {
+			defer_area->pfn = pfn;
+			defer_area->count = count;
+			spin_lock_irqsave(&cma->lock, flags);
+			list_add(&defer_area->list, &cma->defer_free);
+			atomic64_add(count, &cma->defer_count);
+			spin_unlock_irqrestore(&cma->lock, flags);
+			cma_clear_bitmap(cma, pfn, count);
+			return true;
+		}
+	}
+	else
+		free_contig_range(pfn, count);
 	cma_clear_bitmap(cma, pfn, count);
 	trace_cma_release(cma->name, pfn, pages, count);
 
@@ -586,3 +658,91 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+static unsigned long cma_defer_free_count(struct shrinker *shrinker,
+					struct shrink_control *sc)
+{
+	struct cma *cma = container_of(shrinker, struct cma, shrinker);
+	unsigned long val;
+
+	val = atomic64_read(&cma->defer_count);
+	return val;
+}
+
+static unsigned long cma_defer_free_scan(struct shrinker *shrinker,
+					struct shrink_control *sc)
+{
+	struct cma *cma = container_of(shrinker, struct cma, shrinker);
+	unsigned long to_scan;
+	struct cma_defer_free_area *area;
+	unsigned long new_pfn;
+	unsigned long defer_count;
+
+	if (sc->nr_to_scan < cma->batch)
+		return 0;
+
+	to_scan = cma->batch - sc->nr_to_scan;
+	defer_count = atomic64_read(&cma->defer_count);
+	spin_lock_irq(&cma->lock);
+
+	/*free all node*/
+	if (to_scan >= defer_count) {
+		list_for_each_entry(area, &cma->defer_free, list) {
+			list_del(&area->list);
+			free_contig_range(area->pfn, area->count);
+			cma_clear_bitmap(cma, area->pfn, area->count);
+			kfree(area);
+		}
+		atomic64_set(&cma->defer_count, 0);
+		return defer_count;
+	}
+
+	list_for_each_entry(area, &cma->defer_free, list) {
+		if (to_scan <= area->count) {
+			list_del(&area->list);
+			free_contig_range(area->pfn, area->count);
+			cma_clear_bitmap(cma, area->pfn, area->count);
+			kfree(area);
+			atomic64_sub(to_scan, &cma->defer_count);
+			/*release the rest pfn to cma*/
+			if (!list_empty(&cma->defer_free)) {
+				new_pfn = area->pfn + to_scan;
+				cma_release(cma, pfn_to_page(new_pfn), area->count - to_scan);
+			}
+			break;
+		}
+		else {
+			list_del(&area->list);
+			free_contig_range(area->pfn, area->count);
+			cma_clear_bitmap(cma, area->pfn, area->count);
+			kfree(area);
+			to_scan = to_scan - atomic64_read(&cma->defer_count);
+			/*release the rest pfn to cma*/
+			if (!list_empty(&cma->defer_free)) {
+				new_pfn = area->pfn + to_scan;
+				cma_release(cma, pfn_to_page(new_pfn), area->count - to_scan);
+			}
+			continue;
+		}
+	}
+	spin_unlock_irq(&cma->lock);
+	return 0;
+}
+
+static struct shrinker cma_shrinker = {
+	.count_objects = cma_defer_free_count,
+	.scan_objects = cma_defer_free_scan,
+	.seeks = 0,
+};
+static int __init cma_init(void)
+{
+	int ret = -1;
+	ret = prealloc_shrinker(&cma_shrinker, "cma-shadow");
+	if (ret)
+		goto err;
+	register_shrinker_prepared(&cma_shrinker);
+	ret = 0;
+err:
+	return ret;
+}
+module_init(cma_init);
diff --git a/mm/cma.h b/mm/cma.h
index 88a0595..e1e3e2f 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -4,6 +4,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/kobject.h>
+#include <linux/shrinker.h>
 
 struct cma_kobject {
 	struct kobject kobj;
@@ -31,6 +32,16 @@ struct cma {
 	struct cma_kobject *cma_kobj;
 #endif
 	bool reserve_pages_on_error;
+	struct list_head defer_free;
+	atomic64_t defer_count;
+	unsigned long batch;
+	struct shrinker shrinker;
+};
+
+struct cma_defer_free_area {
+	unsigned long pfn;
+	unsigned long count;
+	struct list_head list;
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-- 
1.9.1

