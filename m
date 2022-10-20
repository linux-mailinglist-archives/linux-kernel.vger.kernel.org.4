Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34411606429
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJTPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJTPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:19:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B1153E08;
        Thu, 20 Oct 2022 08:18:57 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:17:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666279079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXnO+9US1ohgLnA0cDOxbGyf76pFnVkIvvO1mJ/t/80=;
        b=dP3UdzrbJp51J2b71Coe4JN0bVt6aMgcnyrC3FsyyGVFSdFCmU1Sf0Vyl1rkG9AWJ+RW8c
        rpHc3LNcj4iAd+XX8m7KfpurLGLcWW6KMYxjox+anG0iNHKzx1sMEY/COktWRvFH30xBhL
        SK8UwKLG206Ywj0DqgoE6JyYFXpTrTmhEmWzhIvPUAFH/73nIFGW/kWwGkspT1UWkbPABJ
        qd2febZ95mOp2GA5cD3lI9TKRS4Ca2ptM6mrzJRrbmY64I0OrzDzRvMWmrdsxzuqkrtOz0
        CuOEhBhyywz6/3U0L++awBU/coV1JQg7TQcjh9fc/5NL6eu3DLsBN8RNVRcQ8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666279079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXnO+9US1ohgLnA0cDOxbGyf76pFnVkIvvO1mJ/t/80=;
        b=cM0oXgVODLnYPQ1bpnt9WalKno7YQzU9LgVk8VY3U10q3/waDAMt0Pw+BpIYWS37u3ZH/+
        mAVzO+sRVWpVuvCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ftrace: Remove ftrace_epilogue()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.719080593@infradead.org>
References: <20220915111148.719080593@infradead.org>
MIME-Version: 1.0
Message-ID: <166627907851.401.17695370739230342384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b5f1fc3184405ab955db1b86d41d8b744d07c12d
Gitweb:        https://git.kernel.org/tip/b5f1fc3184405ab955db1b86d41d8b744d07c12d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Oct 2022 17:10:27 +02:00

x86/ftrace: Remove ftrace_epilogue()

Remove the weird jumps to RET and simply use RET.

This then promotes ftrace_stub() to a real function; which becomes
important for kcfi.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.719080593@infradead.org
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
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
