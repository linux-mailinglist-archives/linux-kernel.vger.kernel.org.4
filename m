Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91318632A86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKURNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKURMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8850BCB96C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68E5C220D5;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMmNopRYRfA37kq/EN9aG18MOnK/i5uLhKJ1sge8xAA=;
        b=p6VpLMdMxN1kJ4n9jv3xcJa8KnPdeS9ZGmhAlu1UHcCH6DEBqPKsdNwZkAaWRSKwPN4y08
        xDURlE0TZATHKwd51J4Q3qmb82ACWWzgCQykDg9AQEbIzdj6A3VKWm5nw2Gjq5Uj/LWlcx
        jaID3ty2j28Z+LUc+mLFSclopdkoY8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMmNopRYRfA37kq/EN9aG18MOnK/i5uLhKJ1sge8xAA=;
        b=SujXFbAWs2lGrzR/O4yA0XV7pl+hnwj3LAsswVaOhswJrHrH7T9uxC6qZPBVs/RqNBplWo
        6TymHqOKZvWaJcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F9F11377F;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iBzjDmyxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:12 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 10/12] mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:12:00 +0100
Message-Id: <20221121171202.22080-11-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB gets most of its scalability by percpu slabs. However for
CONFIG_SLUB_TINY the goal is minimal memory overhead, not scalability.
Thus, #ifdef out the whole kmem_cache_cpu percpu structure and
associated code. Additionally to the slab page savings, this reduces
percpu allocator usage, and code size.

