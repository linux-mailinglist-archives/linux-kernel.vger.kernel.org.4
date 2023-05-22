Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E570BE43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjEVM3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjEVM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:27:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DF58102;
        Mon, 22 May 2023 05:25:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C4E11FB;
        Mon, 22 May 2023 05:26:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 927A73F59C;
        Mon, 22 May 2023 05:25:25 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 20/26] locking/atomic: scripts: restructure fallback ifdeffery
Date:   Mon, 22 May 2023 13:24:23 +0100
Message-Id: <20230522122429.1915021-21-mark.rutland@arm.com>
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

Currently the various ordering variants of an atomic operation are
defined in groups of full/acquire/release/relaxed ordering variants with
some shared ifdeffery and several potential definitions of each ordering
variant in different branches of the shared ifdeffery.

As an ordering variant can have several potential definitions down
different branches of the shared ifdeffery, it can be painful for a
human to find a relevant definition, and we don't have a good location
to place anything common to all definitions of an ordering variant (e.g.
kerneldoc).

Historically the grouping of full/acquire/release/relaxed ordering
variants was necessary as we filled in the missing atomics in the same
namespace as the architecture used. It would be easy to accidentally
define one ordering fallback in terms of another ordering fallback with
redundant barriers, and avoiding that would otherwise require a lot of
baroque ifdeffery.

With recent changes we no longer need to fill in the missing atomics in
the arch_atomic*_<op>() namespace, and only need to fill in the
raw_atomic*_<op>() namespace. Due to this, there's no risk of a
namespace collision, and we can define each raw_atomic*_<op> ordering
variant with its own ifdeffery checking for the arch_atomic*_<op>
ordering variants.

Restructure the fallbacks in this way, with each ordering variant having
its own ifdeffery of the form:

| #if defined(arch_atomic_fetch_andnot_acquire)
| #define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
| #elif defined(arch_atomic_fetch_andnot_relaxed)
| static __always_inline int
| raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
| {
| 	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
| 	__atomic_acquire_fence();
| 	return ret;
| }
| #elif defined(arch_atomic_fetch_andnot)
| #define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
| #else
| static __always_inline int
| raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
| {
| 	return raw_atomic_fetch_and_acquire(~i, v);
| }
| #endif

Note that where there's no relevant arch_atomic*_<op>() ordering
variant, we'll define the operation in terms of a distinct
raw_atomic*_<otherop>(), as this itself might have been filled in with a
fallback.

As we now generate the raw_atomic*_<op>() implementations directly, we
no longer need the trivial wrappers, so they are removed.

This makes the ifdeffery easier to follow, and will allow for further
improvements in subsequent patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/atomic.h                       |    1 -
 include/linux/atomic/atomic-arch-fallback.h  | 3178 +++++++++---------
 include/linux/atomic/atomic-raw.h            | 1135 -------
 scripts/atomic/fallbacks/acquire             |    2 +-
 scripts/atomic/fallbacks/add_negative        |    4 +-
 scripts/atomic/fallbacks/add_unless          |    4 +-
 scripts/atomic/fallbacks/andnot              |    4 +-
 scripts/atomic/fallbacks/cmpxchg             |    4 +-
 scripts/atomic/fallbacks/dec                 |    4 +-
 scripts/atomic/fallbacks/dec_and_test        |    4 +-
 scripts/atomic/fallbacks/dec_if_positive     |    6 +-
 scripts/atomic/fallbacks/dec_unless_positive |    6 +-
 scripts/atomic/fallbacks/fence               |    2 +-
 scripts/atomic/fallbacks/fetch_add_unless    |    6 +-
 scripts/atomic/fallbacks/inc                 |    4 +-
 scripts/atomic/fallbacks/inc_and_test        |    4 +-
 scripts/atomic/fallbacks/inc_not_zero        |    4 +-
 scripts/atomic/fallbacks/inc_unless_negative |    6 +-
 scripts/atomic/fallbacks/read_acquire        |    4 +-
 scripts/atomic/fallbacks/release             |    2 +-
 scripts/atomic/fallbacks/set_release         |    4 +-
 scripts/atomic/fallbacks/sub_and_test        |    4 +-
 scripts/atomic/fallbacks/try_cmpxchg         |    4 +-
 scripts/atomic/fallbacks/xchg                |    4 +-
 scripts/atomic/gen-atomic-fallback.sh        |  236 +-
 scripts/atomic/gen-atomic-raw.sh             |   80 -
 scripts/atomic/gen-atomics.sh                |    1 -
 27 files changed, 1866 insertions(+), 2851 deletions(-)
 delete mode 100644 include/linux/atomic/atomic-raw.h
 delete mode 100755 scripts/atomic/gen-atomic-raw.sh

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 296cfae0389fe..8dd57c3a99e9b 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -78,7 +78,6 @@
 })
 
 #include <linux/atomic/atomic-arch-fallback.h>
-#include <linux/atomic/atomic-raw.h>
 #include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-instrumented.h>
 
diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 1a2d81dbc2e48..99bc1a871dc12 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -8,2749 +8,2911 @@
 
 #include <linux/compiler.h>
 
-#ifndef arch_xchg_relaxed
-#define arch_xchg_acquire arch_xchg
-#define arch_xchg_release arch_xchg
-#define arch_xchg_relaxed arch_xchg
-#else /* arch_xchg_relaxed */
-
-#ifndef arch_xchg_acquire
-#define arch_xchg_acquire(...) \
-	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
+#if defined(arch_xchg)
+#define raw_xchg arch_xchg
+#elif defined(arch_xchg_relaxed)
+#define raw_xchg(...) \
+	__atomic_op_fence(arch_xchg, __VA_ARGS__)
+#else
+extern void raw_xchg_not_implemented(void);
+#define raw_xchg(...) raw_xchg_not_implemented()
 #endif
 
-#ifndef arch_xchg_release
-#define arch_xchg_release(...) \
-	__atomic_op_release(arch_xchg, __VA_ARGS__)
+#if defined(arch_xchg_acquire)
+#define raw_xchg_acquire arch_xchg_acquire
+#elif defined(arch_xchg_relaxed)
+#define raw_xchg_acquire(...) \
+	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
+#elif defined(arch_xchg)
+#define raw_xchg_acquire arch_xchg
+#else
+extern void raw_xchg_acquire_not_implemented(void);
+#define raw_xchg_acquire(...) raw_xchg_acquire_not_implemented()
 #endif
 
-#ifndef arch_xchg
-#define arch_xchg(...) \
-	__atomic_op_fence(arch_xchg, __VA_ARGS__)
+#if defined(arch_xchg_release)
+#define raw_xchg_release arch_xchg_release
+#elif defined(arch_xchg_relaxed)
+#define raw_xchg_release(...) \
+	__atomic_op_release(arch_xchg, __VA_ARGS__)
+#elif defined(arch_xchg)
+#define raw_xchg_release arch_xchg
+#else
+extern void raw_xchg_release_not_implemented(void);
+#define raw_xchg_release(...) raw_xchg_release_not_implemented()
+#endif
+
+#if defined(arch_xchg_relaxed)
+#define raw_xchg_relaxed arch_xchg_relaxed
+#elif defined(arch_xchg)
+#define raw_xchg_relaxed arch_xchg
+#else
+extern void raw_xchg_relaxed_not_implemented(void);
+#define raw_xchg_relaxed(...) raw_xchg_relaxed_not_implemented()
+#endif
+
+#if defined(arch_cmpxchg)
+#define raw_cmpxchg arch_cmpxchg
+#elif defined(arch_cmpxchg_relaxed)
+#define raw_cmpxchg(...) \
+	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
+#else
+extern void raw_cmpxchg_not_implemented(void);
+#define raw_cmpxchg(...) raw_cmpxchg_not_implemented()
 #endif
 
-#endif /* arch_xchg_relaxed */
-
-#ifndef arch_cmpxchg_relaxed
-#define arch_cmpxchg_acquire arch_cmpxchg
-#define arch_cmpxchg_release arch_cmpxchg
-#define arch_cmpxchg_relaxed arch_cmpxchg
-#else /* arch_cmpxchg_relaxed */
-
-#ifndef arch_cmpxchg_acquire
-#define arch_cmpxchg_acquire(...) \
+#if defined(arch_cmpxchg_acquire)
+#define raw_cmpxchg_acquire arch_cmpxchg_acquire
+#elif defined(arch_cmpxchg_relaxed)
+#define raw_cmpxchg_acquire(...) \
 	__atomic_op_acquire(arch_cmpxchg, __VA_ARGS__)
+#elif defined(arch_cmpxchg)
+#define raw_cmpxchg_acquire arch_cmpxchg
+#else
+extern void raw_cmpxchg_acquire_not_implemented(void);
+#define raw_cmpxchg_acquire(...) raw_cmpxchg_acquire_not_implemented()
 #endif
 
-#ifndef arch_cmpxchg_release
-#define arch_cmpxchg_release(...) \
+#if defined(arch_cmpxchg_release)
+#define raw_cmpxchg_release arch_cmpxchg_release
+#elif defined(arch_cmpxchg_relaxed)
+#define raw_cmpxchg_release(...) \
 	__atomic_op_release(arch_cmpxchg, __VA_ARGS__)
+#elif defined(arch_cmpxchg)
+#define raw_cmpxchg_release arch_cmpxchg
+#else
+extern void raw_cmpxchg_release_not_implemented(void);
+#define raw_cmpxchg_release(...) raw_cmpxchg_release_not_implemented()
+#endif
+
+#if defined(arch_cmpxchg_relaxed)
+#define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
+#elif defined(arch_cmpxchg)
+#define raw_cmpxchg_relaxed arch_cmpxchg
+#else
+extern void raw_cmpxchg_relaxed_not_implemented(void);
+#define raw_cmpxchg_relaxed(...) raw_cmpxchg_relaxed_not_implemented()
+#endif
+
+#if defined(arch_cmpxchg64)
+#define raw_cmpxchg64 arch_cmpxchg64
+#elif defined(arch_cmpxchg64_relaxed)
+#define raw_cmpxchg64(...) \
+	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
+#else
+extern void raw_cmpxchg64_not_implemented(void);
+#define raw_cmpxchg64(...) raw_cmpxchg64_not_implemented()
 #endif
 
-#ifndef arch_cmpxchg
-#define arch_cmpxchg(...) \
-	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
-#endif
-
-#endif /* arch_cmpxchg_relaxed */
-
-#ifndef arch_cmpxchg64_relaxed
-#define arch_cmpxchg64_acquire arch_cmpxchg64
-#define arch_cmpxchg64_release arch_cmpxchg64
-#define arch_cmpxchg64_relaxed arch_cmpxchg64
-#else /* arch_cmpxchg64_relaxed */
-
-#ifndef arch_cmpxchg64_acquire
-#define arch_cmpxchg64_acquire(...) \
+#if defined(arch_cmpxchg64_acquire)
+#define raw_cmpxchg64_acquire arch_cmpxchg64_acquire
+#elif defined(arch_cmpxchg64_relaxed)
+#define raw_cmpxchg64_acquire(...) \
 	__atomic_op_acquire(arch_cmpxchg64, __VA_ARGS__)
+#elif defined(arch_cmpxchg64)
+#define raw_cmpxchg64_acquire arch_cmpxchg64
+#else
+extern void raw_cmpxchg64_acquire_not_implemented(void);
+#define raw_cmpxchg64_acquire(...) raw_cmpxchg64_acquire_not_implemented()
 #endif
 
-#ifndef arch_cmpxchg64_release
-#define arch_cmpxchg64_release(...) \
+#if defined(arch_cmpxchg64_release)
+#define raw_cmpxchg64_release arch_cmpxchg64_release
+#elif defined(arch_cmpxchg64_relaxed)
+#define raw_cmpxchg64_release(...) \
 	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
+#elif defined(arch_cmpxchg64)
+#define raw_cmpxchg64_release arch_cmpxchg64
+#else
+extern void raw_cmpxchg64_release_not_implemented(void);
+#define raw_cmpxchg64_release(...) raw_cmpxchg64_release_not_implemented()
+#endif
+
+#if defined(arch_cmpxchg64_relaxed)
+#define raw_cmpxchg64_relaxed arch_cmpxchg64_relaxed
+#elif defined(arch_cmpxchg64)
+#define raw_cmpxchg64_relaxed arch_cmpxchg64
+#else
+extern void raw_cmpxchg64_relaxed_not_implemented(void);
+#define raw_cmpxchg64_relaxed(...) raw_cmpxchg64_relaxed_not_implemented()
+#endif
+
+#if defined(arch_cmpxchg128)
+#define raw_cmpxchg128 arch_cmpxchg128
+#elif defined(arch_cmpxchg128_relaxed)
+#define raw_cmpxchg128(...) \
+	__atomic_op_fence(arch_cmpxchg128, __VA_ARGS__)
+#else
+extern void raw_cmpxchg128_not_implemented(void);
+#define raw_cmpxchg128(...) raw_cmpxchg128_not_implemented()
 #endif
 
-#ifndef arch_cmpxchg64
-#define arch_cmpxchg64(...) \
-	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
-#endif
-
-#endif /* arch_cmpxchg64_relaxed */
-
-#ifndef arch_cmpxchg128_relaxed
-#define arch_cmpxchg128_acquire arch_cmpxchg128
-#define arch_cmpxchg128_release arch_cmpxchg128
-#define arch_cmpxchg128_relaxed arch_cmpxchg128
-#else /* arch_cmpxchg128_relaxed */
-
-#ifndef arch_cmpxchg128_acquire
-#define arch_cmpxchg128_acquire(...) \
+#if defined(arch_cmpxchg128_acquire)
+#define raw_cmpxchg128_acquire arch_cmpxchg128_acquire
+#elif defined(arch_cmpxchg128_relaxed)
+#define raw_cmpxchg128_acquire(...) \
 	__atomic_op_acquire(arch_cmpxchg128, __VA_ARGS__)
+#elif defined(arch_cmpxchg128)
+#define raw_cmpxchg128_acquire arch_cmpxchg128
+#else
+extern void raw_cmpxchg128_acquire_not_implemented(void);
+#define raw_cmpxchg128_acquire(...) raw_cmpxchg128_acquire_not_implemented()
 #endif
 
-#ifndef arch_cmpxchg128_release
-#define arch_cmpxchg128_release(...) \
+#if defined(arch_cmpxchg128_release)
+#define raw_cmpxchg128_release arch_cmpxchg128_release
+#elif defined(arch_cmpxchg128_relaxed)
+#define raw_cmpxchg128_release(...) \
 	__atomic_op_release(arch_cmpxchg128, __VA_ARGS__)
-#endif
-
-#ifndef arch_cmpxchg128
-#define arch_cmpxchg128(...) \
-	__atomic_op_fence(arch_cmpxchg128, __VA_ARGS__)
-#endif
-
-#endif /* arch_cmpxchg128_relaxed */
-
-#ifndef arch_try_cmpxchg_relaxed
-#ifdef arch_try_cmpxchg
-#define arch_try_cmpxchg_acquire arch_try_cmpxchg
-#define arch_try_cmpxchg_release arch_try_cmpxchg
-#define arch_try_cmpxchg_relaxed arch_try_cmpxchg
-#endif /* arch_try_cmpxchg */
-
-#ifndef arch_try_cmpxchg
-#define arch_try_cmpxchg(_ptr, _oldp, _new) \
+#elif defined(arch_cmpxchg128)
+#define raw_cmpxchg128_release arch_cmpxchg128
+#else
+extern void raw_cmpxchg128_release_not_implemented(void);
+#define raw_cmpxchg128_release(...) raw_cmpxchg128_release_not_implemented()
+#endif
+
+#if defined(arch_cmpxchg128_relaxed)
+#define raw_cmpxchg128_relaxed arch_cmpxchg128_relaxed
+#elif defined(arch_cmpxchg128)
+#define raw_cmpxchg128_relaxed arch_cmpxchg128
+#else
+extern void raw_cmpxchg128_relaxed_not_implemented(void);
+#define raw_cmpxchg128_relaxed(...) raw_cmpxchg128_relaxed_not_implemented()
+#endif
+
+#if defined(arch_try_cmpxchg)
+#define raw_try_cmpxchg arch_try_cmpxchg
+#elif defined(arch_try_cmpxchg_relaxed)
+#define raw_try_cmpxchg(...) \
+	__atomic_op_fence(arch_try_cmpxchg, __VA_ARGS__)
+#else
+#define raw_try_cmpxchg(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg */
+#endif
 
-#ifndef arch_try_cmpxchg_acquire
-#define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg_acquire)
+#define raw_try_cmpxchg_acquire arch_try_cmpxchg_acquire
+#elif defined(arch_try_cmpxchg_relaxed)
+#define raw_try_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg, __VA_ARGS__)
+#elif defined(arch_try_cmpxchg)
+#define raw_try_cmpxchg_acquire arch_try_cmpxchg
+#else
+#define raw_try_cmpxchg_acquire(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg_acquire */
+#endif
 
-#ifndef arch_try_cmpxchg_release
-#define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg_release)
+#define raw_try_cmpxchg_release arch_try_cmpxchg_release
+#elif defined(arch_try_cmpxchg_relaxed)
+#define raw_try_cmpxchg_release(...) \
+	__atomic_op_release(arch_try_cmpxchg, __VA_ARGS__)
+#elif defined(arch_try_cmpxchg)
+#define raw_try_cmpxchg_release arch_try_cmpxchg
+#else
+#define raw_try_cmpxchg_release(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg_release */
+#endif
 
