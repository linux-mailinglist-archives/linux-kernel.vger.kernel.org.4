Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC46036E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJSANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJSAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F149D2CF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEDB8B821A9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0DFC43147;
        Wed, 19 Oct 2022 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138404;
        bh=pjhUTVwc23jb22PLD77G9UOJ0xr3wiyTA4y/GUqZ9tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEbm6sDfcTXIUricBf/6Gpo1iIpZ+mRGtQ+MFjwsqdJcMRJG9ThbLV6mOcnyN3FaF
         9M5u8LLdvZSETH6dqZ4z96sfehJMpZL2WdpYp/KUFbTfbjE3Ba8CYBbSZ0BvRr8Xuj
         d6zarTSpwWTQoCBOLMITRQysEWsVO5HK+vXwINqgk3cuyZkcS3greW5jS5CMPHSoDu
         drJ1uoCiHbCYJPYHO8EciFfvMUpl3A386v1pPN6M2QOTOxo6ZRA3VGwJXWakLh6LpV
         MRIu67iNrSlldNaaK170Gl0j7cFBF/6btlJCrSBK0xULd1XQ+FmDDZ6lGg1+tao5gF
         5OL1s4J4q1s8A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/18] mm/damon/core: split damos application logic into a new function
Date:   Wed, 19 Oct 2022 00:13:02 +0000
Message-Id: <20221019001317.104270-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: <20221019001317.104270-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 mm/damon/core.c | 72 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index eec258b3e57b..e777a751295f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -748,6 +748,44 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
@@ -756,9 +794,6 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
-		unsigned long sz;
-		struct timespec64 begin, end;
-		unsigned long sz_applied = 0;
 
 		if (!s->wmarks.activated)
 			continue;
@@ -774,36 +809,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Apply the scheme */
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

