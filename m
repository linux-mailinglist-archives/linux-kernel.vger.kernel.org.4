Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DD6EFA39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjDZSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjDZSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:45:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B6D83F8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:45:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b73203e0aso367284b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682534700; x=1685126700;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXv9EBXsjnGX9kEXn0B/s+hqjmyTTUzLD32lO39BZvU=;
        b=PmtX0uvD5R08TnTNcgBkAMUdrmv6Ik+3HBUHjNPdM0a73HFMZrqZfIpRTz4VO7eGko
         GP7ig7Z69Qb//X2HugVeLDxvTpJ6MBgEAXyC6PMotMCpMC4byu4umSUgJxOtU1U7TVkH
         3NMS95PQScbu2jZKVZ5wADycPfQ1dGBKC49UWYwPuZB7RwpLbCeMk0PxwSCzVlWuhscR
         XoVUY4NN3kxp/L6S2ORON9Ynu7qjVnzP39JL8j3lywPX2i3O/LrtHck8h/bQnFzoH2M8
         8EW1jvloRCc/z9y5d4cVkzpp/G5lX5ePVdLh6TaZK5izU/cYWjbtiez5YUomenDiSqfL
         MtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534700; x=1685126700;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXv9EBXsjnGX9kEXn0B/s+hqjmyTTUzLD32lO39BZvU=;
        b=SUXf0mF+JnaIY778ihNszoHrOq/ZuYzLtgP73XaqCd1gdMCxjhjLisnFdUcozIB4aP
         xpv3uRE0kT96Y8sdb7LctLLRR9SJEOeltxWGpuBMbuqPPNSJ/HG5f/Potx276z51mWqQ
         Kx/WyszvQeJDz2oI97Zrs4hqNz5luZ2uO4SJ1bqakAFvvoEZtf5djGPpDuM508Z4xRR+
         LDkdA306YqEGxhKR3P3YxURF8TN/Ux59TjW3ZbGEqaDRIfzY+RfW/yPy1uQZjWXlA2Wm
         81yhzAbC5UYR76I08g7oI0ESYrGn9QGM0J3TlteIg4nxHiWdqInpLu1K+l9z/V85PVNJ
         8w+g==
X-Gm-Message-State: AC+VfDyDrPs+gO1xgPewu2R+crbGA15GvJY1BdHXzbPj8C48LAazvDfV
        GDVaWhelnXFlJiqF8dN8o7wOYA==
X-Google-Smtp-Source: ACHHUZ4koQkpMzhT77rN0UH3bIxXMo20U7ZWYjzcC2V8VtCwyH/q+kE8Se/3f+lYbUegITz75dSaRw==
X-Received: by 2002:a17:903:41c4:b0:1a5:27d2:b6de with SMTP id u4-20020a17090341c400b001a527d2b6demr4532376ple.3.1682534699878;
        Wed, 26 Apr 2023 11:44:59 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902864b00b001a285269b70sm10170989plt.280.2023.04.26.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:44:59 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:44:59 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Apr 2023 11:15:15 PDT (-0700)
Subject:     Re: [PATCH V4 06/23] RISC-V: Add support to build the ACPI core
In-Reply-To: <20230404182037.863533-7-sunilvl@ventanamicro.com>
CC:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, Marc Zyngier <maz@kernel.org>,
        luzmaximilian@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rafael@kernel.org, davem@davemloft.net, sunilvl@ventanamicro.com,
        rafael.j.wysocki@intel.com, ajones@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-79ce292f-436e-47f4-bfab-aa80064d73e8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 11:20:20 PDT (-0700), sunilvl@ventanamicro.com wrote:
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
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
> index 139055bcfcae..710037f7ca0a 100644
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
> @@ -639,6 +641,7 @@ config EFI
>  	depends on OF && !XIP_KERNEL
>  	depends on MMU
>  	default y
> +	select ARCH_SUPPORTS_ACPI if 64BIT
>  	select EFI_GENERIC_STUB
>  	select EFI_PARAMS_FROM_FDT
>  	select EFI_RUNTIME_WRAPPERS
> @@ -742,3 +745,5 @@ source "drivers/cpufreq/Kconfig"
>  endmenu # "CPU Power Management"
>
>  source "arch/riscv/kvm/Kconfig"
> +
> +source "drivers/acpi/Kconfig"
> diff --git a/arch/riscv/include/asm/acenv.h b/arch/riscv/include/asm/acenv.h
> new file mode 100644
> index 000000000000..43ae2e32c779
> --- /dev/null
> +++ b/arch/riscv/include/asm/acenv.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RISC-V specific ACPICA environments and implementation
> + */
> +
> +#ifndef _ASM_ACENV_H
> +#define _ASM_ACENV_H
> +
> +/* This header is required unconditionally by the ACPI core */
> +
> +#endif /* _ASM_ACENV_H */
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> new file mode 100644
> index 000000000000..bcade255bd6e
> --- /dev/null
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *  Copyright (C) 2013-2014, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + */
> +
> +#ifndef _ASM_ACPI_H
> +#define _ASM_ACPI_H
> +
> +/* Basic configuration for ACPI */
> +#ifdef CONFIG_ACPI
> +
> +/* ACPI table mapping after acpi_permanent_mmap is set */
> +void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> +#define acpi_os_ioremap acpi_os_ioremap
> +
> +#define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
> +extern int acpi_disabled;
> +extern int acpi_noirq;
> +extern int acpi_pci_disabled;
> +
> +static inline void disable_acpi(void)
> +{
> +	acpi_disabled = 1;
> +	acpi_pci_disabled = 1;
> +	acpi_noirq = 1;
> +}
> +
> +static inline void enable_acpi(void)
> +{
> +	acpi_disabled = 0;
> +	acpi_pci_disabled = 0;
> +	acpi_noirq = 0;
> +}
> +
> +/*
> + * The ACPI processor driver for ACPI core code needs this macro
> + * to find out whether this cpu was already mapped (mapping from CPU hardware
> + * ID to CPU logical ID) or not.
> + */
> +#define cpu_physical_id(cpu) cpuid_to_hartid_map(cpu)
> +
> +/*
> + * Since MADT must provide at least one RINTC structure, the
> + * CPU will be always available in MADT on RISC-V.
> + */
> +static inline bool acpi_has_cpu_in_madt(void)
> +{
> +	return true;
> +}
> +
> +static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> +
> +#endif /* CONFIG_ACPI */
> +
> +#endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/include/asm/cpu.h b/arch/riscv/include/asm/cpu.h
> new file mode 100644
> index 000000000000..28d45a6678ce
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_CPU_H
> +#define _ASM_CPU_H
> +
> +/* This header is required unconditionally by the ACPI core */
> +
> +#endif /* _ASM_CPU_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 67f542be1bea..8ce334f6932f 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -90,3 +90,5 @@ obj-$(CONFIG_EFI)		+= efi.o
>  obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
>  obj-$(CONFIG_COMPAT)		+= compat_signal.o
>  obj-$(CONFIG_COMPAT)		+= compat_vdso/
> +
> +obj-$(CONFIG_ACPI)		+= acpi.o
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> new file mode 100644
> index 000000000000..81d448c41714
> --- /dev/null
> +++ b/arch/riscv/kernel/acpi.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  RISC-V Specific Low-Level ACPI Boot Support
> + *
> + *  Copyright (C) 2013-2014, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> + *	Author: Naresh Bhat <naresh.bhat@linaro.org>
> + *
> + *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +
> +int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
> +int acpi_disabled = 1;
> +EXPORT_SYMBOL(acpi_disabled);
> +
> +int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
> +EXPORT_SYMBOL(acpi_pci_disabled);
> +
> +/*
> + * __acpi_map_table() will be called before paging_init(), so early_ioremap()
> + * or early_memremap() should be called here to for ACPI table mapping.
> + */
> +void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
> +{
> +	if (!size)
> +		return NULL;
> +
> +	return early_memremap(phys, size);
> +}
> +
> +void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> +{
> +	if (!map || !size)
> +		return;
> +
> +	early_memunmap(map, size);
> +}
> +
> +void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> +{
> +	return memremap(phys, size, MEMREMAP_WB);
> +}
> +
> +#ifdef CONFIG_PCI
> +
> +/*
> + * These interfaces are defined just to enable building ACPI core.
> + * TODO: Update it with actual implementation when external interrupt
> + * controller support is added in RISC-V ACPI.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
> +		 int reg, int len, u32 *val)
> +{
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
> +		  int reg, int len, u32 val)
> +{
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> +{
> +	return -1;
> +}
> +
> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +{
> +	return NULL;
> +}
> +#endif	/* CONFIG_PCI */

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
