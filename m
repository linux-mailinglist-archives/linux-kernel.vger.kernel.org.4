Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3E70BE48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjEVM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjEVM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:27:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 015B011A;
        Mon, 22 May 2023 05:25:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D468F150C;
        Mon, 22 May 2023 05:26:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 002DF3F59C;
        Mon, 22 May 2023 05:25:32 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 23/26] locking/atomic: scripts: simplify raw_atomic*() definitions
Date:   Mon, 22 May 2023 13:24:26 +0100
Message-Id: <20230522122429.1915021-24-mark.rutland@arm.com>
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

Currently each ordering variant has several potential definitions,
with a mixture of preprocessor and C definitions, including several
copies of its C prototype, e.g.

| #if defined(arch_atomic_fetch_andnot_acquire)
| #define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
| #elif defined(arch_atomic_fetch_andnot_relaxed)
| static __always_inline int
| raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
| {
|       int ret = arch_atomic_fetch_andnot_relaxed(i, v);
|       __atomic_acquire_fence();
|       return ret;
| }
| #elif defined(arch_atomic_fetch_andnot)
| #define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
| #else
| static __always_inline int
| raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
| {
|       return raw_atomic_fetch_and_acquire(~i, v);
| }
| #endif

Make this a bit simpler by defining the C prototype once, and writing
the various potential definitions as plain C code guarded by ifdeffery.
For example, the above becomes:

| static __always_inline int
| raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
| {
| #if defined(arch_atomic_fetch_andnot_acquire)
|         return arch_atomic_fetch_andnot_acquire(i, v);
| #elif defined(arch_atomic_fetch_andnot_relaxed)
|         int ret = arch_atomic_fetch_andnot_relaxed(i, v);
|         __atomic_acquire_fence();
|         return ret;
| #elif defined(arch_atomic_fetch_andnot)
|         return arch_atomic_fetch_andnot(i, v);
| #else
|         return raw_atomic_fetch_and_acquire(~i, v);
| #endif
| }

Which is far easier to read. As we now always have a single copy of the
C prototype wrapping all the potential definitions, we now have an
obvious single location for kerneldoc comments.

At the same time, the fallbacks for raw_atomic*_xhcg() are made to use
'new' rather than 'i' as the name of the new value. This is what the
existing fallback template used, and is more consistent with the
raw_atomic{_try,}cmpxchg() fallbacks.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h  | 1790 +++++++++---------
 include/linux/atomic/atomic-instrumented.h   |   50 +-
 include/linux/atomic/atomic-long.h           |   26 +-
 scripts/atomic/atomics.tbl                   |    2 +-
 scripts/atomic/fallbacks/acquire             |    4 -
 scripts/atomic/fallbacks/add_negative        |    4 -
 scripts/atomic/fallbacks/add_unless          |    4 -
 scripts/atomic/fallbacks/andnot              |    4 -
 scripts/atomic/fallbacks/cmpxchg             |    4 -
 scripts/atomic/fallbacks/dec                 |    4 -
 scripts/atomic/fallbacks/dec_and_test        |    4 -
 scripts/atomic/fallbacks/dec_if_positive     |    4 -
 scripts/atomic/fallbacks/dec_unless_positive |    4 -
 scripts/atomic/fallbacks/fence               |    4 -
 scripts/atomic/fallbacks/fetch_add_unless    |    4 -
 scripts/atomic/fallbacks/inc                 |    4 -
 scripts/atomic/fallbacks/inc_and_test        |    4 -
 scripts/atomic/fallbacks/inc_not_zero        |    4 -
 scripts/atomic/fallbacks/inc_unless_negative |    4 -
 scripts/atomic/fallbacks/read_acquire        |    4 -
 scripts/atomic/fallbacks/release             |    4 -
 scripts/atomic/fallbacks/set_release         |    4 -
 scripts/atomic/fallbacks/sub_and_test        |    4 -
 scripts/atomic/fallbacks/try_cmpxchg         |    4 -
 scripts/atomic/fallbacks/xchg                |    4 -
 scripts/atomic/gen-atomic-fallback.sh        |   26 +-
 26 files changed, 901 insertions(+), 1077 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 99bc1a871dc12..470c2890ab8d6 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -428,16 +428,20 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 
 #define raw_sync_cmpxchg arch_sync_cmpxchg
 
-#define raw_atomic_read arch_atomic_read
+static __always_inline int
+raw_atomic_read(const atomic_t *v)
+{
+	return arch_atomic_read(v);
+}
 
-#if defined(arch_atomic_read_acquire)
-#define raw_atomic_read_acquire arch_atomic_read_acquire
-#elif defined(arch_atomic_read)
-#define raw_atomic_read_acquire arch_atomic_read
-#else
 static __always_inline int
 raw_atomic_read_acquire(const atomic_t *v)
 {
+#if defined(arch_atomic_read_acquire)
+	return arch_atomic_read_acquire(v);
+#elif defined(arch_atomic_read)
+	return arch_atomic_read(v);
+#else
 	int ret;
 
 	if (__native_word(atomic_t)) {
@@ -448,1144 +452,1088 @@ raw_atomic_read_acquire(const atomic_t *v)
 	}
 
 	return ret;
-}
 #endif
+}
 
-#define raw_atomic_set arch_atomic_set
+static __always_inline void
+raw_atomic_set(atomic_t *v, int i)
+{
+	arch_atomic_set(v, i);
+}
 
-#if defined(arch_atomic_set_release)
-#define raw_atomic_set_release arch_atomic_set_release
-#elif defined(arch_atomic_set)
-#define raw_atomic_set_release arch_atomic_set
-#else
 static __always_inline void
 raw_atomic_set_release(atomic_t *v, int i)
 {
+#if defined(arch_atomic_set_release)
+	arch_atomic_set_release(v, i);
+#elif defined(arch_atomic_set)
+	arch_atomic_set(v, i);
+#else
 	if (__native_word(atomic_t)) {
 		smp_store_release(&(v)->counter, i);
 	} else {
 		__atomic_release_fence();
 		raw_atomic_set(v, i);
 	}
-}
 #endif
+}
 
-#define raw_atomic_add arch_atomic_add
+static __always_inline void
+raw_atomic_add(int i, atomic_t *v)
+{
+	arch_atomic_add(i, v);
+}
 
-#if defined(arch_atomic_add_return)
-#define raw_atomic_add_return arch_atomic_add_return
-#elif defined(arch_atomic_add_return_relaxed)
 static __always_inline int
 raw_atomic_add_return(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_return)
+	return arch_atomic_add_return(i, v);
+#elif defined(arch_atomic_add_return_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_add_return_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_add_return"
 #endif
+}
 
-#if defined(arch_atomic_add_return_acquire)
-#define raw_atomic_add_return_acquire arch_atomic_add_return_acquire
-#elif defined(arch_atomic_add_return_relaxed)
 static __always_inline int
 raw_atomic_add_return_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_return_acquire)
+	return arch_atomic_add_return_acquire(i, v);
+#elif defined(arch_atomic_add_return_relaxed)
 	int ret = arch_atomic_add_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_add_return)
-#define raw_atomic_add_return_acquire arch_atomic_add_return
+	return arch_atomic_add_return(i, v);
 #else
 #error "Unable to define raw_atomic_add_return_acquire"
 #endif
+}
 
-#if defined(arch_atomic_add_return_release)
-#define raw_atomic_add_return_release arch_atomic_add_return_release
-#elif defined(arch_atomic_add_return_relaxed)
 static __always_inline int
 raw_atomic_add_return_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_return_release)
+	return arch_atomic_add_return_release(i, v);
+#elif defined(arch_atomic_add_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_add_return_relaxed(i, v);
-}
 #elif defined(arch_atomic_add_return)
-#define raw_atomic_add_return_release arch_atomic_add_return
+	return arch_atomic_add_return(i, v);
 #else
 #error "Unable to define raw_atomic_add_return_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_add_return_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_add_return_relaxed)
-#define raw_atomic_add_return_relaxed arch_atomic_add_return_relaxed
+	return arch_atomic_add_return_relaxed(i, v);
 #elif defined(arch_atomic_add_return)
-#define raw_atomic_add_return_relaxed arch_atomic_add_return
+	return arch_atomic_add_return(i, v);
 #else
 #error "Unable to define raw_atomic_add_return_relaxed"
 #endif
+}
 
-#if defined(arch_atomic_fetch_add)
-#define raw_atomic_fetch_add arch_atomic_fetch_add
-#elif defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
 raw_atomic_fetch_add(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_add)
+	return arch_atomic_fetch_add(i, v);
+#elif defined(arch_atomic_fetch_add_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_add_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_fetch_add"
 #endif
+}
 
-#if defined(arch_atomic_fetch_add_acquire)
-#define raw_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
-#elif defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
 raw_atomic_fetch_add_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_add_acquire)
+	return arch_atomic_fetch_add_acquire(i, v);
+#elif defined(arch_atomic_fetch_add_relaxed)
 	int ret = arch_atomic_fetch_add_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_add)
-#define raw_atomic_fetch_add_acquire arch_atomic_fetch_add
+	return arch_atomic_fetch_add(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_add_acquire"
 #endif
+}
 
-#if defined(arch_atomic_fetch_add_release)
-#define raw_atomic_fetch_add_release arch_atomic_fetch_add_release
-#elif defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
 raw_atomic_fetch_add_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_add_release)
+	return arch_atomic_fetch_add_release(i, v);
+#elif defined(arch_atomic_fetch_add_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_add_relaxed(i, v);
-}
 #elif defined(arch_atomic_fetch_add)
-#define raw_atomic_fetch_add_release arch_atomic_fetch_add
+	return arch_atomic_fetch_add(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_add_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_fetch_add_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_fetch_add_relaxed)
-#define raw_atomic_fetch_add_relaxed arch_atomic_fetch_add_relaxed
+	return arch_atomic_fetch_add_relaxed(i, v);
 #elif defined(arch_atomic_fetch_add)
-#define raw_atomic_fetch_add_relaxed arch_atomic_fetch_add
+	return arch_atomic_fetch_add(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_add_relaxed"
 #endif
+}
 
-#define raw_atomic_sub arch_atomic_sub
+static __always_inline void
+raw_atomic_sub(int i, atomic_t *v)
+{
+	arch_atomic_sub(i, v);
+}
 
-#if defined(arch_atomic_sub_return)
-#define raw_atomic_sub_return arch_atomic_sub_return
-#elif defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
 raw_atomic_sub_return(int i, atomic_t *v)
 {
+#if defined(arch_atomic_sub_return)
+	return arch_atomic_sub_return(i, v);
+#elif defined(arch_atomic_sub_return_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_sub_return_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_sub_return"
 #endif
+}
 
-#if defined(arch_atomic_sub_return_acquire)
-#define raw_atomic_sub_return_acquire arch_atomic_sub_return_acquire
-#elif defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
 raw_atomic_sub_return_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_sub_return_acquire)
+	return arch_atomic_sub_return_acquire(i, v);
+#elif defined(arch_atomic_sub_return_relaxed)
 	int ret = arch_atomic_sub_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_sub_return)
-#define raw_atomic_sub_return_acquire arch_atomic_sub_return
+	return arch_atomic_sub_return(i, v);
 #else
 #error "Unable to define raw_atomic_sub_return_acquire"
 #endif
+}
 
-#if defined(arch_atomic_sub_return_release)
-#define raw_atomic_sub_return_release arch_atomic_sub_return_release
-#elif defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
 raw_atomic_sub_return_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_sub_return_release)
+	return arch_atomic_sub_return_release(i, v);
+#elif defined(arch_atomic_sub_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_sub_return_relaxed(i, v);
-}
 #elif defined(arch_atomic_sub_return)
-#define raw_atomic_sub_return_release arch_atomic_sub_return
+	return arch_atomic_sub_return(i, v);
 #else
 #error "Unable to define raw_atomic_sub_return_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_sub_return_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_sub_return_relaxed)
-#define raw_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
+	return arch_atomic_sub_return_relaxed(i, v);
 #elif defined(arch_atomic_sub_return)
-#define raw_atomic_sub_return_relaxed arch_atomic_sub_return
+	return arch_atomic_sub_return(i, v);
 #else
 #error "Unable to define raw_atomic_sub_return_relaxed"
 #endif
+}
 
