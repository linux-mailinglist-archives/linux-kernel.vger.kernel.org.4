Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020763DBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiK3RQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiK3RP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:15:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA533B08
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:14:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a16so3474526edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj3StdHBGTawh0e6h/e+Le5dr9aX+Vm1MyzuqjyovbM=;
        b=scadwmJXHd6bp347syF/H4ak1MBvj9K1DEb/9kP+TIsR5O8zYHvZEwO+GZWZhJuZKC
         5DuqFIz+i5YyZevQxZH4jWzqELHY1hV2r+5SpE9Js4gvW6kSu1Ve2u/Ua/OC9iEKKrii
         9uRw5oFpAkeSOj4AF59t2Ape7Fta4KFwvw860JaR59lda2r1SxEuxKDXwoYsH2joxtiL
         MPChT6+w1uKq1HLeMVNkyc48sIQvi98DZoLKFOAVcfaebVmhuE4j1KxCasqBCYlWN3Zc
         FZEAtKAFgVNw5lYv1a7J4SkGFcGwGvWuuW3mc6007J9Rp9XvcVxkiBvj35EESHYpj8iu
         48dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj3StdHBGTawh0e6h/e+Le5dr9aX+Vm1MyzuqjyovbM=;
        b=cJ+YoU0CXHxtgUFRMFcQxDipGrDWpugTP62xDCm0mxyCbW8Qa5yMJ+c3ynULhKVb3K
         /MjHKp/kwVTVFWXSdm+13lCta5uHBCgWqDQuDs7paaA7n37rb01uGoXsKnwLUhfk0BkM
         FfwpiaPaYoB14sgCpN5864Jbf1YCLB/J82Nc4fM/dty5BsjTh4LA4shTYA/i3CLagxGB
         p2PCPZoleiKGSoKKZuLvhRIK/yhdx2hToifm+loHqTv8POr2u0DFpiz+jjhOUEXUIPaZ
         u7l+BYSb0xkVJSfc8TfGqGRI+tmlNvDhYR/2LubHLLozB1VLPmYe52OaXXxj4zfFclkm
         5bbg==
X-Gm-Message-State: ANoB5pl8wIQJeV8gEmPBw9zV4xBCiEypfxoImQeStL90PVgRA/JXd5Bb
        nzD2jT1szLJjQBP0220V9FaC66ncI3SZWKB1uGuE4w==
X-Google-Smtp-Source: AA0mqf4xIQ+xtTOaX/KDZS3gsulsEZW7VRGmN2Lqa7e6ntq7Rf8Scl6rU0A5sUbUv17N4XKQp90JwWQgzM6iO8uUWrI=
X-Received: by 2002:aa7:d7d4:0:b0:46b:7f11:10a4 with SMTP id
 e20-20020aa7d7d4000000b0046b7f1110a4mr7764818eds.59.1669828461075; Wed, 30
 Nov 2022 09:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20221129142449.886518-1-apatel@ventanamicro.com>
 <20221129142449.886518-5-apatel@ventanamicro.com> <86bkoomn4h.wl-maz@kernel.org>
In-Reply-To: <86bkoomn4h.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 30 Nov 2022 22:44:09 +0530
Message-ID: <CAAhSdy0T1G7=XVSmtYxONtfk+5-XYnv3qWyFL2Nnp-MS3aQroA@mail.gmail.com>
Subject: Re: [PATCH v13 4/7] RISC-V: Treat IPIs as normal Linux IRQs
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 9:48 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 29 Nov 2022 14:24:46 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Currently, the RISC-V kernel provides arch specific hooks (i.e.
> > struct riscv_ipi_ops) to register IPI handling methods. The stats
> > gathering of IPIs is also arch specific in the RISC-V kernel.
> >
> > Other architectures (such as ARM, ARM64, and MIPS) have moved away
> > from custom arch specific IPI handling methods. Currently, these
> > architectures have Linux irqchip drivers providing a range of Linux
> > IRQ numbers to be used as IPIs and IPI triggering is done using
> > generic IPI APIs. This approach allows architectures to treat IPIs
> > as normal Linux IRQs and IPI stats gathering is done by the generic
> > Linux IRQ subsystem.
> >
> > We extend the RISC-V IPI handling as-per above approach so that arch
> > specific IPI handling methods (struct riscv_ipi_ops) can be removed
> > and the IPI handling is done through the Linux IRQ subsystem.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig                |   2 +
> >  arch/riscv/include/asm/sbi.h      |  10 +-
> >  arch/riscv/include/asm/smp.h      |  35 ++++---
> >  arch/riscv/kernel/Makefile        |   1 +
> >  arch/riscv/kernel/cpu-hotplug.c   |   3 +-
> >  arch/riscv/kernel/irq.c           |   3 +-
> >  arch/riscv/kernel/sbi-ipi.c       |  81 ++++++++++++++++
> >  arch/riscv/kernel/sbi.c           | 106 +++-----------------
> >  arch/riscv/kernel/smp.c           | 155 +++++++++++++++---------------
> >  arch/riscv/kernel/smpboot.c       |   5 +-
> >  drivers/clocksource/timer-clint.c |  65 ++++++++++---
> >  drivers/irqchip/Kconfig           |   1 +
> >  drivers/irqchip/irq-riscv-intc.c  |  55 +++++------
> >  13 files changed, 287 insertions(+), 235 deletions(-)
> >  create mode 100644 arch/riscv/kernel/sbi-ipi.c
> >
>
> [...]
>
> > diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> > new file mode 100644
> > index 000000000000..6466706b03a7
> > --- /dev/null
> > +++ b/arch/riscv/kernel/sbi-ipi.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Multiplex several IPIs over a single HW IPI.
> > + *
> > + * Copyright (c) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/init.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/percpu.h>
> > +#include <asm/sbi.h>
> > +
> > +static int sbi_ipi_virq;
> > +static DEFINE_PER_CPU_READ_MOSTLY(int, sbi_ipi_dummy_dev);
> > +
> > +static irqreturn_t sbi_ipi_handle(int irq, void *dev_id)
> > +{
> > +     csr_clear(CSR_IP, IE_SIE);
> > +     ipi_mux_process();
> > +     return IRQ_HANDLED;
>
> Urgh... I really wish I hadn't seen this. This requires a chained
> handler. You had it before, and yet you dropped it. Why?
>
> Either you call ipi_mux_process() from your root interrupt controller,
> or you implement a chained handler. But not this.
>
> Same thing about the clint stuff.

We had chained handler all along but there is problem (which
was pointed to us) in using chained handler because the parent
RISC-V INTC irqchip driver does not have irq_eoi() so the
chained_irq_enter() and chained_irq_exit() will do the interrupt
mask/unmask dance which seems unnecessary.

Is there a better way to avoid the interrupt mask/unmask dance ?

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
