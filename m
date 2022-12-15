Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD79564D64A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 06:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLOF4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 00:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiLOF4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 00:56:01 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 651BEB4A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 21:55:54 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxuurptppjLL8FAA--.13427S3;
        Thu, 15 Dec 2022 13:55:53 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxY+XmtppjDSoAAA--.1345S3;
        Thu, 15 Dec 2022 13:55:52 +0800 (CST)
Subject: Re: [PATCH 1/6] LoongArch: Get frame info in unwind_start when regs
 is not supported
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221215040141.18610-1-hejinyang@loongson.cn>
 <20221215040141.18610-2-hejinyang@loongson.cn>
 <d3c5aa06-0cc3-b1a4-18b9-858e8f1216de@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <e4d39bdb-827a-8a9c-0aeb-fcc919743826@loongson.cn>
Date:   Thu, 15 Dec 2022 13:55:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3c5aa06-0cc3-b1a4-18b9-858e8f1216de@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxY+XmtppjDSoAAA--.1345S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw1DGw1UCw1UZr4DGr47CFg_yoW7Aw43pF
        1kArW5GrWUWrn7Jr17Jr1UXr98Jr1kCwnrGFyktFy5KF47AFy2gryUXryq9F4UA3y8Gw48
        Xr15XrnI9anrJaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        baAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1D
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7IU8yrW7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 13:24, Qing Zhang wrote:

> Hi, Jinyang
>
> On 2022/12/15 下午12:01, Jinyang He wrote:
>> At unwind_start, it is better to try to get its frame info even we not
>> support regs rather than get them outside. So that we can simply use
>> unwind_{start, next_frame, done} outside.
>>
>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>> ---
>>   arch/loongarch/kernel/process.c         | 12 +++---------
>>   arch/loongarch/kernel/unwind_guess.c    |  6 ++++++
>>   arch/loongarch/kernel/unwind_prologue.c | 16 +++++++++++++---
>>   3 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/process.c 
>> b/arch/loongarch/kernel/process.c
>> index 502b8b950057..6ef45174ad35 100644
>> --- a/arch/loongarch/kernel/process.c
>> +++ b/arch/loongarch/kernel/process.c
>> @@ -197,20 +197,14 @@ int copy_thread(struct task_struct *p, const 
>> struct kernel_clone_args *args)
>>     unsigned long __get_wchan(struct task_struct *task)
>>   {
>> -    unsigned long pc;
>> +    unsigned long pc = 0;
>>       struct unwind_state state;
>>         if (!try_get_task_stack(task))
>>           return 0;
>>   -    unwind_start(&state, task, NULL);
>> -    state.sp = thread_saved_fp(task);
>> -    get_stack_info(state.sp, state.task, &state.stack_info);
>> -    state.pc = thread_saved_ra(task);
>> -#ifdef CONFIG_UNWINDER_PROLOGUE
>> -    state.type = UNWINDER_PROLOGUE;
>> -#endif
>> -    for (; !unwind_done(&state); unwind_next_frame(&state)) {
>> +    for (unwind_start(&state, task, NULL); !unwind_done(&state);
>> +         unwind_next_frame(&state)) {
>>           pc = unwind_get_return_address(&state);
>>           if (!pc)
>>               break;
>> diff --git a/arch/loongarch/kernel/unwind_guess.c 
>> b/arch/loongarch/kernel/unwind_guess.c
>> index e2d2e4f3001f..e03864511582 100644
>> --- a/arch/loongarch/kernel/unwind_guess.c
>> +++ b/arch/loongarch/kernel/unwind_guess.c
>> @@ -26,6 +26,12 @@ void unwind_start(struct unwind_state *state, 
>> struct task_struct *task,
>>       if (regs) {
>>           state->sp = regs->regs[3];
>>           state->pc = regs->csr_era;
>> +    } else if (task == current) {
>> +        state->sp = (unsigned long)__builtin_frame_address(0);
>> +        state->pc = (unsigned long)__builtin_return_address(0);
>> +    } else {
>> +        state->sp = thread_saved_fp(task);
>> +        state->pc = thread_saved_ra(task);
> The case for tasks is already handled in stacktrace.c, which is 
> reusable code:
> void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>              struct task_struct *task, struct pt_regs *regs)
> {
> ...
>
>     if (task == current) {
>         regs->regs[3] = (unsigned long)__builtin_frame_address(0);
>         regs->csr_era = (unsigned long)__builtin_return_address(0);
>     } else {
>         regs->regs[3] = thread_saved_fp(task);
>         regs->csr_era = thread_saved_ra(task);
>     }
> ...
>     for (unwind_start(&state, task, regs);
>           !unwind_done(&state); unwind_next_frame(&state)) {
>         addr = unwind_get_return_address(&state);
> ...
> }
>
>>         state->task = task;
>> diff --git a/arch/loongarch/kernel/unwind_prologue.c 
>> b/arch/loongarch/kernel/unwind_prologue.c
>> index 0f8d1451ebb8..9d51ea37782e 100644
>> --- a/arch/loongarch/kernel/unwind_prologue.c
>> +++ b/arch/loongarch/kernel/unwind_prologue.c
>> @@ -141,12 +141,22 @@ void unwind_start(struct unwind_state *state, 
>> struct task_struct *task,
>>               struct pt_regs *regs)
>>   {
>>       memset(state, 0, sizeof(*state));
>> +    state->type = UNWINDER_PROLOGUE;
>>   -    if (regs && __kernel_text_address(regs->csr_era)) {
>> -        state->pc = regs->csr_era;
>> +    if (regs) {
>>           state->sp = regs->regs[3];
>> +        state->pc = regs->csr_era;
>>           state->ra = regs->regs[1];
>> -        state->type = UNWINDER_PROLOGUE;
>> +        if (!__kernel_text_address(state->pc))
>> +            state->type = UNWINDER_GUESS;
>> +    } else if (task == current) {
>> +        state->sp = (unsigned long)__builtin_frame_address(0);
>> +        state->pc = (unsigned long)__builtin_return_address(0);
>> +        state->ra = 0;
>> +    } else {
>> +        state->sp = thread_saved_fp(task);
>> +        state->pc = thread_saved_ra(task);
>> +        state->ra = 0;
>>       }
> also...
>>       state->task = task;
>>
That looks similar, but stacktrace actually provides the regs parameter.
Unwind_{start, next_frame, get_return_address} is API to others, such the
GPL module. Btw, if we want to drop the redundant codes in arch_stack_walk
and keep same result, use "cookie->skip += 1", I think, but beyond this 
series.


Thanks,

Jinyang

