Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EE764DAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLOMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLOMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:05:01 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE855263A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:04:57 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxaepoDZtjgNEFAA--.9961S3;
        Thu, 15 Dec 2022 20:04:56 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+RmDZtjs3UAAA--.1958S3;
        Thu, 15 Dec 2022 20:04:55 +0800 (CST)
Subject: Re: [PATCH 6/6] LoongArch: Add generic ex-handler unwind in prologue
 unwinder
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221215040141.18610-1-hejinyang@loongson.cn>
 <20221215040141.18610-7-hejinyang@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <2aa963e1-e202-73b8-725f-3ca207d622a7@loongson.cn>
Date:   Thu, 15 Dec 2022 20:04:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221215040141.18610-7-hejinyang@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxb+RmDZtjs3UAAA--.1958S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3ZF1fWF4fKF1DZr4furyDJrb_yoWDuF4rpF
        90yrs5Gr48Kryqvr47JF1UZrn8Z3ZruF47AayDKryUAFn2qr13Xr1vy34q9r1DCrWUWFyI
        qFnxJrnIka17t3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcrWFUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

On 2022/12/15 下午12:01, Jinyang He wrote:
> When exception is triggered, code flow go handle_\exception in some
> cases. One of stackframe in this case as follows,
> 
> high -> +-------+
>          | REGS  |  <- a pt_regs
>          |       |
>          |       |  <- ex trigger
>          | REGS  |  <- ex pt_regs   <-+
>          |       |                    |
>          |       |                    |
> low  -> +-------+           ->unwind-+
> 
> When unwinder unwind to handler_\exception it cannot go on prologue
> analysis. It is asynchronous code flow, we should get the next frame
> PC from regs->csr_era but not from regs->regs[1]. And we copy the
> handler codes to eentry in the early time and copy the handler codes
> to NUMA-relative memory named pcpu_handlers if NUMA is enabled. Thus,
> unwinder cannot unwind normally. Therefore, try to give some hint in
> handler_\exception and fixup it in unwind_next_frame.
> 
> Reported-by: Qing Zhang <zhangqing@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>   arch/loongarch/include/asm/unwind.h     |   2 +-
>   arch/loongarch/kernel/genex.S           |   3 +
>   arch/loongarch/kernel/unwind_prologue.c | 100 +++++++++++++++++++++---
>   arch/loongarch/mm/tlb.c                 |   2 +-
>   4 files changed, 92 insertions(+), 15 deletions(-)
> 
The others look good to me, but there is still a small problem:
When I tested hw_breakpoint.ko with prologue unwinder,
sometimes output address [<9000000100302724>] 0x9000000100302724, eg: 
CPU: 3 PID: 0
But some processes are normal, eg: CPU: 0 PID: 0

[27.655549] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.1.0-rc8 #9
[27.655552] Hardware name: Loongson Loongson-3A5000-7A1000-1w-A2101/
Loongson-LS3A5000-7A1000-1w-A2101,  BIOS 
vUDK2018-LoongArch-V2.0.pre-beta8 06/15/2022

[27.655604]...
[27.655606] Call Trace:
[27.655607] [<9000000000222f88>] show_stack+0x60/0x184
[27.655613] [<90000000010e9b8c>] dump_stack_lvl+0x60/0x88
[27.655618] [] sample_hbp_handler+0x30/0x4c [data_breakpoint]
[27.655626] [<900000000037c8a0>] __perf_event_overflow+0x84/0x26c
[27.655629] [<900000000038980c>] perf_bp_event+0xc0/0xc8
[27.655633] [<900000000022e3bc>] watchpoint_handler+0x54/0x88
[27.655637] [<90000000010ea2f8>] do_watch+0x30/0x48
[27.655640] [<9000000100302724>] 0x9000000100302724      // Not natural
[27.655642] [<9000000000ab4cbc>] add_interrupt_randomness+0x60/0xbc
[27.655646] [<90000000002a0fa0>] handle_irq_event_percpu+0x28/0x70
[27.655650] [<90000000002a6f9c>] handle_percpu_irq+0x54/0x88
[27.655652] [<90000000002a025c>] generic_handle_domain_irq+0x28/0x40
[27.655655] [<9000000000995458>] handle_cpu_irq+0x68/0xa4
[27.655658] [<90000000010ea8dc>] handle_loongarch_irq+0x34/0x4c
[27.655661] [<90000000010ea974>] do_vint+0x80/0xb4
[27.655664] [<90000000002216a0>] __arch_cpu_idle+0x20/0x24
[27.655667] [<90000000010f8178>] default_idle_call+0x30/0x58
[27.655670] [<90000000002825cc>] do_idle+0xb4/0x118
[27.655674] [<900000000028281c>] cpu_startup_entry+0x20/0x24
[27.655677] [<900000000022b198>] start_secondary+0x9c/0xa4
[27.655679] [<90000000010eb124>] smpboot_entry+0x60/0x64


[27.658940] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc8 #9
...
[28.229978] Call Trace:
[28.229979] [<9000000000222f88>] show_stack+0x60/0x184
[28.237503] [<90000000010e9b8c>] dump_stack_lvl+0x60/0x88
[28.242866] [] sample_hbp_handler+0x30/0x4c [data_breakpoint]
[28.250132] [<900000000037c8a0>] __perf_event_overflow+0x84/0x26c
[28.256186] [<900000000038980c>] perf_bp_event+0xc0/0xc8
[28.261462] [<900000000022e3bc>] watchpoint_handler+0x54/0x88
[28.267170] [<90000000010ea2f8>] do_watch+0x30/0x48
[28.272013] [<90000000017d2724>] exception_handlers+0x2724/0x1000  //...
[28.278155] [<9000000000ab4cbc>] add_interrupt_randomness+0x60/0xbc
[28.284381] [<90000000002a0fa0>] handle_irq_event_percpu+0x28/0x70
[28.290520] [<90000000002a6f9c>] handle_percpu_irq+0x54/0x88
[28.296140] [<90000000002a025c>] generic_handle_domain_irq+0x28/0x40
[28.302452] [<9000000000995458>] handle_cpu_irq+0x68/0xa4
[28.307813] [<90000000010ea8dc>] handle_loongarch_irq+0x34/0x4c
[28.313693] [<90000000010ea974>] do_vint+0x80/0xb4
[28.318450] [<90000000002216a0>] __arch_cpu_idle+0x20/0x24
[28.323897] [<90000000010f8178>] default_idle_call+0x30/0x58
[28.329518] [<90000000002825cc>] do_idle+0xb4/0x118
[28.334361] [<900000000028281c>] cpu_startup_entry+0x20/0x24
[28.339982] [<90000000010ec0dc>] kernel_init+0x0/0x110
[28.345085] [<90000000011106f8>] arch_post_acpi_subsys_init+0x0/0x4

Maybe sometimes assembly kallsyms is not recognized, let me think...

Thanks,
-Qing

> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> index a16aff1d086a..c02cb3b39fe2 100644
> --- a/arch/loongarch/include/asm/unwind.h
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -24,7 +24,7 @@ struct unwind_state {
>   	char type; /* UNWINDER_XXX */
>   	struct stack_info stack_info;
>   	struct task_struct *task;
> -	bool first, error, is_ftrace;
> +	bool first, error, reset;
>   	int graph_idx;
>   	unsigned long sp, pc, ra;
>   	const struct unwinder_ops *ops;
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 75e5be807a0d..7e5c293ed89f 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -67,14 +67,17 @@ SYM_FUNC_END(except_vec_cex)
>   	.macro	BUILD_HANDLER exception handler prep
>   	.align	5
>   	SYM_FUNC_START(handle_\exception)
> +	666:
>   	BACKUP_T0T1
>   	SAVE_ALL
>   	build_prep_\prep
>   	move	a0, sp
>   	la.abs	t0, do_\handler
>   	jirl	ra, t0, 0
> +	668:
>   	RESTORE_ALL_AND_RET
>   	SYM_FUNC_END(handle_\exception)
> +	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
>   	.endm
>   
>   	BUILD_HANDLER ade ade badv
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> index 441641227c10..c34bb035ac56 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -2,23 +2,102 @@
>   /*
>    * Copyright (C) 2022 Loongson Technology Corporation Limited
>    */
> +#include <linux/cpumask.h>
>   #include <linux/ftrace.h>
>   #include <linux/kallsyms.h>
>   
>   #include <asm/inst.h>
> +#include <asm/loongson.h>
>   #include <asm/ptrace.h>
> +#include <asm/setup.h>
>   #include <asm/unwind.h>
>   
>   static const struct unwinder_ops *guard_unwinder = &unwinder_guess;
>   
> -static inline void unwind_state_fixup(struct unwind_state *state)
> +extern const int unwind_hint_ade;
> +extern const int unwind_hint_ale;
> +extern const int unwind_hint_bp;
> +extern const int unwind_hint_fpe;
> +extern const int unwind_hint_fpu;
> +extern const int unwind_hint_lsx;
> +extern const int unwind_hint_lasx;
> +extern const int unwind_hint_lbt;
> +extern const int unwind_hint_ri;
> +extern const int unwind_hint_watch;
> +extern unsigned long eentry;
> +#ifdef CONFIG_NUMA
> +extern unsigned long pcpu_handlers[NR_CPUS];
> +#endif
> +
> +static inline bool scan_handler(unsigned long entry_offset)
>   {
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -	static unsigned long ftrace = (unsigned long)ftrace_call + 4;
> +	int idx, offset;
>   
> -	if (state->pc == ftrace)
> -		state->is_ftrace = true;
> +	if (entry_offset >= EXCCODE_INT_START * VECSIZE)
> +		return false;
> +
> +	idx = entry_offset / VECSIZE;
> +	offset = entry_offset % VECSIZE;
> +	switch (idx) {
> +	case EXCCODE_ADE:
> +		return offset == unwind_hint_ade;
> +	case EXCCODE_ALE:
> +		return offset == unwind_hint_ale;
> +	case EXCCODE_BP:
> +		return offset == unwind_hint_bp;
> +	case EXCCODE_FPE:
> +		return offset == unwind_hint_fpe;
> +	case EXCCODE_FPDIS:
> +		return offset == unwind_hint_fpu;
> +	case EXCCODE_LSXDIS:
> +		return offset == unwind_hint_lsx;
> +	case EXCCODE_LASXDIS:
> +		return offset == unwind_hint_lasx;
> +	case EXCCODE_BTDIS:
> +		return offset == unwind_hint_lbt;
> +	case EXCCODE_INE:
> +		return offset == unwind_hint_ri;
> +	case EXCCODE_WATCH:
> +		return offset == unwind_hint_watch;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool fix_exceptions(unsigned long pc)
> +{
> +#ifdef CONFIG_NUMA
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (!pcpu_handlers[cpu])
> +			continue;
> +		if (scan_handler(pc - pcpu_handlers[cpu]))
> +			return true;
> +	}
>   #endif
> +	return scan_handler(pc - eentry);
> +}
> +
> +/*
> + * As we meet ftrace_regs_entry, reset first flag like first doing
> + * tracing. Prologue analysis will stop soon because PC is at entry.
> + */
> +static inline bool fix_ftrace(unsigned long pc)
> +{
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	return pc == (unsigned long)ftrace_call + LOONGARCH_INSN_SIZE;
> +#else
> +	return false;
> +#endif
> +}
> +
> +static inline bool unwind_state_fixup(struct unwind_state *state)
> +{
> +	if (!fix_exceptions(state->pc) && !fix_ftrace(state->pc))
> +		return false;
> +	state->reset = true;
> +	return true;
>   }
>   
>   static unsigned long get_return_address(struct unwind_state *state)
> @@ -46,14 +125,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
>   	if (state->sp >= info->end || state->sp < info->begin)
>   		return false;
>   
> -	if (state->is_ftrace) {
> -		/*
> -		 * As we meet ftrace_regs_entry, reset first flag like first doing
> -		 * tracing. Prologue analysis will stop soon because PC is at entry.
> -		 */
> +	if (state->reset) {
>   		regs = (struct pt_regs *)state->sp;
>   		state->first = true;
> -		state->is_ftrace = false;
> +		state->reset = false;
>   		state->pc = regs->csr_era;
>   		state->ra = regs->regs[1];
>   		state->sp = regs->regs[3];
> @@ -118,8 +193,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>   
>   out:
>   	state->first = false;
> -	unwind_state_fixup(state);
> -	return !!__kernel_text_address(state->pc);
> +	return unwind_state_fixup(state) || __kernel_text_address(state->pc);
>   }
>   
>   static int raw_show_trace;
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index da3681f131c8..8bad6b0cff59 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -251,7 +251,7 @@ static void output_pgtable_bits_defines(void)
>   }
>   
>   #ifdef CONFIG_NUMA
> -static unsigned long pcpu_handlers[NR_CPUS];
> +unsigned long pcpu_handlers[NR_CPUS];
>   #endif
>   extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>   
> 

