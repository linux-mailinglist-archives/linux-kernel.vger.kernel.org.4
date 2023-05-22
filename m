Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99570BE49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjEVM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjEVM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:27:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB9EDFD;
        Mon, 22 May 2023 05:25:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B2941515;
        Mon, 22 May 2023 05:26:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B48B83F59C;
        Mon, 22 May 2023 05:25:35 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc comments
Date:   Mon, 22 May 2023 13:24:27 +0100
Message-Id: <20230522122429.1915021-25-mark.rutland@arm.com>
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

Currently the atomics are documented in Documentation/atomic_t.txt, and
have no kerneldoc comments. There are a sufficient number of gotchas
(e.g. semantics, noinstr-safety) that it would be nice to have comments
to call these out, and it would be nice to have kerneldoc comments such
that these can be collated.

While it's possible to derive the semantics from the code, this can be
painful given the amount of indirection we currently have (e.g. fallback
paths), and it's easy to be mislead by naming, e.g.

* The unconditional void-returning ops *only* have relaxed variants
  without a _relaxed suffix, and can easily be mistaken for being fully
  ordered.

  It would be nice to give these a _relaxed() suffix, but this would
  result in significant churn throughout the kernel.

* Our naming of conditional and unconditional+test ops is rather
  inconsistent, and it can be difficult to derive the name of an
  operation, or to identify where an op is conditional or
  unconditional+test.

  Some ops are clearly conditional:
  - dec_if_positive
  - add_unless
  - dec_unless_positive
  - inc_unless_negative

  Some ops are clearly unconditional+test:
  - sub_and_test
  - dec_and_test
  - inc_and_test

  However, what exactly those test is not obvious. A _test_zero suffix
  might be clearer.

  Others could be read ambiguously:
  - inc_not_zero	// conditional
  - add_negative	// unconditional+test

  It would probably be worth renaming these, e.g. to inc_unless_zero and
  add_test_negative.

As a step towards making this more consistent and easier to understand,
this patch adds kerneldoc comments for all generated *atomic*_*()
functions. These are generated from templates, with some common text
shared, making it easy to extend these in future if necessary.

I've tried to make these as consistent and clear as possible, and I've
deliberately ensured:

* All ops have their ordering explicitly mentioned in the short and long
  description.

* All test ops have "test" in their short description.

* All ops are described as an expression using their usual C operator.
  For example:

  andnot: "Atomically updates @v to (@v & ~@i)"
  inc:    "Atomically updates @v to (@v + 1)"

  Which may be clearer to non-naative English speakers, and allows all
  the operations to be described in the same style.

* All conditional ops have their condition described as an expression
  using the usual C operators. For example:

  add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
  cmpxchg:    "If (@v == @old), atomically updates @v to @new"

  Which may be clearer to non-naative English speakers, and allows all
  the operations to be described in the same style.

* All bitwise ops (and,andnot,or,xor) explicitly mention that they are
  bitwise in their short description, so that they are not mistaken for
  performing their logical equivalents.

* The noinstr safety of each op is explicitly described, with a
  description of whether or not to use the raw_ form of the op.

There should be no functional change as a result of this patch.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/atomic/atomic-arch-fallback.h  | 1848 +++++++++++-
 include/linux/atomic/atomic-instrumented.h   | 2771 +++++++++++++++++-
 include/linux/atomic/atomic-long.h           |  925 +++++-
 scripts/atomic/atomic-tbl.sh                 |  112 +-
 scripts/atomic/gen-atomic-fallback.sh        |    2 +
 scripts/atomic/gen-atomic-instrumented.sh    |    2 +
 scripts/atomic/gen-atomic-long.sh            |    2 +
 scripts/atomic/kerneldoc/add                 |   13 +
 scripts/atomic/kerneldoc/add_negative        |   13 +
 scripts/atomic/kerneldoc/add_unless          |   18 +
 scripts/atomic/kerneldoc/and                 |   13 +
 scripts/atomic/kerneldoc/andnot              |   13 +
 scripts/atomic/kerneldoc/cmpxchg             |   14 +
 scripts/atomic/kerneldoc/dec                 |   12 +
 scripts/atomic/kerneldoc/dec_and_test        |   12 +
 scripts/atomic/kerneldoc/dec_if_positive     |   12 +
 scripts/atomic/kerneldoc/dec_unless_positive |   12 +
 scripts/atomic/kerneldoc/inc                 |   12 +
 scripts/atomic/kerneldoc/inc_and_test        |   12 +
 scripts/atomic/kerneldoc/inc_not_zero        |   12 +
 scripts/atomic/kerneldoc/inc_unless_negative |   12 +
 scripts/atomic/kerneldoc/or                  |   13 +
 scripts/atomic/kerneldoc/read                |   12 +
 scripts/atomic/kerneldoc/set                 |   13 +
 scripts/atomic/kerneldoc/sub                 |   13 +
 scripts/atomic/kerneldoc/sub_and_test        |   13 +
 scripts/atomic/kerneldoc/try_cmpxchg         |   15 +
 scripts/atomic/kerneldoc/xchg                |   13 +
 scripts/atomic/kerneldoc/xor                 |   13 +
 29 files changed, 5940 insertions(+), 7 deletions(-)
 create mode 100644 scripts/atomic/kerneldoc/add
 create mode 100644 scripts/atomic/kerneldoc/add_negative
 create mode 100644 scripts/atomic/kerneldoc/add_unless
 create mode 100644 scripts/atomic/kerneldoc/and
 create mode 100644 scripts/atomic/kerneldoc/andnot
 create mode 100644 scripts/atomic/kerneldoc/cmpxchg
 create mode 100644 scripts/atomic/kerneldoc/dec
 create mode 100644 scripts/atomic/kerneldoc/dec_and_test
 create mode 100644 scripts/atomic/kerneldoc/dec_if_positive
 create mode 100644 scripts/atomic/kerneldoc/dec_unless_positive
 create mode 100644 scripts/atomic/kerneldoc/inc
 create mode 100644 scripts/atomic/kerneldoc/inc_and_test
 create mode 100644 scripts/atomic/kerneldoc/inc_not_zero
 create mode 100644 scripts/atomic/kerneldoc/inc_unless_negative
 create mode 100644 scripts/atomic/kerneldoc/or
 create mode 100644 scripts/atomic/kerneldoc/read
 create mode 100644 scripts/atomic/kerneldoc/set
 create mode 100644 scripts/atomic/kerneldoc/sub
 create mode 100644 scripts/atomic/kerneldoc/sub_and_test
 create mode 100644 scripts/atomic/kerneldoc/try_cmpxchg
 create mode 100644 scripts/atomic/kerneldoc/xchg
 create mode 100644 scripts/atomic/kerneldoc/xor

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 470c2890ab8d6..fa676565453c0 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -428,12 +428,32 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 
 #define raw_sync_cmpxchg arch_sync_cmpxchg
 
