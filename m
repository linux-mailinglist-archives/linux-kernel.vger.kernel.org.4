Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581F9697266
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBOADW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBOAC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:02:56 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06895FF5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:02:52 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 670F924E1CF;
        Wed, 15 Feb 2023 08:02:50 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 08:02:50 +0800
Received: from [192.168.125.89] (183.27.97.168) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 08:02:49 +0800
Message-ID: <0cecf0a7-a37c-e1ac-2cdc-89baa01725ff@starfivetech.com>
Date:   Wed, 15 Feb 2023 08:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] irqchip/irq-sifive-plic: Add syscore callbacks for
 hibernation
To:     Dan Carpenter <error27@gmail.com>, <oe-kbuild@lists.linux.dev>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Ley Foon Tan" <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <202302140709.CdkxgtPi-lkp@intel.com>
Content-Language: en-US
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <202302140709.CdkxgtPi-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 15:54, Dan Carpenter wrote:
> Hi Mason,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mason-Huo/irqchip-irq-sifive-plic-Add-syscore-callbacks-for-hibernation/20230210-180324
> patch link:    https://lore.kernel.org/r/20230210100122.80255-1-mason.huo%40starfivetech.com
> patch subject: [PATCH v3] irqchip/irq-sifive-plic: Add syscore callbacks for hibernation
> config: riscv-randconfig-m031-20230212 (https://download.01.org/0day-ci/archive/20230214/202302140709.CdkxgtPi-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202302140709.CdkxgtPi-lkp@intel.com/
> 
> smatch warnings:
> drivers/irqchip/irq-sifive-plic.c:521 __plic_init() warn: double check that we're allocating correct size: 4 vs 32
> 
> vim +521 drivers/irqchip/irq-sifive-plic.c
> 
> dd46337ca69662 Lad Prabhakar     2022-06-30  409  static int __init __plic_init(struct device_node *node,
> dd46337ca69662 Lad Prabhakar     2022-06-30  410  			      struct device_node *parent,
> dd46337ca69662 Lad Prabhakar     2022-06-30  411  			      unsigned long plic_quirks)
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  412  {
> 6adfe8d2f5b353 Anup Patel        2019-02-12  413  	int error = 0, nr_contexts, nr_handlers = 0, i;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  414  	u32 nr_irqs;
> f1ad1133b18f2a Atish Patra       2020-03-02  415  	struct plic_priv *priv;
> 2234ae846ccb9e Anup Patel        2020-05-18  416  	struct plic_handler *handler;
> 2858a4d6b620ef Mason Huo         2023-02-10  417  	unsigned int cpu;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  418  
> f1ad1133b18f2a Atish Patra       2020-03-02  419  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> f1ad1133b18f2a Atish Patra       2020-03-02  420  	if (!priv)
> f1ad1133b18f2a Atish Patra       2020-03-02  421  		return -ENOMEM;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  422  
> dd46337ca69662 Lad Prabhakar     2022-06-30  423  	priv->plic_quirks = plic_quirks;
> dd46337ca69662 Lad Prabhakar     2022-06-30  424  
> f1ad1133b18f2a Atish Patra       2020-03-02  425  	priv->regs = of_iomap(node, 0);
> f1ad1133b18f2a Atish Patra       2020-03-02  426  	if (WARN_ON(!priv->regs)) {
> f1ad1133b18f2a Atish Patra       2020-03-02  427  		error = -EIO;
> f1ad1133b18f2a Atish Patra       2020-03-02  428  		goto out_free_priv;
> f1ad1133b18f2a Atish Patra       2020-03-02  429  	}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  430  
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  431  	error = -EINVAL;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  432  	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  433  	if (WARN_ON(!nr_irqs))
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  434  		goto out_iounmap;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  435  
> 2858a4d6b620ef Mason Huo         2023-02-10  436  	priv->nr_irqs = nr_irqs;
> 2858a4d6b620ef Mason Huo         2023-02-10  437  
> 2858a4d6b620ef Mason Huo         2023-02-10  438  	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
> 2858a4d6b620ef Mason Huo         2023-02-10  439  	if (!priv->prio_save)
> 2858a4d6b620ef Mason Huo         2023-02-10  440  		goto out_free_priority_reg;
> 2858a4d6b620ef Mason Huo         2023-02-10  441  
> 6adfe8d2f5b353 Anup Patel        2019-02-12  442  	nr_contexts = of_irq_count(node);
> 6adfe8d2f5b353 Anup Patel        2019-02-12  443  	if (WARN_ON(!nr_contexts))
> 2858a4d6b620ef Mason Huo         2023-02-10  444  		goto out_free_priority_reg;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  445  
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  446  	error = -ENOMEM;
> f1ad1133b18f2a Atish Patra       2020-03-02  447  	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> f1ad1133b18f2a Atish Patra       2020-03-02  448  			&plic_irqdomain_ops, priv);
> f1ad1133b18f2a Atish Patra       2020-03-02  449  	if (WARN_ON(!priv->irqdomain))
> 2858a4d6b620ef Mason Huo         2023-02-10  450  		goto out_free_priority_reg;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  451  
> 6adfe8d2f5b353 Anup Patel        2019-02-12  452  	for (i = 0; i < nr_contexts; i++) {
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  453  		struct of_phandle_args parent;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  454  		irq_hw_number_t hwirq;
> ad635e723e1737 Sunil V L         2022-05-27  455  		int cpu;
> ad635e723e1737 Sunil V L         2022-05-27  456  		unsigned long hartid;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  457  
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  458  		if (of_irq_parse_one(node, i, &parent)) {
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  459  			pr_err("failed to parse parent for context %d.\n", i);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  460  			continue;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  461  		}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  462  
> a4c3733d32a72f Christoph Hellwig 2019-10-28  463  		/*
> a4c3733d32a72f Christoph Hellwig 2019-10-28  464  		 * Skip contexts other than external interrupts for our
> a4c3733d32a72f Christoph Hellwig 2019-10-28  465  		 * privilege level.
> a4c3733d32a72f Christoph Hellwig 2019-10-28  466  		 */
> 098fdbc3531f06 Niklas Cassel     2022-03-02  467  		if (parent.args[0] != RV_IRQ_EXT) {
> 098fdbc3531f06 Niklas Cassel     2022-03-02  468  			/* Disable S-mode enable bits if running in M-mode. */
> 098fdbc3531f06 Niklas Cassel     2022-03-02  469  			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
> 098fdbc3531f06 Niklas Cassel     2022-03-02  470  				void __iomem *enable_base = priv->regs +
> 098fdbc3531f06 Niklas Cassel     2022-03-02  471  					CONTEXT_ENABLE_BASE +
> 098fdbc3531f06 Niklas Cassel     2022-03-02  472  					i * CONTEXT_ENABLE_SIZE;
> 098fdbc3531f06 Niklas Cassel     2022-03-02  473  
> 098fdbc3531f06 Niklas Cassel     2022-03-02  474  				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> 098fdbc3531f06 Niklas Cassel     2022-03-02  475  					__plic_toggle(enable_base, hwirq, 0);
> 098fdbc3531f06 Niklas Cassel     2022-03-02  476  			}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  477  			continue;
> 098fdbc3531f06 Niklas Cassel     2022-03-02  478  		}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  479  
> ad635e723e1737 Sunil V L         2022-05-27  480  		error = riscv_of_parent_hartid(parent.np, &hartid);
> ad635e723e1737 Sunil V L         2022-05-27  481  		if (error < 0) {
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  482  			pr_warn("failed to parse hart ID for context %d.\n", i);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  483  			continue;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  484  		}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  485  
> f99fb607fb2bc0 Atish Patra       2018-10-02  486  		cpu = riscv_hartid_to_cpuid(hartid);
> fc03acaeab358c Atish Patra       2019-02-12  487  		if (cpu < 0) {
> fc03acaeab358c Atish Patra       2019-02-12  488  			pr_warn("Invalid cpuid for context %d\n", i);
> fc03acaeab358c Atish Patra       2019-02-12  489  			continue;
> fc03acaeab358c Atish Patra       2019-02-12  490  		}
> fc03acaeab358c Atish Patra       2019-02-12  491  
> 6b7ce8927b5a4d Anup Patel        2020-06-01  492  		/* Find parent domain and register chained handler */
> 6b7ce8927b5a4d Anup Patel        2020-06-01  493  		if (!plic_parent_irq && irq_find_host(parent.np)) {
> 6b7ce8927b5a4d Anup Patel        2020-06-01  494  			plic_parent_irq = irq_of_parse_and_map(node, i);
> 6b7ce8927b5a4d Anup Patel        2020-06-01  495  			if (plic_parent_irq)
> 6b7ce8927b5a4d Anup Patel        2020-06-01  496  				irq_set_chained_handler(plic_parent_irq,
> 6b7ce8927b5a4d Anup Patel        2020-06-01  497  							plic_handle_irq);
> 6b7ce8927b5a4d Anup Patel        2020-06-01  498  		}
> 6b7ce8927b5a4d Anup Patel        2020-06-01  499  
> 9ce06497c2722a Christoph Hellwig 2019-09-03  500  		/*
> 9ce06497c2722a Christoph Hellwig 2019-09-03  501  		 * When running in M-mode we need to ignore the S-mode handler.
> 9ce06497c2722a Christoph Hellwig 2019-09-03  502  		 * Here we assume it always comes later, but that might be a
> 9ce06497c2722a Christoph Hellwig 2019-09-03  503  		 * little fragile.
> 9ce06497c2722a Christoph Hellwig 2019-09-03  504  		 */
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  505  		handler = per_cpu_ptr(&plic_handlers, cpu);
> 3fecb5aac28888 Anup Patel        2019-02-12  506  		if (handler->present) {
> 3fecb5aac28888 Anup Patel        2019-02-12  507  			pr_warn("handler already present for context %d.\n", i);
> ccbe80bad571c2 Atish Patra       2020-03-02  508  			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> 9ce06497c2722a Christoph Hellwig 2019-09-03  509  			goto done;
> 3fecb5aac28888 Anup Patel        2019-02-12  510  		}
> 3fecb5aac28888 Anup Patel        2019-02-12  511  
> f1ad1133b18f2a Atish Patra       2020-03-02  512  		cpumask_set_cpu(cpu, &priv->lmask);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  513  		handler->present = true;
> 0d3616bbd03cdf Niklas Cassel     2022-03-02  514  		handler->hart_base = priv->regs + CONTEXT_BASE +
> 0d3616bbd03cdf Niklas Cassel     2022-03-02  515  			i * CONTEXT_SIZE;
> 86c7cbf1e8d1d4 Anup Patel        2019-02-12  516  		raw_spin_lock_init(&handler->enable_lock);
> 0d3616bbd03cdf Niklas Cassel     2022-03-02  517  		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
> 0d3616bbd03cdf Niklas Cassel     2022-03-02  518  			i * CONTEXT_ENABLE_SIZE;
> f1ad1133b18f2a Atish Patra       2020-03-02  519  		handler->priv = priv;
> 2858a4d6b620ef Mason Huo         2023-02-10  520  
> 2858a4d6b620ef Mason Huo         2023-02-10 @521  		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
> 2858a4d6b620ef Mason Huo         2023-02-10  522  						32, GFP_KERNEL);
> 
> Smatch is correct that this should be allocating
> sizeof(*handler->enable_save) which is 4 bytes instead of 32 bytes.
> I looked at the code, and this is a bits vs bytes bug.
> 
Hi Dan,
Yes, and will fix it in next revision.

