Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90469723B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjFFI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjFFI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD0E8;
        Tue,  6 Jun 2023 01:26:20 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtREA5eHj/a5d3lm7DuAPmkHFXPz+QQPCCqhcNI9vdg=;
        b=CRwyxJSH5IzUynyzFnchtO46bgGdy+uHPISOlM80FcJp7mMq8NWWkdFUEYREhixjrSH2me
        si9RH/EL/wFfJ27znyirvei95YXrbqOqyWtgIes/VFhH8g06NjxBSx3mPDEBPAuknvZ2l6
        tRDeG67ZbDjn3TdzCqT5YNbGDYrzALEXcFKuHeemjsLlHz1EGexWkymuDJJZl2Z0xoPmXF
        dKxfP948pPrQqmrBCmh4ATicOE+wL6EC2P0x/YlzP2HVLLs4eqNF1l/TR1Sewg7fU4YLTB
        WgK7Vfe4ySd799M25jVpNxc3Ohoytss5oGBO9WjsAvRh5F1r99E5JW9vbloW8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtREA5eHj/a5d3lm7DuAPmkHFXPz+QQPCCqhcNI9vdg=;
        b=IcE6WgSoQiLkdRfi168CbeoV1v4PtbRgzb/qblYqv/SyfPxzX4L0+BRs6fElqguOxR6K3G
        CVzDbHYzCQRPxuCA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: simplify
 raw_atomic_long*() definitions
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-23-mark.rutland@arm.com>
References: <20230605070124.3741859-23-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603997766.404.9127247654381835819.tip-bot2@tip-bot2>
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

Commit-ID:     630399469ffcb937936644fbaa5daf61e700a329
Gitweb:        https://git.kernel.org/tip/630399469ffcb937936644fbaa5daf61e700a329
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:22 +02:00

locking/atomic: scripts: simplify raw_atomic_long*() definitions

Currently, atomic-long is split into two sections, one defining the
raw_atomic_long_*() ops for CONFIG_64BIT, and one defining the raw
atomic_long_*() ops for !CONFIG_64BIT.

With many lines elided, this looks like:

| #ifdef CONFIG_64BIT
| ...
| static __always_inline bool
| raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
| {
|         return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
| }
| ...
| #else /* CONFIG_64BIT */
| ...
| static __always_inline bool
| raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
| {
|         return raw_atomic_try_cmpxchg(v, (int *)old, new);
| }
| ...
| #endif

The two definitions are spread far apart in the file, and duplicate the
prototype, making it hard to have a legible set of kerneldoc comments.

Make this simpler by defining the C prototype once, and writing the two
definitions inline. For example, the above becomes:

| static __always_inline bool
| raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
| {
| #ifdef CONFIG_64BIT
|         return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
| #else
|         return raw_atomic_try_cmpxchg(v, (int *)old, new);
| #endif
| }

As we now always have a single copy of the C prototype wrapping all the
potential definitions, we now have an obvious single location for kerneldoc
comments. As a bonus, both the script and the generated file are
somewhat shorter.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-23-mark.rutland@arm.com
---
 include/linux/atomic/atomic-long.h | 857 +++++++++++-----------------
 scripts/atomic/gen-atomic-long.sh  |  27 +-
 2 files changed, 350 insertions(+), 534 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 92dc82c..63e0b40 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -21,1030 +21,855 @@ typedef atomic_t atomic_long_t;
 #define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
 #endif
 
