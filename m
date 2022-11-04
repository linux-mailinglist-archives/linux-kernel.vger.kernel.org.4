Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F661937F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKDJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiKDJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:29:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315382A72A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2900B82C76
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A47C43470
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667554164;
        bh=aNOl+2FIEtDvCGeFZD6bVGRvtuI/8JV0W4swGtgsVwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vGhC+qUBQEEWcWRxLiwpWIeNLkC9P/2npH5tHEE/0JZMab1WTEaHadiI3a9vpzwf+
         hU+iGgmHjeYcLJ6QPlKhJcmC6JYvlEZyuCwfDJaWceIlldpZapRLaTy5CApxCg8DFd
         2hpXFhHZEIoNfVzTQyVhJxBFQG5ok3ZQYoOWfYtZYM3TNIAzrridgQ2/VEo7KiLZVc
         Xqy/CM2riTcKJjGTOfrqtWmodV6FBAFtMi4z1MF/yyhWLi9Jl0O3WnRi7sQR8lVxfS
         Bj8IRMLlnanBSl8/2QWykgua2og5aQ4oZ+TxPUwM69jX7dnGnBjB0owo5Cng1GNdM/
         A8Jw2KUeDdWwA==
Received: by mail-lj1-f170.google.com with SMTP id z24so5528903ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 02:29:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf1rgzDXGkbEyJyQ4MN/YyhyogjtJ/wNz2+IXC/lyFfSshdNck/R
        5cqQtIQJc5lvy3lf4w/txjWiLKU3WorROM0MK3Q=
X-Google-Smtp-Source: AMsMyM6SLkqOjXVSEgqSjw0me/nAS6EP+tTeaAd41cBNe49Kf4c5fjAwb1tsfmR+0OcLVe1UeTapde6YPO7s6vDGjIQ=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr14029618lji.291.1667554162339; Fri, 04
 Nov 2022 02:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221027112741.1678057-1-ardb@kernel.org> <Y2TIqcfxFaThC4d5@sol.localdomain>
In-Reply-To: <Y2TIqcfxFaThC4d5@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 4 Nov 2022 10:29:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFv5gyp=jkgHPJPT9nLW16jpBF4rdo6tDCZYAPgkRma3Q@mail.gmail.com>
Message-ID: <CAMj1kXFv5gyp=jkgHPJPT9nLW16jpBF4rdo6tDCZYAPgkRma3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the kernel
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 09:09, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Ard,
>
> On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> > Given that running privileged code with DIT disabled on a CPU that
> > implements support for it may result in a side channel that exposes
> > privileged data to unprivileged user space processes, let's enable DIT
> > while running in the kernel if supported by all CPUs.
>
> This patch looks good to me, though I'm not an expert in low-level arm64 stuff.
> It's a bit unfortunate that we have to manually create the .inst to enable DIT
> instead of just using the assembler.  But it looks like there's a reason for it
> (it's done for PAN et al. too), and based on the manual it looks correct.
>

Yes. The reason is that the assembler requires -march=armv8.2-a to be
passed when using the DIT register (and similar requirements apply to
the other registers). However, doing so may result in object code that
can no longer run on pre-v8.2 cores, whereas the DIT accesses
themselves are only emitted in a carefully controlled manner anyway,
so keeping the arch baseline to v8.0 and using .inst is the cleanest
way around this.


> Two nits below:
>
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
>
> To keep the order consistent, set_pstate_dit() should be defined after
> set_pstate_ssbs(), not before.
>

Ack. Seems I just inserted it one from the bottom without actually reading :-)

> >  /* Internal helper functions to match cpu capability type */
> >  static bool
> >  cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
> > @@ -2640,6 +2645,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >               .matches = has_cpuid_feature,
> >               .cpu_enable = cpu_trap_el0_impdef,
> >       },
> > +     {
> > +             .desc = "Data independent timing control (DIT)",
> > +             .capability = ARM64_HAS_DIT,
> > +             .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > +             .matches = has_cpuid_feature,
> > +             .sys_reg = SYS_ID_AA64PFR0_EL1,
> > +             .field_pos = ID_AA64PFR0_EL1_DIT_SHIFT,
> > +             .field_width = 4,
> > +             .min_field_value = 1,
> > +             .cpu_enable = cpu_enable_dit,
> > +     },
>
> The other entries in this array are explicit about '.sign = FTR_UNSIGNED'
> (even though FTR_UNSIGNED is defined to false, so it's the default value).
>

Ack.
