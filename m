Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24B4721FED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjFEHnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjFEHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B0CD;
        Mon,  5 Jun 2023 00:42:54 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxriJXHIxry6ntRuqEWpiCoIiRQEOs8YhaZDm44n/6o=;
        b=j+GaaRFcl8rBLM73KS90aa00DzS82P77DEXHZuPAh9xpugWsohD7GW2uYMZm6BLYyPfKGg
        ZUvfETS4lPllBGVESYgfyM3TvbEqq1DG84B4laISwMl/dhOkb2yjoQWRcVyAH+oWsXOUF8
        vtV/imOuJKZwyunBw9LPwDW37rQYTs/KmBvbREL8LDrdwDqqcHKQ/GIBLLlDkPHxzZbqUM
        3QwkyHr6WzsF6phiLAR+tO+MfWdt7t15x7+x3wXrenoJn78sOUhaqX9Qm5vBAeG3uO837u
        gGCdodFTm/GADzaONj6EJEgU4W1EebLZ+kJLGye60pPawLxgsy6tkFmAB5Z++A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxriJXHIxry6ntRuqEWpiCoIiRQEOs8YhaZDm44n/6o=;
        b=TqElpIbnAPVSp88LWVY6t0mWVO8g12xDjpjPKCNJn0fDIvwUsCb8sE1EqADNxvBQF6aOye
        dqmOREhUcZ3Ao8Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] percpu: Add {raw,this}_cpu_try_cmpxchg()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.587480729@infradead.org>
References: <20230531132323.587480729@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097138.404.12287049788720492697.tip-bot2@tip-bot2>
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

Commit-ID:     c5c0ba953b8c969c5d51bf1c57f239866a97c47c
Gitweb:        https://git.kernel.org/tip/c5c0ba953b8c969c5d51bf1c57f239866a97c47c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:36 +02:00

percpu: Add {raw,this}_cpu_try_cmpxchg()

Add the try_cmpxchg() form to the per-cpu ops.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.587480729@infradead.org
---
 include/asm-generic/percpu.h | 113 ++++++++++++++++++++++++++++++++--
 include/linux/percpu-defs.h  |  19 ++++++-
 2 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 6432a7f..96af32c 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -89,16 +89,37 @@ do {									\
 	__ret;								\
 })
 
-#define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
+#define __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, _cmpxchg)		\
+({									\
+	typeof(pcp) __val, __old = *(ovalp);				\
+	__val = _cmpxchg(pcp, __old, nval);				\
+	if (__val != __old)						\
+		*(ovalp) = __val;					\
+	__val == __old;							\
+})
+
+#define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
 ({									\
 	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __ret;						\
-	__ret = *__p;							\
-	if (__ret == (oval))						\
+	typeof(pcp) __val = *__p, __old = *(ovalp);			\
+	bool __ret;							\
+	if (__val == __old) {						\
 		*__p = nval;						\
+		__ret = true;						\
+	} else {							\
+		*(ovalp) = __val;					\
+		__ret = false;						\
+	}								\
 	__ret;								\
 })
 
+#define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
+({									\
+	typeof(pcp) __old = (oval);					\
+	raw_cpu_generic_try_cmpxchg(pcp, &__old, nval);			\
+	__old;								\
+})
+
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
 	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
@@ -170,6 +191,16 @@ do {									\
 	__ret;								\
 })
 
+#define this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
+({									\
+	bool __ret;							\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval);		\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
 #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
 	typeof(pcp) __ret;						\
@@ -282,6 +313,43 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef raw_cpu_try_cmpxchg_1
+#ifdef raw_cpu_cmpxchg_1
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_1)
+#else
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg_2
+#ifdef raw_cpu_cmpxchg_2
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_2)
+#else
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg_4
+#ifdef raw_cpu_cmpxchg_4
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_4)
+#else
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg_8
+#ifdef raw_cpu_cmpxchg_8
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_8)
+#else
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef raw_cpu_cmpxchg_1
 #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -407,6 +475,43 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)	this_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef this_cpu_try_cmpxchg_1
+#ifdef this_cpu_cmpxchg_1
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_1)
+#else
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg_2
+#ifdef this_cpu_cmpxchg_2
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_2)
+#else
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg_4
+#ifdef this_cpu_cmpxchg_4
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_4)
+#else
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg_8
+#ifdef this_cpu_cmpxchg_8
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_8)
+#else
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef this_cpu_cmpxchg_1
 #define this_cpu_cmpxchg_1(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index e60727b..cbbf6d1 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -343,6 +343,21 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 	pscr2_ret__;							\
 })
 
+#define __pcpu_size_call_return2bool(stem, variable, ...)		\
+({									\
+	bool pscr2_ret__;						\
+	__verify_pcpu_ptr(&(variable));					\
+	switch(sizeof(variable)) {					\
+	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
+	case 2: pscr2_ret__ = stem##2(variable, __VA_ARGS__); break;	\
+	case 4: pscr2_ret__ = stem##4(variable, __VA_ARGS__); break;	\
+	case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break;	\
+	default:							\
+		__bad_size_call_parameter(); break;			\
+	}								\
+	pscr2_ret__;							\
+})
+
 /*
  * Special handling for cmpxchg_double.  cmpxchg_double is passed two
  * percpu variables.  The first has to be aligned to a double word
@@ -426,6 +441,8 @@ do {									\
 #define raw_cpu_xchg(pcp, nval)		__pcpu_size_call_return2(raw_cpu_xchg_, pcp, nval)
 #define raw_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
+#define raw_cpu_try_cmpxchg(pcp, ovalp, nval) \
+	__pcpu_size_call_return2bool(raw_cpu_try_cmpxchg_, pcp, ovalp, nval)
 #define raw_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(raw_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 
@@ -513,6 +530,8 @@ do {									\
 #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
 #define this_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
+#define this_cpu_try_cmpxchg(pcp, ovalp, nval) \
+	__pcpu_size_call_return2bool(this_cpu_try_cmpxchg_, pcp, ovalp, nval)
 #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 
