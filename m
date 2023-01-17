Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3485666E451
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjAQRCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjAQRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:02:06 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F83A58C;
        Tue, 17 Jan 2023 09:02:04 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id d16so14736178qtw.8;
        Tue, 17 Jan 2023 09:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG07rkufzJudbSBlfxWXzYs9DtgP7S33LaaSRTlg/Ec=;
        b=sSRXxqomvtTkSYKSfDPaliblvltNjr+JFTr8q6FHHAWvnp9Xo/5WJ/04woYezMtH/u
         VTrQYg2AleLb4Jpf6+QIQTIyqgBCYwrXNLt9QBPQyrQmNdHLWlQwvv4EeEldSrP6zbDi
         o0xCT8/ugoPweLxBUuHkTURxo4ZWarRAd9QBoG7ettdAiHPLIcx6ZBvv73XyoBUh0iWX
         kWji0NsmTSQdKJ7diN1p20s9kgLqs0kSFpcYEyHCI9K3uU99AYPt5XKPF4+XiYfQtDYz
         5ELwHxBfayojJSiE/3/mY6s1Og7VpDrJZvHIK6N623eMnFoEuLKiGsAJ09ZzH6XcsltW
         gC0Q==
X-Gm-Message-State: AFqh2krnv9HX3MnFTsJhw+3mz37/C6yygIzKwbYxc28TL+4utAsOHVqW
        iHBRFrAzIkGkhpCfZMRJ6q6L2QdLNrn0lw==
X-Google-Smtp-Source: AMrXdXsNcHyj2t90IEZdye5uKLC8cCdUWOCIrEUCxGS2puAFZN1gu1cBB+bGf26IF95xAy6I6Cn0lQ==
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr4367214qto.1.1673974923290;
        Tue, 17 Jan 2023 09:02:03 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86bc3000000b003ab7aee56a0sm16269410qtt.39.2023.01.17.09.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:02:03 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id t15so34843165ybq.4;
        Tue, 17 Jan 2023 09:02:02 -0800 (PST)
X-Received: by 2002:a25:d88c:0:b0:77a:b5f3:d0ac with SMTP id
 p134-20020a25d88c000000b0077ab5f3d0acmr418050ybg.202.1673974922451; Tue, 17
 Jan 2023 09:02:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com> <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
In-Reply-To: <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jan 2023 18:01:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
Message-ID: <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
Subject: Re: Calculating array sizes in C - was: Re: Build regressions/improvements
 in v6.2-rc1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Jan 17, 2023 at 5:42 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 1/6/23 16:17, Geert Uytterhoeven wrote:
> >> I'm not seeing this one, but I am getting this one instead:
> >>
> >> In file included from ./arch/sh/include/asm/hw_irq.h:6,
> >>                    from ./include/linux/irq.h:596,
> >>                    from ./include/asm-generic/hardirq.h:17,
> >>                    from ./arch/sh/include/asm/hardirq.h:9,
> >>                    from ./include/linux/hardirq.h:11,
> >>                    from ./include/linux/interrupt.h:11,
> >>                    from ./include/linux/serial_core.h:13,
> >>                    from ./include/linux/serial_sci.h:6,
> >>                    from arch/sh/kernel/cpu/sh2/setup-sh7619.c:11:
> >> ./include/linux/sh_intc.h:100:63: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]
> >>     100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> >>         |                                                               ^
> >> ./include/linux/sh_intc.h:105:31: note: in expansion of macro '_INTC_ARRAY'
> >>     105 |         _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
> >>         |                               ^~~~~~~~~~~
> >
> > The easiest fix for the latter is to disable CONFIG_WERROR.
> > Unfortunately I don't know a simple solution to get rid of the warning.
>
> I did some research and it seems that what the macro _INT_ARRAY() does with "sizeof(a)/sizeof(*a)"
> is a commonly used way to calculate array sizes and the kernel has even its own macro for that
> called ARRAY_SIZE() which Linus asks people to use here [1].
>
> So, I replaced _INTC_ARRAY() with ARRAY_SIZE() (see below), however the kernel's own ARRAY_SIZE()
> macro triggers the same compiler warning. I'm CC'ing Michael Karcher who has more knowledge on
> writing proper C code than me and maybe an idea how to fix this warning.
>
> Thanks,
> Adrian
>
> > [1] https://lkml.org/lkml/2015/9/3/428
>
> diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> index c255273b0281..07a187686a84 100644
> --- a/include/linux/sh_intc.h
> +++ b/include/linux/sh_intc.h
> @@ -97,14 +97,12 @@ struct intc_hw_desc {
>          unsigned int nr_subgroups;
>   };
>
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> -
>   #define INTC_HW_DESC(vectors, groups, mask_regs,       \
>                       prio_regs, sense_regs, ack_regs)   \
>   {                                                      \
> -       _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
> -       _INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs), \
> -       _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
> +       ARRAY_SIZE(vectors), ARRAY_SIZE(groups),        \
> +       ARRAY_SIZE(mask_regs), ARRAY_SIZE(prio_regs),   \
> +       ARRAY_SIZE(sense_regs), ARRAY_SIZE(ack_regs),   \
>   }

The issue is that some of the parameters are not arrays, but
NULL. E.g.:

arch/sh/kernel/cpu/sh2/setup-sh7619.c:static
DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
arch/sh/kernel/cpu/sh2/setup-sh7619.c-                   NULL,
prio_registers, NULL);
--

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
