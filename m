Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128D632A83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKURMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiKURMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D70CFA41
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47632220D4;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMqYhmOsEKQ7/VSttswoCKZLBAGMRcn+b2MFFvLoSuw=;
        b=Ojl3e44RiDKVqXpC9HV756II2gtNxdR9Uatm8nFW93vuLQRymEttq75jrUTkbvJAa11QQ2
        Vplon66ODrOjFPKmrshp5Ww7UH7GdyiL91VE2NMIXexKgm+Y9C93ymTHgFPf6dEUO1sjNy
        H+fp5ErLwwU44qguaKE3oUXmhmewgPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMqYhmOsEKQ7/VSttswoCKZLBAGMRcn+b2MFFvLoSuw=;
        b=YOjMxAi/H9hdYzqkkCS1LB5sqrRT42/kj/OR9JrMx1foyoNrQPbUdup3ul7JTSY6C0BcqG
        8StRZNrD3lITgBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 118A113B03;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFqfA2yxe2MQeQAAMHmgww
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
Subject: [PATCH 09/12] mm, slub: split out allocations from pre/post hooks
Date:   Mon, 21 Nov 2022 18:11:59 +0100
Message-Id: <20221121171202.22080-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following patch we want to introduce CONFIG_SLUB_TINY allocation
paths that don't use the percpu slab. To prepare, refactor the
allocation functions:

Split out __slab_alloc_node() from slab_alloc_node() where the former
does the actual allocation and the latter calls the pre/post hooks.

Analogically, split out __kmem_cache_alloc_bulk() from
kmem_cache_alloc_bulk().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 127 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 50 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index fd56d7cca9c2..5677db3f6d15 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2907,10 +2907,10 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 }
 #endif /* CONFIG_SLUB_DEBUG || SLAB_SUPPORTS_SYSFS */
 
+#ifdef CONFIG_SLUB_DEBUG
 static noinline void
 slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 {
-#ifdef CONFIG_SLUB_DEBUG
 	static DEFINE_RATELIMIT_STATE(slub_oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 	int node;
@@ -2941,8 +2941,11 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 		pr_warn("  node %d: slabs: %ld, objs: %ld, free: %ld\n",
 			node, nr_slabs, nr_objs, nr_free);
 	}
-#endif
 }
+#else /* CONFIG_SLUB_DEBUG */
+static inline void
+slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid) { }
+#endif
 
 static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
 {
@@ -3239,45 +3242,13 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	return p;
 }
 
-/*
- * If the object has been wiped upon free, make sure it's fully initialized by
- * zeroing out freelist pointer.
- */
-static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
-						   void *obj)
-{
-	if (unlikely(slab_want_init_on_free(s)) && obj)
-		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
-			0, sizeof(void *));
-}
-
-/*
- * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
- * have the fastpath folded into their functions. So no function call
- * overhead for requests that can be satisfied on the fastpath.
- *
- * The fastpath works by first checking if the lockless freelist can be used.
- * If not then __slab_alloc is called for slow processing.
- *
- * Otherwise we can simply pick the next object from the lockless free list.
- */
-static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
+static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
-	void *object;
 	struct kmem_cache_cpu *c;
 	struct slab *slab;
 	unsigned long tid;
-	struct obj_cgroup *objcg = NULL;
-	bool init = false;
-
-	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
-	if (!s)
-		return NULL;
-
-	object = kfence_alloc(s, orig_size, gfpflags);
-	if (unlikely(object))
-		goto out;
+	void *object;
 
 redo:
 	/*
@@ -3347,6 +3318,48 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 		stat(s, ALLOC_FASTPATH);
 	}
 
+	return object;
+}
+
+/*
+ * If the object has been wiped upon free, make sure it's fully initialized by
+ * zeroing out freelist pointer.
+ */
+static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
+						   void *obj)
+{
+	if (unlikely(slab_want_init_on_free(s)) && obj)
+		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
+			0, sizeof(void *));
+}
+
+/*
+ * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
+ * have the fastpath folded into their functions. So no function call
+ * overhead for requests that can be satisfied on the fastpath.
+ *
+ * The fastpath works by first checking if the lockless freelist can be used.
+ * If not then __slab_alloc is called for slow processing.
+ *
+ * Otherwise we can simply pick the next object from the lockless free list.
+ */
+static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
+		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+{
+	void *object;
+	struct obj_cgroup *objcg = NULL;
+	bool init = false;
+
+	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
+	if (!s)
+		return NULL;
+
+	object = kfence_alloc(s, orig_size, gfpflags);
+	if (unlikely(object))
+		goto out;
+
+	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
+
 	maybe_wipe_obj_freeptr(s, object);
 	init = slab_want_init_on_alloc(gfpflags, s);
 
@@ -3799,18 +3812,12 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
-/* Note that interrupts must be enabled when calling this function. */
-int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
-			  void **p)
+static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
+			size_t size, void **p, struct obj_cgroup *objcg)
 {
 	struct kmem_cache_cpu *c;
 	int i;
-	struct obj_cgroup *objcg = NULL;
 
-	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
-	if (unlikely(!s))
-		return false;
 	/*
 	 * Drain objects in the per cpu slab, while disabling local
 	 * IRQs, which protects against PREEMPT and interrupts
@@ -3864,18 +3871,38 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	local_unlock_irq(&s->cpu_slab->lock);
 	slub_put_cpu_ptr(s->cpu_slab);
 
-	/*
-	 * memcg and kmem_cache debug support and memory initialization.
-	 * Done outside of the IRQ disabled fastpath loop.
-	 */
-	slab_post_alloc_hook(s, objcg, flags, size, p,
-				slab_want_init_on_alloc(flags, s));
 	return i;
+
 error:
 	slub_put_cpu_ptr(s->cpu_slab);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	kmem_cache_free_bulk(s, i, p);
 	return 0;
+
+}
+
+/* Note that interrupts must be enabled when calling this function. */
+int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
+			  void **p)
+{
+	int i;
+	struct obj_cgroup *objcg = NULL;
+
+	/* memcg and kmem_cache debug support */
+	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
+	if (unlikely(!s))
+		return false;
+
+	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
+
+	/*
+	 * memcg and kmem_cache debug support and memory initialization.
+	 * Done outside of the IRQ disabled fastpath loop.
+	 */
+	if (i != 0)
+		slab_post_alloc_hook(s, objcg, flags, size, p,
+				slab_want_init_on_alloc(flags, s));
+	return i;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-- 
2.38.1

