Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62308639FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiK1DD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1DD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:03:26 -0500
Received: from out0-155.mail.aliyun.com (out0-155.mail.aliyun.com [140.205.0.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7865A7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:03:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.QIQ9UlG_1669604600;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.QIQ9UlG_1669604600)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 11:03:21 +0800
Date:   Mon, 28 Nov 2022 11:03:20 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
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
Subject: Re: [PATCH v2] x86/paravirt: Use relative reference for original
 instruction
Message-ID: <20221128030320.GA101008@k08j02272.eu95sqa>
References: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
 <DD7871BE-B969-4E2E-BDF0-C5D730F0B0AE@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7871BE-B969-4E2E-BDF0-C5D730F0B0AE@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 09:24:34AM -0800, H. Peter Anvin wrote:
> On November 24, 2022 3:51:53 AM PST, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >Similar to the alternative patching, use relative reference for original
> >instruction rather than absolute one, which saves 8 bytes for one entry
> >on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
> >R_X86_64_64 relocation, which also reduces relocation metadata on
> >relocatable builds. And the alignment could be hard coded to be 4 now.
> >
> >Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> >---
> > arch/x86/include/asm/paravirt.h       | 10 +++++-----
> > arch/x86/include/asm/paravirt_types.h |  8 ++++----
> > arch/x86/kernel/alternative.c         |  8 +++++---
> > 3 files changed, 14 insertions(+), 12 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> >index 2851bc2339d5..e56065ea73f2 100644
> >--- a/arch/x86/include/asm/paravirt.h
> >+++ b/arch/x86/include/asm/paravirt.h
> >@@ -735,16 +735,16 @@ extern void default_banner(void);
> > 
> > #else  /* __ASSEMBLY__ */
> > 
> >-#define _PVSITE(ptype, ops, word, algn)		\
> >+#define _PVSITE(ptype, ops)			\
> > 771:;						\
> > 	ops;					\
> > 772:;						\
> > 	.pushsection .parainstructions,"a";	\
> >-	 .align	algn;				\
> >-	 word 771b;				\
> >+	 .align	4;				\
> >+	 .long 771b-.;				\
> > 	 .byte ptype;				\
> > 	 .byte 772b-771b;			\
> >-	 _ASM_ALIGN;				\
> >+	 .align 4;				\
> > 	.popsection
> > 
> > 
> >@@ -752,7 +752,7 @@ extern void default_banner(void);
> > #ifdef CONFIG_PARAVIRT_XXL
> > 
> > #define PARA_PATCH(off)		((off) / 8)
> >-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
> >+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
> > #define PARA_INDIRECT(addr)	*addr(%rip)
> > 
> > #ifdef CONFIG_DEBUG_ENTRY
> >diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> >index 8c1da419260f..68952ae07a3f 100644
> >--- a/arch/x86/include/asm/paravirt_types.h
> >+++ b/arch/x86/include/asm/paravirt_types.h
> >@@ -5,7 +5,7 @@
> > #ifndef __ASSEMBLY__
> > /* These all sit in the .parainstructions section to tell us what to patch. */
> > struct paravirt_patch_site {
> >-	u8 *instr;		/* original instructions */
> >+	s32 instr_offset;	/* original instructions */
> > 	u8 type;		/* type of this instruction */
> > 	u8 len;			/* length of original instruction */
> > };
> >@@ -273,11 +273,11 @@ extern struct paravirt_patch_template pv_ops;
> > #define _paravirt_alt(insn_string, type)		\
> > 	"771:\n\t" insn_string "\n" "772:\n"		\
> > 	".pushsection .parainstructions,\"a\"\n"	\
> >-	_ASM_ALIGN "\n"					\
> >-	_ASM_PTR " 771b\n"				\
> >+	"  .align 4\n"					\
> >+	"  .long 771b-.\n"				\
> > 	"  .byte " type "\n"				\
> > 	"  .byte 772b-771b\n"				\
> >-	_ASM_ALIGN "\n"					\
> >+	"  .align 4\n"					\
> > 	".popsection\n"
> > 
> > /* Generate patchable code, with the default asm parameters. */
> >diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> >index 111b809f0ac2..6eea563a098d 100644
> >--- a/arch/x86/kernel/alternative.c
> >+++ b/arch/x86/kernel/alternative.c
> >@@ -1232,20 +1232,22 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
> > {
> > 	struct paravirt_patch_site *p;
> > 	char insn_buff[MAX_PATCH_LEN];
> >+	u8 *instr;
> > 
> > 	for (p = start; p < end; p++) {
> > 		unsigned int used;
> > 
> >+		instr = (u8 *)&p->instr_offset + p->instr_offset;
> > 		BUG_ON(p->len > MAX_PATCH_LEN);
> > 		/* prep the buffer with the original instructions */
> >-		memcpy(insn_buff, p->instr, p->len);
> >-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
> >+		memcpy(insn_buff, instr, p->len);
> >+		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
> > 
> > 		BUG_ON(used > p->len);
> > 
> > 		/* Pad the rest with nops */
> > 		add_nops(insn_buff + used, p->len - used);
> >-		text_poke_early(p->instr, insn_buff, p->len);
> >+		text_poke_early(instr, insn_buff, p->len);
> > 	}
> > }
> > extern struct paravirt_patch_site __start_parainstructions[],
> 
> Any reason that you couldn't use the same patching code?

Sorry, what do you mean using the same patching code? Do you
mean that share some code between apply_alternatives() and
apply_paravirt()?
