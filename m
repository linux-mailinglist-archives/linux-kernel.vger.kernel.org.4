Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D146D27D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjCaS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCaS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:29:02 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7CC2221D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:28:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bz27so22543388qtb.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680287325; x=1682879325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qjJep1HmOCTR3Eny7tDFLbXtP/kalBCqoJWt+veltE=;
        b=LexCKPpN46jlEmLP62RZqmlhaFRViTp+87zM1dokeh2OhRX5V1a4TbjAkbI8AqCuzD
         yMRzxE8ycPAqR2hJn3nC7AAh4n4hd8pkULmyaywYJAaSXuOXCTnAkfqW0ICMnQogDqMU
         v6RcC3SfA3vVSBV9ACr7RuuDCvWOl6nVsctmAbaOzdMu3wrhRPhUHIUGoqGfv/43dB/R
         SPTxkaA2+3SfcwveUnKN6wNy4BueLtQfGVre0y9TFirG7Ov4T5TmoQQspaUCFSp2NgEG
         +mGEZOr7fekfhuq1sL8790dOqT63ZZAyKdayu/ilBttOJLqR5ZtifsaUfqGqJrShcef6
         sS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287325; x=1682879325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qjJep1HmOCTR3Eny7tDFLbXtP/kalBCqoJWt+veltE=;
        b=iYbJzvQbU9w7iMKkyL4ASs1Sz0sA8cLCMe/x6o6bf6u2UhDtRYr5d8RgpP1dmIAjNB
         vLsxEcBRbBG4XIT2FCTJfmnnhhVYXvP0ntgkNIt9KR0yZkcUFo2m8SxHzhpdGS41VwpX
         78mOPiAYUSD//VxF1gYDeS2zyjfimjqsT+aUj3tB3mZm+Mu5jtiHp3lRSOrb7syJ3t3F
         2GuPHqBW2RrMA+5AetmSGseHYCeK2+GkL9Qaq/Scu/+3HmARlGlD1JTVeD5HwvXTbSoh
         Tprj88NUH0o2pTts3DBwwJ8BvQeSHdkl7NdoQ6MvLR01R4fYaLcet5PggrYgWGMLN9OC
         z9bQ==
X-Gm-Message-State: AO0yUKUh7XA6ioMf4OHs5IDikokHKf33WgPldPH4gaklXHI9JfxJdHbz
        6qvgJgzzqS9/Ab6ywIC0rZoXtpUuGQ==
X-Google-Smtp-Source: AK7set8FuFRAykraJZSmRvSk11vTjQJTY8G3eXLdOoIHt0mypNVpAsYKLo8sN8OtcjZxSHd9ZxGPaw==
X-Received: by 2002:a05:622a:1003:b0:3d2:a192:3d93 with SMTP id d3-20020a05622a100300b003d2a1923d93mr48303173qte.8.1680287324912;
        Fri, 31 Mar 2023 11:28:44 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id b26-20020ac8679a000000b003e6356d28acsm254927qtp.20.2023.03.31.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:28:44 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/boot: Clean up handling of boot_params pointer
Date:   Fri, 31 Mar 2023 14:28:39 -0400
Message-Id: <20230331182839.13960-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On entry from the bootloader, RSI contains the pointer to the
boot_params data structure.  Since the RSI register can be clobbered
when calling C functions, it is saved and restored around every call.
Instead, move it to the R12 register, which is preserved across calls.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/head_64.S | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e994f04..0d130ca2e0a3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -49,8 +49,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * for us.  These identity mapped page tables map all of the
 	 * kernel pages and possibly all of memory.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
-	 *
 	 * We come here either directly from a 64bit bootloader, or from
 	 * arch/x86/boot/compressed/head_64.S.
 	 *
@@ -61,6 +59,12 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * tables and then reload them.
 	 */
 
+	/*
+	 * RSI holds a physical pointer to real_mode_data.  Move it to R12,
+	 * which is preserved across C function calls.
+	 */
+	movq	%rsi, %r12
+
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
@@ -73,9 +77,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	pushq	%rsi
 	call	startup_64_setup_env
-	popq	%rsi
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
@@ -84,10 +86,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * which needs to be done before any CPUID instructions are executed in
 	 * subsequent code.
 	 */
-	movq	%rsi, %rdi
-	pushq	%rsi
+	movq	%r12, %rdi
 	call	sme_enable
-	popq	%rsi
 #endif
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
@@ -109,9 +109,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
+	movq	%r12, %rsi
 	call	__startup_64
-	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
@@ -125,8 +124,6 @@ SYM_CODE_START(secondary_startup_64)
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
-	 *
 	 * We come here either from startup_64 (using physical addresses)
 	 * or from trampoline.S (using virtual addresses).
 	 *
@@ -197,13 +194,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * hypervisor could lie about the C-bit position to perform a ROP
 	 * attack on the guest by writing to the unencrypted stack and wait for
 	 * the next RET instruction.
-	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
-	 * and restore it.
 	 */
-	pushq	%rsi
 	movq	%rax, %rdi
 	call	sev_verify_cbit
-	popq	%rsi
 
 	/*
 	 * Switch to new page-table
@@ -294,9 +287,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	wrmsr
 
 	/* Setup and Load IDT */
-	pushq	%rsi
 	call	early_setup_idt
-	popq	%rsi
 
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
@@ -332,9 +323,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	pushq $0
 	popfq
 
-	/* rsi is pointer to real mode structure with interesting info.
+	/* R12 is pointer to real mode structure with interesting info.
 	   pass it to C */
-	movq	%rsi, %rdi
+	movq	%r12, %rdi
 
 .Ljump_to_C_code:
 	/*
-- 
2.39.2

