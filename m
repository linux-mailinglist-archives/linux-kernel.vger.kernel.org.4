Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488C698B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBPDNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBPDNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:13:47 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 912A934C3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:13:44 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8CxSNlnn+1j5SoBAA--.2697S3;
        Thu, 16 Feb 2023 11:13:43 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTL5jn+1jHDY0AA--.31515S3;
        Thu, 16 Feb 2023 11:13:41 +0800 (CST)
Subject: Re: [PATCH v3 2/3] LoongArch: Add ptrace single step support
To:     Jinyang He <hejinyang@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
References: <20230215092358.30368-1-zhangqing@loongson.cn>
 <20230215092358.30368-3-zhangqing@loongson.cn>
 <2b759af4-4047-4ac6-acbb-42e91c14fb48@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <42a352da-936a-bf7e-994f-6d884a230646@loongson.cn>
Date:   Thu, 16 Feb 2023 11:13:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2b759af4-4047-4ac6-acbb-42e91c14fb48@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxTL5jn+1jHDY0AA--.31515S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gry8Wr43XF4kCF47AFWDJwb_yoWfCr17pF
        9rAFs5Gr4UJr10grnIqw45ZF13twn7Ww42grySya4Yy34qvryrGr1kKr9xuF4rAw1jga4I
        9r1YgwsIgF4UXaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bc8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r
        1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj4RKtC7UUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/16/2023 10:07 AM, Jinyang He wrote:
>
> On 2023-02-15 17:23, Qing Zhang wrote:
>> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
>> PTRACE_KILL and PTRACE_SINGLESTEP. This implies defining
>> arch_has_single_step in  and implementing the
>> user_enable_single_step and user_disable_single_step functions.
>>
>> LongArch has no hardware single-step register. the hardware single-step
>> function multiplex fetch instruction watchpoint(FWPS) and specifies that
>> the next instruction must trigger the watch exception by setting the
>> mask bit.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/processor.h |  3 ++
>>   arch/loongarch/include/asm/ptrace.h    |  2 +
>>   arch/loongarch/kernel/hw_breakpoint.c  | 35 +++++++++++--
>>   arch/loongarch/kernel/ptrace.c         | 68 ++++++++++++++++++++++++++
>>   arch/loongarch/kernel/traps.c          | 20 ++++++--
>>   5 files changed, 120 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/processor.h
>> b/arch/loongarch/include/asm/processor.h
>> index db060c5a976f..3ea0f1910c23 100644
>> --- a/arch/loongarch/include/asm/processor.h
>> +++ b/arch/loongarch/include/asm/processor.h
>> @@ -131,6 +131,9 @@ struct thread_struct {
>>       struct perf_event    *hbp_break[LOONGARCH_MAX_BRP];
>>       struct perf_event    *hbp_watch[LOONGARCH_MAX_WRP];
>>   +    /* Used by ptrace single_step */
>> +    unsigned long single_step;
>> +
>>       /*
>>        * FPU & vector registers, must be at last because
>>        * they are conditionally copied at fork().
>> diff --git a/arch/loongarch/include/asm/ptrace.h
>> b/arch/loongarch/include/asm/ptrace.h
>> index 58596c4f8a0f..66a0e6c480a3 100644
>> --- a/arch/loongarch/include/asm/ptrace.h
>> +++ b/arch/loongarch/include/asm/ptrace.h
>> @@ -150,4 +150,6 @@ static inline void user_stack_pointer_set(struct
>> pt_regs *regs,
>>       regs->regs[3] = val;
>>   }
>>   +#define arch_has_single_step()        (1)
>> +
>>   #endif /* _ASM_PTRACE_H */
>> diff --git a/arch/loongarch/kernel/hw_breakpoint.c
>> b/arch/loongarch/kernel/hw_breakpoint.c
>> index 6431cd319c32..94967b887d92 100644
>> --- a/arch/loongarch/kernel/hw_breakpoint.c
>> +++ b/arch/loongarch/kernel/hw_breakpoint.c
>> @@ -153,6 +153,22 @@ static int hw_breakpoint_slot_setup(struct
>> perf_event **slots, int max_slots,
>>    */
>>   void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>>   {
>> +    int i;
>> +    struct thread_struct *t = &tsk->thread;
>> +
>> +    for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
>> +        if (t->hbp_break[i]) {
>> +            unregister_hw_breakpoint(t->hbp_break[i]);
>> +            t->hbp_break[i] = NULL;
>> +        }
>> +    }
>> +
>> +    for (i = 0; i < LOONGARCH_MAX_WRP; i++) {
>> +        if (t->hbp_watch[i]) {
>> +            unregister_hw_breakpoint(t->hbp_watch[i]);
>> +            t->hbp_watch[i] = NULL;
>> +        }
>> +    }
>>   }
>>     void ptrace_hw_copy_thread(struct task_struct *tsk)
>> @@ -498,11 +514,20 @@ arch_initcall(arch_hw_breakpoint_init);
>>   void hw_breakpoint_thread_switch(struct task_struct *next)
>>   {
>>       struct pt_regs *regs = task_pt_regs(next);
>> -
>> -    /* Update breakpoints */
>> -    update_bp_registers(regs, 1, 0);
>> -    /* Update watchpoints */
>> -    update_bp_registers(regs, 1, 1);
>> +    u64 addr, mask;
>> +
>> +    if (test_bit(TIF_SINGLESTEP, &task_thread_info(next)->flags)) {
>> +        addr = read_wb_reg(CSR_CFG_ADDR, 0, 0);
>> +        mask = read_wb_reg(CSR_CFG_MASK, 0, 0);
>> +        if ((task_pt_regs(next)->csr_era & ~mask) == (addr & ~mask))
>> +            csr_write32(0x10000, LOONGARCH_CSR_FWPS);
>> +        regs->csr_prmd |= CSR_PRMD_PWE;
>> +    } else {
>> +        /* Update breakpoints */
>> +        update_bp_registers(regs, 1, 0);
>> +        /* Update watchpoints */
>> +        update_bp_registers(regs, 1, 1);
>> +    }
>>   }
>>     void hw_breakpoint_pmu_read(struct perf_event *bp)
>> diff --git a/arch/loongarch/kernel/ptrace.c
>> b/arch/loongarch/kernel/ptrace.c
>> index bee4194177fd..52a3ee4366f4 100644
>> --- a/arch/loongarch/kernel/ptrace.c
>> +++ b/arch/loongarch/kernel/ptrace.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/context_tracking.h>
>>   #include <linux/elf.h>
>>   #include <linux/errno.h>
>> +#include <linux/hw_breakpoint.h>
>>   #include <linux/mm.h>
>>   #include <linux/ptrace.h>
>>   #include <linux/regset.h>
>> @@ -30,6 +31,7 @@
>>   #include <linux/stddef.h>
>>   #include <linux/seccomp.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/thread_info.h>
>>     #include <asm/byteorder.h>
>>   #include <asm/cpu.h>
>> @@ -39,6 +41,7 @@
>>   #include <asm/page.h>
>>   #include <asm/pgtable.h>
>>   #include <asm/processor.h>
>> +#include <asm/ptrace.h>
>>   #include <asm/reg.h>
>>   #include <asm/syscall.h>
>>   @@ -541,3 +544,68 @@ long arch_ptrace(struct task_struct *child,
>> long request,
>>         return ret;
>>   }
>> +
>> +void ptrace_triggered(struct perf_event *bp,
>> +              struct perf_sample_data *data, struct pt_regs *regs)
>> +{
>> +    struct perf_event_attr attr;
>> +
>> +    attr = bp->attr;
>> +    attr.disabled = true;
>> +    modify_user_hw_breakpoint(bp, &attr);
>> +}
>> +
>> +static int set_single_step(struct task_struct *tsk, unsigned long addr)
>> +{
>> +    struct thread_struct *thread = &tsk->thread;
>> +    struct perf_event *bp;
>> +    struct perf_event_attr attr;
>> +    struct arch_hw_breakpoint *info;
>> +
>> +    bp = thread->hbp_break[0];
>> +    if (!bp) {
>> +        ptrace_breakpoint_init(&attr);
>> +
>> +        attr.bp_addr = addr;
>> +        attr.bp_len = HW_BREAKPOINT_LEN_8;
>> +        attr.bp_type = HW_BREAKPOINT_X;
>> +
>> +        bp = register_user_hw_breakpoint(&attr, ptrace_triggered,
>> +                         NULL, tsk);
>> +        if (IS_ERR(bp))
>> +            return PTR_ERR(bp);
>> +
>> +        thread->hbp_break[0] = bp;
>> +    } else {
>> +        int err;
>> +
>> +        attr = bp->attr;
>> +        attr.bp_addr = addr;
>> +        /* reenable breakpoint */
>> +        attr.disabled = false;
>> +        err = modify_user_hw_breakpoint(bp, &attr);
>> +        if (unlikely(err))
>> +            return err;
>> +
>> +        csr_write64(attr.bp_addr, LOONGARCH_CSR_IB0ADDR);
>> +    }
>> +    info = counter_arch_bp(bp);
>> +    info->mask = 0xffffffffffff;
>> +
>> +    return 0;
>> +}
>> +
>> +/* ptrace API */
>> +void user_enable_single_step(struct task_struct *task)
>> +{
>> +    struct thread_info *ti = task_thread_info(task);
>> +
>> +    set_single_step(task, task_pt_regs(task)->csr_era);
>> +    task->thread.single_step = task_pt_regs(task)->csr_era;
>> +    set_ti_thread_flag(ti, TIF_SINGLESTEP);
>> +}
>> +
>> +void user_disable_single_step(struct task_struct *task)
>> +{
>> +    clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>> +}
>> diff --git a/arch/loongarch/kernel/traps.c
>> b/arch/loongarch/kernel/traps.c
>> index 2b133079e0f3..56d7d076153c 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -511,9 +511,23 @@ asmlinkage void noinstr do_watch(struct pt_regs
>> *regs)
>>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>>       irqentry_state_t state = irqentry_enter(regs);
>>   -    breakpoint_handler(regs);
>> -    watchpoint_handler(regs);
>> -    force_sig(SIGTRAP);
>> +    if (test_tsk_thread_flag(current, TIF_SINGLESTEP)) {
>> +        int llbit = (csr_read32(LOONGARCH_CSR_LLBCTL) & 0x1);
>> +        unsigned long pc = regs->csr_era;
>> +
>> +        if (llbit) {
>
> Hi, Qing,
>
>
> It should be noted here. When the ll-sc combo is encountered, it is
> regarded as an single instruction. So donnot clear llbit and reset
> CSR.FWPS.Skip until the llsc execution is completed.
>
>> +            csr_write32(0x10000, LOONGARCH_CSR_FWPS);
>> +            csr_write32(0x4, LOONGARCH_CSR_LLBCTL);
>> +        } else if (pc == current->thread.single_step) {
> Note here as well. Because 3A5000 has a strange hardware issue that
> certain insns are occasionally not skipped when CSR.FWPS.Skip is set,
> such as fld.d/fst.d. Singlestep needs compare whether the csr_era is
> equal to the value of singlestep which last time set, as in most case
>
> they should be not equal.

BTW, I prefer to separate this special processing from this patch (for
example, add two patchs in this series, add special processing of
instructions such as LL-SC, and FLD.D/FST.D, etc.), and add
corresponding test cases to describe the phenomenon and reason, this
is conducive to everyone's understanding of the code.

>
>
> And for this condition expression, some potentially strange insns may
> cause bugs. For example, "b 0" or "jr rd" where rd is equal to its PC
> will cause cannot stop the singlestep. These insns is so strange that
> we did not consider in OW. However, I think we should consider this
> case for robustness in upstream.
>

I don't know if there will be instructions like "b 0" or "jr rd (rd =
pc)" in the executable file after linking?

Youling.

> It is better to use macros avoid direct numbers when csr_write* is invoked.
>
>
> Thanks,
>
> Jinyang
>
>> +            csr_write32(0x10000, LOONGARCH_CSR_FWPS);
>> +        } else {
>> +            force_sig(SIGTRAP);
>> +        }
>> +    } else {
>> +        breakpoint_handler(regs);
>> +        watchpoint_handler(regs);
>> +        force_sig(SIGTRAP);
>> +    }
>>         irqentry_exit(regs, state);
>>   #endif
>

