Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C826A1EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBXPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBXPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:46 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE6A6ADE4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:45 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id nf5so13775879qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tliLWqZo1ClCFllMBGoxhRkpYCPqcv1PK4tnZkLlMM0=;
        b=O2Uu3GbTz3FO7MHs1vCp97YWPwcz36gukuqk3vw3IuhBTAYf4vkn+mVDvu2zjRsCpm
         bEoOBul9nkV1MK3PRvbtKQhUZFkGJGeKTmixHzuujh2E5YmRo50KQgkpu9tqME5e11Q3
         Otk0IDQTM1xiknWW9sh+uqbDyqDBCa+0ZNqI5ZfY8NH+OF/+aU+qCuxVcrU/zUYCxxK1
         J/sNmbw1aZLj9DC347LlgUdyHatgBvMCRYPFCh8WpXgzZgZP6+kNeorMSpYBCNZeKDM5
         fvWEMSTpF22coIW9nCKJ6q9+x67rzknOj1Yb2+CV/flLhXeimewH+oDtb7tyogc9X491
         awXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tliLWqZo1ClCFllMBGoxhRkpYCPqcv1PK4tnZkLlMM0=;
        b=2lW7l3ziExeyrM7gAwjtuShGLzJykzpkGJRavtlPn7Y5m7N97bfPzqTd6vdNIVTofC
         7YaWAuH3NEON1tVaJlpSMTtH1SmBqQQ91MfFVN3Ck5Cer3ehBkcNsL6v2Yqzh+R3rKnx
         G5CeB9O0V2igvemrZPpt7B8/CvJdh9h5qEpB3aJ9GYSeztlTRnCzidsEi+Sfa2oE/cZV
         rwE4J1d5K2KkUSqbeFbNSkr6gDLh/oSMO8f+DwKTKvIKFRSED4B+jxvVjFmbPhrX0vld
         AfXzxSRPOLx5IXuQMfMAoyibZrU802tXcVP0fJEjKCMCzVlAYIaM+l8ntqfYeEcGb0J8
         akhQ==
X-Gm-Message-State: AO0yUKUY+DbAvTvAF+/pf8zi7Jg4/xUmNSLtwoKsX06Hoaqvja4bYfcj
        qpf9VouACLRKTGnTihx9xO89L/e4cQ==
X-Google-Smtp-Source: AK7set+H1d3jhAvT2EV/UtMS707IDVtG/4668+VsZMFIcDqSgJ1UMKaLb3d8tQFdweCWvbvV07FkSA==
X-Received: by 2002:a05:6214:e44:b0:56f:c948:411b with SMTP id o4-20020a0562140e4400b0056fc948411bmr26341454qvc.29.1677253364009;
        Fri, 24 Feb 2023 07:42:44 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a015a00b0073b399700adsm1276131qkn.3.2023.02.24.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:42:43 -0800 (PST)
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
Subject: [PATCH v2 4/5] x86/smpboot: Simplify boot CPU setup
Date:   Fri, 24 Feb 2023 10:42:34 -0500
Message-Id: <20230224154235.277350-5-brgerst@gmail.com>
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

Now that the per-cpu GSBASE, stack, and GDT descriptor can be derived
dynamically by CPU number, the boot CPU can use a fixed CPU number and
take the same path as secondary CPUs.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/head_64.S | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9ed87ba0609f..8bd29ab523dd 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -235,11 +235,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -250,13 +245,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -277,7 +272,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 .Lfind_cpunr:
 	cmpl	(%rbx,%rcx,4), %edx
-	jz	.Linit_cpu_data
+	jz	.Lsetup_cpu
 	inc	%ecx
 	cmpl	nr_cpu_ids(%rip), %ecx
 	jb	.Lfind_cpunr
@@ -291,18 +286,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
-- 
2.39.2

