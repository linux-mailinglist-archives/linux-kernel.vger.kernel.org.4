Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633C60F8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiJ0NSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0NSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA48E475
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A47E622EA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEC5C4347C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666876690;
        bh=bF8ntUwbuEsxVgziUvq9BmtNiRtLW3dlwE/vT9uUfT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sz54nwx4gc9QJYeshgZWGLr367mFs8EhSDT886PBOzCqyeQV8dGtuCUS83UttApOm
         Y6V0YTjy/sd5thTQbT83VBE4i7v1aOxcBqJokjFuBEum7poL9JXD86RzmUT4Y7N6l7
         5ppcUaAGJHyP83ptL0LIWp/kBxIQEQG0Xspe3S/4y7Mvad0D8EGXfEmGl0I2HO79EA
         BecMbkhfaPjZCiBwMf1JKqFn+X9ACPaKTOunZaSCCOH2YY8xbNq7V09AemOXSTcDku
         c7ZOek5p+cX/ROm86bXD8uMI9HQZ7aN+DGpdwP4yLXd9j2rgMsxJxthNrZ2QDi6ky7
         hv43lbSDCtN8g==
Received: by mail-lj1-f180.google.com with SMTP id x21so1066534ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:18:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf1z/ht36hQXXIG9tglUvlIBvIQaqD1tUL3WGdISFc9WxikXvFgq
        EvnhyfXIFmd08wL7MmMV0ZYGfdcNglxb60hqyog=
X-Google-Smtp-Source: AMsMyM4Wh19SvBsIbNvVNr4qKK2dQpxghWgmyF3nOsS8EVCFdaKOE2OJjqLVJBUY24h5Tc1vMjC4Tqb6PtJnHvSlWzo=
X-Received: by 2002:a2e:b621:0:b0:26e:535f:a90f with SMTP id
 s1-20020a2eb621000000b0026e535fa90fmr17037887ljn.69.1666876687824; Thu, 27
 Oct 2022 06:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221027112741.1678057-1-ardb@kernel.org> <Y1p1oKCE+paB8JUK@FVFF77S0Q05N>
In-Reply-To: <Y1p1oKCE+paB8JUK@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Oct 2022 15:17:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFo3abMdpO+YjqPhvtkDkjCHS9hs4urRA3g5iSbwrR17A@mail.gmail.com>
Message-ID: <CAMj1kXFo3abMdpO+YjqPhvtkDkjCHS9hs4urRA3g5iSbwrR17A@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the kernel
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 at 14:12, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> > The ARM architecture revision v8.4 introduces a data independent timing
> > control (DIT) which can be set at any exception level, and instructs the
> > CPU to avoid optimizations that may result in a correlation between the
> > execution time of certain instructions and the value of the data they
> > operate on.
> >
> > The DIT bit is part of PSTATE, and is therefore context switched as
> > usual, given that it becomes part of the saved program state (SPSR) when
> > taking an exception. We have also defined a hwcap for DIT, and so user
> > space can discover already whether or nor DIT is available. This means
> > that, as far as user space is concerned, DIT is wired up and fully
> > functional.
> >
> > In the kernel, however, we never bothered with DIT: we disable at it
> > boot (i.e., INIT_PSTATE_EL1 has DIT cleared) and ignore the fact that we
> > might run with DIT enabled if user space happened to set it.
>
> FWIW, I did raise this with some architects a while back, and the thinking at
> the time was that implementations were likely to have data independent timing
> regardless of the value of the DIT bit, and so manipulating this at exception
> entry was busy work with no actual gain (especially if we had to handle
> mismatched big.LITTLE systems).
>
> Since then, I have become aware of some possible implementation choices which
> would consider the bit (though I have no idea if anyone is building such
> implementations).
>

It's a bit unfortunate that FEAT_DIT is mandatory even if the uarch in
question behaves the same regardless. And the fact that it is
documented as resetting to 0x0, and already being exposed to user
space doesn't help either. But that doesn't justify keeping this
disabled in the kernel.

The architecture does not permit us to distinguish between the cases
where this is just busywork and where it does make a difference. So we
have to assume it is the latter.

> > Given that running privileged code with DIT disabled on a CPU that
> > implements support for it may result in a side channel that exposes
> > privileged data to unprivileged user space processes,
>
> I appreciate this is a simple way to rule out issues of that sort, but I think
> the "may" in that sentence is doing a lot of work, since:
>
> * IIUC, we don't have a specific case in mind that we're concerned about. I can
>   believe that we think all the crypto code we intend to be constant time is
>   theoretically affected.
>

