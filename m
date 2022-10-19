Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0B6036E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJSAN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJSANb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE7DAC7B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60786173D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15CFC43470;
        Wed, 19 Oct 2022 00:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138409;
        bh=vYg+3rru4Qa0elGvOm6kAk7xSDdvfn1bfJkC8oPWZ2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tenTG1A90nsH1Dak3pwkOGg9UDD1hooxSi094QDdvMoBscH2C/g7zi8v2BGUjOhPs
         y4vIo+fNXXvhZhdooE2tmgSkAHMnQA5xpd4Kqhszbate1ebnPJS213e8UgRdy2bOvV
         OvqLR9fcbjQ1QwyBWoADNhTvBU1uPaQrB6xo0B6PTD3861jXC+6LXZSuFC/avMxfmQ
         YSWdi+DUHLKhJ5BEDMVSXPos2mJ4TVI89Wi1q1KYUVoBa+4jRm4z+at1G8xPdyOzcT
         6JiZvuVOVGsMIoYDWxxhKwxEb6Nkse5ZZlaafcyNDhBYfeuDXnjtzBM1RWG/fYHYsP
         QFqZnCDousbvA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/18] mm/damon/sysfs: split out kdamond-independent schemes stats update logic into a new function
Date:   Wed, 19 Oct 2022 00:13:10 +0000
Message-Id: <20221019001317.104270-12-sj@kernel.org>
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

'damon_sysfs_schemes_update_stats()' is coupled with both
damon_sysfs_kdamond and damon_sysfs_schemes.  It's a wide range of types
dependency.  It makes splitting the logics a little bit distracting.
Split the function so that each function is coupled with smaller range
of types.

Signed-off-by: SeongJae Park <sj@kernel.org>
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

