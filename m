Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1A5B92B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIOChG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIOChD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:37:03 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745433360
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:37:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPqc0wr_1663209417;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPqc0wr_1663209417)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 10:36:58 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH V3] mm/damon: simplify scheme create in lru_sort.c
Date:   Thu, 15 Sep 2022 10:36:55 +0800
Message-Id: <20220915023655.41923-1-xhao@linux.alibaba.com>
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

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Changes from v2
(https://lore.kernel.org/linux-mm/20220914113859.37637-1-xhao@linux.alibaba.com/)
- Add static global 'struct damos_access_pattern' stub variable
---
 mm/damon/lru_sort.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 07a0908963fd..6a26c5822286 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -132,6 +132,18 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
 		cold_quota_exceeds);

+struct damos_access_pattern damon_lru_sort_stub_access_pattern = {
+	/* Find regions having PAGE_SIZE or larger size */
+	.min_sz_region = PAGE_SIZE,
+	.max_sz_region = ULONG_MAX,
+	/* and accessed for more than the threshold */
+	.min_nr_accesses = 0,
+	.max_nr_accesses = UINT_MAX,
+	/* no matter its age */
+	.min_age_region = 0,
+	.max_age_region = UINT_MAX,
+};
+
 static struct damon_ctx *ctx;
 static struct damon_target *target;

@@ -157,17 +169,9 @@ static struct damos *damon_lru_sort_new_scheme(
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and accessed for more than the threshold */
-		.min_nr_accesses = hot_thres,
-		.max_nr_accesses = UINT_MAX,
-		/* no matter its age */
-		.min_age_region = 0,
-		.max_age_region = UINT_MAX,
-	};
+	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;
+
+	pattern.min_nr_accesses = hot_thres;

 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
 }
@@ -175,17 +179,10 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
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
+	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;
+
+	pattern.max_nr_accesses = 0;
+	pattern.min_age_region = cold_thres;

 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
--
2.31.0
