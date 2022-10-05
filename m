Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6A5F5451
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJEMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJEMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:21:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1533F53019
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:21:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664972482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jzLKw1j8nRFlDp9C0E7uu+hxhzMNX0ccMsJT0RrZp6k=;
        b=1eELc529iuPAAhkpwDLDacOaAm18xquyPdYowtN0lqR3tHhVMwiH2GUQ3s5VGDA/jE4JnJ
        xiWEnlIyA7s7B5e/sPV70uCT4621CHBv8m5sFLWm9u+nZhjUWsy4seVBFNnxi3v5EwrzZ1
        VCiy96FceTjwGc3wn7xjoylP0HvoJObRf+wfvLIGH1c5way9y3oXsl2jBFGqbbquE06ZBd
        AYedkZBBfErmVpCUdphHK0HvqO/098Qy9oox6fdsOPJh2lslRSuveW3OBnSgVcrtZ+IBTK
        a2MBAjN1NGTWzGGbSdqr+/jyOgJKr+Ur+822oyXHSsseph0x78Hh4wzV8c5gIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664972482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jzLKw1j8nRFlDp9C0E7uu+hxhzMNX0ccMsJT0RrZp6k=;
        b=AxS7HgwEzg4czwzpkZy3RCR1+X03QumviiEyOn2/SSl1pVfaUwX2f+3qnWzm8EAozEMokW
        tJDgwBAZHouzBAAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/rt for v6.1-rc1
Message-ID: <166497241171.125841.9535880258521894817.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed,  5 Oct 2022 14:21:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/rt branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-rt-2022-10=
-05

up to:  44b0c2957adc: u64_stats: Streamline the implementation

