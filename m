Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18D6FE982
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjEKBdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEKBds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:33:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BE7C65A8;
        Wed, 10 May 2023 18:33:42 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.100.1])
        by gateway (Coremail) with SMTP id _____8BxrOr1RVxkTZgHAA--.13034S3;
        Thu, 11 May 2023 09:33:41 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.100.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxBMXxRVxk8AxVAA--.21003S3;
        Thu, 11 May 2023 09:33:38 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Add jump-label implementation
To:     WANG Xuerui <kernel@xen0n.name>
References: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
 <3b360532-6ad5-b22c-b02a-103be491be4c@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <72b6c81a-d4ee-575a-ff48-6be7e034ac96@loongson.cn>
Date:   Thu, 11 May 2023 09:33:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3b360532-6ad5-b22c-b02a-103be491be4c@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxBMXxRVxk8AxVAA--.21003S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Wr13uryfZF4DAr4UZr1rCrg_yoWxGr4fpF
        1UCan5GF4kGF1fJrZ0qw1Dur1Yq393Gr12gF13tFy8AFnFvry8Arnakryq9F1ktaykWrWI
        vF1ruFsIva1UJa7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui

On 05/10/2023 05:28 PM, WANG Xuerui wrote:
> Hi Youling,
>
> On 2023/5/10 17:16, Youling Tang wrote:
>> Add jump-label implementation based on the ARM64 version.
>
> "Add support for jump labels based on ..." sounds better IMO.

OK.

>
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>> Changes in v2:
>> - Fix build errors.
>> - fix comment.
>>
>>   .../core/jump-labels/arch-support.txt         |  2 +-
>>   arch/loongarch/Kconfig                        |  2 +
>>   arch/loongarch/configs/loongson3_defconfig    |  1 +
>>   arch/loongarch/include/asm/jump_label.h       | 51 +++++++++++++++++++
>>   arch/loongarch/kernel/Makefile                |  2 +
>>   arch/loongarch/kernel/jump_label.c            | 23 +++++++++
>>   6 files changed, 80 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/loongarch/include/asm/jump_label.h
>>   create mode 100644 arch/loongarch/kernel/jump_label.c
>>
>> diff --git a/Documentation/features/core/jump-labels/arch-support.txt
>> b/Documentation/features/core/jump-labels/arch-support.txt
>> index 2328eada3a49..94d9dece580f 100644
>> --- a/Documentation/features/core/jump-labels/arch-support.txt
>> +++ b/Documentation/features/core/jump-labels/arch-support.txt
>> @@ -13,7 +13,7 @@
>>       |        csky: |  ok  |
>>       |     hexagon: | TODO |
>>       |        ia64: | TODO |
>> -    |   loongarch: | TODO |
>> +    |   loongarch: |  ok  |
>
> +1 for updating the docs along with the implementation!
>
>>       |        m68k: | TODO |
>>       |  microblaze: | TODO |
>>       |        mips: |  ok  |
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index d38b066fc931..193a959a5611 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -83,6 +83,8 @@ config LOONGARCH
>>       select GPIOLIB
>>       select HAS_IOPORT
>>       select HAVE_ARCH_AUDITSYSCALL
>> +    select HAVE_ARCH_JUMP_LABEL
>> +    select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>       select HAVE_ARCH_MMAP_RND_BITS if MMU
>>       select HAVE_ARCH_SECCOMP_FILTER
>>       select HAVE_ARCH_TRACEHOOK
>> diff --git a/arch/loongarch/configs/loongson3_defconfig
>> b/arch/loongarch/configs/loongson3_defconfig
>> index 6cd26dd3c134..33a0f5f742f6 100644
>> --- a/arch/loongarch/configs/loongson3_defconfig
>> +++ b/arch/loongarch/configs/loongson3_defconfig
>> @@ -63,6 +63,7 @@ CONFIG_EFI_ZBOOT=y
>>   CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
>>   CONFIG_EFI_CAPSULE_LOADER=m
>>   CONFIG_EFI_TEST=m
>> +CONFIG_JUMP_LABEL=y
>>   CONFIG_MODULES=y
>>   CONFIG_MODULE_FORCE_LOAD=y
>>   CONFIG_MODULE_UNLOAD=y
>> diff --git a/arch/loongarch/include/asm/jump_label.h
>> b/arch/loongarch/include/asm/jump_label.h
>> new file mode 100644
>> index 000000000000..2f9fdec256c5
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/jump_label.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + *
>> + * Based on arch/arm64/include/asm/jump_label.h
>> + */
>> +#ifndef __ASM_JUMP_LABEL_H
>> +#define __ASM_JUMP_LABEL_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/types.h>
>> +
>> +#define JUMP_LABEL_NOP_SIZE    4
>
> Saying LOONGARCH_INSN_SIZE here might be better for reducing redundancy,
> although that'll necessitate an extra include of <asm/inst.h>. Leaving
> the 4 alone won't cause much harm so I'm fine with either.

