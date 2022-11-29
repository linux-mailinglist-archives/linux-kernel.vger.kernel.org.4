Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884463C2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiK2Ogx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiK2Ogu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:36:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64BC3AF;
        Tue, 29 Nov 2022 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669732608; x=1701268608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joBDR/6R/yQ5IZXkVvlgcx/puPOD9ZA3pVYvhslPmAU=;
  b=BuSBcgVouqWF9EduZ6uA8/Pt7Cos6pQ3VYC/Q+vGV+OigBClAVySQ4fi
   w7lOnKWSOTEKJPeYSaO2f1/PegdQxEnAWVwus/38/ZbmbphG5298UekSm
   jKHO49AyIsQuTqzWEVfNc6X+oXcBT1jysfOPl9pN4xgtn7PRMy/LzfbOG
   HSirkf/ZcrkXJKuwQM4tQfZPiDRymRqqn8WmC920BNtNSGajwE/uvkCsd
   ilia0x2TsRHs+3brC4pAWfzZYxwjx4Woh0RoxfuwTBH8EFdMA80VONZsS
   2MNBzr4nFl9G2rB0rqOKX85XyR/4x51z8LtwFUfMfw+XotB43JWkvTWCj
   A==;
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="189175751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2022 07:36:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 29 Nov 2022 07:36:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 29 Nov 2022 07:36:45 -0700
Date:   Tue, 29 Nov 2022 14:36:26 +0000
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
Subject: Re: [PATCH v4 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <Y4YY6kBBEBdZoUIp@wendy>
References: <20221129140313.886192-1-apatel@ventanamicro.com>
 <20221129140313.886192-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221129140313.886192-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 07:33:13PM +0530, Anup Patel wrote:
> We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> when riscv,timer-cant-wake-up DT property is present in the RISC-V
> timer DT node.
> 
> This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> based on RISC-V platform capabilities rather than having it set for
> all RISC-V platforms.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

I thought I had left an R-b on this one?
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Also, I think that we need to backport *something* that disables C3STOP
which is why I had suggested keeping the revert in place.
Patch 1 of this series only solves the timer issues but does not restore
sleep states to their prior behaviour, right?
Either this patch or the revert needs to go to stable IMO.

Thanks,
Conor.

> ---
>  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 969a552da8d2..0c8bdd168a45 100644
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
> @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
>  	.rating			= 100,
>  	.set_next_event		= riscv_clock_next_event,
>  };
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
