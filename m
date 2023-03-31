Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0186D197B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjCaILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjCaILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:11:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5831135A1;
        Fri, 31 Mar 2023 01:11:30 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxJ_BdlSZkvuAUAA--.32184S3;
        Fri, 31 Mar 2023 16:10:06 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxtrzZlCZkDuoRAA--.12556S3;
        Fri, 31 Mar 2023 16:08:09 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Qing Zhang <zhangqing@loongson.cn>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230328111714.2056-1-zhangqing@loongson.cn>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <8b472ba9-a39d-b9cc-d515-c1a9d42ae865@loongson.cn>
Date:   Fri, 31 Mar 2023 16:07:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230328111714.2056-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxtrzZlCZkDuoRAA--.12556S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GF43try5WF4rZF13AryrJFb_yoWDGF47pr
        WkCFyvgrWktF1Ig3yrKr1UJr1DJrs3Ga12gF13JFWfCF4xu3s2gr1DKFWkta4UXw4kJFyF
        gFn5uayjq39rt37anT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bsAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
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

Maybe you need to update `Documentation/translations/zh_CN/dev-tools
/kasan.rst` synchronously.

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

When the "earlycon=uart,mmio,0x1fe001e0,115200n8" cmdline parameter is
added under CONFIG_KASAN, the kernel will not start normally and stay
at the following position:
...
[    0.000000] On node 0, zone DMA32: 4 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 8 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 8 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 160 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 256 pages in unavailable ranges


The reason is that when accessing the serial port address `0x1fe001e0`,
kasan will add relevant checks, such as inserting `__asan_load1()`, and
will eventually enter the `default` branch in kasan_mem_to_shadow(),
causing the kernel to fail to start.

Add the following modification to avoid inserting the kasan check in
8250_early.o, and it will be able to start successfully.

diff --git a/drivers/tty/serial/8250/Makefile 
b/drivers/tty/serial/8250/Makefile
index 4fc2fc1f41b6..3c17d0e72c83 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -3,6 +3,8 @@
  # Makefile for the 8250 serial device drivers.
  #

+KASAN_SANITIZE_8250_early.o            := n
+
  obj-$(CONFIG_SERIAL_8250)              += 8250.o 8250_base.o
  8250-y                                 := 8250_core.o
  8250-$(CONFIG_ALPHA_GENERIC)           += 8250_alpha.o

Thanks,
Youling

