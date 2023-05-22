Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6270BE3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjEVM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjEVM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:27:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DDA71705;
        Mon, 22 May 2023 05:25:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1FFA1688;
        Mon, 22 May 2023 05:26:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 014E73F59C;
        Mon, 22 May 2023 05:25:17 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 17/26] locking/atomic: scripts: add trivial raw_atomic*_<op>()
Date:   Mon, 22 May 2023 13:24:20 +0100
Message-Id: <20230522122429.1915021-18-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a number of arch_atomic*_<op>() functions are optional, and
where an arch does not provide a given arch_atomic*_<op>() we will
define an implementation of arch_atomic*_<op>() in
atomic-arch-fallback.h.

Filling in the missing ops requires special care as we want to select
the optimal definition of each op (e.g. preferentially defining ops in
terms of their relaxed form rather than their fully-ordered form). The
ifdeffery necessary for this requires us to group ordering variants
together, which can be a bit painful to read, and is painful for
kerneldoc generation.

It would be easier to handle this if we generated ops into a separate
namespace, as this would remove the need to take special care with the
ifdeffery, and allow each ordering variant to be generated separately.

This patch adds a new set of raw_atomic_<op>() definitions, which are
currently trivial wrappers of their arch_atomic_<op>() equivalent. This
will allow us to move treewide users of arch_atomic_<op>() over to raw
atomic op before we rework the fallback generation to generate
raw_atomic_<op> directly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/atomic.h                     |    1 +
 include/linux/atomic/atomic-instrumented.h |  595 ++++---
 include/linux/atomic/atomic-raw.h          | 1645 ++++++++++++++++++++
 scripts/atomic/gen-atomic-instrumented.sh  |   19 +-
 scripts/atomic/gen-atomic-raw.sh           |   84 +
 scripts/atomic/gen-atomics.sh              |    1 +
 6 files changed, 2033 insertions(+), 312 deletions(-)
 create mode 100644 include/linux/atomic/atomic-raw.h
 create mode 100755 scripts/atomic/gen-atomic-raw.sh

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9b..127f5dc63a7df 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -79,6 +79,7 @@
 
 #include <linux/atomic/atomic-arch-fallback.h>
 #include <linux/atomic/atomic-long.h>
+#include <linux/atomic/atomic-raw.h>
 #include <linux/atomic/atomic-instrumented.h>
 
 #endif /* _LINUX_ATOMIC_H */
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index a55b5b70a3e15..90ee2f55af770 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -4,15 +4,10 @@
 // DO NOT MODIFY THIS FILE DIRECTLY
 
 /*
- * This file provides wrappers with KASAN instrumentation for atomic operations.
- * To use this functionality an arch's atomic.h file needs to define all
- * atomic operations with arch_ prefix (e.g. arch_atomic_read()) and include
- * this file at the end. This file provides atomic_read() that forwards to
- * arch_atomic_read() for actual atomic operation.
- * Note: if an arch atomic operation is implemented by means of other atomic
- * operations (e.g. atomic_read()/atomic_cmpxchg() loop), then it needs to use
- * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
- * double instrumentation.
+ * This file provoides atomic operations with explicit instrumentation (e.g.
+ * KASAN, KCSAN), which should be used unless it is necessary to avoid
+ * instrumentation. Where it is necessary to aovid instrumenation, the
+ * raw_atomic*() operations should be used.
  */
 #ifndef _LINUX_ATOMIC_INSTRUMENTED_H
 #define _LINUX_ATOMIC_INSTRUMENTED_H
@@ -25,21 +20,21 @@ static __always_inline int
 atomic_read(const atomic_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic_read(v);
+	return raw_atomic_read(v);
 }
 
 static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic_read_acquire(v);
+	return raw_atomic_read_acquire(v);
 }
 
 static __always_inline void
 atomic_set(atomic_t *v, int i)
 {
 	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic_set(v, i);
+	raw_atomic_set(v, i);
 }
 
 static __always_inline void
@@ -47,14 +42,14 @@ atomic_set_release(atomic_t *v, int i)
 {
 	kcsan_release();
 	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic_set_release(v, i);
+	raw_atomic_set_release(v, i);
 }
 
 static __always_inline void
 atomic_add(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_add(i, v);
+	raw_atomic_add(i, v);
 }
 
 static __always_inline int
@@ -62,14 +57,14 @@ atomic_add_return(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return(i, v);
+	return raw_atomic_add_return(i, v);
 }
 
 static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return_acquire(i, v);
+	return raw_atomic_add_return_acquire(i, v);
 }
 
 static __always_inline int
@@ -77,14 +72,14 @@ atomic_add_return_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return_release(i, v);
+	return raw_atomic_add_return_release(i, v);
 }
 
 static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return_relaxed(i, v);
+	return raw_atomic_add_return_relaxed(i, v);
 }
 
 static __always_inline int
@@ -92,14 +87,14 @@ atomic_fetch_add(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add(i, v);
+	return raw_atomic_fetch_add(i, v);
 }
 
 static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_acquire(i, v);
+	return raw_atomic_fetch_add_acquire(i, v);
 }
 
 static __always_inline int
@@ -107,21 +102,21 @@ atomic_fetch_add_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_release(i, v);
+	return raw_atomic_fetch_add_release(i, v);
 }
 
 static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_relaxed(i, v);
+	return raw_atomic_fetch_add_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_sub(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_sub(i, v);
+	raw_atomic_sub(i, v);
 }
 
 static __always_inline int
@@ -129,14 +124,14 @@ atomic_sub_return(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return(i, v);
+	return raw_atomic_sub_return(i, v);
 }
 
 static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return_acquire(i, v);
+	return raw_atomic_sub_return_acquire(i, v);
 }
 
 static __always_inline int
@@ -144,14 +139,14 @@ atomic_sub_return_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return_release(i, v);
+	return raw_atomic_sub_return_release(i, v);
 }
 
 static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return_relaxed(i, v);
+	return raw_atomic_sub_return_relaxed(i, v);
 }
 
 static __always_inline int
@@ -159,14 +154,14 @@ atomic_fetch_sub(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub(i, v);
+	return raw_atomic_fetch_sub(i, v);
 }
 
 static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub_acquire(i, v);
+	return raw_atomic_fetch_sub_acquire(i, v);
 }
 
 static __always_inline int
@@ -174,21 +169,21 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub_release(i, v);
+	return raw_atomic_fetch_sub_release(i, v);
 }
 
 static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub_relaxed(i, v);
+	return raw_atomic_fetch_sub_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_inc(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_inc(v);
+	raw_atomic_inc(v);
 }
 
 static __always_inline int
@@ -196,14 +191,14 @@ atomic_inc_return(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return(v);
+	return raw_atomic_inc_return(v);
 }
 
 static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return_acquire(v);
+	return raw_atomic_inc_return_acquire(v);
 }
 
 static __always_inline int
@@ -211,14 +206,14 @@ atomic_inc_return_release(atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return_release(v);
+	return raw_atomic_inc_return_release(v);
 }
 
 static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return_relaxed(v);
+	return raw_atomic_inc_return_relaxed(v);
 }
 
 static __always_inline int
@@ -226,14 +221,14 @@ atomic_fetch_inc(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc(v);
+	return raw_atomic_fetch_inc(v);
 }
 
 static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc_acquire(v);
+	return raw_atomic_fetch_inc_acquire(v);
 }
 
 static __always_inline int
@@ -241,21 +236,21 @@ atomic_fetch_inc_release(atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc_release(v);
+	return raw_atomic_fetch_inc_release(v);
 }
 
 static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc_relaxed(v);
+	return raw_atomic_fetch_inc_relaxed(v);
 }
 
 static __always_inline void
 atomic_dec(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_dec(v);
+	raw_atomic_dec(v);
 }
 
 static __always_inline int
@@ -263,14 +258,14 @@ atomic_dec_return(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return(v);
+	return raw_atomic_dec_return(v);
 }
 
 static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return_acquire(v);
+	return raw_atomic_dec_return_acquire(v);
 }
 
 static __always_inline int
@@ -278,14 +273,14 @@ atomic_dec_return_release(atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return_release(v);
+	return raw_atomic_dec_return_release(v);
 }
 
 static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return_relaxed(v);
