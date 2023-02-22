Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD86269F0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjBVJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjBVJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:05:38 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6389634C35
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677056732; bh=doLFNBfQZMguCbeNzfwuDelzgMYN2in0OqoSTR/dzs8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ieg+1+oj7bvZxBgU6vXwqlH66nTwwWaeqofYOlvDzl0kJ5vACan5Nf4WMbRqHu/kd
         cWaiKmakQ4rSVOdP7SXNUC316DhzO5PXwduBIKxsh8f1X4OPpAzghMZGeBKrUzZkDx
         Ga9xNsGIvuCd4XkJUu8kYh7c+9IDU6OIoKokIq2Y=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 27EB9600DA;
        Wed, 22 Feb 2023 17:05:32 +0800 (CST)
Message-ID: <6d71e063-8e18-dd08-ac40-36b41ccfcfdb@xen0n.name>
Date:   Wed, 22 Feb 2023 17:05:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] LoongArch: kdump: Add the same binary implementation
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1677048791-26951-1-git-send-email-tangyouling@loongson.cn>
 <1677048791-26951-2-git-send-email-tangyouling@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <1677048791-26951-2-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/22 14:53, Youling Tang wrote:
> This feature depends on the relocation function, so the relocation configuration
> CONFIG_RELOCATABLE will be enabled.

In general try to describe things briefly: "This depends on the kernel 
being relocatable" would be enough in this case.

> 
> Add the same set of binary implementations for kdump, and then no longer need to
> compile two kernels (the production kernel and the capture kernel share the same
> binary).

Sorry but what do you mean by "same set of binary implementation", 
where's the "first set of binary implementation"?

Judging from the patch content, I guess it's kinda wrong translation, 
and what you actually mean is something like "enable using the same 
image for crashkernel"?

> 
> CONFIG_CRASH_DUMP is enabled by default (CONFIG_RELOCATABLE is also enabled).

No it's not: you didn't add "default y" anywhere. What you actually did 
is to enable it *in the defconfig*. And the latter part about 
CONFIG_RELOCATABLE shouldn't be necessary, it's implementation detail 
after all, and the users likely don't have to be aware of it.

Better reword a little bit, like "Also enable CONFIG_CRASH_DUMP in 
loongson3_defconfig".

> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>   arch/loongarch/Kconfig                     | 12 +-----------
>   arch/loongarch/Makefile                    |  4 ----
>   arch/loongarch/configs/loongson3_defconfig |  1 +
>   arch/loongarch/include/asm/addrspace.h     |  2 ++
>   arch/loongarch/kernel/head.S               |  2 +-
>   5 files changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ab4c2ab146ab..84f220273296 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -502,6 +502,7 @@ config KEXEC
>   
>   config CRASH_DUMP
>   	bool "Build kdump crash kernel"
> +	select RELOCATABLE
>   	help
>   	  Generate crash dump after being started by kexec. This should
>   	  be normally only set in special crash dump kernels which are
> @@ -511,17 +512,6 @@ config CRASH_DUMP
>   
>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>   
> -config PHYSICAL_START
> -	hex "Physical address where the kernel is loaded"
> -	default "0x90000000a0000000"
> -	depends on CRASH_DUMP
> -	help
> -	  This gives the XKPRANGE address where the kernel is loaded.
> -	  If you plan to use kernel for capturing the crash dump change
> -	  this value to start of the reserved region (the "X" value as
> -	  specified in the "crashkernel=YM@XM" command line boot parameter
> -	  passed to the panic-ed kernel).
> -
>   config RELOCATABLE
>   	bool "Relocatable kernel"
>   	help
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 2aba6ff30436..8304fed7aa42 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -79,11 +79,7 @@ endif
>   cflags-y += -ffreestanding
>   cflags-y += $(call cc-option, -mno-check-zero-division)
>   
> -ifndef CONFIG_PHYSICAL_START
>   load-y		= 0x9000000000200000
> -else
> -load-y		= $(CONFIG_PHYSICAL_START)
> -endif
>   bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)

Both load-y and VMLINUX_LOAD_ADDRESS are kinda LoongArch-ism (stemming 
from similar usage in arch/mips apparently), so why not just drop load-y 
and fold the constant into the bootvars-y definition? So we have one 
piece of "special" definition instead of two.

>   
>   drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index cb52774c80e8..7885f6e5de93 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -48,6 +48,7 @@ CONFIG_HOTPLUG_CPU=y
>   CONFIG_NR_CPUS=64
>   CONFIG_NUMA=y
>   CONFIG_KEXEC=y
> +CONFIG_CRASH_DUMP=y
>   CONFIG_SUSPEND=y
>   CONFIG_HIBERNATION=y
>   CONFIG_ACPI=y
> diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
> index d342935e5a72..4edcb3c21cf5 100644
> --- a/arch/loongarch/include/asm/addrspace.h
> +++ b/arch/loongarch/include/asm/addrspace.h
> @@ -125,4 +125,6 @@ extern unsigned long vm_map_base;
>   #define ISA_IOSIZE	SZ_16K
>   #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
>   
> +#define PHYS_LINK_ADDR	PHYSADDR(VMLINUX_LOAD_ADDRESS)
> +
>   #endif /* _ASM_ADDRSPACE_H */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index b12f459ad73a..57962ff08f6d 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -24,7 +24,7 @@ _head:
>   	.org	0x8
>   	.dword	kernel_entry		/* Kernel entry point */
>   	.dword	_end - _text		/* Kernel image effective size */
> -	.quad	0			/* Kernel image load offset from start of RAM */
> +	.quad	PHYS_LINK_ADDR		/* Kernel image load offset from start of RAM */
>   	.org	0x38			/* 0x20 ~ 0x37 reserved */
>   	.long	LINUX_PE_MAGIC
>   	.long	pe_header - _head	/* Offset to the PE header */

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

