Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212716EEEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbjDZHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbjDZHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CEF420A;
        Wed, 26 Apr 2023 00:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE66A633B6;
        Wed, 26 Apr 2023 07:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C75C4339E;
        Wed, 26 Apr 2023 07:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682492945;
        bh=UfXtHQLFbD4Qk0s1jZztXQOQEe5nIWBt7eKvofY330o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=okcNitRJm6ndvuv5MKiXTWT/XXVGFrEvPzr6D4ek/WomAObj8zWgn7dnwsO5VzxoJ
         uczWqEBfSzf+hB49KXJ6TJPFgfndlUKSOdStThfg2t/nnSjw7rjwMcgFNroLSqspT5
         XsnwJ+XGNXb9Iqid1nwtF8Xsnq/4GqMIAwqXsywyJFLyjBxnl7PVgQGWqw1kTAIsVt
         Vc8SAU0AXrYnGq+OK4l0epAY7MWI1P5+FcnST7r0B/jtoa7jkonxq/Cwg0tSc6LIAS
         0Heamnl1d0AuN8R6LCM2mhPMDGSJAcZr6VFNGQCzfDqLbWI8msfK+hR+D1OJMwNI+y
         Hgcd0CcEHEdCg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so7314294e87.2;
        Wed, 26 Apr 2023 00:09:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDzR10OKW/JE0j25Jjj7JG8ZtXJOdVvgz8W2M6ncq8qOR0XO704Z
        Cm4E+MFLAiMmdi43PxkgW+LSfklQF+sP9s6x+3M=
X-Google-Smtp-Source: ACHHUZ7vK5qZmgeBTSpyZLgRSq7J2UnnonzQU9mD7M3f/6fxeFAToe1Rxh8rEQ0OHWk/O2/zP5pzdtKJsgpUDSlFs/Y=
X-Received: by 2002:a05:6512:3744:b0:4ef:fe49:e14f with SMTP id
 a4-20020a056512374400b004effe49e14fmr1092114lfs.20.1682492942989; Wed, 26 Apr
 2023 00:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com>
In-Reply-To: <20230426034001.16-1-cuiyunhui@bytedance.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Apr 2023 08:08:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
Message-ID: <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: added a firmware information passing method FFI
To:     Yunhui Cui <cuiyunhui@bytedance.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        cujomalainey@chromium.org, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 at 04:40, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>
> Some BootLoaders do not support UEFI and cannot pass ACPI/SBMIOS table
> addresses through UEFI, such as coreboot.
>
> On the x86 platform, we pass the ACPI/SMBIOS table through the reserved
> address segment 0xF0000, but other arches usually do not reserve this
> address segment.
>
> We have added a new firmware information transmission method named FFI
> (FDT FIRMWARE INTERFACE), through FDT to obtain firmware information,
> such as the base address of the ACPI and SMBIOS table.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Hello Yunhui,

I am not sure this is a good idea: this is clearly intended for arm64,
which cannot use ACPI without the EFI memory map, which it uses to
cross reference memory opregion accesses, to determine the correct
memory type attributes.

What is the use case you are trying to accommodate here?




