Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EA745688
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGCHzG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 03:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGCHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:55:01 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5269BA;
        Mon,  3 Jul 2023 00:54:59 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579dfae6855so22582167b3.1;
        Mon, 03 Jul 2023 00:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370899; x=1690962899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap+98X7lUU4Mb/R2w4KrLGdPkASGfI2gOWe+xareG/w=;
        b=gV20QlEGzskXm07NAqjW665ZOYqxSGlkKqWzqoJMbhnIEuBkLxl4oSnIw+4dMp/6Qu
         rTBskUaVp+NpWb1A2bQDMcw75It6Eze/JvCCstzZHZja06hmfb50w1hES/NOjA7v7dan
         j7Duf2YvIsW6Pk8YvaKXdM2KKPxORSPfJuOEeQOagyL0bAenCS2mejFCokjJP/pzSc7c
         Zq+1+yvVojwqbfa83kSVQXXZDAQpRnjQivEcltHnSlHuuWE/kWFqTdswimQT//evGouf
         OvnNrUQYo//zINW7PYrkA1/fRkmHGfnYqN6PqtMmTIRP0DHWMxMC6lcI9iM1F5rOVIo8
         yGZw==
X-Gm-Message-State: ABy/qLZ8JxjsjLPy8UYTLdPS/PjqNX0RSExMIU5yyOlrz4WgP70p8TFd
        LM2iWpojrFiGfOw7jAWMPsQ8GBURmdfLDg==
X-Google-Smtp-Source: APBJJlHb87eLaE470shsNSC1acSVhnfK0tWhT1v3ISD1tEI3oo1td+vo0uIBY60+HpW5q2cS4a+/aQ==
X-Received: by 2002:a0d:f005:0:b0:573:4d8b:471f with SMTP id z5-20020a0df005000000b005734d8b471fmr8421371ywe.26.1688370898728;
        Mon, 03 Jul 2023 00:54:58 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id l189-20020a0dfbc6000000b0055a931afe48sm4942907ywf.8.2023.07.03.00.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 00:54:58 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c4d1b491095so1850181276.0;
        Mon, 03 Jul 2023 00:54:58 -0700 (PDT)
X-Received: by 2002:a25:a287:0:b0:c1a:2928:74ab with SMTP id
 c7-20020a25a287000000b00c1a292874abmr8554017ybi.31.1688370898299; Mon, 03 Jul
 2023 00:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-21-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-21-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 09:54:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5bXeE=nr7+hHxL+xhm2q05udkJpMBM-BG7g9S7Nt7Zg@mail.gmail.com>
Message-ID: <CAMuHMdW5bXeE=nr7+hHxL+xhm2q05udkJpMBM-BG7g9S7Nt7Zg@mail.gmail.com>
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean() helper
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Mar 27, 2023 at 2:16 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm version of the arch_sync_dma_for_cpu() function annotates pages as
> PG_dcache_clean after a DMA, but no other architecture does this here. On
> ia64, the same thing is done in arch_sync_dma_for_cpu(), so it makes sense
> to use the same hook in order to have identical arch_sync_dma_for_cpu()
> semantics as all other architectures.
>
> Splitting this out has multiple effects:
>
>  - for dma-direct, this now gets called after arch_sync_dma_for_cpu()
>    for DMA_FROM_DEVICE mappings, but not for DMA_BIDIRECTIONAL. While
>    it would not be harmful to keep doing it for bidirectional mappings,
>    those are apparently not used in any callers that care about the flag.
>
>  - Since arm has its own dma-iommu abstraction, this now also needs to
>    call the same function, so the calls are added there to mirror the
>    dma-direct version.
>
>  - Like dma-direct, the dma-iommu version now marks the dcache clean
>    for both coherent and noncoherent devices after a DMA, but it only
>    does this for DMA_FROM_DEVICE, not DMA_BIDIRECTIONAL.
>
> [ HELP NEEDED: can anyone confirm that it is a correct assumption
>   on arm that a cache-coherent device writing to a page always results
>   in it being in a PG_dcache_clean state like on ia64, or can a device
>   write directly into the dcache?]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch, which is now commit 322dbe898f82fd8a
("ARM: dma-mapping: split out arch_dma_mark_clean() helper") in
esmil/jh7100-dmapool.

If CONFIG_ARM_DMA_USE_IOMMU=y, the build fails.

> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c

> @@ -1294,6 +1298,17 @@ static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
>         return -EINVAL;
>  }
>
> +static void arm_iommu_sync_dma_for_cpu(phys_addr_t phys, size_t len,
> +                                      enum dma_data_direction dir,
> +                                      bool dma_coherent)
> +{
> +       if (!dma_coherent)
> +               arch_sync_dma_for_cpu(phys, s->length, dir);

s/s->length/len/

> +
> +       if (dir == DMA_FROM_DEVICE)
> +               arch_dma_mark_clean(phys, s->length);

Likewise.

> +}
> +
>  /**
>   * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
>   * @dev: valid struct device pointer

> @@ -1425,9 +1438,9 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
>         if (!iova)
>                 return;
>
> -       if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> +       if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))

Missing opening curly brace.

>                 phys = iommu_iova_to_phys(mapping->domain, handle);
> -               arch_sync_dma_for_cpu(phys, size, dir);
> +               arm_iommu_sync_dma_for_cpu(phys, size, dir, dev->dma_coherent);
>         }
>
>         iommu_unmap(mapping->domain, iova, len);

With the above fixed, it builds and boots fine (on R-Car M2-W).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
