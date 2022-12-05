Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6328B642384
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiLEHVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiLEHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:20:55 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D3F020
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:20:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 08BC7425EA;
        Mon,  5 Dec 2022 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1670224852; bh=X9riitV1+2ZWDLkgkw28xLwImCPxVEWhVJCBjFMEpvk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Vx0ka+UU3MjTUrLbSasxkFMyD42J+MM7ehGUQlLbZAEjdaopdK5ugKUKXye1l5x3w
         IfK7pW2pIWgv4TjB49WXFgA5UzsW52s29QJiybducg3gM6F6131Od6oDhRMU3daI9h
         Z5l3NQMXsmvkTXbH56x3IEidfY5DXMfYnRTIcJGx4CkT5F77VJdmwshmCtBS3rF6na
         gSYwGDnYWl76QXcn63Mo8sJNhiM7Bj/gSojoEbAcbftCLBtuD3qT1QsFo3t01ufqkO
         i6gOcLja0Yzcc7muxzsLmSDeqp+sebI5rXv1jabSN6HnBPLV4JwrKsIovjudxWDPTC
         azGj/DB35bLjw==
Message-ID: <87dc326b-a12c-7377-ff37-6008795598e5@marcan.st>
Date:   Mon, 5 Dec 2022 16:20:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20221203064629.1601299-1-apatel@ventanamicro.com>
 <20221203064629.1601299-4-apatel@ventanamicro.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v15 3/9] genirq: Add mechanism to multiplex a single HW
 IPI
