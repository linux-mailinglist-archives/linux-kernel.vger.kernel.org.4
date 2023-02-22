Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A369FE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjBVWNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjBVWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:38 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7916269E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w23so9165558qtn.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/4x9pKiWHQd4E9PHb0AStQCoTUIAgCrnRCTs6gjCBg=;
        b=bq5W5DCO6zteSItMu7IDxWg0jtdy8N6ZOUsZFYI4Vr05QFSPAVgMMRnA6zUY+tOrAF
         GVWiTHmEkbq38U5+QK9+aWiuuuPkT7npWFu1ZXam+cwCnSmDQqfJ4AYzh8MfTp6q6bO6
         v767B9ashF+IX6xrk//Pw5X5srWJn0H2F7Kwcd+nn+Cr1RFxjbgE3xVw4nFkLMVwjpeq
         xx1R30EJ7OKV8xZmuu7Dj6oCfR7qKq1SzCaKKXnAf/x7wcX8tn7EXFVWVl7E3L+pzrE4
         1TGDCzFEU/ROJBP/HrKEQA34whLuXfeTaa05ilWfAUuedpMiPMzuk9AZ8X9ae/+xjhP9
         FPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/4x9pKiWHQd4E9PHb0AStQCoTUIAgCrnRCTs6gjCBg=;
        b=HRsJOlWRp5KJ/HBab1okzvIQhqkTJnvoOiuEAa9mb2hrlvqiVHL980spirqlKlpD7t
         OuAUoxIKGzjiGBExJGr6Be/ycKvC/w58Gok4Jx8KNfhISnUdXlEtA4BvEjtkE82MX1e+
         O7qUGEf0dR0E14o+Q2eQ8uDMSA/yCdrrVUVSsk7P0eiSBi4UZcXHrpR+I+5/pc7gF0tT
         x7TtHQsHNvU/FUFvh/cO1yJXR6bDiL8dQqtXc5RC9mNYwtszWBBi+8HQqOgEeUmCK+2t
         PeAAj6m4M3JuQ9egpNif/czMTrRaYQOFnvkBOZUvJrnKPU/tIFCy6GKzxvqcedpQyFzZ
         eQgw==
X-Gm-Message-State: AO0yUKUMyFbK3ravVCNoXcGgYcZlap1Df3wq1dpwguXg7EOzKHMQT0C3
        Y7UUrCcXckmA0yCiawMCStuhtqZqMw==
X-Google-Smtp-Source: AK7set8VhrBFVUDZAsuO6MKEQN7b3zUGUuRcxvvKJs/rfLseKH1Y8j57Lr2lm7q4FztP3nQ82ww+YA==
X-Received: by 2002:ac8:5850:0:b0:3b3:b92f:3650 with SMTP id h16-20020ac85850000000b003b3b92f3650mr2410995qth.62.1677104002589;
        Wed, 22 Feb 2023 14:13:22 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:22 -0800 (PST)
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
Subject: [PATCH 4/6] x86/smpbppt: Remove early_gdt_descr on 64-bit
Date:   Wed, 22 Feb 2023 17:12:59 -0500
Message-Id: <20230222221301.245890-5-brgerst@gmail.com>
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

Build the GDT descriptor on the stack instead.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
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

