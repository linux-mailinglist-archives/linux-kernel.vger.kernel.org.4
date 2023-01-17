Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2AF66D70F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjAQHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjAQHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:41:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFE351ABF1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:41:30 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxCeooUcZjXwoCAA--.6041S3;
        Tue, 17 Jan 2023 15:41:28 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+QlUcZjiaIaAA--.15350S3;
        Tue, 17 Jan 2023 15:41:26 +0800 (CST)
Subject: Re: [PATCH v3 5/5] LoongArch: Add generic ex-handler unwind in
 prologue unwinder
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230112004048.26191-1-hejinyang@loongson.cn>
 <CAAhV-H417wC+Bh6-EeD6sKmqgrJDP8kQPFZ9xu19Ev9Egdu1YQ@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <e471ad49-8b2e-179f-45c7-ba1f4ff94101@loongson.cn>
Date:   Tue, 17 Jan 2023 15:41:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H417wC+Bh6-EeD6sKmqgrJDP8kQPFZ9xu19Ev9Egdu1YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxb+QlUcZjiaIaAA--.15350S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrWrGryUAw1xAF1fZFy5Jwb_yoW3JF45pF
        95CFn5GF48Kry2qryUXryDur95Aw1kCr17KF9rKa4rGFnFvryfWrnYy34v9FWDJrW8WryI
        vFs5Xr9I9a13ta7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 2023/1/17 下午2:25, Huacai Chen wrote:
> On Thu, Jan 12, 2023 at 8:41 AM Jinyang He <hejinyang@loongson.cn> wrote:
>>
>> When exception is triggered, code flow go handle_\exception in some
>> cases. One of stackframe in this case as follows,
>>
>> high -> +-------+
>>          | REGS  |  <- a pt_regs
>>          |       |
>>          |       |  <- ex trigger
>>          | REGS  |  <- ex pt_regs   <-+
>>          |       |                    |
>>          |       |                    |
>> low  -> +-------+           ->unwind-+
>>
>> When unwinder unwind to handler_\exception it cannot go on prologue
>> analysis. It is asynchronous code flow, we should get the next frame
>> PC from regs->csr_era but not from regs->regs[1]. And we copy the
>> handler codes to eentry in the early time and copy the handler codes
>> to NUMA-relative memory named pcpu_handlers if NUMA is enabled. Thus,
>> unwinder cannot unwind normally. Therefore, try to give some hint in
>> handler_\exception and fixup it in unwind_next_frame.
>>
>> Reported-by: Qing Zhang <zhangqing@loongson.cn>
>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/unwind.h     |   2 +-
>>   arch/loongarch/kernel/genex.S           |   3 +
>>   arch/loongarch/kernel/unwind_prologue.c | 100 +++++++++++++++++++++---
>>   arch/loongarch/mm/tlb.c                 |   2 +-
>>   4 files changed, 92 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
>> index cb428e1b19af..a38eb152aefb 100644
>> --- a/arch/loongarch/include/asm/unwind.h
>> +++ b/arch/loongarch/include/asm/unwind.h
>> @@ -22,7 +22,7 @@ struct unwind_state {
>>          char type; /* UNWINDER_XXX */
>>          struct stack_info stack_info;
>>          struct task_struct *task;
>> -       bool first, error, is_ftrace;
>> +       bool first, error, reset;
> Hi, Qing,
> Do you think is_reset is better than reset here?
ok, It depends on you.

Thanks
-Qing

>>          int graph_idx;
>>          unsigned long sp, pc, ra;
>>   };
>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>> index 75e5be807a0d..7e5c293ed89f 100644
>> --- a/arch/loongarch/kernel/genex.S
>> +++ b/arch/loongarch/kernel/genex.S
>> @@ -67,14 +67,17 @@ SYM_FUNC_END(except_vec_cex)
>>          .macro  BUILD_HANDLER exception handler prep
>>          .align  5
>>          SYM_FUNC_START(handle_\exception)
>> +       666:
>>          BACKUP_T0T1
>>          SAVE_ALL
>>          build_prep_\prep
>>          move    a0, sp
>>          la.abs  t0, do_\handler
>>          jirl    ra, t0, 0
>> +       668:
>>          RESTORE_ALL_AND_RET
> I think the 668 label should be after RESTORE_ALL_AND_RET, right?
> 
> Huacai
> 
>>          SYM_FUNC_END(handle_\exception)
>> +       SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
>>          .endm
>>
>>          BUILD_HANDLER ade ade badv
>> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
>> index e6c3f2ee507c..e52c18c2b604 100644
>> --- a/arch/loongarch/kernel/unwind_prologue.c
>> +++ b/arch/loongarch/kernel/unwind_prologue.c
>> @@ -2,21 +2,100 @@
>>   /*
>>    * Copyright (C) 2022 Loongson Technology Corporation Limited
>>    */
>> +#include <linux/cpumask.h>
>>   #include <linux/ftrace.h>
>>   #include <linux/kallsyms.h>
>>
>>   #include <asm/inst.h>
>> +#include <asm/loongson.h>
>>   #include <asm/ptrace.h>
>> +#include <asm/setup.h>
>>   #include <asm/unwind.h>
>>
>> -static inline void unwind_state_fixup(struct unwind_state *state)
>> +extern const int unwind_hint_ade;
>> +extern const int unwind_hint_ale;
>> +extern const int unwind_hint_bp;
>> +extern const int unwind_hint_fpe;
>> +extern const int unwind_hint_fpu;
>> +extern const int unwind_hint_lsx;
>> +extern const int unwind_hint_lasx;
>> +extern const int unwind_hint_lbt;
>> +extern const int unwind_hint_ri;
>> +extern const int unwind_hint_watch;
>> +extern unsigned long eentry;
>> +#ifdef CONFIG_NUMA
>> +extern unsigned long pcpu_handlers[NR_CPUS];
>> +#endif
>> +
>> +static inline bool scan_handler(unsigned long entry_offset)
>>   {
>> -#ifdef CONFIG_DYNAMIC_FTRACE
>> -       static unsigned long ftrace = (unsigned long)ftrace_call + 4;
>> +       int idx, offset;
>>
>> -       if (state->pc == ftrace)
>> -               state->is_ftrace = true;
>> +       if (entry_offset >= EXCCODE_INT_START * VECSIZE)
>> +               return false;
>> +
>> +       idx = entry_offset / VECSIZE;
>> +       offset = entry_offset % VECSIZE;
>> +       switch (idx) {
>> +       case EXCCODE_ADE:
>> +               return offset == unwind_hint_ade;
>> +       case EXCCODE_ALE:
>> +               return offset == unwind_hint_ale;
>> +       case EXCCODE_BP:
>> +               return offset == unwind_hint_bp;
>> +       case EXCCODE_FPE:
>> +               return offset == unwind_hint_fpe;
>> +       case EXCCODE_FPDIS:
>> +               return offset == unwind_hint_fpu;
>> +       case EXCCODE_LSXDIS:
>> +               return offset == unwind_hint_lsx;
>> +       case EXCCODE_LASXDIS:
>> +               return offset == unwind_hint_lasx;
>> +       case EXCCODE_BTDIS:
>> +               return offset == unwind_hint_lbt;
>> +       case EXCCODE_INE:
>> +               return offset == unwind_hint_ri;
>> +       case EXCCODE_WATCH:
>> +               return offset == unwind_hint_watch;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>> +static inline bool fix_exceptions(unsigned long pc)
>> +{
>> +#ifdef CONFIG_NUMA
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               if (!pcpu_handlers[cpu])
>> +                       continue;
>> +               if (scan_handler(pc - pcpu_handlers[cpu]))
>> +                       return true;
>> +       }
>>   #endif
>> +       return scan_handler(pc - eentry);
>> +}
>> +
>> +/*
>> + * As we meet ftrace_regs_entry, reset first flag like first doing
>> + * tracing. Prologue analysis will stop soon because PC is at entry.
>> + */
>> +static inline bool fix_ftrace(unsigned long pc)
>> +{
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>> +       return pc == (unsigned long)ftrace_call + LOONGARCH_INSN_SIZE;
>> +#else
>> +       return false;
>> +#endif
>> +}
>> +
>> +static inline bool unwind_state_fixup(struct unwind_state *state)
>> +{
>> +       if (!fix_exceptions(state->pc) && !fix_ftrace(state->pc))
>> +               return false;
>> +       state->reset = true;
>> +       return true;
>>   }
>>
>>   /*
>> @@ -39,14 +118,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
>>          if (state->sp >= info->end || state->sp < info->begin)
>>                  return false;
>>
>> -       if (state->is_ftrace) {
>> -               /*
>> -                * As we meet ftrace_regs_entry, reset first flag like first doing
>> -                * tracing. Prologue analysis will stop soon because PC is at entry.
>> -                */
>> +       if (state->reset) {
>>                  regs = (struct pt_regs *)state->sp;
>>                  state->first = true;
>> -               state->is_ftrace = false;
>> +               state->reset = false;
>>                  state->pc = regs->csr_era;
>>                  state->ra = regs->regs[1];
>>                  state->sp = regs->regs[3];
>> @@ -111,8 +186,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>>
>>   out:
>>          state->first = false;
>> -       unwind_state_fixup(state);
>> -       return !!__kernel_text_address(state->pc);
>> +       return unwind_state_fixup(state) || __kernel_text_address(state->pc);
>>   }
>>
>>   static bool next_frame(struct unwind_state *state)
>> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
>> index da3681f131c8..8bad6b0cff59 100644
>> --- a/arch/loongarch/mm/tlb.c
>> +++ b/arch/loongarch/mm/tlb.c
>> @@ -251,7 +251,7 @@ static void output_pgtable_bits_defines(void)
>>   }
>>
>>   #ifdef CONFIG_NUMA
>> -static unsigned long pcpu_handlers[NR_CPUS];
>> +unsigned long pcpu_handlers[NR_CPUS];
>>   #endif
>>   extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>>
>> --
>> 2.34.3
>>
>>

