Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5356F77AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjEDVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEDVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:01:43 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B01493C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230732;
        bh=QRmMLfXg5unF7/3RNcMH7AOL6J3UpJBYx5LfEyiS2RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/dCD84HuYJgTT5w4IJtqAmtHBQh8auLZmyc/r854jojAY8mbnR7qunxRrDb9sm/H
         PuqMc5qLmGpf0CBbmricpzPkYNSERIKKeFL40PZmw64U1phoW3/ggTIZ+E2g4/aELv
         S30ofIhjNFqOU9X3sLYYavOSH8ljbEGVN6KfSnv1D84bVErgj3V6K5loX4+xKwYOCi
         zK1XyIig4dExnSpgyxNEGupyY9pxRo0k01WaggUNcSMG5FLPxOdAc4My9Us0IPxImJ
         BLRNcl9nQknH66s5Eq5XrY9xjP5nxHlm6MJlITftb3DdwY9G1s3ivy8Uy6rP3SyPYm
         GGfK4Q/1eDeRQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yl5vByzxRG;
        Thu,  4 May 2023 16:05:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: [RFC PATCH 01/13] rcu: rcupdate.h: Fix parentheses around macro parameter use
Date:   Thu,  4 May 2023 16:05:15 -0400
Message-Id: <20230504200527.1935944-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:

  typeof(*p)

rather than

  typeof(*(p))

The following test-case shows how it can generate confusion due to C
operator precedence being reversed compared to the expectations:

    #define m(p) \
    do { \
            __typeof__(*p) v = 0; \
    } while (0)

    void fct(unsigned long long *p1)
    {
            m(p1 + 1);      /* works */
            m(1 + p1);      /* broken */
    }

Add missing parentheses around macro parameter use in the following
pattern to ensure operator precedence behaves as expected:

- m(&p) is changed for m(&(p)).

Remove useless parentheses in the following macro argument usage
patterns:

- m((x), y) is changed for m(x, y), because comma has the lowest
  operator precedence, and thus the extra parentheses are useless.
- "(_r_a_p__v) where _r_a_p__v is a variable and not a macro parameter,
  is changed for "_r_a_p__v",

An extra whitespace is also removed in kvfree_rcu_arg_2() for
consistency.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang1.zhang@intel.com>
---
 include/linux/rcupdate.h | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dcd2cf1e8326..4f26c3080953 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -215,7 +215,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 										\
 		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
 		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+			rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);	\
 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
@@ -227,7 +227,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 
 #define rcu_tasks_qs(t, preempt)					\
 do {									\
-	rcu_tasks_classic_qs((t), (preempt));				\
+	rcu_tasks_classic_qs(t, preempt);				\
 	rcu_tasks_trace_qs(t);						\
 } while (0)
 
@@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #ifdef __CHECKER__
 #define rcu_check_sparse(p, space) \
-	((void)(((typeof(*p) space *)p) == p))
+	((void)(((typeof(*(p)) space *)(p)) == (p)))
 #else /* #ifdef __CHECKER__ */
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
 #define __unrcu_pointer(p, local)					\
 ({									\
-	typeof(*p) *local = (typeof(*p) *__force)(p);			\
+	typeof(*(p)) *local = (typeof(*(p)) *__force)(p);		\
 	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(local)); 			\
+	((typeof(*(p)) __force __kernel *)(local));			\
 })
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
@@ -452,29 +452,29 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #define __rcu_access_pointer(p, local, space) \
 ({ \
-	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((typeof(*(p)) __force __kernel *)(local)); \
 })
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((typeof(*(p)) __force __kernel *)(local)); \
 })
 #define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(p)); \
+	((typeof(*(p)) __force __kernel *)(p)); \
 })
 #define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
 	typeof(p) local = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((typeof(*(p)) __force __kernel *)(local)); \
 })
 #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 
@@ -520,10 +520,10 @@ do {									      \
 	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
 	rcu_check_sparse(p, __rcu);					      \
 									      \
-	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
-		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
+	if (__builtin_constant_p(v) && _r_a_p__v == (uintptr_t)NULL)	      \
+		WRITE_ONCE(p, (typeof(p))_r_a_p__v);			      \
 	else								      \
-		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
+		smp_store_release(&(p), RCU_INITIALIZER((typeof(p))_r_a_p__v));\
 } while (0)
 
 /**
@@ -539,8 +539,8 @@ do {									      \
  */
 #define rcu_replace_pointer(rcu_ptr, ptr, c)				\
 ({									\
-	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
-	rcu_assign_pointer((rcu_ptr), (ptr));				\
+	typeof(ptr) __tmp = rcu_dereference_protected(rcu_ptr, c);	\
+	rcu_assign_pointer(rcu_ptr, ptr);				\
 	__tmp;								\
 })
 
@@ -571,7 +571,7 @@ do {									      \
  * down multi-linked structures after a grace period has elapsed.  However,
  * rcu_dereference_protected() is normally preferred for this use case.
  */
-#define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
+#define rcu_access_pointer(p) __rcu_access_pointer(p, __UNIQUE_ID(rcu), __rcu)
 
 /**
  * rcu_dereference_check() - rcu_dereference with debug checking
@@ -607,7 +607,7 @@ do {									      \
  * annotated as __rcu.
  */
 #define rcu_dereference_check(p, c) \
-	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+	__rcu_dereference_check(p, __UNIQUE_ID(rcu), \
 				(c) || rcu_read_lock_held(), __rcu)
 
 /**
@@ -623,7 +623,7 @@ do {									      \
  * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
-	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+	__rcu_dereference_check(p, __UNIQUE_ID(rcu), \
 				(c) || rcu_read_lock_bh_held(), __rcu)
 
 /**
@@ -639,7 +639,7 @@ do {									      \
  * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
-	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+	__rcu_dereference_check(p, __UNIQUE_ID(rcu), \
 				(c) || rcu_read_lock_sched_held(), \
 				__rcu)
 
@@ -651,7 +651,7 @@ do {									      \
  * rcu_read_lock_held().
  */
 #define rcu_dereference_raw_check(p) \
-	__rcu_dereference_check((p), __UNIQUE_ID(rcu), 1, __rcu)
+	__rcu_dereference_check(p, __UNIQUE_ID(rcu), 1, __rcu)
 
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
@@ -670,7 +670,7 @@ do {									      \
  * but very ugly failures.
  */
 #define rcu_dereference_protected(p, c) \
-	__rcu_dereference_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
+	__rcu_dereference_protected(p, __UNIQUE_ID(rcu), c, __rcu)
 
 
 /**
@@ -1021,7 +1021,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
-	typeof (ptr) ___p = (ptr);					\
+	typeof(ptr) ___p = (ptr);					\
 									\
 	if (___p) {									\
 		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
-- 
2.25.1

