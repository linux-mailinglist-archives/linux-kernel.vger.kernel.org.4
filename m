Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EC63808A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKXVV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKXVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:21:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62293CF6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:21:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3488F62258
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 21:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D9C43150;
        Thu, 24 Nov 2022 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669324880;
        bh=A+37s6JJXYN+1C0NX4ExPJftU7PAKfFK4zc/BA9nVsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+0V/UoqSADE6pcLDhZbExhGqrYT4Q8hixpFvbQBtIq6Bj3mpP154eBt+hH0yZnPF
         sjEbxqQrqRwRIAGFNSdF4WLlSyzdwuIfiCNRf4yZMh/lHgz3zIQh/9XsneDPEthf5x
         dHkbbR/KPwDkpjuocYYxSEVkwBwLfv6TZBXEENrrySTPlPLDMqWC86RwQ1qXzmyvSb
         4ZNk6T1mi0uXuLtfXpfoCc7M0E2NDBlUeytO6oZdIMx0M00hcuq8ZGyiRkgFX08Gng
         x0PtTaFaHv13Y98mbnIPQgHenGd/LdGPchqBOBwTa0fqjP40QdhT19S5SAuPjIoRQs
         1ovdbbxYfl+Ow==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 02/11] mm/damon/paddr: support DAMOS filters
Date:   Thu, 24 Nov 2022 21:21:05 +0000
Message-Id: <20221124212114.136863-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-1-sj@kernel.org>
References: <20221124212114.136863-1-sj@kernel.org>
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

