Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A86109B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ1F1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1F1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:27:20 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED62B1B574B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:27:18 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxStg1aFtjtwUDAA--.9723S3;
        Fri, 28 Oct 2022 13:27:17 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBlc0aFtj8S0GAA--.3614S3;
        Fri, 28 Oct 2022 13:27:17 +0800 (CST)
Subject: Re: [PATCH v5 10/10] LoongArch/ftrace: Fix unwind state when option
 func_stack_trace
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>,
        Jinyang He <hejinyang@loongson.cn>
References: <20220919031910.15512-1-zhangqing@loongson.cn>
 <CAAhV-H7G53unX8CBN637kmpKBfYuJb4RZnFXOuVnPCq4xNav3Q@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <9e4e00b1-f252-ce89-05f2-6f4ab31a225b@loongson.cn>
Date:   Fri, 28 Oct 2022 13:27:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7G53unX8CBN637kmpKBfYuJb4RZnFXOuVnPCq4xNav3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxBlc0aFtj8S0GAA--.3614S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXw17KF4rWF4xWFyUuw43GFg_yoWrurWrpF
        95CF95Ca1FgryI9rnFqrn09r95Crnayr12gryDta4rCFnFqF4fArnYv3s8uan8JrWkGF1x
        ZF1rCrya9w45ta7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/28 上午10:56, Huacai Chen wrote:
> Hi, Qing,
> 
> Can this patch be squashed to a previous one?
>
ok, I'll combine this patch with the previous patch.

Thanks
- Qing

> Huacai
> 
> On Mon, Sep 19, 2022 at 11:19 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>>
>> Ftrace plays like function head exception, prologue analysis will stop soon
>> because PC is at entry.
>>
>>     90000000004c5a54 <callee>:
>>     90000000004c5a54:    03400000  andi   $zero, $zero, 0x0   ==>move  t0, ra
>>     90000000004c5a58:    03400000  andi   $zero, $zero, 0x0   ==>bl callsite
>> ==>90000000004c5a5c:    02fcc063  addi.d $sp, $sp, -208(0xf30)
>>     ...
>>
>> When encountering ftrace_call, save trace function ra at PT_ERA, save
>> parent ra at PT_R1, At this time, pc is the position after the two nops
>> of callee. There is no conventional prologue operation between this
>> position and the function entry, so we need to reset the first flag to
>> make the caller continue to unwind.
>>
>> testing method:
>>    echo path_openat > ./set_ftrace_filter
>>    echo 1 > ./options/func_stack_trace
>>    echo function > ./current_tracer
>>
>> Reported-by: Jeff Xie <xiehuan09@gmail.com>
>> Tested-by: Jinyang He <hejinyang@loongson.cn>
>> Tested-by: Jeff Xie <xiehuan09@gmail.com>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/unwind.h     |  2 +-
>>   arch/loongarch/kernel/unwind_prologue.c | 35 +++++++++++++++++++++----
>>   2 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
>> index f66b07c3e6a1..f2b52b9ea93d 100644
>> --- a/arch/loongarch/include/asm/unwind.h
>> +++ b/arch/loongarch/include/asm/unwind.h
>> @@ -20,7 +20,7 @@ struct unwind_state {
>>          char type; /* UNWINDER_XXX */
>>          struct stack_info stack_info;
>>          struct task_struct *task;
>> -       bool first, error;
>> +       bool first, error, is_ftrace;
>>          int graph_idx;
>>          unsigned long sp, pc, ra;
>>   };
>> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
>> index f77f3b6f3f06..4fb4923b68cc 100644
>> --- a/arch/loongarch/kernel/unwind_prologue.c
>> +++ b/arch/loongarch/kernel/unwind_prologue.c
>> @@ -14,9 +14,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
>>
>>          if (unwind_done(state))
>>                  return 0;
>> -       else if (state->type)
>> -               return state->pc;
>> -       else if (state->first)
>> +       else if (state->type || state->first)
>>                  return state->pc;
>>
>>          return *(unsigned long *)(state->sp);
>> @@ -42,16 +40,41 @@ static bool unwind_by_guess(struct unwind_state *state)
>>          return false;
>>   }
>>
>> +static inline void unwind_state_fixup(struct unwind_state *state)
>> +{
>> +#ifdef CONFIG_FUNCTION_TRACER
>> +       static unsigned long ftrace_case = (unsigned long)ftrace_call + 4;
>> +
>> +       if (state->pc == ftrace_case)
>> +               state->is_ftrace = true;
>> +#endif
>> +}
>> +
>>   static bool unwind_by_prologue(struct unwind_state *state)
>>   {
>>          struct stack_info *info = &state->stack_info;
>>          union loongarch_instruction *ip, *ip_end;
>>          unsigned long frame_size = 0, frame_ra = -1;
>>          unsigned long size, offset, pc = state->pc;
>> +       struct pt_regs *regs;
>>
>>          if (state->sp >= info->end || state->sp < info->begin)
>>                  return false;
>>
>> +       if (state->is_ftrace) {
>> +               /*
>> +                * As we meet ftrace_regs_entry, reset first flag like first doing
>> +                * tracing, Prologue analysis will stop soon because PC is at entry.
>> +                */
>> +               regs = (struct pt_regs *)state->sp;
>> +               state->pc = regs->csr_era;
>> +               state->ra = regs->regs[1];
>> +               state->sp = regs->regs[3];
>> +               state->first = true;
>> +               state->is_ftrace = false;
>> +               return true;
>> +       }
>> +
>>          if (!kallsyms_lookup_size_offset(pc, &size, &offset))
>>                  return false;
>>
>> @@ -97,7 +120,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>>
>>          state->pc = *(unsigned long *)(state->sp + frame_ra);
>>          state->sp = state->sp + frame_size;
>> -       return !!__kernel_text_address(state->pc);
>> +       goto out;
>>
>>   first:
>>          state->first = false;
>> @@ -106,7 +129,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
>>
>>          state->pc = state->ra;
>>
>> -       return !!__kernel_text_address(state->ra);
>> +out:
>> +       unwind_state_fixup(state);
>> +       return !!__kernel_text_address(state->pc);
>>   }
>>
>>   void unwind_start(struct unwind_state *state, struct task_struct *task,
>> --
>> 2.36.1
>>

