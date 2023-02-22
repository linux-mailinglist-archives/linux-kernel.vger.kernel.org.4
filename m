Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAB69FE40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBVWOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjBVWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014162713
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:24 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x1so9804191qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZl87VAowiKqRTZnAo8837ZE4CLgK5LvrG7fNO1ZVqU=;
        b=jYzbenw1o4WXN7UaxcFUzN7LT/X3NE/lyfzPyQvKp/a3COZO15lUWzwS6saNXInRTi
         Ou/YHN0RnMFNntznqTHHshDdc292dsv+JpqZRmGXuiKAVA/eFRD6p59akg3shOdNz42O
         bR6wfBlbVwNk9FADxavCZWou7CQhd0FbFeDE9fCpnFeVD0dUrre5BcsWAmpe4Rpn402O
         A5oH2CnBkxtnrUUTZII/NdTnxrF1K9Pz7VbDisC3k1nE5lAeTUFwPduhlbnNEqzpHZ7Z
         PX5jKT9GoHtqkLXk0smZ8U6iuCPvy6OJO/CFHESfdjoH/71UwltmwW+shllu5Tqe2pvG
         3ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZl87VAowiKqRTZnAo8837ZE4CLgK5LvrG7fNO1ZVqU=;
        b=DebcNascAt8gTb0eB6YB8bhg7+JjbAGTeF8AfFG1hykhIUv1qgzUX7TGoiiLZKDWLZ
         9/T956GhSuCImDKuk5x84h3WDMnOy5v/LoiYbGiFPQOmni9+FAcnrBcWjhfSrwaUGDnO
         d0aM0QzzB2qha9ja/pTde103OljJGdhBcia9wRrrKumRKotrhtVBjgeuAqN/FSMD+PTd
         gJbd7YOC4LfFBMnQ2cytLF+Qiim2gn3QBCfqY/Olv6PTb6XuequdwnOpYoUp4shUdBjt
         VLATPqMRUCEXNXHJ5lujH5rnAogsUJJdsBAGiumMfb7fhXbaimB85WrNOYWQdMLB/NEX
         yKlw==
X-Gm-Message-State: AO0yUKUvXcst6rf2q4qUR7z4YA/zz5+GCUjatv1XdVP+OM/EhTOgz3DZ
        VZmtHlH9uARrfpZ/P5boGBDdrVIrAA==
X-Google-Smtp-Source: AK7set8pjyOZJpyw4AK24+y/4GfR1klo7ua0e3MNGMI1Rn4vmgQWqIMgSqsR493uhVD5Dwd79T7+Sg==
X-Received: by 2002:a05:622a:1483:b0:3b8:6b4c:aba8 with SMTP id t3-20020a05622a148300b003b86b4caba8mr19772710qtx.39.1677104003866;
        Wed, 22 Feb 2023 14:13:23 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:23 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/6] x86/smpboot: Remove initial_gs
Date:   Wed, 22 Feb 2023 17:13:00 -0500
Message-Id: <20230222221301.245890-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222221301.245890-1-brgerst@gmail.com>
References: <20230222221301.245890-1-brgerst@gmail.com>
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

