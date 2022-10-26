Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A160EBED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiJZXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiJZW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C5C26569
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4E2620DC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E6C43142;
        Wed, 26 Oct 2022 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825191;
        bh=JpR/JpSFcvX/01k1C+QGg0rBNnZER7RU6+E6N5NVTO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6Eyv8ffq85heYOnigGBCrI+z0CZ4/IyyIB+YPDQDNJr+24gdpnLwQ302W4TFpqyE
         5PQSq5YVSY+94t/kcpD7m9+o9jvI/FY4BYFd0+W9bHrzsmGY6GI8uVrq3mV9rcjRmN
         hvtwew5+HkJ8S2WsXBTfP9t2ch6LmFZtXk+MMmVxUGPLhHE2XSGGUP1y+Wl/1C0mhA
         CD1fMCaw9yw3bWwDBGNYTqGQ6za5fGkEaUIrJrrazMtESzldt4aujvwPTKMP2i7JEw
         3hx82Iuk66RtdFldolTjr0JN5VVAl0a+BGfrNSkmoMLSrijYWfDanoNknERIUi3044
         JlEfEkO6oAyjg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 03/12] mm/damon/core: split out scheme stat update logic into a new function
Date:   Wed, 26 Oct 2022 22:59:34 +0000
Message-Id: <20221026225943.100429-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
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

The function for applying a given DAMON scheme action to a given DAMON
region, 'damos_apply_scheme()' is not quite short.  Make it better to read
by splitting out the stat update logic into a new function.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c1a912bc46ae..3a810c6e26bc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -755,6 +755,16 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
@@ -786,11 +796,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
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
-- 
2.25.1