-#if defined(arch_atomic_fetch_sub)
-#define raw_atomic_fetch_sub arch_atomic_fetch_sub
-#elif defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
 raw_atomic_fetch_sub(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_sub)
+	return arch_atomic_fetch_sub(i, v);
+#elif defined(arch_atomic_fetch_sub_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_sub_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_fetch_sub"
 #endif
+}
 
-#if defined(arch_atomic_fetch_sub_acquire)
-#define raw_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
-#elif defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
 raw_atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_sub_acquire)
+	return arch_atomic_fetch_sub_acquire(i, v);
+#elif defined(arch_atomic_fetch_sub_relaxed)
 	int ret = arch_atomic_fetch_sub_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_sub)
-#define raw_atomic_fetch_sub_acquire arch_atomic_fetch_sub
+	return arch_atomic_fetch_sub(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_sub_acquire"
 #endif
+}
 
-#if defined(arch_atomic_fetch_sub_release)
-#define raw_atomic_fetch_sub_release arch_atomic_fetch_sub_release
-#elif defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
 raw_atomic_fetch_sub_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_sub_release)
+	return arch_atomic_fetch_sub_release(i, v);
+#elif defined(arch_atomic_fetch_sub_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_sub_relaxed(i, v);
-}
 #elif defined(arch_atomic_fetch_sub)
-#define raw_atomic_fetch_sub_release arch_atomic_fetch_sub
+	return arch_atomic_fetch_sub(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_sub_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_fetch_sub_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_fetch_sub_relaxed)
-#define raw_atomic_fetch_sub_relaxed arch_atomic_fetch_sub_relaxed
+	return arch_atomic_fetch_sub_relaxed(i, v);
 #elif defined(arch_atomic_fetch_sub)
-#define raw_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
+	return arch_atomic_fetch_sub(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_sub_relaxed"
 #endif
+}
 
-#if defined(arch_atomic_inc)
-#define raw_atomic_inc arch_atomic_inc
-#else
 static __always_inline void
 raw_atomic_inc(atomic_t *v)
 {
+#if defined(arch_atomic_inc)
+	arch_atomic_inc(v);
+#else
 	raw_atomic_add(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_return)
-#define raw_atomic_inc_return arch_atomic_inc_return
-#elif defined(arch_atomic_inc_return_relaxed)
 static __always_inline int
 raw_atomic_inc_return(atomic_t *v)
 {
+#if defined(arch_atomic_inc_return)
+	return arch_atomic_inc_return(v);
+#elif defined(arch_atomic_inc_return_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_inc_return_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_inc_return(atomic_t *v)
-{
 	return raw_atomic_add_return(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_return_acquire)
-#define raw_atomic_inc_return_acquire arch_atomic_inc_return_acquire
-#elif defined(arch_atomic_inc_return_relaxed)
 static __always_inline int
 raw_atomic_inc_return_acquire(atomic_t *v)
 {
+#if defined(arch_atomic_inc_return_acquire)
+	return arch_atomic_inc_return_acquire(v);
+#elif defined(arch_atomic_inc_return_relaxed)
 	int ret = arch_atomic_inc_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_inc_return)
-#define raw_atomic_inc_return_acquire arch_atomic_inc_return
+	return arch_atomic_inc_return(v);
 #else
-static __always_inline int
-raw_atomic_inc_return_acquire(atomic_t *v)
-{
 	return raw_atomic_add_return_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_return_release)
-#define raw_atomic_inc_return_release arch_atomic_inc_return_release
-#elif defined(arch_atomic_inc_return_relaxed)
 static __always_inline int
 raw_atomic_inc_return_release(atomic_t *v)
 {
+#if defined(arch_atomic_inc_return_release)
+	return arch_atomic_inc_return_release(v);
+#elif defined(arch_atomic_inc_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_inc_return_relaxed(v);
-}
 #elif defined(arch_atomic_inc_return)
-#define raw_atomic_inc_return_release arch_atomic_inc_return
+	return arch_atomic_inc_return(v);
 #else
-static __always_inline int
-raw_atomic_inc_return_release(atomic_t *v)
-{
 	return raw_atomic_add_return_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_return_relaxed)
-#define raw_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
-#elif defined(arch_atomic_inc_return)
-#define raw_atomic_inc_return_relaxed arch_atomic_inc_return
-#else
 static __always_inline int
 raw_atomic_inc_return_relaxed(atomic_t *v)
 {
+#if defined(arch_atomic_inc_return_relaxed)
+	return arch_atomic_inc_return_relaxed(v);
+#elif defined(arch_atomic_inc_return)
+	return arch_atomic_inc_return(v);
+#else
 	return raw_atomic_add_return_relaxed(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_inc)
-#define raw_atomic_fetch_inc arch_atomic_fetch_inc
-#elif defined(arch_atomic_fetch_inc_relaxed)
 static __always_inline int
 raw_atomic_fetch_inc(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_inc)
+	return arch_atomic_fetch_inc(v);
+#elif defined(arch_atomic_fetch_inc_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_inc_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_fetch_inc(atomic_t *v)
-{
 	return raw_atomic_fetch_add(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_inc_acquire)
-#define raw_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
-#elif defined(arch_atomic_fetch_inc_relaxed)
 static __always_inline int
 raw_atomic_fetch_inc_acquire(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_inc_acquire)
+	return arch_atomic_fetch_inc_acquire(v);
+#elif defined(arch_atomic_fetch_inc_relaxed)
 	int ret = arch_atomic_fetch_inc_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_inc)
-#define raw_atomic_fetch_inc_acquire arch_atomic_fetch_inc
+	return arch_atomic_fetch_inc(v);
 #else
-static __always_inline int
-raw_atomic_fetch_inc_acquire(atomic_t *v)
-{
 	return raw_atomic_fetch_add_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_inc_release)
-#define raw_atomic_fetch_inc_release arch_atomic_fetch_inc_release
-#elif defined(arch_atomic_fetch_inc_relaxed)
 static __always_inline int
 raw_atomic_fetch_inc_release(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_inc_release)
+	return arch_atomic_fetch_inc_release(v);
+#elif defined(arch_atomic_fetch_inc_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_inc_relaxed(v);
-}
 #elif defined(arch_atomic_fetch_inc)
-#define raw_atomic_fetch_inc_release arch_atomic_fetch_inc
+	return arch_atomic_fetch_inc(v);
 #else
-static __always_inline int
-raw_atomic_fetch_inc_release(atomic_t *v)
-{
 	return raw_atomic_fetch_add_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_inc_relaxed)
-#define raw_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
-#elif defined(arch_atomic_fetch_inc)
-#define raw_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
-#else
 static __always_inline int
 raw_atomic_fetch_inc_relaxed(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_inc_relaxed)
+	return arch_atomic_fetch_inc_relaxed(v);
+#elif defined(arch_atomic_fetch_inc)
+	return arch_atomic_fetch_inc(v);
+#else
 	return raw_atomic_fetch_add_relaxed(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_dec)
-#define raw_atomic_dec arch_atomic_dec
-#else
 static __always_inline void
 raw_atomic_dec(atomic_t *v)
 {
+#if defined(arch_atomic_dec)
+	arch_atomic_dec(v);
+#else
 	raw_atomic_sub(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_return)
-#define raw_atomic_dec_return arch_atomic_dec_return
-#elif defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
 raw_atomic_dec_return(atomic_t *v)
 {
+#if defined(arch_atomic_dec_return)
+	return arch_atomic_dec_return(v);
+#elif defined(arch_atomic_dec_return_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_dec_return_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_dec_return(atomic_t *v)
-{
 	return raw_atomic_sub_return(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_return_acquire)
-#define raw_atomic_dec_return_acquire arch_atomic_dec_return_acquire
-#elif defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
 raw_atomic_dec_return_acquire(atomic_t *v)
 {
+#if defined(arch_atomic_dec_return_acquire)
+	return arch_atomic_dec_return_acquire(v);
+#elif defined(arch_atomic_dec_return_relaxed)
 	int ret = arch_atomic_dec_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_dec_return)
-#define raw_atomic_dec_return_acquire arch_atomic_dec_return
+	return arch_atomic_dec_return(v);
 #else
-static __always_inline int
-raw_atomic_dec_return_acquire(atomic_t *v)
-{
 	return raw_atomic_sub_return_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_return_release)
-#define raw_atomic_dec_return_release arch_atomic_dec_return_release
-#elif defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
 raw_atomic_dec_return_release(atomic_t *v)
 {
+#if defined(arch_atomic_dec_return_release)
+	return arch_atomic_dec_return_release(v);
+#elif defined(arch_atomic_dec_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_dec_return_relaxed(v);
-}
 #elif defined(arch_atomic_dec_return)
-#define raw_atomic_dec_return_release arch_atomic_dec_return
+	return arch_atomic_dec_return(v);
 #else
-static __always_inline int
-raw_atomic_dec_return_release(atomic_t *v)
-{
 	return raw_atomic_sub_return_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_return_relaxed)
-#define raw_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
-#elif defined(arch_atomic_dec_return)
-#define raw_atomic_dec_return_relaxed arch_atomic_dec_return
-#else
 static __always_inline int
 raw_atomic_dec_return_relaxed(atomic_t *v)
 {
+#if defined(arch_atomic_dec_return_relaxed)
+	return arch_atomic_dec_return_relaxed(v);
+#elif defined(arch_atomic_dec_return)
+	return arch_atomic_dec_return(v);
+#else
 	return raw_atomic_sub_return_relaxed(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_dec)
-#define raw_atomic_fetch_dec arch_atomic_fetch_dec
-#elif defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
 raw_atomic_fetch_dec(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_dec)
+	return arch_atomic_fetch_dec(v);
+#elif defined(arch_atomic_fetch_dec_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_dec_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_fetch_dec(atomic_t *v)
-{
 	return raw_atomic_fetch_sub(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_dec_acquire)
-#define raw_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
-#elif defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
 raw_atomic_fetch_dec_acquire(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_dec_acquire)
+	return arch_atomic_fetch_dec_acquire(v);
+#elif defined(arch_atomic_fetch_dec_relaxed)
 	int ret = arch_atomic_fetch_dec_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_dec)
-#define raw_atomic_fetch_dec_acquire arch_atomic_fetch_dec
+	return arch_atomic_fetch_dec(v);
 #else
-static __always_inline int
-raw_atomic_fetch_dec_acquire(atomic_t *v)
-{
 	return raw_atomic_fetch_sub_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_dec_release)
-#define raw_atomic_fetch_dec_release arch_atomic_fetch_dec_release
-#elif defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
 raw_atomic_fetch_dec_release(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_dec_release)
+	return arch_atomic_fetch_dec_release(v);
+#elif defined(arch_atomic_fetch_dec_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_dec_relaxed(v);
-}
 #elif defined(arch_atomic_fetch_dec)
-#define raw_atomic_fetch_dec_release arch_atomic_fetch_dec
+	return arch_atomic_fetch_dec(v);
 #else
-static __always_inline int
-raw_atomic_fetch_dec_release(atomic_t *v)
-{
 	return raw_atomic_fetch_sub_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_dec_relaxed)
-#define raw_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
-#elif defined(arch_atomic_fetch_dec)
-#define raw_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
-#else
 static __always_inline int
 raw_atomic_fetch_dec_relaxed(atomic_t *v)
 {
+#if defined(arch_atomic_fetch_dec_relaxed)
+	return arch_atomic_fetch_dec_relaxed(v);
+#elif defined(arch_atomic_fetch_dec)
+	return arch_atomic_fetch_dec(v);
+#else
 	return raw_atomic_fetch_sub_relaxed(1, v);
-}
 #endif
+}
 
-#define raw_atomic_and arch_atomic_and
+static __always_inline void
+raw_atomic_and(int i, atomic_t *v)
+{
+	arch_atomic_and(i, v);
+}
 
-#if defined(arch_atomic_fetch_and)
-#define raw_atomic_fetch_and arch_atomic_fetch_and
-#elif defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
 raw_atomic_fetch_and(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_and)
+	return arch_atomic_fetch_and(i, v);
+#elif defined(arch_atomic_fetch_and_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_and_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_fetch_and"
 #endif
+}
 
-#if defined(arch_atomic_fetch_and_acquire)
-#define raw_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
-#elif defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
 raw_atomic_fetch_and_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_and_acquire)
+	return arch_atomic_fetch_and_acquire(i, v);
+#elif defined(arch_atomic_fetch_and_relaxed)
 	int ret = arch_atomic_fetch_and_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_and)
-#define raw_atomic_fetch_and_acquire arch_atomic_fetch_and
+	return arch_atomic_fetch_and(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_and_acquire"
 #endif
+}
 
-#if defined(arch_atomic_fetch_and_release)
-#define raw_atomic_fetch_and_release arch_atomic_fetch_and_release
-#elif defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
 raw_atomic_fetch_and_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_and_release)
+	return arch_atomic_fetch_and_release(i, v);
+#elif defined(arch_atomic_fetch_and_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_and_relaxed(i, v);
-}
 #elif defined(arch_atomic_fetch_and)
