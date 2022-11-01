Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62484614798
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKAKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKAKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:19:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D957D6369
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:19:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p127so15391389oih.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xBm5F24RanvxSwBGYePAcpZ2sd9hyRnqMzxPviRfwC0=;
        b=KdM+0ZpTBllZvcBKpeHz5uI0F5PtnkntWuYOayb1O7ZIkEcItJu2aLzpMSqBMNOwLQ
         F5IzW/htXrKGaDws/I2cDrMN98AN8oi7SYJQytsDrYEVgCvDZmGabfQdBoyPkc6voNxs
         lZJp8Hp6+ry5c/0zEFVVNTxA4p7O+94H+KOGgtC7isBal8/bPBerswYOiQNrN685O3UR
         6AzTXgnoObkNeEOkiYR2LrlcR02ihXCIr+6uJfpfOhWgJm0oJttT/0jSs0CEXv99d5k2
         o5RkPiaxYwv2D3ThCvmQAT4vvDwahnsBwJW8xp9vc0GD9TR2oqFfGw4n+UBwLHNXlWK9
         AtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBm5F24RanvxSwBGYePAcpZ2sd9hyRnqMzxPviRfwC0=;
        b=wle2IFa9B2JWeDxDImTjmKZ4hI7+CoI8F+/8zovbmTHK3YdNLzM0aTr9M/L41Uxk+2
         gmh8BKni9xc028GGX/Mdv8kxpQkwI/U3+qW2KYKL8zOsoFIf9kDO1BDF12lV82VkPVYO
         zEm9goUzkaRSpxz4rFBFZUCtB9a1oVRaHiBkRgrN5z1sIlfQuWF5SV4r7KNF26ctGsEu
         8KIVVlKnjwJ3qJILkpvV4rm9KzUUUuM4WZ4/LZd+D7gMRSntx+O3VOqoN2+Orca0sBDt
         j4Ci8vWxK9LgSNQTXkfrYuz2AFun2I/JquKFP5qVOo4iGkdLhjRKH9b2jxqHKuTigzHy
         MbIQ==
X-Gm-Message-State: ACrzQf0vKVx/7YLSZOCWkijM5kGsw9DXiywEwaxP+Bh7geRTa1fVZne0
        qiMT0mj27mAdiQn41ktKSE1nhTOJ7k+GEYyQNAsF3w==
X-Google-Smtp-Source: AMsMyM4tX1GuDmDr8376Vz9x8x8qPBJmmXPabdqW8TQ0T8Ch7Qu6L+PX9PvrQhOp8lZLnMI/HW58YZNNhdFYGQ55zrE=
X-Received: by 2002:a05:6808:e88:b0:351:2725:ed84 with SMTP id
 k8-20020a0568080e8800b003512725ed84mr17105924oil.17.1667297950909; Tue, 01
 Nov 2022 03:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220903161309.32848-1-apatel@ventanamicro.com>
 <20220903161309.32848-4-apatel@ventanamicro.com> <87k05wk2da.wl-maz@kernel.org>
In-Reply-To: <87k05wk2da.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 1 Nov 2022 15:48:26 +0530
Message-ID: <CAK9=C2V+81u6L78to8CCLZtU30oHCjrCZY8juODXc1hSP9H5BA@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] genirq: Add mechanism to multiplex a single HW IPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Apologies for being slow, I got preempted by other tasks.

On Wed, Sep 21, 2022 at 11:59 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 03 Sep 2022 17:13:05 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > All RISC-V platforms have a single HW IPI provided by the INTC local
> > interrupt controller. The HW method to trigger INTC IPI can be through
> > external irqchip (e.g. RISC-V AIA), through platform specific device
> > (e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).
> >
> > To support multiple IPIs on RISC-V, we add a generic IPI multiplexing
> > mechanism which help us create multiple virtual IPIs using a single
> > HW IPI. This generic IPI multiplexing is shared among various RISC-V
> > irqchip drivers.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  include/linux/irq.h  |  18 ++++
> >  kernel/irq/Kconfig   |   5 +
> >  kernel/irq/Makefile  |   1 +
> >  kernel/irq/ipi-mux.c | 244 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 268 insertions(+)
> >  create mode 100644 kernel/irq/ipi-mux.c
> >
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index c3eb89606c2b..5ab702cb0a5b 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -1266,6 +1266,24 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
> >  int ipi_send_single(unsigned int virq, unsigned int cpu);
> >  int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
> >
> > +/**
> > + * struct ipi_mux_ops - IPI multiplex operations
> > + *
> > + * @ipi_mux_pre_handle:      Optional function called before handling parent IPI
> > + * @ipi_mux_post_handle:Optional function called after handling parent IPI
> > + * @ipi_mux_send:    Trigger parent IPI on target CPUs
> > + */
> > +struct ipi_mux_ops {
> > +     void (*ipi_mux_pre_handle)(unsigned int parent_virq, void *data);
> > +     void (*ipi_mux_post_handle)(unsigned int parent_virq, void *data);
> > +     void (*ipi_mux_send)(unsigned int parent_virq, void *data,
> > +                          const struct cpumask *mask);
> > +};
>
> What is the rational for these pre/post handling functions? We don't
> have them for normal interrupts, why are they required for IPIs?

