Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6D69D249
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjBTRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBTRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:45:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16681EBF5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:45:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x10so6880052edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OomCsAtjgTUhc5/uWu5S1Dwt7IqLJYnfNUapR4lMKM=;
        b=kjf/oxvGkbMEKzaGNdrHdbeiWoXva4Pk5nCrklsjeuHj2z4wb3/4uov8DAo/4LnUXy
         TFkwKE4iJ96MsNjP9leIlb9A/gkA8q+YV571IN+BdM0KvkQ/upYwuRzTC9O2+TDaFrZJ
         Nu5GxPoRLn1X0dgr0Y5jZktIPW8bQuAsdaX6/2t1INkSD1yzGgwLNCPt5Wl7T+t7YYUO
         cwJIrq/WOe02m6B1RRQ/Y09nuRsrHRf8cn0LLszL5dLNC8XU0dfi8aYgquVIEQ70If+u
         I1YKAZw18wlqUGO2slNs3Ir6H7SpE9QSy5F1Po7mxufcYGnJyWdUnNEPHYYg17xuuQPh
         SrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OomCsAtjgTUhc5/uWu5S1Dwt7IqLJYnfNUapR4lMKM=;
        b=uWdwfRt7WRazsiPZSx8oCOW42s8ZmVMXUP5oyRitkHWL+GlTsGFyUB6uZ4VXCiH60S
         nModnVP7oaEDdXBB6oB6CMG7jpBjjcnXWm4KDhhg9Mps32hV/p+WvqrtbVFfSDXcRb1k
         GsbGyQyrr0C/hzIovMAg/UmPYkVzKx7PavU1nLYyONpFuLgbwKIlHHAr3UcaCiXhGaOy
         Nu976gf4ysAd61RNYiDSDOSEM4NZXo/OWbKm95hVzPgi1dhIHoZPAcXKR6x4WXjXW43p
         uMRQW7r9ZPDiNHj716cmGQsDWRPhHUxbMAPmhIXaI1OjQmdoDuM98BFvktUsenLP23Mj
         RVUw==
X-Gm-Message-State: AO0yUKVVEZ1WFqTfUPq8408yJeutj8YP92MK0Jrqp+BY91RWDm462fc2
        nTWd/gV2acnfQ0KMtKu2nltvZw==
X-Google-Smtp-Source: AK7set9OX61vxoMeLX0XmAo8W6cuM4l63PtlvtJ/WQaLpJZ8HMnk+OftyAWykxcf88wjgsFZyCTxkg==
X-Received: by 2002:a17:906:3e43:b0:88a:2e57:9813 with SMTP id t3-20020a1709063e4300b0088a2e579813mr9571118eji.33.1676915154314;
        Mon, 20 Feb 2023 09:45:54 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e20-20020a1709062c1400b008bbc9115038sm3671028ejh.56.2023.02.20.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:45:54 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:45:53 +0100
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
Subject: Re: [PATCH V2 12/21] RISC-V: cpufeature: Add ACPI support in
 riscv_fill_hwcap()
Message-ID: <20230220174553.pgd53ao5d7wsfrx7@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-13-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:34PM +0530, Sunil V L wrote:
> On ACPI based systems, the information about the hart
> like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
> Enable filling up hwcap structure based on the information in RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 93e45560af30..cb67d3fcbb56 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -6,12 +6,15 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/ctype.h>
>  #include <linux/libfdt.h>
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <asm/acpi.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/errata_list.h>
> @@ -93,7 +96,10 @@ void __init riscv_fill_hwcap(void)
>  	char print_str[NUM_ALPHA_EXTS + 1];
>  	int i, j, rc;
>  	unsigned long isa2hwcap[26] = {0};
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
>  	unsigned long hartid;
> +	unsigned int cpu;
>  
>  	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
> @@ -106,18 +112,36 @@ void __init riscv_fill_hwcap(void)
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
> +		if (acpi_disabled) {
> +			node = of_cpu_device_node_get(cpu);
> +			if (node) {
> +				rc = riscv_of_processor_hartid(node, &hartid);
> +				if (rc < 0)
> +					continue;

This 'continue' and the one below need of_node_put() calls. Or,
restructure to ensure that the one of_node_put() call added below
is always called.

>  
> -		if (of_property_read_string(node, "riscv,isa", &isa)) {
> -			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> -			continue;
> +				if (of_property_read_string(node, "riscv,isa", &isa)) {
> +					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +					continue;
> +				}
> +				of_node_put(node);
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
> @@ -248,6 +272,9 @@ void __init riscv_fill_hwcap(void)
>  			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>  	}
>  
> +	if (!acpi_disabled)
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +
>  	/* We don't support systems with F but without D, so mask those out
>  	 * here. */
>  	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> -- 
> 2.34.1
>

Thanks,
drew
