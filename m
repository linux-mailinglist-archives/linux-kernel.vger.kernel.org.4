Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2B64D623
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 06:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLOFZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 00:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOFY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 00:24:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4770454473
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 21:24:49 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx7+ugr5pj2b0FAA--.13221S3;
        Thu, 15 Dec 2022 13:24:48 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+Sfr5pj6iQAAA--.246S3;
        Thu, 15 Dec 2022 13:24:48 +0800 (CST)
Subject: Re: [PATCH 1/6] LoongArch: Get frame info in unwind_start when regs
 is not supported
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221215040141.18610-1-hejinyang@loongson.cn>
 <20221215040141.18610-2-hejinyang@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <d3c5aa06-0cc3-b1a4-18b9-858e8f1216de@loongson.cn>
Date:   Thu, 15 Dec 2022 13:24:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221215040141.18610-2-hejinyang@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX+Sfr5pj6iQAAA--.246S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw1fCw43uF1UJF4DGF4xCrg_yoWrWryxpr
        ZrCrsxWF4YgF9FvFy7trn8Zr95Grn7uw12gFWqy34rCFnrXFyxCr9093s8ZFs0y34kGw40
        qFn0yrsrKa1DtaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

On 2022/12/15 下午12:01, Jinyang He wrote:
> At unwind_start, it is better to try to get its frame info even we not
> support regs rather than get them outside. So that we can simply use
> unwind_{start, next_frame, done} outside.
> 
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>   arch/loongarch/kernel/process.c         | 12 +++---------
>   arch/loongarch/kernel/unwind_guess.c    |  6 ++++++
>   arch/loongarch/kernel/unwind_prologue.c | 16 +++++++++++++---
>   3 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index 502b8b950057..6ef45174ad35 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -197,20 +197,14 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   
>   unsigned long __get_wchan(struct task_struct *task)
>   {
> -	unsigned long pc;
> +	unsigned long pc = 0;
>   	struct unwind_state state;
>   
>   	if (!try_get_task_stack(task))
>   		return 0;
>   
> -	unwind_start(&state, task, NULL);
> -	state.sp = thread_saved_fp(task);
> -	get_stack_info(state.sp, state.task, &state.stack_info);
> -	state.pc = thread_saved_ra(task);
> -#ifdef CONFIG_UNWINDER_PROLOGUE
> -	state.type = UNWINDER_PROLOGUE;
> -#endif
> -	for (; !unwind_done(&state); unwind_next_frame(&state)) {
> +	for (unwind_start(&state, task, NULL); !unwind_done(&state);
> +	     unwind_next_frame(&state)) {
>   		pc = unwind_get_return_address(&state);
>   		if (!pc)
>   			break;
> diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
> index e2d2e4f3001f..e03864511582 100644
> --- a/arch/loongarch/kernel/unwind_guess.c
> +++ b/arch/loongarch/kernel/unwind_guess.c
> @@ -26,6 +26,12 @@ void unwind_start(struct unwind_state *state, struct task_struct *task,
>   	if (regs) {
>   		state->sp = regs->regs[3];
>   		state->pc = regs->csr_era;
> +	} else if (task == current) {
> +		state->sp = (unsigned long)__builtin_frame_address(0);
> +		state->pc = (unsigned long)__builtin_return_address(0);
> +	} else {
> +		state->sp = thread_saved_fp(task);
> +		state->pc = thread_saved_ra(task);
>   
The case for tasks is already handled in stacktrace.c, which is reusable 
code:
void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
		     struct task_struct *task, struct pt_regs *regs)
{
...

	if (task == current) {
		regs->regs[3] = (unsigned long)__builtin_frame_address(0);
		regs->csr_era = (unsigned long)__builtin_return_address(0);
	} else {
		regs->regs[3] = thread_saved_fp(task);
		regs->csr_era = thread_saved_ra(task);
	}
...
	for (unwind_start(&state, task, regs);
	      !unwind_done(&state); unwind_next_frame(&state)) {
		addr = unwind_get_return_address(&state);
...
}

>   
>   	state->task = task;
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> index 0f8d1451ebb8..9d51ea37782e 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -141,12 +141,22 @@ void unwind_start(struct unwind_state *state, struct task_struct *task,
>   		    struct pt_regs *regs)
>   {
>   	memset(state, 0, sizeof(*state));
> +	state->type = UNWINDER_PROLOGUE;
>   
> -	if (regs &&  __kernel_text_address(regs->csr_era)) {
> -		state->pc = regs->csr_era;
> +	if (regs) {
>   		state->sp = regs->regs[3];
> +		state->pc = regs->csr_era;
>   		state->ra = regs->regs[1];
> -		state->type = UNWINDER_PROLOGUE;
> +		if (!__kernel_text_address(state->pc))
> +			state->type = UNWINDER_GUESS;
> +	} else if (task == current) {
> +		state->sp = (unsigned long)__builtin_frame_address(0);
> +		state->pc = (unsigned long)__builtin_return_address(0);
> +		state->ra = 0;
> +	} else {
> +		state->sp = thread_saved_fp(task);
> +		state->pc = thread_saved_ra(task);
> +		state->ra = 0;
>   	}
>   
also...
>   	state->task = task;
> 
Thanks,
-Qing

