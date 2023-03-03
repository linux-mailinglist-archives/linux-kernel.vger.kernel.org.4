Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE26A9B73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCCQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCCQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:16:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E023128
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:16:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so12462276edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29lhwYiW98gSQjktyysEqQtqN3RT8BV1yMsZ6bnD5sI=;
        b=eSUDPW5xP/wrxbkAQZCoPLxpc0K1OMCa9agV1Wm10ELQIvysYEiVgYsOvmhXNOG5mM
         9ny/FmnBEGvCx2Y6zzysd/kC2b3/r8cRXNYKJ1DnyLdwe5I16cUQDYnsspWM0GWlOFCX
         qam18Hk4eI0Jn1Zsfan4YqLmAYElEMNFSl/6/Q5GW5EgmX8flCQV8tkG/fpF0DFpPTBl
         E4sD4NhZt3AVhUYf4gerQKt67ehCL0+Z/psyWyJycFft9VScKfjLrCWNVJHMIGEmvZtK
         tyvaQfY6Iv0R9scgm3mXheT5szkT7P1vRpCIQYWqFvolQ6oTCHLA57VKGz0nutMu8+ch
         VWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29lhwYiW98gSQjktyysEqQtqN3RT8BV1yMsZ6bnD5sI=;
        b=i0Vqw6Pu/8BNMiF4H7ZCyjq0O+BaZFAERMaGcd41AWXt8exABdHqb2Lw73VGlD1QoO
         tY+W+otGRz9LA+yy9mymMb91n1s3+c2xei7aFKBDdCfWpJSiQEAWrpkOGTfNdN8W36PG
         ACE8BdiQIaQIgdsKzbNbH/0/udRuZYEmI0irqaY1hSE8CO7PBTvqXhhC1dhYZMgeHLsp
         4+lfemLFJC3funEuJW2+rbd0IyVooo4MjKbkxauSGEGvfhq3X76z0cgiHSuiwJpFLzFK
         vlJMCVW2VTi1aZylNLiPIFMbdyrxpdAT/pDG2mdvDuZ07NPPwL4rqvCEqzVfkubwzLi1
         Bk4Q==
X-Gm-Message-State: AO0yUKVN2c0ZLC1p45dNiAJlbepF5RyMxW5xWuz5wgioBdkc52D04n72
        g6x4qjU6cfEKilXU761SOYT4XvmRbmSxubuC
X-Google-Smtp-Source: AK7set+6XDP/s9CIHVzW8AetHwFP9jbTQ+AvZLr8/rl3luYfPyfzQuWgTqOO4r/yk8Zqgfvc3nCasw==
X-Received: by 2002:a17:907:8c09:b0:88a:888b:c8b with SMTP id ta9-20020a1709078c0900b0088a888b0c8bmr2512107ejc.35.1677860208550;
        Fri, 03 Mar 2023 08:16:48 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ga2-20020a170906b84200b00882f9130eafsm1107033ejb.26.2023.03.03.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:16:48 -0800 (PST)
Date:   Fri, 3 Mar 2023 17:16:47 +0100
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
Subject: Re: [PATCH V3 12/20] RISC-V: cpufeature: Add ACPI support in
 riscv_fill_hwcap()
Message-ID: <20230303161647.mksonnutzaw4d3gb@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-13-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:39PM +0530, Sunil V L wrote:
> On ACPI based systems, the information about the hart
> like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
> Enable filling up hwcap structure based on the information in RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 59d58ee0f68d..478dbf129922 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/ctype.h>
>  #include <linux/libfdt.h>
> @@ -13,6 +14,8 @@
>  #include <linux/memory.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <asm/acpi.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/errata_list.h>
> @@ -91,7 +94,9 @@ void __init riscv_fill_hwcap(void)
>  	char print_str[NUM_ALPHA_EXTS + 1];
>  	int i, j, rc;
>  	unsigned long isa2hwcap[26] = {0};
> -	unsigned long hartid;
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
> +	unsigned int cpu;
>  
>  	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
> @@ -104,18 +109,33 @@ void __init riscv_fill_hwcap(void)
>  
>  	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
>  
> -	for_each_of_cpu_node(node) {
> +	if (!acpi_disabled) {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
>  		unsigned long this_hwcap = 0;
>  		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>  		const char *temp;
>  
> -		rc = riscv_of_processor_hartid(node, &hartid);
> -		if (rc < 0)
> -			continue;

The above is an unrelated cleanup and should be in a separate patch.

> -
> -		if (of_property_read_string(node, "riscv,isa", &isa)) {
> -			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> -			continue;
> +		if (acpi_disabled) {
> +			node = of_cpu_device_node_get(cpu);
> +			if (node) {
> +				rc = of_property_read_string(node, "riscv,isa", &isa);
> +				of_node_put(node);
> +				if (rc) {
> +					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +					continue;
> +				}
> +			}
> +		} else {
> +			rc = acpi_get_riscv_isa(rhct, get_acpi_id_for_cpu(cpu), &isa);
> +			if (rc < 0) {
> +				pr_warn("Unable to get ISA for the hart - %d\n", cpu);
> +				continue;
> +			}
>  		}
>  
>  		temp = isa;
> @@ -248,6 +268,9 @@ void __init riscv_fill_hwcap(void)
>  			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>  	}
>  
> +	if (!acpi_disabled && rhct)
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +
>  	/* We don't support systems with F but without D, so mask those out
>  	 * here. */
>  	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
