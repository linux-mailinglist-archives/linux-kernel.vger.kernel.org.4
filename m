Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC15B9A01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIOLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIOLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FDF79A47
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=maQprE9zY8EM3FYZN4zOoTRIJJNod/NvjmNUuhepp5Y=; b=DhOtcqHCrPM9hXK98+VB+8EHeV
        ZXS9ThEtLfUQtF/REvRg0oiaFp7TCvzknirPrA7xqXcPoXVtgKIc86zNpyF8IJVobYtYfkRGEyI45
        waqfl+etHsbboDN3X/WbWKYqSux7QZCBDZl262bQXigPpmkYiw3PlKeko2imJsO12eSX1yGVNF65B
        z57WRueINVdvIkp33rFTjAxjjS4KTt5nVtXSeIo63/LM72/jgQoLFK38f4OQK5e9gSb7Rcqf3WML0
        WxR5WJWYJwu8VZ19uax3buBs2dSDCH90zoAPiqrr9ueDOWetKV/mizCH3zNRLWR4PcKmODwzmhiTz
        rgQPhuyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDs-00CacT-Rb; Thu, 15 Sep 2022 11:40:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FDE4302EE0;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3D3A229AADBE3; Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Message-ID: <20220915111148.615413406@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 55/59] x86/bpf: Emit call depth accounting if required
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Ensure that calls in BPF jitted programs are emitting call depth accounting
when enabled to keep the call/return balanced. The return thunk jump is
already injected due to the earlier retbleed mitigations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/alternative.h |    6 ++++++
 arch/x86/kernel/callthunks.c       |   19 +++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c        |   32 +++++++++++++++++++++++---------
 3 files changed, 48 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -93,6 +93,7 @@ extern void callthunks_patch_module_call
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
 extern bool is_callthunk(void *addr);
+extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -106,6 +107,11 @@ static __always_inline bool is_callthunk
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
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -305,6 +305,25 @@ bool is_callthunk(void *addr)
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
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -340,6 +340,13 @@ static int emit_call(u8 **pprog, void *f
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
@@ -1434,19 +1441,26 @@ st:			if (is_imm8(insn->off))
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
@@ -1823,7 +1837,7 @@ static int invoke_bpf_prog(const struct
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
 	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
-	if (emit_call(&prog, enter, prog))
+	if (emit_rsb_call(&prog, enter, prog))
 		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
@@ -1844,7 +1858,7 @@ static int invoke_bpf_prog(const struct
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
 	/* call JITed bpf program or interpreter */
-	if (emit_call(&prog, p->bpf_func, prog))
+	if (emit_rsb_call(&prog, p->bpf_func, prog))
 		return -EINVAL;
 
 	/*
@@ -1868,7 +1882,7 @@ static int invoke_bpf_prog(const struct
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
 	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_call(&prog, exit, prog))
+	if (emit_rsb_call(&prog, exit, prog))
 		return -EINVAL;
 
 	*pprog = prog;
@@ -2109,7 +2123,7 @@ int arch_prepare_bpf_trampoline(struct b
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_call(&prog, __bpf_tramp_enter, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2141,7 +2155,7 @@ int arch_prepare_bpf_trampoline(struct b
 			EMIT2(0xff, 0xd0); /* call *rax */
 		} else {
 			/* call original function */
-			if (emit_call(&prog, orig_call, prog)) {
+			if (emit_rsb_call(&prog, orig_call, prog)) {
 				ret = -EINVAL;
 				goto cleanup;
 			}
@@ -2185,7 +2199,7 @@ int arch_prepare_bpf_trampoline(struct b
 		im->ip_epilogue = prog;
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_call(&prog, __bpf_tramp_exit, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_exit, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}


