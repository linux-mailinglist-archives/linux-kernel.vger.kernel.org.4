Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507D05B340D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiIIJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiIIJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:34:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C93556B81
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:32:48 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2s3CBtjOE8VAA--.18278S3;
        Fri, 09 Sep 2022 17:32:40 +0800 (CST)
Subject: Re: [PATCH v2 1/3] LoongArch: Add kexec support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1662693621-31053-1-git-send-email-tangyouling@loongson.cn>
 <1662693621-31053-2-git-send-email-tangyouling@loongson.cn>
 <CAAhV-H5nb5c6+wsSqWRUN176nBhgQVk18pKEDZ_7Qr752Scj=w@mail.gmail.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>, kexec@lists.infradead.org,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <1a94b100-e3f7-a5cb-d4b4-4d452f6146eb@loongson.cn>
Date:   Fri, 9 Sep 2022 17:32:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5nb5c6+wsSqWRUN176nBhgQVk18pKEDZ_7Qr752Scj=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx_2s3CBtjOE8VAA--.18278S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uF4UWF48XrykAw18Wr4Uurg_yoW8XrWUJo
        ZxtF4xtw4xKryUGw15G3s8XFZ8Z3s0gry5Z3y7AwsxWF12ya4UWr1UKryYy3y3K3Wvg3y8
        Ga43X3sI9a97Xrn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYL7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjwSdDUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 09/09/2022 04:16 PM, Huacai Chen wrote:
> Hi, Youling,
>
> On Fri, Sep 9, 2022 at 11:20 AM Youling Tang <tangyouling@loongson.cn> wrote:
>>
>> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
>> LoongArch architecture that add support for the kexec re-boot mechanis
>> (CONFIG_KEXEC) on LoongArch platforms.
>>
>> Supports loading vmlinux (vmlinux.elf) in ELF format and vmlinux.efi in
>> PE format.
>>
>> I tested this on  LoongArch 3A5000 machine and works as expected,
>>
>>  $ sudo kexec -l /boot/vmlinux.efi --reuse-cmdline
>>  $ sudo kexec -e
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>  arch/loongarch/Kconfig                  |  11 ++
>>  arch/loongarch/include/asm/kexec.h      |  58 ++++++++
>>  arch/loongarch/kernel/Makefile          |   2 +
>>  arch/loongarch/kernel/head.S            |   7 +-
>>  arch/loongarch/kernel/machine_kexec.c   | 188 ++++++++++++++++++++++++
>>  arch/loongarch/kernel/relocate_kernel.S | 106 +++++++++++++
>>  6 files changed, 371 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/loongarch/include/asm/kexec.h
>>  create mode 100644 arch/loongarch/kernel/machine_kexec.c
>>  create mode 100644 arch/loongarch/kernel/relocate_kernel.S
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 9b1f2ab878e9..08e063aaf847 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -422,6 +422,17 @@ config ARCH_IOREMAP
>>           protection support. However, you can enable LoongArch DMW-based
>>           ioremap() for better performance.
>>
>> +config KEXEC
>> +       bool "Kexec system call"
>> +       select KEXEC_CORE
>> +       help
>> +         kexec is a system call that implements the ability to shutdown your
>> +         current kernel, and to start another kernel.  It is like a reboot
>> +         but it is independent of the system firmware.   And like a reboot
>> +         you can start any kernel with it, not just Linux.
>> +
>> +         The name comes from the similarity to the exec system call.
>> +
>>  config SECCOMP
>>         bool "Enable seccomp to safely compute untrusted bytecode"
>>         depends on PROC_FS
>> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
>> new file mode 100644
>> index 000000000000..f23506725e00
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/kexec.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * kexec.h for kexec
>> + *
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>> + */
>> +
>> +#ifndef _ASM_KEXEC_H
>> +#define _ASM_KEXEC_H
>> +
>> +#include <asm/stacktrace.h>
>> +#include <asm/page.h>
>> +
>> +/* Maximum physical address we can use pages from */
>> +#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
>> +/* Maximum address we can reach in physical address mode */
>> +#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
>> + /* Maximum address we can use for the control code buffer */
>> +#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
>> +
>> +/* Reserve a page for the control code buffer */
>> +#define KEXEC_CONTROL_PAGE_SIZE PAGE_SIZE
>> +
>> +/* The native architecture */
>> +#define KEXEC_ARCH KEXEC_ARCH_LOONGARCH
>> +
>> +static inline void crash_setup_regs(struct pt_regs *newregs,
>> +                                   struct pt_regs *oldregs)
>> +{
>> +       if (oldregs)
>> +               memcpy(newregs, oldregs, sizeof(*newregs));
>> +       else
>> +               prepare_frametrace(newregs);
>> +}
>> +
>> +#define ARCH_HAS_KIMAGE_ARCH
>> +
>> +struct kimage_arch {
>> +       unsigned long boot_flag;
>> +       unsigned long fdt_addr;
>> +};
> I prefer to change boot_flag to efi_boot, the latter is better to
> correspond the current usage, and keeps consistency with efistub.
>

