Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8660BD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiJXW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiJXW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CD857D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAE8AB81219
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11B0C4347C;
        Mon, 24 Oct 2022 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644567;
        bh=dahNXHHpseZsI9Nv09e0SATucdrpYMf1XoLkXw98+8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T00bDNA9EM4Dfry8euvfrqLlGlmknH7wo3tkSrHReFZBihrsinlKvK2L6eYULPQ71
         CEhWRzbBenBjIaZ4xywgYNePssRTPlLGv/TTZf2YahCGZ60rbcYuw6AALjOMWfphHY
         HltEqsgeCd1Q2xSuMHVmc+QmHO8G4GK2irj3nbqXCjkypNOKBzV3T9OpuJJU2Qz4zs
         q/0wlkJgkK3VcA8eTX7mBjy1aVzt+LXhrDDU0SF4KiUt6htMt6fa0XPXmcPrsu5ma2
         5ZXYR6syB+bRWAl1LEBPvVsA5Ld3jN8MhWF+d3+jxfZgkGEDDO1IGv+5OCvKqa7Wgq
         VD4zGhLaNXxtw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] mm/damon/core: split out scheme quota adjustment logic into a new function
Date:   Mon, 24 Oct 2022 20:49:12 +0000
Message-Id: <20221024204919.18524-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMOS quota adjustment logic in 'kdamond_apply_schemes()', has some
amount of code, and the logic is not so straightforward.  Split it out
to a new function for better readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 91 ++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3a810c6e26bc..80d5937fe337 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -848,59 +848,64 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	quota->esz = esz;
 }
 
-static void kdamond_apply_schemes(struct damon_ctx *c)
+static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
-	struct damos *s;
+	struct damon_region *r;
+	unsigned long cumulated_sz;
+	unsigned int score, max_score = 0;
 
-	damon_for_each_scheme(s, c) {
-		struct damos_quota *quota = &s->quota;
-		unsigned long cumulated_sz;
-		unsigned int score, max_score = 0;
+	if (!quota->ms && !quota->sz)
+		return;
 
-		if (!s->wmarks.activated)
-			continue;
+	/* New charge window starts */
+	if (time_after_eq(jiffies, quota->charged_from +
+				msecs_to_jiffies(quota->reset_interval))) {
+		if (quota->esz && quota->charged_sz >= quota->esz)
+			s->stat.qt_exceeds++;
+		quota->total_charged_sz += quota->charged_sz;
+		quota->charged_from = jiffies;
+		quota->charged_sz = 0;
+		damos_set_effective_quota(quota);
+	}
 
-		if (!quota->ms && !quota->sz)
-			continue;
+	if (!c->ops.get_scheme_score)
+		return;
 
-		/* New charge window starts */
-		if (time_after_eq(jiffies, quota->charged_from +
-					msecs_to_jiffies(
-						quota->reset_interval))) {
-			if (quota->esz && quota->charged_sz >= quota->esz)
-				s->stat.qt_exceeds++;
-			quota->total_charged_sz += quota->charged_sz;
-			quota->charged_from = jiffies;
-			quota->charged_sz = 0;
-			damos_set_effective_quota(quota);
+	/* Fill up the score histogram */
+	memset(quota->histogram, 0, sizeof(quota->histogram));
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			if (!__damos_valid_target(r, s))
+				continue;
+			score = c->ops.get_scheme_score(c, t, r, s);
+			quota->histogram[score] += damon_sz_region(r);
+			if (score > max_score)
+				max_score = score;
 		}
+	}
 
-		if (!c->ops.get_scheme_score)
-			continue;
+	/* Set the min score limit */
+	for (cumulated_sz = 0, score = max_score; ; score--) {
+		cumulated_sz += quota->histogram[score];
+		if (cumulated_sz >= quota->esz || !score)
+			break;
+	}
+	quota->min_score = score;
+}
 
-		/* Fill up the score histogram */
-		memset(quota->histogram, 0, sizeof(quota->histogram));
-		damon_for_each_target(t, c) {
-			damon_for_each_region(r, t) {
-				if (!__damos_valid_target(r, s))
-					continue;
-				score = c->ops.get_scheme_score(
-						c, t, r, s);
-				quota->histogram[score] += damon_sz_region(r);
-				if (score > max_score)
-					max_score = score;
-			}
-		}
+static void kdamond_apply_schemes(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r, *next_r;
+	struct damos *s;
 
-		/* Set the min score limit */
-		for (cumulated_sz = 0, score = max_score; ; score--) {
-			cumulated_sz += quota->histogram[score];
-			if (cumulated_sz >= quota->esz || !score)
-				break;
-		}
-		quota->min_score = score;
+	damon_for_each_scheme(s, c) {
+		if (!s->wmarks.activated)
+			continue;
+
+		damos_adjust_quota(c, s);
 	}
 
 	damon_for_each_target(t, c) {
-- 
2.25.1

