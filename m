Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FE75B4184
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiIIVgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIIVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B701251BF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A045620A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 21:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB63C433D7;
        Fri,  9 Sep 2022 21:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662759372;
        bh=ivNYXsY7JT+JXLG0HOg36KXU8sEFg67K/OLLAMuJcZY=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9c1qXkiJdMQpkq7YgN/YPgpYoFyTc+tgS0K/WISPY1115ZTfXWDkwkG4h9V6uqp+
         seheIZW0rtd9+Rd9hHEEZuUGs72LKbsxYkjDfIjfysy3KclwE6urxDVIvNEOKnTogB
         GT2dXLnWrs2hmsuVF0Uumtp3+Mr0PWauePX6wZSbpNy/DKu+2mUwjr+l5daIEWle4B
         U6guOWCLxJCkXqE9Oj4NLgFvrnn8sjw5LgTrNrmZt8GwlFsopeB92Mby8irPBrD+o4
         t7eKV3zWo9IsH7HP+Z+7F2OapbAoNsvlMotdniIoi1T/6osPUme0l5qqD99utRVUVr
         2D5zu5ut7sndw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v5] mm/damon: remove duplicate get_monitoring_region() definitions
Date:   Fri,  9 Sep 2022 21:36:06 +0000
Message-Id: <20220909213606.136221-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Hao <xhao@linux.alibaba.com>

In lru_sort.c and reclaim.c, they are all defining
get_monitoring_region() function, there is no need to define it
separately.

As 'get_monitoring_region()' is not a 'static' function anymore, we try
to use a prefix to distinguish with other functions, so there rename it
to 'damon_find_biggest_system_ram'.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v4
(https://lore.kernel.org/damon/20220909024105.84831-1-xhao@linux.alibaba.com/)
- Fix trivial cosmetic nits (SeongJae Park)
- Move definition of the new struct to core.c (SeongJae Park)

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/lru_sort.c   | 37 ++-----------------------------------
 mm/damon/reclaim.c    | 37 ++-----------------------------------
 4 files changed, 46 insertions(+), 70 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 90f20675da22..016b6c9c03d6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -549,6 +549,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
+bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
+
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6f6c9c9aca9d..325365939308 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1239,4 +1239,44 @@ static int kdamond_fn(void *data)
 	return 0;
 }
 
+/*
+ * struct damon_system_ram_region - System RAM resource address region of
+ *				    [@start, @end).
+ * @start:	Start address of the region (inclusive).
+ * @end:	End address of the region (exclusive).
+ */
+struct damon_system_ram_region {
+	unsigned long start;
+	unsigned long end;
+};
+
+static int walk_system_ram(struct resource *res, void *arg)
+{
+	struct damon_system_ram_region *a = arg;
+
+	if (a->end - a->start < resource_size(res)) {
+		a->start = res->start;
+		a->end = res->end;
+	}
+	return 0;
+}
+
+/*
+ * Find biggest 'System RAM' resource and store its start and end address in
+ * @start and @end, respectively.  If no System RAM is found, returns false.
+ */
+bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
+
+{
+	struct damon_system_ram_region arg = {};
+
+	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
+	if (arg.end <= arg.start)
+		return false;
+
+	*start = arg.start;
+	*end = arg.end;
+	return true;
+}
+
 #include "core-test.h"
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 0184ed4828b7..8415e18fcf0e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -257,39 +257,6 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-struct damon_lru_sort_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct damon_lru_sort_ram_walk_arg *a = arg;
-
-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
-{
-	struct damon_lru_sort_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
-		return false;
-
-	*start = arg.start;
-	*end = arg.end;
-	return true;
-}
-
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
@@ -414,8 +381,8 @@ static int damon_lru_sort_apply_parameters(void)
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
 	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
+	    !damon_find_biggest_system_ram(&monitor_region_start,
+					   &monitor_region_end))
 		return -EINVAL;
 	addr_range.start = monitor_region_start;
 	addr_range.end = monitor_region_end;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 5aeca0b9e88e..fe7bc0c55ecb 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -229,39 +229,6 @@ module_param(nr_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-struct damon_reclaim_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct damon_reclaim_ram_walk_arg *a = arg;
-
-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
-{
-	struct damon_reclaim_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
-		return false;
-
-	*start = arg.start;
-	*end = arg.end;
-	return true;
-}
-
 static struct damos *damon_reclaim_new_scheme(void)
 {
 	struct damos_access_pattern pattern = {
@@ -328,8 +295,8 @@ static int damon_reclaim_apply_parameters(void)
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
 	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
+	    !damon_find_biggest_system_ram(&monitor_region_start,
+					   &monitor_region_end))
 		return -EINVAL;
 	addr_range.start = monitor_region_start;
 	addr_range.end = monitor_region_end;
-- 
2.25.1