In-Reply-To: <20221203064629.1601299-4-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2022 15.46, Anup Patel wrote:
> All RISC-V platforms have a single HW IPI provided by the INTC local
> interrupt controller. The HW method to trigger INTC IPI can be through
> external irqchip (e.g. RISC-V AIA), through platform specific device
> (e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).
> 
> To support multiple IPIs on RISC-V, add a generic IPI multiplexing
> mechanism which help us create multiple virtual IPIs using a single
> HW IPI. This generic IPI multiplexing is inspired by the Apple AIC
> irqchip driver and it is shared by various RISC-V irqchip drivers.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  include/linux/irq.h  |   3 +
>  kernel/irq/Kconfig   |   5 ++
>  kernel/irq/Makefile  |   1 +
>  kernel/irq/ipi-mux.c | 207 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 216 insertions(+)
>  create mode 100644 kernel/irq/ipi-mux.c
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c3eb89606c2b..b1b28affb32a 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -1266,6 +1266,9 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
>  int ipi_send_single(unsigned int virq, unsigned int cpu);
>  int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
>  
> +void ipi_mux_process(void);
> +int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu));
> +
>  #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
>  /*
>   * Registers a generic IRQ handling function as the top-level IRQ handler in
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index db3d174c53d4..df17dbc54b02 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -86,6 +86,11 @@ config GENERIC_IRQ_IPI
>  	depends on SMP
>  	select IRQ_DOMAIN_HIERARCHY
>  
> +# Generic IRQ IPI Mux support
> +config GENERIC_IRQ_IPI_MUX
> +	bool
> +	depends on SMP
> +
>  # Generic MSI interrupt support
>  config GENERIC_MSI_IRQ
>  	bool
> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> index b4f53717d143..f19d3080bf11 100644
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
>  obj-$(CONFIG_PM_SLEEP) += pm.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
>  obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
> +obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) += ipi-mux.o
>  obj-$(CONFIG_SMP) += affinity.o
>  obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
>  obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
> diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
> new file mode 100644
> index 000000000000..3a403c3a785d
> --- /dev/null
> +++ b/kernel/irq/ipi-mux.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Multiplex several virtual IPIs over a single HW IPI.
> + *
> + * Copyright The Asahi Linux Contributors
> + * Copyright (c) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "ipi-mux: " fmt
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/jump_label.h>
> +#include <linux/percpu.h>
> +#include <linux/smp.h>
> +
> +struct ipi_mux_cpu {
> +	atomic_t			enable;
> +	atomic_t			bits;
> +};
> +
> +static struct ipi_mux_cpu __percpu *ipi_mux_pcpu;
> +static struct irq_domain *ipi_mux_domain;
> +static void (*ipi_mux_send)(unsigned int cpu);
> +
> +static void ipi_mux_mask(struct irq_data *d)
> +{
> +	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> +
> +	atomic_andnot(BIT(irqd_to_hwirq(d)), &icpu->enable);
> +}
> +
> +static void ipi_mux_unmask(struct irq_data *d)
> +{
> +	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> +	u32 ibit = BIT(irqd_to_hwirq(d));
> +
> +	atomic_or(ibit, &icpu->enable);
> +
> +	/*
> +	 * The atomic_or() above must complete before the atomic_read()
> +	 * below to avoid racing ipi_mux_send_mask().
> +	 */
> +	smp_mb__after_atomic();
> +
> +	/* If a pending IPI was unmasked, raise a parent IPI immediately. */
> +	if (atomic_read(&icpu->bits) & ibit)
> +		ipi_mux_send(smp_processor_id());
> +}
> +
> +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> +{
> +	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> +	u32 ibit = BIT(irqd_to_hwirq(d));
> +	unsigned long pending;
> +	int cpu;
> +
> +	for_each_cpu(cpu, mask) {
> +		icpu = per_cpu_ptr(ipi_mux_pcpu, cpu);
> +
> +		/*
> +		 * This sequence is the mirror of the one in ipi_mux_unmask();
> +		 * see the comment there. Additionally, release semantics
> +		 * ensure that the vIPI flag set is ordered after any shared
> +		 * memory accesses that precede it. This therefore also pairs
> +		 * with the atomic_fetch_andnot in ipi_mux_process().
> +		 */
> +		pending = atomic_fetch_or_release(ibit, &icpu->bits);
> +
> +		/*
> +		 * The atomic_fetch_or_release() above must complete
> +		 * before the atomic_read() below to avoid racing with
> +		 * ipi_mux_unmask().
> +		 */
> +		smp_mb__after_atomic();
> +
> +		/*
> +		 * The flag writes must complete before the physical IPI is
> +		 * issued to another CPU. This is implied by the control
> +		 * dependency on the result of atomic_read() below, which is
> +		 * itself already ordered after the vIPI flag write.
> +		 */
> +		if (!(pending & ibit) && (atomic_read(&icpu->enable) & ibit))
> +			ipi_mux_send(cpu);
> +	}
> +}
> +
> +static const struct irq_chip ipi_mux_chip = {
> +	.name		= "IPI Mux",
> +	.irq_mask	= ipi_mux_mask,
> +	.irq_unmask	= ipi_mux_unmask,
> +	.ipi_send_mask	= ipi_mux_send_mask,
> +};
> +
> +static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
> +				unsigned int nr_irqs, void *arg)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_set_percpu_devid(virq + i);
> +		irq_domain_set_info(d, virq + i, i, &ipi_mux_chip, NULL,
> +				    handle_percpu_devid_irq, NULL, NULL);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ipi_mux_domain_ops = {
> +	.alloc		= ipi_mux_domain_alloc,
> +	.free		= irq_domain_free_irqs_top,
> +};
> +
> +/**
> + * ipi_mux_process - Process multiplexed virtual IPIs
> + */
> +void ipi_mux_process(void)
> +{
> +	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> +	irq_hw_number_t hwirq;
> +	unsigned long ipis;
> +	unsigned int en;
> +
> +	/*
> +	 * Reading enable mask does not need to be ordered as long as
> +	 * this function is called from interrupt handler because only
> +	 * the CPU itself can change it's own enable mask.
> +	 */
> +	en = atomic_read(&icpu->enable);
> +
> +	/*
> +	 * Clear the IPIs we are about to handle. This pairs with the
> +	 * atomic_fetch_or_release() in ipi_mux_send_mask().
> +	 */
> +	ipis = atomic_fetch_andnot(en, &icpu->bits) & en;
> +
> +	for_each_set_bit(hwirq, &ipis, BITS_PER_TYPE(int))
> +		generic_handle_domain_irq(ipi_mux_domain, hwirq);
> +}
> +
> +/**
> + * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
> + * parent IPI.
> + * @nr_ipi:		number of virtual IPIs to create. This should
> + *			be <= BITS_PER_TYPE(int)
> + * @mux_send:		callback to trigger parent IPI for a particular CPU
> + *
> + * Returns first virq of the newly created virtual IPIs upon success
> + * or <=0 upon failure
> + */
> +int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu))
> +{
> +	struct fwnode_handle *fwnode;
> +	struct irq_domain *domain;
> +	int rc;
> +
> +	if (ipi_mux_domain)
> +		return -EEXIST;
> +
> +	if (BITS_PER_TYPE(int) < nr_ipi || !mux_send)
> +		return -EINVAL;
> +
> +	ipi_mux_pcpu = alloc_percpu(typeof(*ipi_mux_pcpu));
> +	if (!ipi_mux_pcpu)
> +		return -ENOMEM;
> +
> +	fwnode = irq_domain_alloc_named_fwnode("IPI-Mux");
> +	if (!fwnode) {
> +		pr_err("unable to create IPI Mux fwnode\n");
> +		rc = -ENOMEM;
> +		goto fail_free_cpu;
> +	}
> +
> +	domain = irq_domain_create_linear(fwnode, nr_ipi,
> +					  &ipi_mux_domain_ops, NULL);
> +	if (!domain) {
> +		pr_err("unable to add IPI Mux domain\n");
> +		rc = -ENOMEM;
> +		goto fail_free_fwnode;
> +	}
> +
> +	domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
> +	irq_domain_update_bus_token(domain, DOMAIN_BUS_IPI);
> +
> +	rc = __irq_domain_alloc_irqs(domain, -1, nr_ipi,
> +				     NUMA_NO_NODE, NULL, false, NULL);
> +	if (rc <= 0) {
> +		pr_err("unable to alloc IRQs from IPI Mux domain\n");
> +		goto fail_free_domain;
> +	}
> +
> +	ipi_mux_domain = domain;
> +	ipi_mux_send = mux_send;
> +
> +	return rc;
> +
> +fail_free_domain:
> +	irq_domain_remove(domain);
> +fail_free_fwnode:
> +	irq_domain_free_fwnode(fwnode);
> +fail_free_cpu:
> +	free_percpu(ipi_mux_pcpu);
> +	return rc;
> +}

Reviewed-by: Hector Martin <marcan@marcan.st>
Tested-by: Hector Martin <marcan@marcan.st>

I was actually surprised this wasn't already a solved problem when I
first had to write this code. Glad RISC-V found it useful :)

Note: we agonized over the memory ordering here quite a bit when this
was first written, and all that was viewed through the lens of the ARM64
memory model. You might want to do a similarly thorough review from a
RISC-V perspective to make sure it isn't relying on any ARMisms (or that
RISC-V isn't failing to meet the underlying Linux model - we already ran
into a core kernel bitop issue once for ARM too!).

- Hector
