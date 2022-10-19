Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5088D6036E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJSANh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSAN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58CCF181
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF826173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC371C4347C;
        Wed, 19 Oct 2022 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138405;
        bh=NhB5q6GWy35Ngqzu+zzoT7ZIWK8McTIGgP7rtWh58k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAAHDU7I6mkr0GDQcxxNJpSGpHNIxZZ76iNdS3Ntg8O7v25hder/BrwKr/J49yG2h
         KNJDI9MMXhaskiFZ71axg0bSTaqWjPLQ45HbZM09lQxLJZDb3FHb1ynHFKKVFSyWoP
         /YGaWGTV0GH9UfFXClAy7Ed6GArzvahx4Frx/y4i6Zbng9lSPIfvKgN7TITSDHsdXo
         VauZbzXPqNUDxOS4Z148iWXypUdEeZNo6kAbdD5tzPvEqzgu+xLIV9+J0B7aFwI02j
         AYjOTGw1OwDywujwOqI5T7scoJ3/lmDm1rH651EHfy/XNesEj+lymee+3V/f2JG304
         zsnZ0g7EW6b2g==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/18] mm/damon/core: split out scheme stat update logic into a new function
Date:   Wed, 19 Oct 2022 00:13:03 +0000
Message-Id: <20221019001317.104270-5-sj@kernel.org>
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

The function for applying a given DAMON scheme action to a given DAMON
region, 'damos_apply_scheme()' is not quite short.  Make it better to
read by splitting out the stat update logic into a new function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e777a751295f..7fa88dda711d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -748,6 +748,16 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	return false;
 }
 
+static void damos_update_stat(struct damos *s,
+		unsigned long sz_tried, unsigned long sz_applied)
+{
+	s->stat.nr_tried++;
+	s->stat.sz_tried += sz_tried;
+	if (sz_applied)
+		s->stat.nr_applied++;
+	s->stat.sz_applied += sz_applied;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -779,11 +789,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		r->age = 0;
 
 update_stat:
-	s->stat.nr_tried++;
-	s->stat.sz_tried += sz;
-	if (sz_applied)
-		s->stat.nr_applied++;
-	s->stat.sz_applied += sz_applied;
+	damos_update_stat(s, sz, sz_applied);
 }
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
@@ -808,7 +814,6 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!damos_valid_target(c, t, r, s))
 			continue;
 
-		/* Apply the scheme */
 		damos_apply_scheme(c, t, r, s);
 	}
 }
-- 
2.25.1

