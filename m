Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAA6A0161
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjBWDFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjBWDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:10 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA56460A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c1so11510932plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+oVIrjvupRwrVwXlg7PumbsuiNQvLcBtQYCdoukFrI=;
        b=RqUAZ7NvMZZunMUB/MmiD0jYODuJNYZpUHSO0ZTUtA0mNcmpTGprRdyBcM13rR+YkV
         BqEL4V2jbOwYKfcCfOjCE6vYdJMPvmebObR8Rn82FOYHiwGm/nz48QVNQY69a7MM+Xgi
         jsEu9m1WWpq9GBL2stEA0/m3bW+gDboZWkQZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+oVIrjvupRwrVwXlg7PumbsuiNQvLcBtQYCdoukFrI=;
        b=w14Rdm31efB7q77mNqsNM9JaSYFnPvW1Nom5lMyuKxp5GMTW51ysNk+KNLkGCdh2db
         WmONSIc2arvrPBjQ1OsrbQjRr1ku3LtJ+5i6GNN1rGTkZBr//LRWLldle7xTAP84QvEw
         ZPBHTWrErHHbs+VOVESW3ReGWerOHWrvNcL98Dw1kkb8u3z9yk+G0X+D6ut7Kipwjizt
         Rv+7TVOj5nANwryknonHWDb7ovIG3FVx09nyWSZvwn5oFk7z9zTVR4IzElwHf8kxnR5l
         Yj4dWtcLKYHdyCtV7dMOm6s4Ry9EAms/njpJKf2JIRvzjlaTb7EDFNcrAtZeRHKVWnBe
         NtxA==
X-Gm-Message-State: AO0yUKUvi8RsUmPtvRvShvRRzaM2gZLExMD0wDZQ2V1fgsEbOaPMZOmV
        sDjJJSUC6zyAAVLsNM2Da72lu1Mtps+UOa9V
X-Google-Smtp-Source: AK7set9n/kR4OsBAyMS4NO+Nfr/q6P17NvG3FPUw+0WktVTf7LO65SnlQ+Sk3o2XFtmQGImRRC8Scg==
X-Received: by 2002:a17:902:ea07:b0:19a:887d:98ac with SMTP id s7-20020a170902ea0700b0019a887d98acmr13433066plg.46.1677121506725;
        Wed, 22 Feb 2023 19:05:06 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:05:06 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness grouping
Date:   Thu, 23 Feb 2023 12:04:48 +0900
Message-Id: <20230223030451.543162-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230223030451.543162-1-senozhatsky@chromium.org>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each zspage maintains ->inuse counter which keeps track of the
number of objects stored in the page. The ->inuse counter also
determines the page's "fullness group" which is calculated as
the ratio of the "inuse" objects to the total number of objects
the page can hold (objs_per_zspage). The closer the ->inuse
counter is to objs_per_zspage, the better.

Each size class maintains several fullness lists, that keep
track of zspages of particular "fullness". Pages within each
fullness list are stored in random order with regard to the
->inuse counter. This is because sorting the pages by ->inuse
counter each time obj_malloc() or obj_free() is called would
be too expensive. However, the ->inuse counter is still a
crucial factor in many situations.

For the two major zsmalloc operations, zs_malloc() and zs_compact(),
we typically select the head page from the corresponding fullness
list as the best candidate page. However, this assumption is not
always accurate.

For the zs_malloc() operation, the optimal candidate page should
have the highest ->inuse counter. This is because the goal is to
maximize the number of ZS_FULL pages and make full use of all
allocated memory.

For the zs_compact() operation, the optimal candidate page should
have the lowest ->inuse counter. This is because compaction needs
to move objects in use to another page before it can release the
zspage and return its physical pages to the buddy allocator. The
fewer objects in use, the quicker compaction can release the page.
Additionally, compaction is measured by the number of pages it
releases.

This patch reworks the fullness grouping mechanism. Instead of
having two groups - ZS_ALMOST_EMPTY (usage ratio below 3/4) and
ZS_ALMOST_FULL (usage ration above 3/4) - that result in too many
pages being included in the ALMOST_EMPTY group for specific
classes, size classes maintain a larger number of fullness lists
that give strict guarantees on the minimum and maximum ->inuse
values within each group. Each group represents a 10% change in the
->inuse ratio compared to neighboring groups. In essence, there
are groups for pages with 0%, 10%, 20% usage ratios, and so on,
up to 100%.

