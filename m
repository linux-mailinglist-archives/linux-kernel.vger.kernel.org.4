Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8270BA20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjEVK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjEVK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:27:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C694139;
        Mon, 22 May 2023 03:27:28 -0700 (PDT)
Date:   Mon, 22 May 2023 10:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684751246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9wvo25Xik0KYzGVGTG48qaG3MCgVhi+fV4iIsg67KE=;
        b=arUaARg092zOyqfSCOT1xigkc31wYMQP8zUdRCIbzg7UB2GN1ydQcHCFEnOd3F7KwHgriD
        Wn3Rd28w0AFgVU89VJ8PxSxb0+5bZenCrJfhNEnHQSuZT29mUkHKj+xFqag2CpegiSQlIG
        2rFke+45OGBmDAUvDXyw3932hpcNad7ece59SaH/Ei7MDjlNxZen4KjSPoIPkWJtBbjCOi
        uou6ZyCyMRN2I5O3xOI03OYKYKJnm35piRS/Kx00MVkSIwUdGILJEEho8/DB4+wp1ncNXI
        ZQki3ESLizPZaDa0HIN7SuV6OIzGAHG8wL7CP8Fmvp1I1NwOqudbyfjybcsbZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684751246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9wvo25Xik0KYzGVGTG48qaG3MCgVhi+fV4iIsg67KE=;
        b=Rn0+GbBT3Tah4HT63hj+OhjMPfG7DE/J8cxvnrdZKpYeOgFCTWCSzU8tF/xC2TEw3Dqj5E
        DcVeaR2Yy+n7iRBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] slub: Replace cmpxchg_double()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080554.453785148@infradead.org>
References: <20230515080554.453785148@infradead.org>
MIME-Version: 1.0
Message-ID: <168475124580.404.17843460196511539821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f4ab23558310d2181260b30825a90cdf050ebfc0
Gitweb:        https://git.kernel.org/tip/f4ab23558310d2181260b30825a90cdf050ebfc0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 May 2023 10:49:50 +02:00

slub: Replace cmpxchg_double()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/r/20230515080554.453785148@infradead.org
---
 include/linux/slub_def.h |  12 ++-
 mm/slab.h                |  49 +++++++++++--
 mm/slub.c                | 143 ++++++++++++++++++++++----------------
 3 files changed, 138 insertions(+), 66 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index f6df03f..deb90cf 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -39,7 +39,8 @@ enum stat_item {
 	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
 	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
-	NR_SLUB_STAT_ITEMS };
+	NR_SLUB_STAT_ITEMS
+};
 
 #ifndef CONFIG_SLUB_TINY
 /*
@@ -47,8 +48,13 @@ enum stat_item {
  * with this_cpu_cmpxchg_double() alignment requirements.
  */
 struct kmem_cache_cpu {
-	void **freelist;	/* Pointer to next available object */
-	unsigned long tid;	/* Globally unique transaction id */
+	union {
+		struct {
+			void **freelist;	/* Pointer to next available object */
+			unsigned long tid;	/* Globally unique transaction id */
+		};
+		freelist_aba_t freelist_tid;
+	};
 	struct slab *slab;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct slab *partial;	/* Partially allocated frozen slabs */
diff --git a/mm/slab.h b/mm/slab.h
index f01ac25..5880c70 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -6,6 +6,38 @@
  */
 void __init kmem_cache_init(void);
 
+#ifdef CONFIG_HAVE_ALIGNED_STRUCT_PAGE
+#ifdef CONFIG_64BIT
+# ifdef system_has_cmpxchg128
+# define system_has_freelist_aba()	system_has_cmpxchg128()
+# define try_cmpxchg_freelist		try_cmpxchg128
+# define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg128
+typedef u128 freelist_full_t;
+# endif
+#else /* CONFIG_64BIT */
+# ifdef system_has_cmpxchg64
+# define system_has_freelist_aba()	system_has_cmpxchg64()
+# define try_cmpxchg_freelist		try_cmpxchg64
+# define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg64
+typedef u64 freelist_full_t;
+# endif
+#endif /* CONFIG_64BIT */
+#endif /* CONFIG_HAVE_ALIGNED_STRUCT_PAGE */
+
+/*
+ * Freelist pointer and counter to cmpxchg together, avoids the typical ABA
+ * problems with cmpxchg of just a pointer.
+ */
+typedef union {
+#ifdef system_has_freelist_aba
+	struct {
+		void *freelist;
+		unsigned long counter;
+	};
+	freelist_full_t full;
+#endif
+} freelist_aba_t;
+
 /* Reuses the bits in struct page */
 struct slab {
 	unsigned long __page_flags;
@@ -38,14 +70,19 @@ struct slab {
 #endif
 			};
 			/* Double-word boundary */
-			void *freelist;		/* first free object */
 			union {
-				unsigned long counters;
 				struct {
-					unsigned inuse:16;
-					unsigned objects:15;
-					unsigned frozen:1;
+					void *freelist;		/* first free object */
+					union {
+						unsigned long counters;
+						struct {
+							unsigned inuse:16;
+							unsigned objects:15;
+							unsigned frozen:1;
+						};
+					};
 				};
+				freelist_aba_t freelist_counter;
 			};
 		};
 		struct rcu_head rcu_head;
@@ -72,7 +109,7 @@ SLAB_MATCH(memcg_data, memcg_data);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
+#if defined(system_has_freelist_aba) && defined(CONFIG_SLUB)
 static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 2*sizeof(void *)));
 #endif
 