-#define raw_atomic_fetch_and_release arch_atomic_fetch_and
+	return arch_atomic_fetch_and(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_and_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_fetch_and_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_fetch_and_relaxed)
-#define raw_atomic_fetch_and_relaxed arch_atomic_fetch_and_relaxed
+	return arch_atomic_fetch_and_relaxed(i, v);
 #elif defined(arch_atomic_fetch_and)
-#define raw_atomic_fetch_and_relaxed arch_atomic_fetch_and
+	return arch_atomic_fetch_and(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_and_relaxed"
 #endif
+}
 
-#if defined(arch_atomic_andnot)
-#define raw_atomic_andnot arch_atomic_andnot
-#else
 static __always_inline void
 raw_atomic_andnot(int i, atomic_t *v)
 {
+#if defined(arch_atomic_andnot)
+	arch_atomic_andnot(i, v);
+#else
 	raw_atomic_and(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_andnot)
-#define raw_atomic_fetch_andnot arch_atomic_fetch_andnot
-#elif defined(arch_atomic_fetch_andnot_relaxed)
 static __always_inline int
 raw_atomic_fetch_andnot(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_andnot)
+	return arch_atomic_fetch_andnot(i, v);
+#elif defined(arch_atomic_fetch_andnot_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_andnot_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_fetch_andnot(int i, atomic_t *v)
-{
 	return raw_atomic_fetch_and(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_andnot_acquire)
-#define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
-#elif defined(arch_atomic_fetch_andnot_relaxed)
 static __always_inline int
 raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_andnot_acquire)
+	return arch_atomic_fetch_andnot_acquire(i, v);
+#elif defined(arch_atomic_fetch_andnot_relaxed)
 	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_andnot)
-#define raw_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
+	return arch_atomic_fetch_andnot(i, v);
 #else
-static __always_inline int
-raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
 	return raw_atomic_fetch_and_acquire(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_andnot_release)
-#define raw_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
-#elif defined(arch_atomic_fetch_andnot_relaxed)
 static __always_inline int
 raw_atomic_fetch_andnot_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_andnot_release)
+	return arch_atomic_fetch_andnot_release(i, v);
+#elif defined(arch_atomic_fetch_andnot_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_andnot_relaxed(i, v);
-}
 #elif defined(arch_atomic_fetch_andnot)
-#define raw_atomic_fetch_andnot_release arch_atomic_fetch_andnot
+	return arch_atomic_fetch_andnot(i, v);
 #else
-static __always_inline int
-raw_atomic_fetch_andnot_release(int i, atomic_t *v)
-{
 	return raw_atomic_fetch_and_release(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_andnot_relaxed)
-#define raw_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
-#elif defined(arch_atomic_fetch_andnot)
-#define raw_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
-#else
 static __always_inline int
 raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_andnot_relaxed)
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+#elif defined(arch_atomic_fetch_andnot)
+	return arch_atomic_fetch_andnot(i, v);
+#else
 	return raw_atomic_fetch_and_relaxed(~i, v);
-}
 #endif
+}
 
-#define raw_atomic_or arch_atomic_or
+static __always_inline void
+raw_atomic_or(int i, atomic_t *v)
+{
+	arch_atomic_or(i, v);
+}
 
-#if defined(arch_atomic_fetch_or)
-#define raw_atomic_fetch_or arch_atomic_fetch_or
-#elif defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
 raw_atomic_fetch_or(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_or)
+	return arch_atomic_fetch_or(i, v);
+#elif defined(arch_atomic_fetch_or_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_or_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_fetch_or"
 #endif
+}
 
-#if defined(arch_atomic_fetch_or_acquire)
-#define raw_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
-#elif defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
 raw_atomic_fetch_or_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_or_acquire)
+	return arch_atomic_fetch_or_acquire(i, v);
+#elif defined(arch_atomic_fetch_or_relaxed)
 	int ret = arch_atomic_fetch_or_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_or)
-#define raw_atomic_fetch_or_acquire arch_atomic_fetch_or
+	return arch_atomic_fetch_or(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_or_acquire"
 #endif
+}
 
-#if defined(arch_atomic_fetch_or_release)
-#define raw_atomic_fetch_or_release arch_atomic_fetch_or_release
-#elif defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
 raw_atomic_fetch_or_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_or_release)
+	return arch_atomic_fetch_or_release(i, v);
+#elif defined(arch_atomic_fetch_or_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_or_relaxed(i, v);
-}
 #elif defined(arch_atomic_fetch_or)
-#define raw_atomic_fetch_or_release arch_atomic_fetch_or
+	return arch_atomic_fetch_or(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_or_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_fetch_or_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_fetch_or_relaxed)
-#define raw_atomic_fetch_or_relaxed arch_atomic_fetch_or_relaxed
+	return arch_atomic_fetch_or_relaxed(i, v);
 #elif defined(arch_atomic_fetch_or)
-#define raw_atomic_fetch_or_relaxed arch_atomic_fetch_or
+	return arch_atomic_fetch_or(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_or_relaxed"
 #endif
+}
 
-#define raw_atomic_xor arch_atomic_xor
+static __always_inline void
+raw_atomic_xor(int i, atomic_t *v)
+{
+	arch_atomic_xor(i, v);
+}
 
-#if defined(arch_atomic_fetch_xor)
-#define raw_atomic_fetch_xor arch_atomic_fetch_xor
-#elif defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
 raw_atomic_fetch_xor(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_xor)
+	return arch_atomic_fetch_xor(i, v);
+#elif defined(arch_atomic_fetch_xor_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_fetch_xor_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic_fetch_xor"
 #endif
+}
 
-#if defined(arch_atomic_fetch_xor_acquire)
-#define raw_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
-#elif defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
 raw_atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_xor_acquire)
+	return arch_atomic_fetch_xor_acquire(i, v);
+#elif defined(arch_atomic_fetch_xor_relaxed)
 	int ret = arch_atomic_fetch_xor_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_fetch_xor)
-#define raw_atomic_fetch_xor_acquire arch_atomic_fetch_xor
+	return arch_atomic_fetch_xor(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_xor_acquire"
 #endif
+}
 
-#if defined(arch_atomic_fetch_xor_release)
-#define raw_atomic_fetch_xor_release arch_atomic_fetch_xor_release
-#elif defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
 raw_atomic_fetch_xor_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_fetch_xor_release)
+	return arch_atomic_fetch_xor_release(i, v);
+#elif defined(arch_atomic_fetch_xor_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_xor_relaxed(i, v);
-}
 #elif defined(arch_atomic_fetch_xor)
-#define raw_atomic_fetch_xor_release arch_atomic_fetch_xor
+	return arch_atomic_fetch_xor(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_xor_release"
 #endif
+}
 
+static __always_inline int
+raw_atomic_fetch_xor_relaxed(int i, atomic_t *v)
+{
 #if defined(arch_atomic_fetch_xor_relaxed)
-#define raw_atomic_fetch_xor_relaxed arch_atomic_fetch_xor_relaxed
+	return arch_atomic_fetch_xor_relaxed(i, v);
 #elif defined(arch_atomic_fetch_xor)
-#define raw_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
+	return arch_atomic_fetch_xor(i, v);
 #else
 #error "Unable to define raw_atomic_fetch_xor_relaxed"
 #endif
+}
 
-#if defined(arch_atomic_xchg)
-#define raw_atomic_xchg arch_atomic_xchg
-#elif defined(arch_atomic_xchg_relaxed)
 static __always_inline int