This enhances the selection of candidate pages for both zs_malloc()
and zs_compact(). A printout of the ->inuse counters of the first 7
pages per (random) class fullness group:

 class-768 objs_per_zspage 16:
   fullness 100%:  empty
   fullness  99%:  empty
   fullness  90%:  empty
   fullness  80%:  empty
   fullness  70%:  empty
   fullness  60%:  8  8  9  9  8  8  8
   fullness  50%:  empty
   fullness  40%:  5  5  6  5  5  5  5
   fullness  30%:  4  4  4  4  4  4  4
   fullness  20%:  2  3  2  3  3  2  2
   fullness  10%:  1  1  1  1  1  1  1
   fullness   0%:  empty

The zs_malloc() function searches through the groups of pages
starting with the one having the highest usage ratio. This means
that it always selects a page from the group with the least
internal fragmentation (highest usage ratio) and makes it even
less fragmented by increasing its usage ratio.

The zs_compact() function, on the other hand, begins by scanning
the group with the highest fragmentation (lowest usage ratio) to
locate the source page. The first available page is selected, and
then the function moves downward to find a destination page in
the group with the lowest internal fragmentation (highest usage
ratio).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 183 +++++++++++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 76 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 38ae8963c0eb..1a92ebe338eb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -127,7 +127,7 @@
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
 #define HUGE_BITS	1
-#define FULLNESS_BITS	2
+#define FULLNESS_BITS	4
 #define CLASS_BITS	8
 #define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
@@ -159,15 +159,33 @@
 #define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
 				      ZS_SIZE_CLASS_DELTA) + 1)
 
-#define ZS_EMPTY		0
-#define ZS_ALMOST_EMPTY		1
-#define ZS_ALMOST_FULL		2
-#define ZS_FULL			3
-#define ZS_OBJS_ALLOCATED	4
-#define ZS_OBJS_INUSE		5
-
-#define NR_ZS_STAT		6
-#define NR_ZS_FULLNESS		4
+/*
+ * Pages are distinguished by the ratio of used memory (that is the ratio
+ * of ->inuse objects to all objects that page can store). For example,
+ * INUSE_RATIO_30 means that the ratio of used objects is > 20% and <= 30%.
+ *
+ * The number of fullness groups is not random. It allows us to keep
+ * diffeence between the least busy page in the group (minimum permitted
+ * number of ->inuse objects) and the most busy page (maximum permitted
+ * number of ->inuse objects) at a reasonable value.
+ */
+#define ZS_INUSE_RATIO_0	0
+#define ZS_INUSE_RATIO_10	1
+#define ZS_INUSE_RATIO_20	2
+#define ZS_INUSE_RATIO_30	3
+#define ZS_INUSE_RATIO_40	4
+#define ZS_INUSE_RATIO_50	5
+#define ZS_INUSE_RATIO_60	6
+#define ZS_INUSE_RATIO_70	7
+#define ZS_INUSE_RATIO_80	8
+#define ZS_INUSE_RATIO_90	9
+#define ZS_INUSE_RATIO_99	10
+#define ZS_INUSE_RATIO_100	11
+#define ZS_OBJS_ALLOCATED	12
+#define ZS_OBJS_INUSE		13
+
+#define NR_ZS_INUSE_RATIO	12
+#define NR_ZS_STAT		14
 
 struct zs_size_stat {
 	unsigned long objs[NR_ZS_STAT];
@@ -177,25 +195,10 @@ struct zs_size_stat {
 static struct dentry *zs_stat_root;
 #endif
 
-/*
- * We assign a page to ZS_ALMOST_EMPTY fullness group when:
- *	n <= N / f, where
- * n = number of allocated objects
- * N = total number of objects zspage can store
- * f = fullness_threshold_frac
- *
- * Similarly, we assign zspage to:
- *	ZS_ALMOST_FULL	when n > N / f
- *	ZS_EMPTY	when n == 0
- *	ZS_FULL		when n == N
- *
- * (see: fix_fullness_group())
- */
-static const int fullness_threshold_frac = 4;
 static size_t huge_class_size;
 
 struct size_class {
-	struct list_head fullness_list[NR_ZS_FULLNESS];
+	struct list_head fullness_list[NR_ZS_INUSE_RATIO];
 	/*
 	 * Size of objects stored in this class. Must be multiple
 	 * of ZS_ALIGN.
@@ -641,8 +644,23 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 			continue;
 
 		spin_lock(&pool->lock);
-		class_almost_full = zs_stat_get(class, ZS_ALMOST_FULL);
-		class_almost_empty = zs_stat_get(class, ZS_ALMOST_EMPTY);
+
+		/*
+		 * Replecate old behaviour for almost_full and almost_empty
+		 * stats.
+		 */
+		class_almost_full = zs_stat_get(class, ZS_INUSE_RATIO_99);
+		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_90);
+		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_80);
+		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_70);
+
+		class_almost_empty = zs_stat_get(class, ZS_INUSE_RATIO_60);
+		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_50);
+		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_40);
+		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_30);
+		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_20);
+		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_10);
+
 		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
 		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
