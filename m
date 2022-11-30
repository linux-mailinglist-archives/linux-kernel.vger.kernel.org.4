Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380EE63DB92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiK3RIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiK3RIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:08:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A71A81396
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:03:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id td2so28767265ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYMMG0Xx78ci4rSGafg1aeshdWrMZWJAaUMKgBBaQfE=;
        b=DbnaczQgP2VrIkHihS0MpCnlYRHv+RYEnBbS+N7MSHdXWjZnojAbmCZPLQUg5ZEsI2
         ojl6YTACqG3+fMtXxKsIH8ucWc4prE0JxoqQh+VNjo14vQy/O9zUufyp9SJErPb6buBT
         m+Xa21SnYvaFbleMngbhCSMI5Osj8qdHOUcmIuWthBA/tVMJ+dcq7RThmp1PUbaz9h/j
         VP/se8gAUYFY1Fd7ApWJ6vj1TkMLajsDtKslTNUW8syVVNGg/nbrYtFxEYqa5tD841Mr
         qBRIUnTUrma7j54foglKvBQOjh403kzbKPRJdqz4xPiccM3wV/PhCVm3n9Nz9W1FXLbP
         gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYMMG0Xx78ci4rSGafg1aeshdWrMZWJAaUMKgBBaQfE=;
        b=ZHgTi/Lhfjndo/tyy55bhSYk1qd6XvOY+zHe4/tN9QWaW4w90SZsOyB/fdUIKveBJE
         fXmxbtrkJhQRbjqAP/+KMfjzTXkPrpiBVlmIom7BOk/jL5o7/hA6HxPXM5j6dbArhV9T
         yOgLPSEDS0/gZtw/d8q/kcAX6sJiDGPNEF/4/nvhgoCttO7WgyEc6kouFovcy3kuLtNJ
         nSoHb7c3T+rFIdgGa486gxiTLUaL0lW1pFWpYaFqPDwmWQpGgpr2pi7JsAnWAmHOK+Je
         YTV2ogD/UxcQLiAI/99Wy19VPEgBtYKamE8OSxXGi8yjPaXwoKBNdxF7EWG2oXKu+u15
         bkgw==
X-Gm-Message-State: ANoB5plyausVHjcxrLxsxioT2z97RgMzJz5QF0h0gZ6yLOQM6Ll6W226
        FEgNvXJfNnVMha5GsmxmcZobXFrI7RemMBDMurtJeQ==
X-Google-Smtp-Source: AA0mqf6EyA7YtrTBcFZJK174OkTrsKWiLmYM0e6dIjaTX3tgPfsjUx3jdGQ2rw5PNYzp8U3ztlRdTrtIgLPscTc5gbU=
X-Received: by 2002:a17:906:ae99:b0:7c0:82d8:243a with SMTP id
 md25-20020a170906ae9900b007c082d8243amr8545786ejb.230.1669827796637; Wed, 30
 Nov 2022 09:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20221129142449.886518-1-apatel@ventanamicro.com>
 <20221129142449.886518-4-apatel@ventanamicro.com> <86cz94mrc4.wl-maz@kernel.org>
In-Reply-To: <86cz94mrc4.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 30 Nov 2022 22:33:05 +0530
Message-ID: <CAAhSdy150BemP2YR2gf6yNMiJiD+os8VHkvyx7Nnqrqaz1+xjA@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] genirq: Add mechanism to multiplex a single HW IPI
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

On Wed, Nov 30, 2022 at 8:17 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 29 Nov 2022 14:24:45 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > All RISC-V platforms have a single HW IPI provided by the INTC local
> > interrupt controller. The HW method to trigger INTC IPI can be through
> > external irqchip (e.g. RISC-V AIA), through platform specific device
> > (e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).
> >
> > To support multiple IPIs on RISC-V, we add a generic IPI multiplexing
> > mechanism which help us create multiple virtual IPIs using a single
> > HW IPI. This generic IPI multiplexing is inspired from the Apple AIC
> > irqchip driver and it is shared by various RISC-V irqchip drivers.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  include/linux/irq.h  |   3 +
> >  kernel/irq/Kconfig   |   5 ++
> >  kernel/irq/Makefile  |   1 +
> >  kernel/irq/ipi-mux.c | 193 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 202 insertions(+)
> >  create mode 100644 kernel/irq/ipi-mux.c
>
> [...]
>
> This is finally starting to look acceptable. My only changes are:
>
> diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
> index 626c564233e9..1a6ba19b736c 100644
> --- a/kernel/irq/ipi-mux.c
> +++ b/kernel/irq/ipi-mux.c
> @@ -69,6 +69,12 @@ static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
>                  */
>                 smp_mb__after_atomic();
>
> +               /*
> +                * The flag writes must complete before the physical IPI is
> +                * issued to another CPU. This is implied by the control
> +                * dependency on the result of atomic_read() below, which is
> +                * itself already ordered after the vIPI flag write.
> +                */
>                 if (!(pending & ibit) && (atomic_read(&icpu->enable) & ibit))
>                         ipi_mux_send(cpu);
>         }
> @@ -160,7 +166,7 @@ int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu))
>                 goto fail_free_cpu;
>         }
>
> -       domain = irq_domain_create_simple(fwnode, nr_ipi, 0,
> +       domain = irq_domain_create_linear(fwnode, nr_ipi,
>                                           &ipi_mux_domain_ops, NULL);
>         if (!domain) {
>                 pr_err("unable to add IPI Mux domain\n");
>
> The first hunk preserve an important piece of information about how
> delicate the ordering is, while the second only allocates the irqdesc
> structures as needed, not upfront.
>
> I'll shortly go over the rest of the irqchip code and can apply the
> above myself if there is nothing more to fix.
>
> I've also converted the AIC driver over to this[1], and nothing broke
> so far...
>
>         M.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-mux

Thanks Marc, I will include your changes in the next patch revision.

>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
