Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6816296C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiKOLHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbiKOLHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:07:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F25C2DFC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:06:52 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxOdjLcnNjqjwHAA--.19807S3;
        Tue, 15 Nov 2022 19:06:51 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPuLKcnNj8ZATAA--.52346S3;
        Tue, 15 Nov 2022 19:06:51 +0800 (CST)
Subject: Re: [PATCH v6 1/9] LoongArch/ftrace: Add basic support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>
References: <20221115025527.13382-1-zhangqing@loongson.cn>
 <20221115025527.13382-2-zhangqing@loongson.cn>
 <CAAhV-H7JxZ9SAVXGLgY3sMo9jtuANxQqu4_o2FrBBfN-Kf=VFw@mail.gmail.com>
 <0a32d7d6-b26f-87d7-49e3-31ad53218ec1@loongson.cn>
 <CAAhV-H7xwXks8gjOwdRtMXGvzXZo47KvoFoQ4z+FCuZZ1_iz9g@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <577c4455-24fa-9a49-d993-9a7bc5f63ac6@loongson.cn>
Date:   Tue, 15 Nov 2022 19:06:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7xwXks8gjOwdRtMXGvzXZo47KvoFoQ4z+FCuZZ1_iz9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPuLKcnNj8ZATAA--.52346S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Zw45Cr4kWr4kuF1xGFWfZrb_yoWDur1Dpr
        y8AF4DGF48Jr17Kry2vw15XrnIyrykGry2gFnrKryFyr1qqr13Gr10yr1q9F97tw18Gry0
        9ryrGr43CF4Yq37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU7PrcDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, huacai
On 2022/11/15 下午5:04, Huacai Chen wrote:
> On Tue, Nov 15, 2022 at 4:51 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>>
>> Hi, Huacai
>>
>> On 2022/11/15 下午4:25, Huacai Chen wrote:
>>> Hi, Qing,
>>>
>>> On Tue, Nov 15, 2022 at 10:55 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>>>>
>>>> This patch contains basic ftrace support for LoongArch.
>>>> Specifically, function tracer (HAVE_FUNCTION_TRACER), function graph
>>>> tracer (HAVE_FUNCTION_GRAPH_TRACER) are implemented following the
>>>> instructions in Documentation/trace/ftrace-design.txt.
>>>>
>>>> Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
>>>> Thus, it can be seen store RA and open stack before `call _mcount`.
>>>> Find `open stack` at first, and then find `store RA`
>>>>
>>>> Note that the functions in both inst.c and time.c should not be
>>>> hooked with the compiler's -pg option: to prevent infinite self-
>>>> referencing for the former, and to ignore early setup stuff for the
>>>> latter.
>>>>
>>>> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
>>>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>>>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>>> ---
>>>>    arch/loongarch/Kconfig              |  2 +
>>>>    arch/loongarch/Makefile             |  5 ++
>>>>    arch/loongarch/include/asm/ftrace.h | 18 ++++++
>>>>    arch/loongarch/kernel/Makefile      |  8 +++
>>>>    arch/loongarch/kernel/ftrace.c      | 74 +++++++++++++++++++++++
>>>>    arch/loongarch/kernel/mcount.S      | 94 +++++++++++++++++++++++++++++
>>>>    6 files changed, 201 insertions(+)
>>>>    create mode 100644 arch/loongarch/include/asm/ftrace.h
>>>>    create mode 100644 arch/loongarch/kernel/ftrace.c
>>>>    create mode 100644 arch/loongarch/kernel/mcount.S
>>>>
>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>>> index 1943f840e494..92c4ec8c8527 100644
>>>> --- a/arch/loongarch/Kconfig
>>>> +++ b/arch/loongarch/Kconfig
>>>> @@ -91,6 +91,8 @@ config LOONGARCH
>>>>           select HAVE_EBPF_JIT
>>>>           select HAVE_EXIT_THREAD
>>>>           select HAVE_FAST_GUP
>>>> +       select HAVE_FUNCTION_GRAPH_TRACER
>>> This line should be moved to another patch.
>>>
>>>> +       select HAVE_FUNCTION_TRACER
>>>>           select HAVE_GENERIC_VDSO
>>>>           select HAVE_IOREMAP_PROT
>>>>           select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>>>> index a0fc1f9980e3..6832a8f891fd 100644
>>>> --- a/arch/loongarch/Makefile
>>>> +++ b/arch/loongarch/Makefile
>>>> @@ -36,6 +36,11 @@ ifneq ($(SUBARCH),$(ARCH))
>>>>      endif
>>>>    endif
>>>>
>>>> +ifdef CONFIG_DYNAMIC_FTRACE
>>>> +KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>>>> +CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>>>> +endif
>>>> +
>>>>    ifdef CONFIG_64BIT
>>>>    ld-emul                        = $(64bit-emul)
>>>>    cflags-y               += -mabi=lp64s
>>>> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
>>>> new file mode 100644
>>>> index 000000000000..6a3e76234618
>>>> --- /dev/null
>>>> +++ b/arch/loongarch/include/asm/ftrace.h
>>>> @@ -0,0 +1,18 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#ifndef _ASM_LOONGARCH_FTRACE_H
>>>> +#define _ASM_LOONGARCH_FTRACE_H
>>>> +
>>>> +#ifdef CONFIG_FUNCTION_TRACER
>>>> +#define MCOUNT_INSN_SIZE 4             /* sizeof mcount call */
>>>> +
>>>> +#ifndef __ASSEMBLY__
>>>> +extern void _mcount(void);
>>>> +#define mcount _mcount
>>>> +
>>>> +#endif /* __ASSEMBLY__ */
>>>> +#endif /* CONFIG_FUNCTION_TRACER */
>>>> +#endif /* _ASM_LOONGARCH_FTRACE_H */
>>>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>>>> index 86744531b100..3f71bce1c7ce 100644
>>>> --- a/arch/loongarch/kernel/Makefile
>>>> +++ b/arch/loongarch/kernel/Makefile
>>>> @@ -15,6 +15,14 @@ obj-$(CONFIG_EFI)            += efi.o
>>>>
>>>>    obj-$(CONFIG_CPU_HAS_FPU)      += fpu.o
>>>>
>>>> +ifdef CONFIG_FUNCTION_TRACER
>>>> +obj-y += mcount.o ftrace.o
>>>> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
>>>> +CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
>>>> +CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
>>>> +CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
>>>> +endif
>>>> +
>>>>    obj-$(CONFIG_MODULES)          += module.o module-sections.o
>>>>    obj-$(CONFIG_STACKTRACE)       += stacktrace.o
>>>>
>>>> diff --git a/arch/loongarch/kernel/ftrace.c b/arch/loongarch/kernel/ftrace.c
>>>> new file mode 100644
>>>> index 000000000000..c8ddc5f11f32
>>>> --- /dev/null
>>>> +++ b/arch/loongarch/kernel/ftrace.c
>>>> @@ -0,0 +1,74 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#include <linux/uaccess.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/ftrace.h>
>>>> +#include <linux/syscalls.h>
>>>> +
>>>> +#include <asm/asm.h>
>>>> +#include <asm/asm-offsets.h>
>>>> +#include <asm/cacheflush.h>
>>>> +#include <asm/inst.h>
>>>> +#include <asm/loongarch.h>
>>>> +#include <asm/syscall.h>
>>>> +#include <asm/unistd.h>
>>>> +
>>>> +#include <asm-generic/sections.h>
>>>> +
>>>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> This should also be moved to another patch.
>>
>> No, CONFIG_FUNCTION_GRAPH_TRACER is the basic feature, as the first
>> patch for non-dynamic ftrace, unless it is a separate patch, which is
>> obviously not necessary (Refer to the first submission of riscv and
>> arm64 here).
> But FUNCTION_GRAPH_TRACER is added until Patch-4.