@@ -712,32 +730,30 @@ static inline void zs_pool_stat_destroy(struct zs_pool *pool)
 }
 #endif
 
-
 /*
  * For each size class, zspages are divided into different groups
- * depending on how "full" they are. This was done so that we could
- * easily find empty or nearly empty zspages when we try to shrink
- * the pool (not yet implemented). This function returns fullness
+ * depending on their usage ratio. This function returns fullness
  * status of the given page.
  */
 static int get_fullness_group(struct size_class *class, struct zspage *zspage)
 {
-	int inuse, objs_per_zspage;
-	int fg;
+	int inuse, objs_per_zspage, ratio;
 
 	inuse = get_zspage_inuse(zspage);
 	objs_per_zspage = class->objs_per_zspage;
 
 	if (inuse == 0)
-		fg = ZS_EMPTY;
-	else if (inuse == objs_per_zspage)
-		fg = ZS_FULL;
-	else if (inuse <= 3 * objs_per_zspage / fullness_threshold_frac)
-		fg = ZS_ALMOST_EMPTY;
-	else
-		fg = ZS_ALMOST_FULL;
+		return ZS_INUSE_RATIO_0;
+	if (inuse == objs_per_zspage)
+		return ZS_INUSE_RATIO_100;
 
-	return fg;
+	ratio = 100 * inuse / objs_per_zspage;
+	/*
+	 * Take integer division into consideration: a page with one inuse
+	 * object out of 127 possible, will endup having 0 usage ratio,
+	 * which is wrong as it belongs in ZS_INUSE_RATIO_10 fullness group.
+	 */
+	return ratio / 10 + 1;
 }
 
 /*
@@ -769,11 +785,11 @@ static void remove_zspage(struct size_class *class,
 /*
  * Each size class maintains zspages in different fullness groups depending
  * on the number of live objects they contain. When allocating or freeing
- * objects, the fullness status of the page can change, say, from ALMOST_FULL
- * to ALMOST_EMPTY when freeing an object. This function checks if such
- * a status change has occurred for the given page and accordingly moves the
- * page from the freelist of the old fullness group to that of the new
- * fullness group.
+ * objects, the fullness status of the page can change, for instance, from
+ * INUSE_RATIO_80 to INUSE_RATIO_70 when freeing an object. This function
+ * checks if such a status change has occurred for the given page and
+ * accordingly moves the page from the list of the old fullness group to that
+ * of the new fullness group.
  */
 static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 {
@@ -959,7 +975,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	assert_spin_locked(&pool->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
-	VM_BUG_ON(fg != ZS_EMPTY);
+	VM_BUG_ON(fg != ZS_INUSE_RATIO_0);
 
 	/* Free all deferred handles from zs_free */
 	free_handles(pool, class, zspage);
@@ -998,7 +1014,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 		return;
 	}
 
-	remove_zspage(class, zspage, ZS_EMPTY);
+	remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
 #ifdef CONFIG_ZPOOL
 	list_del(&zspage->lru);
 #endif
@@ -1134,9 +1150,9 @@ static struct zspage *find_get_zspage(struct size_class *class)
 	int i;
 	struct zspage *zspage;
 
-	for (i = ZS_ALMOST_FULL; i >= ZS_EMPTY; i--) {
+	for (i = ZS_INUSE_RATIO_99; i >= ZS_INUSE_RATIO_0; i--) {
 		zspage = list_first_entry_or_null(&class->fullness_list[i],
-				struct zspage, list);
+						  struct zspage, list);
 		if (zspage)
 			break;
 	}
@@ -1629,7 +1645,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	obj_free(class->size, obj, NULL);
 
 	fullness = fix_fullness_group(class, zspage);
-	if (fullness == ZS_EMPTY)
+	if (fullness == ZS_INUSE_RATIO_0)
 		free_zspage(pool, class, zspage);
 
 	spin_unlock(&pool->lock);
@@ -1811,22 +1827,33 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 	return ret;
 }
 
