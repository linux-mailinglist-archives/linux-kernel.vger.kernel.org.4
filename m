Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0570ADF8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjEULua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjEULt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:49:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9DE10F0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:47:20 -0700 (PDT)
Received: from ip5b412278.dynamic.kabel-deutschland.de ([91.65.34.120] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q0hWv-0008T6-9y; Sun, 21 May 2023 13:47:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, christoph.muellner@vrull.eu,
        David.Laight@ACULAB.COM, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v3 2/2] riscv: Add Zawrs support for spinlocks
Date:   Sun, 21 May 2023 13:47:15 +0200
Message-Id: <20230521114715.955823-3-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

The current RISC-V code uses the generic ticket lock implementation,
that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
Currently, RISC-V uses the generic implementation of these macros.
This patch introduces a RISC-V specific implementation, of these
macros, that peels off the first loop iteration and modifies the waiting
loop such, that it is possible to use the WRS.STO instruction of the Zawrs
ISA extension to stall the CPU.

The resulting implementation of smp_cond_load_*() will only work for
32-bit or 64-bit types for RV64 and 32-bit types for RV32.
This is caused by the restrictions of the LR instruction (RISC-V only
has LR.W and LR.D). Compiler assertions guard this new restriction.

This patch uses the existing RISC-V ISA extension framework
to detect the presence of Zawrs at run-time.
If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.

The whole mechanism is gated by Kconfig setting, which defaults to Y.

The Zawrs specification can be found here:
https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
[rebase, update to review comments]
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/Kconfig                   | 10 +++++
 arch/riscv/include/asm/barrier.h     | 64 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/errata_list.h | 14 ++++++
 arch/riscv/include/asm/hwcap.h       |  1 +
 arch/riscv/kernel/cpu.c              |  1 +
 arch/riscv/kernel/cpufeature.c       |  1 +
 6 files changed, 91 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..60ff303ff58a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -460,6 +460,16 @@ config RISCV_ISA_SVPBMT
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZAWRS
+	bool "Zawrs extension support"
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the Zawrs extension
+	   (wait for reservation set) and enable its usage.
+
+	   If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 110752594228..bd64cfe5ae10 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -12,6 +12,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/errata_list.h>
+
 #define nop()		__asm__ __volatile__ ("nop")
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		__asm__ __volatile__ (__nops(n))
@@ -44,6 +46,36 @@ do {									\
 	___p1;								\
 })
 
+#define ___smp_load_reservedN(pfx, ptr)					\
+({									\
+	typeof(*ptr) ___p1;						\
+	__asm__ __volatile__ ("lr." pfx "	%[p], %[c]\n"		\
+			      : [p]"=&r" (___p1), [c]"+A"(*ptr));	\
+	___p1;								\
+})
+
+#define __smp_load_reserved_relaxed(ptr)				\
+({									\
+	typeof(*ptr) ___p1;						\
+	if (sizeof(*ptr) == sizeof(int))				\
+		___p1 = ___smp_load_reservedN("w", ptr);		\
+	else if (sizeof(*ptr) == sizeof(long))				\
+		___p1 = ___smp_load_reservedN("d", ptr);		\
+	else								\
+		compiletime_assert(0,					\
+			"Need type compatible with LR/SC instructions "	\
+			"for " __stringify(ptr));			\
+	___p1;								\
+})
+
+#define __smp_load_reserved_acquire(ptr)				\
+({									\
+	typeof(*ptr) ___p1;						\
+	___p1 = __smp_load_reserved_relaxed(ptr);			\
+	RISCV_FENCE(r, rw);						\
+	___p1;								\
+})
+
 /*
  * This is a very specific barrier: it's currently only used in two places in
  * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
@@ -71,6 +103,38 @@ do {									\
  */
 #define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
 
+#define smp_cond_load_relaxed(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	VAL = READ_ONCE(*__PTR);					\
+	if (!cond_expr) {						\
+		for (;;) {						\
+			VAL = __smp_load_reserved_relaxed(__PTR);	\
+			if (cond_expr)					\
+				break;					\
+			ALT_WRS_STO();					\
+		}							\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define smp_cond_load_acquire(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	VAL = smp_load_acquire(__PTR);					\
+	if (!cond_expr) {						\
+		for (;;) {						\
+			VAL = __smp_load_reserved_acquire(__PTR);	\
+			if (cond_expr)					\
+				break;					\
+			ALT_WRS_STO();					\
+		}							\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index fb1a810f3d8c..36a72a07d62c 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -44,6 +44,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+#define ZAWRS_WRS_NTO	".long 0x00d00073"
+#define ALT_WRS_NTO()							\
+asm volatile(ALTERNATIVE(						\
+	"nop\n\t",							\
+	ZAWRS_WRS_NTO "\n\t",						\
+	0, RISCV_ISA_EXT_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
+
+#define ZAWRS_WRS_STO	".long 0x01d00073"
+#define ALT_WRS_STO()							\
+asm volatile(ALTERNATIVE(						\
+	"nop\n\t",							\
+	ZAWRS_WRS_STO "\n\t",						\
+	0, RISCV_ISA_EXT_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e0c40a4c63d5..4233d87539ab 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -46,6 +46,7 @@
 #define RISCV_ISA_EXT_ZICBOZ		34
 #define RISCV_ISA_EXT_SMAIA		35
 #define RISCV_ISA_EXT_SSAIA		36
+#define RISCV_ISA_EXT_ZAWRS		37
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index c96aa56cf1c7..ac9c604d8936 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -184,6 +184,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
+	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1d6b7e4b829..d4a22a7aed99 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -236,6 +236,7 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zawrs", RISCV_ISA_EXT_ZAWRS);
 				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
-- 
2.39.0

