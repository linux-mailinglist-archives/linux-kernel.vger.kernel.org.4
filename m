Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4586FEEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbjEKJdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjEKJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:33:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02602A268;
        Thu, 11 May 2023 02:32:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6438d95f447so5857480b3a.3;
        Thu, 11 May 2023 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683797577; x=1686389577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Um+q3GAJJdwCHUz925rKpngWorIxf9/k65Kv/Jmfkk=;
        b=YBxri1PZvS15/BxoWHnchNjvi+HHQm3BdR6WRsk34v+dVANVyYSb7uJ21hmF0lZ0Ma
         AyEadXzk6+PlhYXNyjHOcg90/cOaFludWJSVIUB91rdYwas8fOgIJAXM58foybf1jast
         r4WNLPMkzz6dYob5+poX2QQSoN362sYpGKD28cLboUxKpMghBmWA+lCryIIbzGIbcLGD
         8AGtRiDTVPYoXRIz/pO4kvAn930rFIjAVuKTOn5Qwa3IaK99YCL2kuD8KilCa+XLf4Ee
         lsCn6zBOwycKwC2KMI83rAMAMtf5IjjeoQQydGE0uSwzxisrfklcBUTSCp4XkReH0wyT
         kLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797577; x=1686389577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Um+q3GAJJdwCHUz925rKpngWorIxf9/k65Kv/Jmfkk=;
        b=fnb7D1ZcluAu6zFcsvhDOq53k9MowaXlFys7Bhyzu8mlNHBMJgicRuK9rLK/mBQOaY
         BojJ0RLlP81IH2ZOkyqStPEt6vsQ2BBH79mJTasSFjxzP3LCCrGm1jKWaH1f7iZ6hQrg
         0xEfsSYnryJN3m1N9r5RsJl0EvvOZY2pwKqoLnKM2K3zpOkIC21kb4QSCeFs6oGWLl6M
         1p/0jjcUhSdl4Ar5qEfoWIKbm9UVBQTCQtMAPAimVgyZ81eH9Ku9JyLeehUGtzR8JR8t
         o7MXF8XdFO8CLZnsc+6v8sVSXphIdcAZUo8nlrZoye8C8ZiMI7San7FdKLPNANDnXQ+1
         jPOw==
X-Gm-Message-State: AC+VfDw8h9cZBGUB8MCDf6upsTngVdcUFHP8z4J4TpAHaRBCCmDvyBFc
        KcyKlk7V8I/T7Aeri8IXAG8=
X-Google-Smtp-Source: ACHHUZ57rQA+tZLmOzeENDpNF17v0MZDjE9hj1prPs2rUYppjFTD7BQ5rzlbXSoMbf9VYu2EVEzJvw==
X-Received: by 2002:a05:6a21:7891:b0:101:47d8:ff80 with SMTP id bf17-20020a056a21789100b0010147d8ff80mr12860676pzc.41.1683797577442;
        Thu, 11 May 2023 02:32:57 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b00627e87f51a5sm4875400pfn.161.2023.05.11.02.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:32:57 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        jszhang@kernel.org, e.shatokhin@yadro.com, bjorn@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH V10 4/4] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
Date:   Thu, 11 May 2023 17:32:34 +0800
Message-Id: <20230511093234.3123181-5-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230511093234.3123181-1-suagrfillet@gmail.com>
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
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
index fdf0b219a02c..cb94ef086f0c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -121,6 +121,8 @@ config RISCV
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

