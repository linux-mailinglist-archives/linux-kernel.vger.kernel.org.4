Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF96CFBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjC3GvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjC3Gu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:50:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E7A40D9;
        Wed, 29 Mar 2023 23:50:56 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxEk5PMSVkBUQUAA--.19702S3;
        Thu, 30 Mar 2023 14:50:55 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_75LMSVklQcRAA--.48492S3;
        Thu, 30 Mar 2023 14:50:53 +0800 (CST)
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
Message-ID: <4ad7dfe6-160a-d4a8-e262-1fb13a395510@loongson.cn>
Date:   Thu, 30 Mar 2023 14:50:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230328111714.2056-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx_75LMSVklQcRAA--.48492S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfJF1xuFWfKF4ftryrKrWUtwb_yoW8Jr47Xo
        WFkF43Kw4rGw47CrZ8Xw4DJ34Utr109r4kA3y7Zr1fuF1xAFWak3yUtw4Sgry3t34kKr13
        W3y2gFZ3J3sYyrn8n29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64
        kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
        kF7I0E14v26r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaV
        Av8VWrMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
        Y487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
        0_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ur73kU
        UUUU=
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

If we need to add __NO_FORTIFY processing, please add
ARCH_HAS_FORTIFY_SOURCE in Kconfig, and submit a separate patch like
9530141455c9 ("riscv: Add ARCH_HAS_FORTIFY_SOURCE").

Youling.

