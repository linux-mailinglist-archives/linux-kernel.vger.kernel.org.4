Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2073C458
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjFWW4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFWW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:56:12 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8582727
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:37 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b720fd0e60so1089127a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687560936; x=1690152936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR6g0KQRb2O6Ea75fiXFjt5uQ0E9Sud+2f8NF24oWis=;
        b=Fqs5BbTMlJj5MYjaBUKQsQlninT9VZmCArJ2HxdceUWS00ICgJID4w2Dq8TyOjVogr
         04GoDeSjUMoxo4FrZEZ04tlnpMfE2iR/CdFXS6mbB8Nb08CrNE10naZ6AnQaWw/js6Pp
         GHnnvCKOTUmEzm40e9vG8IQr1bhcLzVaEpuPiuXq1oV+0fm5dtMfgDrc9hNinWJsxMtq
         989rzk6icXGq7lcMvOB+h4oEM9eSIgzauQTc+gWS8Vn05iO7dUh6J+G6koxWR3iHMxAS
         7CJj35HaR2DKiZiemXsDmrkO198MifN+FlGyqYxhWXUm4PzBLr7JKPtL6CkitMkkh7Yi
         3ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560936; x=1690152936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR6g0KQRb2O6Ea75fiXFjt5uQ0E9Sud+2f8NF24oWis=;
        b=E/joQfkW23W6mjjxJCI4wNtan+yW+mET18Lxu/SdKc3qmgrv4M1lkGkJ7CF4oxWCfj
         faXgIeNyTb/t4d1o4CtOgI4XgFewCpa3fpdHVUMFJVXAlBfo6Eg70RUGIJgTWBFkFVH/
         bN9+ej6fbFFcoUPgQAEujFotPHdtJd21Pc/Cp3guUbKX1ruEsffspF3kXG6JeNKJ9Vyr
         +C8nNzcFzD/QGtlFgqeidONVk8wW9XLp+dl9AZrMsqy0OMRiOeMJN7yfbeBaUJ7GWHDX
         l4Jdr6Vvort3VvVo6D2GGYpeDmTeX1cG8Jhb2nczunbCDATqI4F8czOPTUj5ohCPYuMu
         xhVw==
X-Gm-Message-State: AC+VfDxF7I4CZlcGUWrWgvGYKzYxrGNiTnPcGKluL+Exv9FqqfdXZok7
        o6oh8ExMm/Rb2+luYvzK9rvHuJkN/A==
X-Google-Smtp-Source: ACHHUZ6OZPxgXVFwsMzEuO4Ti2cVcu+JZ6dJ7zGreTJLKDXwxAtZWvr9CIp3/YZXTvqMxx3hOXVkDA==
X-Received: by 2002:a05:6830:60c:b0:6b7:24f7:ec0e with SMTP id w12-20020a056830060c00b006b724f7ec0emr2799713oti.26.1687560935722;
        Fri, 23 Jun 2023 15:55:35 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id b21-20020a9d5d15000000b006af9d8af435sm267479oti.50.2023.06.23.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:55:35 -0700 (PDT)
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
Subject: [PATCH v2 1/2] x86/32: Remove schedule_tail_wrapper()
Date:   Fri, 23 Jun 2023 18:55:28 -0400
Message-ID: <20230623225529.34590-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623225529.34590-1-brgerst@gmail.com>
References: <20230623225529.34590-1-brgerst@gmail.com>
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
 arch/x86/entry/entry_32.S | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 91397f58ac30..e56123f03a79 100644
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
-- 
2.41.0

