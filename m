Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DB63F6F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLASAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLASAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:00:34 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367FB274B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:00:32 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y17so2373416plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3l6W+4wCOmk5H2E5YROhRyJHHJ2tANXndiSfYTNLKA=;
        b=LPbxOfrTB9fyfIBLwI9GmIvloOZLwzc5XO84esfl6QNOQpq/PxRAl5rm+Ti+T4Q37d
         lCWp0inv5wIvqXwglrX83PfpZ3Q0ervr4AYgeL+m50dwe1upazuVZ3UZNSOlMqAd8B6a
         YGPZ13wOq1yWRIEtEACOhp6H5Pl/6toNQPbGKRqIBqAfyk3cIPBW9tMcAmZH+UTd24+a
         pkgAGzBKLl+cYt2y0/0DdCj8uHx4sY7xGALTKdDIHFKzVWhn61BRBGwIVZ5atvJGHQO6
         rSyUjMgbHcmt/ryyQnEmWAqXWOBallk8rs2b9fyQ/qQ34uOkW32no9fiikFXVx7nX37l
         Sy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3l6W+4wCOmk5H2E5YROhRyJHHJ2tANXndiSfYTNLKA=;
        b=rEXOYhH2uEhlDB4Kn9NI9dtHFoDj84wpqVBp0AUD6FOxv9t1GTRDEvt4ENhZD07hTH
         OyaoSCL3f8sIqiIC8qUD/CjOQhKShKxrU1OvtV6k2RKcyLoSZTE7dgrWZQ9USqpQToeL
         MIfkIVMtCuLRSojUiYThbUXTPY+/QKuyClGbhFL5mnyHf5y2Vv6eumKZ7l7Q6c8cM5z+
         Op0fAUO0TpgvkCZaYj7CTbJJ6Kjv93/GSbXmOgYur5p1KBK1mObeMUUKuHHJeSrwAmdq
         Rvttin1yR/qnkqNsEJwiM15lRaaRrqOw+sUpxBTaH4mDa92ySRmlkULoMDvVMfw4qxP8
         myfA==
X-Gm-Message-State: ANoB5pmVrrHMaPoyPWLL3FfJHu4xC8huuYqho16nzQOI7IqC84IyTFYW
        5qoX19sxtyena6NG4pdOL2dptCnyBy+qAVQzfeqwvw==
X-Google-Smtp-Source: AA0mqf6y+U57HPHVdgjCnjJZA/z4cEc+sR5khbPriXkILN5I/gE93IstCZWbONlRJ/Bn8v5oma0tfOOfXJtAqtxlqDU=
X-Received: by 2002:a17:90a:df0e:b0:20b:22fb:2ef with SMTP id
 gp14-20020a17090adf0e00b0020b22fb02efmr78225062pjb.158.1669917631940; Thu, 01
 Dec 2022 10:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20221201130135.1115380-1-apatel@ventanamicro.com>
 <20221201130135.1115380-4-apatel@ventanamicro.com> <87v8mvqbvq.ffs@tglx>
In-Reply-To: <87v8mvqbvq.ffs@tglx>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 1 Dec 2022 23:30:20 +0530
Message-ID: <CAK9=C2WN57hHUz=3SDruyWPdAobn+QP8uGwugjPAobeFG7dBkw@mail.gmail.com>
Subject: Re: [PATCH v14 3/8] genirq: Add mechanism to multiplex a single HW IPI
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
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

On Thu, Dec 1, 2022 at 10:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Dec 01 2022 at 18:31, Anup Patel wrote:
> > All RISC-V platforms have a single HW IPI provided by the INTC local
> > interrupt controller. The HW method to trigger INTC IPI can be through
> > external irqchip (e.g. RISC-V AIA), through platform specific device
> > (e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).
> >
> > To support multiple IPIs on RISC-V, we add a generic IPI multiplexing
>
> s/we//

Okay, I will update.

>
> > mechanism which help us create multiple virtual IPIs using a single
> > HW IPI. This generic IPI multiplexing is inspired from the Apple AIC
>
> s/from/by/

Okay, I will update.

>
> > irqchip driver and it is shared by various RISC-V irqchip drivers.
>
> Sure, but now we have two copies of this. One in the Apple AIC and one
> here. The obvious thing to do is:
>
>    1) Provide generic infrastructure
>
>    2) Convert AIC to use it

Mark Z already has a converted version of AIC driver.
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-mux

>
>    3) Add RISCV users

The PATCH4 of this series converts the two existing
RISC-V users (SBI IPI and CLINT).

We also have a RISC-V AIA series (posted recently) which
uses the IPI muxing added by this series.

>
> No?
>
> > +static void ipi_mux_mask(struct irq_data *d)
> > +{
> > +     struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> > +
> > +     atomic_andnot(BIT(irqd_to_hwirq(d)), &icpu->enable);
> > +}
> > +
> > +static void ipi_mux_unmask(struct irq_data *d)
> > +{
> > +     u32 ibit = BIT(irqd_to_hwirq(d));
> > +     struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
>
> The AIC code got the variable ordering correct ...
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

Okay, I will update.

>
> > +     atomic_or(ibit, &icpu->enable);
> > +
> > +     /*
> > +      * The atomic_or() above must complete before the atomic_read()
> > +      * below to avoid racing ipi_mux_send_mask().
> > +      */
> > +     smp_mb__after_atomic();
> > +
> > +     /* If a pending IPI was unmasked, raise a parent IPI immediately. */
> > +     if (atomic_read(&icpu->bits) & ibit)
> > +             ipi_mux_send(smp_processor_id());
> > +}
> > +
> > +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> > +{
> > +     u32 ibit = BIT(irqd_to_hwirq(d));
> > +     struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> > +     unsigned long pending;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             icpu = per_cpu_ptr(ipi_mux_pcpu, cpu);
> > +             pending = atomic_fetch_or_release(ibit, &icpu->bits);
> > +
> > +             /*
> > +              * The atomic_fetch_or_release() above must complete
> > +              * before the atomic_read() below to avoid racing with
> > +              * ipi_mux_unmask().
> > +              */
> > +             smp_mb__after_atomic();
> > +
> > +             /*
> > +              * The flag writes must complete before the physical IPI is
> > +              * issued to another CPU. This is implied by the control
> > +              * dependency on the result of atomic_read() below, which is
> > +              * itself already ordered after the vIPI flag write.
> > +              */
> > +             if (!(pending & ibit) && (atomic_read(&icpu->enable) & ibit))
> > +                     ipi_mux_send(cpu);
> > +     }
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
> > +     int i;
> > +
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             irq_set_percpu_devid(virq + i);
> > +             irq_domain_set_info(d, virq + i, i, &ipi_mux_chip, NULL,
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
> > +     struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> > +     irq_hw_number_t hwirq;
> > +     unsigned long ipis;
> > +     unsigned int en;
> > +
> > +     /*
> > +      * Reading enable mask does not need to be ordered as long as
> > +      * this function called from interrupt handler because only
> > +      * the CPU itself can change it's own enable mask.
> > +      */
> > +     en = atomic_read(&icpu->enable);
> > +
> > +     /*
> > +      * Clear the IPIs we are about to handle. This pairs with the
> > +      * atomic_fetch_or_release() in ipi_mux_send_mask().
>
> The comments in the AIC code where you copied from are definitely
> better...
>
> Thanks,
>
>         tglx

Regards,
Anup
