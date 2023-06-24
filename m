Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D336573CACF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjFXMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjFXMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:21:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD212120
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3127e67842aso423854f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609258; x=1690201258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0yKSEPQ2uBWE2LY+saIm//xFx7HrBCHNyL34cp2oHM=;
        b=QeZjgJfhQJvqZvx1t1IeWYsbwQNI5QY0nY+n+6iuKprKzqPPDhqAlCK/X8MXw9lllM
         MF7MJUd3AyF6NLExmFN2tqOyKJxGXQ5A620LqDfFp1F1MgWOF2XqUr8EUczC4R2MWmPT
         FPV9ONEJm4zSLcf0xZlhrZVG+xsG//PTKyBEZCr7/8dLR1hNjsmbGDUqGsh9vM21Svm7
         dAy7RyMU7SrYkSqPju5iD/CqEc/7iiUHvgjZoAQEvI82vuQl+FYI2+3r31+PjQUdTX5Y
         sjL2IQB9LnUMnP7pvvD/q1oELJQNwk2RV0RkSmIPwXN9cWyi2KhZGSAxqRLH8HJDsVlQ
         TIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609258; x=1690201258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0yKSEPQ2uBWE2LY+saIm//xFx7HrBCHNyL34cp2oHM=;
        b=azzY2eHCbZ5KyIxz64ltg/XusQKUbwYAQL+/iw8Br/paVCyFVSEthXk3LODkY0UrI0
         8fFPim986niFeLVJrsCRodZ6AN28Z5WHzAU2+W7O9jL4cGm2Bf2mI/5BWcwk1nIrtJMW
         rt9fGqJiPVvXKtx6w9oKVuGxS1FVz3Q3LOtwPrJejwivcdPziAmzBYbdgWJMulv9s38K
         mEIVw9jxm7MOnayhQRKOF2BE2znlDJiqgA38kFVJtDf6Kr1vuADmziDWNfizTCOSRBdb
         P5aQzE6OmHxupJQe3LovbJP0d5yEJGWMcn/ZL3d12W3X+ZR3+7JiUAc0VUJ36v+9pS37
         wIow==
X-Gm-Message-State: AC+VfDzxyDbwYLwhnkqBjZRhzBdS6WvGtIXDZCmk0OvxOFPrmbbZPe8d
        ZT0RwPzXMQmjnN3AbvHItmo/Nw==
X-Google-Smtp-Source: ACHHUZ4ou5+mAhAZf0neB/pEp/lFSTloYGI60h/0wpB1djUbSRRuQtMMLGSiDbhu49FUgBf4zF50Sg==
X-Received: by 2002:adf:fdc8:0:b0:313:e3a8:b477 with SMTP id i8-20020adffdc8000000b00313e3a8b477mr1055898wrs.2.1687609258116;
        Sat, 24 Jun 2023 05:20:58 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:20:57 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/6] riscv: add support for misaligned handling in S-mode
Date:   Sat, 24 Jun 2023 14:20:45 +0200
Message-Id: <20230624122049.7886-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230624122049.7886-1-cleger@rivosinc.com>
References: <20230624122049.7886-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misalignment handling is only supported for M-mode and uses direct
accesses to user memory. in S-mode, this requires to use the
get_user()/put_user() accessors. Implement load_u8(), store_u8() and
get_insn() using these accessors. Also, use CSR_TVAL instead of
hardcoded mtval in csr_read() call which will work for both S-mode and
M-mode. When used in S-mode, we do not handle misaligned accesses that
are triggered from kernel mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/Makefile           |   2 +-
 arch/riscv/kernel/traps_misaligned.c | 111 +++++++++++++++++++++++----
 2 files changed, 99 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 153864e4f399..61bad09280a6 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -56,9 +56,9 @@ obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
 obj-y	+= probes/
+obj-y	+= traps_misaligned.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index e7bfb33089c1..e4a273ab77c9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/bug.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -151,21 +152,25 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-static inline u8 load_u8(const u8 *addr)
+#ifdef CONFIG_RISCV_M_MODE
+static inline int load_u8(const u8 *addr, u8 *r_val)
 {
 	u8 val;
 
 	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
+	*r_val = val;
 
-	return val;
+	return 0;
 }
 
-static inline void store_u8(u8 *addr, u8 val)
+static inline int store_u8(u8 *addr, u8 val)
 {
 	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
+
+	return 0;
 }
 
-static inline ulong get_insn(ulong mepc)
+static inline int get_insn(ulong mepc, ulong *r_insn)
 {
 	register ulong __mepc asm ("a2") = mepc;
 	ulong val, rvc_mask = 3, tmp;
@@ -194,9 +199,63 @@ static inline ulong get_insn(ulong mepc)
 	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
 	  [xlen_minus_16] "i" (XLEN_MINUS_16));
 
-	return val;
+	*r_insn = val;
+
+	return 0;
+}
+#else
+static inline int load_u8(const u8 *addr, u8 *r_val)
+{
+	return __get_user(*r_val, addr);
+}
+
+static inline int store_u8(u8 *addr, u8 val)
+{
+	return __put_user(val, addr);
 }
 
+static inline int get_insn(ulong mepc, ulong *r_insn)
+{
+	ulong insn = 0;
+
+	if (mepc & 0x2) {
+		ulong tmp = 0;
+		u16 __user *insn_addr = (u16 __user *)mepc;
+
+		if (__get_user(insn, insn_addr))
+			return -EFAULT;
+		/* __get_user() uses regular "lw" which sign extend the loaded
+		 * value make sure to clear higher order bits in case we "or" it
+		 * below with the upper 16 bits half.
+		 */
+		insn &= GENMASK(15, 0);
+		if ((insn & __INSN_LENGTH_MASK) != __INSN_LENGTH_32) {
+			*r_insn = insn;
+			return 0;
+		}
+		insn_addr++;
+		if (__get_user(tmp, insn_addr))
+			return -EFAULT;
+		*r_insn = (tmp << 16) | insn;
+
+		return 0;
+	} else {
+		u32 __user *insn_addr = (u32 __user *)mepc;
+
+		if (__get_user(insn, insn_addr))
+			return -EFAULT;
+		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
+			*r_insn = insn;
+			return 0;
+		}
+		insn &= GENMASK(15, 0);
+		*r_insn = insn;
+
+		return 0;
+	}
+}
+#endif
+
 union reg_data {
 	u8 data_bytes[8];
 	ulong data_ulong;
@@ -207,10 +266,21 @@ int handle_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
-	unsigned long insn = get_insn(epc);
-	unsigned long addr = csr_read(mtval);
+	unsigned long insn;
+	unsigned long addr;
 	int i, fp = 0, shift = 0, len = 0;
 
+	/*
+	 * When running in supervisor mode, we only handle misaligned accesses
+	 * triggered from user mode.
+	 */
+	if (!IS_ENABLED(CONFIG_RISCV_M_MODE) && !user_mode(regs))
+		return -1;
+
+	if (get_insn(epc, &insn))
+		return -1;
+
+	addr = csr_read(CSR_TVAL);
 	regs->epc = 0;
 
 	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
@@ -274,8 +344,10 @@ int handle_misaligned_load(struct pt_regs *regs)
 	}
 
 	val.data_u64 = 0;
-	for (i = 0; i < len; i++)
-		val.data_bytes[i] = load_u8((void *)(addr + i));
+	for (i = 0; i < len; i++) {
+		if (load_u8((void *)(addr + i), &val.data_bytes[i]))
+			return -1;
+	}
 
 	if (fp)
 		return -1;
@@ -290,10 +362,21 @@ int handle_misaligned_store(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
-	unsigned long insn = get_insn(epc);
-	unsigned long addr = csr_read(mtval);
+	unsigned long insn;
+	unsigned long addr;
 	int i, len = 0;
 
+	/*
+	 * When running in supervisor mode, we only handle misaligned accesses
+	 * triggered from user mode.
+	 */
+	if (!IS_ENABLED(CONFIG_RISCV_M_MODE) && !user_mode(regs))
+		return -1;
+
+	if (get_insn(epc, &insn))
+		return -1;
+
+	addr = csr_read(CSR_TVAL);
 	regs->epc = 0;
 
 	val.data_ulong = GET_RS2(insn, regs);
@@ -327,8 +410,10 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -1;
 	}
 
-	for (i = 0; i < len; i++)
-		store_u8((void *)(addr + i), val.data_bytes[i]);
+	for (i = 0; i < len; i++) {
+		if (store_u8((void *)(addr + i), val.data_bytes[i]))
+			return -1;
+	}
 
 	regs->epc = epc + INSN_LEN(insn);
 
-- 
2.40.1

