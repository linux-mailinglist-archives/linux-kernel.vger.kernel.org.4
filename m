Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093A66D0148
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjC3Kdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjC3Kdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:33:38 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020EBC4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:33:35 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CA0E424E268;
        Thu, 30 Mar 2023 18:33:26 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Mar
 2023 18:33:26 +0800
Received: from [192.168.125.89] (113.72.144.76) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Mar
 2023 18:33:26 +0800
Message-ID: <66dba937-9364-b28a-5d4b-c6e36b6c7852@starfivetech.com>
Date:   Thu, 30 Mar 2023 18:33:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] irqchip/irq-sifive-plic: Add syscore callbacks for
 hibernation
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20230308064643.24805-1-mason.huo@starfivetech.com>
 <CAJM55Z8aOqAOfnNSJcKNuxJKRhjj7PzWia0Cu5kmyt9znbqcNQ@mail.gmail.com>
Content-Language: en-US
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <CAJM55Z8aOqAOfnNSJcKNuxJKRhjj7PzWia0Cu5kmyt9znbqcNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 0:44, Emil Renner Berthing wrote:
> On Wed, 8 Mar 2023 at 07:49, Mason Huo <mason.huo@starfivetech.com> wrote:
>>
>> The priority and enable registers of plic will be reset
>> during hibernation power cycle in poweroff mode,
>> add the syscore callbacks to save/restore those registers.
>>
>> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
>> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>> Reviewed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Link: https://lore.kernel.org/r/202302140709.CdkxgtPi-lkp@intel.com/
>> ---
>>  drivers/irqchip/irq-sifive-plic.c | 93 ++++++++++++++++++++++++++++++-
>>  1 file changed, 91 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index ff47bd0dec45..2800e7bb149a 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/syscore_ops.h>
>>  #include <asm/smp.h>
>>
>>  /*
>> @@ -67,6 +68,8 @@ struct plic_priv {
>>         struct irq_domain *irqdomain;
>>         void __iomem *regs;
>>         unsigned long plic_quirks;
>> +       unsigned int nr_irqs;
>> +       unsigned long *prio_save;
>>  };
>>
>>  struct plic_handler {
>> @@ -78,6 +81,7 @@ struct plic_handler {
>>          */
>>         raw_spinlock_t          enable_lock;
>>         void __iomem            *enable_base;
>> +       u32                     *enable_save;
>>         struct plic_priv        *priv;
>>  };
>>  static int plic_parent_irq __ro_after_init;
>> @@ -229,6 +233,71 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
>>         return IRQ_SET_MASK_OK;
>>  }
>>
>> +static int plic_irq_suspend(void)
>> +{
>> +       unsigned int i, cpu;
>> +       u32 __iomem *reg;
>> +       struct plic_priv *priv;
>> +
>> +       priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
>> +
>> +       for (i = 0; i < priv->nr_irqs; i++)
>> +               if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
>> +                       __set_bit(i, priv->prio_save);
>> +               else
>> +                       __clear_bit(i, priv->prio_save);
>> +
>> +       for_each_cpu(cpu, cpu_present_mask) {
>> +               struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
>> +
>> +               if (!handler->present)
>> +                       continue;
>> +
>> +               raw_spin_lock(&handler->enable_lock);
>> +               for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
>> +                       reg = handler->enable_base + i * sizeof(u32);
>> +                       handler->enable_save[i] = readl(reg);
>> +               }
>> +               raw_spin_unlock(&handler->enable_lock);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void plic_irq_resume(void)
>> +{
>> +       unsigned int i, index, cpu;
>> +       u32 __iomem *reg;
>> +       struct plic_priv *priv;
>> +
>> +       priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
>> +
>> +       for (i = 0; i < priv->nr_irqs; i++) {
>> +               index = (i / BITS_PER_LONG);
>> +               writel((priv->prio_save[index] & BIT(i % BITS_PER_LONG)) ? 1 : 0,
> 
> This looks like BIT_WORD and test_bit (or at least BIT_MASK).
> 
Hi Emil,
Thanks for your review, will replace it. 

>> +                      priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
>> +       }
>> +
>> +       for_each_cpu(cpu, cpu_present_mask) {
>> +               struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
>> +
>> +               if (!handler->present)
>> +                       continue;
>> +
>> +               raw_spin_lock(&handler->enable_lock);
>> +               for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
>> +                       reg = handler->enable_base + i * sizeof(u32);
>> +                       writel(handler->enable_save[i], reg);
>> +               }
>> +               raw_spin_unlock(&handler->enable_lock);
>> +       }
>> +}
>> +
>> +static struct syscore_ops plic_irq_syscore_ops = {
>> +       .suspend        = plic_irq_suspend,
>> +       .resume         = plic_irq_resume,
>> +};
>> +
>>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>>                               irq_hw_number_t hwirq)
>>  {
>> @@ -345,6 +414,7 @@ static int __init __plic_init(struct device_node *node,
>>         u32 nr_irqs;
>>         struct plic_priv *priv;
>>         struct plic_handler *handler;
>> +       unsigned int cpu;
>>
>>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>         if (!priv)
>> @@ -363,15 +433,21 @@ static int __init __plic_init(struct device_node *node,
>>         if (WARN_ON(!nr_irqs))
>>                 goto out_iounmap;
>>
>> +       priv->nr_irqs = nr_irqs;
>> +
>> +       priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
>> +       if (!priv->prio_save)
>> +               goto out_free_priority_reg;
>> +
>>         nr_contexts = of_irq_count(node);
>>         if (WARN_ON(!nr_contexts))
>> -               goto out_iounmap;
>> +               goto out_free_priority_reg;
>>
>>         error = -ENOMEM;
>>         priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
>>                         &plic_irqdomain_ops, priv);
>>         if (WARN_ON(!priv->irqdomain))
>> -               goto out_iounmap;
>> +               goto out_free_priority_reg;
>>
>>         for (i = 0; i < nr_contexts; i++) {
>>                 struct of_phandle_args parent;
>> @@ -441,6 +517,11 @@ static int __init __plic_init(struct device_node *node,
>>                 handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
>>                         i * CONTEXT_ENABLE_SIZE;
>>                 handler->priv = priv;
>> +
>> +               handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
>> +                                               sizeof(*handler->enable_save), GFP_KERNEL);
>> +               if (!handler->enable_save)
>> +                       goto out_free_enable_reg;
>>  done:
>>                 for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
>>                         plic_toggle(handler, hwirq, 0);
>> @@ -461,11 +542,19 @@ static int __init __plic_init(struct device_node *node,
>>                                   plic_starting_cpu, plic_dying_cpu);
>>                 plic_cpuhp_setup_done = true;
>>         }
>> +       register_syscore_ops(&plic_irq_syscore_ops);
>>
>>         pr_info("%pOFP: mapped %d interrupts with %d handlers for"
>>                 " %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
>>         return 0;
>>
>> +out_free_enable_reg:
>> +       for_each_cpu(cpu, cpu_present_mask) {
>> +               handler = per_cpu_ptr(&plic_handlers, cpu);
>> +               kfree(handler->enable_save);
>> +       }
>> +out_free_priority_reg:
>> +       kfree(priv->prio_save);
>>  out_iounmap:
>>         iounmap(priv->regs);
>>  out_free_priv:
>> --
>> 2.39.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
