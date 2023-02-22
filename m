Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77269FE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjBVWN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjBVWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:39 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B92D68
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:26 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b6so2959134qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKWSB76bpGFHfSMuRjbeX5BE0c7lf8Zs7C04cRyFq44=;
        b=SNEmnY6SbsIYNsIbyiBD4bfLXQZarAQFjf1PgWn08FxeWwnvPuspqhFkaTJd1+LpGs
         TTWkSFwf6h4emTlR7H3WRaqhiPm5khBQgmo7NuvAGYED8WJPcw6T7Vpwp+P/Zb+ozsXd
         XVuqdwaoRl/OQsUm0o409j7MR6cnh50XSCEzZnsn6Uf8Tts9tiwZO9RVdYYNPKcb99HG
         CWxO7Ye67f/R4M4zqDzn2+NaT6WOitGJsoPKc9vckemunHnSGUXNRzFxvjecbVCTe3cD
         hc7lzfgTNMCGiR7ou27YISwyCI4nU8PubrBOI6BDPtJeyV/TbbQXK7B4AT+JQSvaqr/D
         gG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKWSB76bpGFHfSMuRjbeX5BE0c7lf8Zs7C04cRyFq44=;
        b=rbRfVMcpReFxsFJ03qP+ONBF19wF9aMHqfV2c5sgteesC1WoES4yYZtV2R2wE74imy
         nPR93HaW4YBnLXczp0JxHbyAdxedaoM0aqxYiQUtaovAAhy4FEJkGAtrXGEf1LSCk9z9
         fiLrmdBfuOtuQ0sB8J1SFGTV/HZoc0YP/KToNO6w9yfqK43u/kiQZeY/OAL+a8o6gFbT
         RiJTQWFbr8N2K4uQdj2qgp3zM7cAPqLcYhjyrEs0D6HUXCMPywGK7wrJZibVqdAdejRN
         3pxKsvpVzHsL94G1ssVBT3WESrvJ6I8XIfOzrVjdf0GNDxC6X9wpelgFiWI2cs0yO/qA
         KtMg==
X-Gm-Message-State: AO0yUKWagj6rW4JWfQ0uM48qod4lm/AOIQMTm8ByQuut4ZS08gE5+yHJ
        DLu2hwbLkYtuVyMSZ+9D2AaQIQyhxQ==
X-Google-Smtp-Source: AK7set+WqWfCTFNa8+rLCgae4hcHWf16A8wYvxx+r5KTVl8ANeRkhImZhwopwzcNlYRh6/XlecxcSA==
X-Received: by 2002:ac8:5ad5:0:b0:3bb:7649:bd89 with SMTP id d21-20020ac85ad5000000b003bb7649bd89mr18887315qtd.61.1677104004977;
        Wed, 22 Feb 2023 14:13:24 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:24 -0800 (PST)
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
Subject: [PATCH 6/6] x86/smpboot: Simplify boot CPU setup
Date:   Wed, 22 Feb 2023 17:13:01 -0500
Message-Id: <20230222221301.245890-7-brgerst@gmail.com>
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

Now that the per-cpu GSBASE, stack, and GDT descriptor can be derived
dynammically by CPU number, the boot CPU can use a fixed CPU number and
take the same path as secondary CPUs.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/smp.h |  1 -
 arch/x86/kernel/head_64.S  | 25 +++++++------------------
 arch/x86/kernel/smpboot.c  |  6 +++---
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4b29e052b6e..32c9157238c0 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -202,7 +202,6 @@ extern unsigned int smpboot_control;
 #endif /* !__ASSEMBLY__ */
 
 /* Control bits for startup_64 */
-#define STARTUP_SECONDARY	0x80000000
 #define STARTUP_APICID_CPUID_0B	0x40000000
 #define STARTUP_APICID_CPUID_01	0x20000000
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9ed87ba0609f..949c13b26811 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -235,28 +235,22 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR // above
 
 #ifdef CONFIG_SMP
-	/* Is this the boot CPU coming up? */
-	movl	smpboot_control(%rip), %edx
-	testl	$STARTUP_SECONDARY, %edx
-	jz	.Linit_cpu0_data
-
 	/*
 	 * For parallel boot, the APIC ID is retrieved from CPUID, and then
 	 * used to look up the CPU number.  For booting a single CPU, the
 	 * CPU number is encoded in smpboot_control.
 	 *
-	 * Bit 31	STARTUP_SECONDARY flag (checked above)
 	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
 	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
 	 * Bit 0-24	CPU# if STARTUP_APICID_CPUID_xx flags are not set
 	 */
-	testl	$STARTUP_APICID_CPUID_0B, %edx
+	movl	smpboot_control(%rip), %ecx
+	testl	$STARTUP_APICID_CPUID_0B, %ecx
 	jnz	.Luse_cpuid_0b
-	testl	$STARTUP_APICID_CPUID_01, %edx
+	testl	$STARTUP_APICID_CPUID_01, %ecx
 	jnz	.Luse_cpuid_01
-	andl	$0x0FFFFFFF, %edx
-	movl	%edx, %ecx
-	jmp	.Linit_cpu_data
+	andl	$0x0FFFFFFF, %ecx
+	jmp	.Lsetup_cpu
 
 .Luse_cpuid_01:
 	mov	$0x01, %eax
@@ -277,7 +271,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 .Lfind_cpunr:
 	cmpl	(%rbx,%rcx,4), %edx
-	jz	.Linit_cpu_data
+	jz	.Lsetup_cpu
 	inc	%ecx
 	cmpl	nr_cpu_ids(%rip), %ecx
 	jb	.Lfind_cpunr
@@ -291,18 +285,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	hlt
 	jmp	1b
 
-.Linit_cpu0_data:
-	movq	__per_cpu_offset(%rip), %rdx
-	jmp	.Lsetup_cpu
-
-.Linit_cpu_data:
+.Lsetup_cpu:
 	/* Get the per cpu offset for the given CPU# which is in ECX */
 	movq	__per_cpu_offset(,%rcx,8), %rdx
 #else
 	xorl	%edx, %edx
 #endif /* CONFIG_SMP */
 
-.Lsetup_cpu:
 	/*
 	 * Setup a boot time stack - Any secondary CPU will have lost its stack
 	 * by now because the cr3-switch above unmaps the real-mode stack
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1a2843c2841..c159a5c2df9f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1140,7 +1140,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  = idle->thread.sp;
 	} else if (!do_parallel_bringup) {
-		smpboot_control = STARTUP_SECONDARY | cpu;
+		smpboot_control = cpu;
 	}
 
 	/* Enable the espfix hack for this CPU */
@@ -1580,7 +1580,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		 */
 		if (eax) {
 			pr_debug("Using CPUID 0xb for parallel CPU startup\n");
-			smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_0B;
+			smpboot_control = STARTUP_APICID_CPUID_0B;
 		} else {
 			pr_info("Disabling parallel bringup because CPUID 0xb looks untrustworthy\n");
 			do_parallel_bringup = false;
@@ -1588,7 +1588,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	} else if (do_parallel_bringup) {
 		/* Without X2APIC, what's in CPUID 0x01 should suffice. */
 		pr_debug("Using CPUID 0x1 for parallel CPU startup\n");
-		smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_01;
+		smpboot_control = STARTUP_APICID_CPUID_01;
 	}
 
 	if (do_parallel_bringup) {
-- 
2.39.2

