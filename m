Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0635B7984
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiIMS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiIMS10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:27:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B536CD17
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E261DB8109A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC0DC43141;
        Tue, 13 Sep 2022 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091107;
        bh=Rt+6znKPHySLjT8sirY/weqR0AkuV9kF+fJNNSJrSSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZwfAFpo76S/yeZ9tvwi0xEeO6SrP80OCSrdIOOm02Nyb8iiWg+JIPr2SCcG/sW80
         gnBrwd1U3IPU9Liv+aDrK21/MXVScY/XaIh2yt4nsNeIY/HRe1UmNZKl7l7IZu8HaC
         BIfCeTAU9A3GYGQ+0NBz638hN7GosgelXDq71owqLS7N7JEbyYhIyZtOUun/3eEHIK
         XHgnLMeBinShgZ7zdH0SHzL6noiiB1AOHt2TNlGrk9bJXrPJ/foMZ9JdYG5omTjfV/
         ZqccItcLesNgd1WLLZtIovibYzdtBdlIXcoC0qZsLGNzCymQ22DETnD6N50VQGByU0
         6r5AP78PmqOkg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/22] mm/damon/reclaim: use the quota params generator macro
Date:   Tue, 13 Sep 2022 17:44:47 +0000
Message-Id: <20220913174449.50645-21-sj@kernel.org>
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

This commit makes DAMON_RECLAIM to generate the module parameters for
DAMOS quotas using the generator macro to simplify the code and reduce
duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 64 +++++++++-------------------------------------
 1 file changed, 12 insertions(+), 52 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 1ef8353ac15a..1acf808e1624 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -52,44 +52,17 @@ module_param(commit_inputs, bool, 0600);
 static unsigned long min_age __read_mostly = 120000000;
 module_param(min_age, ulong, 0600);
 
-/*
- * Limit of time for trying the reclamation in milliseconds.
- *
- * DAMON_RECLAIM tries to use only up to this time within a time window
- * (quota_reset_interval_ms) for trying reclamation of cold pages.  This can be
- * used for limiting CPU consumption of DAMON_RECLAIM.  If the value is zero,
- * the limit is disabled.
- *
- * 10 ms by default.
- */
-static unsigned long quota_ms __read_mostly = 10;
-module_param(quota_ms, ulong, 0600);
-
-/*
- * Limit of size of memory for the reclamation in bytes.
- *
- * DAMON_RECLAIM charges amount of memory which it tried to reclaim within a
- * time window (quota_reset_interval_ms) and makes no more than this limit is
- * tried.  This can be used for limiting consumption of CPU and IO.  If this
- * value is zero, the limit is disabled.
- *
- * 128 MiB by default.
- */
-static unsigned long quota_sz __read_mostly = 128 * 1024 * 1024;
-module_param(quota_sz, ulong, 0600);
-
-/*
- * The time/size quota charge reset interval in milliseconds.
- *
- * The charge reset interval for the quota of time (quota_ms) and size
- * (quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
- * quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
- * milliseconds.
- *
- * 1 second by default.
- */
-static unsigned long quota_reset_interval_ms __read_mostly = 1000;
-module_param(quota_reset_interval_ms, ulong, 0600);
+static struct damos_quota damon_reclaim_quota = {
+	/* use up to 10 ms time, reclaim up to 128 MiB per 1 sec by default */
+	.ms = 10,
+	.sz = 128 * 1024 * 1024,
+	.reset_interval = 1000,
+	/* Within the quota, page out older regions first. */
+	.weight_sz = 0,
+	.weight_nr_accesses = 0,
+	.weight_age = 1
+};
+DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_reclaim_quota);
 
 struct damos_watermarks damon_reclaim_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
@@ -157,26 +130,13 @@ static struct damos *damon_reclaim_new_scheme(void)
 			damon_reclaim_mon_attrs.aggr_interval,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_quota quota = {
-		/*
-		 * Do not try reclamation for more than quota_ms milliseconds
-		 * or quota_sz bytes within quota_reset_interval_ms.
-		 */
-		.ms = quota_ms,
-		.sz = quota_sz,
-		.reset_interval = quota_reset_interval_ms,
-		/* Within the quota, page out older regions first. */
-		.weight_sz = 0,
-		.weight_nr_accesses = 0,
-		.weight_age = 1
-	};
 
 	return damon_new_scheme(
 			&pattern,
 			/* page out those, as soon as found */
 			DAMOS_PAGEOUT,
 			/* under the quota. */
-			&quota,
+			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_reclaim_wmarks);
 }
-- 
2.25.1

