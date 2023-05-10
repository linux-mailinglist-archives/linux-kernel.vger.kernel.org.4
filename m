Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C516FE3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjEJSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjEJSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1289B4;
        Wed, 10 May 2023 11:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3293D63F88;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0B9C4339E;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=VbR1Phwuz3aHPV2NlTFLb/EDzs8Ul66u7yy6d5bFcic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nguuQFdDUOXv21uxQD87l1plbiHh/tRqZwj0yCk7865P/p6EfkFlS+RuGkq8vOgZL
         1Yc2kXzqoCdL0TlUSWCzDFK8x50N1TQm9Gi3zEP0QkRXhWVbXgd9rZoSVB+/Rl+j2+
         RXhBV3Ls7SSn5rN4EZCYrjSYitwR75OzAZ2ygMqFJlYfnbs43iaZXBDSkldB5hr8eQ
         PgLErOpzvfty35MRYaHWqq+TmTAEXINl4x8Tygbr1dfbQtfQir5u9wR3ekGlK1X4pO
         KN7F6MZaXD6HZ1zZuqa50NQp8h9x/8csRLTMgIqWCOFfomcBrNstsnuIQ723DxqZjX
         uFq1tTfwV6khg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F295CCE1F76; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 14/19] locking/atomic: Add kernel-doc header for arch_${atomic}_${pfx}${name}${sfx}_acquire
Date:   Wed, 10 May 2023 11:17:12 -0700
Message-Id: <20230510181717.2200934-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc header template for arch_${atomic}_${pfx}${name}${sfx}_acquire
function family with the help of my good friend awk, as encapsulated in
acqrel.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 268 +++++++++++++++++++-
 scripts/atomic/fallbacks/acquire            |   4 +-
 2 files changed, 270 insertions(+), 2 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index c3552b83bf49..fc80113ca60a 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -292,6 +292,14 @@ arch_atomic_set_release(atomic_t *v, int i)
 #else /* arch_atomic_add_return_relaxed */
 
 #ifndef arch_atomic_add_return_acquire
+/**
+ * arch_atomic_add_return_acquire - Atomic add with acquire ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i to @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_add_return_acquire(int i, atomic_t *v)
 {
@@ -334,6 +342,14 @@ arch_atomic_add_return(int i, atomic_t *v)
 #else /* arch_atomic_fetch_add_relaxed */
 
 #ifndef arch_atomic_fetch_add_acquire
+/**
+ * arch_atomic_fetch_add_acquire - Atomic add with acquire ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i to @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_add_acquire(int i, atomic_t *v)
 {
@@ -376,6 +392,14 @@ arch_atomic_fetch_add(int i, atomic_t *v)
 #else /* arch_atomic_sub_return_relaxed */
 
 #ifndef arch_atomic_sub_return_acquire
+/**
+ * arch_atomic_sub_return_acquire - Atomic sub with acquire ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtract @i from @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_sub_return_acquire(int i, atomic_t *v)
 {
@@ -418,6 +442,14 @@ arch_atomic_sub_return(int i, atomic_t *v)
 #else /* arch_atomic_fetch_sub_relaxed */
 
 #ifndef arch_atomic_fetch_sub_acquire
+/**
+ * arch_atomic_fetch_sub_acquire - Atomic sub with acquire ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtract @i from @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
@@ -543,6 +575,13 @@ arch_atomic_inc_return_relaxed(atomic_t *v)
 #else /* arch_atomic_inc_return_relaxed */
 
 #ifndef arch_atomic_inc_return_acquire
+/**
+ * arch_atomic_inc_return_acquire - Atomic inc with acquire ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_inc_return_acquire(atomic_t *v)
 {
@@ -652,6 +691,13 @@ arch_atomic_fetch_inc_relaxed(atomic_t *v)
 #else /* arch_atomic_fetch_inc_relaxed */
 
 #ifndef arch_atomic_fetch_inc_acquire
+/**
+ * arch_atomic_fetch_inc_acquire - Atomic inc with acquire ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc_acquire(atomic_t *v)
 {
@@ -777,6 +823,13 @@ arch_atomic_dec_return_relaxed(atomic_t *v)
 #else /* arch_atomic_dec_return_relaxed */
 
 #ifndef arch_atomic_dec_return_acquire
+/**
+ * arch_atomic_dec_return_acquire - Atomic dec with acquire ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_dec_return_acquire(atomic_t *v)
 {
@@ -886,6 +939,13 @@ arch_atomic_fetch_dec_relaxed(atomic_t *v)
 #else /* arch_atomic_fetch_dec_relaxed */
 
 #ifndef arch_atomic_fetch_dec_acquire
+/**
+ * arch_atomic_fetch_dec_acquire - Atomic dec with acquire ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec_acquire(atomic_t *v)
 {
@@ -928,6 +988,14 @@ arch_atomic_fetch_dec(atomic_t *v)
 #else /* arch_atomic_fetch_and_relaxed */
 
 #ifndef arch_atomic_fetch_and_acquire
