Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939E5E9A40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiIZHL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiIZHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:11:34 -0400
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37617CE05
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:11:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQhSYSs_1664176264;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQhSYSs_1664176264)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 15:11:05 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH v1 2/2] mm/damon: use damon_region_size() in appropriate place
Date:   Mon, 26 Sep 2022 15:11:00 +0800
Message-Id: <20220926071100.76379-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220926071100.76379-1-xhao@linux.alibaba.com>
References: <20220926071100.76379-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many place, we can use damon_region_size() to instead of "r->ar.end -
r->ar.start".

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/core.c  | 17 ++++++++---------
 mm/damon/vaddr.c |  4 ++--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 74ab45b2c2f1..0368551c5a8b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -490,7 +490,7 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)

 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			sz += r->ar.end - r->ar.start;
+			sz += damon_region_size(r);
 	}

 	if (ctx->attrs.min_nr_regions)
@@ -673,7 +673,7 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;

-	sz = r->ar.end - r->ar.start;
+	sz = damon_region_size(r);
 	return s->pattern.min_sz_region <= sz &&
 		sz <= s->pattern.max_sz_region &&
 		s->pattern.min_nr_accesses <= r->nr_accesses &&
@@ -701,7 +701,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,

 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
-		unsigned long sz = r->ar.end - r->ar.start;
+		unsigned long sz = damon_region_size(r);
 		struct timespec64 begin, end;
 		unsigned long sz_applied = 0;

@@ -730,14 +730,14 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 				sz = ALIGN_DOWN(quota->charge_addr_from -
 						r->ar.start, DAMON_MIN_REGION);
 				if (!sz) {
-					if (r->ar.end - r->ar.start <=
-							DAMON_MIN_REGION)
+					if (damon_region_size(r) <=
+					    DAMON_MIN_REGION)
 						continue;
 					sz = DAMON_MIN_REGION;
 				}
 				damon_split_region_at(t, r, sz);
 				r = damon_next_region(r);
-				sz = r->ar.end - r->ar.start;
+				sz = damon_region_size(r);
 			}
 			quota->charge_target_from = NULL;
 			quota->charge_addr_from = 0;
@@ -842,8 +842,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 					continue;
 				score = c->ops.get_scheme_score(
 						c, t, r, s);
-				quota->histogram[score] +=
-					r->ar.end - r->ar.start;
+				quota->histogram[score] += damon_region_size(r);
 				if (score > max_score)
 					max_score = score;
 			}
@@ -962,7 +961,7 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 	int i;

 	damon_for_each_region_safe(r, next, t) {
-		sz_region = r->ar.end - r->ar.start;
+		sz_region = damon_region_size(r);

 		for (i = 0; i < nr_subs - 1 &&
 				sz_region > 2 * DAMON_MIN_REGION; i++) {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index ea94e0b2c311..bd1ac9db0f49 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -72,7 +72,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 		return -EINVAL;

 	orig_end = r->ar.end;
-	sz_orig = r->ar.end - r->ar.start;
+	sz_orig = damon_region_size(r);
 	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);

 	if (!sz_piece)
@@ -618,7 +618,7 @@ static unsigned long damos_madvise(struct damon_target *target,
 {
 	struct mm_struct *mm;
 	unsigned long start = PAGE_ALIGN(r->ar.start);
-	unsigned long len = PAGE_ALIGN(r->ar.end - r->ar.start);
+	unsigned long len = PAGE_ALIGN(damon_region_size(r));
 	unsigned long applied;

 	mm = damon_get_mm(target);
--
2.31.0
