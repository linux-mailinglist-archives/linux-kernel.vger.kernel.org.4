Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F256A91BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCCHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCCHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:31:46 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA73D099
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:31:43 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c4so1034122pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f1ViRZ4YeKX8ZgWQLobABDWwzOU0KOgFG1pN8DNKf4=;
        b=bT7fROkdVv1z9VsE+CkjDQg2rQwAoxGdS4/qtyQNAOwINX6daVeSyp9Ne+MoY7zLR+
         5KA7Dq1F/pHFzkOompHF4jDph0QXHiF2Jc6mkQ0f5xxymHPSXkIHyrlDW8YwjdkBJHig
         Hwqyaq/KM/J++Fv4M64EcvXERjtiu6/KXaKiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+f1ViRZ4YeKX8ZgWQLobABDWwzOU0KOgFG1pN8DNKf4=;
        b=mt44Dt82wPkD9hu77KlwoOmoCt6PuDJQAXrjq6r6vlI9plD0bbnKIUAT5FcJhXkd79
         6tZVDxnZPtbeBoQsR4gHadTb5z8QC+WUR6xEN7hA0Na7YRoOn/sOoxbmvZgDoSiOHxj5
         F5F1Fr2IfAJta0mAdk0xUsL2HJANgFaXqn+fpWgvcujs6i6wZsYw4fqZ6UPj3hzFoF+P
         i2yECc3u/zNMv5gpsfuX3NjnUcDKfhizYhqsU4mJh1vBkbQebLdfefh2ou3x8AwN6Nyk
         CHcwTDz7Yb2fTBrQs80WRHO3TqbHScP6whCBwXXVfRvN5OF3rPX+0mPwVaLIFS+XAhKX
         NVdg==
X-Gm-Message-State: AO0yUKWhLF0Tis0YuwAPy7rPkzXFN3BaIprW10XLFgQZZGuBzsWL1pjS
        oeIkVhdSDA249YeMWJ5Cjsf4fQ==
X-Google-Smtp-Source: AK7set+SgxBsT6SwLd3BD5CWFP/8kCRryFEXMoIGk9mGe0JgTO8Qr80TVtT52zZKlS9sfqTZm3/vWQ==
X-Received: by 2002:a62:848d:0:b0:593:89ab:2ec4 with SMTP id k135-20020a62848d000000b0059389ab2ec4mr1506693pfd.10.1677828702872;
        Thu, 02 Mar 2023 23:31:42 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:badf:7e3e:d3f9:4956])
        by smtp.gmail.com with ESMTPSA id c18-20020aa781d2000000b005a8b4dcd21asm933439pfn.15.2023.03.02.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:31:42 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 2/4] zsmalloc: fine-grained inuse ratio based fullness grouping
Date:   Fri,  3 Mar 2023 16:31:28 +0900
Message-Id: <20230303073130.1950714-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230303073130.1950714-1-senozhatsky@chromium.org>
References: <20230303073130.1950714-1-senozhatsky@chromium.org>
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
number of objects stored in the zspage. The ->inuse counter also
determines the zspage's "fullness group" which is calculated as
the ratio of the "inuse" objects to the total number of objects
the zspage can hold (objs_per_zspage). The closer the ->inuse
counter is to objs_per_zspage, the better.

Each size class maintains several fullness lists, that keep
track of zspages of particular "fullness". Pages within each
fullness list are stored in random order with regard to the
->inuse counter. This is because sorting the zspages by ->inuse
counter each time obj_malloc() or obj_free() is called would
be too expensive. However, the ->inuse counter is still a
crucial factor in many situations.

For the two major zsmalloc operations, zs_malloc() and zs_compact(),
we typically select the head zspage from the corresponding fullness
list as the best candidate zspage. However, this assumption is not
always accurate.

For the zs_malloc() operation, the optimal candidate zspage should
have the highest ->inuse counter. This is because the goal is to
maximize the number of ZS_FULL zspages and make full use of all
allocated memory.

