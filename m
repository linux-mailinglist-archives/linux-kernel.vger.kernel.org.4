Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0791E6AA7E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCDDtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCDDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:48:51 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0441C7E1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:48:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h8so4759162plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxRoi4TukkX6UlbjK9WtsqOLfwrBv6GFUJd0cC4XWDw=;
        b=PoJckSaXrWf6myxlSmql82ndp3fdHyLe8QuReRZtA53h8cgepOrcFc3wAxf5T+880d
         JxwL2bFvEx57bJWamf060g4cq+HktGLGh3pibGPW+OlzO+ceBhngA6O7ZtD+EcQopQ6T
         MaCJNdUlbXoZGJC2ah7Uxd+e2hfQW5hlYfvYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxRoi4TukkX6UlbjK9WtsqOLfwrBv6GFUJd0cC4XWDw=;
        b=jRDbnI+C4mJzrQJZWb8ccly74X40CJHnqqCsjjMuLEnY1gaWVVG/Jn3UWevu2+UCiJ
         2Zu7RUPNIGxRZd5eEIJsZaYKJWemtZvHxjuK2PmOxyP1CNrYd+TfxAK0HHPuFkw6jzWE
         D+kLLl/kmVBk3GIKCxCHXvyM1kRKaO1HVelNcI+j3S9xlOw7K0igsgRxPvbU0OLhYNqH
         DVZcztFftDbBjGX8LLhHsOrHfTupEV5VfGZF2UVsu9SmRTlvffJasyBAlE0h4CsLiCZY
         VmGoCOob6QCqwC6SiV616AMFt5j2SgdXPs0OEtJTpMBE6m3ymnjArI++O3YoOmY077Qn
         vBgQ==
X-Gm-Message-State: AO0yUKWh1Pc4I5zLuf3EgeAKnCvUAR3rgGKrrZ4JtSMXfKpCUuUOXfPV
        P07+uGdexFxYWZdW2Z7WjUHd/A==
X-Google-Smtp-Source: AK7set8zpcSUINaMZnuyOqbfw1GR5LVivHiboO47W0G55Vv1CAgAtziIWwGghZEnWnNpAu3eWy170Q==
X-Received: by 2002:a17:903:1cb:b0:19c:eaf0:9859 with SMTP id e11-20020a17090301cb00b0019ceaf09859mr5610861plh.38.1677901728469;
        Fri, 03 Mar 2023 19:48:48 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6ac2:6eee:5465:7ee6])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b00199025284b3sm2249204pld.151.2023.03.03.19.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:48:48 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 3/4] zsmalloc: rework compaction algorithm
Date:   Sat,  4 Mar 2023 12:48:34 +0900
Message-Id: <20230304034835.2082479-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230304034835.2082479-1-senozhatsky@chromium.org>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
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
index cc59336a966a..a61540afbb28 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1782,15 +1782,14 @@ struct zs_compact_control {
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
@@ -1803,10 +1802,8 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		}
 
 		/* Stop if there is no more space */
-		if (zspage_full(class, get_zspage(d_page))) {
-			ret = -ENOMEM;
+		if (zspage_full(class, get_zspage(d_page)))
 			break;
-		}
 
 		used_obj = handle_to_obj(handle);
 		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
@@ -1819,8 +1816,6 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 	/* Remember last position in this iteration */
 	cc->s_page = s_page;
 	cc->obj_idx = obj_idx;
-
-	return ret;
 }
 
 static struct zspage *isolate_src_zspage(struct size_class *class)
@@ -2216,7 +2211,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 				  struct size_class *class)
 {
 	struct zs_compact_control cc;
-	struct zspage *src_zspage;
+	struct zspage *src_zspage = NULL;
 	struct zspage *dst_zspage = NULL;
 	unsigned long pages_freed = 0;
 
@@ -2225,50 +2220,45 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	spin_lock(&pool->lock);
-	while ((src_zspage = isolate_src_zspage(class))) {
-		/* protect someone accessing the zspage(i.e., zs_map_object) */
-		migrate_write_lock(src_zspage);
+	while (zs_can_compact(class)) {
+		int fg;
 
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
+		fg = putback_zspage(class, src_zspage);
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
+		if (fg == ZS_INUSE_RATIO_0) {
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
@@ -2276,6 +2266,10 @@ static unsigned long __zs_compact(struct zs_pool *pool,
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

