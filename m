Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C2E69D26A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjBTRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjBTRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:54:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5A20555
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:54:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so7964523edz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxVGzwL+4x3d9xJ01+WEs/SSEAgiQEFyyqTh9v+9xno=;
        b=EfMA0ETWjV96fNEC4CzFcupfrFJjDfHulIs6YlojxbS20dQfrNIna6iFxdhIddGqFN
         xwTGlwiFI4Zxn6sLWa3ttv8ecDYNj3j6mr59r/EzdgEOG5WfgyILX7l+d8CQ7/WRigF4
         TUfyWFFf3nB0pmQlnIChNZvWOlp/2eT4Yqh3IP/ZMUKabl94zPk9dw0Kgse75wTlhL98
         eijn6NLcGthMcxB4a3srFLN2eyiny5hJJTTaXFXfW7v+urnDrENTho/HgXLIaaUiihNY
         WcURuND807FTzSyxRxzpc2xvzG4ndLY1/lA8XHu3j54A0hL4tyojiUuyEh384iHdpJmF
         nlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxVGzwL+4x3d9xJ01+WEs/SSEAgiQEFyyqTh9v+9xno=;
        b=IiQgNWdBJ41RHgXJKl2uEXbPXXsb+QoweagRA1h11Scvtwx3oq9xmYJ+nUubt1W/0s
         mlPaj6wkhNivzfBab9/nXXOWJOGRO/C0Tbf4YV6XcnhPzd5kZT8cuae0JIbRQ7H/dt9g
         RdPh/5qT8LXqZLeaieVwgm+YNMo3Hn7p4jtF4SNOY9LSLmxibhogcsNtSENHky9LJETl
         5riRvqX7hm6TDkZuOz/nFWmNLHW/fMiSNkfbxGzlmTvofeeCID04e5jzyk5P+tqz5jX2
         Rlz/BJeg/edLCuRuDmRZ3CqJlStKmi2nWpTgAKR2HjtkdNwcvvXe651iFY366Dk/k0M9
         BMCw==
X-Gm-Message-State: AO0yUKVrszDNzZPUHOZdAEAYZogGYFsVAPavzK//jap5D2GHYWxRDRE2
        yMkyUUBdSPkI79u4ITUiB0AirA==
X-Google-Smtp-Source: AK7set9+seOO5w23B1b675NlE1L1sk3LefUXMHQbeTRgRc1BMWWM2yO+dRohFd2Tcef33VUGV0PBdQ==
X-Received: by 2002:a17:907:1686:b0:8af:2f5e:93e3 with SMTP id hc6-20020a170907168600b008af2f5e93e3mr7996390ejc.29.1676915671483;
        Mon, 20 Feb 2023 09:54:31 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ke27-20020a17090798fb00b008b12b9c6c49sm6041450ejc.125.2023.02.20.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:54:31 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:54:29 +0100
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
Subject: Re: [PATCH V2 13/21] RISC-V: cpu: Enable cpuinfo for ACPI systems
Message-ID: <20230220175429.dzojoryw2dhhbodl@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-14-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-14-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:35PM +0530, Sunil V L wrote:
> On ACPI based platforms, few details like ISA need to be read
> from the ACPI table. Enable cpuinfo on ACPI based systems.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/cpu.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1b9a5a66e55a..a227c0661b19 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -3,10 +3,12 @@
>   * Copyright (C) 2012 Regents of the University of California
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
> +#include <asm/acpi.h>
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/sbi.h>
> @@ -256,26 +258,41 @@ static void c_stop(struct seq_file *m, void *v)
>  {
>  }
>  
> +static void acpi_print_hart_info(struct seq_file *m, unsigned long cpu)
> +{
> +	const char *isa;
> +
> +	if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu), &isa))
> +		print_isa(m, isa);
> +}
> +
>  static int c_show(struct seq_file *m, void *v)
>  {
>  	unsigned long cpu_id = (unsigned long)v - 1;
> -	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
>  	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
> +	struct device_node *node;
>  	const char *compat, *isa;
>  
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	if (!of_property_read_string(node, "riscv,isa", &isa))
> -		print_isa(m, isa);
> +
> +	if (acpi_disabled) {
> +		node = of_get_cpu_node(cpu_id, NULL);
> +		if (!of_property_read_string(node, "riscv,isa", &isa))
> +			print_isa(m, isa);
> +		if (!of_property_read_string(node, "compatible", &compat) &&
> +		    strcmp(compat, "riscv"))
> +			seq_printf(m, "uarch\t\t: %s\n", compat);
> +		of_node_put(node);
> +	} else {
> +		acpi_print_hart_info(m, cpu_id);

I don't think we need the helper function for the two lines which would
otherwise nicely complement the two similar DT lines above.

> +	}
> +
>  	print_mmu(m);
> -	if (!of_property_read_string(node, "compatible", &compat)
> -	    && strcmp(compat, "riscv"))
> -		seq_printf(m, "uarch\t\t: %s\n", compat);

This will now print uarch before mmu for DT systems.

>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
>  	seq_puts(m, "\n");
> -	of_node_put(node);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
>

Thanks,
drew
