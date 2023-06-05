Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D808721FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjFEHnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjFEHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C8ED2;
        Mon,  5 Jun 2023 00:42:54 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFL93DotU4qHpSdkfRIIq0+Yi+1+PlieQD+ueNn+SlA=;
        b=mWBrrjPFf8gDuQA3HgySm46tLFzxJUJNsPpb4X10irLUunxvR2GDgSUtKFsUVTybX6BVfa
        aCik11pj97tii4uVyIO9TGgOviOmT662ZJosxpkEdRba2C20S0IpOTBUh5SKWpC7sST/sA
        cs5dsKDirZd9Wn76zrhKz5QjvBBi8yXqkS5infoULr1e9NUJL0kdFF+EFgjmDRxfF514Wd
        borgfFVi9jAw7PRMc/XIQzjwywGmt8TF+9fulF1unMtrWPpMS+rmG+lPjbxDPuageLrq1B
        vxSG5XwPtxxK6Y9bYNSyAetwAB9dRII6AZh+CRQAwP6ovortEwXvjla56g+KyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFL93DotU4qHpSdkfRIIq0+Yi+1+PlieQD+ueNn+SlA=;
        b=DkLicMTuBfMFdpHnFYzz6betvxy2Pud76iDNJ4Bgr3v+owGBaCcyJQMekBZlexq+/C/WZK
        Ypgf8z3gvlweVtAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] instrumentation: Wire up cmpxchg128()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.519237070@infradead.org>
References: <20230531132323.519237070@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097170.404.10443718027819954718.tip-bot2@tip-bot2>
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

Commit-ID:     8c8b096a23d12fedf3c0f50524f30113ef97aa8c
Gitweb:        https://git.kernel.org/tip/8c8b096a23d12fedf3c0f50524f30113ef97aa8c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:36 +02:00

instrumentation: Wire up cmpxchg128()

Wire up the cmpxchg128 family in the atomic wrapper scripts.

These provide the generic cmpxchg128 family of functions from the
arch_ prefixed version, adding explicit instrumentation where needed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.519237070@infradead.org
---
 include/linux/atomic/atomic-arch-fallback.h | 95 +++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  | 86 +++++++++++++++++-
 scripts/atomic/gen-atomic-fallback.sh       |  4 +-
 scripts/atomic/gen-atomic-instrumented.sh   |  4 +-
 4 files changed, 183 insertions(+), 6 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index a6e4437..1722ddb 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -77,6 +77,29 @@
 
 #endif /* arch_cmpxchg64_relaxed */
 
+#ifndef arch_cmpxchg128_relaxed
+#define arch_cmpxchg128_acquire arch_cmpxchg128
+#define arch_cmpxchg128_release arch_cmpxchg128
+#define arch_cmpxchg128_relaxed arch_cmpxchg128
+#else /* arch_cmpxchg128_relaxed */
+
+#ifndef arch_cmpxchg128_acquire
+#define arch_cmpxchg128_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg128_release
+#define arch_cmpxchg128_release(...) \
+	__atomic_op_release(arch_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg128
+#define arch_cmpxchg128(...) \
+	__atomic_op_fence(arch_cmpxchg128, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg128_relaxed */
+
 #ifndef arch_try_cmpxchg_relaxed
 #ifdef arch_try_cmpxchg
 #define arch_try_cmpxchg_acquire arch_try_cmpxchg
@@ -217,6 +240,76 @@
 
 #endif /* arch_try_cmpxchg64_relaxed */
 
+#ifndef arch_try_cmpxchg128_relaxed
+#ifdef arch_try_cmpxchg128
+#define arch_try_cmpxchg128_acquire arch_try_cmpxchg128
+#define arch_try_cmpxchg128_release arch_try_cmpxchg128
+#define arch_try_cmpxchg128_relaxed arch_try_cmpxchg128
+#endif /* arch_try_cmpxchg128 */
+
+#ifndef arch_try_cmpxchg128
+#define arch_try_cmpxchg128(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128 */
+
+#ifndef arch_try_cmpxchg128_acquire
+#define arch_try_cmpxchg128_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128_acquire */
+
+#ifndef arch_try_cmpxchg128_release
+#define arch_try_cmpxchg128_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128_release */
+
+#ifndef arch_try_cmpxchg128_relaxed
+#define arch_try_cmpxchg128_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128_relaxed */
+
+#else /* arch_try_cmpxchg128_relaxed */
+
+#ifndef arch_try_cmpxchg128_acquire
+#define arch_try_cmpxchg128_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg128_release
+#define arch_try_cmpxchg128_release(...) \
+	__atomic_op_release(arch_try_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg128
+#define arch_try_cmpxchg128(...) \
+	__atomic_op_fence(arch_try_cmpxchg128, __VA_ARGS__)
+#endif
+
+#endif /* arch_try_cmpxchg128_relaxed */
+
 #ifndef arch_try_cmpxchg_local
 #define arch_try_cmpxchg_local(_ptr, _oldp, _new) \
 ({ \
@@ -2668,4 +2761,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// ad2e2b4d168dbc60a73922616047a9bfa446af36
+// 52dfc6fe4a2e7234bbd2aa3e16a377c1db793a53
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 03a232a..8583720 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -2034,6 +2034,36 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
+#define cmpxchg128(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	kcsan_mb(); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg128_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_acquire(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg128_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	kcsan_release(); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_release(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg128_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+
 #define try_cmpxchg(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2110,6 +2140,44 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
+#define try_cmpxchg128(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	kcsan_mb(); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg128_acquire(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg128_release(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	kcsan_release(); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg128_relaxed(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2124,6 +2192,13 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
+#define cmpxchg128_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
+})
+
 #define sync_cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2150,6 +2225,15 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
+#define try_cmpxchg128_local(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
 #define cmpxchg_double(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2167,4 +2251,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 6b513a42e1a1b5962532a019b7fc91eaa044ad5e
+// 82d1be694fab30414527d0877c29fa75ed5a0b74
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 6e853f0..a70acd5 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -217,11 +217,11 @@ cat << EOF
 
 EOF
 
-for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64"; do
+for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64" "arch_cmpxchg128"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
-for cmpxchg in "cmpxchg" "cmpxchg64"; do
+for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
 	gen_try_cmpxchg_fallbacks "${cmpxchg}"
 done
 
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index d9ffd74..4f80347 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -166,14 +166,14 @@ grep '^[a-z]' "$1" | while read name meta args; do
 done
 
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_xchg "${xchg}" "${order}" ""
 		printf "\n"
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" ; do
+for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local"; do
 	gen_xchg "${xchg}" "" ""
 	printf "\n"
 done
