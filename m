Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32A6721EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjFEHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFEHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:02:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64B5CE51;
        Mon,  5 Jun 2023 00:01:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D111596;
        Mon,  5 Jun 2023 00:02:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33D4B3F793;
        Mon,  5 Jun 2023 00:01:54 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: [PATCH v2 09/27] locking/atomic: parisc: add preprocessor symbols
Date:   Mon,  5 Jun 2023 08:01:06 +0100
Message-Id: <20230605070124.3741859-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605070124.3741859-1-mark.rutland@arm.com>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/parisc/include/asm/atomic.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 0b3f64c92e3c0..d4f023887ff87 100644
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
-- 
2.30.2