-#ifndef arch_try_cmpxchg_relaxed
-#define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg_relaxed)
+#define raw_try_cmpxchg_relaxed arch_try_cmpxchg_relaxed
+#elif defined(arch_try_cmpxchg)
+#define raw_try_cmpxchg_relaxed arch_try_cmpxchg
+#else
+#define raw_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg_relaxed */
-
-#else /* arch_try_cmpxchg_relaxed */
-
-#ifndef arch_try_cmpxchg_acquire
-#define arch_try_cmpxchg_acquire(...) \
-	__atomic_op_acquire(arch_try_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_try_cmpxchg_release
-#define arch_try_cmpxchg_release(...) \
-	__atomic_op_release(arch_try_cmpxchg, __VA_ARGS__)
 #endif
 
-#ifndef arch_try_cmpxchg
-#define arch_try_cmpxchg(...) \
-	__atomic_op_fence(arch_try_cmpxchg, __VA_ARGS__)
-#endif
-
-#endif /* arch_try_cmpxchg_relaxed */
-
-#ifndef arch_try_cmpxchg64_relaxed
-#ifdef arch_try_cmpxchg64
-#define arch_try_cmpxchg64_acquire arch_try_cmpxchg64
-#define arch_try_cmpxchg64_release arch_try_cmpxchg64
-#define arch_try_cmpxchg64_relaxed arch_try_cmpxchg64
-#endif /* arch_try_cmpxchg64 */
-
-#ifndef arch_try_cmpxchg64
-#define arch_try_cmpxchg64(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg64)
+#define raw_try_cmpxchg64 arch_try_cmpxchg64
+#elif defined(arch_try_cmpxchg64_relaxed)
+#define raw_try_cmpxchg64(...) \
+	__atomic_op_fence(arch_try_cmpxchg64, __VA_ARGS__)
+#else
+#define raw_try_cmpxchg64(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg64((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg64((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg64 */
+#endif
 
-#ifndef arch_try_cmpxchg64_acquire
-#define arch_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg64_acquire)
+#define raw_try_cmpxchg64_acquire arch_try_cmpxchg64_acquire
+#elif defined(arch_try_cmpxchg64_relaxed)
+#define raw_try_cmpxchg64_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg64, __VA_ARGS__)
+#elif defined(arch_try_cmpxchg64)
+#define raw_try_cmpxchg64_acquire arch_try_cmpxchg64
+#else
+#define raw_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg64_acquire((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg64_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg64_acquire */
+#endif
 
-#ifndef arch_try_cmpxchg64_release
-#define arch_try_cmpxchg64_release(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg64_release)
+#define raw_try_cmpxchg64_release arch_try_cmpxchg64_release
+#elif defined(arch_try_cmpxchg64_relaxed)
+#define raw_try_cmpxchg64_release(...) \
+	__atomic_op_release(arch_try_cmpxchg64, __VA_ARGS__)
+#elif defined(arch_try_cmpxchg64)
+#define raw_try_cmpxchg64_release arch_try_cmpxchg64
+#else
+#define raw_try_cmpxchg64_release(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg64_release((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg64_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg64_release */
+#endif
 
-#ifndef arch_try_cmpxchg64_relaxed
-#define arch_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg64_relaxed)
+#define raw_try_cmpxchg64_relaxed arch_try_cmpxchg64_relaxed
+#elif defined(arch_try_cmpxchg64)
+#define raw_try_cmpxchg64_relaxed arch_try_cmpxchg64
+#else
+#define raw_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg64_relaxed */
-
-#else /* arch_try_cmpxchg64_relaxed */
-
-#ifndef arch_try_cmpxchg64_acquire
-#define arch_try_cmpxchg64_acquire(...) \
-	__atomic_op_acquire(arch_try_cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef arch_try_cmpxchg64_release
-#define arch_try_cmpxchg64_release(...) \
-	__atomic_op_release(arch_try_cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef arch_try_cmpxchg64
-#define arch_try_cmpxchg64(...) \
-	__atomic_op_fence(arch_try_cmpxchg64, __VA_ARGS__)
 #endif
 
-#endif /* arch_try_cmpxchg64_relaxed */
-
-#ifndef arch_try_cmpxchg128_relaxed
-#ifdef arch_try_cmpxchg128
-#define arch_try_cmpxchg128_acquire arch_try_cmpxchg128
-#define arch_try_cmpxchg128_release arch_try_cmpxchg128
-#define arch_try_cmpxchg128_relaxed arch_try_cmpxchg128
-#endif /* arch_try_cmpxchg128 */
-
-#ifndef arch_try_cmpxchg128
-#define arch_try_cmpxchg128(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg128)
+#define raw_try_cmpxchg128 arch_try_cmpxchg128
+#elif defined(arch_try_cmpxchg128_relaxed)
+#define raw_try_cmpxchg128(...) \
+	__atomic_op_fence(arch_try_cmpxchg128, __VA_ARGS__)
+#else
+#define raw_try_cmpxchg128(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg128((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg128((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg128 */
+#endif
 
-#ifndef arch_try_cmpxchg128_acquire
-#define arch_try_cmpxchg128_acquire(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg128_acquire)
+#define raw_try_cmpxchg128_acquire arch_try_cmpxchg128_acquire
+#elif defined(arch_try_cmpxchg128_relaxed)
+#define raw_try_cmpxchg128_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg128, __VA_ARGS__)
+#elif defined(arch_try_cmpxchg128)
+#define raw_try_cmpxchg128_acquire arch_try_cmpxchg128
+#else
+#define raw_try_cmpxchg128_acquire(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg128_acquire((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg128_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg128_acquire */
+#endif
 
-#ifndef arch_try_cmpxchg128_release
-#define arch_try_cmpxchg128_release(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg128_release)
+#define raw_try_cmpxchg128_release arch_try_cmpxchg128_release
+#elif defined(arch_try_cmpxchg128_relaxed)
+#define raw_try_cmpxchg128_release(...) \
+	__atomic_op_release(arch_try_cmpxchg128, __VA_ARGS__)
+#elif defined(arch_try_cmpxchg128)
+#define raw_try_cmpxchg128_release arch_try_cmpxchg128
+#else
+#define raw_try_cmpxchg128_release(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg128_release((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg128_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg128_release */
+#endif
 
-#ifndef arch_try_cmpxchg128_relaxed
-#define arch_try_cmpxchg128_relaxed(_ptr, _oldp, _new) \
+#if defined(arch_try_cmpxchg128_relaxed)
+#define raw_try_cmpxchg128_relaxed arch_try_cmpxchg128_relaxed
+#elif defined(arch_try_cmpxchg128)
+#define raw_try_cmpxchg128_relaxed arch_try_cmpxchg128
+#else
+#define raw_try_cmpxchg128_relaxed(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg128_relaxed((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg128_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg128_relaxed */
-
-#else /* arch_try_cmpxchg128_relaxed */
-
-#ifndef arch_try_cmpxchg128_acquire
-#define arch_try_cmpxchg128_acquire(...) \
-	__atomic_op_acquire(arch_try_cmpxchg128, __VA_ARGS__)
 #endif
 
-#ifndef arch_try_cmpxchg128_release
-#define arch_try_cmpxchg128_release(...) \
-	__atomic_op_release(arch_try_cmpxchg128, __VA_ARGS__)
-#endif
+#define raw_cmpxchg_local arch_cmpxchg_local
 
-#ifndef arch_try_cmpxchg128
-#define arch_try_cmpxchg128(...) \
-	__atomic_op_fence(arch_try_cmpxchg128, __VA_ARGS__)
+#ifdef arch_try_cmpxchg_local
+#define raw_try_cmpxchg_local arch_try_cmpxchg_local
+#else
+#define raw_try_cmpxchg_local(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
 #endif
 
-#endif /* arch_try_cmpxchg128_relaxed */
+#define raw_cmpxchg64_local arch_cmpxchg64_local
 
-#ifndef arch_try_cmpxchg_local
-#define arch_try_cmpxchg_local(_ptr, _oldp, _new) \
+#ifdef arch_try_cmpxchg64_local
+#define raw_try_cmpxchg64_local arch_try_cmpxchg64_local
+#else
+#define raw_try_cmpxchg64_local(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_local((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg64_local((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg_local */
+#endif
+
+#define raw_cmpxchg128_local arch_cmpxchg128_local
 
-#ifndef arch_try_cmpxchg64_local
-#define arch_try_cmpxchg64_local(_ptr, _oldp, _new) \
+#ifdef arch_try_cmpxchg128_local
+#define raw_try_cmpxchg128_local arch_try_cmpxchg128_local
+#else
+#define raw_try_cmpxchg128_local(_ptr, _oldp, _new) \
 ({ \
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg64_local((_ptr), ___o, (_new)); \
+	___r = raw_cmpxchg128_local((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
 	likely(___r == ___o); \
 })
-#endif /* arch_try_cmpxchg64_local */
+#endif
+
+#define raw_sync_cmpxchg arch_sync_cmpxchg
 
-#ifndef arch_atomic_read_acquire
+#define raw_atomic_read arch_atomic_read
+
+#if defined(arch_atomic_read_acquire)
+#define raw_atomic_read_acquire arch_atomic_read_acquire
+#elif defined(arch_atomic_read)
+#define raw_atomic_read_acquire arch_atomic_read
+#else
 static __always_inline int
-arch_atomic_read_acquire(const atomic_t *v)
+raw_atomic_read_acquire(const atomic_t *v)
 {
 	int ret;
 
 	if (__native_word(atomic_t)) {
 		ret = smp_load_acquire(&(v)->counter);
 	} else {
-		ret = arch_atomic_read(v);
+		ret = raw_atomic_read(v);
 		__atomic_acquire_fence();
 	}
 
 	return ret;
 }
-#define arch_atomic_read_acquire arch_atomic_read_acquire
 #endif
 
-#ifndef arch_atomic_set_release
+#define raw_atomic_set arch_atomic_set
+
+#if defined(arch_atomic_set_release)
+#define raw_atomic_set_release arch_atomic_set_release
+#elif defined(arch_atomic_set)
+#define raw_atomic_set_release arch_atomic_set
+#else
 static __always_inline void
-arch_atomic_set_release(atomic_t *v, int i)
+raw_atomic_set_release(atomic_t *v, int i)
 {
 	if (__native_word(atomic_t)) {
 		smp_store_release(&(v)->counter, i);
 	} else {
 		__atomic_release_fence();
-		arch_atomic_set(v, i);
+		raw_atomic_set(v, i);
 	}
 }
-#define arch_atomic_set_release arch_atomic_set_release
 #endif
 
-#ifndef arch_atomic_add_return_relaxed
-#define arch_atomic_add_return_acquire arch_atomic_add_return
-#define arch_atomic_add_return_release arch_atomic_add_return
-#define arch_atomic_add_return_relaxed arch_atomic_add_return
-#else /* arch_atomic_add_return_relaxed */
+#define raw_atomic_add arch_atomic_add
+
+#if defined(arch_atomic_add_return)
+#define raw_atomic_add_return arch_atomic_add_return
+#elif defined(arch_atomic_add_return_relaxed)
+static __always_inline int
+raw_atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#else
+#error "Unable to define raw_atomic_add_return"
+#endif
 
-#ifndef arch_atomic_add_return_acquire
+#if defined(arch_atomic_add_return_acquire)
+#define raw_atomic_add_return_acquire arch_atomic_add_return_acquire
+#elif defined(arch_atomic_add_return_relaxed)
 static __always_inline int
-arch_atomic_add_return_acquire(int i, atomic_t *v)
+raw_atomic_add_return_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_add_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
+#elif defined(arch_atomic_add_return)
+#define raw_atomic_add_return_acquire arch_atomic_add_return
+#else
+#error "Unable to define raw_atomic_add_return_acquire"
 #endif
 
-#ifndef arch_atomic_add_return_release
+#if defined(arch_atomic_add_return_release)
+#define raw_atomic_add_return_release arch_atomic_add_return_release
+#elif defined(arch_atomic_add_return_relaxed)
 static __always_inline int
-arch_atomic_add_return_release(int i, atomic_t *v)
+raw_atomic_add_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_add_return_relaxed(i, v);
 }
-#define arch_atomic_add_return_release arch_atomic_add_return_release
+#elif defined(arch_atomic_add_return)
+#define raw_atomic_add_return_release arch_atomic_add_return
+#else
+#error "Unable to define raw_atomic_add_return_release"
 #endif
 
-#ifndef arch_atomic_add_return
+#if defined(arch_atomic_add_return_relaxed)
+#define raw_atomic_add_return_relaxed arch_atomic_add_return_relaxed
+#elif defined(arch_atomic_add_return)
+#define raw_atomic_add_return_relaxed arch_atomic_add_return
+#else
+#error "Unable to define raw_atomic_add_return_relaxed"
+#endif
+
+#if defined(arch_atomic_fetch_add)
+#define raw_atomic_fetch_add arch_atomic_fetch_add
+#elif defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
-arch_atomic_add_return(int i, atomic_t *v)
+raw_atomic_fetch_add(int i, atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_add_return_relaxed(i, v);
+	ret = arch_atomic_fetch_add_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_add_return arch_atomic_add_return
+#else
+#error "Unable to define raw_atomic_fetch_add"
 #endif
 
-#endif /* arch_atomic_add_return_relaxed */
-
-#ifndef arch_atomic_fetch_add_relaxed
-#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add
-#define arch_atomic_fetch_add_release arch_atomic_fetch_add
-#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add
-#else /* arch_atomic_fetch_add_relaxed */
-
-#ifndef arch_atomic_fetch_add_acquire
+#if defined(arch_atomic_fetch_add_acquire)
+#define raw_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
+#elif defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
-arch_atomic_fetch_add_acquire(int i, atomic_t *v)
+raw_atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_fetch_add_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
+#elif defined(arch_atomic_fetch_add)
+#define raw_atomic_fetch_add_acquire arch_atomic_fetch_add
+#else
+#error "Unable to define raw_atomic_fetch_add_acquire"
 #endif
 
-#ifndef arch_atomic_fetch_add_release
+#if defined(arch_atomic_fetch_add_release)
+#define raw_atomic_fetch_add_release arch_atomic_fetch_add_release
+#elif defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
-arch_atomic_fetch_add_release(int i, atomic_t *v)
+raw_atomic_fetch_add_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
-#define arch_atomic_fetch_add_release arch_atomic_fetch_add_release
+#elif defined(arch_atomic_fetch_add)
+#define raw_atomic_fetch_add_release arch_atomic_fetch_add
+#else
+#error "Unable to define raw_atomic_fetch_add_release"
+#endif
+
+#if defined(arch_atomic_fetch_add_relaxed)
+#define raw_atomic_fetch_add_relaxed arch_atomic_fetch_add_relaxed
+#elif defined(arch_atomic_fetch_add)
+#define raw_atomic_fetch_add_relaxed arch_atomic_fetch_add
+#else
+#error "Unable to define raw_atomic_fetch_add_relaxed"
 #endif
 
-#ifndef arch_atomic_fetch_add
+#define raw_atomic_sub arch_atomic_sub
+
+#if defined(arch_atomic_sub_return)
+#define raw_atomic_sub_return arch_atomic_sub_return
+#elif defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
-arch_atomic_fetch_add(int i, atomic_t *v)
+raw_atomic_sub_return(int i, atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_add_relaxed(i, v);
+	ret = arch_atomic_sub_return_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_add arch_atomic_fetch_add
+#else
+#error "Unable to define raw_atomic_sub_return"
 #endif
 
-#endif /* arch_atomic_fetch_add_relaxed */
-
-#ifndef arch_atomic_sub_return_relaxed
-#define arch_atomic_sub_return_acquire arch_atomic_sub_return
-#define arch_atomic_sub_return_release arch_atomic_sub_return
-#define arch_atomic_sub_return_relaxed arch_atomic_sub_return
-#else /* arch_atomic_sub_return_relaxed */
-
-#ifndef arch_atomic_sub_return_acquire
+#if defined(arch_atomic_sub_return_acquire)
+#define raw_atomic_sub_return_acquire arch_atomic_sub_return_acquire
+#elif defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
-arch_atomic_sub_return_acquire(int i, atomic_t *v)
+raw_atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_sub_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
+#elif defined(arch_atomic_sub_return)
+#define raw_atomic_sub_return_acquire arch_atomic_sub_return
+#else
+#error "Unable to define raw_atomic_sub_return_acquire"
 #endif
 
-#ifndef arch_atomic_sub_return_release
+#if defined(arch_atomic_sub_return_release)
+#define raw_atomic_sub_return_release arch_atomic_sub_return_release
+#elif defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
-arch_atomic_sub_return_release(int i, atomic_t *v)
+raw_atomic_sub_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_sub_return_relaxed(i, v);
 }
-#define arch_atomic_sub_return_release arch_atomic_sub_return_release
+#elif defined(arch_atomic_sub_return)
+#define raw_atomic_sub_return_release arch_atomic_sub_return
+#else
+#error "Unable to define raw_atomic_sub_return_release"
+#endif
+
+#if defined(arch_atomic_sub_return_relaxed)
+#define raw_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
+#elif defined(arch_atomic_sub_return)
+#define raw_atomic_sub_return_relaxed arch_atomic_sub_return
+#else
+#error "Unable to define raw_atomic_sub_return_relaxed"
 #endif
 
-#ifndef arch_atomic_sub_return
+#if defined(arch_atomic_fetch_sub)
+#define raw_atomic_fetch_sub arch_atomic_fetch_sub
+#elif defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
-arch_atomic_sub_return(int i, atomic_t *v)
+raw_atomic_fetch_sub(int i, atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_sub_return_relaxed(i, v);
+	ret = arch_atomic_fetch_sub_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_sub_return arch_atomic_sub_return
+#else
+#error "Unable to define raw_atomic_fetch_sub"
 #endif
 
-#endif /* arch_atomic_sub_return_relaxed */
-
-#ifndef arch_atomic_fetch_sub_relaxed
-#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
-#else /* arch_atomic_fetch_sub_relaxed */
-
-#ifndef arch_atomic_fetch_sub_acquire
+#if defined(arch_atomic_fetch_sub_acquire)
+#define raw_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
+#elif defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
-arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
+raw_atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_fetch_sub_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
+#elif defined(arch_atomic_fetch_sub)
+#define raw_atomic_fetch_sub_acquire arch_atomic_fetch_sub
+#else
+#error "Unable to define raw_atomic_fetch_sub_acquire"
 #endif
 
-#ifndef arch_atomic_fetch_sub_release
+#if defined(arch_atomic_fetch_sub_release)
+#define raw_atomic_fetch_sub_release arch_atomic_fetch_sub_release
+#elif defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
-arch_atomic_fetch_sub_release(int i, atomic_t *v)
+raw_atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
-#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub_release
+#elif defined(arch_atomic_fetch_sub)
+#define raw_atomic_fetch_sub_release arch_atomic_fetch_sub
+#else
+#error "Unable to define raw_atomic_fetch_sub_release"
 #endif
 
-#ifndef arch_atomic_fetch_sub
-static __always_inline int
-arch_atomic_fetch_sub(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_sub_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#if defined(arch_atomic_fetch_sub_relaxed)
+#define raw_atomic_fetch_sub_relaxed arch_atomic_fetch_sub_relaxed
+#elif defined(arch_atomic_fetch_sub)
+#define raw_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
+#else
+#error "Unable to define raw_atomic_fetch_sub_relaxed"
 #endif
 
-#endif /* arch_atomic_fetch_sub_relaxed */
-
-#ifndef arch_atomic_inc
+#if defined(arch_atomic_inc)
+#define raw_atomic_inc arch_atomic_inc
+#else
 static __always_inline void
-arch_atomic_inc(atomic_t *v)
+raw_atomic_inc(atomic_t *v)
 {
-	arch_atomic_add(1, v);
+	raw_atomic_add(1, v);
 }
-#define arch_atomic_inc arch_atomic_inc
 #endif
 
-#ifndef arch_atomic_inc_return_relaxed
-#ifdef arch_atomic_inc_return
-#define arch_atomic_inc_return_acquire arch_atomic_inc_return
-#define arch_atomic_inc_return_release arch_atomic_inc_return
-#define arch_atomic_inc_return_relaxed arch_atomic_inc_return
-#endif /* arch_atomic_inc_return */
-
-#ifndef arch_atomic_inc_return
+#if defined(arch_atomic_inc_return)
+#define raw_atomic_inc_return arch_atomic_inc_return
+#elif defined(arch_atomic_inc_return_relaxed)
+static __always_inline int
+raw_atomic_inc_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#else
 static __always_inline int
-arch_atomic_inc_return(atomic_t *v)
+raw_atomic_inc_return(atomic_t *v)
 {
-	return arch_atomic_add_return(1, v);
+	return raw_atomic_add_return(1, v);
 }
-#define arch_atomic_inc_return arch_atomic_inc_return
 #endif
 
-#ifndef arch_atomic_inc_return_acquire
+#if defined(arch_atomic_inc_return_acquire)
+#define raw_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#elif defined(arch_atomic_inc_return_relaxed)
 static __always_inline int
-arch_atomic_inc_return_acquire(atomic_t *v)
+raw_atomic_inc_return_acquire(atomic_t *v)
 {
-	return arch_atomic_add_return_acquire(1, v);
+	int ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
-#endif
-
-#ifndef arch_atomic_inc_return_release
+#elif defined(arch_atomic_inc_return)
+#define raw_atomic_inc_return_acquire arch_atomic_inc_return
+#else
 static __always_inline int
-arch_atomic_inc_return_release(atomic_t *v)
+raw_atomic_inc_return_acquire(atomic_t *v)
 {
-	return arch_atomic_add_return_release(1, v);
+	return raw_atomic_add_return_acquire(1, v);
 }
-#define arch_atomic_inc_return_release arch_atomic_inc_return_release
 #endif
 
-#ifndef arch_atomic_inc_return_relaxed
+#if defined(arch_atomic_inc_return_release)
+#define raw_atomic_inc_return_release arch_atomic_inc_return_release
+#elif defined(arch_atomic_inc_return_relaxed)
 static __always_inline int
-arch_atomic_inc_return_relaxed(atomic_t *v)
+raw_atomic_inc_return_release(atomic_t *v)
 {
-	return arch_atomic_add_return_relaxed(1, v);
+	__atomic_release_fence();
+	return arch_atomic_inc_return_relaxed(v);
 }
-#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
-#endif
-
-#else /* arch_atomic_inc_return_relaxed */
-
-#ifndef arch_atomic_inc_return_acquire
+#elif defined(arch_atomic_inc_return)
+#define raw_atomic_inc_return_release arch_atomic_inc_return
+#else
 static __always_inline int
-arch_atomic_inc_return_acquire(atomic_t *v)
+raw_atomic_inc_return_release(atomic_t *v)
 {
-	int ret = arch_atomic_inc_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic_add_return_release(1, v);
 }
-#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
 #endif
 
-#ifndef arch_atomic_inc_return_release
+#if defined(arch_atomic_inc_return_relaxed)
+#define raw_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+#elif defined(arch_atomic_inc_return)
+#define raw_atomic_inc_return_relaxed arch_atomic_inc_return
+#else
 static __always_inline int
-arch_atomic_inc_return_release(atomic_t *v)
+raw_atomic_inc_return_relaxed(atomic_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic_inc_return_relaxed(v);
+	return raw_atomic_add_return_relaxed(1, v);
 }
-#define arch_atomic_inc_return_release arch_atomic_inc_return_release
 #endif
 
-#ifndef arch_atomic_inc_return
+#if defined(arch_atomic_fetch_inc)
+#define raw_atomic_fetch_inc arch_atomic_fetch_inc
+#elif defined(arch_atomic_fetch_inc_relaxed)
 static __always_inline int
-arch_atomic_inc_return(atomic_t *v)
+raw_atomic_fetch_inc(atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_inc_return_relaxed(v);
+	ret = arch_atomic_fetch_inc_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_inc_return arch_atomic_inc_return
-#endif
-
-#endif /* arch_atomic_inc_return_relaxed */
-
-#ifndef arch_atomic_fetch_inc_relaxed
-#ifdef arch_atomic_fetch_inc
-#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc
-#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc
-#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
-#endif /* arch_atomic_fetch_inc */
-
-#ifndef arch_atomic_fetch_inc
+#else
 static __always_inline int
-arch_atomic_fetch_inc(atomic_t *v)
+raw_atomic_fetch_inc(atomic_t *v)
 {
-	return arch_atomic_fetch_add(1, v);
+	return raw_atomic_fetch_add(1, v);
 }
-#define arch_atomic_fetch_inc arch_atomic_fetch_inc
 #endif
 
-#ifndef arch_atomic_fetch_inc_acquire
+#if defined(arch_atomic_fetch_inc_acquire)
+#define raw_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#elif defined(arch_atomic_fetch_inc_relaxed)
 static __always_inline int
-arch_atomic_fetch_inc_acquire(atomic_t *v)
+raw_atomic_fetch_inc_acquire(atomic_t *v)
 {
-	return arch_atomic_fetch_add_acquire(1, v);
+	int ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
-#endif
-
-#ifndef arch_atomic_fetch_inc_release
+#elif defined(arch_atomic_fetch_inc)
+#define raw_atomic_fetch_inc_acquire arch_atomic_fetch_inc
+#else
 static __always_inline int
-arch_atomic_fetch_inc_release(atomic_t *v)
+raw_atomic_fetch_inc_acquire(atomic_t *v)
 {
-	return arch_atomic_fetch_add_release(1, v);
+	return raw_atomic_fetch_add_acquire(1, v);
 }
-#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
 #endif
 
-#ifndef arch_atomic_fetch_inc_relaxed
+#if defined(arch_atomic_fetch_inc_release)
+#define raw_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#elif defined(arch_atomic_fetch_inc_relaxed)
+static __always_inline int
+raw_atomic_fetch_inc_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+#elif defined(arch_atomic_fetch_inc)
+#define raw_atomic_fetch_inc_release arch_atomic_fetch_inc
+#else
 static __always_inline int
-arch_atomic_fetch_inc_relaxed(atomic_t *v)
+raw_atomic_fetch_inc_release(atomic_t *v)
 {
-	return arch_atomic_fetch_add_relaxed(1, v);
+	return raw_atomic_fetch_add_release(1, v);
 }
-#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
 #endif
 
-#else /* arch_atomic_fetch_inc_relaxed */
-
-#ifndef arch_atomic_fetch_inc_acquire
+#if defined(arch_atomic_fetch_inc_relaxed)
+#define raw_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
+#elif defined(arch_atomic_fetch_inc)
+#define raw_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
+#else
 static __always_inline int
-arch_atomic_fetch_inc_acquire(atomic_t *v)
+raw_atomic_fetch_inc_relaxed(atomic_t *v)
 {
-	int ret = arch_atomic_fetch_inc_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic_fetch_add_relaxed(1, v);
 }
-#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
 #endif
 
-#ifndef arch_atomic_fetch_inc_release
-static __always_inline int
-arch_atomic_fetch_inc_release(atomic_t *v)
+#if defined(arch_atomic_dec)
+#define raw_atomic_dec arch_atomic_dec
+#else
+static __always_inline void
+raw_atomic_dec(atomic_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic_fetch_inc_relaxed(v);
+	raw_atomic_sub(1, v);
 }
-#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
 #endif
 
-#ifndef arch_atomic_fetch_inc
+#if defined(arch_atomic_dec_return)
+#define raw_atomic_dec_return arch_atomic_dec_return
+#elif defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
-arch_atomic_fetch_inc(atomic_t *v)
+raw_atomic_dec_return(atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_inc_relaxed(v);
+	ret = arch_atomic_dec_return_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_inc arch_atomic_fetch_inc
-#endif
-
-#endif /* arch_atomic_fetch_inc_relaxed */
-
-#ifndef arch_atomic_dec
-static __always_inline void
-arch_atomic_dec(atomic_t *v)
-{
-	arch_atomic_sub(1, v);
-}
-#define arch_atomic_dec arch_atomic_dec
-#endif
-
-#ifndef arch_atomic_dec_return_relaxed
-#ifdef arch_atomic_dec_return
-#define arch_atomic_dec_return_acquire arch_atomic_dec_return
-#define arch_atomic_dec_return_release arch_atomic_dec_return
-#define arch_atomic_dec_return_relaxed arch_atomic_dec_return
-#endif /* arch_atomic_dec_return */
-
-#ifndef arch_atomic_dec_return
+#else
 static __always_inline int
-arch_atomic_dec_return(atomic_t *v)
+raw_atomic_dec_return(atomic_t *v)
 {
-	return arch_atomic_sub_return(1, v);
+	return raw_atomic_sub_return(1, v);
 }
-#define arch_atomic_dec_return arch_atomic_dec_return
 #endif
 
-#ifndef arch_atomic_dec_return_acquire
+#if defined(arch_atomic_dec_return_acquire)
+#define raw_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#elif defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
-arch_atomic_dec_return_acquire(atomic_t *v)
+raw_atomic_dec_return_acquire(atomic_t *v)
 {
-	return arch_atomic_sub_return_acquire(1, v);
+	int ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
-#endif
-
-#ifndef arch_atomic_dec_return_release
+#elif defined(arch_atomic_dec_return)
+#define raw_atomic_dec_return_acquire arch_atomic_dec_return
+#else
 static __always_inline int
-arch_atomic_dec_return_release(atomic_t *v)
+raw_atomic_dec_return_acquire(atomic_t *v)
 {
-	return arch_atomic_sub_return_release(1, v);
+	return raw_atomic_sub_return_acquire(1, v);
 }
-#define arch_atomic_dec_return_release arch_atomic_dec_return_release
 #endif
 
-#ifndef arch_atomic_dec_return_relaxed
+#if defined(arch_atomic_dec_return_release)
+#define raw_atomic_dec_return_release arch_atomic_dec_return_release
+#elif defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
-arch_atomic_dec_return_relaxed(atomic_t *v)
+raw_atomic_dec_return_release(atomic_t *v)
 {
-	return arch_atomic_sub_return_relaxed(1, v);
+	__atomic_release_fence();
+	return arch_atomic_dec_return_relaxed(v);
 }
-#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
-#endif
-
-#else /* arch_atomic_dec_return_relaxed */
-
-#ifndef arch_atomic_dec_return_acquire
+#elif defined(arch_atomic_dec_return)
+#define raw_atomic_dec_return_release arch_atomic_dec_return
+#else
 static __always_inline int
-arch_atomic_dec_return_acquire(atomic_t *v)
+raw_atomic_dec_return_release(atomic_t *v)
 {
-	int ret = arch_atomic_dec_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic_sub_return_release(1, v);
 }
-#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
 #endif
 
-#ifndef arch_atomic_dec_return_release
+#if defined(arch_atomic_dec_return_relaxed)
+#define raw_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
+#elif defined(arch_atomic_dec_return)
+#define raw_atomic_dec_return_relaxed arch_atomic_dec_return
+#else
 static __always_inline int
-arch_atomic_dec_return_release(atomic_t *v)
+raw_atomic_dec_return_relaxed(atomic_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic_dec_return_relaxed(v);
+	return raw_atomic_sub_return_relaxed(1, v);
 }
-#define arch_atomic_dec_return_release arch_atomic_dec_return_release
 #endif
 
-#ifndef arch_atomic_dec_return
+#if defined(arch_atomic_fetch_dec)
+#define raw_atomic_fetch_dec arch_atomic_fetch_dec
+#elif defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
-arch_atomic_dec_return(atomic_t *v)
+raw_atomic_fetch_dec(atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_dec_return_relaxed(v);
+	ret = arch_atomic_fetch_dec_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_dec_return arch_atomic_dec_return
-#endif
-
-#endif /* arch_atomic_dec_return_relaxed */
-
-#ifndef arch_atomic_fetch_dec_relaxed
-#ifdef arch_atomic_fetch_dec
-#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec
-#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec
-#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
-#endif /* arch_atomic_fetch_dec */
-
-#ifndef arch_atomic_fetch_dec
+#else
 static __always_inline int
-arch_atomic_fetch_dec(atomic_t *v)
+raw_atomic_fetch_dec(atomic_t *v)
 {
-	return arch_atomic_fetch_sub(1, v);
+	return raw_atomic_fetch_sub(1, v);
 }
-#define arch_atomic_fetch_dec arch_atomic_fetch_dec
 #endif
 
-#ifndef arch_atomic_fetch_dec_acquire
+#if defined(arch_atomic_fetch_dec_acquire)
+#define raw_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#elif defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
-arch_atomic_fetch_dec_acquire(atomic_t *v)
+raw_atomic_fetch_dec_acquire(atomic_t *v)
 {
-	return arch_atomic_fetch_sub_acquire(1, v);
+	int ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
-#endif
-
-#ifndef arch_atomic_fetch_dec_release
+#elif defined(arch_atomic_fetch_dec)
+#define raw_atomic_fetch_dec_acquire arch_atomic_fetch_dec
+#else
 static __always_inline int
-arch_atomic_fetch_dec_release(atomic_t *v)
+raw_atomic_fetch_dec_acquire(atomic_t *v)
 {
-	return arch_atomic_fetch_sub_release(1, v);
+	return raw_atomic_fetch_sub_acquire(1, v);
 }
-#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
 #endif
 
-#ifndef arch_atomic_fetch_dec_relaxed
+#if defined(arch_atomic_fetch_dec_release)
+#define raw_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#elif defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
-arch_atomic_fetch_dec_relaxed(atomic_t *v)
+raw_atomic_fetch_dec_release(atomic_t *v)
 {
-	return arch_atomic_fetch_sub_relaxed(1, v);
+	__atomic_release_fence();
+	return arch_atomic_fetch_dec_relaxed(v);
 }
-#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
-#endif
-
-#else /* arch_atomic_fetch_dec_relaxed */
-
-#ifndef arch_atomic_fetch_dec_acquire
+#elif defined(arch_atomic_fetch_dec)
+#define raw_atomic_fetch_dec_release arch_atomic_fetch_dec
+#else
 static __always_inline int
-arch_atomic_fetch_dec_acquire(atomic_t *v)
+raw_atomic_fetch_dec_release(atomic_t *v)
 {
-	int ret = arch_atomic_fetch_dec_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic_fetch_sub_release(1, v);
 }
-#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
 #endif
 
-#ifndef arch_atomic_fetch_dec_release
+#if defined(arch_atomic_fetch_dec_relaxed)
+#define raw_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
+#elif defined(arch_atomic_fetch_dec)
+#define raw_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
+#else
 static __always_inline int
-arch_atomic_fetch_dec_release(atomic_t *v)
+raw_atomic_fetch_dec_relaxed(atomic_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic_fetch_dec_relaxed(v);
+	return raw_atomic_fetch_sub_relaxed(1, v);
 }
-#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
 #endif
 
-#ifndef arch_atomic_fetch_dec
+#define raw_atomic_and arch_atomic_and
+
+#if defined(arch_atomic_fetch_and)
+#define raw_atomic_fetch_and arch_atomic_fetch_and
+#elif defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
-arch_atomic_fetch_dec(atomic_t *v)
+raw_atomic_fetch_and(int i, atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_dec_relaxed(v);
+	ret = arch_atomic_fetch_and_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#else
+#error "Unable to define raw_atomic_fetch_and"
 #endif
 
-#endif /* arch_atomic_fetch_dec_relaxed */
-
-#ifndef arch_atomic_fetch_and_relaxed
-#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and
-#define arch_atomic_fetch_and_release arch_atomic_fetch_and
-#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and
-#else /* arch_atomic_fetch_and_relaxed */
-
-#ifndef arch_atomic_fetch_and_acquire
+#if defined(arch_atomic_fetch_and_acquire)
+#define raw_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
+#elif defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
-arch_atomic_fetch_and_acquire(int i, atomic_t *v)
+raw_atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_fetch_and_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
+#elif defined(arch_atomic_fetch_and)
+#define raw_atomic_fetch_and_acquire arch_atomic_fetch_and
+#else
+#error "Unable to define raw_atomic_fetch_and_acquire"
 #endif
 
-#ifndef arch_atomic_fetch_and_release
+#if defined(arch_atomic_fetch_and_release)
+#define raw_atomic_fetch_and_release arch_atomic_fetch_and_release
+#elif defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
-arch_atomic_fetch_and_release(int i, atomic_t *v)
+raw_atomic_fetch_and_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
-#define arch_atomic_fetch_and_release arch_atomic_fetch_and_release
+#elif defined(arch_atomic_fetch_and)
+#define raw_atomic_fetch_and_release arch_atomic_fetch_and
+#else
+#error "Unable to define raw_atomic_fetch_and_release"
 #endif
 
-#ifndef arch_atomic_fetch_and
+#if defined(arch_atomic_fetch_and_relaxed)
+#define raw_atomic_fetch_and_relaxed arch_atomic_fetch_and_relaxed
+#elif defined(arch_atomic_fetch_and)
+#define raw_atomic_fetch_and_relaxed arch_atomic_fetch_and
+#else
+#error "Unable to define raw_atomic_fetch_and_relaxed"
+#endif
+
+#if defined(arch_atomic_andnot)
+#define raw_atomic_andnot arch_atomic_andnot
+#else
+static __always_inline void
+raw_atomic_andnot(int i, atomic_t *v)
+{
+	raw_atomic_and(~i, v);
+}
+#endif
+
+#if defined(arch_atomic_fetch_andnot)
+#define raw_atomic_fetch_andnot arch_atomic_fetch_andnot
+#elif defined(arch_atomic_fetch_andnot_relaxed)
 static __always_inline int
-arch_atomic_fetch_and(int i, atomic_t *v)
+raw_atomic_fetch_andnot(int i, atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_and_relaxed(i, v);
+	ret = arch_atomic_fetch_andnot_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_and arch_atomic_fetch_and
-#endif
-
-#endif /* arch_atomic_fetch_and_relaxed */
-
-#ifndef arch_atomic_andnot
-static __always_inline void
-arch_atomic_andnot(int i, atomic_t *v)
+#else
+static __always_inline int
+raw_atomic_fetch_andnot(int i, atomic_t *v)
 {
-	arch_atomic_and(~i, v);
+	return raw_atomic_fetch_and(~i, v);
 }
-#define arch_atomic_andnot arch_atomic_andnot
 #endif
 
-#ifndef arch_atomic_fetch_andnot_relaxed
-#ifdef arch_atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
-#endif /* arch_atomic_fetch_andnot */
-
-#ifndef arch_atomic_fetch_andnot
+#if defined(arch_atomic_fetch_andnot_acquire)
+#define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#elif defined(arch_atomic_fetch_andnot_relaxed)
+static __always_inline int
+raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#elif defined(arch_atomic_fetch_andnot)
+#define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
+#else
 static __always_inline int
-arch_atomic_fetch_andnot(int i, atomic_t *v)
+raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
-	return arch_atomic_fetch_and(~i, v);
+	return raw_atomic_fetch_and_acquire(~i, v);
 }
-#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
 #endif
 
-#ifndef arch_atomic_fetch_andnot_acquire
+#if defined(arch_atomic_fetch_andnot_release)
+#define raw_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#elif defined(arch_atomic_fetch_andnot_relaxed)
 static __always_inline int
-arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+raw_atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	return arch_atomic_fetch_and_acquire(~i, v);
+	__atomic_release_fence();
+	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
-#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
-#endif
-
-#ifndef arch_atomic_fetch_andnot_release
+#elif defined(arch_atomic_fetch_andnot)
+#define raw_atomic_fetch_andnot_release arch_atomic_fetch_andnot
+#else
 static __always_inline int
-arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+raw_atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	return arch_atomic_fetch_and_release(~i, v);
+	return raw_atomic_fetch_and_release(~i, v);
 }
-#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
 #endif
 
-#ifndef arch_atomic_fetch_andnot_relaxed
+#if defined(arch_atomic_fetch_andnot_relaxed)
+#define raw_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
+#elif defined(arch_atomic_fetch_andnot)
+#define raw_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
+#else
 static __always_inline int
-arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
-	return arch_atomic_fetch_and_relaxed(~i, v);
+	return raw_atomic_fetch_and_relaxed(~i, v);
 }
-#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
 #endif
 
-#else /* arch_atomic_fetch_andnot_relaxed */
+#define raw_atomic_or arch_atomic_or
 
-#ifndef arch_atomic_fetch_andnot_acquire
+#if defined(arch_atomic_fetch_or)
+#define raw_atomic_fetch_or arch_atomic_fetch_or
+#elif defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
-arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+raw_atomic_fetch_or(int i, atomic_t *v)
 {
-	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
-	__atomic_acquire_fence();
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#else
+#error "Unable to define raw_atomic_fetch_or"
 #endif
 
-#ifndef arch_atomic_fetch_andnot_release
+#if defined(arch_atomic_fetch_or_acquire)
+#define raw_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
+#elif defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
-arch_atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_andnot_relaxed(i, v);
-}
-#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
-#endif
-
-#ifndef arch_atomic_fetch_andnot
-static __always_inline int
-arch_atomic_fetch_andnot(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_andnot_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
-#endif
-
-#endif /* arch_atomic_fetch_andnot_relaxed */
-
-#ifndef arch_atomic_fetch_or_relaxed
-#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or
-#define arch_atomic_fetch_or_release arch_atomic_fetch_or
-#define arch_atomic_fetch_or_relaxed arch_atomic_fetch_or
-#else /* arch_atomic_fetch_or_relaxed */
-
-#ifndef arch_atomic_fetch_or_acquire
-static __always_inline int
-arch_atomic_fetch_or_acquire(int i, atomic_t *v)
+raw_atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_fetch_or_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
+#elif defined(arch_atomic_fetch_or)
+#define raw_atomic_fetch_or_acquire arch_atomic_fetch_or
+#else
+#error "Unable to define raw_atomic_fetch_or_acquire"
 #endif
 
-#ifndef arch_atomic_fetch_or_release
+#if defined(arch_atomic_fetch_or_release)
+#define raw_atomic_fetch_or_release arch_atomic_fetch_or_release
+#elif defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
-arch_atomic_fetch_or_release(int i, atomic_t *v)
+raw_atomic_fetch_or_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
-#define arch_atomic_fetch_or_release arch_atomic_fetch_or_release
+#elif defined(arch_atomic_fetch_or)
+#define raw_atomic_fetch_or_release arch_atomic_fetch_or
+#else
+#error "Unable to define raw_atomic_fetch_or_release"
 #endif
 
-#ifndef arch_atomic_fetch_or
+#if defined(arch_atomic_fetch_or_relaxed)
+#define raw_atomic_fetch_or_relaxed arch_atomic_fetch_or_relaxed
+#elif defined(arch_atomic_fetch_or)
+#define raw_atomic_fetch_or_relaxed arch_atomic_fetch_or
+#else
+#error "Unable to define raw_atomic_fetch_or_relaxed"
+#endif
+
+#define raw_atomic_xor arch_atomic_xor
+
+#if defined(arch_atomic_fetch_xor)
+#define raw_atomic_fetch_xor arch_atomic_fetch_xor
+#elif defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
-arch_atomic_fetch_or(int i, atomic_t *v)
+raw_atomic_fetch_xor(int i, atomic_t *v)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_or_relaxed(i, v);
+	ret = arch_atomic_fetch_xor_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_or arch_atomic_fetch_or
+#else
+#error "Unable to define raw_atomic_fetch_xor"
 #endif
 
-#endif /* arch_atomic_fetch_or_relaxed */
-
-#ifndef arch_atomic_fetch_xor_relaxed
-#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
-#else /* arch_atomic_fetch_xor_relaxed */
-
-#ifndef arch_atomic_fetch_xor_acquire
+#if defined(arch_atomic_fetch_xor_acquire)
+#define raw_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
+#elif defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
-arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
+raw_atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	int ret = arch_atomic_fetch_xor_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
+#elif defined(arch_atomic_fetch_xor)
+#define raw_atomic_fetch_xor_acquire arch_atomic_fetch_xor
+#else
+#error "Unable to define raw_atomic_fetch_xor_acquire"
 #endif
 
-#ifndef arch_atomic_fetch_xor_release
+#if defined(arch_atomic_fetch_xor_release)
+#define raw_atomic_fetch_xor_release arch_atomic_fetch_xor_release
+#elif defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
-arch_atomic_fetch_xor_release(int i, atomic_t *v)
+raw_atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
-#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor_release
+#elif defined(arch_atomic_fetch_xor)
+#define raw_atomic_fetch_xor_release arch_atomic_fetch_xor
+#else
+#error "Unable to define raw_atomic_fetch_xor_release"
 #endif
 
-#ifndef arch_atomic_fetch_xor
+#if defined(arch_atomic_fetch_xor_relaxed)
+#define raw_atomic_fetch_xor_relaxed arch_atomic_fetch_xor_relaxed
+#elif defined(arch_atomic_fetch_xor)
+#define raw_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
+#else
+#error "Unable to define raw_atomic_fetch_xor_relaxed"
+#endif
+
+#if defined(arch_atomic_xchg)
+#define raw_atomic_xchg arch_atomic_xchg
+#elif defined(arch_atomic_xchg_relaxed)
 static __always_inline int
-arch_atomic_fetch_xor(int i, atomic_t *v)
+raw_atomic_xchg(atomic_t *v, int i)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_xor_relaxed(i, v);
+	ret = arch_atomic_xchg_relaxed(v, i);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_fetch_xor arch_atomic_fetch_xor
-#endif
-
-#endif /* arch_atomic_fetch_xor_relaxed */
-
-#ifndef arch_atomic_xchg_relaxed
-#ifdef arch_atomic_xchg
-#define arch_atomic_xchg_acquire arch_atomic_xchg
-#define arch_atomic_xchg_release arch_atomic_xchg
-#define arch_atomic_xchg_relaxed arch_atomic_xchg
-#endif /* arch_atomic_xchg */
-
-#ifndef arch_atomic_xchg
+#else
 static __always_inline int
-arch_atomic_xchg(atomic_t *v, int new)
+raw_atomic_xchg(atomic_t *v, int new)
 {
-	return arch_xchg(&v->counter, new);
+	return raw_xchg(&v->counter, new);
 }
-#define arch_atomic_xchg arch_atomic_xchg
 #endif
 
-#ifndef arch_atomic_xchg_acquire
+#if defined(arch_atomic_xchg_acquire)
+#define raw_atomic_xchg_acquire arch_atomic_xchg_acquire
+#elif defined(arch_atomic_xchg_relaxed)
 static __always_inline int
-arch_atomic_xchg_acquire(atomic_t *v, int new)
+raw_atomic_xchg_acquire(atomic_t *v, int i)
 {
-	return arch_xchg_acquire(&v->counter, new);
+	int ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
-#endif
-
-#ifndef arch_atomic_xchg_release
+#elif defined(arch_atomic_xchg)
+#define raw_atomic_xchg_acquire arch_atomic_xchg
+#else
 static __always_inline int
-arch_atomic_xchg_release(atomic_t *v, int new)
+raw_atomic_xchg_acquire(atomic_t *v, int new)
 {
-	return arch_xchg_release(&v->counter, new);
+	return raw_xchg_acquire(&v->counter, new);
 }
-#define arch_atomic_xchg_release arch_atomic_xchg_release
 #endif
 
-#ifndef arch_atomic_xchg_relaxed
+#if defined(arch_atomic_xchg_release)
+#define raw_atomic_xchg_release arch_atomic_xchg_release
+#elif defined(arch_atomic_xchg_relaxed)
 static __always_inline int
-arch_atomic_xchg_relaxed(atomic_t *v, int new)
+raw_atomic_xchg_release(atomic_t *v, int i)
 {
-	return arch_xchg_relaxed(&v->counter, new);
+	__atomic_release_fence();
+	return arch_atomic_xchg_relaxed(v, i);
 }
-#define arch_atomic_xchg_relaxed arch_atomic_xchg_relaxed
-#endif
-
-#else /* arch_atomic_xchg_relaxed */
-
-#ifndef arch_atomic_xchg_acquire
+#elif defined(arch_atomic_xchg)
+#define raw_atomic_xchg_release arch_atomic_xchg
+#else
 static __always_inline int
-arch_atomic_xchg_acquire(atomic_t *v, int i)
+raw_atomic_xchg_release(atomic_t *v, int new)
 {
-	int ret = arch_atomic_xchg_relaxed(v, i);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_xchg_release(&v->counter, new);
 }
-#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
 #endif
 
-#ifndef arch_atomic_xchg_release
+#if defined(arch_atomic_xchg_relaxed)
+#define raw_atomic_xchg_relaxed arch_atomic_xchg_relaxed
+#elif defined(arch_atomic_xchg)
+#define raw_atomic_xchg_relaxed arch_atomic_xchg
+#else
 static __always_inline int
-arch_atomic_xchg_release(atomic_t *v, int i)
+raw_atomic_xchg_relaxed(atomic_t *v, int new)
 {
-	__atomic_release_fence();
-	return arch_atomic_xchg_relaxed(v, i);
+	return raw_xchg_relaxed(&v->counter, new);
 }
-#define arch_atomic_xchg_release arch_atomic_xchg_release
 #endif
 
-#ifndef arch_atomic_xchg
+#if defined(arch_atomic_cmpxchg)
+#define raw_atomic_cmpxchg arch_atomic_cmpxchg
+#elif defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
-arch_atomic_xchg(atomic_t *v, int i)
+raw_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_xchg_relaxed(v, i);
+	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_xchg arch_atomic_xchg
-#endif
-
-#endif /* arch_atomic_xchg_relaxed */
-
-#ifndef arch_atomic_cmpxchg_relaxed
-#ifdef arch_atomic_cmpxchg
-#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
-#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
-#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
-#endif /* arch_atomic_cmpxchg */
-
-#ifndef arch_atomic_cmpxchg
+#else
 static __always_inline int
-arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+raw_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-	return arch_cmpxchg(&v->counter, old, new);
+	return raw_cmpxchg(&v->counter, old, new);
 }
-#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 #endif
 
-#ifndef arch_atomic_cmpxchg_acquire
+#if defined(arch_atomic_cmpxchg_acquire)
+#define raw_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
+#elif defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
-arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	return arch_cmpxchg_acquire(&v->counter, old, new);
+	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic_cmpxchg_release
+#elif defined(arch_atomic_cmpxchg)
+#define raw_atomic_cmpxchg_acquire arch_atomic_cmpxchg
+#else
 static __always_inline int
-arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	return arch_cmpxchg_release(&v->counter, old, new);
+	return raw_cmpxchg_acquire(&v->counter, old, new);
 }
-#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
 #endif
 
-#ifndef arch_atomic_cmpxchg_relaxed
+#if defined(arch_atomic_cmpxchg_release)
+#define raw_atomic_cmpxchg_release arch_atomic_cmpxchg_release
+#elif defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
-arch_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	return arch_cmpxchg_relaxed(&v->counter, old, new);
+	__atomic_release_fence();
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
-#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg_relaxed
-#endif
-
-#else /* arch_atomic_cmpxchg_relaxed */
-
-#ifndef arch_atomic_cmpxchg_acquire
+#elif defined(arch_atomic_cmpxchg)
+#define raw_atomic_cmpxchg_release arch_atomic_cmpxchg
+#else
 static __always_inline int
-arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_cmpxchg_release(&v->counter, old, new);
 }
-#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
 #endif
 
-#ifndef arch_atomic_cmpxchg_release
+#if defined(arch_atomic_cmpxchg_relaxed)
+#define raw_atomic_cmpxchg_relaxed arch_atomic_cmpxchg_relaxed
+#elif defined(arch_atomic_cmpxchg)
+#define raw_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
+#else
 static __always_inline int
-arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
-	__atomic_release_fence();
-	return arch_atomic_cmpxchg_relaxed(v, old, new);
+	return raw_cmpxchg_relaxed(&v->counter, old, new);
 }
-#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
 #endif
 
-#ifndef arch_atomic_cmpxchg
-static __always_inline int
-arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+#if defined(arch_atomic_try_cmpxchg)
+#define raw_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#elif defined(arch_atomic_try_cmpxchg_relaxed)
+static __always_inline bool
+raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	int ret;
+	bool ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic_cmpxchg arch_atomic_cmpxchg
-#endif
-
-#endif /* arch_atomic_cmpxchg_relaxed */
-
-#ifndef arch_atomic_try_cmpxchg_relaxed
-#ifdef arch_atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
-#endif /* arch_atomic_try_cmpxchg */
-
-#ifndef arch_atomic_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
-	r = arch_atomic_cmpxchg(v, o, new);
+	r = raw_atomic_cmpxchg(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 #endif
 
-#ifndef arch_atomic_try_cmpxchg_acquire
+#if defined(arch_atomic_try_cmpxchg_acquire)
+#define raw_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#elif defined(arch_atomic_try_cmpxchg_relaxed)
+static __always_inline bool
+raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#elif defined(arch_atomic_try_cmpxchg)
+#define raw_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
-	r = arch_atomic_cmpxchg_acquire(v, o, new);
+	r = raw_atomic_cmpxchg_acquire(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
 #endif
 
-#ifndef arch_atomic_try_cmpxchg_release
+#if defined(arch_atomic_try_cmpxchg_release)
+#define raw_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#elif defined(arch_atomic_try_cmpxchg_relaxed)
 static __always_inline bool
-arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+#elif defined(arch_atomic_try_cmpxchg)
+#define raw_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
+#else
+static __always_inline bool
+raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
-	r = arch_atomic_cmpxchg_release(v, o, new);
+	r = raw_atomic_cmpxchg_release(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
 #endif
 
-#ifndef arch_atomic_try_cmpxchg_relaxed
+#if defined(arch_atomic_try_cmpxchg_relaxed)
+#define raw_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
+#elif defined(arch_atomic_try_cmpxchg)
+#define raw_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
-	r = arch_atomic_cmpxchg_relaxed(v, o, new);
+	r = raw_atomic_cmpxchg_relaxed(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
-#endif
-
-#else /* arch_atomic_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic_try_cmpxchg_acquire
-static __always_inline bool
-arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic_try_cmpxchg_release
-static __always_inline bool
-arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	__atomic_release_fence();
-	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-}
-#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
-#endif
-
-#ifndef arch_atomic_try_cmpxchg
-static __always_inline bool
-arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 #endif
 
-#endif /* arch_atomic_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic_sub_and_test
+#if defined(arch_atomic_sub_and_test)
+#define raw_atomic_sub_and_test arch_atomic_sub_and_test
+#else
 static __always_inline bool
-arch_atomic_sub_and_test(int i, atomic_t *v)
+raw_atomic_sub_and_test(int i, atomic_t *v)
 {
-	return arch_atomic_sub_return(i, v) == 0;
+	return raw_atomic_sub_return(i, v) == 0;
 }
-#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 #endif
 
-#ifndef arch_atomic_dec_and_test
+#if defined(arch_atomic_dec_and_test)
+#define raw_atomic_dec_and_test arch_atomic_dec_and_test
+#else
 static __always_inline bool
-arch_atomic_dec_and_test(atomic_t *v)
+raw_atomic_dec_and_test(atomic_t *v)
 {
-	return arch_atomic_dec_return(v) == 0;
+	return raw_atomic_dec_return(v) == 0;
 }
-#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 #endif
 
-#ifndef arch_atomic_inc_and_test
+#if defined(arch_atomic_inc_and_test)
+#define raw_atomic_inc_and_test arch_atomic_inc_and_test
+#else
 static __always_inline bool
-arch_atomic_inc_and_test(atomic_t *v)
+raw_atomic_inc_and_test(atomic_t *v)
 {
-	return arch_atomic_inc_return(v) == 0;
+	return raw_atomic_inc_return(v) == 0;
 }
-#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 #endif
 
-#ifndef arch_atomic_add_negative_relaxed
-#ifdef arch_atomic_add_negative
-#define arch_atomic_add_negative_acquire arch_atomic_add_negative
-#define arch_atomic_add_negative_release arch_atomic_add_negative
-#define arch_atomic_add_negative_relaxed arch_atomic_add_negative
-#endif /* arch_atomic_add_negative */
-
-#ifndef arch_atomic_add_negative
+#if defined(arch_atomic_add_negative)
+#define raw_atomic_add_negative arch_atomic_add_negative
+#elif defined(arch_atomic_add_negative_relaxed)
 static __always_inline bool
-arch_atomic_add_negative(int i, atomic_t *v)
+raw_atomic_add_negative(int i, atomic_t *v)
 {
-	return arch_atomic_add_return(i, v) < 0;
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_add_negative_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
 }
-#define arch_atomic_add_negative arch_atomic_add_negative
-#endif
-
-#ifndef arch_atomic_add_negative_acquire
+#else
 static __always_inline bool
-arch_atomic_add_negative_acquire(int i, atomic_t *v)
+raw_atomic_add_negative(int i, atomic_t *v)
 {
-	return arch_atomic_add_return_acquire(i, v) < 0;
+	return raw_atomic_add_return(i, v) < 0;
 }
-#define arch_atomic_add_negative_acquire arch_atomic_add_negative_acquire
 #endif
 
-#ifndef arch_atomic_add_negative_release
+#if defined(arch_atomic_add_negative_acquire)
+#define raw_atomic_add_negative_acquire arch_atomic_add_negative_acquire
+#elif defined(arch_atomic_add_negative_relaxed)
 static __always_inline bool
-arch_atomic_add_negative_release(int i, atomic_t *v)
+raw_atomic_add_negative_acquire(int i, atomic_t *v)
 {
-	return arch_atomic_add_return_release(i, v) < 0;
+	bool ret = arch_atomic_add_negative_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic_add_negative_release arch_atomic_add_negative_release
-#endif
-
-#ifndef arch_atomic_add_negative_relaxed
+#elif defined(arch_atomic_add_negative)
+#define raw_atomic_add_negative_acquire arch_atomic_add_negative
+#else
 static __always_inline bool
-arch_atomic_add_negative_relaxed(int i, atomic_t *v)
+raw_atomic_add_negative_acquire(int i, atomic_t *v)
 {
-	return arch_atomic_add_return_relaxed(i, v) < 0;
+	return raw_atomic_add_return_acquire(i, v) < 0;
 }
-#define arch_atomic_add_negative_relaxed arch_atomic_add_negative_relaxed
 #endif
 
-#else /* arch_atomic_add_negative_relaxed */
-
-#ifndef arch_atomic_add_negative_acquire
+#if defined(arch_atomic_add_negative_release)
+#define raw_atomic_add_negative_release arch_atomic_add_negative_release
+#elif defined(arch_atomic_add_negative_relaxed)
 static __always_inline bool
-arch_atomic_add_negative_acquire(int i, atomic_t *v)
+raw_atomic_add_negative_release(int i, atomic_t *v)
 {
-	bool ret = arch_atomic_add_negative_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
+	__atomic_release_fence();
+	return arch_atomic_add_negative_relaxed(i, v);
 }
-#define arch_atomic_add_negative_acquire arch_atomic_add_negative_acquire
-#endif
-
-#ifndef arch_atomic_add_negative_release
+#elif defined(arch_atomic_add_negative)
+#define raw_atomic_add_negative_release arch_atomic_add_negative
+#else
 static __always_inline bool
-arch_atomic_add_negative_release(int i, atomic_t *v)
+raw_atomic_add_negative_release(int i, atomic_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic_add_negative_relaxed(i, v);
+	return raw_atomic_add_return_release(i, v) < 0;
 }
-#define arch_atomic_add_negative_release arch_atomic_add_negative_release
 #endif
 
-#ifndef arch_atomic_add_negative
+#if defined(arch_atomic_add_negative_relaxed)
+#define raw_atomic_add_negative_relaxed arch_atomic_add_negative_relaxed
+#elif defined(arch_atomic_add_negative)
+#define raw_atomic_add_negative_relaxed arch_atomic_add_negative
+#else
 static __always_inline bool
-arch_atomic_add_negative(int i, atomic_t *v)
+raw_atomic_add_negative_relaxed(int i, atomic_t *v)
 {
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_add_negative_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
+	return raw_atomic_add_return_relaxed(i, v) < 0;
 }
-#define arch_atomic_add_negative arch_atomic_add_negative
 #endif
 
-#endif /* arch_atomic_add_negative_relaxed */
-
-#ifndef arch_atomic_fetch_add_unless
+#if defined(arch_atomic_fetch_add_unless)
+#define raw_atomic_fetch_add_unless arch_atomic_fetch_add_unless
+#else
 static __always_inline int
-arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
-	int c = arch_atomic_read(v);
+	int c = raw_atomic_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
+	} while (!raw_atomic_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
-#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 #endif
 
-#ifndef arch_atomic_add_unless
+#if defined(arch_atomic_add_unless)
+#define raw_atomic_add_unless arch_atomic_add_unless
+#else
 static __always_inline bool
-arch_atomic_add_unless(atomic_t *v, int a, int u)
+raw_atomic_add_unless(atomic_t *v, int a, int u)
 {
-	return arch_atomic_fetch_add_unless(v, a, u) != u;
+	return raw_atomic_fetch_add_unless(v, a, u) != u;
 }
-#define arch_atomic_add_unless arch_atomic_add_unless
 #endif
 
-#ifndef arch_atomic_inc_not_zero
+#if defined(arch_atomic_inc_not_zero)
+#define raw_atomic_inc_not_zero arch_atomic_inc_not_zero
+#else
 static __always_inline bool
-arch_atomic_inc_not_zero(atomic_t *v)
+raw_atomic_inc_not_zero(atomic_t *v)
 {
-	return arch_atomic_add_unless(v, 1, 0);
+	return raw_atomic_add_unless(v, 1, 0);
 }
-#define arch_atomic_inc_not_zero arch_atomic_inc_not_zero
 #endif
 
-#ifndef arch_atomic_inc_unless_negative
+#if defined(arch_atomic_inc_unless_negative)
+#define raw_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+#else
 static __always_inline bool
-arch_atomic_inc_unless_negative(atomic_t *v)
+raw_atomic_inc_unless_negative(atomic_t *v)
 {
-	int c = arch_atomic_read(v);
+	int c = raw_atomic_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
+	} while (!raw_atomic_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
-#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
 #endif
 
-#ifndef arch_atomic_dec_unless_positive
+#if defined(arch_atomic_dec_unless_positive)
+#define raw_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+#else
 static __always_inline bool
-arch_atomic_dec_unless_positive(atomic_t *v)
+raw_atomic_dec_unless_positive(atomic_t *v)
 {
-	int c = arch_atomic_read(v);
+	int c = raw_atomic_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c - 1));
+	} while (!raw_atomic_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
-#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
 #endif
 
-#ifndef arch_atomic_dec_if_positive
+#if defined(arch_atomic_dec_if_positive)
+#define raw_atomic_dec_if_positive arch_atomic_dec_if_positive
+#else
 static __always_inline int
-arch_atomic_dec_if_positive(atomic_t *v)
+raw_atomic_dec_if_positive(atomic_t *v)
 {
-	int dec, c = arch_atomic_read(v);
+	int dec, c = raw_atomic_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!arch_atomic_try_cmpxchg(v, &c, dec));
+	} while (!raw_atomic_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
-#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 #endif
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
 
-#ifndef arch_atomic64_read_acquire
+#define raw_atomic64_read arch_atomic64_read
+
+#if defined(arch_atomic64_read_acquire)
+#define raw_atomic64_read_acquire arch_atomic64_read_acquire
+#elif defined(arch_atomic64_read)
+#define raw_atomic64_read_acquire arch_atomic64_read
+#else
 static __always_inline s64
-arch_atomic64_read_acquire(const atomic64_t *v)
+raw_atomic64_read_acquire(const atomic64_t *v)
 {
 	s64 ret;
 
 	if (__native_word(atomic64_t)) {
 		ret = smp_load_acquire(&(v)->counter);
 	} else {
-		ret = arch_atomic64_read(v);
+		ret = raw_atomic64_read(v);
 		__atomic_acquire_fence();
 	}
 
 	return ret;
 }
-#define arch_atomic64_read_acquire arch_atomic64_read_acquire
 #endif
 
-#ifndef arch_atomic64_set_release
+#define raw_atomic64_set arch_atomic64_set
+
+#if defined(arch_atomic64_set_release)
+#define raw_atomic64_set_release arch_atomic64_set_release
+#elif defined(arch_atomic64_set)
+#define raw_atomic64_set_release arch_atomic64_set
+#else
 static __always_inline void
-arch_atomic64_set_release(atomic64_t *v, s64 i)
+raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
 	if (__native_word(atomic64_t)) {
 		smp_store_release(&(v)->counter, i);
 	} else {
 		__atomic_release_fence();
-		arch_atomic64_set(v, i);
+		raw_atomic64_set(v, i);
 	}
 }
-#define arch_atomic64_set_release arch_atomic64_set_release
 #endif
 
-#ifndef arch_atomic64_add_return_relaxed
-#define arch_atomic64_add_return_acquire arch_atomic64_add_return
-#define arch_atomic64_add_return_release arch_atomic64_add_return
-#define arch_atomic64_add_return_relaxed arch_atomic64_add_return
-#else /* arch_atomic64_add_return_relaxed */
+#define raw_atomic64_add arch_atomic64_add
+
+#if defined(arch_atomic64_add_return)
+#define raw_atomic64_add_return arch_atomic64_add_return
+#elif defined(arch_atomic64_add_return_relaxed)
+static __always_inline s64
+raw_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#else
+#error "Unable to define raw_atomic64_add_return"
+#endif
 
-#ifndef arch_atomic64_add_return_acquire
+#if defined(arch_atomic64_add_return_acquire)
+#define raw_atomic64_add_return_acquire arch_atomic64_add_return_acquire
+#elif defined(arch_atomic64_add_return_relaxed)
 static __always_inline s64
-arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+raw_atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_add_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
+#elif defined(arch_atomic64_add_return)
+#define raw_atomic64_add_return_acquire arch_atomic64_add_return
+#else
+#error "Unable to define raw_atomic64_add_return_acquire"
 #endif
 
-#ifndef arch_atomic64_add_return_release
+#if defined(arch_atomic64_add_return_release)
+#define raw_atomic64_add_return_release arch_atomic64_add_return_release
+#elif defined(arch_atomic64_add_return_relaxed)
 static __always_inline s64
-arch_atomic64_add_return_release(s64 i, atomic64_t *v)
+raw_atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_add_return_relaxed(i, v);
 }
-#define arch_atomic64_add_return_release arch_atomic64_add_return_release
+#elif defined(arch_atomic64_add_return)
+#define raw_atomic64_add_return_release arch_atomic64_add_return
+#else
+#error "Unable to define raw_atomic64_add_return_release"
+#endif
+
+#if defined(arch_atomic64_add_return_relaxed)
+#define raw_atomic64_add_return_relaxed arch_atomic64_add_return_relaxed
+#elif defined(arch_atomic64_add_return)
+#define raw_atomic64_add_return_relaxed arch_atomic64_add_return
+#else
+#error "Unable to define raw_atomic64_add_return_relaxed"
 #endif
 
-#ifndef arch_atomic64_add_return
+#if defined(arch_atomic64_fetch_add)
+#define raw_atomic64_fetch_add arch_atomic64_fetch_add
+#elif defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
-arch_atomic64_add_return(s64 i, atomic64_t *v)
+raw_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_add_return_relaxed(i, v);
+	ret = arch_atomic64_fetch_add_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_add_return arch_atomic64_add_return
+#else
+#error "Unable to define raw_atomic64_fetch_add"
 #endif
 
-#endif /* arch_atomic64_add_return_relaxed */
-
-#ifndef arch_atomic64_fetch_add_relaxed
-#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
-#else /* arch_atomic64_fetch_add_relaxed */
-
-#ifndef arch_atomic64_fetch_add_acquire
+#if defined(arch_atomic64_fetch_add_acquire)
+#define raw_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
+#elif defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
+#elif defined(arch_atomic64_fetch_add)
+#define raw_atomic64_fetch_add_acquire arch_atomic64_fetch_add
+#else
+#error "Unable to define raw_atomic64_fetch_add_acquire"
 #endif
 
-#ifndef arch_atomic64_fetch_add_release
+#if defined(arch_atomic64_fetch_add_release)
+#define raw_atomic64_fetch_add_release arch_atomic64_fetch_add_release
+#elif defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
-#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
+#elif defined(arch_atomic64_fetch_add)
+#define raw_atomic64_fetch_add_release arch_atomic64_fetch_add
+#else
+#error "Unable to define raw_atomic64_fetch_add_release"
+#endif
+
+#if defined(arch_atomic64_fetch_add_relaxed)
+#define raw_atomic64_fetch_add_relaxed arch_atomic64_fetch_add_relaxed
+#elif defined(arch_atomic64_fetch_add)
+#define raw_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
+#else
+#error "Unable to define raw_atomic64_fetch_add_relaxed"
 #endif
 
-#ifndef arch_atomic64_fetch_add
+#define raw_atomic64_sub arch_atomic64_sub
+
+#if defined(arch_atomic64_sub_return)
+#define raw_atomic64_sub_return arch_atomic64_sub_return
+#elif defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+raw_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_add_relaxed(i, v);
+	ret = arch_atomic64_sub_return_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_add arch_atomic64_fetch_add
+#else
+#error "Unable to define raw_atomic64_sub_return"
 #endif
 
-#endif /* arch_atomic64_fetch_add_relaxed */
-
-#ifndef arch_atomic64_sub_return_relaxed
-#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
-#define arch_atomic64_sub_return_release arch_atomic64_sub_return
-#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
-#else /* arch_atomic64_sub_return_relaxed */
-
-#ifndef arch_atomic64_sub_return_acquire
+#if defined(arch_atomic64_sub_return_acquire)
+#define raw_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
+#elif defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
-arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+raw_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
+#elif defined(arch_atomic64_sub_return)
+#define raw_atomic64_sub_return_acquire arch_atomic64_sub_return
+#else
+#error "Unable to define raw_atomic64_sub_return_acquire"
 #endif
 
-#ifndef arch_atomic64_sub_return_release
+#if defined(arch_atomic64_sub_return_release)
+#define raw_atomic64_sub_return_release arch_atomic64_sub_return_release
+#elif defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
-arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
+raw_atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
-#define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
+#elif defined(arch_atomic64_sub_return)
+#define raw_atomic64_sub_return_release arch_atomic64_sub_return
+#else
+#error "Unable to define raw_atomic64_sub_return_release"
+#endif
+
+#if defined(arch_atomic64_sub_return_relaxed)
+#define raw_atomic64_sub_return_relaxed arch_atomic64_sub_return_relaxed
+#elif defined(arch_atomic64_sub_return)
+#define raw_atomic64_sub_return_relaxed arch_atomic64_sub_return
+#else
+#error "Unable to define raw_atomic64_sub_return_relaxed"
 #endif
 
-#ifndef arch_atomic64_sub_return
+#if defined(arch_atomic64_fetch_sub)
+#define raw_atomic64_fetch_sub arch_atomic64_fetch_sub
+#elif defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
-arch_atomic64_sub_return(s64 i, atomic64_t *v)
+raw_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_sub_return_relaxed(i, v);
+	ret = arch_atomic64_fetch_sub_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_sub_return arch_atomic64_sub_return
+#else
+#error "Unable to define raw_atomic64_fetch_sub"
 #endif
 
-#endif /* arch_atomic64_sub_return_relaxed */
-
-#ifndef arch_atomic64_fetch_sub_relaxed
-#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
-#else /* arch_atomic64_fetch_sub_relaxed */
-
-#ifndef arch_atomic64_fetch_sub_acquire
+#if defined(arch_atomic64_fetch_sub_acquire)
+#define raw_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
+#elif defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
+#elif defined(arch_atomic64_fetch_sub)
+#define raw_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
+#else
+#error "Unable to define raw_atomic64_fetch_sub_acquire"
 #endif
 
-#ifndef arch_atomic64_fetch_sub_release
+#if defined(arch_atomic64_fetch_sub_release)
+#define raw_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
+#elif defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
-#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
+#elif defined(arch_atomic64_fetch_sub)
+#define raw_atomic64_fetch_sub_release arch_atomic64_fetch_sub
+#else
+#error "Unable to define raw_atomic64_fetch_sub_release"
 #endif
 
-#ifndef arch_atomic64_fetch_sub
-static __always_inline s64
-arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_sub_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#if defined(arch_atomic64_fetch_sub_relaxed)
+#define raw_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub_relaxed
+#elif defined(arch_atomic64_fetch_sub)
+#define raw_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
+#else
+#error "Unable to define raw_atomic64_fetch_sub_relaxed"
 #endif
 
-#endif /* arch_atomic64_fetch_sub_relaxed */
-
-#ifndef arch_atomic64_inc
+#if defined(arch_atomic64_inc)
+#define raw_atomic64_inc arch_atomic64_inc
+#else
 static __always_inline void
-arch_atomic64_inc(atomic64_t *v)
+raw_atomic64_inc(atomic64_t *v)
 {
-	arch_atomic64_add(1, v);
+	raw_atomic64_add(1, v);
 }
-#define arch_atomic64_inc arch_atomic64_inc
 #endif
 
-#ifndef arch_atomic64_inc_return_relaxed
-#ifdef arch_atomic64_inc_return
-#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return
-#define arch_atomic64_inc_return_release arch_atomic64_inc_return
-#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return
-#endif /* arch_atomic64_inc_return */
-
-#ifndef arch_atomic64_inc_return
+#if defined(arch_atomic64_inc_return)
+#define raw_atomic64_inc_return arch_atomic64_inc_return
+#elif defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
-arch_atomic64_inc_return(atomic64_t *v)
+raw_atomic64_inc_return(atomic64_t *v)
 {
-	return arch_atomic64_add_return(1, v);
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
 }
-#define arch_atomic64_inc_return arch_atomic64_inc_return
-#endif
-
-#ifndef arch_atomic64_inc_return_acquire
+#else
 static __always_inline s64
-arch_atomic64_inc_return_acquire(atomic64_t *v)
+raw_atomic64_inc_return(atomic64_t *v)
 {
-	return arch_atomic64_add_return_acquire(1, v);
+	return raw_atomic64_add_return(1, v);
 }
-#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
 #endif
 
-#ifndef arch_atomic64_inc_return_release
+#if defined(arch_atomic64_inc_return_acquire)
+#define raw_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#elif defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
-arch_atomic64_inc_return_release(atomic64_t *v)
+raw_atomic64_inc_return_acquire(atomic64_t *v)
 {
-	return arch_atomic64_add_return_release(1, v);
+	s64 ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
-#endif
-
-#ifndef arch_atomic64_inc_return_relaxed
+#elif defined(arch_atomic64_inc_return)
+#define raw_atomic64_inc_return_acquire arch_atomic64_inc_return
+#else
 static __always_inline s64
-arch_atomic64_inc_return_relaxed(atomic64_t *v)
+raw_atomic64_inc_return_acquire(atomic64_t *v)
 {
-	return arch_atomic64_add_return_relaxed(1, v);
+	return raw_atomic64_add_return_acquire(1, v);
 }
-#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
 #endif
 
-#else /* arch_atomic64_inc_return_relaxed */
-
-#ifndef arch_atomic64_inc_return_acquire
+#if defined(arch_atomic64_inc_return_release)
+#define raw_atomic64_inc_return_release arch_atomic64_inc_return_release
+#elif defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
-arch_atomic64_inc_return_acquire(atomic64_t *v)
+raw_atomic64_inc_return_release(atomic64_t *v)
 {
-	s64 ret = arch_atomic64_inc_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	__atomic_release_fence();
+	return arch_atomic64_inc_return_relaxed(v);
+}
+#elif defined(arch_atomic64_inc_return)
+#define raw_atomic64_inc_return_release arch_atomic64_inc_return
+#else
+static __always_inline s64
+raw_atomic64_inc_return_release(atomic64_t *v)
+{
+	return raw_atomic64_add_return_release(1, v);
 }
-#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
 #endif
 
-#ifndef arch_atomic64_inc_return_release
+#if defined(arch_atomic64_inc_return_relaxed)
+#define raw_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+#elif defined(arch_atomic64_inc_return)
+#define raw_atomic64_inc_return_relaxed arch_atomic64_inc_return
+#else
 static __always_inline s64
-arch_atomic64_inc_return_release(atomic64_t *v)
+raw_atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic64_inc_return_relaxed(v);
+	return raw_atomic64_add_return_relaxed(1, v);
 }
-#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
 #endif
 
-#ifndef arch_atomic64_inc_return
+#if defined(arch_atomic64_fetch_inc)
+#define raw_atomic64_fetch_inc arch_atomic64_fetch_inc
+#elif defined(arch_atomic64_fetch_inc_relaxed)
 static __always_inline s64
-arch_atomic64_inc_return(atomic64_t *v)
+raw_atomic64_fetch_inc(atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_inc_return_relaxed(v);
+	ret = arch_atomic64_fetch_inc_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_inc_return arch_atomic64_inc_return
-#endif
-
-#endif /* arch_atomic64_inc_return_relaxed */
-
-#ifndef arch_atomic64_fetch_inc_relaxed
-#ifdef arch_atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
-#endif /* arch_atomic64_fetch_inc */
-
-#ifndef arch_atomic64_fetch_inc
+#else
 static __always_inline s64
-arch_atomic64_fetch_inc(atomic64_t *v)
+raw_atomic64_fetch_inc(atomic64_t *v)
 {
-	return arch_atomic64_fetch_add(1, v);
+	return raw_atomic64_fetch_add(1, v);
 }
-#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
 #endif
 
-#ifndef arch_atomic64_fetch_inc_acquire
+#if defined(arch_atomic64_fetch_inc_acquire)
+#define raw_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#elif defined(arch_atomic64_fetch_inc_relaxed)
+static __always_inline s64
+raw_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#elif defined(arch_atomic64_fetch_inc)
+#define raw_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
+#else
 static __always_inline s64
-arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+raw_atomic64_fetch_inc_acquire(atomic64_t *v)
 {
-	return arch_atomic64_fetch_add_acquire(1, v);
+	return raw_atomic64_fetch_add_acquire(1, v);
 }
-#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
 #endif
 
-#ifndef arch_atomic64_fetch_inc_release
+#if defined(arch_atomic64_fetch_inc_release)
+#define raw_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#elif defined(arch_atomic64_fetch_inc_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_inc_release(atomic64_t *v)
+raw_atomic64_fetch_inc_release(atomic64_t *v)
 {
-	return arch_atomic64_fetch_add_release(1, v);
+	__atomic_release_fence();
+	return arch_atomic64_fetch_inc_relaxed(v);
 }
-#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
-#endif
-
-#ifndef arch_atomic64_fetch_inc_relaxed
+#elif defined(arch_atomic64_fetch_inc)
+#define raw_atomic64_fetch_inc_release arch_atomic64_fetch_inc
+#else
 static __always_inline s64
-arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
+raw_atomic64_fetch_inc_release(atomic64_t *v)
 {
-	return arch_atomic64_fetch_add_relaxed(1, v);
+	return raw_atomic64_fetch_add_release(1, v);
 }
-#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
 #endif
 
-#else /* arch_atomic64_fetch_inc_relaxed */
-
-#ifndef arch_atomic64_fetch_inc_acquire
+#if defined(arch_atomic64_fetch_inc_relaxed)
+#define raw_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
+#elif defined(arch_atomic64_fetch_inc)
+#define raw_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
+#else
 static __always_inline s64
-arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
-	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic64_fetch_add_relaxed(1, v);
 }
-#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
 #endif
 
-#ifndef arch_atomic64_fetch_inc_release
-static __always_inline s64
-arch_atomic64_fetch_inc_release(atomic64_t *v)
+#if defined(arch_atomic64_dec)
+#define raw_atomic64_dec arch_atomic64_dec
+#else
+static __always_inline void
+raw_atomic64_dec(atomic64_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic64_fetch_inc_relaxed(v);
+	raw_atomic64_sub(1, v);
 }
-#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
 #endif
 
-#ifndef arch_atomic64_fetch_inc
+#if defined(arch_atomic64_dec_return)
+#define raw_atomic64_dec_return arch_atomic64_dec_return
+#elif defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_inc(atomic64_t *v)
+raw_atomic64_dec_return(atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_inc_relaxed(v);
+	ret = arch_atomic64_dec_return_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
-#endif
-
-#endif /* arch_atomic64_fetch_inc_relaxed */
-
-#ifndef arch_atomic64_dec
-static __always_inline void
-arch_atomic64_dec(atomic64_t *v)
-{
-	arch_atomic64_sub(1, v);
-}
-#define arch_atomic64_dec arch_atomic64_dec
-#endif
-
-#ifndef arch_atomic64_dec_return_relaxed
-#ifdef arch_atomic64_dec_return
-#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return
-#define arch_atomic64_dec_return_release arch_atomic64_dec_return
-#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return
-#endif /* arch_atomic64_dec_return */
-
-#ifndef arch_atomic64_dec_return
+#else
 static __always_inline s64
-arch_atomic64_dec_return(atomic64_t *v)
+raw_atomic64_dec_return(atomic64_t *v)
 {
-	return arch_atomic64_sub_return(1, v);
+	return raw_atomic64_sub_return(1, v);
 }
-#define arch_atomic64_dec_return arch_atomic64_dec_return
 #endif
 
-#ifndef arch_atomic64_dec_return_acquire
+#if defined(arch_atomic64_dec_return_acquire)
+#define raw_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#elif defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
-arch_atomic64_dec_return_acquire(atomic64_t *v)
+raw_atomic64_dec_return_acquire(atomic64_t *v)
 {
-	return arch_atomic64_sub_return_acquire(1, v);
+	s64 ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
-#endif
-
-#ifndef arch_atomic64_dec_return_release
+#elif defined(arch_atomic64_dec_return)
+#define raw_atomic64_dec_return_acquire arch_atomic64_dec_return
+#else
 static __always_inline s64
-arch_atomic64_dec_return_release(atomic64_t *v)
+raw_atomic64_dec_return_acquire(atomic64_t *v)
 {
-	return arch_atomic64_sub_return_release(1, v);
+	return raw_atomic64_sub_return_acquire(1, v);
 }
-#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
 #endif
 
-#ifndef arch_atomic64_dec_return_relaxed
+#if defined(arch_atomic64_dec_return_release)
+#define raw_atomic64_dec_return_release arch_atomic64_dec_return_release
+#elif defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
-arch_atomic64_dec_return_relaxed(atomic64_t *v)
+raw_atomic64_dec_return_release(atomic64_t *v)
 {
-	return arch_atomic64_sub_return_relaxed(1, v);
+	__atomic_release_fence();
+	return arch_atomic64_dec_return_relaxed(v);
 }
-#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
-#endif
-
-#else /* arch_atomic64_dec_return_relaxed */
-
-#ifndef arch_atomic64_dec_return_acquire
+#elif defined(arch_atomic64_dec_return)
+#define raw_atomic64_dec_return_release arch_atomic64_dec_return
+#else
 static __always_inline s64
-arch_atomic64_dec_return_acquire(atomic64_t *v)
+raw_atomic64_dec_return_release(atomic64_t *v)
 {
-	s64 ret = arch_atomic64_dec_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic64_sub_return_release(1, v);
 }
-#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
 #endif
 
-#ifndef arch_atomic64_dec_return_release
+#if defined(arch_atomic64_dec_return_relaxed)
+#define raw_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
+#elif defined(arch_atomic64_dec_return)
+#define raw_atomic64_dec_return_relaxed arch_atomic64_dec_return
+#else
 static __always_inline s64
-arch_atomic64_dec_return_release(atomic64_t *v)
+raw_atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic64_dec_return_relaxed(v);
+	return raw_atomic64_sub_return_relaxed(1, v);
 }
-#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
 #endif
 
-#ifndef arch_atomic64_dec_return
+#if defined(arch_atomic64_fetch_dec)
+#define raw_atomic64_fetch_dec arch_atomic64_fetch_dec
+#elif defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
-arch_atomic64_dec_return(atomic64_t *v)
+raw_atomic64_fetch_dec(atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_dec_return_relaxed(v);
+	ret = arch_atomic64_fetch_dec_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_dec_return arch_atomic64_dec_return
-#endif
-
-#endif /* arch_atomic64_dec_return_relaxed */
-
-#ifndef arch_atomic64_fetch_dec_relaxed
-#ifdef arch_atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
-#endif /* arch_atomic64_fetch_dec */
-
-#ifndef arch_atomic64_fetch_dec
+#else
 static __always_inline s64
-arch_atomic64_fetch_dec(atomic64_t *v)
+raw_atomic64_fetch_dec(atomic64_t *v)
 {
-	return arch_atomic64_fetch_sub(1, v);
+	return raw_atomic64_fetch_sub(1, v);
 }
-#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
 #endif
 
-#ifndef arch_atomic64_fetch_dec_acquire
+#if defined(arch_atomic64_fetch_dec_acquire)
+#define raw_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#elif defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+raw_atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	return arch_atomic64_fetch_sub_acquire(1, v);
+	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_dec_release
+#elif defined(arch_atomic64_fetch_dec)
+#define raw_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
+#else
 static __always_inline s64
-arch_atomic64_fetch_dec_release(atomic64_t *v)
+raw_atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	return arch_atomic64_fetch_sub_release(1, v);
+	return raw_atomic64_fetch_sub_acquire(1, v);
 }
-#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
 #endif
 
-#ifndef arch_atomic64_fetch_dec_relaxed
+#if defined(arch_atomic64_fetch_dec_release)
+#define raw_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#elif defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
+raw_atomic64_fetch_dec_release(atomic64_t *v)
 {
-	return arch_atomic64_fetch_sub_relaxed(1, v);
+	__atomic_release_fence();
+	return arch_atomic64_fetch_dec_relaxed(v);
 }
-#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
-#endif
-
-#else /* arch_atomic64_fetch_dec_relaxed */
-
-#ifndef arch_atomic64_fetch_dec_acquire
+#elif defined(arch_atomic64_fetch_dec)
+#define raw_atomic64_fetch_dec_release arch_atomic64_fetch_dec
+#else
 static __always_inline s64
-arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+raw_atomic64_fetch_dec_release(atomic64_t *v)
 {
-	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_atomic64_fetch_sub_release(1, v);
 }
-#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
 #endif
 
-#ifndef arch_atomic64_fetch_dec_release
+#if defined(arch_atomic64_fetch_dec_relaxed)
+#define raw_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
+#elif defined(arch_atomic64_fetch_dec)
+#define raw_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
+#else
 static __always_inline s64
-arch_atomic64_fetch_dec_release(atomic64_t *v)
+raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic64_fetch_dec_relaxed(v);
+	return raw_atomic64_fetch_sub_relaxed(1, v);
 }
-#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
 #endif
 
-#ifndef arch_atomic64_fetch_dec
+#define raw_atomic64_and arch_atomic64_and
+
+#if defined(arch_atomic64_fetch_and)
+#define raw_atomic64_fetch_and arch_atomic64_fetch_and
+#elif defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_dec(atomic64_t *v)
+raw_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_dec_relaxed(v);
+	ret = arch_atomic64_fetch_and_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#else
+#error "Unable to define raw_atomic64_fetch_and"
 #endif
 
-#endif /* arch_atomic64_fetch_dec_relaxed */
-
-#ifndef arch_atomic64_fetch_and_relaxed
-#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
-#else /* arch_atomic64_fetch_and_relaxed */
-
-#ifndef arch_atomic64_fetch_and_acquire
+#if defined(arch_atomic64_fetch_and_acquire)
+#define raw_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
+#elif defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
+#elif defined(arch_atomic64_fetch_and)
+#define raw_atomic64_fetch_and_acquire arch_atomic64_fetch_and
+#else
+#error "Unable to define raw_atomic64_fetch_and_acquire"
 #endif
 
-#ifndef arch_atomic64_fetch_and_release
+#if defined(arch_atomic64_fetch_and_release)
+#define raw_atomic64_fetch_and_release arch_atomic64_fetch_and_release
+#elif defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
-#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and_release
+#elif defined(arch_atomic64_fetch_and)
+#define raw_atomic64_fetch_and_release arch_atomic64_fetch_and
+#else
+#error "Unable to define raw_atomic64_fetch_and_release"
 #endif
 
-#ifndef arch_atomic64_fetch_and
-static __always_inline s64
-arch_atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_and_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_and arch_atomic64_fetch_and
+#if defined(arch_atomic64_fetch_and_relaxed)
+#define raw_atomic64_fetch_and_relaxed arch_atomic64_fetch_and_relaxed
+#elif defined(arch_atomic64_fetch_and)
+#define raw_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
+#else
+#error "Unable to define raw_atomic64_fetch_and_relaxed"
 #endif
 
-#endif /* arch_atomic64_fetch_and_relaxed */
-
-#ifndef arch_atomic64_andnot
+#if defined(arch_atomic64_andnot)
+#define raw_atomic64_andnot arch_atomic64_andnot
+#else
 static __always_inline void
-arch_atomic64_andnot(s64 i, atomic64_t *v)
+raw_atomic64_andnot(s64 i, atomic64_t *v)
 {
-	arch_atomic64_and(~i, v);
+	raw_atomic64_and(~i, v);
 }
-#define arch_atomic64_andnot arch_atomic64_andnot
 #endif
 
-#ifndef arch_atomic64_fetch_andnot_relaxed
-#ifdef arch_atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
-#endif /* arch_atomic64_fetch_andnot */
-
-#ifndef arch_atomic64_fetch_andnot
+#if defined(arch_atomic64_fetch_andnot)
+#define raw_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#elif defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_fetch_and(~i, v);
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
 }
-#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_acquire
+#else
 static __always_inline s64
-arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_fetch_and_acquire(~i, v);
+	return raw_atomic64_fetch_and(~i, v);
 }
-#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
 #endif
 
-#ifndef arch_atomic64_fetch_andnot_release
+#if defined(arch_atomic64_fetch_andnot_acquire)
+#define raw_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#elif defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_fetch_and_release(~i, v);
+	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_relaxed
+#elif defined(arch_atomic64_fetch_andnot)
+#define raw_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
+#else
 static __always_inline s64
-arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_fetch_and_relaxed(~i, v);
+	return raw_atomic64_fetch_and_acquire(~i, v);
 }
-#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
 #endif
 
-#else /* arch_atomic64_fetch_andnot_relaxed */
-
-#ifndef arch_atomic64_fetch_andnot_acquire
+#if defined(arch_atomic64_fetch_andnot_release)
+#define raw_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#elif defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
-	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
+	__atomic_release_fence();
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+#elif defined(arch_atomic64_fetch_andnot)
+#define raw_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
+#else
+static __always_inline s64
+raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return raw_atomic64_fetch_and_release(~i, v);
 }
-#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
 #endif
 
-#ifndef arch_atomic64_fetch_andnot_release
+#if defined(arch_atomic64_fetch_andnot_relaxed)
+#define raw_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
+#elif defined(arch_atomic64_fetch_andnot)
+#define raw_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
+#else
 static __always_inline s64
-arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic64_fetch_andnot_relaxed(i, v);
+	return raw_atomic64_fetch_and_relaxed(~i, v);
 }
-#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
 #endif
 
-#ifndef arch_atomic64_fetch_andnot
+#define raw_atomic64_or arch_atomic64_or
+
+#if defined(arch_atomic64_fetch_or)
+#define raw_atomic64_fetch_or arch_atomic64_fetch_or
+#elif defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+raw_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	ret = arch_atomic64_fetch_or_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#else
+#error "Unable to define raw_atomic64_fetch_or"
 #endif
 
-#endif /* arch_atomic64_fetch_andnot_relaxed */
-
-#ifndef arch_atomic64_fetch_or_relaxed
-#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
-#else /* arch_atomic64_fetch_or_relaxed */
-
-#ifndef arch_atomic64_fetch_or_acquire
+#if defined(arch_atomic64_fetch_or_acquire)
+#define raw_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
+#elif defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
+#elif defined(arch_atomic64_fetch_or)
+#define raw_atomic64_fetch_or_acquire arch_atomic64_fetch_or
+#else
+#error "Unable to define raw_atomic64_fetch_or_acquire"
 #endif
 
-#ifndef arch_atomic64_fetch_or_release
+#if defined(arch_atomic64_fetch_or_release)
+#define raw_atomic64_fetch_or_release arch_atomic64_fetch_or_release
+#elif defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
-#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
+#elif defined(arch_atomic64_fetch_or)
+#define raw_atomic64_fetch_or_release arch_atomic64_fetch_or
+#else
+#error "Unable to define raw_atomic64_fetch_or_release"
+#endif
+
+#if defined(arch_atomic64_fetch_or_relaxed)
+#define raw_atomic64_fetch_or_relaxed arch_atomic64_fetch_or_relaxed
+#elif defined(arch_atomic64_fetch_or)
+#define raw_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
+#else
+#error "Unable to define raw_atomic64_fetch_or_relaxed"
 #endif
 
-#ifndef arch_atomic64_fetch_or
+#define raw_atomic64_xor arch_atomic64_xor
+
+#if defined(arch_atomic64_fetch_xor)
+#define raw_atomic64_fetch_xor arch_atomic64_fetch_xor
+#elif defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+raw_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_or_relaxed(i, v);
+	ret = arch_atomic64_fetch_xor_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_or arch_atomic64_fetch_or
+#else
+#error "Unable to define raw_atomic64_fetch_xor"
 #endif
 
-#endif /* arch_atomic64_fetch_or_relaxed */
-
-#ifndef arch_atomic64_fetch_xor_relaxed
-#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
-#else /* arch_atomic64_fetch_xor_relaxed */
-
-#ifndef arch_atomic64_fetch_xor_acquire
+#if defined(arch_atomic64_fetch_xor_acquire)
+#define raw_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
+#elif defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+raw_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
+#elif defined(arch_atomic64_fetch_xor)
+#define raw_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
+#else
+#error "Unable to define raw_atomic64_fetch_xor_acquire"
 #endif
 
-#ifndef arch_atomic64_fetch_xor_release
+#if defined(arch_atomic64_fetch_xor_release)
+#define raw_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
+#elif defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+raw_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
-#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
+#elif defined(arch_atomic64_fetch_xor)
+#define raw_atomic64_fetch_xor_release arch_atomic64_fetch_xor
+#else
+#error "Unable to define raw_atomic64_fetch_xor_release"
+#endif
+
+#if defined(arch_atomic64_fetch_xor_relaxed)
+#define raw_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor_relaxed
+#elif defined(arch_atomic64_fetch_xor)
+#define raw_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
+#else
+#error "Unable to define raw_atomic64_fetch_xor_relaxed"
 #endif
 
-#ifndef arch_atomic64_fetch_xor
+#if defined(arch_atomic64_xchg)
+#define raw_atomic64_xchg arch_atomic64_xchg
+#elif defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
-arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+raw_atomic64_xchg(atomic64_t *v, s64 i)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	ret = arch_atomic64_xchg_relaxed(v, i);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
-#endif
-
-#endif /* arch_atomic64_fetch_xor_relaxed */
-
-#ifndef arch_atomic64_xchg_relaxed
-#ifdef arch_atomic64_xchg
-#define arch_atomic64_xchg_acquire arch_atomic64_xchg
-#define arch_atomic64_xchg_release arch_atomic64_xchg
-#define arch_atomic64_xchg_relaxed arch_atomic64_xchg
-#endif /* arch_atomic64_xchg */
-
-#ifndef arch_atomic64_xchg
+#else
 static __always_inline s64
-arch_atomic64_xchg(atomic64_t *v, s64 new)
+raw_atomic64_xchg(atomic64_t *v, s64 new)
 {
-	return arch_xchg(&v->counter, new);
+	return raw_xchg(&v->counter, new);
 }
-#define arch_atomic64_xchg arch_atomic64_xchg
 #endif
 
-#ifndef arch_atomic64_xchg_acquire
+#if defined(arch_atomic64_xchg_acquire)
+#define raw_atomic64_xchg_acquire arch_atomic64_xchg_acquire
+#elif defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
-arch_atomic64_xchg_acquire(atomic64_t *v, s64 new)
+raw_atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
-	return arch_xchg_acquire(&v->counter, new);
+	s64 ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
-#endif
-
-#ifndef arch_atomic64_xchg_release
+#elif defined(arch_atomic64_xchg)
+#define raw_atomic64_xchg_acquire arch_atomic64_xchg
+#else
 static __always_inline s64
-arch_atomic64_xchg_release(atomic64_t *v, s64 new)
+raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
 {
-	return arch_xchg_release(&v->counter, new);
+	return raw_xchg_acquire(&v->counter, new);
 }
-#define arch_atomic64_xchg_release arch_atomic64_xchg_release
 #endif
 
-#ifndef arch_atomic64_xchg_relaxed
+#if defined(arch_atomic64_xchg_release)
+#define raw_atomic64_xchg_release arch_atomic64_xchg_release
+#elif defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
-arch_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
+raw_atomic64_xchg_release(atomic64_t *v, s64 i)
 {
-	return arch_xchg_relaxed(&v->counter, new);
+	__atomic_release_fence();
+	return arch_atomic64_xchg_relaxed(v, i);
 }
-#define arch_atomic64_xchg_relaxed arch_atomic64_xchg_relaxed
-#endif
-
-#else /* arch_atomic64_xchg_relaxed */
-
-#ifndef arch_atomic64_xchg_acquire
+#elif defined(arch_atomic64_xchg)
+#define raw_atomic64_xchg_release arch_atomic64_xchg
+#else
 static __always_inline s64
-arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+raw_atomic64_xchg_release(atomic64_t *v, s64 new)
 {
-	s64 ret = arch_atomic64_xchg_relaxed(v, i);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_xchg_release(&v->counter, new);
 }
-#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
 #endif
 
-#ifndef arch_atomic64_xchg_release
+#if defined(arch_atomic64_xchg_relaxed)
+#define raw_atomic64_xchg_relaxed arch_atomic64_xchg_relaxed
+#elif defined(arch_atomic64_xchg)
+#define raw_atomic64_xchg_relaxed arch_atomic64_xchg
+#else
 static __always_inline s64
-arch_atomic64_xchg_release(atomic64_t *v, s64 i)
+raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 {
-	__atomic_release_fence();
-	return arch_atomic64_xchg_relaxed(v, i);
+	return raw_xchg_relaxed(&v->counter, new);
 }
-#define arch_atomic64_xchg_release arch_atomic64_xchg_release
 #endif
 
-#ifndef arch_atomic64_xchg
+#if defined(arch_atomic64_cmpxchg)
+#define raw_atomic64_cmpxchg arch_atomic64_cmpxchg
+#elif defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
-arch_atomic64_xchg(atomic64_t *v, s64 i)
+raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_xchg_relaxed(v, i);
+	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_xchg arch_atomic64_xchg
-#endif
-
-#endif /* arch_atomic64_xchg_relaxed */
-
-#ifndef arch_atomic64_cmpxchg_relaxed
-#ifdef arch_atomic64_cmpxchg
-#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
-#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
-#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
-#endif /* arch_atomic64_cmpxchg */
-
-#ifndef arch_atomic64_cmpxchg
+#else
 static __always_inline s64
-arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg(&v->counter, old, new);
+	return raw_cmpxchg(&v->counter, old, new);
 }
-#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 #endif
 
-#ifndef arch_atomic64_cmpxchg_acquire
+#if defined(arch_atomic64_cmpxchg_acquire)
+#define raw_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
+#elif defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
-arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg_acquire(&v->counter, old, new);
+	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic64_cmpxchg_release
+#elif defined(arch_atomic64_cmpxchg)
+#define raw_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
+#else
 static __always_inline s64
-arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg_release(&v->counter, old, new);
+	return raw_cmpxchg_acquire(&v->counter, old, new);
 }
-#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
 #endif
 
-#ifndef arch_atomic64_cmpxchg_relaxed
+#if defined(arch_atomic64_cmpxchg_release)
+#define raw_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
+#elif defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
-arch_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg_relaxed(&v->counter, old, new);
+	__atomic_release_fence();
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
-#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg_relaxed
-#endif
-
-#else /* arch_atomic64_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_cmpxchg_acquire
+#elif defined(arch_atomic64_cmpxchg)
+#define raw_atomic64_cmpxchg_release arch_atomic64_cmpxchg
+#else
 static __always_inline s64
-arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
+	return raw_cmpxchg_release(&v->counter, old, new);
 }
-#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
 #endif
 
-#ifndef arch_atomic64_cmpxchg_release
+#if defined(arch_atomic64_cmpxchg_relaxed)
+#define raw_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg_relaxed
+#elif defined(arch_atomic64_cmpxchg)
+#define raw_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
+#else
 static __always_inline s64
-arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
-	__atomic_release_fence();
-	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+	return raw_cmpxchg_relaxed(&v->counter, old, new);
 }
-#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
 #endif
 
-#ifndef arch_atomic64_cmpxchg
-static __always_inline s64
-arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+#if defined(arch_atomic64_try_cmpxchg)
+#define raw_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#elif defined(arch_atomic64_try_cmpxchg_relaxed)
+static __always_inline bool
+raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	s64 ret;
+	bool ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
 }
-#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
-#endif
-
-#endif /* arch_atomic64_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_try_cmpxchg_relaxed
-#ifdef arch_atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
-#endif /* arch_atomic64_try_cmpxchg */
-
-#ifndef arch_atomic64_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg(v, o, new);
+	r = raw_atomic64_cmpxchg(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 #endif
 
-#ifndef arch_atomic64_try_cmpxchg_acquire
+#if defined(arch_atomic64_try_cmpxchg_acquire)
+#define raw_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#elif defined(arch_atomic64_try_cmpxchg_relaxed)
+static __always_inline bool
+raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#elif defined(arch_atomic64_try_cmpxchg)
+#define raw_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg_acquire(v, o, new);
+	r = raw_atomic64_cmpxchg_acquire(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
 #endif
 
-#ifndef arch_atomic64_try_cmpxchg_release
+#if defined(arch_atomic64_try_cmpxchg_release)
+#define raw_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#elif defined(arch_atomic64_try_cmpxchg_relaxed)
+static __always_inline bool
+raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+#elif defined(arch_atomic64_try_cmpxchg)
+#define raw_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg_release(v, o, new);
+	r = raw_atomic64_cmpxchg_release(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
 #endif
 
-#ifndef arch_atomic64_try_cmpxchg_relaxed
+#if defined(arch_atomic64_try_cmpxchg_relaxed)
+#define raw_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
+#elif defined(arch_atomic64_try_cmpxchg)
+#define raw_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
+#else
 static __always_inline bool
-arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg_relaxed(v, o, new);
+	r = raw_atomic64_cmpxchg_relaxed(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
 }
-#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
 #endif
 
-#else /* arch_atomic64_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_try_cmpxchg_acquire
-static __always_inline bool
-arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg_release
-static __always_inline bool
-arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	__atomic_release_fence();
-	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-}
-#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg
-static __always_inline bool
-arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
-#endif
-
-#endif /* arch_atomic64_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_sub_and_test
+#if defined(arch_atomic64_sub_and_test)
+#define raw_atomic64_sub_and_test arch_atomic64_sub_and_test
+#else
 static __always_inline bool
-arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+raw_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_sub_return(i, v) == 0;
+	return raw_atomic64_sub_return(i, v) == 0;
 }
-#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 #endif
 
-#ifndef arch_atomic64_dec_and_test
+#if defined(arch_atomic64_dec_and_test)
+#define raw_atomic64_dec_and_test arch_atomic64_dec_and_test
+#else
 static __always_inline bool
-arch_atomic64_dec_and_test(atomic64_t *v)
+raw_atomic64_dec_and_test(atomic64_t *v)
 {
-	return arch_atomic64_dec_return(v) == 0;
+	return raw_atomic64_dec_return(v) == 0;
 }
-#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 #endif
 
-#ifndef arch_atomic64_inc_and_test
+#if defined(arch_atomic64_inc_and_test)
+#define raw_atomic64_inc_and_test arch_atomic64_inc_and_test
+#else
 static __always_inline bool
-arch_atomic64_inc_and_test(atomic64_t *v)
+raw_atomic64_inc_and_test(atomic64_t *v)
 {
-	return arch_atomic64_inc_return(v) == 0;
+	return raw_atomic64_inc_return(v) == 0;
 }
-#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 #endif
 
-#ifndef arch_atomic64_add_negative_relaxed
-#ifdef arch_atomic64_add_negative
-#define arch_atomic64_add_negative_acquire arch_atomic64_add_negative
-#define arch_atomic64_add_negative_release arch_atomic64_add_negative
-#define arch_atomic64_add_negative_relaxed arch_atomic64_add_negative
-#endif /* arch_atomic64_add_negative */
-
-#ifndef arch_atomic64_add_negative
+#if defined(arch_atomic64_add_negative)
+#define raw_atomic64_add_negative arch_atomic64_add_negative
+#elif defined(arch_atomic64_add_negative_relaxed)
 static __always_inline bool
-arch_atomic64_add_negative(s64 i, atomic64_t *v)
+raw_atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_add_return(i, v) < 0;
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_add_negative_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
 }
-#define arch_atomic64_add_negative arch_atomic64_add_negative
-#endif
-
-#ifndef arch_atomic64_add_negative_acquire
+#else
 static __always_inline bool
-arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
+raw_atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_add_return_acquire(i, v) < 0;
+	return raw_atomic64_add_return(i, v) < 0;
 }
-#define arch_atomic64_add_negative_acquire arch_atomic64_add_negative_acquire
 #endif
 
-#ifndef arch_atomic64_add_negative_release
+#if defined(arch_atomic64_add_negative_acquire)
+#define raw_atomic64_add_negative_acquire arch_atomic64_add_negative_acquire
+#elif defined(arch_atomic64_add_negative_relaxed)
 static __always_inline bool
-arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
+raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_add_return_release(i, v) < 0;
+	bool ret = arch_atomic64_add_negative_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
 }
-#define arch_atomic64_add_negative_release arch_atomic64_add_negative_release
-#endif
-
-#ifndef arch_atomic64_add_negative_relaxed
+#elif defined(arch_atomic64_add_negative)
+#define raw_atomic64_add_negative_acquire arch_atomic64_add_negative
+#else
 static __always_inline bool
-arch_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
+raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
-	return arch_atomic64_add_return_relaxed(i, v) < 0;
+	return raw_atomic64_add_return_acquire(i, v) < 0;
 }
