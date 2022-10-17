Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193CB601812
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiJQTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJQTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101E10FF6;
        Mon, 17 Oct 2022 12:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB6461219;
        Mon, 17 Oct 2022 19:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF7CC433D7;
        Mon, 17 Oct 2022 19:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666036476;
        bh=RjBn26b54Qi9hFzWIH/n9PJ/ByfUPuIEutsDV4SvCtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2RTCDdWs6UFggXb3K1bjDM1eF7gIH+o00GFyEI3o6+eiVahUtptyD6IHMINLEsWi
         0KOmf1XXtv/HDz5Y8qRmDvOD0PbR+4BWl56eNEtKtaYE1XJpviwXu6GuH3XFXGZLW8
         5U8MxpQVRcXBcheWjwC9vurSJhUxVRho2nEHTREKcAnzJYPQtmeml7BSYRbbgsnA/t
         DXeOxcX7Cr3ZtI2KOfPkVHZyal9qM0I9dtSczyeyEO2Nt6l0PieRDuQisCVo4Wr3D6
         MWCBZ00RgKMjIbqmkjrqZ9rc+W81g7lW01kd7jVEHaKDeAkanf99OxClmxj27gyGiy
         9ZWx0u5faSFWg==
Date:   Mon, 17 Oct 2022 20:54:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V2 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y02y9eN1TNJteTw6@spud>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014134139.5151-2-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 09:41:38PM +0800, Xianting Tian wrote:
> Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
> VMEMMAP and KERNEL_LINK_ADDR ranges), va bits and ram base for vmcore.
> 
> Default pagetable levels and PAGE_OFFSET aren't same for different kernel
> version as below. For default pagetable levels, it sets sv57 on defaultly
> in latest kernel and do fallback to try to set sv48 on boot time if sv57
> is not supported in current hardware.

nit: This would read better as "it sets sv57 by default and falls back
to setting sv48 at boot time if sv57 is not supported by the hardware".

> 
> For ram base, the default value is 0x80200000 for qemu riscv64 env, 0x200000
> for riscv64 SoC platform(eg, SoC platform of RISC-V XuanTie 910 CPU).

The second part of this sentence I'm not really sure that that is true,
I think you should reword it to something like "...for qemu riscv64 and,
for example, is 0x200000 on the XuanTie 910 CPU." and avoid applying
that number blanketly for other SoCs.
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
>  arch/riscv/kernel/crash_core.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 arch/riscv/kernel/crash_core.c
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index db6e4b1294ba..4cf303a779ab 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>  obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
> +obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
>  
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>  
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> new file mode 100644
> index 000000000000..8d7f5ff108da
> --- /dev/null
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/crash_core.h>
> +#include <linux/pagemap.h>
> +
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +	VMCOREINFO_NUMBER(VA_BITS);
> +	VMCOREINFO_NUMBER(phys_ram_base);
> +
> +	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> +#ifdef CONFIG_64BIT
> +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> +	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> +#endif
> +
> +	if (IS_ENABLED(CONFIG_64BIT)) {

You've already got a #ifdef CONFIG_64BIT above, is there a reason why
you'd use the IS_ENABLED here rather than merge this with the above
section? I'm a big fan of IS_ENABLED but I'm not sure what it adds here,
maybe you can show me the light :)

Thanks,
Conor.


> +#ifdef CONFIG_KASAN
> +		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_START)=0x%lx\n", KASAN_SHADOW_START);
> +		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_END)=0x%lx\n", KASAN_SHADOW_END);
> +#endif
> +		vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> +		vmcoreinfo_append_str("NUMBER(ADDRESS_SPACE_END)=0x%lx\n", ADDRESS_SPACE_END);
> +	}
> +}
> -- 
> 2.17.1
> 
> 
