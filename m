Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB786A0160
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjBWDFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjBWDFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8672F457E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i3so819949plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+a7RvRhurz1Ai+VZTI1SaXOAjw7CakUvWehQGGNcJ0=;
        b=PVE/woFYX/y2Nv/sSWN/ThQ7WpqOXClosC23oGEVbNLw+KQEHwBO6RQseLQLRiTTO8
         rQ3VjL8xKc7Wgb/Jl357h+iW+SZvTOhE+otycFTz0/T665RZa055Y/XJ5GzLILgml5tC
         2n9hS+yqHu+gRYPQ1oJQZHmz4yUqpgjh5Y0UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+a7RvRhurz1Ai+VZTI1SaXOAjw7CakUvWehQGGNcJ0=;
        b=yLXp8f1bURQ9mQhuqK2qhd1QkTAi3wbKfExCGDkf2sSh0vdhqg4Zpl8teme4eW+ywy
         QDb0DANUZajXt9/f9n/8W5HyyjzalHaAUDtyAdQciI3IpNcxYyF07Xe00d6M00w0jCZv
         js923Wwo9Q5UWTa3gj4RZfsj4F8cuXE4lzfh+tOCg6RogtsFezCc+46Mz03sW3+XZB/H
         NPIhQBwmoOi/2rO79k7YXdIFSzcd9SRVXTT+Ti45u74ipPbdGk9GF/nKv4uq+3JVAq19
         hwu90YyaF7b3KxmBCpyOY9rukoRCeYKPJBexhw3lUA54AnWllASEetdHtYBim5DLpNZJ
         uPFA==
X-Gm-Message-State: AO0yUKUrGpBT0lEmoz+MLSy4D3s2KmOnytZBLBg8wyjnddILGkFwcsXV
        NqwZUVdkbQlsSrDfmtXjJ7QshQ==
X-Google-Smtp-Source: AK7set9iWFHlpCYsAD2np6Tp3JHdZO5a9W4ONaB5Ya2yJKg+38hrP2KF/ufMSur/h6V0NBGOjezMpQ==
X-Received: by 2002:a17:902:ecd0:b0:19b:2332:18cb with SMTP id a16-20020a170902ecd000b0019b233218cbmr12943938plh.1.1677121503834;
        Wed, 22 Feb 2023 19:05:03 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:05:03 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/6] zsmalloc: remove stat and fullness enums
Date:   Thu, 23 Feb 2023 12:04:47 +0900
Message-Id: <20230223030451.543162-3-senozhatsky@chromium.org>
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

The fullness_group enum is nested (sub-enum) within the
class_stat_type enum. zsmalloc requires the values in both
enums to match, because zsmalloc passes these values to
generic functions, e.g. class_stat_inc() and class_stat_dec(),
after casting them to integers.

Replace these enums (and enum nesting) and use simple defines
instead. Also rename some of zsmalloc stats defines, as they
sort of clash with zspage object tags.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 104 ++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 59 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b57a89ed6f30..38ae8963c0eb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -159,26 +159,18 @@
 #define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
 				      ZS_SIZE_CLASS_DELTA) + 1)
 
-enum fullness_group {
-	ZS_EMPTY,
-	ZS_ALMOST_EMPTY,
-	ZS_ALMOST_FULL,
-	ZS_FULL,
-	NR_ZS_FULLNESS,
-};
+#define ZS_EMPTY		0
+#define ZS_ALMOST_EMPTY		1
+#define ZS_ALMOST_FULL		2
+#define ZS_FULL			3
+#define ZS_OBJS_ALLOCATED	4
+#define ZS_OBJS_INUSE		5
 
-enum class_stat_type {
-	CLASS_EMPTY,
-	CLASS_ALMOST_EMPTY,
-	CLASS_ALMOST_FULL,
-	CLASS_FULL,
-	OBJ_ALLOCATED,
-	OBJ_USED,
-	NR_ZS_STAT_TYPE,
-};
+#define NR_ZS_STAT		6
+#define NR_ZS_FULLNESS		4
 
 struct zs_size_stat {
-	unsigned long objs[NR_ZS_STAT_TYPE];
+	unsigned long objs[NR_ZS_STAT];
 };
 
 #ifdef CONFIG_ZSMALLOC_STAT
