Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC360E6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiJZSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiJZSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:08:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D2B9A9D4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:08:28 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1C4D1EC06A7;
        Wed, 26 Oct 2022 20:08:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666807706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GoDDP+xnbVQ4x7skEFOwsY4I4Z3qguLizOfgJeu8odg=;
        b=C/6h2zxadK03BQiP92QBsVy+pue+mv7tPB/0IBZl3dZxIQH1gQSl61x6N5sAOOUgzWQCs8
        WksbWYRJtrxk9LCeu3yQItTLkWBHU8kjnPdruFoOuAo978RgWC2rMGjdTQ3cb/TpdjqsMn
        qjNAV4yuejOCVpC0OCcboxDHo77nmGY=
Date:   Wed, 26 Oct 2022 20:08:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/alternative: Consistently patch SMP locks in vmlinux
 and modules
Message-ID: <Y1l3lqPTNAcqwtRT@zn.tnic>
References: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:42:37AM +0200, Julian Pidancet wrote:
> The alternatives_smp_module_add() function restricts patching of SMP
> lock prefixes to the text address range passed as an argument.
> 
> For vmlinux, patching all the instructions located between the _text and
> _etext symbols is allowed. That includes the .text section but also
> other sections such as .text.hot and .text.unlikely.
> 
> As per the comment inside the 'struct smp_alt_module' definition, the
> original purpose of this restriction is to avoid patching the init code
> which may have been deallocated when the alternatives code run.
> 
> For modules, the current code only allows patching instructions located
> inside the .text segment, excluding other sections such as .text.hot or
> .text.unlikely, which may need patching.

Is this something you noticed by inspection or is there a real failure
behind it?

> This change aims to make patching of the kernel core and modules more

Avoid having "This patch" or "This commit" and so on, in the commit
message. It is tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> consistent, by allowing all text sections of modules except .init.text
> to be patched in module_finalize().
> 
> For that we use mod->core_layout.base/mod->core_layout.text_size as the

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> address range allowed to be patched, which include all the code sections
> except the init code.
> 
> Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
> ---
> Public tests: https://gist.github.com/jpidancet/1ee457623426f3e3902a28edaf2c80d0 

Looks like you wrote a module to verify that :)

> Related thread: https://marc.info/?t=130864398400006

Aha, someone else noticed this inconsistency.

>  arch/x86/kernel/module.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b1abf663417c..da22193eb5e0 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -251,14 +251,12 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
>  		    struct module *me)
>  {
> -	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
> -		*para = NULL, *orc = NULL, *orc_ip = NULL,
> -		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
> +	const Elf_Shdr *s, *alt = NULL, *locks = NULL, *para = NULL,
> +		*orc = NULL, *orc_ip = NULL, *retpolines = NULL,
> +		*returns = NULL, *ibt_endbr = NULL;
>  	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>  
>  	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
> -		if (!strcmp(".text", secstrings + s->sh_name))
> -			text = s;
>  		if (!strcmp(".altinstructions", secstrings + s->sh_name))
>  			alt = s;
>  		if (!strcmp(".smp_locks", secstrings + s->sh_name))
> @@ -302,12 +300,13 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		void *iseg = (void *)ibt_endbr->sh_addr;
>  		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
>  	}
> -	if (locks && text) {
> +	if (locks) {
>  		void *lseg = (void *)locks->sh_addr;
> -		void *tseg = (void *)text->sh_addr;
> +		void *text = me->core_layout.base;
> +		void *text_end = text + me->core_layout.text_size;
>  		alternatives_smp_module_add(me, me->name,
>  					    lseg, lseg + locks->sh_size,
> -					    tseg, tseg + text->sh_size);
> +					    text, text_end);
>  	}
>  
>  	if (orc && orc_ip)
> -- 

I don't see anything wrong with doing that on a quick glance...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