OK.
>> +
>> +typedef void (*do_kexec_t)(unsigned long boot_flag,
>> +                          unsigned long fdt_addr,
>> +                          unsigned long first_ind_entry,
>> +                          unsigned long jump_addr);
> I prefer change the order of jump_addr and first_ind_entry here.

OK.
>
>> +
>> +struct kimage;
>> +extern const unsigned char relocate_new_kernel[];
>> +extern const size_t relocate_new_kernel_size;
>> +extern void kexec_reboot(void);
>> +
>> +#ifdef CONFIG_SMP
>> +extern atomic_t kexec_ready_to_reboot;
>> +extern const unsigned char kexec_smp_wait[];
>> +#endif
>> +
>> +#endif /* !_ASM_KEXEC_H */
>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>> index 7225916dd378..17dc8ce6b5ce 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -17,6 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)     += fpu.o
>>  obj-$(CONFIG_MODULES)          += module.o module-sections.o
>>  obj-$(CONFIG_STACKTRACE)       += stacktrace.o
>>
>> +obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o
>> +
>>  obj-$(CONFIG_PROC_FS)          += proc.o
>>
>>  obj-$(CONFIG_SMP)              += smp.o
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index eb3f641d5915..0f786d670e66 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -20,7 +20,12 @@
>>
>>  _head:
>>         .word   MZ_MAGIC                /* "MZ", MS-DOS header */
>> -       .org    0x3c                    /* 0x04 ~ 0x3b reserved */
>> +       .org    0x8
>> +       .quad   0                       /* Image load offset from start of RAM */
>> +       .dword  _end - _text            /* Effective size of kernel image */
>> +       .quad   0
>> +       .dword  kernel_entry            /* Kernel entry point */
>> +       .org    0x3c                    /* 0x28 ~ 0x3b reserved */
>>         .long   pe_header - _head       /* Offset to the PE header */
> As discussed before, I prefer kernel entry point before kernel image size.

I will modify it in the next version, and will modify the kexec-tools
tool at the same time.

>
>>
>>  pe_header:
>> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
>> new file mode 100644
>> index 000000000000..7b3fea506c6d
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/machine_kexec.c
>> @@ -0,0 +1,188 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * machine_kexec.c for kexec
>> + *
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>> + */
>> +#include <linux/compiler.h>
>> +#include <linux/cpu.h>
>> +#include <linux/kexec.h>
>> +#include <linux/mm.h>
>> +#include <linux/delay.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/of_fdt.h>
>> +
>> +#include <asm/bootinfo.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/page.h>
>> +
>> +/* 0x100000 ~ 0x200000 is safe */
>> +#define KEXEC_CTRL_CODE        TO_CACHE(0x100000UL)
>> +#define KEXEC_BLOB_ADDR        TO_CACHE(0x108000UL)
>> +
>> +static unsigned long reboot_code_buffer;
>> +
>> +#ifdef CONFIG_SMP
>> +static void (*relocated_kexec_smp_wait)(void *);
>> +atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
>> +#endif
>> +
>> +static unsigned long jump_addr;
>> +static unsigned long first_ind_entry;
>> +static unsigned long boot_flag;
>> +static unsigned long fdt_addr;
> Keep the same order as do_kexec() may be better.

