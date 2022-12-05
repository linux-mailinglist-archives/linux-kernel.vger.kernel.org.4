Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C547A643942
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiLEXJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLEXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:08:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D46544
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:08:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A91E1B815A3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62FDC433D6;
        Mon,  5 Dec 2022 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670281717;
        bh=A+37s6JJXYN+1C0NX4ExPJftU7PAKfFK4zc/BA9nVsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZtT+uKK4/4lwOI6eMAjYSBULmKtBrpMkQl2IHAUITb7EXo98LhCroIQJT8y9r+hV
         RjErPSimYQk6wI+oQHnJ2W8q1HKG7VsvuN3Z+CN8V9E9/92jWWK9WujY4iRGqptbr9
         dZ1X1kwT3xUlFezXuwH46XHCKBojafP0YCqEFGFR1vZNAWcV05AY87wJz86mrDFUu8
         7AT3dCObaN7p4ljYZ0j2i9jOwjEn4aYoNgDh58H+HC36IVp3cySUm5RJG8jNb1gCrq
         Qpf8bWCAA+bJNi9KZjsPhX+0mk7H/hdAO4opS9KDOUtLyh6k3SSBP+kytCHh8F6y1J
         YJYBKx0ps72Uw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 02/11] mm/damon/paddr: support DAMOS filters
Date:   Mon,  5 Dec 2022 23:08:21 +0000
Message-Id: <20221205230830.144349-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
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

Implement support of the DAMOS filters in the physical address space
monitoring operations set, for all DAMOS actions that it supports
including 'pageout', 'lru_prio', and 'lru_deprio'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 71 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..ebd1905eed6f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -202,7 +202,47 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r)
+static bool __damos_pa_filter_out(struct damos_filter *filter,
+		struct page *page)
+{
+	bool matched = false;
+	struct mem_cgroup *memcg;
+
+	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_ANON:
+		matched = PageAnon(page);
+		break;
+	case DAMOS_FILTER_TYPE_MEMCG:
+		rcu_read_lock();
+		memcg = page_memcg_check(page);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
+	default:
+		break;
+	}
+
+	return matched == filter->matching;
+}
+
+/*
+ * damos_pa_filter_out - Return true if the page should be filtered out.
+ */
+static bool damos_pa_filter_out(struct damos *scheme, struct page *page)
+{
+	struct damos_filter *filter;
+
+	damos_for_each_filter(filter, scheme) {
+		if (__damos_pa_filter_out(filter, page))
+			return true;
+	}
+	return false;
+}
+
+static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(page_list);
@@ -213,6 +253,11 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 		if (!page)
 			continue;
 
+		if (damos_pa_filter_out(s, page)) {
+			put_page(page);
+			continue;
+		}
+
 		ClearPageReferenced(page);
 		test_and_clear_page_young(page);
 		if (isolate_lru_page(page)) {
@@ -232,7 +277,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 }
 
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
-		struct damon_region *r, bool mark_accessed)
+		struct damon_region *r, struct damos *s, bool mark_accessed)
 {
 	unsigned long addr, applied = 0;
 
@@ -241,6 +286,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 		if (!page)
 			continue;
+
+		if (damos_pa_filter_out(s, page)) {
+			put_page(page);
+			continue;
+		}
+
 		if (mark_accessed)
 			mark_page_accessed(page);
 		else
@@ -251,14 +302,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	return applied * PAGE_SIZE;
 }
 
-static unsigned long damon_pa_mark_accessed(struct damon_region *r)
+static unsigned long damon_pa_mark_accessed(struct damon_region *r,
+	struct damos *s)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, true);
+	return damon_pa_mark_accessed_or_deactivate(r, s, true);
 }
 
-static unsigned long damon_pa_deactivate_pages(struct damon_region *r)
+static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
+	struct damos *s)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, false);
+	return damon_pa_mark_accessed_or_deactivate(r, s, false);
 }
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
@@ -267,11 +320,11 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r);
+		return damon_pa_pageout(r, scheme);
 	case DAMOS_LRU_PRIO:
-		return damon_pa_mark_accessed(r);
+		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
-		return damon_pa_deactivate_pages(r);
+		return damon_pa_deactivate_pages(r, scheme);
 	case DAMOS_STAT:
 		break;
 	default:
-- 
2.25.1

