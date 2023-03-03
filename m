Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6546A9AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCCPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCCPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:36:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1F76B0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:36:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so11976532edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+a4iAObubgdupIx5A13t4eGPRZyH4LhREkXgghv4xxk=;
        b=Fv49W5DvFygeRCObHLWFGBApnfTmVTZKsuKv5skwkgqTlhwp7y0NVF9S9+JDySWkp5
         LKcsFR/2x/z/MPF/H4cJv9cHBcnx+1RGn/Ao8mwpc7eYF/j9xKct2/zvql1qvVZlfkTv
         vpK+Rft5JIrZ3SMip85z3PMYm4JcDepSx35m2Twsq/DaAQaHlJY56kK9N8sXYcsgrsSZ
         URjrUD/1LA3SHJIlry2EvscmT7O8rmO44+Up79eInIwRKGX8BE1Am1CQkh22MuFQhJrG
         evvkpHXwpZD+I8PNzhrTcs5U9UinFJfRkLM8tSq4YH6nOu/liOPYUzRDOC8A6hBJjW+v
         aarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a4iAObubgdupIx5A13t4eGPRZyH4LhREkXgghv4xxk=;
        b=xnD3n7DBPc/QTz+EPVU4socVXS04YENd9Spj4U332nn8GTjhzwyKU45+9FHkWQcUl/
         gMHfqcaWbX3RErofQL9GyD3fOX/++qYLJ4VMujEQTtTLTopY17TEXwLNfyXn//ATvrnU
         3ZqpZycmbiW9fZYbSZcMwSGl0jSmrdmTiZIX/hkIXGHo4wq1Q/xz53haSQrRkMDCVsVB
         bU9etS16P1lJgknmJsY8W+MTnYM5kzdfIA2i/vZx6r2LC+rZ/GxE8fyLsDZ9Vig8dfMa
         4GB7WKEMA6ZqORqfBdrJWlMvpne/2wDmROroCkj/Ka3k1uJ7KznHul736gFQiXL1K8cf
         NkFQ==
X-Gm-Message-State: AO0yUKUi8kDR+soW+5TditLJveba7L6ZURPuGJIyMD70vD8N0FQaf5H6
        FLmXCsTE2X8iC5JsaML7bE87wwqht9VmS4Fh
X-Google-Smtp-Source: AK7set9EtY0wspQMB4VPYlpSRdJQhEAZ1ryiI5eLWiuIMV0gy5sE2XY9CWySdjcNRf/alEQ/500zsA==
X-Received: by 2002:a17:907:7f13:b0:884:3174:119d with SMTP id qf19-20020a1709077f1300b008843174119dmr2431543ejc.14.1677857779172;
        Fri, 03 Mar 2023 07:36:19 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z92-20020a509e65000000b004bc11e5f8b9sm1270904ede.83.2023.03.03.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:36:18 -0800 (PST)
Date:   Fri, 3 Mar 2023 16:36:17 +0100
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
Subject: Re: [PATCH V3 06/20] RISC-V: Add support to build the ACPI core
Message-ID: <20230303153617.ko4duynxjvixy3bf@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-7-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-7-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:33PM +0530, Sunil V L wrote:
> Enable ACPI core for RISC-V after adding architecture-specific
> interfaces and header files required to build the ACPI core.
> 
> 1) Couple of header files are required unconditionally by the ACPI
> core. Add empty acenv.h and cpu.h header files.
> 
> 2) If CONFIG_PCI is enabled, a few PCI related interfaces need to
> be provided by the architecture. Define dummy interfaces for now
> so that build succeeds. Actual implementation will be added when
> PCI support is added for ACPI along with external interrupt
> controller support.
> 
> 3) A few globals and memory mapping related functions specific
> to the architecture need to be provided.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig             |  5 +++
>  arch/riscv/include/asm/acenv.h | 11 +++++
>  arch/riscv/include/asm/acpi.h  | 61 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/cpu.h   |  8 ++++
>  arch/riscv/kernel/Makefile     |  2 +
>  arch/riscv/kernel/acpi.c       | 80 ++++++++++++++++++++++++++++++++++
>  6 files changed, 167 insertions(+)
>  create mode 100644 arch/riscv/include/asm/acenv.h
>  create mode 100644 arch/riscv/include/asm/acpi.h
>  create mode 100644 arch/riscv/include/asm/cpu.h
>  create mode 100644 arch/riscv/kernel/acpi.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 71754eb32ee6..f3108c7e19d8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,6 +12,8 @@ config 32BIT
>  
>  config RISCV
>  	def_bool y
> +	select ACPI_GENERIC_GSI if ACPI
> +	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> @@ -617,6 +619,7 @@ config EFI
>  	depends on OF && !XIP_KERNEL
>  	depends on MMU
>  	default y
> +	select ARCH_SUPPORTS_ACPI if 64BIT
>  	select EFI_GENERIC_STUB
>  	select EFI_PARAMS_FROM_FDT
>  	select EFI_RUNTIME_WRAPPERS
> @@ -720,3 +723,5 @@ source "drivers/cpufreq/Kconfig"
>  endmenu # "CPU Power Management"
>  
>  source "arch/riscv/kvm/Kconfig"
> +
> +source "drivers/acpi/Kconfig"

The above Kconfig hunks don't apply on the IPI improvement base. The
second hunk also looks weird with the select under the default.

Thanks,
drew