+/**
+ * arch_atomic_fetch_and_acquire - Atomic and with acquire ordering
+ * @i: value to AND
+ * @v: pointer of type atomic_t
+ *
+ * Atomically AND @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_and_acquire(int i, atomic_t *v)
 {
@@ -1058,6 +1126,14 @@ arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 #else /* arch_atomic_fetch_andnot_relaxed */
 
 #ifndef arch_atomic_fetch_andnot_acquire
+/**
+ * arch_atomic_fetch_andnot_acquire - Atomic andnot with acquire ordering
+ * @i: value to complement then AND
+ * @v: pointer of type atomic_t
+ *
+ * Atomically complement then AND @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
@@ -1100,6 +1176,14 @@ arch_atomic_fetch_andnot(int i, atomic_t *v)
 #else /* arch_atomic_fetch_or_relaxed */
 
 #ifndef arch_atomic_fetch_or_acquire
+/**
+ * arch_atomic_fetch_or_acquire - Atomic or with acquire ordering
+ * @i: value to OR
+ * @v: pointer of type atomic_t
+ *
+ * Atomically OR @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_or_acquire(int i, atomic_t *v)
 {
@@ -1142,6 +1226,14 @@ arch_atomic_fetch_or(int i, atomic_t *v)
 #else /* arch_atomic_fetch_xor_relaxed */
 
 #ifndef arch_atomic_fetch_xor_acquire
+/**
+ * arch_atomic_fetch_xor_acquire - Atomic xor with acquire ordering
+ * @i: value to XOR
+ * @v: pointer of type atomic_t
+ *
+ * Atomically XOR @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
@@ -1184,6 +1276,14 @@ arch_atomic_fetch_xor(int i, atomic_t *v)
 #else /* arch_atomic_xchg_relaxed */
 
 #ifndef arch_atomic_xchg_acquire
+/**
+ * arch_atomic_xchg_acquire - Atomic xchg with acquire ordering
+ * @v: pointer of type atomic_t
+ * @i: value to exchange
+ *
+ * Atomically exchange @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_xchg_acquire(atomic_t *v, int i)
 {
@@ -1226,6 +1326,18 @@ arch_atomic_xchg(atomic_t *v, int i)
 #else /* arch_atomic_cmpxchg_relaxed */
 
 #ifndef arch_atomic_cmpxchg_acquire
+/**
+ * arch_atomic_cmpxchg_acquire - Atomic cmpxchg with acquire ordering
+ * @v: pointer of type atomic_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing acquire ordering.
+ * Returns the old value *@v regardless of the result of
+ * the comparison.  Therefore, if the return value is not
+ * equal to @old, the cmpxchg operation failed.
+ */
 static __always_inline int
 arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
@@ -1363,6 +1475,18 @@ arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 #else /* arch_atomic_try_cmpxchg_relaxed */
 
 #ifndef arch_atomic_try_cmpxchg_acquire
+/**
+ * arch_atomic_try_cmpxchg_acquire - Atomic try_cmpxchg with acquire ordering
+ * @v: pointer of type atomic_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing acquire ordering.
+ * Returns @true if the cmpxchg operation succeeded,
+ * and false otherwise.  Either way, stores the old
+ * value of *@v to *@old.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
@@ -1528,6 +1652,15 @@ arch_atomic_add_negative_relaxed(int i, atomic_t *v)
 #else /* arch_atomic_add_negative_relaxed */
 
 #ifndef arch_atomic_add_negative_acquire
