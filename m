Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329D721EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFEHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEHBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:01:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5585110;
        Mon,  5 Jun 2023 00:01:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DAAAD75;
        Mon,  5 Jun 2023 00:02:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EEF23F793;
        Mon,  5 Jun 2023 00:01:42 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: [PATCH v2 05/27] locking/atomic: arc: add preprocessor symbols
Date:   Mon,  5 Jun 2023 08:01:02 +0100
Message-Id: <20230605070124.3741859-6-mark.rutland@arm.com>
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

Add the required definitions to arch/arc.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arc/include/asm/atomic-spinlock.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arc/include/asm/atomic-spinlock.h b/arch/arc/include/asm/atomic-spinlock.h
index 2c830347bfb4e..89d12a60f84c0 100644
--- a/arch/arc/include/asm/atomic-spinlock.h
+++ b/arch/arc/include/asm/atomic-spinlock.h
@@ -81,6 +81,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_sub_return		arch_atomic_sub_return
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
@@ -92,7 +97,11 @@ ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
 
 #define arch_atomic_andnot		arch_atomic_andnot
+
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
 #define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
 
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
-- 
2.30.2

