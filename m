Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F26A9B81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCCQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCCQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:18:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8362166FB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:18:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u9so12497397edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFUF1lBawdy3HQTMvToE8tlc5+s1Z78NHFKh5Xpfejo=;
        b=dmxu/HtmCT/N/FbMcM0CxEtxN8TIOUKS/d6g5Fw6aH5SNapP6ZtIwiTmzTYiyqwCHF
         v28/pdBIm8n8TT63ky2K23Esq4AmQbUQ1eJsMJtUUO7OvYQlqP26dP23XVQ5snpjCKT1
         H/0eH8d0MDugpkwJQzpYeGa5iHJ0ulHki/9MSIiUUAZ82qfhOqJ+GxDmA/3wHAAlfFxf
         zDVfMz9bR3P/79vrN1umXds3o3Mj+5MTVfmyBwZeoIdWJvRRPOe48lnrDKJrFP44NpXg
         ceuMMXKg6iVA+kreLoZ1SaiXLk7OvDB8vYcRfTeDAqukj0Ac6jkIzGN9aCKkcinCdjaQ
         pFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFUF1lBawdy3HQTMvToE8tlc5+s1Z78NHFKh5Xpfejo=;
        b=1oBk2DaRjFznspTyA7JFNGGRK1OiKZhbEMnuaFpMrSNePZT3xNJcQBKxszKWsVBFaL
         yleZdS5lBw2Dptu08cIZDwfCjB30tugZdRhQ8a41WFEYN9Kw61GSVzcAi4FfWunA3h7g
         wvViv7sxiByEJupk2065MKGkAkZyp5H2/BE/CZzfz+17/3JrxHKmpoFsZ8QQk8lAO/hI
         sVDZl1kDmnPRltM+qprXYi2ObMosoWCFZVNU2+etH5lvwz+21gk0BGCoiJ8FKgN4l+nr
         J0BmKnucz/+e5rPABRIADWGCucsRGR1uq5bp3fQ9/c8NChR7Bkle8LGOMlB0lW5lqC5I
         poIA==
X-Gm-Message-State: AO0yUKXf492Im0+qcGA9DIvjT9dPDXaj7AMibmjK1OlET4rVrFewVQ1M
        RT997Xz4GILMYsmjdHONGkEQIA==
X-Google-Smtp-Source: AK7set9KFbKWbHzMH5IwdN7fAabZAjcAVpz6yuy3G52zPbL1ze7nJgA7ll7IYlauO19cTFJaipxlnQ==
X-Received: by 2002:aa7:d88c:0:b0:4ab:4c36:463c with SMTP id u12-20020aa7d88c000000b004ab4c36463cmr2491680edq.16.1677860327018;
        Fri, 03 Mar 2023 08:18:47 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id si9-20020a170906cec900b008c5075f5331sm1083378ejb.165.2023.03.03.08.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:18:46 -0800 (PST)
Date:   Fri, 3 Mar 2023 17:18:45 +0100
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
Subject: Re: [PATCH V3 13/20] RISC-V: cpu: Enable cpuinfo for ACPI systems
Message-ID: <20230303161845.rzx2bxmvcij5vrzr@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-14-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-14-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:40PM +0530, Sunil V L wrote:
> On ACPI based platforms, few details like ISA need to be read
> from the ACPI table. Enable cpuinfo on ACPI based systems.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/cpu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 8400f0cc9704..80101bf77dab 100644
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
> @@ -283,23 +285,32 @@ static void c_stop(struct seq_file *m, void *v)
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
> -	print_mmu(m);
> -	if (!of_property_read_string(node, "compatible", &compat)
> -	    && strcmp(compat, "riscv"))
> -		seq_printf(m, "uarch\t\t: %s\n", compat);
> +
> +	if (acpi_disabled) {
> +		node = of_get_cpu_node(cpu_id, NULL);
> +		if (!of_property_read_string(node, "riscv,isa", &isa))
> +			print_isa(m, isa);
> +		print_mmu(m);
> +		if (!of_property_read_string(node, "compatible", &compat) &&
> +		    strcmp(compat, "riscv"))
> +			seq_printf(m, "uarch\t\t: %s\n", compat);
> +		of_node_put(node);
> +	} else {
> +		if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu_id), &isa))
> +			print_isa(m, isa);
> +		print_mmu(m);
> +	}
> +
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
