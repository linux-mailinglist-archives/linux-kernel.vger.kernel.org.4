Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C8960EBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiJZXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiJZXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C84627FCF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0CD8B82476
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D0C43142;
        Wed, 26 Oct 2022 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825194;
        bh=ntGtZw3yOs+uZ3gGOlcjovkmvzOGben11U2Vk6cgNsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apA/DBpn9ihjONGTe+7Tm+CF2VK2nXdQwrRSROG0uPjYVHC6AfMycLiYCPgw4tSV2
         Bjryu70eLbWJwZ3NnTsY4AVkIq6TUoB9gxxBJDdYo6uGFuIOdvOmyM2ICd2Cwgeqh1
         bTgFL7CxZRZOpao4OYSzJN/iSg34iczbkjbdwE9d9E28XH99UhR/tWLjlRWvTEmtqF
         FMSuaipMVFPhD+vCFcKCokDIHnrMv8uH4EJ1suKOml4QfwTOj3gtr8C5rM00UCydjr
         ZzzldyJunEtbF2+KVU4QrINjXm4ToX4LMI7rLviAU6jxY6ZWlaCORklG3p0m8AeQtA
         2CdoglM3N20DQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 09/12] mm/damon/sysfs: split out kdamond-independent schemes stats update logic into a new function
Date:   Wed, 26 Oct 2022 22:59:40 +0000
Message-Id: <20221026225943.100429-10-sj@kernel.org>
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

'damon_sysfs_schemes_update_stats()' is coupled with both
damon_sysfs_kdamond and damon_sysfs_schemes.  It's a wide range of types
dependency.  It makes splitting the logics a little bit distracting.
Split the function so that each function is coupled with smaller range of
types.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 129743292e17..082c55e68e0e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2204,6 +2204,25 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->kdamond_lock);
 }
 
+static void damon_sysfs_schemes_update_stats(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_stats *sysfs_stats;
+
+		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
+		sysfs_stats->nr_tried = scheme->stat.nr_tried;
+		sysfs_stats->sz_tried = scheme->stat.sz_tried;
+		sysfs_stats->nr_applied = scheme->stat.nr_applied;
+		sysfs_stats->sz_applied = scheme->stat.sz_applied;
+		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+	}
+}
+
 /*
  * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
  * @kdamond:	The kobject wrapper that associated to the kdamond thread.
@@ -2216,23 +2235,11 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx = kdamond->damon_ctx;
-	struct damon_sysfs_schemes *sysfs_schemes;
-	struct damos *scheme;
-	int schemes_idx = 0;
 
 	if (!ctx)
 		return -EINVAL;
-	sysfs_schemes = kdamond->contexts->contexts_arr[0]->schemes;
-	damon_for_each_scheme(scheme, ctx) {
-		struct damon_sysfs_stats *sysfs_stats;
-
-		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
-		sysfs_stats->nr_tried = scheme->stat.nr_tried;
-		sysfs_stats->sz_tried = scheme->stat.sz_tried;
-		sysfs_stats->nr_applied = scheme->stat.nr_applied;
-		sysfs_stats->sz_applied = scheme->stat.sz_applied;
-		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
-	}
+	damon_sysfs_schemes_update_stats(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
 }
 
-- 
2.25.1

