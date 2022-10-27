Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153AD60FABD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiJ0Opr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiJ0OpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:45:23 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46438180AE0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:45:19 -0700 (PDT)
X-KPN-MessageId: f733a8dd-5605-11ed-8a67-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id f733a8dd-5605-11ed-8a67-005056ab378f;
        Thu, 27 Oct 2022 16:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=nbk8WDHXYOvz/12Vpr8rjQ9y6U1PwH88UX68bHe7olg=;
        b=tx4gQqczK/U0DfOGBYRGVmbLmwlO4m96QYiwfOvP/tTq/V5sjwCY3LySnA137pPYtQ9En+r2wixsi
         enJi2q/yD+/FlGUh957mmD06KrmLFWQn0kydGB8ZJ3Ue7zPAN5iMbmdYgG3oIDikmSQMGaY4LdxaUh
         5BxeMtZTBzWOmwBkk0kCbrokMuXt83nAaSuWmMJm80CPkonM+sKhl9LCo1jTk3bj3CY4pwBWlcxkP0
         jd9nMc7SuMXhmBFWjiLJyXB2C1D4z687BQl6lGWN0j1K109Xjhkmm5yHmTD3dCZCQntjME51eb4O3D
         TxxTlX7PihAdw0FzBOZJLH5VAAam92A==
X-KPN-MID: 33|qgMiHmgicS/fk3MqqMY6y4srLvE+DOTJaVq5bSkvc1mSmmvHkWI5AWFzLuzTMkX
 6yBoW0Kzr0XsvHgQC1Uf06ExZZaLBGapPNmzdrGslJfk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LhEhDit/SjXESQ1su4/zOWhveljt8QdAJGBoM9g/3QEVhBJUtQlu20sGusyHaFM
 m+yToRgytjjy2Wh8PbvbqwA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id f871d71e-5605-11ed-9ebb-005056ab7584;
        Thu, 27 Oct 2022 16:45:17 +0200 (CEST)
Date:   Thu, 27 Oct 2022 16:45:16 +0200
Message-Id: <87czadqq9v.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org, ebiggers@kernel.org,
        Jason@zx2c4.com, keescook@chromium.org, suzuki.poulose@arm.com,
        agl@google.com, james.morse@arm.com
In-Reply-To: <CAMj1kXFo3abMdpO+YjqPhvtkDkjCHS9hs4urRA3g5iSbwrR17A@mail.gmail.com>
        (message from Ard Biesheuvel on Thu, 27 Oct 2022 15:17:56 +0200)
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the kernel
References: <20221027112741.1678057-1-ardb@kernel.org> <Y1p1oKCE+paB8JUK@FVFF77S0Q05N> <CAMj1kXFo3abMdpO+YjqPhvtkDkjCHS9hs4urRA3g5iSbwrR17A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ard Biesheuvel <ardb@kernel.org>
> Date: Thu, 27 Oct 2022 15:17:56 +0200
> 
> On Thu, 27 Oct 2022 at 14:12, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> > > The ARM architecture revision v8.4 introduces a data independent timing
> > > control (DIT) which can be set at any exception level, and instructs the
> > > CPU to avoid optimizations that may result in a correlation between the
> > > execution time of certain instructions and the value of the data they
> > > operate on.
> > >
> > > The DIT bit is part of PSTATE, and is therefore context switched as
> > > usual, given that it becomes part of the saved program state (SPSR) when
> > > taking an exception. We have also defined a hwcap for DIT, and so user
> > > space can discover already whether or nor DIT is available. This means
> > > that, as far as user space is concerned, DIT is wired up and fully
> > > functional.
> > >
> > > In the kernel, however, we never bothered with DIT: we disable at it
> > > boot (i.e., INIT_PSTATE_EL1 has DIT cleared) and ignore the fact that we
> > > might run with DIT enabled if user space happened to set it.
> >
> > FWIW, I did raise this with some architects a while back, and the thinking at
> > the time was that implementations were likely to have data independent timing
> > regardless of the value of the DIT bit, and so manipulating this at exception
> > entry was busy work with no actual gain (especially if we had to handle
> > mismatched big.LITTLE systems).
> >
> > Since then, I have become aware of some possible implementation choices which
> > would consider the bit (though I have no idea if anyone is building such
> > implementations).
> >
> 
> It's a bit unfortunate that FEAT_DIT is mandatory even if the uarch in
> question behaves the same regardless. And the fact that it is
> documented as resetting to 0x0, and already being exposed to user
> space doesn't help either. But that doesn't justify keeping this
> disabled in the kernel.
> 
> The architecture does not permit us to distinguish between the cases
> where this is just busywork and where it does make a difference. So we
> have to assume it is the latter.
> 
> > > Given that running privileged code with DIT disabled on a CPU that
> > > implements support for it may result in a side channel that exposes
> > > privileged data to unprivileged user space processes,
> >
> > I appreciate this is a simple way to rule out issues of that sort, but I think
> > the "may" in that sentence is doing a lot of work, since:
> >
> > * IIUC, we don't have a specific case in mind that we're concerned about. I can
> >   believe that we think all the crypto code we intend to be constant time is
> >   theoretically affected.
> >
> 
> I think this reasoning is backwards. I don't think it is necessary to
> go and identify where we are relying on timing invariance. Crypto
> keeps coming up, and of course, it is a well known example of where
> timing variances may leak the plaintext or the key. But crypto is just
> one way to keep data confidential, and another method we rely on
> heavily is the privilege boundary between kernel and user space. So
> just like all crypto should be constant time, all privileged execution
> should [ideally] be constant time as well.
> 
> > * IIUC we haven't gone an audited all constant-time code to check it doesn't
> >   happen to use instructions with data-dependent-timing. So there might be more
> >   work to do atop this to ensure theoretical correctness.
> >
> 
> Sure.
> 
> > * AFAIK there are no contemporary implementations where the DIT is both
> >   implemented and it being clear results in data-dependent-timing. i.e. we have
> >   nothing to actually test on.
> >
> 
> Then why on earth are such implementations required to implement FEAT_DIT??
> 
> > Given that, it would be nice if we could make this a bit clearer, e.g. state
> > that this is currently a belt-and-braces approach for theoretical cases, rather
> > than an extant side-channel today (as far as we're aware).
> >
> 
> Sure - I'll add some extra prose to the commit log to capture the above.
> 
> > > let's enable DIT while running in the kernel if supported by all CPUs.
> >
> > FWIW, I think it's reasonable to do this when all CPUs have DIT.
> >
> > I have a slight fear that (as above) if there are future CPUs which do consider
> > DIT, there's presumably a noticeable performance difference (or the CPU would
> > just provide data-independent-timing regardless), but I'm not sure if that's
> > just something we have to live with or could punt on until we notice such
> > cases.
> >
> 
> Sure. Another concern might be the overhead of toggling the bit, so
> getting this change in sooner than later might actually help direct
> the development towards implementations where the performance uplift
> substantially outweighs the cycles spent on managing the DIT state.
> 
> To me, it seems unlikely that timing dependent optimizations in
> privileged code would benefit actual real-world workloads while not
> resulting in exploitable timing leajs, but user space should be able
> to manage this however it wants.
> 
> IOW, yes. Let's pick a safe default, and when use cases turn up where
> disabling DIT makes a substantial difference, we can revisit this.

FWIW, I came to the same conclusion and that's what I implemented for
OpenBSD.

> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Cc: Adam Langley <agl@google.com>
> > > Link: https://lore.kernel.org/all/YwgCrqutxmX0W72r@gmail.com/
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/sysreg.h |  3 +++
> > >  arch/arm64/kernel/cpufeature.c  | 16 ++++++++++++++++
> > >  arch/arm64/kernel/entry.S       |  3 +++
> > >  arch/arm64/tools/cpucaps        |  1 +
> > >  4 files changed, 23 insertions(+)
> >
> > Don't we also need to touch __cpu_suspend_exit() in arch/am64/kernel/suspend.c?
> > I'm assuming so given that has __uaccess_enable_hw_pan() today.
> >
> 
> Indeed, I missed that.
> 
> > Presumably we'd also care about this in KVM hyp code?
> >
> 
> Presumably, yes but I didn't investigate thoroughly what that would
> entail. I think this can be managed separately, and I'll look into it
> once the discussion here converges.
> 
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index 7d301700d1a9..18e065f5130c 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -94,15 +94,18 @@
> > >  #define PSTATE_PAN                   pstate_field(0, 4)
> > >  #define PSTATE_UAO                   pstate_field(0, 3)
> > >  #define PSTATE_SSBS                  pstate_field(3, 1)
> > > +#define PSTATE_DIT                   pstate_field(3, 2)
> > >  #define PSTATE_TCO                   pstate_field(3, 4)
> > >
> > >  #define SET_PSTATE_PAN(x)            __emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
> > >  #define SET_PSTATE_UAO(x)            __emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
> > >  #define SET_PSTATE_SSBS(x)           __emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
> > > +#define SET_PSTATE_DIT(x)            __emit_inst(0xd500401f | PSTATE_DIT | ((!!x) << PSTATE_Imm_shift))
> > >  #define SET_PSTATE_TCO(x)            __emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
> > >
> > >  #define set_pstate_pan(x)            asm volatile(SET_PSTATE_PAN(x))
> > >  #define set_pstate_uao(x)            asm volatile(SET_PSTATE_UAO(x))
> > > +#define set_pstate_dit(x)            asm volatile(SET_PSTATE_DIT(x))
> > >  #define set_pstate_ssbs(x)           asm volatile(SET_PSTATE_SSBS(x))
> > >
> > >  #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 6062454a9067..273a74df24fe 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -2077,6 +2077,11 @@ static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
> > >       sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
> > >  }
> > >
> > > +static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)
> > > +{
> > > +     set_pstate_dit(1);
> > > +}
> >
> > I think this wants the same treatment as PAN, i.e.
> > WARN_ON_ONCE(in_interrupt()); with a comment about PSTATE being discareded upon
> > ERET.
> >
> 
> This is only called from the CPU feature code, which calls it under
> stop_machine(), so I decided it was not needed. I don't mind adding
> it, though, just seems unnecessary to me.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
