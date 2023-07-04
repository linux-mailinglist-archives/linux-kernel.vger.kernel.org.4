Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4B7473BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGDOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGDOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:10:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808910C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:10:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7e0904a3aso6748235ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479843; x=1691071843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjQ2GzX04kf0h9GMnyJoWtp+hj7mtUQd1bUdoSwTimI=;
        b=2D84fmx8ldK1bX2AURYX4UfCnJ8PND8qZqnODVLh1ZPtRExDeFgT6muDDtq5fo/me2
         KM1xs6xcI8E5R8wpwRry3UPICUkVmfPp7feQ8W3knFgty1UqbENYodnh+uSqomp6hSK/
         llhsZvbc5a0wePJY30HYr9hdfkC7deKJnxNX2zz14X5NlnZiYftro2CpaOfbOBe1WOg5
         D0s4qCelN8Q0YU8DHTKypQpN0thdgEyP+XhR0rEhDR1CqUNLK3GMZIObn5oNXJI61nDY
         zxXuY0BDhzq6PSX5LXN1sR/84VrWV47u5iKDQPLpW1iNLfTgo46+OrYFBY6Da+ETpsbj
         g3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479843; x=1691071843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjQ2GzX04kf0h9GMnyJoWtp+hj7mtUQd1bUdoSwTimI=;
        b=Bvw99NvNzg/UnBx0HscSh1ROQwVrmBNFqeL1AU7OptTo604gUuG7cBzSVGFPMAywW0
         wXG5zGRjs4NW0f1ay0zzxwDGkl/Otnft7pYhT1GTStRPGPuqNK+IhOYUNe8NR2w7JjmF
         q3+3upQL/TJELurKGfFFVG0KG+ZZD17qWv7bLKrapuAOMNx41TmAGNDDq1SbH7tGVwYJ
         HEJHhi/Y2dnkNe/zk+TfPKxCBI/xMbYh2CrVb24lnb1sYH1mX0QnEcSPrCJZmX05146v
         ylJlWBnxZV6+nqI2nk6TUuK8l2TTIiJ8YTwNxm5RML4j3KbyRgoOibU88V7ZgBfcOyg6
         j/SA==
X-Gm-Message-State: ABy/qLb8iw81sheaJVSvoQ8WU2yxnMaJ6scMxhHd3dyPG9AYoIBB1E2K
        I+A632c+uUdE0mfMOn7cIjEFYQ==
X-Google-Smtp-Source: APBJJlHtqmN+8FBUFiHr/OGtEU+mlJXelWyy/CZVQGAvVawGZmoodlwRJaLU0Rd2kUcdu8kdGt9NRw==
X-Received: by 2002:a17:902:720c:b0:1ae:3ff8:7fa7 with SMTP id ba12-20020a170902720c00b001ae3ff87fa7mr13945198plb.4.1688479842532;
        Tue, 04 Jul 2023 07:10:42 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:10:41 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 PATCH 3/9] riscv: add support for misaligned handling in S-mode
Date:   Tue,  4 Jul 2023 16:09:18 +0200
Message-Id: <20230704140924.315594-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704140924.315594-1-cleger@rivosinc.com>
References: <20230704140924.315594-1-cleger@rivosinc.com>
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
get_insn() using these accessors.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/Makefile           |   2 +-
 arch/riscv/kernel/traps.c            |   7 --
 arch/riscv/kernel/traps_misaligned.c | 118 ++++++++++++++++++++++++---
 3 files changed, 106 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 153864e4f399..79b8dafc699d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -55,10 +55,10 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
+obj-y	+= traps_misaligned.o
 obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 7fcaf2fd27a1..b2fb2266fb83 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -149,12 +149,6 @@ DO_ERROR_INFO(do_trap_insn_illegal,
 	SIGILL, ILL_ILLOPC, "illegal instruction");
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
-#ifndef CONFIG_RISCV_M_MODE
-DO_ERROR_INFO(do_trap_load_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
-DO_ERROR_INFO(do_trap_store_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
-#else
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
@@ -197,7 +191,6 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
 		irqentry_nmi_exit(regs, state);
 	}
 }
