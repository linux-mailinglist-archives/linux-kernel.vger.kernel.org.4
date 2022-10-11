Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EEA5FB170
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJKL2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJKL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:28:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FD84E4D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:28:20 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1BF41EC0518;
        Tue, 11 Oct 2022 13:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665487695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VDHDm6Gir98v074DFtxeAypUwf4edMomZuBJuk5Dcxw=;
        b=dSGqwiHwR1TJBayS5oNp+VjEO7KvcySGjv4DMabWRzNV9LE/tpkox2ltu1bW1kDEU/W3tj
        pV8Mmbp62oNIWInPsMaSzArRGywYTrtkGXyzWnJ9cEiEpBUpdU7yKsEc9e7oRhDdMkDGb1
        6XrRUv4BEoOLRM24/Q0TuIQ76XLMkZU=
Date:   Tue, 11 Oct 2022 13:28:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Y0VTS9qTF/GaMihP@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:08:45AM -0700, Daniel Verkamp wrote:
> We found that the IA32_MISC_ENABLE MSR setup was missing in the crosvm
> firmware boot path

Sounds like crazy virtualization stuff.

> However, I still think it would be appropriate to apply this patch or
> something like it, since there could be a CPU, microcode update, BIOS,
> etc. that clears this bit while still having the CPUID flags for FSRM
> and ERMS.

You mean that "something" would be so silly so as to clear the MSR but
leave the CPUID bits set?

That sounds like a bug in that "something".

> The Intel SDM says: "Software can disable fast-string operation by
> clearing the fast-string-enable bit (bit 0) of IA32_MISC_ENABLE MSR",
> so it's not an invalid configuration for this bit to be unset.

Dunno, did Intel folks think about clearing the respective CPUID bits
when exposing IA32_MISC_ENABLE[0] to software? Tony?

> Additionally, something like this avoids the problem by making the
> FSRM case jump directly to the REP MOVSB rather than falling through
> to the ERMS jump in the next instruction, which seems like basically
> free insurance (but if the FSRM flag gets used somewhere else in the
> future,

I can't follow here.

> having it set consistently with ERMS is probably still a good
> idea, per the original patch):
> 
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 724bbf83eb5b..8ac557409c7d 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -38,7 +38,7 @@ SYM_FUNC_START(__memmove)
> 
>          /* FSRM implies ERMS => no length checks, do the copy directly */
>  .Lmemmove_begin_forward:
> -        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> +        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "jmp .Lmemmove_erms",
> X86_FEATURE_FSRM
>          ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
> 
> And hey, this means one less instruction to execute in the FSRM path. :)

What one less instruction? After patching and since we assume FSRM =>
ERMS, we have only the JMP there if both flags are set. If ERMS only is
set, then we do the length check.

And you need the second alternative call for !ERMS, i.e., old rust.

So yes, your proposal is to do this because we assume if FSRM, then ERMS
but your diff above doesn't make it more readable but less.

Or I'm missing something ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