+	return raw_atomic_dec_return_relaxed(v);
 }
 
 static __always_inline int
@@ -293,14 +288,14 @@ atomic_fetch_dec(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec(v);
+	return raw_atomic_fetch_dec(v);
 }
 
 static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec_acquire(v);
+	return raw_atomic_fetch_dec_acquire(v);
 }
 
 static __always_inline int
@@ -308,21 +303,21 @@ atomic_fetch_dec_release(atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec_release(v);
+	return raw_atomic_fetch_dec_release(v);
 }
 
 static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec_relaxed(v);
+	return raw_atomic_fetch_dec_relaxed(v);
 }
 
 static __always_inline void
 atomic_and(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_and(i, v);
+	raw_atomic_and(i, v);
 }
 
 static __always_inline int
@@ -330,14 +325,14 @@ atomic_fetch_and(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and(i, v);
+	return raw_atomic_fetch_and(i, v);
 }
 
 static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and_acquire(i, v);
+	return raw_atomic_fetch_and_acquire(i, v);
 }
 
 static __always_inline int
@@ -345,21 +340,21 @@ atomic_fetch_and_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and_release(i, v);
+	return raw_atomic_fetch_and_release(i, v);
 }
 
 static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and_relaxed(i, v);
+	return raw_atomic_fetch_and_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_andnot(i, v);
+	raw_atomic_andnot(i, v);
 }
 
 static __always_inline int
@@ -367,14 +362,14 @@ atomic_fetch_andnot(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot(i, v);
+	return raw_atomic_fetch_andnot(i, v);
 }
 
 static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot_acquire(i, v);
+	return raw_atomic_fetch_andnot_acquire(i, v);
 }
 
 static __always_inline int
@@ -382,21 +377,21 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot_release(i, v);
+	return raw_atomic_fetch_andnot_release(i, v);
 }
 
 static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot_relaxed(i, v);
+	return raw_atomic_fetch_andnot_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_or(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_or(i, v);
+	raw_atomic_or(i, v);
 }
 
 static __always_inline int
@@ -404,14 +399,14 @@ atomic_fetch_or(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or(i, v);
+	return raw_atomic_fetch_or(i, v);
 }
 
 static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or_acquire(i, v);
+	return raw_atomic_fetch_or_acquire(i, v);
 }
 
 static __always_inline int
@@ -419,21 +414,21 @@ atomic_fetch_or_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or_release(i, v);
+	return raw_atomic_fetch_or_release(i, v);
 }
 
 static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or_relaxed(i, v);
+	return raw_atomic_fetch_or_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_xor(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_xor(i, v);
+	raw_atomic_xor(i, v);
 }
 
 static __always_inline int
@@ -441,14 +436,14 @@ atomic_fetch_xor(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor(i, v);
+	return raw_atomic_fetch_xor(i, v);
 }
 
 static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor_acquire(i, v);
+	return raw_atomic_fetch_xor_acquire(i, v);
 }
 
 static __always_inline int
@@ -456,14 +451,14 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor_release(i, v);
+	return raw_atomic_fetch_xor_release(i, v);
 }
 
 static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor_relaxed(i, v);
+	return raw_atomic_fetch_xor_relaxed(i, v);
 }
 
 static __always_inline int
@@ -471,14 +466,14 @@ atomic_xchg(atomic_t *v, int i)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg(v, i);
+	return raw_atomic_xchg(v, i);
 }
 
 static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg_acquire(v, i);
+	return raw_atomic_xchg_acquire(v, i);
 }
 
 static __always_inline int
@@ -486,14 +481,14 @@ atomic_xchg_release(atomic_t *v, int i)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg_release(v, i);
+	return raw_atomic_xchg_release(v, i);
 }
 
 static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg_relaxed(v, i);
+	return raw_atomic_xchg_relaxed(v, i);
 }
 
 static __always_inline int
@@ -501,14 +496,14 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg(v, old, new);
+	return raw_atomic_cmpxchg(v, old, new);
 }
 
 static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg_acquire(v, old, new);
+	return raw_atomic_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline int
@@ -516,14 +511,14 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg_release(v, old, new);
+	return raw_atomic_cmpxchg_release(v, old, new);
 }
 
 static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg_relaxed(v, old, new);
+	return raw_atomic_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
@@ -532,7 +527,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg(v, old, new);
+	return raw_atomic_try_cmpxchg(v, old, new);
 }
 
 static __always_inline bool
@@ -540,7 +535,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg_acquire(v, old, new);
+	return raw_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline bool
@@ -549,7 +544,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg_release(v, old, new);
+	return raw_atomic_try_cmpxchg_release(v, old, new);
 }
 
 static __always_inline bool
@@ -557,7 +552,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	return raw_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
@@ -565,7 +560,7 @@ atomic_sub_and_test(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_and_test(i, v);
+	return raw_atomic_sub_and_test(i, v);
 }
 
 static __always_inline bool
@@ -573,7 +568,7 @@ atomic_dec_and_test(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_and_test(v);
+	return raw_atomic_dec_and_test(v);
 }
 
 static __always_inline bool
@@ -581,7 +576,7 @@ atomic_inc_and_test(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_and_test(v);
+	return raw_atomic_inc_and_test(v);
 }
 
 static __always_inline bool
@@ -589,14 +584,14 @@ atomic_add_negative(int i, atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_negative(i, v);
+	return raw_atomic_add_negative(i, v);
 }
 
 static __always_inline bool
 atomic_add_negative_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_negative_acquire(i, v);
+	return raw_atomic_add_negative_acquire(i, v);
 }
 
 static __always_inline bool
@@ -604,14 +599,14 @@ atomic_add_negative_release(int i, atomic_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_negative_release(i, v);
+	return raw_atomic_add_negative_release(i, v);
 }
 
 static __always_inline bool
 atomic_add_negative_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_negative_relaxed(i, v);
+	return raw_atomic_add_negative_relaxed(i, v);
 }
 
 static __always_inline int
@@ -619,7 +614,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_unless(v, a, u);
+	return raw_atomic_fetch_add_unless(v, a, u);
 }
 
 static __always_inline bool
@@ -627,7 +622,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_unless(v, a, u);
+	return raw_atomic_add_unless(v, a, u);
 }
 
 static __always_inline bool
@@ -635,7 +630,7 @@ atomic_inc_not_zero(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_not_zero(v);
+	return raw_atomic_inc_not_zero(v);
 }
 
 static __always_inline bool
@@ -643,7 +638,7 @@ atomic_inc_unless_negative(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_unless_negative(v);
+	return raw_atomic_inc_unless_negative(v);
 }
 
 static __always_inline bool
@@ -651,7 +646,7 @@ atomic_dec_unless_positive(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_unless_positive(v);
+	return raw_atomic_dec_unless_positive(v);
 }
 
 static __always_inline int
@@ -659,28 +654,28 @@ atomic_dec_if_positive(atomic_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_if_positive(v);
+	return raw_atomic_dec_if_positive(v);
 }
 
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic64_read(v);
+	return raw_atomic64_read(v);
 }
 
 static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic64_read_acquire(v);
+	return raw_atomic64_read_acquire(v);
 }
 
 static __always_inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
 	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic64_set(v, i);
+	raw_atomic64_set(v, i);
 }
 
 static __always_inline void
@@ -688,14 +683,14 @@ atomic64_set_release(atomic64_t *v, s64 i)
 {
 	kcsan_release();
 	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic64_set_release(v, i);
+	raw_atomic64_set_release(v, i);
 }
 
 static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_add(i, v);
+	raw_atomic64_add(i, v);
 }
 
 static __always_inline s64
@@ -703,14 +698,14 @@ atomic64_add_return(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return(i, v);
+	return raw_atomic64_add_return(i, v);
 }
 
 static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return_acquire(i, v);
+	return raw_atomic64_add_return_acquire(i, v);
 }
 
 static __always_inline s64
@@ -718,14 +713,14 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return_release(i, v);
+	return raw_atomic64_add_return_release(i, v);
 }
 
 static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return_relaxed(i, v);
+	return raw_atomic64_add_return_relaxed(i, v);
 }
 
 static __always_inline s64
