Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E156FA108
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjEHHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEHHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5731FCA;
        Mon,  8 May 2023 00:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BFF615AC;
        Mon,  8 May 2023 07:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B7CC433D2;
        Mon,  8 May 2023 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683531035;
        bh=M9Gp4XYXDUvrXLJSIBBU5HWRNqkwCmnPdpch7gGzxZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ECW8/wsOkZgFlukZU7Py5T9UKG3cO0ozWVXEEcB1uVwZcnQDZUF/4xrL+LD+uZ408
         fPnydBEnn5gmEtciZb/EBLEN7XtLJqOrPhqe+jnOPaZUWdWP3U9tJ7A3zr/fxcLnP3
         fZl3YnvOr615Amt3hxlMqcwsgnMCQt8q33yqgKUXmdEakZsfbB0z07Gtw2lGq6RcEE
         qFPPMoIakqJs6LOzmGNX4gSBPUltp/JybBLwn4IGEeiTse5hLVdd6/HOb8I6H8Y4iz
         GzvRV8/4jd/funez3oSakrm4CdTzOgGuVuUxMTZWIrpXPdF76XUSjzBvXOtVWIeirl
         HdAYesvSy5LFQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ad714536cfso16847641fa.0;
        Mon, 08 May 2023 00:30:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDw7q1OeqzxtR3u5S0hEzUdgRwzU57BFOO6vSn5EVvvaFhKnrCge
        DSkWFR992BNKrDTrBhRXdGtpeGjHspLt6JL1fiE=
X-Google-Smtp-Source: ACHHUZ4nO7dApCsYrfdeUXX8ZNgXOCesYONc/XIkF0LLCKgR15dqxmoCIiV7mzYT+O6cROIaRMRMt/4uZxdWLeEYops=
X-Received: by 2002:a2e:9d87:0:b0:2a8:a629:c203 with SMTP id
 c7-20020a2e9d87000000b002a8a629c203mr2618680ljj.32.1683531033749; Mon, 08 May
 2023 00:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com> <20230507234618.18067-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230507234618.18067-5-kirill.shutemov@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 May 2023 09:30:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
Message-ID: <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kirill,

On Mon, 8 May 2023 at 01:46, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance: Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific for the Virtual
> Machine platform.
>
> Accepting memory is costly and it makes VMM allocate memory for the
> accepted guest physical address range. It's better to postpone memory
> acceptance until memory is needed. It lowers boot time and reduces
> memory overhead.
>
> The kernel needs to know what memory has been accepted. Firmware
> communicates this information via memory map: a new memory type --
> EFI_UNACCEPTED_MEMORY -- indicates such memory.
>
> Range-based tracking works fine for firmware, but it gets bulky for
> the kernel: e820 has to be modified on every page acceptance. It leads
> to table fragmentation, but there's a limited number of entries in the
> e820 table
>
> Another option is to mark such memory as usable in e820 and track if the
> range has been accepted in a bitmap. One bit in the bitmap represents
> 2MiB in the address space: one 4k page is enough to track 64GiB or
> physical address space.
>
> In the worst-case scenario -- a huge hole in the middle of the
> address space -- It needs 256MiB to handle 4PiB of the address
> space.
>
> Any unaccepted memory that is not aligned to 2M gets accepted upfront.
>
> The bitmap is allocated and constructed in the EFI stub and passed down
> to the kernel via boot_params. allocate_e820() allocates the bitmap if
> unaccepted memory is present, according to the maximum address in the
> memory map.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  Documentation/arch/x86/zero-page.rst     |  1 +
>  arch/x86/boot/compressed/Makefile        |  1 +
>  arch/x86/boot/compressed/mem.c           | 73 ++++++++++++++++++++++++
>  arch/x86/include/asm/unaccepted_memory.h | 10 ++++
>  arch/x86/include/uapi/asm/bootparam.h    |  2 +-
>  drivers/firmware/efi/Kconfig             | 14 +++++
>  drivers/firmware/efi/efi.c               |  1 +
>  drivers/firmware/efi/libstub/x86-stub.c  | 65 +++++++++++++++++++++
>  include/linux/efi.h                      |  3 +-
>  9 files changed, 168 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/mem.c
>  create mode 100644 arch/x86/include/asm/unaccepted_memory.h
>
> diff --git a/Documentation/arch/x86/zero-page.rst b/Documentation/arch/x86/zero-page.rst
> index 45aa9cceb4f1..f21905e61ade 100644
> --- a/Documentation/arch/x86/zero-page.rst
> +++ b/Documentation/arch/x86/zero-page.rst
> @@ -20,6 +20,7 @@ Offset/Size   Proto   Name                    Meaning
>  060/010                ALL     ist_info                Intel SpeedStep (IST) BIOS support information
>                                                 (struct ist_info)
>  070/008                ALL     acpi_rsdp_addr          Physical address of ACPI RSDP table
> +078/008                ALL     unaccepted_memory       Bitmap of unaccepted memory (1bit == 2M)

