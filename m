Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B11693D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBMEzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBMEy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77C10ABB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z1so12288729plg.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzh1F9dWgL9z5qWHfkyPDeO9BiBZZOuMNa7E/NQMYRA=;
        b=hBAMguZTqz8mBO0i9eURw5EVnyTRjZI/TA0b+TvPmhimWAwoztTflfei++MGWOOhhp
         y9UQAG+6WEpmcozlhgFWPCfcNQEzazPzUc/BX/nwlV3/TfGY4oELgmwTzmcXbl8+8cLl
         YEyUj++v3tAMb1ug4pKO06rWe166GtjQy4/L6hNDTIxwdYO6Ph9pApQUVXelympLBY5P
         P2ApcmLSjc979qayu5Jclp/xPesWV0Ux6A2gskrj7yI7PMJAnA8Rupt6ysIl/wy30dGv
         MavO85rbflXHbv+JQi0NDSiLwIMFGmpAvYbubygtTeUtBxtynv9lE2AP/U0geTFdg9Iz
         T4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzh1F9dWgL9z5qWHfkyPDeO9BiBZZOuMNa7E/NQMYRA=;
        b=Vjw6KVIDzXdfs6XW+RI8ui3/esW/dYhsM2No1Yr+tHwrGcJysCNpfVOy73Ro0jiVmu
         6h3keYVxBMuaFg8AuDzfkFcttj37EpckeFwc5laO62k5UMsEqPqILJmm1TxFPmgR0o6Y
         JLaQNTOdx1P9hzCAGbhmi/CifQisid8eeIzb7J4ygkWu/HRVOWCAgQhxYsSZGc0tVj4x
         pjlFCYDzyuLZOfrmCc0CG04ktCcXQJe2MQNL0zbQw5yO1xVzBg47gQvUYcoodhB5q15a
         mUVA8pNNMgics4oFtjF9P3HhXBovp/x+OC9NUguxbb2JqUowxXn8lcz62CWdKj3FOBLd
         Njag==
X-Gm-Message-State: AO0yUKUsPZ5yM1bwve8EAHeJP4mKXmB2+XtP5hQgW9IPu9ywERyx/4RN
        Y7jEewxftEddZgPureS3zuzwuf1wUNrdrN/8
X-Google-Smtp-Source: AK7set/ieVh7qhs04S/uXJn79ItEgAaNBhP4tICRnJOHZZuCn+oguG49FVAuZKnOk1MHnr6vz9IICA==
X-Received: by 2002:a17:902:e40d:b0:19a:a2f3:e41c with SMTP id m13-20020a170902e40d00b0019aa2f3e41cmr1350325ple.35.1676264061243;
        Sun, 12 Feb 2023 20:54:21 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:20 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 13/20] riscv: illegal instruction handler for cfi violations
Date:   Sun, 12 Feb 2023 20:53:42 -0800
Message-Id: <20230213045351.3945824-14-debug@rivosinc.com>
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

Zisslpcfi spec proposes that cfi violations are reported as illegal
instruction exception. Following are the cases

- elp missing: An indirect jmp/call landed on instruction which is
  not `lpcll`
- label mismatch: Static label embedded in instr `lpcll/lpcml/lpcul`
  doesn't match with repsective label in CSR_LPLR
- sscheckra: x1 and x5 don't match.

Current changes run user code in audit mode. That means that any cfi
violation is suppressed and app is allowed to continue.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 79 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 5553b8d48ba5..a292699f4f25 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -97,6 +97,10 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 /* Zisslpcfi instructions encodings */
 #define SS_PUSH_POP 0x81C04073
 #define SS_AMOSWAP  0x82004073
+#define SS_CHECKRA  0x8A12C073
+#define LP_C_LL     0x83004073
+#define LP_C_ML     0x86804073
+#define LP_C_UL     0x8B804073
 
 bool is_ss_load_store_insn(unsigned long insn)
 {
@@ -112,6 +116,71 @@ bool is_ss_load_store_insn(unsigned long insn)
 	return false;
 }
 
+bool is_cfi_violation_insn(unsigned long insn)
+{
+	struct task_struct *task = current;
+	bool ss_exist = false, lp_exist = false;
+
+	ss_exist = arch_supports_shadow_stack();
+	lp_exist = arch_supports_indirect_br_lp_instr();
+
+	if (ss_exist && (insn == SS_CHECKRA)) {
+		pr_warn("cfi violation (sschkra): comm = %s, task = %p\n", task->comm, task);
+		return true;
+	}
+	if (lp_exist && ((insn & LP_C_LL) == LP_C_LL)) {
+		pr_warn("cfi violation (lpcll): comm = %s, task = %p\n", task->comm, task);
+		return true;
+	}
+	if (lp_exist && ((insn & LP_C_ML) == LP_C_ML)) {
+		pr_warn("cfi violation (lpcml): comm = %s, task = %p\n", task->comm, task);
+		return true;
+	}
+	if (lp_exist && ((insn & LP_C_UL) == LP_C_UL)) {
+		pr_warn("cfi violation (lpcul): comm = %s, task = %p\n", task->comm, task);
+		return true;
+	}
+
+	return false;
+}
+
+int handle_illegal_instruction(struct pt_regs *regs)
+{
+	/* stval should hold faulting opcode */
+	unsigned long insn = csr_read(stval);
+	struct thread_info *info = NULL;
+	struct task_struct *task = current;
+
+	info = current_thread_info();
+	/*
+	 * If CFI enabled then following instructions leads to illegal instruction fault
+	 * -- sscheckra: x1 and x5 mismatch
+	 * -- ELP = 1, Any instruction other than lpcll will fault
+	 * -- lpcll will fault if lower label don't match with LPLR.LL
+	 * -- lpcml will fault if lower label don't match with LPLR.ML
+	 * -- lpcul will fault if lower label don't match with LPLR.UL
+	 */
+
+	/* If fcfi enabled and  ELP = 1, suppress ELP (audit mode)  and resume */
+	if (arch_supports_indirect_br_lp_instr() &&
+#ifdef CONFIG_USER_INDIRECT_BR_LP
+	    info->user_cfi_state.ufcfi_en &&
+#endif
+	    (regs->status & SR_ELP)) {
+		pr_warn("cfi violation (elp): comm = %s, task = %p\n", task->comm, task);
+		regs->status &= ~(SR_ELP);
+		return 0;
+	}
+	/* if faulting opcode is sscheckra/lpcll/lpcml/lpcll, advance PC and resume */
+	if (is_cfi_violation_insn(insn)) {
+		/* no compressed form for zisslpcfi instructions */
+		regs->epc += 4;
+		return 0;
+	}
+
+	return 1;
+}
+
 ulong get_instruction(ulong epc)
 {
 	ulong *epc_ptr = (ulong *) epc;
@@ -190,8 +259,14 @@ DO_ERROR_INFO(do_trap_insn_misaligned,
 	SIGBUS, BUS_ADRALN, "instruction address misaligned");
 DO_ERROR_INFO(do_trap_insn_fault,
 	SIGSEGV, SEGV_ACCERR, "instruction access fault");
-DO_ERROR_INFO(do_trap_insn_illegal,
-	SIGILL, ILL_ILLOPC, "illegal instruction");
+
+asmlinkage void __trap_section do_trap_insn_illegal(struct pt_regs *regs)
+{
+	if (!handle_illegal_instruction(regs))
+		return;
+	do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
+		      "illegal instruction");
+}
 #ifdef CONFIG_USER_SHADOW_STACK
 asmlinkage void __trap_section do_trap_load_fault(struct pt_regs *regs)
 {
-- 
2.25.1

