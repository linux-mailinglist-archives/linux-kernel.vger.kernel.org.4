Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F564E1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLOTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:47:42 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454B53EF1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:47:40 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id i20so433796qtw.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPYxTZTqJC2cdh9DTW09sHVEq0B/4FV+Y1mjGIsAm28=;
        b=JgupwQ0M+cS5odKFWl56mZ7K5YiFNnaWBWQklLgq/ittQi07poJfGSkTnet2ShdGvP
         ghKJiwO+7INPwfEwJueoVvRzvJdkJEQLRrITMCraE8npHanYxQ4s4m4oglXvMJ4ifENq
         FyVJONH8prG9SjuJgfiToWT0D/FBUL++KQMmZjeEV/lBUpwF2eC8XHcDtJg01WrbfsFw
         uZkuXmPPdY4sqa6SDqiJAdNxoxSyWiQ2sxBZVG22JDv0WHlFhk09gvYW3dqF0AfFrUIf
         SQqJkayH92MDwA+UgfLBuNSFFWpv3glYA/wZccfEB0RoyAPs3T1+zANvu7KRdRYWAc+V
         K3qw==
X-Gm-Message-State: ANoB5pm3aXL0xUCxn3HvY0qz2SdDWHgXPcUX0hi+p/ctOffKaDQZMhbf
        3QexQDfCrn4xG4KxsoFKeWkd/l4ugEd3HA==
X-Google-Smtp-Source: AA0mqf5YliKDaZmyulY8+r/Smc00K+rvpaQgSEwikqNl7v/EqUnbTT3PWQ0kwxIbZ3tE0UYVrn/CXQ==
X-Received: by 2002:ac8:58ca:0:b0:3a8:a8e:c0e0 with SMTP id u10-20020ac858ca000000b003a80a8ec0e0mr46378634qta.8.1671133659380;
        Thu, 15 Dec 2022 11:47:39 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05622a610600b003a50248b89esm3896506qtb.26.2022.12.15.11.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 11:47:38 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id g4so4813645ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:47:38 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr74538346ybp.202.1671133658135; Thu, 15
 Dec 2022 11:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20221215164109.761427-1-arnd@kernel.org>
In-Reply-To: <20221215164109.761427-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Dec 2022 20:47:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWi-LYfEiSTG1Oa_DyjmA-t1_WW_HfL6adt_TXTrzEx-A@mail.gmail.com>
Message-ID: <CAMuHMdWi-LYfEiSTG1Oa_DyjmA-t1_WW_HfL6adt_TXTrzEx-A@mail.gmail.com>
Subject: Re: [PATCH] irqchip: build IMX_MU_MSI only on ARM
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Dec 15, 2022 at 5:41 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> compile-testing IMX_MU_MSI on x86 without PCI_MSI support results
> in a build failure:
>
> arch/x86/kernel/hpet.c:520:46: error: 'msi_alloc_info_t' {aka 'struct irq_alloc_info'} has no member named 'hwirq'
>   520 |         irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
>       |                                              ^~
> arch/x86/kernel/hpet.c:521:49: error: 'msi_alloc_info_t' {aka 'struct irq_alloc_info'} has no member named 'data'
>   521 |                             handle_edge_irq, arg->data, "edge");
>       |                                                 ^~
> arch/x86/kernel/hpet.c: In function 'hpet_create_irq_domain':
> arch/x86/kernel/hpet.c:550:13: error: 'x86_vector_domain' undeclared (first use in this function)
>   550 |         if (x86_vector_domain == NULL)
>       |             ^~~~~~~~~~~~~~~~~
> arch/x86/kernel/hpet.c:550:13: note: each undeclared identifier is reported only once for each function it appears in
> arch/x86/kernel/hpet.c: In function 'hpet_assign_irq':
> arch/x86/kernel/hpet.c:600:9: error: implicit declaration of function 'init_irq_alloc_info' [-Werror=implicit-function-declaration]
>   600 |         init_irq_alloc_info(&info, NULL);
>
> Tighten the dependency further to only allow compile testing on Arm.
> This could be refined further to allow certain x86 configs.

Thanks for your patch!

> Fixes: 6c9f7434159b ("irqchip: IMX_MU_MSI should depend on ARCH_MXC")

This is not the commit that introduced the issue.

Fixes: 70afdab904d2d1e6 ("irqchip: Add IMX MU MSI controller driver")

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/irqchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index caa952c40ff9..4ebf4d566e6f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -484,7 +484,7 @@ config IMX_INTMUX
>  config IMX_MU_MSI
>         tristate "i.MX MU used as MSI controller"
>         depends on OF && HAS_IOMEM
> -       depends on ARCH_MXC || COMPILE_TEST
> +       depends on ARCH_MXC || ((ARM || ARM64) && COMPILE_TEST)

I think adding a separate line

    depends on ARM || ARM64

is easier to read (and easier to extend).

>         default m if ARCH_MXC
>         select IRQ_DOMAIN
>         select IRQ_DOMAIN_HIERARCHY

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
