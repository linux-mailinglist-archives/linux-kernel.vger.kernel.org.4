Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19971723BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjFFI1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjFFI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D5E6A;
        Tue,  6 Jun 2023 01:26:27 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoWRNjEC8b88vYCwf6jdo+1vsVv3EQG+11tseF6XQ8A=;
        b=2iC1u3USQKis14ujknjnJ3aJREaQ62iPvJBAvlben6nUpHSPnee8Tyc0yU3S6PjZkok9YW
        srRHYcxz3r4X7e39sB5h1sCIOU5mbugusKc5JVApAFm0sxJ++taVejQElJuqLPXer4kvM/
        yl6n7f9J/M4UPA6cyAIyStqJbx1kOnE/mzj7SrVv1rTINrb9YdZcTUBBWPcSVrDqOSWwe3
        LwJNdAGCtaCXuE3jjKa5skQc2U218aTVgDY0f5jE09P6f7xekVBrjUZ3da2F0o5g0gojkZ
        nBNeDRC23c5VYNy7InOg/3wqpQqQHjCAZ/RLHoEOawniDQ7vt9QVB+jeVUCjzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoWRNjEC8b88vYCwf6jdo+1vsVv3EQG+11tseF6XQ8A=;
        b=1agxxeaQdL7iw1+gI9nAJQH4LiMNUqkeGK+AXYSV720IaSdmZH0qoALUL+Lyi8bXv1fc8p
        iRenKF34nomAbPAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: sh: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-11-mark.rutland@arm.com>
References: <20230605070124.3741859-11-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998249.404.992028948986196499.tip-bot2@tip-bot2>
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

Commit-ID:     770345adc38485c688e5d832d82306a4c2da828c
Gitweb:        https://git.kernel.org/tip/770345adc38485c688e5d832d82306a4c2da828c
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:16 +02:00

locking/atomic: sh: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/sh.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-11-mark.rutland@arm.com
---
 arch/sh/include/asm/atomic-grb.h  |  9 +++++++++
 arch/sh/include/asm/atomic-irq.h  |  9 +++++++++
 arch/sh/include/asm/atomic-llsc.h |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/sh/include/asm/atomic-grb.h b/arch/sh/include/asm/atomic-grb.h
index 059791f..cf1c10f 100644
--- a/arch/sh/include/asm/atomic-grb.h
+++ b/arch/sh/include/asm/atomic-grb.h
@@ -71,6 +71,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define arch_atomic_add_return	arch_atomic_add_return
+#define arch_atomic_sub_return	arch_atomic_sub_return
+#define arch_atomic_fetch_add	arch_atomic_fetch_add
+#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
@@ -78,6 +83,10 @@ ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
 
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
diff --git a/arch/sh/include/asm/atomic-irq.h b/arch/sh/include/asm/atomic-irq.h
index 7665de9..b4090cc 100644
--- a/arch/sh/include/asm/atomic-irq.h
+++ b/arch/sh/include/asm/atomic-irq.h
@@ -55,6 +55,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
 
+#define arch_atomic_add_return	arch_atomic_add_return
+#define arch_atomic_sub_return	arch_atomic_sub_return
+#define arch_atomic_fetch_add	arch_atomic_fetch_add
+#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op)						\
 	ATOMIC_OP(op, c_op)						\
@@ -64,6 +69,10 @@ ATOMIC_OPS(and, &=)
 ATOMIC_OPS(or, |=)
 ATOMIC_OPS(xor, ^=)
 
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
diff --git a/arch/sh/include/asm/atomic-llsc.h b/arch/sh/include/asm/atomic-llsc.h
index b63dcfb..9ef1fb1 100644
--- a/arch/sh/include/asm/atomic-llsc.h
+++ b/arch/sh/include/asm/atomic-llsc.h
@@ -73,6 +73,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define arch_atomic_add_return	arch_atomic_add_return
+#define arch_atomic_sub_return	arch_atomic_sub_return
+#define arch_atomic_fetch_add	arch_atomic_fetch_add
+#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
@@ -80,6 +85,10 @@ ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
 
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