-raw_atomic_xchg(atomic_t *v, int i)
+raw_atomic_xchg(atomic_t *v, int new)
 {
+#if defined(arch_atomic_xchg)
+	return arch_atomic_xchg(v, new);
+#elif defined(arch_atomic_xchg_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic_xchg_relaxed(v, i);
+	ret = arch_atomic_xchg_relaxed(v, new);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_xchg(atomic_t *v, int new)
-{
 	return raw_xchg(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_xchg_acquire)
-#define raw_atomic_xchg_acquire arch_atomic_xchg_acquire
-#elif defined(arch_atomic_xchg_relaxed)
 static __always_inline int
-raw_atomic_xchg_acquire(atomic_t *v, int i)
+raw_atomic_xchg_acquire(atomic_t *v, int new)
 {
-	int ret = arch_atomic_xchg_relaxed(v, i);
+#if defined(arch_atomic_xchg_acquire)
+	return arch_atomic_xchg_acquire(v, new);
+#elif defined(arch_atomic_xchg_relaxed)
+	int ret = arch_atomic_xchg_relaxed(v, new);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_xchg)
-#define raw_atomic_xchg_acquire arch_atomic_xchg
+	return arch_atomic_xchg(v, new);
 #else
-static __always_inline int
-raw_atomic_xchg_acquire(atomic_t *v, int new)
-{
 	return raw_xchg_acquire(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_xchg_release)
-#define raw_atomic_xchg_release arch_atomic_xchg_release
-#elif defined(arch_atomic_xchg_relaxed)
 static __always_inline int
-raw_atomic_xchg_release(atomic_t *v, int i)
+raw_atomic_xchg_release(atomic_t *v, int new)
 {
+#if defined(arch_atomic_xchg_release)
+	return arch_atomic_xchg_release(v, new);
+#elif defined(arch_atomic_xchg_relaxed)
 	__atomic_release_fence();
-	return arch_atomic_xchg_relaxed(v, i);
-}
+	return arch_atomic_xchg_relaxed(v, new);
 #elif defined(arch_atomic_xchg)
-#define raw_atomic_xchg_release arch_atomic_xchg
+	return arch_atomic_xchg(v, new);
 #else
-static __always_inline int
-raw_atomic_xchg_release(atomic_t *v, int new)
-{
 	return raw_xchg_release(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_xchg_relaxed)
-#define raw_atomic_xchg_relaxed arch_atomic_xchg_relaxed
-#elif defined(arch_atomic_xchg)
-#define raw_atomic_xchg_relaxed arch_atomic_xchg
-#else
 static __always_inline int
 raw_atomic_xchg_relaxed(atomic_t *v, int new)
 {
+#if defined(arch_atomic_xchg_relaxed)
+	return arch_atomic_xchg_relaxed(v, new);
+#elif defined(arch_atomic_xchg)
+	return arch_atomic_xchg(v, new);
+#else
 	return raw_xchg_relaxed(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_cmpxchg)
-#define raw_atomic_cmpxchg arch_atomic_cmpxchg
-#elif defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
 raw_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
+#if defined(arch_atomic_cmpxchg)
+	return arch_atomic_cmpxchg(v, old, new);
+#elif defined(arch_atomic_cmpxchg_relaxed)
 	int ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline int
-raw_atomic_cmpxchg(atomic_t *v, int old, int new)
-{
 	return raw_cmpxchg(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_cmpxchg_acquire)
-#define raw_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
-#elif defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
 raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
+#if defined(arch_atomic_cmpxchg_acquire)
+	return arch_atomic_cmpxchg_acquire(v, old, new);
+#elif defined(arch_atomic_cmpxchg_relaxed)
 	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_cmpxchg)
-#define raw_atomic_cmpxchg_acquire arch_atomic_cmpxchg
+	return arch_atomic_cmpxchg(v, old, new);
 #else
-static __always_inline int
-raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
-{
 	return raw_cmpxchg_acquire(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_cmpxchg_release)
-#define raw_atomic_cmpxchg_release arch_atomic_cmpxchg_release
-#elif defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
 raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
+#if defined(arch_atomic_cmpxchg_release)
+	return arch_atomic_cmpxchg_release(v, old, new);
+#elif defined(arch_atomic_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
-}
 #elif defined(arch_atomic_cmpxchg)
-#define raw_atomic_cmpxchg_release arch_atomic_cmpxchg
+	return arch_atomic_cmpxchg(v, old, new);
 #else
-static __always_inline int
-raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
-{
 	return raw_cmpxchg_release(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_cmpxchg_relaxed)
-#define raw_atomic_cmpxchg_relaxed arch_atomic_cmpxchg_relaxed
-#elif defined(arch_atomic_cmpxchg)
-#define raw_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
-#else
 static __always_inline int
 raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
+#if defined(arch_atomic_cmpxchg_relaxed)
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+#elif defined(arch_atomic_cmpxchg)
+	return arch_atomic_cmpxchg(v, old, new);
+#else
 	return raw_cmpxchg_relaxed(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic_try_cmpxchg)
-#define raw_atomic_try_cmpxchg arch_atomic_try_cmpxchg
-#elif defined(arch_atomic_try_cmpxchg_relaxed)
 static __always_inline bool
 raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
+#if defined(arch_atomic_try_cmpxchg)
+	return arch_atomic_try_cmpxchg(v, old, new);
+#elif defined(arch_atomic_try_cmpxchg_relaxed)
 	bool ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline bool
-raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
 	int r, o = *old;
 	r = raw_atomic_cmpxchg(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic_try_cmpxchg_acquire)
-#define raw_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
-#elif defined(arch_atomic_try_cmpxchg_relaxed)
 static __always_inline bool
 raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
+#if defined(arch_atomic_try_cmpxchg_acquire)
+	return arch_atomic_try_cmpxchg_acquire(v, old, new);
+#elif defined(arch_atomic_try_cmpxchg_relaxed)
 	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_try_cmpxchg)
-#define raw_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
+	return arch_atomic_try_cmpxchg(v, old, new);
 #else
-static __always_inline bool
-raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
 	int r, o = *old;
 	r = raw_atomic_cmpxchg_acquire(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic_try_cmpxchg_release)
-#define raw_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
-#elif defined(arch_atomic_try_cmpxchg_relaxed)
 static __always_inline bool
 raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
+#if defined(arch_atomic_try_cmpxchg_release)
+	return arch_atomic_try_cmpxchg_release(v, old, new);
+#elif defined(arch_atomic_try_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-}
 #elif defined(arch_atomic_try_cmpxchg)
-#define raw_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
+	return arch_atomic_try_cmpxchg(v, old, new);
 #else
-static __always_inline bool
-raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
 	int r, o = *old;
 	r = raw_atomic_cmpxchg_release(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic_try_cmpxchg_relaxed)
-#define raw_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
-#elif defined(arch_atomic_try_cmpxchg)
-#define raw_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
-#else
 static __always_inline bool
 raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
+#if defined(arch_atomic_try_cmpxchg_relaxed)
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+#elif defined(arch_atomic_try_cmpxchg)
+	return arch_atomic_try_cmpxchg(v, old, new);
+#else
 	int r, o = *old;
 	r = raw_atomic_cmpxchg_relaxed(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic_sub_and_test)
-#define raw_atomic_sub_and_test arch_atomic_sub_and_test
-#else
 static __always_inline bool
 raw_atomic_sub_and_test(int i, atomic_t *v)
 {
+#if defined(arch_atomic_sub_and_test)
+	return arch_atomic_sub_and_test(i, v);
+#else
 	return raw_atomic_sub_return(i, v) == 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_and_test)
-#define raw_atomic_dec_and_test arch_atomic_dec_and_test
-#else
 static __always_inline bool
 raw_atomic_dec_and_test(atomic_t *v)
 {
+#if defined(arch_atomic_dec_and_test)
+	return arch_atomic_dec_and_test(v);
+#else
 	return raw_atomic_dec_return(v) == 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_and_test)
-#define raw_atomic_inc_and_test arch_atomic_inc_and_test
-#else
 static __always_inline bool
 raw_atomic_inc_and_test(atomic_t *v)
 {
+#if defined(arch_atomic_inc_and_test)
+	return arch_atomic_inc_and_test(v);
+#else
 	return raw_atomic_inc_return(v) == 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_add_negative)
-#define raw_atomic_add_negative arch_atomic_add_negative
-#elif defined(arch_atomic_add_negative_relaxed)
 static __always_inline bool
 raw_atomic_add_negative(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_negative)
+	return arch_atomic_add_negative(i, v);
+#elif defined(arch_atomic_add_negative_relaxed)
 	bool ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic_add_negative_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline bool
-raw_atomic_add_negative(int i, atomic_t *v)
-{
 	return raw_atomic_add_return(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_add_negative_acquire)
-#define raw_atomic_add_negative_acquire arch_atomic_add_negative_acquire
-#elif defined(arch_atomic_add_negative_relaxed)
 static __always_inline bool
 raw_atomic_add_negative_acquire(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_negative_acquire)
+	return arch_atomic_add_negative_acquire(i, v);
+#elif defined(arch_atomic_add_negative_relaxed)
 	bool ret = arch_atomic_add_negative_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic_add_negative)
-#define raw_atomic_add_negative_acquire arch_atomic_add_negative
+	return arch_atomic_add_negative(i, v);
 #else
-static __always_inline bool
-raw_atomic_add_negative_acquire(int i, atomic_t *v)
-{
 	return raw_atomic_add_return_acquire(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_add_negative_release)
-#define raw_atomic_add_negative_release arch_atomic_add_negative_release
-#elif defined(arch_atomic_add_negative_relaxed)
 static __always_inline bool
 raw_atomic_add_negative_release(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_negative_release)
+	return arch_atomic_add_negative_release(i, v);
+#elif defined(arch_atomic_add_negative_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_add_negative_relaxed(i, v);
-}
 #elif defined(arch_atomic_add_negative)
-#define raw_atomic_add_negative_release arch_atomic_add_negative
+	return arch_atomic_add_negative(i, v);
 #else
-static __always_inline bool
-raw_atomic_add_negative_release(int i, atomic_t *v)
-{
 	return raw_atomic_add_return_release(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_add_negative_relaxed)
-#define raw_atomic_add_negative_relaxed arch_atomic_add_negative_relaxed
-#elif defined(arch_atomic_add_negative)
-#define raw_atomic_add_negative_relaxed arch_atomic_add_negative
-#else
 static __always_inline bool
 raw_atomic_add_negative_relaxed(int i, atomic_t *v)
 {
+#if defined(arch_atomic_add_negative_relaxed)
+	return arch_atomic_add_negative_relaxed(i, v);
+#elif defined(arch_atomic_add_negative)
+	return arch_atomic_add_negative(i, v);
+#else
 	return raw_atomic_add_return_relaxed(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic_fetch_add_unless)
-#define raw_atomic_fetch_add_unless arch_atomic_fetch_add_unless
-#else
 static __always_inline int
 raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
+#if defined(arch_atomic_fetch_add_unless)
+	return arch_atomic_fetch_add_unless(v, a, u);
+#else
 	int c = raw_atomic_read(v);
 
 	do {
@@ -1594,35 +1542,35 @@ raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	} while (!raw_atomic_try_cmpxchg(v, &c, c + a));
 
 	return c;
-}
 #endif
+}
 
-#if defined(arch_atomic_add_unless)
-#define raw_atomic_add_unless arch_atomic_add_unless
-#else
 static __always_inline bool
 raw_atomic_add_unless(atomic_t *v, int a, int u)
 {
+#if defined(arch_atomic_add_unless)
+	return arch_atomic_add_unless(v, a, u);
+#else
 	return raw_atomic_fetch_add_unless(v, a, u) != u;
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_not_zero)
-#define raw_atomic_inc_not_zero arch_atomic_inc_not_zero
-#else
 static __always_inline bool
 raw_atomic_inc_not_zero(atomic_t *v)
 {
+#if defined(arch_atomic_inc_not_zero)
+	return arch_atomic_inc_not_zero(v);
+#else
 	return raw_atomic_add_unless(v, 1, 0);
-}
 #endif
+}
 
-#if defined(arch_atomic_inc_unless_negative)
-#define raw_atomic_inc_unless_negative arch_atomic_inc_unless_negative
-#else
 static __always_inline bool
 raw_atomic_inc_unless_negative(atomic_t *v)
 {
+#if defined(arch_atomic_inc_unless_negative)
+	return arch_atomic_inc_unless_negative(v);
+#else
 	int c = raw_atomic_read(v);
 
 	do {
@@ -1631,15 +1579,15 @@ raw_atomic_inc_unless_negative(atomic_t *v)
 	} while (!raw_atomic_try_cmpxchg(v, &c, c + 1));
 
 	return true;
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_unless_positive)
-#define raw_atomic_dec_unless_positive arch_atomic_dec_unless_positive
-#else
 static __always_inline bool
 raw_atomic_dec_unless_positive(atomic_t *v)
 {
+#if defined(arch_atomic_dec_unless_positive)
+	return arch_atomic_dec_unless_positive(v);
+#else
 	int c = raw_atomic_read(v);
 
 	do {
@@ -1648,15 +1596,15 @@ raw_atomic_dec_unless_positive(atomic_t *v)
 	} while (!raw_atomic_try_cmpxchg(v, &c, c - 1));
 
 	return true;
-}
 #endif
+}
 
-#if defined(arch_atomic_dec_if_positive)
-#define raw_atomic_dec_if_positive arch_atomic_dec_if_positive
-#else
 static __always_inline int
 raw_atomic_dec_if_positive(atomic_t *v)
 {
+#if defined(arch_atomic_dec_if_positive)
+	return arch_atomic_dec_if_positive(v);
+#else
 	int dec, c = raw_atomic_read(v);
 
 	do {
@@ -1666,23 +1614,27 @@ raw_atomic_dec_if_positive(atomic_t *v)
 	} while (!raw_atomic_try_cmpxchg(v, &c, dec));
 
 	return dec;
-}
 #endif
+}
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
 
-#define raw_atomic64_read arch_atomic64_read
+static __always_inline s64
+raw_atomic64_read(const atomic64_t *v)
+{
+	return arch_atomic64_read(v);
+}
 
-#if defined(arch_atomic64_read_acquire)
-#define raw_atomic64_read_acquire arch_atomic64_read_acquire
-#elif defined(arch_atomic64_read)
-#define raw_atomic64_read_acquire arch_atomic64_read
-#else
 static __always_inline s64
 raw_atomic64_read_acquire(const atomic64_t *v)
 {
+#if defined(arch_atomic64_read_acquire)
+	return arch_atomic64_read_acquire(v);
+#elif defined(arch_atomic64_read)
+	return arch_atomic64_read(v);
+#else
 	s64 ret;
 
 	if (__native_word(atomic64_t)) {
@@ -1693,1144 +1645,1088 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 	}
 
 	return ret;
-}
 #endif
+}
 
-#define raw_atomic64_set arch_atomic64_set
+static __always_inline void
+raw_atomic64_set(atomic64_t *v, s64 i)
+{
+	arch_atomic64_set(v, i);
+}
 
-#if defined(arch_atomic64_set_release)
-#define raw_atomic64_set_release arch_atomic64_set_release
-#elif defined(arch_atomic64_set)
-#define raw_atomic64_set_release arch_atomic64_set
-#else
 static __always_inline void
 raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
+#if defined(arch_atomic64_set_release)
+	arch_atomic64_set_release(v, i);
+#elif defined(arch_atomic64_set)
+	arch_atomic64_set(v, i);
+#else
 	if (__native_word(atomic64_t)) {
 		smp_store_release(&(v)->counter, i);
 	} else {
 		__atomic_release_fence();
 		raw_atomic64_set(v, i);
 	}
-}
 #endif
+}
 
-#define raw_atomic64_add arch_atomic64_add
+static __always_inline void
+raw_atomic64_add(s64 i, atomic64_t *v)
+{
+	arch_atomic64_add(i, v);
+}
 
-#if defined(arch_atomic64_add_return)
-#define raw_atomic64_add_return arch_atomic64_add_return
-#elif defined(arch_atomic64_add_return_relaxed)
 static __always_inline s64
 raw_atomic64_add_return(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_return)
+	return arch_atomic64_add_return(i, v);
+#elif defined(arch_atomic64_add_return_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_add_return_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_add_return"
 #endif
+}
 