Yes, normal interrupts don't require these functions but there is
diversity among irqchip drivers for IPI muxing.

For example:  the Apple AIC driver has device specific MMIO access
before and after handling IPIs whereas the RISC-V SBI IPI driver needs
to clear the sip.SSIP bit before handling the IPIs.

>
> > +
> > +void ipi_mux_process(void);
> > +int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
> > +                const struct ipi_mux_ops *ops, void *data);
> > +
> >  #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
> >  /*
> >   * Registers a generic IRQ handling function as the top-level IRQ handler in
> > diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> > index db3d174c53d4..df17dbc54b02 100644
> > --- a/kernel/irq/Kconfig
> > +++ b/kernel/irq/Kconfig
> > @@ -86,6 +86,11 @@ config GENERIC_IRQ_IPI
> >       depends on SMP
> >       select IRQ_DOMAIN_HIERARCHY
> >
> > +# Generic IRQ IPI Mux support
> > +config GENERIC_IRQ_IPI_MUX
> > +     bool
> > +     depends on SMP
> > +
> >  # Generic MSI interrupt support
> >  config GENERIC_MSI_IRQ
> >       bool
> > diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> > index b4f53717d143..f19d3080bf11 100644
> > --- a/kernel/irq/Makefile
> > +++ b/kernel/irq/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
> >  obj-$(CONFIG_PM_SLEEP) += pm.o
> >  obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
> >  obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
> > +obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) += ipi-mux.o
> >  obj-$(CONFIG_SMP) += affinity.o
> >  obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
> >  obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
> > diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
> > new file mode 100644
> > index 000000000000..8939fa2be73c
> > --- /dev/null
> > +++ b/kernel/irq/ipi-mux.c
> > @@ -0,0 +1,244 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Multiplex several virtual IPIs over a single HW IPI.
> > + *
> > + * Copyright (c) 2022 Ventana Micro Systems Inc.
>
> Basic courtesy would be to at least mention where this was lifted
> from, as well as the original copyrights. Also, the original code
> states "GPL-2.0-or-later". Since this is a derivative work, the same
> licence should apply, shouldn't it?

Sure, I will update it.

>
> > + */
> > +
> > +#define pr_fmt(fmt) "ipi-mux: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/init.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/smp.h>
> > +
> > +static void *ipi_mux_data;
> > +static unsigned int ipi_mux_nr;
> > +static unsigned int ipi_mux_parent_virq;
> > +static struct irq_domain *ipi_mux_domain;
> > +static const struct ipi_mux_ops *ipi_mux_ops;
> > +static DEFINE_PER_CPU(atomic_t, ipi_mux_enable);
> > +static DEFINE_PER_CPU(atomic_t, ipi_mux_bits);
>
> How about making these fields part of a structure, and only allocate
> them on creation of an IPI irqdomain? Most platforms do not require
> this at all.

Okay, I will update like you suggested.

