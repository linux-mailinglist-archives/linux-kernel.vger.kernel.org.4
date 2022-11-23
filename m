Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F0636189
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbiKWOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiKWOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:21:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D836586D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:43 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z26so17463262pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpISd1d/uhv2+upzDxICvohf61x5+Sa1ZjCwlVU0Tf0=;
        b=Y2tNspjdXDud07SoecBE7gvF/ldPswCAM3oeqKHCW1Fyjuz0133YIjEz5n6pA4wSOk
         HAUGIgas6x+bVwvRmIm5n7Fp5Y/k6rDJ4Yw/Mfk6gSOBSk+UVyDFZ1Sn0ZpJRYtHiRhx
         1JBpnnqHsFY8a9tq/uetUMeEi1FqzzrPLLNGhkd9fvKm+TnbaUSkWit6CDW2yiqrtYbX
         OJk8IkeL2nim0glmSzO5UiBXIqJP9cbCMzjtufg1eRfLX2n95tDE9m+qUOZbFCg4yOaY
         YfeZbdA9uf2ltO9y5eaZIVh1w0S6HxOGPgkFDAdIzBuVeO205/xY5E3bHQannje0RnqF
         x82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpISd1d/uhv2+upzDxICvohf61x5+Sa1ZjCwlVU0Tf0=;
        b=VN4W61EnvCZLlgWS9KYPls6WhUG5sX4zNT+Vw2dNepk+rIyLVF0G4k0j9Xuz79OStM
         NDlmhXH5fqkH6U3k0TheUdi+KKMOqZbG1UreTCvQ2sCGjQfSDRLy/kbA6sOS6NVMhGiu
         CUOQYWF0Nw7mCic0W9DaEkDZxwwEi7MPgoqV4Us1rIyliB+COQfUJFxUExfh/Gcd8O2p
         nsbPiRmW92nLCLGWNsMp84btPNBgUb9c706zZzukHb/y0QqZk1tkMsVj8bmlVECWMJiV
         eXo5oVFjymdZp4nyAjGao6d63koaA6NtAl81FMCK35r1MiIbRPUURvFCcgNS2r4azfLt
         5UqQ==
X-Gm-Message-State: ANoB5plsLIqwMKgS9ytSnNE38bGJS8pPVPvYGCiWmPAPwbO+pncmJn2Y
        KePtuomFz3aInwM9uOk9+Ws=
X-Google-Smtp-Source: AA0mqf6rnuo5eYZ5Q8KZ6gnEEZI+xbyqKhr4y2Gdiw/hYL3qOvvNWezCFQN1irYSyz5KyYy/jotCMQ==
X-Received: by 2002:aa7:9635:0:b0:56b:6936:ddf6 with SMTP id r21-20020aa79635000000b0056b6936ddf6mr8811622pfg.84.1669213242754;
        Wed, 23 Nov 2022 06:20:42 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016c5306917fsm14516732plh.53.2022.11.23.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:20:42 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH 2/2] samples/ftrace: add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
Date:   Wed, 23 Nov 2022 22:20:25 +0800
Message-Id: <20221123142025.1504030-3-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221123142025.1504030-1-suagrfillet@gmail.com>
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
the ftrace-direct*.c files in samples/ftrace/.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/Kconfig                          |  2 ++
 samples/ftrace/ftrace-direct-modify.c       | 35 ++++++++++++++++++-
 samples/ftrace/ftrace-direct-multi-modify.c | 37 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
 samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
 6 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d083ec08d0b6..572973103d73 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -279,6 +279,8 @@ config ARCH_RV64I
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 39146fa83e20..5582d000d803 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -17,10 +17,43 @@ void my_direct_func2(void)
 	trace_printk("my direct func2\n");
 }
 
+static unsigned long my_ip = (unsigned long)schedule;
+
 extern void my_tramp1(void *);
 extern void my_tramp2(void *);
 
-static unsigned long my_ip = (unsigned long)schedule;
+#ifdef CONFIG_RISCV
+
+asm ("	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi sp,sp,-16\n"
+"	sd   t0,0(sp)\n"
+"	sd   ra,8(sp)\n"
+"	call my_direct_func1\n"
+"	ld   t0,0(sp)\n"
+"	ld   ra,8(sp)\n"
+"	addi sp,sp,16\n"
+"	jr t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"	addi sp,sp,-16\n"
+"	sd   t0,0(sp)\n"
+"	sd   ra,8(sp)\n"
+"	call my_direct_func2\n"
+"	ld   t0,0(sp)\n"
+"	ld   ra,8(sp)\n"
+"	addi sp,sp,16\n"
+"	jr t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
 
 #ifdef CONFIG_X86_64
 
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 65aa94d96f4e..43e02d39c652 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -20,6 +20,43 @@ void my_direct_func2(unsigned long ip)
 extern void my_tramp1(void *);
 extern void my_tramp2(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func1\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"	jr t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func2\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"	jr t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 41ded7c615c7..df91339d3095 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -15,6 +15,28 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"       jr t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 6690468c5cc2..fe3b8c4f3336 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -17,6 +17,32 @@ void my_direct_func(struct vm_area_struct *vma,
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-40\n"
+"       sd   a0,0(sp)\n"
+"       sd   a1,8(sp)\n"
+"       sd   a2,16(sp)\n"
+"       sd   t0,24(sp)\n"
+"       sd   ra,32(sp)\n"
+"       call my_direct_func\n"
+"       ld   a0,0(sp)\n"
+"       ld   a1,8(sp)\n"
+"       ld   a2,16(sp)\n"
+"       ld   t0,24(sp)\n"
+"       ld   ra,32(sp)\n"
+"       addi sp,sp,40\n"
+"       jr t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index e8f1e440b9b8..0784024b6653 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -14,6 +14,28 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"       jr t0\n"
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