Preempt RT cleanups:

 Introduce preempt_[dis|enable_nested() and use it to clean up
 various places which have open coded PREEMPT_RT conditionals.

 On PREEMPT_RT enabled kernels, spinlocks and rwlocks are neither disabling
 preemption nor interrupts. Though there are a few places which depend on
 the implicit preemption/interrupt disable of those locks, e.g. seqcount
 write sections, per CPU statistics updates etc.

 PREEMPT_RT added open coded CONFIG_PREEMPT_RT conditionals to
 disable/enable preemption in the related code parts all over the
 place. That's hard to read and does not really explain why this is
 necessary.

 Linus suggested to use helper functions (preempt_disable_nested() and
 preempt_enable_nested()) and use those in the affected places. On !RT
 enabled kernels these functions are NOPs, but contain a lockdep assert to
 validate that preemption is actually disabled to catch call sites which
 do not have preemption disabled.

 Clean up the affected code paths in mm, dentry and lib.

   =20

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (1):
      flex_proportions: Disable preemption entering the write section.

Thomas Gleixner (7):
      preempt: Provide preempt_[dis|en]able_nested()
      dentry: Use preempt_[dis|en]able_nested()
      mm/vmstat: Use preempt_[dis|en]able_nested()
      mm/debug: Provide VM_WARN_ON_IRQS_ENABLED()
      mm/memcontrol: Replace the PREEMPT_RT conditionals
      mm/compaction: Get rid of RT ifdeffery
      u64_stats: Streamline the implementation


 fs/dcache.c                    |  13 +---
 include/linux/mmdebug.h        |   6 ++
 include/linux/preempt.h        |  42 ++++++++++++
 include/linux/u64_stats_sync.h | 145 ++++++++++++++++++---------------------=
--
 lib/Kconfig.debug              |   3 +
 lib/flex_proportions.c         |   2 +
 mm/Kconfig                     |   6 ++
 mm/compaction.c                |   6 +-
 mm/memcontrol.c                |  19 ++----
 mm/vmstat.c                    |  36 ++++------
 10 files changed, 144 insertions(+), 134 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index bb0c4d0038db..2ee8636016ee 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2597,15 +2597,7 @@ EXPORT_SYMBOL(d_rehash);
=20
 static inline unsigned start_dir_add(struct inode *dir)
 {
-	/*
-	 * The caller holds a spinlock (dentry::d_lock). On !PREEMPT_RT
-	 * kernels spin_lock() implicitly disables preemption, but not on
-	 * PREEMPT_RT.  So for RT it has to be done explicitly to protect
-	 * the sequence count write side critical section against a reader
-	 * or another writer preempting, which would result in a live lock.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	for (;;) {
 		unsigned n =3D dir->i_dir_seq;
 		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) =3D=3D n)
@@ -2618,8 +2610,7 @@ static inline void end_dir_add(struct inode *dir, unsig=
ned int n,
 			       wait_queue_head_t *d_wait)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 	wake_up_all(d_wait);
 }
=20
diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 15ae78cd2853..b8728d11c949 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -94,6 +94,12 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
=20
+#ifdef CONFIG_DEBUG_VM_IRQSOFF
+#define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
+#else
+#define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_VIRTUAL
 #define VIRTUAL_BUG_ON(cond) BUG_ON(cond)
 #else
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b4381f255a5c..0df425bf9bd7 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -421,4 +421,46 @@ static inline void migrate_enable(void) { }
=20
 #endif /* CONFIG_SMP */
=20
+/**
+ * preempt_disable_nested - Disable preemption inside a normally preempt dis=
abled section
+ *
+ * Use for code which requires preemption protection inside a critical
+ * section which has preemption disabled implicitly on non-PREEMPT_RT
+ * enabled kernels, by e.g.:
+ *  - holding a spinlock/rwlock
+ *  - soft interrupt context
+ *  - regular interrupt handlers
+ *
+ * On PREEMPT_RT enabled kernels spinlock/rwlock held sections, soft
+ * interrupt context and regular interrupt handlers are preemptible and
+ * only prevent migration. preempt_disable_nested() ensures that preemption
+ * is disabled for cases which require CPU local serialization even on
+ * PREEMPT_RT. For non-PREEMPT_RT kernels this is a NOP.
+ *
+ * The use cases are code sequences which are not serialized by a
+ * particular lock instance, e.g.:
+ *  - seqcount write side critical sections where the seqcount is not
+ *    associated to a particular lock and therefore the automatic
+ *    protection mechanism does not work. This prevents a live lock
+ *    against a preempting high priority reader.
+ *  - RMW per CPU variable updates like vmstat.
+ */
+/* Macro to avoid header recursion hell vs. lockdep */
+#define preempt_disable_nested()				\
+do {								\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		preempt_disable();				\
+	else							\
+		lockdep_assert_preemption_disabled();		\
+} while (0)
+
+/**
+ * preempt_enable_nested - Undo the effect of preempt_disable_nested()
+ */
+static __always_inline void preempt_enable_nested(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 6ad4e9032d53..46040d66334a 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -8,7 +8,7 @@
  *
  * Key points :
  *
- * -  Use a seqcount on 32-bit SMP, only disable preemption for 32-bit UP.
+ * -  Use a seqcount on 32-bit
  * -  The whole thing is a no-op on 64-bit architectures.
  *
  * Usage constraints:
@@ -20,7 +20,8 @@
  *    writer and also spin forever.
  *
  * 3) Write side must use the _irqsave() variant if other writers, or a read=
er,
- *    can be invoked from an IRQ context.
+ *    can be invoked from an IRQ context. On 64bit systems this variant does=
 not
+ *    disable interrupts.
  *
  * 4) If reader fetches several counters, there is no guarantee the whole va=
lues
  *    are consistent w.r.t. each other (remember point #2: seqcounts are not
@@ -29,11 +30,6 @@
  * 5) Readers are allowed to sleep or be preempted/interrupted: they perform
  *    pure reads.
  *
- * 6) Readers must use both u64_stats_fetch_{begin,retry}_irq() if the stats
- *    might be updated from a hardirq or softirq context (remember point #1:
- *    seqcounts are not used for UP kernels). 32-bit UP stat readers could r=
ead
- *    corrupted 64-bit values otherwise.
- *
  * Usage :
  *
  * Stats producer (writer) should use following template granted it already =
got
@@ -66,7 +62,7 @@
 #include <linux/seqlock.h>
=20
 struct u64_stats_sync {
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
+#if BITS_PER_LONG =3D=3D 32
 	seqcount_t	seq;
 #endif
 };
@@ -98,7 +94,22 @@ static inline void u64_stats_inc(u64_stats_t *p)
 	local64_inc(&p->v);
 }