-#if defined(arch_atomic64_add_return_acquire)
-#define raw_atomic64_add_return_acquire arch_atomic64_add_return_acquire
-#elif defined(arch_atomic64_add_return_relaxed)
 static __always_inline s64
 raw_atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_return_acquire)
+	return arch_atomic64_add_return_acquire(i, v);
+#elif defined(arch_atomic64_add_return_relaxed)
 	s64 ret = arch_atomic64_add_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_add_return)
-#define raw_atomic64_add_return_acquire arch_atomic64_add_return
+	return arch_atomic64_add_return(i, v);
 #else
 #error "Unable to define raw_atomic64_add_return_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_add_return_release)
-#define raw_atomic64_add_return_release arch_atomic64_add_return_release
-#elif defined(arch_atomic64_add_return_relaxed)
 static __always_inline s64
 raw_atomic64_add_return_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_return_release)
+	return arch_atomic64_add_return_release(i, v);
+#elif defined(arch_atomic64_add_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_add_return_relaxed(i, v);
-}
 #elif defined(arch_atomic64_add_return)
-#define raw_atomic64_add_return_release arch_atomic64_add_return
+	return arch_atomic64_add_return(i, v);
 #else
 #error "Unable to define raw_atomic64_add_return_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_add_return_relaxed)
-#define raw_atomic64_add_return_relaxed arch_atomic64_add_return_relaxed
+	return arch_atomic64_add_return_relaxed(i, v);
 #elif defined(arch_atomic64_add_return)
-#define raw_atomic64_add_return_relaxed arch_atomic64_add_return
+	return arch_atomic64_add_return(i, v);
 #else
 #error "Unable to define raw_atomic64_add_return_relaxed"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_add)
-#define raw_atomic64_fetch_add arch_atomic64_fetch_add
-#elif defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_add)
+	return arch_atomic64_fetch_add(i, v);
+#elif defined(arch_atomic64_fetch_add_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_add_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_fetch_add"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_add_acquire)
-#define raw_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
-#elif defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_add_acquire)
+	return arch_atomic64_fetch_add_acquire(i, v);
+#elif defined(arch_atomic64_fetch_add_relaxed)
 	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_add)
-#define raw_atomic64_fetch_add_acquire arch_atomic64_fetch_add
+	return arch_atomic64_fetch_add(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_add_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_add_release)
-#define raw_atomic64_fetch_add_release arch_atomic64_fetch_add_release
-#elif defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_add_release)
+	return arch_atomic64_fetch_add_release(i, v);
+#elif defined(arch_atomic64_fetch_add_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_add_relaxed(i, v);
-}
 #elif defined(arch_atomic64_fetch_add)
-#define raw_atomic64_fetch_add_release arch_atomic64_fetch_add
+	return arch_atomic64_fetch_add(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_add_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_fetch_add_relaxed)
-#define raw_atomic64_fetch_add_relaxed arch_atomic64_fetch_add_relaxed
+	return arch_atomic64_fetch_add_relaxed(i, v);
 #elif defined(arch_atomic64_fetch_add)
-#define raw_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
+	return arch_atomic64_fetch_add(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_add_relaxed"
 #endif
+}
 
-#define raw_atomic64_sub arch_atomic64_sub
+static __always_inline void
+raw_atomic64_sub(s64 i, atomic64_t *v)
+{
+	arch_atomic64_sub(i, v);
+}
 
-#if defined(arch_atomic64_sub_return)
-#define raw_atomic64_sub_return arch_atomic64_sub_return
-#elif defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
 raw_atomic64_sub_return(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_sub_return)
+	return arch_atomic64_sub_return(i, v);
+#elif defined(arch_atomic64_sub_return_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_sub_return_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_sub_return"
 #endif
+}
 
-#if defined(arch_atomic64_sub_return_acquire)
-#define raw_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
-#elif defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
 raw_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_sub_return_acquire)
+	return arch_atomic64_sub_return_acquire(i, v);
+#elif defined(arch_atomic64_sub_return_relaxed)
 	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_sub_return)
-#define raw_atomic64_sub_return_acquire arch_atomic64_sub_return
+	return arch_atomic64_sub_return(i, v);
 #else
 #error "Unable to define raw_atomic64_sub_return_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_sub_return_release)
-#define raw_atomic64_sub_return_release arch_atomic64_sub_return_release
-#elif defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
 raw_atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_sub_return_release)
+	return arch_atomic64_sub_return_release(i, v);
+#elif defined(arch_atomic64_sub_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_sub_return_relaxed(i, v);
-}
 #elif defined(arch_atomic64_sub_return)
-#define raw_atomic64_sub_return_release arch_atomic64_sub_return
+	return arch_atomic64_sub_return(i, v);
 #else
 #error "Unable to define raw_atomic64_sub_return_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_sub_return_relaxed)
-#define raw_atomic64_sub_return_relaxed arch_atomic64_sub_return_relaxed
+	return arch_atomic64_sub_return_relaxed(i, v);
 #elif defined(arch_atomic64_sub_return)
-#define raw_atomic64_sub_return_relaxed arch_atomic64_sub_return
+	return arch_atomic64_sub_return(i, v);
 #else
 #error "Unable to define raw_atomic64_sub_return_relaxed"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_sub)
-#define raw_atomic64_fetch_sub arch_atomic64_fetch_sub
-#elif defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_sub)
+	return arch_atomic64_fetch_sub(i, v);
+#elif defined(arch_atomic64_fetch_sub_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_sub_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_fetch_sub"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_sub_acquire)
-#define raw_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
-#elif defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_sub_acquire)
+	return arch_atomic64_fetch_sub_acquire(i, v);
+#elif defined(arch_atomic64_fetch_sub_relaxed)
 	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_sub)
-#define raw_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
+	return arch_atomic64_fetch_sub(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_sub_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_sub_release)
-#define raw_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
-#elif defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_sub_release)
+	return arch_atomic64_fetch_sub_release(i, v);
+#elif defined(arch_atomic64_fetch_sub_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_sub_relaxed(i, v);
-}
 #elif defined(arch_atomic64_fetch_sub)
-#define raw_atomic64_fetch_sub_release arch_atomic64_fetch_sub
+	return arch_atomic64_fetch_sub(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_sub_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_fetch_sub_relaxed)
-#define raw_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub_relaxed
+	return arch_atomic64_fetch_sub_relaxed(i, v);
 #elif defined(arch_atomic64_fetch_sub)
-#define raw_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
+	return arch_atomic64_fetch_sub(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_sub_relaxed"
 #endif
+}
 
-#if defined(arch_atomic64_inc)
-#define raw_atomic64_inc arch_atomic64_inc
-#else
 static __always_inline void
 raw_atomic64_inc(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc)
+	arch_atomic64_inc(v);
+#else
 	raw_atomic64_add(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_return)
-#define raw_atomic64_inc_return arch_atomic64_inc_return
-#elif defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
 raw_atomic64_inc_return(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_return)
+	return arch_atomic64_inc_return(v);
+#elif defined(arch_atomic64_inc_return_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_inc_return_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_inc_return(atomic64_t *v)
-{
 	return raw_atomic64_add_return(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_return_acquire)
-#define raw_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
-#elif defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
 raw_atomic64_inc_return_acquire(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_return_acquire)
+	return arch_atomic64_inc_return_acquire(v);
+#elif defined(arch_atomic64_inc_return_relaxed)
 	s64 ret = arch_atomic64_inc_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_inc_return)
-#define raw_atomic64_inc_return_acquire arch_atomic64_inc_return
+	return arch_atomic64_inc_return(v);
 #else
-static __always_inline s64
-raw_atomic64_inc_return_acquire(atomic64_t *v)
-{
 	return raw_atomic64_add_return_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_return_release)
-#define raw_atomic64_inc_return_release arch_atomic64_inc_return_release
-#elif defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
 raw_atomic64_inc_return_release(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_return_release)
+	return arch_atomic64_inc_return_release(v);
+#elif defined(arch_atomic64_inc_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_inc_return_relaxed(v);
-}
 #elif defined(arch_atomic64_inc_return)
-#define raw_atomic64_inc_return_release arch_atomic64_inc_return
+	return arch_atomic64_inc_return(v);
 #else
-static __always_inline s64
-raw_atomic64_inc_return_release(atomic64_t *v)
-{
 	return raw_atomic64_add_return_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_return_relaxed)
-#define raw_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
-#elif defined(arch_atomic64_inc_return)
-#define raw_atomic64_inc_return_relaxed arch_atomic64_inc_return
-#else
 static __always_inline s64
 raw_atomic64_inc_return_relaxed(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_return_relaxed)
+	return arch_atomic64_inc_return_relaxed(v);
+#elif defined(arch_atomic64_inc_return)
+	return arch_atomic64_inc_return(v);
+#else
 	return raw_atomic64_add_return_relaxed(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_inc)
-#define raw_atomic64_fetch_inc arch_atomic64_fetch_inc
-#elif defined(arch_atomic64_fetch_inc_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_inc(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_inc)
+	return arch_atomic64_fetch_inc(v);
+#elif defined(arch_atomic64_fetch_inc_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_inc_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_fetch_inc(atomic64_t *v)
-{
 	return raw_atomic64_fetch_add(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_inc_acquire)
-#define raw_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
-#elif defined(arch_atomic64_fetch_inc_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_inc_acquire(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_inc_acquire)
+	return arch_atomic64_fetch_inc_acquire(v);
+#elif defined(arch_atomic64_fetch_inc_relaxed)
 	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_inc)
-#define raw_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
+	return arch_atomic64_fetch_inc(v);
 #else
-static __always_inline s64
-raw_atomic64_fetch_inc_acquire(atomic64_t *v)
-{
 	return raw_atomic64_fetch_add_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_inc_release)
-#define raw_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
-#elif defined(arch_atomic64_fetch_inc_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_inc_release(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_inc_release)
+	return arch_atomic64_fetch_inc_release(v);
+#elif defined(arch_atomic64_fetch_inc_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_inc_relaxed(v);
-}
 #elif defined(arch_atomic64_fetch_inc)
-#define raw_atomic64_fetch_inc_release arch_atomic64_fetch_inc
+	return arch_atomic64_fetch_inc(v);
 #else
-static __always_inline s64
-raw_atomic64_fetch_inc_release(atomic64_t *v)
-{
 	return raw_atomic64_fetch_add_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_inc_relaxed)
-#define raw_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
-#elif defined(arch_atomic64_fetch_inc)
-#define raw_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
-#else
 static __always_inline s64
 raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_inc_relaxed)
+	return arch_atomic64_fetch_inc_relaxed(v);
+#elif defined(arch_atomic64_fetch_inc)
+	return arch_atomic64_fetch_inc(v);
+#else
 	return raw_atomic64_fetch_add_relaxed(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec)
-#define raw_atomic64_dec arch_atomic64_dec
-#else
 static __always_inline void
 raw_atomic64_dec(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec)
+	arch_atomic64_dec(v);
+#else
 	raw_atomic64_sub(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_return)
-#define raw_atomic64_dec_return arch_atomic64_dec_return
-#elif defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
 raw_atomic64_dec_return(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_return)
+	return arch_atomic64_dec_return(v);
+#elif defined(arch_atomic64_dec_return_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_dec_return_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_dec_return(atomic64_t *v)
-{
 	return raw_atomic64_sub_return(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_return_acquire)
-#define raw_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
-#elif defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
 raw_atomic64_dec_return_acquire(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_return_acquire)
+	return arch_atomic64_dec_return_acquire(v);
+#elif defined(arch_atomic64_dec_return_relaxed)
 	s64 ret = arch_atomic64_dec_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_dec_return)
-#define raw_atomic64_dec_return_acquire arch_atomic64_dec_return
+	return arch_atomic64_dec_return(v);
 #else
-static __always_inline s64
-raw_atomic64_dec_return_acquire(atomic64_t *v)
-{
 	return raw_atomic64_sub_return_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_return_release)
-#define raw_atomic64_dec_return_release arch_atomic64_dec_return_release
-#elif defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
 raw_atomic64_dec_return_release(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_return_release)
+	return arch_atomic64_dec_return_release(v);
+#elif defined(arch_atomic64_dec_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_dec_return_relaxed(v);
-}
 #elif defined(arch_atomic64_dec_return)
-#define raw_atomic64_dec_return_release arch_atomic64_dec_return
+	return arch_atomic64_dec_return(v);
 #else
