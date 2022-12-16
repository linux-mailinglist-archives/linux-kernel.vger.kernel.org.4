Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8864E5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLPCOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLPCOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:14:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 338C4528A9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:14:43 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxTeuS1JtjAAEGAA--.13799S3;
        Fri, 16 Dec 2022 10:14:42 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+SQ1Jtj0REBAA--.4764S3;
        Fri, 16 Dec 2022 10:14:41 +0800 (CST)
Subject: Re: [PATCH 4/6] LoongArch: Strip guess_unwinder out from
 prologue_unwinder
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221215040141.18610-1-hejinyang@loongson.cn>
 <20221215040141.18610-5-hejinyang@loongson.cn>
 <36c3560a-0a2d-4c3f-ecb6-0e7e71746917@loongson.cn>
 <be643b7c-611e-c87b-c030-5fa51220d78c@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <6fdb3dc9-2b34-ce53-1ff8-6b23c1eaaa82@loongson.cn>
Date:   Fri, 16 Dec 2022 10:14:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be643b7c-611e-c87b-c030-5fa51220d78c@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxf+SQ1Jtj0REBAA--.4764S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfGF4DCF1UWFyDGry7tFW3trb_yoW8Wr18Zo
        W3KF13Wr4fXrW5K3yUAryUJFyYgr4UJwnrArW5tr13Gr4Iya45A3yUJa45tayxtr1rKrWU
        Gr1jqr4FvFWxZr1fn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2
        z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