+/**
+ * raw_atomic_read() - atomic load with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically loads the value of @v with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_read() elsewhere.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline int
 raw_atomic_read(const atomic_t *v)
 {
 	return arch_atomic_read(v);
 }
 
+/**
+ * raw_atomic_read_acquire() - atomic load with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically loads the value of @v with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_read_acquire() elsewhere.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline int
 raw_atomic_read_acquire(const atomic_t *v)
 {
@@ -455,12 +475,34 @@ raw_atomic_read_acquire(const atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_set() - atomic set with relaxed ordering
+ * @v: pointer to atomic_t
+ * @i: int value to assign
+ *
+ * Atomically sets @v to @i with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_set() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_set(atomic_t *v, int i)
 {
 	arch_atomic_set(v, i);
 }
 
+/**
+ * raw_atomic_set_release() - atomic set with release ordering
+ * @v: pointer to atomic_t
+ * @i: int value to assign
+ *
+ * Atomically sets @v to @i with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_set_release() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_set_release(atomic_t *v, int i)
 {
@@ -478,12 +520,34 @@ raw_atomic_set_release(atomic_t *v, int i)
 #endif
 }
 
+/**
+ * raw_atomic_add() - atomic add with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_add(int i, atomic_t *v)
 {
 	arch_atomic_add(i, v);
 }
 
+/**
+ * raw_atomic_add_return() - atomic add with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_add_return(int i, atomic_t *v)
 {
@@ -500,6 +564,17 @@ raw_atomic_add_return(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_return_acquire() - atomic add with acquire ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_add_return_acquire(int i, atomic_t *v)
 {
@@ -516,6 +591,17 @@ raw_atomic_add_return_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_return_release() - atomic add with release ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_add_return_release(int i, atomic_t *v)
 {
@@ -531,6 +617,17 @@ raw_atomic_add_return_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_return_relaxed() - atomic add with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_add_return_relaxed(int i, atomic_t *v)
 {
@@ -543,6 +640,17 @@ raw_atomic_add_return_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_add() - atomic add with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_add() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_add(int i, atomic_t *v)
 {
@@ -559,6 +667,17 @@ raw_atomic_fetch_add(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_add_acquire() - atomic add with acquire ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_add_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_add_acquire(int i, atomic_t *v)
 {
@@ -575,6 +694,17 @@ raw_atomic_fetch_add_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_add_release() - atomic add with release ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_add_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_add_release(int i, atomic_t *v)
 {
@@ -590,6 +720,17 @@ raw_atomic_fetch_add_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_add_relaxed() - atomic add with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_add_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
@@ -602,12 +743,34 @@ raw_atomic_fetch_add_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_sub() - atomic subtract with relaxed ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_sub() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_sub(int i, atomic_t *v)
 {
 	arch_atomic_sub(i, v);
 }
 
+/**
+ * raw_atomic_sub_return() - atomic subtract with full ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_sub_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_sub_return(int i, atomic_t *v)
 {
@@ -624,6 +787,17 @@ raw_atomic_sub_return(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_sub_return_acquire() - atomic subtract with acquire ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_sub_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_sub_return_acquire(int i, atomic_t *v)
 {
@@ -640,6 +814,17 @@ raw_atomic_sub_return_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_sub_return_release() - atomic subtract with release ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_sub_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_sub_return_release(int i, atomic_t *v)
 {
@@ -655,6 +840,17 @@ raw_atomic_sub_return_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_sub_return_relaxed() - atomic subtract with relaxed ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_sub_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_sub_return_relaxed(int i, atomic_t *v)
 {
@@ -667,6 +863,17 @@ raw_atomic_sub_return_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_sub() - atomic subtract with full ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_sub() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_sub(int i, atomic_t *v)
 {
@@ -683,6 +890,17 @@ raw_atomic_fetch_sub(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_sub_acquire() - atomic subtract with acquire ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_sub_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
@@ -699,6 +917,17 @@ raw_atomic_fetch_sub_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_sub_release() - atomic subtract with release ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_sub_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_sub_release(int i, atomic_t *v)
 {
@@ -714,6 +943,17 @@ raw_atomic_fetch_sub_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_sub_relaxed() - atomic subtract with relaxed ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_sub_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
@@ -726,6 +966,16 @@ raw_atomic_fetch_sub_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_inc(atomic_t *v)
 {
@@ -736,6 +986,16 @@ raw_atomic_inc(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc_return() - atomic increment with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_inc_return(atomic_t *v)
 {
@@ -752,6 +1012,16 @@ raw_atomic_inc_return(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc_return_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_inc_return_acquire(atomic_t *v)
 {
@@ -768,6 +1038,16 @@ raw_atomic_inc_return_acquire(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc_return_release() - atomic increment with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_inc_return_release(atomic_t *v)
 {
@@ -783,6 +1063,16 @@ raw_atomic_inc_return_release(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc_return_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_inc_return_relaxed(atomic_t *v)
 {
@@ -795,6 +1085,16 @@ raw_atomic_inc_return_relaxed(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_inc() - atomic increment with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_inc() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_inc(atomic_t *v)
 {
@@ -811,6 +1111,16 @@ raw_atomic_fetch_inc(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_inc_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_inc_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_inc_acquire(atomic_t *v)
 {
@@ -827,6 +1137,16 @@ raw_atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_inc_release() - atomic increment with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_inc_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_inc_release(atomic_t *v)
 {
@@ -842,6 +1162,16 @@ raw_atomic_fetch_inc_release(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_inc_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_inc_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_inc_relaxed(atomic_t *v)
 {
@@ -854,6 +1184,16 @@ raw_atomic_fetch_inc_relaxed(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_dec(atomic_t *v)
 {
@@ -864,6 +1204,16 @@ raw_atomic_dec(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_return() - atomic decrement with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_dec_return(atomic_t *v)
 {
@@ -880,6 +1230,16 @@ raw_atomic_dec_return(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_return_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_dec_return_acquire(atomic_t *v)
 {
@@ -896,6 +1256,16 @@ raw_atomic_dec_return_acquire(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_return_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_dec_return_release(atomic_t *v)
 {
@@ -911,6 +1281,16 @@ raw_atomic_dec_return_release(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_return_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 raw_atomic_dec_return_relaxed(atomic_t *v)
 {
@@ -923,6 +1303,16 @@ raw_atomic_dec_return_relaxed(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_dec() - atomic decrement with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_dec() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_dec(atomic_t *v)
 {
@@ -939,6 +1329,16 @@ raw_atomic_fetch_dec(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_dec_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_dec_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_dec_acquire(atomic_t *v)
 {
@@ -955,6 +1355,16 @@ raw_atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_dec_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_dec_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_dec_release(atomic_t *v)
 {
@@ -970,6 +1380,16 @@ raw_atomic_fetch_dec_release(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_dec_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_dec_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_dec_relaxed(atomic_t *v)
 {
@@ -982,12 +1402,34 @@ raw_atomic_fetch_dec_relaxed(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_and() - atomic bitwise AND with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_and() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_and(int i, atomic_t *v)
 {
 	arch_atomic_and(i, v);
 }
 
+/**
+ * raw_atomic_fetch_and() - atomic bitwise AND with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_and() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_and(int i, atomic_t *v)
 {
@@ -1004,6 +1446,17 @@ raw_atomic_fetch_and(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_and_acquire() - atomic bitwise AND with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_and_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_and_acquire(int i, atomic_t *v)
 {
@@ -1020,6 +1473,17 @@ raw_atomic_fetch_and_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_and_release() - atomic bitwise AND with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_and_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_and_release(int i, atomic_t *v)
 {
@@ -1035,6 +1499,17 @@ raw_atomic_fetch_and_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_and_relaxed() - atomic bitwise AND with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_and_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
@@ -1047,6 +1522,17 @@ raw_atomic_fetch_and_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_andnot() - atomic bitwise AND NOT with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_andnot() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_andnot(int i, atomic_t *v)
 {
@@ -1057,6 +1543,17 @@ raw_atomic_andnot(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_andnot() - atomic bitwise AND NOT with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_andnot() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_andnot(int i, atomic_t *v)
 {
@@ -1073,6 +1570,17 @@ raw_atomic_fetch_andnot(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_andnot_acquire() - atomic bitwise AND NOT with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_andnot_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
@@ -1089,6 +1597,17 @@ raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_andnot_release() - atomic bitwise AND NOT with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_andnot_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_andnot_release(int i, atomic_t *v)
 {
@@ -1104,6 +1623,17 @@ raw_atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_andnot_relaxed() - atomic bitwise AND NOT with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_andnot_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
@@ -1116,12 +1646,34 @@ raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_or() - atomic bitwise OR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_or() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_or(int i, atomic_t *v)
 {
 	arch_atomic_or(i, v);
 }
 
+/**
+ * raw_atomic_fetch_or() - atomic bitwise OR with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_or() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_or(int i, atomic_t *v)
 {
@@ -1138,6 +1690,17 @@ raw_atomic_fetch_or(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_or_acquire() - atomic bitwise OR with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_or_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_or_acquire(int i, atomic_t *v)
 {
@@ -1154,6 +1717,17 @@ raw_atomic_fetch_or_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_or_release() - atomic bitwise OR with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_or_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_or_release(int i, atomic_t *v)
 {
@@ -1169,6 +1743,17 @@ raw_atomic_fetch_or_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_or_relaxed() - atomic bitwise OR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_or_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
@@ -1181,12 +1766,34 @@ raw_atomic_fetch_or_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_xor() - atomic bitwise XOR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_xor() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_xor(int i, atomic_t *v)
 {
 	arch_atomic_xor(i, v);
 }
 
+/**
+ * raw_atomic_fetch_xor() - atomic bitwise XOR with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_xor() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_xor(int i, atomic_t *v)
 {
@@ -1203,6 +1810,17 @@ raw_atomic_fetch_xor(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_xor_acquire() - atomic bitwise XOR with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_xor_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
@@ -1219,6 +1837,17 @@ raw_atomic_fetch_xor_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_xor_release() - atomic bitwise XOR with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_xor_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_xor_release(int i, atomic_t *v)
 {
@@ -1234,6 +1863,17 @@ raw_atomic_fetch_xor_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_xor_relaxed() - atomic bitwise XOR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_xor_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
@@ -1246,6 +1886,17 @@ raw_atomic_fetch_xor_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_xchg() - atomic exchange with full ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_xchg() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_xchg(atomic_t *v, int new)
 {
@@ -1262,6 +1913,17 @@ raw_atomic_xchg(atomic_t *v, int new)
 #endif
 }
 
+/**
+ * raw_atomic_xchg_acquire() - atomic exchange with acquire ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_xchg_acquire() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_xchg_acquire(atomic_t *v, int new)
 {
@@ -1278,6 +1940,17 @@ raw_atomic_xchg_acquire(atomic_t *v, int new)
 #endif
 }
 
+/**
+ * raw_atomic_xchg_release() - atomic exchange with release ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_xchg_release() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_xchg_release(atomic_t *v, int new)
 {
@@ -1293,6 +1966,17 @@ raw_atomic_xchg_release(atomic_t *v, int new)
 #endif
 }
 
+/**
+ * raw_atomic_xchg_relaxed() - atomic exchange with relaxed ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_xchg_relaxed() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_xchg_relaxed(atomic_t *v, int new)
 {
@@ -1305,6 +1989,18 @@ raw_atomic_xchg_relaxed(atomic_t *v, int new)
 #endif
 }
 
+/**
+ * raw_atomic_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_cmpxchg() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
@@ -1321,6 +2017,18 @@ raw_atomic_cmpxchg(atomic_t *v, int old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_cmpxchg_acquire() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
@@ -1337,6 +2045,18 @@ raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_cmpxchg_release() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
@@ -1352,6 +2072,18 @@ raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_cmpxchg_relaxed() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
@@ -1364,6 +2096,19 @@ raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_try_cmpxchg() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
@@ -1384,6 +2129,19 @@ raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_try_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_try_cmpxchg_acquire() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
@@ -1404,6 +2162,19 @@ raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_try_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_try_cmpxchg_release() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
@@ -1423,6 +2194,19 @@ raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_try_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_try_cmpxchg_relaxed() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
@@ -1439,6 +2223,17 @@ raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 #endif
 }
 
+/**
+ * raw_atomic_sub_and_test() - atomic subtract and test if zero with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_sub_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_sub_and_test(int i, atomic_t *v)
 {
@@ -1449,6 +2244,16 @@ raw_atomic_sub_and_test(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_and_test() - atomic decrement and test if zero with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_dec_and_test(atomic_t *v)
 {
@@ -1459,6 +2264,16 @@ raw_atomic_dec_and_test(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc_and_test() - atomic increment and test if zero with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_inc_and_test(atomic_t *v)
 {
@@ -1469,6 +2284,17 @@ raw_atomic_inc_and_test(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_negative() - atomic add and test if negative with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_negative() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_add_negative(int i, atomic_t *v)
 {
@@ -1485,6 +2311,17 @@ raw_atomic_add_negative(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_negative_acquire() - atomic add and test if negative with acquire ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_negative_acquire() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_add_negative_acquire(int i, atomic_t *v)
 {
@@ -1501,6 +2338,17 @@ raw_atomic_add_negative_acquire(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_negative_release() - atomic add and test if negative with release ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_negative_release() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_add_negative_release(int i, atomic_t *v)
 {
@@ -1516,6 +2364,17 @@ raw_atomic_add_negative_release(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_add_negative_relaxed() - atomic add and test if negative with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_negative_relaxed() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_add_negative_relaxed(int i, atomic_t *v)
 {
@@ -1528,6 +2387,18 @@ raw_atomic_add_negative_relaxed(int i, atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_fetch_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_t
+ * @a: int value to add
+ * @u: int value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_fetch_add_unless() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
@@ -1545,6 +2416,18 @@ raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #endif
 }
 
+/**
+ * raw_atomic_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_t
+ * @a: int value to add
+ * @u: int value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_add_unless() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_add_unless(atomic_t *v, int a, int u)
 {
@@ -1555,6 +2438,16 @@ raw_atomic_add_unless(atomic_t *v, int a, int u)
 #endif
 }
 
+/**
+ * raw_atomic_inc_not_zero() - atomic increment unless zero with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_not_zero() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_inc_not_zero(atomic_t *v)
 {
@@ -1565,6 +2458,16 @@ raw_atomic_inc_not_zero(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_inc_unless_negative() - atomic increment unless negative with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_inc_unless_negative() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_inc_unless_negative(atomic_t *v)
 {
@@ -1582,6 +2485,16 @@ raw_atomic_inc_unless_negative(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_unless_positive() - atomic decrement unless positive with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_unless_positive() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_dec_unless_positive(atomic_t *v)
 {
@@ -1599,6 +2512,16 @@ raw_atomic_dec_unless_positive(atomic_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_dec_if_positive() - atomic decrement if positive with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_dec_if_positive() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline int
 raw_atomic_dec_if_positive(atomic_t *v)
 {
@@ -1621,12 +2544,32 @@ raw_atomic_dec_if_positive(atomic_t *v)
 #include <asm-generic/atomic64.h>
 #endif
 
+/**
+ * raw_atomic64_read() - atomic load with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically loads the value of @v with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_read() elsewhere.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline s64
 raw_atomic64_read(const atomic64_t *v)
 {
 	return arch_atomic64_read(v);
 }
 
+/**
+ * raw_atomic64_read_acquire() - atomic load with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically loads the value of @v with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_read_acquire() elsewhere.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline s64
 raw_atomic64_read_acquire(const atomic64_t *v)
 {
@@ -1648,12 +2591,34 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_set() - atomic set with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @i: s64 value to assign
+ *
+ * Atomically sets @v to @i with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_set() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_set(atomic64_t *v, s64 i)
 {
 	arch_atomic64_set(v, i);
 }
 
+/**
+ * raw_atomic64_set_release() - atomic set with release ordering
+ * @v: pointer to atomic64_t
+ * @i: s64 value to assign
+ *
+ * Atomically sets @v to @i with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_set_release() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
@@ -1671,12 +2636,34 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
 #endif
 }
 
+/**
+ * raw_atomic64_add() - atomic add with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_add(s64 i, atomic64_t *v)
 {
 	arch_atomic64_add(i, v);
 }
 
+/**
+ * raw_atomic64_add_return() - atomic add with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_add_return(s64 i, atomic64_t *v)
 {
@@ -1693,6 +2680,17 @@ raw_atomic64_add_return(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_return_acquire() - atomic add with acquire ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
@@ -1709,6 +2707,17 @@ raw_atomic64_add_return_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_return_release() - atomic add with release ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_add_return_release(s64 i, atomic64_t *v)
 {
@@ -1724,6 +2733,17 @@ raw_atomic64_add_return_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_return_relaxed() - atomic add with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
@@ -1736,6 +2756,17 @@ raw_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_add() - atomic add with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_add() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -1752,6 +2783,17 @@ raw_atomic64_fetch_add(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_add_acquire() - atomic add with acquire ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_add_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
@@ -1768,6 +2810,17 @@ raw_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_add_release() - atomic add with release ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_add_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
@@ -1783,6 +2836,17 @@ raw_atomic64_fetch_add_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_add_relaxed() - atomic add with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_add_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
@@ -1795,12 +2859,34 @@ raw_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_sub() - atomic subtract with relaxed ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_sub() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_sub(s64 i, atomic64_t *v)
 {
 	arch_atomic64_sub(i, v);
 }
 
+/**
+ * raw_atomic64_sub_return() - atomic subtract with full ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_sub_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_sub_return(s64 i, atomic64_t *v)
 {
@@ -1817,6 +2903,17 @@ raw_atomic64_sub_return(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_sub_return_acquire() - atomic subtract with acquire ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_sub_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
@@ -1833,6 +2930,17 @@ raw_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_sub_return_release() - atomic subtract with release ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_sub_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
@@ -1848,6 +2956,17 @@ raw_atomic64_sub_return_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_sub_return_relaxed() - atomic subtract with relaxed ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_sub_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
@@ -1860,6 +2979,17 @@ raw_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_sub() - atomic subtract with full ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_sub() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
@@ -1876,6 +3006,17 @@ raw_atomic64_fetch_sub(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_sub_acquire() - atomic subtract with acquire ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_sub_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
@@ -1892,6 +3033,17 @@ raw_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_sub_release() - atomic subtract with release ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_sub_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
@@ -1907,6 +3059,17 @@ raw_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_sub_relaxed() - atomic subtract with relaxed ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_sub_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
@@ -1919,6 +3082,16 @@ raw_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc() - atomic increment with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_inc(atomic64_t *v)
 {
@@ -1929,6 +3102,16 @@ raw_atomic64_inc(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_return() - atomic increment with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_inc_return(atomic64_t *v)
 {
@@ -1945,6 +3128,16 @@ raw_atomic64_inc_return(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_return_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_inc_return_acquire(atomic64_t *v)
 {
@@ -1961,6 +3154,16 @@ raw_atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_return_release() - atomic increment with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_inc_return_release(atomic64_t *v)
 {
@@ -1976,6 +3179,16 @@ raw_atomic64_inc_return_release(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_return_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_inc_return_relaxed(atomic64_t *v)
 {
@@ -1988,6 +3201,16 @@ raw_atomic64_inc_return_relaxed(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_inc() - atomic increment with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_inc() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_inc(atomic64_t *v)
 {
@@ -2004,6 +3227,16 @@ raw_atomic64_fetch_inc(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_inc_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_inc_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_inc_acquire(atomic64_t *v)
 {
@@ -2020,6 +3253,16 @@ raw_atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_inc_release() - atomic increment with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_inc_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_inc_release(atomic64_t *v)
 {
@@ -2035,6 +3278,16 @@ raw_atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_inc_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_inc_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
@@ -2047,6 +3300,16 @@ raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_dec(atomic64_t *v)
 {
@@ -2057,6 +3320,16 @@ raw_atomic64_dec(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_return() - atomic decrement with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_dec_return(atomic64_t *v)
 {
@@ -2073,6 +3346,16 @@ raw_atomic64_dec_return(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_return_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_dec_return_acquire(atomic64_t *v)
 {
@@ -2089,6 +3372,16 @@ raw_atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_return_release() - atomic decrement with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_dec_return_release(atomic64_t *v)
 {
@@ -2104,6 +3397,16 @@ raw_atomic64_dec_return_release(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_return_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 raw_atomic64_dec_return_relaxed(atomic64_t *v)
 {
@@ -2116,6 +3419,16 @@ raw_atomic64_dec_return_relaxed(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_dec() - atomic decrement with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_dec() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_dec(atomic64_t *v)
 {
@@ -2132,6 +3445,16 @@ raw_atomic64_fetch_dec(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_dec_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_dec_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_dec_acquire(atomic64_t *v)
 {
@@ -2148,6 +3471,16 @@ raw_atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_dec_release() - atomic decrement with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_dec_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_dec_release(atomic64_t *v)
 {
@@ -2163,6 +3496,16 @@ raw_atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_dec_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_dec_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
@@ -2175,12 +3518,34 @@ raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_and() - atomic bitwise AND with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_and() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_and(s64 i, atomic64_t *v)
 {
 	arch_atomic64_and(i, v);
 }
 
+/**
+ * raw_atomic64_fetch_and() - atomic bitwise AND with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_and() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
@@ -2197,6 +3562,17 @@ raw_atomic64_fetch_and(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_and_acquire() - atomic bitwise AND with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_and_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
@@ -2213,6 +3589,17 @@ raw_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_and_release() - atomic bitwise AND with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_and_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
@@ -2228,6 +3615,17 @@ raw_atomic64_fetch_and_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_and_relaxed() - atomic bitwise AND with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_and_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
@@ -2240,6 +3638,17 @@ raw_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_andnot() - atomic bitwise AND NOT with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_andnot() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_andnot(s64 i, atomic64_t *v)
 {
@@ -2250,6 +3659,17 @@ raw_atomic64_andnot(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_andnot() - atomic bitwise AND NOT with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_andnot() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
@@ -2266,6 +3686,17 @@ raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_andnot_acquire() - atomic bitwise AND NOT with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_andnot_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
@@ -2282,6 +3713,17 @@ raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_andnot_release() - atomic bitwise AND NOT with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_andnot_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
@@ -2297,6 +3739,17 @@ raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_andnot_relaxed() - atomic bitwise AND NOT with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_andnot_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
@@ -2309,12 +3762,34 @@ raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_or() - atomic bitwise OR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_or() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_or(s64 i, atomic64_t *v)
 {
 	arch_atomic64_or(i, v);
 }
 
+/**
+ * raw_atomic64_fetch_or() - atomic bitwise OR with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_or() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
@@ -2331,6 +3806,17 @@ raw_atomic64_fetch_or(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_or_acquire() - atomic bitwise OR with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_or_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
@@ -2347,6 +3833,17 @@ raw_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_or_release() - atomic bitwise OR with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_or_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
@@ -2362,6 +3859,17 @@ raw_atomic64_fetch_or_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_or_relaxed() - atomic bitwise OR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_or_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
@@ -2374,12 +3882,34 @@ raw_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_xor() - atomic bitwise XOR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_xor() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic64_xor(s64 i, atomic64_t *v)
 {
 	arch_atomic64_xor(i, v);
 }
 
+/**
+ * raw_atomic64_fetch_xor() - atomic bitwise XOR with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_xor() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
@@ -2396,6 +3926,17 @@ raw_atomic64_fetch_xor(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_xor_acquire() - atomic bitwise XOR with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_xor_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
@@ -2412,6 +3953,17 @@ raw_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_xor_release() - atomic bitwise XOR with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_xor_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
@@ -2427,6 +3979,17 @@ raw_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_xor_relaxed() - atomic bitwise XOR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_xor_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
@@ -2439,6 +4002,17 @@ raw_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_xchg() - atomic exchange with full ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_xchg() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_xchg(atomic64_t *v, s64 new)
 {
@@ -2455,6 +4029,17 @@ raw_atomic64_xchg(atomic64_t *v, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_xchg_acquire() - atomic exchange with acquire ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_xchg_acquire() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
 {
@@ -2471,6 +4056,17 @@ raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_xchg_release() - atomic exchange with release ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_xchg_release() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_xchg_release(atomic64_t *v, s64 new)
 {
@@ -2486,6 +4082,17 @@ raw_atomic64_xchg_release(atomic64_t *v, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_xchg_relaxed() - atomic exchange with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_xchg_relaxed() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 {
@@ -2498,6 +4105,18 @@ raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_cmpxchg() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
@@ -2514,6 +4133,18 @@ raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_cmpxchg_acquire() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
@@ -2530,6 +4161,18 @@ raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_cmpxchg_release() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
@@ -2545,6 +4188,18 @@ raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_cmpxchg_relaxed() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
@@ -2557,6 +4212,19 @@ raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic64_try_cmpxchg() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2577,6 +4245,19 @@ raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_try_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_acquire() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2597,6 +4278,19 @@ raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_try_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_release() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2616,6 +4310,19 @@ raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_try_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_relaxed() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2632,6 +4339,17 @@ raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 #endif
 }
 
+/**
+ * raw_atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_sub_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
@@ -2642,6 +4360,16 @@ raw_atomic64_sub_and_test(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_and_test() - atomic decrement and test if zero with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_dec_and_test(atomic64_t *v)
 {
@@ -2652,6 +4380,16 @@ raw_atomic64_dec_and_test(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_and_test() - atomic increment and test if zero with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_inc_and_test(atomic64_t *v)
 {
@@ -2662,6 +4400,17 @@ raw_atomic64_inc_and_test(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_negative() - atomic add and test if negative with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_negative() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_add_negative(s64 i, atomic64_t *v)
 {
@@ -2678,6 +4427,17 @@ raw_atomic64_add_negative(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_negative_acquire() - atomic add and test if negative with acquire ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_negative_acquire() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
@@ -2694,6 +4454,17 @@ raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_negative_release() - atomic add and test if negative with release ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_negative_release() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
@@ -2709,6 +4480,17 @@ raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_add_negative_relaxed() - atomic add and test if negative with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_negative_relaxed() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
@@ -2721,6 +4503,18 @@ raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_fetch_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic64_t
+ * @a: s64 value to add
+ * @u: s64 value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_fetch_add_unless() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -2738,6 +4532,18 @@ raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 #endif
 }
 
+/**
+ * raw_atomic64_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic64_t
+ * @a: s64 value to add
+ * @u: s64 value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_add_unless() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -2748,6 +4554,16 @@ raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_not_zero() - atomic increment unless zero with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_not_zero() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -2758,6 +4574,16 @@ raw_atomic64_inc_not_zero(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_inc_unless_negative() - atomic increment unless negative with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_inc_unless_negative() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_inc_unless_negative(atomic64_t *v)
 {
@@ -2775,6 +4601,16 @@ raw_atomic64_inc_unless_negative(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_unless_positive() - atomic decrement unless positive with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_unless_positive() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic64_dec_unless_positive(atomic64_t *v)
 {
@@ -2792,6 +4628,16 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
 #endif
 }
 
+/**
+ * raw_atomic64_dec_if_positive() - atomic decrement if positive with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic64_dec_if_positive() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline s64
 raw_atomic64_dec_if_positive(atomic64_t *v)
 {
@@ -2811,4 +4657,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 205e090382132f1fc85e48b46e722865f9c81309
+// 05af058ad6cbb042b0729969eb13ac6586f0fda7
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 5491c89dc03a0..248fa54f56265 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -16,6 +16,16 @@
 #include <linux/compiler.h>
 #include <linux/instrumented.h>
 
+/**
+ * atomic_read() - atomic load with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically loads the value of @v with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_read() there.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline int
 atomic_read(const atomic_t *v)
 {
@@ -23,6 +33,16 @@ atomic_read(const atomic_t *v)
 	return raw_atomic_read(v);
 }
 
+/**
+ * atomic_read_acquire() - atomic load with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically loads the value of @v with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_read_acquire() there.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
@@ -30,6 +50,17 @@ atomic_read_acquire(const atomic_t *v)
 	return raw_atomic_read_acquire(v);
 }
 
+/**
+ * atomic_set() - atomic set with relaxed ordering
+ * @v: pointer to atomic_t
+ * @i: int value to assign
+ *
+ * Atomically sets @v to @i with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_set() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_set(atomic_t *v, int i)
 {
@@ -37,6 +68,17 @@ atomic_set(atomic_t *v, int i)
 	raw_atomic_set(v, i);
 }
 
+/**
+ * atomic_set_release() - atomic set with release ordering
+ * @v: pointer to atomic_t
+ * @i: int value to assign
+ *
+ * Atomically sets @v to @i with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_set_release() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
@@ -45,6 +87,17 @@ atomic_set_release(atomic_t *v, int i)
 	raw_atomic_set_release(v, i);
 }
 
+/**
+ * atomic_add() - atomic add with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_add(int i, atomic_t *v)
 {
@@ -52,6 +105,17 @@ atomic_add(int i, atomic_t *v)
 	raw_atomic_add(i, v);
 }
 
+/**
+ * atomic_add_return() - atomic add with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
@@ -60,6 +124,17 @@ atomic_add_return(int i, atomic_t *v)
 	return raw_atomic_add_return(i, v);
 }
 
+/**
+ * atomic_add_return_acquire() - atomic add with acquire ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
@@ -67,6 +142,17 @@ atomic_add_return_acquire(int i, atomic_t *v)
 	return raw_atomic_add_return_acquire(i, v);
 }
 
+/**
+ * atomic_add_return_release() - atomic add with release ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
@@ -75,6 +161,17 @@ atomic_add_return_release(int i, atomic_t *v)
 	return raw_atomic_add_return_release(i, v);
 }
 
+/**
+ * atomic_add_return_relaxed() - atomic add with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
@@ -82,6 +179,17 @@ atomic_add_return_relaxed(int i, atomic_t *v)
 	return raw_atomic_add_return_relaxed(i, v);
 }
 
+/**
+ * atomic_fetch_add() - atomic add with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
@@ -90,6 +198,17 @@ atomic_fetch_add(int i, atomic_t *v)
 	return raw_atomic_fetch_add(i, v);
 }
 
+/**
+ * atomic_fetch_add_acquire() - atomic add with acquire ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
@@ -97,6 +216,17 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 	return raw_atomic_fetch_add_acquire(i, v);
 }
 
+/**
+ * atomic_fetch_add_release() - atomic add with release ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
@@ -105,6 +235,17 @@ atomic_fetch_add_release(int i, atomic_t *v)
 	return raw_atomic_fetch_add_release(i, v);
 }
 
+/**
+ * atomic_fetch_add_relaxed() - atomic add with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
@@ -112,6 +253,17 @@ atomic_fetch_add_relaxed(int i, atomic_t *v)
 	return raw_atomic_fetch_add_relaxed(i, v);
 }
 
+/**
+ * atomic_sub() - atomic subtract with relaxed ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_sub() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_sub(int i, atomic_t *v)
 {
@@ -119,6 +271,17 @@ atomic_sub(int i, atomic_t *v)
 	raw_atomic_sub(i, v);
 }
 
+/**
+ * atomic_sub_return() - atomic subtract with full ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_sub_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
@@ -127,6 +290,17 @@ atomic_sub_return(int i, atomic_t *v)
 	return raw_atomic_sub_return(i, v);
 }
 
+/**
+ * atomic_sub_return_acquire() - atomic subtract with acquire ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_sub_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
@@ -134,6 +308,17 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 	return raw_atomic_sub_return_acquire(i, v);
 }
 
+/**
+ * atomic_sub_return_release() - atomic subtract with release ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_sub_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
@@ -142,6 +327,17 @@ atomic_sub_return_release(int i, atomic_t *v)
 	return raw_atomic_sub_return_release(i, v);
 }
 
+/**
+ * atomic_sub_return_relaxed() - atomic subtract with relaxed ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_sub_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
@@ -149,6 +345,17 @@ atomic_sub_return_relaxed(int i, atomic_t *v)
 	return raw_atomic_sub_return_relaxed(i, v);
 }
 
+/**
+ * atomic_fetch_sub() - atomic subtract with full ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_sub() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
@@ -157,6 +364,17 @@ atomic_fetch_sub(int i, atomic_t *v)
 	return raw_atomic_fetch_sub(i, v);
 }
 
+/**
+ * atomic_fetch_sub_acquire() - atomic subtract with acquire ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_sub_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
@@ -164,6 +382,17 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 	return raw_atomic_fetch_sub_acquire(i, v);
 }
 
+/**
+ * atomic_fetch_sub_release() - atomic subtract with release ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_sub_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
@@ -172,6 +401,17 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 	return raw_atomic_fetch_sub_release(i, v);
 }
 
+/**
+ * atomic_fetch_sub_relaxed() - atomic subtract with relaxed ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_sub_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
@@ -179,6 +419,16 @@ atomic_fetch_sub_relaxed(int i, atomic_t *v)
 	return raw_atomic_fetch_sub_relaxed(i, v);
 }
 
+/**
+ * atomic_inc() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_inc(atomic_t *v)
 {
@@ -186,6 +436,16 @@ atomic_inc(atomic_t *v)
 	raw_atomic_inc(v);
 }
 
+/**
+ * atomic_inc_return() - atomic increment with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
@@ -194,6 +454,16 @@ atomic_inc_return(atomic_t *v)
 	return raw_atomic_inc_return(v);
 }
 
+/**
+ * atomic_inc_return_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
@@ -201,6 +471,16 @@ atomic_inc_return_acquire(atomic_t *v)
 	return raw_atomic_inc_return_acquire(v);
 }
 
+/**
+ * atomic_inc_return_release() - atomic increment with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
@@ -209,6 +489,16 @@ atomic_inc_return_release(atomic_t *v)
 	return raw_atomic_inc_return_release(v);
 }
 
+/**
+ * atomic_inc_return_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
@@ -216,6 +506,16 @@ atomic_inc_return_relaxed(atomic_t *v)
 	return raw_atomic_inc_return_relaxed(v);
 }
 
+/**
+ * atomic_fetch_inc() - atomic increment with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_inc() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
@@ -224,6 +524,16 @@ atomic_fetch_inc(atomic_t *v)
 	return raw_atomic_fetch_inc(v);
 }
 
+/**
+ * atomic_fetch_inc_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_inc_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
@@ -231,6 +541,16 @@ atomic_fetch_inc_acquire(atomic_t *v)
 	return raw_atomic_fetch_inc_acquire(v);
 }
 
+/**
+ * atomic_fetch_inc_release() - atomic increment with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_inc_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
@@ -239,6 +559,16 @@ atomic_fetch_inc_release(atomic_t *v)
 	return raw_atomic_fetch_inc_release(v);
 }
 
+/**
+ * atomic_fetch_inc_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_inc_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
@@ -246,6 +576,16 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 	return raw_atomic_fetch_inc_relaxed(v);
 }
 
+/**
+ * atomic_dec() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_dec(atomic_t *v)
 {
@@ -253,6 +593,16 @@ atomic_dec(atomic_t *v)
 	raw_atomic_dec(v);
 }
 
+/**
+ * atomic_dec_return() - atomic decrement with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
@@ -261,6 +611,16 @@ atomic_dec_return(atomic_t *v)
 	return raw_atomic_dec_return(v);
 }
 
+/**
+ * atomic_dec_return_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
@@ -268,6 +628,16 @@ atomic_dec_return_acquire(atomic_t *v)
 	return raw_atomic_dec_return_acquire(v);
 }
 
+/**
+ * atomic_dec_return_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
@@ -276,6 +646,16 @@ atomic_dec_return_release(atomic_t *v)
 	return raw_atomic_dec_return_release(v);
 }
 
+/**
+ * atomic_dec_return_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
@@ -283,6 +663,16 @@ atomic_dec_return_relaxed(atomic_t *v)
 	return raw_atomic_dec_return_relaxed(v);
 }
 
+/**
+ * atomic_fetch_dec() - atomic decrement with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_dec() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
@@ -291,6 +681,16 @@ atomic_fetch_dec(atomic_t *v)
 	return raw_atomic_fetch_dec(v);
 }
 
+/**
+ * atomic_fetch_dec_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_dec_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
@@ -298,6 +698,16 @@ atomic_fetch_dec_acquire(atomic_t *v)
 	return raw_atomic_fetch_dec_acquire(v);
 }
 
+/**
+ * atomic_fetch_dec_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_dec_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
@@ -306,6 +716,16 @@ atomic_fetch_dec_release(atomic_t *v)
 	return raw_atomic_fetch_dec_release(v);
 }
 
+/**
+ * atomic_fetch_dec_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_dec_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
@@ -313,6 +733,17 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 	return raw_atomic_fetch_dec_relaxed(v);
 }
 
+/**
+ * atomic_and() - atomic bitwise AND with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_and() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_and(int i, atomic_t *v)
 {
@@ -320,6 +751,17 @@ atomic_and(int i, atomic_t *v)
 	raw_atomic_and(i, v);
 }
 
+/**
+ * atomic_fetch_and() - atomic bitwise AND with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_and() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
@@ -328,6 +770,17 @@ atomic_fetch_and(int i, atomic_t *v)
 	return raw_atomic_fetch_and(i, v);
 }
 
+/**
+ * atomic_fetch_and_acquire() - atomic bitwise AND with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_and_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
@@ -335,6 +788,17 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 	return raw_atomic_fetch_and_acquire(i, v);
 }
 
+/**
+ * atomic_fetch_and_release() - atomic bitwise AND with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_and_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
@@ -343,6 +807,17 @@ atomic_fetch_and_release(int i, atomic_t *v)
 	return raw_atomic_fetch_and_release(i, v);
 }
 
+/**
+ * atomic_fetch_and_relaxed() - atomic bitwise AND with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_and_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
@@ -350,6 +825,17 @@ atomic_fetch_and_relaxed(int i, atomic_t *v)
 	return raw_atomic_fetch_and_relaxed(i, v);
 }
 
+/**
+ * atomic_andnot() - atomic bitwise AND NOT with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_andnot() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
@@ -357,6 +843,17 @@ atomic_andnot(int i, atomic_t *v)
 	raw_atomic_andnot(i, v);
 }
 
+/**
+ * atomic_fetch_andnot() - atomic bitwise AND NOT with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_andnot() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
@@ -365,6 +862,17 @@ atomic_fetch_andnot(int i, atomic_t *v)
 	return raw_atomic_fetch_andnot(i, v);
 }
 
+/**
+ * atomic_fetch_andnot_acquire() - atomic bitwise AND NOT with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_andnot_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
@@ -372,6 +880,17 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 	return raw_atomic_fetch_andnot_acquire(i, v);
 }
 
+/**
+ * atomic_fetch_andnot_release() - atomic bitwise AND NOT with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_andnot_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
@@ -380,6 +899,17 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 	return raw_atomic_fetch_andnot_release(i, v);
 }
 
+/**
+ * atomic_fetch_andnot_relaxed() - atomic bitwise AND NOT with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_andnot_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
@@ -387,6 +917,17 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 	return raw_atomic_fetch_andnot_relaxed(i, v);
 }
 
+/**
+ * atomic_or() - atomic bitwise OR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_or() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_or(int i, atomic_t *v)
 {
@@ -394,6 +935,17 @@ atomic_or(int i, atomic_t *v)
 	raw_atomic_or(i, v);
 }
 
+/**
+ * atomic_fetch_or() - atomic bitwise OR with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_or() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
@@ -402,6 +954,17 @@ atomic_fetch_or(int i, atomic_t *v)
 	return raw_atomic_fetch_or(i, v);
 }
 
+/**
+ * atomic_fetch_or_acquire() - atomic bitwise OR with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_or_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
@@ -409,6 +972,17 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 	return raw_atomic_fetch_or_acquire(i, v);
 }
 
+/**
+ * atomic_fetch_or_release() - atomic bitwise OR with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_or_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
@@ -417,6 +991,17 @@ atomic_fetch_or_release(int i, atomic_t *v)
 	return raw_atomic_fetch_or_release(i, v);
 }
 
+/**
+ * atomic_fetch_or_relaxed() - atomic bitwise OR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_or_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
@@ -424,6 +1009,17 @@ atomic_fetch_or_relaxed(int i, atomic_t *v)
 	return raw_atomic_fetch_or_relaxed(i, v);
 }
 
+/**
+ * atomic_xor() - atomic bitwise XOR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_xor() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_xor(int i, atomic_t *v)
 {
@@ -431,6 +1027,17 @@ atomic_xor(int i, atomic_t *v)
 	raw_atomic_xor(i, v);
 }
 
+/**
+ * atomic_fetch_xor() - atomic bitwise XOR with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_xor() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
@@ -439,6 +1046,17 @@ atomic_fetch_xor(int i, atomic_t *v)
 	return raw_atomic_fetch_xor(i, v);
 }
 
+/**
+ * atomic_fetch_xor_acquire() - atomic bitwise XOR with acquire ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_xor_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
@@ -446,6 +1064,17 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 	return raw_atomic_fetch_xor_acquire(i, v);
 }
 
+/**
+ * atomic_fetch_xor_release() - atomic bitwise XOR with release ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_xor_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
@@ -454,6 +1083,17 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 	return raw_atomic_fetch_xor_release(i, v);
 }
 
+/**
+ * atomic_fetch_xor_relaxed() - atomic bitwise XOR with relaxed ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_xor_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
@@ -461,6 +1101,17 @@ atomic_fetch_xor_relaxed(int i, atomic_t *v)
 	return raw_atomic_fetch_xor_relaxed(i, v);
 }
 
+/**
+ * atomic_xchg() - atomic exchange with full ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_xchg() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_xchg(atomic_t *v, int new)
 {
@@ -469,6 +1120,17 @@ atomic_xchg(atomic_t *v, int new)
 	return raw_atomic_xchg(v, new);
 }
 
+/**
+ * atomic_xchg_acquire() - atomic exchange with acquire ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_xchg_acquire() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int new)
 {
@@ -476,6 +1138,17 @@ atomic_xchg_acquire(atomic_t *v, int new)
 	return raw_atomic_xchg_acquire(v, new);
 }
 
+/**
+ * atomic_xchg_release() - atomic exchange with release ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_xchg_release() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_xchg_release(atomic_t *v, int new)
 {
@@ -484,6 +1157,17 @@ atomic_xchg_release(atomic_t *v, int new)
 	return raw_atomic_xchg_release(v, new);
 }
 
+/**
+ * atomic_xchg_relaxed() - atomic exchange with relaxed ordering
+ * @v: pointer to atomic_t
+ * @new: int value to assign
+ *
+ * Atomically updates @v to @new with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_xchg_relaxed() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int new)
 {
@@ -491,6 +1175,18 @@ atomic_xchg_relaxed(atomic_t *v, int new)
 	return raw_atomic_xchg_relaxed(v, new);
 }
 
+/**
+ * atomic_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_cmpxchg() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
@@ -499,6 +1195,18 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 	return raw_atomic_cmpxchg(v, old, new);
 }
 
+/**
+ * atomic_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_acquire() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
@@ -506,6 +1214,18 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 	return raw_atomic_cmpxchg_acquire(v, old, new);
 }
 
+/**
+ * atomic_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_release() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
@@ -514,6 +1234,18 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 	return raw_atomic_cmpxchg_release(v, old, new);
 }
 
+/**
+ * atomic_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_t
+ * @old: int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_relaxed() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
@@ -521,6 +1253,19 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 	return raw_atomic_cmpxchg_relaxed(v, old, new);
 }
 
+/**
+ * atomic_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
@@ -530,6 +1275,19 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 	return raw_atomic_try_cmpxchg(v, old, new);
 }
 
+/**
+ * atomic_try_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_acquire() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
@@ -538,6 +1296,19 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 	return raw_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
+/**
+ * atomic_try_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_release() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
@@ -547,6 +1318,19 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 	return raw_atomic_try_cmpxchg_release(v, old, new);
 }
 
+/**
+ * atomic_try_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_relaxed() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
@@ -555,6 +1339,17 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 	return raw_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
+/**
+ * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_sub_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
@@ -563,6 +1358,16 @@ atomic_sub_and_test(int i, atomic_t *v)
 	return raw_atomic_sub_and_test(i, v);
 }
 
+/**
+ * atomic_dec_and_test() - atomic decrement and test if zero with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
@@ -571,6 +1376,16 @@ atomic_dec_and_test(atomic_t *v)
 	return raw_atomic_dec_and_test(v);
 }
 
+/**
+ * atomic_inc_and_test() - atomic increment and test if zero with full ordering
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
@@ -579,6 +1394,17 @@ atomic_inc_and_test(atomic_t *v)
 	return raw_atomic_inc_and_test(v);
 }
 
+/**
+ * atomic_add_negative() - atomic add and test if negative with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_negative() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
@@ -587,6 +1413,17 @@ atomic_add_negative(int i, atomic_t *v)
 	return raw_atomic_add_negative(i, v);
 }
 
+/**
+ * atomic_add_negative_acquire() - atomic add and test if negative with acquire ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_negative_acquire() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_add_negative_acquire(int i, atomic_t *v)
 {
@@ -594,6 +1431,17 @@ atomic_add_negative_acquire(int i, atomic_t *v)
 	return raw_atomic_add_negative_acquire(i, v);
 }
 
+/**
+ * atomic_add_negative_release() - atomic add and test if negative with release ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_negative_release() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_add_negative_release(int i, atomic_t *v)
 {
@@ -602,6 +1450,17 @@ atomic_add_negative_release(int i, atomic_t *v)
 	return raw_atomic_add_negative_release(i, v);
 }
 
+/**
+ * atomic_add_negative_relaxed() - atomic add and test if negative with relaxed ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_negative_relaxed() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_add_negative_relaxed(int i, atomic_t *v)
 {
@@ -609,6 +1468,18 @@ atomic_add_negative_relaxed(int i, atomic_t *v)
 	return raw_atomic_add_negative_relaxed(i, v);
 }
 
+/**
+ * atomic_fetch_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_t
+ * @a: int value to add
+ * @u: int value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add_unless() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
@@ -617,6 +1488,18 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	return raw_atomic_fetch_add_unless(v, a, u);
 }
 
+/**
+ * atomic_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_t
+ * @a: int value to add
+ * @u: int value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_add_unless() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
@@ -625,6 +1508,16 @@ atomic_add_unless(atomic_t *v, int a, int u)
 	return raw_atomic_add_unless(v, a, u);
 }
 
+/**
+ * atomic_inc_not_zero() - atomic increment unless zero with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_not_zero() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
@@ -633,6 +1526,16 @@ atomic_inc_not_zero(atomic_t *v)
 	return raw_atomic_inc_not_zero(v);
 }
 
+/**
+ * atomic_inc_unless_negative() - atomic increment unless negative with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_inc_unless_negative() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
@@ -641,6 +1544,16 @@ atomic_inc_unless_negative(atomic_t *v)
 	return raw_atomic_inc_unless_negative(v);
 }
 
+/**
+ * atomic_dec_unless_positive() - atomic decrement unless positive with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_unless_positive() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
@@ -649,6 +1562,16 @@ atomic_dec_unless_positive(atomic_t *v)
 	return raw_atomic_dec_unless_positive(v);
 }
 
+/**
+ * atomic_dec_if_positive() - atomic decrement if positive with full ordering
+ * @v: pointer to atomic_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_dec_if_positive() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
@@ -657,6 +1580,16 @@ atomic_dec_if_positive(atomic_t *v)
 	return raw_atomic_dec_if_positive(v);
 }
 
+/**
+ * atomic64_read() - atomic load with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically loads the value of @v with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_read() there.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
@@ -664,6 +1597,16 @@ atomic64_read(const atomic64_t *v)
 	return raw_atomic64_read(v);
 }
 
+/**
+ * atomic64_read_acquire() - atomic load with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically loads the value of @v with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_read_acquire() there.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
@@ -671,6 +1614,17 @@ atomic64_read_acquire(const atomic64_t *v)
 	return raw_atomic64_read_acquire(v);
 }
 
+/**
+ * atomic64_set() - atomic set with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @i: s64 value to assign
+ *
+ * Atomically sets @v to @i with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_set() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
@@ -678,6 +1632,17 @@ atomic64_set(atomic64_t *v, s64 i)
 	raw_atomic64_set(v, i);
 }
 
+/**
+ * atomic64_set_release() - atomic set with release ordering
+ * @v: pointer to atomic64_t
+ * @i: s64 value to assign
+ *
+ * Atomically sets @v to @i with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_set_release() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
@@ -686,6 +1651,17 @@ atomic64_set_release(atomic64_t *v, s64 i)
 	raw_atomic64_set_release(v, i);
 }
 
+/**
+ * atomic64_add() - atomic add with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
@@ -693,6 +1669,17 @@ atomic64_add(s64 i, atomic64_t *v)
 	raw_atomic64_add(i, v);
 }
 
+/**
+ * atomic64_add_return() - atomic add with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
@@ -701,6 +1688,17 @@ atomic64_add_return(s64 i, atomic64_t *v)
 	return raw_atomic64_add_return(i, v);
 }
 
+/**
+ * atomic64_add_return_acquire() - atomic add with acquire ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
@@ -708,6 +1706,17 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_add_return_acquire(i, v);
 }
 
+/**
+ * atomic64_add_return_release() - atomic add with release ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
@@ -716,6 +1725,17 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 	return raw_atomic64_add_return_release(i, v);
 }
 
+/**
+ * atomic64_add_return_relaxed() - atomic add with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
@@ -723,6 +1743,17 @@ atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_add_return_relaxed(i, v);
 }
 
+/**
+ * atomic64_fetch_add() - atomic add with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_add() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -731,6 +1762,17 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_add(i, v);
 }
 
+/**
+ * atomic64_fetch_add_acquire() - atomic add with acquire ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_add_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
@@ -738,6 +1780,17 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_add_acquire(i, v);
 }
 
+/**
+ * atomic64_fetch_add_release() - atomic add with release ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_add_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
@@ -746,6 +1799,17 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_add_release(i, v);
 }
 
+/**
+ * atomic64_fetch_add_relaxed() - atomic add with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_add_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
@@ -753,6 +1817,17 @@ atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_add_relaxed(i, v);
 }
 
+/**
+ * atomic64_sub() - atomic subtract with relaxed ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_sub() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
@@ -760,6 +1835,17 @@ atomic64_sub(s64 i, atomic64_t *v)
 	raw_atomic64_sub(i, v);
 }
 
+/**
+ * atomic64_sub_return() - atomic subtract with full ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_sub_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
@@ -768,6 +1854,17 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 	return raw_atomic64_sub_return(i, v);
 }
 
+/**
+ * atomic64_sub_return_acquire() - atomic subtract with acquire ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_sub_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
@@ -775,6 +1872,17 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_sub_return_acquire(i, v);
 }
 
+/**
+ * atomic64_sub_return_release() - atomic subtract with release ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_sub_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
@@ -783,6 +1891,17 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 	return raw_atomic64_sub_return_release(i, v);
 }
 
+/**
+ * atomic64_sub_return_relaxed() - atomic subtract with relaxed ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_sub_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
@@ -790,6 +1909,17 @@ atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_sub_return_relaxed(i, v);
 }
 
+/**
+ * atomic64_fetch_sub() - atomic subtract with full ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_sub() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
@@ -798,6 +1928,17 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_sub(i, v);
 }
 
+/**
+ * atomic64_fetch_sub_acquire() - atomic subtract with acquire ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_sub_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
@@ -805,6 +1946,17 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_sub_acquire(i, v);
 }
 
+/**
+ * atomic64_fetch_sub_release() - atomic subtract with release ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_sub_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
@@ -813,6 +1965,17 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_sub_release(i, v);
 }
 
+/**
+ * atomic64_fetch_sub_relaxed() - atomic subtract with relaxed ordering
+ * @i: s64 value to subtract
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_sub_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
@@ -820,6 +1983,16 @@ atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_sub_relaxed(i, v);
 }
 
+/**
+ * atomic64_inc() - atomic increment with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
@@ -827,6 +2000,16 @@ atomic64_inc(atomic64_t *v)
 	raw_atomic64_inc(v);
 }
 
+/**
+ * atomic64_inc_return() - atomic increment with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
@@ -835,6 +2018,16 @@ atomic64_inc_return(atomic64_t *v)
 	return raw_atomic64_inc_return(v);
 }
 
+/**
+ * atomic64_inc_return_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
@@ -842,6 +2035,16 @@ atomic64_inc_return_acquire(atomic64_t *v)
 	return raw_atomic64_inc_return_acquire(v);
 }
 
+/**
+ * atomic64_inc_return_release() - atomic increment with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
@@ -850,6 +2053,16 @@ atomic64_inc_return_release(atomic64_t *v)
 	return raw_atomic64_inc_return_release(v);
 }
 
+/**
+ * atomic64_inc_return_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
@@ -857,6 +2070,16 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 	return raw_atomic64_inc_return_relaxed(v);
 }
 
+/**
+ * atomic64_fetch_inc() - atomic increment with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_inc() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
@@ -865,6 +2088,16 @@ atomic64_fetch_inc(atomic64_t *v)
 	return raw_atomic64_fetch_inc(v);
 }
 
+/**
+ * atomic64_fetch_inc_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_inc_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
@@ -872,6 +2105,16 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 	return raw_atomic64_fetch_inc_acquire(v);
 }
 
+/**
+ * atomic64_fetch_inc_release() - atomic increment with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_inc_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
@@ -880,6 +2123,16 @@ atomic64_fetch_inc_release(atomic64_t *v)
 	return raw_atomic64_fetch_inc_release(v);
 }
 
+/**
+ * atomic64_fetch_inc_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_inc_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
@@ -887,6 +2140,16 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 	return raw_atomic64_fetch_inc_relaxed(v);
 }
 
+/**
+ * atomic64_dec() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
@@ -894,6 +2157,16 @@ atomic64_dec(atomic64_t *v)
 	raw_atomic64_dec(v);
 }
 
+/**
+ * atomic64_dec_return() - atomic decrement with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
@@ -902,6 +2175,16 @@ atomic64_dec_return(atomic64_t *v)
 	return raw_atomic64_dec_return(v);
 }
 
+/**
+ * atomic64_dec_return_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
@@ -909,6 +2192,16 @@ atomic64_dec_return_acquire(atomic64_t *v)
 	return raw_atomic64_dec_return_acquire(v);
 }
 
+/**
+ * atomic64_dec_return_release() - atomic decrement with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
@@ -917,6 +2210,16 @@ atomic64_dec_return_release(atomic64_t *v)
 	return raw_atomic64_dec_return_release(v);
 }
 
+/**
+ * atomic64_dec_return_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
@@ -924,6 +2227,16 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 	return raw_atomic64_dec_return_relaxed(v);
 }
 
+/**
+ * atomic64_fetch_dec() - atomic decrement with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_dec() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
@@ -932,6 +2245,16 @@ atomic64_fetch_dec(atomic64_t *v)
 	return raw_atomic64_fetch_dec(v);
 }
 
+/**
+ * atomic64_fetch_dec_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_dec_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
@@ -939,6 +2262,16 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 	return raw_atomic64_fetch_dec_acquire(v);
 }
 
+/**
+ * atomic64_fetch_dec_release() - atomic decrement with release ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_dec_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
@@ -947,6 +2280,16 @@ atomic64_fetch_dec_release(atomic64_t *v)
 	return raw_atomic64_fetch_dec_release(v);
 }
 
+/**
+ * atomic64_fetch_dec_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_dec_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
@@ -954,6 +2297,17 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 	return raw_atomic64_fetch_dec_relaxed(v);
 }
 
+/**
+ * atomic64_and() - atomic bitwise AND with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_and() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
@@ -961,6 +2315,17 @@ atomic64_and(s64 i, atomic64_t *v)
 	raw_atomic64_and(i, v);
 }
 
+/**
+ * atomic64_fetch_and() - atomic bitwise AND with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_and() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
@@ -969,6 +2334,17 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_and(i, v);
 }
 
+/**
+ * atomic64_fetch_and_acquire() - atomic bitwise AND with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_and_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
@@ -976,6 +2352,17 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_and_acquire(i, v);
 }
 
+/**
+ * atomic64_fetch_and_release() - atomic bitwise AND with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_and_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
@@ -984,6 +2371,17 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_and_release(i, v);
 }
 
+/**
+ * atomic64_fetch_and_relaxed() - atomic bitwise AND with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_and_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
@@ -991,6 +2389,17 @@ atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_and_relaxed(i, v);
 }
 
+/**
+ * atomic64_andnot() - atomic bitwise AND NOT with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_andnot() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
@@ -998,6 +2407,17 @@ atomic64_andnot(s64 i, atomic64_t *v)
 	raw_atomic64_andnot(i, v);
 }
 
+/**
+ * atomic64_fetch_andnot() - atomic bitwise AND NOT with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_andnot() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
@@ -1006,6 +2426,17 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_andnot(i, v);
 }
 
+/**
+ * atomic64_fetch_andnot_acquire() - atomic bitwise AND NOT with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_andnot_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
@@ -1013,6 +2444,17 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_andnot_acquire(i, v);
 }
 
+/**
+ * atomic64_fetch_andnot_release() - atomic bitwise AND NOT with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_andnot_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
@@ -1021,6 +2463,17 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_andnot_release(i, v);
 }
 
+/**
+ * atomic64_fetch_andnot_relaxed() - atomic bitwise AND NOT with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_andnot_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
@@ -1028,6 +2481,17 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_andnot_relaxed(i, v);
 }
 
+/**
+ * atomic64_or() - atomic bitwise OR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_or() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
@@ -1035,6 +2499,17 @@ atomic64_or(s64 i, atomic64_t *v)
 	raw_atomic64_or(i, v);
 }
 
+/**
+ * atomic64_fetch_or() - atomic bitwise OR with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_or() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
@@ -1043,6 +2518,17 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_or(i, v);
 }
 
+/**
+ * atomic64_fetch_or_acquire() - atomic bitwise OR with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_or_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
@@ -1050,6 +2536,17 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_or_acquire(i, v);
 }
 
+/**
+ * atomic64_fetch_or_release() - atomic bitwise OR with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_or_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
@@ -1058,6 +2555,17 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_or_release(i, v);
 }
 
+/**
+ * atomic64_fetch_or_relaxed() - atomic bitwise OR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_or_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
@@ -1065,6 +2573,17 @@ atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_or_relaxed(i, v);
 }
 
+/**
+ * atomic64_xor() - atomic bitwise XOR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_xor() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -1072,6 +2591,17 @@ atomic64_xor(s64 i, atomic64_t *v)
 	raw_atomic64_xor(i, v);
 }
 
+/**
+ * atomic64_fetch_xor() - atomic bitwise XOR with full ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_xor() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
@@ -1080,6 +2610,17 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_xor(i, v);
 }
 
+/**
+ * atomic64_fetch_xor_acquire() - atomic bitwise XOR with acquire ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_xor_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
@@ -1087,6 +2628,17 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_xor_acquire(i, v);
 }
 
+/**
+ * atomic64_fetch_xor_release() - atomic bitwise XOR with release ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_xor_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
@@ -1095,6 +2647,17 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_xor_release(i, v);
 }
 
+/**
+ * atomic64_fetch_xor_relaxed() - atomic bitwise XOR with relaxed ordering
+ * @i: s64 value
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_xor_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
@@ -1102,6 +2665,17 @@ atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_fetch_xor_relaxed(i, v);
 }
 
+/**
+ * atomic64_xchg() - atomic exchange with full ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_xchg() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 new)
 {
@@ -1110,6 +2684,17 @@ atomic64_xchg(atomic64_t *v, s64 new)
 	return raw_atomic64_xchg(v, new);
 }
 
+/**
+ * atomic64_xchg_acquire() - atomic exchange with acquire ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_xchg_acquire() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 new)
 {
@@ -1117,6 +2702,17 @@ atomic64_xchg_acquire(atomic64_t *v, s64 new)
 	return raw_atomic64_xchg_acquire(v, new);
 }
 
+/**
+ * atomic64_xchg_release() - atomic exchange with release ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_xchg_release() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 new)
 {
@@ -1125,6 +2721,17 @@ atomic64_xchg_release(atomic64_t *v, s64 new)
 	return raw_atomic64_xchg_release(v, new);
 }
 
+/**
+ * atomic64_xchg_relaxed() - atomic exchange with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @new: s64 value to assign
+ *
+ * Atomically updates @v to @new with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_xchg_relaxed() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 {
@@ -1132,6 +2739,18 @@ atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 	return raw_atomic64_xchg_relaxed(v, new);
 }
 
+/**
+ * atomic64_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
@@ -1140,6 +2759,18 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 	return raw_atomic64_cmpxchg(v, old, new);
 }
 
+/**
+ * atomic64_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_acquire() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
@@ -1147,6 +2778,18 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 	return raw_atomic64_cmpxchg_acquire(v, old, new);
 }
 
+/**
+ * atomic64_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_release() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
@@ -1155,6 +2798,18 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 	return raw_atomic64_cmpxchg_release(v, old, new);
 }
 
+/**
+ * atomic64_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @old: s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_relaxed() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
@@ -1162,6 +2817,19 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 	return raw_atomic64_cmpxchg_relaxed(v, old, new);
 }
 
+/**
+ * atomic64_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1171,6 +2839,19 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 	return raw_atomic64_try_cmpxchg(v, old, new);
 }
 
+/**
+ * atomic64_try_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_acquire() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1179,6 +2860,19 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 	return raw_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
+/**
+ * atomic64_try_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_release() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1188,6 +2882,19 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 	return raw_atomic64_try_cmpxchg_release(v, old, new);
 }
 
+/**
+ * atomic64_try_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic64_t
+ * @old: pointer to s64 value to compare with
+ * @new: s64 value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_relaxed() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1196,6 +2903,17 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 	return raw_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
+/**
+ * atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_sub_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
@@ -1204,6 +2922,16 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
 	return raw_atomic64_sub_and_test(i, v);
 }
 
+/**
+ * atomic64_dec_and_test() - atomic decrement and test if zero with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
@@ -1212,6 +2940,16 @@ atomic64_dec_and_test(atomic64_t *v)
 	return raw_atomic64_dec_and_test(v);
 }
 
+/**
+ * atomic64_inc_and_test() - atomic increment and test if zero with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
@@ -1220,6 +2958,17 @@ atomic64_inc_and_test(atomic64_t *v)
 	return raw_atomic64_inc_and_test(v);
 }
 
+/**
+ * atomic64_add_negative() - atomic add and test if negative with full ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_negative() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
@@ -1228,6 +2977,17 @@ atomic64_add_negative(s64 i, atomic64_t *v)
 	return raw_atomic64_add_negative(i, v);
 }
 
+/**
+ * atomic64_add_negative_acquire() - atomic add and test if negative with acquire ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_negative_acquire() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
@@ -1235,6 +2995,17 @@ atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 	return raw_atomic64_add_negative_acquire(i, v);
 }
 
+/**
+ * atomic64_add_negative_release() - atomic add and test if negative with release ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_negative_release() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
@@ -1243,6 +3014,17 @@ atomic64_add_negative_release(s64 i, atomic64_t *v)
 	return raw_atomic64_add_negative_release(i, v);
 }
 
+/**
+ * atomic64_add_negative_relaxed() - atomic add and test if negative with relaxed ordering
+ * @i: s64 value to add
+ * @v: pointer to atomic64_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_negative_relaxed() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
@@ -1250,6 +3032,18 @@ atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 	return raw_atomic64_add_negative_relaxed(i, v);
 }
 
+/**
+ * atomic64_fetch_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic64_t
+ * @a: s64 value to add
+ * @u: s64 value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_fetch_add_unless() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -1258,6 +3052,18 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 	return raw_atomic64_fetch_add_unless(v, a, u);
 }
 
+/**
+ * atomic64_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic64_t
+ * @a: s64 value to add
+ * @u: s64 value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_add_unless() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -1266,6 +3072,16 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 	return raw_atomic64_add_unless(v, a, u);
 }
 
+/**
+ * atomic64_inc_not_zero() - atomic increment unless zero with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_not_zero() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -1274,6 +3090,16 @@ atomic64_inc_not_zero(atomic64_t *v)
 	return raw_atomic64_inc_not_zero(v);
 }
 
+/**
+ * atomic64_inc_unless_negative() - atomic increment unless negative with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_inc_unless_negative() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
@@ -1282,6 +3108,16 @@ atomic64_inc_unless_negative(atomic64_t *v)
 	return raw_atomic64_inc_unless_negative(v);
 }
 
+/**
+ * atomic64_dec_unless_positive() - atomic decrement unless positive with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_unless_positive() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
@@ -1290,6 +3126,16 @@ atomic64_dec_unless_positive(atomic64_t *v)
 	return raw_atomic64_dec_unless_positive(v);
 }
 
+/**
+ * atomic64_dec_if_positive() - atomic decrement if positive with full ordering
+ * @v: pointer to atomic64_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic64_dec_if_positive() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
@@ -1298,6 +3144,16 @@ atomic64_dec_if_positive(atomic64_t *v)
 	return raw_atomic64_dec_if_positive(v);
 }
 
+/**
+ * atomic_long_read() - atomic load with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically loads the value of @v with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_read() there.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
@@ -1305,6 +3161,16 @@ atomic_long_read(const atomic_long_t *v)
 	return raw_atomic_long_read(v);
 }
 
+/**
+ * atomic_long_read_acquire() - atomic load with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically loads the value of @v with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_read_acquire() there.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline long
 atomic_long_read_acquire(const atomic_long_t *v)
 {
@@ -1312,6 +3178,17 @@ atomic_long_read_acquire(const atomic_long_t *v)
 	return raw_atomic_long_read_acquire(v);
 }
 
+/**
+ * atomic_long_set() - atomic set with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @i: long value to assign
+ *
+ * Atomically sets @v to @i with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_set() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_set(atomic_long_t *v, long i)
 {
@@ -1319,6 +3196,17 @@ atomic_long_set(atomic_long_t *v, long i)
 	raw_atomic_long_set(v, i);
 }
 
+/**
+ * atomic_long_set_release() - atomic set with release ordering
+ * @v: pointer to atomic_long_t
+ * @i: long value to assign
+ *
+ * Atomically sets @v to @i with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_set_release() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_set_release(atomic_long_t *v, long i)
 {
@@ -1327,6 +3215,17 @@ atomic_long_set_release(atomic_long_t *v, long i)
 	raw_atomic_long_set_release(v, i);
 }
 
+/**
+ * atomic_long_add() - atomic add with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_add(long i, atomic_long_t *v)
 {
@@ -1334,6 +3233,17 @@ atomic_long_add(long i, atomic_long_t *v)
 	raw_atomic_long_add(i, v);
 }
 
+/**
+ * atomic_long_add_return() - atomic add with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_add_return(long i, atomic_long_t *v)
 {
@@ -1342,6 +3252,17 @@ atomic_long_add_return(long i, atomic_long_t *v)
 	return raw_atomic_long_add_return(i, v);
 }
 
+/**
+ * atomic_long_add_return_acquire() - atomic add with acquire ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
@@ -1349,6 +3270,17 @@ atomic_long_add_return_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_add_return_acquire(i, v);
 }
 
+/**
+ * atomic_long_add_return_release() - atomic add with release ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_add_return_release(long i, atomic_long_t *v)
 {
@@ -1357,6 +3289,17 @@ atomic_long_add_return_release(long i, atomic_long_t *v)
 	return raw_atomic_long_add_return_release(i, v);
 }
 
+/**
+ * atomic_long_add_return_relaxed() - atomic add with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
@@ -1364,6 +3307,17 @@ atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_add_return_relaxed(i, v);
 }
 
+/**
+ * atomic_long_fetch_add() - atomic add with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_add(long i, atomic_long_t *v)
 {
@@ -1372,6 +3326,17 @@ atomic_long_fetch_add(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_add(i, v);
 }
 
+/**
+ * atomic_long_fetch_add_acquire() - atomic add with acquire ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
@@ -1379,6 +3344,17 @@ atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_add_acquire(i, v);
 }
 
+/**
+ * atomic_long_fetch_add_release() - atomic add with release ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
@@ -1387,6 +3363,17 @@ atomic_long_fetch_add_release(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_add_release(i, v);
 }
 
+/**
+ * atomic_long_fetch_add_relaxed() - atomic add with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
@@ -1394,6 +3381,17 @@ atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_add_relaxed(i, v);
 }
 
+/**
+ * atomic_long_sub() - atomic subtract with relaxed ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_sub() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_sub(long i, atomic_long_t *v)
 {
@@ -1401,6 +3399,17 @@ atomic_long_sub(long i, atomic_long_t *v)
 	raw_atomic_long_sub(i, v);
 }
 
+/**
+ * atomic_long_sub_return() - atomic subtract with full ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_sub_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_sub_return(long i, atomic_long_t *v)
 {
@@ -1409,6 +3418,17 @@ atomic_long_sub_return(long i, atomic_long_t *v)
 	return raw_atomic_long_sub_return(i, v);
 }
 
+/**
+ * atomic_long_sub_return_acquire() - atomic subtract with acquire ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_sub_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
@@ -1416,6 +3436,17 @@ atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_sub_return_acquire(i, v);
 }
 
+/**
+ * atomic_long_sub_return_release() - atomic subtract with release ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_sub_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
@@ -1424,6 +3455,17 @@ atomic_long_sub_return_release(long i, atomic_long_t *v)
 	return raw_atomic_long_sub_return_release(i, v);
 }
 
+/**
+ * atomic_long_sub_return_relaxed() - atomic subtract with relaxed ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_sub_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
@@ -1431,6 +3473,17 @@ atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_sub_return_relaxed(i, v);
 }
 
+/**
+ * atomic_long_fetch_sub() - atomic subtract with full ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_sub() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
@@ -1439,6 +3492,17 @@ atomic_long_fetch_sub(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_sub(i, v);
 }
 
+/**
+ * atomic_long_fetch_sub_acquire() - atomic subtract with acquire ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_sub_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
@@ -1446,6 +3510,17 @@ atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_sub_acquire(i, v);
 }
 
+/**
+ * atomic_long_fetch_sub_release() - atomic subtract with release ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_sub_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
@@ -1454,6 +3529,17 @@ atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_sub_release(i, v);
 }
 
+/**
+ * atomic_long_fetch_sub_relaxed() - atomic subtract with relaxed ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_sub_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
@@ -1461,6 +3547,16 @@ atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_sub_relaxed(i, v);
 }
 
+/**
+ * atomic_long_inc() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_inc(atomic_long_t *v)
 {
@@ -1468,6 +3564,16 @@ atomic_long_inc(atomic_long_t *v)
 	raw_atomic_long_inc(v);
 }
 
+/**
+ * atomic_long_inc_return() - atomic increment with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_inc_return(atomic_long_t *v)
 {
@@ -1476,6 +3582,16 @@ atomic_long_inc_return(atomic_long_t *v)
 	return raw_atomic_long_inc_return(v);
 }
 
+/**
+ * atomic_long_inc_return_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_inc_return_acquire(atomic_long_t *v)
 {
@@ -1483,6 +3599,16 @@ atomic_long_inc_return_acquire(atomic_long_t *v)
 	return raw_atomic_long_inc_return_acquire(v);
 }
 
+/**
+ * atomic_long_inc_return_release() - atomic increment with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_inc_return_release(atomic_long_t *v)
 {
@@ -1491,6 +3617,16 @@ atomic_long_inc_return_release(atomic_long_t *v)
 	return raw_atomic_long_inc_return_release(v);
 }
 
+/**
+ * atomic_long_inc_return_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
@@ -1498,6 +3634,16 @@ atomic_long_inc_return_relaxed(atomic_long_t *v)
 	return raw_atomic_long_inc_return_relaxed(v);
 }
 
+/**
+ * atomic_long_fetch_inc() - atomic increment with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_inc() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_inc(atomic_long_t *v)
 {
@@ -1506,6 +3652,16 @@ atomic_long_fetch_inc(atomic_long_t *v)
 	return raw_atomic_long_fetch_inc(v);
 }
 
+/**
+ * atomic_long_fetch_inc_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_inc_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
@@ -1513,6 +3669,16 @@ atomic_long_fetch_inc_acquire(atomic_long_t *v)
 	return raw_atomic_long_fetch_inc_acquire(v);
 }
 
+/**
+ * atomic_long_fetch_inc_release() - atomic increment with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_inc_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_inc_release(atomic_long_t *v)
 {
@@ -1521,6 +3687,16 @@ atomic_long_fetch_inc_release(atomic_long_t *v)
 	return raw_atomic_long_fetch_inc_release(v);
 }
 
+/**
+ * atomic_long_fetch_inc_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_inc_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
@@ -1528,6 +3704,16 @@ atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 	return raw_atomic_long_fetch_inc_relaxed(v);
 }
 
+/**
+ * atomic_long_dec() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_dec(atomic_long_t *v)
 {
@@ -1535,6 +3721,16 @@ atomic_long_dec(atomic_long_t *v)
 	raw_atomic_long_dec(v);
 }
 
+/**
+ * atomic_long_dec_return() - atomic decrement with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_return() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_dec_return(atomic_long_t *v)
 {
@@ -1543,6 +3739,16 @@ atomic_long_dec_return(atomic_long_t *v)
 	return raw_atomic_long_dec_return(v);
 }
 
+/**
+ * atomic_long_dec_return_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_return_acquire() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_dec_return_acquire(atomic_long_t *v)
 {
@@ -1550,6 +3756,16 @@ atomic_long_dec_return_acquire(atomic_long_t *v)
 	return raw_atomic_long_dec_return_acquire(v);
 }
 
+/**
+ * atomic_long_dec_return_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_return_release() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_dec_return_release(atomic_long_t *v)
 {
@@ -1558,6 +3774,16 @@ atomic_long_dec_return_release(atomic_long_t *v)
 	return raw_atomic_long_dec_return_release(v);
 }
 
+/**
+ * atomic_long_dec_return_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_return_relaxed() there.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
@@ -1565,6 +3791,16 @@ atomic_long_dec_return_relaxed(atomic_long_t *v)
 	return raw_atomic_long_dec_return_relaxed(v);
 }
 
+/**
+ * atomic_long_fetch_dec() - atomic decrement with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_dec() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_dec(atomic_long_t *v)
 {
@@ -1573,6 +3809,16 @@ atomic_long_fetch_dec(atomic_long_t *v)
 	return raw_atomic_long_fetch_dec(v);
 }
 
+/**
+ * atomic_long_fetch_dec_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_dec_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
@@ -1580,6 +3826,16 @@ atomic_long_fetch_dec_acquire(atomic_long_t *v)
 	return raw_atomic_long_fetch_dec_acquire(v);
 }
 
+/**
+ * atomic_long_fetch_dec_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_dec_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_dec_release(atomic_long_t *v)
 {
@@ -1588,6 +3844,16 @@ atomic_long_fetch_dec_release(atomic_long_t *v)
 	return raw_atomic_long_fetch_dec_release(v);
 }
 
+/**
+ * atomic_long_fetch_dec_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_dec_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
@@ -1595,6 +3861,17 @@ atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 	return raw_atomic_long_fetch_dec_relaxed(v);
 }
 
+/**
+ * atomic_long_and() - atomic bitwise AND with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_and() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_and(long i, atomic_long_t *v)
 {
@@ -1602,6 +3879,17 @@ atomic_long_and(long i, atomic_long_t *v)
 	raw_atomic_long_and(i, v);
 }
 
+/**
+ * atomic_long_fetch_and() - atomic bitwise AND with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_and() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_and(long i, atomic_long_t *v)
 {
@@ -1610,6 +3898,17 @@ atomic_long_fetch_and(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_and(i, v);
 }
 
+/**
+ * atomic_long_fetch_and_acquire() - atomic bitwise AND with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_and_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
@@ -1617,6 +3916,17 @@ atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_and_acquire(i, v);
 }
 
+/**
+ * atomic_long_fetch_and_release() - atomic bitwise AND with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_and_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
@@ -1625,6 +3935,17 @@ atomic_long_fetch_and_release(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_and_release(i, v);
 }
 
+/**
+ * atomic_long_fetch_and_relaxed() - atomic bitwise AND with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_and_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
@@ -1632,6 +3953,17 @@ atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_and_relaxed(i, v);
 }
 
+/**
+ * atomic_long_andnot() - atomic bitwise AND NOT with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_andnot() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_andnot(long i, atomic_long_t *v)
 {
@@ -1639,6 +3971,17 @@ atomic_long_andnot(long i, atomic_long_t *v)
 	raw_atomic_long_andnot(i, v);
 }
 
+/**
+ * atomic_long_fetch_andnot() - atomic bitwise AND NOT with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_andnot() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
@@ -1647,6 +3990,17 @@ atomic_long_fetch_andnot(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_andnot(i, v);
 }
 
+/**
+ * atomic_long_fetch_andnot_acquire() - atomic bitwise AND NOT with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_andnot_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
@@ -1654,6 +4008,17 @@ atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_andnot_acquire(i, v);
 }
 
+/**
+ * atomic_long_fetch_andnot_release() - atomic bitwise AND NOT with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_andnot_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
@@ -1662,6 +4027,17 @@ atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_andnot_release(i, v);
 }
 
+/**
+ * atomic_long_fetch_andnot_relaxed() - atomic bitwise AND NOT with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_andnot_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
@@ -1669,6 +4045,17 @@ atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_andnot_relaxed(i, v);
 }
 
+/**
+ * atomic_long_or() - atomic bitwise OR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_or() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_or(long i, atomic_long_t *v)
 {
@@ -1676,6 +4063,17 @@ atomic_long_or(long i, atomic_long_t *v)
 	raw_atomic_long_or(i, v);
 }
 
+/**
+ * atomic_long_fetch_or() - atomic bitwise OR with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_or() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_or(long i, atomic_long_t *v)
 {
@@ -1684,6 +4082,17 @@ atomic_long_fetch_or(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_or(i, v);
 }
 
+/**
+ * atomic_long_fetch_or_acquire() - atomic bitwise OR with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_or_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
@@ -1691,6 +4100,17 @@ atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_or_acquire(i, v);
 }
 
+/**
+ * atomic_long_fetch_or_release() - atomic bitwise OR with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_or_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
@@ -1699,6 +4119,17 @@ atomic_long_fetch_or_release(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_or_release(i, v);
 }
 
+/**
+ * atomic_long_fetch_or_relaxed() - atomic bitwise OR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_or_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
@@ -1706,6 +4137,17 @@ atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_or_relaxed(i, v);
 }
 
+/**
+ * atomic_long_xor() - atomic bitwise XOR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_xor() there.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 atomic_long_xor(long i, atomic_long_t *v)
 {
@@ -1713,6 +4155,17 @@ atomic_long_xor(long i, atomic_long_t *v)
 	raw_atomic_long_xor(i, v);
 }
 
+/**
+ * atomic_long_fetch_xor() - atomic bitwise XOR with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_xor() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
@@ -1721,6 +4174,17 @@ atomic_long_fetch_xor(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_xor(i, v);
 }
 
+/**
+ * atomic_long_fetch_xor_acquire() - atomic bitwise XOR with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_xor_acquire() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
@@ -1728,6 +4192,17 @@ atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_xor_acquire(i, v);
 }
 
+/**
+ * atomic_long_fetch_xor_release() - atomic bitwise XOR with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_xor_release() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
@@ -1736,6 +4211,17 @@ atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_xor_release(i, v);
 }
 
+/**
+ * atomic_long_fetch_xor_relaxed() - atomic bitwise XOR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_xor_relaxed() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
@@ -1743,6 +4229,17 @@ atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_fetch_xor_relaxed(i, v);
 }
 
+/**
+ * atomic_long_xchg() - atomic exchange with full ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_xchg() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_xchg(atomic_long_t *v, long new)
 {
@@ -1751,6 +4248,17 @@ atomic_long_xchg(atomic_long_t *v, long new)
 	return raw_atomic_long_xchg(v, new);
 }
 
+/**
+ * atomic_long_xchg_acquire() - atomic exchange with acquire ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_xchg_acquire() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_xchg_acquire(atomic_long_t *v, long new)
 {
@@ -1758,6 +4266,17 @@ atomic_long_xchg_acquire(atomic_long_t *v, long new)
 	return raw_atomic_long_xchg_acquire(v, new);
 }
 
+/**
+ * atomic_long_xchg_release() - atomic exchange with release ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_xchg_release() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_xchg_release(atomic_long_t *v, long new)
 {
@@ -1766,6 +4285,17 @@ atomic_long_xchg_release(atomic_long_t *v, long new)
 	return raw_atomic_long_xchg_release(v, new);
 }
 
+/**
+ * atomic_long_xchg_relaxed() - atomic exchange with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_xchg_relaxed() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_xchg_relaxed(atomic_long_t *v, long new)
 {
@@ -1773,6 +4303,18 @@ atomic_long_xchg_relaxed(atomic_long_t *v, long new)
 	return raw_atomic_long_xchg_relaxed(v, new);
 }
 
+/**
+ * atomic_long_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
@@ -1781,6 +4323,18 @@ atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 	return raw_atomic_long_cmpxchg(v, old, new);
 }
 
+/**
+ * atomic_long_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_acquire() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
@@ -1788,6 +4342,18 @@ atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 	return raw_atomic_long_cmpxchg_acquire(v, old, new);
 }
 
+/**
+ * atomic_long_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_release() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
@@ -1796,6 +4362,18 @@ atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 	return raw_atomic_long_cmpxchg_release(v, old, new);
 }
 
+/**
+ * atomic_long_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_relaxed() there.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
@@ -1803,6 +4381,19 @@ atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 	return raw_atomic_long_cmpxchg_relaxed(v, old, new);
 }
 
+/**
+ * atomic_long_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
@@ -1812,6 +4403,19 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 	return raw_atomic_long_try_cmpxchg(v, old, new);
 }
 
+/**
+ * atomic_long_try_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_acquire() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
@@ -1820,6 +4424,19 @@ atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 	return raw_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
+/**
+ * atomic_long_try_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_release() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
@@ -1829,6 +4446,19 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 	return raw_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
+/**
+ * atomic_long_try_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_relaxed() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
@@ -1837,6 +4467,17 @@ atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 	return raw_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 
+/**
+ * atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_sub_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
@@ -1845,6 +4486,16 @@ atomic_long_sub_and_test(long i, atomic_long_t *v)
 	return raw_atomic_long_sub_and_test(i, v);
 }
 
+/**
+ * atomic_long_dec_and_test() - atomic decrement and test if zero with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_dec_and_test(atomic_long_t *v)
 {
@@ -1853,6 +4504,16 @@ atomic_long_dec_and_test(atomic_long_t *v)
 	return raw_atomic_long_dec_and_test(v);
 }
 
+/**
+ * atomic_long_inc_and_test() - atomic increment and test if zero with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_and_test() there.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_inc_and_test(atomic_long_t *v)
 {
@@ -1861,6 +4522,17 @@ atomic_long_inc_and_test(atomic_long_t *v)
 	return raw_atomic_long_inc_and_test(v);
 }
 
+/**
+ * atomic_long_add_negative() - atomic add and test if negative with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_negative() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_add_negative(long i, atomic_long_t *v)
 {
@@ -1869,6 +4541,17 @@ atomic_long_add_negative(long i, atomic_long_t *v)
 	return raw_atomic_long_add_negative(i, v);
 }
 
+/**
+ * atomic_long_add_negative_acquire() - atomic add and test if negative with acquire ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_negative_acquire() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
@@ -1876,6 +4559,17 @@ atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 	return raw_atomic_long_add_negative_acquire(i, v);
 }
 
+/**
+ * atomic_long_add_negative_release() - atomic add and test if negative with release ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_negative_release() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
@@ -1884,6 +4578,17 @@ atomic_long_add_negative_release(long i, atomic_long_t *v)
 	return raw_atomic_long_add_negative_release(i, v);
 }
 
+/**
+ * atomic_long_add_negative_relaxed() - atomic add and test if negative with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_negative_relaxed() there.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
@@ -1891,6 +4596,18 @@ atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 	return raw_atomic_long_add_negative_relaxed(i, v);
 }
 
+/**
+ * atomic_long_fetch_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_long_t
+ * @a: long value to add
+ * @u: long value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add_unless() there.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
@@ -1899,6 +4616,18 @@ atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 	return raw_atomic_long_fetch_add_unless(v, a, u);
 }
 
+/**
+ * atomic_long_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_long_t
+ * @a: long value to add
+ * @u: long value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_add_unless() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
@@ -1907,6 +4636,16 @@ atomic_long_add_unless(atomic_long_t *v, long a, long u)
 	return raw_atomic_long_add_unless(v, a, u);
 }
 
+/**
+ * atomic_long_inc_not_zero() - atomic increment unless zero with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_not_zero() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_inc_not_zero(atomic_long_t *v)
 {
@@ -1915,6 +4654,16 @@ atomic_long_inc_not_zero(atomic_long_t *v)
 	return raw_atomic_long_inc_not_zero(v);
 }
 
+/**
+ * atomic_long_inc_unless_negative() - atomic increment unless negative with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_inc_unless_negative() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_inc_unless_negative(atomic_long_t *v)
 {
@@ -1923,6 +4672,16 @@ atomic_long_inc_unless_negative(atomic_long_t *v)
 	return raw_atomic_long_inc_unless_negative(v);
 }
 
+/**
+ * atomic_long_dec_unless_positive() - atomic decrement unless positive with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_unless_positive() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 atomic_long_dec_unless_positive(atomic_long_t *v)
 {
@@ -1931,6 +4690,16 @@ atomic_long_dec_unless_positive(atomic_long_t *v)
 	return raw_atomic_long_dec_unless_positive(v);
 }
 
+/**
+ * atomic_long_dec_if_positive() - atomic decrement if positive with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_long_dec_if_positive() there.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline long
 atomic_long_dec_if_positive(atomic_long_t *v)
 {
@@ -2231,4 +5000,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// a4c3d2b229f907654cc53cb5d40e80f7fed1ec9c
+// 92b07cc6336f94f5511e9e16f184d28f9d97be95
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index f564f71ff8afc..c1dc7a6a0f85f 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -21,6 +21,16 @@ typedef atomic_t atomic_long_t;
 #define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
 #endif
 
+/**
+ * raw_atomic_long_read() - atomic load with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically loads the value of @v with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_read() elsewhere.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline long
 raw_atomic_long_read(const atomic_long_t *v)
 {
@@ -31,6 +41,16 @@ raw_atomic_long_read(const atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_read_acquire() - atomic load with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically loads the value of @v with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_read_acquire() elsewhere.
+ *
+ * Return: the value loaded from @v
+ */
 static __always_inline long
 raw_atomic_long_read_acquire(const atomic_long_t *v)
 {
@@ -41,6 +61,17 @@ raw_atomic_long_read_acquire(const atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_set() - atomic set with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @i: long value to assign
+ *
+ * Atomically sets @v to @i with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_set() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_set(atomic_long_t *v, long i)
 {
@@ -51,6 +82,17 @@ raw_atomic_long_set(atomic_long_t *v, long i)
 #endif
 }
 
+/**
+ * raw_atomic_long_set_release() - atomic set with release ordering
+ * @v: pointer to atomic_long_t
+ * @i: long value to assign
+ *
+ * Atomically sets @v to @i with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_set_release() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_set_release(atomic_long_t *v, long i)
 {
@@ -61,6 +103,17 @@ raw_atomic_long_set_release(atomic_long_t *v, long i)
 #endif
 }
 
+/**
+ * raw_atomic_long_add() - atomic add with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_add(long i, atomic_long_t *v)
 {
@@ -71,6 +124,17 @@ raw_atomic_long_add(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_return() - atomic add with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_add_return(long i, atomic_long_t *v)
 {
@@ -81,6 +145,17 @@ raw_atomic_long_add_return(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_return_acquire() - atomic add with acquire ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
@@ -91,6 +166,17 @@ raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_return_release() - atomic add with release ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_add_return_release(long i, atomic_long_t *v)
 {
@@ -101,6 +187,17 @@ raw_atomic_long_add_return_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_return_relaxed() - atomic add with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
@@ -111,6 +208,17 @@ raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_add() - atomic add with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_add() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_add(long i, atomic_long_t *v)
 {
@@ -121,6 +229,17 @@ raw_atomic_long_fetch_add(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_add_acquire() - atomic add with acquire ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_add_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
@@ -131,6 +250,17 @@ raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_add_release() - atomic add with release ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_add_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
@@ -141,6 +271,17 @@ raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_add_relaxed() - atomic add with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_add_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
@@ -151,6 +292,17 @@ raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_sub() - atomic subtract with relaxed ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_sub() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_sub(long i, atomic_long_t *v)
 {
@@ -161,6 +313,17 @@ raw_atomic_long_sub(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_sub_return() - atomic subtract with full ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_sub_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_sub_return(long i, atomic_long_t *v)
 {
@@ -171,6 +334,17 @@ raw_atomic_long_sub_return(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_sub_return_acquire() - atomic subtract with acquire ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_sub_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
@@ -181,6 +355,17 @@ raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_sub_return_release() - atomic subtract with release ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_sub_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
@@ -191,6 +376,17 @@ raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_sub_return_relaxed() - atomic subtract with relaxed ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_sub_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
@@ -201,6 +397,17 @@ raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_sub() - atomic subtract with full ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_sub() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
@@ -211,6 +418,17 @@ raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_sub_acquire() - atomic subtract with acquire ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_sub_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
@@ -221,6 +439,17 @@ raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_sub_release() - atomic subtract with release ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_sub_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
@@ -231,6 +460,17 @@ raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_sub_relaxed() - atomic subtract with relaxed ordering
+ * @i: long value to subtract
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_sub_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
@@ -241,6 +481,16 @@ raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_inc(atomic_long_t *v)
 {
@@ -251,6 +501,16 @@ raw_atomic_long_inc(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_return() - atomic increment with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_inc_return(atomic_long_t *v)
 {
@@ -261,6 +521,16 @@ raw_atomic_long_inc_return(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_return_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_inc_return_acquire(atomic_long_t *v)
 {
@@ -271,6 +541,16 @@ raw_atomic_long_inc_return_acquire(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_return_release() - atomic increment with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_inc_return_release(atomic_long_t *v)
 {
@@ -281,6 +561,16 @@ raw_atomic_long_inc_return_release(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_return_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
@@ -291,6 +581,16 @@ raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_inc() - atomic increment with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_inc() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_inc(atomic_long_t *v)
 {
@@ -301,6 +601,16 @@ raw_atomic_long_fetch_inc(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_inc_acquire() - atomic increment with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_inc_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
@@ -311,6 +621,16 @@ raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_inc_release() - atomic increment with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_inc_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_inc_release(atomic_long_t *v)
 {
@@ -321,6 +641,16 @@ raw_atomic_long_fetch_inc_release(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_inc_relaxed() - atomic increment with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_inc_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
@@ -331,6 +661,16 @@ raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_dec(atomic_long_t *v)
 {
@@ -341,6 +681,16 @@ raw_atomic_long_dec(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_return() - atomic decrement with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_return() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_dec_return(atomic_long_t *v)
 {
@@ -351,6 +701,16 @@ raw_atomic_long_dec_return(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_return_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_return_acquire() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_dec_return_acquire(atomic_long_t *v)
 {
@@ -361,6 +721,16 @@ raw_atomic_long_dec_return_acquire(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_return_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_return_release() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_dec_return_release(atomic_long_t *v)
 {
@@ -371,6 +741,16 @@ raw_atomic_long_dec_return_release(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_return_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_return_relaxed() elsewhere.
+ *
+ * Return: the new value of @v.
+ */
 static __always_inline long
 raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
@@ -381,6 +761,16 @@ raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_dec() - atomic decrement with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_dec() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_dec(atomic_long_t *v)
 {
@@ -391,6 +781,16 @@ raw_atomic_long_fetch_dec(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_dec_acquire() - atomic decrement with acquire ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_dec_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
@@ -401,6 +801,16 @@ raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_dec_release() - atomic decrement with release ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_dec_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_dec_release(atomic_long_t *v)
 {
@@ -411,6 +821,16 @@ raw_atomic_long_fetch_dec_release(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_dec_relaxed() - atomic decrement with relaxed ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_dec_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
@@ -421,6 +841,17 @@ raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_and() - atomic bitwise AND with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_and() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_and(long i, atomic_long_t *v)
 {
@@ -431,6 +862,17 @@ raw_atomic_long_and(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_and() - atomic bitwise AND with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_and() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_and(long i, atomic_long_t *v)
 {
@@ -441,6 +883,17 @@ raw_atomic_long_fetch_and(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_and_acquire() - atomic bitwise AND with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_and_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
@@ -451,6 +904,17 @@ raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_and_release() - atomic bitwise AND with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_and_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
@@ -461,6 +925,17 @@ raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_and_relaxed() - atomic bitwise AND with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_and_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
@@ -471,6 +946,17 @@ raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_andnot() - atomic bitwise AND NOT with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_andnot() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_andnot(long i, atomic_long_t *v)
 {
@@ -481,6 +967,17 @@ raw_atomic_long_andnot(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_andnot() - atomic bitwise AND NOT with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_andnot() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
@@ -491,6 +988,17 @@ raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_andnot_acquire() - atomic bitwise AND NOT with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_andnot_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
@@ -501,6 +1009,17 @@ raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_andnot_release() - atomic bitwise AND NOT with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_andnot_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
@@ -511,6 +1030,17 @@ raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_andnot_relaxed() - atomic bitwise AND NOT with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v & ~@i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_andnot_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
@@ -521,6 +1051,17 @@ raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_or() - atomic bitwise OR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_or() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_or(long i, atomic_long_t *v)
 {
@@ -531,6 +1072,17 @@ raw_atomic_long_or(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_or() - atomic bitwise OR with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_or() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_or(long i, atomic_long_t *v)
 {
@@ -541,6 +1093,17 @@ raw_atomic_long_fetch_or(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_or_acquire() - atomic bitwise OR with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_or_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
@@ -551,6 +1114,17 @@ raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_or_release() - atomic bitwise OR with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_or_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
@@ -561,6 +1135,17 @@ raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_or_relaxed() - atomic bitwise OR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v | @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_or_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
@@ -571,6 +1156,17 @@ raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_xor() - atomic bitwise XOR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_xor() elsewhere.
+ *
+ * Return: nothing.
+ */
 static __always_inline void
 raw_atomic_long_xor(long i, atomic_long_t *v)
 {
@@ -581,6 +1177,17 @@ raw_atomic_long_xor(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_xor() - atomic bitwise XOR with full ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_xor() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
@@ -591,6 +1198,17 @@ raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_xor_acquire() - atomic bitwise XOR with acquire ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_xor_acquire() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
@@ -601,6 +1219,17 @@ raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_xor_release() - atomic bitwise XOR with release ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_xor_release() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
@@ -611,6 +1240,17 @@ raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_xor_relaxed() - atomic bitwise XOR with relaxed ordering
+ * @i: long value
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v ^ @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_xor_relaxed() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
@@ -621,6 +1261,17 @@ raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_xchg() - atomic exchange with full ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_xchg() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_xchg(atomic_long_t *v, long new)
 {
@@ -631,6 +1282,17 @@ raw_atomic_long_xchg(atomic_long_t *v, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_xchg_acquire() - atomic exchange with acquire ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_xchg_acquire() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_xchg_acquire(atomic_long_t *v, long new)
 {
@@ -641,6 +1303,17 @@ raw_atomic_long_xchg_acquire(atomic_long_t *v, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_xchg_release() - atomic exchange with release ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_xchg_release() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_xchg_release(atomic_long_t *v, long new)
 {
@@ -651,6 +1324,17 @@ raw_atomic_long_xchg_release(atomic_long_t *v, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_xchg_relaxed() - atomic exchange with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @new: long value to assign
+ *
+ * Atomically updates @v to @new with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_xchg_relaxed() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_xchg_relaxed(atomic_long_t *v, long new)
 {
@@ -661,6 +1345,18 @@ raw_atomic_long_xchg_relaxed(atomic_long_t *v, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_cmpxchg() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
@@ -671,6 +1367,18 @@ raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_cmpxchg_acquire() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
@@ -681,6 +1389,18 @@ raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_cmpxchg_release() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
@@ -691,6 +1411,18 @@ raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @old: long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_cmpxchg_relaxed() elsewhere.
+ *
+ * Return: the old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
@@ -701,6 +1433,19 @@ raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
@@ -711,6 +1456,19 @@ raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_try_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_acquire() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
@@ -721,6 +1479,19 @@ raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_try_cmpxchg_release() - atomic compare and exchange with release ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_release() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
@@ -731,6 +1502,19 @@ raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_try_cmpxchg_relaxed() - atomic compare and exchange with relaxed ordering
+ * @v: pointer to atomic_long_t
+ * @old: pointer to long value to compare with
+ * @new: long value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_relaxed() elsewhere.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
@@ -741,6 +1525,17 @@ raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 #endif
 }
 
+/**
+ * raw_atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_sub_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
@@ -751,6 +1546,16 @@ raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_and_test() - atomic decrement and test if zero with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_dec_and_test(atomic_long_t *v)
 {
@@ -761,6 +1566,16 @@ raw_atomic_long_dec_and_test(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_and_test() - atomic increment and test if zero with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_and_test() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_inc_and_test(atomic_long_t *v)
 {
@@ -771,6 +1586,17 @@ raw_atomic_long_inc_and_test(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_negative() - atomic add and test if negative with full ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_negative() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_add_negative(long i, atomic_long_t *v)
 {
@@ -781,6 +1607,17 @@ raw_atomic_long_add_negative(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_negative_acquire() - atomic add and test if negative with acquire ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with acquire ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_negative_acquire() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
@@ -791,6 +1628,17 @@ raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_negative_release() - atomic add and test if negative with release ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with release ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_negative_release() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
@@ -801,6 +1649,17 @@ raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_negative_relaxed() - atomic add and test if negative with relaxed ordering
+ * @i: long value to add
+ * @v: pointer to atomic_long_t
+ *
+ * Atomically updates @v to (@v + @i) with relaxed ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_negative_relaxed() elsewhere.
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
@@ -811,6 +1670,18 @@ raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_fetch_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_long_t
+ * @a: long value to add
+ * @u: long value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_fetch_add_unless() elsewhere.
+ *
+ * Return: The old value of @v.
+ */
 static __always_inline long
 raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
@@ -821,6 +1692,18 @@ raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 #endif
 }
 
+/**
+ * raw_atomic_long_add_unless() - atomic add unless value with full ordering
+ * @v: pointer to atomic_long_t
+ * @a: long value to add
+ * @u: long value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_add_unless() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
@@ -831,6 +1714,16 @@ raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_not_zero() - atomic increment unless zero with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_not_zero() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_inc_not_zero(atomic_long_t *v)
 {
@@ -841,6 +1734,16 @@ raw_atomic_long_inc_not_zero(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_inc_unless_negative() - atomic increment unless negative with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_inc_unless_negative() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_inc_unless_negative(atomic_long_t *v)
 {
@@ -851,6 +1754,16 @@ raw_atomic_long_inc_unless_negative(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_unless_positive() - atomic decrement unless positive with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_unless_positive() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline bool
 raw_atomic_long_dec_unless_positive(atomic_long_t *v)
 {
@@ -861,6 +1774,16 @@ raw_atomic_long_dec_unless_positive(atomic_long_t *v)
 #endif
 }
 
+/**
+ * raw_atomic_long_dec_if_positive() - atomic decrement if positive with full ordering
+ * @v: pointer to atomic_long_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ *
+ * Safe to use in noinstr code; prefer atomic_long_dec_if_positive() elsewhere.
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
 static __always_inline long
 raw_atomic_long_dec_if_positive(atomic_long_t *v)
 {
@@ -872,4 +1795,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// e785d25cc3f220b7d473d36aac9da85dd7eb13a8
+// ac6d232f716fae95b5f018bb1188e7edfcf8c48a
diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
index 81d5c32039dd4..9a42647719598 100755
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -36,9 +36,16 @@ meta_has_relaxed()
 	meta_in "$1" "BFIR"
 }
 
-#find_fallback_template(pfx, name, sfx, order)
-find_fallback_template()
+#meta_is_implicitly_relaxed(meta)
+meta_is_implicitly_relaxed()
+{
+	meta_in "$1" "vls"
+}
+
+#find_template(tmpltype, pfx, name, sfx, order)
+find_template()
 {
+	local tmpltype="$1"; shift
 	local pfx="$1"; shift
 	local name="$1"; shift
 	local sfx="$1"; shift
@@ -52,8 +59,8 @@ find_fallback_template()
 	#
 	# Start at the most specific, and fall back to the most general. Once
 	# we find a specific fallback, don't bother looking for more.
-	for base in "${pfx}${name}${sfx}${order}" "${name}"; do
-		file="${ATOMICDIR}/fallbacks/${base}"
+	for base in "${pfx}${name}${sfx}${order}" "${pfx}${name}${sfx}" "${name}"; do
+		file="${ATOMICDIR}/${tmpltype}/${base}"
 
 		if [ -f "${file}" ]; then
 			printf "${file}"
@@ -62,6 +69,18 @@ find_fallback_template()
 	done
 }
 
+#find_fallback_template(pfx, name, sfx, order)
+find_fallback_template()
+{
+	find_template "fallbacks" "$@"
+}
+
+#find_kerneldoc_template(pfx, name, sfx, order)
+find_kerneldoc_template()
+{
+	find_template "kerneldoc" "$@"
+}
+
 #gen_ret_type(meta, int)
 gen_ret_type() {
 	local meta="$1"; shift
@@ -142,6 +161,91 @@ gen_args()
 	done
 }
 
+#gen_desc_return(meta)
+gen_desc_return()
+{
+	local meta="$1"; shift
+
+	case "${meta}" in
+	[v])
+		printf "Return: nothing."
+		;;
+	[Ff])
+		printf "Return: The old value of @v."
+		;;
+	[R])
+		printf "Return: the new value of @v."
+		;;
+	[l])
+		printf "Return: the value of @v."
+		;;
+	esac
+}
+
+#gen_template_kerneldoc(template, class, meta, pfx, name, sfx, order, atomic, int, args...)
+gen_template_kerneldoc()
+{
+	local template="$1"; shift
+	local class="$1"; shift
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
+	local retstmt="$(gen_ret_stmt "${meta}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+	local desc_order=""
+	local desc_instrumentation=""
+	local desc_return=""
+
+	if [ ! -z "${order}" ]; then
+		desc_order="${order##_}"
+	elif meta_is_implicitly_relaxed "${meta}"; then
+		desc_order="relaxed"
+	else
+		desc_order="full"
+	fi
+
+	if [ -z "${class}" ]; then
+		desc_noinstr="Unsafe to use in noinstr code; use raw_${atomicname}() there."
+	else
+		desc_noinstr="Safe to use in noinstr code; prefer ${atomicname}() elsewhere."
+	fi
+
+	desc_return="$(gen_desc_return "${meta}")"
+
+	. ${template}
+}
+
+#gen_kerneldoc(class, meta, pfx, name, sfx, order, atomic, int, args...)
+gen_kerneldoc()
+{
+	local class="$1"; shift
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local tmpl="$(find_kerneldoc_template "${pfx}" "${name}" "${sfx}" "${order}")"
+	if [ -z "${tmpl}" ]; then
+		printf "/*\n"
+		printf " * No kerneldoc available for ${class}${atomicname}\n"
+		printf " */\n"
+	else
+	gen_template_kerneldoc "${tmpl}" "${class}" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+	fi
+}
+
 #gen_proto_order_variants(meta, pfx, name, sfx, ...)
 gen_proto_order_variants()
 {
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 2b470d31e3539..c0c8a85d7c81b 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -73,6 +73,8 @@ gen_proto_order_variant()
 	local params="$(gen_params "${int}" "${atomic}" "$@")"
 	local args="$(gen_args "$@")"
 
+	gen_kerneldoc "raw_" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "${atomic}" "${int}" "$@"
+
 	printf "static __always_inline ${ret}\n"
 	printf "raw_${atomicname}(${params})\n"
 	printf "{\n"
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 93c949aa9e544..9d3863ceb4d48 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -67,6 +67,8 @@ gen_proto_order_variant()
 	local checks="$(gen_params_checks "${meta}" "${order}" "$@")"
 	local args="$(gen_args "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
+	
+	gen_kerneldoc "" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "${atomic}" "${int}" "$@"
 
 cat <<EOF
 static __always_inline ${ret}
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index af27a71b37ef1..9826be3ba9862 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -49,6 +49,8 @@ gen_proto_order_variant()
 	local argscast_64="$(gen_args_cast "s64" "atomic64" "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
+	gen_kerneldoc "raw_" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "atomic_long" "long" "$@"
+
 cat <<EOF
 static __always_inline ${ret}
 raw_atomic_long_${atomicname}(${params})
diff --git a/scripts/atomic/kerneldoc/add b/scripts/atomic/kerneldoc/add
new file mode 100644
index 0000000000000..991f3dafceea3
--- /dev/null
+++ b/scripts/atomic/kerneldoc/add
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic add with ${desc_order} ordering
+ * @i: ${int} value to add
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v + @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/add_negative b/scripts/atomic/kerneldoc/add_negative
new file mode 100644
index 0000000000000..f4ca1f05d1d81
--- /dev/null
+++ b/scripts/atomic/kerneldoc/add_negative
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic add and test if negative with ${desc_order} ordering
+ * @i: ${int} value to add
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v + @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if the resulting value of @v is negative, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/add_unless b/scripts/atomic/kerneldoc/add_unless
new file mode 100644
index 0000000000000..f828e5f6750c2
--- /dev/null
+++ b/scripts/atomic/kerneldoc/add_unless
@@ -0,0 +1,18 @@
+if [ -z "${pfx}" ]; then
+	desc_return="Return: @true if @v was updated, @false otherwise."
+fi
+
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic add unless value with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ * @a: ${int} value to add
+ * @u: ${int} value to compare with
+ *
+ * If (@v != @u), atomically updates @v to (@v + @a) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/and b/scripts/atomic/kerneldoc/and
new file mode 100644
index 0000000000000..a923574351fc2
--- /dev/null
+++ b/scripts/atomic/kerneldoc/and
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic bitwise AND with ${desc_order} ordering
+ * @i: ${int} value
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v & @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/andnot b/scripts/atomic/kerneldoc/andnot
new file mode 100644
index 0000000000000..64bb509f866bf
--- /dev/null
+++ b/scripts/atomic/kerneldoc/andnot
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic bitwise AND NOT with ${desc_order} ordering
+ * @i: ${int} value
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v & ~@i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/cmpxchg b/scripts/atomic/kerneldoc/cmpxchg
new file mode 100644
index 0000000000000..c59b4ece072bf
--- /dev/null
+++ b/scripts/atomic/kerneldoc/cmpxchg
@@ -0,0 +1,14 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic compare and exchange with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ * @old: ${int} value to compare with
+ * @new: ${int} value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: the old value of @v.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/dec b/scripts/atomic/kerneldoc/dec
new file mode 100644
index 0000000000000..bbeecbc4c20a4
--- /dev/null
+++ b/scripts/atomic/kerneldoc/dec
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic decrement with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v - 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/dec_and_test b/scripts/atomic/kerneldoc/dec_and_test
new file mode 100644
index 0000000000000..71bbd23ce4bca
--- /dev/null
+++ b/scripts/atomic/kerneldoc/dec_and_test
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic decrement and test if zero with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v - 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/dec_if_positive b/scripts/atomic/kerneldoc/dec_if_positive
new file mode 100644
index 0000000000000..7c742866fb6b6
--- /dev/null
+++ b/scripts/atomic/kerneldoc/dec_if_positive
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic decrement if positive with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * If (@v > 0), atomically updates @v to (@v - 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/dec_unless_positive b/scripts/atomic/kerneldoc/dec_unless_positive
new file mode 100644
index 0000000000000..ee73612f03547
--- /dev/null
+++ b/scripts/atomic/kerneldoc/dec_unless_positive
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic decrement unless positive with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * If (@v <= 0), atomically updates @v to (@v - 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/inc b/scripts/atomic/kerneldoc/inc
new file mode 100644
index 0000000000000..9f14f1b3d2ef2
--- /dev/null
+++ b/scripts/atomic/kerneldoc/inc
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic increment with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v + 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/inc_and_test b/scripts/atomic/kerneldoc/inc_and_test
new file mode 100644
index 0000000000000..971694d59bbd1
--- /dev/null
+++ b/scripts/atomic/kerneldoc/inc_and_test
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic increment and test if zero with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v + 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/inc_not_zero b/scripts/atomic/kerneldoc/inc_not_zero
new file mode 100644
index 0000000000000..618be08e653e5
--- /dev/null
+++ b/scripts/atomic/kerneldoc/inc_not_zero
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic increment unless zero with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * If (@v != 0), atomically updates @v to (@v + 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/inc_unless_negative b/scripts/atomic/kerneldoc/inc_unless_negative
new file mode 100644
index 0000000000000..597f23d4dc8dc
--- /dev/null
+++ b/scripts/atomic/kerneldoc/inc_unless_negative
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic increment unless negative with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * If (@v >= 0), atomically updates @v to (@v + 1) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if @v was updated, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/or b/scripts/atomic/kerneldoc/or
new file mode 100644
index 0000000000000..55b33de504165
--- /dev/null
+++ b/scripts/atomic/kerneldoc/or
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic bitwise OR with ${desc_order} ordering
+ * @i: ${int} value
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v | @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/read b/scripts/atomic/kerneldoc/read
new file mode 100644
index 0000000000000..c50d88e96f851
--- /dev/null
+++ b/scripts/atomic/kerneldoc/read
@@ -0,0 +1,12 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic load with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically loads the value of @v with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: the value loaded from @v
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/set b/scripts/atomic/kerneldoc/set
new file mode 100644
index 0000000000000..e9e223e91ce13
--- /dev/null
+++ b/scripts/atomic/kerneldoc/set
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic set with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ * @i: ${int} value to assign
+ *
+ * Atomically sets @v to @i with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: nothing.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/sub b/scripts/atomic/kerneldoc/sub
new file mode 100644
index 0000000000000..3ba642d04407a
--- /dev/null
+++ b/scripts/atomic/kerneldoc/sub
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic subtract with ${desc_order} ordering
+ * @i: ${int} value to subtract
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v - @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/sub_and_test b/scripts/atomic/kerneldoc/sub_and_test
new file mode 100644
index 0000000000000..d3760f7749d4e
--- /dev/null
+++ b/scripts/atomic/kerneldoc/sub_and_test
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic subtract and test if zero with ${desc_order} ordering
+ * @i: ${int} value to add
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v - @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if the resulting value of @v is zero, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/try_cmpxchg b/scripts/atomic/kerneldoc/try_cmpxchg
new file mode 100644
index 0000000000000..296553206c06e
--- /dev/null
+++ b/scripts/atomic/kerneldoc/try_cmpxchg
@@ -0,0 +1,15 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic compare and exchange with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ * @old: pointer to ${int} value to compare with
+ * @new: ${int} value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with ${desc_order} ordering.
+ * Otherwise, updates @old to the current value of @v.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/xchg b/scripts/atomic/kerneldoc/xchg
new file mode 100644
index 0000000000000..4035b9de63ca0
--- /dev/null
+++ b/scripts/atomic/kerneldoc/xchg
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic exchange with ${desc_order} ordering
+ * @v: pointer to ${atomic}_t
+ * @new: ${int} value to assign
+ *
+ * Atomically updates @v to @new with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * Return: the old value of @v.
+ */
+EOF
diff --git a/scripts/atomic/kerneldoc/xor b/scripts/atomic/kerneldoc/xor
new file mode 100644
index 0000000000000..8837270f2806d
--- /dev/null
+++ b/scripts/atomic/kerneldoc/xor
@@ -0,0 +1,13 @@
+cat <<EOF
+/**
+ * ${class}${atomicname}() - atomic bitwise XOR with ${desc_order} ordering
+ * @i: ${int} value
+ * @v: pointer to ${atomic}_t
+ *
+ * Atomically updates @v to (@v ^ @i) with ${desc_order} ordering.
+ *
+ * ${desc_noinstr}
+ *
+ * ${desc_return}
+ */
+EOF
-- 
2.30.2

