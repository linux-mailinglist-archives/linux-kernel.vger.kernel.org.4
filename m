Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6562E031
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiKQPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiKQPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:43:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C0BD3;
        Thu, 17 Nov 2022 07:43:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C96AB820C9;
        Thu, 17 Nov 2022 15:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA88EC4314D;
        Thu, 17 Nov 2022 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668699798;
        bh=IlMz1HuDGTEi4UcjN5UC5MjvYMpLuVoL5C47NsVRGi8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MV8KXCxPDxlnaKY59Ujsn17Jn1JdwF3WvZA/R6qSE+Vgo8B1k3a66PghuhUHoUAss
         q1qmQjdYWZ66do8Iotpe05/KaXsL/OOazs1FQlD5C0ptx+UgOdPtPy9PTTgN0cJ685
         sY5Yb7RLF2M2NYHHcEIT0vHf4q1CLDMkOVgYiJB7hM9K7cBlsRxDWVerLGrMYdr0o4
         zwWhRKYct7ge6cD3RECAtdsoAXfvaNmc9lYCMT1w7N0VL2GX9ZmgIMb2CBQtQ5a9UL
         osTF3yuuWf753W3Muwm9jNqMGvDF+HBrLhW/rdAm7AbW2yTaQLoymAeOKqA7ghtOtj
         dwvVHqvAKTJxA==
Received: by mail-ed1-f49.google.com with SMTP id a5so3072450edb.11;
        Thu, 17 Nov 2022 07:43:18 -0800 (PST)
X-Gm-Message-State: ANoB5pkT9zDdLxFFzArCNXMO3Tc2X+S4iPVtkuXzXvjMEALCd1ZqDm46
        FNWlqf+ryyroEo9xNQ/+ScC37o8lajhp0kExekQ=
X-Google-Smtp-Source: AA0mqf6yeL/kc+GepGU3lHwiws6jGGEpvGMgRGXApxJyDYVtsnBS08Lxnq97WJBlvE5zOz5GgDwYWXD1f3rHkpU/XMM=
X-Received: by 2002:a05:6402:1a:b0:467:30ad:c4ca with SMTP id
 d26-20020a056402001a00b0046730adc4camr2658516edu.285.1668699796927; Thu, 17
 Nov 2022 07:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com> <20221026144208.373504-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221026144208.373504-2-xianting.tian@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 17 Nov 2022 23:43:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS4XzZXLR_+mhWUce3HFNP0KrVdBAexq+RAxuHrThuhEg@mail.gmail.com>
Message-ID: <CAJF2gTS4XzZXLR_+mhWUce3HFNP0KrVdBAexq+RAxuHrThuhEg@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, bagasdotme@gmail.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Guo Ren <guoren@kernel.org>

On Wed, Oct 26, 2022 at 10:42 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
> VMEMMAP ranges and KERNEL_LINK_ADDR), va bits and ram base for vmcore.
>
> Default pagetable levels and PAGE_OFFSET aren't same for different kernel
> version as below. For pagetable levels, it sets sv57 by default and falls
> back to setting sv48 at boot time if sv57 is not supported by the hardware.
>
> For ram base, the default value is 0x80200000 for qemu riscv64 env and,
> for example, is 0x200000 on the XuanTie 910 CPU.
>
>  * Linux Kernel 5.18 ~
>  *      PGTABLE_LEVELS = 5
>  *      PAGE_OFFSET = 0xff60000000000000
>  * Linux Kernel 5.17 ~
>  *      PGTABLE_LEVELS = 4
>  *      PAGE_OFFSET = 0xffffaf8000000000
>  * Linux Kernel 4.19 ~
>  *      PGTABLE_LEVELS = 3
>  *      PAGE_OFFSET = 0xffffffe000000000
>
> Since these configurations change from time to time and version to version,
> it is preferable to export them via vmcoreinfo than to change the crash's
> code frequently, it can simplify the development of crash tool.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/Makefile     |  1 +
>  arch/riscv/kernel/crash_core.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 arch/riscv/kernel/crash_core.c
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index db6e4b1294ba..4cf303a779ab 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)            += kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)       += kexec_relocate.o crash_save_regs.o machine_kexec.o
>  obj-$(CONFIG_KEXEC_FILE)       += elf_kexec.o machine_kexec_file.o
>  obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o
> +obj-$(CONFIG_CRASH_CORE)       += crash_core.o
>
>  obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
>
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> new file mode 100644
> index 000000000000..b351a3c01355
> --- /dev/null
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/crash_core.h>
> +#include <linux/pagemap.h>
> +
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +       VMCOREINFO_NUMBER(VA_BITS);
> +       VMCOREINFO_NUMBER(phys_ram_base);
> +
> +       vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> +       vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> +#ifdef CONFIG_64BIT
> +       vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> +       vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> +#endif
> +       vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> +}
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren
