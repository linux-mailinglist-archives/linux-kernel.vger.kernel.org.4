Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF315637722
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKXLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKXLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:07:09 -0500
Received: from out0-138.mail.aliyun.com (out0-138.mail.aliyun.com [140.205.0.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE45FB95
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:07:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.QFrPKRt_1669288013;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.QFrPKRt_1669288013)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 19:06:53 +0800
Date:   Thu, 24 Nov 2022 19:06:53 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] x86/paravirt: Use relative reference for original
 instruction
Message-ID: <20221124110653.GA88913@k08j02272.eu95sqa>
References: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>
 <aa4c49a6-65f2-d04c-ee0d-afb9e1262dea@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4c49a6-65f2-d04c-ee0d-afb9e1262dea@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 11:18:52AM +0100, Juergen Gross wrote:
> On 24.11.22 09:51, Hou Wenlong wrote:
> >Similar to the alternative patching, use relative reference for original
> >instruction rather than absolute one, which saves 8 bytes for one entry
> >on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
> 
> 8 bytes saved? I think those are 4 bytes only.
>
The corresponding C structure paravirt_patch_site is not packed, Before this,
its size is 16 bytes in x86_64£¬due to the alignment of 8 bytes. Now the alignment
is 4 bytes, so the size is 8 bytes.

> >R_X86_64_64 relocation, which also reduces relocation metadata on
> >relocatable builds.
> >
> >Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> >---
> >  arch/x86/include/asm/paravirt.h       | 6 +++---
> >  arch/x86/include/asm/paravirt_types.h | 4 ++--
> >  arch/x86/kernel/alternative.c         | 8 +++++---
> >  3 files changed, 10 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> >index 2851bc2339d5..2cbe9b64e103 100644
> >--- a/arch/x86/include/asm/paravirt.h
> >+++ b/arch/x86/include/asm/paravirt.h
> >@@ -735,13 +735,13 @@ extern void default_banner(void);
> >  #else  /* __ASSEMBLY__ */
> >-#define _PVSITE(ptype, ops, word, algn)		\
> >+#define _PVSITE(ptype, ops, algn)		\
> 
> Would you please drop the algn parameter, too? It isn't needed anymore
> as the alignment can be hard coded to be 4 now. This would need to be
> adjusted in the _paravirt_alt() macro, too.
> 
OK, since the aligment is 4 bytes now, it seems that _ASM_ALIGN could
be dropped too?

> >  771:;						\
> >  	ops;					\
> >  772:;						\
> >  	.pushsection .parainstructions,"a";	\
> >  	 .align	algn;				\
> >-	 word 771b;				\
> >+	 .long 771b-.;				\
> >  	 .byte ptype;				\
> >  	 .byte 772b-771b;			\
> >  	 _ASM_ALIGN;				\
> >@@ -752,7 +752,7 @@ extern void default_banner(void);
> >  #ifdef CONFIG_PARAVIRT_XXL
> >  #define PARA_PATCH(off)		((off) / 8)
> >-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
> >+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, 8)
> >  #define PARA_INDIRECT(addr)	*addr(%rip)
> >  #ifdef CONFIG_DEBUG_ENTRY
> >diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> >index 8c1da419260f..19f709cf7df9 100644
> >--- a/arch/x86/include/asm/paravirt_types.h
> >+++ b/arch/x86/include/asm/paravirt_types.h
> >@@ -5,7 +5,7 @@
> >  #ifndef __ASSEMBLY__
> >  /* These all sit in the .parainstructions section to tell us what to patch. */
> >  struct paravirt_patch_site {
> >-	u8 *instr;		/* original instructions */
> >+	s32 instr_offset;	/* original instructions */
> >  	u8 type;		/* type of this instruction */
> >  	u8 len;			/* length of original instruction */
> >  };
> >@@ -274,7 +274,7 @@ extern struct paravirt_patch_template pv_ops;
> >  	"771:\n\t" insn_string "\n" "772:\n"		\
> >  	".pushsection .parainstructions,\"a\"\n"	\
> >  	_ASM_ALIGN "\n"					\
> >-	_ASM_PTR " 771b\n"				\
> >+	"  .long 771b-.\n"				\
> >  	"  .byte " type "\n"				\
> >  	"  .byte 772b-771b\n"				\
> >  	_ASM_ALIGN "\n"					\
> >diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> >index 111b809f0ac2..6eea563a098d 100644
> >--- a/arch/x86/kernel/alternative.c
> >+++ b/arch/x86/kernel/alternative.c
> >@@ -1232,20 +1232,22 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
> >  {
> >  	struct paravirt_patch_site *p;
> >  	char insn_buff[MAX_PATCH_LEN];
> >+	u8 *instr;
> >  	for (p = start; p < end; p++) {
> >  		unsigned int used;
> >+		instr = (u8 *)&p->instr_offset + p->instr_offset;
> >  		BUG_ON(p->len > MAX_PATCH_LEN);
> >  		/* prep the buffer with the original instructions */
> >-		memcpy(insn_buff, p->instr, p->len);
> >-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
> >+		memcpy(insn_buff, instr, p->len);
> >+		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
> >  		BUG_ON(used > p->len);
> >  		/* Pad the rest with nops */
> >  		add_nops(insn_buff + used, p->len - used);
> >-		text_poke_early(p->instr, insn_buff, p->len);
> >+		text_poke_early(instr, insn_buff, p->len);
> >  	}
> >  }
> >  extern struct paravirt_patch_site __start_parainstructions[],
> 
> 
> Juergen

> pub  2048R/28BF132F 2014-06-02 Juergen Gross <jg@pfupf.net>
> uid                            Juergen Gross <jgross@suse.com>
> uid                            Juergen Gross <jgross@novell.com>
> uid                            Juergen Gross <jgross@suse.de>
> sub  2048R/16375B53 2014-06-02




