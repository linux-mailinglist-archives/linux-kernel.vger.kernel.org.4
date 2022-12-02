Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC763FC7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLBAGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiLBAGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:06:07 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4BC82E0;
        Thu,  1 Dec 2022 16:06:05 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1322d768ba7so4017693fac.5;
        Thu, 01 Dec 2022 16:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkJj63AQ5n6QH7dnwOSIpJeyXYTYjMm/XE9Let7JGVs=;
        b=zdlPZZ0HP3xMP1U9VIsNVgOvXAWVTvZzNgpu5e87nG064NvoJVuomC8Mt7umppjnJJ
         WHM5+HMNN5DvQrdo+/q4+VAe561mFVihZK0I+15izE1Ma8/xeFf1zG1ML38RA8wzzuH2
         kECybBNk6+qhrIV7xUofBemuCyCYfGnOb+Kh++QCbWXS092TDHlqafhwHgwxIDhVWRsf
         8yP3oeiqtgkz/zrLSk6GqD6p5vbhejGjZ7umNnHZFyBHIYNlysY1+K4t/IKVWlvVK2qt
         kOUMExfhjgBSCpJl3BzfsD9HlCwKpJ/xe0mSj8SYqNBVA10FWVXvTKuhPleHUV/O1smc
         +BzQ==
X-Gm-Message-State: ANoB5pmBemSUfMdUG2a/M6YYNKi9BHBeQd9vKzeoIhf7ahFlwfjR7VJV
        5mFBSB0z1VfHKKgwoR3hHQ==
X-Google-Smtp-Source: AA0mqf4VIEUj6jNd9sHSBBaDfI/rBkBpivN4B3re+ALowYnCuyPWtggrj0DPpMOsTfKLvOuiEY0RSQ==
X-Received: by 2002:a05:6871:4684:b0:141:c076:de4c with SMTP id ni4-20020a056871468400b00141c076de4cmr42017933oab.248.1669939564797;
        Thu, 01 Dec 2022 16:06:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 76-20020a9d0852000000b0066e3cebb7a7sm2681131oty.78.2022.12.01.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:06:04 -0800 (PST)
Received: (nullmailer pid 1730725 invoked by uid 1000);
        Fri, 02 Dec 2022 00:06:03 -0000
Date:   Thu, 1 Dec 2022 18:06:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v5 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <20221202000603.GA1720201-robh@kernel.org>
References: <20221201123954.1111603-1-apatel@ventanamicro.com>
 <20221201123954.1111603-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201123954.1111603-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 06:09:54PM +0530, Anup Patel wrote:
> We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> when riscv,timer-cannot-wake-cpu DT property is present in the RISC-V
> timer DT node.
> 
> This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> based on RISC-V platform capabilities rather than having it set for
> all RISC-V platforms.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 969a552da8d2..1b4b36df5484 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -28,6 +28,7 @@
>  #include <asm/timex.h>
>  
>  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> +static bool riscv_timer_cannot_wake_cpu;
>  
>  static int riscv_clock_next_event(unsigned long delta,
>  		struct clock_event_device *ce)
> @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,

A platform that depended on CLOCK_EVT_FEAT_C3STOP being set will break 
with this change because its existing DT will not have the new property.

It needs to be the other way around which would effectively be the 
existing 'always-on' property. 

>  	.rating			= 100,
>  	.set_next_event		= riscv_clock_next_event,
>  };
> @@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  
>  	ce->cpumask = cpumask_of(cpu);
>  	ce->irq = riscv_clock_event_irq;
> +	if (riscv_timer_cannot_wake_cpu)
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
> +		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
> +					"riscv,timer-cannot-wake-cpu");
> +		of_node_put(child);
> +	}
> +
>  	domain = NULL;
>  	child = of_get_compatible_child(n, "riscv,cpu-intc");
>  	if (!child) {
> -- 
> 2.34.1
> 
> 
