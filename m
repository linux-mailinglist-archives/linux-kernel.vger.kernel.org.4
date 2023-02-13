Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7846D6950AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBMT3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:29:54 -0500
Received: from out-203.mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD910E4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:29:52 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676316590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TFd86/lZY0jUwVlpn5vMoRoTnYYIyh1u0uvkFRiAkpw=;
        b=vcCNvhUPB1Y6hXQuytul217yOHmDBd7yes08cATKxZTHFzbOcEBZlNeBKLTwoPWWPNEGiC
        EnCJt24L+EWKP8lqR9217v9hvv44u690jr3k8DWb/v28XIunVbQTc7XXy+D5vYFIBVTJrW
        b0W84QPIWgdxTN09+f1VjjpA6Nc0yhU=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>, linux-mm@kvack.org
Subject: [PATCH] mm: memcontrol: rename memcg_kmem_enabled()
Date:   Mon, 13 Feb 2023 11:29:22 -0800
Message-Id: <20230213192922.1146370-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are two kmem-related helper functions with a confusing
semantics: memcg_kmem_enabled() and mem_cgroup_kmem_disabled().

The problem is that an obvious expectation
memcg_kmem_enabled() == !mem_cgroup_kmem_disabled(),
can be false.

mem_cgroup_kmem_disabled() is similar to mem_cgroup_disabled(): it
returns true only if CONFIG_MEMCG_KMEM is not set or the kmem
accounting is disabled using a boot time kernel option
"cgroup.memory=nokmem". It never changes the value dynamically.

memcg_kmem_enabled() is different: it always returns false until
the first non-root memory cgroup will get online (assuming the kernel
memory accounting is enabled). It's goal is to improve the performance
on systems without the cgroupfs mounted/memory controller enabled or
on the systems with only the root memory cgroup.

To make things more obvious and avoid potential bugs, let's rename
memcg_kmem_enabled() to memcg_kmem_online().

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 14 +++++++-------
 mm/memcontrol.c            |  8 ++++----
 mm/page_alloc.c            |  8 ++++----
 mm/percpu.c                |  2 +-
 mm/slab.h                  | 10 +++++-----
 mm/vmscan.c                |  2 +-
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 35478695cabf..5567319027d1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1776,24 +1776,24 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
-extern struct static_key_false memcg_kmem_enabled_key;
+extern struct static_key_false memcg_kmem_online_key;
 
-static inline bool memcg_kmem_enabled(void)
+static inline bool memcg_kmem_online(void)
 {
-	return static_branch_likely(&memcg_kmem_enabled_key);
+	return static_branch_likely(&memcg_kmem_online_key);
 }
 
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
 {
-	if (memcg_kmem_enabled())
+	if (memcg_kmem_online())
 		return __memcg_kmem_charge_page(page, gfp, order);
 	return 0;
 }
 
 static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	if (memcg_kmem_enabled())
+	if (memcg_kmem_online())
 		__memcg_kmem_uncharge_page(page, order);
 }
 
@@ -1814,7 +1814,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 	struct mem_cgroup *memcg;
 
-	if (!memcg_kmem_enabled())
+	if (!memcg_kmem_online())
 		return;
 
 	rcu_read_lock();
@@ -1854,7 +1854,7 @@ static inline struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	return NULL;
 }
 
-static inline bool memcg_kmem_enabled(void)
+static inline bool memcg_kmem_online(void)
 {
 	return false;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17335459d8dc..3e3cdb9bed95 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -345,8 +345,8 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
  * conditional to this static branch, we'll have to allow modules that does
  * kmem_cache_alloc and the such to see this symbol as well
  */
-DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
-EXPORT_SYMBOL(memcg_kmem_enabled_key);
+DEFINE_STATIC_KEY_FALSE(memcg_kmem_online_key);
+EXPORT_SYMBOL(memcg_kmem_online_key);
 #endif
 
 /**
@@ -3034,7 +3034,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 {
 	struct obj_cgroup *objcg;
 
-	if (!memcg_kmem_enabled())
+	if (!memcg_kmem_online())
 		return NULL;
 
 	if (PageMemcgKmem(page)) {
@@ -3746,7 +3746,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
-	static_branch_enable(&memcg_kmem_enabled_key);
+	static_branch_enable(&memcg_kmem_online_key);
 
 	memcg->kmemcg_id = memcg->id.id;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6721c0ba12f8..7bbe514d1bdc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1410,7 +1410,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		 * Do not let hwpoison pages hit pcplists/buddy
 		 * Untie memcg state and reset page's owner
 		 */
-		if (memcg_kmem_enabled() && PageMemcgKmem(page))
+		if (memcg_kmem_online() && PageMemcgKmem(page))
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
@@ -1441,7 +1441,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	}
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
-	if (memcg_kmem_enabled() && PageMemcgKmem(page))
+	if (memcg_kmem_online() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
 	if (check_free && free_page_is_bad(page))
 		bad++;
@@ -5446,7 +5446,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto out;
 
 	/* Bulk allocator does not support memcg accounting. */
-	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT))
+	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT))
 		goto failed;
 
 	/* Use the single page allocator for one page. */
@@ -5618,7 +5618,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
 
 out:
-	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT) && page &&
+	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
 	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
 		__free_pages(page, order);
 		page = NULL;
diff --git a/mm/percpu.c b/mm/percpu.c
index acd78da0493b..28e07ede46f6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1625,7 +1625,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 {
 	struct obj_cgroup *objcg;
 
-	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
+	if (!memcg_kmem_online() || !(gfp & __GFP_ACCOUNT))
 		return true;
 
 	objcg = get_obj_cgroup_from_current();
diff --git a/mm/slab.h b/mm/slab.h
index 63fb4c00d529..43966aa5fadf 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -494,7 +494,7 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 {
 	struct obj_cgroup *objcg;
 
-	if (!memcg_kmem_enabled())
+	if (!memcg_kmem_online())
 		return true;
 
 	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
@@ -535,7 +535,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	unsigned long off;
 	size_t i;
 
-	if (!memcg_kmem_enabled() || !objcg)
+	if (!memcg_kmem_online() || !objcg)
 		return;
 
 	for (i = 0; i < size; i++) {
@@ -567,7 +567,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 	struct obj_cgroup **objcgs;
 	int i;
 
-	if (!memcg_kmem_enabled())
+	if (!memcg_kmem_online())
 		return;
 
 	objcgs = slab_objcgs(slab);
@@ -649,7 +649,7 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
-	if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
+	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
 		memcg_alloc_slab_cgroups(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
@@ -659,7 +659,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_enabled())
+	if (memcg_kmem_online())
 		memcg_free_slab_cgroups(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4b9fd1ae0ed..7c8d95b2b3aa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -915,7 +915,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		}
 
 		/* Call non-slab shrinkers even though kmem is disabled */
-		if (!memcg_kmem_enabled() &&
+		if (!memcg_kmem_online() &&
 		    !(shrinker->flags & SHRINKER_NONSLAB))
 			continue;
 
-- 
2.39.1

