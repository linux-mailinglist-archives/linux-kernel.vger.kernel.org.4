Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114346CBE41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjC1L6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1L6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:58:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67B376E8B;
        Tue, 28 Mar 2023 04:58:01 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxEk5H1iJkJhQTAA--.17781S3;
        Tue, 28 Mar 2023 19:57:59 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxur1F1iJkSmAPAA--.10783S3;
        Tue, 28 Mar 2023 19:57:58 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Qing Zhang <zhangqing@loongson.cn>
References: <20230328111714.2056-1-zhangqing@loongson.cn>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <39af0c57-acff-d36c-a67d-e4a6783b57cd@loongson.cn>
Date:   Tue, 28 Mar 2023 19:57:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230328111714.2056-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxur1F1iJkSmAPAA--.10783S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfJF1xuFWfKF4ftryrKrWUtwb_yoW8XFW5to
        WFkF17Kw48Gw47CrZ8Ww1DJFyUtr1qkrWkZ39rZr1fWF1xAFW3C3yUtayagry3t34kGr1f
        W3y2gFZay3sYyrn8n29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64
        kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
        kF7I0E14v26F4UJVW0owAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUUGjg7UU
        UUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing

On 03/28/2023 07:17 PM, Qing Zhang wrote:
> 1/8 of kernel addresses reserved for shadow memory. But for LoongArch,
> There are a lot of holes between different segments and valid address
> space(256T available) is insufficient to map all these segments to kasan
> shadow memory with the common formula provided by kasan core, saying
> addr >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET
>
> So Loongarch has a ARCH specific mapping formula,different segments
`Loongarch` -> `LoongArch`

