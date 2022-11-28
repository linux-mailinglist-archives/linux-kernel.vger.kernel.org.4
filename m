Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228A63A5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiK1KMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiK1KMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B001D8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D5B9B80CB4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E067C433D6;
        Mon, 28 Nov 2022 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669630346;
        bh=u89aOTJopm5tzMbQZRi0aLUZMGuYaAIU5HPAPaFbrYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tA71LX2K+I/jJhM2ALB1Ec6vFXPMSlU1IrsxnPGS5+n2LsZ6j2kLcz7LN7SMTuyk6
         9wtMzBJezeEAHf5Ew5IBV8D+wQVL03oD9yts9NtNtTVgXHTdgYVocg8VZ7+cPSyp04
         o312tL8/bGzH7xeK3WsLKEDB4w4+QlpGkFxy46Z8jepPCUtGVlhdaOuarSGLGMChsE
         VEFIJe/NNAqdJPGIZbnOuui9YlBmxM2S1XlWOo0K3REkR2Csy13OSLKntMDHBzgPZV
         6vUvyVtcWPQrUN8x8Yq7rkTxxyd/QVSD1YZcj9pok6dU0wgIP9RZDhsdKdHR7ItLbx
         So8WdNqib+bqg==
From:   guoren@kernel.org
To:     suagrfillet@gmail.com, guoren@kernel.org
Cc:     aou@eecs.berkeley.edu, bp@suse.de, jolsa@redhat.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        mhiramat@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org
Subject: [PATCH 2/2] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
Date:   Mon, 28 Nov 2022 05:12:01 -0500
Message-Id: <20221128101201.4144527-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221128101201.4144527-1-guoren@kernel.org>
References: <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
 <20221128101201.4144527-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
the ftrace-direct*.c files in samples/ftrace/.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
Below is modified by Guo Ren:

diff --git a/samples/ftrace/ftrace-direct-modify.c
b/samples/ftrace/ftrace-direct-modify.c
index 5582d000d803..d970b46ecc4e 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -29,6 +29,7 @@ asm ("        .pushsection    .text, \"ax\",
@progbits\n"
 "      .globl          my_tramp1\n"
 "   my_tramp1:\n"
 "      addi sp,sp,-16\n"
+"      move t0,t1\n"
 "      sd   t0,0(sp)\n"
 "      sd   ra,8(sp)\n"
 "      call my_direct_func1\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c
b/samples/ftrace/ftrace-direct-multi-modify.c
index 43e02d39c652..9534e18fa6ed 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -28,6 +28,7 @@ asm ("        .pushsection    .text, \"ax\",
@progbits\n"
 "   my_tramp1:\n"
 "       addi sp,sp,-24\n"
 "       sd   a0,0(sp)\n"
+"       move t0,t1\n"
 "       sd   t0,8(sp)\n"
 "       sd   ra,16(sp)\n"
 "       call my_direct_func1\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c
b/samples/ftrace/ftrace-direct-multi.c
index df91339d3095..2111478b0463 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -23,6 +23,7 @@ asm ("       .pushsection    .text, \"ax\",
@progbits\n"
 "   my_tramp:\n"
 "       addi sp,sp,-24\n"
 "       sd   a0,0(sp)\n"
+"       move t0,t1\n"
 "       sd   t0,8(sp)\n"
 "       sd   ra,16(sp)\n"
 "       call my_direct_func\n"
diff --git a/samples/ftrace/ftrace-direct-too.c
b/samples/ftrace/ftrace-direct-too.c
index fe3b8c4f3336..e80981d3dc0a 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -27,6 +27,7 @@ asm ("       .pushsection    .text, \"ax\",
@progbits\n"
 "       sd   a0,0(sp)\n"
 "       sd   a1,8(sp)\n"
 "       sd   a2,16(sp)\n"
+"       move t0,t1\n"
 "       sd   t0,24(sp)\n"
 "       sd   ra,32(sp)\n"
 "       call my_direct_func\n"
diff --git a/samples/ftrace/ftrace-direct.c
b/samples/ftrace/ftrace-direct.c
index 0784024b6653..b6cae1b5cb66 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -22,6 +22,7 @@ asm ("       .pushsection    .text, \"ax\",
@progbits\n"
 "   my_tramp:\n"
 "       addi sp,sp,-24\n"
 "       sd   a0,0(sp)\n"
+"       move t0,t1\n"
 "       sd   t0,8(sp)\n"
 "       sd   ra,16(sp)\n"
 "       call my_direct_func\n"
---
 arch/riscv/Kconfig                          |  2 ++
 samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 38 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 23 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 27 +++++++++++++++
 samples/ftrace/ftrace-direct.c              | 23 +++++++++++++
 6 files changed, 147 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2828537abfcd..0a1da03e88c2 100644
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
index 39146fa83e20..6a633ff4cf6d 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -22,6 +22,40 @@ extern void my_tramp2(void *);
 
 static unsigned long my_ip = (unsigned long)schedule;
 
+#ifdef CONFIG_RISCV
+
+asm ("	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi sp,sp,-16\n"
+"	move t0,t1\n"
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
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 65aa94d96f4e..9534e18fa6ed 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -20,6 +20,44 @@ void my_direct_func2(unsigned long ip)
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
+"       move t0,t1\n"
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
index 41ded7c615c7..2111478b0463 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -15,6 +15,29 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       move t0,t1\n"
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
index 6690468c5cc2..e80981d3dc0a 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -17,6 +17,33 @@ void my_direct_func(struct vm_area_struct *vma,
 
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
+"       move t0,t1\n"
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
index e8f1e440b9b8..b6cae1b5cb66 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -14,6 +14,29 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       move t0,t1\n"
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
2.36.1

