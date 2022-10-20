Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBEC606337
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJTOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJTOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FA513C3FC;
        Thu, 20 Oct 2022 07:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3A66191F;
        Thu, 20 Oct 2022 14:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A035BC43149;
        Thu, 20 Oct 2022 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666276533;
        bh=LCGJBSRGVbeIJ5hd+BFarnFeqPOj/yT1VOE+UzJXnLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t3MpQXzCAzbPYYQNCi/X7lFDoOgS/9UqN8kv4rFh4vkJRSmayfFAIgng+dPgApu1h
         K+HkCsugLs4cxx02GB0HCy+LSlw+v1eOTP6GY+w5qcO0y/ZI5LDm5jL5mAmG9IE84c
         MTsIWr/WgL6ioL5xnjn7gnAINWnMKEekKZj+Os+AbGAxpxKh/PpZlOTpL5Xc2Ikkq1
         NXJbl/pkOxMM6pC1bsU1CqeTvRUhktRu+ntO8oJxI03jA7rrxBZSmsZnXknUzNighM
         l3m0ThTZaFc/SCttY1PpOBpAPStSDMzZPMAm5nBdUtf0TPM9RQs8TajKziT/d56V8K
         NEyW01RiuzcVA==
Received: by mail-ot1-f41.google.com with SMTP id f4-20020a9d0384000000b0066208c73094so29869otf.0;
        Thu, 20 Oct 2022 07:35:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf05ZtMzXGwIqj4YOpnzGCmjtmTSYhWz9qchwgmHQAtgh38xf74l
        NvwwASleWukfbeyNgMP4ELXzxspE9kiLRDzMEC0=
X-Google-Smtp-Source: AMsMyM5qQ4ar9uJ0SPnN8rvwMF93C3T7WFzeBCvLwriEpZzXOZp8MGndWxMLk8oh/dMvf6wpqmkRhydSYqZeY40cZIY=
X-Received: by 2002:a9d:60dd:0:b0:661:b6ae:aa7a with SMTP id
 b29-20020a9d60dd000000b00661b6aeaa7amr6998580otk.140.1666276532511; Thu, 20
 Oct 2022 07:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com> <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Oct 2022 22:35:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSWX75fNMYeAK4ckGB9SQvJgfr-zSczirbdaBxHK6opVw@mail.gmail.com>
Message-ID: <CAJF2gTSWX75fNMYeAK4ckGB9SQvJgfr-zSczirbdaBxHK6opVw@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, bagasdotme@gmail.com,
        k-hagio-ab@nec.com, lijiang@redhat.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, hschauhan@nulltrace.org,
        yixun.lan@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Guo Ren <guoren@kernel.org>

Don't forget the another two kdump fixups [1]
[1] https://lore.kernel.org/all/20221020141603.2856206-3-guoren@kernel.org/

    Only the patch without [1]:
    crash> help -r
    CPU 0: [OFFLINE]

    CPU 1:
    epc : ffffffff80009ff0 ra : ffffffff800b789a sp : ff2000001098bb40
     gp : ffffffff815fca60 tp : ff60000004680000 t0 : 6666666666663c5b
     t1 : 0000000000000000 t2 : 666666666666663c s0 : ff2000001098bc90
     s1 : ffffffff81600798 a0 : ff2000001098bb48 a1 : 0000000000000000
     a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
     a5 : ff60000004690800 a6 : 0000000000000000 a7 : 0000000000000000
     s2 : ff2000001098bb48 s3 : ffffffff81093ec8 s4 : ffffffff816004ac
     s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80e7f720
     s8 : 00fffffffffff3f0 s9 : 0000000000000007 s10: 00aaaaaaaab98700
     s11: 0000000000000001 t3 : ffffffff819a8097 t4 : ffffffff819a8097
     t5 : ffffffff819a8098 t6 : ff2000001098b9a8

    CPU 2: [OFFLINE]

    CPU 3: [OFFLINE]

    The patch with [1]:
    crash> help -r
    CPU 0:
    epc : ffffffff80003f34 ra : ffffffff808caa7c sp : ffffffff81403eb0
     gp : ffffffff815fcb48 tp : ffffffff81413400 t0 : 0000000000000000
     t1 : 0000000000000000 t2 : 0000000000000000 s0 : ffffffff81403ec0
     s1 : 0000000000000000 a0 : 0000000000000000 a1 : 0000000000000000
     a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
     a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
     s2 : ffffffff816001c8 s3 : ffffffff81600370 s4 : ffffffff80c32e18
     s5 : ffffffff819d3018 s6 : ffffffff810e2110 s7 : 0000000000000000
     s8 : 0000000000000000 s9 : 0000000080039eac s10: 0000000000000000
     s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
     t5 : 0000000000000000 t6 : 0000000000000000

    CPU 1:
    epc : ffffffff80003f34 ra : ffffffff808caa7c sp : ff2000000068bf30
     gp : ffffffff815fcb48 tp : ff6000000240d400 t0 : 0000000000000000
     t1 : 0000000000000000 t2 : 0000000000000000 s0 : ff2000000068bf40
     s1 : 0000000000000001 a0 : 0000000000000000 a1 : 0000000000000000
     a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
     a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
     s2 : ffffffff816001c8 s3 : ffffffff81600370 s4 : ffffffff80c32e18
     s5 : ffffffff819d3018 s6 : ffffffff810e2110 s7 : 0000000000000000
     s8 : 0000000000000000 s9 : 0000000080039ea8 s10: 0000000000000000
     s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
     t5 : 0000000000000000 t6 : 0000000000000000

    CPU 2:
    epc : ffffffff80003f34 ra : ffffffff808caa7c sp : ff20000000693f30
     gp : ffffffff815fcb48 tp : ff6000000240e900 t0 : 0000000000000000
     t1 : 0000000000000000 t2 : 0000000000000000 s0 : ff20000000693f40
     s1 : 0000000000000002 a0 : 0000000000000000 a1 : 0000000000000000
     a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
     a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
     s2 : ffffffff816001c8 s3 : ffffffff81600370 s4 : ffffffff80c32e18
     s5 : ffffffff819d3018 s6 : ffffffff810e2110 s7 : 0000000000000000
     s8 : 0000000000000000 s9 : 0000000080039eb0 s10: 0000000000000000
     s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
     t5 : 0000000000000000 t6 : 0000000000000000

    CPU 3:
    epc : ffffffff8000a1e4 ra : ffffffff800b7bba sp : ff200000109bbb40
     gp : ffffffff815fcb48 tp : ff6000000373aa00 t0 : 6666666666663c5b
     t1 : 0000000000000000 t2 : 666666666666663c s0 : ff200000109bbc90
     s1 : ffffffff816007a0 a0 : ff200000109bbb48 a1 : 0000000000000000
     a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
     a5 : ff60000002c61c00 a6 : 0000000000000000 a7 : 0000000000000000
     s2 : ff200000109bbb48 s3 : ffffffff810941a8 s4 : ffffffff816004b4
     s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80e7f7a0
     s8 : 00fffffffffff3f0 s9 : 0000000000000007 s10: 00aaaaaaaab98700
     s11: 0000000000000001 t3 : ffffffff819a8097 t4 : ffffffff819a8097
     t5 : ffffffff819a8098 t6 : ff200000109bb9a8

On Wed, Oct 19, 2022 at 6:36 PM Xianting Tian
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
>  arch/riscv/kernel/crash_core.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
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
> index 000000000000..3e889d0ed7bd
> --- /dev/null
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -0,0 +1,23 @@
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
> +
> +       if (IS_ENABLED(CONFIG_64BIT))
> +               vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> +}
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren
