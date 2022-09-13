Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08C55B7980
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiIMS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIMS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:27:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884056D54A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67D73B81095
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9C5C4347C;
        Tue, 13 Sep 2022 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091108;
        bh=vDKNHhOgxvXdmTbnCpBFmnMIFqpdFy3QEkyiK51v7wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0yD8AsuLcJY/gdEyZtKUR8q1Ts7XNhquj3lx0IpkCYiMXfHclxM34eS35xvz5mGh
         fkuMV0nRyR0ro+vFojhppd4ac+A71wrZJNunIKAb5DtvrNoKoDnH6zOCHz6tmFkbmK
         3QsXvf5zG2B6yuDePFY3HZ6FDO/KlfqqjANqTebR/1yB+9XeztxD5Hthie3KR0QJNX
         oR4tOs2/ML/GJ4AKnMgp+nZfnQBn0bDVsunxi2qkG5CHaItsMPVwFvj62tHHPZJhuz
         y/1ytxtrSdHS19LaXn3XYOkYz6YMzbI6S06WFBSegLR4f6HdEb2eqeVVQE9WXnjsfh
         0qImovxL20cRA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/22] mm/damon/lru_sort: use quotas param generator
Date:   Tue, 13 Sep 2022 17:44:48 +0000
Message-Id: <20220913174449.50645-22-sj@kernel.org>
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
DAMOS watermarks using the generator macro to simplify the code and
reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 70 ++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 13a752aed272..8d9c3d1fd6be 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -65,30 +65,17 @@ module_param(hot_thres_access_freq, ulong, 0600);
 static unsigned long cold_min_age __read_mostly = 120000000;
 module_param(cold_min_age, ulong, 0600);
 
-/*
- * Limit of time for trying the LRU lists sorting in milliseconds.
- *
- * DAMON_LRU_SORT tries to use only up to this time within a time window
- * (quota_reset_interval_ms) for trying LRU lists sorting.  This can be used
- * for limiting CPU consumption of DAMON_LRU_SORT.  If the value is zero, the
- * limit is disabled.
- *
- * 10 ms by default.
- */
-static unsigned long quota_ms __read_mostly = 10;
-module_param(quota_ms, ulong, 0600);
-
-/*
- * The time quota charge reset interval in milliseconds.
- *
- * The charge reset interval for the quota of time (quota_ms).  That is,
- * DAMON_LRU_SORT does not try LRU-lists sorting for more than quota_ms
- * milliseconds or quota_sz bytes within quota_reset_interval_ms milliseconds.
- *
- * 1 second by default.
- */
-static unsigned long quota_reset_interval_ms __read_mostly = 1000;
-module_param(quota_reset_interval_ms, ulong, 0600);
+static struct damos_quota damon_lru_sort_quota = {
+	/* Use up to 10 ms per 1 sec, by default */
+	.ms = 10,
+	.sz = 0,
+	.reset_interval = 1000,
+	/* Within the quota, mark hotter regions accessed first. */
+	.weight_sz = 0,
+	.weight_nr_accesses = 1,
+	.weight_age = 0,
+};
+DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_lru_sort_quota);
 
 struct damos_watermarks damon_lru_sort_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
@@ -162,19 +149,10 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 		.min_age_region = 0,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_quota quota = {
-		/*
-		 * Do not try LRU-lists sorting of hot pages for more than half
-		 * of quota_ms milliseconds within quota_reset_interval_ms.
-		 */
-		.ms = quota_ms / 2,
-		.sz = 0,
-		.reset_interval = quota_reset_interval_ms,
-		/* Within the quota, mark hotter regions accessed first. */
-		.weight_sz = 0,
-		.weight_nr_accesses = 1,
-		.weight_age = 0,
-	};
+	struct damos_quota quota = damon_lru_sort_quota;
+
+	/* Use half of total quota for hot pages sorting */
+	quota.ms = quota.ms / 2;
 
 	return damon_new_scheme(
 			&pattern,
@@ -200,20 +178,10 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 		.min_age_region = cold_thres,
 		.max_age_region = UINT_MAX,
 	};
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
+	struct damos_quota quota = damon_lru_sort_quota;
+
+	/* Use half of total quota for cold pages sorting */
+	quota.ms = quota.ms / 2;
 
 	return damon_new_scheme(
 			&pattern,
-- 
2.25.1