@@ -733,14 +728,14 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add(i, v);
+	return raw_atomic64_fetch_add(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_acquire(i, v);
+	return raw_atomic64_fetch_add_acquire(i, v);
 }
 
 static __always_inline s64
@@ -748,21 +743,21 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_release(i, v);
+	return raw_atomic64_fetch_add_release(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_relaxed(i, v);
+	return raw_atomic64_fetch_add_relaxed(i, v);
 }
 
 static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_sub(i, v);
+	raw_atomic64_sub(i, v);
 }
 
 static __always_inline s64
@@ -770,14 +765,14 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return(i, v);
+	return raw_atomic64_sub_return(i, v);
 }
 
 static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return_acquire(i, v);
+	return raw_atomic64_sub_return_acquire(i, v);
 }
 
 static __always_inline s64
@@ -785,14 +780,14 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return_release(i, v);
+	return raw_atomic64_sub_return_release(i, v);
 }
 
 static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return_relaxed(i, v);
+	return raw_atomic64_sub_return_relaxed(i, v);
 }
 
 static __always_inline s64
@@ -800,14 +795,14 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub(i, v);
+	return raw_atomic64_fetch_sub(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub_acquire(i, v);
+	return raw_atomic64_fetch_sub_acquire(i, v);
 }
 
 static __always_inline s64
@@ -815,21 +810,21 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub_release(i, v);
+	return raw_atomic64_fetch_sub_release(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub_relaxed(i, v);
+	return raw_atomic64_fetch_sub_relaxed(i, v);
 }
 
 static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_inc(v);
+	raw_atomic64_inc(v);
 }
 
 static __always_inline s64
@@ -837,14 +832,14 @@ atomic64_inc_return(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return(v);
+	return raw_atomic64_inc_return(v);
 }
 
 static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return_acquire(v);
+	return raw_atomic64_inc_return_acquire(v);
 }
 
 static __always_inline s64
@@ -852,14 +847,14 @@ atomic64_inc_return_release(atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return_release(v);
+	return raw_atomic64_inc_return_release(v);
 }
 
 static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return_relaxed(v);
+	return raw_atomic64_inc_return_relaxed(v);
 }
 
 static __always_inline s64
@@ -867,14 +862,14 @@ atomic64_fetch_inc(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc(v);
+	return raw_atomic64_fetch_inc(v);
 }
 
 static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc_acquire(v);
+	return raw_atomic64_fetch_inc_acquire(v);
 }
 
 static __always_inline s64
@@ -882,21 +877,21 @@ atomic64_fetch_inc_release(atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc_release(v);
+	return raw_atomic64_fetch_inc_release(v);
 }
 
 static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc_relaxed(v);
+	return raw_atomic64_fetch_inc_relaxed(v);
 }
 
 static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_dec(v);
+	raw_atomic64_dec(v);
 }
 
 static __always_inline s64
@@ -904,14 +899,14 @@ atomic64_dec_return(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return(v);
+	return raw_atomic64_dec_return(v);
 }
 
 static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return_acquire(v);
+	return raw_atomic64_dec_return_acquire(v);
 }
 
 static __always_inline s64
@@ -919,14 +914,14 @@ atomic64_dec_return_release(atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return_release(v);
+	return raw_atomic64_dec_return_release(v);
 }
 
 static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return_relaxed(v);
+	return raw_atomic64_dec_return_relaxed(v);
 }
 
 static __always_inline s64
@@ -934,14 +929,14 @@ atomic64_fetch_dec(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec(v);
+	return raw_atomic64_fetch_dec(v);
 }
 
 static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec_acquire(v);
+	return raw_atomic64_fetch_dec_acquire(v);
 }
 
 static __always_inline s64
@@ -949,21 +944,21 @@ atomic64_fetch_dec_release(atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec_release(v);
+	return raw_atomic64_fetch_dec_release(v);
 }
 
 static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec_relaxed(v);
+	return raw_atomic64_fetch_dec_relaxed(v);
 }
 
 static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_and(i, v);
+	raw_atomic64_and(i, v);
 }
 
 static __always_inline s64
@@ -971,14 +966,14 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and(i, v);
+	return raw_atomic64_fetch_and(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and_acquire(i, v);
+	return raw_atomic64_fetch_and_acquire(i, v);
 }
 
 static __always_inline s64
@@ -986,21 +981,21 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and_release(i, v);
+	return raw_atomic64_fetch_and_release(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and_relaxed(i, v);
+	return raw_atomic64_fetch_and_relaxed(i, v);
 }
 
 static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_andnot(i, v);
+	raw_atomic64_andnot(i, v);
 }
 
 static __always_inline s64
@@ -1008,14 +1003,14 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot(i, v);
+	return raw_atomic64_fetch_andnot(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot_acquire(i, v);
+	return raw_atomic64_fetch_andnot_acquire(i, v);
 }
 
 static __always_inline s64
@@ -1023,21 +1018,21 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot_release(i, v);
+	return raw_atomic64_fetch_andnot_release(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot_relaxed(i, v);
+	return raw_atomic64_fetch_andnot_relaxed(i, v);
 }
 
 static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_or(i, v);
+	raw_atomic64_or(i, v);
 }
 
 static __always_inline s64
@@ -1045,14 +1040,14 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or(i, v);
+	return raw_atomic64_fetch_or(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or_acquire(i, v);
+	return raw_atomic64_fetch_or_acquire(i, v);
 }
 
 static __always_inline s64
@@ -1060,21 +1055,21 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or_release(i, v);
+	return raw_atomic64_fetch_or_release(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or_relaxed(i, v);
+	return raw_atomic64_fetch_or_relaxed(i, v);
 }
 
 static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_xor(i, v);
+	raw_atomic64_xor(i, v);
 }
 
 static __always_inline s64
@@ -1082,14 +1077,14 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor(i, v);
+	return raw_atomic64_fetch_xor(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor_acquire(i, v);
+	return raw_atomic64_fetch_xor_acquire(i, v);
 }
 
 static __always_inline s64
@@ -1097,14 +1092,14 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor_release(i, v);
+	return raw_atomic64_fetch_xor_release(i, v);
 }
 
 static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor_relaxed(i, v);
+	return raw_atomic64_fetch_xor_relaxed(i, v);
 }
 
 static __always_inline s64
@@ -1112,14 +1107,14 @@ atomic64_xchg(atomic64_t *v, s64 i)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg(v, i);
+	return raw_atomic64_xchg(v, i);
 }
 
 static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg_acquire(v, i);
+	return raw_atomic64_xchg_acquire(v, i);
 }
 
 static __always_inline s64
@@ -1127,14 +1122,14 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg_release(v, i);
+	return raw_atomic64_xchg_release(v, i);
 }
 
 static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg_relaxed(v, i);
+	return raw_atomic64_xchg_relaxed(v, i);
 }
 
 static __always_inline s64
@@ -1142,14 +1137,14 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg(v, old, new);
+	return raw_atomic64_cmpxchg(v, old, new);
 }
 
 static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg_acquire(v, old, new);
+	return raw_atomic64_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline s64
@@ -1157,14 +1152,14 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg_release(v, old, new);
+	return raw_atomic64_cmpxchg_release(v, old, new);
 }
 
 static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+	return raw_atomic64_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
@@ -1173,7 +1168,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg(v, old, new);
+	return raw_atomic64_try_cmpxchg(v, old, new);
 }
 
 static __always_inline bool
@@ -1181,7 +1176,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
+	return raw_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline bool
@@ -1190,7 +1185,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg_release(v, old, new);
+	return raw_atomic64_try_cmpxchg_release(v, old, new);
 }
 
 static __always_inline bool
@@ -1198,7 +1193,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	return raw_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
@@ -1206,7 +1201,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_and_test(i, v);
+	return raw_atomic64_sub_and_test(i, v);
 }
 
 static __always_inline bool
@@ -1214,7 +1209,7 @@ atomic64_dec_and_test(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_and_test(v);
+	return raw_atomic64_dec_and_test(v);
 }
 
 static __always_inline bool
@@ -1222,7 +1217,7 @@ atomic64_inc_and_test(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_and_test(v);
+	return raw_atomic64_inc_and_test(v);
 }
 
 static __always_inline bool
