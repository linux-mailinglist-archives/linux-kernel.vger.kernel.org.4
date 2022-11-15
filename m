Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF9629039
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiKOC5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiKOC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:56:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4EE1A3AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:55:34 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxDdmj_3Jjdh8HAA--.21030S3;
        Tue, 15 Nov 2022 10:55:31 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuKf_3JjmywTAA--.51398S6;
        Tue, 15 Nov 2022 10:55:31 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH v6 4/9] LoongArch/ftrace: Add dynamic function graph tracer support
Date:   Tue, 15 Nov 2022 10:55:22 +0800
Message-Id: <20221115025527.13382-5-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221115025527.13382-1-zhangqing@loongson.cn>
References: <20221115025527.13382-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuKf_3JjmywTAA--.51398S6
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF4DAF1DKw4rGFWUtw4UXFb_yoWrKFyDpr
        y2y3ZxtrWjkFsakr9Igw4DXrW5J393W342qanrtryrCwsFqF13Aw1xA34qqFyaqw4UCryS
        vayrAr4jka1UXa7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxU4OzVUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the function_graph tracer is enabled, a filtered function has the
following call sequence:

1) ftracer_caller     ==> on/off by ftrace_make_call/ftrace_make_nop
2) ftrace_graph_caller
3) ftrace_graph_call  ==> on/off by ftrace_en/disable_ftrace_graph_caller
4) prepare_ftrace_return

Considering the following DYNAMIC_FTRACE_WITH_REGS feature, it would be
more extendable to have a ftrace_graph_caller function, instead of
calling prepare_ftrace_return directly in ftrace_caller.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/kernel/ftrace_dyn.c | 45 ++++++++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c       | 24 ++++++++++++++++
 arch/loongarch/kernel/mcount-dyn.S | 33 ++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 1f8955be8b64..3fe791b6783e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -109,3 +109,48 @@ int __init ftrace_dyn_arch_init(void)
 {
 	return 0;
 }
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern void ftrace_graph_call(void);
+
+void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+
+	if (!function_graph_enter(old, self_addr, 0, NULL))
+		*parent = return_hooker;
+}
+
+static int ftrace_modify_graph_caller(bool enable)
+{
+	unsigned long pc, func;
+	u32 branch, nop;
+
+	pc = (unsigned long)&ftrace_graph_call;
+	func = (unsigned long)&ftrace_graph_caller;
+
+	branch = larch_insn_gen_b(pc, func);
+	nop = larch_insn_gen_nop();
+
+	if (enable)
+		return ftrace_modify_code(pc, nop, branch, true);
+	else
+		return ftrace_modify_code(pc, branch, nop, true);
+}
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(true);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(false);
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index d62cdf4a9ffb..2d2e942eb06a 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -55,6 +55,30 @@ u32 larch_insn_gen_nop(void)
 	return INSN_NOP;
 }
 
+u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
+{
+	unsigned int immediate_l, immediate_h;
+	union loongarch_instruction insn;
+	long offset = dest - pc;
+
+	if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
+		pr_warn("The generated b instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	offset >>= 2;
+
+	immediate_l = offset & 0xffff;
+	offset >>= 16;
+	immediate_h = offset & 0x3ff;
+
+	insn.reg0i26_format.opcode = b_op;
+	insn.reg0i26_format.immediate_l = immediate_l;
+	insn.reg0i26_format.immediate_h = immediate_h;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 {
 	unsigned int immediate_l, immediate_h;
diff --git a/arch/loongarch/kernel/mcount-dyn.S b/arch/loongarch/kernel/mcount-dyn.S
index 205925bc3822..0c12cc108e6f 100644
--- a/arch/loongarch/kernel/mcount-dyn.S
+++ b/arch/loongarch/kernel/mcount-dyn.S
@@ -62,6 +62,11 @@ SYM_CODE_START(ftrace_common)
 	.globl ftrace_call
 ftrace_call:
 	bl		ftrace_stub
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	nop				/* b ftrace_graph_caller */
+#endif
 /*
  * As we didn't use S series regs in this assmembly code and all calls
  * are C function which will save S series regs by themselves, there is
@@ -84,6 +89,34 @@ ftrace_common_return:
 	jr	t0
 SYM_CODE_END(ftrace_common)
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_CODE_START(ftrace_graph_caller)
+	PTR_L		a0, sp, PT_ERA
+	PTR_ADDI	a0, a0, -8	/* arg0: self_addr */
+	PTR_ADDI	a1, sp, PT_R1	/* arg1: parent */
+	bl		prepare_ftrace_return
+	b		ftrace_common_return
+SYM_CODE_END(ftrace_graph_caller)
+
+SYM_CODE_START(return_to_handler)
+	/* save return value regs */
+	PTR_ADDI 	sp, sp, -2 * SZREG
+	PTR_S		a0, sp, 0
+	PTR_S		a1, sp, SZREG
+
+	move		a0, zero	/* Has no check FP now. */
+	bl		ftrace_return_to_handler
+	move		ra, a0		/* parent ra */
+
+	/* restore return value regs */
+	PTR_L		a0, sp, 0
+	PTR_L		a1, sp, SZREG
+	PTR_ADDI 	sp, sp, 2 * SZREG
+
+	jr	ra
+SYM_CODE_END(return_to_handler)
+#endif
+
 SYM_FUNC_START(ftrace_stub)
 	jr	ra
 SYM_FUNC_END(ftrace_stub)
-- 
2.36.0