-#define arch_atomic64_add_negative_relaxed arch_atomic64_add_negative_relaxed
 #endif
 
-#else /* arch_atomic64_add_negative_relaxed */
-
-#ifndef arch_atomic64_add_negative_acquire
+#if defined(arch_atomic64_add_negative_release)
+#define raw_atomic64_add_negative_release arch_atomic64_add_negative_release
+#elif defined(arch_atomic64_add_negative_relaxed)
 static __always_inline bool
-arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
+raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
-	bool ret = arch_atomic64_add_negative_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
+	__atomic_release_fence();
+	return arch_atomic64_add_negative_relaxed(i, v);
 }
-#define arch_atomic64_add_negative_acquire arch_atomic64_add_negative_acquire
-#endif
-
-#ifndef arch_atomic64_add_negative_release
+#elif defined(arch_atomic64_add_negative)
+#define raw_atomic64_add_negative_release arch_atomic64_add_negative
+#else
 static __always_inline bool
-arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
+raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
-	__atomic_release_fence();
-	return arch_atomic64_add_negative_relaxed(i, v);
+	return raw_atomic64_add_return_release(i, v) < 0;
 }
-#define arch_atomic64_add_negative_release arch_atomic64_add_negative_release
 #endif
 
-#ifndef arch_atomic64_add_negative
+#if defined(arch_atomic64_add_negative_relaxed)
+#define raw_atomic64_add_negative_relaxed arch_atomic64_add_negative_relaxed
+#elif defined(arch_atomic64_add_negative)
+#define raw_atomic64_add_negative_relaxed arch_atomic64_add_negative
+#else
 static __always_inline bool
