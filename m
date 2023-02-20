Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E574969D46E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjBTUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjBTUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:07:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342CC1EFC8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:07:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ec43so8425597edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w5X67HTfkILqEFlfX+HSJPjcXyLvpwqICue55s3QYSw=;
        b=ljlyerwG96LRAPYltgdfRgo4LNVCAqRoMZ2NyaaBblrOty1DurlpAMzrJO/D/rpIq+
         d0USN24Mzo/zGlck1ez3BHzoeZelgm2BUMkjGRaGCdwlxNA2rkK3fYo80oX3BrR18gQT
         R5ncLcuCAdj5TW9fk2g6LRw7SaA49rRVU5H90SplU6ckJt2nX7iNKdPrDkk7948l47ZY
         GaUYJCgV7COBQbzBssRFT4loF9aJ/nEC0OsGN3LGfwnfW33QYMsnmMnVTHI8E+6bnqHF
         E+PqBCAIIOoRotkNxnB0aBE40G9pHBug8lv4RWzdutV182W9oFPC9Bdya1PHgIBiYzI4
         HyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5X67HTfkILqEFlfX+HSJPjcXyLvpwqICue55s3QYSw=;
        b=TzSk4lTD8Je1/8Mt6TRlVei7n2tynbpraWgWt2k5Lm+g+MYCcd8cOXbvPTPX8GIFu6
         abd2vLahiUY1QwShLCoaAf4E2PqlTyLJ6ecvL2sq2+0+SxeHQnJ7kjKOD9m50gJhOoHC
         bcJmLPTCR+Tw+ZSAOk6T3XuBPRA63j630DzirntgPrPVhBd4OBEzArD5ZizrDq0MX3Aw
         VPTYkN8UbC/s7Tl7W3ClU7VXftztCul0dtShFvSPnURom/3o6I4liSwEg3jDJhcOd/wh
         eQkxByym04oOX6+q5J+mhVzZLsiBD06CDWLUXj2r8WHOiVBiaIoJEggRDoNE35vjJLCL
         P1VA==
X-Gm-Message-State: AO0yUKXQJITfWOZBuu1SViRtsY/lzLOW0+PYqqb83y1piHzEhvZk3nhv
        cL/aLQ02agV7qbZFsTBtn0s0Zw==
X-Google-Smtp-Source: AK7set9eZptDBkFAeqjmw/AtYlX3GnpO0T0d2EUlMjozAoScxvArhJpH8B/6tZhR2Uibhf3vdE2NXg==
X-Received: by 2002:a17:907:9543:b0:8b2:c2fc:178e with SMTP id ex3-20020a170907954300b008b2c2fc178emr9492092ejc.74.1676923664681;
        Mon, 20 Feb 2023 12:07:44 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id gz17-20020a170907a05100b00882f9130eb3sm6213593ejc.223.2023.02.20.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:07:44 -0800 (PST)