+/**
+ * arch_atomic_add_negative_acquire - Atomic add_negative with acquire ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i with @v using acquire ordering.
+ * Return @true if the result is negative, or @false when
+ * the result is greater than or equal to zero.
+ */
 static __always_inline bool
 arch_atomic_add_negative_acquire(int i, atomic_t *v)
 {
@@ -1754,6 +1887,14 @@ arch_atomic64_set_release(atomic64_t *v, s64 i)
 #else /* arch_atomic64_add_return_relaxed */
 
 #ifndef arch_atomic64_add_return_acquire
+/**
+ * arch_atomic64_add_return_acquire - Atomic add with acquire ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i to @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
@@ -1796,6 +1937,14 @@ arch_atomic64_add_return(s64 i, atomic64_t *v)
 #else /* arch_atomic64_fetch_add_relaxed */
 
 #ifndef arch_atomic64_fetch_add_acquire
+/**
+ * arch_atomic64_fetch_add_acquire - Atomic add with acquire ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i to @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
@@ -1838,6 +1987,14 @@ arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 #else /* arch_atomic64_sub_return_relaxed */
 
 #ifndef arch_atomic64_sub_return_acquire
+/**
+ * arch_atomic64_sub_return_acquire - Atomic sub with acquire ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtract @i from @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
@@ -1880,6 +2037,14 @@ arch_atomic64_sub_return(s64 i, atomic64_t *v)
 #else /* arch_atomic64_fetch_sub_relaxed */
 
 #ifndef arch_atomic64_fetch_sub_acquire
+/**
+ * arch_atomic64_fetch_sub_acquire - Atomic sub with acquire ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtract @i from @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
@@ -2005,6 +2170,13 @@ arch_atomic64_inc_return_relaxed(atomic64_t *v)
 #else /* arch_atomic64_inc_return_relaxed */
 
 #ifndef arch_atomic64_inc_return_acquire
+/**
+ * arch_atomic64_inc_return_acquire - Atomic inc with acquire ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return_acquire(atomic64_t *v)
 {
@@ -2114,6 +2286,13 @@ arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
 #else /* arch_atomic64_fetch_inc_relaxed */
 
 #ifndef arch_atomic64_fetch_inc_acquire
+/**
+ * arch_atomic64_fetch_inc_acquire - Atomic inc with acquire ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc_acquire(atomic64_t *v)
 {
@@ -2239,6 +2418,13 @@ arch_atomic64_dec_return_relaxed(atomic64_t *v)
 #else /* arch_atomic64_dec_return_relaxed */
 
 #ifndef arch_atomic64_dec_return_acquire
+/**
+ * arch_atomic64_dec_return_acquire - Atomic dec with acquire ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v using acquire ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return_acquire(atomic64_t *v)
 {
@@ -2348,6 +2534,13 @@ arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
 #else /* arch_atomic64_fetch_dec_relaxed */
 
 #ifndef arch_atomic64_fetch_dec_acquire
+/**
+ * arch_atomic64_fetch_dec_acquire - Atomic dec with acquire ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec_acquire(atomic64_t *v)
 {
@@ -2390,6 +2583,14 @@ arch_atomic64_fetch_dec(atomic64_t *v)
 #else /* arch_atomic64_fetch_and_relaxed */
 
 #ifndef arch_atomic64_fetch_and_acquire
+/**
+ * arch_atomic64_fetch_and_acquire - Atomic and with acquire ordering
+ * @i: value to AND
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically AND @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
@@ -2520,6 +2721,14 @@ arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 #else /* arch_atomic64_fetch_andnot_relaxed */
 
 #ifndef arch_atomic64_fetch_andnot_acquire
+/**
+ * arch_atomic64_fetch_andnot_acquire - Atomic andnot with acquire ordering
+ * @i: value to complement then AND
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically complement then AND @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
@@ -2562,6 +2771,14 @@ arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #else /* arch_atomic64_fetch_or_relaxed */
 
 #ifndef arch_atomic64_fetch_or_acquire
+/**
+ * arch_atomic64_fetch_or_acquire - Atomic or with acquire ordering
+ * @i: value to OR
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically OR @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
@@ -2604,6 +2821,14 @@ arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 #else /* arch_atomic64_fetch_xor_relaxed */
 
 #ifndef arch_atomic64_fetch_xor_acquire
+/**
+ * arch_atomic64_fetch_xor_acquire - Atomic xor with acquire ordering
+ * @i: value to XOR
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically XOR @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
@@ -2646,6 +2871,14 @@ arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 #else /* arch_atomic64_xchg_relaxed */
 
 #ifndef arch_atomic64_xchg_acquire
+/**
+ * arch_atomic64_xchg_acquire - Atomic xchg with acquire ordering
+ * @v: pointer of type atomic64_t
+ * @i: value to exchange
+ *
+ * Atomically exchange @i with @v using acquire ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
@@ -2688,6 +2921,18 @@ arch_atomic64_xchg(atomic64_t *v, s64 i)
 #else /* arch_atomic64_cmpxchg_relaxed */
 
 #ifndef arch_atomic64_cmpxchg_acquire
+/**
+ * arch_atomic64_cmpxchg_acquire - Atomic cmpxchg with acquire ordering
+ * @v: pointer of type atomic64_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing acquire ordering.
+ * Returns the old value *@v regardless of the result of
+ * the comparison.  Therefore, if the return value is not
+ * equal to @old, the cmpxchg operation failed.
+ */
 static __always_inline s64
 arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
@@ -2825,6 +3070,18 @@ arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 #else /* arch_atomic64_try_cmpxchg_relaxed */
 
 #ifndef arch_atomic64_try_cmpxchg_acquire
+/**
+ * arch_atomic64_try_cmpxchg_acquire - Atomic try_cmpxchg with acquire ordering
+ * @v: pointer of type atomic64_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing acquire ordering.
+ * Returns @true if the cmpxchg operation succeeded,
+ * and false otherwise.  Either way, stores the old
+ * value of *@v to *@old.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2990,6 +3247,15 @@ arch_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 #else /* arch_atomic64_add_negative_relaxed */
 
 #ifndef arch_atomic64_add_negative_acquire
+/**
+ * arch_atomic64_add_negative_acquire - Atomic add_negative with acquire ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i with @v using acquire ordering.
+ * Return @true if the result is negative, or @false when
+ * the result is greater than or equal to zero.
+ */
 static __always_inline bool
 arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
@@ -3160,4 +3426,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 96c8a3c4d13b12c9f3e0f715709c8af1653a7e79
+// a7944792460cf5adb72d49025850800d2cd178be
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index ef764085c79a..08fc6c30a9ef 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,4 +1,6 @@
-cat <<EOF
+acqrel=acquire
+. ${ATOMICDIR}/acqrel.sh
+cat << EOF
 static __always_inline ${ret}
 arch_${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
-- 
2.40.1