I think this reasoning is backwards. I don't think it is necessary to
go and identify where we are relying on timing invariance. Crypto
keeps coming up, and of course, it is a well known example of where
timing variances may leak the plaintext or the key. But crypto is just
one way to keep data confidential, and another method we rely on
heavily is the privilege boundary between kernel and user space. So
just like all crypto should be constant time, all privileged execution
should [ideally] be constant time as well.

> * IIUC we haven't gone an audited all constant-time code to check it doesn't
>   happen to use instructions with data-dependent-timing. So there might be more
>   work to do atop this to ensure theoretical correctness.
>

Sure.

> * AFAIK there are no contemporary implementations where the DIT is both
>   implemented and it being clear results in data-dependent-timing. i.e. we have
>   nothing to actually test on.
>

Then why on earth are such implementations required to implement FEAT_DIT??

> Given that, it would be nice if we could make this a bit clearer, e.g. state
> that this is currently a belt-and-braces approach for theoretical cases, rather
> than an extant side-channel today (as far as we're aware).
>

Sure - I'll add some extra prose to the commit log to capture the above.

> > let's enable DIT while running in the kernel if supported by all CPUs.
>
> FWIW, I think it's reasonable to do this when all CPUs have DIT.
>
> I have a slight fear that (as above) if there are future CPUs which do consider
> DIT, there's presumably a noticeable performance difference (or the CPU would
> just provide data-independent-timing regardless), but I'm not sure if that's
> just something we have to live with or could punt on until we notice such
> cases.
>

Sure. Another concern might be the overhead of toggling the bit, so
getting this change in sooner than later might actually help direct
the development towards implementations where the performance uplift
substantially outweighs the cycles spent on managing the DIT state.

To me, it seems unlikely that timing dependent optimizations in
privileged code would benefit actual real-world workloads while not
resulting in exploitable timing leajs, but user space should be able
to manage this however it wants.

IOW, yes. Let's pick a safe default, and when use cases turn up where
disabling DIT makes a substantial difference, we can revisit this.

> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Adam Langley <agl@google.com>
> > Link: https://lore.kernel.org/all/YwgCrqutxmX0W72r@gmail.com/
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/sysreg.h |  3 +++
> >  arch/arm64/kernel/cpufeature.c  | 16 ++++++++++++++++
> >  arch/arm64/kernel/entry.S       |  3 +++
> >  arch/arm64/tools/cpucaps        |  1 +
> >  4 files changed, 23 insertions(+)
>
> Don't we also need to touch __cpu_suspend_exit() in arch/am64/kernel/suspend.c?
> I'm assuming so given that has __uaccess_enable_hw_pan() today.
>

Indeed, I missed that.

> Presumably we'd also care about this in KVM hyp code?
>

Presumably, yes but I didn't investigate thoroughly what that would
entail. I think this can be managed separately, and I'll look into it
once the discussion here converges.

> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 7d301700d1a9..18e065f5130c 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -94,15 +94,18 @@
> >  #define PSTATE_PAN                   pstate_field(0, 4)
> >  #define PSTATE_UAO                   pstate_field(0, 3)
> >  #define PSTATE_SSBS                  pstate_field(3, 1)
> > +#define PSTATE_DIT                   pstate_field(3, 2)
> >  #define PSTATE_TCO                   pstate_field(3, 4)
> >
> >  #define SET_PSTATE_PAN(x)            __emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
> >  #define SET_PSTATE_UAO(x)            __emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
> >  #define SET_PSTATE_SSBS(x)           __emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
> > +#define SET_PSTATE_DIT(x)            __emit_inst(0xd500401f | PSTATE_DIT | ((!!x) << PSTATE_Imm_shift))
> >  #define SET_PSTATE_TCO(x)            __emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
> >
> >  #define set_pstate_pan(x)            asm volatile(SET_PSTATE_PAN(x))
> >  #define set_pstate_uao(x)            asm volatile(SET_PSTATE_UAO(x))
> > +#define set_pstate_dit(x)            asm volatile(SET_PSTATE_DIT(x))
> >  #define set_pstate_ssbs(x)           asm volatile(SET_PSTATE_SSBS(x))
> >
> >  #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 6062454a9067..273a74df24fe 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2077,6 +2077,11 @@ static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
> >       sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
> >  }
> >
> > +static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)
> > +{
> > +     set_pstate_dit(1);
> > +}
>
> I think this wants the same treatment as PAN, i.e.
> WARN_ON_ONCE(in_interrupt()); with a comment about PSTATE being discareded upon
> ERET.
>

This is only called from the CPU feature code, which calls it under
stop_machine(), so I decided it was not needed. I don't mind adding
it, though, just seems unnecessary to me.