@@ -1230,14 +1225,14 @@ atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_negative(i, v);
+	return raw_atomic64_add_negative(i, v);
 }
 
 static __always_inline bool
 atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_negative_acquire(i, v);
+	return raw_atomic64_add_negative_acquire(i, v);
 }
 
 static __always_inline bool
@@ -1245,14 +1240,14 @@ atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_negative_release(i, v);
+	return raw_atomic64_add_negative_release(i, v);
 }
 
 static __always_inline bool
 atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_negative_relaxed(i, v);
+	return raw_atomic64_add_negative_relaxed(i, v);
 }
 
 static __always_inline s64
@@ -1260,7 +1255,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_unless(v, a, u);
+	return raw_atomic64_fetch_add_unless(v, a, u);
 }
 
 static __always_inline bool
@@ -1268,7 +1263,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_unless(v, a, u);
+	return raw_atomic64_add_unless(v, a, u);
 }
 
 static __always_inline bool
@@ -1276,7 +1271,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_not_zero(v);
+	return raw_atomic64_inc_not_zero(v);
 }
 
 static __always_inline bool
@@ -1284,7 +1279,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_unless_negative(v);
+	return raw_atomic64_inc_unless_negative(v);
 }
 
 static __always_inline bool
@@ -1292,7 +1287,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_unless_positive(v);
+	return raw_atomic64_dec_unless_positive(v);
 }
 
 static __always_inline s64
@@ -1300,28 +1295,28 @@ atomic64_dec_if_positive(atomic64_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_if_positive(v);
+	return raw_atomic64_dec_if_positive(v);
 }
 
 static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic_long_read(v);
+	return raw_atomic_long_read(v);
 }
 
 static __always_inline long
 atomic_long_read_acquire(const atomic_long_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic_long_read_acquire(v);
+	return raw_atomic_long_read_acquire(v);
 }
 
 static __always_inline void
 atomic_long_set(atomic_long_t *v, long i)
 {
 	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic_long_set(v, i);
+	raw_atomic_long_set(v, i);
 }
 
 static __always_inline void
@@ -1329,14 +1324,14 @@ atomic_long_set_release(atomic_long_t *v, long i)
 {
 	kcsan_release();
 	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic_long_set_release(v, i);
+	raw_atomic_long_set_release(v, i);
 }
 
 static __always_inline void
 atomic_long_add(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_add(i, v);
+	raw_atomic_long_add(i, v);
 }
 
 static __always_inline long
@@ -1344,14 +1339,14 @@ atomic_long_add_return(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_return(i, v);
+	return raw_atomic_long_add_return(i, v);
 }
 
 static __always_inline long
 atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_return_acquire(i, v);
+	return raw_atomic_long_add_return_acquire(i, v);
 }
 
 static __always_inline long
@@ -1359,14 +1354,14 @@ atomic_long_add_return_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_return_release(i, v);
+	return raw_atomic_long_add_return_release(i, v);
 }
 
 static __always_inline long
 atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_return_relaxed(i, v);
+	return raw_atomic_long_add_return_relaxed(i, v);
 }
 
 static __always_inline long
@@ -1374,14 +1369,14 @@ atomic_long_fetch_add(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_add(i, v);
+	return raw_atomic_long_fetch_add(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_add_acquire(i, v);
+	return raw_atomic_long_fetch_add_acquire(i, v);
 }
 
 static __always_inline long
@@ -1389,21 +1384,21 @@ atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_add_release(i, v);
+	return raw_atomic_long_fetch_add_release(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_add_relaxed(i, v);
+	return raw_atomic_long_fetch_add_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_long_sub(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_sub(i, v);
+	raw_atomic_long_sub(i, v);
 }
 
 static __always_inline long
@@ -1411,14 +1406,14 @@ atomic_long_sub_return(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_sub_return(i, v);
+	return raw_atomic_long_sub_return(i, v);
 }
 
 static __always_inline long
 atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_sub_return_acquire(i, v);
+	return raw_atomic_long_sub_return_acquire(i, v);
 }
 
 static __always_inline long
@@ -1426,14 +1421,14 @@ atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_sub_return_release(i, v);
+	return raw_atomic_long_sub_return_release(i, v);
 }
 
 static __always_inline long
 atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_sub_return_relaxed(i, v);
+	return raw_atomic_long_sub_return_relaxed(i, v);
 }
 
 static __always_inline long
@@ -1441,14 +1436,14 @@ atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_sub(i, v);
+	return raw_atomic_long_fetch_sub(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_sub_acquire(i, v);
+	return raw_atomic_long_fetch_sub_acquire(i, v);
 }
 
 static __always_inline long
@@ -1456,21 +1451,21 @@ atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_sub_release(i, v);
+	return raw_atomic_long_fetch_sub_release(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_sub_relaxed(i, v);
+	return raw_atomic_long_fetch_sub_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_long_inc(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_inc(v);
+	raw_atomic_long_inc(v);
 }
 
 static __always_inline long
@@ -1478,14 +1473,14 @@ atomic_long_inc_return(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_return(v);
+	return raw_atomic_long_inc_return(v);
 }
 
 static __always_inline long
 atomic_long_inc_return_acquire(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_return_acquire(v);
+	return raw_atomic_long_inc_return_acquire(v);
 }
 
 static __always_inline long
@@ -1493,14 +1488,14 @@ atomic_long_inc_return_release(atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_return_release(v);
+	return raw_atomic_long_inc_return_release(v);
 }
 
 static __always_inline long
 atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_return_relaxed(v);
+	return raw_atomic_long_inc_return_relaxed(v);
 }
 
 static __always_inline long
@@ -1508,14 +1503,14 @@ atomic_long_fetch_inc(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_inc(v);
+	return raw_atomic_long_fetch_inc(v);
 }
 
 static __always_inline long
 atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_inc_acquire(v);
+	return raw_atomic_long_fetch_inc_acquire(v);
 }
 
 static __always_inline long
@@ -1523,21 +1518,21 @@ atomic_long_fetch_inc_release(atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_inc_release(v);
+	return raw_atomic_long_fetch_inc_release(v);
 }
 
 static __always_inline long
 atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_inc_relaxed(v);
+	return raw_atomic_long_fetch_inc_relaxed(v);
 }
 
 static __always_inline void
 atomic_long_dec(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_dec(v);
+	raw_atomic_long_dec(v);
 }
 
 static __always_inline long
@@ -1545,14 +1540,14 @@ atomic_long_dec_return(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_return(v);
+	return raw_atomic_long_dec_return(v);
 }
 
 static __always_inline long
 atomic_long_dec_return_acquire(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_return_acquire(v);
+	return raw_atomic_long_dec_return_acquire(v);
 }
 
 static __always_inline long
@@ -1560,14 +1555,14 @@ atomic_long_dec_return_release(atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_return_release(v);
+	return raw_atomic_long_dec_return_release(v);
 }
 
 static __always_inline long
 atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_return_relaxed(v);
+	return raw_atomic_long_dec_return_relaxed(v);
 }
 
 static __always_inline long
@@ -1575,14 +1570,14 @@ atomic_long_fetch_dec(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_dec(v);
+	return raw_atomic_long_fetch_dec(v);
 }
 
 static __always_inline long
 atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_dec_acquire(v);
+	return raw_atomic_long_fetch_dec_acquire(v);
 }
 
 static __always_inline long
@@ -1590,21 +1585,21 @@ atomic_long_fetch_dec_release(atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_dec_release(v);
+	return raw_atomic_long_fetch_dec_release(v);
 }
 
 static __always_inline long
 atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_dec_relaxed(v);
+	return raw_atomic_long_fetch_dec_relaxed(v);
 }
 
 static __always_inline void
 atomic_long_and(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_and(i, v);
+	raw_atomic_long_and(i, v);
 }
 
 static __always_inline long
