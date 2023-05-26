Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3D712E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbjEZVBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbjEZVBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:01:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD1BC;
        Fri, 26 May 2023 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wURy4lxzk/MrGEFXC8cHIPvRafnSizbQlFWQkp81o38=; b=cFsJOmIBHuxy1xUriTe13VZ6vw
        /6skX1O3gOlIS6UjsYhtatZWFMzeKbV5mS9pWE/h16pWWAvUo6eO/5LC0LH2led+NFUM0NUMo8Q8I
        25VwE0JxYMskrfcQUm9yUQzq4Q95hWhZsV1o2+QOnBdSlFyz832kS/eUxBxGgESfM04dDY0naD1VA
        e8iosIlbBMn5FcaqNbIYpkVkZsS4m6hk0PA3Vsvgfy1Flb5hTFrAAv/R3y2bfPR9XiePoRaHCzNZf
        6iV+KQL83ifxMhNJ/RWs3H5OpC0MbVP7j6reA+N7+W0zoaTXxS3ZDG/lxaDrOh6cjHxuCKXdEtLl5
        CnfynjBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2eYG-007hpP-2z;
        Fri, 26 May 2023 21:00:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0885E3006F6;
        Fri, 26 May 2023 23:00:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B5B30205BBDAF; Fri, 26 May 2023 23:00:41 +0200 (CEST)
Message-ID: <20230526205855.587341916@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 May 2023 22:52:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 1/2] locking: Introduce __cleanup__ based guards
References: <20230526205204.861311518@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __attribute__((__cleanup__(func))) to buid pointer and lock
guards.

Actual usage in the next patch

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_attributes.h |    6 +
 include/linux/guards.h              |  142 ++++++++++++++++++++++++++++++++++++
 include/linux/irqflags.h            |    7 +
 include/linux/mutex.h               |    5 +
 include/linux/preempt.h             |    4 +
 include/linux/rcupdate.h            |    3 
 include/linux/sched/task.h          |    2 
 include/linux/spinlock.h            |   27 ++++++
 scripts/checkpatch.pl               |    2 
 9 files changed, 197 insertions(+), 1 deletion(-)

