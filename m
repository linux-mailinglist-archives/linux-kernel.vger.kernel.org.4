Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226BD6F2391
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjD2HSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjD2HSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:18:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC31BC8;
        Sat, 29 Apr 2023 00:18:08 -0700 (PDT)
Date:   Sat, 29 Apr 2023 07:18:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682752687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijpE08zRMyXqW0rRCsMjIXvXY80lo9xaDWYymiWennU=;
        b=Z3Avh7MROQ6ypmKfWZa7lSTFzOwq6ikqa17fqmJstQLULND5X8ux61BXMna4ULoyuMrlXX
        wITnyme6IeKLEMH3Yn3zXZdb/RLLhYLMX4OYXUWltKOga47Y+/0HbcSUCg3QZYauN9IZOT
        s4+wJJrWV59jOPC4Wrx7gkYU19q3MnpBuq5nnmvaQZVAGHlghTyEb9Y9OFn0Fv6QH+z9C5
        +coiq9bFLH3KY2dW0nBCp8GdLhdd9GvNixX8AAn5P2BnOMf0y2gNAGUYwhQrqgtC58c8DV
        aVEX0gdMkqaxz+3PkcRR/ws8XoON2JT2kY/eJNITm0qG+P98KDzKIaMCU2nzLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682752687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijpE08zRMyXqW0rRCsMjIXvXY80lo9xaDWYymiWennU=;
        b=LoLA6DG7HXyGSIXGwAJxsgDAc6EYlg8VqqZVhG46r8Vy29vMGaTg0csN2mHzZ+7zI4FL+A
        uS9OO7LHvIb3+BBg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: Correct (cmp)xchg() instrumentation
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230413160644.490976-1-mark.rutland@arm.com>
References: <20230413160644.490976-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168275268656.404.15827480037678551714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ec570320b09f76d52819e60abdccf372658216b6
Gitweb:        https://git.kernel.org/tip/ec570320b09f76d52819e60abdccf372658216b6
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Thu, 13 Apr 2023 17:06:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 29 Apr 2023 09:09:31 +02:00

locking/atomic: Correct (cmp)xchg() instrumentation

All xchg() and cmpxchg() ops are atomic RMWs, but currently we
instrument these with instrument_atomic_write() rather than
instrument_atomic_read_write(), missing the read aspect.

Similarly, all try_cmpxchg() ops are non-atomic RMWs on *oldp, but we
instrument these accesses with instrument_atomic_write() rather than
instrument_read_write(), missing the read aspect and erroneously marking
these as atomic.

Fix the instrumentation for both points.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20230413160644.490976-1-mark.rutland@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/atomic/atomic-instrumented.h | 76 ++++++++++-----------
 scripts/atomic/gen-atomic-instrumented.sh  |  6 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 245ba66..03a232a 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1948,14 +1948,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -1963,14 +1963,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -1978,14 +1978,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -1993,14 +1993,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -2008,14 +2008,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -2023,14 +2023,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_release(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -2039,8 +2039,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2048,8 +2048,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2058,8 +2058,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
 	kcsan_release(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2067,8 +2067,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2077,8 +2077,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2086,8 +2086,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg64_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2096,8 +2096,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
 	kcsan_release(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2105,22 +2105,22 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -2128,7 +2128,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -2136,8 +2136,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2145,8 +2145,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -2154,7 +2154,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	kcsan_mb(); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -2162,9 +2162,9 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 #define cmpxchg_double_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 97fe4d79aa058d2164df824632cbc4f716d2a407
+// 6b513a42e1a1b5962532a019b7fc91eaa044ad5e
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index c8165e9..d9ffd74 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -104,8 +104,8 @@ cat <<EOF
 EOF
 [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
 cat <<EOF
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
-	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
+	instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_read_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
 	arch_${xchg}${order}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
 })
 EOF
@@ -119,7 +119,7 @@ cat <<EOF
 EOF
 [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
 cat <<EOF
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
 	arch_${xchg}${order}(__ai_ptr, __VA_ARGS__); \\
 })
 EOF
