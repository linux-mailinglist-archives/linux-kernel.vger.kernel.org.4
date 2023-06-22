Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98773A08A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFVMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjFVMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:08:12 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C91738
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:08:11 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55e0706af99so4957400eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687435690; x=1690027690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR0nU561LA4PHr72qcL73A0peyY9mwPpSm/pLNW6xqk=;
        b=V4li/iTD3iSKACmwnJ+QJZHDhDW3rlmgWfK4+AMPink0bZ+MP+BAogOq1pT+9WS0ZU
         SyN0j9pnmnZx1NG8VE5o6kxo9Mq29udRTqIMbVd3WlwYf3xGs1nNFLUpDeYvT+3/ynuh
         i3vnTPj5ssSZwdbDsLe5TdwaNCVozzFJHjYkw9Oq5I8G1yHl5+O7puMRchVKveaKZ8RR
         UHXTlOls/cncy3DS9yxhoA0giYxrdXk4JWbfdzMOyQBP6MqBVxYqCYFIg+eJ0qJVu7sL
         Az0ZL0WZLlGDzW6F9sltauRklnVaoirT0/z0xc5UofLwZ/qjAjffTB1rNgD9rrziR4wu
         01Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435690; x=1690027690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eR0nU561LA4PHr72qcL73A0peyY9mwPpSm/pLNW6xqk=;
        b=VROvB83kFesChw9hMPTUZhDtZhrXyzbFAt0IjZYC3f/ljNCZj7Rnu0u/trUPg5E495
         uEMZa6M2NJ+GGDEnVQs8zqHDVCjiCljZh63j7xgjgnBR4k8XzJVhMzIvUJmw5G54Sl1f
         5IDmglu6Rzy+aEm4kyDx5ntjwmUY/tQmW2s0BuCirVSe16uzwwrqJKN17HLXNZxPk2rZ
         bVT/pscQk+MZOhKRzssPqylY89iU6ll9bQSBxcqahRq29rQUZpuvXtF6WdttbPt+Bnq8
         A6boGRaSXLcKL3j9oLvRLqyrD7yub65nl+/iGD6LsjAbVfk3QVSlfOtU7pdk4jPua6c/
         VVmg==
X-Gm-Message-State: AC+VfDz87hCUKetUO87Y1ZSkxvqoHcSHeuZsgvY1EpmMrMKCmFujnu1V
        fq7++Fs9D/sSLefz5liFS/i0zDpKxw==
X-Google-Smtp-Source: ACHHUZ4tUKjG3y52DXZ+NJQc3nQ6HaYNmkZuLKNb1Wjl6RpmXMnLp0msZRwsD8ltZ3bW7yknXsoXhA==
X-Received: by 2002:a4a:d9c8:0:b0:55d:cc04:4968 with SMTP id l8-20020a4ad9c8000000b0055dcc044968mr7073277oou.3.1687435689861;
        Thu, 22 Jun 2023 05:08:09 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id m2-20020a4ae842000000b0054f85f67f31sm2705773oom.46.2023.06.22.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:08:09 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/2] x86/32: Remove schedule_tail_wrapper()
Date:   Thu, 22 Jun 2023 08:07:49 -0400
Message-ID: <20230622120750.5549-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622120750.5549-1-brgerst@gmail.com>
References: <20230622120750.5549-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unwinder expects a return address at the very top of the kernel
stack just below pt_regs and before any stack frame is created.  Instead
of calling a wrapper, set up a return address as if ret_from_fork()
was called from the syscall entry code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_32.S | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 91397f58ac30..6c1ee76adc11 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -719,26 +719,6 @@ SYM_CODE_START(__switch_to_asm)
 SYM_CODE_END(__switch_to_asm)
 .popsection
 
-/*
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
 /*
  * A newly forked process directly context switches into this address.
  *
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
-- 
2.41.0

