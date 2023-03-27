Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43B6CA615
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjC0Nhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjC0Nhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9E1BC6;
        Mon, 27 Mar 2023 06:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D5E61286;
        Mon, 27 Mar 2023 13:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4CC433AE;
        Mon, 27 Mar 2023 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679924255;
        bh=sKw5GnPYWTx1tEo+IYG63yzmzH5uUSkHi5W70RXeiXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=me5d4slZ7BQwLYQm0UbRAC2iVqyUYiUxghqwGTfCH/vpOgHLgDekGA1TBK2dJnpUc
         9WkLB4v/ufSmAfgCCV5YSuoaGaKiOwCqLyqumjx5XyRbF9dJBFFSs6HLt7PEmp891n
         XwMOQwvU37TpfHRmLM6F2Wu2rjJcr08TSj+OfMLw3e/eYNtc8Ff3gi22phENHfgyn4
         DNtHVC4q96uONAXntDKuUBjVgg2LmxrGjTx5EvWUGZrk2TnDCWrxinTYGMaEa37yw+
         smAD8fYPQMq6WbMRXe/30WkwvLcPhMLKpDQqlLl5O9Eqp+HZa9Zv6aqE9YRxyDLRSD
         1UErhgcXn+Ddg==
Received: by mail-ed1-f52.google.com with SMTP id r11so36361759edd.5;
        Mon, 27 Mar 2023 06:37:35 -0700 (PDT)
X-Gm-Message-State: AAQBX9eEu4XKsmRvh0JrG+LYiYn12N/qN/lZiehJvyNIK6uUwrxWSZIa
        fogXil5VslYgdYJZExPp8pksxJBCtWLuhtdig5k=
X-Google-Smtp-Source: AKy350aPL1uQ3r2MblLdeWPWx+R7rA3ZaUJTGPp0hWqhXUlS0wDj97jvk8gg6F5BBuMMpzVJHH5p6CMaiE85EcR30Es=
X-Received: by 2002:a17:906:4746:b0:8ab:b606:9728 with SMTP id
 j6-20020a170906474600b008abb6069728mr5893837ejs.5.1679924253534; Mon, 27 Mar
 2023 06:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-11-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-11-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Mar 2023 21:37:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT73KBZ01N2fr8z6=9XWFKo4D7cGKOtZLZeXN9NrscCXg@mail.gmail.com>
Message-ID: <CAJF2gTT73KBZ01N2fr8z6=9XWFKo4D7cGKOtZLZeXN9NrscCXg@mail.gmail.com>
Subject: Re: [PATCH 10/21] csky: dma-mapping: skip invalidating before DMA
 from device
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> csky is the only architecture that does a full flush for the
> dma_sync_*_for_device(..., DMA_FROM_DEVICE) operation. The requirement
> is only make sure there are no dirty cache lines for the buffer,
> which can be either done through an invalidate operation (as on most
> architectures including arm32, mips and arc), or a writeback (as on
> arm64 and riscv). The cache also has to be invalidated eventually but
> csky already does that after the transfer.
>
> Use a 'clean' operation here for consistency with arm64 and riscv.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/mm/dma-mapping.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 82447029feb4..c90f912e2822 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -60,11 +60,9 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_=
t size,
>  {
>         switch (dir) {
>         case DMA_TO_DEVICE:
> -               cache_op(paddr, size, dma_wb_range);
> -               break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
> -               cache_op(paddr, size, dma_wbinv_range);
> +               cache_op(paddr, size, dma_wb_range);
Reviewed-by: Guo Ren <guoren@kernel.org>


>                 break;
>         default:
>                 BUG();
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