Separate non dynamic FUNCTION_ GRAPH_ TRACER and dynamic 
FUNCTION_GRAPH_TRACER
can be placed in a patch, However, since the dynamic can completely 
replace the
non dynamic, my idea is to put the non dynamic content in the first 
patch, which
is more consistent with our idea of gradual evolution at the beginning, 
How do you think?

Thanks,
- Qing
> 
> Huacai
>>
>>    Thanks,
>> - Qing
>>>
>>>> +
>>>> +/*
>>>> + * As `call _mcount` follows LoongArch psABI, ra-saved operation and
>>>> + * stack operation can be found before this insn.
>>>> + */
>>>> +
>>>> +static int ftrace_get_parent_ra_addr(unsigned long insn_addr, int *ra_off)
>>>> +{
>>>> +       union loongarch_instruction *insn;
>>>> +       int limit = 32;
>>>> +
>>>> +       insn = (union loongarch_instruction *)insn_addr;
>>>> +
>>>> +       do {
>>>> +               insn--;
>>>> +               limit--;
>>>> +
>>>> +               if (is_ra_save_ins(insn))
>>>> +                       *ra_off = -((1 << 12) - insn->reg2i12_format.immediate);
>>>> +
>>>> +       } while (!is_stack_alloc_ins(insn) && limit);
>>>> +
>>>> +       if (!limit)
>>>> +               return -EINVAL;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +void prepare_ftrace_return(unsigned long self_addr,
>>>> +               unsigned long callsite_sp, unsigned long old)
>>>> +{
>>>> +       int ra_off;
>>>> +       unsigned long return_hooker = (unsigned long)&return_to_handler;
>>>> +
>>>> +       if (unlikely(ftrace_graph_is_dead()))
>>>> +               return;
>>>> +
>>>> +       if (unlikely(atomic_read(&current->tracing_graph_pause)))
>>>> +               return;
>>>> +
>>>> +       if (ftrace_get_parent_ra_addr(self_addr, &ra_off))
>>>> +               goto out;
>>>> +
>>>> +       if (!function_graph_enter(old, self_addr, 0, NULL))
>>>> +               *(unsigned long *)(callsite_sp + ra_off) = return_hooker;
>>>> +
>>>> +       return;
>>>> +
>>>> +out:
>>>> +       ftrace_graph_stop();
>>>> +       WARN_ON(1);
>>>> +}
>>>> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>>>> diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
>>>> new file mode 100644
>>>> index 000000000000..3de7c2d7fd12
>>>> --- /dev/null
>>>> +++ b/arch/loongarch/kernel/mcount.S
>>>> @@ -0,0 +1,94 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * LoongArch specific _mcount support
>>>> + *
>>>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#include <asm/export.h>
>>>> +#include <asm/regdef.h>
>>>> +#include <asm/stackframe.h>
>>>> +#include <asm/ftrace.h>
>>>> +
>>>> +       .text
>>>> +
>>>> +#define MCOUNT_STACK_SIZE      (2 * SZREG)
>>>> +#define MCOUNT_S0_OFFSET       (0)
>>>> +#define MCOUNT_RA_OFFSET       (SZREG)
>>>> +
>>>> +       .macro MCOUNT_SAVE_REGS
>>>> +       PTR_ADDI sp, sp, -MCOUNT_STACK_SIZE
>>>> +       PTR_S   s0, sp, MCOUNT_S0_OFFSET
>>>> +       PTR_S   ra, sp, MCOUNT_RA_OFFSET
>>>> +       move    s0, a0
>>>> +       .endm
>>>> +
>>>> +       .macro MCOUNT_RESTORE_REGS
>>>> +       move    a0, s0
>>>> +       PTR_L   ra, sp, MCOUNT_RA_OFFSET
>>>> +       PTR_L   s0, sp, MCOUNT_S0_OFFSET
>>>> +       PTR_ADDI sp, sp, MCOUNT_STACK_SIZE
>>>> +       .endm
>>>> +
>>>> +
>>>> +SYM_FUNC_START(_mcount)
>>>> +       la.pcrel        t1, ftrace_stub
>>>> +       la.pcrel        t2, ftrace_trace_function       /* Prepare t2 for (1) */
>>>> +       PTR_L   t2, t2, 0
>>>> +       beq     t1, t2, fgraph_trace
>>>> +
>>>> +       MCOUNT_SAVE_REGS
>>>> +
>>>> +       move    a0, ra                          /* arg0: self return address */
>>>> +       move    a1, s0                          /* arg1: parent's return address */
>>>> +       jirl    ra, t2, 0                       /* (1) call *ftrace_trace_function */
>>>> +
>>>> +       MCOUNT_RESTORE_REGS
>>>> +
>>>> +fgraph_trace:
>>>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> The same as above.
>>>
>>> Huacai
>>>> +       la.pcrel        t1, ftrace_stub
>>>> +       la.pcrel        t3, ftrace_graph_return
>>>> +       PTR_L   t3, t3, 0
>>>> +       bne     t1, t3, ftrace_graph_caller
>>>> +       la.pcrel        t1, ftrace_graph_entry_stub
>>>> +       la.pcrel        t3, ftrace_graph_entry
>>>> +       PTR_L   t3, t3, 0
>>>> +       bne     t1, t3, ftrace_graph_caller
>>>> +#endif
>>>> +
>>>> +       .globl ftrace_stub
>>>> +ftrace_stub:
>>>> +       jr      ra
>>>> +SYM_FUNC_END(_mcount)
>>>> +EXPORT_SYMBOL(_mcount)
>>>> +
>>>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>>> +SYM_FUNC_START(ftrace_graph_caller)
>>>> +       MCOUNT_SAVE_REGS
>>>> +
>>>> +       PTR_ADDI        a0, ra, -4                      /* arg0: Callsite self return addr */
>>>> +       PTR_ADDI        a1, sp, MCOUNT_STACK_SIZE       /* arg1: Callsite sp */
>>>> +       move    a2, s0                                  /* arg2: Callsite parent ra */
>>>> +       bl      prepare_ftrace_return
>>>> +
>>>> +       MCOUNT_RESTORE_REGS
>>>> +       jr      ra
>>>> +SYM_FUNC_END(ftrace_graph_caller)
>>>> +
>>>> +SYM_FUNC_START(return_to_handler)
>>>> +       PTR_ADDI sp, sp, -2 * SZREG
>>>> +       PTR_S   a0, sp, 0
>>>> +       PTR_S   a1, sp, SZREG
>>>> +
>>>> +       bl      ftrace_return_to_handler
>>>> +
>>>> +       /* restore the real parent address: a0 -> ra */
>>>> +       move    ra, a0
>>>> +
>>>> +       PTR_L   a0, sp, 0
>>>> +       PTR_L   a1, sp, SZREG
>>>> +       PTR_ADDI        sp, sp, 2 * SZREG
>>>> +       jr      ra
>>>> +SYM_FUNC_END(return_to_handler)
>>>> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>>>> --
>>>> 2.36.0
>>>>
>>>>
>>

