Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C369D461
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBTT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:58:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F583C33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:58:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id da10so10075943edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrugdTKLSDJwHyjHjZ36D6OjjlvSRka7EpHAWIsGDzo=;
        b=QaGObWgZc1ovML+WcKgHPHYayMiw6l/d2CRjtcpbEfbU3WzgAUnE4PghRbQkWPZhCM
         zwvEurQW6YHEL0FCkn1CpJ/jj07Q7eCNa2YSgg2pNjmh1pUnHpCvuSLK4yNijpFaMbai
         S9ywBG5R312pa2XZa5Adqa3J6Xiy7bPUob7HuIpdMWP3ypMtipsbdPlKgAZt8tD7ptC/
         sXTBjXSLuLZ4r1SgkbOEfaerw/Q2YoI9/b1B+pF2ossbynGyGeeUQZ2qmW7Dyte/MIot
         GB3kDCmOuDoVE9cgd1xswfqkNi+BohvzTeeyvrM503kxOUlhoyn6eCkJClNVWs5fFc2A
         /klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrugdTKLSDJwHyjHjZ36D6OjjlvSRka7EpHAWIsGDzo=;
        b=KAXjuBpOYrBKMB10d5JoL9Cd1MfELwPGSaY2MjVhvq8qD97RP+c0IdOqWijNzm8i9k
         Wnn3ejtgao+D6Wz7fSZH8xmjr19/3OJM4e1LI9ClcRrxY8v6zX/A5C3z4w/NRtet4Cdm
         4puj8WL1HzRj3nzuRQn/xoyc5cv7aZaI+b55PxAMwu3iQ9ool2KHn6BhPY9SaGA+FVyn
         QiOnlEZHsX8s5PsIfJLf1hDrcsbXVDOr83GXngz1o/qqUbmUe2DSXgUUo2F1Hqf1f9Uq
         fpJGgW4BLSC4Iv0hplnmHVsyP7qqbOPYHFFaC5LANbKbfcQupP76rzZQPI/dJwMUrsgb
         k7hA==
X-Gm-Message-State: AO0yUKV8J4HmCSRIJ6U8ub5Z7UrR76u9T0VH6DLJ1LIFcjJfumXYhBct
        c+WoHFnSdVPwIFNd5o+AB+aWUA==
X-Google-Smtp-Source: AK7set//9YBqcSpXyQvjERLB7zb/V6CJ6RVjsiEoNC5DrECGp5WFq8Wo5HkcHQI2vOoive6rCOJFHQ==
X-Received: by 2002:a17:907:3e87:b0:8af:4969:1bb4 with SMTP id hs7-20020a1709073e8700b008af49691bb4mr13130826ejc.53.1676923090092;
        Mon, 20 Feb 2023 11:58:10 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906b19300b008ddf3476c75sm131906ejy.92.2023.02.20.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:58:09 -0800 (PST)
Date:   Mon, 20 Feb 2023 20:58:08 +0100
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
Subject: Re: [PATCH V2 17/21] RISC-V: time.c: Add ACPI support for time_init()
Message-ID: <20230220195808.reyuclvefujucpsq@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-18-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-18-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:39PM +0530, Sunil V L wrote:
> On ACPI based platforms, timer related information is
> available in RHCT. Add ACPI based probe support to the
> timer initialization.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/time.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 1cf21db4fcc7..e49b897fc657 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/of_clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/clocksource.h>
> @@ -18,17 +19,29 @@ EXPORT_SYMBOL_GPL(riscv_timebase);
>  void __init time_init(void)
>  {
>  	struct device_node *cpu;
> +	struct acpi_table_rhct *rhct;
> +	acpi_status status;
>  	u32 prop;
>  
> -	cpu = of_find_node_by_path("/cpus");
> -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> -	of_node_put(cpu);
> -	riscv_timebase = prop;
> +	if (acpi_disabled) {
> +		cpu = of_find_node_by_path("/cpus");
> +		if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> +			panic("RISC-V system with no 'timebase-frequency' in DTS\n");
> +		of_node_put(cpu);
> +		riscv_timebase = prop;
> +	} else {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, (struct acpi_table_header **)&rhct);
> +		if (ACPI_FAILURE(status))
> +			panic("RISC-V ACPI system with no RHCT table\n");
> +		riscv_timebase = rhct->time_base_freq;
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +	}
>  
>  	lpj_fine = riscv_timebase / HZ;
>  
> -	of_clk_init(NULL);
> +	if (acpi_disabled)
> +		of_clk_init(NULL);

I think we should be able to move of_clk_init() up into the acpi_disabled
arm rather than add another if here.

> +
>  	timer_probe();
>  
>  	tick_setup_hrtimer_broadcast();
> -- 
> 2.34.1
> 

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
