Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07CB73A395
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFVOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjFVOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:50:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CAE57
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LGsdeHWEpXVTOOsTrfyXxkvr7QjEX8WnxEDVS86hVu0=; b=Vc1PCzlgv53QVpsR+WDW+RQqb6
        hK7KNjrcjl+OM0sSOaXWHo1TLrdWF6Ft+sYwXsr6/tvfbojEmVncYsiUxhSWg/ccffx5Vp5h+E65l
        iTOfakYBU57ARcTK5pLhxLX1TwdYs+p+rSAi35g9L7X/LffRI+NRdtOrMWDspVfMgzmS1h0vWfayf
        92OwwNzhL4uiLlFDCTrtaT0x3lah4hMBUKxB/5tLAOxbTKp31oapEesD7UR1+ROiQbXFVLC2HgORi
        SQp/YPBNcgr0rmbQmi37UXBKkT/rDdl8fS3inb9MhS5FPUIHGwQtdpek14S6NsTFIbr4tFvPPh9nA
        mhbSdVtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCLdh-001CzP-1B;
        Thu, 22 Jun 2023 14:50:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3999330075E;
        Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 20EF6209D8B3E; Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Message-ID: <20230622144321.561264520@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 16:42:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Subject: [PATCH v2 4/6] x86/32: Remove schedule_tail_wrapper()
References: <20230622144218.860926475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

The unwinder expects a return address at the very top of the kernel
stack just below pt_regs and before any stack frame is created.  Instead
of calling a wrapper, set up a return address as if ret_from_fork()
was called from the syscall entry code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230622120750.5549-2-brgerst@gmail.com
---
 arch/x86/entry/entry_32.S |   32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

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
@@ -748,7 +728,13 @@ SYM_FUNC_END(schedule_tail_wrapper)
  */
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
-	call	schedule_tail_wrapper
+	/* return address for the stack unwinder */
+	pushl	$.Lsyscall_32_done
+	FRAME_BEGIN
+
+	pushl	%eax
+	call	schedule_tail
+	addl	$4, %esp
 
 	testl	%ebx, %ebx
 	jnz	1f		/* kernel threads are uncommon */
@@ -757,7 +743,9 @@ SYM_CODE_START(ret_from_fork)
 	/* When we fork, we trace the syscall return in the child, too. */
 	movl    %esp, %eax
 	call    syscall_exit_to_user_mode
-	jmp     .Lsyscall_32_done
+
+	FRAME_END
+	RET
 
 	/* kernel thread */
 1:	movl	%edi, %eax


