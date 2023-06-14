Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F72672FF25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbjFNMxp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244757AbjFNMxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:53:43 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15110EC;
        Wed, 14 Jun 2023 05:53:42 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1a6bd78fd14so1675515fac.2;
        Wed, 14 Jun 2023 05:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747221; x=1689339221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XWEKvAMOuR1l+m/B+1m8slMbaOUqRu1ZrBY3HpAHis=;
        b=G+OasIuVzyG3o+cQ0PchHEXjMA0q7mNHLgSeyOzYlxFwQRkFZ1UR+kNOyI3tc8rS7/
         VA6t6Jh789Aqiiw/5TbpVde2InRlEXBolmloPm/zbZ+HRUDjz0uUCJAfpms/iSzKyyKS
         mGtfx3cDGnwkxac6lrHzMG2/BcbPP7kxeIMB7O3VLGSWDhS59tkVjqmm8QJ0RHmoOZ21
         /QBOAapg3uah51yABW/Rz3xLtnMaZqZ1fMk/jU/8OX/Jb8VKwfmVaKhJ8kTcNtmrYM3x
         TPfGPgdnUA7UuZdu3f49w4d0ylV1ZtnJATJ5sgp3uF5eDnSWTTMTzNg6gM93Ob/fGDdk
         BBbw==
X-Gm-Message-State: AC+VfDwxpRiQi94vWhOeKYk6S4ZJURYJ8pzpQZju2xU2+LeohMT4gllx
        lF0njQlCl7VyOYACOji3SyrVKppLomEwvA==
X-Google-Smtp-Source: ACHHUZ5hrll0i2MDXIkPOW4ZPUZghO1IsYfpdiPJaLb8RA3iekMg9kAqz236/pPcQYCizVWFr4xm0Q==
X-Received: by 2002:a05:6870:5142:b0:177:ad57:cb36 with SMTP id z2-20020a056870514200b00177ad57cb36mr12505202oak.27.1686747221690;
        Wed, 14 Jun 2023 05:53:41 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id na1-20020a0568706c0100b0019a291d1672sm4962145oab.26.2023.06.14.05.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 05:53:40 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-55b171c06dcso546464eaf.2;
        Wed, 14 Jun 2023 05:53:39 -0700 (PDT)
X-Received: by 2002:a05:6359:a26:b0:129:c25e:1cb0 with SMTP id
 el38-20020a0563590a2600b00129c25e1cb0mr8260221rwb.30.1686747219592; Wed, 14
 Jun 2023 05:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Jun 2023 14:53:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWApGKsS8DU7-=6j6WaRBDZ8Amig2NtA8f8=PbGKoFQjQ@mail.gmail.com>
Message-ID: <CAMuHMdWApGKsS8DU7-=6j6WaRBDZ8Amig2NtA8f8=PbGKoFQjQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Jun 14, 2023 at 12:48 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce support for nonstandard noncoherent systems in the RISC-V
> architecture. It enables function pointer support to handle cache
> management in such systems.
>
> This patch adds a new configuration option called
> "RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
> depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
> support for cache management in nonstandard noncoherent systems.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v8 -> v9
> * New patch

Thanks for your patch!

> --- /dev/null
> +++ b/arch/riscv/include/asm/dma-noncoherent.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +#ifndef __ASM_DMA_NONCOHERENT_H
> +#define __ASM_DMA_NONCOHERENT_H
> +
> +#include <linux/dma-direct.h>
> +
> +/*
> + * struct riscv_cache_ops - Structure for CMO function pointers
> + *
> + * @clean: Function pointer for clean cache
> + * @inval: Function pointer for invalidate cache
> + * @flush: Function pointer for flushing the cache
> + */
> +struct riscv_cache_ops {
> +       void (*clean)(phys_addr_t paddr, unsigned long size);
> +       void (*inval)(phys_addr_t paddr, unsigned long size);
> +       void (*flush)(phys_addr_t paddr, unsigned long size);
> +};

I guess the naming can be improved?

.clean() is used by arch_dma_cache_wback() / arch_wb_cache_pmem(),
.inval() is used by arch_dma_cache_inv() / arch_invalidate_pmem(),
.flush() is used by arch_dma_cache_wback_inv() / arch_dma_prep_coherent().

Perhaps .wback(), .inv(), .wback_inv() are more clear?

I understand this is subject to bikeshedding...
But hey, how many innocent bits of data have already been lost due
to cache semantic mismatches?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