> are mapped individually, and only limited length of space of that
> specific segment is mapped to shadow.
>
> At early boot stage the whole shadow region populated with just
> one physical page (kasan_early_shadow_page). Later, this page is
> reused as readonly zero shadow for some memory that Kasan currently
> don't track.
> After mapping the physical memory, pages for shadow memory are
> allocated and mapped.
>
> Functions like memset/memmove/memcpy do a lot of memory accesses.
> If bad pointer passed to one of these function it is important
> to catch this. Compiler's instrumentation cannot do this since
> these functions are written in assembly.
> KASan replaces memory functions with manually instrumented variants.
> Original functions declared as weak symbols so strong definitions
> in mm/kasan/kasan.c could replace them. Original functions have aliases
> with '__' prefix in name, so we could call non-instrumented variant
> if needed.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  Documentation/dev-tools/kasan.rst             |   4 +-
>  .../features/debug/KASAN/arch-support.txt     |   2 +-
>  arch/loongarch/Kconfig                        |   7 +
>  arch/loongarch/include/asm/kasan.h            | 120 +++++++++
>  arch/loongarch/include/asm/pgtable.h          |   7 +
>  arch/loongarch/include/asm/setup.h            |   2 +-
>  arch/loongarch/include/asm/string.h           |  20 ++
>  arch/loongarch/kernel/Makefile                |   3 +
>  arch/loongarch/kernel/head.S                  |  14 +-
>  arch/loongarch/kernel/relocate.c              |   8 +-
>  arch/loongarch/kernel/setup.c                 |   4 +
>  arch/loongarch/lib/memcpy.S                   |   4 +-
>  arch/loongarch/lib/memmove.S                  |  13 +-
>  arch/loongarch/lib/memset.S                   |   4 +-
>  arch/loongarch/mm/Makefile                    |   2 +
>  arch/loongarch/mm/kasan_init.c                | 255 ++++++++++++++++++
>  arch/loongarch/vdso/Makefile                  |   4 +
>  include/linux/kasan.h                         |   2 +
>  mm/kasan/generic.c                            |   5 +
>  mm/kasan/init.c                               |  10 +-
>  mm/kasan/kasan.h                              |   6 +
>  21 files changed, 470 insertions(+), 26 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kasan.h
>  create mode 100644 arch/loongarch/mm/kasan_init.c
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index e66916a483cd..ee91f2872767 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -41,8 +41,8 @@ Support
>  Architectures
>  ~~~~~~~~~~~~~
>
> -Generic KASAN is supported on x86_64, arm, arm64, powerpc, riscv, s390, and
> -xtensa, and the tag-based KASAN modes are supported only on arm64.
> +Generic KASAN is supported on x86_64, arm, arm64, powerpc, riscv, s390, xtensa,
> +and loongarch, and the tag-based KASAN modes are supported only on arm64.
>
>  Compilers
>  ~~~~~~~~~
> diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
> index bf0124fae643..c4581c2edb28 100644
> --- a/Documentation/features/debug/KASAN/arch-support.txt
> +++ b/Documentation/features/debug/KASAN/arch-support.txt
> @@ -13,7 +13,7 @@
>      |        csky: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> -    |   loongarch: | TODO |
> +    |   loongarch: |  ok  |
>      |        m68k: | TODO |
>      |  microblaze: | TODO |
>      |        mips: | TODO |
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 72dd00f48b8c..61f883c51045 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -7,6 +7,7 @@ config LOONGARCH
>  	select ACPI_MCFG if ACPI
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_BINFMT_ELF_STATE
> +	select ARCH_DISABLE_KASAN_INLINE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
> @@ -83,6 +84,7 @@ config LOONGARCH
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_KASAN if 64BIT
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select HAVE_ASM_MODVERSIONS
> @@ -626,6 +628,11 @@ config ARCH_MMAP_RND_BITS_MIN
>  config ARCH_MMAP_RND_BITS_MAX
>  	default 18
>
> +config KASAN_SHADOW_OFFSET
> +	hex
> +	default 0x0
> +	depends on KASAN
> +
>  menu "Power management options"
>
>  config ARCH_SUSPEND_POSSIBLE
> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
> new file mode 100644
> index 000000000000..582bcded311e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kasan.h
> @@ -0,0 +1,120 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_KASAN_H
> +#define __ASM_KASAN_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/linkage.h>
> +#include <linux/mmzone.h>
> +#include <asm/addrspace.h>
> +#include <asm/io.h>
> +#include <asm/pgtable.h>
> +
> +#define __HAVE_ARCH_SHADOW_MAP
> +
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +#define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +
> +#define XRANGE_SHIFT (48)
> +
> +/* Valid address length */
> +#define XRANGE_SHADOW_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
> +/* Used for taking out the valid address */
> +#define XRANGE_SHADOW_MASK	GENMASK_ULL(XRANGE_SHADOW_SHIFT - 1, 0)
> +/* One segment whole address space size */
> +#define	XRANGE_SIZE		(XRANGE_SHADOW_MASK + 1)
> +
> +/* 64-bit segment value. */
> +#define XKPRANGE_UC_SEG		(0x8000)
> +#define XKPRANGE_CC_SEG		(0x9000)
It is not recommended to use a fixed value, it can be as follows,

CACHE_BASE >> DMW_PABITS
UNCACHE_BASE >> DMW_PABITS