-static __always_inline s64
-raw_atomic64_dec_return_release(atomic64_t *v)
-{
 	return raw_atomic64_sub_return_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_return_relaxed)
-#define raw_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
-#elif defined(arch_atomic64_dec_return)
-#define raw_atomic64_dec_return_relaxed arch_atomic64_dec_return
-#else
 static __always_inline s64
 raw_atomic64_dec_return_relaxed(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_return_relaxed)
+	return arch_atomic64_dec_return_relaxed(v);
+#elif defined(arch_atomic64_dec_return)
+	return arch_atomic64_dec_return(v);
+#else
 	return raw_atomic64_sub_return_relaxed(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_dec)
-#define raw_atomic64_fetch_dec arch_atomic64_fetch_dec
-#elif defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_dec(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_dec)
+	return arch_atomic64_fetch_dec(v);
+#elif defined(arch_atomic64_fetch_dec_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_dec_relaxed(v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_fetch_dec(atomic64_t *v)
-{
 	return raw_atomic64_fetch_sub(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_dec_acquire)
-#define raw_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
-#elif defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_dec_acquire(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_dec_acquire)
+	return arch_atomic64_fetch_dec_acquire(v);
+#elif defined(arch_atomic64_fetch_dec_relaxed)
 	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_dec)
-#define raw_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
+	return arch_atomic64_fetch_dec(v);
 #else
-static __always_inline s64
-raw_atomic64_fetch_dec_acquire(atomic64_t *v)
-{
 	return raw_atomic64_fetch_sub_acquire(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_dec_release)
-#define raw_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
-#elif defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_dec_release(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_dec_release)
+	return arch_atomic64_fetch_dec_release(v);
+#elif defined(arch_atomic64_fetch_dec_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_dec_relaxed(v);
-}
 #elif defined(arch_atomic64_fetch_dec)
-#define raw_atomic64_fetch_dec_release arch_atomic64_fetch_dec
+	return arch_atomic64_fetch_dec(v);
 #else
-static __always_inline s64
-raw_atomic64_fetch_dec_release(atomic64_t *v)
-{
 	return raw_atomic64_fetch_sub_release(1, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_dec_relaxed)
-#define raw_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
-#elif defined(arch_atomic64_fetch_dec)
-#define raw_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
-#else
 static __always_inline s64
 raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_dec_relaxed)
+	return arch_atomic64_fetch_dec_relaxed(v);
+#elif defined(arch_atomic64_fetch_dec)
+	return arch_atomic64_fetch_dec(v);
+#else
 	return raw_atomic64_fetch_sub_relaxed(1, v);
-}
 #endif
+}
 
-#define raw_atomic64_and arch_atomic64_and
+static __always_inline void
+raw_atomic64_and(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(i, v);
+}
 
-#if defined(arch_atomic64_fetch_and)
-#define raw_atomic64_fetch_and arch_atomic64_fetch_and
-#elif defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_and)
+	return arch_atomic64_fetch_and(i, v);
+#elif defined(arch_atomic64_fetch_and_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_and_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_fetch_and"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_and_acquire)
-#define raw_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
-#elif defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_and_acquire)
+	return arch_atomic64_fetch_and_acquire(i, v);
+#elif defined(arch_atomic64_fetch_and_relaxed)
 	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_and)
-#define raw_atomic64_fetch_and_acquire arch_atomic64_fetch_and
+	return arch_atomic64_fetch_and(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_and_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_and_release)
-#define raw_atomic64_fetch_and_release arch_atomic64_fetch_and_release
-#elif defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_and_release)
+	return arch_atomic64_fetch_and_release(i, v);
+#elif defined(arch_atomic64_fetch_and_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_and_relaxed(i, v);
-}
 #elif defined(arch_atomic64_fetch_and)
-#define raw_atomic64_fetch_and_release arch_atomic64_fetch_and
+	return arch_atomic64_fetch_and(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_and_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_fetch_and_relaxed)
-#define raw_atomic64_fetch_and_relaxed arch_atomic64_fetch_and_relaxed
+	return arch_atomic64_fetch_and_relaxed(i, v);
 #elif defined(arch_atomic64_fetch_and)
-#define raw_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
+	return arch_atomic64_fetch_and(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_and_relaxed"
 #endif
+}
 
-#if defined(arch_atomic64_andnot)
-#define raw_atomic64_andnot arch_atomic64_andnot
-#else
 static __always_inline void
 raw_atomic64_andnot(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_andnot)
+	arch_atomic64_andnot(i, v);
+#else
 	raw_atomic64_and(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_andnot)
-#define raw_atomic64_fetch_andnot arch_atomic64_fetch_andnot
-#elif defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_andnot)
+	return arch_atomic64_fetch_andnot(i, v);
+#elif defined(arch_atomic64_fetch_andnot_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
 	return raw_atomic64_fetch_and(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_andnot_acquire)
-#define raw_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
-#elif defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_andnot_acquire)
+	return arch_atomic64_fetch_andnot_acquire(i, v);
+#elif defined(arch_atomic64_fetch_andnot_relaxed)
 	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_andnot)
-#define raw_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
+	return arch_atomic64_fetch_andnot(i, v);
 #else
-static __always_inline s64
-raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
 	return raw_atomic64_fetch_and_acquire(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_andnot_release)
-#define raw_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
-#elif defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_andnot_release)
+	return arch_atomic64_fetch_andnot_release(i, v);
+#elif defined(arch_atomic64_fetch_andnot_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
-}
 #elif defined(arch_atomic64_fetch_andnot)
-#define raw_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
+	return arch_atomic64_fetch_andnot(i, v);
 #else
-static __always_inline s64
-raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
 	return raw_atomic64_fetch_and_release(~i, v);
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_andnot_relaxed)
-#define raw_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
-#elif defined(arch_atomic64_fetch_andnot)
-#define raw_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
-#else
 static __always_inline s64
 raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_andnot_relaxed)
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+#elif defined(arch_atomic64_fetch_andnot)
+	return arch_atomic64_fetch_andnot(i, v);
+#else
 	return raw_atomic64_fetch_and_relaxed(~i, v);
-}
 #endif
+}
 
-#define raw_atomic64_or arch_atomic64_or
+static __always_inline void
+raw_atomic64_or(s64 i, atomic64_t *v)
+{
+	arch_atomic64_or(i, v);
+}
 
-#if defined(arch_atomic64_fetch_or)
-#define raw_atomic64_fetch_or arch_atomic64_fetch_or
-#elif defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_or)
+	return arch_atomic64_fetch_or(i, v);
+#elif defined(arch_atomic64_fetch_or_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_or_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_fetch_or"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_or_acquire)
-#define raw_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
-#elif defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_or_acquire)
+	return arch_atomic64_fetch_or_acquire(i, v);
+#elif defined(arch_atomic64_fetch_or_relaxed)
 	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_or)
-#define raw_atomic64_fetch_or_acquire arch_atomic64_fetch_or
+	return arch_atomic64_fetch_or(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_or_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_or_release)
-#define raw_atomic64_fetch_or_release arch_atomic64_fetch_or_release
-#elif defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_or_release)
+	return arch_atomic64_fetch_or_release(i, v);
+#elif defined(arch_atomic64_fetch_or_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_or_relaxed(i, v);
-}
 #elif defined(arch_atomic64_fetch_or)
-#define raw_atomic64_fetch_or_release arch_atomic64_fetch_or
+	return arch_atomic64_fetch_or(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_or_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_fetch_or_relaxed)
-#define raw_atomic64_fetch_or_relaxed arch_atomic64_fetch_or_relaxed
+	return arch_atomic64_fetch_or_relaxed(i, v);
 #elif defined(arch_atomic64_fetch_or)
-#define raw_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
+	return arch_atomic64_fetch_or(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_or_relaxed"
 #endif
+}
 
-#define raw_atomic64_xor arch_atomic64_xor
+static __always_inline void
+raw_atomic64_xor(s64 i, atomic64_t *v)
+{
+	arch_atomic64_xor(i, v);
+}
 
-#if defined(arch_atomic64_fetch_xor)
-#define raw_atomic64_fetch_xor arch_atomic64_fetch_xor
-#elif defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_xor)
+	return arch_atomic64_fetch_xor(i, v);
+#elif defined(arch_atomic64_fetch_xor_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_fetch_xor_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
 #error "Unable to define raw_atomic64_fetch_xor"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_xor_acquire)
-#define raw_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
-#elif defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_xor_acquire)
+	return arch_atomic64_fetch_xor_acquire(i, v);
+#elif defined(arch_atomic64_fetch_xor_relaxed)
 	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_fetch_xor)
-#define raw_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
+	return arch_atomic64_fetch_xor(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_xor_acquire"
 #endif
+}
 
-#if defined(arch_atomic64_fetch_xor_release)
-#define raw_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
-#elif defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
 raw_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_fetch_xor_release)
+	return arch_atomic64_fetch_xor_release(i, v);
+#elif defined(arch_atomic64_fetch_xor_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_xor_relaxed(i, v);
-}
 #elif defined(arch_atomic64_fetch_xor)
-#define raw_atomic64_fetch_xor_release arch_atomic64_fetch_xor
+	return arch_atomic64_fetch_xor(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_xor_release"
 #endif
+}
 
+static __always_inline s64
+raw_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
+{
 #if defined(arch_atomic64_fetch_xor_relaxed)
-#define raw_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor_relaxed
+	return arch_atomic64_fetch_xor_relaxed(i, v);
 #elif defined(arch_atomic64_fetch_xor)
-#define raw_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
+	return arch_atomic64_fetch_xor(i, v);
 #else
 #error "Unable to define raw_atomic64_fetch_xor_relaxed"
 #endif
+}
 
