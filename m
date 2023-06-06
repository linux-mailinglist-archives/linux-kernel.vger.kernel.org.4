Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B69723BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbjFFI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbjFFI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE31E69;
        Tue,  6 Jun 2023 01:26:27 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JrGBfnWCtaPtwV9oJHvceCXs8q0mXOHU/60PMsg8uM=;
        b=TBBkWK+5HqZJD3Cm3VBRPoVFUSiu0G5amQddD1y0S1GUTTAa7JTpzzjm07KeHVWc2IH42w
        SavI2YbqHpxg3B6QxI6xaef1GdCjavplIKeHJC2lz0l4d5GaDZBepuDGd5FFE1iqYcnT2k
        i5sF1xjAgFvrbbLwREwLmoldlQ9IJvurSEaLXEPVV5+OaCGQldItLZEmsqdSZPMdzARZGp
        sNndoUZCYmujVI4jg5RT7CH5UFI4k3y0VgTBCqy2ZI7WBFLiNf4ZKT35Y1vvF74II8GVTR
        sSMFS9Ky1jtlKDz1To+oUHeXY5fDj0mSeAr/ncF1yEBr0w6ffKe4+4WhF9aTPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JrGBfnWCtaPtwV9oJHvceCXs8q0mXOHU/60PMsg8uM=;
        b=Xv2ZqEhmpDVB3OgOLqtc9DJGDg6pYSP3FdbLN3WxSSGIpw/oCnDJWYbjKzAPxr6gMrSelM
        gNRplaS0DkoxWHAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: parisc: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-10-mark.rutland@arm.com>
References: <20230605070124.3741859-10-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998287.404.11765785706099830595.tip-bot2@tip-bot2>
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

Commit-ID:     07bf3dcbe0e199422598f12918021c516161fd12
Gitweb:        https://git.kernel.org/tip/07bf3dcbe0e199422598f12918021c516161fd12
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:16 +02:00

locking/atomic: parisc: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/parisc.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-10-mark.rutland@arm.com
---
 arch/parisc/include/asm/atomic.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 0b3f64c..d4f0238 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -118,6 +118,11 @@ static __inline__ int arch_atomic_fetch_##op(int i, atomic_t *v)	\
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
@@ -127,6 +132,10 @@ ATOMIC_OPS(and, &=)
 ATOMIC_OPS(or, |=)
 ATOMIC_OPS(xor, ^=)
 
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
@@ -181,6 +190,11 @@ static __inline__ s64 arch_atomic64_fetch_##op(s64 i, atomic64_t *v)	\
 ATOMIC64_OPS(add, +=)
 ATOMIC64_OPS(sub, -=)
 
+#define arch_atomic64_add_return	arch_atomic64_add_return
+#define arch_atomic64_sub_return	arch_atomic64_sub_return
+#define arch_atomic64_fetch_add		arch_atomic64_fetch_add
+#define arch_atomic64_fetch_sub		arch_atomic64_fetch_sub
+
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
@@ -190,6 +204,10 @@ ATOMIC64_OPS(and, &=)
 ATOMIC64_OPS(or, |=)
 ATOMIC64_OPS(xor, ^=)
 
+#define arch_atomic64_fetch_and		arch_atomic64_fetch_and
+#define arch_atomic64_fetch_or		arch_atomic64_fetch_or
+#define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