Date:   Mon, 20 Feb 2023 21:07:43 +0100
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
Subject: Re: [PATCH V2 18/21] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <20230220200743.rev3djzbaa2jcmg6@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-19-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-19-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:40PM +0530, Sunil V L wrote:
> Initialize the ACPI core for RISC-V during boot.
> 
> ACPI tables and interpreter are initialized based on
> the information passed from the firmware and the value of
> the kernel parameter 'acpi'.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/acpi.c  | 113 ++++++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c |  25 ++++++---
>  2 files changed, 130 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 13b26c87c136..35e7b24a30c8 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/pci.h>
> +#include <linux/efi.h>
>  
>  int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
> @@ -26,6 +27,118 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>  
>  static unsigned int intc_count;
>  static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> +static bool param_acpi_off __initdata;
> +static bool param_acpi_on __initdata;
> +static bool param_acpi_force __initdata;
> +
> +static int __init parse_acpi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	/* "acpi=off" disables both ACPI table parsing and interpreter */
> +	if (strcmp(arg, "off") == 0)
> +		param_acpi_off = true;
> +	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
> +		param_acpi_on = true;
> +	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
> +		param_acpi_force = true;
> +	else
> +		return -EINVAL;	/* Core will print when we return error */
> +
> +	return 0;
> +}
> +early_param("acpi", parse_acpi);
> +
> +/*
> + * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
> + *			      checks on it
> + *
> + * Return 0 on success,  <0 on failure
> + */
> +static int __init acpi_fadt_sanity_check(void)
> +{
> +	struct acpi_table_header *table;
> +	struct acpi_table_fadt *fadt;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	/*
> +	 * FADT is required on riscv; retrieve it to check its presence
> +	 * and carry out revision and ACPI HW reduced compliancy tests
> +	 */
> +	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
> +	if (ACPI_FAILURE(status)) {
> +		const char *msg = acpi_format_exception(status);
> +
> +		pr_err("Failed to get FADT table, %s\n", msg);
> +		return -ENODEV;
> +	}
> +
> +	fadt = (struct acpi_table_fadt *)table;
> +
> +	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {

Do we also need to check for ACPI version 5.0+ when checking for HW
reduced?

> +		pr_err("FADT not ACPI hardware reduced compliant\n");
> +		ret = -EINVAL;
> +	}
> +
> +	/*
> +	 * acpi_get_table() creates FADT table mapping that
> +	 * should be released after parsing and before resuming boot
> +	 */
> +	acpi_put_table(table);
> +	return ret;
> +}
> +
> +/*
> + * acpi_boot_table_init() called from setup_arch(), always.
> + *	1. find RSDP and get its address, and then find XSDT
> + *	2. extract all tables and checksums them all
> + *	3. check ACPI FADT HW reduced flag
> + *
> + * We can parse ACPI boot-time tables such as MADT after
> + * this function is called.
> + *
> + * On return ACPI is enabled if either:
> + *
> + * - ACPI tables are initialized and sanity checks passed
> + * - acpi=force was passed in the command line and ACPI was not disabled
> + *   explicitly through acpi=off command line parameter
> + *
> + * ACPI is disabled on function return otherwise
> + */
> +void __init acpi_boot_table_init(void)
> +{
> +	/*
> +	 * Enable ACPI instead of device tree unless
> +	 * - ACPI has been disabled explicitly (acpi=off), or
> +	 * - firmware has not populated ACPI ptr in EFI system table
> +	 *   and ACPI has not been [force] enabled (acpi=on|force)
> +	 */
> +	if (param_acpi_off ||
> +	    (!param_acpi_on && !param_acpi_force &&
> +	     efi.acpi20 == EFI_INVALID_TABLE_ADDR))
> +		return;
> +
> +	/*
> +	 * ACPI is disabled at this point. Enable it in order to parse
> +	 * the ACPI tables and carry out sanity checks
> +	 */
> +	enable_acpi();
> +
> +	/*
> +	 * If ACPI tables are initialized and FADT sanity checks passed,
> +	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
> +	 * on initialization error.
> +	 * If acpi=force was passed on the command line it forces ACPI
> +	 * to be enabled even if its initialization failed.
> +	 */
> +	if (acpi_table_init() || acpi_fadt_sanity_check()) {
> +		pr_err("Failed to init ACPI tables\n");
> +		if (!param_acpi_force)
> +			disable_acpi();
> +	}
> +}

A lot of the above code is common with arm64. It'd be nice to share that,
but maybe refactoring can be done on top of this.

>  
>  static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
>  {
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4335f08ffaf2..c2ee7f4427a1 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -8,6 +8,7 @@
>   *  Nick Kossifidis <mick@ics.forth.gr>
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memblock.h>
> @@ -276,14 +277,22 @@ void __init setup_arch(char **cmdline_p)
>  
>  	efi_init();
>  	paging_init();
> -#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> -	unflatten_and_copy_device_tree();
> -#else
> -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> -		unflatten_device_tree();
> -	else
> -		pr_err("No DTB found in kernel mappings\n");
> -#endif
> +
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +	if (acpi_disabled) {
> +		if (IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> +			unflatten_and_copy_device_tree();
> +		} else {
> +			if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> +				unflatten_device_tree();
> +			else
> +				pr_err("No DTB found in kernel mappings\n");
> +		}
> +	} else {
> +		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
> +	}
> +
>  	early_init_fdt_scan_reserved_mem();
>  	misc_mem_init();
>  
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