@@ -1612,14 +1607,14 @@ atomic_long_fetch_and(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_and(i, v);
+	return raw_atomic_long_fetch_and(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_and_acquire(i, v);
+	return raw_atomic_long_fetch_and_acquire(i, v);
 }
 
 static __always_inline long
@@ -1627,21 +1622,21 @@ atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_and_release(i, v);
+	return raw_atomic_long_fetch_and_release(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_and_relaxed(i, v);
+	return raw_atomic_long_fetch_and_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_long_andnot(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_andnot(i, v);
+	raw_atomic_long_andnot(i, v);
 }
 
 static __always_inline long
@@ -1649,14 +1644,14 @@ atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_andnot(i, v);
+	return raw_atomic_long_fetch_andnot(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_andnot_acquire(i, v);
+	return raw_atomic_long_fetch_andnot_acquire(i, v);
 }
 
 static __always_inline long
@@ -1664,21 +1659,21 @@ atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_andnot_release(i, v);
+	return raw_atomic_long_fetch_andnot_release(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_andnot_relaxed(i, v);
+	return raw_atomic_long_fetch_andnot_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_long_or(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_or(i, v);
+	raw_atomic_long_or(i, v);
 }
 
 static __always_inline long
@@ -1686,14 +1681,14 @@ atomic_long_fetch_or(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_or(i, v);
+	return raw_atomic_long_fetch_or(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_or_acquire(i, v);
+	return raw_atomic_long_fetch_or_acquire(i, v);
 }
 
 static __always_inline long
@@ -1701,21 +1696,21 @@ atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_or_release(i, v);
+	return raw_atomic_long_fetch_or_release(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_or_relaxed(i, v);
+	return raw_atomic_long_fetch_or_relaxed(i, v);
 }
 
 static __always_inline void
 atomic_long_xor(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_long_xor(i, v);
+	raw_atomic_long_xor(i, v);
 }
 
 static __always_inline long
@@ -1723,14 +1718,14 @@ atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_xor(i, v);
+	return raw_atomic_long_fetch_xor(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_xor_acquire(i, v);
+	return raw_atomic_long_fetch_xor_acquire(i, v);
 }
 
 static __always_inline long
@@ -1738,14 +1733,14 @@ atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_xor_release(i, v);
+	return raw_atomic_long_fetch_xor_release(i, v);
 }
 
 static __always_inline long
 atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_xor_relaxed(i, v);
+	return raw_atomic_long_fetch_xor_relaxed(i, v);
 }
 
 static __always_inline long
@@ -1753,14 +1748,14 @@ atomic_long_xchg(atomic_long_t *v, long i)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_xchg(v, i);
+	return raw_atomic_long_xchg(v, i);
 }
 
 static __always_inline long
 atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_xchg_acquire(v, i);
+	return raw_atomic_long_xchg_acquire(v, i);
 }
 
 static __always_inline long
@@ -1768,14 +1763,14 @@ atomic_long_xchg_release(atomic_long_t *v, long i)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_xchg_release(v, i);
+	return raw_atomic_long_xchg_release(v, i);
 }
 
 static __always_inline long
 atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_xchg_relaxed(v, i);
+	return raw_atomic_long_xchg_relaxed(v, i);
 }
 
 static __always_inline long
@@ -1783,14 +1778,14 @@ atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_cmpxchg(v, old, new);
+	return raw_atomic_long_cmpxchg(v, old, new);
 }
 
 static __always_inline long
 atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_cmpxchg_acquire(v, old, new);
+	return raw_atomic_long_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline long
@@ -1798,14 +1793,14 @@ atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_cmpxchg_release(v, old, new);
+	return raw_atomic_long_cmpxchg_release(v, old, new);
 }
 
 static __always_inline long
 atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_cmpxchg_relaxed(v, old, new);
+	return raw_atomic_long_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
@@ -1814,7 +1809,7 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_long_try_cmpxchg(v, old, new);
+	return raw_atomic_long_try_cmpxchg(v, old, new);
 }
 
 static __always_inline bool
@@ -1822,7 +1817,7 @@ atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_long_try_cmpxchg_acquire(v, old, new);
+	return raw_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline bool
@@ -1831,7 +1826,7 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_long_try_cmpxchg_release(v, old, new);
+	return raw_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
 static __always_inline bool
@@ -1839,7 +1834,7 @@ atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_long_try_cmpxchg_relaxed(v, old, new);
+	return raw_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
@@ -1847,7 +1842,7 @@ atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_sub_and_test(i, v);
+	return raw_atomic_long_sub_and_test(i, v);
 }
 
 static __always_inline bool
@@ -1855,7 +1850,7 @@ atomic_long_dec_and_test(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_and_test(v);
+	return raw_atomic_long_dec_and_test(v);
 }
 
 static __always_inline bool
@@ -1863,7 +1858,7 @@ atomic_long_inc_and_test(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_and_test(v);
+	return raw_atomic_long_inc_and_test(v);
 }
 
 static __always_inline bool
@@ -1871,14 +1866,14 @@ atomic_long_add_negative(long i, atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_negative(i, v);
+	return raw_atomic_long_add_negative(i, v);
 }
 
 static __always_inline bool
 atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_negative_acquire(i, v);
+	return raw_atomic_long_add_negative_acquire(i, v);
 }
 
 static __always_inline bool
@@ -1886,14 +1881,14 @@ atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_negative_release(i, v);
+	return raw_atomic_long_add_negative_release(i, v);
 }
 
 static __always_inline bool
 atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_negative_relaxed(i, v);
+	return raw_atomic_long_add_negative_relaxed(i, v);
 }
 
 static __always_inline long
@@ -1901,7 +1896,7 @@ atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_fetch_add_unless(v, a, u);
+	return raw_atomic_long_fetch_add_unless(v, a, u);
 }
 
 static __always_inline bool
@@ -1909,7 +1904,7 @@ atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_add_unless(v, a, u);
+	return raw_atomic_long_add_unless(v, a, u);
 }
 
 static __always_inline bool
@@ -1917,7 +1912,7 @@ atomic_long_inc_not_zero(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_not_zero(v);
+	return raw_atomic_long_inc_not_zero(v);
 }
 
 static __always_inline bool
@@ -1925,7 +1920,7 @@ atomic_long_inc_unless_negative(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_inc_unless_negative(v);
+	return raw_atomic_long_inc_unless_negative(v);
 }
 
 static __always_inline bool
@@ -1933,7 +1928,7 @@ atomic_long_dec_unless_positive(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_unless_positive(v);
+	return raw_atomic_long_dec_unless_positive(v);
 }
 
 static __always_inline long
@@ -1941,7 +1936,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_long_dec_if_positive(v);
+	return raw_atomic_long_dec_if_positive(v);
 }
 
 #define xchg(ptr, ...) \