Using LOONGARCH_INSN_SIZE in v1, but causing build errors due to
inclusion of <asm/inst.h> [1].

So I removed the <asm/inst.h> include and used hardcoded 4.

[1]: 
https://lore.kernel.org/loongarch/202305100412.gazWW71q-lkp@intel.com/T/#m0d8393aaf529aea0a4dcc5985469e698d63d66b3
>
>> +
>> +static __always_inline bool arch_static_branch(struct static_key *
>> const key,
>> +                           const bool branch)
>> +{
>> +    asm_volatile_goto(
>> +        "1:    nop                    \n\t"
>> +         "    .pushsection    __jump_table, \"aw\"    \n\t"
>> +         "    .align        3            \n\t"
>> +         "    .long        1b - ., %l[l_yes] - .    \n\t"
>> +         "    .quad        %0 - .            \n\t"
>> +         "    .popsection                \n\t"
>> +         :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> +
>> +    return false;
>> +l_yes:
>> +    return true;
>> +}
>> +
>> +static __always_inline bool arch_static_branch_jump(struct static_key
>> * const key,
>> +                            const bool branch)
>> +{
>> +    asm_volatile_goto(
>> +        "1:    b        %l[l_yes]        \n\t"
>> +         "    .pushsection    __jump_table, \"aw\"    \n\t"
>> +         "    .align        3            \n\t"
>> +         "    .long        1b - ., %l[l_yes] - .    \n\t"
>> +         "    .quad        %0 - .            \n\t"
>> +         "    .popsection                \n\t"
>> +         :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> +
>> +    return false;
>> +l_yes:
>> +    return true;
>> +}
>> +
>> +#endif  /* __ASSEMBLY__ */
>> +#endif    /* __ASM_JUMP_LABEL_H */
>> diff --git a/arch/loongarch/kernel/Makefile
>> b/arch/loongarch/kernel/Makefile
>> index 9a72d91cd104..64ea76f60e2c 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -54,4 +54,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)    += hw_breakpoint.o
>>     obj-$(CONFIG_KPROBES)        += kprobes.o kprobes_trampoline.o
>>   +obj-$(CONFIG_JUMP_LABEL)    += jump_label.o
>> +
>>   CPPFLAGS_vmlinux.lds        := $(KBUILD_CFLAGS)
>> diff --git a/arch/loongarch/kernel/jump_label.c
>> b/arch/loongarch/kernel/jump_label.c
>> new file mode 100644
>> index 000000000000..b06245955f7a
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/jump_label.c
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + *
>> + * Based on arch/arm64/kernel/jump_label.c
>> + */
>> +#include <linux/jump_label.h>
>> +#include <linux/kernel.h>
>> +#include <asm/inst.h>
>> +
>> +void arch_jump_label_transform(struct jump_entry *entry,
>> +                   enum jump_label_type type)
>> +{
>> +    void *addr = (void *)jump_entry_code(entry);
>> +    u32 insn;
>> +
>> +    if (type == JUMP_LABEL_JMP)
>
> Please use a switch for dealing with enum-typed values.

Because the current type only has JUMP_LABEL_NOP and JUMP_LABEL_JMP,
using if may be simpler than switch.

Thanks,
Youling.
>
>> +        insn = larch_insn_gen_b(jump_entry_code(entry),
>> jump_entry_target(entry));
>> +    else
>> +        insn = larch_insn_gen_nop();
>> +
>> +    larch_insn_patch_text(addr, insn);
>> +}
>

