Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE580725226
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbjFGCkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbjFGCkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:40:12 -0400
Received: from out-8.mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE441990
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:40:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686105608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sqUILCp46Jj47kiEIO7DRVGvfhl8JWDw877OJqEVvRU=;
        b=vwIe7yWn2mHkbKvWsHxQjHndMddY6TdIFGCmdPfxJ6Sz2JzzNt4B8wik8kvRuMZd9J/H3u
        23Xp4QxF5UC1pTejMotjmvMDZNQXtziAaEMybqPV8N91l6zY8qlxt1ZOVv8WueKLQ+5Hho
        FhoqHpyRtf4loEK+nIT8Z6+vfqDrcxE=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/sparse: remove unused parameters in sparse_remove_section()
Date:   Wed,  7 Jun 2023 10:39:52 +0800
Message-Id: <20230607023952.2247489-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These parameters ms and map_offset are not used in
sparse_remove_section(), so remove them.

The __remove_section() is only called by __remove_pages(), remove it.
And put the WARN_ON_ONCE() in sparse_remove_section().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/memory_hotplug.h |  5 ++---
 mm/memory_hotplug.c            | 18 +-----------------
 mm/sparse.c                    | 10 +++++++---
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 04bc286eed42..013c69753c91 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -344,9 +344,8 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
 extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
-extern void sparse_remove_section(struct mem_section *ms,
-		unsigned long pfn, unsigned long nr_pages,
-		unsigned long map_offset, struct vmem_altmap *altmap);
+extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
+				  struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(int online_type, int nid,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9061ac69b1b6..8877734b5f2f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -492,18 +492,6 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 	set_zone_contiguous(zone);
 }
 
-static void __remove_section(unsigned long pfn, unsigned long nr_pages,
-			     unsigned long map_offset,
-			     struct vmem_altmap *altmap)
-{
-	struct mem_section *ms = __pfn_to_section(pfn);
-
-	if (WARN_ON_ONCE(!valid_section(ms)))
-		return;
-
-	sparse_remove_section(ms, pfn, nr_pages, map_offset, altmap);
-}
-
 /**
  * __remove_pages() - remove sections of pages
  * @pfn: starting pageframe (must be aligned to start of a section)
@@ -520,9 +508,6 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 {
 	const unsigned long end_pfn = pfn + nr_pages;
 	unsigned long cur_nr_pages;
-	unsigned long map_offset = 0;
-
-	map_offset = vmem_altmap_offset(altmap);
 
 	if (check_pfn_span(pfn, nr_pages)) {
 		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
@@ -534,8 +519,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		__remove_section(pfn, cur_nr_pages, map_offset, altmap);
-		map_offset = 0;
+		sparse_remove_section(pfn, cur_nr_pages, altmap);
 	}
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index b8d5d58fe240..297a8b772e8d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -922,10 +922,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	return 0;
 }
 
-void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
-		unsigned long nr_pages, unsigned long map_offset,
-		struct vmem_altmap *altmap)
+void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
+			   struct vmem_altmap *altmap)
 {
+	struct mem_section *ms = __pfn_to_section(pfn);
+
+	if (WARN_ON_ONCE(!valid_section(ms)))
+		return;
+
 	section_deactivate(pfn, nr_pages, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.25.1