> +#define XKVRANGE_VC_SEG		(0xffff)
> +
> +/* Cached */
> +#define XKPRANGE_CC_START		CACHE_BASE
> +#define XKPRANGE_CC_SIZE		XRANGE_SIZE
> +#define XKPRANGE_CC_KASAN_OFFSET	(0)
> +#define XKPRANGE_CC_SHADOW_SIZE		(XKPRANGE_CC_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> +#define XKPRANGE_CC_SHADOW_END		(XKPRANGE_CC_KASAN_OFFSET + XKPRANGE_CC_SHADOW_SIZE)
> +
> +/* UnCached */
> +#define XKPRANGE_UC_START		UNCACHE_BASE
> +#define XKPRANGE_UC_SIZE		XRANGE_SIZE
> +#define XKPRANGE_UC_KASAN_OFFSET	XKPRANGE_CC_SHADOW_END
> +#define XKPRANGE_UC_SHADOW_SIZE		(XKPRANGE_UC_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> +#define XKPRANGE_UC_SHADOW_END		(XKPRANGE_UC_KASAN_OFFSET + XKPRANGE_UC_SHADOW_SIZE)
> +
> +/* VMALLOC (Cached or UnCached)  */
> +#define XKVRANGE_VC_START		MODULES_VADDR
> +#define XKVRANGE_VC_SIZE		round_up(VMEMMAP_END - MODULES_VADDR + 1, PGDIR_SIZE)
> +#define XKVRANGE_VC_KASAN_OFFSET	XKPRANGE_UC_SHADOW_END
> +#define XKVRANGE_VC_SHADOW_SIZE		(XKVRANGE_VC_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> +#define XKVRANGE_VC_SHADOW_END		(XKVRANGE_VC_KASAN_OFFSET + XKVRANGE_VC_SHADOW_SIZE)
> +
> +/* Kasan shadow memory start right after vmalloc. */
> +#define KASAN_SHADOW_START		round_up(VMEMMAP_END, PGDIR_SIZE)
> +#define KASAN_SHADOW_SIZE		(XKVRANGE_VC_SHADOW_END - XKPRANGE_CC_KASAN_OFFSET)
> +#define KASAN_SHADOW_END		round_up(KASAN_SHADOW_START + KASAN_SHADOW_SIZE, PGDIR_SIZE)
> +
> +#define XKPRANGE_CC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_CC_KASAN_OFFSET)
> +#define XKPRANGE_UC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_UC_KASAN_OFFSET)
> +#define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
> +
> +extern bool kasan_early_stage;
> +extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> +
> +static inline void *kasan_mem_to_shadow(const void *addr)
> +{
> +	if (kasan_early_stage) {
> +		return (void *)(kasan_early_shadow_page);
> +	} else {
> +		unsigned long maddr = (unsigned long)addr;
> +		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
> +		unsigned long offset = 0;
> +
> +		maddr &= XRANGE_SHADOW_MASK;
> +		switch (xrange) {
> +		case XKPRANGE_CC_SEG:
> +			offset = XKPRANGE_CC_SHADOW_OFFSET;
> +			break;
> +		case XKPRANGE_UC_SEG:
> +			offset = XKPRANGE_UC_SHADOW_OFFSET;
> +			break;
> +		case XKVRANGE_VC_SEG:
> +			offset = XKVRANGE_VC_SHADOW_OFFSET;
> +			break;
> +		default:
> +			WARN_ON(1);
> +			return NULL;
> +		}
> +
> +		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
> +	}
> +}
> +
> +static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
> +{
> +	unsigned long addr = (unsigned long)shadow_addr;
> +
> +	if (unlikely(addr > KASAN_SHADOW_END) ||
> +		unlikely(addr < KASAN_SHADOW_START)) {
> +		WARN_ON(1);
> +		return NULL;
> +	}
> +
> +	if (addr >= XKVRANGE_VC_SHADOW_OFFSET)
> +		return (void *)(((addr - XKVRANGE_VC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKVRANGE_VC_START);
> +	else if (addr >= XKPRANGE_UC_SHADOW_OFFSET)
> +		return (void *)(((addr - XKPRANGE_UC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKPRANGE_UC_START);
> +	else if (addr >= XKPRANGE_CC_SHADOW_OFFSET)
> +		return (void *)(((addr - XKPRANGE_CC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKPRANGE_CC_START);
> +	else {
> +		WARN_ON(1);
> +		return NULL;
> +	}
> +}
> +
> +void kasan_init(void);
> +asmlinkage void kasan_early_init(void);
> +
> +#endif
> +#endif
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index d28fb9dbec59..5cfdf79b287e 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -86,9 +86,16 @@ extern unsigned long zero_page_mask;
>  #define MODULES_END	(MODULES_VADDR + SZ_256M)
>
>  #define VMALLOC_START	MODULES_END
> +
> +#ifndef CONFIG_KASAN
>  #define VMALLOC_END	\
>  	(vm_map_base +	\
>  	 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
> +#else
> +#define VMALLOC_END	\
> +	(vm_map_base +	\
> +	 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits) / 2) - PMD_SIZE - VMEMMAP_SIZE)
> +#endif
>
>  #define vmemmap		((struct page *)((VMALLOC_END + PMD_SIZE) & PMD_MASK))
>  #define VMEMMAP_END	((unsigned long)vmemmap + VMEMMAP_SIZE - 1)
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
> index be05c0e706a2..2dca0d1dd90a 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -33,7 +33,7 @@ extern long __la_abs_end;
>  extern long __rela_dyn_begin;
>  extern long __rela_dyn_end;
>
> -extern void * __init relocate_kernel(void);
> +extern unsigned long __init relocate_kernel(void);
>
>  #endif
>
> diff --git a/arch/loongarch/include/asm/string.h b/arch/loongarch/include/asm/string.h
> index 7b29cc9c70aa..5bb5a90d2681 100644
> --- a/arch/loongarch/include/asm/string.h
> +++ b/arch/loongarch/include/asm/string.h
> @@ -7,11 +7,31 @@
>
>  #define __HAVE_ARCH_MEMSET
>  extern void *memset(void *__s, int __c, size_t __count);
> +extern void *__memset(void *__s, int __c, size_t __count);
>
>  #define __HAVE_ARCH_MEMCPY
>  extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
> +extern void *__memcpy(void *__to, __const__ void *__from, size_t __n);
>
>  #define __HAVE_ARCH_MEMMOVE
>  extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
> +extern void *__memmove(void *__dest, __const__ void *__src, size_t __n);
> +
> +#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> +
> +/*
> + * For files that are not instrumented (e.g. mm/slub.c) we
> + * should use not instrumented version of mem* functions.
> + */
> +
> +#define memset(s, c, n) __memset(s, c, n)
> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
> +#define memmove(dst, src, len) __memmove(dst, src, len)
> +
> +#ifndef __NO_FORTIFY
> +#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> +#endif
> +
> +#endif
>
>  #endif /* _ASM_STRING_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 9a72d91cd104..0055e7582e15 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -30,6 +30,9 @@ ifdef CONFIG_FUNCTION_TRACER
>    CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
>  endif
>
> +KASAN_SANITIZE_vdso.o := n
> +KASAN_SANITIZE_efi.o := n
> +
>  obj-$(CONFIG_MODULES)		+= module.o module-sections.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index aa64b179744f..19d4be5c8381 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -95,13 +95,17 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>  	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
>  	PTR_ADD		sp, sp, tp
>  	set_saved_sp	sp, t0, t1
> -#endif
> -
> -	/* relocate_kernel() returns the new kernel entry point */
> -	jr		a0
> -	ASM_BUG()
>
> +	/* Jump to new kernel: new_pc = current_pc + random_offset */
> +	pcaddi		t0, 0
> +	add.d		t0, t0, a0
> +	jirl		zero, t0, 0xc
>  #endif
> +#endif
> +
> +	#ifdef CONFIG_KASAN
> +	bl              kasan_early_init
> +	#endif
No tab operation is required before `#ifdef`.

>
>  	bl		start_kernel
>  	ASM_BUG()
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
> index 01f94d1e3edf..6c3eff9af9fb 100644
> --- a/arch/loongarch/kernel/relocate.c
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -157,12 +157,11 @@ static inline void __init update_reloc_offset(unsigned long *addr, long random_o
>  	*new_addr = (unsigned long)reloc_offset;
>  }
>
> -void * __init relocate_kernel(void)
> +unsigned long __init relocate_kernel(void)
>  {
>  	unsigned long kernel_length;
>  	unsigned long random_offset = 0;
>  	void *location_new = _text; /* Default to original kernel start */
> -	void *kernel_entry = start_kernel; /* Default to original kernel entry point */
>  	char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
>
>  	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
> @@ -190,9 +189,6 @@ void * __init relocate_kernel(void)
>
>  		reloc_offset += random_offset;
>
> -		/* Return the new kernel's entry point */
> -		kernel_entry = RELOCATED_KASLR(start_kernel);
> -
>  		/* The current thread is now within the relocated kernel */
>  		__current_thread_info = RELOCATED_KASLR(__current_thread_info);
>
> @@ -204,7 +200,7 @@ void * __init relocate_kernel(void)
>
>  	relocate_absolute(random_offset);
>
> -	return kernel_entry;
> +	return random_offset;
>  }
>
>  /*
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 27f71f9531e1..18453f8cb9e8 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -610,4 +610,8 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>
>  	paging_init();
> +
> +#if defined(CONFIG_KASAN)
> +	kasan_init();
> +#endif
Can be added in arch/loongarch/include/asm/kasan.h,
#else
static inline void kasan_init(void) { }
#endif


Youling.