>
> > +
> > +static void ipi_mux_mask(struct irq_data *d)
> > +{
> > +     atomic_andnot(BIT(irqd_to_hwirq(d)), this_cpu_ptr(&ipi_mux_enable));
> > +}
> > +
> > +static void ipi_mux_unmask(struct irq_data *d)
> > +{
> > +     u32 ipi_bit = BIT(irqd_to_hwirq(d));
> > +
> > +     atomic_or(ipi_bit, this_cpu_ptr(&ipi_mux_enable));
> > +
> > +     /*
> > +      * The atomic_or() above must complete before the atomic_read()
> > +      * below to avoid racing ipi_mux_send_mask().
> > +      */
> > +     smp_mb__after_atomic();
> > +
> > +     /* If a pending IPI was unmasked, raise a parent IPI immediately. */
> > +     if (atomic_read(this_cpu_ptr(&ipi_mux_bits)) & ipi_bit)
> > +             ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, ipi_mux_data,
> > +                                       cpumask_of(smp_processor_id()));
> > +}
> > +
> > +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> > +{
> > +     u32 ipi_bit = BIT(irqd_to_hwirq(d));
> > +     struct cpumask pmask = { 0 };
>
> Urgh, no (see the comment in cpumask.h). struct cpumask can be really
> huge (it uses NR_CPUS), and we only want to depend on nr_cpus. Use a
> per-CPU temp if you must, but don't allocate something like this on
> the stack.

Okay, I will create per-CPU temp like you suggested.

>
> > +     unsigned long pending;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             pending = atomic_fetch_or_release(ipi_bit,
> > +                                     per_cpu_ptr(&ipi_mux_bits, cpu));
> > +
> > +             /*
> > +              * The atomic_fetch_or_release() above must complete before
> > +              * the atomic_read() below to avoid racing ipi_mux_unmask().
> > +              */
> > +             smp_mb__after_atomic();
> > +
> > +             if (!(pending & ipi_bit) &&
> > +                 (atomic_read(per_cpu_ptr(&ipi_mux_enable, cpu)) & ipi_bit))
> > +                     cpumask_set_cpu(cpu, &pmask);
> > +     }
> > +
> > +     /* Trigger the parent IPI */
> > +     ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, ipi_mux_data, &pmask);
> > +}
> > +
> > +static const struct irq_chip ipi_mux_chip = {
> > +     .name           = "IPI Mux",
> > +     .irq_mask       = ipi_mux_mask,
> > +     .irq_unmask     = ipi_mux_unmask,
> > +     .ipi_send_mask  = ipi_mux_send_mask,
> > +};
> > +
> > +static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
> > +                             unsigned int nr_irqs, void *arg)
> > +{
> > +     struct irq_fwspec *fwspec = arg;
> > +     irq_hw_number_t hwirq;
> > +     unsigned int type;
> > +     int i, ret;
> > +
> > +     ret = irq_domain_translate_onecell(d, fwspec, &hwirq, &type);
>
> Where is the format of this fwspec documented?

We don't need this fwspec. I will remove it in next patch revision.

>
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             irq_set_percpu_devid(virq + i);
> > +             irq_domain_set_info(d, virq + i, hwirq + i,
> > +                                 &ipi_mux_chip, d->host_data,
> > +                                 handle_percpu_devid_irq, NULL, NULL);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops ipi_mux_domain_ops = {
> > +     .alloc          = ipi_mux_domain_alloc,
> > +     .free           = irq_domain_free_irqs_top,
> > +};
> > +
> > +/**
> > + * ipi_mux_process - Process multiplexed virtual IPIs
> > + */
> > +void ipi_mux_process(void)
> > +{
> > +     irq_hw_number_t hwirq;
> > +     unsigned long ipis;
> > +     int en, err;
> > +
> > +     if (ipi_mux_ops->ipi_mux_pre_handle)
>
> Given that this shouldn't change in the lifetime of the system, this
> needs to be turned into a static key in order to avoid the overhead of
> accessing this on each and every IPI.

Sure, I will use static keys here.

>
> > +             ipi_mux_ops->ipi_mux_pre_handle(ipi_mux_parent_virq,
> > +                                             ipi_mux_data);
> > +
> > +     /*
> > +      * Reading enable mask does not need to be ordered as long as
> > +      * this function called from interrupt handler because only
> > +      * the CPU itself can change it's own enable mask.
> > +      */
> > +     en = atomic_read(this_cpu_ptr(&ipi_mux_enable));
> > +
> > +     /*
> > +      * Clear the IPIs we are about to handle. This pairs with the
> > +      * atomic_fetch_or_release() in ipi_mux_send_mask().
> > +      */
> > +     ipis = atomic_fetch_andnot(en, this_cpu_ptr(&ipi_mux_bits)) & en;
> > +
> > +     for_each_set_bit(hwirq, &ipis, ipi_mux_nr) {
> > +             err = generic_handle_domain_irq(ipi_mux_domain,
> > +                                             hwirq);
> > +             if (unlikely(err))
> > +                     pr_warn_ratelimited(
> > +                             "can't find mapping for hwirq %lu\n",
> > +                             hwirq);
>
> How can this happen?

This is a paranoid check on my side. I will remove it.

>
> > +     }
> > +
> > +     if (ipi_mux_ops->ipi_mux_post_handle)
>
> Same thing as above.

Okay, I will update.

>
> > +             ipi_mux_ops->ipi_mux_post_handle(ipi_mux_parent_virq,
> > +                                              ipi_mux_data);
> > +}
> > +
> > +static void ipi_mux_handler(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +     chained_irq_enter(chip, desc);
> > +     ipi_mux_process();
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int ipi_mux_dying_cpu(unsigned int cpu)
> > +{
> > +     disable_percpu_irq(ipi_mux_parent_virq);
> > +     return 0;
> > +}
> > +
> > +static int ipi_mux_starting_cpu(unsigned int cpu)
> > +{
> > +     enable_percpu_irq(ipi_mux_parent_virq,
> > +                       irq_get_trigger_type(ipi_mux_parent_virq));
> > +     return 0;
> > +}
> > +
> > +/**
> > + * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
> > + * parent IPI.
> > + * @parent_virq:     virq of the parent per-CPU IRQ
> > + * @nr_ipi:          number of virtual IPIs to create. This should
> > + *                   be <= BITS_PER_TYPE(int)
>
> In general, please use 'long' rather than 'int', like for most other
> things in the kernel.

This is BITS_PER_TYPE(int) because we are using 32bit atomic
operations.

>
> > + * @ops:             multiplexing operations for the parent IPI
> > + * @data:            opaque data used by the multiplexing operations
> > + *
> > + * If the parent IPI > 0 then ipi_mux_process() will be automatically
> > + * called via chained handler.
> > + *
> > + * If the parent IPI <= 0 then it is responsibility of irqchip drivers
> > + * to explicitly call ipi_mux_process() for processing muxed IPIs.
> > + *
> > + * Returns first virq of the newly created virtual IPIs upon success
> > + * or <=0 upon failure
> > + */
> > +int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
> > +                const struct ipi_mux_ops *ops, void *data)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +     struct irq_domain *domain;
> > +     struct irq_fwspec ipi;
> > +     int virq;
> > +
> > +     if (ipi_mux_domain || BITS_PER_TYPE(int) < nr_ipi ||
> > +         !ops || !ops->ipi_mux_send)
> > +             return -EINVAL;
> > +
> > +     if (parent_virq &&
> > +         !irqd_is_per_cpu(irq_desc_get_irq_data(irq_to_desc(parent_virq))))
> > +             return -EINVAL;
> > +
> > +     fwnode = irq_domain_alloc_named_fwnode("IPI-Mux");
> > +     if (!fwnode) {
> > +             pr_err("unable to create IPI Mux fwnode\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     domain = irq_domain_create_simple(fwnode, nr_ipi, 0,
> > +                                       &ipi_mux_domain_ops, NULL);
> > +     if (!domain) {
> > +             pr_err("unable to add IPI Mux domain\n");
> > +             irq_domain_free_fwnode(fwnode);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ipi.fwnode = domain->fwnode;
> > +     ipi.param_count = 1;
> > +     ipi.param[0] = 0;
>
> This really deserves some documentation if this is to be used at scale
> (and not be a riscv-special).

This fwspec is not needed. I will be removing it in the next patch revision.

>
> > +     virq = __irq_domain_alloc_irqs(domain, -1, nr_ipi,
> > +                                    NUMA_NO_NODE, &ipi, false, NULL);
> > +     if (virq <= 0) {
> > +             pr_err("unable to alloc IRQs from IPI Mux domain\n");
> > +             irq_domain_remove(domain);
> > +             irq_domain_free_fwnode(fwnode);
> > +             return virq;
> > +     }
> > +
> > +     ipi_mux_domain = domain;
> > +     ipi_mux_data = data;
> > +     ipi_mux_nr = nr_ipi;
> > +     ipi_mux_parent_virq = parent_virq;
> > +     ipi_mux_ops = ops;
> > +
> > +     if (parent_virq > 0) {
> > +             irq_set_chained_handler(parent_virq, ipi_mux_handler);
> > +             cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                               "irqchip/ipi-mux:starting",
> > +                               ipi_mux_starting_cpu, ipi_mux_dying_cpu);
> > +     }
>
> This whole CPUHP thing feels like something that should stay outside
> of the generic code. I'm pretty sure some architectures would have
> specific requirements and wouldn't be able to just use any odd dynamic
> value...

I agree. I will update irqchip drivers to do the parent_virq enable/disable
and remove it from here.

>
> > +
> > +     return virq;
> > +}
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Anup
