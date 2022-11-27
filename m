Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A759639BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiK0RZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0RZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:25:38 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4FBE05
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 09:25:37 -0800 (PST)
Received: from [IPv6:::1] ([172.58.89.136])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2ARHOi1Z2093772
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 27 Nov 2022 09:24:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2ARHOi1Z2093772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022110601; t=1669569889;
        bh=onPExFmU8kkDJicwNe4UEJNsfvddfveagmwBV0peyQU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=NHYCvpXsp/ej6cChBHv4IZey+MpDNtOP153kT6q+1lkUcddgqbCQctt7ZJavPuKow
         wM+C8IDe4rN/2IwkfmDL4Ooqh2xRUhJyyaspcqB3B8x7sxdBeKYE4jJUQHBhEorK/d
         J45x8wLVIgjVz/f47R7056grkkrSONeUo/b/trUNNbW4xF1bDQwk/U0J30lmSCwpIH
         afmtjY/2TE4KkC7XQfF1PbyTl3IfecaW8QY4tow83uxl9rvU4HlwaKDZUjhlJErD8W
         jEhZbaX9w+h1rOijCQxgKpzpF0S+ymspT0uqQKrhFCzNJg04H2ToHX7VofGVIiL531
         tyHdqpzK4XK7w==
Date:   Sun, 27 Nov 2022 09:24:34 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org
CC:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        virtualization@lists.linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/paravirt=3A_Use_relat?= =?US-ASCII?Q?ive_reference_for_original_instruction?=
User-Agent: K-9 Mail for Android
In-Reply-To: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
References: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
Message-ID: <DD7871BE-B969-4E2E-BDF0-C5D730F0B0AE@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 24, 2022 3:51:53 AM PST, Hou Wenlong <houwenlong=2Ehwl@antgroup=
=2Ecom> wrote:
>Similar to the alternative patching, use relative reference for original
>instruction rather than absolute one, which saves 8 bytes for one entry
>on x86_64=2E  And it could generate R_X86_64_PC32 relocation instead of
>R_X86_64_64 relocation, which also reduces relocation metadata on
>relocatable builds=2E And the alignment could be hard coded to be 4 now=
=2E
>
>Signed-off-by: Hou Wenlong <houwenlong=2Ehwl@antgroup=2Ecom>
>---
> arch/x86/include/asm/paravirt=2Eh       | 10 +++++-----
> arch/x86/include/asm/paravirt_types=2Eh |  8 ++++----
> arch/x86/kernel/alternative=2Ec         |  8 +++++---
> 3 files changed, 14 insertions(+), 12 deletions(-)
>
>diff --git a/arch/x86/include/asm/paravirt=2Eh b/arch/x86/include/asm/par=
avirt=2Eh
>index 2851bc2339d5=2E=2Ee56065ea73f2 100644
>--- a/arch/x86/include/asm/paravirt=2Eh
>+++ b/arch/x86/include/asm/paravirt=2Eh
>@@ -735,16 +735,16 @@ extern void default_banner(void);
>=20
> #else  /* __ASSEMBLY__ */
>=20
>-#define _PVSITE(ptype, ops, word, algn)		\
>+#define _PVSITE(ptype, ops)			\
> 771:;						\
> 	ops;					\
> 772:;						\
> 	=2Epushsection =2Eparainstructions,"a";	\
>-	 =2Ealign	algn;				\
>-	 word 771b;				\
>+	 =2Ealign	4;				\
>+	 =2Elong 771b-=2E;				\
> 	 =2Ebyte ptype;				\
> 	 =2Ebyte 772b-771b;			\
>-	 _ASM_ALIGN;				\
>+	 =2Ealign 4;				\
> 	=2Epopsection
>=20
>=20
>@@ -752,7 +752,7 @@ extern void default_banner(void);
> #ifdef CONFIG_PARAVIRT_XXL
>=20
> #define PARA_PATCH(off)		((off) / 8)
>-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, =2Equad, 8)
>+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
> #define PARA_INDIRECT(addr)	*addr(%rip)
>=20
> #ifdef CONFIG_DEBUG_ENTRY
>diff --git a/arch/x86/include/asm/paravirt_types=2Eh b/arch/x86/include/a=
sm/paravirt_types=2Eh
>index 8c1da419260f=2E=2E68952ae07a3f 100644
>--- a/arch/x86/include/asm/paravirt_types=2Eh
>+++ b/arch/x86/include/asm/paravirt_types=2Eh
>@@ -5,7 +5,7 @@
> #ifndef __ASSEMBLY__
> /* These all sit in the =2Eparainstructions section to tell us what to p=
atch=2E */
> struct paravirt_patch_site {
>-	u8 *instr;		/* original instructions */
>+	s32 instr_offset;	/* original instructions */
> 	u8 type;		/* type of this instruction */
> 	u8 len;			/* length of original instruction */
> };
>@@ -273,11 +273,11 @@ extern struct paravirt_patch_template pv_ops;
> #define _paravirt_alt(insn_string, type)		\
> 	"771:\n\t" insn_string "\n" "772:\n"		\
> 	"=2Epushsection =2Eparainstructions,\"a\"\n"	\
>-	_ASM_ALIGN "\n"					\
>-	_ASM_PTR " 771b\n"				\
>+	"  =2Ealign 4\n"					\
>+	"  =2Elong 771b-=2E\n"				\
> 	"  =2Ebyte " type "\n"				\
> 	"  =2Ebyte 772b-771b\n"				\
>-	_ASM_ALIGN "\n"					\
>+	"  =2Ealign 4\n"					\
> 	"=2Epopsection\n"
>=20
> /* Generate patchable code, with the default asm parameters=2E */
>diff --git a/arch/x86/kernel/alternative=2Ec b/arch/x86/kernel/alternativ=
e=2Ec
>index 111b809f0ac2=2E=2E6eea563a098d 100644
>--- a/arch/x86/kernel/alternative=2Ec
>+++ b/arch/x86/kernel/alternative=2Ec
>@@ -1232,20 +1232,22 @@ void __init_or_module apply_paravirt(struct parav=
irt_patch_site *start,
> {
> 	struct paravirt_patch_site *p;
> 	char insn_buff[MAX_PATCH_LEN];
>+	u8 *instr;
>=20
> 	for (p =3D start; p < end; p++) {
> 		unsigned int used;
>=20
>+		instr =3D (u8 *)&p->instr_offset + p->instr_offset;
> 		BUG_ON(p->len > MAX_PATCH_LEN);
> 		/* prep the buffer with the original instructions */
>-		memcpy(insn_buff, p->instr, p->len);
>-		used =3D paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p=
->len);
>+		memcpy(insn_buff, instr, p->len);
>+		used =3D paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->l=
en);
>=20
> 		BUG_ON(used > p->len);
>=20
> 		/* Pad the rest with nops */
> 		add_nops(insn_buff + used, p->len - used);
>-		text_poke_early(p->instr, insn_buff, p->len);
>+		text_poke_early(instr, insn_buff, p->len);
> 	}
> }
> extern struct paravirt_patch_site __start_parainstructions[],

Any reason that you couldn't use the same patching code?
