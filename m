Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23A374F14F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjGKOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGKOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:12:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E637B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so6540799f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689084748; x=1691676748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfD1QKdUUlCP07+roOoFywxk5muRqmFooE0qd5aLBns=;
        b=Kt9VufYvB/j33LbCFZgmXbkZGy73eeJnSwJU6p4I6FPhIWqWc/XSW9TCpHoNIlP8rV
         OTYAZr32mXwnI6z3yyXxO3bpKIrZwF4CJPrTbU2HTgCOTL8WMBFfMHVQkP+g87VqCPXM
         qfcuNn4l4ev0h26GQGWG3Mj1Xjeoo7InCIXUFEca6NR+P2cDr5X8/3eeI8WqJoWAg2TN
         iFQSJqpzrhAGrQ2tebTqq7MlT5APaAGqd1W+pXzuOdgmFeQ6Ka8F9I90N6QOuceU/gy6
         pk6Xn9jWWHFGkTJ+GvzoQk6r/PRePEf4t7JPhZchGETRjvERS3nflezo9XljrQUBYOa2
         thgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689084748; x=1691676748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfD1QKdUUlCP07+roOoFywxk5muRqmFooE0qd5aLBns=;
        b=kegnJ57viTvxB6qyBRKa2sLhhxa1MRLas8ePhVtVXnB13fND5aA60ArZEu5p8c5TeA
         9aNRcQrh9hLkxVHjW9BL9cOdjQ1ngTIjv1HIhzuzw4IkcXCA5VfOe/ucGfjdYTejTWBU
         /pgrf3l0fSR1fbJHfkbE1GK3ag/QO1KSCNUbr1zyeo9/cw3auGhKzHHK5sn9GKunv++h
         ug/RgyEmlO3zocHadAm67XICkPjN0KlGBrxdhY97ev3GBQI6GuKv+2yXXUnK68XhF3D7
         552uJ2O3/GRMr+cBxM6WP6b1MkzYhHIs2AeZweJOe0wcv8EMnBU8rHtsbErbv4McsCKc
         ZiQw==
X-Gm-Message-State: ABy/qLZFRBnwKDVSmIsWS5k1aDVh5/Lb2BIpPeWuY88GZkGAYedTAuD3
        NekkX4KjCdpdDUqleKiSEGBN3g==
X-Google-Smtp-Source: APBJJlHdpMDer9jq8C+08J0C6lUJOUhXFT5I8NKyZycrI5aqDIXOSH3usMO5vCEWntD4j587cS4rRw==
X-Received: by 2002:adf:db04:0:b0:313:ee73:cc9a with SMTP id s4-20020adfdb04000000b00313ee73cc9amr13524583wri.70.1689084747658;
        Tue, 11 Jul 2023 07:12:27 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o18-20020adfe812000000b00314417f5272sm2354907wrm.64.2023.07.11.07.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:12:27 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:12:26 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/9] irqchip/riscv-intc: Add support for RISC-V AIA
Message-ID: <20230711-df9211fcae3b67948896b77f@orel>
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710094321.1378351-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:13:14PM +0530, Anup Patel wrote:
> The RISC-V advanced interrupt architecture (AIA) extends the per-HART
> local interrupts in following ways:
> 1. Minimum 64 local interrupts for both RV32 and RV64
> 2. Ability to process multiple pending local interrupts in same
>    interrupt handler
> 3. Priority configuration for each local interrupts
> 4. Special CSRs to configure/access the per-HART MSI controller

afaict, we're only doing (1) and (2) from this list in this patch.

> 
> This patch adds support for RISC-V AIA in the RISC-V intc driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 36 ++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 4adeee1bc391..e235bf1708a4 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/smp.h>
> +#include <asm/hwcap.h>
>  
>  static struct irq_domain *intc_domain;
>  
> @@ -30,6 +31,15 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  	generic_handle_domain_irq(intc_domain, cause);
>  }
>  
> +static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
> +{
> +	unsigned long topi;
> +
> +	while ((topi = csr_read(CSR_TOPI)))
> +		generic_handle_domain_irq(intc_domain,
> +					  topi >> TOPI_IID_SHIFT);
> +}
> +
>  /*
>   * On RISC-V systems local interrupts are masked or unmasked by writing
>   * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be written
> @@ -39,12 +49,18 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  
>  static void riscv_intc_irq_mask(struct irq_data *d)
>  {
> -	csr_clear(CSR_IE, BIT(d->hwirq));
> +	if (d->hwirq < BITS_PER_LONG)
> +		csr_clear(CSR_IE, BIT(d->hwirq));
> +	else
> +		csr_clear(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));

We can optimize rv64 by allowing the compiler to remove the branch

 if (IS_ENABLED(CONFIG_32BIT) && d->hwirq >= 32)
    csr_clear(CSR_IEH, BIT(d->hwirq - 32));
 else
    csr_clear(CSR_IE, BIT(d->hwirq));


>  }
>  
>  static void riscv_intc_irq_unmask(struct irq_data *d)
>  {
> -	csr_set(CSR_IE, BIT(d->hwirq));
> +	if (d->hwirq < BITS_PER_LONG)
> +		csr_set(CSR_IE, BIT(d->hwirq));
> +	else
> +		csr_set(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));

Same comment as above.

>  }
>  
>  static void riscv_intc_irq_eoi(struct irq_data *d)
> @@ -115,16 +131,22 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
>  
>  static int __init riscv_intc_init_common(struct fwnode_handle *fn)
>  {
> -	int rc;
> +	int rc, nr_irqs = BITS_PER_LONG;
> +
> +	if (riscv_isa_extension_available(NULL, SxAIA) && BITS_PER_LONG == 32)
> +		nr_irqs = nr_irqs * 2;

The AIA spec states sie and sip are explicitly 64, so how about writing
this as

 int rc, nr_irqs = BITS_PER_LONG;

 if (riscv_isa_extension_available(NULL, SxAIA))
     nr_irqs = 64;

>  
> -	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> +	intc_domain = irq_domain_create_linear(fn, nr_irqs,
>  					       &riscv_intc_domain_ops, NULL);
>  	if (!intc_domain) {
>  		pr_err("unable to add IRQ domain\n");
>  		return -ENXIO;
>  	}
>  
> -	rc = set_handle_irq(&riscv_intc_irq);
> +	if (riscv_isa_extension_available(NULL, SxAIA))
> +		rc = set_handle_irq(&riscv_intc_aia_irq);
> +	else
> +		rc = set_handle_irq(&riscv_intc_irq);

nit: blank line here

>  	if (rc) {
>  		pr_err("failed to set irq handler\n");
>  		return rc;
> @@ -132,7 +154,9 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
>  
>  	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
>  
> -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +	pr_info("%d local interrupts mapped%s\n",
> +		nr_irqs, (riscv_isa_extension_available(NULL, SxAIA)) ?

nit: unnecessary ()

> +			 " using AIA" : "");
>  
>  	return 0;
>  }
> -- 
> 2.34.1
>

Thanks,
drew
