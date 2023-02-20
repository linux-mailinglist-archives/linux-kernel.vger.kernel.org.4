Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA269D1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBTRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBTRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:08:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E09E3B6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:08:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g1so7056904edz.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIl3tZRjQudwGcAPjHCVTUjKcZHKk0uk+iVNDZ3xrIk=;
        b=gEaMH7e5pBRP9t31EL3LXw5WzCF3qikFsCxVhgrTQ1hq8KMmK8BQi+B1vq0Gdt6TPj
         QsI9OvmfxfIYinS6BmqbsvwVYCdEOm1K32TDFpY5IbFcHg0ABxbafcx/7a16stzydHMn
         oVNBrw786Atvq29/FVYTBZWRgPLBOhs3RnZxweXK8blQNKDKcF5VFAZ6qMl8M8XhQaLy
         6WZoiwaf+q5flcqVO7ottyVCThfo/EYKjJKOmZmbK2uex+60YRVwrz/vVsmAI7WrpqhO
         qhAk7jm+cbklp/uJ98LUY7Bvw15iiBPTAR2Zd9VXem2DHpIJgNq9BxchEg6YAL41YYgI
         Jxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIl3tZRjQudwGcAPjHCVTUjKcZHKk0uk+iVNDZ3xrIk=;
        b=zFuDQUqUbyEwlRjFJDe1guadOlchxteZstse2LbWh4yZzT0WD6tzJcwRdpQc6NyKhN
         9HySfFB4mj93DAR2c3TMjP0BRETdj/MtZz74ROHlmeKq2PBHGVRdzlobUSnXaq9EtPcR
         Kv9jUQz++i/b8mx6sqwhcfqAWnpQ/9Npf+/nj6PKJZQ7h6sJLPCw4AVr+wah0HsO1YTn
         7j4r/ZoUmOlfrSllhSEgtfnIbKQNY/kclZDms163n8cnpKb2V6NpxmyRh0+BlKx/vgpA
         nWBfDeiesrbzbjkqiBx9WTXn4WLeAP26vgBMneGBOK1OmI1PqWnu+JGCDiUTpbtjDrmu
         CO/w==
X-Gm-Message-State: AO0yUKV78hHHCkR4OLywa484Yy3ug/ZOKBuooCLAVtyyh/i+d7rFabtl
        GQdP9JWUZsFPS6habLbxyR5Mew==
X-Google-Smtp-Source: AK7set+RR6G+X/nFYBCntzbSKel+s1z5JB0JKEsUDVyhG3rLlenMH2XA+o4bF+Lq87hNDUVBPK0fNA==
X-Received: by 2002:a17:907:9b09:b0:8aa:c035:a651 with SMTP id kn9-20020a1709079b0900b008aac035a651mr11661476ejc.37.1676912924944;
        Mon, 20 Feb 2023 09:08:44 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906539700b008b128106fc7sm6029367ejo.46.2023.02.20.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:08:44 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:08:43 +0100
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
Subject: Re: [PATCH V2 10/21] RISC-V: smpboot: Add ACPI support in smp_setup()
Message-ID: <20230220170843.2zkrqcnqcwbruea6@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-11-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-11-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:32PM +0530, Sunil V L wrote:
> Enable SMP boot on ACPI based platforms by using the RINTC
> structures in the MADT table.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/acpi.h |  7 ++++
>  arch/riscv/kernel/smpboot.c   | 70 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 7bc49f65c86b..3c3a8ac3b37a 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -60,6 +60,13 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  
>  int acpi_get_riscv_isa(struct acpi_table_header *table,
>  		       unsigned int cpu, const char **isa);
> +
> +#ifdef CONFIG_ACPI_NUMA
> +int acpi_numa_get_nid(unsigned int cpu);
> +#else
> +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> +#endif /* CONFIG_ACPI_NUMA */

The #ifdef stuff seems premature since we're not providing an
implementation for acpi_numa_get_nid() or selecting ACPI_NUMA, but OK.

> +
>  #else
>  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
>  				     unsigned int cpu, const char **isa)
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 26214ddefaa4..77630f8ed12b 100644
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
> @@ -70,6 +71,70 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> +#ifdef CONFIG_ACPI
> +static unsigned int cpu_count = 1;
> +
> +static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
> +{
> +	unsigned long hart;
> +	bool found_boot_cpu = false;

I guess found_boot_cpu should be static?

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
> +	hart = processor->hart_id;
> +	if (hart < 0)
> +		return 0;

A valid hart ID is anything up to INVALID_HARTID, right? Shouldn't we only
be checking for INVALID_HARTID here? And what does it mean to have an
invalid hart ID here? It's not an issue to error/warn about?

> +	if (hart == cpuid_to_hartid_map(0)) {
> +		BUG_ON(found_boot_cpu);

Do we really want to BUG due to bad, but potentially bootable ACPI tables?
I'd BUG for things that can only happen when we break the code, but broken
ACPI tables might be something we want to complain loudly about and then
attempt to limp along.

> +		found_boot_cpu = true;
> +		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
> +		return 0;
> +	}
> +
> +	if (cpu_count >= NR_CPUS) {
> +		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
> +			cpu_count, hart);

cpuid isn't invalid, NR_CPUS is too small for the number of ACPI tables.

> +		return 0;
> +	}
> +
> +	cpuid_to_hartid_map(cpu_count) = hart;
> +	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
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
> +	/*
> +	 * do a walk of MADT to determine how many CPUs
> +	 * we have including disabled CPUs, and get information
> +	 * we need for SMP init.
> +	 */

I know this comment comes verbatim from arm64, but not only does it
have grammar issues, I'm not sure it's accurate. Where is the count
of disabled CPUs for arm64 or riscv?

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
> @@ -118,7 +183,10 @@ static void __init of_parse_and_init_cpus(void)
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

Do we not want to add an entry to acpi_table_print_madt_entry() for RINTC?

Thanks,
drew