On 2022/12/16 上午9:40, Jinyang He wrote:
> On 2022-12-15 17:15, Qing Zhang wrote:
> 
>> Hi, Jinyang
>>
>> On 2022/12/15 下午12:01, Jinyang He wrote:
>>> The prolugue unwinder rely on symbol info. When PC is not in kernel
>>> text address, it cannot find relative symbol info and it will be broken.
>>> The guess unwinder will be used in this case. And the guess unwinder
>>> codes in prolugue unwinder is redundant. Strip it out and set the
>>> unwinder info in unwind_state.
>>>
>>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>>> ---
>>>   arch/loongarch/include/asm/unwind.h     |  22 ++++
>>>   arch/loongarch/kernel/Makefile          |   3 +-
>>>   arch/loongarch/kernel/unwind.c          |  52 +++++++++
>>>   arch/loongarch/kernel/unwind_guess.c    |  41 ++-----
>>>   arch/loongarch/kernel/unwind_prologue.c | 135 +++++++++---------------
>>>   5 files changed, 135 insertions(+), 118 deletions(-)
>>>   create mode 100644 arch/loongarch/kernel/unwind.c
>>>
>>> diff --git a/arch/loongarch/include/asm/unwind.h 
>>> b/arch/loongarch/include/asm/unwind.h
>>> index 6ece48f0ff77..a16aff1d086a 100644
>>> --- a/arch/loongarch/include/asm/unwind.h
>>> +++ b/arch/loongarch/include/asm/unwind.h
>>> @@ -18,6 +18,8 @@ enum unwinder_type {
>>>       UNWINDER_PROLOGUE,
>>>   };
>>>   +struct unwinder_ops;
>>> +
>>>   struct unwind_state {
>>>       char type; /* UNWINDER_XXX */
>>>       struct stack_info stack_info;
>>> @@ -25,8 +27,22 @@ struct unwind_state {
>>>       bool first, error, is_ftrace;
>>>       int graph_idx;
>>>       unsigned long sp, pc, ra;
>>> +    const struct unwinder_ops *ops;
>>> +};
>>> +
>>> +struct unwinder_ops {
>>> +    void (*unwind_start)(struct unwind_state *state,
>>> +                 struct task_struct *task, struct pt_regs *regs);
>>> +    bool (*unwind_next_frame)(struct unwind_state *state);
>>> +    unsigned long (*unwind_get_return_address)(struct unwind_state 
>>> *state);
>>>   };
>>>   +extern const struct unwinder_ops *default_unwinder;
>>> +extern const struct unwinder_ops unwinder_guess;
>>> +#ifdef CONFIG_UNWINDER_PROLOGUE
>>> +extern const struct unwinder_ops unwinder_prologue;
>>> +#endif
>>> +
>>>   void unwind_start(struct unwind_state *state,
>>>             struct task_struct *task, struct pt_regs *regs);
>>>   bool unwind_next_frame(struct unwind_state *state);
>>> @@ -49,4 +65,10 @@ static inline unsigned long 
>>> unwind_graph_addr(struct unwind_state *state,
>>>       return ftrace_graph_ret_addr(state->task, &state->graph_idx,
>>>                        pc, (unsigned long *)(cfa - GRAPH_FAKE_OFFSET));
>>>   }
>>> +
>>> +static inline void unwind_register_unwinder(struct unwind_state *state,
>>> +                      const struct unwinder_ops *unwinder)
>>> +{
>>> +    state->ops = unwinder;
>>> +}
>>>   #endif /* _ASM_UNWIND_H */
>>> diff --git a/arch/loongarch/kernel/Makefile 
>>> b/arch/loongarch/kernel/Makefile
>>> index 7ca65195f7f8..cb6029ea3ea9 100644
>>> --- a/arch/loongarch/kernel/Makefile
>>> +++ b/arch/loongarch/kernel/Makefile
>>> @@ -8,7 +8,7 @@ extra-y        := vmlinux.lds
>>>   obj-y        += head.o cpu-probe.o cacheinfo.o env.o setup.o 
>>> entry.o genex.o \
>>>              traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o 
>>> switch.o \
>>>              elf.o syscall.o signal.o time.o topology.o inst.o 
>>> ptrace.o vdso.o \
>>> -           alternative.o unaligned.o
>>> +           alternative.o unaligned.o unwind.o unwind_guess.o
>>>     obj-$(CONFIG_ACPI)        += acpi.o
>>>   obj-$(CONFIG_EFI)         += efi.o
>>> @@ -42,7 +42,6 @@ obj-$(CONFIG_MAGIC_SYSRQ)    += sysrq.o
>>>   obj-$(CONFIG_KEXEC)        += machine_kexec.o relocate_kernel.o
>>>   obj-$(CONFIG_CRASH_DUMP)    += crash_dump.o
>>>   -obj-$(CONFIG_UNWINDER_GUESS)    += unwind_guess.o
>>>   obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>>>     obj-$(CONFIG_PERF_EVENTS)    += perf_event.o perf_regs.o
>>> diff --git a/arch/loongarch/kernel/unwind.c 
>>> b/arch/loongarch/kernel/unwind.c
>>> new file mode 100644
>>> index 000000000000..568c6fe707d1
>>> --- /dev/null
>>> +++ b/arch/loongarch/kernel/unwind.c
>>> @@ -0,0 +1,52 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>>> + */
>>> +#include <asm/unwind.h>
>>> +
>>> +#if defined(CONFIG_UNWINDER_GUESS)
>>> +const struct unwinder_ops *default_unwinder = &unwinder_guess;
>>> +#elif defined(CONFIG_UNWINDER_PROLOGUE)
>>> +const struct unwinder_ops *default_unwinder = &unwinder_prologue;
>>> +#endif
>>> +
>>> +unsigned long unwind_get_return_address(struct unwind_state *state)
>>> +{
>>> +    if (!state->ops || unwind_done(state))
>>> +        return 0;
>>> +    return state->ops->unwind_get_return_address(state);
>>> +}
>>> +EXPORT_SYMBOL_GPL(unwind_get_return_address);
>>> +
>>> +void unwind_start(struct unwind_state *state, struct task_struct *task,
>>> +            struct pt_regs *regs)
>>> +{
>>> +    memset(state, 0, sizeof(*state));
>>> +    unwind_register_unwinder(state, default_unwinder);
>>> +    if (regs) {
>>> +        state->sp = regs->regs[3];
>>> +        state->pc = regs->csr_era;
>>> +        state->ra = regs->regs[1];
>>> +    } else if (task == current) {
>>> +        state->sp = (unsigned long)__builtin_frame_address(0);
>>> +        state->pc = (unsigned long)__builtin_return_address(0);
>>> +        state->ra = 0;
>>> +    } else {
>>> +        state->sp = thread_saved_fp(task);
>>> +        state->pc = thread_saved_ra(task);
>>> +        state->ra = 0;
>>> +    }
>>> +    state->task = task;
>>> +    get_stack_info(state->sp, state->task, &state->stack_info);
>>> +    state->pc = unwind_graph_addr(state, state->pc, state->sp);

  here. :)

>>> +    state->ops->unwind_start(state, task, regs);
>>> +}
>>> +EXPORT_SYMBOL_GPL(unwind_start);
>>> +
>>> +bool unwind_next_frame(struct unwind_state *state)
>>> +{
>>> +    if (!state->ops || unwind_done(state))
>>> +        return false;
>>> +    return state->ops->unwind_next_frame(state);
>>> +}
>>> +EXPORT_SYMBOL_GPL(unwind_next_frame);
>>> diff --git a/arch/loongarch/kernel/unwind_guess.c 
>>> b/arch/loongarch/kernel/unwind_guess.c
>>> index 8ce32c37c587..b7ca2b88ac63 100644
>>> --- a/arch/loongarch/kernel/unwind_guess.c
>>> +++ b/arch/loongarch/kernel/unwind_guess.c
>>> @@ -7,51 +7,23 @@
>>>     #include <asm/unwind.h>
>>>   -unsigned long unwind_get_return_address(struct unwind_state *state)
>>> +static unsigned long get_return_address(struct unwind_state *state)
>>>   {
>>> -    if (unwind_done(state))
>>> -        return 0;
>>>       return state->pc;
>>>   }
>>> -EXPORT_SYMBOL_GPL(unwind_get_return_address);
>>>   -void unwind_start(struct unwind_state *state, struct task_struct 
>>> *task,
>>> +static void start(struct unwind_state *state, struct task_struct *task,
>>>               struct pt_regs *regs)
>>>   {
>>> -    memset(state, 0, sizeof(*state));
>>> -
>>> -    if (regs) {
>>> -        state->sp = regs->regs[3];
>>> -        state->pc = regs->csr_era;
>>> -    } else if (task == current) {
>>> -        state->sp = (unsigned long)__builtin_frame_address(0);
>>> -        state->pc = (unsigned long)__builtin_return_address(0);
>>> -    } else {
>>> -        state->sp = thread_saved_fp(task);
>>> -        state->pc = thread_saved_ra(task);
>>> -    }
>>> -
>>> -    state->task = task;
>>> -    state->first = true;
>>> -    state->pc = unwind_graph_add(state, state->pc, state->sp);
>>
>> Do we need to unwind_graph_add again here? unwinder_guess and 
>> unwind_prologue have already been done.
> 
> Hi, Qing
> 
> 
> Sorry I don't what meanning here, as here is a delete line.
> 
Sorry, It's the unwind_start up here.
> 
>>
>>> -    get_stack_info(state->sp, state->task, &state->stack_info);
>>> -
>>>       if (!unwind_done(state) && !__kernel_text_address(state->pc))
>>>           unwind_next_frame(state);
>>>   }
>>> -EXPORT_SYMBOL_GPL(unwind_start);
>>>   -bool unwind_next_frame(struct unwind_state *state)
>>> +static bool next_frame(struct unwind_state *state)
>>>   {
>>>       struct stack_info *info = &state->stack_info;
>>>       unsigned long addr;
>>>   -    if (unwind_done(state))
>>> -        return false;
>>> -
>>> -    if (state->first)
>>> -        state->first = false;
>>> -
>>>       do {
>>>           for (state->sp += sizeof(unsigned long);
>>>                state->sp < info->end;
>>> @@ -68,4 +40,9 @@ bool unwind_next_frame(struct unwind_state *state)
>>>         return false;
>>>   }
>>> -EXPORT_SYMBOL_GPL(unwind_next_frame);
>>> +
>>> +const struct unwinder_ops unwinder_guess = {
>>> +    .unwind_start = start,
>>> +    .unwind_next_frame = next_frame,
>>> +    .unwind_get_return_address = get_return_address,
>>> +};
>>> diff --git a/arch/loongarch/kernel/unwind_prologue.c 
>>> b/arch/loongarch/kernel/unwind_prologue.c
>>> index d464c533c64f..9677e13c4b4c 100644
>>> --- a/arch/loongarch/kernel/unwind_prologue.c
>>> +++ b/arch/loongarch/kernel/unwind_prologue.c
>>> @@ -9,6 +9,8 @@
>>>   #include <asm/ptrace.h>
>>>   #include <asm/unwind.h>
>>>   +static const struct unwinder_ops *guard_unwinder = &unwinder_guess;
>>> +
>>>   static inline void unwind_state_fixup(struct unwind_state *state)
>>>   {
>>>   #ifdef CONFIG_DYNAMIC_FTRACE
>>> @@ -19,31 +21,19 @@ static inline void unwind_state_fixup(struct 
>>> unwind_state *state)
>>>   #endif
>>>   }
>>>   -unsigned long unwind_get_return_address(struct unwind_state *state)
>>> +static unsigned long get_return_address(struct unwind_state *state)
>>>   {
>>> -    if (unwind_done(state))
>>> -        return 0;
>>>       return state->pc;
>>>   }
>>> -EXPORT_SYMBOL_GPL(unwind_get_return_address);
>>> -
>>> -static bool unwind_by_guess(struct unwind_state *state)
>>> -{
>>> -    struct stack_info *info = &state->stack_info;
>>> -    unsigned long addr;
>>> -
>>> -    for (state->sp += sizeof(unsigned long);
>>> -         state->sp < info->end;
>>> -         state->sp += sizeof(unsigned long)) {
>>> -        addr = *(unsigned long *)(state->sp);
>>> -        state->pc = unwind_graph_addr(state, addr, state->sp + 8);
>>> -        if (__kernel_text_address(state->pc))
>>> -            return true;
>>> -    }
>>> -
>>> -    return false;
>>> -}
>>>   +/*
>>> + * LoongArch function prologue like follows,
>>> + *     [others instructions not use stack var]
>>> + *     addi.d sp, sp, -imm
>>> + *     st.d   xx, sp, offset <- save callee saved regs and
>>> + *     st.d   yy, sp, offset    save ra if function is nest.
>>> + *     [others instructions]
>>> + */
>>>   static bool unwind_by_prologue(struct unwind_state *state)
>>>   {
>>>       long frame_ra = -1;
>>> @@ -89,6 +79,10 @@ static bool unwind_by_prologue(struct unwind_state 
>>> *state)
>>>           ip++;
>>>       }
>>>   +    /*
>>> +     * Not find stack alloc action, PC may be in a leaf function. 
>>> Only the
>>> +     * first being true is reasonable, otherwise indicate analysis 
>>> is broken.
>>> +     */
>>>       if (!frame_size) {
>>>           if (state->first)
>>>               goto first;
>>> @@ -106,6 +100,7 @@ static bool unwind_by_prologue(struct 
>>> unwind_state *state)
>>>           ip++;
>>>       }
>>>   +    /* Not find save $ra action, PC may be in a leaf function, 
>>> too. */
>>>       if (frame_ra < 0) {
>>>           if (state->first) {
>>>               state->sp = state->sp + frame_size;
>>> @@ -114,96 +109,63 @@ static bool unwind_by_prologue(struct 
>>> unwind_state *state)
>>>           return false;
>>>       }
>>>   -    if (state->first)
>>> -        state->first = false;
>>> -
>>>       state->pc = *(unsigned long *)(state->sp + frame_ra);
>>>       state->sp = state->sp + frame_size;
>>>       goto out;
>>>     first:
>>> -    state->first = false;
>>> -    if (state->pc == state->ra)
>>> -        return false;
>>> -
>>>       state->pc = state->ra;
>>>     out:
>>> +    state->first = false;
>>>       unwind_state_fixup(state);
>>>       return !!__kernel_text_address(state->pc);
>>>   }
>>>   -void unwind_start(struct unwind_state *state, struct task_struct 
>>> *task,
>>> +static void start(struct unwind_state *state, struct task_struct *task,
>>>               struct pt_regs *regs)
>>>   {
>>> -    memset(state, 0, sizeof(*state));
>>> -    state->type = UNWINDER_PROLOGUE;
>>> -
>>> -    if (regs) {
>>> -        state->sp = regs->regs[3];
>>> -        state->pc = regs->csr_era;
>>> -        state->ra = regs->regs[1];
>>> -        if (!__kernel_text_address(state->pc))
>>> -            state->type = UNWINDER_GUESS;
>>> -    } else if (task == current) {
>>> -        state->sp = (unsigned long)__builtin_frame_address(0);
>>> -        state->pc = (unsigned long)__builtin_return_address(0);
>>> -        state->ra = 0;
>>> -    } else {
>>> -        state->sp = thread_saved_fp(task);
>>> -        state->pc = thread_saved_ra(task);
>>> -        state->ra = 0;
>>> -    }
>>> -
>>> -    state->task = task;
>>>       state->first = true;
>>> -    state->pc = unwind_graph_addr(state, state->pc, state->sp);
>>> -    get_stack_info(state->sp, state->task, &state->stack_info);
>>>   -    if (!unwind_done(state) && !__kernel_text_address(state->pc))
>>> -        unwind_next_frame(state);
>>> +    /*
>>> +     * The current PC is not kernel text address, we cannot find its
>>> +     * relative symbol. Thus, prologue analysis will be broken. Luckly,
>>> +     * we can use the guard unwinder.
>>> +     */
>>> +    if (!__kernel_text_address(state->pc)) {
>>> +        unwind_register_unwinder(state, guard_unwinder);
>>
>> Just add a comment here. Instead of using guard_unwinder, can we still
>> use guess_unwinder?
> 
> Yes, and I'll use '&guess_unwinder' in next version. And I'll
> drop unwind type in next version, too.
> 
> 
> Thanks,
> 
> Jinyang
> 

