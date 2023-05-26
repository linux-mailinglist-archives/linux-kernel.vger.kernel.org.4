Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D1712956
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbjEZPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244102AbjEZPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:23:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937411BB;
        Fri, 26 May 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aDDRfIRALymKGYTGPzWZEeq6LhR5c9CExYB33O4qi8c=; b=jPZfcDD6XLJh/y5T/mXEk4yY7u
        7y+972qq0afpUqUen5NJ7dnixuDUk2+JHg2ivSHFXLI2JpM4W9yHwzcfTNNBbs0fAaa272jNlU85p
        Z1IzrHRYRh+kQ4TPWrgYoli4hlXLJUmn3H4xj6seahw6sM3bPPWO53Qz0pift98UdvnRSgcz5tjWf
        fJyYdjooLxhZAnDm4/RH8cCItgB5oAu6ca9QLrySix9kVpxyGoPNO1VIXb5rcM7fLHMqVJKjxTv5m
        oe92TLdtcn4Y2V+j/iGytMu6ymFB90xrkT65Sy6VtyXsosnUV8EpAq9UHObrYgLj6Ovocym37NGGu
        ykdu72KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2ZHE-007cia-1I;
        Fri, 26 May 2023 15:22:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87021300673;
        Fri, 26 May 2023 17:22:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3B12F2023D644; Fri, 26 May 2023 17:22:44 +0200 (CEST)
Message-ID: <20230526151946.960406324@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 May 2023 17:05:50 +0200
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
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
References: <20230526150549.250372621@infradead.org>
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

Use __attribute__((__cleanup__(func))) to buid various guards:

 - ptr_guard()
 - void_guard() / void_scope()
 - lock_guard() / lock_scope()
 - double_lock_guard() / double_lock_scope()

Where the _guard thingies are variables with scope-based cleanup and
the _scope thingies are basically do-once for-loops with the same.

The CPP is rather impenetrable -- but I'll attempt to write proper
comments if/when people think this is worth pursuing.

Actual usage in the next patch

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_attributes.h |    2 
 include/linux/irqflags.h            |    7 ++
 include/linux/guards.h          |  118 ++++++++++++++++++++++++++++++++++++
 include/linux/mutex.h               |    5 +
 include/linux/preempt.h             |    4 +
 include/linux/rcupdate.h            |    3 
 include/linux/sched/task.h          |    2 
 include/linux/spinlock.h            |   23 +++++++
 8 files changed, 164 insertions(+)

--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -366,4 +366,6 @@
  */
 #define __fix_address noinline __noclone
 
+#define __cleanup(func)			__attribute__((__cleanup__(func)))
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
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
 
+DEFINE_VOID_GUARD(irq, local_irq_disable(), local_irq_enable())
+DEFINE_VOID_GUARD(irqsave,
+		  local_irq_save(_G->flags),
+		  local_irq_restore(_G->flags),
+		  unsigned long flags;)
+
 #endif
