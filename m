Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BEF66AB02
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjANKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 05:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjANKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 05:42:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C79658E
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 02:42:19 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA0481EC02DD;
        Sat, 14 Jan 2023 11:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673692937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nc4svnm9H0W9xUEpP10/xhOcrgg3qamuw2dYRSpReg8=;
        b=FBu23s47bcABn7WqFqaCJcH/R/AwYAWVJr/FTCTFTaImeYqkNeA0PxAPco/8mXoYN/U7wQ
        34j1nRfx0QjRwu1uHh61z1W+rm+sGN4M2Nq0Ex6Ksaa/Go5hrHNKOlwYzLHTFCub8P2DLq
        gzr4ZqMaxXYlNUaBIJb3/tXu3+a+GNI=
Date:   Sat, 14 Jan 2023 11:42:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: combine memmove FSRM and ERMS alternatives
Message-ID: <Y8KE2h8LSKsrkJhX@zn.tnic>
References: <20230113203427.1111689-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230113203427.1111689-1-dverkamp@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ lkml.

Always CC lkml on patches pls.

Ok, let's see. I hope the coffee's working already and I'm not missing an
aspect...

On Fri, Jan 13, 2023 at 12:34:27PM -0800, Daniel Verkamp wrote:
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 724bbf83eb5b..1fc36dbd3bdc 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -38,8 +38,10 @@ SYM_FUNC_START(__memmove)
>  
>  	/* FSRM implies ERMS => no length checks, do the copy directly */
>  .Lmemmove_begin_forward:
> -	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> -	ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
> +	ALTERNATIVE_2 \
> +		"cmp $0x20, %rdx; jb 1f", \
> +		"jmp .Lmemmove_erms", X86_FEATURE_FSRM, \
> +		"jmp .Lmemmove_erms", X86_FEATURE_ERMS

This is wrong in the ERMS case:

* If you have FSRM, you can simply do

	REP; MOVSB

as any size is handled fine. So that's ok. BUT:

* If you have ERMS, you need to jump to 1f for smaller sizes. ERMS makes sense
only for bigger than, well, we have 0x20 there.

So if you have ERMS, you can't simply replace:

	"cmp $0x20, %rdx; jb 1f"

with

	"jmp .Lmemmove_erms"

You still need that size check.

IOW, it should be something like this:

	ALTERNATIVE_2
		"cmp $0x20, %rdx; jb 1f; jmp .Lmemmove_erms", X86_FEATURE_ERMS,
		"jmp .Lmemmove_erms", X86_FEATURE_FSRM

But you can't have JMPs as NOT the first insn in alternatives because we fixup
the JMP offsets only for the first insn, see where recompute_jump() is called.

So, in order for the above to work, you'd need to use the insn decoder and look
at every insn in replacement and recompute_jump() it if it is a JMP.

And there are nice examples how to do that - see the loops in alternative.c
doing insn_decode_kernel().

Feel like getting your hands dirty with that?

:-)

Or, altenatively (pun intended), you can do what copy_user_generic() does and
move all that logic into C and inline asm. Which I'd prefer, actually, instead of
doing ugly asm hacks. Depends on how ugly it gets...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
