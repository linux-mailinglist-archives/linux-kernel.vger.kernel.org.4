Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234FD6A02F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjBWGud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjBWGuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:50:32 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349831ABDC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:50:31 -0800 (PST)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 31N6nSif2363059
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 22 Feb 2023 22:49:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 31N6nSif2363059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023020601; t=1677134970;
        bh=ikY9NwyVTiW1bsEu7tufpSeUXyWc3eiAkJsSOtBbJro=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=U+9F2DDNMV30/CcI1EVoQ2JpAcTpbBeEEbwwcrv/zOs3wsSjR2wcn/QP/WJRzJnV/
         cyt/OBSDRmf5OFjwD2kR1dZ3VVk1EQuvYm485WnfDJFsxH6Hg28E4GIaiibTsuctUu
         4uHG8RPB3w0MGZZZpaSnF5YWTYXERwirmyJzeU/hwRNwORuvo7mfvWPGHyG7UPvmhu
         IwW5xJg8RFs5DRBKCcMMMe79DQ5DJiTJhwxT80Oj/ggV7F3evMyTDIHsH2G2UElHb1
         XdNFGCy1lsG1lKT1665+Wp6ijFhNoPjr1ROInT9cSqaVdUxAuDccCwadQT+2AxXr8v
         CmL8cF3b86PbA==
Date:   Wed, 22 Feb 2023 22:49:26 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] x86/smpbppt: Remove early_gdt_descr on 64-bit
User-Agent: K-9 Mail for Android
In-Reply-To: <20230222221301.245890-5-brgerst@gmail.com>
References: <20230222221301.245890-1-brgerst@gmail.com> <20230222221301.245890-5-brgerst@gmail.com>
Message-ID: <47E3748A-47CB-4F83-9125-2570968C3280@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 22, 2023 2:12:59 PM PST, Brian Gerst <brgerst@gmail=2Ecom> wrot=
e:
>Build the GDT descriptor on the stack instead=2E
>
>Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>---
> arch/x86/kernel/acpi/sleep=2Ec |  2 --
> arch/x86/kernel/head_64=2ES    | 19 +++++++------------
> 2 files changed, 7 insertions(+), 14 deletions(-)
>
>diff --git a/arch/x86/kernel/acpi/sleep=2Ec b/arch/x86/kernel/acpi/sleep=
=2Ec
>index 008fda8b1982=2E=2E6538ddb55f28 100644
>--- a/arch/x86/kernel/acpi/sleep=2Ec
>+++ b/arch/x86/kernel/acpi/sleep=2Ec
>@@ -114,8 +114,6 @@ int x86_acpi_suspend_lowlevel(void)
> #else /* CONFIG_64BIT */
> #ifdef CONFIG_SMP
> 	current->thread=2Esp =3D (unsigned long)temp_stack + sizeof(temp_stack)=
;
>-	early_gdt_descr=2Eaddress =3D
>-			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
> 	initial_gs =3D per_cpu_offset(smp_processor_id());
> 	/* Force the startup into boot mode */
> 	saved_smpboot_ctrl =3D xchg(&smpboot_control, 0);
>diff --git a/arch/x86/kernel/head_64=2ES b/arch/x86/kernel/head_64=2ES
>index f7905ba4b992=2E=2E0dd57d573a0e 100644
>--- a/arch/x86/kernel/head_64=2ES
>+++ b/arch/x86/kernel/head_64=2ES
>@@ -245,7 +245,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
> #ifdef CONFIG_SMP
> 	/*
> 	 * Is this the boot CPU coming up? If so everything is available
>-	 * in initial_gs and early_gdt_descr=2E
>+	 * in initial_gs=2E
> 	 */
> 	movl	smpboot_control(%rip), %edx
> 	testl	$STARTUP_SECONDARY, %edx
>@@ -313,11 +313,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
> 	/* Save it for GS BASE setup */
> 	movq	%rbx, initial_gs(%rip)
>=20
>-	/* Calculate the GDT address */
>-	movq	$gdt_page, %rcx
>-	addq	%rbx, %rcx
>-	movq	%rcx, early_gdt_descr_base(%rip)
>-
> 	movq	%rbx, %rdx
> #else
> 	xorl	%edx, %edx
>@@ -339,7 +334,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
> 	 * addresses where we're currently running on=2E We have to do that her=
e
> 	 * because in 32bit we couldn't load a 64bit linear address=2E
> 	 */
>-	lgdt	early_gdt_descr(%rip)
>+	subq	$16, %rsp
>+	movw	$(GDT_SIZE-1), (%rsp)
>+	leaq	gdt_page(%rdx), %rax
>+	movq	%rax, 2(%rsp)
>+	lgdt	(%rsp)
>+	addq	$16, %rsp
>=20
> 	/* set up data segments */
> 	xorl %eax,%eax
>@@ -754,11 +754,6 @@ SYM_DATA_END(level1_fixmap_pgt)
>=20
> 	=2Edata
> 	=2Ealign 16
>-
>-SYM_DATA(early_gdt_descr,		=2Eword GDT_ENTRIES*8-1)
>-SYM_DATA_LOCAL(early_gdt_descr_base,	=2Equad INIT_PER_CPU_VAR(gdt_page))
>-
>-	=2Ealign 16
> SYM_DATA(smpboot_control,		=2Elong 0)
>=20
> 	=2Ealign 16

This is known to break at least some hypervisors, probably old by now, but=
=2E=2E=2E
