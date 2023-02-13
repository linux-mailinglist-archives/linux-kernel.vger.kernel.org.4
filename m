Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A16693D98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBMEy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBMEyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE9113F3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ja21so4709956plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWWHkk0uRmCoQD1IDjmpM1K4crsMB3GryXLB1Ck58mM=;
        b=FGjJdoMrQlppTBz+ObqT8luvhuIMwvfjvmkBZprc9HlYpoiSS1sA85FZnlrmeoeEgh
         SlSW2oU2EYk9KtAhXRm18M+PupNhB7PJwPtUNGXJcECNEGsnVdHApGyWg64SViYKipvg
         76A+vJJvWrYRsBqZ5NpIAB/yexvjeXKgZYZluduj2LNgSueMGYFoy6UM6NpAbW54+uJv
         n80E0ec86qo5fTn+m5TpVEbZlOl8oMoq1dQ3t1CAp93yrTxg3gz0bUQfZSAdBr3s/OIu
         sMljApBWJCh4QonvYNxSCj45B5bFELOws2WJg2kb2PQukm27+t6Rb1njgf4IzZonV0W+
         2nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWWHkk0uRmCoQD1IDjmpM1K4crsMB3GryXLB1Ck58mM=;
        b=z8c3Ws7UZQYgsoprZr7sRGvmsz8xar1c4/qm65Kbuk3BEN67qFGSECVhqw+1F60uR/
         Ftvpdg0/Jgh9YCT4MJUCTX2StzV3/3Uoj0zlaKkTsEP7EZBcXOx9KJJ0mWEsTvo+nJWB
         wdOXFg95MFY2WlaELt4SxUSyONRR59tYtweuiY3Ib0y0/LmWN/s18sqlCk6qH0Cx8gqd
         CV1sOYZBLk5jP50nqI/ElHJhNGQ4heEhG02IYlkprwrhgu1XDUsl0GMjrKaJS5RXion6
         qzPjxS3q0T0R7pwn6FXk23EE5lf+V5x/Zmh3cKsyKYcBndqyJOjMILN1xi0idnBejkQs
         2gog==
X-Gm-Message-State: AO0yUKWhwgqG1iZSol99yHeU3URlUNcKym31E7tZdgPd8FN6fR4r/eDm
        biJBSHKOqtTNFY19emI79/+q6SoQdrKjqbkO
X-Google-Smtp-Source: AK7set9406LLxtGzTMJ9GgnStCTat5aRGFN2npHB9cBHONwfu4URf5ZDmziYqqSaME7wnrSw88O6bA==
X-Received: by 2002:a17:903:2448:b0:198:f027:5925 with SMTP id l8-20020a170903244800b00198f0275925mr25005204pls.64.1676264055395;
        Sun, 12 Feb 2023 20:54:15 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:14 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 09/20] riscv mmu: riscv shadow stack page fault handling
Date:   Sun, 12 Feb 2023 20:53:38 -0800
Message-Id: <20230213045351.3945824-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow stack load/stores to valid non-shadow memory raise access faults.
Regular store to shadow stack memory raise access fault as well.

This patch implements load and store access handler. Load access handler
reads faulting instruction and if it was an instruction issuing ss load,
it'll invoke page fault handler with a synthetic cause (marked reserved
in priv spec).
Similarly store access hanlder reads faulting instruction and if it was
an instruction issuing ss store, it'll invoke page fault handler with a
synthetic cause (reserved in spec).

All other cases in load/store access handler will lead to SIGSEV.

There might be concerns that using a reserved exception code may create
an issue because some riscv implementation might already using this code.
However counter argument would be, linux kernel is not using this code
and thus linux kernel should be able to use this exception code on such
a hardware.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h |  3 ++
 arch/riscv/kernel/traps.c    | 99 ++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/fault.c        | 23 ++++++++-
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 243031d1d305..828b1c2a74c2 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -104,6 +104,9 @@
 #define EXC_SUPERVISOR_SYSCALL	10
 #define EXC_INST_PAGE_FAULT	12
 #define EXC_LOAD_PAGE_FAULT	13
+#ifdef CONFIG_USER_SHADOW_STACK
+#define EXC_SS_ACCESS_PAGE_FAULT	14
+#endif
 #define EXC_STORE_PAGE_FAULT	15
 #define EXC_INST_GUEST_PAGE_FAULT	20
 #define EXC_LOAD_GUEST_PAGE_FAULT	21
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 549bde5c970a..5553b8d48ba5 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -94,6 +94,85 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	}
 }
 
