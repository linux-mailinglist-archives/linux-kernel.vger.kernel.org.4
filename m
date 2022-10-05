Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E505F5122
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJEIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJEIp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:45:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953860500;
        Wed,  5 Oct 2022 01:45:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s30so18323466eds.1;
        Wed, 05 Oct 2022 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=N76xG0GokcjJpvpLRh+j2uUxMJHbvuLcunuG3FqOIOk=;
        b=ir+E89PfW/2E8TzckX4+QpM7sGEz08GHphTr5bzssCRppG+8uk0G/JQaN3+QLy8Yk7
         pNhbAWqqsFcrMaWTTxfeQuk+cTyPoKDSQo5i+D9iXmnAKPi/OnIxgwoqkFcREKhJJaYt
         M83ipmWdee4ly+MBkh4Dz9lU8JYUe5cTgZvbvksY5Z9UqFqNmGZcJttGNkACpEk0j6dC
         d+S3+Cv7QCv8APWWAswpUkQqehT3lnRsV7Q+cnKOuUKs20btFw/u+7FsPXg73/4ZPd/T
         NW9U/ljKXvRMaeaaFOUgKreHJo7k5jmBI+K0Lx3LpT/FBx5k10r84c3AhDtPjqfLIgXH
         Jyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=N76xG0GokcjJpvpLRh+j2uUxMJHbvuLcunuG3FqOIOk=;
        b=W8xc63d35QCJUEqn0iabpMHtUQmIq4X3rvQZfq2c8+NUQHb4OIoqGvHuZ+cmH+RP7/
         qWGg0x+ZKL87twW/gOaVubz4vQRBSPnRlJHqVAt9rD0USVyUitabwYx5dPJeIoCBZevz
         6ZiiFnycsJgkrZJo2r4uUz3yN3oJj6eu+cifT6buYtt/kZwcGGIfIgHHOLwXocev1Pmv
         EYUiqSZidemTYCNpPij8vvyekI6mR4ajsq4bbNFm3kp78cECigO/6e2DNCz/3AiUJOHc
         wQwKy/D4lMdHNWTeC/5Efgla4MsLowtg0h2arGvHSDaNVpfoouLQuQ+0cdlIUEbJIGzE
         H/DA==
X-Gm-Message-State: ACrzQf3RPUZYSOljpVAijk1VvK/+fNtjKjyshvxpIS0YNlxkGL0wdqZj
        FT5iRhm6MAKL7nxIUaaskoEosSbU9CHi96YIddC8W17yrtQWBl8O
X-Google-Smtp-Source: AMsMyM5zyrSMfLw5ECN5O9MJim8yz5492TSxgHP6eVP8VHNO6NpyX1ftQ6ekHgvru4ZYQsiwdEi4AWPRu7/n7tCG7yc=
X-Received: by 2002:a05:6402:50d4:b0:459:6f54:40df with SMTP id
 h20-20020a05640250d400b004596f5440dfmr5457133edb.255.1664959523406; Wed, 05
 Oct 2022 01:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <YzxwoELNBctbhjJb@spud>
In-Reply-To: <YzxwoELNBctbhjJb@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Oct 2022 09:44:56 +0100
Message-ID: <CA+V-a8tgvF16vduoQ+ZbzTpRJUmCnN-GPQs5G8AqMOXbnznwHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the review.

On Tue, Oct 4, 2022 at 6:43 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Oct 03, 2022 at 11:32:22PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the AX45MP core, cache coherency is a specification option so it may
> > not be supported. In this case DMA will fail. As a workaround, firstly we
> > allocate a global dma coherent pool from which DMA allocations are taken
> > and marked as non-cacheable + bufferable using the PMA region as specified
> > in the device tree. Synchronization callbacks are implemented to
> > synchronize when doing DMA transactions.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> >
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> >
> > This patch adds support to configure the memory attributes of the memory
> > regions as passed from the l2 cache node and exposes the cache management
> > ops. Currently the OpenSBI code implements support for "Memory,
> > Non-cacheable, Non-bufferable" option with SBI_EXT_ANDES_SET_PMA.
> >
> > More info about PMA (section 10.3):
> > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >
> > This feature is based on the work posted [0] by Vincent Chen
> > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> >
> > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/riscv/include/asm/cacheflush.h    |   8 +
> >  arch/riscv/include/asm/errata_list.h   |   2 +
> >  arch/riscv/include/asm/sbi.h           |   1 +
> >  arch/riscv/mm/dma-noncoherent.c        |  20 ++
>
> Stupid question maybe, but I assume you mixed the driver addition and
> the changes to arch/riscv for the sake of easily creating the RFC?
>
Indeed.