diff --git a/mm/slub.c b/mm/slub.c
index c87628c..161b091 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -292,7 +292,12 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 /* Poison object */
 #define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
 /* Use cmpxchg_double */
+
+#ifdef system_has_freelist_aba
 #define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
+#else
+#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
+#endif
 
 /*
  * Tracking user of a slab.
@@ -512,6 +517,40 @@ static __always_inline void slab_unlock(struct slab *slab)
 	__bit_spin_unlock(PG_locked, &page->flags);
 }
 
+static inline bool
+__update_freelist_fast(struct slab *slab,
+		      void *freelist_old, unsigned long counters_old,
+		      void *freelist_new, unsigned long counters_new)
+{
+#ifdef system_has_freelist_aba
+	freelist_aba_t old = { .freelist = freelist_old, .counter = counters_old };
+	freelist_aba_t new = { .freelist = freelist_new, .counter = counters_new };
+
+	return try_cmpxchg_freelist(&slab->freelist_counter.full, &old.full, new.full);
+#else
+	return false;
+#endif
+}
+
+static inline bool
+__update_freelist_slow(struct slab *slab,
+		      void *freelist_old, unsigned long counters_old,
+		      void *freelist_new, unsigned long counters_new)
+{
+	bool ret = false;
+
+	slab_lock(slab);
+	if (slab->freelist == freelist_old &&
+	    slab->counters == counters_old) {
+		slab->freelist = freelist_new;
+		slab->counters = counters_new;
+		ret = true;
+	}
+	slab_unlock(slab);
+
+	return ret;
+}
+
 /*
  * Interrupts must be disabled (for the fallback code to work right), typically
  * by an _irqsave() lock variant. On PREEMPT_RT the preempt_disable(), which is
@@ -519,33 +558,25 @@ static __always_inline void slab_unlock(struct slab *slab)
  * allocation/ free operation in hardirq context. Therefore nothing can
  * interrupt the operation.
  */
