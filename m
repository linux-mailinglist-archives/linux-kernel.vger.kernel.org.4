Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966416A9B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCCPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjCCPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:49:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA415B775
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:49:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o15so11878175edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+5JbfjZ8Aa/Wy9sFT0uYrAvKsrB7pVmzzINwbowStU=;
        b=BdAa7enZ9MgSZLdVOPUP7KtdM25yTv5Gt4+UmTEGXb7tjay5ZxpdRRJ5ETYRoBsFni
         sYRzYsTu7lRj8u1pbH/PIRnyjrBqHsOm4hnYswNP0thheg/2KeuBGaM1mFOaA3VuEA7s
         /hHlOlrHosFopTpSNTUPWO9kpAsHtEjlUEVgG6aGnoT280yjnwWVjQx5RKnoBSt+Tc51
         jckjfynl8Uk+9ziSywgoXzTKVfuZPeuTcvBJNcuroVDn8E89+pxP46ZuJje4tWSaJ7IT
         7uG7+keqhI47E+fSZiRZxmqIDOfrPvU2GdGqwgoF4bGDFTB6JP1zWKoQTClbRT/c/TE5
         BQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+5JbfjZ8Aa/Wy9sFT0uYrAvKsrB7pVmzzINwbowStU=;
        b=PE/bZmlqDqZAhsBvQL9LJhFL4giHvC8Evu8BmbrPt6wK4J0YR3K7ziWUA4BCyYK51m
         iIcmlQqj51paESxzwhPs5EfvX+I6Qg8SnL1CO3F0D7MWyUQ7UAczR+afLbuRX4MD0BWk
         3nDhaXKWy+0ZqI6jcpmQaiam+EtDMPaxMbJlnoabWTCHjdSyhdKyZm7kNNIX8B+pAJAd
         cdHrEUK5al1lcsbfuH5L5aP4KgmbEV/6jtC8vXmXmnFzmpuVxLZtQXCqs9g06t71tsGS
         YEYRcbSWghFddp3/2C5Qwz3Q8VBmwpo10UfPABWbu8LJKLg7+FHQIJAyZWcyQXS/8xJ3
         v3rA==
X-Gm-Message-State: AO0yUKX5dl1fOnIMMkWeurKQpCyhsB9fobDdsoJ+MyMopavHHSjA9Yr2
        2++2vMXYNvPx3Scqv3pO1BjoAQ==
X-Google-Smtp-Source: AK7set+zOpC3DQ8WQaz+jDiXR0tvMLVKI1MlDuFlw/L+S82YrzsxNoEXEDmTRZn0PNz1SmwhvAcsNg==
X-Received: by 2002:a17:907:d109:b0:878:78f9:d1be with SMTP id uy9-20020a170907d10900b0087878f9d1bemr1957250ejc.23.1677858562207;
        Fri, 03 Mar 2023 07:49:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906164d00b008deba75e89csm1080779ejd.66.2023.03.03.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:49:21 -0800 (PST)
Date:   Fri, 3 Mar 2023 16:49:20 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 10/20] RISC-V: smpboot: Add ACPI support in smp_setup()
Message-ID: <20230303154920.dq65hkcivpv7zyev@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-11-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-11-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:37PM +0530, Sunil V L wrote:
> Enable SMP boot on ACPI based platforms by using the RINTC
> structures in the MADT table.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/smpboot.c | 72 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 26214ddefaa4..27047322d3bb 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/arch_topology.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -70,6 +71,72 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> +#ifdef CONFIG_ACPI
> +static unsigned int cpu_count = 1;
> +
> +static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
> +{
> +	unsigned long hart;
> +	static bool found_boot_cpu;
> +	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
> +
> +	/*
> +	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
> +	 * bit in the flag is not enabled, it means OS should not try to enable
> +	 * the cpu to which RINTC belongs.
> +	 */
> +	if (!(processor->flags & ACPI_MADT_ENABLED))
> +		return 0;
> +
> +	if (BAD_MADT_ENTRY(processor, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(&header->common);
> +
> +	hart = processor->hart_id;
> +	if (hart == INVALID_HARTID) {
> +		pr_warn("Invalid hartid\n");
> +		return 0;
> +	}
> +
> +	if (hart == cpuid_to_hartid_map(0)) {
> +		BUG_ON(found_boot_cpu);
> +		found_boot_cpu = true;
> +		early_map_cpu_to_node(0, NUMA_NO_NODE);

We should have kept

 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }

and only dropped the

 #ifdef CONFIG_ACPI_NUMA
 int acpi_numa_get_nid(unsigned int cpu);
 #else
 ...
 #endif

> +		return 0;
> +	}
> +
> +	if (cpu_count >= NR_CPUS) {
> +		pr_warn("NR_CPUS is too small for the number of ACPI tables.\n");
> +		return 0;
> +	}
> +
> +	cpuid_to_hartid_map(cpu_count) = hart;
> +	early_map_cpu_to_node(cpu_count, NUMA_NO_NODE);
> +	cpu_count++;
> +
> +	return 0;
> +}
> +
> +static void __init acpi_parse_and_init_cpus(void)
> +{
> +	int cpuid;
> +
> +	cpu_set_ops(0);
> +
> +	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_rintc, 0);
> +
> +	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
> +		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
> +			cpu_set_ops(cpuid);
> +			set_cpu_possible(cpuid, true);
> +		}
> +	}
> +}
> +#else
> +#define acpi_parse_and_init_cpus(...)	do { } while (0)
> +#endif
> +
>  static void __init of_parse_and_init_cpus(void)
>  {
>  	struct device_node *dn;
> @@ -118,7 +185,10 @@ static void __init of_parse_and_init_cpus(void)
>  
>  void __init setup_smp(void)
>  {
> -	of_parse_and_init_cpus();
> +	if (acpi_disabled)
> +		of_parse_and_init_cpus();
> +	else
> +		acpi_parse_and_init_cpus();
>  }
>  
>  static int start_secondary_cpu(int cpu, struct task_struct *tidle)
> -- 
> 2.34.1
>

Thanks,
drew
