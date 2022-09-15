Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2B5B9BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIONav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIONat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:30:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B2872B6A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA176B8204F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC60C433C1;
        Thu, 15 Sep 2022 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663248645;
        bh=h5IX1MKrcfUblY8yoekIagX32KlVYCASL/Rb+1FBFqM=;
        h=From:To:Cc:Subject:Date:From;
        b=LixP+DrQUxm+g9O13ts3MR4iOUlsbJOQFNVFmiypecGAC/BiHSpkxPJXS/iRueKme
         NixrvAdN+FznronfXGHhGCNiaFKyDEU7VGHZ7xQblaPWd358sqCgYrXM8gDjL4s27P
         REekv1RG2X8/vpVzBF7oCI+WWsUv7ZOI7gJp6WYcYSlI6yrzSlnHnrLA6ASN9OlUFu
         8vfdzVyAo/h2d5TMqjYzbOwX4epvCjhgA8qJIB2BJ9NiBC5xF2VM1JGfkgF8/Mha6e
         r8DBVEKAgb9LOmyJAXBGyGST/xs9h/XanpKe4gdh2SOSd9I/zeEkhXMrsZSfeRc5p5
         L+mmH1wGc3wVA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v4] mm/damon: simplify scheme create in lru_sort.c
Date:   Thu, 15 Sep 2022 13:30:41 +0000
Message-Id: <20220915133041.71819-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Hao <xhao@linux.alibaba.com>

In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
they have so much in common, so we can combine them into a single
function, and we just need to distinguish their differences.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
changes from v3
(https://lore.kernel.org/damon/20220915023655.41923-1-xhao@linux.alibaba.com/)
- Cosmetic cleanups

Changes from v2
(https://lore.kernel.org/linux-mm/20220914113859.37637-1-xhao@linux.alibaba.com/)
- Add static global 'struct damos_access_pattern' stub variable

 mm/damon/lru_sort.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 46e7c0738bc5..abfaf471e3e9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -132,6 +132,18 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
 		cold_quota_exceeds);
 
+struct damos_access_pattern damon_lru_sort_stub_pattern = {
+	/* Find regions having PAGE_SIZE or larger size */
+	.min_sz_region = PAGE_SIZE,
+	.max_sz_region = ULONG_MAX,
+	/* no matter its access frequency */
+	.min_nr_accesses = 0,
+	.max_nr_accesses = UINT_MAX,
+	/* no matter its age */
+	.min_age_region = 0,
+	.max_age_region = UINT_MAX,
+};
+
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
@@ -157,36 +169,19 @@ static struct damos *damon_lru_sort_new_scheme(
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and accessed for more than the threshold */
-		.min_nr_accesses = hot_thres,
-		.max_nr_accesses = UINT_MAX,
-		/* no matter its age */
-		.min_age_region = 0,
-		.max_age_region = UINT_MAX,
-	};
+	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
 
+	pattern.min_nr_accesses = hot_thres;
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
 static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and not accessed at all */
-		.min_nr_accesses = 0,
-		.max_nr_accesses = 0,
-		/* for min_age or more micro-seconds */
-		.min_age_region = cold_thres,
-		.max_age_region = UINT_MAX,
-	};
+	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
 
+	pattern.max_nr_accesses = 0;
+	pattern.min_age_region = cold_thres;
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
-- 
2.25.1