-static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
+static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
+	bool ret;
+
 	if (USE_LOCKLESS_FAST_PATH())
 		lockdep_assert_irqs_disabled();
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
-    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&slab->freelist, &slab->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
-			return true;
-	} else
-#endif
-	{
-		slab_lock(slab);
-		if (slab->freelist == freelist_old &&
-					slab->counters == counters_old) {
-			slab->freelist = freelist_new;
-			slab->counters = counters_new;
-			slab_unlock(slab);
-			return true;
-		}
-		slab_unlock(slab);
+		ret = __update_freelist_fast(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
+	} else {
+		ret = __update_freelist_slow(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
 	}
+	if (likely(ret))
+		return true;
 
 	cpu_relax();
 	stat(s, CMPXCHG_DOUBLE_FAIL);
@@ -557,36 +588,26 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
 	return false;
 }
 
-static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
+static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
-    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+	bool ret;
+
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&slab->freelist, &slab->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
-			return true;
-	} else
-#endif
-	{
+		ret = __update_freelist_fast(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
+	} else {
 		unsigned long flags;
 
 		local_irq_save(flags);
-		slab_lock(slab);
-		if (slab->freelist == freelist_old &&
-					slab->counters == counters_old) {
-			slab->freelist = freelist_new;
-			slab->counters = counters_new;
-			slab_unlock(slab);
-			local_irq_restore(flags);
-			return true;
-		}
-		slab_unlock(slab);
+		ret = __update_freelist_slow(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
 		local_irq_restore(flags);
 	}
+	if (likely(ret))
+		return true;
 
 	cpu_relax();
 	stat(s, CMPXCHG_DOUBLE_FAIL);
@@ -2228,7 +2249,7 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	VM_BUG_ON(new.frozen);
 	new.frozen = 1;
 
-	if (!__cmpxchg_double_slab(s, slab,
+	if (!__slab_update_freelist(s, slab,
 			freelist, counters,
 			new.freelist, new.counters,
 			"acquire_slab"))
@@ -2554,7 +2575,7 @@ redo:
 	}
 
 
-	if (!cmpxchg_double_slab(s, slab,
+	if (!slab_update_freelist(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab")) {
@@ -2611,7 +2632,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 
 			new.frozen = 0;
 
-		} while (!__cmpxchg_double_slab(s, slab,
+		} while (!__slab_update_freelist(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab"));
@@ -3008,6 +3029,22 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
 }
 
 #ifndef CONFIG_SLUB_TINY
+static inline bool
+__update_cpu_freelist_fast(struct kmem_cache *s,
+			   void *freelist_old, void *freelist_new,
+			   unsigned long tid)
+{
+#ifdef system_has_freelist_aba
+	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
+	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
+
+	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
+					 old.full, new.full) == old.full;
+#else
+	return false;
+#endif
+}
+
 /*
  * Check the slab->freelist and either transfer the freelist to the
  * per cpu freelist or deactivate the slab.
@@ -3034,7 +3071,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 		new.inuse = slab->objects;
 		new.frozen = freelist != NULL;
 
-	} while (!__cmpxchg_double_slab(s, slab,
+	} while (!__slab_update_freelist(s, slab,
 		freelist, counters,
 		NULL, new.counters,
 		"get_freelist"));
@@ -3359,11 +3396,7 @@ redo:
 		 * against code executing on this cpu *not* from access by
 		 * other cpus.
 		 */
-		if (unlikely(!this_cpu_cmpxchg_double(
-				s->cpu_slab->freelist, s->cpu_slab->tid,
-				object, tid,
-				next_object, next_tid(tid)))) {
-
+		if (unlikely(!__update_cpu_freelist_fast(s, object, next_object, tid))) {
 			note_cmpxchg_failure("slab_alloc", s, tid);
 			goto redo;
 		}
@@ -3631,7 +3664,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			}
 		}
 
-	} while (!cmpxchg_double_slab(s, slab,
+	} while (!slab_update_freelist(s, slab,
 		prior, counters,
 		head, new.counters,
 		"__slab_free"));
@@ -3736,11 +3769,7 @@ redo:
 
 		set_freepointer(s, tail_obj, freelist);
 
-		if (unlikely(!this_cpu_cmpxchg_double(
-				s->cpu_slab->freelist, s->cpu_slab->tid,
-				freelist, tid,
-				head, next_tid(tid)))) {
-
+		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
 			note_cmpxchg_failure("slab_free", s, tid);
 			goto redo;
 		}
@@ -4505,11 +4534,11 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 		}
 	}
 
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
-    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
-	if (system_has_cmpxchg_double() && (s->flags & SLAB_NO_CMPXCHG) == 0)
+#ifdef system_has_freelist_aba
+	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
 		/* Enable fast mode */
 		s->flags |= __CMPXCHG_DOUBLE;
+	}
 #endif
 
 	/*