For the zs_compact() operation, the optimal source zspage should
have the lowest ->inuse counter. This is because compaction needs
to move objects in use to another page before it can release the
zspage and return its physical pages to the buddy allocator. The
fewer objects in use, the quicker compaction can release the zspage.
Additionally, compaction is measured by the number of pages it
releases.

This patch reworks the fullness grouping mechanism. Instead of
having two groups - ZS_ALMOST_EMPTY (usage ratio below 3/4) and
ZS_ALMOST_FULL (usage ration above 3/4) - that result in too many
zspages being included in the ALMOST_EMPTY group for specific
classes, size classes maintain a larger number of fullness lists
that give strict guarantees on the minimum and maximum ->inuse
values within each group. Each group represents a 10% change in the
->inuse ratio compared to neighboring groups. In essence, there
are groups for zspages with 0%, 10%, 20% usage ratios, and so on,
up to 100%.

This enhances the selection of candidate zspages for both zs_malloc()
and zs_compact(). A printout of the ->inuse counters of the first 7
zspages per (random) class fullness group:

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
that it always selects a zspage from the group with the least
internal fragmentation (highest usage ratio) and makes it even
less fragmented by increasing its usage ratio.

The zs_compact() function, on the other hand, begins by scanning
the group with the highest fragmentation (lowest usage ratio) to
locate the source page. The first available zspage is selected, and
then the function moves downward to find a destination zspage in
the group with the lowest internal fragmentation (highest usage
ratio).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 245 ++++++++++++++++++++++++++------------------------
 1 file changed, 128 insertions(+), 117 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1cd180caff76..630854575c30 100644
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
@@ -159,51 +159,46 @@
 #define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
 				      ZS_SIZE_CLASS_DELTA) + 1)
 