Thanks
Mason
> 2858a4d6b620ef Mason Huo         2023-02-10  523  		if (!handler->enable_save)
> 2858a4d6b620ef Mason Huo         2023-02-10  524  			goto out_free_enable_reg;
> 9ce06497c2722a Christoph Hellwig 2019-09-03  525  done:
> a1706a1c5062e0 Samuel Holland    2022-07-01  526  		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
> 86c7cbf1e8d1d4 Anup Patel        2019-02-12  527  			plic_toggle(handler, hwirq, 0);
> a1706a1c5062e0 Samuel Holland    2022-07-01  528  			writel(1, priv->regs + PRIORITY_BASE +
> a1706a1c5062e0 Samuel Holland    2022-07-01  529  				  hwirq * PRIORITY_PER_ID);
> a1706a1c5062e0 Samuel Holland    2022-07-01  530  		}
> 6adfe8d2f5b353 Anup Patel        2019-02-12  531  		nr_handlers++;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  532  	}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  533  
> 2234ae846ccb9e Anup Patel        2020-05-18  534  	/*
> 2234ae846ccb9e Anup Patel        2020-05-18  535  	 * We can have multiple PLIC instances so setup cpuhp state only
> 2234ae846ccb9e Anup Patel        2020-05-18  536  	 * when context handler for current/boot CPU is present.
> 2234ae846ccb9e Anup Patel        2020-05-18  537  	 */
> 2234ae846ccb9e Anup Patel        2020-05-18  538  	handler = this_cpu_ptr(&plic_handlers);
> 2234ae846ccb9e Anup Patel        2020-05-18  539  	if (handler->present && !plic_cpuhp_setup_done) {
> ccbe80bad571c2 Atish Patra       2020-03-02  540  		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> ccbe80bad571c2 Atish Patra       2020-03-02  541  				  "irqchip/sifive/plic:starting",
> ccbe80bad571c2 Atish Patra       2020-03-02  542  				  plic_starting_cpu, plic_dying_cpu);
> 2234ae846ccb9e Anup Patel        2020-05-18  543  		plic_cpuhp_setup_done = true;
> 2234ae846ccb9e Anup Patel        2020-05-18  544  	}
> 2858a4d6b620ef Mason Huo         2023-02-10  545  	register_syscore_ops(&plic_irq_syscore_ops);
> 2234ae846ccb9e Anup Patel        2020-05-18  546  
> 0e375f51017bcc Anup Patel        2020-05-18  547  	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
> 0e375f51017bcc Anup Patel        2020-05-18  548  		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  549  	return 0;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  550  
> 2858a4d6b620ef Mason Huo         2023-02-10  551  out_free_enable_reg:
> 2858a4d6b620ef Mason Huo         2023-02-10  552  	for_each_cpu(cpu, cpu_present_mask) {
> 2858a4d6b620ef Mason Huo         2023-02-10  553  		handler = per_cpu_ptr(&plic_handlers, cpu);
> 2858a4d6b620ef Mason Huo         2023-02-10  554  		kfree(handler->enable_save);
> 2858a4d6b620ef Mason Huo         2023-02-10  555  	}
> 2858a4d6b620ef Mason Huo         2023-02-10  556  out_free_priority_reg:
> 2858a4d6b620ef Mason Huo         2023-02-10  557  	kfree(priv->prio_save);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  558  out_iounmap:
> f1ad1133b18f2a Atish Patra       2020-03-02  559  	iounmap(priv->regs);
> f1ad1133b18f2a Atish Patra       2020-03-02  560  out_free_priv:
> f1ad1133b18f2a Atish Patra       2020-03-02  561  	kfree(priv);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  562  	return error;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  563  }
> 
