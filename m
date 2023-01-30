Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A688680406
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjA3DFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjA3DFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:05:19 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467C91BAFB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:05:06 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6FFF024E120;
        Mon, 30 Jan 2023 11:05:02 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 11:05:02 +0800
Received: from [192.168.125.89] (183.27.97.127) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 11:05:01 +0800
Message-ID: <62f93e87-0519-39d0-7a6d-3276fcde1d30@starfivetech.com>
Date:   Mon, 30 Jan 2023 11:05:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] irqchip/irq-sifive-plic: Add syscore callbacks for
 hibernation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Ley Foon Tan" <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20230113094216.116036-1-mason.huo@starfivetech.com>
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230113094216.116036-1-mason.huo@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.127]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/13 17:42, Mason Huo wrote:
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
> index ff47bd0dec45..80306de45d2b 100644
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
> +	u32 *priority_reg;
>  };
>  
>  struct plic_handler {
> @@ -79,10 +82,13 @@ struct plic_handler {
>  	raw_spinlock_t		enable_lock;
>  	void __iomem		*enable_base;
>  	struct plic_priv	*priv;
> +	/* To record interrupts that are enabled before suspend. */
> +	u32 enable_reg[MAX_DEVICES / 32];
>  };
>  static int plic_parent_irq __ro_after_init;
>  static bool plic_cpuhp_setup_done __ro_after_init;
>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> +static struct plic_priv *priv_data;
>  
>  static int plic_irq_set_type(struct irq_data *d, unsigned int type);
>  
> @@ -229,6 +235,78 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
>  	return IRQ_SET_MASK_OK;
>  }
>  
> +static void plic_irq_resume(void)
> +{
> +	unsigned int i, cpu;
> +	u32 __iomem *reg;
> +
> +	for (i = 0; i < priv_data->nr_irqs; i++)
> +		writel(priv_data->priority_reg[i],
> +				priv_data->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
> +
> +	for_each_cpu(cpu, cpu_present_mask) {
> +		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +		if (!handler->present)
> +			continue;
> +
> +		for (i = 0; i < DIV_ROUND_UP(priv_data->nr_irqs, 32); i++) {
> +			reg = handler->enable_base + i * sizeof(u32);
> +			raw_spin_lock(&handler->enable_lock);
> +			writel(handler->enable_reg[i], reg);
> +			raw_spin_unlock(&handler->enable_lock);
> +		}
> +	}
> +}
> +
> +static int plic_irq_suspend(void)
> +{
> +	unsigned int i, cpu;
> +	u32 __iomem *reg;
> +
> +	for (i = 0; i < priv_data->nr_irqs; i++)
> +		priv_data->priority_reg[i] =
> +			readl(priv_data->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
> +
> +	for_each_cpu(cpu, cpu_present_mask) {
> +		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +		if (!handler->present)
> +			continue;
> +
> +		for (i = 0; i < DIV_ROUND_UP(priv_data->nr_irqs, 32); i++) {
> +			reg = handler->enable_base + i * sizeof(u32);
> +			raw_spin_lock(&handler->enable_lock);
> +			handler->enable_reg[i] = readl(reg);
> +			raw_spin_unlock(&handler->enable_lock);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct syscore_ops plic_irq_syscore_ops = {
> +	.suspend	= plic_irq_suspend,
> +	.resume		= plic_irq_resume,
> +};
> +
> +static void plic_irq_pm_init(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, cpu_present_mask) {
> +		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +		if (!handler->present)
> +			continue;
> +
> +		memset(&handler->enable_reg[0], 0,
> +			sizeof(handler->enable_reg));
> +	}
> +
> +	register_syscore_ops(&plic_irq_syscore_ops);
> +}
> +
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  			      irq_hw_number_t hwirq)
>  {
> @@ -351,6 +429,7 @@ static int __init __plic_init(struct device_node *node,
>  		return -ENOMEM;
>  
>  	priv->plic_quirks = plic_quirks;
> +	priv_data = priv;
>  
>  	priv->regs = of_iomap(node, 0);
>  	if (WARN_ON(!priv->regs)) {
> @@ -363,15 +442,21 @@ static int __init __plic_init(struct device_node *node,
>  	if (WARN_ON(!nr_irqs))
>  		goto out_iounmap;
>  
> +	priv->nr_irqs = nr_irqs;
> +
> +	priv->priority_reg = kcalloc(nr_irqs, sizeof(u32), GFP_KERNEL);
> +	if (!priv->priority_reg)
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
> @@ -461,11 +546,15 @@ static int __init __plic_init(struct device_node *node,
>  				  plic_starting_cpu, plic_dying_cpu);
>  		plic_cpuhp_setup_done = true;
>  	}
> +	plic_irq_pm_init();
>  
>  	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
>  		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
>  	return 0;
>  
> +out_free_priority_reg:
> +	kfree(priv->priority_reg);
> +
>  out_iounmap:
>  	iounmap(priv->regs);
>  out_free_priv:

Hi all,

Could you please help to review and provide comments on this patch?
Looking for your reply.

Thanks
Mason
