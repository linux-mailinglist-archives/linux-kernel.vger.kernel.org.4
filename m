Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7635B7986
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiIMS1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiIMS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F848C85
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 378506153C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372B1C43142;
        Tue, 13 Sep 2022 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091098;
        bh=NmwfN6rjHtuY0cGSf7TZTGlKmFrWA2cYVA41QNlR/mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4SBKtFVloi7aHyiVt/VGkmApQhdA9O4SPaKa4oro1nPzJrYjcjQHOxeK6yRUdh/h
         788AcjFDF9ERysE6ASER7jfwL1KMbwCD+qVljfPwskuYABnKGY5w+k2vMj3izd3NCi
         d5m+sW4ppjCbdaDx/fHvUjTdx1MXlDNcw8jG1cKidC39bZYg2napwAvyHsQQqWWhRW
         Sd5QA/aogI3AiExpbw1B8PzQ9py1HrKAYOGgEnGJGj+aDFMe4nOB3w42YATbdiATEE
         yDjt4qUcWFXWKas2AEIewEU3tu/Y5R40jgXCpCYSp0tDKJXOmq8Q5v/ZZsRQyaBoNL
         b840F7R8bMAng==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/22] mm/damon/core: use a dedicated struct for monitoring attributes
Date:   Tue, 13 Sep 2022 17:44:32 +0000
Message-Id: <20220913174449.50645-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
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

DAMON monitoring attributes are directly defined as fields of 'struct
damon_ctx'.  This makes 'struct damon_ctx' a little long and
complicated.  This commit defines and uses a struct, 'struct
damon_attrs', which is dedicated for only the monitoring attributes to
make the purpose of the five values clearer and simplify 'struct
damon_ctx'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 30 ++++++++++++++++++++----------
 mm/damon/core.c       | 34 +++++++++++++++++-----------------
 mm/damon/dbgfs.c      |  6 +++---
 mm/damon/ops-common.c |  4 ++--
 mm/damon/vaddr.c      |  4 ++--
 5 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 016b6c9c03d6..2ceee8b07726 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -389,13 +389,15 @@ struct damon_callback {
 };
 
 /**
- * struct damon_ctx - Represents a context for each monitoring.  This is the
- * main interface that allows users to set the attributes and get the results
- * of the monitoring.
+ * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
  * @ops_update_interval:	The time between monitoring operations updates.
+ * @min_nr_regions:		The minimum number of adaptive monitoring
+ *				regions.
+ * @max_nr_regions:		The maximum number of adaptive monitoring
+ *				regions.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
@@ -405,7 +407,21 @@ struct damon_callback {
  * @ops_update_interval.  All time intervals are in micro-seconds.
  * Please refer to &struct damon_operations and &struct damon_callback for more
  * detail.
+ */
+struct damon_attrs {
+	unsigned long sample_interval;
+	unsigned long aggr_interval;
+	unsigned long ops_update_interval;
+	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
+};
+
+/**
+ * struct damon_ctx - Represents a context for each monitoring.  This is the
+ * main interface that allows users to set the attributes and get the results
+ * of the monitoring.
  *
+ * @attrs:		Monitoring attributes for accuracy/overhead control.
  * @kdamond:		Kernel thread who does the monitoring.
  * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
  *
@@ -427,15 +443,11 @@ struct damon_callback {
  * @ops:	Set of monitoring operations for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
  *
- * @min_nr_regions:	The minimum number of adaptive monitoring regions.
- * @max_nr_regions:	The maximum number of adaptive monitoring regions.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
 struct damon_ctx {
-	unsigned long sample_interval;
-	unsigned long aggr_interval;
-	unsigned long ops_update_interval;
+	struct damon_attrs attrs;
 
 /* private: internal use only */
 	struct timespec64 last_aggregation;