=20
-#else
+static inline void u64_stats_init(struct u64_stats_sync *syncp) { }
+static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp) { }
+static inline void __u64_stats_update_end(struct u64_stats_sync *syncp) { }
+static inline unsigned long __u64_stats_irqsave(void) { return 0; }
+static inline void __u64_stats_irqrestore(unsigned long flags) { }
+static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sy=
nc *syncp)
+{
+	return 0;
+}
+static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *sync=
p,
+					   unsigned int start)
+{
+	return false;
+}
+
+#else /* 64 bit */
=20
 typedef struct {
 	u64		v;
@@ -123,123 +134,95 @@ static inline void u64_stats_inc(u64_stats_t *p)
 {
 	p->v++;
 }
-#endif
=20
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
-#define u64_stats_init(syncp)	seqcount_init(&(syncp)->seq)
-#else
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
 {
+	seqcount_init(&syncp->seq);
 }
-#endif
=20
-static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
+static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	write_seqcount_begin(&syncp->seq);
-#endif
 }
=20
-static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
+static inline void __u64_stats_update_end(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
 	write_seqcount_end(&syncp->seq);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-#endif
+	preempt_enable_nested();
 }
=20
-static inline unsigned long
-u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+static inline unsigned long __u64_stats_irqsave(void)
 {
-	unsigned long flags =3D 0;
+	unsigned long flags;
=20
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
-	else
-		local_irq_save(flags);
-	write_seqcount_begin(&syncp->seq);
-#endif
+	local_irq_save(flags);
 	return flags;
 }
=20
-static inline void
-u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
-				unsigned long flags)
+static inline void __u64_stats_irqrestore(unsigned long flags)
 {
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
-	write_seqcount_end(&syncp->seq);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
-#endif
+	local_irq_restore(flags);
 }
=20
 static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sy=
nc *syncp)
 {
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
 	return read_seqcount_begin(&syncp->seq);
-#else
-	return 0;
-#endif
 }
=20
-static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync=
 *syncp)
+static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *sync=
p,
+					   unsigned int start)
 {
-#if BITS_PER_LONG =3D=3D 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREE=
MPT_RT))
-	preempt_disable();
-#endif
-	return __u64_stats_fetch_begin(syncp);
+	return read_seqcount_retry(&syncp->seq, start);
 }
+#endif /* !64 bit */
=20
-static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *sync=
p,
-					 unsigned int start)
+static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG =3D=3D 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMP=
T_RT))
-	return read_seqcount_retry(&syncp->seq, start);
-#else
-	return false;
-#endif
+	__u64_stats_update_begin(syncp);
+}
+
+static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
+{
+	__u64_stats_update_end(syncp);
+}
+
+static inline unsigned long u64_stats_update_begin_irqsave(struct u64_stats_=
sync *syncp)
+{
+	unsigned long flags =3D __u64_stats_irqsave();
+
+	__u64_stats_update_begin(syncp);
+	return flags;
+}
+
+static inline void u64_stats_update_end_irqrestore(struct u64_stats_sync *sy=
ncp,
+						   unsigned long flags)
+{
+	__u64_stats_update_end(syncp);
+	__u64_stats_irqrestore(flags);
+}
+
+static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync=
 *syncp)
+{
+	return __u64_stats_fetch_begin(syncp);
 }
=20
 static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 					 unsigned int start)
 {
-#if BITS_PER_LONG =3D=3D 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREE=
MPT_RT))
-	preempt_enable();
-#endif
 	return __u64_stats_fetch_retry(syncp, start);
 }
=20
-/*
- * In case irq handlers can update u64 counters, readers can use following h=
elpers
- * - SMP 32bit arches use seqcount protection, irq safe.
- * - UP 32bit must disable irqs.
- * - 64bit have no problem atomically reading u64 values, irq safe.
- */
+/* Obsolete interfaces */
 static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_=
sync *syncp)
 {
-#if BITS_PER_LONG =3D=3D 32 && defined(CONFIG_PREEMPT_RT)
-	preempt_disable();
-#elif BITS_PER_LONG =3D=3D 32 && !defined(CONFIG_SMP)
-	local_irq_disable();
-#endif
-	return __u64_stats_fetch_begin(syncp);
+	return u64_stats_fetch_begin(syncp);
 }
=20
 static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *sy=
