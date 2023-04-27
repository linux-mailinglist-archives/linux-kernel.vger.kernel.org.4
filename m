Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666FF6EFF41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbjD0CN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbjD0CNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:13:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D68EC40F0;
        Wed, 26 Apr 2023 19:12:44 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxTusZ2klk2l4BAA--.2334S3;
        Thu, 27 Apr 2023 10:12:41 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrYQ2klkZ_U9AA--.18515S5;
        Thu, 27 Apr 2023 10:12:40 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: [PATCH v2 3/5] LoongArch: ftrace: Add direct call support
Date:   Thu, 27 Apr 2023 10:12:30 +0800
Message-Id: <1682561552-32324-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
References: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxqrYQ2klkZ_U9AA--.18515S5
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXryDKF13uFWftr1UKFWUXFb_yoWrZFWfpr
        y7AwnrJFWj9FsYkasF9a48Wr4UJrWkW34ava47CFyFkrn8XFyjvr48AryDXFyjqws7G3yx
        XF1rCrW5CF47XwUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
register_ftrace_direct[_multi] interfaces allowing users to register
the customed trampoline (direct_caller) as the mcount for one or
more target functions. And modify_ftrace_direct[_multi] are also
provided for modifying direct_caller.

There are a few cases to distinguish:
- If a direct call ops is the only one tracing a function AND the direct
  called trampoline is within the reach of a 'bl' instruction
  -> the ftrace patchsite jumps to the trampoline
- Else
  -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline points
     to ftrace_list_ops so it iterates over all registered ftrace ops,
     including the direct call ops and calls its call_direct_funcs handler
     which stores the direct called trampoline's address in the ftrace_regs
     and the ftrace_regs_caller trampoline will return to that address
     instead of returning to the traced function

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h | 12 ++++++++++++
 arch/loongarch/kernel/ftrace_dyn.c  |  8 ++++++++
 arch/loongarch/kernel/mcount_dyn.S  |  7 ++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bc82c87c32ef..b4e039729bc7 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -95,6 +95,7 @@ config LOONGARCH
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 3418d32d4fc7..f789e680f633 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -57,6 +57,18 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+static inline void
+__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+	regs->regs[13] = addr;	/* t1 */
+}
+
+#define arch_ftrace_set_direct_caller(fregs, addr) \
+	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 3cc4f8159f48..4062a7e63137 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -66,6 +66,14 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod
 	unsigned long pc = rec->ip + LOONGARCH_INSN_SIZE;
 	struct plt_entry *plt;
 
+	/*
+	 * If a custom trampoline is unreachable, rely on the ftrace_regs_caller
+	 * trampoline which knows how to indirectly reach that trampoline
+	 * through ops->direct_call.
+	 */
+	if (*addr != FTRACE_ADDR && *addr != FTRACE_REGS_ADDR && !reachable_by_bl(*addr, pc))
+		*addr = FTRACE_REGS_ADDR;
+
 	/*
 	 * When the target is within range of the 'bl' instruction, use 'addr'
 	 * as-is and branch to that directly.
diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index bbabf06244c2..1008fbc3cabc 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -42,7 +42,6 @@
 	.if \allregs
 	PTR_S		tp, sp, PT_R2
 	PTR_S		t0, sp, PT_R12
-	PTR_S		t1, sp, PT_R13
 	PTR_S		t2, sp, PT_R14
 	PTR_S		t3, sp, PT_R15
 	PTR_S		t4, sp, PT_R16
@@ -64,6 +63,8 @@
 	PTR_S		zero, sp, PT_R0
 	.endif
 	PTR_S		ra, sp, PT_ERA /* Save trace function ra at PT_ERA */
+	move		t1, zero
+	PTR_S		t1, sp, PT_R13
 	PTR_ADDI	t8, sp, PT_SIZE
 	PTR_S		t8, sp, PT_R3
 	.endm
@@ -104,8 +105,12 @@ ftrace_common_return:
 	PTR_L		a7, sp, PT_R11
 	PTR_L		fp, sp, PT_R22
 	PTR_L		t0, sp, PT_ERA
+	PTR_L		t1, sp, PT_R13
 	PTR_ADDI	sp, sp, PT_SIZE
+	bnez		t1,.Ldirect
 	jr		t0
+.Ldirect:
+	jr		t1
 SYM_CODE_END(ftrace_common)
 
 SYM_CODE_START(ftrace_caller)
-- 
2.37.1

