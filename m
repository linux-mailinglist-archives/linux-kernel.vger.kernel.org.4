Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C269A2DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBQAMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQAMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:12:45 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0592D3A860
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:12:40 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 58FEF24E1A6;
        Fri, 17 Feb 2023 08:12:39 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Feb
 2023 08:12:39 +0800
Received: from [192.168.125.89] (183.27.98.67) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Feb
 2023 08:12:38 +0800
Message-ID: <f07e1037-641d-c1f6-f3c0-5cf0b8bbbc3c@starfivetech.com>
Date:   Fri, 17 Feb 2023 08:12:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] irqchip/irq-sifive-plic: Add syscore callbacks for
 hibernation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Ley Foon Tan" <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20230210100122.80255-1-mason.huo@starfivetech.com>
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230210100122.80255-1-mason.huo@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Do you have any comment on v3 patch that fixed the issues you commented in v2?

Thanks
Mason

On 2023/2/10 18:01, Mason Huo wrote:
> The priority and enable registers of plic will be reset
> during hibernation power cycle in poweroff mode,
> add the syscore callbacks to save/restore those registers.
> 
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 93 ++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index ff47bd0dec45..f9d314afecf1 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> +#include <linux/syscore_ops.h>
>  #include <asm/smp.h>
>  
>  /*
> @@ -67,6 +68,8 @@ struct plic_priv {
>  	struct irq_domain *irqdomain;
>  	void __iomem *regs;
>  	unsigned long plic_quirks;
> +	unsigned int nr_irqs;
> +	unsigned long *prio_save;
>  };
>  
>  struct plic_handler {
> @@ -78,6 +81,7 @@ struct plic_handler {
>  	 */
>  	raw_spinlock_t		enable_lock;
>  	void __iomem		*enable_base;
> +	u32			*enable_save;
>  	struct plic_priv	*priv;
>  };
>  static int plic_parent_irq __ro_after_init;
> @@ -229,6 +233,71 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
>  	return IRQ_SET_MASK_OK;
>  }
>  
> +static int plic_irq_suspend(void)
> +{
> +	unsigned int i, cpu;
> +	u32 __iomem *reg;
> +	struct plic_priv *priv;
> +
> +	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
> +
> +	for (i = 0; i < priv->nr_irqs; i++)
> +		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
> +			__set_bit(i, priv->prio_save);
> +		else
> +			__clear_bit(i, priv->prio_save);
> +
> +	for_each_cpu(cpu, cpu_present_mask) {
> +		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +		if (!handler->present)
> +			continue;
> +
> +		raw_spin_lock(&handler->enable_lock);
> +		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
> +			reg = handler->enable_base + i * sizeof(u32);
> +			handler->enable_save[i] = readl(reg);
> +		}
> +		raw_spin_unlock(&handler->enable_lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static void plic_irq_resume(void)
> +{
> +	unsigned int i, index, cpu;
> +	u32 __iomem *reg;
> +	struct plic_priv *priv;
> +
> +	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
> +
> +	for (i = 0; i < priv->nr_irqs; i++) {
> +		index = (i / BITS_PER_LONG);
> +		writel((priv->prio_save[index] & BIT(i % BITS_PER_LONG)) ? 1 : 0,
> +		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
> +	}
> +
> +	for_each_cpu(cpu, cpu_present_mask) {
> +		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +		if (!handler->present)
> +			continue;
> +
> +		raw_spin_lock(&handler->enable_lock);
> +		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
> +			reg = handler->enable_base + i * sizeof(u32);
> +			writel(handler->enable_save[i], reg);
> +		}
> +		raw_spin_unlock(&handler->enable_lock);
> +	}
> +}
> +
> +static struct syscore_ops plic_irq_syscore_ops = {
> +	.suspend	= plic_irq_suspend,
> +	.resume		= plic_irq_resume,
> +};
> +
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  			      irq_hw_number_t hwirq)
>  {
> @@ -345,6 +414,7 @@ static int __init __plic_init(struct device_node *node,
>  	u32 nr_irqs;
>  	struct plic_priv *priv;
>  	struct plic_handler *handler;
> +	unsigned int cpu;
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -363,15 +433,21 @@ static int __init __plic_init(struct device_node *node,
>  	if (WARN_ON(!nr_irqs))
>  		goto out_iounmap;
>  
> +	priv->nr_irqs = nr_irqs;
> +
> +	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
> +	if (!priv->prio_save)
> +		goto out_free_priority_reg;
> +
>  	nr_contexts = of_irq_count(node);
>  	if (WARN_ON(!nr_contexts))
> -		goto out_iounmap;
> +		goto out_free_priority_reg;
>  
>  	error = -ENOMEM;
>  	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
>  			&plic_irqdomain_ops, priv);
>  	if (WARN_ON(!priv->irqdomain))
> -		goto out_iounmap;
> +		goto out_free_priority_reg;
>  
>  	for (i = 0; i < nr_contexts; i++) {
>  		struct of_phandle_args parent;
> @@ -441,6 +517,11 @@ static int __init __plic_init(struct device_node *node,
>  		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
>  			i * CONTEXT_ENABLE_SIZE;
>  		handler->priv = priv;
> +
> +		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
> +						32, GFP_KERNEL);
> +		if (!handler->enable_save)
> +			goto out_free_enable_reg;
>  done:
>  		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
>  			plic_toggle(handler, hwirq, 0);
> @@ -461,11 +542,19 @@ static int __init __plic_init(struct device_node *node,
>  				  plic_starting_cpu, plic_dying_cpu);
>  		plic_cpuhp_setup_done = true;
>  	}
> +	register_syscore_ops(&plic_irq_syscore_ops);
>  
>  	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
>  		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
>  	return 0;
>  
> +out_free_enable_reg:
> +	for_each_cpu(cpu, cpu_present_mask) {
> +		handler = per_cpu_ptr(&plic_handlers, cpu);
> +		kfree(handler->enable_save);
> +	}
> +out_free_priority_reg:
> +	kfree(priv->prio_save);
>  out_iounmap:
>  	iounmap(priv->regs);
>  out_free_priv:
