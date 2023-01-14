Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841ED66AD57
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjANS7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjANS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:59:19 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC009B76D;
        Sat, 14 Jan 2023 10:59:18 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4a2f8ad29d5so328511467b3.8;
        Sat, 14 Jan 2023 10:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvSA+Lx4428ZeCqIe+MLNPk8FnuAPH7irnwCNjVyepg=;
        b=E/Z7vgZuk7gjVRqsylXqM2hjmpmB+3D6Z+7L/t7h1F575IWk064ySp7dFiRB765EpZ
         GNK5NAC0kDvAVx1CKmD8SpgrBnhHoeWTVJW0ZD149chpcmHhQ5y4lIv8eD0QHSFQNoNX
         oCA7jwWvBRh2EMqgsFS6SR70T2xvpunuS54kAw/ZuxdkoXHZ7P/JNMn2VuI96YAbS8HY
         Ayx8Yem9zjfCn7txUB9DK9MECtvMiXYtdRY4uKJ9JIeJooLdUk+kEjVnIYGPF/oBfBML
         YeR25uyJhpLoadDfVdykzooeh4HrkJU+A+/6MNUNd3/Z9W+lWdF5bIR7jMqtklIPmyJ6
         +ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvSA+Lx4428ZeCqIe+MLNPk8FnuAPH7irnwCNjVyepg=;
        b=ExFjXecnwqzr7LUDBVl0ZLPdq+SkKL8aUVTWDRBeLO9rIjQQcCJkhOV2M1m7299TJC
         exmt9nKsX40iciyJlGpimevBuaFBQD+80M9h4WaCtiiwUBLM6fGXr3sSEoR/XmQk3A4i
         JicXbpcR/Nes8NSlv4qRpRiJG2TzW7P3uO1shf4t00Zki+Fsub9CSXHgzOCYe7s48yEg
         FRVxv+9pui+dnAVCt6uM7CvdLbePoCQhw+lEN0O5UA8SsjzTbgR05E3ZDiBr6Cl07Rsa
         jal6a24xh/MnmdM8frBXy3sZmowIxS1GVKvqeFqqtPvDC5qkLIE91xXChgtV/X39WYf2
         UCOA==
X-Gm-Message-State: AFqh2krBqJd1Qr0W+IJcMoLYzF99vGfZbuNj0LlviiGCX2txroEGK1Xu
        nprjPBsT283/uKY9JbWMt1manPCQol1g7Zbta7I=
X-Google-Smtp-Source: AMrXdXv+37ZTyFOBsHwWwFuVHUiogjw4yQ6vwuYJv3R41Nb8EHC+LjAe/xhxW2jrxj4BgjxRIgUKiXI8cvts3nEGPrw=
X-Received: by 2002:a81:a112:0:b0:4cf:84af:7e95 with SMTP id
 y18-20020a81a112000000b004cf84af7e95mr1817829ywg.309.1673722758140; Sat, 14
 Jan 2023 10:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 14 Jan 2023 18:58:52 +0000
Message-ID: <CA+V-a8t38vHuBd+GJs5_643Jp5L6u6ci7NWVjRn53iwA445ODA@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>
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

On Thu, Dec 29, 2022 at 10:50 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Having a clocksource_arch_init() callback always sets vdso_clock_mode to
> VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
> required for the riscv-timer.
>
> This works for platforms where just riscv-timer clocksource is present.
> On platforms where other clock sources are available we want them to
> register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.
>
> On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
> avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
> move setting of vdso_clock_mode in the riscv-timer driver instead of doing
> this in clocksource_arch_init() callback as done similarly for ARM/64
> architecture.
>
> [0] drivers/clocksource/renesas-ostm.c
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Samuel Holland <samuel@sholland.org>
> ---
> RFC -> v2
> * Dropped vdso_default static global variable
> * Used IS_ENABLED() macro
> * Included Tested-by from Samuel
>
> RFC:
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  arch/riscv/Kconfig                | 1 -
>  arch/riscv/kernel/time.c          | 9 ---------
>  drivers/clocksource/timer-riscv.c | 5 +++++
>  3 files changed, 5 insertions(+), 10 deletions(-)
>
Gentle ping.

Cheers,
Prabhakar

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..9c687da7756d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,7 +12,6 @@ config 32BIT
>
>  config RISCV
>         def_bool y
> -       select ARCH_CLOCKSOURCE_INIT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_HAS_BINFMT_FLAT
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 8217b0f67c6c..42bee305e997 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -30,12 +30,3 @@ void __init time_init(void)
>         of_clk_init(NULL);
>         timer_probe();
>  }
> -
> -void clocksource_arch_init(struct clocksource *cs)
> -{
> -#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> -       cs->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER;
> -#else
> -       cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
> -#endif
> -}
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 55dad7965f43..c416e5e934bf 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -77,6 +77,11 @@ static struct clocksource riscv_clocksource = {
>         .mask           = CLOCKSOURCE_MASK(64),
>         .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
>         .read           = riscv_clocksource_rdtime,
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +       .vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
> +#else
> +       .vdso_clock_mode = VDSO_CLOCKMODE_NONE,
> +#endif
>  };
>
>  static int riscv_timer_starting_cpu(unsigned int cpu)
> --
> 2.25.1
>
