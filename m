Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF4638AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKYNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKYNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:13:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DD24BC4;
        Fri, 25 Nov 2022 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669382013; x=1700918013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=URMsbJgze28ts7TAuGW6Vykuoh3mCPWkBvj7qVYKBE0=;
  b=bhhCyZ8Zl4P4P7XWhCP8RpLj+DZsntsZqN4OwaUH9S/BHjhxwyKUT18R
   GBiAsoxPE4SarPb/EOER+gzymkAA75Rw13y9n91uTMBxXl4NrHqM58hTa
   MrHXTD7HZMlhw6FqliPyPwBEutxveqBPdpuED4czqoCFUp3x2lPU2V8mY
   MmDw+5jl913eAPs92mff9d+0/SUzcTpiLwhpJXuM/az/GDaedG/TuWBfA
   MzwOab5wd4+7oqDz+Xxl5q2zsSe3iv7eNZb5v35UMQFT/sPixBQQAOXNq
   z4EXccgzABPpKD+lFnB/E1kmKvrgchzu5RlyVtlj7+klT9+r0fKRfieep
   A==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="188664077"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:13:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:13:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 06:13:22 -0700
Date:   Fri, 25 Nov 2022 13:13:04 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <Y4C/YOoHxX5dxwG3@wendy>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
 <20221125112105.427045-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221125112105.427045-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 04:51:05PM +0530, Anup Patel wrote:
> We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> when riscv,timer-cant-wake-up DT property is present in the RISC-V
> timer DT node.
> 
> This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> based on RISC-V platform capabilities rather than having it set for
> all RISC-V platforms.

I need to go do some testing on what setting the C3STOP flag does on
platforms other than PolarFire SoC. I'm not sure that we should be
enabling this flag *at all* until we know that it does not break on
other platforms too.

Hopefully I'll get to it tonight or tomorrow..

> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index a0d66fabf073..0c8bdd168a45 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -28,6 +28,7 @@
>  #include <asm/timex.h>
>  
>  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> +static bool riscv_timer_cant_wake_cpu;
>  
>  static int riscv_clock_next_event(unsigned long delta,
>  		struct clock_event_device *ce)
> @@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  
>  	ce->cpumask = cpumask_of(cpu);
>  	ce->irq = riscv_clock_event_irq;
> +	if (riscv_timer_cant_wake_cpu)
> +		ce->features |= CLOCK_EVT_FEAT_C3STOP;
>  	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>  
>  	enable_percpu_irq(riscv_clock_event_irq,
> @@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	if (cpuid != smp_processor_id())
>  		return 0;
>  
> +	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
> +	if (child) {
> +		riscv_timer_cant_wake_cpu = of_property_read_bool(child,
> +						"riscv,timer-cant-wake-cpu");
> +		of_node_put(child);
> +	}
> +
>  	domain = NULL;
>  	child = of_get_compatible_child(n, "riscv,cpu-intc");
>  	if (!child) {
> -- 
> 2.34.1
> 
