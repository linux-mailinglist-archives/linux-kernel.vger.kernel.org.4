Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC26011C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJQOyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiJQOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D768CEF;
        Mon, 17 Oct 2022 07:53:51 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brruPqTqUU9fTZWrUqRiiP3PaFtkap8CCYjIT4ZdseI=;
        b=XhcETwL9/4Ecs6DeNtG1KKKYGxVa3tGl3S3+PW7rtbcLRSSR/ySOj1lyKdNS9SGERist9H
        De1ikr32ieh9bfgIh07oYibHlCAgzxdwzOg75/fFfqwtJaBQnKeGLrYrogfNNwxUj33Yb6
        jXi099CpfcHmAjbXhIysxB9KXdNZnHfZilu1WctoYZUDncw0t28v+pnca0O0YsVvXurAob
        Ext7B7f8M8wifEOsqHRQu3+ITiMSvqDFccJghOSiynGlAjK5x1KD0qyvHzCMMp71M/WYN5
        Nro2xuBFJBEODARdDjZj3tipF6I490E9hEhqm2Ortmrsg9Arij0BMZYTNetzvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brruPqTqUU9fTZWrUqRiiP3PaFtkap8CCYjIT4ZdseI=;
        b=0LP8jHaXnKb3gY7nHHc/oK4FNDd97hynmoYhZrUomBcmbft34QJCFDz1FYWLUbdXokDSD/
        QIkB46YE6HdP/rCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/returnthunk: Allow different return thunks
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.680469665@infradead.org>
References: <20220915111147.680469665@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842272.401.18030395061124314174.tip-bot2@tip-bot2>
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

Commit-ID:     770ae1b709528a6a173b5c7b183818ee9b45e376
Gitweb:        https://git.kernel.org/tip/770ae1b709528a6a173b5c7b183818ee9b45e376
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:14 +02:00

x86/returnthunk: Allow different return thunks

In preparation for call depth tracking on Intel SKL CPUs, make it possible
to patch in a SKL specific return thunk.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.680469665@infradead.org
---
 arch/x86/include/asm/nospec-branch.h |  6 ++++++
 arch/x86/kernel/alternative.c        | 17 +++++++++++++----
 arch/x86/kernel/ftrace.c             |  2 +-
 arch/x86/kernel/static_call.c        |  2 +-
 arch/x86/net/bpf_jit_comp.c          |  2 +-
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c936ce9..f10ca33 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -208,6 +208,12 @@ extern void __x86_return_thunk(void);
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 963872d..04d1e3d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -518,6 +518,11 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
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
@@ -533,14 +538,18 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 {
 	int i = 0;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		return -1;
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+		if (x86_return_thunk == __x86_return_thunk)
+			return -1;
 
-	bytes[i++] = RET_INSN_OPCODE;
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
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 00eac45..4ac6692 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -359,7 +359,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	ip = trampoline + size;
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, &__x86_return_thunk, JMP32_INSN_SIZE);
+		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
 
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index aaaba85..5d3844a 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -52,7 +52,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 
 	case RET:
 		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, &__x86_return_thunk);
+			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
 		break;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9962042..0df391e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -432,7 +432,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 	u8 *prog = *pprog;
 
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		emit_jump(&prog, &__x86_return_thunk, ip);
+		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_SLS))
