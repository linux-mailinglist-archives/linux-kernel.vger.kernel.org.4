Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD586A1EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBXPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBXPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:46 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CDE6A9CD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cf14so4657299qtb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkpL2g7L2sQ+6ZxUM2vC2iNXW2IcArehGjgvwIpbvEw=;
        b=Xhb7nQliM0PER/Dw9ahi/hPKBHv/E6io/C+U0Omq1Ib5xL2ZrelvvLuQB7ZktxhFPc
         r9CsY9S01DXv+SmTttclUjHJuOc2bVKe6wSdIIkoNLEhFk3mpSrhGOWo0lmck88atSVM
         OCcMGV9DV7og10HrnvCQqia3ybm6vi4zVjea0QMBjTH0/caexqkXwVyXm2llf2mfXiGR
         7XgMtLIydlaLS5Ir8fmEbdx4VMumQK9v7+vyCAo+4iJUgcFWkB0j30FcVW7W5bAUSvKv
         etwkIM+1qmZt5cMzQYG2M5nQmaqxSlaPcPWTpi/Wq8KoVXwvQ9pXg/sAvdGPgWBe1SFW
         H2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkpL2g7L2sQ+6ZxUM2vC2iNXW2IcArehGjgvwIpbvEw=;
        b=X0d+5wkNAJoDOoOmQ+P5gNdidhL4pcBXMac/lqS2duUmfGThQW0TWMt5/oRIr6YhN6
         Nnun6IKA4RSiKA7gtXMrbekHi/Ofo6vLdV95xnX52PKsnMafhk85U1F38I3M4i+nRCpg
         idU+AMawKM8uv2iPizwlyeJGoMJaeKTPS3ggwxPpPP30Wjv+nAEJu7ywGfdw/1NYqIrs
         gNs/zo+9DbNAb2FLXp87Yu/8G6AgrtiEH+ZcNC2IwkLoUL5JXHR/lOpVJK8zXFyGc1G4
         PDgExi2k/Neq0l4Ww07/vSIVpc3YV9ght6ZNeSD9KhJsCqkj9D7cSQalZdQUatisbS+w
         +J/A==
X-Gm-Message-State: AO0yUKXDu6UD7rq4oBxYyFQa2hB+L6sL4P9+6Rj13OH68q9ga3emR/Q0
        Z714z486te/u2GfSDI0Rp4DLzd94sA==
X-Google-Smtp-Source: AK7set+cmIv0LaIQRYRGTGGFQorfxHDYOT5+6QbE/5lz3if5/FqHTkBT5gAoKJNdKwZDPkUCImvw0Q==
X-Received: by 2002:ac8:598c:0:b0:3bd:efa:baf with SMTP id e12-20020ac8598c000000b003bd0efa0bafmr30729870qte.19.1677253362756;
        Fri, 24 Feb 2023 07:42:42 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a015a00b0073b399700adsm1276131qkn.3.2023.02.24.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:42:42 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 3/5] x86/smpboot: Remove initial_gs
Date:   Fri, 24 Feb 2023 10:42:33 -0500
Message-Id: <20230224154235.277350-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224154235.277350-1-brgerst@gmail.com>
References: <20230224154235.277350-1-brgerst@gmail.com>
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

Use the percpu offset directly to set GSBASE.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/include/asm/realmode.h |  1 -
 arch/x86/kernel/acpi/sleep.c    |  1 -
 arch/x86/kernel/head_64.S       | 34 ++++++++++-----------------------
 3 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f0357cfe2fb0..87e5482acd0d 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -60,7 +60,6 @@ extern struct real_mode_header *real_mode_header;
 extern unsigned char real_mode_blob_end[];
 
 extern unsigned long initial_code;
-extern unsigned long initial_gs;
 extern unsigned long initial_stack;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern unsigned long initial_vc_handler;
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 6538ddb55f28..214dd4a79860 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -114,7 +114,6 @@ int x86_acpi_suspend_lowlevel(void)
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	initial_gs = per_cpu_offset(smp_processor_id());
 	/* Force the startup into boot mode */
 	saved_smpboot_ctrl = xchg(&smpboot_control, 0);
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0dd57d573a0e..9ed87ba0609f 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -67,18 +67,10 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	leaq	_text(%rip), %rdi
 
-	/*
-	 * initial_gs points to initial fixed_percpu_data struct with storage for
-	 * the stack protector canary. Global pointer fixups are needed at this
-	 * stage, so apply them as is done in fixup_pointer(), and initialize %gs
-	 * such that the canary can be accessed at %gs:40 for subsequent C calls.
-	 */
+	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
-	movq	initial_gs(%rip), %rax
-	movq	$_text, %rdx
-	subq	%rdx, %rax
-	addq	%rdi, %rax
-	movq	%rax, %rdx
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	movl	%edx, %eax
 	shrq	$32,  %rdx
 	wrmsr
 
@@ -243,10 +235,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR // above
 
 #ifdef CONFIG_SMP
-	/*
-	 * Is this the boot CPU coming up? If so everything is available
-	 * in initial_gs.
-	 */
+	/* Is this the boot CPU coming up? */
 	movl	smpboot_control(%rip), %edx
 	testl	$STARTUP_SECONDARY, %edx
 	jz	.Linit_cpu0_data
@@ -308,12 +297,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 .Linit_cpu_data:
 	/* Get the per cpu offset for the given CPU# which is in ECX */
-	leaq	__per_cpu_offset(%rip), %rbx
-	movq	(%rbx,%rcx,8), %rbx
-	/* Save it for GS BASE setup */
-	movq	%rbx, initial_gs(%rip)
-
-	movq	%rbx, %rdx
+	movq	__per_cpu_offset(,%rcx,8), %rdx
 #else
 	xorl	%edx, %edx
 #endif /* CONFIG_SMP */
@@ -363,8 +347,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movl	initial_gs(%rip),%eax
-	movl	initial_gs+4(%rip),%edx
+#ifndef CONFIG_SMP
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#endif
+	movl	%edx, %eax
+	shrq	$32, %rdx
 	wrmsr
 
 	/* Drop the realmode protection. For the boot CPU the pointer is NULL! */
@@ -514,7 +501,6 @@ SYM_CODE_END(vc_boot_ghcb)
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
-SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
-- 
2.39.2