-#ifdef CONFIG_64BIT
-
-static __always_inline long
-raw_atomic_long_read(const atomic_long_t *v)
-{
-	return raw_atomic64_read(v);
-}
-
-static __always_inline long
-raw_atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return raw_atomic64_read_acquire(v);
-}
-
-static __always_inline void
-raw_atomic_long_set(atomic_long_t *v, long i)
-{
-	raw_atomic64_set(v, i);
-}
-
-static __always_inline void
-raw_atomic_long_set_release(atomic_long_t *v, long i)
-{
-	raw_atomic64_set_release(v, i);
-}
-
-static __always_inline void
-raw_atomic_long_add(long i, atomic_long_t *v)
-{
-	raw_atomic64_add(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_sub(long i, atomic_long_t *v)
-{
-	raw_atomic64_sub(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_inc(atomic_long_t *v)
-{
-	raw_atomic64_inc(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return_relaxed(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_long_dec(atomic_long_t *v)
-{
-	raw_atomic64_dec(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return_relaxed(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_long_and(long i, atomic_long_t *v)
-{
-	raw_atomic64_and(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_andnot(long i, atomic_long_t *v)
-{
-	raw_atomic64_andnot(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_or(long i, atomic_long_t *v)
-{
-	raw_atomic64_or(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_xor(long i, atomic_long_t *v)
-{
-	raw_atomic64_xor(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg_acquire(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg_release(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_and_test(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return raw_atomic64_dec_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return raw_atomic64_inc_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative_acquire(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative_release(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return raw_atomic64_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return raw_atomic64_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return raw_atomic64_inc_not_zero(v);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return raw_atomic64_inc_unless_negative(v);
-}
-
-static __always_inline bool
-raw_atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return raw_atomic64_dec_unless_positive(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return raw_atomic64_dec_if_positive(v);
-}
-
-#else /* CONFIG_64BIT */
-
 static __always_inline long
 raw_atomic_long_read(const atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_read(v);
+#else
 	return raw_atomic_read(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_read_acquire(const atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_read_acquire(v);
+#else
 	return raw_atomic_read_acquire(v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_set(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_set(v, i);
+#else
 	raw_atomic_set(v, i);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_set_release(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_set_release(v, i);
+#else
 	raw_atomic_set_release(v, i);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_add(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_add(i, v);
+#else
 	raw_atomic_add(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return(i, v);
+#else
 	return raw_atomic_add_return(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return_acquire(i, v);
+#else
 	return raw_atomic_add_return_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return_release(i, v);
+#else
 	return raw_atomic_add_return_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return_relaxed(i, v);
+#else
 	return raw_atomic_add_return_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add(i, v);
+#else
 	return raw_atomic_fetch_add(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_acquire(i, v);
+#else
 	return raw_atomic_fetch_add_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_release(i, v);
+#else
 	return raw_atomic_fetch_add_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_relaxed(i, v);
+#else
 	return raw_atomic_fetch_add_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_sub(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_sub(i, v);
+#else
 	raw_atomic_sub(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return(i, v);
+#else
 	return raw_atomic_sub_return(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return_acquire(i, v);
+#else
 	return raw_atomic_sub_return_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return_release(i, v);
+#else
 	return raw_atomic_sub_return_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return_relaxed(i, v);
+#else
 	return raw_atomic_sub_return_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub(i, v);
+#else
 	return raw_atomic_fetch_sub(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub_acquire(i, v);
+#else
 	return raw_atomic_fetch_sub_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub_release(i, v);
+#else
 	return raw_atomic_fetch_sub_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub_relaxed(i, v);
+#else
 	return raw_atomic_fetch_sub_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_inc(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_inc(v);
+#else
 	raw_atomic_inc(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return(v);
+#else
 	return raw_atomic_inc_return(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return_acquire(v);
+#else
 	return raw_atomic_inc_return_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return_release(v);
+#else
 	return raw_atomic_inc_return_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return_relaxed(v);
+#else
 	return raw_atomic_inc_return_relaxed(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc(v);
+#else
 	return raw_atomic_fetch_inc(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc_acquire(v);
+#else
 	return raw_atomic_fetch_inc_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc_release(v);
+#else
 	return raw_atomic_fetch_inc_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc_relaxed(v);
+#else
 	return raw_atomic_fetch_inc_relaxed(v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_dec(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_dec(v);
+#else
 	raw_atomic_dec(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return(v);
+#else
 	return raw_atomic_dec_return(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return_acquire(v);
+#else
 	return raw_atomic_dec_return_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return_release(v);
+#else
 	return raw_atomic_dec_return_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return_relaxed(v);
+#else
 	return raw_atomic_dec_return_relaxed(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec(v);
+#else
 	return raw_atomic_fetch_dec(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec_acquire(v);
+#else
 	return raw_atomic_fetch_dec_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec_release(v);
+#else
 	return raw_atomic_fetch_dec_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec_relaxed(v);
+#else
 	return raw_atomic_fetch_dec_relaxed(v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_and(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_and(i, v);
+#else
 	raw_atomic_and(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and(i, v);
+#else
 	return raw_atomic_fetch_and(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and_acquire(i, v);
+#else
 	return raw_atomic_fetch_and_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and_release(i, v);
+#else
 	return raw_atomic_fetch_and_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and_relaxed(i, v);
+#else
 	return raw_atomic_fetch_and_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_andnot(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_andnot(i, v);
+#else
 	raw_atomic_andnot(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot(i, v);
+#else
 	return raw_atomic_fetch_andnot(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot_acquire(i, v);
+#else
 	return raw_atomic_fetch_andnot_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot_release(i, v);
+#else
 	return raw_atomic_fetch_andnot_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot_relaxed(i, v);
+#else
 	return raw_atomic_fetch_andnot_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_or(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_or(i, v);
+#else
 	raw_atomic_or(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or(i, v);
+#else
 	return raw_atomic_fetch_or(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or_acquire(i, v);
+#else
 	return raw_atomic_fetch_or_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or_release(i, v);
+#else
 	return raw_atomic_fetch_or_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or_relaxed(i, v);
+#else
 	return raw_atomic_fetch_or_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_xor(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_xor(i, v);
+#else
 	raw_atomic_xor(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor(i, v);
+#else
 	return raw_atomic_fetch_xor(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor_acquire(i, v);
+#else
 	return raw_atomic_fetch_xor_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor_release(i, v);
+#else
 	return raw_atomic_fetch_xor_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor_relaxed(i, v);
+#else
 	return raw_atomic_fetch_xor_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg(v, i);
+#else
 	return raw_atomic_xchg(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg_acquire(v, i);
+#else
 	return raw_atomic_xchg_acquire(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg_release(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg_release(v, i);
+#else
 	return raw_atomic_xchg_release(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg_relaxed(v, i);
+#else
 	return raw_atomic_xchg_relaxed(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg(v, old, new);
+#else
 	return raw_atomic_cmpxchg(v, old, new);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg_acquire(v, old, new);
+#else
 	return raw_atomic_cmpxchg_acquire(v, old, new);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg_release(v, old, new);
+#else
 	return raw_atomic_cmpxchg_release(v, old, new);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg_relaxed(v, old, new);
+#else
 	return raw_atomic_cmpxchg_relaxed(v, old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg_acquire(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg_release(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg_relaxed(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_and_test(i, v);
+#else
 	return raw_atomic_sub_and_test(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_dec_and_test(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_and_test(v);
+#else
 	return raw_atomic_dec_and_test(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_inc_and_test(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_and_test(v);
+#else
 	return raw_atomic_inc_and_test(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative(i, v);
+#else
 	return raw_atomic_add_negative(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative_acquire(i, v);
+#else
 	return raw_atomic_add_negative_acquire(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative_release(i, v);
+#else
 	return raw_atomic_add_negative_release(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative_relaxed(i, v);
+#else
 	return raw_atomic_add_negative_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_unless(v, a, u);
+#else
 	return raw_atomic_fetch_add_unless(v, a, u);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_unless(v, a, u);
+#else
 	return raw_atomic_add_unless(v, a, u);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_inc_not_zero(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_not_zero(v);
+#else
 	return raw_atomic_inc_not_zero(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_inc_unless_negative(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_unless_negative(v);
+#else
 	return raw_atomic_inc_unless_negative(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_dec_unless_positive(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_unless_positive(v);
+#else
 	return raw_atomic_dec_unless_positive(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_if_positive(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_if_positive(v);
+#else
 	return raw_atomic_dec_if_positive(v);
+#endif
 }
 
-#endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 108784846d3bbbb201b8dabe621c5dc30b216206
+// ad09f849db0db5b30c82e497eeb9056a394c5f22
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 1383217..af27a71 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -32,7 +32,7 @@ gen_args_cast()
 	done
 }
 
-#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+#gen_proto_order_variant(meta, pfx, name, sfx, order, arg...)
 gen_proto_order_variant()
 {
 	local meta="$1"; shift
@@ -40,21 +40,24 @@ gen_proto_order_variant()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
-	local atomic="$1"; shift
-	local int="$1"; shift
 
 	local atomicname="${pfx}${name}${sfx}${order}"
 
 	local ret="$(gen_ret_type "${meta}" "long")"
 	local params="$(gen_params "long" "atomic_long" "$@")"
-	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
+	local argscast_32="$(gen_args_cast "int" "atomic" "$@")"
+	local argscast_64="$(gen_args_cast "s64" "atomic64" "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
 static __always_inline ${ret}
 raw_atomic_long_${atomicname}(${params})
 {
-	${retstmt}raw_${atomic}_${atomicname}(${argscast});
+#ifdef CONFIG_64BIT
+	${retstmt}raw_atomic64_${atomicname}(${argscast_64});
+#else
+	${retstmt}raw_atomic_${atomicname}(${argscast_32});
+#endif
 }
 
 EOF
@@ -84,24 +87,12 @@ typedef atomic_t atomic_long_t;
 #define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
 #endif
 
-#ifdef CONFIG_64BIT
-
-EOF
-
-grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
-done
-
-cat <<EOF
-#else /* CONFIG_64BIT */
-
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" ${args}
 done
 
 cat <<EOF
-#endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
 EOF
