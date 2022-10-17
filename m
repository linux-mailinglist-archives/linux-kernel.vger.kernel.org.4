Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647866011AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJQOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJQOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD149B69;
        Mon, 17 Oct 2022 07:53:35 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT5/BcvC6Qp5TgWLuIIniP7KCiPJ7NyILpuDuar90fU=;
        b=Lsfz3018TTNu+jBaLoHCdAceM6VtNpNV+qLCgR7CsjkCdUJ6jk8/nQKnvMb6U1Zletn9LP
        T089vBp3LbiCUQ0l4xMKKKO8G3qxSlqedR9hwUnAILindXw8T6rq6ralqYL1bCdtUvpdUG
        7yJ8+50pkWvt6zlPdHGasREh40KmhDvlPUHgLbiQbnFRsHmuv+7w53DpMsotPEYFt/Vsrg
        AjcCaMQ43VzaIp4UqvPzpw7qfCjBU/Shm7dWKxyUHPV80e6IzV95a+2yCnxZFfW9/nRG/o
        tufZnrbGuNkscXR+ZlEj1bdpdKdPXT2s/wb0dIGzE7MwZ7m6BZWb176cYXDp9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT5/BcvC6Qp5TgWLuIIniP7KCiPJ7NyILpuDuar90fU=;
        b=24KK/A8HvN9x+GeunkRHKTJ2RYEZ5kSe8Sdp5Na3kOy6BT68us7/kZoKRuwTttmY+/Jk0l
        xRJRsLvuhZKr6mBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ftrace: Remove ftrace_epilogue()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.719080593@infradead.org>
References: <20220915111148.719080593@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841196.401.8504499250910970303.tip-bot2@tip-bot2>
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

Commit-ID:     eac828eaef295cd0cc8b58f55fa5c8401fdc2370
Gitweb:        https://git.kernel.org/tip/eac828eaef295cd0cc8b58f55fa5c8401fdc2370
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:18 +02:00

x86/ftrace: Remove ftrace_epilogue()

Remove the weird jumps to RET and simply use RET.

This then promotes ftrace_stub() to a real function; which becomes
important for kcfi.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.719080593@infradead.org
---
 arch/x86/kernel/ftrace_64.S | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index dfeb227..a90c55a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -172,20 +172,14 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-
-	jmp ftrace_epilogue
+	RET
 SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
-SYM_FUNC_START(ftrace_epilogue)
-/*
- * This is weak to keep gas from relaxing the jumps.
- */
-SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
+SYM_FUNC_START(ftrace_stub)
 	UNWIND_HINT_FUNC
-	ENDBR
 	RET
-SYM_FUNC_END(ftrace_epilogue)
+SYM_FUNC_END(ftrace_stub)
 
 SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
@@ -262,14 +256,11 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	popfq
 
 	/*
-	 * As this jmp to ftrace_epilogue can be a short jump
-	 * it must not be copied into the trampoline.
-	 * The trampoline will add the code to jump
-	 * to the return.
+	 * The trampoline will add the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-	jmp ftrace_epilogue
+	RET
 
 	/* Swap the flags with orig_rax */
 1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
@@ -280,7 +271,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
-	jmp	ftrace_epilogue
+	RET
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