Unaccepted memory is a generic EFI feature, and will need to be
supported on other architectures as well.

Could we perhaps use a EFI configuration table to pass the bitmap to
the core kernel, instead of adding more cruft to this archaic header?
That could be implemented in a arch-agnostic manner, even in cases
where the bootloader is the agent that calls ExitBootServices(), as it
would be the loader that allocates and populates the bitmap in that
case.


>  080/010                ALL     hd0_info                hd0 disk parameter, OBSOLETE!!
>  090/010                ALL     hd1_info                hd1 disk parameter, OBSOLETE!!
>  0A0/010                ALL     sys_desc_table          System description table (struct sys_desc_table),
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 6b6cfe607bdb..f62c02348f9a 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,6 +107,7 @@ endif
>
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
>
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> new file mode 100644
> index 000000000000..6b15a0ed8b54
> --- /dev/null
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "../cpuflags.h"
> +#include "bitmap.h"
> +#include "error.h"
> +#include "math.h"
> +
> +#define PMD_SHIFT      21
> +#define PMD_SIZE       (_AC(1, UL) << PMD_SHIFT)
> +#define PMD_MASK       (~(PMD_SIZE - 1))
> +
> +static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       /* Platform-specific memory-acceptance call goes here */
> +       error("Cannot accept memory");
> +}
> +
> +/*
> + * The accepted memory bitmap only works at PMD_SIZE granularity.  Take
> + * unaligned start/end addresses and either:
> + *  1. Accepts the memory immediately and in its entirety
> + *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
> + *
> + * The function will never reach the bitmap_set() with zero bits to set.
> + */
> +void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
> +{
> +       /*
> +        * Ensure that at least one bit will be set in the bitmap by
> +        * immediately accepting all regions under 2*PMD_SIZE.  This is
> +        * imprecise and may immediately accept some areas that could
> +        * have been represented in the bitmap.  But, results in simpler
> +        * code below
> +        *
> +        * Consider case like this:
> +        *
> +        * | 4k | 2044k |    2048k   |
> +        * ^ 0x0        ^ 2MB        ^ 4MB
> +        *
> +        * Only the first 4k has been accepted. The 0MB->2MB region can not be
> +        * represented in the bitmap. The 2MB->4MB region can be represented in
> +        * the bitmap. But, the 0MB->4MB region is <2*PMD_SIZE and will be
> +        * immediately accepted in its entirety.
> +        */
> +       if (end - start < 2 * PMD_SIZE) {
> +               __accept_memory(start, end);
> +               return;
> +       }
> +
> +       /*
> +        * No matter how the start and end are aligned, at least one unaccepted
> +        * PMD_SIZE area will remain to be marked in the bitmap.
> +        */
> +
> +       /* Immediately accept a <PMD_SIZE piece at the start: */
> +       if (start & ~PMD_MASK) {
> +               __accept_memory(start, round_up(start, PMD_SIZE));
> +               start = round_up(start, PMD_SIZE);
> +       }
> +
> +       /* Immediately accept a <PMD_SIZE piece at the end: */
> +       if (end & ~PMD_MASK) {
> +               __accept_memory(round_down(end, PMD_SIZE), end);
> +               end = round_down(end, PMD_SIZE);
> +       }
> +
> +       /*
> +        * 'start' and 'end' are now both PMD-aligned.
> +        * Record the range as being unaccepted:
> +        */
> +       bitmap_set((unsigned long *)params->unaccepted_memory,
> +                  start / PMD_SIZE, (end - start) / PMD_SIZE);
> +}
> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> new file mode 100644
> index 000000000000..df0736d32858
> --- /dev/null
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 Intel Corporation */
> +#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
> +#define _ASM_X86_UNACCEPTED_MEMORY_H
> +
> +struct boot_params;
> +
> +void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
> +
> +#endif
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 01d19fc22346..630a54046af0 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -189,7 +189,7 @@ struct boot_params {
>         __u64  tboot_addr;                              /* 0x058 */
>         struct ist_info ist_info;                       /* 0x060 */
>         __u64 acpi_rsdp_addr;                           /* 0x070 */
> -       __u8  _pad3[8];                                 /* 0x078 */
> +       __u64 unaccepted_memory;                        /* 0x078 */
>         __u8  hd0_info[16];     /* obsolete! */         /* 0x080 */
>         __u8  hd1_info[16];     /* obsolete! */         /* 0x090 */
>         struct sys_desc_table sys_desc_table; /* obsolete! */   /* 0x0a0 */
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..231f1c70d1db 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -269,6 +269,20 @@ config EFI_COCO_SECRET
>           virt/coco/efi_secret module to access the secrets, which in turn
>           allows userspace programs to access the injected secrets.
>
> +config UNACCEPTED_MEMORY
> +       bool
> +       depends on EFI_STUB
> +       help
> +          Some Virtual Machine platforms, such as Intel TDX, require
> +          some memory to be "accepted" by the guest before it can be used.
> +          This mechanism helps prevent malicious hosts from making changes
> +          to guest memory.
> +
> +          UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
> +
> +          This option adds support for unaccepted memory and makes such memory
> +          usable by the kernel.
> +
>  config EFI_EMBEDDED_FIRMWARE
>         bool
>         select CRYPTO_LIB_SHA256
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index abeff7dc0b58..7dce06e419c5 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -843,6 +843,7 @@ static __initdata char memory_type_name[][13] = {
>         "MMIO Port",
>         "PAL Code",
>         "Persistent",
> +       "Unaccepted",
>  };
>
>  char * __init efi_md_typeattr_format(char *buf, size_t size,
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index fff81843169c..1643ddbde249 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -15,6 +15,7 @@
>  #include <asm/setup.h>
>  #include <asm/desc.h>
>  #include <asm/boot.h>
> +#include <asm/unaccepted_memory.h>
>
>  #include "efistub.h"
>
> @@ -613,6 +614,16 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>                         e820_type = E820_TYPE_PMEM;
>                         break;
>
> +               case EFI_UNACCEPTED_MEMORY:
> +                       if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +                               efi_warn_once(
> +"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
> +                               continue;
> +                       }
> +                       e820_type = E820_TYPE_RAM;
> +                       process_unaccepted_memory(params, d->phys_addr,
> +                                                 d->phys_addr + PAGE_SIZE * d->num_pages);
> +                       break;
>                 default:
>                         continue;
>                 }
> @@ -677,6 +688,57 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
>         return status;
>  }
>
> +static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
> +                                              __u32 nr_desc,
> +                                              struct efi_boot_memmap *map)
> +{
> +       unsigned long *mem = NULL;
> +       u64 size, max_addr = 0;
> +       efi_status_t status;
> +       bool found = false;
> +       int i;
> +
> +       /* Check if there's any unaccepted memory and find the max address */
> +       for (i = 0; i < nr_desc; i++) {
> +               efi_memory_desc_t *d;
> +               unsigned long m = (unsigned long)map->map;
> +
> +               d = efi_early_memdesc_ptr(m, map->desc_size, i);
> +               if (d->type == EFI_UNACCEPTED_MEMORY)
> +                       found = true;
> +               if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> +                       max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> +       }
> +
> +       if (!found) {
> +               params->unaccepted_memory = 0;
> +               return EFI_SUCCESS;
> +       }
> +
> +       /*
> +        * If unaccepted memory is present, allocate a bitmap to track what
> +        * memory has to be accepted before access.
> +        *
> +        * One bit in the bitmap represents 2MiB in the address space:
> +        * A 4k bitmap can track 64GiB of physical address space.
> +        *
> +        * In the worst case scenario -- a huge hole in the middle of the
> +        * address space -- It needs 256MiB to handle 4PiB of the address
> +        * space.
> +        *
> +        * The bitmap will be populated in setup_e820() according to the memory
> +        * map after efi_exit_boot_services().
> +        */
> +       size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> +       status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);
> +       if (status == EFI_SUCCESS) {
> +               memset(mem, 0, size);
> +               params->unaccepted_memory = (unsigned long)mem;
> +       }
> +
> +       return status;
> +}
> +
>  static efi_status_t allocate_e820(struct boot_params *params,
>                                   struct setup_data **e820ext,
>                                   u32 *e820ext_size)
> @@ -697,6 +759,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
>                 status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
>         }
>
> +       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
> +               status = allocate_unaccepted_bitmap(params, nr_desc, map);
> +
>         efi_bs_call(free_pool, map);
>         return status;
>  }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7aa62c92185f..efbe14641638 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -108,7 +108,8 @@ typedef     struct {
>  #define EFI_MEMORY_MAPPED_IO_PORT_SPACE        12
>  #define EFI_PAL_CODE                   13
>  #define EFI_PERSISTENT_MEMORY          14
> -#define EFI_MAX_MEMORY_TYPE            15
> +#define EFI_UNACCEPTED_MEMORY          15
> +#define EFI_MAX_MEMORY_TYPE            16
>
>  /* Attribute values: */
>  #define EFI_MEMORY_UC          ((u64)0x0000000000000001ULL)    /* uncached */
> --
> 2.39.3
>
