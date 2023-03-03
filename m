Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94256A91BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCCHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCCHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:31:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567753D081
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:31:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i5so1859479pla.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaoqeXZv4LfGVEpTUejOz4FwTVyi9EWK7MkYs5EdeOk=;
        b=Y8E4rBHRosinda0OmWTLbAlFzsIJYcyRA86sK6m3/T1oYf+s7bbu9abW0fOfmRyqH6
         DgIia1zoJYEKGWghszZU9PMw1T64vinsuJwFEAjXC+tmQfefZMSQ5zlWHY6z+KFZwZTx
         h+L8bBXAVeU3YJfLbtRYUOCYby/LZbRFvFK0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaoqeXZv4LfGVEpTUejOz4FwTVyi9EWK7MkYs5EdeOk=;
        b=G2sNVCyqcescl+vL4+jnJ6i8dT5iYsl8pua4jBwA6m+UTORXzYKEDbQIxf6Emahhdg
         mCGPdXVf9l/JqU4FMcBerAhyndOxuf4El6Tez1jfXq1JniE4RnnyifjPIDqZ8MxdW9MN
         tNuTNGAQci6mBkCHegxsO/fy26vNSc1eYDE517vwhoRsbu1EegCD8cQ09gMJGr7/7s8u
         JAQwqCAzEORxkHkM00eked/5fkG3VQ/KQUQOV++NQ7Ba/9/7cvtFe6bHFi7srFt+1sW7
         95A07IiqdAwa030aLe9Ep5sP3z3w/DVeVL3AbBbr6027I+kslby35eoleRSQ7FQ5umL7
         fwng==
X-Gm-Message-State: AO0yUKU43FUOMiAw1Zn3is8BsUyoCDR6xFNqagmLGhrTeLPgzIxwrLyS
        wOSCOu0iQ7qgWE2v60KpGPICej/tBMs/h+Iq
X-Google-Smtp-Source: AK7set9hGk3rv6YT7DUxhYeRuULEgZmvpKwfvpjPcLe4uqMwh5iXUTEgTN2COTTPag0bPN9QqfIy4Q==
X-Received: by 2002:a05:6a20:938d:b0:cd:74aa:df76 with SMTP id x13-20020a056a20938d00b000cd74aadf76mr1600951pzh.50.1677828705810;
        Thu, 02 Mar 2023 23:31:45 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:badf:7e3e:d3f9:4956])
        by smtp.gmail.com with ESMTPSA id c18-20020aa781d2000000b005a8b4dcd21asm933439pfn.15.2023.03.02.23.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:31:45 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 3/4] zsmalloc: rework compaction algorithm
Date:   Fri,  3 Mar 2023 16:31:29 +0900
Message-Id: <20230303073130.1950714-4-senozhatsky@chromium.org>
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

The zsmalloc compaction algorithm has the potential to
waste some CPU cycles, particularly when compacting pages
within the same fullness group. This is due to the way it
selects the head page of the fullness list for source and
destination pages, and how it reinserts those pages during
each iteration. The algorithm may first use a page as a
migration destination and then as a migration source,
leading to an unnecessary back-and-forth movement of
objects.

Consider the following fullness list:

PageA PageB PageC PageD PageE

During the first iteration, the compaction algorithm will
select PageA as the source and PageB as the destination.
All of PageA's objects will be moved to PageB, and then
PageA will be released while PageB is reinserted into the
fullness list.

PageB PageC PageD PageE

During the next iteration, the compaction algorithm will
again select the head of the list as the source and destination,
meaning that PageB will now serve as the source and PageC as
the destination. This will result in the objects being moved
away from PageB, the same objects that were just moved to PageB
in the previous iteration.

To prevent this avalanche effect, the compaction algorithm
should not reinsert the destination page between iterations.
By doing so, the most optimal page will continue to be used
and its usage ratio will increase, reducing internal
fragmentation. The destination page should only be reinserted
into the fullness list if:
- It becomes full
- No source page is available.

TEST
====

It's very challenging to reliably test this series. I ended up
developing my own synthetic test that has 100% reproducibility.
The test generates significan fragmentation (for each size class)
and then performs compaction for each class individually and tracks
the number of memcpy() in zs_object_copy(), so that we can compare
the amount work compaction does on per-class basis.

Total amount of work (zram mm_stat objs_moved)
----------------------------------------------

Old fullness grouping, old compaction algorithm:
323977 memcpy() in zs_object_copy().

Old fullness grouping, new compaction algorithm:
262944 memcpy() in zs_object_copy().

New fullness grouping, new compaction algorithm:
213978 memcpy() in zs_object_copy().

Per-class compaction memcpy() comparison (T-test)
-------------------------------------------------

x Old fullness grouping, old compaction algorithm
+ Old fullness grouping, new compaction algorithm

    N           Min           Max        Median           Avg        Stddev
