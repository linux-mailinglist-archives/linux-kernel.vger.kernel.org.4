Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331F76EEC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbjDZBt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbjDZBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:49:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8886194;
        Tue, 25 Apr 2023 18:49:19 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxBekeg0hkYdAAAA--.1611S3;
        Wed, 26 Apr 2023 09:49:18 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx97Uag0hkROI7AA--.15428S4;
        Wed, 26 Apr 2023 09:49:17 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH 2/5] LoongArch: ftrace: Implement ftrace_find_callable_addr() to simplify code
Date:   Wed, 26 Apr 2023 09:49:11 +0800
Message-Id: <1682473754-25077-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
References: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Dx97Uag0hkROI7AA--.15428S4
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GrWxGw43uFyxAF48WrWxZwb_yoW7GrykpF
        Zxtw15JrWjqFZ2gFZ2yr1DZr15KrykGa42qFW7K34Skw1DXF45ZFy7C3sxKa45t3ykWFW3
        ZFWfAFW5CrW3X3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
        JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the module processing part, the same code is reused by implementing
ftrace_find_callable_addr().

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/kernel/ftrace_dyn.c | 120 +++++++++++++++--------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index c5f4b4681ddc..3cc4f8159f48 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -31,16 +31,11 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new, bool validate)
 }
 
 #ifdef CONFIG_MODULES
-static inline int __get_mod(struct module **mod, unsigned long addr)
+static bool reachable_by_bl(unsigned long addr, unsigned long pc)
 {
-	preempt_disable();
-	*mod = __module_text_address(addr);
-	preempt_enable();
+	long offset = (long)addr - (long)pc;
 
-	if (WARN_ON(!(*mod)))
-		return -EINVAL;
-
-	return 0;
+	return offset >= -SZ_128M && offset < SZ_128M;
 }
 
 static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
@@ -56,18 +51,63 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 	return NULL;
 }
 
-static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
+/*
+ * Find the address the callsite must branch to in order to reach '*addr'.
+ *
+ * Due to the limited range of 'bl' instructions, modules may be placed too far
+ * away to branch directly and must use a PLT.
+ *
+ * Returns true when '*addr' contains a reachable target address, or has been
+ * modified to contain a PLT address. Returns false otherwise.
+ */
+static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod,
+				      unsigned long *addr)
 {
+	unsigned long pc = rec->ip + LOONGARCH_INSN_SIZE;
 	struct plt_entry *plt;
 
-	plt = get_ftrace_plt(mod, addr);
+	/*
+	 * When the target is within range of the 'bl' instruction, use 'addr'
+	 * as-is and branch to that directly.
+	 */
+	if (reachable_by_bl(*addr, pc))
+		return true;
+
+	/*
+	 * 'mod' is only set at module load time, but if we end up
+	 * dealing with an out-of-range condition, we can assume it
+	 * is due to a module being loaded far away from the kernel.
+	 *
+	 * NOTE: __module_text_address() must be called with preemption
+	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
+	 * retains its validity throughout the remainder of this code.
+	 */
+	if (!mod) {
+		preempt_disable();
+		mod = __module_text_address(pc);
+		preempt_enable();
+	}
+
+	if (WARN_ON(!mod))
+		return false;
+
+	plt = get_ftrace_plt(mod, *addr);
 	if (!plt) {
-		pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
-		return -EINVAL;
+		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
+		return false;
 	}
 
-	return (unsigned long)plt;
+	*addr = (unsigned long)plt;
+	return true;
 }
+
+#else /* !CONFIG_MODULES */
+static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod,
+				      unsigned long *addr)
+{
+	return true;
+}
+
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
@@ -75,26 +115,14 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned
 {
 	u32 old, new;
 	unsigned long pc;
-	long offset __maybe_unused;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
 
-#ifdef CONFIG_MODULES
-	offset = (long)pc - (long)addr;
-
-	if (offset < -SZ_128M || offset >= SZ_128M) {
-		int ret;
-		struct module *mod;
-
-		ret = __get_mod(&mod, pc);
-		if (ret)
-			return ret;
-
-		addr = get_plt_addr(mod, addr);
+	if (!ftrace_find_callable_addr(rec, NULL, &addr))
+		return -EINVAL;
 
-		old_addr = get_plt_addr(mod, old_addr);
-	}
-#endif
+	if (!ftrace_find_callable_addr(rec, NULL, &old_addr))
+		return -EINVAL;
 
 	new = larch_insn_gen_bl(pc, addr);
 	old = larch_insn_gen_bl(pc, old_addr);
@@ -151,24 +179,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	u32 old, new;
 	unsigned long pc;
-	long offset __maybe_unused;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
 
-#ifdef CONFIG_MODULES
-	offset = (long)pc - (long)addr;
-
-	if (offset < -SZ_128M || offset >= SZ_128M) {
-		int ret;
-		struct module *mod;
-
-		ret = __get_mod(&mod, pc);
-		if (ret)
-			return ret;
-
-		addr = get_plt_addr(mod, addr);
-	}
-#endif
+	if (!ftrace_find_callable_addr(rec, NULL, &addr))
+		return -EINVAL;
 
 	old = larch_insn_gen_nop();
 	new = larch_insn_gen_bl(pc, addr);
@@ -180,24 +195,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 {
 	u32 old, new;
 	unsigned long pc;
-	long offset __maybe_unused;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
 
-#ifdef CONFIG_MODULES
-	offset = (long)pc - (long)addr;
-
-	if (offset < -SZ_128M || offset >= SZ_128M) {
-		int ret;
-		struct module *mod;
-
-		ret = __get_mod(&mod, pc);
-		if (ret)
-			return ret;
-
-		addr = get_plt_addr(mod, addr);
-	}
-#endif
+	if (!ftrace_find_callable_addr(rec, NULL, &addr))
+		return -EINVAL;
 
 	new = larch_insn_gen_nop();
 	old = larch_insn_gen_bl(pc, addr);
-- 
2.37.1