-arch_atomic64_add_negative(s64 i, atomic64_t *v)
+raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_add_negative_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
+	return raw_atomic64_add_return_relaxed(i, v) < 0;
 }
-#define arch_atomic64_add_negative arch_atomic64_add_negative
 #endif
 
-#endif /* arch_atomic64_add_negative_relaxed */
-
-#ifndef arch_atomic64_fetch_add_unless
+#if defined(arch_atomic64_fetch_add_unless)
+#define raw_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
+#else
 static __always_inline s64
-arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	s64 c = arch_atomic64_read(v);
+	s64 c = raw_atomic64_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
-#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 #endif
 
-#ifndef arch_atomic64_add_unless
+#if defined(arch_atomic64_add_unless)
+#define raw_atomic64_add_unless arch_atomic64_add_unless
+#else
 static __always_inline bool
-arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	return arch_atomic64_fetch_add_unless(v, a, u) != u;
+	return raw_atomic64_fetch_add_unless(v, a, u) != u;
 }
-#define arch_atomic64_add_unless arch_atomic64_add_unless
 #endif
 
-#ifndef arch_atomic64_inc_not_zero
+#if defined(arch_atomic64_inc_not_zero)
+#define raw_atomic64_inc_not_zero arch_atomic64_inc_not_zero
+#else
 static __always_inline bool
