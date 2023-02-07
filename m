Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063168DA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjBGOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjBGOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:16:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC0B1D916
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:16:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675779413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMBsGdGaUVtpVb5l7qAv/CD26vfZYLfuerCxMvwtG94=;
        b=Z1VjMItoihm9Q5k80PT5C1fQWCpwP9WvO3o6gWf/0/msrRbYyI0Kp6aOBcDM0zvpeovF59
        jHRwxOr8kpnpQAXJdGJxlvJe+5jqfxkq3hhE7uV9PaHEok2TmSwhjskPAMlCeyhdX17SKE
        EhURhyr5f1g06F/fHrO13pN2IXxHYHwvkXUl190+XFhs7qF2mYWQltO98PsbGClOgMx+dy
        AZsywvOvz/YhLa2Hees8YcOXNGW7GfMtl8GvSNcwEDj8Vmae1XO0QjqKTduDpTqfILYTTm
        t0alDHuV9ytg7gsXT3J0hAmEZm7xdEokgU8kYEbfx2048bBJHY20xIbgO1DJdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675779413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMBsGdGaUVtpVb5l7qAv/CD26vfZYLfuerCxMvwtG94=;
        b=5KIdDvzlVcK/H2duY4vqVIvrkGkr2fYRRVcFh/a6cnDuLXvioiD+aWcuU+STnf3sv5o4j4
        wUdzUVDmg6uOomDw==
To:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early
In-Reply-To: <875ycdwyx6.ffs@tglx>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx>
Date:   Tue, 07 Feb 2023 15:16:53 +0100
Message-ID: <871qn1wofe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory allocators are available during early boot even in the phase
where interrupts are disabled and scheduling is not yet possible.

The setup is so that GFP_KERNEL allocations work in this phase without
causing might_alloc() splats to be emitted because the system state is
SYSTEM_BOOTING at that point which prevents the warnings to trigger.

Most allocation/free functions use local_irq_save()/restore() or a lock
variant of that. But kmem_cache_alloc_bulk() and kmem_cache_free_bulk() use
local_[lock]_irq_disable()/enable(), which leads to a lockdep warning when
interrupts are enabled during the early boot phase.

This went unnoticed so far as there are no early users of these
interfaces. The upcoming conversion of the interrupt descriptor store from
radix_tree to maple_tree triggered this warning as maple_tree uses the bulk
interface.

Cure this by moving the kmem_cache_alloc/free() bulk variants of SLUB and
SLAB to local[_lock]_irq_save()/restore().

There is obviously no reclaim possible and required at this point so there
is no need to expand this coverage further.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Initial version: https://lore.kernel.org/r/87o7qdzfay.ffs@tglx
Changes: Update SLAB as well and add changelog
---
 mm/slab.c |   18 ++++++++++--------
 mm/slub.c |    9 +++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3479,14 +3479,15 @@ cache_alloc_debugcheck_after_bulk(struct
 int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			  void **p)
 {
-	size_t i;
 	struct obj_cgroup *objcg = NULL;
+	unsigned long irqflags;
+	size_t i;
 
 	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
 	if (!s)
 		return 0;
 
-	local_irq_disable();
+	local_irq_save(irqflags);
 	for (i = 0; i < size; i++) {
 		void *objp = kfence_alloc(s, s->object_size, flags) ?:
 			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
@@ -3495,7 +3496,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
 			goto error;
 		p[i] = objp;
 	}
-	local_irq_enable();
+	local_irq_restore(irqflags);
 
 	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
 
@@ -3508,7 +3509,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
-	local_irq_enable();
+	local_irq_restore(irqflags);
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
 	kmem_cache_free_bulk(s, i, p);
@@ -3610,8 +3611,9 @@ EXPORT_SYMBOL(kmem_cache_free);
 
 void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 {
+	unsigned long flags;
 
-	local_irq_disable();
+	local_irq_save(flags);
 	for (int i = 0; i < size; i++) {
 		void *objp = p[i];
 		struct kmem_cache *s;
@@ -3621,9 +3623,9 @@ void kmem_cache_free_bulk(struct kmem_ca
 
 			/* called via kfree_bulk */
 			if (!folio_test_slab(folio)) {
-				local_irq_enable();
+				local_irq_restore(flags);
 				free_large_kmalloc(folio, objp);
-				local_irq_disable();
+				local_irq_save(flags);
 				continue;
 			}
 			s = folio_slab(folio)->slab_cache;
@@ -3640,7 +3642,7 @@ void kmem_cache_free_bulk(struct kmem_ca
 
 		__cache_free(s, objp, _RET_IP_);
 	}
-	local_irq_enable();
+	local_irq_restore(flags);
 
 	/* FIXME: add tracing */
 }
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3913,6 +3913,7 @@ static inline int __kmem_cache_alloc_bul
 			size_t size, void **p, struct obj_cgroup *objcg)
 {
 	struct kmem_cache_cpu *c;
+	unsigned long irqflags;
 	int i;
 
 	/*
@@ -3921,7 +3922,7 @@ static inline int __kmem_cache_alloc_bul
 	 * handlers invoking normal fastpath.
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
-	local_lock_irq(&s->cpu_slab->lock);
+	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3942,7 +3943,7 @@ static inline int __kmem_cache_alloc_bul
 			 */
 			c->tid = next_tid(c->tid);
 
-			local_unlock_irq(&s->cpu_slab->lock);
+			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
 
 			/*
 			 * Invoking slow path likely have side-effect
@@ -3956,7 +3957,7 @@ static inline int __kmem_cache_alloc_bul
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
-			local_lock_irq(&s->cpu_slab->lock);
+			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
 
 			continue; /* goto for-loop */
 		}
@@ -3965,7 +3966,7 @@ static inline int __kmem_cache_alloc_bul
 		maybe_wipe_obj_freeptr(s, p[i]);
 	}
 	c->tid = next_tid(c->tid);
-	local_unlock_irq(&s->cpu_slab->lock);
+	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
 	slub_put_cpu_ptr(s->cpu_slab);
 
 	return i;
