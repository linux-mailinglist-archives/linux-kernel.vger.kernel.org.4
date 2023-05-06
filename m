Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84F06F8FE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEFHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEFHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD04A267;
        Sat,  6 May 2023 00:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE6361827;
        Sat,  6 May 2023 07:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CA8C433B0;
        Sat,  6 May 2023 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683357955;
        bh=/pqLqv84J2jWuKl1Lk7AhETw9xQvFqEdpB7kxyH6fI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cUPgDdY7WBdR+obN6ZVonxD9+AqvTjDLZek6hO8Bh5anvhOs4TmU67zRl7ySmPvBp
         i8FRz1KX+mzHYYI+Z/y0wYNkkGVlDZfw2wNSyJH6w3yIBsRuEiCKsmGiGIf/pZsEal
         texLImmTg/gCpVHUuWvn14o5Lgf+f1wOysFff2gp10PJHZgoXw6iwYzAwIUxisqWfw
         u5jsEnyW3YFcIFUx6RL4jWbXoqzOfY/dd8vIcdt+Xq68Ux5KJCIYvI2XApR9C23Nmm
         Sgkh2cUCXwwJKLy4JCAVy999KDS8Et5jkyt2gkH/o90zp2F9JCGMHuMQgxIkMklZJH
         mmsRI+wgR/9MQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso4764522a12.0;
        Sat, 06 May 2023 00:25:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDx1fH+AarEJBfLItd5cBE1oD/OYqmgTHedz96Mhy7/Sz0wG3gD+
        8pXZX7UAVq9WS4X4inu9EdKBwRF8HD2z5O2lsMI=
X-Google-Smtp-Source: ACHHUZ4qS4i5Im7J3Ox7v0tb1ueCK3xmeH5uM44ArLR4roviIMhnWXngkOBBuBeiDbJ5qp2UGTwR6EkhF28IpBmVniU=
X-Received: by 2002:a17:907:3d9f:b0:959:5454:1db7 with SMTP id
 he31-20020a1709073d9f00b0095954541db7mr3511012ejc.3.1683357953246; Sat, 06
 May 2023 00:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
 <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com> <f460ad77-aa76-43bb-b2bb-e3b6dbcd8b03@app.fastmail.com>
In-Reply-To: <f460ad77-aa76-43bb-b2bb-e3b6dbcd8b03@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 6 May 2023 15:25:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSRuj3-AgynXxZeXc2vGSH8Ohn5eP2hsuKi8rTzSPLhRQ@mail.gmail.com>
Message-ID: <CAJF2gTSRuj3-AgynXxZeXc2vGSH8Ohn5eP2hsuKi8rTzSPLhRQ@mail.gmail.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before
 bidirectional DMA
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
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
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
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

On Fri, May 5, 2023 at 9:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 5, 2023, at 07:47, Guo Ren wrote:
> > On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>
> >>
> >> riscv also invalidates the caches before the transfer, which does
> >> not appear to serve any purpose.
> > Yes, we can't guarantee the CPU pre-load cache lines randomly during
> > dma working.
> >
> > But I've two purposes to keep invalidates before dma transfer:
> >  - We clearly tell the CPU these cache lines are invalid. The caching
> > algorithm would use these invalid slots first instead of replacing
> > valid ones.
> >  - Invalidating is very cheap. Actually, flush and clean have the same
> > performance in our machine.
>
> The main purpose of the series was to get consistent behavior on
> all machines, so I really don't want a custom optimization on
> one architecture. You make a good point about cacheline reuse
> after invalidation, but if we do that, I'd suggest doing this
> across all architectures.
Yes, invalidation of DMA_FROM_DEVICE-for_device is a proposal for all
architectures.

>
> > So, how about:
> >
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoh=
erent.c
> > index d919efab6eba..2c52fbc15064 100644
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -22,8 +22,6 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size=
_t size,
> >                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> >                 break;
> >         case DMA_FROM_DEVICE:
> > -               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> > -               break;
> >         case DMA_BIDIRECTIONAL:
> >                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> >                 break;
>
> This is something we can consider. Unfortunately, this is something
> that no architecture (except pa-risc, which has other problems)
> does at the moment, so we'd probably need to have a proper debate
> about this.
>
> We already have two conflicting ways to handle DMA_FROM_DEVICE,
> either invalidate/invalidate, or clean/invalidate. I can see
I vote to invalidate/invalidate.

My key point is to let DMA_FROM_DEVICE-for_device invalidate, and
DMA_BIDIRECTIONAL contains DMA_FROM_DEVICE.
So I also agree:
@@ -22,8 +22,6 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t s=
ize,
                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
                 break;
         case DMA_FROM_DEVICE:
 -               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 +              ALT_CMO_OP(invalidate, vaddr, size, riscv_cbom_block_size);
                 break;
         case DMA_BIDIRECTIONAL:
                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
                 break;

> that flush/invalidate may be a sensible option as well, but I'd
> want to have that discussion after the series is complete, so
> we can come to a generic solution that has the same documented
> behavior across all architectures.
Yes, I agree to unify them into a generic solution first. My proposal
could be another topic in the future.
For that purpose, I give
Acked-by: Guo Ren <guoren@kernel.org>

>
> In particular, if we end up moving arm64 and riscv back to the
> traditional invalidate/invalidate for DMA_FROM_DEVICE and
> document that driver must not rely on buffers getting cleaned
After invalidation, the cache lines are also cleaned, right? So why do
we need to document it additionally?

> before a partial DMA_FROM_DEVICE, the question between clean
> or flush becomes moot as well.
>
> > @@ -42,7 +40,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t =
size,
> >                 break;
> >         case DMA_FROM_DEVICE:
> >         case DMA_BIDIRECTIONAL:
> >                 /* I'm not sure all drivers have guaranteed cacheline
> > alignment. If not, this inval would cause problems */
> > -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> > +               ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> >                 break;
>
> This is my original patch, and I would not mix it with the other
> change. The problem with non-aligned DMA_BIDIRECTIONAL buffers in
> is that both flush and inval would be wrong if you get simultaneous
> writes from device and cpu to the same cache line, so there is
> no way to win this. Using inval instead of flush would at least
> work if the CPU data in the cacheline is read-only from the CPU,
> so that seems better than something that is always wrong.
If CPU data in the cacheline is read-only, the cacheline would never
be dirty. Yes, It's always safe.
Okay, I agree we must keep cache-line-aligned. I comment it here, just
worry some dirty drivers couldn't work with the "invalid mechanism"
because of the CPU data corruption, and device data in the cacheline
is useless.

>
> The documented API is that sharing the cache line is not allowed
> at all, so anything that would observe a difference between the
> two is also a bug. One idea that we have considered already is
> that we could overwrite the unused bits of the cacheline with
> poison values and/or mark them as invalid using KASAN for debugging
> purposes, to find drivers that already violate this.
>
>       Arnd



--=20
Best Regards
 Guo Ren
