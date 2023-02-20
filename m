Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0654C69D44F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjBTTrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBTTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:47:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F510AA7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:47:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cy6so3296707edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yUq4FLB/m803F8fK5gZnIqcPnrhr2EPp/zQNvrCSCU=;
        b=Nlw2qqdiuA+f6FDd37PV1+VWypIXmelCRTvF41kn2/XQJVs/PUbZeL1cChlgHIL6tA
         YEqLLvfPvioOkiry08GiJPu+nhAHiFRZDW5UTHJcvttvvlUokneNZnR8HMKYc9AKkDCP
         EYMqikEdcIwdBySNMkJLuxT5xtuP/4PYwyOPb9oXgeF1trSqPB95edwgQVDuIXujf7N3
         230nnVnBABlLfdyrt7wEz1qYOaX9thIsPOFRrspnuQ4k/FT/smsCwTIOc7RXfGShK6bZ
         kWLfGcKvVoDTQAIsA1z59gDh/EWLkKyNfyLLZdyoSHe/VfBmlIr8hMWgnQKxDPX7AXeW
         /u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yUq4FLB/m803F8fK5gZnIqcPnrhr2EPp/zQNvrCSCU=;
        b=tMkDn8fhHfLuXHGJBbqk3JG4P4ywk6fFihrMHvHmcXy/kQVy3E5FJDAVnUGPH5bPUD
         rMkcpWdWZD9QrEdCbXEKWz+vmAHh2D33F6tGzRbGvcOtCCno4WZell5CrYzYsEOBmAFR
         BtxkCBBDFNqTTdd12S/b2XmmkufwUIymDtn8Yd5Jrb0XF2R6tkNyVqHc7lRvn83EaUdb
         txSFvXazT+Kh8uXXHX5ry8IrShgRXANmZSA1soqP8jk1YbL+iiDAB9xU221GR0Ellge5
         smhnFbnN9jFeO7fC+V71qR7M9nla12OXEKuaJgOD+r2NgyfX0jqq/7rulAnc/3zWTniA
         EMAg==
X-Gm-Message-State: AO0yUKU1Cse0Fj9Iw6GJARl07/VU77JHHEFGNzgfyRzdLrjdJQHDZUA1
        ibLUTK5aexR/OkRkN0y9Dxfwfw==
X-Google-Smtp-Source: AK7set8RywwJjUsXHxcla4nZoFxtGhrqCjIKnFCmuP2n+AzhTmEkkrnNyLjn4u75+PR+ezJZq/UB3w==
X-Received: by 2002:a17:906:9bec:b0:8b2:fa6d:45e6 with SMTP id de44-20020a1709069bec00b008b2fa6d45e6mr11552300ejc.2.1676922447830;
        Mon, 20 Feb 2023 11:47:27 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b008c405ebc32esm3249911eju.28.2023.02.20.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:47:27 -0800 (PST)
Date:   Mon, 20 Feb 2023 20:47:26 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 15/21] clocksource/timer-riscv: Refactor
 riscv_timer_init_dt()
Message-ID: <20230220194726.meppdac4y7qdjsoj@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-16-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-16-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:37PM +0530, Sunil V L wrote:
> Refactor the timer init function such that few things can be
> shared by both DT and ACPI based platforms.
> 
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/clocksource/timer-riscv.c | 82 +++++++++++++++----------------
>  1 file changed, 40 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 1b4b36df5484..2ae8e300d303 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -119,61 +119,28 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int __init riscv_timer_init_dt(struct device_node *n)
> +static int __init riscv_timer_init_common(void)
>  {
> -	int cpuid, error;
> -	unsigned long hartid;
> -	struct device_node *child;
> -	struct irq_domain *domain;
> +	int error;
> +	struct irq_domain *domain = NULL;

domain is always assigned below, so we don't need to set it NULL here.

> +	struct fwnode_handle *intc_fwnode = riscv_get_intc_hwnode();
>  
> -	error = riscv_of_processor_hartid(n, &hartid);
> -	if (error < 0) {
> -		pr_warn("Not valid hartid for node [%pOF] error = [%lu]\n",
> -			n, hartid);
> -		return error;
> -	}
> -
> -	cpuid = riscv_hartid_to_cpuid(hartid);
> -	if (cpuid < 0) {
> -		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
> -		return cpuid;
> -	}
> -
> -	if (cpuid != smp_processor_id())
> -		return 0;
> -
> -	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
> -	if (child) {
> -		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
> -					"riscv,timer-cannot-wake-cpu");
> -		of_node_put(child);
> -	}
> -
> -	domain = NULL;
> -	child = of_get_compatible_child(n, "riscv,cpu-intc");
> -	if (!child) {
> -		pr_err("Failed to find INTC node [%pOF]\n", n);
> -		return -ENODEV;
> -	}
> -	domain = irq_find_host(child);
> -	of_node_put(child);
> +	domain = irq_find_matching_fwnode(intc_fwnode, DOMAIN_BUS_ANY);
>  	if (!domain) {
> -		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
> +		pr_err("Failed to find irq_domain for INTC node [%pfwP]\n",
> +		       intc_fwnode);
>  		return -ENODEV;
>  	}
>  
>  	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
>  	if (!riscv_clock_event_irq) {
> -		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
> +		pr_err("Failed to map timer interrupt for node [%pfwP]\n", intc_fwnode);
>  		return -ENODEV;
>  	}
>  
> -	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
> -	       __func__, cpuid, hartid);
>  	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>  	if (error) {
> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> -		       error, cpuid);
> +		pr_err("RISCV timer registration failed [%d]\n", error);
>  		return error;
>  	}
>  
> @@ -202,4 +169,35 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	return error;
>  }
>  
> +static int __init riscv_timer_init_dt(struct device_node *n)
> +{
> +	int cpuid, error;
> +	unsigned long hartid;
> +	struct device_node *child;
> +
> +	error = riscv_of_processor_hartid(n, &hartid);
> +	if (error < 0) {
> +		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n",
> +			n, hartid);
> +		return error;
> +	}
> +
> +	cpuid = riscv_hartid_to_cpuid(hartid);
> +	if (cpuid < 0) {
> +		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
> +		return cpuid;
> +	}
> +
> +	if (cpuid != smp_processor_id())
> +		return 0;
> +
> +	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
> +	if (child) {
> +		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
> +					"riscv,timer-cannot-wake-cpu");
> +		of_node_put(child);
> +	}

need blank line here

> +	return riscv_timer_init_common();
> +}
> +
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
