Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA77259E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjFGJQn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:16:41 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E083;
        Wed,  7 Jun 2023 02:16:40 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-565eb83efe4so93007877b3.0;
        Wed, 07 Jun 2023 02:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129399; x=1688721399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6fIbBz94NXBI1+KVIOgP3CUxQlOZI2uVELRCoMaFFA=;
        b=gt3sepA3A5WR3KhAPWGvVUptVUAajiEWPgGvhe5U4ntZsXGWni1c5uzOYwT+T3AnDo
         AbJ1qw7bD4k2YIiOjLApvRnWoyat1M9cuzqtF5jNvLjxGhrRy5DDdanHSJkrIimFGQPx
         aRsQvOa8l6hQbmJDR3GbthMqfN/oQjMtpAwAlnMGeGF+Xv9GjDNxR84z05NeUUlWxEdR
         wpLK5oJme862nTY/+0Q5mdIGTZHaqKNGpS41fnpGXxlilJj3dktQI4x/5vNxd9GlGtpJ
         U51JZNPaijDqoSYDqjtDCgOr4irRYE+4ZWsZFeYLLtjD3hyc+TLA2D6xQ8UAFIsecmpu
         zsqg==
X-Gm-Message-State: AC+VfDw4hLBnhkxwJugeXFroImdEcs1fL/yNy/qD+wB20TNKfd1zzGvG
        cu7OpQpTqcwZLDvyk2KNsshTSFQSzuswbw==
X-Google-Smtp-Source: ACHHUZ6yvflTH0edmN+V9BihJnWGO7D1Hwt6ib4O/Xgb/YkKltVzg5cKfcJ9o4nDoPCbFi7IWD3HIg==
X-Received: by 2002:a0d:d5c8:0:b0:565:a8e7:239e with SMTP id x191-20020a0dd5c8000000b00565a8e7239emr5973478ywd.23.1686129399375;
        Wed, 07 Jun 2023 02:16:39 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x128-20020a814a86000000b0056183cdb2d9sm4599970ywa.60.2023.06.07.02.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:16:38 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-56974f42224so66356157b3.1;
        Wed, 07 Jun 2023 02:16:38 -0700 (PDT)
X-Received: by 2002:a25:33c6:0:b0:ba8:7122:2917 with SMTP id
 z189-20020a2533c6000000b00ba871222917mr5649365ybz.0.1686129398094; Wed, 07
 Jun 2023 02:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu> <20230527164452.64797-4-contact@artur-rojek.eu>
In-Reply-To: <20230527164452.64797-4-contact@artur-rojek.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 11:16:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
Message-ID: <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in SH7709
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

On Sat, May 27, 2023 at 6:45 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> According to the hardware manual [1], the DMAC found in SH7709 features
> only 4 channels.
>
> While at it, also sort the existing targets and clarify that
> NR_ONCHIP_DMA_CHANNELS must be a multiply of two.
>
> [1] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual (p. 373)
>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>
> v2: - sort existing targets

Thanks for the update!

>     - clarify that the value must be a multiply of two

That's only true when there are two DMACs, right?

Even in that case, you could mitigate that by avoiding the division by

    #ifdef SH_DMAC_BASE1
   -#define        SH_DMAC_NR_MD_CH        (CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
   +#define        SH_DMAC_NR_MD_CH        6
    #else
    #define        SH_DMAC_NR_MD_CH        CONFIG_NR_ONCHIP_DMA_CHANNELS
    #endif

That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
when configuring his kernel, thus breaking DMA  due to an incorrect
value of SH_DMAC_NR_MD_CH.

Unfortunately we cannot protect against that when using a single DMAC,
as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.

Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
to protect against a user overriding this value?

> --- a/arch/sh/drivers/dma/Kconfig
> +++ b/arch/sh/drivers/dma/Kconfig
> @@ -28,17 +28,19 @@ config SH_DMA_API
>  config NR_ONCHIP_DMA_CHANNELS
>         int
>         depends on SH_DMA
> -       default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
> -                      CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
> +       default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
> +                      CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7751 || \
> +                      CPU_SUBTYPE_SH7091
>         default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
>                        CPU_SUBTYPE_SH7760
> -       default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
> -                       CPU_SUBTYPE_SH7785 || CPU_SUBTYPE_SH7724
> +       default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7724  || \
> +                       CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
>         default "6"
>         help
>           This allows you to specify the number of channels that the on-chip
> -         DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
> -         SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
> +         DMAC supports. This will be 4 for SH7709/SH7750/SH7750S/SH7751/SH7091,
> +         8 for SH7750R/SH7751R/SH7760, and 12 for SH7723/SH7724/SH7780/SH7785.
> +         Default is 6. Must be an even number.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