-arch_atomic64_inc_not_zero(atomic64_t *v)
+raw_atomic64_inc_not_zero(atomic64_t *v)
 {
-	return arch_atomic64_add_unless(v, 1, 0);
+	return raw_atomic64_add_unless(v, 1, 0);
 }
-#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 #endif
 
-#ifndef arch_atomic64_inc_unless_negative
+#if defined(arch_atomic64_inc_unless_negative)
+#define raw_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
+#else
 static __always_inline bool
-arch_atomic64_inc_unless_negative(atomic64_t *v)
+raw_atomic64_inc_unless_negative(atomic64_t *v)
 {
-	s64 c = arch_atomic64_read(v);
+	s64 c = raw_atomic64_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c + 1));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
-#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
 #endif
 
-#ifndef arch_atomic64_dec_unless_positive
+#if defined(arch_atomic64_dec_unless_positive)
+#define raw_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
+#else
 static __always_inline bool
-arch_atomic64_dec_unless_positive(atomic64_t *v)
+raw_atomic64_dec_unless_positive(atomic64_t *v)
 {
-	s64 c = arch_atomic64_read(v);
+	s64 c = raw_atomic64_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c - 1));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
-#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
 #endif
 
-#ifndef arch_atomic64_dec_if_positive
+#if defined(arch_atomic64_dec_if_positive)
+#define raw_atomic64_dec_if_positive arch_atomic64_dec_if_positive
+#else
 static __always_inline s64