OK.
>
>> +
>> +static void kexec_image_info(const struct kimage *kimage)
>> +{
>> +       unsigned long i;
>> +
>> +       pr_debug("kexec kimage info:\n");
>> +       pr_debug("\ttype:        %d\n", kimage->type);
>> +       pr_debug("\tstart:       %lx\n", kimage->start);
>> +       pr_debug("\thead:        %lx\n", kimage->head);
>> +       pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
>> +
>> +       for (i = 0; i < kimage->nr_segments; i++) {
>> +               pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
>> +                       kimage->segment[i].mem,
>> +                       kimage->segment[i].mem + kimage->segment[i].memsz);
>> +               pr_debug("\t\t0x%lx bytes, %lu pages\n",
>> +                       (unsigned long)kimage->segment[i].memsz,
>> +                       (unsigned long)kimage->segment[i].memsz /  PAGE_SIZE);
>> +       }
>> +}
>> +
>> +int machine_kexec_prepare(struct kimage *kimage)
>> +{
>> +       int i;
>> +       void *dtb = (void *)KEXEC_BLOB_ADDR;
>> +
>> +       kexec_image_info(kimage);
>> +
>> +       /* Find the Flattened Device Tree */
>> +       for (i = 0; i < kimage->nr_segments; i++) {
>> +               if (!fdt_check_header(kimage->segment[i].buf)) {
>> +                       memcpy(dtb, kimage->segment[i].buf, SZ_64K);
>> +                       kimage->arch.boot_flag = fw_arg0;
>> +                       kimage->arch.fdt_addr = (unsigned long) dtb;
>> +                       break;
>> +               }
>> +               continue;
>> +       }
>> +
>> +       /* kexec need a safe page to save reboot_code_buffer */
>> +       kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
>> +
>> +       reboot_code_buffer =
>> +         (unsigned long)page_address(kimage->control_code_page);
>> +       memcpy((void *)reboot_code_buffer, relocate_new_kernel,
>> +              relocate_new_kernel_size);
>> +
>> +#ifdef CONFIG_SMP
>> +       /* All secondary cpus now may jump to kexec_smp_wait cycle */
>> +       relocated_kexec_smp_wait = reboot_code_buffer +
>> +               (void *)(kexec_smp_wait - relocate_new_kernel);
>> +#endif
>> +
>> +       return 0;
>> +}
>> +
>> +void machine_kexec_cleanup(struct kimage *kimage)
>> +{
>> +}
>> +
>> +void kexec_reboot(void)
>> +{
>> +       do_kexec_t do_kexec = NULL;
>> +
> The old implementation has an "ibar" here, I suppose it is still needed?

The new implementation no longer has to turn off the non-boot cpus and
then turn it back on when doing multi-core kexec operations, so I don't
think there's any need to use ibar to make sure the remote CPUs are
online (as I didn't make it go offline).

>
>> +#ifdef CONFIG_SMP
>> +       /* All secondary cpus go to kexec_smp_wait */
>> +       if (smp_processor_id() > 0) {
>> +               relocated_kexec_smp_wait(NULL);
>> +               unreachable();
>> +       }
>> +#endif
>> +
>> +       do_kexec = (void *)reboot_code_buffer;
>> +       do_kexec(boot_flag, fdt_addr, first_ind_entry, jump_addr);
>> +
>> +       unreachable();
>> +}
>> +
>> +
>> +#ifdef CONFIG_SMP
>> +static void kexec_shutdown_secondary(void *)
>> +{
>> +       local_irq_disable();
>> +       while (!atomic_read(&kexec_ready_to_reboot))
>> +               cpu_relax();
>> +
>> +       kexec_reboot();
> The old implementation has an unreachable() after kexec_reboot(), but
> I don't know whether it is really needed.
>

I have marked as unreachable() in kexec_reboot, IMO, the place where
kexec_reboot is called no longer needs to be marked as unreachable().

>> +}
>> +#endif
>> +
>> +void machine_crash_shutdown(struct pt_regs *regs)
>> +{
>> +}
>> +
>> +void machine_shutdown(void)
>> +{
>> +#ifdef CONFIG_SMP
>> +       smp_call_function(kexec_shutdown_secondary, NULL, 0);
>> +#endif
>> +}
>> +
>> +void machine_kexec(struct kimage *image)
>> +{
>> +       unsigned long entry;
>> +       unsigned long *ptr;
>> +       struct kimage_arch *internal = &image->arch;
>> +
>> +       boot_flag = internal->boot_flag;
>> +       fdt_addr = internal->fdt_addr;
>> +
>> +       jump_addr = (unsigned long)phys_to_virt(image->start);
>> +
>> +       first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
>> +
>> +       /*
>> +        * The generic kexec code builds a page list with physical
>> +        * addresses. they are directly accessible through XKPRANGE
>> +        * hence the phys_to_virt() call.
>> +        */
>> +       for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE);
>> +            ptr = (entry & IND_INDIRECTION) ?
>> +              phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
>> +               if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
>> +                   *ptr & IND_DESTINATION)
>> +                       *ptr = (unsigned long) phys_to_virt(*ptr);
>> +       }
>> +
>> +       /* Mark offline before disabling local irq. */
>> +       set_cpu_online(smp_processor_id(), false);
>> +
>> +       /* we do not want to be bothered. */
>> +       local_irq_disable();
>> +
>> +       pr_notice("Will call new kernel at %lx\n", jump_addr);
>> +       pr_notice("FDT image at %lx\n", fdt_addr);
>> +       pr_notice("Bye ...\n");
>> +
>> +       /* Make reboot code buffer available to the boot CPU. */
>> +       flush_cache_all();
>> +
>> +#ifdef CONFIG_SMP
>> +       atomic_set(&kexec_ready_to_reboot, 1);
>> +#endif
>> +
>> +       /*
>> +        * We know we were online, and there will be no incoming IPIs at
>> +        * this point.
>> +        */
>> +       set_cpu_online(smp_processor_id(), true);
>> +
>> +       /* Ensure remote CPUs observe that we're online before rebooting. */
>> +       smp_mb__after_atomic();
>> +
>> +       kexec_reboot();
>> +}
>> diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/kernel/relocate_kernel.S
>> new file mode 100644
>> index 000000000000..05a0c1ccfab6
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/relocate_kernel.S
>> @@ -0,0 +1,106 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * relocate_kernel.S for kexec
>> + *
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/kexec.h>
>> +
>> +#include <asm/asm.h>
>> +#include <asm/asmmacro.h>
>> +#include <asm/regdef.h>
>> +#include <asm/loongarch.h>
>> +#include <asm/stackframe.h>
>> +#include <asm/addrspace.h>
>> +
>> +SYM_CODE_START(relocate_new_kernel)
>> +       /*
>> +        * s0: Boot flag passed to the new kernel
>> +        * s1: Virt address of the FDT image
>> +        * s2: Pointer to the current entry
> "Pointer to the current entry" can be "Pointer to the current
> indirection page entry"? And I think we needn't backup Ax to Sx except
> this one in the assembly below.
>

Since there are no function calls in between, I can remove the backup
of the a-series registers.

Thanks,
Youling.

> Huacai
>
>> +        * s3: Virt address to jump to after relocation
>> +        */
>> +       move            s0, a0
>> +       move            s1, a1
>> +       move            s2, a2
>> +       move            s3, a3
>> +
>> +process_entry:
>> +       PTR_L           s4, s2, 0
>> +       PTR_ADDI        s2, s2, SZREG
>> +
>> +       /* destination page */
>> +       andi            s5, s4, IND_DESTINATION
>> +       beqz            s5, 1f
>> +       li.w            t0, ~0x1
>> +       and             s6, s4, t0      /* store destination addr in s6 */
>> +       b               process_entry
>> +
>> +1:
>> +       /* indirection page, update s2  */
>> +       andi            s5, s4, IND_INDIRECTION
>> +       beqz            s5, 1f
>> +       li.w            t0, ~0x2
>> +       and             s2, s4, t0
>> +       b               process_entry
>> +
>> +1:
>> +       /* done page */
>> +       andi            s5, s4, IND_DONE
>> +       beqz            s5, 1f
>> +       b               done
>> +1:
>> +       /* source page */
>> +       andi            s5, s4, IND_SOURCE
>> +       beqz            s5, process_entry
>> +       li.w            t0, ~0x8
>> +       and             s4, s4, t0
>> +       li.w            s8, (1 << _PAGE_SHIFT) / SZREG
>> +
>> +copy_word:
>> +       /* copy page word by word */
>> +       REG_L           s7, s4, 0
>> +       REG_S           s7, s6, 0
>> +       PTR_ADDI        s6, s6, SZREG
>> +       PTR_ADDI        s4, s4, SZREG
>> +       LONG_ADDI       s8, s8, -1
>> +       beqz            s8, process_entry
>> +       b               copy_word
>> +       b               process_entry
>> +
>> +done:
>> +       ibar            0
>> +       dbar            0
>> +
>> +       move            a0, s0
>> +       move            a1, s1
>> +       /* jump to the new kernel */
>> +       jr              s3
>> +SYM_CODE_END(relocate_new_kernel)
>> +
>> +#ifdef CONFIG_SMP
>> +/*
>> + * Other CPUs should wait until code is relocated and
>> + * then start at entry (?) point.
>> + */
>> +SYM_CODE_START(kexec_smp_wait)
>> +1:     li.w            t0, 0x100                       /* wait for init loop */
>> +2:     addi.w          t0, t0, -1                      /* limit mailbox access */
>> +       bnez            t0, 2b
>> +       li.w            t1, LOONGARCH_IOCSR_MBUF0
>> +       iocsrrd.w       s1, t1                          /* check PC as an indicator */
>> +       beqz            s1, 1b
>> +       iocsrrd.d       s1, t1                          /* get PC via mailbox */
>> +
>> +       li.d            t0, CACHE_BASE
>> +       or              s1, s1, t0                      /* s1 = TO_CACHE(s1) */
>> +       jr              s1                              /* jump to initial PC */
>> +SYM_CODE_END(kexec_smp_wait)
>> +#endif
>> +
>> +relocate_new_kernel_end:
>> +
>> +SYM_DATA_START(relocate_new_kernel_size)
>> +       PTR             relocate_new_kernel_end - relocate_new_kernel
>> +SYM_DATA_END(relocate_new_kernel_size)
>> --
>> 2.36.0
>>