+/*
+ * Pages are distinguished by the ratio of used memory (that is the ratio
+ * of ->inuse objects to all objects that page can store). For example,
+ * INUSE_RATIO_10 means that the ratio of used objects is > 0% and <= 10%.
+ *
+ * The number of fullness groups is not random. It allows us to keep
+ * diffeence between the least busy page in the group (minimum permitted
+ * number of ->inuse objects) and the most busy page (maximum permitted
+ * number of ->inuse objects) at a reasonable value.
+ */
 enum fullness_group {
-	ZS_EMPTY,
-	ZS_ALMOST_EMPTY,
-	ZS_ALMOST_FULL,
-	ZS_FULL,
-	NR_ZS_FULLNESS,
+	ZS_INUSE_RATIO_0,
+	ZS_INUSE_RATIO_10,
+	/* NOTE: 5 more fullness groups here */
+	ZS_INUSE_RATIO_70	= 7,
+	/* NOTE: 2 more fullness groups here */
+	ZS_INUSE_RATIO_99       = 10,
+	ZS_INUSE_RATIO_100,
+	NR_FULLNESS_GROUPS,
 };
 
 enum class_stat_type {
-	CLASS_EMPTY,
-	CLASS_ALMOST_EMPTY,
-	CLASS_ALMOST_FULL,
-	CLASS_FULL,
-	OBJ_ALLOCATED,
-	OBJ_USED,
-	NR_ZS_STAT_TYPE,
+	/* NOTE: stats for 12 fullness groups here: from inuse 0 to 100 */
+	ZS_OBJS_ALLOCATED       = NR_FULLNESS_GROUPS,
+	ZS_OBJS_INUSE,
+	NR_CLASS_STAT_TYPES,
 };
 
 struct zs_size_stat {
-	unsigned long objs[NR_ZS_STAT_TYPE];
+	unsigned long objs[NR_CLASS_STAT_TYPES];
 };
 
 #ifdef CONFIG_ZSMALLOC_STAT
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
+	struct list_head fullness_list[NR_FULLNESS_GROUPS];
 	/*
 	 * Size of objects stored in this class. Must be multiple
 	 * of ZS_ALIGN.
@@ -547,8 +542,8 @@ static inline void set_freeobj(struct zspage *zspage, unsigned int obj)
 }
 
 static void get_zspage_mapping(struct zspage *zspage,
-				unsigned int *class_idx,
-				enum fullness_group *fullness)
+			       unsigned int *class_idx,
+			       int *fullness)
 {
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 
@@ -557,14 +552,14 @@ static void get_zspage_mapping(struct zspage *zspage,
 }
 
 static struct size_class *zspage_class(struct zs_pool *pool,
-					     struct zspage *zspage)
+				       struct zspage *zspage)
 {
 	return pool->size_class[zspage->class];
 }
 
 static void set_zspage_mapping(struct zspage *zspage,
-				unsigned int class_idx,
-				enum fullness_group fullness)
+			       unsigned int class_idx,
+			       int fullness)
 {
 	zspage->class = class_idx;
 	zspage->fullness = fullness;
@@ -588,23 +583,19 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
-/* type can be of enum type class_stat_type or fullness_group */
 static inline void class_stat_inc(struct size_class *class,
 				int type, unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
-/* type can be of enum type class_stat_type or fullness_group */
 static inline void class_stat_dec(struct size_class *class,
 				int type, unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
-/* type can be of enum type class_stat_type or fullness_group */
-static inline unsigned long zs_stat_get(struct size_class *class,
-				int type)
+static inline unsigned long zs_stat_get(struct size_class *class, int type)
 {
 	return class->stats.objs[type];
 }
@@ -646,16 +637,26 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 			"pages_per_zspage", "freeable");
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
+		int fg;
+
 		class = pool->size_class[i];
 
 		if (class->index != i)
 			continue;
 
 		spin_lock(&pool->lock);
-		class_almost_full = zs_stat_get(class, CLASS_ALMOST_FULL);
-		class_almost_empty = zs_stat_get(class, CLASS_ALMOST_EMPTY);
-		obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
-		obj_used = zs_stat_get(class, OBJ_USED);
+
+		/*
+		 * Replecate old behaviour for almost_full and almost_empty
+		 * stats.
+		 */
+		for (fg = ZS_INUSE_RATIO_70; fg <= ZS_INUSE_RATIO_99; fg++)
+			class_almost_full = zs_stat_get(class, fg);
+		for (fg = ZS_INUSE_RATIO_10; fg < ZS_INUSE_RATIO_70; fg++)
+			class_almost_empty = zs_stat_get(class, fg);
+
+		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
+		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
 		spin_unlock(&pool->lock);
 
@@ -723,42 +724,39 @@ static inline void zs_pool_stat_destroy(struct zs_pool *pool)
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
-static enum fullness_group get_fullness_group(struct size_class *class,
-						struct zspage *zspage)
+static int get_fullness_group(struct size_class *class, struct zspage *zspage)
 {
-	int inuse, objs_per_zspage;
-	enum fullness_group fg;
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
  * This function adds the given zspage to the fullness list identified
- * by <class, fullness_group>.
+ * by <class, fullness group>.
  */
 static void insert_zspage(struct size_class *class,
 				struct zspage *zspage,
-				enum fullness_group fullness)
+				int fullness)
 {
 	class_stat_inc(class, fullness, 1);
 	list_add(&zspage->list, &class->fullness_list[fullness]);
@@ -766,11 +764,11 @@ static void insert_zspage(struct size_class *class,
 
 /*
  * This function removes the given zspage from the fullness list identified
- * by <class, fullness_group>.
+ * by <class, fullness group>.
  */
 static void remove_zspage(struct size_class *class,
 				struct zspage *zspage,
-				enum fullness_group fullness)
+				int fullness)
 {
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
@@ -781,17 +779,16 @@ static void remove_zspage(struct size_class *class,
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
-static enum fullness_group fix_fullness_group(struct size_class *class,
-						struct zspage *zspage)
+static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 {
 	int class_idx;
-	enum fullness_group currfg, newfg;
+	int currfg, newfg;
 
 	get_zspage_mapping(zspage, &class_idx, &currfg);
 	newfg = get_fullness_group(class, zspage);
@@ -964,7 +961,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
 	struct page *page, *next;
-	enum fullness_group fg;
+	int fg;
 	unsigned int class_idx;
 
 	get_zspage_mapping(zspage, &class_idx, &fg);
@@ -972,7 +969,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	assert_spin_locked(&pool->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
-	VM_BUG_ON(fg != ZS_EMPTY);
+	VM_BUG_ON(fg != ZS_INUSE_RATIO_0);
 
 	/* Free all deferred handles from zs_free */
 	free_handles(pool, class, zspage);
@@ -990,7 +987,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	cache_free_zspage(pool, zspage);
 
-	class_stat_dec(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage,
 					&pool->pages_allocated);
 }
@@ -1011,7 +1008,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 		return;
 	}
 
-	remove_zspage(class, zspage, ZS_EMPTY);
+	remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
 #ifdef CONFIG_ZPOOL
 	list_del(&zspage->lru);
 #endif
@@ -1147,9 +1144,9 @@ static struct zspage *find_get_zspage(struct size_class *class)
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
@@ -1508,7 +1505,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 {
 	unsigned long handle, obj;
 	struct size_class *class;
-	enum fullness_group newfg;
+	int newfg;
 	struct zspage *zspage;
 
 	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
@@ -1530,7 +1527,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
-		class_stat_inc(class, OBJ_USED, 1);
+		class_stat_inc(class, ZS_OBJS_INUSE, 1);
 		spin_unlock(&pool->lock);
 
 		return handle;
@@ -1552,8 +1549,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage,
 				&pool->pages_allocated);
-	class_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
-	class_stat_inc(class, OBJ_USED, 1);
+	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_inc(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1609,7 +1606,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	struct page *f_page;
 	unsigned long obj;
 	struct size_class *class;
-	enum fullness_group fullness;
+	int fullness;
 
 	if (IS_ERR_OR_NULL((void *)handle))
 		return;
@@ -1624,7 +1621,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
 
-	class_stat_dec(class, OBJ_USED, 1);
+	class_stat_dec(class, ZS_OBJS_INUSE, 1);
 
 #ifdef CONFIG_ZPOOL
 	if (zspage->under_reclaim) {
@@ -1642,7 +1639,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	obj_free(class->size, obj, NULL);
 
 	fullness = fix_fullness_group(class, zspage);
-	if (fullness == ZS_EMPTY)
+	if (fullness == ZS_INUSE_RATIO_0)
 		free_zspage(pool, class, zspage);
 
 	spin_unlock(&pool->lock);
@@ -1824,22 +1821,33 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 	return ret;
 }
 
-static struct zspage *isolate_zspage(struct size_class *class, bool source)
+static struct zspage *isolate_src_zspage(struct size_class *class)
 {
-	int i;
 	struct zspage *zspage;
-	enum fullness_group fg[2] = {ZS_ALMOST_EMPTY, ZS_ALMOST_FULL};
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
@@ -1852,12 +1860,11 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
  * @class: destination class
  * @zspage: target page
  *
- * Return @zspage's fullness_group
+ * Return @zspage's fullness status
  */
-static enum fullness_group putback_zspage(struct size_class *class,
-			struct zspage *zspage)
+static int putback_zspage(struct size_class *class, struct zspage *zspage)
 {
-	enum fullness_group fullness;
+	int fullness;
 
 	fullness = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, fullness);
@@ -2121,7 +2128,7 @@ static void async_free_zspage(struct work_struct *work)
 	int i;
 	struct size_class *class;
 	unsigned int class_idx;
-	enum fullness_group fullness;
+	int fullness;
 	struct zspage *zspage, *tmp;
 	LIST_HEAD(free_pages);
 	struct zs_pool *pool = container_of(work, struct zs_pool,
@@ -2133,7 +2140,7 @@ static void async_free_zspage(struct work_struct *work)
 			continue;
 
 		spin_lock(&pool->lock);
-		list_splice_init(&class->fullness_list[ZS_EMPTY], &free_pages);
+		list_splice_init(&class->fullness_list[ZS_INUSE_RATIO_0], &free_pages);
 		spin_unlock(&pool->lock);
 	}
 
@@ -2142,7 +2149,7 @@ static void async_free_zspage(struct work_struct *work)
 		lock_zspage(zspage);
 
 		get_zspage_mapping(zspage, &class_idx, &fullness);
-		VM_BUG_ON(fullness != ZS_EMPTY);
+		VM_BUG_ON(fullness != ZS_INUSE_RATIO_0);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
 #ifdef CONFIG_ZPOOL
@@ -2190,8 +2197,8 @@ static inline void zs_flush_migration(struct zs_pool *pool) { }
 static unsigned long zs_can_compact(struct size_class *class)
 {
 	unsigned long obj_wasted;
-	unsigned long obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
-	unsigned long obj_used = zs_stat_get(class, OBJ_USED);
+	unsigned long obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
+	unsigned long obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
 
 	if (obj_allocated <= obj_used)
 		return 0;
@@ -2215,7 +2222,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	spin_lock(&pool->lock);
-	while ((src_zspage = isolate_zspage(class, true))) {
+	while ((src_zspage = isolate_src_zspage(class))) {
 		/* protect someone accessing the zspage(i.e., zs_map_object) */
 		migrate_write_lock(src_zspage);
 
@@ -2225,7 +2232,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		cc.obj_idx = 0;
 		cc.s_page = get_first_page(src_zspage);
 
-		while ((dst_zspage = isolate_zspage(class, false))) {
+		while ((dst_zspage = isolate_dst_zspage(class))) {
 			migrate_write_lock_nested(dst_zspage);
 
 			cc.d_page = get_first_page(dst_zspage);
@@ -2250,7 +2257,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		putback_zspage(class, dst_zspage);
 		migrate_write_unlock(dst_zspage);
 
-		if (putback_zspage(class, src_zspage) == ZS_EMPTY) {
+		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
 			migrate_write_unlock(src_zspage);
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
@@ -2408,7 +2415,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		int pages_per_zspage;
 		int objs_per_zspage;
 		struct size_class *class;
-		int fullness = 0;
+		int fullness;
 
 		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
 		if (size > ZS_MAX_ALLOC_SIZE)
@@ -2462,9 +2469,12 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
 		pool->size_class[i] = class;
-		for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
-							fullness++)
+
+		fullness = ZS_INUSE_RATIO_0;
+		while (fullness < NR_FULLNESS_GROUPS) {
 			INIT_LIST_HEAD(&class->fullness_list[fullness]);
+			fullness++;
+		}
 
 		prev_class = class;
 	}
@@ -2510,11 +2520,12 @@ void zs_destroy_pool(struct zs_pool *pool)
 		if (class->index != i)
 			continue;
 
-		for (fg = ZS_EMPTY; fg < NR_ZS_FULLNESS; fg++) {
-			if (!list_empty(&class->fullness_list[fg])) {
-				pr_info("Freeing non-empty class with size %db, fullness group %d\n",
-					class->size, fg);
-			}
+		for (fg = ZS_INUSE_RATIO_0; fg < NR_FULLNESS_GROUPS; fg++) {
+			if (list_empty(&class->fullness_list[fg]))
+				continue;
+
+			pr_err("Class-%d fullness group %d is not empty\n",
+			       class->size, fg);
 		}
 		kfree(class);
 	}
@@ -2616,7 +2627,7 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
 	unsigned long handle;
 	struct zspage *zspage;
 	struct page *page;
-	enum fullness_group fullness;
+	int fullness;
 
 	/* Lock LRU and fullness list */
 	spin_lock(&pool->lock);
@@ -2686,7 +2697,7 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
 			 * while the page is removed from the pool. Fix it
 			 * up for the check in __free_zspage().
 			 */
-			zspage->fullness = ZS_EMPTY;
+			zspage->fullness = ZS_INUSE_RATIO_0;
 
 			__free_zspage(pool, class, zspage);
 			spin_unlock(&pool->lock);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