> ---
>  MAINTAINERS                 |  6 +++
>  drivers/acpi/osl.c          |  8 ++++
>  drivers/firmware/Kconfig    | 12 +++++
>  drivers/firmware/Makefile   |  1 +
>  drivers/firmware/dmi_scan.c | 96 ++++++++++++++++++++++---------------
>  drivers/firmware/ffi.c      | 56 ++++++++++++++++++++++
>  include/linux/ffi.h         | 15 ++++++
>  7 files changed, 155 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/firmware/ffi.c
>  create mode 100644 include/linux/ffi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f305..94664f3b4c96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7750,6 +7750,12 @@ F:       arch/x86/platform/efi/
>  F:     drivers/firmware/efi/
>  F:     include/linux/efi*.h
>
> +FDT FIRMWARE INTERFACE (FFI)
> +M:     Yunhui Cui cuiyunhui@bytedance.com
> +S:     Maintained
> +F:     drivers/firmware/ffi.c
> +F:     include/linux/ffi.h
> +
>  EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)
>  M:     MyungJoo Ham <myungjoo.ham@samsung.com>
>  M:     Chanwoo Choi <cw00.choi@samsung.com>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a..d45000041d2b 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -25,6 +25,7 @@
>  #include <linux/nmi.h>
>  #include <linux/acpi.h>
>  #include <linux/efi.h>
> +#include <linux/ffi.h>
>  #include <linux/ioport.h>
>  #include <linux/list.h>
>  #include <linux/jiffies.h>
> @@ -206,6 +207,13 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>         if (pa)
>                 return pa;
>
> +#ifdef CONFIG_FDT_FW_INTERFACE
> +       if (fdt_fwtbl.acpi20 != FDT_INVALID_FWTBL_ADDR)
> +               return fdt_fwtbl.acpi20;
> +       if (fdt_fwtbl.acpi != FDT_INVALID_FWTBL_ADDR)
> +               return fdt_fwtbl.acpi;
> +       pr_err("Fdt system description tables not found\n");
> +#endif
>         if (efi_enabled(EFI_CONFIG_TABLES)) {
>                 if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
>                         return efi.acpi20;
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..13c67b50c17a 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -303,6 +303,18 @@ config TURRIS_MOX_RWTM
>           other manufacturing data and also utilize the Entropy Bit Generator
>           for hardware random number generation.
>
> +config FDT_FW_INTERFACE
> +       bool "An interface for passing firmware info through FDT"
> +       depends on OF && OF_FLATTREE
> +       default n
> +       help
> +         When some bootloaders do not support UEFI, and the arch does not
> +         support SMBIOS_ENTRY_POINT_SCAN_START, then you can enable this option
> +         to support the transfer of firmware information, such as acpi, smbios
> +         tables.
> +
> +         Say Y here if you want to pass firmware information by FDT.
> +
>  source "drivers/firmware/arm_ffa/Kconfig"
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/cirrus/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 28fcddcd688f..3b8b5d0868a6 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -33,6 +33,7 @@ obj-y                         += cirrus/
>  obj-y                          += meson/
>  obj-$(CONFIG_GOOGLE_FIRMWARE)  += google/
>  obj-y                          += efi/
> +obj-$(CONFIG_FDT_FW_INTERFACE) += ffi.o
>  obj-y                          += imx/
>  obj-y                          += psci/
>  obj-y                          += smccc/
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 015c95a825d3..1e1a74ed7d3b 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -6,6 +6,7 @@
>  #include <linux/ctype.h>
>  #include <linux/dmi.h>
>  #include <linux/efi.h>
> +#include <linux/ffi.h>
>  #include <linux/memblock.h>
>  #include <linux/random.h>
>  #include <asm/dmi.h>
> @@ -655,54 +656,71 @@ static int __init dmi_smbios3_present(const u8 *buf)
>         return 1;
>  }
>
> -static void __init dmi_scan_machine(void)
> +/*
> + * According to the DMTF SMBIOS reference spec v3.0.0, it is
> + * allowed to define both the 64-bit entry point (smbios3) and
> + * the 32-bit entry point (smbios), in which case they should
> + * either both point to the same SMBIOS structure table, or the
> + * table pointed to by the 64-bit entry point should contain a
> + * superset of the table contents pointed to by the 32-bit entry
> + * point (section 5.2)
> + * This implies that the 64-bit entry point should have
> + * precedence if it is defined and supported by the OS. If we
> + * have the 64-bit entry point, but fail to decode it, fall
> + * back to the legacy one (if available)
> + */
> +static int __init dmi_sacn_smbios(unsigned long smbios3, unsigned long smbios)
>  {
> -       char __iomem *p, *q;
> +       char __iomem *p;
>         char buf[32];
> +       #define INVALID_TABLE_ADDR (~0UL)
>
> -       if (efi_enabled(EFI_CONFIG_TABLES)) {
> -               /*
> -                * According to the DMTF SMBIOS reference spec v3.0.0, it is
> -                * allowed to define both the 64-bit entry point (smbios3) and
> -                * the 32-bit entry point (smbios), in which case they should
> -                * either both point to the same SMBIOS structure table, or the
> -                * table pointed to by the 64-bit entry point should contain a
> -                * superset of the table contents pointed to by the 32-bit entry
> -                * point (section 5.2)
> -                * This implies that the 64-bit entry point should have
> -                * precedence if it is defined and supported by the OS. If we
> -                * have the 64-bit entry point, but fail to decode it, fall
> -                * back to the legacy one (if available)
> -                */
> -               if (efi.smbios3 != EFI_INVALID_TABLE_ADDR) {
> -                       p = dmi_early_remap(efi.smbios3, 32);
> -                       if (p == NULL)
> -                               goto error;
> -                       memcpy_fromio(buf, p, 32);
> -                       dmi_early_unmap(p, 32);
> -
> -                       if (!dmi_smbios3_present(buf)) {
> -                               dmi_available = 1;
> -                               return;
> -                       }
> -               }
> -               if (efi.smbios == EFI_INVALID_TABLE_ADDR)
> -                       goto error;
> -
> -               /* This is called as a core_initcall() because it isn't
> -                * needed during early boot.  This also means we can
> -                * iounmap the space when we're done with it.
> -                */
> -               p = dmi_early_remap(efi.smbios, 32);
> +       if (smbios3 != INVALID_TABLE_ADDR) {
> +               p = dmi_early_remap(smbios3, 32);
>                 if (p == NULL)
> -                       goto error;
> +                       return -1;
>                 memcpy_fromio(buf, p, 32);
>                 dmi_early_unmap(p, 32);
>
> -               if (!dmi_present(buf)) {
> +               if (!dmi_smbios3_present(buf)) {
>                         dmi_available = 1;
> -                       return;
> +                       return 0;
>                 }
> +       }
> +
> +       if (smbios == INVALID_TABLE_ADDR)
> +               return -1;
> +
> +       /*
> +        * This is called as a core_initcall() because it isn't
> +        * needed during early boot.  This also means we can
> +        * iounmap the space when we're done with it.
> +        */
> +       p = dmi_early_remap(smbios, 32);
> +       if (p == NULL)
> +               return -1;
> +       memcpy_fromio(buf, p, 32);
> +       dmi_early_unmap(p, 32);
> +
> +       if (!dmi_present(buf)) {
> +               dmi_available = 1;
> +               return 0;
> +       }
> +       return -1;
> +}
> +
> +static void __init dmi_scan_machine(void)
> +{
> +       char __iomem *p, *q;
> +       char buf[32];
> +
> +#ifdef CONFIG_FDT_FW_INTERFACE
> +       if (dmi_sacn_smbios(fdt_fwtbl.smbios3, fdt_fwtbl.smbios))
> +               goto error;
> +#endif
> +       if (efi_enabled(EFI_CONFIG_TABLES)) {
> +               if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> +                       goto error;
>         } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
>                 p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
>                 if (p == NULL)
> diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
> new file mode 100644
> index 000000000000..83c7abf22220
> --- /dev/null
> +++ b/drivers/firmware/ffi.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kobject.h>
> +#include <linux/ffi.h>
> +#include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
> +
> +struct fdt_fwtable __read_mostly fdt_fwtbl = {
> +       .acpi                   = FDT_INVALID_FWTBL_ADDR,
> +       .acpi20                 = FDT_INVALID_FWTBL_ADDR,
> +       .smbios                 = FDT_INVALID_FWTBL_ADDR,
> +       .smbios3                = FDT_INVALID_FWTBL_ADDR,
> +};
> +EXPORT_SYMBOL(fdt_fwtbl);
> +
> +void __init of_fdt_fwtbl(void)
> +{
> +       int cfgtbl, len;
> +       fdt64_t *prop;
> +
> +       cfgtbl = fdt_path_offset(initial_boot_params, "/cfgtables");
> +       if (cfgtbl < 0) {
> +               pr_info("cfgtables not found.\n");
> +               return;
> +       }
> +       prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy_ptr", &len);
> +       if (!prop || len != sizeof(u64))
> +               pr_info("smbios_phy_ptr not found.\n");
> +       else
> +               fdt_fwtbl.smbios = fdt64_to_cpu(*prop);
> +
> +       prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios3_phy_ptr", &len);
> +       if (!prop || len != sizeof(u64))
> +               pr_info("smbios3_phy_ptr not found.\n");
> +       else
> +               fdt_fwtbl.smbios3 = fdt64_to_cpu(*prop);
> +
> +       prop = fdt_getprop_w(initial_boot_params, cfgtbl, "acpi_phy_ptr", &len);
> +       if (!prop || len != sizeof(u64))
> +               pr_info("acpi_phy_ptr not found.\n");
> +       else
> +               fdt_fwtbl.acpi = fdt64_to_cpu(*prop);
> +
> +       prop = fdt_getprop_w(initial_boot_params, cfgtbl, "acpi20_phy_ptr", &len);
> +       if (!prop || len != sizeof(u64))
> +               pr_info("acpi20_phy_ptr not found.\n");
> +       else
> +               fdt_fwtbl.acpi20 = fdt64_to_cpu(*prop);
> +}
> +
> +void __init fdt_fwtbl_init(void)
> +{
> +       of_fdt_fwtbl();
> +}
> diff --git a/include/linux/ffi.h b/include/linux/ffi.h
> new file mode 100644
> index 000000000000..ffb50810a01e
> --- /dev/null
> +++ b/include/linux/ffi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_FDT_FW_H
> +#define _LINUX_FDT_FW_H
> +
> +#define FDT_INVALID_FWTBL_ADDR         (~0UL)
> +extern struct fdt_fwtable {
> +       unsigned long                   acpi;
> +       unsigned long                   acpi20;
> +       unsigned long                   smbios;
> +       unsigned long                   smbios3;
> +       unsigned long                   flags;
> +} fdt_fwtbl;
> +
> +#endif
> --
> 2.20.1
>
