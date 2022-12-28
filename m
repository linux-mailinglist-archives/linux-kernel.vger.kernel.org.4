Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0B6587F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiL1Xoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL1Xog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:44:36 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D7513E22;
        Wed, 28 Dec 2022 15:44:35 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-43ea87d0797so241061467b3.5;
        Wed, 28 Dec 2022 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbGhLufIgqXDdb1BN5HzkBQRvTU9efkD5B+p/KhTdLo=;
        b=S93e4U7AJgIp/1cRRpi8jqaGy6dMUpEYkKtGlP2nl964lAgj68R54yOQxMweYq+e5b
         AoZh5EUHn99Hln3b7DxkLhig5piBVh7mVacLc0IwQTwUo+mWg8TA54mjjz4iPRzDG1BP
         llZ6xofNgj5fczbyZsbpDionw/fZf3c2FnTs9CLYR1wUpulRn2eMZkJeBAGCyKOELbxr
         8lHUbonYbpdSX0LhiLVoI8Nv5qGjBnU2r7ZxfQTyYI3ZvtmZc8tMgvenEhnXEgjTkWPW
         lUWsySNYtc9/L1+9y9TNs71n/FM9GJdQ7xnSewOJd97hOMlSpZTISDAZzVCucnp6A9SK
         089A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbGhLufIgqXDdb1BN5HzkBQRvTU9efkD5B+p/KhTdLo=;
        b=5sIC0Jm7EvdA7SYnL8F3+2Z9QpfSj+Wmd/EUiqcE7kmvvRZqCsgJ0myGS1oNaSrS+P
         7rc+GpbGXwnb3HtzGf2VI9K0s428bPH2cvUCi9jEXkMrk6yTYUrXqvFCtoG1fVy4ypDQ
         n7URsVHpEaMLM84i7Fo1OZktV23rvMdUPhuZG4QW60Q7CRqD9XxuPcYqkeoY1WzZ64QM
         NRYB89jkoy5cg0EJWQkV7ZeCQdET0WaEodn6VKtl+dQU0EFArrkwP0F8c+B5CCn/s2Sw
         6f814V6vFH0rlLhwb63i40PEhLJqD1U/tF3k/IOo7Icobhn3YEQeqnaGgd24riRdqUUl
         UkZA==
X-Gm-Message-State: AFqh2kpkflcuyUJszf65U64laYweTt5CSdJYJf1Ahpzfbc3WKIQ7lUam
        MI2/0oGkxxI3a86Jc+36YV5vPKgf+hV3sl7T7e4=
X-Google-Smtp-Source: AMrXdXurW45CCPloviW/gcdr6IUKvd7hSti4zW1PmI1pK0x+q6NVPKN9/xSVaH46yCH2O/LewYQF32/cvLWvnx6YMjY=
X-Received: by 2002:a81:9e41:0:b0:3b7:1b8a:6024 with SMTP id
 n1-20020a819e41000000b003b71b8a6024mr2944186ywj.421.1672271074846; Wed, 28
 Dec 2022 15:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <a92eda53-90ed-718d-6925-0d9afbb029c5@sholland.org>
In-Reply-To: <a92eda53-90ed-718d-6925-0d9afbb029c5@sholland.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 28 Dec 2022 23:44:08 +0000
Message-ID: <CA+V-a8vLtmo7VjQfZAnvLvjBADF_Zk3TNM62VJQnyxSBwjVDnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
To:     Samuel Holland <samuel@sholland.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Thank you for the review.

On Tue, Dec 27, 2022 at 11:17 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 12/11/22 15:58, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Having a clocksource_arch_init() callback always sets vdso_clock_mode to
> > VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
> > required for the riscv-timer.
> >
> > This works for platforms where just riscv-timer clocksource is present.
> > On platforms where other clock sources are available we want them to
> > register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.
> >
> > On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
> > avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
> > move setting of vdso_clock_mode in the riscv-timer driver instead of doing
> > this in clocksource_arch_init() callback as done similarly for ARM/64
> > architecture.
>
> This is definitely a good change to make, but shouldn't we still prefer
> the architectural CSR-based clocksource over an MMIO-based clocksource?
> It has double the number of bits, and reading it should have less
> overhead. So I think we also want to increase the rating of
> riscv_clocksource.
>
For which now you have already have a patch posted.

> D1 is in the same situation, as timer-sun4i.c registers a clocksource
> with a higher rating than riscv_clocksource. Without this patch,
> tools/testing/selftests/vDSO/vdso_test_correctness fails. With this
> patch, it passes, so:
>
> Tested-by: Samuel Holland <samuel@sholland.org>
>
> > [0] drivers/clocksource/renesas-ostm.c
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/riscv/Kconfig                | 1 -
> >  arch/riscv/kernel/time.c          | 9 ---------
> >  drivers/clocksource/timer-riscv.c | 7 +++++++
> >  3 files changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 7ea12de636bd..b269e062c1b1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -12,7 +12,6 @@ config 32BIT
> >
> >  config RISCV
> >       def_bool y
> > -     select ARCH_CLOCKSOURCE_INIT
> >       select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> >       select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> >       select ARCH_HAS_BINFMT_FLAT
> > diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> > index 8217b0f67c6c..42bee305e997 100644
> > --- a/arch/riscv/kernel/time.c
> > +++ b/arch/riscv/kernel/time.c
> > @@ -30,12 +30,3 @@ void __init time_init(void)
> >       of_clk_init(NULL);
> >       timer_probe();
> >  }
> > -
> > -void clocksource_arch_init(struct clocksource *cs)
> > -{
> > -#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> > -     cs->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER;
> > -#else
> > -     cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
> > -#endif
> > -}
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 969a552da8d2..7ec9668cd36d 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -29,6 +29,12 @@
> >
> >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> >
> > +#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> > +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
> > +#else
> > +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
> > +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
>
> We don't have any workarounds like arm_arch_timer, so we do not need
> this indirection through vdso_default. You can set .vdso_clock_mode
> directly in the declaration of riscv_clocksource.
>
Agreed, I'll do that in v2.

Cheers,
Prabhakar
