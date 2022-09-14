Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD55B8AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiINOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiINOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:41:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED265EDD2;
        Wed, 14 Sep 2022 07:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D8CDB81BB7;
        Wed, 14 Sep 2022 14:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD45C433C1;
        Wed, 14 Sep 2022 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663166459;
        bh=TWVD90t16Cl0movMc47E4a7VMRO0iib3j6mMZIPWEy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hv6Q78z6Q2nIk33ayTd0SENgiMZAkQbK+662pi7q6PYJ8VAdnvxiPBuQJoLPM4vza
         PeabpbDqHjj23HH1SgLFUMgqpcPH6+1c2CQHFEQJ2rk96xaOpYUNxMp8quRBL8XB4V
         fEf2eJIcDr8S6vR8S0uXlQhnGzn4dEqgbMAPuDlxD80r0j46KnPmQ1XtCvKfvhu5vZ
         wnZBTD4gUhr5lCrWbEEwMb6gLgc/X2BTRQlnQmp1RKxJ9Go7eIhtSbqLWxmZLOyPEQ
         hV239TE/NRjWX7ttnxwkcO0pd7nbgPDdQMRoSqKXunH8gPzs99xgsywPRP6TSNFimC
         /vWGTtutWNVHA==
Date:   Wed, 14 Sep 2022 07:40:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <YyHn+UbfC7e1XIT3@dev-arch.thelio-3990X>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:50:03AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> > On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > > [...]
> > > > >         callq   *pv_ops+536(%rip)
> > > >
> > > > Do you know which pv_ops function is this? I can't figure out where
> > > > pte_offset_kernel() gets converted into a pv_ops call....
> > > >
> > > This one is _paravirt_ident_64, I believe. I think that the original
> > > issue Nathan was seeing was with another seemingly innocuous function.
> > 
> > _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> > really needs to not be touched at all by the compiler for
> > these...special features.
> 
> My source tree sayeth:
> 
>   u64 notrace _paravirt_ident_64(u64 x)
> 
> And that function is only ever called at boot, after alternatives runs
> it's patched with:
> 
>   mov %_ASM_ARG1, %_ASM_AX
> 
> Anyway, if you want to take it away from the compiler, something like
> so should do.

This appears to work fine for me in QEMU, as I can still boot with
CONFIG_ZERO_CALL_USED_REGS and spawn a nested guest without any issues.

> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 7ca2d46c08cc..8922e2887779 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -80,11 +80,16 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
>  }
>  
>  #ifdef CONFIG_PARAVIRT_XXL
> -/* identity function, which can be inlined */
> -u64 notrace _paravirt_ident_64(u64 x)
> -{
> -	return x;
> -}
> +extern u64 _paravirt_ident_64(u64 x);
> +asm (".pushsection .entry.text, \"ax\"\n"
> +     ".global _paravirt_ident_64\n"
> +     "_paravirt_ident_64:\n\t"
> +     ASM_ENDBR
> +     "mov %" _ASM_ARG1 ", %" _ASM_AX "\n\t"
> +     ASM_RET
> +     ".size _paravirt_ident_64, . - _paravirt_ident_64\n\t"
> +     ".type _paravirt_ident_64, @function\n\t"
> +     ".popsection");
>  #endif
>  
>  DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> 
