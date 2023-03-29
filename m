Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B86CEFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjC2Qox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjC2Qos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:44:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D746AC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:44:47 -0700 (PDT)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA9DF3F22E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680108285;
        bh=EyeEQ1AHWnCSnuIf8XiK8lJXYQEG/nT/Q5+PoE7cTkw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bByMShUNl10QA2w3GkSQ9I3BVA4joqiJ+gZEWlFed7tp7H/g3AWijcv9gL4slhpS7
         OjH3iSRN9us1JovZWRjBfqPRfETKcDdT/Ae6wj7LsX5GBqAVmv1tPiw4S0e51n9Vln
         bq6l6/nwB+pxpkK/gHTWdOpiA3AUpwmG1Q0dp6F/awyG6X/pZVixkzz5Eh4JXZpzjQ
         Xc19z/Z7CknJR2QwKMJHNxS3/dNxQjmugBtyXJP1Dtuo2G3jWdTyVV+xzCCrtKC/GO
         ADy3WYVwn3SzIDrhoELcRamJKb1qxs9qLgEbiiOWrjqYKCaju+YMk/ZRbzkxdK5T5i
         7zq21V8DC+QOw==
Received: by mail-qk1-f199.google.com with SMTP id c186-20020a379ac3000000b007484744a472so7293943qke.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyeEQ1AHWnCSnuIf8XiK8lJXYQEG/nT/Q5+PoE7cTkw=;
        b=XCdA7yWBe2Re2PTzrypP+Ny7BjQqsG5CGoiKdVfGyTu6W3Q2lgpqEs7o0Dn+BFq43S
         4p+3n1/rdNnQ24PE06KgXXX+7yaNmTB0NexwjnUnG+VJvp75uJ3YGVnFEPt1l5HpX9Fr
         OkKHJMr1rh4006pw0i38tQD14Zsx21oHDW8dJJtxWqesjT/dY42HJpWbfhmY+o1zxr4i
         msI2UEy/qt0VCM5vLGFoqtZEyC4OWRVeB/U817O2S6n7Pq1MXnBtoF0/R7o1iuOMdeh2
         mGZiUD9Yl2CgH6RtvN/AyO1St++IXU38eNkidLZ1GspDrQ6RuEiEEmTQpmxoG7bZwdL9
         GpIQ==
X-Gm-Message-State: AO0yUKVZEVYYVfb/VEtHZ0F3Aig6Wwk2tIv7N8iCGC6oEOrbtwdNQzQc
        Rs1E52sAB1Y8AX4zabLTdy172qoNzrSvflSqtDfV7v7KGuUpVYFJCllbNbRlXicUdbW+sM1Rg4E
        r2e12gVKov75tVKhZSdyWmf8/GclhL8/SuWLycct/5z9T2JNhITNWUBGzyg==
X-Received: by 2002:a05:622a:1884:b0:3df:bda6:6932 with SMTP id v4-20020a05622a188400b003dfbda66932mr7869658qtc.5.1680108284782;
        Wed, 29 Mar 2023 09:44:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y1cVxGuPtBTs1wRb/jyIhkYUN/54t+rl3mcjEBrkbwCHAbaWmaIbnZhzUATvLj14fK9TXwo7iF2IFoPdOcByI=
X-Received: by 2002:a05:622a:1884:b0:3df:bda6:6932 with SMTP id
 v4-20020a05622a188400b003dfbda66932mr7869652qtc.5.1680108284532; Wed, 29 Mar
 2023 09:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064643.24805-1-mason.huo@starfivetech.com>
