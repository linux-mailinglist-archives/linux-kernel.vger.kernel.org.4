Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68866ADD5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjANUtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjANUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:49:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C35255
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:49:06 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 661921EC03D6;
        Sat, 14 Jan 2023 21:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673729345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DfVTsxZCeN35tH4Z4isb1sKi8CCdb0TNdIbmOMJDUqI=;
        b=rRl3bvNQTkW5FqYkIvhcqwUQ/qGUiwgyWSknOkBJTSSeUTbpCGqEZ6+tFlaPj1UJVLrmtT
        Dw4lB70t1RKtE48fPGBIxl2EQTcSNqfdLI/bXo1K3g5jD7g3ZcmgGBSSVC5IwoYL5PRGTL
        ru0w1Xz7sUQwsAgijuHGIl3QSy7Wzvk=
Date:   Sat, 14 Jan 2023 21:49:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: combine memmove FSRM and ERMS alternatives
Message-ID: <Y8MVPcgWLZspXJxq@zn.tnic>
References: <20230113203427.1111689-1-dverkamp@chromium.org>
 <Y8KE2h8LSKsrkJhX@zn.tnic>
 <Y8LVmIeUP4cw0oJS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8LVmIeUP4cw0oJS@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 05:17:28PM +0100, Borislav Petkov wrote:
> On Sat, Jan 14, 2023 at 11:42:13AM +0100, Borislav Petkov wrote:
> > Or, altenatively (pun intended), you can do what copy_user_generic() does and
> > move all that logic into C and inline asm. Which I'd prefer, actually, instead of
> > doing ugly asm hacks. Depends on how ugly it gets...
> 
> Alternatively #2, you can do the below as a minimal fix for stable along with
> explaining what we're doing there and why and then do the other things I
> suggested - if you'd like, that is - later and with no pressure.
> 
> Thx.
> 
> ---
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 02661861e5dd..d6ffb4164cdb 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -38,10 +38,9 @@ SYM_FUNC_START(__memmove)
>  	cmp %rdi, %r8
>  	jg 2f
>  
> -	/* FSRM implies ERMS => no length checks, do the copy directly */
>  .Lmemmove_begin_forward:
>  	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> -	ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
> +	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "jmp .Lmemmove_erms", X86_FEATURE_ERMS

Forget what I said - now that I think of it this is bull.

The more and more I think about it, the more I like the copy_user_generic() idea
but lemme see how ugly it gets...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
