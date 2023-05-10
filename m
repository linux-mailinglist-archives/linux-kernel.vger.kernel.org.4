Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444806FDB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjEJKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjEJKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:19:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AB2716;
        Wed, 10 May 2023 03:19:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so4730219b3a.1;
        Wed, 10 May 2023 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683713965; x=1686305965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8PnWPxOmTgqoGmgt89yn/TCaGU0tidyCiXa2X9+A9Y=;
        b=NG7LekLrGub/XMbXfi3gcSS73gXoq3iSZZWfSXlZPqmSMrHzfFFBIubqDmC8Eefr80
         wEqvElqqiPuolBOBiv4wBsXIWbKKlA308XesKY6liA0h+mP8zmKLs24IUzpctt+SG5gS
         MNWt4pprKn4yBZEDrxeoI4HcPoIbPdwN1KdNUGmN86tF3xDsYjW18X58KbPjw1oglnhe
         DHJowzV74jSy2dQCs2Zx7N0zEMr2KU1q8gtfolnEdFdsAZYtlXGm9tyf6qPvpxGqB8K+
         9sogzCb89uOGBEmmpJ/dhsAW5Z9zQ1Wr/4y4QoGRMIdKFhKW/bY07Ng70r7mvpguvbR9
         qcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713965; x=1686305965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8PnWPxOmTgqoGmgt89yn/TCaGU0tidyCiXa2X9+A9Y=;
        b=H71UrmvQeVCQ8HWMJtI5DTZRkDM0tMaIqTfZ3waULNvkZaqL3ayrZaIoTY+1FBz/Sh
         vhbFi+E5Ul1TbdrXgrOpu0uos/E2BYdLdQFzvfaydDAFuL3VX4Mr0pOXOxFVJUhmzUqr
         EGded6EKqRcZLeExRzjxSYANe7EkY95Cb9p1ZPECJjXG4hUtS0bFfYc1/hfwFSl1+74v
         s3bSPUfF26HH1ahEEYlLXhOjZ3xxwdy7Mio0LGbMFk5HI2ExjQyLbfUDr/R9sObTefq2
         0bohiPp6IbHU1PuCKY4K1icejtuC8sAtbjA9CNcOcZDMOupcU4lQkKkqpPaO+tlY8eko
         vFWA==
X-Gm-Message-State: AC+VfDwTmS1059AGEeQhc3ZyNRDYZvL+ye9gwikK5tjFcbZcEa/th3bm
        jnV5uzOdC0Fpc2LZm0MsG0o=
X-Google-Smtp-Source: ACHHUZ7gurpxafT4w92Tf1R2lQSIyFKwV1m9Tw2YU6mZh5n2LcwNQ+K3Sa7lcEJ5m5EO47H60l6ZAA==
X-Received: by 2002:a17:902:d505:b0:1a6:dd9a:62c5 with SMTP id b5-20020a170902d50500b001a6dd9a62c5mr21537860plg.10.1683713965388;
        Wed, 10 May 2023 03:19:25 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001aadd0d7364sm3393419plf.83.2023.05.10.03.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 03:19:25 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        jszhang@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH V9 2/4] riscv: ftrace: Add ftrace_graph_func
Date:   Wed, 10 May 2023 18:18:55 +0800
Message-Id: <20230510101857.2953955-3-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230510101857.2953955-1-suagrfillet@gmail.com>
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here implements ftrace_graph_func as the function graph tracing function
with FTRACE_WITH_REGS defined.

function_graph_func gets the point of the parent IP and the frame pointer
from fregs and call prepare_ftrace_return for function graph tracing.

If FTRACE_WITH_REGS isn't defined, the enable/disable helpers of
ftrace_graph_[regs]_call are revised for serving only ftrace_graph_call
in the !FTRACE_WITH_REGS version ftrace_caller.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/ftrace.h |  11 ++-
 arch/riscv/kernel/ftrace.c      |  30 +++---
 arch/riscv/kernel/mcount-dyn.S  | 166 +++++++++++++++++++++++++++-----
 3 files changed, 163 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index d47d87c2d7e3..84f856a3286e 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -107,7 +107,16 @@ do {									\
 struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
-#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+struct ftrace_ops;
+struct ftrace_regs;
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 03a6434a8cdd..f5aa24d9e1c1 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -178,32 +178,28 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&regs->ra;
+
+	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+}
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 extern void ftrace_graph_call(void);
-extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, true, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false, true);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 669b8697aa38..f26e9f6e2fed 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -57,31 +57,150 @@
 	.endm
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	.macro SAVE_ALL
+
+/**
+* SAVE_ABI_REGS - save regs against the pt_regs struct
+*
+* @all: tell if saving all the regs
+*
+* If all is set, all the regs will be saved, otherwise only ABI
+* related regs (a0-a7,epc,ra and optional s0) will be saved.
+*
+* After the stack is established,
+*
+* 0(sp) stores the PC of the traced function which can be accessed
+* by &(fregs)->regs->epc in tracing function. Note that the real
+* function entry address should be computed with -FENTRY_RA_OFFSET.
+*
+* 8(sp) stores the function return address (i.e. parent IP) that
+* can be accessed by &(fregs)->regs->ra in tracing function.
+*
+* The other regs are saved at the respective localtion and accessed
+* by the respective pt_regs member.
+*
+* Here is the layout of stack for your reference.
+*
+* PT_SIZE_ON_STACK  ->  +++++++++
+*                       + ..... +
+*                       + t3-t6 +
+*                       + s2-s11+
+*                       + a0-a7 + --++++-> ftrace_caller saved
+*                       + s1    +   +
+*                       + s0    + --+
+*                       + t0-t2 +   +
+*                       + tp    +   +
+*                       + gp    +   +
+*                       + sp    +   +
+*                       + ra    + --+ // parent IP
+*               sp  ->  + epc   + --+ // PC
+*                       +++++++++
+**/
+	.macro SAVE_ABI_REGS, all=0
 	addi	sp, sp, -PT_SIZE_ON_STACK
 
 	REG_S t0,  PT_EPC(sp)
 	REG_S x1,  PT_RA(sp)