> >  drivers/soc/renesas/Makefile           |   4 +
> >  drivers/soc/renesas/rzf/Makefile       |   3 +
> >  drivers/soc/renesas/rzf/ax45mp_cache.c | 365 +++++++++++++++++++++++++
> >  drivers/soc/renesas/rzf/rzf_sbi.h      |  27 ++
> >  8 files changed, 430 insertions(+)
> >  create mode 100644 drivers/soc/renesas/rzf/Makefile
> >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
> >  create mode 100644 drivers/soc/renesas/rzf/rzf_sbi.h
> >
>
> I won't make any comments on the ALTERNATIVES usage & leave that to the
> likes of Heiko rather than make a fool of myself! But to my untrained
> eye, having to use #defines looks like you've strayed pretty far from
> the light.. My understanding was that the whole point was to avoid
> having any ifdef-ery!
>
Agreed, as mentioned in the cover letter, we need an approach where we
can detect things runtime and not degrade the system and get rid of
ifdef-ery!. (Suggestion welcome :))

> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 2a0ef738695e..10a7c855d125 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -37,6 +37,7 @@ enum sbi_ext_id {
> >
> >         /* Vendor extensions must lie within this range */
> >         SBI_EXT_VENDOR_START = 0x09000000,
> > +       SBI_EXT_ANDES = 0x0900031E,
> >         SBI_EXT_VENDOR_END = 0x09FFFFFF,
> >  };
>
> Hmm, does this belong there? It certainly makes the comment look a
> little odd! /If/ it goes into this file, I think it should be in a
> separate section "heading" - but could it not be put into rzf_sbi.h?
>
It can be moved to rzf_sbi.h

> > diff --git a/drivers/soc/renesas/rzf/ax45mp_cache.c b/drivers/soc/renesas/rzf/ax45mp_cache.c
> > new file mode 100644
> > index 000000000000..6eca32aef33e
> > --- /dev/null
> > +++ b/drivers/soc/renesas/rzf/ax45mp_cache.c
> > @@ -0,0 +1,365 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PMA setup and non-coherent cache functions for AX45MP
> > + *
>
> Given your comment in the commit message, should this also be carrying a
> copyright from Andestech?
>
I was in two minds as the code has changed a lot compared to orignal
patch series. If you insist I can include it.

> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <linux/cacheinfo.h>
> > +#include <linux/of_address.h>
> > +
>
> > +static void __iomem *l2c_base;
> > +
> > +/* -----------------------------------------------------------------------------
>
> I'll (mostly) keep my nose out of style for soc/renesas, but this /* ---
> style looks unusual!
>
It's not typical style we use in soc/renesas its just that I wanted to
separate functions it out.

> > + * PMA setup
> > + */
>
> > +static long sbi_set_pma(void *arg)
> > +static void ax45mp_configure_pma_regions(struct device_node *np, int count)
> > +static void cpu_dcache_inval_range(unsigned long start,
> > +void rzfive_cpu_dma_inval_range(void *vaddr, size_t size)
>
> There's a real mix of function name prefixes in here, sbi_ aside is
> there a reason you didn't just stick to ax45mp_foo()? Apologies if
> I missed something that should've been obvious
>
Agreed, I will follow ax45mp_foo() approach.

> > +static void cpu_dcache_wb_range(unsigned long start,
> > +                             unsigned long end,
> > +                             int line_size)
> > +{
> > +     bool ucctl_ok = false;
> > +     unsigned long pa;
> > +     int mhartid = 0;
> > +#ifdef CONFIG_SMP
> > +     mhartid = smp_processor_id();
> > +#endif
>
> Won't this produce complaints from your if you compile with CONFIG_SMP
> set?
>
No I dont see a build issue with SMP enabled, do you see any reason
why it should fail?

Cheers,
Prabhakar