@@ -1949,14 +1944,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg(__ai_ptr, __VA_ARGS__); \
+	raw_xchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
+	raw_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_release(ptr, ...) \
@@ -1964,14 +1959,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
+	raw_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
+	raw_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg(ptr, ...) \
@@ -1979,14 +1974,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_release(ptr, ...) \
@@ -1994,14 +1989,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64(ptr, ...) \
@@ -2009,14 +2004,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_release(ptr, ...) \
@@ -2024,14 +2019,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg128(ptr, ...) \
@@ -2039,14 +2034,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg128(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg128(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg128_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg128_acquire(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg128_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg128_release(ptr, ...) \
@@ -2054,14 +2049,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg128_release(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg128_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg128_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg128_relaxed(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg128_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define try_cmpxchg(ptr, oldp, ...) \
@@ -2071,7 +2066,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg_acquire(ptr, oldp, ...) \
@@ -2080,7 +2075,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg_release(ptr, oldp, ...) \
@@ -2090,7 +2085,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg_relaxed(ptr, oldp, ...) \
@@ -2099,7 +2094,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg64(ptr, oldp, ...) \
@@ -2109,7 +2104,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg64_acquire(ptr, oldp, ...) \
@@ -2118,7 +2113,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg64_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg64_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg64_release(ptr, oldp, ...) \
@@ -2128,7 +2123,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg64_relaxed(ptr, oldp, ...) \
@@ -2137,7 +2132,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg128(ptr, oldp, ...) \
@@ -2147,7 +2142,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg128(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg128(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg128_acquire(ptr, oldp, ...) \
@@ -2156,7 +2151,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg128_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg128_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg128_release(ptr, oldp, ...) \
@@ -2166,7 +2161,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	kcsan_release(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg128_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg128_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg128_relaxed(ptr, oldp, ...) \
@@ -2175,28 +2170,28 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg128_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg128_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg128_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
+	raw_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define sync_cmpxchg(ptr, ...) \
@@ -2204,7 +2199,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
+	raw_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define try_cmpxchg_local(ptr, oldp, ...) \
@@ -2213,7 +2208,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg64_local(ptr, oldp, ...) \
@@ -2222,7 +2217,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define try_cmpxchg128_local(ptr, oldp, ...) \
@@ -2231,9 +2226,9 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(oldp) __ai_oldp = (oldp); \
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg128_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+	raw_try_cmpxchg128_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 3611991b015450e119bcd7417a9431af7f3ba13c
+// f6502977180430e61c1a7c4e5e665f04f501fb8d
diff --git a/include/linux/atomic/atomic-raw.h b/include/linux/atomic/atomic-raw.h
new file mode 100644
index 0000000000000..83ff0269657e7
--- /dev/null
+++ b/include/linux/atomic/atomic-raw.h
@@ -0,0 +1,1645 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-raw.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_RAW_H
+#define _LINUX_ATOMIC_RAW_H
+
+static __always_inline int
+raw_atomic_read(const atomic_t *v)
+{
+	return arch_atomic_read(v);
+}
+
+static __always_inline int
+raw_atomic_read_acquire(const atomic_t *v)
+{
+	return arch_atomic_read_acquire(v);
+}
+
+static __always_inline void
+raw_atomic_set(atomic_t *v, int i)
+{
+	arch_atomic_set(v, i);
+}
+
+static __always_inline void
+raw_atomic_set_release(atomic_t *v, int i)
+{
+	arch_atomic_set_release(v, i);
+}
+
+static __always_inline void
+raw_atomic_add(int i, atomic_t *v)
+{
+	arch_atomic_add(i, v);
+}
+
+static __always_inline int
+raw_atomic_add_return(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(i, v);
+}
+
+static __always_inline int
+raw_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_add_return_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_add_return_release(int i, atomic_t *v)
+{
+	return arch_atomic_add_return_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_add_return_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_add_return_relaxed(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_add(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_add(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_add_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_add_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_add_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_sub(int i, atomic_t *v)
+{
+	arch_atomic_sub(i, v);
+}
+
+static __always_inline int
+raw_atomic_sub_return(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return(i, v);
+}
+
+static __always_inline int
+raw_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_sub_return_release(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_sub_return_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_sub(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_sub(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_sub_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_sub_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_sub_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_inc(atomic_t *v)
+{
+	arch_atomic_inc(v);
+}
+
+static __always_inline int
+raw_atomic_inc_return(atomic_t *v)
+{
+	return arch_atomic_inc_return(v);
+}
+
+static __always_inline int
+raw_atomic_inc_return_acquire(atomic_t *v)
+{
+	return arch_atomic_inc_return_acquire(v);
+}
+
+static __always_inline int
+raw_atomic_inc_return_release(atomic_t *v)
+{
+	return arch_atomic_inc_return_release(v);
+}
+
+static __always_inline int
+raw_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_inc_return_relaxed(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_inc(atomic_t *v)
+{
+	return arch_atomic_fetch_inc(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_inc_acquire(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_inc_release(atomic_t *v)
+{
+	return arch_atomic_fetch_inc_release(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+raw_atomic_dec(atomic_t *v)
+{
+	arch_atomic_dec(v);
+}
+
+static __always_inline int
+raw_atomic_dec_return(atomic_t *v)
+{
+	return arch_atomic_dec_return(v);
+}
+
+static __always_inline int
+raw_atomic_dec_return_acquire(atomic_t *v)
+{
+	return arch_atomic_dec_return_acquire(v);
+}
+
+static __always_inline int
+raw_atomic_dec_return_release(atomic_t *v)
+{
+	return arch_atomic_dec_return_release(v);
+}
+
+static __always_inline int
+raw_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_dec_return_relaxed(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_dec(atomic_t *v)
+{
+	return arch_atomic_fetch_dec(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_dec_acquire(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_dec_release(atomic_t *v)
+{
+	return arch_atomic_fetch_dec_release(v);
+}
+
+static __always_inline int
+raw_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+raw_atomic_and(int i, atomic_t *v)
+{
+	arch_atomic_and(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_and(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_and_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_andnot(int i, atomic_t *v)
+{
+	arch_atomic_andnot(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_andnot(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_andnot_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_or(int i, atomic_t *v)
+{
+	arch_atomic_or(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_or(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_or(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_or_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_or_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_or_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_xor(int i, atomic_t *v)
+{
+	arch_atomic_xor(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_xor(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_xor(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_xor_acquire(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_xor_release(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_xor_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline int
+raw_atomic_xchg(atomic_t *v, int i)
+{
+	return arch_atomic_xchg(v, i);
+}
+
+static __always_inline int
+raw_atomic_xchg_acquire(atomic_t *v, int i)
+{
+	return arch_atomic_xchg_acquire(v, i);
+}
+
+static __always_inline int
+raw_atomic_xchg_release(atomic_t *v, int i)
+{
+	return arch_atomic_xchg_release(v, i);
+}
+
+static __always_inline int
+raw_atomic_xchg_relaxed(atomic_t *v, int i)
+{
+	return arch_atomic_xchg_relaxed(v, i);
+}
+
+static __always_inline int
+raw_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return arch_atomic_cmpxchg(v, old, new);
+}
+
+static __always_inline int
+raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	return arch_atomic_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline int
+raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	return arch_atomic_cmpxchg_release(v, old, new);
+}
+
+static __always_inline int
+raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	return arch_atomic_try_cmpxchg(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	return arch_atomic_try_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	return arch_atomic_try_cmpxchg_release(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return arch_atomic_sub_and_test(i, v);
+}
+
+static __always_inline bool
+raw_atomic_dec_and_test(atomic_t *v)
+{
+	return arch_atomic_dec_and_test(v);
+}
+
+static __always_inline bool
+raw_atomic_inc_and_test(atomic_t *v)
+{
+	return arch_atomic_inc_and_test(v);
+}
+
+static __always_inline bool
+raw_atomic_add_negative(int i, atomic_t *v)
+{
+	return arch_atomic_add_negative(i, v);
+}
+
+static __always_inline bool
+raw_atomic_add_negative_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_add_negative_acquire(i, v);
+}
+
+static __always_inline bool
+raw_atomic_add_negative_release(int i, atomic_t *v)
+{
+	return arch_atomic_add_negative_release(i, v);
+}
+
+static __always_inline bool
+raw_atomic_add_negative_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_add_negative_relaxed(i, v);
+}
+
+static __always_inline int
+raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	return arch_atomic_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+raw_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return arch_atomic_add_unless(v, a, u);
+}
+
+static __always_inline bool
+raw_atomic_inc_not_zero(atomic_t *v)
+{
+	return arch_atomic_inc_not_zero(v);
+}
+
+static __always_inline bool
+raw_atomic_inc_unless_negative(atomic_t *v)
+{
+	return arch_atomic_inc_unless_negative(v);
+}
+
+static __always_inline bool
+raw_atomic_dec_unless_positive(atomic_t *v)
+{
+	return arch_atomic_dec_unless_positive(v);
+}
+
+static __always_inline int
+raw_atomic_dec_if_positive(atomic_t *v)
+{
+	return arch_atomic_dec_if_positive(v);
+}
+
+static __always_inline s64
+raw_atomic64_read(const atomic64_t *v)
+{
+	return arch_atomic64_read(v);
+}
+
+static __always_inline s64
+raw_atomic64_read_acquire(const atomic64_t *v)
+{
+	return arch_atomic64_read_acquire(v);
+}
+
+static __always_inline void
+raw_atomic64_set(atomic64_t *v, s64 i)
+{
+	arch_atomic64_set(v, i);
+}
+
+static __always_inline void
+raw_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	arch_atomic64_set_release(v, i);
+}
+
+static __always_inline void
+raw_atomic64_add(s64 i, atomic64_t *v)
+{
+	arch_atomic64_add(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_add(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic64_sub(s64 i, atomic64_t *v)
+{
+	arch_atomic64_sub(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic64_inc(atomic64_t *v)
+{
+	arch_atomic64_inc(v);
+}
+
+static __always_inline s64
+raw_atomic64_inc_return(atomic64_t *v)
+{
+	return arch_atomic64_inc_return(v);
+}
+
+static __always_inline s64
+raw_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_inc_return_acquire(v);
+}
+
+static __always_inline s64
+raw_atomic64_inc_return_release(atomic64_t *v)
+{
+	return arch_atomic64_inc_return_release(v);
+}
+
+static __always_inline s64
+raw_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_inc_return_relaxed(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_inc(atomic64_t *v)
+{
+	return arch_atomic64_fetch_inc(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_inc_acquire(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_inc_release(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+raw_atomic64_dec(atomic64_t *v)
+{
+	arch_atomic64_dec(v);
+}
+
+static __always_inline s64
+raw_atomic64_dec_return(atomic64_t *v)
+{
+	return arch_atomic64_dec_return(v);
+}
+
+static __always_inline s64
+raw_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_dec_return_acquire(v);
+}
+
+static __always_inline s64
+raw_atomic64_dec_return_release(atomic64_t *v)
+{
+	return arch_atomic64_dec_return_release(v);
+}
+
+static __always_inline s64
+raw_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_dec_return_relaxed(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_dec(atomic64_t *v)
+{
+	return arch_atomic64_fetch_dec(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_dec_acquire(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_dec_release(v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+raw_atomic64_and(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	arch_atomic64_andnot(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_andnot(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_andnot_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic64_or(s64 i, atomic64_t *v)
+{
+	arch_atomic64_or(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_or(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_or_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_or_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic64_xor(s64 i, atomic64_t *v)
+{
+	arch_atomic64_xor(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_xor(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_xor_acquire(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_xor_release(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_xchg(atomic64_t *v, s64 i)
+{
+	return arch_atomic64_xchg(v, i);
+}
+
+static __always_inline s64
+raw_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+{
+	return arch_atomic64_xchg_acquire(v, i);
+}
+
+static __always_inline s64
+raw_atomic64_xchg_release(atomic64_t *v, s64 i)
+{
+	return arch_atomic64_xchg_release(v, i);
+}
+
+static __always_inline s64
+raw_atomic64_xchg_relaxed(atomic64_t *v, s64 i)
+{
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+
+static __always_inline s64
+raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_atomic64_cmpxchg(v, old, new);
+}
+
+static __always_inline s64
+raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_atomic64_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline s64
+raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_atomic64_cmpxchg_release(v, old, new);
+}
+
+static __always_inline s64
+raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_atomic64_try_cmpxchg(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_atomic64_try_cmpxchg_release(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_and_test(i, v);
+}
+
+static __always_inline bool
+raw_atomic64_dec_and_test(atomic64_t *v)
+{
+	return arch_atomic64_dec_and_test(v);
+}
+
+static __always_inline bool
+raw_atomic64_inc_and_test(atomic64_t *v)
+{
+	return arch_atomic64_inc_and_test(v);
+}
+
+static __always_inline bool
+raw_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_negative(i, v);
+}
+
+static __always_inline bool
+raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_negative_acquire(i, v);
+}
+
+static __always_inline bool
+raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_negative_release(i, v);
+}
+
+static __always_inline bool
+raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_negative_relaxed(i, v);
+}
+
+static __always_inline s64
+raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_add_unless(v, a, u);
+}
+
+static __always_inline bool
+raw_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return arch_atomic64_inc_not_zero(v);
+}
+
+static __always_inline bool
+raw_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	return arch_atomic64_inc_unless_negative(v);
+}
+
+static __always_inline bool
+raw_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	return arch_atomic64_dec_unless_positive(v);
+}
+
+static __always_inline s64
+raw_atomic64_dec_if_positive(atomic64_t *v)
+{
+	return arch_atomic64_dec_if_positive(v);
+}
+
+static __always_inline long
+raw_atomic_long_read(const atomic_long_t *v)
+{
+	return arch_atomic_long_read(v);
+}
+
+static __always_inline long
+raw_atomic_long_read_acquire(const atomic_long_t *v)
+{
+	return arch_atomic_long_read_acquire(v);
+}
+
+static __always_inline void
+raw_atomic_long_set(atomic_long_t *v, long i)
+{
+	arch_atomic_long_set(v, i);
+}
+
+static __always_inline void
+raw_atomic_long_set_release(atomic_long_t *v, long i)
+{
+	arch_atomic_long_set_release(v, i);
+}
+
+static __always_inline void
+raw_atomic_long_add(long i, atomic_long_t *v)
+{
+	arch_atomic_long_add(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_add_return(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_return(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_return_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_add_return_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_return_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_return_relaxed(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_add(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_add(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_add_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_add_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_long_sub(long i, atomic_long_t *v)
+{
+	arch_atomic_long_sub(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_sub_return(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_sub_return(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_sub_return_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_sub_return_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_sub_return_relaxed(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_sub(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_sub_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_sub_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_long_inc(atomic_long_t *v)
+{
+	arch_atomic_long_inc(v);
+}
+
+static __always_inline long
+raw_atomic_long_inc_return(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_return(v);
+}
+
+static __always_inline long
+raw_atomic_long_inc_return_acquire(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_return_acquire(v);
+}
+
+static __always_inline long
+raw_atomic_long_inc_return_release(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_return_release(v);
+}
+
+static __always_inline long
+raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_return_relaxed(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_inc(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_inc(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_inc_acquire(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_inc_release(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_inc_release(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+raw_atomic_long_dec(atomic_long_t *v)
+{
+	arch_atomic_long_dec(v);
+}
+
+static __always_inline long
+raw_atomic_long_dec_return(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_return(v);
+}
+
+static __always_inline long
+raw_atomic_long_dec_return_acquire(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_return_acquire(v);
+}
+
+static __always_inline long
+raw_atomic_long_dec_return_release(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_return_release(v);
+}
+
+static __always_inline long
+raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_return_relaxed(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_dec(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_dec(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_dec_acquire(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_dec_release(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_dec_release(v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+raw_atomic_long_and(long i, atomic_long_t *v)
+{
+	arch_atomic_long_and(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_and(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_and(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_and_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_and_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_long_andnot(long i, atomic_long_t *v)
+{
+	arch_atomic_long_andnot(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_andnot(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_andnot_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_long_or(long i, atomic_long_t *v)
+{
+	arch_atomic_long_or(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_or(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_or(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_or_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_or_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+raw_atomic_long_xor(long i, atomic_long_t *v)
+{
+	arch_atomic_long_xor(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_xor(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_xor_acquire(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_xor_release(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_xchg(atomic_long_t *v, long i)
+{
+	return arch_atomic_long_xchg(v, i);
+}
+
+static __always_inline long
+raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
+{
+	return arch_atomic_long_xchg_acquire(v, i);
+}
+
+static __always_inline long
+raw_atomic_long_xchg_release(atomic_long_t *v, long i)
+{
+	return arch_atomic_long_xchg_release(v, i);
+}
+
+static __always_inline long
+raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+{
+	return arch_atomic_long_xchg_relaxed(v, i);
+}
+
+static __always_inline long
+raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_long_cmpxchg(v, old, new);
+}
+
+static __always_inline long
+raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_long_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline long
+raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_long_cmpxchg_release(v, old, new);
+}
+
+static __always_inline long
+raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_long_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_long_try_cmpxchg(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_long_try_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_long_try_cmpxchg_release(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_long_try_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_sub_and_test(i, v);
+}
+
+static __always_inline bool
+raw_atomic_long_dec_and_test(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_and_test(v);
+}
+
+static __always_inline bool
+raw_atomic_long_inc_and_test(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_and_test(v);
+}
+
+static __always_inline bool
+raw_atomic_long_add_negative(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_negative(i, v);
+}
+
+static __always_inline bool
+raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_negative_acquire(i, v);
+}
+
+static __always_inline bool
+raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_negative_release(i, v);
+}
+
+static __always_inline bool
+raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_long_add_negative_relaxed(i, v);
+}
+
+static __always_inline long
+raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+{
+	return arch_atomic_long_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
+{
+	return arch_atomic_long_add_unless(v, a, u);
+}
+
+static __always_inline bool
+raw_atomic_long_inc_not_zero(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_not_zero(v);
+}
+
+static __always_inline bool
+raw_atomic_long_inc_unless_negative(atomic_long_t *v)
+{
+	return arch_atomic_long_inc_unless_negative(v);
+}
+
+static __always_inline bool
+raw_atomic_long_dec_unless_positive(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_unless_positive(v);
+}
+
+static __always_inline long
+raw_atomic_long_dec_if_positive(atomic_long_t *v)
+{
+	return arch_atomic_long_dec_if_positive(v);
+}
+
+#define raw_xchg(...) \
+	arch_xchg(__VA_ARGS__)
+
+#define raw_xchg_acquire(...) \
+	arch_xchg_acquire(__VA_ARGS__)
+
+#define raw_xchg_release(...) \
+	arch_xchg_release(__VA_ARGS__)
+
+#define raw_xchg_relaxed(...) \
+	arch_xchg_relaxed(__VA_ARGS__)
+
+#define raw_cmpxchg(...) \
+	arch_cmpxchg(__VA_ARGS__)
+
+#define raw_cmpxchg_acquire(...) \
+	arch_cmpxchg_acquire(__VA_ARGS__)
+
+#define raw_cmpxchg_release(...) \
+	arch_cmpxchg_release(__VA_ARGS__)
+
+#define raw_cmpxchg_relaxed(...) \
+	arch_cmpxchg_relaxed(__VA_ARGS__)
+
+#define raw_cmpxchg64(...) \
+	arch_cmpxchg64(__VA_ARGS__)
+
+#define raw_cmpxchg64_acquire(...) \
+	arch_cmpxchg64_acquire(__VA_ARGS__)
+
+#define raw_cmpxchg64_release(...) \
+	arch_cmpxchg64_release(__VA_ARGS__)
+
+#define raw_cmpxchg64_relaxed(...) \
+	arch_cmpxchg64_relaxed(__VA_ARGS__)
+
+#define raw_cmpxchg128(...) \
+	arch_cmpxchg128(__VA_ARGS__)
+
+#define raw_cmpxchg128_acquire(...) \
+	arch_cmpxchg128_acquire(__VA_ARGS__)
+
+#define raw_cmpxchg128_release(...) \
+	arch_cmpxchg128_release(__VA_ARGS__)
+
+#define raw_cmpxchg128_relaxed(...) \
+	arch_cmpxchg128_relaxed(__VA_ARGS__)
+
+#define raw_try_cmpxchg(...) \
+	arch_try_cmpxchg(__VA_ARGS__)
+
+#define raw_try_cmpxchg_acquire(...) \
+	arch_try_cmpxchg_acquire(__VA_ARGS__)
+
+#define raw_try_cmpxchg_release(...) \
+	arch_try_cmpxchg_release(__VA_ARGS__)
+
+#define raw_try_cmpxchg_relaxed(...) \
+	arch_try_cmpxchg_relaxed(__VA_ARGS__)
+
+#define raw_try_cmpxchg64(...) \
+	arch_try_cmpxchg64(__VA_ARGS__)
+
+#define raw_try_cmpxchg64_acquire(...) \
+	arch_try_cmpxchg64_acquire(__VA_ARGS__)
+
+#define raw_try_cmpxchg64_release(...) \
+	arch_try_cmpxchg64_release(__VA_ARGS__)
+
+#define raw_try_cmpxchg64_relaxed(...) \
+	arch_try_cmpxchg64_relaxed(__VA_ARGS__)
+
+#define raw_try_cmpxchg128(...) \
+	arch_try_cmpxchg128(__VA_ARGS__)
+
+#define raw_try_cmpxchg128_acquire(...) \
+	arch_try_cmpxchg128_acquire(__VA_ARGS__)
+
+#define raw_try_cmpxchg128_release(...) \
+	arch_try_cmpxchg128_release(__VA_ARGS__)
+
+#define raw_try_cmpxchg128_relaxed(...) \
+	arch_try_cmpxchg128_relaxed(__VA_ARGS__)
+
+#define raw_cmpxchg_local(...) \
+	arch_cmpxchg_local(__VA_ARGS__)
+
+#define raw_cmpxchg64_local(...) \
+	arch_cmpxchg64_local(__VA_ARGS__)
+
+#define raw_cmpxchg128_local(...) \
+	arch_cmpxchg128_local(__VA_ARGS__)
+
+#define raw_sync_cmpxchg(...) \
+	arch_sync_cmpxchg(__VA_ARGS__)
+
+#define raw_try_cmpxchg_local(...) \
+	arch_try_cmpxchg_local(__VA_ARGS__)
+
+#define raw_try_cmpxchg64_local(...) \
+	arch_try_cmpxchg64_local(__VA_ARGS__)
+
+#define raw_try_cmpxchg128_local(...) \
+	arch_try_cmpxchg128_local(__VA_ARGS__)
+
+#endif /* _LINUX_ATOMIC_RAW_H */
+// 01d54200571b3857755a07c10074a4fd58cef6b1
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 68557bfbbdc5e..93c949aa9e544 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -73,7 +73,7 @@ static __always_inline ${ret}
 ${atomicname}(${params})
 {
 ${checks}
-	${retstmt}arch_${atomicname}(${args});
+	${retstmt}raw_${atomicname}(${args});
 }
 EOF
 
@@ -105,7 +105,7 @@ EOF
 cat <<EOF
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \\
 	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \\
-	arch_${xchg}${order}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
+	raw_${xchg}${order}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
 })
 EOF
 
@@ -119,7 +119,7 @@ EOF
 [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
 cat <<EOF
 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \\
-	arch_${xchg}${order}(__ai_ptr, __VA_ARGS__); \\
+	raw_${xchg}${order}(__ai_ptr, __VA_ARGS__); \\
 })
 EOF
 
@@ -133,15 +133,10 @@ cat << EOF
 // DO NOT MODIFY THIS FILE DIRECTLY
 
 /*
- * This file provides wrappers with KASAN instrumentation for atomic operations.
- * To use this functionality an arch's atomic.h file needs to define all
- * atomic operations with arch_ prefix (e.g. arch_atomic_read()) and include
- * this file at the end. This file provides atomic_read() that forwards to
- * arch_atomic_read() for actual atomic operation.
- * Note: if an arch atomic operation is implemented by means of other atomic
- * operations (e.g. atomic_read()/atomic_cmpxchg() loop), then it needs to use
- * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
- * double instrumentation.
+ * This file provoides atomic operations with explicit instrumentation (e.g.
+ * KASAN, KCSAN), which should be used unless it is necessary to avoid
+ * instrumentation. Where it is necessary to aovid instrumenation, the
+ * raw_atomic*() operations should be used.
  */
 #ifndef _LINUX_ATOMIC_INSTRUMENTED_H
 #define _LINUX_ATOMIC_INSTRUMENTED_H
diff --git a/scripts/atomic/gen-atomic-raw.sh b/scripts/atomic/gen-atomic-raw.sh
new file mode 100755
index 0000000000000..ba8d136f30e4c
--- /dev/null
+++ b/scripts/atomic/gen-atomic-raw.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+
+cat <<EOF
+static __always_inline ${ret}
+raw_${atomicname}(${params})
+{
+	${retstmt}arch_${atomicname}(${args});
+}
+
+EOF
+}
+
+gen_xchg()
+{
+	local xchg="$1"; shift
+	local order="$1"; shift
+
+cat <<EOF
+#define raw_${xchg}${order}(...) \\
+	arch_${xchg}${order}(__VA_ARGS__)
+EOF
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_RAW_H
+#define _LINUX_ATOMIC_RAW_H
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}
+done
+
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
+	for order in "" "_acquire" "_release" "_relaxed"; do
+		gen_xchg "${xchg}" "${order}"
+		printf "\n"
+	done
+done
+
+for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local"; do
+	gen_xchg "${xchg}" ""
+	printf "\n"
+done
+
+cat <<EOF
+#endif /* _LINUX_ATOMIC_RAW_H */
+EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 5b98a83076932..631d351f9f1f3 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,6 +11,7 @@ cat <<EOF |
 gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
 gen-atomic-long.sh              linux/atomic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
+gen-atomic-raw.sh               linux/atomic/atomic-raw.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
-- 
2.30.2

