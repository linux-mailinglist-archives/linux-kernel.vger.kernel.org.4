Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7036A1EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBXPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBXPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F71671F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:42 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id o3so13338206qvr.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgwqEMh4NVAV5/z+1kf0xdWoVrFjbHnXgTZ0UxK4U+A=;
        b=A/qW8aPHMfBwwIk8xwVvReYCkRKJt3Wkfuk+H+kesyi8qO3eKXbjhqYBM3PHlxX2TJ
         J85Q2mjlchuUDRJu31HjMA9/59M19PXwu/J05kHydivGztJiMNPYROVpPBFn7I8+FJYr
         4xniQn2dgmRPA9y5Zg6wbMq+BitsGD5OiQOXFYJ2Uq+vFeQ2K5ZkITvG1ZS/cMhqy3ye
         4+x+KWLnJD+FhhPOvoeFpFlTrvKHIf/+MzKN7yCjBZQj98Lb5PGrXPwcVpcJMF4IxjOd
         H7m6TZsGPXVZF1nrZxXKvwNuNPSLrB+O53YbM1+bsKqyPRLMCG8al/QWuktYmiiiPhEp
         b98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgwqEMh4NVAV5/z+1kf0xdWoVrFjbHnXgTZ0UxK4U+A=;
        b=Fq7Kg1EELjVP59mpJXHmxd2YeKJ9XJxaLo48AtcIWJCHMtBQVt/SdngMwXOJHeIA/8
         xXp0egps3rxGemlYf/z50VOBc5l4PFyIGqj+MONi81nZu//Fs4B05Vhl8CqfjNAw8KTS
         wlGpqkHQvBvUoJgMcYvzRqxYFddq5ysRoilrGmGp1ymkoNX6Agl04gIIP+JEiW3rjVfY
         3WF6llKEUOzLS/hTBJbgM3Vp2bnNRVlJuaHRcA3rekEddFX6YPiFdNdBZjEg8MWRfkQ1
         hbZ+nQnAaewdLMQJKWxYyJRsjk1Kpg+Q6D5mYOP/r66+hkQYJLlxAL3Sy/FH6jWOlXnz
         8Hwg==
X-Gm-Message-State: AO0yUKXLefh1jwAyQe1+dH5etjploafVb7ltnLp5VZjjQ3Ih3q+jxYIb
        bOEUqVwOxK3qfv7cFSpgJiP+ywKhlQ==
X-Google-Smtp-Source: AK7set9eMLORCaRWXMiWW4eSdJsvRF9ubgz4as0YXJRNTFFEllaZ+CBvlglmO+cXoOepdnt2ju/3GA==
X-Received: by 2002:ad4:5748:0:b0:571:314:d725 with SMTP id q8-20020ad45748000000b005710314d725mr33296502qvx.49.1677253361626;
        Fri, 24 Feb 2023 07:42:41 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a015a00b0073b399700adsm1276131qkn.3.2023.02.24.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:42:41 -0800 (PST)
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
Subject: [PATCH v2 2/5] x86/smpboot: Remove early_gdt_descr on 64-bit
Date:   Fri, 24 Feb 2023 10:42:32 -0500
Message-Id: <20230224154235.277350-3-brgerst@gmail.com>
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

Build the GDT descriptor on the stack instead.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/acpi/sleep.c |  2 --
 arch/x86/kernel/head_64.S    | 19 +++++++------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 008fda8b1982..6538ddb55f28 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -114,8 +114,6 @@ int x86_acpi_suspend_lowlevel(void)
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	early_gdt_descr.address =
-			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
 	/* Force the startup into boot mode */
 	saved_smpboot_ctrl = xchg(&smpboot_control, 0);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f7905ba4b992..0dd57d573a0e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -245,7 +245,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_SMP
 	/*
 	 * Is this the boot CPU coming up? If so everything is available
-	 * in initial_gs and early_gdt_descr.
+	 * in initial_gs.
 	 */
 	movl	smpboot_control(%rip), %edx
 	testl	$STARTUP_SECONDARY, %edx
@@ -313,11 +313,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Save it for GS BASE setup */
 	movq	%rbx, initial_gs(%rip)
 
-	/* Calculate the GDT address */
-	movq	$gdt_page, %rcx
-	addq	%rbx, %rcx
-	movq	%rcx, early_gdt_descr_base(%rip)
-
 	movq	%rbx, %rdx
 #else
 	xorl	%edx, %edx
@@ -339,7 +334,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	early_gdt_descr(%rip)
+	subq	$16, %rsp
+	movw	$(GDT_SIZE-1), (%rsp)
+	leaq	gdt_page(%rdx), %rax
+	movq	%rax, 2(%rsp)
+	lgdt	(%rsp)
+	addq	$16, %rsp
 
 	/* set up data segments */
 	xorl %eax,%eax
@@ -754,11 +754,6 @@ SYM_DATA_END(level1_fixmap_pgt)
 
 	.data
 	.align 16
-
-SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
-SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
-
-	.align 16
 SYM_DATA(smpboot_control,		.long 0)
 
 	.align 16
-- 
2.39.2