-arch_atomic64_dec_if_positive(atomic64_t *v)
+raw_atomic64_dec_if_positive(atomic64_t *v)
 {
-	s64 dec, c = arch_atomic64_read(v);
+	s64 dec, c = raw_atomic64_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
-#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// e1cee558cc61cae887890db30fcdf93baca9f498
+// c2048fccede6fac923252290e2b303949d5dec83
diff --git a/include/linux/atomic/atomic-raw.h b/include/linux/atomic/atomic-raw.h
deleted file mode 100644
index 8b2fc04cf8c54..0000000000000
--- a/include/linux/atomic/atomic-raw.h
+++ /dev/null
@@ -1,1135 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by scripts/atomic/gen-atomic-raw.sh
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-#ifndef _LINUX_ATOMIC_RAW_H
-#define _LINUX_ATOMIC_RAW_H
-
-static __always_inline int
-raw_atomic_read(const atomic_t *v)
-{
-	return arch_atomic_read(v);
-}
-
-static __always_inline int
-raw_atomic_read_acquire(const atomic_t *v)
-{
-	return arch_atomic_read_acquire(v);
-}
-
-static __always_inline void
-raw_atomic_set(atomic_t *v, int i)
-{
-	arch_atomic_set(v, i);
-}
-
-static __always_inline void
-raw_atomic_set_release(atomic_t *v, int i)
-{
-	arch_atomic_set_release(v, i);
-}
-
-static __always_inline void
-raw_atomic_add(int i, atomic_t *v)
-{
-	arch_atomic_add(i, v);
-}
-
-static __always_inline int
-raw_atomic_add_return(int i, atomic_t *v)
-{
-	return arch_atomic_add_return(i, v);
-}
-
-static __always_inline int
-raw_atomic_add_return_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_add_return_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_add_return_release(int i, atomic_t *v)
-{
-	return arch_atomic_add_return_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_add_return_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_add_return_relaxed(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_add(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_add(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_add_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_add_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_add_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_add_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_add_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_sub(int i, atomic_t *v)
-{
-	arch_atomic_sub(i, v);
-}
-
-static __always_inline int
-raw_atomic_sub_return(int i, atomic_t *v)
-{
-	return arch_atomic_sub_return(i, v);
-}
-
-static __always_inline int
-raw_atomic_sub_return_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_sub_return_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_sub_return_release(int i, atomic_t *v)
-{
-	return arch_atomic_sub_return_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_sub_return_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_sub_return_relaxed(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_sub(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_sub(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_sub_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_sub_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_sub_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_sub_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_sub_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_inc(atomic_t *v)
-{
-	arch_atomic_inc(v);
-}
-
-static __always_inline int
-raw_atomic_inc_return(atomic_t *v)
-{
-	return arch_atomic_inc_return(v);
-}
-
-static __always_inline int
-raw_atomic_inc_return_acquire(atomic_t *v)
-{
-	return arch_atomic_inc_return_acquire(v);
-}
-
-static __always_inline int
-raw_atomic_inc_return_release(atomic_t *v)
-{
-	return arch_atomic_inc_return_release(v);
-}
-
-static __always_inline int
-raw_atomic_inc_return_relaxed(atomic_t *v)
-{
-	return arch_atomic_inc_return_relaxed(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_inc(atomic_t *v)
-{
-	return arch_atomic_fetch_inc(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_inc_acquire(atomic_t *v)
-{
-	return arch_atomic_fetch_inc_acquire(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_inc_release(atomic_t *v)
-{
-	return arch_atomic_fetch_inc_release(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_inc_relaxed(atomic_t *v)
-{
-	return arch_atomic_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_dec(atomic_t *v)
-{
-	arch_atomic_dec(v);
-}
-
-static __always_inline int
-raw_atomic_dec_return(atomic_t *v)
-{
-	return arch_atomic_dec_return(v);
-}
-
-static __always_inline int
-raw_atomic_dec_return_acquire(atomic_t *v)
-{
-	return arch_atomic_dec_return_acquire(v);
-}
-
-static __always_inline int
-raw_atomic_dec_return_release(atomic_t *v)
-{
-	return arch_atomic_dec_return_release(v);
-}
-
-static __always_inline int
-raw_atomic_dec_return_relaxed(atomic_t *v)
-{
-	return arch_atomic_dec_return_relaxed(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_dec(atomic_t *v)
-{
-	return arch_atomic_fetch_dec(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_dec_acquire(atomic_t *v)
-{
-	return arch_atomic_fetch_dec_acquire(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_dec_release(atomic_t *v)
-{
-	return arch_atomic_fetch_dec_release(v);
-}
-
-static __always_inline int
-raw_atomic_fetch_dec_relaxed(atomic_t *v)
-{
-	return arch_atomic_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_and(int i, atomic_t *v)
-{
-	arch_atomic_and(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_and(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_and_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_and_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_and_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_andnot(int i, atomic_t *v)
-{
-	arch_atomic_andnot(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_andnot(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_andnot(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_andnot_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_or(int i, atomic_t *v)
-{
-	arch_atomic_or(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_or(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_or(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_or_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_or_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_or_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_or_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_or_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_xor(int i, atomic_t *v)
-{
-	arch_atomic_xor(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_xor(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_xor(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_xor_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_xor_acquire(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_xor_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_xor_release(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_xor_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline int
-raw_atomic_xchg(atomic_t *v, int i)
-{
-	return arch_atomic_xchg(v, i);
-}
-
-static __always_inline int
-raw_atomic_xchg_acquire(atomic_t *v, int i)
-{
-	return arch_atomic_xchg_acquire(v, i);
-}
-
-static __always_inline int
-raw_atomic_xchg_release(atomic_t *v, int i)
-{
-	return arch_atomic_xchg_release(v, i);
-}
-
-static __always_inline int
-raw_atomic_xchg_relaxed(atomic_t *v, int i)
-{
-	return arch_atomic_xchg_relaxed(v, i);
-}
-
-static __always_inline int
-raw_atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	return arch_atomic_cmpxchg(v, old, new);
-}
-
-static __always_inline int
-raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
-{
-	return arch_atomic_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline int
-raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
-{
-	return arch_atomic_cmpxchg_release(v, old, new);
-}
-
-static __always_inline int
-raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
-{
-	return arch_atomic_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	return arch_atomic_try_cmpxchg(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	return arch_atomic_try_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	return arch_atomic_try_cmpxchg_release(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
-{
-	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_sub_and_test(int i, atomic_t *v)
-{
-	return arch_atomic_sub_and_test(i, v);
-}
-
-static __always_inline bool
-raw_atomic_dec_and_test(atomic_t *v)
-{
-	return arch_atomic_dec_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_inc_and_test(atomic_t *v)
-{
-	return arch_atomic_inc_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_add_negative(int i, atomic_t *v)
-{
-	return arch_atomic_add_negative(i, v);
-}
-
-static __always_inline bool
-raw_atomic_add_negative_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_add_negative_acquire(i, v);
-}
-
-static __always_inline bool
-raw_atomic_add_negative_release(int i, atomic_t *v)
-{
-	return arch_atomic_add_negative_release(i, v);
-}
-
-static __always_inline bool
-raw_atomic_add_negative_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_add_negative_relaxed(i, v);
-}
-
-static __always_inline int
-raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	return arch_atomic_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_add_unless(atomic_t *v, int a, int u)
-{
-	return arch_atomic_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_inc_not_zero(atomic_t *v)
-{
-	return arch_atomic_inc_not_zero(v);
-}
-
-static __always_inline bool
-raw_atomic_inc_unless_negative(atomic_t *v)
-{
-	return arch_atomic_inc_unless_negative(v);
-}
-
-static __always_inline bool
-raw_atomic_dec_unless_positive(atomic_t *v)
-{
-	return arch_atomic_dec_unless_positive(v);
-}
-
-static __always_inline int
-raw_atomic_dec_if_positive(atomic_t *v)
-{
-	return arch_atomic_dec_if_positive(v);
-}
-
-static __always_inline s64
-raw_atomic64_read(const atomic64_t *v)
-{
-	return arch_atomic64_read(v);
-}
-
-static __always_inline s64
-raw_atomic64_read_acquire(const atomic64_t *v)
-{
-	return arch_atomic64_read_acquire(v);
-}
-
-static __always_inline void
-raw_atomic64_set(atomic64_t *v, s64 i)
-{
-	arch_atomic64_set(v, i);
-}
-
-static __always_inline void
-raw_atomic64_set_release(atomic64_t *v, s64 i)
-{
-	arch_atomic64_set_release(v, i);
-}
-
-static __always_inline void
-raw_atomic64_add(s64 i, atomic64_t *v)
-{
-	arch_atomic64_add(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_add_return(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_add_return_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_add_return_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return_relaxed(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_add(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_add(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_add_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_add_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_add_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic64_sub(s64 i, atomic64_t *v)
-{
-	arch_atomic64_sub(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_sub_return(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_sub_return_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_sub_return_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_sub_return_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_sub_return_relaxed(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic64_inc(atomic64_t *v)
-{
-	arch_atomic64_inc(v);
-}
-
-static __always_inline s64
-raw_atomic64_inc_return(atomic64_t *v)
-{
-	return arch_atomic64_inc_return(v);
-}
-
-static __always_inline s64
-raw_atomic64_inc_return_acquire(atomic64_t *v)
-{
-	return arch_atomic64_inc_return_acquire(v);
-}
-
-static __always_inline s64
-raw_atomic64_inc_return_release(atomic64_t *v)
-{
-	return arch_atomic64_inc_return_release(v);
-}
-
-static __always_inline s64
-raw_atomic64_inc_return_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_inc_return_relaxed(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_inc(atomic64_t *v)
-{
-	return arch_atomic64_fetch_inc(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_inc_acquire(atomic64_t *v)
-{
-	return arch_atomic64_fetch_inc_acquire(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_inc_release(atomic64_t *v)
-{
-	return arch_atomic64_fetch_inc_release(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic64_dec(atomic64_t *v)
-{
-	arch_atomic64_dec(v);
-}
-
-static __always_inline s64
-raw_atomic64_dec_return(atomic64_t *v)
-{
-	return arch_atomic64_dec_return(v);
-}
-
-static __always_inline s64
-raw_atomic64_dec_return_acquire(atomic64_t *v)
-{
-	return arch_atomic64_dec_return_acquire(v);
-}
-
-static __always_inline s64
-raw_atomic64_dec_return_release(atomic64_t *v)
-{
-	return arch_atomic64_dec_return_release(v);
-}
-
-static __always_inline s64
-raw_atomic64_dec_return_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_dec_return_relaxed(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_dec(atomic64_t *v)
-{
-	return arch_atomic64_fetch_dec(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_dec_acquire(atomic64_t *v)
-{
-	return arch_atomic64_fetch_dec_acquire(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_dec_release(atomic64_t *v)
-{
-	return arch_atomic64_fetch_dec_release(v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic64_and(s64 i, atomic64_t *v)
-{
-	arch_atomic64_and(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_and_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic64_andnot(s64 i, atomic64_t *v)
-{
-	arch_atomic64_andnot(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_andnot(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_andnot_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic64_or(s64 i, atomic64_t *v)
-{
-	arch_atomic64_or(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_or(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_or(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_or_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_or_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_or_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic64_xor(s64 i, atomic64_t *v)
-{
-	arch_atomic64_xor(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_xor(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_xor(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_xor_acquire(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_xor_release(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_xchg(atomic64_t *v, s64 i)
-{
-	return arch_atomic64_xchg(v, i);
-}
-
-static __always_inline s64
-raw_atomic64_xchg_acquire(atomic64_t *v, s64 i)
-{
-	return arch_atomic64_xchg_acquire(v, i);
-}
-
-static __always_inline s64
-raw_atomic64_xchg_release(atomic64_t *v, s64 i)
-{
-	return arch_atomic64_xchg_release(v, i);
-}
-
-static __always_inline s64
-raw_atomic64_xchg_relaxed(atomic64_t *v, s64 i)
-{
-	return arch_atomic64_xchg_relaxed(v, i);
-}
-
-static __always_inline s64
-raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
-{
-	return arch_atomic64_cmpxchg(v, old, new);
-}
-
-static __always_inline s64
-raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
-{
-	return arch_atomic64_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline s64
-raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
-{
-	return arch_atomic64_cmpxchg_release(v, old, new);
-}
-
-static __always_inline s64
-raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
-{
-	return arch_atomic64_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	return arch_atomic64_try_cmpxchg(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	return arch_atomic64_try_cmpxchg_release(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
-{
-	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic64_sub_and_test(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_sub_and_test(i, v);
-}
-
-static __always_inline bool
-raw_atomic64_dec_and_test(atomic64_t *v)
-{
-	return arch_atomic64_dec_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic64_inc_and_test(atomic64_t *v)
-{
-	return arch_atomic64_inc_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic64_add_negative(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_negative(i, v);
-}
-
-static __always_inline bool
-raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_negative_acquire(i, v);
-}
-
-static __always_inline bool
-raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_negative_release(i, v);
-}
-
-static __always_inline bool
-raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_negative_relaxed(i, v);
-}
-
-static __always_inline s64
-raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	return arch_atomic64_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	return arch_atomic64_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic64_inc_not_zero(atomic64_t *v)
-{
-	return arch_atomic64_inc_not_zero(v);
-}
-
-static __always_inline bool
-raw_atomic64_inc_unless_negative(atomic64_t *v)
-{
-	return arch_atomic64_inc_unless_negative(v);
-}
-
-static __always_inline bool
-raw_atomic64_dec_unless_positive(atomic64_t *v)
-{
-	return arch_atomic64_dec_unless_positive(v);
-}
-
-static __always_inline s64
-raw_atomic64_dec_if_positive(atomic64_t *v)
-{
-	return arch_atomic64_dec_if_positive(v);
-}
-
-#define raw_xchg(...) \
-	arch_xchg(__VA_ARGS__)
-
-#define raw_xchg_acquire(...) \
-	arch_xchg_acquire(__VA_ARGS__)
-
-#define raw_xchg_release(...) \
-	arch_xchg_release(__VA_ARGS__)
-
-#define raw_xchg_relaxed(...) \
-	arch_xchg_relaxed(__VA_ARGS__)
-
-#define raw_cmpxchg(...) \
-	arch_cmpxchg(__VA_ARGS__)
-
-#define raw_cmpxchg_acquire(...) \
-	arch_cmpxchg_acquire(__VA_ARGS__)
-
-#define raw_cmpxchg_release(...) \
-	arch_cmpxchg_release(__VA_ARGS__)
-
-#define raw_cmpxchg_relaxed(...) \
-	arch_cmpxchg_relaxed(__VA_ARGS__)
-
-#define raw_cmpxchg64(...) \
-	arch_cmpxchg64(__VA_ARGS__)
-
-#define raw_cmpxchg64_acquire(...) \
-	arch_cmpxchg64_acquire(__VA_ARGS__)
-
-#define raw_cmpxchg64_release(...) \
-	arch_cmpxchg64_release(__VA_ARGS__)
-
-#define raw_cmpxchg64_relaxed(...) \
-	arch_cmpxchg64_relaxed(__VA_ARGS__)
-
-#define raw_cmpxchg128(...) \
-	arch_cmpxchg128(__VA_ARGS__)
-
-#define raw_cmpxchg128_acquire(...) \
-	arch_cmpxchg128_acquire(__VA_ARGS__)
-
-#define raw_cmpxchg128_release(...) \
-	arch_cmpxchg128_release(__VA_ARGS__)
-
-#define raw_cmpxchg128_relaxed(...) \
-	arch_cmpxchg128_relaxed(__VA_ARGS__)
-
-#define raw_try_cmpxchg(...) \
-	arch_try_cmpxchg(__VA_ARGS__)
-
-#define raw_try_cmpxchg_acquire(...) \
-	arch_try_cmpxchg_acquire(__VA_ARGS__)
-
-#define raw_try_cmpxchg_release(...) \
-	arch_try_cmpxchg_release(__VA_ARGS__)
-
-#define raw_try_cmpxchg_relaxed(...) \
-	arch_try_cmpxchg_relaxed(__VA_ARGS__)
-
-#define raw_try_cmpxchg64(...) \
-	arch_try_cmpxchg64(__VA_ARGS__)
-
-#define raw_try_cmpxchg64_acquire(...) \
-	arch_try_cmpxchg64_acquire(__VA_ARGS__)
-
-#define raw_try_cmpxchg64_release(...) \
-	arch_try_cmpxchg64_release(__VA_ARGS__)
-
-#define raw_try_cmpxchg64_relaxed(...) \
-	arch_try_cmpxchg64_relaxed(__VA_ARGS__)
-
-#define raw_try_cmpxchg128(...) \
-	arch_try_cmpxchg128(__VA_ARGS__)
-
-#define raw_try_cmpxchg128_acquire(...) \
-	arch_try_cmpxchg128_acquire(__VA_ARGS__)
-
-#define raw_try_cmpxchg128_release(...) \
-	arch_try_cmpxchg128_release(__VA_ARGS__)
-
-#define raw_try_cmpxchg128_relaxed(...) \
-	arch_try_cmpxchg128_relaxed(__VA_ARGS__)
-
-#define raw_cmpxchg_local(...) \
-	arch_cmpxchg_local(__VA_ARGS__)
-
-#define raw_cmpxchg64_local(...) \
-	arch_cmpxchg64_local(__VA_ARGS__)
-
-#define raw_cmpxchg128_local(...) \
-	arch_cmpxchg128_local(__VA_ARGS__)
-
-#define raw_sync_cmpxchg(...) \
-	arch_sync_cmpxchg(__VA_ARGS__)
-
-#define raw_try_cmpxchg_local(...) \
-	arch_try_cmpxchg_local(__VA_ARGS__)
-
-#define raw_try_cmpxchg64_local(...) \
-	arch_try_cmpxchg64_local(__VA_ARGS__)
-
-#define raw_try_cmpxchg128_local(...) \
-	arch_try_cmpxchg128_local(__VA_ARGS__)
-
-#endif /* _LINUX_ATOMIC_RAW_H */
-// b23ed4424e85200e200ded094522e1d743b3a5b1
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index ef764085c79aa..b0f732a5c46ef 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_${pfx}${name}${sfx}_acquire(${params})
+raw_${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
 	${ret} ret = arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index d0bd2dfbb244c..16876118019ec 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
+raw_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
 {
-	return arch_${atomic}_add_return${order}(i, v) < 0;
+	return raw_${atomic}_add_return${order}(i, v) < 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index cf79b9da38dbb..88593e28b1637 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,7 +1,7 @@
 cat << EOF
 static __always_inline bool
-arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+raw_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	return arch_${atomic}_fetch_add_unless(v, a, u) != u;
+	return raw_${atomic}_fetch_add_unless(v, a, u) != u;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 5a42f54a35950..5b83bb63f7284 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+raw_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-	${retstmt}arch_${atomic}_${pfx}and${sfx}${order}(~i, v);
+	${retstmt}raw_${atomic}_${pfx}and${sfx}${order}(~i, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/cmpxchg b/scripts/atomic/fallbacks/cmpxchg
index 87cd010f98d58..312ee67f1743e 100755
--- a/scripts/atomic/fallbacks/cmpxchg
+++ b/scripts/atomic/fallbacks/cmpxchg
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${int}
-arch_${atomic}_cmpxchg${order}(${atomic}_t *v, ${int} old, ${int} new)
+raw_${atomic}_cmpxchg${order}(${atomic}_t *v, ${int} old, ${int} new)
 {
-	return arch_cmpxchg${order}(&v->counter, old, new);
+	return raw_cmpxchg${order}(&v->counter, old, new);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index 8c144c818e9ed..a660ac65994bd 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+raw_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}arch_${atomic}_${pfx}sub${sfx}${order}(1, v);
+	${retstmt}raw_${atomic}_${pfx}sub${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 3f6b6a8b47733..521dfcae03f24 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_dec_and_test(${atomic}_t *v)
+raw_${atomic}_dec_and_test(${atomic}_t *v)
 {
-	return arch_${atomic}_dec_return(v) == 0;
+	return raw_${atomic}_dec_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index 86bdced3428d6..7acb205e6ce35 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,14 +1,14 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_dec_if_positive(${atomic}_t *v)
+raw_${atomic}_dec_if_positive(${atomic}_t *v)
 {
-	${int} dec, c = arch_${atomic}_read(v);
+	${int} dec, c = raw_${atomic}_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!arch_${atomic}_try_cmpxchg(v, &c, dec));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index c531d5afecc47..bcb4f27945eaa 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_dec_unless_positive(${atomic}_t *v)
+raw_${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-	${int} c = arch_${atomic}_read(v);
+	${int} c = raw_${atomic}_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!arch_${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 07757d8e338ef..067eea553f5e0 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_${pfx}${name}${sfx}(${params})
+raw_${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
 	__atomic_pre_full_fence();
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index 81d2834f03d23..c18b940153dfd 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,13 +1,13 @@
 cat << EOF
 static __always_inline ${int}
-arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+raw_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	${int} c = arch_${atomic}_read(v);
+	${int} c = raw_${atomic}_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!arch_${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index 3c2c3739169e5..7d838f0b66391 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+raw_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}arch_${atomic}_${pfx}add${sfx}${order}(1, v);
+	${retstmt}raw_${atomic}_${pfx}add${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index c726a6d0634d3..de25aebee715d 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_inc_and_test(${atomic}_t *v)
+raw_${atomic}_inc_and_test(${atomic}_t *v)
 {
-	return arch_${atomic}_inc_return(v) == 0;
+	return raw_${atomic}_inc_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index 97603591aac2a..e02206d017f62 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_inc_not_zero(${atomic}_t *v)
+raw_${atomic}_inc_not_zero(${atomic}_t *v)
 {
-	return arch_${atomic}_add_unless(v, 1, 0);
+	return raw_${atomic}_add_unless(v, 1, 0);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 95d8ce48233ff..7b85cc5b00d2b 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_inc_unless_negative(${atomic}_t *v)
+raw_${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-	${int} c = arch_${atomic}_read(v);
+	${int} c = raw_${atomic}_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!arch_${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index a0ea1d26e6b2e..26d15ad92d043 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_read_acquire(const ${atomic}_t *v)
+raw_${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	${int} ret;
 
 	if (__native_word(${atomic}_t)) {
 		ret = smp_load_acquire(&(v)->counter);
 	} else {
-		ret = arch_${atomic}_read(v);
+		ret = raw_${atomic}_read(v);
 		__atomic_acquire_fence();
 	}
 
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index b46feb56d69ca..cbbff708129b8 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline ${ret}
-arch_${atomic}_${pfx}${name}${sfx}_release(${params})
+raw_${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
 	${retstmt}arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 05cdb7f42477a..104693bc3c660 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,12 +1,12 @@
 cat <<EOF
 static __always_inline void
-arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
+raw_${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	if (__native_word(${atomic}_t)) {
 		smp_store_release(&(v)->counter, i);
 	} else {
 		__atomic_release_fence();
-		arch_${atomic}_set(v, i);
+		raw_${atomic}_set(v, i);
 	}
 }
 EOF
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index da8a049c9b02b..8975a496d495c 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+raw_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-	return arch_${atomic}_sub_return(i, v) == 0;
+	return raw_${atomic}_sub_return(i, v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 890f850ede378..4c911a6cced94 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,9 +1,9 @@
 cat <<EOF
 static __always_inline bool
-arch_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+raw_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o = *old;
-	r = arch_${atomic}_cmpxchg${order}(v, o, new);
+	r = raw_${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
diff --git a/scripts/atomic/fallbacks/xchg b/scripts/atomic/fallbacks/xchg
index 733b8980b2f3b..bdd788aa575ff 100755
--- a/scripts/atomic/fallbacks/xchg
+++ b/scripts/atomic/fallbacks/xchg
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${int}
-arch_${atomic}_xchg${order}(${atomic}_t *v, ${int} new)
+raw_${atomic}_xchg${order}(${atomic}_t *v, ${int} new)
 {
-	return arch_xchg${order}(&v->counter, new);
+	return raw_xchg${order}(&v->counter, new);
 }
 EOF
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 337330865fa2e..86aca4f9f315a 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -17,19 +17,12 @@ gen_template_fallback()
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local atomicname="arch_${atomic}_${pfx}${name}${sfx}${order}"
-
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 	local params="$(gen_params "${int}" "${atomic}" "$@")"
 	local args="$(gen_args "$@")"
 
-	if [ ! -z "${template}" ]; then
-		printf "#ifndef ${atomicname}\n"
-		. ${template}
-		printf "#define ${atomicname} ${atomicname}\n"
-		printf "#endif\n\n"
-	fi
+	. ${template}
 }
 
 #gen_order_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
@@ -59,69 +52,92 @@ gen_proto_fallback()
 	gen_template_fallback "${tmpl}" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
 }
 
-#gen_basic_fallbacks(basename)
-gen_basic_fallbacks()
-{
-	local basename="$1"; shift
-cat << EOF
-#define ${basename}_acquire ${basename}
-#define ${basename}_release ${basename}
-#define ${basename}_relaxed ${basename}
-EOF
-}
-
-#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
-gen_proto_order_variants()
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, args...)
+gen_proto_order_variant()
 {
 	local meta="$1"; shift
 	local pfx="$1"; shift
 	local name="$1"; shift
 	local sfx="$1"; shift
+	local order="$1"; shift
 	local atomic="$1"
 
-	local basename="arch_${atomic}_${pfx}${name}${sfx}"
-
-	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "")"
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+	local basename="${atomic}_${pfx}${name}${sfx}"
 
-	# If we don't have relaxed atomics, then we don't bother with ordering fallbacks
-	# read_acquire and set_release need to be templated, though
-	if ! meta_has_relaxed "${meta}"; then
-		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
-		if meta_has_acquire "${meta}"; then
-			gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
-		fi
+	# Where there is no possible fallback, this order variant is mandatory
+	# and must be provided by arch code. Add a comment to the header to
+	# make this obvious.
+	#
+	# Ideally we'd error on a missing definition, but arch code might
+	# define this order variant as a C function without a preprocessor
+	# symbol.
+	if [ -z ${template} ] && [ -z "${order}" ] && ! meta_has_relaxed "${meta}"; then
+		printf "#define raw_${atomicname} arch_${atomicname}\n\n"
+		return
+	fi
 
-		if meta_has_release "${meta}"; then
-			gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-		fi
+	printf "#if defined(arch_${atomicname})\n"
+	printf "#define raw_${atomicname} arch_${atomicname}\n"
 
-		return
+	# Allow FULL/ACQUIRE/RELEASE ops to be defined in terms of RELAXED ops
+	if [ "${order}" != "_relaxed" ] && meta_has_relaxed "${meta}"; then
+		printf "#elif defined(arch_${basename}_relaxed)\n"
+		gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
 	fi
 
-	printf "#ifndef ${basename}_relaxed\n"
+	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
+	if [ ! -z "${order}" ]; then
+		printf "#elif defined(arch_${basename})\n"
+		printf "#define raw_${atomicname} arch_${basename}\n"
+	fi
 
+	printf "#else\n"
 	if [ ! -z "${template}" ]; then
-		printf "#ifdef ${basename}\n"
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+	else
+		printf "#error \"Unable to define raw_${atomicname}\"\n"
 	fi
 
-	gen_basic_fallbacks "${basename}"
+	printf "#endif\n\n"
+}
 
-	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${basename} */\n\n"
-		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
-		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
-		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" "$@"
+
+#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
+gen_proto_order_variants()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local atomic="$1"
+
+	gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+
+	if meta_has_acquire "${meta}"; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 	fi
 
-	printf "#else /* ${basename}_relaxed */\n\n"
+	if meta_has_release "${meta}"; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+	fi
 
-	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
-	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+	if meta_has_relaxed "${meta}"; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" "$@"
+	fi
+}
 
-	printf "#endif /* ${basename}_relaxed */\n\n"
+#gen_basic_fallbacks(basename)
+gen_basic_fallbacks()
+{
+	local basename="$1"; shift
+cat << EOF
+#define raw_${basename}_acquire arch_${basename}
+#define raw_${basename}_release arch_${basename}
+#define raw_${basename}_relaxed arch_${basename}
+EOF
 }
 
 gen_order_fallbacks()
@@ -130,36 +146,65 @@ gen_order_fallbacks()
 
 cat <<EOF
 
-#ifndef ${xchg}_acquire
-#define ${xchg}_acquire(...) \\
-	__atomic_op_acquire(${xchg}, __VA_ARGS__)
+#define raw_${xchg}_relaxed arch_${xchg}_relaxed
+
+#ifdef arch_${xchg}_acquire
+#define raw_${xchg}_acquire arch_${xchg}_acquire
+#else
+#define raw_${xchg}_acquire(...) \\
+	__atomic_op_acquire(arch_${xchg}, __VA_ARGS__)
 #endif
 
-#ifndef ${xchg}_release
-#define ${xchg}_release(...) \\
-	__atomic_op_release(${xchg}, __VA_ARGS__)
+#ifdef arch_${xchg}_release
+#define raw_${xchg}_release arch_${xchg}_release
+#else
+#define raw_${xchg}_release(...) \\
+	__atomic_op_release(arch_${xchg}, __VA_ARGS__)
 #endif
 
-#ifndef ${xchg}
-#define ${xchg}(...) \\
-	__atomic_op_fence(${xchg}, __VA_ARGS__)
+#ifdef arch_${xchg}
+#define raw_${xchg} arch_${xchg}
+#else
+#define raw_${xchg}(...) \\
+	__atomic_op_fence(arch_${xchg}, __VA_ARGS__)
 #endif
 
 EOF
 }
 
-gen_xchg_fallbacks()
+gen_xchg_order_fallback()
 {
 	local xchg="$1"; shift
-	printf "#ifndef ${xchg}_relaxed\n"
+	local order="$1"; shift
+	local forder="${order:-_fence}"
 
-	gen_basic_fallbacks ${xchg}
+	printf "#if defined(arch_${xchg}${order})\n"
+	printf "#define raw_${xchg}${order} arch_${xchg}${order}\n"
 
-	printf "#else /* ${xchg}_relaxed */\n"
+	if [ "${order}" != "_relaxed" ]; then
+		printf "#elif defined(arch_${xchg}_relaxed)\n"
+		printf "#define raw_${xchg}${order}(...) \\\\\n"
+		printf "	__atomic_op${forder}(arch_${xchg}, __VA_ARGS__)\n"
+	fi
 
-	gen_order_fallbacks ${xchg}
+	if [ ! -z "${order}" ]; then
+		printf "#elif defined(arch_${xchg})\n"
+		printf "#define raw_${xchg}${order} arch_${xchg}\n"
+	fi
 
-	printf "#endif /* ${xchg}_relaxed */\n\n"
+	printf "#else\n"
+	printf "extern void raw_${xchg}${order}_not_implemented(void);\n"
+	printf "#define raw_${xchg}${order}(...) raw_${xchg}${order}_not_implemented()\n"
+	printf "#endif\n\n"
+}
+
+gen_xchg_fallbacks()
+{
+	local xchg="$1"; shift
+
+	for order in "" "_acquire" "_release" "_relaxed"; do
+		gen_xchg_order_fallback "${xchg}" "${order}"
+	done
 }
 
 gen_try_cmpxchg_fallback()
@@ -168,40 +213,61 @@ gen_try_cmpxchg_fallback()
 	local order="$1"; shift;
 
 cat <<EOF
-#ifndef arch_try_${cmpxchg}${order}
-#define arch_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
+#define raw_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
 ({ \\
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
-	___r = arch_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
+	___r = raw_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
 	likely(___r == ___o); \\
 })
-#endif /* arch_try_${cmpxchg}${order} */
-
 EOF
 }
 
-gen_try_cmpxchg_fallbacks()
+gen_try_cmpxchg_order_fallback()
 {
-	local cmpxchg="$1"; shift;
+	local cmpxchg="$1"; shift
+	local order="$1"; shift
+	local forder="${order:-_fence}"
 
-	printf "#ifndef arch_try_${cmpxchg}_relaxed\n"
-	printf "#ifdef arch_try_${cmpxchg}\n"
+	printf "#if defined(arch_try_${cmpxchg}${order})\n"
+	printf "#define raw_try_${cmpxchg}${order} arch_try_${cmpxchg}${order}\n"
 
-	gen_basic_fallbacks "arch_try_${cmpxchg}"
+	if [ "${order}" != "_relaxed" ]; then
+		printf "#elif defined(arch_try_${cmpxchg}_relaxed)\n"
+		printf "#define raw_try_${cmpxchg}${order}(...) \\\\\n"
+		printf "	__atomic_op${forder}(arch_try_${cmpxchg}, __VA_ARGS__)\n"
+	fi
+
+	if [ ! -z "${order}" ]; then
+		printf "#elif defined(arch_try_${cmpxchg})\n"
+		printf "#define raw_try_${cmpxchg}${order} arch_try_${cmpxchg}\n"
+	fi
 
-	printf "#endif /* arch_try_${cmpxchg} */\n\n"
+	printf "#else\n"
+	gen_try_cmpxchg_fallback "${cmpxchg}" "${order}"
+	printf "#endif\n\n"
+}
+
+gen_try_cmpxchg_fallbacks()
+{
+	local cmpxchg="$1"; shift;
 
 	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_try_cmpxchg_fallback "${cmpxchg}" "${order}"
+		gen_try_cmpxchg_order_fallback "${cmpxchg}" "${order}"
 	done
+}
 
-	printf "#else /* arch_try_${cmpxchg}_relaxed */\n"
-
-	gen_order_fallbacks "arch_try_${cmpxchg}"
+gen_cmpxchg_local_fallbacks()
+{
+	local cmpxchg="$1"; shift
 
-	printf "#endif /* arch_try_${cmpxchg}_relaxed */\n\n"
+	printf "#define raw_${cmpxchg} arch_${cmpxchg}\n\n"
+	printf "#ifdef arch_try_${cmpxchg}\n"
+	printf "#define raw_try_${cmpxchg} arch_try_${cmpxchg}\n"
+	printf "#else\n"
+	gen_try_cmpxchg_fallback "${cmpxchg}" ""
+	printf "#endif\n\n"
 }
 
 cat << EOF
@@ -217,7 +283,7 @@ cat << EOF
 
 EOF
 
-for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64" "arch_cmpxchg128"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
@@ -225,8 +291,12 @@ for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
 	gen_try_cmpxchg_fallbacks "${cmpxchg}"
 done
 
-for cmpxchg in "cmpxchg_local" "cmpxchg64_local"; do
-	gen_try_cmpxchg_fallback "${cmpxchg}" ""
+for cmpxchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local"; do
+	gen_cmpxchg_local_fallbacks "${cmpxchg}" ""
+done
+
+for cmpxchg in "sync_cmpxchg"; do
+	printf "#define raw_${cmpxchg} arch_${cmpxchg}\n\n"
 done
 
 grep '^[a-z]' "$1" | while read name meta args; do
diff --git a/scripts/atomic/gen-atomic-raw.sh b/scripts/atomic/gen-atomic-raw.sh
deleted file mode 100755
index c7e3c52b49279..0000000000000
--- a/scripts/atomic/gen-atomic-raw.sh
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-ATOMICDIR=$(dirname $0)
-
-. ${ATOMICDIR}/atomic-tbl.sh
-
-#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
-gen_proto_order_variant()
-{
-	local meta="$1"; shift
-	local pfx="$1"; shift
-	local name="$1"; shift
-	local sfx="$1"; shift
-	local order="$1"; shift
-	local atomic="$1"; shift
-	local int="$1"; shift
-
-	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
-
-	local ret="$(gen_ret_type "${meta}" "${int}")"
-	local params="$(gen_params "${int}" "${atomic}" "$@")"
-	local args="$(gen_args "$@")"
-	local retstmt="$(gen_ret_stmt "${meta}")"
-
-cat <<EOF
-static __always_inline ${ret}
-raw_${atomicname}(${params})
-{
-	${retstmt}arch_${atomicname}(${args});
-}
-
-EOF
-}
-
-gen_xchg()
-{
-	local xchg="$1"; shift
-	local order="$1"; shift
-
-cat <<EOF
-#define raw_${xchg}${order}(...) \\
-	arch_${xchg}${order}(__VA_ARGS__)
-EOF
-}
-
-cat << EOF
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by $0
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-#ifndef _LINUX_ATOMIC_RAW_H
-#define _LINUX_ATOMIC_RAW_H
-
-EOF
-
-grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
-done
-
-grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
-done
-
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
-	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_xchg "${xchg}" "${order}"
-		printf "\n"
-	done
-done
-
-for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local"; do
-	gen_xchg "${xchg}" ""
-	printf "\n"
-done
-
-cat <<EOF
-#endif /* _LINUX_ATOMIC_RAW_H */
-EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 631d351f9f1f3..5b98a83076932 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,7 +11,6 @@ cat <<EOF |
 gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
 gen-atomic-long.sh              linux/atomic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
-gen-atomic-raw.sh               linux/atomic/atomic-raw.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
-- 
2.30.2