In-Reply-To: <20230308064643.24805-1-mason.huo@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 29 Mar 2023 18:44:28 +0200
Message-ID: <CAJM55Z8aOqAOfnNSJcKNuxJKRhjj7PzWia0Cu5kmyt9znbqcNQ@mail.gmail.com>
Subject: Re: [PATCH v4] irqchip/irq-sifive-plic: Add syscore callbacks for hibernation
To:     Mason Huo <mason.huo@starfivetech.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 at 07:49, Mason Huo <mason.huo@starfivetech.com> wrote:
>
> The priority and enable registers of plic will be reset
> during hibernation power cycle in poweroff mode,
> add the syscore callbacks to save/restore those registers.
>
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302140709.CdkxgtPi-lkp@intel.com/
> ---
>  drivers/irqchip/irq-sifive-plic.c | 93 ++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index ff47bd0dec45..2800e7bb149a 100644
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
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
>         unsigned long plic_quirks;
> +       unsigned int nr_irqs;
> +       unsigned long *prio_save;
>  };
>
>  struct plic_handler {
> @@ -78,6 +81,7 @@ struct plic_handler {
>          */
>         raw_spinlock_t          enable_lock;
>         void __iomem            *enable_base;
> +       u32                     *enable_save;
>         struct plic_priv        *priv;
>  };
>  static int plic_parent_irq __ro_after_init;
> @@ -229,6 +233,71 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
>         return IRQ_SET_MASK_OK;
>  }
>
> +static int plic_irq_suspend(void)
> +{
> +       unsigned int i, cpu;
> +       u32 __iomem *reg;
> +       struct plic_priv *priv;
> +
> +       priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
> +
> +       for (i = 0; i < priv->nr_irqs; i++)
> +               if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
> +                       __set_bit(i, priv->prio_save);
> +               else
> +                       __clear_bit(i, priv->prio_save);
> +
> +       for_each_cpu(cpu, cpu_present_mask) {
> +               struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +               if (!handler->present)
> +                       continue;
> +
> +               raw_spin_lock(&handler->enable_lock);
> +               for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
> +                       reg = handler->enable_base + i * sizeof(u32);
> +                       handler->enable_save[i] = readl(reg);
> +               }
> +               raw_spin_unlock(&handler->enable_lock);
> +       }
> +
> +       return 0;
> +}
> +
> +static void plic_irq_resume(void)
> +{
> +       unsigned int i, index, cpu;
> +       u32 __iomem *reg;
> +       struct plic_priv *priv;
> +
> +       priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
> +
> +       for (i = 0; i < priv->nr_irqs; i++) {
> +               index = (i / BITS_PER_LONG);
> +               writel((priv->prio_save[index] & BIT(i % BITS_PER_LONG)) ? 1 : 0,

This looks like BIT_WORD and test_bit (or at least BIT_MASK).

> +                      priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
> +       }
> +
> +       for_each_cpu(cpu, cpu_present_mask) {
> +               struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +               if (!handler->present)
> +                       continue;
> +
> +               raw_spin_lock(&handler->enable_lock);
> +               for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
> +                       reg = handler->enable_base + i * sizeof(u32);
> +                       writel(handler->enable_save[i], reg);
> +               }
> +               raw_spin_unlock(&handler->enable_lock);
> +       }
> +}
> +
> +static struct syscore_ops plic_irq_syscore_ops = {
> +       .suspend        = plic_irq_suspend,
> +       .resume         = plic_irq_resume,
> +};
> +
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>                               irq_hw_number_t hwirq)
>  {
> @@ -345,6 +414,7 @@ static int __init __plic_init(struct device_node *node,
>         u32 nr_irqs;
>         struct plic_priv *priv;
>         struct plic_handler *handler;
> +       unsigned int cpu;
>
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -363,15 +433,21 @@ static int __init __plic_init(struct device_node *node,
>         if (WARN_ON(!nr_irqs))
>                 goto out_iounmap;
>
> +       priv->nr_irqs = nr_irqs;
> +
> +       priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
> +       if (!priv->prio_save)
> +               goto out_free_priority_reg;
> +
>         nr_contexts = of_irq_count(node);
>         if (WARN_ON(!nr_contexts))
> -               goto out_iounmap;
> +               goto out_free_priority_reg;
>
>         error = -ENOMEM;
>         priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
>                         &plic_irqdomain_ops, priv);
>         if (WARN_ON(!priv->irqdomain))
> -               goto out_iounmap;
> +               goto out_free_priority_reg;
>
>         for (i = 0; i < nr_contexts; i++) {
>                 struct of_phandle_args parent;
> @@ -441,6 +517,11 @@ static int __init __plic_init(struct device_node *node,
>                 handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
>                         i * CONTEXT_ENABLE_SIZE;
>                 handler->priv = priv;
> +
> +               handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
> +                                               sizeof(*handler->enable_save), GFP_KERNEL);
> +               if (!handler->enable_save)
> +                       goto out_free_enable_reg;
>  done:
>                 for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
>                         plic_toggle(handler, hwirq, 0);
> @@ -461,11 +542,19 @@ static int __init __plic_init(struct device_node *node,
>                                   plic_starting_cpu, plic_dying_cpu);
>                 plic_cpuhp_setup_done = true;
>         }
> +       register_syscore_ops(&plic_irq_syscore_ops);
>
>         pr_info("%pOFP: mapped %d interrupts with %d handlers for"
>                 " %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
>         return 0;
>
> +out_free_enable_reg:
> +       for_each_cpu(cpu, cpu_present_mask) {
> +               handler = per_cpu_ptr(&plic_handlers, cpu);
> +               kfree(handler->enable_save);
> +       }
> +out_free_priority_reg:
> +       kfree(priv->prio_save);
>  out_iounmap:
>         iounmap(priv->regs);
>  out_free_priv:
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
