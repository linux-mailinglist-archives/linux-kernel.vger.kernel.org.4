Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F586F237A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbjD2HDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjD2HDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:03:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB762D4A;
        Sat, 29 Apr 2023 00:03:07 -0700 (PDT)
Date:   Sat, 29 Apr 2023 07:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682751786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3mrM/QJ2Lg/FRiU9STvHmaare2Exqy7ouwgCM7hNFY=;
        b=y79ujX+sh0wJM+1tCjZcSeF+5rlUcIV35ATJMH05jlHBil8c6ls7V0vOLDGzvuNezjVrRq
        qlfT6uOkZweqjkvHNhopOyH3mCeUQlfkPAd5gN51bU+yGHY/QmOiJdZu6yeJI41/CC8yI6
        ZdnDnHZfRUFf/Zo9g3VxbSTPq3Nxi1K4LD1Ai74cOPzbVbpo9YDavfMOd6mpJIdUIHmRnz
        oqN+lMkpud63BsEaygjc46HEGhhwTyQHE7chfgHxl0xq2UKrG7KfC6OMSsPTrJVE0Lw4tw
        nGy/Uw794LUTrMuSptMKxzrh1jTByz/C6D3KABLmSu9RIv1CfNaySwxlI6+cDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682751786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3mrM/QJ2Lg/FRiU9STvHmaare2Exqy7ouwgCM7hNFY=;
        b=CV7f3DxeSRd9/mosiUBEuA+aSb/WVSsavluVefXIr5VjybFoSMBLiKKOZjKnLNKyKeLG8n
        csuHxtLfyM3kKSAw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: Add generic
 try_cmpxchg{,64}_local() support
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230405141710.3551-2-ubizjak@gmail.com>
References: <20230405141710.3551-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168275178570.404.10146871888315087834.tip-bot2@tip-bot2>
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

Commit-ID:     cd6637248298aca6f9f7df489e73baa727409210
Gitweb:        https://git.kernel.org/tip/cd6637248298aca6f9f7df489e73baa727409210
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Apr 2023 16:17:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 29 Apr 2023 08:51:55 +02:00

locking/atomic: Add generic try_cmpxchg{,64}_local() support

Add generic support for try_cmpxchg{,64}_local() and their falbacks.

These provides the generic try_cmpxchg_local family of functions
from the arch_ prefixed version, also adding explicit instrumentation.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230405141710.3551-2-ubizjak@gmail.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 24 +++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  | 20 ++++++++++++++++-
 scripts/atomic/gen-atomic-fallback.sh       |  4 +++-
 scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 4226379..a6e4437 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -217,6 +217,28 @@
 
 #endif /* arch_try_cmpxchg64_relaxed */
 
+#ifndef arch_try_cmpxchg_local
+#define arch_try_cmpxchg_local(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_local((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_local */
+
+#ifndef arch_try_cmpxchg64_local
+#define arch_try_cmpxchg64_local(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg64_local((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg64_local */
+
 #ifndef arch_atomic_read_acquire
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
@@ -2646,4 +2668,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 00071fffa021cec66f6290d706d69c91df87bade
+// ad2e2b4d168dbc60a73922616047a9bfa446af36
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 0496816..245ba66 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -2132,6 +2132,24 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
+#define try_cmpxchg_local(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg64_local(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
 #define cmpxchg_double(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2149,4 +2167,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 1b485de9cbaa4900de59e14ee2084357eaeb1c3a
+// 97fe4d79aa058d2164df824632cbc4f716d2a407
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 3a07695..6e853f0 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -225,6 +225,10 @@ for cmpxchg in "cmpxchg" "cmpxchg64"; do
 	gen_try_cmpxchg_fallbacks "${cmpxchg}"
 done
 
+for cmpxchg in "cmpxchg_local" "cmpxchg64_local"; do
+	gen_try_cmpxchg_fallback "${cmpxchg}" ""
+done
+
 grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
 done
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 77c0652..c8165e9 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -173,7 +173,7 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
+for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" ; do
 	gen_xchg "${xchg}" "" ""
 	printf "\n"
 done
