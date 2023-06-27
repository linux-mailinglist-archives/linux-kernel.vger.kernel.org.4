Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFC73FAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjF0LRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjF0LQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:16:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B72213A;
        Tue, 27 Jun 2023 04:16:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so124625b3a.2;
        Tue, 27 Jun 2023 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864602; x=1690456602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFNRYkJFul3uxQnpIVJKj4lTZ10bNSEM4pJM0DfkaGQ=;
        b=riD3tkb/ZxO7sMN6XdzjQcynh1Awf51wX5fjr/TV5g2bWLVQHFkKGLZef9j6vpnaba
         y38tYCvUPfdAdXbDaWYd8mDKqjC71Y9VDe2zFI1kQQA79D7gP7JEQenTyauoReqj/V38
         acQviFLaUFncSC7JFg0cnK3O7irJSAYY9nRTFuUwdYDjYD4zaP5NCWtRo475GOD2x0ZZ
         Z3gL2dIsEP+PlgdEfi7rnoZ6oAPxFTmQ2IZ75hNPrb1bBmhS6ZFJovclqAq/zP1sOhuS
         c2R+D9PhVAXaMQgqkwVPaaNWgsiyjevu1E1dsotLhPjfqOih+1Tlj+5Ia6ODSik85YkT
         w+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864602; x=1690456602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFNRYkJFul3uxQnpIVJKj4lTZ10bNSEM4pJM0DfkaGQ=;
        b=W3roM9eO4sNShpVSRrIAQclGD/TnnJZbpbFMyPTdOctpf16Iyd9hSzxPtHmBKUP9vW
         i8FaoZ7Iarj3qw41YX0nfnrrY5wxm6NLPNG7iNdNR/EohH5+2y5EUoi6mMvDvUwrLKDI
         6kYH9PA7Rzn05wZAAsNODtyIka8EYtIAogqL2wfR20Uz86UVp2QRBSFFqWkthDCHCkZH
         rB/PBh2qP9T5N612mfx7MiOLTAT69FEqxe5Yc242XQWnq8zig1Xaa2sPUFARmVbNhMe/
         64Zjs6MC10ErYj47J093bRWxoOEt8L3q0eg9g76ZVf+3R3ujsEdQZO7NZrwOaa5femeN
         oHBw==
X-Gm-Message-State: AC+VfDylBqrpNGxOR2GWUbYsaTmWeeUpUlT7jFXshSB/Qa18zX3qw3Pw
        MCV6F6+X2gy6k+faqYQSnIzoy8TBki4AbA==
X-Google-Smtp-Source: ACHHUZ60AzKSYLh8p4Rb4XirIuSFDC/Tbx/HHno5EeLmV9gTRD15P5HC35cYhK/BRHBchDAG9iVIMg==
X-Received: by 2002:a17:90a:ab0d:b0:25e:bd1d:4f0c with SMTP id m13-20020a17090aab0d00b0025ebd1d4f0cmr28286507pjq.10.1687864602484;
        Tue, 27 Jun 2023 04:16:42 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm5438658pjb.9.2023.06.27.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:16:42 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        bjorn@rivosinc.com, jszhang@kernel.org, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org,
        Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: [PATCH V11 4/5] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
Date:   Tue, 27 Jun 2023 19:16:11 +0800
Message-Id: <20230627111612.761164-5-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627111612.761164-1-suagrfillet@gmail.com>
References: <20230627111612.761164-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
the ftrace-direct*.c files in samples/ftrace/.

Link: https://lore.kernel.org/linux-riscv/c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com/T/#ma13012560331c66b051b580b3ab4a04ba44455ec
Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                          |  2 ++
 samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 27 ++++++++++++++
 samples/ftrace/ftrace-direct.c              | 23 ++++++++++++
 6 files changed, 150 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c3e678450acf..35d8255a12c6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -122,6 +122,8 @@ config RISCV
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 06d889149012..e90ca7b68314 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -22,6 +22,40 @@ extern void my_tramp2(void *);
 
 static unsigned long my_ip = (unsigned long)schedule;
 
+#ifdef CONFIG_RISCV
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi	sp,sp,-16\n"
+"	sd	t0,0(sp)\n"
+"	sd	ra,8(sp)\n"
+"	call	my_direct_func1\n"
+"	ld	t0,0(sp)\n"
+"	ld	ra,8(sp)\n"
+"	addi	sp,sp,16\n"
+"	jr	t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"	addi	sp,sp,-16\n"
+"	sd	t0,0(sp)\n"
+"	sd	ra,8(sp)\n"
+"	call	my_direct_func2\n"
+"	ld	t0,0(sp)\n"
+"	ld	ra,8(sp)\n"
+"	addi	sp,sp,16\n"
+"	jr	t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 62f6b681999e..5a81af7b3af3 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -20,6 +20,46 @@ void my_direct_func2(unsigned long ip)
 extern void my_tramp1(void *);
 extern void my_tramp2(void *);
 
+#ifdef CONFIG_RISCV
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"       addi	sp,sp,-24\n"
+"       sd	a0,0(sp)\n"
+"       sd	t0,8(sp)\n"
+"       sd	ra,16(sp)\n"
+"       mv	a0,t0\n"
+"       call	my_direct_func1\n"
+"       ld	a0,0(sp)\n"
+"       ld	t0,8(sp)\n"
+"       ld	ra,16(sp)\n"
+"       addi	sp,sp,24\n"
+"	jr	t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"       addi	sp,sp,-24\n"
+"       sd	a0,0(sp)\n"
+"       sd	t0,8(sp)\n"
+"       sd	ra,16(sp)\n"
+"       mv	a0,t0\n"
+"       call	my_direct_func2\n"
+"       ld	a0,0(sp)\n"
+"       ld	t0,8(sp)\n"
+"       ld	ra,16(sp)\n"
+"       addi	sp,sp,24\n"
+"	jr	t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 5482cf616b43..0e9bb94edade 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -15,6 +15,30 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi	sp,sp,-24\n"
+"       sd	a0,0(sp)\n"
+"       sd	t0,8(sp)\n"
+"       sd	ra,16(sp)\n"
+"       mv	a0,t0\n"
+"       call	my_direct_func\n"
+"       ld	a0,0(sp)\n"
+"       ld	t0,8(sp)\n"
+"       ld	ra,16(sp)\n"
+"       addi	sp,sp,24\n"
+"       jr	t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index a05bc2cc2261..5c319db48af2 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -17,6 +17,33 @@ void my_direct_func(struct vm_area_struct *vma,
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi	sp,sp,-40\n"
+"       sd	a0,0(sp)\n"
+"       sd	a1,8(sp)\n"
+"       sd	a2,16(sp)\n"
+"       sd	t0,24(sp)\n"
+"       sd	ra,32(sp)\n"
+"       call	my_direct_func\n"
+"       ld	a0,0(sp)\n"
+"       ld	a1,8(sp)\n"
+"       ld	a2,16(sp)\n"
+"       ld	t0,24(sp)\n"
+"       ld	ra,32(sp)\n"
+"       addi	sp,sp,40\n"
+"       jr	t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 06879bbd3399..ca95506b0350 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -14,6 +14,29 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi	sp,sp,-24\n"
+"       sd	a0,0(sp)\n"
+"       sd	t0,8(sp)\n"
+"       sd	ra,16(sp)\n"
+"       call	my_direct_func\n"
+"       ld	a0,0(sp)\n"
+"       ld	t0,8(sp)\n"
+"       ld	ra,16(sp)\n"
+"       addi	sp,sp,24\n"
+"       jr	t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
-- 
2.20.1