ncp,
 					     unsigned int start)
 {
-#if BITS_PER_LONG =3D=3D 32 && defined(CONFIG_PREEMPT_RT)
-	preempt_enable();
-#elif BITS_PER_LONG =3D=3D 32 && !defined(CONFIG_SMP)
-	local_irq_enable();
-#endif
-	return __u64_stats_fetch_retry(syncp, start);
+	return u64_stats_fetch_retry(syncp, start);
 }
=20
 #endif /* _LINUX_U64_STATS_SYNC_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bcbe60d6c80c..cdb4b27ef1a0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -803,6 +803,9 @@ config ARCH_HAS_DEBUG_VM_PGTABLE
 	  An architecture should select this when it can successfully
 	  build and run DEBUG_VM_PGTABLE.
=20
+config DEBUG_VM_IRQSOFF
+	def_bool DEBUG_VM && !PREEMPT_RT
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 05cccbcf1661..83332fefa6f4 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -70,6 +70,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	 */
 	if (events <=3D 1)
 		return false;
+	preempt_disable_nested();
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -=3D events >> periods;
@@ -77,6 +78,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period +=3D periods;
 	write_seqcount_end(&p->sequence);
+	preempt_enable_nested();
=20
 	return true;
 }
diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81..3897e924e40f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -579,6 +579,12 @@ config COMPACTION
 	  it and then we would be really interested to hear about that at
 	  linux-mm@kvack.org.
=20
+config COMPACT_UNEVICTABLE_DEFAULT
+	int
+	depends on COMPACTION
+	default 0 if PREEMPT_RT
+	default 1
+
 #
 # support for free page reporting
 config PAGE_REPORTING
diff --git a/mm/compaction.c b/mm/compaction.c
index 640fa76228dd..10561cb1aaad 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1727,11 +1727,7 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
-#ifdef CONFIG_PREEMPT_RT
-int sysctl_compact_unevictable_allowed __read_mostly =3D 0;
-#else
-int sysctl_compact_unevictable_allowed __read_mostly =3D 1;
-#endif
+int sysctl_compact_unevictable_allowed __read_mostly =3D CONFIG_COMPACT_UNEV=
ICTABLE_DEFAULT;
=20
 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..d35b6fa560f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -597,25 +597,18 @@ static u64 flush_next_time;
  */
 static void memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#else
-      VM_BUG_ON(!irqs_disabled());
-#endif
+	preempt_disable_nested();
+	VM_WARN_ON_IRQS_ENABLED();
 }
=20
 static void __memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#endif
+	preempt_disable_nested();
 }
=20
 static void memcg_stats_unlock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_enable();
-#endif
+	preempt_enable_nested();
 }
=20
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
@@ -715,7 +708,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum=
 node_stat_item idx,
 	 * interrupt context while other caller need to have disabled interrupt.
 	 */
 	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
 		switch (idx) {
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
@@ -725,7 +718,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum=
 node_stat_item idx,
 			WARN_ON_ONCE(!in_task());
 			break;
 		default:
-			WARN_ON_ONCE(!irqs_disabled());
+			VM_WARN_ON_IRQS_ENABLED();
 		}
 	}
=20
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..7a2d73f15230 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -355,8 +355,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_s=
tat_item item,
 	 * CPU migrations and preemption potentially corrupts a counter so
 	 * disable preemption.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	x =3D delta + __this_cpu_read(*p);
=20
@@ -368,8 +367,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_s=
tat_item item,
 	}
 	__this_cpu_write(*p, x);
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
=20
@@ -393,8 +391,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enu=
m node_stat_item item,
 	}
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	x =3D delta + __this_cpu_read(*p);
=20
@@ -406,8 +403,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enu=
m node_stat_item item,
 	}
 	__this_cpu_write(*p, x);
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
=20
@@ -441,8 +437,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_i=
tem item)
 	s8 v, t;
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_inc_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -453,8 +448,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_i=
tem item)
 		__this_cpu_write(*p, -overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -466,8 +460,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum nod=
e_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_inc_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -478,8 +471,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum nod=
e_stat_item item)
 		__this_cpu_write(*p, -overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -501,8 +493,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_i=
tem item)
 	s8 v, t;
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_dec_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -513,8 +504,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_i=
tem item)
 		__this_cpu_write(*p, overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -526,8 +516,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum nod=
e_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_dec_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -538,8 +527,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum nod=
e_stat_item item)
 		__this_cpu_write(*p, overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)

