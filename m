Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3C6D2C33
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 03:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjDABBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 21:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjDABBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 21:01:13 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106D1D869
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 18:01:11 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 33110dwi1634686
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 31 Mar 2023 18:00:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 33110dwi1634686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023030901; t=1680310842;
        bh=iBrhDcT3pcdPV/Jo46PvXF1uBf1OgqTiWiIgTf+W7yg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hCEAS6SJ2kaiKIFHOuJ+aTkMldUo6d410GW3zcUCh5P6OaCFORIxXdOc7OUtBWxO9
         53mHf4jtgAOdfAwNp4D+Xmsv/hh12gYV2Ggfcg8Ycv8CltUp/64x0B1qNIFFGkt5Xf
         j77oG2GhlPeS6iJEpB9WcPt68vRJ09vQKFQUDKZPgbMz4dp0Lm6OjZEo7CqssuILSU
         ZVvlMd+FKOUgP24ZSiQF25FYqqXQ4S1BEh6yokJ5Ziae+YVCGDxbmvw01wRsfh/laR
         ebpYjj442qR1lnSfGwbAmT+mip90AMd6BBXY3YHyxHjGBH2+7EY6OtMzV4hWp2oF+Q
         7KBHFpvX+9lJg==
Date:   Fri, 31 Mar 2023 18:00:35 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/boot: Clean up handling of boot_params pointer
User-Agent: K-9 Mail for Android
In-Reply-To: <20230331182839.13960-1-brgerst@gmail.com>
References: <20230331182839.13960-1-brgerst@gmail.com>
Message-ID: <659B7DAA-7D24-4122-8A66-B490E0AFDEA0@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 31, 2023 11:28:39 AM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On entry from the bootloader, RSI contains the pointer to the
>boot_params data structure=2E  Since the RSI register can be clobbered
>when calling C functions, it is saved and restored around every call=2E
>Instead, move it to the R12 register, which is preserved across calls=2E
>
>Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>---
> arch/x86/kernel/head_64=2ES | 29 ++++++++++-------------------
> 1 file changed, 10 insertions(+), 19 deletions(-)
>
>diff --git a/arch/x86/kernel/head_64=2ES b/arch/x86/kernel/head_64=2ES
>index a5df3e994f04=2E=2E0d130ca2e0a3 100644
>--- a/arch/x86/kernel/head_64=2ES
>+++ b/arch/x86/kernel/head_64=2ES
>@@ -49,8 +49,6 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	 * for us=2E  These identity mapped page tables map all of the
> 	 * kernel pages and possibly all of memory=2E
> 	 *
>-	 * %rsi holds a physical pointer to real_mode_data=2E
>-	 *
> 	 * We come here either directly from a 64bit bootloader, or from
> 	 * arch/x86/boot/compressed/head_64=2ES=2E
> 	 *
>@@ -61,6 +59,12 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	 * tables and then reload them=2E
> 	 */
>=20
>+	/*
>+	 * RSI holds a physical pointer to real_mode_data=2E  Move it to R12,
>+	 * which is preserved across C function calls=2E
>+	 */
>+	movq	%rsi, %r12
>+
> 	/* Set up the stack for verify_cpu() */
> 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
>=20
>@@ -73,9 +77,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	shrq	$32,  %rdx
> 	wrmsr
>=20
>-	pushq	%rsi
> 	call	startup_64_setup_env
>-	popq	%rsi
>=20
> #ifdef CONFIG_AMD_MEM_ENCRYPT
> 	/*
>@@ -84,10 +86,8 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	 * which needs to be done before any CPUID instructions are executed in
> 	 * subsequent code=2E
> 	 */
>-	movq	%rsi, %rdi
>-	pushq	%rsi
>+	movq	%r12, %rdi
> 	call	sme_enable
>-	popq	%rsi
> #endif
>=20
> 	/* Now switch to __KERNEL_CS so IRET works reliably */
>@@ -109,9 +109,8 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	 * programmed into CR3=2E
> 	 */
> 	leaq	_text(%rip), %rdi
>-	pushq	%rsi
>+	movq	%r12, %rsi
> 	call	__startup_64
>-	popq	%rsi
>=20
> 	/* Form the CR3 value being sure to include the CR3 modifier */
> 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
>@@ -125,8 +124,6 @@ SYM_CODE_START(secondary_startup_64)
> 	 * At this point the CPU runs in 64bit mode CS=2EL =3D 1 CS=2ED =3D 0,
> 	 * and someone has loaded a mapped page table=2E
> 	 *
>-	 * %rsi holds a physical pointer to real_mode_data=2E
>-	 *
> 	 * We come here either from startup_64 (using physical addresses)
> 	 * or from trampoline=2ES (using virtual addresses)=2E
> 	 *
>@@ -197,13 +194,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
> 	 * hypervisor could lie about the C-bit position to perform a ROP
> 	 * attack on the guest by writing to the unencrypted stack and wait for
> 	 * the next RET instruction=2E
>-	 * %rsi carries pointer to realmode data and is callee-clobbered=2E Sav=
e
>-	 * and restore it=2E
> 	 */
>-	pushq	%rsi
> 	movq	%rax, %rdi
> 	call	sev_verify_cbit
>-	popq	%rsi
>=20
> 	/*
> 	 * Switch to new page-table
>@@ -294,9 +287,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
> 	wrmsr
>=20
> 	/* Setup and Load IDT */
>-	pushq	%rsi
> 	call	early_setup_idt
>-	popq	%rsi
>=20
> 	/* Check if nx is implemented */
> 	movl	$0x80000001, %eax
>@@ -332,9 +323,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
> 	pushq $0
> 	popfq
>=20
>-	/* rsi is pointer to real mode structure with interesting info=2E
>+	/* R12 is pointer to real mode structure with interesting info=2E
> 	   pass it to C */
>-	movq	%rsi, %rdi
>+	movq	%r12, %rdi
>=20
> =2ELjump_to_C_code:
> 	/*

Would it not make more sense to write it into a memory variable and access=
ing that variable from the C code by name?