-#if defined(arch_atomic64_xchg)
-#define raw_atomic64_xchg arch_atomic64_xchg
-#elif defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
-raw_atomic64_xchg(atomic64_t *v, s64 i)
+raw_atomic64_xchg(atomic64_t *v, s64 new)
 {
+#if defined(arch_atomic64_xchg)
+	return arch_atomic64_xchg(v, new);
+#elif defined(arch_atomic64_xchg_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
-	ret = arch_atomic64_xchg_relaxed(v, i);
+	ret = arch_atomic64_xchg_relaxed(v, new);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_xchg(atomic64_t *v, s64 new)
-{
 	return raw_xchg(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_xchg_acquire)
-#define raw_atomic64_xchg_acquire arch_atomic64_xchg_acquire
-#elif defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
-raw_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
 {
-	s64 ret = arch_atomic64_xchg_relaxed(v, i);
+#if defined(arch_atomic64_xchg_acquire)
+	return arch_atomic64_xchg_acquire(v, new);
+#elif defined(arch_atomic64_xchg_relaxed)
+	s64 ret = arch_atomic64_xchg_relaxed(v, new);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_xchg)
-#define raw_atomic64_xchg_acquire arch_atomic64_xchg
+	return arch_atomic64_xchg(v, new);
 #else
-static __always_inline s64
-raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
-{
 	return raw_xchg_acquire(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_xchg_release)
-#define raw_atomic64_xchg_release arch_atomic64_xchg_release
-#elif defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
-raw_atomic64_xchg_release(atomic64_t *v, s64 i)
+raw_atomic64_xchg_release(atomic64_t *v, s64 new)
 {
+#if defined(arch_atomic64_xchg_release)
+	return arch_atomic64_xchg_release(v, new);
+#elif defined(arch_atomic64_xchg_relaxed)
 	__atomic_release_fence();
-	return arch_atomic64_xchg_relaxed(v, i);
-}
+	return arch_atomic64_xchg_relaxed(v, new);
 #elif defined(arch_atomic64_xchg)
-#define raw_atomic64_xchg_release arch_atomic64_xchg
+	return arch_atomic64_xchg(v, new);
 #else
-static __always_inline s64
-raw_atomic64_xchg_release(atomic64_t *v, s64 new)
-{
 	return raw_xchg_release(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_xchg_relaxed)
-#define raw_atomic64_xchg_relaxed arch_atomic64_xchg_relaxed
-#elif defined(arch_atomic64_xchg)
-#define raw_atomic64_xchg_relaxed arch_atomic64_xchg
-#else
 static __always_inline s64
 raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 {
+#if defined(arch_atomic64_xchg_relaxed)
+	return arch_atomic64_xchg_relaxed(v, new);
+#elif defined(arch_atomic64_xchg)
+	return arch_atomic64_xchg(v, new);
+#else
 	return raw_xchg_relaxed(&v->counter, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_cmpxchg)
-#define raw_atomic64_cmpxchg arch_atomic64_cmpxchg
-#elif defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
 raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
+#if defined(arch_atomic64_cmpxchg)
+	return arch_atomic64_cmpxchg(v, old, new);
+#elif defined(arch_atomic64_cmpxchg_relaxed)
 	s64 ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline s64
-raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
-{
 	return raw_cmpxchg(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_cmpxchg_acquire)
-#define raw_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
-#elif defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
 raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
+#if defined(arch_atomic64_cmpxchg_acquire)
+	return arch_atomic64_cmpxchg_acquire(v, old, new);
+#elif defined(arch_atomic64_cmpxchg_relaxed)
 	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_cmpxchg)
-#define raw_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
+	return arch_atomic64_cmpxchg(v, old, new);
 #else
-static __always_inline s64
-raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
-{
 	return raw_cmpxchg_acquire(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_cmpxchg_release)
-#define raw_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
-#elif defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
 raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
+#if defined(arch_atomic64_cmpxchg_release)
+	return arch_atomic64_cmpxchg_release(v, old, new);
+#elif defined(arch_atomic64_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
-}
 #elif defined(arch_atomic64_cmpxchg)
-#define raw_atomic64_cmpxchg_release arch_atomic64_cmpxchg
+	return arch_atomic64_cmpxchg(v, old, new);
 #else
-static __always_inline s64
-raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
-{
 	return raw_cmpxchg_release(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_cmpxchg_relaxed)
-#define raw_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg_relaxed
-#elif defined(arch_atomic64_cmpxchg)
-#define raw_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
-#else
 static __always_inline s64
 raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
+#if defined(arch_atomic64_cmpxchg_relaxed)
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+#elif defined(arch_atomic64_cmpxchg)
+	return arch_atomic64_cmpxchg(v, old, new);
+#else
 	return raw_cmpxchg_relaxed(&v->counter, old, new);
-}
 #endif
+}
 
-#if defined(arch_atomic64_try_cmpxchg)
-#define raw_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
-#elif defined(arch_atomic64_try_cmpxchg_relaxed)
 static __always_inline bool
 raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
+#if defined(arch_atomic64_try_cmpxchg)
+	return arch_atomic64_try_cmpxchg(v, old, new);
+#elif defined(arch_atomic64_try_cmpxchg_relaxed)
 	bool ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline bool
-raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic64_try_cmpxchg_acquire)
-#define raw_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
-#elif defined(arch_atomic64_try_cmpxchg_relaxed)
 static __always_inline bool
 raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
+#if defined(arch_atomic64_try_cmpxchg_acquire)
+	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
+#elif defined(arch_atomic64_try_cmpxchg_relaxed)
 	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_try_cmpxchg)
-#define raw_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
+	return arch_atomic64_try_cmpxchg(v, old, new);
 #else
-static __always_inline bool
-raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg_acquire(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic64_try_cmpxchg_release)
-#define raw_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
-#elif defined(arch_atomic64_try_cmpxchg_relaxed)
 static __always_inline bool
 raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
+#if defined(arch_atomic64_try_cmpxchg_release)
+	return arch_atomic64_try_cmpxchg_release(v, old, new);
+#elif defined(arch_atomic64_try_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-}
 #elif defined(arch_atomic64_try_cmpxchg)
-#define raw_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
+	return arch_atomic64_try_cmpxchg(v, old, new);
 #else
-static __always_inline bool
-raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg_release(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic64_try_cmpxchg_relaxed)
-#define raw_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
-#elif defined(arch_atomic64_try_cmpxchg)
-#define raw_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
-#else
 static __always_inline bool
 raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
+#if defined(arch_atomic64_try_cmpxchg_relaxed)
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+#elif defined(arch_atomic64_try_cmpxchg)
+	return arch_atomic64_try_cmpxchg(v, old, new);
+#else
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg_relaxed(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 #endif
+}
 
-#if defined(arch_atomic64_sub_and_test)
-#define raw_atomic64_sub_and_test arch_atomic64_sub_and_test
-#else
 static __always_inline bool
 raw_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_sub_and_test)
+	return arch_atomic64_sub_and_test(i, v);
+#else
 	return raw_atomic64_sub_return(i, v) == 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_and_test)
-#define raw_atomic64_dec_and_test arch_atomic64_dec_and_test
-#else
 static __always_inline bool
 raw_atomic64_dec_and_test(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_and_test)
+	return arch_atomic64_dec_and_test(v);
+#else
 	return raw_atomic64_dec_return(v) == 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_and_test)
-#define raw_atomic64_inc_and_test arch_atomic64_inc_and_test
-#else
 static __always_inline bool
 raw_atomic64_inc_and_test(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_and_test)
+	return arch_atomic64_inc_and_test(v);
+#else
 	return raw_atomic64_inc_return(v) == 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_add_negative)
-#define raw_atomic64_add_negative arch_atomic64_add_negative
-#elif defined(arch_atomic64_add_negative_relaxed)
 static __always_inline bool
 raw_atomic64_add_negative(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_negative)
+	return arch_atomic64_add_negative(i, v);
+#elif defined(arch_atomic64_add_negative_relaxed)
 	bool ret;
 	__atomic_pre_full_fence();
 	ret = arch_atomic64_add_negative_relaxed(i, v);
 	__atomic_post_full_fence();
 	return ret;
-}
 #else
-static __always_inline bool
-raw_atomic64_add_negative(s64 i, atomic64_t *v)
-{
 	return raw_atomic64_add_return(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_add_negative_acquire)
-#define raw_atomic64_add_negative_acquire arch_atomic64_add_negative_acquire
-#elif defined(arch_atomic64_add_negative_relaxed)
 static __always_inline bool
 raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_negative_acquire)
+	return arch_atomic64_add_negative_acquire(i, v);
+#elif defined(arch_atomic64_add_negative_relaxed)
 	bool ret = arch_atomic64_add_negative_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-}
 #elif defined(arch_atomic64_add_negative)
-#define raw_atomic64_add_negative_acquire arch_atomic64_add_negative
+	return arch_atomic64_add_negative(i, v);
 #else
-static __always_inline bool
-raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
-{
 	return raw_atomic64_add_return_acquire(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_add_negative_release)
-#define raw_atomic64_add_negative_release arch_atomic64_add_negative_release
-#elif defined(arch_atomic64_add_negative_relaxed)
 static __always_inline bool
 raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_negative_release)
+	return arch_atomic64_add_negative_release(i, v);
+#elif defined(arch_atomic64_add_negative_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_add_negative_relaxed(i, v);
-}
 #elif defined(arch_atomic64_add_negative)
-#define raw_atomic64_add_negative_release arch_atomic64_add_negative
+	return arch_atomic64_add_negative(i, v);
 #else
-static __always_inline bool
-raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
-{
 	return raw_atomic64_add_return_release(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_add_negative_relaxed)
-#define raw_atomic64_add_negative_relaxed arch_atomic64_add_negative_relaxed
-#elif defined(arch_atomic64_add_negative)
-#define raw_atomic64_add_negative_relaxed arch_atomic64_add_negative
-#else
 static __always_inline bool
 raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
+#if defined(arch_atomic64_add_negative_relaxed)
+	return arch_atomic64_add_negative_relaxed(i, v);
+#elif defined(arch_atomic64_add_negative)
+	return arch_atomic64_add_negative(i, v);
+#else
 	return raw_atomic64_add_return_relaxed(i, v) < 0;
-}
 #endif
+}
 
-#if defined(arch_atomic64_fetch_add_unless)
-#define raw_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
-#else
 static __always_inline s64
 raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
+#if defined(arch_atomic64_fetch_add_unless)
+	return arch_atomic64_fetch_add_unless(v, a, u);
+#else
 	s64 c = raw_atomic64_read(v);
 
 	do {
@@ -2839,35 +2735,35 @@ raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 	} while (!raw_atomic64_try_cmpxchg(v, &c, c + a));
 
 	return c;
-}
 #endif
+}
 
-#if defined(arch_atomic64_add_unless)
-#define raw_atomic64_add_unless arch_atomic64_add_unless
-#else
 static __always_inline bool
 raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
+#if defined(arch_atomic64_add_unless)
+	return arch_atomic64_add_unless(v, a, u);
+#else
 	return raw_atomic64_fetch_add_unless(v, a, u) != u;
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_not_zero)
-#define raw_atomic64_inc_not_zero arch_atomic64_inc_not_zero
-#else
 static __always_inline bool
 raw_atomic64_inc_not_zero(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_not_zero)
+	return arch_atomic64_inc_not_zero(v);
+#else
 	return raw_atomic64_add_unless(v, 1, 0);
-}
 #endif
+}
 
-#if defined(arch_atomic64_inc_unless_negative)
-#define raw_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
-#else
 static __always_inline bool
 raw_atomic64_inc_unless_negative(atomic64_t *v)
 {
+#if defined(arch_atomic64_inc_unless_negative)
+	return arch_atomic64_inc_unless_negative(v);
+#else
 	s64 c = raw_atomic64_read(v);
 
 	do {
@@ -2876,15 +2772,15 @@ raw_atomic64_inc_unless_negative(atomic64_t *v)
 	} while (!raw_atomic64_try_cmpxchg(v, &c, c + 1));
 
 	return true;
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_unless_positive)
-#define raw_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
-#else
 static __always_inline bool
 raw_atomic64_dec_unless_positive(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_unless_positive)
+	return arch_atomic64_dec_unless_positive(v);
+#else
 	s64 c = raw_atomic64_read(v);
 
 	do {
@@ -2893,15 +2789,15 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
 	} while (!raw_atomic64_try_cmpxchg(v, &c, c - 1));
 
 	return true;
-}
 #endif
+}
 
-#if defined(arch_atomic64_dec_if_positive)
-#define raw_atomic64_dec_if_positive arch_atomic64_dec_if_positive
-#else
 static __always_inline s64
 raw_atomic64_dec_if_positive(atomic64_t *v)
 {
+#if defined(arch_atomic64_dec_if_positive)
+	return arch_atomic64_dec_if_positive(v);
+#else
 	s64 dec, c = raw_atomic64_read(v);
 
 	do {
@@ -2911,8 +2807,8 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 	} while (!raw_atomic64_try_cmpxchg(v, &c, dec));
 
 	return dec;
-}
 #endif
+}
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// c2048fccede6fac923252290e2b303949d5dec83
+// 205e090382132f1fc85e48b46e722865f9c81309
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 90ee2f55af770..5491c89dc03a0 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -462,33 +462,33 @@ atomic_fetch_xor_relaxed(int i, atomic_t *v)
 }
 
 static __always_inline int
-atomic_xchg(atomic_t *v, int i)
+atomic_xchg(atomic_t *v, int new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_xchg(v, i);
+	return raw_atomic_xchg(v, new);
 }
 
 static __always_inline int
-atomic_xchg_acquire(atomic_t *v, int i)
+atomic_xchg_acquire(atomic_t *v, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_xchg_acquire(v, i);
+	return raw_atomic_xchg_acquire(v, new);
 }
 
 static __always_inline int
-atomic_xchg_release(atomic_t *v, int i)
+atomic_xchg_release(atomic_t *v, int new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_xchg_release(v, i);
+	return raw_atomic_xchg_release(v, new);
 }
 
 static __always_inline int
-atomic_xchg_relaxed(atomic_t *v, int i)
+atomic_xchg_relaxed(atomic_t *v, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_xchg_relaxed(v, i);
+	return raw_atomic_xchg_relaxed(v, new);
 }
 
 static __always_inline int
@@ -1103,33 +1103,33 @@ atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 }
 
 static __always_inline s64
-atomic64_xchg(atomic64_t *v, s64 i)
+atomic64_xchg(atomic64_t *v, s64 new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic64_xchg(v, i);
+	return raw_atomic64_xchg(v, new);
 }
 
 static __always_inline s64
-atomic64_xchg_acquire(atomic64_t *v, s64 i)
+atomic64_xchg_acquire(atomic64_t *v, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic64_xchg_acquire(v, i);
+	return raw_atomic64_xchg_acquire(v, new);
 }
 
 static __always_inline s64
