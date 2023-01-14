Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9398F66A9C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjANGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjANGyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:54:16 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EFD646A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:54:12 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8BxqOmTUcJjBJsBAA--.1211S3;
        Sat, 14 Jan 2023 14:54:11 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxc+WQUcJjP04ZAA--.12578S3;
        Sat, 14 Jan 2023 14:54:10 +0800 (CST)
Subject: Re: [PATCH 3/4] LoongArch: Add support for kernel relocation
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
 <1673255274-18238-4-git-send-email-tangyouling@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <76395966-35ca-83b5-7d7c-d6717b39e048@loongson.cn>
Date:   Sat, 14 Jan 2023 14:54:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1673255274-18238-4-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxc+WQUcJjP04ZAA--.12578S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XryfGrWDWw1rKFWxZr1DWrg_yoWfGFyDpr
        ZrZr4kJr4xGF17Jrn2qa4rury5Zws7Ww43W3ZrKryrCF1avF1ruw4v9rnrXFW0qws5Gr40
        qFyF9asFya1UAaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4BHqDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-01-09 17:07, Youling Tang wrote:
> arch/loongarch/kernel/relocate.c contains the functions necessary to
> relocate the kernel elsewhere in memory.
>
> The kernel makes a copy of itself at the new address. It uses the
> relocation table inserted by the relocs tool to fix symbol references
> within the new image.
>
> If copy/relocation is successful then the entry point of the new kernel
> is returned, otherwise fall back to starting the kernel in place.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>   arch/loongarch/Kconfig              | 15 +++++
>   arch/loongarch/Makefile             |  5 ++
>   arch/loongarch/kernel/Makefile      |  2 +
>   arch/loongarch/kernel/head.S        | 18 ++++++
>   arch/loongarch/kernel/relocate.c    | 96 +++++++++++++++++++++++++++++
>   arch/loongarch/kernel/vmlinux.lds.S | 11 +++-
>   6 files changed, 145 insertions(+), 2 deletions(-)
>   create mode 100644 arch/loongarch/kernel/relocate.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 9cc8b84f7eb0..089a4695b1b3 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -48,6 +48,7 @@ config LOONGARCH
>   	select ARCH_SUPPORTS_ATOMIC_RMW
>   	select ARCH_SUPPORTS_HUGETLBFS
>   	select ARCH_SUPPORTS_NUMA_BALANCING
> +	select SYS_SUPPORTS_RELOCATABLE
>   	select ARCH_USE_BUILTIN_BSWAP
>   	select ARCH_USE_CMPXCHG_LOCKREF
>   	select ARCH_USE_QUEUED_RWLOCKS
> @@ -229,6 +230,11 @@ config SCHED_OMIT_FRAME_POINTER
>   config AS_HAS_EXPLICIT_RELOCS
>   	def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
>   
> +config SYS_SUPPORTS_RELOCATABLE
> +	bool
> +	help
> +	  Selected if the platform supports relocating the kernel.
> +
>   menu "Kernel type and options"
>   
>   source "kernel/Kconfig.hz"
> @@ -474,6 +480,15 @@ config PHYSICAL_START
>   	  specified in the "crashkernel=YM@XM" command line boot parameter
>   	  passed to the panic-ed kernel).
>   
> +config RELOCATABLE
> +	bool "Relocatable kernel"
> +	depends on SYS_SUPPORTS_RELOCATABLE
> +	help
> +	  This builds the kernel as a Position Independent Executable (PIE),
> +	  which retains all relocation metadata required to relocate the
> +	  kernel binary at runtime to a different virtual address than the
> +	  address it was linked at.
> +
>   config SECCOMP
>   	bool "Enable seccomp to safely compute untrusted bytecode"
>   	depends on PROC_FS
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 4402387d2755..27b5a70ff31c 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -71,6 +71,11 @@ KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
>   KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
>   endif
>   
> +ifeq ($(CONFIG_RELOCATABLE),y)
> +LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
> +KBUILD_CFLAGS_KERNEL		+= -fPIE
> +endif
> +
>   cflags-y += -ffreestanding
>   cflags-y += $(call cc-option, -mno-check-zero-division)
>   
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index fcaa024a685e..33787d22e6f4 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -31,6 +31,8 @@ endif
>   obj-$(CONFIG_MODULES)		+= module.o module-sections.o
>   obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>   
> +obj-$(CONFIG_RELOCATABLE)	+= relocate.o
> +
>   obj-$(CONFIG_PROC_FS)		+= proc.o
>   
>   obj-$(CONFIG_SMP)		+= smp.o
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index e8a4bf9d7599..6db1549177ad 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -88,7 +88,25 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>   	PTR_ADD		sp, sp, tp
>   	set_saved_sp	sp, t0, t1
>   
> +#ifdef CONFIG_RELOCATABLE
> +	/* Copy kernel and apply the relocations */
> +	bl		relocate_kernel
> +
> +	/* Repoint the sp into the new kernel image */
> +	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
> +	PTR_ADD		sp, sp, tp
> +	set_saved_sp	sp, t0, t1
> +	PTR_ADDI	sp, sp, -4 * SZREG      # init stack pointer
> +
> +	/*
> +	 * relocate_kernel returns the entry point either
> +	 * in the relocated kernel or the original if for
> +	 * some reason relocation failed.
> +	*/
> +	jr		a0
> +#else
>   	bl		start_kernel
> +#endif
>   	ASM_BUG()
>   
>   SYM_CODE_END(kernel_entry)
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
> new file mode 100644
> index 000000000000..a58551c0698d
> --- /dev/null
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for Kernel relocation at boot time
> + *
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/elf.h>
> +#include <linux/kernel.h>
> +#include <linux/start_kernel.h>
> +#include <linux/printk.h>
> +#include <linux/panic_notifier.h>
> +#include <asm/bootinfo.h>
> +#include <asm/inst.h>
> +#include <asm/sections.h>
> +
> +#define RELOCATED(x) ((void *)((long)x + offset))
> +
> +extern long __rela_dyn_start;
> +extern long __rela_dyn_end;
> +
> +/*
> + * Choose a new address for the kernel, for now we'll hard
> + * code the destination.
> + */
> +static inline void __init *determine_relocation_address(void)
> +{
> +	return (void *)(CACHE_BASE + 0x02000000);
> +}
> +
> +static inline int __init relocation_addr_valid(void *loc_new)
> +{
> +	if ((unsigned long)loc_new & 0x0000ffff) {

Hi, Youling,


12bits-aligned is OK as actually R_LARCH_PCALA_LO12 is absolute.


BTW, I think the relocation of kernel looks like the '.so' solve its
Relocs at user space so that it can be placed any legal address. The
address is determined first, and relocation make it works on that address.
Thus, this patch always relocate kernel to 'CACHE_BASE + 0x02000000'
makes me puzzled. I think the relocation only works when the kernel
runtime address is different from the link-time address.


Thanks,
Jinyang


> +		/* Inappropriately aligned new location */
> +		return 0;
> +	}
> +	if ((unsigned long)loc_new < (unsigned long)_end) {
> +		/* New location overlaps original kernel */
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +void *__init relocate_kernel(void)
> +{
> +	Elf64_Rela *rela, *rela_end;
> +	void *loc_new;
> +	unsigned long kernel_length;
> +	long offset = 0;
> +	int res = 1;
> +	/* Default to original kernel entry point */
> +	void *kernel_entry = start_kernel;
> +
> +	kernel_length = (long)(_end) - (long)(_text);
> +
> +	loc_new = determine_relocation_address();
> +
> +	/* Sanity check relocation address */
> +	if (relocation_addr_valid(loc_new))
> +		offset = (unsigned long)loc_new - (unsigned long)(_text);
> +
> +	if (offset) {
> +		/* Copy the kernel to it's new location */
> +		memcpy(loc_new, _text, kernel_length);
> +
> +		/* Sync the caches ready for execution of new kernel */
> +		__asm__ __volatile__ (
> +			"ibar 0 \t\n"
> +			"dbar 0 \t\n");
> +
> +		rela = (Elf64_Rela *)RELOCATED(&__rela_dyn_start);
> +		rela_end = (Elf64_Rela *)RELOCATED(&__rela_dyn_end);
> +
> +		for ( ; rela < rela_end; rela++) {
> +			Elf64_Addr addr = rela->r_offset;
> +			Elf64_Addr relocated_addr = rela->r_addend;
> +
> +			if (rela->r_info != R_LARCH_RELATIVE)
> +				continue;
> +
> +			if (relocated_addr >= VMLINUX_LOAD_ADDRESS)
> +				relocated_addr = RELOCATED(relocated_addr);
> +
> +			*(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
> +
> +		}
> +
> +		/* The current thread is now within the relocated image */
> +		__current_thread_info = RELOCATED(__current_thread_info);
> +
> +		/* Return the new kernel's entry point */
> +		kernel_entry = RELOCATED(start_kernel);
> +	}
> +out:
> +	return kernel_entry;
> +}
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index 733b16e8d55d..aec0b6567d24 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -70,6 +70,8 @@ SECTIONS
>   	.plt : ALIGN(16) { *(.plt) }
>   	.got.plt : ALIGN(16) { *(.got.plt) }
>   
> +	.data.rel : { *(.data.rel*) }
> +
>   	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>   	__init_begin = .;
>   	__inittext_begin = .;
> @@ -93,8 +95,6 @@ SECTIONS
>   	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
>   #endif
>   
> -	.rela.dyn : ALIGN(8) { *(.rela.dyn) *(.rela*) }
> -
>   	.init.bss : {
>   		*(.init.bss)
>   	}
> @@ -107,6 +107,12 @@ SECTIONS
>   	RO_DATA(4096)
>   	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>   
> +	.rela.dyn : ALIGN(8) {
> +		__rela_dyn_start = .;
> +		 *(.rela.dyn) *(.rela*)
> +		__rela_dyn_end = .;
> +	}
> +
>   	.sdata : {
>   		*(.sdata)
>   	}
> @@ -133,6 +139,7 @@ SECTIONS
>   
>   	DISCARDS
>   	/DISCARD/ : {
> +		*(.dynamic .dynsym .dynstr .hash .gnu.hash)
>   		*(.gnu.attributes)
>   		*(.options)
>   		*(.eh_frame)