@@ -448,8 +460,6 @@ struct damon_ctx {
 	struct damon_operations ops;
 	struct damon_callback callback;
 
-	unsigned long min_nr_regions;
-	unsigned long max_nr_regions;
 	struct list_head adaptive_targets;
 	struct list_head schemes;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6767580c0a27..1f43ea9d956c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -405,17 +405,17 @@ struct damon_ctx *damon_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
-	ctx->sample_interval = 5 * 1000;
-	ctx->aggr_interval = 100 * 1000;
-	ctx->ops_update_interval = 60 * 1000 * 1000;
+	ctx->attrs.sample_interval = 5 * 1000;
+	ctx->attrs.aggr_interval = 100 * 1000;
+	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
 
 	ktime_get_coarse_ts64(&ctx->last_aggregation);
 	ctx->last_ops_update = ctx->last_aggregation;
 
 	mutex_init(&ctx->kdamond_lock);
 
-	ctx->min_nr_regions = 10;
-	ctx->max_nr_regions = 1000;
+	ctx->attrs.min_nr_regions = 10;
+	ctx->attrs.max_nr_regions = 1000;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
@@ -471,11 +471,11 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 	if (min_nr_reg > max_nr_reg)
 		return -EINVAL;
 
-	ctx->sample_interval = sample_int;
-	ctx->aggr_interval = aggr_int;
-	ctx->ops_update_interval = ops_upd_int;
-	ctx->min_nr_regions = min_nr_reg;
-	ctx->max_nr_regions = max_nr_reg;
+	ctx->attrs.sample_interval = sample_int;
+	ctx->attrs.aggr_interval = aggr_int;
+	ctx->attrs.ops_update_interval = ops_upd_int;
+	ctx->attrs.min_nr_regions = min_nr_reg;
+	ctx->attrs.max_nr_regions = max_nr_reg;
 
 	return 0;
 }
@@ -530,8 +530,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 			sz += r->ar.end - r->ar.start;
 	}
 
-	if (ctx->min_nr_regions)
-		sz /= ctx->min_nr_regions;
+	if (ctx->attrs.min_nr_regions)
+		sz /= ctx->attrs.min_nr_regions;
 	if (sz < DAMON_MIN_REGION)
 		sz = DAMON_MIN_REGION;
 
@@ -680,7 +680,7 @@ static bool damon_check_reset_time_interval(struct timespec64 *baseline,
 static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
 {
 	return damon_check_reset_time_interval(&ctx->last_aggregation,
-			ctx->aggr_interval);
+			ctx->attrs.aggr_interval);
 }
 
 /*
@@ -1062,12 +1062,12 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx)
 		nr_regions += damon_nr_regions(t);
 
-	if (nr_regions > ctx->max_nr_regions / 2)
+	if (nr_regions > ctx->attrs.max_nr_regions / 2)
 		return;
 
 	/* Maybe the middle of the region has different access frequency */
 	if (last_nr_regions == nr_regions &&
-			nr_regions < ctx->max_nr_regions / 3)
+			nr_regions < ctx->attrs.max_nr_regions / 3)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
@@ -1085,7 +1085,7 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 static bool kdamond_need_update_operations(struct damon_ctx *ctx)
 {
 	return damon_check_reset_time_interval(&ctx->last_ops_update,
-			ctx->ops_update_interval);
+			ctx->attrs.ops_update_interval);
 }
 
 /*
@@ -1229,7 +1229,7 @@ static int kdamond_fn(void *data)
 				ctx->callback.after_sampling(ctx))
 			break;
 
-		kdamond_usleep(ctx->sample_interval);
+		kdamond_usleep(ctx->attrs.sample_interval);
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 1422037cedd2..74e7542af6d3 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -55,9 +55,9 @@ static ssize_t dbgfs_attrs_read(struct file *file,
 
 	mutex_lock(&ctx->kdamond_lock);
 	ret = scnprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
-			ctx->sample_interval, ctx->aggr_interval,
-			ctx->ops_update_interval, ctx->min_nr_regions,
-			ctx->max_nr_regions);
+			ctx->attrs.sample_interval, ctx->attrs.aggr_interval,
+			ctx->attrs.ops_update_interval,
+			ctx->attrs.min_nr_regions, ctx->attrs.max_nr_regions);
 	mutex_unlock(&ctx->kdamond_lock);
 
 	return simple_read_from_buffer(buf, count, ppos, kbuf, ret);
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index f599838b5f64..9310df72e1c5 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -99,10 +99,10 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	max_nr_accesses = c->aggr_interval / c->sample_interval;
+	max_nr_accesses = c->attrs.aggr_interval / c->attrs.sample_interval;
 	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
 
-	age_in_sec = (unsigned long)r->age * c->aggr_interval / 1000000;
+	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
 			age_in_log++, age_in_sec >>= 1)
 		;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 39ea48d9cc15..3f84584f9982 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -251,8 +251,8 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 
 	for (i = 0; i < 3; i++)
 		sz += regions[i].end - regions[i].start;
-	if (ctx->min_nr_regions)
-		sz /= ctx->min_nr_regions;
+	if (ctx->attrs.min_nr_regions)
+		sz /= ctx->attrs.min_nr_regions;
 	if (sz < DAMON_MIN_REGION)
 		sz = DAMON_MIN_REGION;
 
-- 
2.25.1

