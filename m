Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D763804F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKXUrz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Nov 2022 15:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:47:54 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CD1DA4F;
        Thu, 24 Nov 2022 12:47:50 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oyJ8D-0007r7-PG; Thu, 24 Nov 2022 21:47:37 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five SoC
Date:   Thu, 24 Nov 2022 21:47:36 +0100
Message-ID: <5258334.1IzOArtZ34@diego>
In-Reply-To: <CA+V-a8suCqONgmXvoEnibfY1e9+1Uke3dj3HaLiCNd74zZFU4g@mail.gmail.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <5382916.ejJDZkT8p0@diego> <CA+V-a8suCqONgmXvoEnibfY1e9+1Uke3dj3HaLiCNd74zZFU4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. November 2022, 20:56:39 CET schrieb Lad, Prabhakar:
> Hi Heiko,
> 
> Thank you for the review.
> 
> On Thu, Nov 24, 2022 at 6:30 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Am Donnerstag, 24. November 2022, 18:22:07 CET schrieb Prabhakar:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > On the AX45MP core, cache coherency is a specification option so it may
> > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > allocate a global dma coherent pool from which DMA allocations are taken
> > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > in the device tree. Synchronization callbacks are implemented to
> > > synchronize when doing DMA transactions.
> > >
> > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > It contains a configurable amount of PMA entries implemented as CSR
> > > registers to control the attributes of memory locations in interest.
> > >
> > > Below are the memory attributes supported:
> > > * Device, Non-bufferable
> > > * Device, bufferable
> > > * Memory, Non-cacheable, Non-bufferable
> > > * Memory, Non-cacheable, Bufferable
> > > * Memory, Write-back, No-allocate
> > > * Memory, Write-back, Read-allocate
> > > * Memory, Write-back, Write-allocate
> > > * Memory, Write-back, Read and Write-allocate
> > >
> > > This patch adds support to configure the memory attributes of the memory
> > > regions as passed from the l2 cache node and exposes the cache management
> > > ops.
> > >
> > > More info about PMA (section 10.3):
> > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > RFC v3 -> v4
> > > * Made use of runtime patching instead of compile time
> > > * Now just exposing single function ax45mp_no_iocp_cmo() for CMO handling
> > > * Added a check to make sure cache line size is always 64 bytes
> > > * Renamed folder rzf -> rzfive
> > > * Improved Kconfig description
> > > * Dropped L2 cache configuration
> > > * Dropped unnecessary casts
> > > * Fixed comments pointed by Geert, apart from use of PTR_ALIGN_XYZ() macros.
> > > ---
> > >  arch/riscv/include/asm/cacheflush.h       |   8 +
> > >  arch/riscv/include/asm/errata_list.h      |  32 +-
> > >  drivers/soc/renesas/Kconfig               |   7 +
> > >  drivers/soc/renesas/Makefile              |   2 +
> > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> > >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 415 ++++++++++++++++++++++
> > >  drivers/soc/renesas/rzfive/ax45mp_sbi.h   |  29 ++
> > >  8 files changed, 496 insertions(+), 6 deletions(-)
> > >  create mode 100644 drivers/soc/renesas/rzfive/Kconfig
> > >  create mode 100644 drivers/soc/renesas/rzfive/Makefile
> > >  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_cache.c
> > >  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_sbi.h
> > >
> > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > > index 4a04d1be7c67..3226f3aceafe 100644
> > > --- a/arch/riscv/include/asm/cacheflush.h
> > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > @@ -61,6 +61,14 @@ static inline void riscv_noncoherent_supported(void) {}
> > >  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
> > >  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
> > >
> > > +#ifdef CONFIG_AX45MP_L2_CACHE
> > > +extern asmlinkage void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr,
> > > +                                       size_t size, int dir, int ops);
> > > +#else
> > > +inline void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr,
> > > +                            size_t size, int dir, int ops) {}
> > > +#endif
> > > +
> > >  #include <asm-generic/cacheflush.h>
> > >
> > >  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > > index 48e899a8e7a9..300fed3bfd80 100644
> > > --- a/arch/riscv/include/asm/errata_list.h
> > > +++ b/arch/riscv/include/asm/errata_list.h
> > > @@ -125,8 +125,8 @@ asm volatile(ALTERNATIVE(                                         \
> > >  #define THEAD_SYNC_S ".long 0x0190000b"
> > >
> > >  #define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)               \
> > > -asm volatile(ALTERNATIVE_2(                                          \
> > > -     __nops(6),                                                      \
> > > +asm volatile(ALTERNATIVE_3(                                          \
> > > +     __nops(14),                                                     \
> > >       "mv a0, %1\n\t"                                                 \
> > >       "j 2f\n\t"                                                      \
> > >       "3:\n\t"                                                        \
> > > @@ -134,7 +134,7 @@ asm volatile(ALTERNATIVE_2(                                               \
> > >       "add a0, a0, %0\n\t"                                            \
> > >       "2:\n\t"                                                        \
> > >       "bltu a0, %2, 3b\n\t"                                           \
> > > -     "nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,           \
> > > +     __nops(8), 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,       \
> > >       "mv a0, %1\n\t"                                                 \
> > >       "j 2f\n\t"                                                      \
> > >       "3:\n\t"                                                        \
> > > @@ -142,8 +142,28 @@ asm volatile(ALTERNATIVE_2(                                              \
> > >       "add a0, a0, %0\n\t"                                            \
> > >       "2:\n\t"                                                        \
> > >       "bltu a0, %2, 3b\n\t"                                           \
> > > -     THEAD_SYNC_S, THEAD_VENDOR_ID,                                  \
> > > -                     ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)      \
> > > +     THEAD_SYNC_S "\n\t"                                             \
> > > +     __nops(8), THEAD_VENDOR_ID,                                     \
> > > +                     ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO,      \
> > > +     ".option push\n\t\n\t"                                          \
> > > +     ".option norvc\n\t"                                             \
> > > +     ".option norelax\n\t">                                          \
> >
> > alternatives already do the norvc + norelax options anyway for old and new instructions,
> > so the .option stuff shouldn't be necessary I guess?
> >
> I did a quick run with .option stuff and all seems to be OK. I'll do
> some rigorous testing and get rid of it in the next version.
> >
> > > +     "addi sp,sp,-16\n\t"                                            \
> > > +     "sd s0,0(sp)\n\t"                                               \
> > > +     "sd ra,8(sp)\n\t"                                               \
> > > +     "addi s0,sp,16\n\t"                                             \
> > > +     "mv a4,%6\n\t"                                                  \
> > > +     "mv a3,%5\n\t"                                                  \
> > > +     "mv a2,%4\n\t"                                                  \
> > > +     "mv a1,%3\n\t"                                                  \
> > > +     "mv a0,%0\n\t"                                                  \
> > > +     "call ax45mp_no_iocp_cmo\n\t"                                   \
> > > +     "ld ra,8(sp)\n\t"                                               \
> > > +     "ld s0,0(sp)\n\t"                                               \
> > > +     "addi sp,sp,16\n\t"                                             \
> > > +     ".option pop\n\t",                                              \
> > > +     ANDESTECH_VENDOR_ID, ERRATA_ANDESTECH_NO_IOCP,                  \
> > > +     CONFIG_ERRATA_ANDES_CMO)                                        \
> > >       : : "r"(_cachesize),                                            \
> > >           "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),       \
> > >           "r"((unsigned long)(_start) + (_size)),                     \
> > > @@ -151,7 +171,7 @@ asm volatile(ALTERNATIVE_2(                                               \
> > >           "r"((unsigned long)(_size)),                                \
> > >           "r"((unsigned long)(_dir)),                                 \
> > >           "r"((unsigned long)(_ops))                                  \
> > > -     : "a0")
> > > +     : "a0", "a1", "a2", "a3", "a4", "memory")
> > >
> > >  #define THEAD_C9XX_RV_IRQ_PMU                        17
> > >  #define THEAD_C9XX_CSR_SCOUNTEROF            0x5c5
> <snip>
> > > +static int ax45mp_l2c_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device_node *np = pdev->dev.of_node;
> > > +     int ret;
> > > +
> > > +     ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
> > > +     if (!ax45mp_priv)
> > > +             return -ENOMEM;
> > > +
> > > +     ax45mp_priv->l2c_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
> > > +     if (!ax45mp_priv->l2c_base) {
> > > +             ret = -ENOMEM;
> > > +             goto l2c_err;
> > > +     }
> > > +
> > > +     ret = ax45mp_configure_l2_cache(np);
> > > +     if (ret)
> > > +             goto l2c_err;
> > > +
> > > +     ret = ax45mp_configure_pma_regions(np);
> > > +     if (ret)
> > > +             goto l2c_err;
> > > +
> > > +     static_branch_disable(&ax45mp_l2c_configured);
> > > +
> > > +     return 0;
> > > +
> > > +l2c_err:
> > > +     devm_kfree(&pdev->dev, ax45mp_priv);
> > > +     ax45mp_priv = NULL;
> > > +     return ret;
> > > +}
> > > +
> > > +static const struct of_device_id ax45mp_cache_ids[] = {
> > > +     { .compatible = "andestech,ax45mp-cache" },
> > > +     { /* sentinel */ }
> > > +};
> > > +
> > > +static struct platform_driver ax45mp_l2c_driver = {
> > > +     .driver = {
> > > +             .name = "ax45mp-l2c",
> > > +             .of_match_table = ax45mp_cache_ids,
> > > +     },
> > > +     .probe = ax45mp_l2c_probe,
> > > +};
> > > +
> > > +static int __init ax45mp_cache_init(void)
> > > +{
> > > +     static_branch_enable(&ax45mp_l2c_configured);
> > > +     return platform_driver_register(&ax45mp_l2c_driver);
> >
> > the ordering is racy I think.
> >
> > I.e. in the function called from the cmo operations (ax45mp*_range)
> > you need to access ax45mp_priv and its line-size element.
> >
> > But when you enable the static branch the driver is not yet registered
> > but even more important, also not probed yet.
> >
> > So I guess the static-branch-enable should be living at the end of
> > ax45mp_l2c_probe()
> >
> Hmm so my understanding is incorrect.
> 
> static_branch_unlikely() - evaluates to false when
> static_branch_enable() is called
> static_branch_unlikely() - evaluates to true when
> static_branch_disable() is called
>
> Is that what you meant?

That is an issue as well :-)

I.e. static_branch_* will always return true when enabled
and false when disabled. The likely / unlikely suffix is a mechanism
for runtime performance, i.e. unlikely means that you expect
the static-key to be false in _most_ cases, where likely means
you expect it to be true in most cases.

But also

- arch_initcall(ax45mp_cache_init);
- does static-branch enable
- registers platform_driver
- platform_driver probes
- kzalloc(priv)
... [1]
- priv->line_size from dt

at [1] your condition could already be fullfilled
but you don't have a cache-line-size yet.


Heiko