--- /dev/null
+++ b/include/linux/guards.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GUARDS_H
+#define __LINUX_GUARDS_H
+
+#include <linux/compiler_attributes.h>
+
+/* Pointer Guard */
+
+#define DEFINE_PTR_GUARD(_type, _Type, _Put)				\
+typedef _Type *ptr_guard_##_type##_t;					\
+static inline void ptr_guard_##_type##_cleanup(_Type **_ptr)		\
+{									\
+	_Type *_G = *_ptr;						\
+	if (_G)								\
+		_Put(_G);						\
+}
+
+#define ptr_guard(_type, _name)						\
+	ptr_guard_##_type##_t _name __cleanup(ptr_guard_##_type##_cleanup)
+
+
+/* Void Guard */
+
+#define DEFINE_VOID_GUARD(_type, _Lock, _Unlock, ...)				\
+typedef struct {								\
+	__VA_ARGS__								\
+} void_guard_##_type##_t;							\
+										\
+static inline void void_guard_##_type##_cleanup(void *_g)			\
+{										\
+	void_guard_##_type##_t *_G __maybe_unused = _g;				\
+	_Unlock;								\
+}										\
+										\
+static inline void_guard_##_type##_t void_guard_##_type##_init(void)		\
+{										\
+	void_guard_##_type##_t _g = { }, *_G __maybe_unused = &_g;		\
+	_Lock;									\
+	return _g;								\
+}
+
+#define void_guard(_type, _name)						\
+	void_guard_##_type##_t _name __cleanup(void_guard_##_type##_cleanup) =	\
+	void_guard_##_type##_init()
+
+#define void_scope(_type)							\
+	for (struct { void_guard_##_type##_t guard; bool done; } _scope		\
+	     __cleanup(void_guard_##_type##_cleanup) =				\
+	     { .guard = void_guard_##_type##_init() }; !_scope.done;		\
+	     _scope.done = true)
+
+
+/* Lock Guard */
+
+#define DEFINE_LOCK_GUARD(_type, _Type, _Lock, _Unlock, ...)			\
+typedef struct {								\
+	_Type *lock;								\
+	__VA_ARGS__								\
+} lock_guard_##_type##_t;							\
+										\
+static inline void lock_guard_##_type##_cleanup(void *_g)			\
+{										\
+	lock_guard_##_type##_t *_G = _g;					\
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
+#define lock_guard(_type, _name, _ptr)						\
+	lock_guard_##_type##_t _name __cleanup(lock_guard_##_type##_cleanup) =	\
+	lock_guard_##_type##_init(_ptr)
+
+#define lock_scope(_type, _ptr)							\
+	for (struct { lock_guard_##_type##_t guard; bool done; } _scope		\
+	     __cleanup(lock_guard_##_type##_cleanup) =				\
+	     { .guard = lock_guard_##_type##_init(_ptr) }; !_scope.done;	\
+	     _scope.done = true)
+
+
+/* Double Lock Guard */
+
+#define DEFINE_DOUBLE_LOCK_GUARD(_type, _Type, _Lock, _Unlock, ...)		\
+typedef struct {								\
+	_Type *lock;								\
+	_Type *lock2;								\
+	__VA_ARGS__								\
+} double_lock_guard_##_type##_t;						\
+										\
+static inline void double_lock_guard_##_type##_cleanup(void *_g) 		\
+{										\
+	double_lock_guard_##_type##_t *_G = _g;					\
+	_Unlock;								\
+}										\
+										\
+static inline double_lock_guard_##_type##_t double_lock_guard_##_type##_init(_Type *lock, _Type *lock2) \
+{										\
+	double_lock_guard_##_type##_t _g = { .lock = lock, .lock2 = lock2 }, *_G = &_g;\
+	_Lock;									\
+	return _g;								\
+}
+
+#define double_lock_guard(_type, _name, _ptr, _ptr2)				\
+	double_lock_guard_##_type##_t _name __cleanup(double_lock_guard_##_type##_cleanup) = \
+	double_lock_guard_##_type##_init(_ptr, _ptr2)
+
+#define double_lock_scope(_type, _ptr, _ptr2)					\
+	for (struct { double_lock_guard_##_type##_t guard; bool done; } _scope	\
+	     __cleanup(double_lock_guard_##_type##_cleanup) =			\
+	     { .guard = double_lock_guard_##_type##_init(_ptr, _ptr2) };	\
+	     !_scope.done; _scope.done = true)
+
+
+#endif /* __LINUX_GUARDS_H */
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
 
+DEFINE_LOCK_GUARD(mutex, struct mutex,
+		  mutex_lock(_G->lock),
+		  mutex_unlock(_G->lock))
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
 
+DEFINE_VOID_GUARD(preempt, preempt_disable(), preempt_enable())
+DEFINE_VOID_GUARD(migrate, migrate_disable(), migrate_enable())
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
 
+DEFINE_VOID_GUARD(rcu, rcu_read_lock(), rcu_read_unlock())
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
 
@@ -502,5 +503,27 @@ int __alloc_bucket_spinlocks(spinlock_t
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+DEFINE_LOCK_GUARD(raw, raw_spinlock_t,
+		  raw_spin_lock(_G->lock),
+		  raw_spin_unlock(_G->lock))
+DEFINE_LOCK_GUARD(raw_irq, raw_spinlock_t,
+		  raw_spin_lock_irq(_G->lock),
+		  raw_spin_unlock_irq(_G->lock))
+DEFINE_LOCK_GUARD(raw_irqsave, raw_spinlock_t,
+		  raw_spin_lock_irqsave(_G->lock, _G->flags),
+		  raw_spin_unlock_irqrestore(_G->lock, _G->flags),
+		  unsigned long flags;)
+
+DEFINE_LOCK_GUARD(spin, spinlock_t,
+		  spin_lock(_G->lock),
+		  spin_unlock(_G->lock))
+DEFINE_LOCK_GUARD(spin_irq, spinlock_t,
+		  spin_lock_irq(_G->lock),
+		  spin_unlock_irq(_G->lock))
+DEFINE_LOCK_GUARD(spin_irqsave, spinlock_t,
+		  spin_lock_irqsave(_G->lock, _G->flags),
+		  spin_unlock_irqrestore(_G->lock, _G->flags),
+		  unsigned long flags;)
+
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */


