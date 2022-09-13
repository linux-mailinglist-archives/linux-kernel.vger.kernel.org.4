Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E65B7761
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiIMRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiIMRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:11:20 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C5870BA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:00:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPhRr.u_1663082568;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPhRr.u_1663082568)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 23:22:49 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH] mm/damon: simplify scheme create in lru_sort.c
Date:   Tue, 13 Sep 2022 23:22:45 +0800
Message-Id: <20220913152245.25224-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
they have so much in common, so we can combine them into a single
function, and we just need to distinguish their differences.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/lru_sort.c | 82 +++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 8415e18fcf0e..62063ed43224 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -257,15 +257,15 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;

-/* Create a DAMON-based operation scheme for hot memory regions */
-static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
+static inline struct damos *damon_lru_sort_new_scheme(unsigned int thres,
+						      enum damos_action action)
 {
 	struct damos_access_pattern pattern = {
 		/* Find regions having PAGE_SIZE or larger size */
 		.min_sz_region = PAGE_SIZE,
 		.max_sz_region = ULONG_MAX,
 		/* and accessed for more than the threshold */
-		.min_nr_accesses = hot_thres,
+		.min_nr_accesses = 0,
 		.max_nr_accesses = UINT_MAX,
 		/* no matter its age */
 		.min_age_region = 0,
@@ -292,60 +292,38 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 		.weight_age = 0,
 	};

-	return damon_new_scheme(
-			&pattern,
-			/* prioritize those on LRU lists, as soon as found */
-			DAMOS_LRU_PRIO,
-			/* under the quota. */
-			&quota,
-			/* (De)activate this according to the watermarks. */
-			&wmarks);
+	switch (action) {
+	case DAMOS_LRU_PRIO:
+		pattern.min_nr_accesses = thres;
+		break;
+	case DAMOS_LRU_DEPRIO:
+		pattern.min_age_region = thres;
+		quota.weight_nr_accesses = 0;
+		quota.weight_age = 1;
+		break;
+	default:
+		return NULL;
+	}
+
+	return damon_new_scheme(&pattern,
+				/* mark those as not accessed, as soon as found */
+				action,
+				/* under the quota. */
+				&quota,
+				/* (De)activate this according to the watermarks. */
+				&wmarks);
+}
+
+/* Create a DAMON-based operation scheme for hot memory regions */
+static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
+{
+	return damon_lru_sort_new_scheme(hot_thres, DAMOS_LRU_PRIO);
 }

 /* Create a DAMON-based operation scheme for cold memory regions */
 static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and not accessed at all */
-		.min_nr_accesses = 0,
-		.max_nr_accesses = 0,
-		/* for min_age or more micro-seconds */
-		.min_age_region = cold_thres,
-		.max_age_region = UINT_MAX,
-	};
-	struct damos_watermarks wmarks = {
-		.metric = DAMOS_WMARK_FREE_MEM_RATE,
-		.interval = wmarks_interval,
-		.high = wmarks_high,
-		.mid = wmarks_mid,
-		.low = wmarks_low,
-	};
-	struct damos_quota quota = {
-		/*
-		 * Do not try LRU-lists sorting of cold pages for more than
-		 * half of quota_ms milliseconds within
-		 * quota_reset_interval_ms.
-		 */
-		.ms = quota_ms / 2,
-		.sz = 0,
-		.reset_interval = quota_reset_interval_ms,
-		/* Within the quota, mark colder regions not accessed first. */
-		.weight_sz = 0,
-		.weight_nr_accesses = 0,
-		.weight_age = 1,
-	};
-
-	return damon_new_scheme(
-			&pattern,
-			/* mark those as not accessed, as soon as found */
-			DAMOS_LRU_DEPRIO,
-			/* under the quota. */
-			&quota,
-			/* (De)activate this according to the watermarks. */
-			&wmarks);
+	return damon_lru_sort_new_scheme(cold_thres, DAMOS_LRU_DEPRIO);
 }

 static int damon_lru_sort_apply_parameters(void)
--
2.31.0
