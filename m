Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823226F7C83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjEEFrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEFrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398A11D89;
        Thu,  4 May 2023 22:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA2563B30;
        Fri,  5 May 2023 05:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEBDC433B0;
        Fri,  5 May 2023 05:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683265636;
        bh=TmEJ43a9wRyU79Q4Z9WHv4VZR6aLeCdSzDRMZZtHgkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I2g+vyhe1hoLtc3xpRjAc9BU/OAumbEN1B7Qbc0uCZJ6vm38izq9WxgG6TDQIw9Cn
         gtD6rIxqmEHNa8rMU8v/ldvTpcVtaEF3DSdJwkdOmvdfZad8eHH3pZuMYUuPnRHXOF
         aYYdetp0cJMW6mFI28DiTiu7OK1/suDqFmm+PnshMDcFrjGxdV75SdkN4eyVXeCkzW
         HSaITHGNl7LHZa0zreUIjIqZKUUeH1GUas9yTSfl5gIOK4Nx3H8cZuqGu0g7MQUCMn
         LcnwJPgGPB8cca2qNfnc8SP0goqQZTmJ1qZnOLhwiQAwrnHXfTiUVeCmF7841pmmh4
         RSuO/9+XH4fLg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-94f3cd32799so263635666b.0;
        Thu, 04 May 2023 22:47:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDz2FrmL4Up3fD5j3mGM/O8YWH2p5IWI7Om1S8wwmKwlPsAcDzfQ
        f0Yxie+j4D8vrLMz9f2waM7nC/UUl9aPPiqySfE=
X-Google-Smtp-Source: ACHHUZ7vjZvoO17O2+xGcjw8YRQwo0MSgi9BtdhaWD+v+3nmuTyY0RrEyW2wbSK+lqJd6C9lcTXOXjjLYHG3jJse7RE=
X-Received: by 2002:a17:907:1c07:b0:960:ddba:e5c7 with SMTP id
 nc7-20020a1709071c0700b00960ddbae5c7mr139047ejc.40.1683265634680; Thu, 04 May
 2023 22:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 5 May 2023 13:47:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
Message-ID: <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before
 bidirectional DMA
To:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Brian Cain <bcain@quicinc.com>,
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
>
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
Yes, we can't guarantee the CPU pre-load cache lines randomly during
dma working.

But I've two purposes to keep invalidates before dma transfer:
 - We clearly tell the CPU these cache lines are invalid. The caching
algorithm would use these invalid slots first instead of replacing
valid ones.
 - Invalidating is very cheap. Actually, flush and clean have the same
performance in our machine.

So, how about:

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoheren=
t.c
index d919efab6eba..2c52fbc15064 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -22,8 +22,6 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t s=
ize,
                ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
                break;
        case DMA_FROM_DEVICE:
-               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-               break;
        case DMA_BIDIRECTIONAL:
                ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
                break;
@@ -42,7 +40,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size=
,
                break;
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
                /* I'm not sure all drivers have guaranteed cacheline
alignment. If not, this inval would cause problems */
-               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
                break;
        default:
                break;

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index 640f4c496d26..69c80b2155a1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t=
 size,
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         case DMA_BIDIRECTIONAL:
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         default:
>                 break;
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