+
+	// always save the ABI regs
+
+	REG_S x10, PT_A0(sp)
+	REG_S x11, PT_A1(sp)
+	REG_S x12, PT_A2(sp)
+	REG_S x13, PT_A3(sp)
+	REG_S x14, PT_A4(sp)
+	REG_S x15, PT_A5(sp)
+	REG_S x16, PT_A6(sp)
+	REG_S x17, PT_A7(sp)
+
+	// save the leftover regs
+
+	.if \all == 1
 	REG_S x2,  PT_SP(sp)
 	REG_S x3,  PT_GP(sp)
 	REG_S x4,  PT_TP(sp)
 	REG_S x5,  PT_T0(sp)
-	save_from_x6_to_x31
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
+	REG_S x18, PT_S2(sp)
+	REG_S x19, PT_S3(sp)
+	REG_S x20, PT_S4(sp)
+	REG_S x21, PT_S5(sp)
+	REG_S x22, PT_S6(sp)
+	REG_S x23, PT_S7(sp)
+	REG_S x24, PT_S8(sp)
+	REG_S x25, PT_S9(sp)
+	REG_S x26, PT_S10(sp)
+	REG_S x27, PT_S11(sp)
+	REG_S x28, PT_T3(sp)
+	REG_S x29, PT_T4(sp)
+	REG_S x30, PT_T5(sp)
+	REG_S x31, PT_T6(sp)
+
+	// save s0 if FP_TEST defined
+
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_S x8,  PT_S0(sp)
+#endif
+	.endif
 	.endm
 
-	.macro RESTORE_ALL
+	.macro RESTORE_ABI_REGS, all=0
+	REG_L t0,  PT_EPC(sp)
 	REG_L x1,  PT_RA(sp)
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+
+	.if \all == 1
 	REG_L x2,  PT_SP(sp)
 	REG_L x3,  PT_GP(sp)
 	REG_L x4,  PT_TP(sp)
-	/* Restore t0 with PT_EPC */
-	REG_L x5,  PT_EPC(sp)
-	restore_from_x6_to_x31
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
+	REG_L x18, PT_S2(sp)
+	REG_L x19, PT_S3(sp)
+	REG_L x20, PT_S4(sp)
+	REG_L x21, PT_S5(sp)
+	REG_L x22, PT_S6(sp)
+	REG_L x23, PT_S7(sp)
+	REG_L x24, PT_S8(sp)
+	REG_L x25, PT_S9(sp)
+	REG_L x26, PT_S10(sp)
+	REG_L x27, PT_S11(sp)
+	REG_L x28, PT_T3(sp)
+	REG_L x29, PT_T4(sp)
+	REG_L x30, PT_T5(sp)
+	REG_L x31, PT_T6(sp)
 
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_L x8,  PT_S0(sp)
+#endif
+	.endif
 	addi	sp, sp, PT_SIZE_ON_STACK
 	.endm
+
+	.macro PREPARE_ARGS
+	addi	a0, t0, -FENTRY_RA_OFFSET	// ip
+	la	a1, function_trace_op
+	REG_L	a2, 0(a1)			// op
+	mv	a1, ra				// parent_ip
+	mv	a3, sp				// fregs
+	.endm
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 ENTRY(ftrace_caller)
 	SAVE_ABI
 
@@ -110,33 +229,28 @@ ftrace_graph_call:
 	jr t0
 ENDPROC(ftrace_caller)
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
-	SAVE_ALL
-
-	addi	a0, t0, -FENTRY_RA_OFFSET
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	mv	a1, ra
-	mv	a3, sp
+	SAVE_ABI_REGS 1
+	PREPARE_ARGS
 
 ftrace_regs_call:
 	.global ftrace_regs_call
 	call	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, PT_RA
-	REG_L	a1, PT_EPC(sp)
-	addi	a1, a1, -FENTRY_RA_OFFSET
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a2, s0
-#endif
-ftrace_graph_regs_call:
-	.global ftrace_graph_regs_call
+	RESTORE_ABI_REGS 1
+	jr t0
+ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	SAVE_ABI_REGS 0
+	PREPARE_ARGS
+
+ftrace_call:
+	.global ftrace_call
 	call	ftrace_stub
-#endif
 
-	RESTORE_ALL
+	RESTORE_ABI_REGS 0
 	jr t0
-ENDPROC(ftrace_regs_caller)
+ENDPROC(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.20.1

