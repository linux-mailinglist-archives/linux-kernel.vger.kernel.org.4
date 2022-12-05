Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334464237A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiLEHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiLEHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:15:05 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6412741
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:15:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 96D0C425EA;
        Mon,  5 Dec 2022 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1670224501; bh=hVJZFwKCPTntcp35N/eazjq7Urb5u5fINx8mvznpmTU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Eeb/UNa5pYjDLE+moAUp4d24r2sjPTT0HZp2+I3O3pKkiRqqTYmPYTA0Vox2qWpbP
         /GzxOwq0TrPbBj46swXE9AATZ44ElOX4ad7PS0YKRd+ethiiBXEBDHXybmDYYbcYNZ
         C+zAi4gjwSL/zfokZzi0XgGpeRturFoEhGTO1lwY8BItxJZJHY11cne99LbDk9X1iN
         8/K0pUkt+gUEiTbQSRFYtL9MfOAoDKxbo+E0Rn/f6E+NLzs9j7dbhJPBH1MJLRnbz0
         a/CZ6ihB5uNkieuT7aBcKcIOcHdZ8oEYBsgsbQ6HefXY79fEEhHK24EfaGbLivhki6
         81ReHw8P8WWQA==
Message-ID: <18abbb1b-ec5e-11c6-ab16-b523f329064e@marcan.st>
Date:   Mon, 5 Dec 2022 16:14:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v15 9/9] irqchip/apple-aic: Move over to core ipi-mux
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
 <20221203064629.1601299-10-apatel@ventanamicro.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20221203064629.1601299-10-apatel@ventanamicro.com>
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
> From: Marc Zyngier <maz@kernel.org>
> 
> Now that the complexity of the AIC IPI mux has been copied into
> the core code for the benefit of the riscv architecture,
> shrink the AIC driver by the same amount by using that infrastructure.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/Kconfig         |   1 +
>  drivers/irqchip/irq-apple-aic.c | 161 ++------------------------------
>  2 files changed, 9 insertions(+), 153 deletions(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 131379aa8424..0fd452b49ed9 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -675,6 +675,7 @@ config APPLE_AIC
>  	bool "Apple Interrupt Controller (AIC)"
>  	depends on ARM64
>  	depends on ARCH_APPLE || COMPILE_TEST
> +	select GENERIC_IRQ_IPI_MUX
>  	help
>  	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
>  	  such as the M1.
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 1c2813ad8bbe..1fa81fcff788 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -292,7 +292,6 @@ struct aic_irq_chip {
>  	void __iomem *base;
>  	void __iomem *event;
>  	struct irq_domain *hw_domain;
> -	struct irq_domain *ipi_domain;
>  	struct {
>  		cpumask_t aff;
>  	} *fiq_aff[AIC_NR_FIQ];
> @@ -307,9 +306,6 @@ struct aic_irq_chip {
>  
>  static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
>  
> -static DEFINE_PER_CPU(atomic_t, aic_vipi_flag);
> -static DEFINE_PER_CPU(atomic_t, aic_vipi_enable);
> -
>  static struct aic_irq_chip *aic_irqc;
>  
>  static void aic_handle_ipi(struct pt_regs *regs);
> @@ -751,98 +747,8 @@ static void aic_ipi_send_fast(int cpu)
>  	isb();
>  }
>  
> -static void aic_ipi_mask(struct irq_data *d)
> -{
> -	u32 irq_bit = BIT(irqd_to_hwirq(d));
> -
> -	/* No specific ordering requirements needed here. */
> -	atomic_andnot(irq_bit, this_cpu_ptr(&aic_vipi_enable));
> -}
> -
> -static void aic_ipi_unmask(struct irq_data *d)
> -{
> -	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> -	u32 irq_bit = BIT(irqd_to_hwirq(d));
> -
> -	atomic_or(irq_bit, this_cpu_ptr(&aic_vipi_enable));
> -
> -	/*
> -	 * The atomic_or() above must complete before the atomic_read()
> -	 * below to avoid racing aic_ipi_send_mask().
> -	 */
> -	smp_mb__after_atomic();
> -
> -	/*
> -	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
> -	 * No barriers needed here since this is a self-IPI.
> -	 */
> -	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
> -		if (static_branch_likely(&use_fast_ipi))
> -			aic_ipi_send_fast(smp_processor_id());
> -		else
> -			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
> -	}
> -}
> -
> -static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
> -{
> -	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> -	u32 irq_bit = BIT(irqd_to_hwirq(d));
> -	u32 send = 0;
> -	int cpu;
> -	unsigned long pending;
> -
> -	for_each_cpu(cpu, mask) {
> -		/*
> -		 * This sequence is the mirror of the one in aic_ipi_unmask();
> -		 * see the comment there. Additionally, release semantics
> -		 * ensure that the vIPI flag set is ordered after any shared
> -		 * memory accesses that precede it. This therefore also pairs
> -		 * with the atomic_fetch_andnot in aic_handle_ipi().
> -		 */
> -		pending = atomic_fetch_or_release(irq_bit, per_cpu_ptr(&aic_vipi_flag, cpu));
> -
> -		/*
> -		 * The atomic_fetch_or_release() above must complete before the
> -		 * atomic_read() below to avoid racing aic_ipi_unmask().
> -		 */
> -		smp_mb__after_atomic();
> -
> -		if (!(pending & irq_bit) &&
> -		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
> -			if (static_branch_likely(&use_fast_ipi))
> -				aic_ipi_send_fast(cpu);
> -			else
> -				send |= AIC_IPI_SEND_CPU(cpu);
> -		}
> -	}
> -
> -	/*
> -	 * The flag writes must complete before the physical IPI is issued
> -	 * to another CPU. This is implied by the control dependency on
> -	 * the result of atomic_read_acquire() above, which is itself
> -	 * already ordered after the vIPI flag write.
> -	 */
> -	if (send)
> -		aic_ic_write(ic, AIC_IPI_SEND, send);
> -}
> -
> -static struct irq_chip ipi_chip = {
> -	.name = "AIC-IPI",
> -	.irq_mask = aic_ipi_mask,
> -	.irq_unmask = aic_ipi_unmask,
> -	.ipi_send_mask = aic_ipi_send_mask,
> -};
> -
> -/*
> - * IPI IRQ domain
> - */
> -
>  static void aic_handle_ipi(struct pt_regs *regs)
>  {
> -	int i;
> -	unsigned long enabled, firing;
> -
>  	/*
>  	 * Ack the IPI. We need to order this after the AIC event read, but
>  	 * that is enforced by normal MMIO ordering guarantees.
> @@ -857,27 +763,7 @@ static void aic_handle_ipi(struct pt_regs *regs)
>  		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
>  	}
>  
> -	/*
> -	 * The mask read does not need to be ordered. Only we can change
> -	 * our own mask anyway, so no races are possible here, as long as
> -	 * we are properly in the interrupt handler (which is covered by
> -	 * the barrier that is part of the top-level AIC handler's readl()).
> -	 */
> -	enabled = atomic_read(this_cpu_ptr(&aic_vipi_enable));
> -
> -	/*
> -	 * Clear the IPIs we are about to handle. This pairs with the
> -	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
> -	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
> -	 * before IPI handling code (to avoid races handling vIPIs before they
> -	 * are signaled). The former is taken care of by the release semantics
> -	 * of the write portion, while the latter is taken care of by the
> -	 * acquire semantics of the read portion.
> -	 */
> -	firing = atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & enabled;
> -
> -	for_each_set_bit(i, &firing, AIC_NR_SWIPI)
> -		generic_handle_domain_irq(aic_irqc->ipi_domain, i);
> +	ipi_mux_process();
>  
>  	/*
>  	 * No ordering needed here; at worst this just changes the timing of
> @@ -887,55 +773,24 @@ static void aic_handle_ipi(struct pt_regs *regs)
>  		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
>  }
>  
> -static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
> -			 unsigned int nr_irqs, void *args)
> +static void aic_ipi_send_single(unsigned int cpu)
>  {
> -	int i;
> -
> -	for (i = 0; i < nr_irqs; i++) {
> -		irq_set_percpu_devid(virq + i);
> -		irq_domain_set_info(d, virq + i, i, &ipi_chip, d->host_data,
> -				    handle_percpu_devid_irq, NULL, NULL);
> -	}
> -
> -	return 0;
> -}
> -
> -static void aic_ipi_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
> -{
> -	/* Not freeing IPIs */
> +	if (static_branch_likely(&use_fast_ipi))
> +		aic_ipi_send_fast(cpu);
> +	else
> +		aic_ic_write(aic_irqc, AIC_IPI_SEND, AIC_IPI_SEND_CPU(cpu));
>  }
>  
> -static const struct irq_domain_ops aic_ipi_domain_ops = {
> -	.alloc = aic_ipi_alloc,
> -	.free = aic_ipi_free,
> -};
> -
>  static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
>  {
> -	struct irq_domain *ipi_domain;
>  	int base_ipi;
>  
> -	ipi_domain = irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWIPI,
> -					      &aic_ipi_domain_ops, irqc);
> -	if (WARN_ON(!ipi_domain))
> -		return -ENODEV;
> -
> -	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
> -	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
> -
> -	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, AIC_NR_SWIPI,
> -					   NUMA_NO_NODE, NULL, false, NULL);
> -
> -	if (WARN_ON(!base_ipi)) {
> -		irq_domain_remove(ipi_domain);
> +	base_ipi = ipi_mux_create(AIC_NR_SWIPI, aic_ipi_send_single);
> +	if (WARN_ON(base_ipi <= 0))
>  		return -ENODEV;
> -	}
>  
>  	set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
>  
> -	irqc->ipi_domain = ipi_domain;
> -
>  	return 0;
>  }
>  

Reviewed-by: Hector Martin <marcan@marcan.st>
Tested-by: Hector Martin <marcan@marcan.st>

Smoke tested on t8112, nothing exploded :)

- Hector
