Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6D60BD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJXW2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJXW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE4E09B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6908615AF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64AEC433B5;
        Mon, 24 Oct 2022 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644566;
        bh=6gkbB+R8KOY+SdO75f4hZZPeo2cZLZlMbp4Q5xwVX/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2JE8BUc9CDzQp8FHIo00S+bYyfg76YGiWY77fybUWWKCKCkKvkBlapFcVAkJdT21
         OyxQuZehDJkhV+fP/ZKHNJWb13Rey5FR6GVzdWCAY4xyrPPAIW+b80ttkTMwmpK2xu
         ke0PoM0FOADZxag6l+3amaoXlIviMs5WIcrJORGgk4VIXyAPBnphiALkNMpTOg1Oo1
         LJ7U8LoA3eQ7peUhonZAUQAYxYnDw6fU1OyOyV89AaLor7qP2Vd/lbkd2ph5hYdjfZ
         1dTpra6wHkod4UAhw4OzrSI5lszp2jrdqOeLeUDl0EsiTc9F1Y1kBZ+49hmQp5zuPH
         y7FhKrdRFSINg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] mm/damon/core: split damos application logic into a new function
Date:   Mon, 24 Oct 2022 20:49:10 +0000
Message-Id: <20221024204919.18524-3-sj@kernel.org>
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

The DAMOS action applying function, 'damon_do_apply_schemes()', is still
long and not easy to read.  Split out the code for applying a single
action to a single region into a new function for better readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 73 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 06b50ede9cc6..c1a912bc46ae 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -755,6 +755,44 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	return false;
 }
 
+static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
+		struct damon_region *r, struct damos *s)
+{
+	struct damos_quota *quota = &s->quota;
+	unsigned long sz = damon_sz_region(r);
+	struct timespec64 begin, end;
+	unsigned long sz_applied = 0;
+
+	if (c->ops.apply_scheme) {
+		if (quota->esz && quota->charged_sz + sz > quota->esz) {
+			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
+					DAMON_MIN_REGION);
+			if (!sz)
+				goto update_stat;
+			damon_split_region_at(t, r, sz);
+		}
+		ktime_get_coarse_ts64(&begin);
+		sz_applied = c->ops.apply_scheme(c, t, r, s);
+		ktime_get_coarse_ts64(&end);
+		quota->total_charged_ns += timespec64_to_ns(&end) -
+			timespec64_to_ns(&begin);
+		quota->charged_sz += sz;
+		if (quota->esz && quota->charged_sz >= quota->esz) {
+			quota->charge_target_from = t;
+			quota->charge_addr_from = r->ar.end + 1;
+		}
+	}
+	if (s->action != DAMOS_STAT)
+		r->age = 0;
+
+update_stat:
+	s->stat.nr_tried++;
+	s->stat.sz_tried += sz;
+	if (sz_applied)
+		s->stat.nr_applied++;
+	s->stat.sz_applied += sz_applied;
+}
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -763,9 +801,6 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
-		unsigned long sz;
-		struct timespec64 begin, end;
-		unsigned long sz_applied = 0;
 
 		if (!s->wmarks.activated)
 			continue;
@@ -780,37 +815,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!damos_valid_target(c, t, r, s))
 			continue;
 
-		/* Apply the scheme */
-		sz = damon_sz_region(r);
-		if (c->ops.apply_scheme) {
-			if (quota->esz &&
-					quota->charged_sz + sz > quota->esz) {
-				sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-						DAMON_MIN_REGION);
-				if (!sz)
-					goto update_stat;
-				damon_split_region_at(t, r, sz);
-			}
-			ktime_get_coarse_ts64(&begin);
-			sz_applied = c->ops.apply_scheme(c, t, r, s);
-			ktime_get_coarse_ts64(&end);
-			quota->total_charged_ns += timespec64_to_ns(&end) -
-				timespec64_to_ns(&begin);
-			quota->charged_sz += sz;
-			if (quota->esz && quota->charged_sz >= quota->esz) {
-				quota->charge_target_from = t;
-				quota->charge_addr_from = r->ar.end + 1;
-			}
-		}
-		if (s->action != DAMOS_STAT)
-			r->age = 0;
-
-update_stat:
-		s->stat.nr_tried++;
-		s->stat.sz_tried += sz;
-		if (sz_applied)
-			s->stat.nr_applied++;
-		s->stat.sz_applied += sz_applied;
+		damos_apply_scheme(c, t, r, s);
 	}
 }
 
-- 
2.25.1

