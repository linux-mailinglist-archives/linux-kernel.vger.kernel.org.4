Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082636EEC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbjDZBtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbjDZBt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:49:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EC3118B81;
        Tue, 25 Apr 2023 18:49:23 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxKuoig0hkadAAAA--.1405S3;
        Wed, 26 Apr 2023 09:49:22 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx97Uag0hkROI7AA--.15428S5;
        Wed, 26 Apr 2023 09:49:21 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: [PATCH 3/5] LoongArch: ftrace: Add direct call support
Date:   Wed, 26 Apr 2023 09:49:12 +0800
Message-Id: <1682473754-25077-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
References: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Dx97Uag0hkROI7AA--.15428S5
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXrykur1fAF1UJF4DCF1fXrb_yoWrtrWDpr
        W7AwnrJFWj9FsYkasF9a48Wr4UJrWkX34a9asrCFyFkrn8XFyjvr48AryDXFyUtw4kG3yI
        qF1rCrW5CF47X3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
register_ftrace_direct[_multi] interfaces allowing users to register
the customed trampoline (direct_caller) as the mcount for one or
more target functions. And modify_ftrace_direct[_multi] are also
provided for modifying direct_caller.

There are a few cases to distinguish:
- If a direct call ops is the only one tracing a function:
  - If the direct called trampoline is within the reach of a 'bl'
    instruction
     -> the ftrace patchsite jumps to the trampoline
  - Else
     -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline
	which reads the ops pointer in the patchsite and jumps to the
 	direct call address stored in the ops
- Else
  -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline and
     its ops literal points to ftrace_list_ops so it iterates over all
     registered ftrace ops, including the direct call ops and calls its
     call_direct_funcs handler which stores the direct called trampoline's
     address in the ftrace_regs and the ftrace_regs_caller trampoline will
     return to that address instead of returning to the traced function

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h | 12 ++++++++++++
 arch/loongarch/kernel/ftrace_dyn.c  |  8 ++++++++
 arch/loongarch/kernel/mcount_dyn.S  |  7 ++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3ddde336e6a5..d6068a88d53f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -92,6 +92,7 @@ config LOONGARCH
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

