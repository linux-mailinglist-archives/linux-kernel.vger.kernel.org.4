Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648B160C032
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJYAw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJYAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:52:38 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E711D3766;
        Mon, 24 Oct 2022 16:34:09 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1omwC7-0001Zb-SU; Mon, 24 Oct 2022 14:04:39 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for RZ/Five SoC
Date:   Mon, 24 Oct 2022 14:04:38 +0200
Message-ID: <4750602.GXAFRqVoOG@diego>
In-Reply-To: <CA+V-a8vA_ZbV+SEy8Ch8ZuYAb+U37CtC8Ys=svMv7fjy79mR=A@mail.gmail.com>
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y1Md4bMYJHI34HuJ@spud> <CA+V-a8vA_ZbV+SEy8Ch8ZuYAb+U37CtC8Ys=svMv7fjy79mR=A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Am Montag, 24. Oktober 2022, 13:55:00 CEST schrieb Lad, Prabhakar:
> Hi Conor,
> 
> On Fri, Oct 21, 2022 at 11:32 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Oct 21, 2022 at 11:05:40PM +0100, Lad, Prabhakar wrote:
> > > Hi Rob,
> > >
> > > Thank you for the review.
> > >
> > > On Fri, Oct 21, 2022 at 3:05 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Oct 19, 2022 at 11:02:42PM +0100, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > On the AX45MP core, cache coherency is a specification option so it may
> > > > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > > > allocate a global dma coherent pool from which DMA allocations are taken
> > > > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > > > in the device tree. Synchronization callbacks are implemented to
> > > > > synchronize when doing DMA transactions.
> > > > >
> > > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > > registers to control the attributes of memory locations in interest.
> > > > >
> > > > > Below are the memory attributes supported:
> > > > > * Device, Non-bufferable
> > > > > * Device, bufferable
> > > > > * Memory, Non-cacheable, Non-bufferable
> > > > > * Memory, Non-cacheable, Bufferable
> > > > > * Memory, Write-back, No-allocate
> > > > > * Memory, Write-back, Read-allocate
> > > > > * Memory, Write-back, Write-allocate
> > > > > * Memory, Write-back, Read and Write-allocate
> > > > >
> > > > > This patch adds support to configure the memory attributes of the memory
> > > > > regions as passed from the l2 cache node and exposes the cache management
> > > > > ops.
> > > > >
> > > > > More info about PMA (section 10.3):
> > > > > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > > >
> > > > > This feature is based on the work posted [0] by Vincent Chen
> > > > > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> > > > >
> > > > > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/cacheflush.h    |   8 +
> > > > >  arch/riscv/include/asm/errata_list.h   |   2 +
> > > > >  arch/riscv/mm/dma-noncoherent.c        |  20 ++
> > > > >  drivers/soc/renesas/Kconfig            |   5 +
> > > > >  drivers/soc/renesas/Makefile           |   4 +
> > > > >  drivers/soc/renesas/rzf/Kconfig        |   6 +
> > > > >  drivers/soc/renesas/rzf/Makefile       |   3 +
> > > > >  drivers/soc/renesas/rzf/ax45mp_cache.c | 431 +++++++++++++++++++++++++
> > > >
> > > > How many cache drivers do we have around now? I've seen a few bindings
> > > > go by. I'm guessing it is time to stop putting the drivers in the
> > > > drivers/soc/ dumping ground.
> > > >
> > > The main reason this driver is not in arch/riscv is that it has vendor
> > > specific extensions. Due to this reason it was agreed during the LPC
> > > that vendor specific extension should be maintained by SoC vendors and
> > > was agreed that this can go into drivers/soc/renesas folder instead.
> >
> > Does not in drivers/soc mean they need to go into arch/riscv?
> I was under the impression Rob wanted them arch/riscv, sorry for the confusion.
> 
> > The outcome of the chat at the LPC BoF was more that the cache drivers
> > themselves should not be be routed via the arch maintainers, no?
> >
> Indeed.
> 
> > >
> > > > >  drivers/soc/renesas/rzf/ax45mp_sbi.h   |  29 ++
> > > > >  9 files changed, 508 insertions(+)
> > > > >  create mode 100644 drivers/soc/renesas/rzf/Kconfig
> > > > >  create mode 100644 drivers/soc/renesas/rzf/Makefile
> > > > >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
> > > > >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_sbi.h
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > > > > index 8a5c246b0a21..40aa790be9a3 100644
> > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > @@ -65,6 +65,14 @@ static inline void riscv_noncoherent_supported(void) {}
> > > > >  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
> > > > >  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
> > > > >
> > > > > +#ifdef CONFIG_AX45MP_L2_CACHE
> > > > > +void ax45mp_cpu_dma_inval_range(void *vaddr, size_t end);
> > > > > +void ax45mp_cpu_dma_wb_range(void *vaddr, size_t end);
> > > > > +
> > > > > +#define ALT_CMO_OP(_op, _start, _size, _cachesize)   \
> > > > > +                _op(_start, _size)
> > > > > +#endif
> > > > > +
> > > > >  #include <asm-generic/cacheflush.h>
> > > > >
> > > > >  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> > > > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > > > > index 19a771085781..d9cbf60c3b65 100644
> > > > > --- a/arch/riscv/include/asm/errata_list.h
> > > > > +++ b/arch/riscv/include/asm/errata_list.h
> > > > > @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(                                           \
> > > > >  #define ALT_THEAD_PMA(_val)
> > > > >  #endif
> > > > >
> > > > > +#ifdef CONFIG_ERRATA_THEAD_CMO
> > > > >  /*
> > > > >   * dcache.ipa rs1 (invalidate, physical address)
> > > > >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > > > @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(                                               \
> > > > >       : "a0")
> > > > >
> > > > >  #endif /* __ASSEMBLY__ */
> > > > > +#endif
> > > > >
> > > > >  #endif
> > > > > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > > > > index b0add983530a..5270acca6766 100644
> > > > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > > > @@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> > > > >
> > > > >       switch (dir) {
> > > > >       case DMA_TO_DEVICE:
> > > > > +#ifdef CONFIG_ERRATA_THEAD_CMO
> > > > >               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> > > > > +#elif CONFIG_AX45MP_L2_CACHE
> > > > > +             ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, 0x0);
> > > > > +#endif
> > > >
> > > > How do you support more than one platform in a build?
> > > >
> > > Yes, that's one concern which I have mentioned in the cover letter too
> > > (At that moment it's just a single platform). Suggestions welcome!
> >
> > I think I said it on one of the earlier version, but it needs to be
> > implemented w/ runtime patching via alternatives just like the thead
> > stuff patches in their functions.
> >
> I'm a bit stumped with alternatives() usage.
> 
> Currently I am just replacing the ALT_CMO_OP() macro if
> CONFIG_AX45MP_L2_CACHE is enabled. For AX45MP currently we have two
> exported functions ax45mp_cpu_dma_inval_range/ax45mp_cpu_dma_wb_range.
> If I switch to
> ALTERNATIVE() macro usage then I'll have to use the assembly version
> of the above two mentioned functions?

The overarching goal should always be the unified-kernel-image.
So hardware-specific compile-time #ifeefs are normally a no-no :-) .

So yes, it most likely should be assembly-based, and you'll "just" need
to introduce an ALTERNATIVE_3 macro, similar to what ALTERNAITVE_2 does.

That is actually the really nice part of alternatives, that you can have as
many variants as you like.

Heiko