--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -77,6 +77,12 @@
 #define __attribute_const__             __attribute__((__const__))
 
 /*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
+ */
+#define __cleanup(func)			__attribute__((__cleanup__(func)))
+
+/*
  * Optional: only supported since gcc >= 9
  * Optional: not supported by clang
  *
--- /dev/null
+++ b/include/linux/guards.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GUARDS_H
+#define __LINUX_GUARDS_H
+
+#include <linux/compiler_attributes.h>
+
+/*
+ * Pointer Guards are special pointers (variables) with a scope bound cleanup
+ * function.
+ *
+ * Various guard types can be created using:
+ *
+ *   DEFINE_PTR_GUARD(guard_type, typename, cleanup-exp)
+ *
+ * After which they can be used like so:
+ *
+ *   ptr_guard(guard_type, name) = find_get_object(foo);
+ *
+ * Where the return type of find_get_object() should match the guard_type's
+ * 'typname *'. And when @name goes out of scope cleanup-exp is ran (inserted
+ * by the compiler) when !NULL at that time. Also see the __cleanup attribute.
+ */
+
+#define DEFINE_PTR_GUARD(_type, _Type, _Put)					\
+typedef _Type *ptr_guard_##_type##_t;						\
+										\
+static inline void ptr_guard_##_type##_cleanup(_Type **_ptr)			\
+{										\
+	_Type *_G = *_ptr;							\
+	if (_G)									\
+		_Put(_G);							\
+}
+
+#define ptr_guard(_type, _name)							\
+	ptr_guard_##_type##_t _name __cleanup(ptr_guard_##_type##_cleanup)
+
+
+/*
+ * Lock Guards are like the pointer guards above except they also have
+ * a fixed initializor to cover both the Lock and Unlock of the lock type.
+ *
+ * Lock guards types can be created using:
+ *
+ *   DEFINE_LOCK_GUARD_0(guard_type, Lock, Unlock, [extra guard members])
+ *   DEFINE_LOCK_GUARD_1(guard_type, typename, Lock, Unlock, ...)
+ *   DEFINE_LOCK_GUARD_2(guard_type, typename, Lock, Unlock, ...)
+ *
+ * Where the _n suffix indicates the number of arguments of 'typename *' the
+ * Lock function requires.
+ *
+ * Once defined, the lock guards can be used in one of two ways:
+ *
+ *	guard(guard_type, name, var...);
+ *
+ * or:
+ *
+ *	scoped (guard_type, var...) {
+ *		...
+ *	}
+ *
+ * The first creates a named variable that is initialized with the Lock
+ * function and will call the Unlock function when it goes out of scope.
+ *
+ * The second creates an explicit scope, using a for-loop with an implicit
+ * named _scope variable. Again, Lock is called before the scope is entered and
+ * Unlock will be called when the scope is left.
+ *
+ * Both Lock and Unlock are expressions and can access the guard object through
+ * the _G pointer. The guard object will have _n implicit members called of
+ * type 'typename *' called 'lock' and 'lock2' as well as any additional
+ * members specified in the definition.
+ */
+
+#define DEFINE_LOCK_GUARD_0(_type, _Lock, _Unlock, ...)				\
+typedef struct {								\
+	__VA_ARGS__;								\
+} lock_guard_##_type##_t;							\
+										\
+static inline void lock_guard_##_type##_cleanup(lock_guard_##_type##_t *_G)	\
+{										\
+	_Unlock;								\
+}										\
+										\
+static inline lock_guard_##_type##_t lock_guard_##_type##_init(void)		\
+{										\
+	lock_guard_##_type##_t _g = { }, *_G __maybe_unused = &_g;		\
+	_Lock;									\
+	return _g;								\
+}
+
+#define DEFINE_LOCK_GUARD_1(_type, _Type, _Lock, _Unlock, ...)			\
+typedef struct {								\
+	_Type *lock;								\
+	__VA_ARGS__;								\
+} lock_guard_##_type##_t;							\
+										\
+static inline void lock_guard_##_type##_cleanup(lock_guard_##_type##_t *_G)	\
+{										\
+	_Unlock;								\
+}										\
+										\
+static inline lock_guard_##_type##_t lock_guard_##_type##_init(_Type *lock)	\
+{										\
+	lock_guard_##_type##_t _g = { .lock = lock }, *_G = &_g;		\
+	_Lock;									\
+	return _g;								\
+}
+
+#define DEFINE_LOCK_GUARD_2(_type, _Type, _Lock, _Unlock, ...)			\
+typedef struct {								\
+	_Type *lock;								\
+	_Type *lock2;								\
+	__VA_ARGS__;								\
+} lock_guard_##_type##_t;							\
+										\
+static inline void lock_guard_##_type##_cleanup(lock_guard_##_type##_t *_G)	\
+{										\
+	_Unlock;								\
+}										\
+										\
+static inline lock_guard_##_type##_t						\
+lock_guard_##_type##_init(_Type *lock, _Type *lock2)				\
+{										\
+	lock_guard_##_type##_t _g = { .lock = lock, .lock2 = lock2 }, *_G = &_g;\
+	_Lock;									\
+	return _g;								\
+}
+
+#define variable_scope(_type, _enter, _exit)					\
+	for (_type *_done = NULL, _scope __cleanup(_exit) = _enter;		\
+	     !_done; _done = (void *)8)
+
+#define scoped(_type, _var...)							\
+	variable_scope(lock_guard_##_type##_t,					\
+		       lock_guard_##_type##_init(_var),				\
+		       lock_guard_##_type##_cleanup)
+
+#define guard(_type, _name, _var...)						\
+	lock_guard_##_type##_t __cleanup(lock_guard_##_type##_cleanup) _name =	\
+		lock_guard_##_type##_init(_var)
+
+#endif /* __LINUX_GUARDS_H */
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/guards.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -267,4 +268,10 @@ extern void warn_bogus_irq_restore(void)
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
+DEFINE_LOCK_GUARD_0(irqsave,
+		    local_irq_save(_G->flags),
+		    local_irq_restore(_G->flags),
+		    unsigned long flags)
+
 #endif
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/guards.h>
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
@@ -219,4 +220,8 @@ extern void mutex_unlock(struct mutex *l
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
+DEFINE_LOCK_GUARD_1(mutex, struct mutex,
+		    mutex_lock(_G->lock),
+		    mutex_unlock(_G->lock))
+
 #endif /* __LINUX_MUTEX_H */
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/guards.h>
 #include <linux/list.h>
 
 /*
@@ -463,4 +464,7 @@ static __always_inline void preempt_enab
 		preempt_enable();
 }
 
+DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif /* __LINUX_PREEMPT_H */
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -27,6 +27,7 @@
 #include <linux/preempt.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/guards.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
 #include <linux/context_tracking_irq.h>
@@ -1095,4 +1096,6 @@ rcu_head_after_call_rcu(struct rcu_head
 extern int rcu_expedited;
 extern int rcu_normal;
 
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+
 #endif /* __LINUX_RCUPDATE_H */
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -126,6 +126,8 @@ static inline void put_task_struct(struc
 		__put_task_struct(t);
 }
 
+DEFINE_PTR_GUARD(put_task, struct task_struct, put_task_struct)
+
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -61,6 +61,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/guards.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
@@ -502,5 +503,31 @@ int __alloc_bucket_spinlocks(spinlock_t
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_G->lock),
+		    raw_spin_unlock(_G->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_G->lock),
+		    raw_spin_unlock_irq(_G->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_G->lock, _G->flags),
+		    raw_spin_unlock_irqrestore(_G->lock, _G->flags),
+		    unsigned long flags)
+
+DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
+		    spin_lock(_G->lock),
+		    spin_unlock(_G->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
+		    spin_lock_irq(_G->lock),
+		    spin_unlock_irq(_G->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
+		    spin_lock_irqsave(_G->lock, _G->flags),
+		    spin_unlock_irqrestore(_G->lock, _G->flags),
+		    unsigned long flags)
+
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5046,7 +5046,7 @@ sub process {
 				if|for|while|switch|return|case|
 				volatile|__volatile__|
 				__attribute__|format|__extension__|
-				asm|__asm__)$/x)
+				asm|__asm__|scoped)$/x)
 			{
 			# cpp #define statements have non-optional spaces, ie
 			# if there is a space between the name and the open