+/* Zisslpcfi instructions encodings */
+#define SS_PUSH_POP 0x81C04073
+#define SS_AMOSWAP  0x82004073
+
+bool is_ss_load_store_insn(unsigned long insn)
+{
+	if ((insn & SS_PUSH_POP) == SS_PUSH_POP)
+		return true;
+	/*
+	 * SS_AMOSWAP overlaps with LP_S_LL.
+	 * But LP_S_LL can never raise access fault
+	 */
+	if ((insn & SS_AMOSWAP) == SS_AMOSWAP)
+		return true;
+
+	return false;
+}
+
+ulong get_instruction(ulong epc)
+{
+	ulong *epc_ptr = (ulong *) epc;
+	ulong insn = 0;
+
+	__enable_user_access();
+	insn = *epc_ptr;
+	__disable_user_access();
+	return insn;
+}
+
+#ifdef CONFIG_USER_SHADOW_STACK
+extern asmlinkage void do_page_fault(struct pt_regs *regs);
+
+/*
+ * If CFI enabled then following then load access fault can occur if
+ * ssload (sspop/ssamoswap) happens on non-shadow stack memory.
+ * This is a valid case when we want to do COW on SS memory on `fork` or memory is swapped out.
+ * SS memory is marked as readonly and subsequent sspop or sspush will lead to
+ * load/store access fault. We need to decode instruction. If it's sspop or sspush
+ * Page fault handler is invoked.
+ */
+int handle_load_access_fault(struct pt_regs *regs)
+{
+	ulong insn = get_instruction(regs->epc);
+
+	if (is_ss_load_store_insn(insn)) {
+		regs->cause = EXC_SS_ACCESS_PAGE_FAULT;
+		do_page_fault(regs);
+		return 0;
+	}
+
+	return 1;
+}
+/*
+ * If CFI enabled then following then store access fault can occur if
+ * -- ssstore (sspush/ssamoswap) happens on non-shadow stack memory
+ * -- regular store happens on shadow stack memory
+ */
+int handle_store_access_fault(struct pt_regs *regs)
+{
+	ulong insn = get_instruction(regs->epc);
+
+	/*
+	* if a shadow stack store insn, change cause to
+	* synthetic SS_ACCESS_PAGE_FAULT
+	*/
+	if (is_ss_load_store_insn(insn)) {
+	        regs->cause = EXC_SS_ACCESS_PAGE_FAULT;
+	        do_page_fault(regs);
+	        return 0;
+	}
+	/*
+	 * Reaching here means it was a regular store.
+	 * A regular access fault anyways had been delivering SIGSEV
+	 * A regular store to shadow stack anyways is also a SIGSEV
+	 */
+	return 1;
+}
+#endif
+
 #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
 #define __trap_section		__section(".xip.traps")
 #else
@@ -113,8 +192,18 @@ DO_ERROR_INFO(do_trap_insn_fault,
 	SIGSEGV, SEGV_ACCERR, "instruction access fault");
 DO_ERROR_INFO(do_trap_insn_illegal,
 	SIGILL, ILL_ILLOPC, "illegal instruction");
+#ifdef CONFIG_USER_SHADOW_STACK
+asmlinkage void __trap_section do_trap_load_fault(struct pt_regs *regs)
+{
+	if (!handle_load_access_fault(regs))
+		return;
+	do_trap_error(regs, SIGSEGV, SEGV_ACCERR, regs->epc,
+		"load access fault");
+}
+#else
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
+#endif
 #ifndef CONFIG_RISCV_M_MODE
 DO_ERROR_INFO(do_trap_load_misaligned,
 	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
@@ -140,8 +229,18 @@ asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
 		      "Oops - store (or AMO) address misaligned");
 }
 #endif
+#ifdef CONFIG_USER_SHADOW_STACK
+asmlinkage void __trap_section do_trap_store_fault(struct pt_regs *regs)
+{
+	if (!handle_store_access_fault(regs))
+		return;
+	do_trap_error(regs, SIGSEGV, SEGV_ACCERR, regs->epc,
+		"store (or AMO) access fault");
+}
+#else
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
+#endif
 DO_ERROR_INFO(do_trap_ecall_u,
 	SIGILL, ILL_ILLTRP, "environment call from U-mode");
 DO_ERROR_INFO(do_trap_ecall_s,
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index d86f7cebd4a7..b5ecf36eba3d 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -18,6 +18,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
+#include <asm/pgtable.h>
 
 #include "../kernel/head.h"
 
@@ -177,6 +178,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 
 static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 {
+	unsigned long prot = 0, shdw_stk_mask = 0;
 	switch (cause) {
 	case EXC_INST_PAGE_FAULT:
 		if (!(vma->vm_flags & VM_EXEC)) {
@@ -194,6 +196,20 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 			return true;
 		}
 		break;
+#ifdef CONFIG_USER_SHADOW_STACK
+	/*
+	 * If a ss access page fault. vma must have only VM_WRITE.
+	 * and page prot much match to PAGE_SHADOWSTACK.
+	 */
+	case EXC_SS_ACCESS_PAGE_FAULT:
+		prot = pgprot_val(vma->vm_page_prot);
+		shdw_stk_mask = pgprot_val(PAGE_SHADOWSTACK);
+		if (((vma->vm_flags & (VM_WRITE | VM_READ | VM_EXEC)) != VM_WRITE) ||
+		   ((prot & shdw_stk_mask) != shdw_stk_mask)) {
+			return true;
+		}
+		break;
+#endif
 	default:
 		panic("%s: unhandled cause %lu", __func__, cause);
 	}
@@ -274,7 +290,12 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
-	if (cause == EXC_STORE_PAGE_FAULT)
+	if (cause == EXC_STORE_PAGE_FAULT
+#ifdef CONFIG_USER_SHADOW_STACK
+	   || cause == EXC_SS_ACCESS_PAGE_FAULT
+	   /* if config says shadow stack and cause is ss access then indicate a write */
+#endif
+	   )
 		flags |= FAULT_FLAG_WRITE;
 	else if (cause == EXC_INST_PAGE_FAULT)
 		flags |= FAULT_FLAG_INSTRUCTION;
-- 
2.25.1

