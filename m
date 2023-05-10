Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DAF6FDABF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjEJJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEJJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:28:57 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62A3A88;
        Wed, 10 May 2023 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1683710933; bh=Iwd4HphEtoXFGpfJUevca/hbM8Q5YO+WAm14znZJ13k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ure98uSxlqxpy3kj2lJZZLp+wJOVoHih0i3q9H3v6hyHP9iCSPjbSN/BSAhuGS4WE
         tUyWj4INmQGl44m5Pcoh8NwrHJHxocpXHLl5jdxX/UAWWZbKEki+caa5EVhfj37XeS
         JrWt0+Jb4HhtLXpM4plniB7kEM40+qqUO6xZj8Vo=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id CD4E2600CE;
        Wed, 10 May 2023 17:28:52 +0800 (CST)
Message-ID: <3b360532-6ad5-b22c-b02a-103be491be4c@xen0n.name>
Date:   Wed, 10 May 2023 17:28:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2] LoongArch: Add jump-label implementation
Content-Language: en-US
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youling,

On 2023/5/10 17:16, Youling Tang wrote:
> Add jump-label implementation based on the ARM64 version.

"Add support for jump labels based on ..." sounds better IMO.

> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
> Changes in v2:
> - Fix build errors.
> - fix comment.
> 
>   .../core/jump-labels/arch-support.txt         |  2 +-
>   arch/loongarch/Kconfig                        |  2 +
>   arch/loongarch/configs/loongson3_defconfig    |  1 +
>   arch/loongarch/include/asm/jump_label.h       | 51 +++++++++++++++++++
>   arch/loongarch/kernel/Makefile                |  2 +
>   arch/loongarch/kernel/jump_label.c            | 23 +++++++++
>   6 files changed, 80 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch/include/asm/jump_label.h
>   create mode 100644 arch/loongarch/kernel/jump_label.c
> 
> diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
> index 2328eada3a49..94d9dece580f 100644
> --- a/Documentation/features/core/jump-labels/arch-support.txt
> +++ b/Documentation/features/core/jump-labels/arch-support.txt
> @@ -13,7 +13,7 @@
>       |        csky: |  ok  |
>       |     hexagon: | TODO |
>       |        ia64: | TODO |
> -    |   loongarch: | TODO |
> +    |   loongarch: |  ok  |

+1 for updating the docs along with the implementation!

>       |        m68k: | TODO |
>       |  microblaze: | TODO |
>       |        mips: |  ok  |
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931..193a959a5611 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -83,6 +83,8 @@ config LOONGARCH
>   	select GPIOLIB
>   	select HAS_IOPORT
>   	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_JUMP_LABEL
> +	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>   	select HAVE_ARCH_MMAP_RND_BITS if MMU
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 6cd26dd3c134..33a0f5f742f6 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -63,6 +63,7 @@ CONFIG_EFI_ZBOOT=y
>   CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
>   CONFIG_EFI_CAPSULE_LOADER=m
>   CONFIG_EFI_TEST=m
> +CONFIG_JUMP_LABEL=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_FORCE_LOAD=y
>   CONFIG_MODULE_UNLOAD=y
> diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
> new file mode 100644
> index 000000000000..2f9fdec256c5
> --- /dev/null
> +++ b/arch/loongarch/include/asm/jump_label.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + *
> + * Based on arch/arm64/include/asm/jump_label.h
> + */
> +#ifndef __ASM_JUMP_LABEL_H
> +#define __ASM_JUMP_LABEL_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +#define JUMP_LABEL_NOP_SIZE	4

Saying LOONGARCH_INSN_SIZE here might be better for reducing redundancy, 
although that'll necessitate an extra include of <asm/inst.h>. Leaving 
the 4 alone won't cause much harm so I'm fine with either.

> +
> +static __always_inline bool arch_static_branch(struct static_key * const key,
> +					       const bool branch)
> +{
> +	asm_volatile_goto(
> +		"1:	nop					\n\t"
> +		 "	.pushsection	__jump_table, \"aw\"	\n\t"
> +		 "	.align		3			\n\t"
> +		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> +		 "	.quad		%0 - .			\n\t"
> +		 "	.popsection				\n\t"
> +		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> +						    const bool branch)
> +{
> +	asm_volatile_goto(
> +		"1:	b		%l[l_yes]		\n\t"
> +		 "	.pushsection	__jump_table, \"aw\"	\n\t"
> +		 "	.align		3			\n\t"
> +		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> +		 "	.quad		%0 - .			\n\t"
> +		 "	.popsection				\n\t"
> +		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +#endif  /* __ASSEMBLY__ */
> +#endif	/* __ASM_JUMP_LABEL_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 9a72d91cd104..64ea76f60e2c 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -54,4 +54,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>   
>   obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes_trampoline.o
>   
> +obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
> +
>   CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/jump_label.c b/arch/loongarch/kernel/jump_label.c
> new file mode 100644
> index 000000000000..b06245955f7a
> --- /dev/null
> +++ b/arch/loongarch/kernel/jump_label.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + *
> + * Based on arch/arm64/kernel/jump_label.c
> + */
> +#include <linux/jump_label.h>
> +#include <linux/kernel.h>
> +#include <asm/inst.h>
> +
> +void arch_jump_label_transform(struct jump_entry *entry,
> +			       enum jump_label_type type)
> +{
> +	void *addr = (void *)jump_entry_code(entry);
> +	u32 insn;
> +
> +	if (type == JUMP_LABEL_JMP)

Please use a switch for dealing with enum-typed values.

> +		insn = larch_insn_gen_b(jump_entry_code(entry), jump_entry_target(entry));
> +	else
> +		insn = larch_insn_gen_nop();
> +
> +	larch_insn_patch_text(addr, insn);
> +}

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