-atomic64_xchg_release(atomic64_t *v, s64 i)
+atomic64_xchg_release(atomic64_t *v, s64 new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic64_xchg_release(v, i);
+	return raw_atomic64_xchg_release(v, new);
 }
 
 static __always_inline s64
-atomic64_xchg_relaxed(atomic64_t *v, s64 i)
+atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic64_xchg_relaxed(v, i);
+	return raw_atomic64_xchg_relaxed(v, new);
 }
 
 static __always_inline s64
@@ -1744,33 +1744,33 @@ atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 }
 
 static __always_inline long
-atomic_long_xchg(atomic_long_t *v, long i)
+atomic_long_xchg(atomic_long_t *v, long new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_long_xchg(v, i);
+	return raw_atomic_long_xchg(v, new);
 }
 
 static __always_inline long
-atomic_long_xchg_acquire(atomic_long_t *v, long i)
+atomic_long_xchg_acquire(atomic_long_t *v, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_long_xchg_acquire(v, i);
+	return raw_atomic_long_xchg_acquire(v, new);
 }
 
 static __always_inline long
-atomic_long_xchg_release(atomic_long_t *v, long i)
+atomic_long_xchg_release(atomic_long_t *v, long new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_long_xchg_release(v, i);
+	return raw_atomic_long_xchg_release(v, new);
 }
 
 static __always_inline long
-atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+atomic_long_xchg_relaxed(atomic_long_t *v, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	return raw_atomic_long_xchg_relaxed(v, i);
+	return raw_atomic_long_xchg_relaxed(v, new);
 }
 
 static __always_inline long
@@ -2231,4 +2231,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// f6502977180430e61c1a7c4e5e665f04f501fb8d
+// a4c3d2b229f907654cc53cb5d40e80f7fed1ec9c
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 63e0b4078ebd5..f564f71ff8afc 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -622,42 +622,42 @@ raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 }
 
 static __always_inline long
-raw_atomic_long_xchg(atomic_long_t *v, long i)
+raw_atomic_long_xchg(atomic_long_t *v, long new)
 {
 #ifdef CONFIG_64BIT
-	return raw_atomic64_xchg(v, i);
+	return raw_atomic64_xchg(v, new);
 #else
-	return raw_atomic_xchg(v, i);
+	return raw_atomic_xchg(v, new);
 #endif
 }
 
 static __always_inline long
-raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
+raw_atomic_long_xchg_acquire(atomic_long_t *v, long new)
 {
 #ifdef CONFIG_64BIT
-	return raw_atomic64_xchg_acquire(v, i);
+	return raw_atomic64_xchg_acquire(v, new);
 #else
-	return raw_atomic_xchg_acquire(v, i);
+	return raw_atomic_xchg_acquire(v, new);
 #endif
 }
 
 static __always_inline long
-raw_atomic_long_xchg_release(atomic_long_t *v, long i)
+raw_atomic_long_xchg_release(atomic_long_t *v, long new)
 {
 #ifdef CONFIG_64BIT
-	return raw_atomic64_xchg_release(v, i);
+	return raw_atomic64_xchg_release(v, new);
 #else
-	return raw_atomic_xchg_release(v, i);
+	return raw_atomic_xchg_release(v, new);
 #endif
 }
 
 static __always_inline long
-raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+raw_atomic_long_xchg_relaxed(atomic_long_t *v, long new)
 {
 #ifdef CONFIG_64BIT
-	return raw_atomic64_xchg_relaxed(v, i);
+	return raw_atomic64_xchg_relaxed(v, new);
 #else
-	return raw_atomic_xchg_relaxed(v, i);
+	return raw_atomic_xchg_relaxed(v, new);
 #endif
 }
 
@@ -872,4 +872,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// ad09f849db0db5b30c82e497eeb9056a394c5f22
+// e785d25cc3f220b7d473d36aac9da85dd7eb13a8
diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
index 85ca8d9b5c279..903946cbf1b3e 100644
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -27,7 +27,7 @@ and			vF	i	v
 andnot			vF	i	v
 or			vF	i	v
 xor			vF	i	v
-xchg			I	v	i
+xchg			I	v	i:new
 cmpxchg			I	v	i:old	i:new
 try_cmpxchg		B	v	p:old	i:new
 sub_and_test		b	i	v
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index b0f732a5c46ef..4da0cab3604e2 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,9 +1,5 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_${pfx}${name}${sfx}_acquire(${params})
-{
 	${ret} ret = arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
 	return ret;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index 16876118019ec..1d3d4ab3a9d29 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
-{
 	return raw_${atomic}_add_return${order}(i, v) < 0;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 88593e28b1637..95ecb2b7405be 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,7 +1,3 @@
 cat << EOF
-static __always_inline bool
-raw_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
-{
 	return raw_${atomic}_fetch_add_unless(v, a, u) != u;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 5b83bb63f7284..66760457e67a5 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
-{
 	${retstmt}raw_${atomic}_${pfx}and${sfx}${order}(~i, v);
-}
 EOF
diff --git a/scripts/atomic/fallbacks/cmpxchg b/scripts/atomic/fallbacks/cmpxchg
index 312ee67f1743e..1c8507f62e049 100755
--- a/scripts/atomic/fallbacks/cmpxchg
+++ b/scripts/atomic/fallbacks/cmpxchg
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline ${int}
-raw_${atomic}_cmpxchg${order}(${atomic}_t *v, ${int} old, ${int} new)
-{
 	return raw_cmpxchg${order}(&v->counter, old, new);
-}
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index a660ac65994bd..60d286d40300f 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
-{
 	${retstmt}raw_${atomic}_${pfx}sub${sfx}${order}(1, v);
-}
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 521dfcae03f24..3a0278e0ddd73 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_dec_and_test(${atomic}_t *v)
-{
 	return raw_${atomic}_dec_return(v) == 0;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index 7acb205e6ce35..f65c11b4b85bd 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,7 +1,4 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_dec_if_positive(${atomic}_t *v)
-{
 	${int} dec, c = raw_${atomic}_read(v);
 
 	do {
@@ -11,5 +8,4 @@ raw_${atomic}_dec_if_positive(${atomic}_t *v)
 	} while (!raw_${atomic}_try_cmpxchg(v, &c, dec));
 
 	return dec;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index bcb4f27945eaa..d025361d7b85a 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,7 +1,4 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_dec_unless_positive(${atomic}_t *v)
-{
 	${int} c = raw_${atomic}_read(v);
 
 	do {
@@ -10,5 +7,4 @@ raw_${atomic}_dec_unless_positive(${atomic}_t *v)
 	} while (!raw_${atomic}_try_cmpxchg(v, &c, c - 1));
 
 	return true;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 067eea553f5e0..40d5b397658f7 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,11 +1,7 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_${pfx}${name}${sfx}(${params})
-{
 	${ret} ret;
 	__atomic_pre_full_fence();
 	ret = arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_post_full_fence();
 	return ret;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index c18b940153dfd..8db7e9e17facf 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,7 +1,4 @@
 cat << EOF
-static __always_inline ${int}
-raw_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
-{
 	${int} c = raw_${atomic}_read(v);
 
 	do {
@@ -10,5 +7,4 @@ raw_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 	} while (!raw_${atomic}_try_cmpxchg(v, &c, c + a));
 
 	return c;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index 7d838f0b66391..56c770f5919c0 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
-{
 	${retstmt}raw_${atomic}_${pfx}add${sfx}${order}(1, v);
-}
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index de25aebee715d..7d16a10f2257e 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_inc_and_test(${atomic}_t *v)
-{
 	return raw_${atomic}_inc_return(v) == 0;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index e02206d017f62..1fcef1e55bc97 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_inc_not_zero(${atomic}_t *v)
-{
 	return raw_${atomic}_add_unless(v, 1, 0);
-}
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 7b85cc5b00d2b..7b4b09868842d 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,7 +1,4 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_inc_unless_negative(${atomic}_t *v)
-{
 	${int} c = raw_${atomic}_read(v);
 
 	do {
@@ -10,5 +7,4 @@ raw_${atomic}_inc_unless_negative(${atomic}_t *v)
 	} while (!raw_${atomic}_try_cmpxchg(v, &c, c + 1));
 
 	return true;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 26d15ad92d043..e319862d2f1a5 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,7 +1,4 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_read_acquire(const ${atomic}_t *v)
-{
 	${int} ret;
 
 	if (__native_word(${atomic}_t)) {
@@ -12,5 +9,4 @@ raw_${atomic}_read_acquire(const ${atomic}_t *v)
 	}
 
 	return ret;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index cbbff708129b8..1e6daf57b4ba5 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,8 +1,4 @@
 cat <<EOF
-static __always_inline ${ret}
-raw_${atomic}_${pfx}${name}${sfx}_release(${params})
-{
 	__atomic_release_fence();
 	${retstmt}arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
-}
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 104693bc3c660..16a374ae6bb16 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,12 +1,8 @@
 cat <<EOF
-static __always_inline void
-raw_${atomic}_set_release(${atomic}_t *v, ${int} i)
-{
 	if (__native_word(${atomic}_t)) {
 		smp_store_release(&(v)->counter, i);
 	} else {
 		__atomic_release_fence();
 		raw_${atomic}_set(v, i);
 	}
-}
 EOF
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 8975a496d495c..d1f746fe0ca4d 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
-{
 	return raw_${atomic}_sub_return(i, v) == 0;
-}
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 4c911a6cced94..d4da82092baf7 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,11 +1,7 @@
 cat <<EOF
-static __always_inline bool
-raw_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
-{
 	${int} r, o = *old;
 	r = raw_${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
-}
 EOF
diff --git a/scripts/atomic/fallbacks/xchg b/scripts/atomic/fallbacks/xchg
index bdd788aa575ff..e4def1e0d0926 100755
--- a/scripts/atomic/fallbacks/xchg
+++ b/scripts/atomic/fallbacks/xchg
@@ -1,7 +1,3 @@
 cat <<EOF
-static __always_inline ${int}
-raw_${atomic}_xchg${order}(${atomic}_t *v, ${int} new)
-{
 	return raw_xchg${order}(&v->counter, new);
-}
 EOF
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 86aca4f9f315a..2b470d31e3539 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -60,13 +60,23 @@ gen_proto_order_variant()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
-	local atomic="$1"
+	local atomic="$1"; shift
+	local int="$1"; shift
 
 	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
 	local basename="${atomic}_${pfx}${name}${sfx}"
 
 	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+
+	printf "static __always_inline ${ret}\n"
+	printf "raw_${atomicname}(${params})\n"
+	printf "{\n"
+
 	# Where there is no possible fallback, this order variant is mandatory
 	# and must be provided by arch code. Add a comment to the header to
 	# make this obvious.
@@ -75,33 +85,35 @@ gen_proto_order_variant()
 	# define this order variant as a C function without a preprocessor
 	# symbol.
 	if [ -z ${template} ] && [ -z "${order}" ] && ! meta_has_relaxed "${meta}"; then
-		printf "#define raw_${atomicname} arch_${atomicname}\n\n"
+		printf "\t${retstmt}arch_${atomicname}(${args});\n"
+		printf "}\n\n"
 		return
 	fi
 
 	printf "#if defined(arch_${atomicname})\n"
-	printf "#define raw_${atomicname} arch_${atomicname}\n"
+	printf "\t${retstmt}arch_${atomicname}(${args});\n"
 
 	# Allow FULL/ACQUIRE/RELEASE ops to be defined in terms of RELAXED ops
 	if [ "${order}" != "_relaxed" ] && meta_has_relaxed "${meta}"; then
 		printf "#elif defined(arch_${basename}_relaxed)\n"
-		gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+		gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "${atomic}" "${int}" "$@"
 	fi
 
 	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
 	if [ ! -z "${order}" ]; then
 		printf "#elif defined(arch_${basename})\n"
-		printf "#define raw_${atomicname} arch_${basename}\n"
+		printf "\t${retstmt}arch_${basename}(${args});\n"
 	fi
 
 	printf "#else\n"
 	if [ ! -z "${template}" ]; then
-		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "${atomic}" "${int}" "$@"
 	else
 		printf "#error \"Unable to define raw_${atomicname}\"\n"
 	fi
 
-	printf "#endif\n\n"
+	printf "#endif\n"
+	printf "}\n\n"
 }
 
 
-- 
2.30.2