-static struct zspage *isolate_zspage(struct size_class *class, bool source)
+static struct zspage *isolate_src_zspage(struct size_class *class)
 {
-	int i;
 	struct zspage *zspage;
-	int fg[2] = {ZS_ALMOST_EMPTY, ZS_ALMOST_FULL};
+	int fg;
 
-	if (!source) {
-		fg[0] = ZS_ALMOST_FULL;
-		fg[1] = ZS_ALMOST_EMPTY;
+	for (fg = ZS_INUSE_RATIO_10; fg <= ZS_INUSE_RATIO_99; fg++) {
+		zspage = list_first_entry_or_null(&class->fullness_list[fg],
+						  struct zspage, list);
+		if (zspage) {
+			remove_zspage(class, zspage, fg);
+			return zspage;
+		}
 	}
 
-	for (i = 0; i < 2; i++) {
-		zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
-							struct zspage, list);
+	return zspage;
+}
+
+static struct zspage *isolate_dst_zspage(struct size_class *class)
+{
+	struct zspage *zspage;
+	int fg;
+
+	for (fg = ZS_INUSE_RATIO_99; fg >= ZS_INUSE_RATIO_10; fg--) {
+		zspage = list_first_entry_or_null(&class->fullness_list[fg],
+						  struct zspage, list);
 		if (zspage) {
-			remove_zspage(class, zspage, fg[i]);
+			remove_zspage(class, zspage, fg);
 			return zspage;
 		}
 	}
@@ -2119,7 +2146,7 @@ static void async_free_zspage(struct work_struct *work)
 			continue;
 
 		spin_lock(&pool->lock);
-		list_splice_init(&class->fullness_list[ZS_EMPTY], &free_pages);
+		list_splice_init(&class->fullness_list[ZS_INUSE_RATIO_0], &free_pages);
 		spin_unlock(&pool->lock);
 	}
 
@@ -2128,7 +2155,7 @@ static void async_free_zspage(struct work_struct *work)
 		lock_zspage(zspage);
 
 		get_zspage_mapping(zspage, &class_idx, &fullness);
-		VM_BUG_ON(fullness != ZS_EMPTY);
+		VM_BUG_ON(fullness != ZS_INUSE_RATIO_0);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
 #ifdef CONFIG_ZPOOL
@@ -2201,7 +2228,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	spin_lock(&pool->lock);
-	while ((src_zspage = isolate_zspage(class, true))) {
+	while ((src_zspage = isolate_src_zspage(class))) {
 		/* protect someone accessing the zspage(i.e., zs_map_object) */
 		migrate_write_lock(src_zspage);
 
@@ -2211,7 +2238,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		cc.obj_idx = 0;
 		cc.s_page = get_first_page(src_zspage);
 
-		while ((dst_zspage = isolate_zspage(class, false))) {
+		while ((dst_zspage = isolate_dst_zspage(class))) {
 			migrate_write_lock_nested(dst_zspage);
 
 			cc.d_page = get_first_page(dst_zspage);
@@ -2236,7 +2263,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		putback_zspage(class, dst_zspage);
 		migrate_write_unlock(dst_zspage);
 
-		if (putback_zspage(class, src_zspage) == ZS_EMPTY) {
+		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
 			migrate_write_unlock(src_zspage);
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
@@ -2394,7 +2421,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		int pages_per_zspage;
 		int objs_per_zspage;
 		struct size_class *class;
-		int fullness = 0;
+		int fullness;
 
 		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
 		if (size > ZS_MAX_ALLOC_SIZE)
@@ -2448,9 +2475,12 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
 		pool->size_class[i] = class;
-		for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
-							fullness++)
+
+		fullness = ZS_INUSE_RATIO_0;
+		while (fullness < NR_ZS_INUSE_RATIO) {
 			INIT_LIST_HEAD(&class->fullness_list[fullness]);
+			fullness++;
+		}
 
 		prev_class = class;
 	}
@@ -2496,11 +2526,12 @@ void zs_destroy_pool(struct zs_pool *pool)
 		if (class->index != i)
 			continue;
 
-		for (fg = ZS_EMPTY; fg < NR_ZS_FULLNESS; fg++) {
-			if (!list_empty(&class->fullness_list[fg])) {
-				pr_info("Freeing non-empty class with size %db, fullness group %d\n",
-					class->size, fg);
-			}
+		for (fg = ZS_INUSE_RATIO_0; fg < NR_ZS_INUSE_RATIO; fg++) {
+			if (list_empty(&class->fullness_list[fg]))
+				continue;
+
+			pr_err("Class-%d fullness group %d is not empty\n",
+			       class->size, fg);
 		}
 		kfree(class);
 	}
@@ -2672,7 +2703,7 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
 			 * while the page is removed from the pool. Fix it
 			 * up for the check in __free_zspage().
 			 */
-			zspage->fullness = ZS_EMPTY;
+			zspage->fullness = ZS_INUSE_RATIO_0;
 
 			__free_zspage(pool, class, zspage);
 			spin_unlock(&pool->lock);
-- 
2.39.2.637.g21b0678d19-goog

