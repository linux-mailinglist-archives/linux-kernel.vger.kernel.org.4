Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCC5B7988
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiIMS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiIMS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E05A892
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7083D61548
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D303CC433D7;
        Tue, 13 Sep 2022 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091099;
        bh=c3UYaFklJ4IkklkRS/0v+7Mz4UKLXpTsJ9YYL0g2LqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtvTIxy7OnysXwf/omjA/JoG6upB+Jyt+XBlqrSnddezs7pp/rSW39R6eoTLcbsqU
         uk52UePf1qOHcxJKzZHrU3UvlGlBTLDhkieL8vMfIB2N0S8gKGmkX6fkABKbTVB1Vj
         jfDbradKvvSm5mH6JErdjo7/tRL+LYqXCDTSO8tgN4BY8eG5xvyux17S0jPXu4awq5
         pDWnWET8pfClirlz6ON4xEYC6bmgyQHxQuVmlz2Vkes2AeBqJ/qyM6xQgrX9r92FSU
         M/Vkzwm6168kmlq6LlnOpDtQhQX1Q6yrC4Rel+bN3Jr4TKowvbFt28NcSMlRqrFC/+
         k9rlzenfG6DpA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] mm/damon/core: reduce parameters for damon_set_attrs()
Date:   Tue, 13 Sep 2022 17:44:33 +0000
Message-Id: <20220913174449.50645-7-sj@kernel.org>
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

Number of parameters for 'damon_set_attrs()' is six.  As it could be
confusing and verbose, this commit reduces the number by receiving
single pointer to a 'struct damon_attrs'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  4 +---
 mm/damon/core.c       | 21 +++++----------------
 mm/damon/dbgfs.c      |  9 ++++++---
 mm/damon/lru_sort.c   | 10 ++++++++--
 mm/damon/reclaim.c    | 10 ++++++++--
 mm/damon/sysfs.c      | 12 ++++++++----
 6 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2ceee8b07726..c5dc0c77c772 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -540,9 +540,7 @@ unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
-int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long ops_upd_int,
-		unsigned long min_nr_reg, unsigned long max_nr_reg);
+int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
 int damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_nr_running_ctxs(void);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1f43ea9d956c..d9d1bebc6a78 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -451,32 +451,21 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 /**
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
- * @sample_int:		time interval between samplings
- * @aggr_int:		time interval between aggregations
- * @ops_upd_int:	time interval between monitoring operations updates
- * @min_nr_reg:		minimal number of regions
- * @max_nr_reg:		maximum number of regions
+ * @attrs:		monitoring attributes
  *
  * This function should not be called while the kdamond is running.
  * Every time interval is in micro-seconds.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		    unsigned long aggr_int, unsigned long ops_upd_int,
-		    unsigned long min_nr_reg, unsigned long max_nr_reg)
+int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 {
-	if (min_nr_reg < 3)
+	if (attrs->min_nr_regions < 3)
 		return -EINVAL;
-	if (min_nr_reg > max_nr_reg)
+	if (attrs->min_nr_regions > attrs->max_nr_regions)
 		return -EINVAL;
 
-	ctx->attrs.sample_interval = sample_int;
-	ctx->attrs.aggr_interval = aggr_int;
-	ctx->attrs.ops_update_interval = ops_upd_int;
-	ctx->attrs.min_nr_regions = min_nr_reg;
-	ctx->attrs.max_nr_regions = max_nr_reg;
-
+	ctx->attrs = *attrs;
 	return 0;
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 74e7542af6d3..c00eba4448d8 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -67,7 +67,7 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
-	unsigned long s, a, r, minr, maxr;
+	struct damon_attrs attrs;
 	char *kbuf;
 	ssize_t ret;
 
@@ -76,7 +76,10 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 		return PTR_ERR(kbuf);
 
 	if (sscanf(kbuf, "%lu %lu %lu %lu %lu",
-				&s, &a, &r, &minr, &maxr) != 5) {
+				&attrs.sample_interval, &attrs.aggr_interval,
+				&attrs.ops_update_interval,
+				&attrs.min_nr_regions,
+				&attrs.max_nr_regions) != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -87,7 +90,7 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 		goto unlock_out;
 	}
 
-	ret = damon_set_attrs(ctx, s, a, r, minr, maxr);
+	ret = damon_set_attrs(ctx, &attrs);
 	if (!ret)
 		ret = count;
 unlock_out:
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 307ba71adcfa..6d5f83965276 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -350,13 +350,19 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 
 static int damon_lru_sort_apply_parameters(void)
 {
+	struct damon_attrs attrs = {
+		.sample_interval = sample_interval,
+		.aggr_interval = aggr_interval,
+		.ops_update_interval = 0,
+		.min_nr_regions = min_nr_regions,
+		.max_nr_regions = max_nr_regions,
+	};
 	struct damos *scheme;
 	struct damon_addr_range addr_range;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
-	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
-			min_nr_regions, max_nr_regions);
+	err = damon_set_attrs(ctx, &attrs);
 	if (err)
 		return err;
 
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index fe7bc0c55ecb..bc841efbab45 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -275,12 +275,18 @@ static struct damos *damon_reclaim_new_scheme(void)
 
 static int damon_reclaim_apply_parameters(void)
 {
+	struct damon_attrs attrs = {
+		.sample_interval = sample_interval,
+		.aggr_interval = aggr_interval,
+		.ops_update_interval = 0,
+		.min_nr_regions = min_nr_regions,
+		.max_nr_regions = max_nr_regions,
+	};
 	struct damos *scheme;
 	struct damon_addr_range addr_range;
 	int err = 0;
 
-	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
-			min_nr_regions, max_nr_regions);
+	err = damon_set_attrs(ctx, &attrs);
 	if (err)
 		return err;
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3606eec9b65d..1fa0023f136e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2130,10 +2130,14 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	struct damon_sysfs_intervals *sys_intervals = sys_attrs->intervals;
 	struct damon_sysfs_ul_range *sys_nr_regions =
 		sys_attrs->nr_regions_range;
-
-	return damon_set_attrs(ctx, sys_intervals->sample_us,
-			sys_intervals->aggr_us, sys_intervals->update_us,
-			sys_nr_regions->min, sys_nr_regions->max);
+	struct damon_attrs attrs = {
+		.sample_interval = sys_intervals->sample_us,
+		.aggr_interval = sys_intervals->aggr_us,
+		.ops_update_interval = sys_intervals->update_us,
+		.min_nr_regions = sys_nr_regions->min,
+		.max_nr_regions = sys_nr_regions->max,
+	};
+	return damon_set_attrs(ctx, &attrs);
 }
 
 static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
-- 
2.25.1