-#endif
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
 DO_ERROR_INFO(do_trap_ecall_s,
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 0cccac4822a8..9daed7d756ae 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -152,21 +152,25 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-static inline u8 load_u8(const u8 *addr)
+#ifdef CONFIG_RISCV_M_MODE
+static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 {
 	u8 val;
 
 	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
+	*r_val = val;
 
-	return val;
+	return 0;
 }
 
-static inline void store_u8(u8 *addr, u8 val)
+static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
 {
 	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
+
+	return 0;
 }
 
-static inline ulong get_insn(ulong mepc)
+static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
 {
 	register ulong __mepc asm ("a2") = mepc;
 	ulong val, rvc_mask = 3, tmp;
@@ -195,9 +199,87 @@ static inline ulong get_insn(ulong mepc)
 	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
 	  [xlen_minus_16] "i" (XLEN_MINUS_16));
 
-	return val;
+	*r_insn = val;
+
+	return 0;
+}
+#else
+static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
+{
+	if (user_mode(regs)) {
+		return __get_user(*r_val, addr);
+	} else {
+		*r_val = *addr;
+		return 0;
+	}
 }
 
+static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
+{
+	if (user_mode(regs)) {
+		return __put_user(val, addr);
+	} else {
+		*addr = val;
+		return 0;
+	}
+}
+
+#define __read_insn(regs, insn, insn_addr)		\
+({							\
+	int __ret;					\
+							\
+	if (user_mode(regs)) {				\
+		__ret = __get_user(insn, insn_addr);	\
+	} else {					\
+		insn = *insn_addr;			\
+		__ret = 0;				\
+	}						\
+							\
+	__ret;						\
+})
+
+static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	ulong insn = 0;
+
+	if (epc & 0x2) {
+		ulong tmp = 0;
+		u16 __user *insn_addr = (u16 __user *)epc;
+
+		if (__read_insn(regs, insn, insn_addr))
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
+		if (__read_insn(regs, tmp, insn_addr))
+			return -EFAULT;
+		*r_insn = (tmp << 16) | insn;
+
+		return 0;
+	} else {
+		u32 __user *insn_addr = (u32 __user *)epc;
+
+		if (__read_insn(regs, insn, insn_addr))
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
@@ -208,10 +290,13 @@ int handle_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
-	unsigned long insn = get_insn(epc);
-	unsigned long addr = csr_read(mtval);
+	unsigned long insn;
+	unsigned long addr = regs->badaddr;
 	int i, fp = 0, shift = 0, len = 0;
 
+	if (get_insn(regs, epc, &insn))
+		return -1;
+
 	regs->epc = 0;
 
 	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
@@ -275,8 +360,10 @@ int handle_misaligned_load(struct pt_regs *regs)
 	}
 
 	val.data_u64 = 0;
-	for (i = 0; i < len; i++)
-		val.data_bytes[i] = load_u8((void *)(addr + i));
+	for (i = 0; i < len; i++) {
+		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
+			return -1;
+	}
 
 	if (fp)
 		return -1;
@@ -291,10 +378,13 @@ int handle_misaligned_store(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
-	unsigned long insn = get_insn(epc);
-	unsigned long addr = csr_read(mtval);
+	unsigned long insn;
+	unsigned long addr = regs->badaddr;
 	int i, len = 0;
 
+	if (get_insn(regs, epc, &insn))
+		return -1;
+
 	regs->epc = 0;
 
 	val.data_ulong = GET_RS2(insn, regs);
@@ -328,8 +418,10 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -1;
 	}
 
-	for (i = 0; i < len; i++)
-		store_u8((void *)(addr + i), val.data_bytes[i]);
+	for (i = 0; i < len; i++) {
+		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
+			return -1;
+	}
 
 	regs->epc = epc + INSN_LEN(insn);
 
-- 
2.40.1

