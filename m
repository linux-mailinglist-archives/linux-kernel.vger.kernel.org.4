Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014626F4449
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjEBMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjEBMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:52:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D259E1;
        Tue,  2 May 2023 05:52:26 -0700 (PDT)
Date:   Tue, 02 May 2023 12:52:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683031942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRVKrvE+7b8NqLxgGXFFsS4/5M39HOyhxMBAE3oCyqE=;
        b=vdDyTkLl4lL5503EyVnTekpvkTmioAHdGymkIC4vCc4wozwuR8PRcmZUKhzzp8xGASzwvm
        jBfnxg1ZHj47HS8U1q4/ixWwrsBXYysUgQm9i83Aecv94ShcLziEOpKOsmdTcRueaNYj4E
        Gcc4jt/hbzsoEgXoRPrqlfZX7jtgH+MUH2Pm7CQn/xsNfRnWyjXznFa5vetO5cLvewCM4O
        tx5LEyI1GlX6FpGnEeMkHqvNMGeeKV5raqKfuxOlmgK6m5BgcW7l5FW9o+o0QBdoioTeJe
        WiYJXKd16/mlmLPSvCLdmcvZmaLAcp3jHDd0fNkIMrIKbjDk0LO1kUxfp/XhZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683031942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRVKrvE+7b8NqLxgGXFFsS4/5M39HOyhxMBAE3oCyqE=;
        b=CM1oUaAvRguax279t56gQcy7S/MIEBgLWYVK4+QT86eGef5lKX6oZUUrsOXC8xDhUlrjwa
        /V8geJEmTIMsiKAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects,locking: Annotate
 debug_object_fill_pool() wait type violation
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230429100614.GA1489784@hirez.programming.kicks-ass.net>
References: <20230429100614.GA1489784@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168303194177.404.8610123576035502891.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     0cce06ba859a515bd06224085d3addb870608b6d
Gitweb:        https://git.kernel.org/tip/0cce06ba859a515bd06224085d3addb870608b6d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Apr 2023 17:03:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 02 May 2023 14:48:14 +02:00

debugobjects,locking: Annotate debug_object_fill_pool() wait type violation

There is an explicit wait-type violation in debug_object_fill_pool()
for PREEMPT_RT=n kernels which allows them to more easily fill the
object pool and reduce the chance of allocation failures.

Lockdep's wait-type checks are designed to check the PREEMPT_RT
locking rules even for PREEMPT_RT=n kernels and object to this, so
create a lockdep annotation to allow this to stand.

Specifically, create a 'lock' type that overrides the inner wait-type
while it is held -- allowing one to temporarily raise it, such that
the violation is hidden.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qi Zheng <zhengqi.arch@bytedance.com>
Link: https://lkml.kernel.org/r/20230429100614.GA1489784@hirez.programming.kicks-ass.net
---
 include/linux/lockdep.h       | 14 ++++++++++++++
 include/linux/lockdep_types.h |  1 +
 kernel/locking/lockdep.c      | 28 +++++++++++++++++++++-------
 lib/debugobjects.c            | 15 +++++++++++++--
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1023f34..a3329fb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -339,6 +339,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
 #define lockdep_unpin_lock(l,c)	lock_unpin_lock(&(l)->dep_map, (c))
 
+/*
+ * Must use lock_map_aquire_try() with override maps to avoid
+ * lockdep thinking they participate in the block chain.
+ */
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map _name = {			\
+		.name = #_name "-wait-type-override",	\
+		.wait_type_inner = _wait_type,		\
+		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -427,6 +437,9 @@ extern int lockdep_is_held(const void *);
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map __maybe_unused _name = {}
+
 #endif /* !LOCKDEP */
 
 enum xhlock_context_t {
@@ -551,6 +564,7 @@ do {									\
 #define rwsem_release(l, i)			lock_release(l, i)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
+#define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d224308..59f4fb1 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
 enum lockdep_lock_type {
 	LD_LOCK_NORMAL = 0,	/* normal, catch all */
 	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_WAIT_OVERRIDE,	/* annotation */
 	LD_LOCK_MAX,
 };
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863..62ef295 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2253,6 +2253,9 @@ static inline bool usage_match(struct lock_list *entry, void *mask)
 
 static inline bool usage_skip(struct lock_list *entry, void *mask)
 {
+	if (entry->class->lock_type == LD_LOCK_NORMAL)
+		return false;
+
 	/*
 	 * Skip local_lock() for irq inversion detection.
 	 *
@@ -2279,14 +2282,16 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
 	 * As a result, we will skip local_lock(), when we search for irq
 	 * inversion bugs.
 	 */
-	if (entry->class->lock_type == LD_LOCK_PERCPU) {
-		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
-			return false;
+	if (entry->class->lock_type == LD_LOCK_PERCPU &&
+	    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+		return false;
 
-		return true;
-	}
+	/*
+	 * Skip WAIT_OVERRIDE for irq inversion detection -- it's not actually
+	 * a lock and only used to override the wait_type.
+	 */
 
-	return false;
+	return true;
 }
 
 /*
@@ -4752,7 +4757,8 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		u8 prev_inner = hlock_class(prev)->wait_type_inner;
+		struct lock_class *class = hlock_class(prev);
+		u8 prev_inner = class->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4762,6 +4768,14 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 			 * Also due to trylocks.
 			 */
 			curr_inner = min(curr_inner, prev_inner);
+
+			/*
+			 * Allow override for annotations -- this is typically
+			 * only valid/needed for code that only exists when
+			 * CONFIG_PREEMPT_RT=n.
+			 */
+			if (unlikely(class->lock_type == LD_LOCK_WAIT_OVERRIDE))
+				curr_inner = prev_inner;
 		}
 	}
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 003edc5..826c617 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -591,10 +591,21 @@ static void debug_objects_fill_pool(void)
 {
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context -- for !RT kernels we rely on the fact that spinlock_t and
+	 * raw_spinlock_t are basically the same type and this lock-type
+	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		/*
+		 * Annotate away the spinlock_t inside raw_spinlock_t warning
+		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * the preemptible() condition above.
+		 */
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
+		lock_map_release(&fill_pool_map);
+	}
 }
 
 static void
