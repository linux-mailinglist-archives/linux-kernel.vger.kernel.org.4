Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBE5B99D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIOLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIOLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF848EBB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=r5OPPEtUvAvLyUEDLHTlEmYZN5yu2Cagrk4lN594PZw=; b=V3jzwitZ46jxisYEU/6zzQ2yQE
        9MvXXXKA11dKv7uUM9UqwSdZ7xucluX5oFHa8Yu8zm3REB25a4juvoCadNK94WLSEd8G99UecI4Bd
        fQZfhgbdyPrhQDZLr36VYTFIimBre2O9tGcN+ClNowb01ssbId4Bj4SzXCx2mfm1EhgFdsuA12bcs
        P88dNg2C4r9gbW2T6oG7Hd87UXUA89I6xvAsUTQcTRNldr4hgynBt+A31rjIogLiN2Ki6ixRebJvk
        x2pfvt+9kvBQ0VtXf5UFLnoshY7soojwRNeBtn5/3rwxRy7jypB6RqqUv0+ic7NPYC8GPAc5B4A53
        ChIdphdw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDn-0012Tc-U8; Thu, 15 Sep 2022 11:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E90B302EC5;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F28E829AADBF2; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111147.680469665@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:25 +0200
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
Subject: [PATCH v3 46/59] x86/returnthunk: Allow different return thunks
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

From: Peter Zijlstra <peterz@infradead.org>

In preparation for call depth tracking on Intel SKL CPUs, make it possible
to patch in a SKL specific return thunk.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    6 ++++++
 arch/x86/kernel/alternative.c        |   19 ++++++++++++++-----
 arch/x86/kernel/ftrace.c             |    2 +-
 arch/x86/kernel/static_call.c        |    2 +-
 arch/x86/net/bpf_jit_comp.c          |    2 +-
 5 files changed, 23 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -198,6 +198,12 @@ extern void __x86_return_thunk(void);
 extern void zen_untrain_ret(void);
 extern void entry_ibpb(void);
 
+#ifdef CONFIG_CALL_THUNKS
+extern void (*x86_return_thunk)(void);
+#else
+#define x86_return_thunk	(&__x86_return_thunk)
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #define GEN(reg) \
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -509,6 +509,11 @@ void __init_or_module noinline apply_ret
 }
 
 #ifdef CONFIG_RETHUNK
+
+#ifdef CONFIG_CALL_THUNKS
+void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+#endif
+
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
@@ -524,14 +529,18 @@ static int patch_return(void *addr, stru
 {
 	int i = 0;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		return -1;
-
-	bytes[i++] = RET_INSN_OPCODE;
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+		if (x86_return_thunk == __x86_return_thunk)
+			return -1;
+
+		i = JMP32_INSN_SIZE;
+		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
+	} else {
+		bytes[i++] = RET_INSN_OPCODE;
+	}
 
 	for (; i < insn->length;)
 		bytes[i++] = INT3_INSN_OPCODE;
-
 	return i;
 }
 
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -359,7 +359,7 @@ create_trampoline(struct ftrace_ops *ops
 
 	ip = trampoline + size;
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, &__x86_return_thunk, JMP32_INSN_SIZE);
+		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
 
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -52,7 +52,7 @@ static void __ref __static_call_transfor
 
 	case RET:
 		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, &__x86_return_thunk);
+			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
 		break;
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -430,7 +430,7 @@ static void emit_return(u8 **pprog, u8 *
 	u8 *prog = *pprog;
 
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		emit_jump(&prog, &__x86_return_thunk, ip);
+		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_SLS))