x 140           349          3513          2461     2314.1214     806.03271
+ 140           289          2778          2006     1878.1714     641.02073
Difference at 95.0% confidence
        -435.95 +/- 170.595
        -18.8387% +/- 7.37193%
        (Student's t, pooled s = 728.216)

x Old fullness grouping, old compaction algorithm
+ New fullness grouping, new compaction algorithm

    N           Min           Max        Median           Avg        Stddev
x 140           349          3513          2461     2314.1214     806.03271
+ 140           226          2279          1644     1528.4143     524.85268
Difference at 95.0% confidence
        -785.707 +/- 159.331
        -33.9527% +/- 6.88516%
        (Student's t, pooled s = 680.132)

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 78 ++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 630854575c30..141a3f69b642 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1780,15 +1780,14 @@ struct zs_compact_control {
 	int obj_idx;
 };
 
-static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
-				struct zs_compact_control *cc)
+static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
+			   struct zs_compact_control *cc)
 {
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
 	struct page *s_page = cc->s_page;
 	struct page *d_page = cc->d_page;
 	int obj_idx = cc->obj_idx;
-	int ret = 0;
 
 	while (1) {
 		handle = find_alloced_obj(class, s_page, &obj_idx);
@@ -1801,10 +1800,8 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		}
 
 		/* Stop if there is no more space */
-		if (zspage_full(class, get_zspage(d_page))) {
-			ret = -ENOMEM;
+		if (zspage_full(class, get_zspage(d_page)))
 			break;
-		}
 
 		used_obj = handle_to_obj(handle);
 		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
@@ -1817,8 +1814,6 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 	/* Remember last position in this iteration */
 	cc->s_page = s_page;
 	cc->obj_idx = obj_idx;
-
-	return ret;
 }
 
 static struct zspage *isolate_src_zspage(struct size_class *class)
@@ -2213,7 +2208,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 				  struct size_class *class)
 {
 	struct zs_compact_control cc;
-	struct zspage *src_zspage;
+	struct zspage *src_zspage = NULL;
 	struct zspage *dst_zspage = NULL;
 	unsigned long pages_freed = 0;
 
@@ -2222,50 +2217,45 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	spin_lock(&pool->lock);
-	while ((src_zspage = isolate_src_zspage(class))) {
-		/* protect someone accessing the zspage(i.e., zs_map_object) */
-		migrate_write_lock(src_zspage);
+	while (zs_can_compact(class)) {
+		int ret;
 
-		if (!zs_can_compact(class))
+		if (!dst_zspage) {
+			dst_zspage = isolate_dst_zspage(class);
+			if (!dst_zspage)
+				break;
+			migrate_write_lock(dst_zspage);
+			cc.d_page = get_first_page(dst_zspage);
+		}
+
+		src_zspage = isolate_src_zspage(class);
+		if (!src_zspage)
 			break;
 
+		migrate_write_lock_nested(src_zspage);
+
 		cc.obj_idx = 0;
 		cc.s_page = get_first_page(src_zspage);
+		migrate_zspage(pool, class, &cc);
+		ret = putback_zspage(class, src_zspage);
+		migrate_write_unlock(src_zspage);
 
-		while ((dst_zspage = isolate_dst_zspage(class))) {
-			migrate_write_lock_nested(dst_zspage);
-
-			cc.d_page = get_first_page(dst_zspage);
-			/*
-			 * If there is no more space in dst_page, resched
-			 * and see if anyone had allocated another zspage.
-			 */
-			if (!migrate_zspage(pool, class, &cc))
-				break;
+		if (ret == ZS_INUSE_RATIO_0) {
+			free_zspage(pool, class, src_zspage);
+			pages_freed += class->pages_per_zspage;
+			src_zspage = NULL;
+		}
 
+		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
+		    || spin_is_contended(&pool->lock)) {
 			putback_zspage(class, dst_zspage);
 			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
-			if (spin_is_contended(&pool->lock))
-				break;
-		}
 
-		/* Stop if we couldn't find slot */
-		if (dst_zspage == NULL)
-			break;
-
-		putback_zspage(class, dst_zspage);
-		migrate_write_unlock(dst_zspage);
-
-		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
-			migrate_write_unlock(src_zspage);
-			free_zspage(pool, class, src_zspage);
-			pages_freed += class->pages_per_zspage;
-		} else
-			migrate_write_unlock(src_zspage);
-		spin_unlock(&pool->lock);
-		cond_resched();
-		spin_lock(&pool->lock);
+			spin_unlock(&pool->lock);
+			cond_resched();
+			spin_lock(&pool->lock);
+		}
 	}
 
 	if (src_zspage) {
@@ -2273,6 +2263,10 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		migrate_write_unlock(src_zspage);
 	}
 
+	if (dst_zspage) {
+		putback_zspage(class, dst_zspage);
+		migrate_write_unlock(dst_zspage);
+	}
 	spin_unlock(&pool->lock);
 
 	return pages_freed;
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

