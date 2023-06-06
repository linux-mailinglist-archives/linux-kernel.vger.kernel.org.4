Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CAA723BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjFFI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjFFI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79710C3;
        Tue,  6 Jun 2023 01:26:30 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039986;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29+esfnvsdOBpeLiQV0gDCNQTDxDM2VeZ1Z9IIVrwzk=;
        b=cqDF7HJ59YhuvJq6RVmezYTW6lfNREhxOdxZfgtTcbqL5AjeJqgX3ExxerQhtaVYnUNhyP
        Wtc9A7uEPLwiQgAaJbKlVnFgvDcUkkKL2Tlw6gH0sSurDIO6skSQe+74BuSk6iwzTxkZAP
        /yAtrQOewpDuvItm7M/mAcI0JvC8g6D/HAB0glJCKKuK5ZKTl6EVdprgNWbxuOcqPa7l+b
        kN2aZE9K91Z0WgTQhkPFbxD/E6rpS2UjhWNqnZoUKl5GbQHKGF8q09nBJ7a6H93OuTHrqC
        xNERaCGcU23Y9P1ZseCwpEwPDjA3EIQP2WlZW8UwPGK/Z+MFYJheUhbkGjslWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039986;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29+esfnvsdOBpeLiQV0gDCNQTDxDM2VeZ1Z9IIVrwzk=;
        b=QQux8DkDOP2BWK0gQmDM6earkSoKRj4omlSf7QYhcMmgRL9zlzmIjEHpGrPqsdo+6jA1px
        VOUZw9Yhu78JIRCg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: arm: fix sync ops
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-2-mark.rutland@arm.com>
References: <20230605070124.3741859-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998596.404.7337206136512798108.tip-bot2@tip-bot2>
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

Commit-ID:     dda5f312bb09e56e7a1c3e3851f2000eb2e9c879
Gitweb:        https://git.kernel.org/tip/dda5f312bb09e56e7a1c3e3851f2000eb2e9c879
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:00:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:13 +02:00

locking/atomic: arm: fix sync ops

The sync_*() ops on arch/arm are defined in terms of the regular bitops
with no special handling. This is not correct, as UP kernels elide
barriers for the fully-ordered operations, and so the required ordering
is lost when such UP kernels are run under a hypervsior on an SMP
system.

Fix this by defining sync ops with the required barriers.

Note: On 32-bit arm, the sync_*() ops are currently only used by Xen,
which requires ARMv7, but the semantics can be implemented for ARMv6+.

Fixes: e54d2f61528165bb ("xen/arm: sync_bitops")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-2-mark.rutland@arm.com
---
 arch/arm/include/asm/assembler.h   | 17 +++++++++++++++++-
 arch/arm/include/asm/sync_bitops.h | 29 +++++++++++++++++++++++++----
 arch/arm/lib/bitops.h              | 14 +++++++++++---
 arch/arm/lib/testchangebit.S       |  4 ++++-
 arch/arm/lib/testclearbit.S        |  4 ++++-
 arch/arm/lib/testsetbit.S          |  4 ++++-
 6 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 505a306..aebe2c8 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -394,6 +394,23 @@ ALT_UP_B(.L0_\@)
 #endif
 	.endm
 
+/*
+ * Raw SMP data memory barrier
+ */
+	.macro	__smp_dmb mode
+#if __LINUX_ARM_ARCH__ >= 7
+	.ifeqs "\mode","arm"
+	dmb	ish
+	.else
+	W(dmb)	ish
+	.endif
+#elif __LINUX_ARM_ARCH__ == 6
+	mcr	p15, 0, r0, c7, c10, 5	@ dmb
+#else
+	.error "Incompatible SMP platform"
+#endif
+	.endm
+
 #if defined(CONFIG_CPU_V7M)
 	/*
 	 * setmode is used to assert to be in svc mode during boot. For v7-M
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 6f5d627..f46b3c5 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -14,14 +14,35 @@
  * ops which are SMP safe even on a UP kernel.
  */
 
+/*
+ * Unordered
+ */
+
 #define sync_set_bit(nr, p)		_set_bit(nr, p)
 #define sync_clear_bit(nr, p)		_clear_bit(nr, p)
 #define sync_change_bit(nr, p)		_change_bit(nr, p)
-#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
-#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
-#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define arch_sync_cmpxchg		arch_cmpxchg
 
+/*
+ * Fully ordered
+ */
+
+int _sync_test_and_set_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_set_bit(nr, p)	_sync_test_and_set_bit(nr, p)
+
+int _sync_test_and_clear_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_clear_bit(nr, p)	_sync_test_and_clear_bit(nr, p)
+
+int _sync_test_and_change_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_change_bit(nr, p)	_sync_test_and_change_bit(nr, p)
+
+#define arch_sync_cmpxchg(ptr, old, new)				\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__smp_mb__before_atomic();					\
+	__ret = arch_cmpxchg_relaxed((ptr), (old), (new));		\
+	__smp_mb__after_atomic();					\
+	__ret;								\
+})
 
 #endif
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 95bd359..f069d1b 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -28,7 +28,7 @@ UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
 
-	.macro	testop, name, instr, store
+	.macro	__testop, name, instr, store, barrier
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
@@ -38,7 +38,7 @@ UNWIND(	.fnstart	)
 	mov	r0, r0, lsr #5
 	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3		@ create mask
-	smp_dmb
+	\barrier
 #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 	.arch_extension	mp
 	ALT_SMP(W(pldw)	[r1])
@@ -50,13 +50,21 @@ UNWIND(	.fnstart	)
 	strex	ip, r2, [r1]
 	cmp	ip, #0
 	bne	1b
-	smp_dmb
+	\barrier
 	cmp	r0, #0
 	movne	r0, #1
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
+
+	.macro	testop, name, instr, store
+	__testop \name, \instr, \store, smp_dmb
+	.endm
+
+	.macro	sync_testop, name, instr, store
+	__testop \name, \instr, \store, __smp_dmb
+	.endm
 #else
 	.macro	bitop, name, instr
 ENTRY(	\name		)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4ebecc6..f13fe9b 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_change_bit, eor, str
+#endif
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 009afa0..4d2c5ca 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_clear_bit, bicne, strne
+#endif
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index f3192e5..649dbab 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_set_bit, orreq, streq
+#endif