@@ -547,8 +539,8 @@ static inline void set_freeobj(struct zspage *zspage, unsigned int obj)
 }
 
 static void get_zspage_mapping(struct zspage *zspage,
-				unsigned int *class_idx,
-				enum fullness_group *fullness)
+			       unsigned int *class_idx,
+			       int *fullness)
 {
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 
@@ -557,14 +549,14 @@ static void get_zspage_mapping(struct zspage *zspage,
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
@@ -588,23 +580,20 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
-/* type can be of enum type class_stat_type or fullness_group */
 static inline void class_stat_inc(struct size_class *class,
-				int type, unsigned long cnt)
+				  int type, unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
-/* type can be of enum type class_stat_type or fullness_group */
 static inline void class_stat_dec(struct size_class *class,
-				int type, unsigned long cnt)
+				  int type, unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
-/* type can be of enum type class_stat_type or fullness_group */
 static inline unsigned long zs_stat_get(struct size_class *class,
-				int type)
+					int type)
 {
 	return class->stats.objs[type];
 }
@@ -652,10 +641,10 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 			continue;
 
 		spin_lock(&pool->lock);
-		class_almost_full = zs_stat_get(class, CLASS_ALMOST_FULL);
-		class_almost_empty = zs_stat_get(class, CLASS_ALMOST_EMPTY);
-		obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
-		obj_used = zs_stat_get(class, OBJ_USED);
+		class_almost_full = zs_stat_get(class, ZS_ALMOST_FULL);
+		class_almost_empty = zs_stat_get(class, ZS_ALMOST_EMPTY);
+		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
+		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
 		spin_unlock(&pool->lock);
 
@@ -731,11 +720,10 @@ static inline void zs_pool_stat_destroy(struct zs_pool *pool)
  * the pool (not yet implemented). This function returns fullness
  * status of the given page.
  */
-static enum fullness_group get_fullness_group(struct size_class *class,
-						struct zspage *zspage)
+static int get_fullness_group(struct size_class *class, struct zspage *zspage)
 {
 	int inuse, objs_per_zspage;
-	enum fullness_group fg;
+	int fg;
 
 	inuse = get_zspage_inuse(zspage);
 	objs_per_zspage = class->objs_per_zspage;
@@ -754,11 +742,11 @@ static enum fullness_group get_fullness_group(struct size_class *class,
 
 /*
  * This function adds the given zspage to the fullness list identified
- * by <class, fullness_group>.
+ * by <class, fullness group>.
  */
 static void insert_zspage(struct size_class *class,
 			  struct zspage *zspage,
-			  enum fullness_group fullness)
+			  int fullness)
 {
 	class_stat_inc(class, fullness, 1);
 	list_add(&zspage->list, &class->fullness_list[fullness]);
@@ -766,11 +754,11 @@ static void insert_zspage(struct size_class *class,
 
 /*
  * This function removes the given zspage from the fullness list identified
- * by <class, fullness_group>.
+ * by <class, fullness group>.
  */
 static void remove_zspage(struct size_class *class,
 			  struct zspage *zspage,
-			  enum fullness_group fullness)
+			  int fullness)
 {
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
@@ -787,11 +775,10 @@ static void remove_zspage(struct size_class *class,
  * page from the freelist of the old fullness group to that of the new
  * fullness group.
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
@@ -964,7 +951,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
 	struct page *page, *next;
-	enum fullness_group fg;
+	int fg;
 	unsigned int class_idx;
 
 	get_zspage_mapping(zspage, &class_idx, &fg);
@@ -990,7 +977,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	cache_free_zspage(pool, zspage);
 
-	class_stat_dec(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage,
 					&pool->pages_allocated);
 }
@@ -1508,7 +1495,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 {
 	unsigned long handle, obj;
 	struct size_class *class;
-	enum fullness_group newfg;
+	int newfg;
 	struct zspage *zspage;
 
 	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
@@ -1530,7 +1517,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
-		class_stat_inc(class, OBJ_USED, 1);
+		class_stat_inc(class, ZS_OBJS_INUSE, 1);
 		spin_unlock(&pool->lock);
 
 		return handle;
@@ -1552,8 +1539,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage,
 				&pool->pages_allocated);
-	class_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
-	class_stat_inc(class, OBJ_USED, 1);
+	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_inc(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1609,7 +1596,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	struct page *f_page;
 	unsigned long obj;
 	struct size_class *class;
-	enum fullness_group fullness;
+	int fullness;
 
 	if (IS_ERR_OR_NULL((void *)handle))
 		return;
@@ -1624,7 +1611,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
 
-	class_stat_dec(class, OBJ_USED, 1);
+	class_stat_dec(class, ZS_OBJS_INUSE, 1);
 
 #ifdef CONFIG_ZPOOL
 	if (zspage->under_reclaim) {
@@ -1828,7 +1815,7 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
 {
 	int i;
 	struct zspage *zspage;
-	enum fullness_group fg[2] = {ZS_ALMOST_EMPTY, ZS_ALMOST_FULL};
+	int fg[2] = {ZS_ALMOST_EMPTY, ZS_ALMOST_FULL};
 
 	if (!source) {
 		fg[0] = ZS_ALMOST_FULL;
@@ -1852,12 +1839,11 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
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
@@ -2121,7 +2107,7 @@ static void async_free_zspage(struct work_struct *work)
 	int i;
 	struct size_class *class;
 	unsigned int class_idx;
-	enum fullness_group fullness;
+	int fullness;
 	struct zspage *zspage, *tmp;
 	LIST_HEAD(free_pages);
 	struct zs_pool *pool = container_of(work, struct zs_pool,
@@ -2190,8 +2176,8 @@ static inline void zs_flush_migration(struct zs_pool *pool) { }
 static unsigned long zs_can_compact(struct size_class *class)
 {
 	unsigned long obj_wasted;
-	unsigned long obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
-	unsigned long obj_used = zs_stat_get(class, OBJ_USED);
+	unsigned long obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
+	unsigned long obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
 
 	if (obj_allocated <= obj_used)
 		return 0;
@@ -2616,7 +2602,7 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
 	unsigned long handle;
 	struct zspage *zspage;
 	struct page *page;
-	enum fullness_group fullness;
+	int fullness;
 
 	/* Lock LRU and fullness list */
 	spin_lock(&pool->lock);
-- 
2.39.2.637.g21b0678d19-goog

