Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869026011B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJQOyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJQOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D163691B1;
        Mon, 17 Oct 2022 07:53:46 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDYboYriwhVdMX54asHSo58M6AeExahoC2Qwqrk6wU8=;
        b=esU20p7He+E7No3f801zT1D2AHzRTgpA/aRdGwyc7WU5JuydQSdHUfSojirnd/KZERxaI+
        Tzot2/PuMYM1GjUOaU+lNt/iyzqc3vrjKiAZVwYt9pLpjmaSyryP33yUmEj70qkzxxZ/rG
        02m3m7qnbLgaVoF4M1Gx5yLXIKwDyCsk1LF94AotbNorifncIwIxb0pC2QmBTB0H1d0XAU
        aA93iPi7QN/mUuQj192WBJGmlyYNkmfuYuEOjZQuAWRwNV4aGY+pdddajxJ6AJLa9AB0xM
        cczJWZ86nad5s9PlMclc6fe57QdoQgfg4NVu0W14Dd41YwrihMgDb33Mwu2oXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDYboYriwhVdMX54asHSo58M6AeExahoC2Qwqrk6wU8=;
        b=UsoKvZYyagXC2U5XKyezMQDymcbDXqWiwKW8oorMIZgXAaNK5WooPtY7W5lV0zYxcoHbjn
        saVrQ5kHAcCziDCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bpf: Emit call depth accounting if required
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.615413406@infradead.org>
References: <20220915111148.615413406@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841301.401.177039402898517120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b2e9dfe54be4d023124d588d6f03d16a9c0d2507
Gitweb:        https://git.kernel.org/tip/b2e9dfe54be4d023124d588d6f03d16a9c0d2507
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:18 +02:00

x86/bpf: Emit call depth accounting if required

Ensure that calls in BPF jitted programs are emitting call depth accounting
when enabled to keep the call/return balanced. The return thunk jump is
already injected due to the earlier retbleed mitigations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.615413406@infradead.org
---
 arch/x86/include/asm/alternative.h |  6 +++++-
 arch/x86/kernel/callthunks.c       | 19 +++++++++++++++++-
 arch/x86/net/bpf_jit_comp.c        | 32 ++++++++++++++++++++---------
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4b8cd25..664c077 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -93,6 +93,7 @@ extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
 extern bool is_callthunk(void *addr);
+extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -106,6 +107,11 @@ static __always_inline bool is_callthunk(void *addr)
 {
 	return false;
 }
+static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
+							  void *func)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 7f97881..a03d646 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -306,6 +306,25 @@ bool is_callthunk(void *addr)
 	return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
 }
 
+#ifdef CONFIG_BPF_JIT
+int x86_call_depth_emit_accounting(u8 **pprog, void *func)
+{
+	unsigned int tmpl_size = SKL_TMPL_SIZE;
+	void *tmpl = skl_call_thunk_template;
+
+	if (!thunks_initialized)
+		return 0;
+
+	/* Is function call target a thunk? */
+	if (is_callthunk(func))
+		return 0;
+
+	memcpy(*pprog, tmpl, tmpl_size);
+	*pprog += tmpl_size;
+	return tmpl_size;
+}
+#endif
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ad8cb7f..a6b4674 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -340,6 +340,13 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
+static int emit_rsb_call(u8 **pprog, void *func, void *ip)
+{
+	OPTIMIZER_HIDE_VAR(func);
+	x86_call_depth_emit_accounting(pprog, func);
+	return emit_patch(pprog, func, ip, 0xE8);
+}
+
 static int emit_jump(u8 **pprog, void *func, void *ip)
 {
 	return emit_patch(pprog, func, ip, 0xE9);
@@ -1436,19 +1443,26 @@ st:			if (is_imm8(insn->off))
 			break;
 
 			/* call */
-		case BPF_JMP | BPF_CALL:
+		case BPF_JMP | BPF_CALL: {
+			int offs;
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
 				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 				EMIT3_off32(0x48, 0x8B, 0x85,
 					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
-				if (!imm32 || emit_call(&prog, func, image + addrs[i - 1] + 7))
+				if (!imm32)
 					return -EINVAL;
+				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
 			} else {
-				if (!imm32 || emit_call(&prog, func, image + addrs[i - 1]))
+				if (!imm32)
 					return -EINVAL;
+				offs = x86_call_depth_emit_accounting(&prog, func);
 			}
+			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
+				return -EINVAL;
 			break;
+		}
 
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
@@ -1854,7 +1868,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
 	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
-	if (emit_call(&prog, enter, prog))
+	if (emit_rsb_call(&prog, enter, prog))
 		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
@@ -1875,7 +1889,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
 	/* call JITed bpf program or interpreter */
-	if (emit_call(&prog, p->bpf_func, prog))
+	if (emit_rsb_call(&prog, p->bpf_func, prog))
 		return -EINVAL;
 
 	/*
@@ -1899,7 +1913,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
 	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_call(&prog, exit, prog))
+	if (emit_rsb_call(&prog, exit, prog))
 		return -EINVAL;
 
 	*pprog = prog;
@@ -2147,7 +2161,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_call(&prog, __bpf_tramp_enter, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2179,7 +2193,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 			EMIT2(0xff, 0xd0); /* call *rax */
 		} else {
 			/* call original function */
-			if (emit_call(&prog, orig_call, prog)) {
+			if (emit_rsb_call(&prog, orig_call, prog)) {
 				ret = -EINVAL;
 				goto cleanup;
 			}
@@ -2223,7 +2237,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		im->ip_epilogue = prog;
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_call(&prog, __bpf_tramp_exit, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_exit, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
