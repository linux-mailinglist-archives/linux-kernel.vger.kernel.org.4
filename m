Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817374CFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGJIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGJIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB3E7;
        Mon, 10 Jul 2023 01:13:58 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOtDsWidxulmTHHJmhH5S2A/34jwRP1wgHitph7bleo=;
        b=CMAFuLvV6wWa7N1QaRCCIF/B4d4m3lIIsKs2JoZZ3w0NO+tCfCLRs9S8AQ0H99eZ43avSq
        L+EBT1WhAFH7fGUxx37mV0Nm66i6xsKVAqUMwWuWC7TlEQ9tUhvaQ3GcDEYS/48ch6hDr4
        Bx8gmoB0PBcz5G3HNkfkKt5XWUXGjUJpbQWTroZpol6HlKN9EU6Nvf8UEqiQtL710eHfBh
        ADAcMv+hHPuy0qRhSHxyVZCF/boW5ECqAZyWFNKDqGza4UzlYd6axujCpD9xybWc1BKPHR
        K1cGNDQs03lFnQ3POYrAYdS42/WnI3oY+MtSxqndPhkgNc6ozO3tJn4yygGPMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOtDsWidxulmTHHJmhH5S2A/34jwRP1wgHitph7bleo=;
        b=UoE61XaP+CqBT7jo5KbtTwuTHuI6MnB4xwFKnqpGlwqwNAeujkEEP53JPZgekTZuxpDt2M
        g96cji8O0w5zM/Cg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/32: Remove schedule_tail_wrapper()
Cc:     Brian Gerst <brgerst@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623225529.34590-2-brgerst@gmail.com>
References: <20230623225529.34590-2-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <168897683652.404.733058783899665441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     81f755d561f365f544795fad92f05a085ea4f292
Gitweb:        https://git.kernel.org/tip/81f755d561f365f544795fad92f05a085ea4f292
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 23 Jun 2023 18:55:28 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:24 +02:00

x86/32: Remove schedule_tail_wrapper()

The unwinder expects a return address at the very top of the kernel
stack just below pt_regs and before any stack frame is created.  Instead
of calling a wrapper, set up a return address as if ret_from_fork()
was called from the syscall entry code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20230623225529.34590-2-brgerst@gmail.com
---
 arch/x86/entry/entry_32.S | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 91397f5..e56123f 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -720,26 +720,6 @@ SYM_CODE_END(__switch_to_asm)
 .popsection
 
 /*
- * The unwinder expects the last frame on the stack to always be at the same
- * offset from the end of the page, which allows it to validate the stack.
- * Calling schedule_tail() directly would break that convention because its an
- * asmlinkage function so its argument has to be pushed on the stack.  This
- * wrapper creates a proper "end of stack" frame header before the call.
- */
-.pushsection .text, "ax"
-SYM_FUNC_START(schedule_tail_wrapper)
-	FRAME_BEGIN
-
-	pushl	%eax
-	call	schedule_tail
-	popl	%eax
-
-	FRAME_END
-	RET
-SYM_FUNC_END(schedule_tail_wrapper)
-.popsection
-
-/*
  * A newly forked process directly context switches into this address.
  *
  * eax: prev task we switched from
@@ -748,16 +728,23 @@ SYM_FUNC_END(schedule_tail_wrapper)
  */
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
-	call	schedule_tail_wrapper
+	/* return address for the stack unwinder */
+	pushl	$.Lsyscall_32_done
+
+	FRAME_BEGIN
+	pushl	%eax
+	call	schedule_tail
+	addl	$4, %esp
+	FRAME_END
 
 	testl	%ebx, %ebx
 	jnz	1f		/* kernel threads are uncommon */
 
 2:
 	/* When we fork, we trace the syscall return in the child, too. */
-	movl    %esp, %eax
+	leal    4(%esp), %eax
 	call    syscall_exit_to_user_mode
-	jmp     .Lsyscall_32_done
+	RET
 
 	/* kernel thread */
 1:	movl	%edi, %eax
