Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9EE5B7982
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiIMS3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiIMS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:27:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15C5FF7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC21B80CBC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EF1C433B5;
        Tue, 13 Sep 2022 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091105;
        bh=u1GfgXM7mUjFBfeDP+toubTJ/FRGtWide9LOC5L8HRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANJQGfxDIqc7hST47btF5G7cY3Nee8GwTbGmGlsyCZgW1CwnmWLuo9umE9c4I5Wcu
         je75w/e6+bs6GhWiu5jU0uWr6tsdyJnyx7KakgcBUCnItnQiuKx2beptNm5L10MVBQ
         5+VP+IYMUcmWekPd9cPkrxVuSQXVE/8Xi/QnvBfbBK67yZFGAGIlteruYBTU5w6/1W
         S99pkLn7F9RQO1J224scXWadm8tUI6K1/dK8BY3VksIg3gDbDknbNKMBzVoGKSXLoW
         u8OXgargc7ImYJbe2WTEJMMGA9PFXtQUezXf0+T9/OMMAjuU0RAB+fI3fMKyprPrBS
         JU/FTvru15AsQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/22] mm/damon/lru_sort: use stat generator
Date:   Tue, 13 Sep 2022 17:44:44 +0000
Message-Id: <20220913174449.50645-18-sj@kernel.org>
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

This commit makes DAMON_LRU_SORT to generate the module parameters for
DAMOS statistics using the generator macro to simplify the code and
reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 83 +++++++--------------------------------------
 1 file changed, 12 insertions(+), 71 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 20760b39b50a..13a752aed272 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -135,65 +135,15 @@ module_param(monitor_region_end, ulong, 0600);
 static int kdamond_pid __read_mostly = -1;
 module_param(kdamond_pid, int, 0400);
 
-/*
- * Number of hot memory regions that tried to be LRU-sorted.
- */
-static unsigned long nr_lru_sort_tried_hot_regions __read_mostly;
-module_param(nr_lru_sort_tried_hot_regions, ulong, 0400);
-
-/*
- * Total bytes of hot memory regions that tried to be LRU-sorted.
- */
-static unsigned long bytes_lru_sort_tried_hot_regions __read_mostly;
-module_param(bytes_lru_sort_tried_hot_regions, ulong, 0400);
-
-/*
- * Number of hot memory regions that successfully be LRU-sorted.
- */
-static unsigned long nr_lru_sorted_hot_regions __read_mostly;
-module_param(nr_lru_sorted_hot_regions, ulong, 0400);
-
-/*
- * Total bytes of hot memory regions that successfully be LRU-sorted.
- */
-static unsigned long bytes_lru_sorted_hot_regions __read_mostly;
-module_param(bytes_lru_sorted_hot_regions, ulong, 0400);
-
-/*
- * Number of times that the time quota limit for hot regions have exceeded
- */
-static unsigned long nr_hot_quota_exceeds __read_mostly;
-module_param(nr_hot_quota_exceeds, ulong, 0400);
+static struct damos_stat damon_lru_sort_hot_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_hot_stat,
+		lru_sort_tried_hot_regions, lru_sorted_hot_regions,
+		hot_quota_exceeds);
 
-/*
- * Number of cold memory regions that tried to be LRU-sorted.
- */
-static unsigned long nr_lru_sort_tried_cold_regions __read_mostly;
-module_param(nr_lru_sort_tried_cold_regions, ulong, 0400);
-
-/*
- * Total bytes of cold memory regions that tried to be LRU-sorted.
- */
-static unsigned long bytes_lru_sort_tried_cold_regions __read_mostly;
-module_param(bytes_lru_sort_tried_cold_regions, ulong, 0400);
-
-/*
- * Number of cold memory regions that successfully be LRU-sorted.
- */
-static unsigned long nr_lru_sorted_cold_regions __read_mostly;
-module_param(nr_lru_sorted_cold_regions, ulong, 0400);
-
-/*
- * Total bytes of cold memory regions that successfully be LRU-sorted.
- */
-static unsigned long bytes_lru_sorted_cold_regions __read_mostly;
-module_param(bytes_lru_sorted_cold_regions, ulong, 0400);
-
-/*
- * Number of times that the time quota limit for cold regions have exceeded
- */
-static unsigned long nr_cold_quota_exceeds __read_mostly;
-module_param(nr_cold_quota_exceeds, ulong, 0400);
+static struct damos_stat damon_lru_sort_cold_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
+		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
+		cold_quota_exceeds);
 
 static struct damon_ctx *ctx;
 static struct damon_target *target;
@@ -397,19 +347,10 @@ static int damon_lru_sort_after_aggregation(struct damon_ctx *c)
 
 	/* update the stats parameter */
 	damon_for_each_scheme(s, c) {
-		if (s->action == DAMOS_LRU_PRIO) {
-			nr_lru_sort_tried_hot_regions = s->stat.nr_tried;
-			bytes_lru_sort_tried_hot_regions = s->stat.sz_tried;
-			nr_lru_sorted_hot_regions = s->stat.nr_applied;
-			bytes_lru_sorted_hot_regions = s->stat.sz_applied;
-			nr_hot_quota_exceeds = s->stat.qt_exceeds;
-		} else if (s->action == DAMOS_LRU_DEPRIO) {
-			nr_lru_sort_tried_cold_regions = s->stat.nr_tried;
-			bytes_lru_sort_tried_cold_regions = s->stat.sz_tried;
-			nr_lru_sorted_cold_regions = s->stat.nr_applied;
-			bytes_lru_sorted_cold_regions = s->stat.sz_applied;
-			nr_cold_quota_exceeds = s->stat.qt_exceeds;
-		}
+		if (s->action == DAMOS_LRU_PRIO)
+			damon_lru_sort_hot_stat = s->stat;
+		else if (s->action == DAMOS_LRU_DEPRIO)
+			damon_lru_sort_cold_stat = s->stat;
 	}
 
 	return damon_lru_sort_handle_commit_inputs();
-- 
2.25.1