This change builds on recent commit c7323a5ad078 ("mm/slub: restrict
sysfs validation to debug caches and make it safe"), as caches with
enabled debugging also avoid percpu slabs and all allocations and
freeing ends up working with the partial list. With a bit more
refactoring by the preceding patches, use the same code paths with
CONFIG_SLUB_TINY.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h |   4 ++
 mm/slub.c                | 102 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index c186f25c8148..79df64eb054e 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -41,6 +41,7 @@ enum stat_item {
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
 	NR_SLUB_STAT_ITEMS };
 
+#ifndef CONFIG_SLUB_TINY
 /*
  * When changing the layout, make sure freelist and tid are still compatible
  * with this_cpu_cmpxchg_double() alignment requirements.
@@ -57,6 +58,7 @@ struct kmem_cache_cpu {
 	unsigned stat[NR_SLUB_STAT_ITEMS];
 #endif
 };
+#endif /* CONFIG_SLUB_TINY */
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 #define slub_percpu_partial(c)		((c)->partial)
@@ -88,7 +90,9 @@ struct kmem_cache_order_objects {
  * Slab cache management.
  */
 struct kmem_cache {
+#ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
+#endif
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
 	unsigned long min_partial;
diff --git a/mm/slub.c b/mm/slub.c
index 5677db3f6d15..7f1cd702c3b4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -337,10 +337,12 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
  */
 static nodemask_t slab_nodes;
 
+#ifndef CONFIG_SLUB_TINY
 /*
  * Workqueue used for flush_cpu_slab().
  */
 static struct workqueue_struct *flushwq;
+#endif
 
 /********************************************************************
  * 			Core slab cache functions
@@ -386,10 +388,12 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 	return freelist_dereference(s, object + s->offset);
 }
 
+#ifndef CONFIG_SLUB_TINY
 static void prefetch_freepointer(const struct kmem_cache *s, void *object)
 {
 	prefetchw(object + s->offset);
 }
+#endif
 
 /*
  * When running under KMSAN, get_freepointer_safe() may return an uninitialized
@@ -1681,11 +1685,13 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 
+#ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
 {
 	return false;
 }
+#endif
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
@@ -2219,7 +2225,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
 
-		if (kmem_cache_debug(s)) {
+		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 			object = alloc_single_from_partial(s, n, slab,
 							pc->orig_size);
 			if (object)
@@ -2334,6 +2340,8 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
 	return get_any_partial(s, pc);
 }
 
+#ifndef CONFIG_SLUB_TINY
+
 #ifdef CONFIG_PREEMPTION
 /*
  * Calculate the next globally unique transaction for disambiguation
@@ -2347,7 +2355,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
  * different cpus.
  */
 #define TID_STEP 1
-#endif
+#endif /* CONFIG_PREEMPTION */
 
 static inline unsigned long next_tid(unsigned long tid)
 {
@@ -2808,6 +2816,13 @@ static int slub_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+#else /* CONFIG_SLUB_TINY */
+static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
+static inline void flush_all(struct kmem_cache *s) { }
+static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
+static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
+#endif /* CONFIG_SLUB_TINY */
+
 /*
  * Check if the objects in a per cpu structure fit numa
  * locality expectations.
@@ -2955,6 +2970,7 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
 	return true;
 }
 
+#ifndef CONFIG_SLUB_TINY
 /*
  * Check the slab->freelist and either transfer the freelist to the
  * per cpu freelist or deactivate the slab.
@@ -3320,6 +3336,33 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 
 	return object;
 }
+#else /* CONFIG_SLUB_TINY */
+static void *__slab_alloc_node(struct kmem_cache *s,
+		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+{
+	struct partial_context pc;
+	struct slab *slab;
+	void *object;
+
+	pc.flags = gfpflags;
+	pc.slab = &slab;
+	pc.orig_size = orig_size;
+	object = get_partial(s, node, &pc);
+
+	if (object)
+		return object;
+
+	slab = new_slab(s, gfpflags, node);
+	if (unlikely(!slab)) {
+		slab_out_of_memory(s, gfpflags, node);
+		return NULL;
+	}
+
+	object = alloc_single_from_new_slab(s, slab, orig_size);
+
+	return object;
+}
+#endif /* CONFIG_SLUB_TINY */
 
 /*
  * If the object has been wiped upon free, make sure it's fully initialized by
@@ -3503,7 +3546,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	if (kfence_free(head))
 		return;
 
-	if (kmem_cache_debug(s)) {
+	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
 	}
@@ -3604,6 +3647,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	discard_slab(s, slab);
 }
 
+#ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
  * can perform fastpath freeing without additional function calls.
@@ -3678,6 +3722,16 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	}
 	stat(s, FREE_FASTPATH);
 }
+#else /* CONFIG_SLUB_TINY */
+static void do_slab_free(struct kmem_cache *s,
+				struct slab *slab, void *head, void *tail,
+				int cnt, unsigned long addr)
+{
+	void *tail_obj = tail ? : head;
+
+	__slab_free(s, slab, head, tail_obj, cnt, addr);
+}
+#endif /* CONFIG_SLUB_TINY */
 
 static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 				      void *head, void *tail, void **p, int cnt,
@@ -3812,6 +3866,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
+#ifndef CONFIG_SLUB_TINY
 static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 			size_t size, void **p, struct obj_cgroup *objcg)
 {
@@ -3880,6 +3935,36 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 	return 0;
 
 }
+#else /* CONFIG_SLUB_TINY */
+static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
+			size_t size, void **p, struct obj_cgroup *objcg)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		void *object = kfence_alloc(s, s->object_size, flags);
+
+		if (unlikely(object)) {
+			p[i] = object;
+			continue;
+		}
+
+		p[i] = __slab_alloc_node(s, flags, NUMA_NO_NODE,
+					 _RET_IP_, s->object_size);
+		if (unlikely(!p[i]))
+			goto error;
+
+		maybe_wipe_obj_freeptr(s, p[i]);
+	}
+
+	return i;
+
+error:
+	slab_post_alloc_hook(s, objcg, flags, i, p, false);
+	kmem_cache_free_bulk(s, i, p);
+	return 0;
+}
+#endif /* CONFIG_SLUB_TINY */
 
 /* Note that interrupts must be enabled when calling this function. */
 int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
@@ -4059,6 +4144,7 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 #endif
 }
 
+#ifndef CONFIG_SLUB_TINY
 static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 {
 	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
@@ -4078,6 +4164,12 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 
 	return 1;
 }
+#else
+static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
+{
+	return 1;
+}
+#endif /* CONFIG_SLUB_TINY */
 
 static struct kmem_cache *kmem_cache_node;
 
@@ -4140,7 +4232,9 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
+#ifndef CONFIG_SLUB_TINY
 	free_percpu(s->cpu_slab);
+#endif
 	free_kmem_cache_nodes(s);
 }
 
@@ -4917,8 +5011,10 @@ void __init kmem_cache_init(void)
 
 void __init kmem_cache_init_late(void)
 {
+#ifndef CONFIG_SLUB_TINY
 	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!flushwq);
+#endif
 }
 
 struct kmem_cache *
-- 
2.38.1

