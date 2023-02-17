Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2513C69A8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBQKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:16:39 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8135AB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1676628994; bh=mktOgn41vxedMEa2KB+BXaGq3+OurN2Pfq1lnp6IMCA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tfQXiVF+scF9bZuxuo7t1orQpZao4paTgcC1MOENqQY7jtrImYZC7NCQ0dQa4fFDK
         DyV2/Ree0JiO3nTArXebbQZogrYdrmRdIerYYlnShryZtH1pDAkleEDc5txfoUVWzB
         jCoetr9LpQ4XHiSk8GExDL/JzAkL/kMMrCnHPdAg=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 83D6C600BD;
        Fri, 17 Feb 2023 18:16:34 +0800 (CST)
Message-ID: <bd9e8bf6-fadc-5be5-3179-e04daa45e150@xen0n.name>
Date:   Fri, 17 Feb 2023 18:16:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v4 2/3] LoongArch: Add ptrace single step support
Content-Language: en-US
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230217023745.20800-1-zhangqing@loongson.cn>
 <20230217023745.20800-3-zhangqing@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230217023745.20800-3-zhangqing@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/17 10:37, Qing Zhang wrote:
> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
> PTRACE_KILL and PTRACE_SINGLESTEP. This implies defining
> arch_has_single_step in  and implementing the
> user_enable_single_step and user_disable_single_step functions.
> 
> LongArch has no hardware single-step register. the hardware single-step

"LoongArch cannot do hardware single-stepping per se" could be more 
accurate a description. ("Hardware single-step register" could be 
ambiguous in implying the only way to achieve single-stepping would be 
via software, but in fact you explained in the next sentence that it's 
actually doable, just in an alternate way.)

> function multiplex fetch instruction watchpoint(FWPS) and specifies that
> the next instruction must trigger the watch exception by setting the mask bit.

I assume the "multiplex" is translated from "复用", in which case it's not 
used in the exact same way as in Chinese. Plus you have the subject 
wrong, "hardware single-step function" is the topic but not the actor 
doing the "multiplexing".

My take (continuing from the previous sentence I suggested):

"Instead it is achieved by configuring the instruction fetch watchpoints 
so that WPEF is triggered on the next instruction."

> Some scenarios use CSR.FWPS.Skip to ignore the next hit result, not to trigger
> the watchpoint exception, and proceed to the next instruction.

Again, wrong topicalization ("scenarios" is not the actor/subject). "In 
some scenarios CSR.FWPS.Skip is used to ..." sounds better.

And the multiple "next" usages sound unclear, you could probably reword 
this a bit. (I can't immediately understand this part so I'm unable to 
provide a suggestion.)

> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>   arch/loongarch/include/asm/inst.h      | 39 +++++++++++++++
>   arch/loongarch/include/asm/loongarch.h |  3 ++
>   arch/loongarch/include/asm/processor.h |  3 ++
>   arch/loongarch/include/asm/ptrace.h    |  2 +
>   arch/loongarch/kernel/hw_breakpoint.c  | 35 +++++++++++--
>   arch/loongarch/kernel/ptrace.c         | 68 ++++++++++++++++++++++++++
>   arch/loongarch/kernel/traps.c          | 34 +++++++++++--
>   7 files changed, 176 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index ba18ce8fbdf2..00c6f261d9a2 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -368,6 +368,45 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
>   		is_imm12_negative(ip->reg2i12_format.immediate);
>   }
>   
> +static inline bool branch_ins_target_pc(union loongarch_instruction *ip)

This name is not faithfully reflecting its purpose, which is to check if 
the given instruction will change PC; and the reason this has to be done 
in the first place being that, single stepping would never stop due to 
current hardware erratum if the PC would stay the same after the insn's 
execution.

You may want to add some comments regarding the erratum too if you're in 
a position to disclose more details.

> +{
> +	switch (ip->reg0i26_format.opcode) {
> +	case b_op:
> +	case bl_op:
> +		if (ip->reg0i26_format.immediate_l == 0
> +		   && ip->reg0i26_format.immediate_h == 0)
> +			return false;
> +	}
> +
> +	switch (ip->reg1i21_format.opcode) {
> +	case beqz_op:
> +	case bnez_op:
> +	case bceqz_op:
> +		if (ip->reg1i21_format.immediate_l == 0
> +		   && ip->reg1i21_format.immediate_h == 0)
> +			return false;
> +	}
> +
> +	switch (ip->reg2i16_format.opcode) {
> +	case jirl_op:
> +		if (ip->reg2i16_format.rj == 0x1
> +		   && ip->reg2i16_format.rd == 0x1
Given the appearance of the other cases, I feel like the triggering 
condition of the nonterminating singlestepping is that "new PC == 
current PC" always hold. So, isn't every `rd == rj && imm == 0` case 
problematic?

> +		   && ip->reg2i16_format.immediate == 0)
> +			return false;
> +		break;
> +	case beq_op:
> +	case bne_op:
> +	case blt_op:
> +	case bge_op:
> +	case bltu_op:
> +	case bgeu_op:
> +		if (ip->reg2i16_format.immediate == 0)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   void simu_pc(struct pt_regs *regs, union loongarch_instruction insn);
>   void simu_branch(struct pt_regs *regs, union loongarch_instruction insn);
>   
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
> index e9aed583a064..65b7dcdea16d 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -1055,6 +1055,9 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
>   #define LOONGARCH_CSR_DERA		0x501	/* debug era */
>   #define LOONGARCH_CSR_DESAVE		0x502	/* debug save */
>   
> +#define CSR_FWPC_SKIP_SHIFT		16
> +#define CSR_FWPC_SKIP			(_ULCAST_(1) << CSR_FWPC_SKIP_SHIFT)
> +
>   /*
>    * CSR_ECFG IM
>    */
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index db060c5a976f..3ea0f1910c23 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -131,6 +131,9 @@ struct thread_struct {
>   	struct perf_event	*hbp_break[LOONGARCH_MAX_BRP];
>   	struct perf_event	*hbp_watch[LOONGARCH_MAX_WRP];
>   
> +	/* Used by ptrace single_step */

"PTRACE_SINGLESTEP" if you want to refer to the technical name of the 
feature, or "ptrace single stepping" which is more natural language.

> +	unsigned long single_step;
> +
>   	/*
>   	 * FPU & vector registers, must be at last because
>   	 * they are conditionally copied at fork().
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 58596c4f8a0f..66a0e6c480a3 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -150,4 +150,6 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
>   	regs->regs[3] = val;
>   }
>   
> +#define arch_has_single_step()		(1)
> +
>   #endif /* _ASM_PTRACE_H */
> diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
> index 6431cd319c32..75d3652fbe00 100644
> --- a/arch/loongarch/kernel/hw_breakpoint.c
> +++ b/arch/loongarch/kernel/hw_breakpoint.c
> @@ -153,6 +153,22 @@ static int hw_breakpoint_slot_setup(struct perf_event **slots, int max_slots,
>    */
>   void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>   {
> +	int i;
> +	struct thread_struct *t = &tsk->thread;
> +
> +	for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
> +		if (t->hbp_break[i]) {
> +			unregister_hw_breakpoint(t->hbp_break[i]);
> +			t->hbp_break[i] = NULL;
> +		}
> +	}
> +
> +	for (i = 0; i < LOONGARCH_MAX_WRP; i++) {
> +		if (t->hbp_watch[i]) {
> +			unregister_hw_breakpoint(t->hbp_watch[i]);
> +			t->hbp_watch[i] = NULL;
> +		}
> +	}
>   }
>   
>   void ptrace_hw_copy_thread(struct task_struct *tsk)
> @@ -498,11 +514,20 @@ arch_initcall(arch_hw_breakpoint_init);
>   void hw_breakpoint_thread_switch(struct task_struct *next)
>   {
>   	struct pt_regs *regs = task_pt_regs(next);
> -
> -	/* Update breakpoints */
> -	update_bp_registers(regs, 1, 0);
> -	/* Update watchpoints */
> -	update_bp_registers(regs, 1, 1);
> +	u64 addr, mask;
> +
> +	if (test_bit(TIF_SINGLESTEP, &task_thread_info(next)->flags)) {
> +		addr = read_wb_reg(CSR_CFG_ADDR, 0, 0);
> +		mask = read_wb_reg(CSR_CFG_MASK, 0, 0);
> +		if ((task_pt_regs(next)->csr_era & ~mask) == (addr & ~mask))
> +			csr_write32(CSR_FWPC_SKIP, LOONGARCH_CSR_FWPS);
> +		regs->csr_prmd |= CSR_PRMD_PWE;
> +	} else {
> +		/* Update breakpoints */
> +		update_bp_registers(regs, 1, 0);
> +		/* Update watchpoints */
> +		update_bp_registers(regs, 1, 1);
> +	}
>   }
>   
>   void hw_breakpoint_pmu_read(struct perf_event *bp)
> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
> index bee4194177fd..52a3ee4366f4 100644
> --- a/arch/loongarch/kernel/ptrace.c
> +++ b/arch/loongarch/kernel/ptrace.c
> @@ -20,6 +20,7 @@
>   #include <linux/context_tracking.h>
>   #include <linux/elf.h>
>   #include <linux/errno.h>
> +#include <linux/hw_breakpoint.h>
>   #include <linux/mm.h>
>   #include <linux/ptrace.h>
>   #include <linux/regset.h>
> @@ -30,6 +31,7 @@
>   #include <linux/stddef.h>
>   #include <linux/seccomp.h>
>   #include <linux/uaccess.h>
> +#include <linux/thread_info.h>
>   
>   #include <asm/byteorder.h>
>   #include <asm/cpu.h>
> @@ -39,6 +41,7 @@
>   #include <asm/page.h>
>   #include <asm/pgtable.h>
>   #include <asm/processor.h>
> +#include <asm/ptrace.h>
>   #include <asm/reg.h>
>   #include <asm/syscall.h>
>   
> @@ -541,3 +544,68 @@ long arch_ptrace(struct task_struct *child, long request,
>   
>   	return ret;
>   }
> +
> +void ptrace_triggered(struct perf_event *bp,
> +		      struct perf_sample_data *data, struct pt_regs *regs)
> +{
> +	struct perf_event_attr attr;
> +
> +	attr = bp->attr;
> +	attr.disabled = true;
> +	modify_user_hw_breakpoint(bp, &attr);
> +}
> +
> +static int set_single_step(struct task_struct *tsk, unsigned long addr)
> +{
> +	struct thread_struct *thread = &tsk->thread;
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +	struct arch_hw_breakpoint *info;
> +
> +	bp = thread->hbp_break[0];
> +	if (!bp) {
> +		ptrace_breakpoint_init(&attr);
> +
> +		attr.bp_addr = addr;
> +		attr.bp_len = HW_BREAKPOINT_LEN_8;
> +		attr.bp_type = HW_BREAKPOINT_X;
> +
> +		bp = register_user_hw_breakpoint(&attr, ptrace_triggered,
> +						 NULL, tsk);
> +		if (IS_ERR(bp))
> +			return PTR_ERR(bp);
> +
> +		thread->hbp_break[0] = bp;
> +	} else {
> +		int err;
> +
> +		attr = bp->attr;
> +		attr.bp_addr = addr;
> +		/* reenable breakpoint */
> +		attr.disabled = false;
> +		err = modify_user_hw_breakpoint(bp, &attr);
> +		if (unlikely(err))
> +			return err;
> +
> +		csr_write64(attr.bp_addr, LOONGARCH_CSR_IB0ADDR);
> +	}
> +	info = counter_arch_bp(bp);
> +	info->mask = 0xffffffffffff;
> +
> +	return 0;
> +}
> +
> +/* ptrace API */
> +void user_enable_single_step(struct task_struct *task)
> +{
> +	struct thread_info *ti = task_thread_info(task);
> +
> +	set_single_step(task, task_pt_regs(task)->csr_era);
> +	task->thread.single_step = task_pt_regs(task)->csr_era;
> +	set_ti_thread_flag(ti, TIF_SINGLESTEP);
> +}
> +
> +void user_disable_single_step(struct task_struct *task)
> +{
> +	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
> +}
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 2b133079e0f3..a59275a43bd1 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -511,9 +511,37 @@ asmlinkage void noinstr do_watch(struct pt_regs *regs)
>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>   	irqentry_state_t state = irqentry_enter(regs);
>   
> -	breakpoint_handler(regs);
> -	watchpoint_handler(regs);
> -	force_sig(SIGTRAP);
> +	if (test_tsk_thread_flag(current, TIF_SINGLESTEP)) {
> +		int llbit = (csr_read32(LOONGARCH_CSR_LLBCTL) & 0x1);
> +		unsigned long pc = regs->csr_era;
> +		union loongarch_instruction *ip = (union loongarch_instruction *)pc;
> +
> +		if (llbit) {
> +		/*
> +		 * When the ll-sc combo is encountered, it is regarded as an single
> +		 * instruction. So don't clear llbit and reset CSR.FWPS.Skip until
> +		 * the llsc execution is completed.
> +		 */
> +			csr_write32(CSR_FWPC_SKIP, LOONGARCH_CSR_FWPS);
> +			csr_write32(CSR_LLBCTL_KLO, LOONGARCH_CSR_LLBCTL);
> +		} else if (pc == current->thread.single_step) {
> +		/*
> +		 * Maybe some hardware Bug caused that certain insns are occasionally
> +		 * not skipped when CSR.FWPS.Skip is set, such as fld.d/fst.d. So Singlestep
> +		 * needs to compare whether the csr_era is equal to the value of singlestep
> +		 * which last time set.
> +		 */
> +			if (branch_ins_target_pc(ip))
> +			/* Prevent rd == pc from causing single step to fail to stop */
> +				csr_write32(CSR_FWPC_SKIP, LOONGARCH_CSR_FWPS);
> +		} else {
> +			force_sig(SIGTRAP);
> +		}
> +	} else {
> +		breakpoint_handler(regs);
> +		watchpoint_handler(regs);
> +		force_sig(SIGTRAP);
> +	}
>   
>   	irqentry_exit(regs, state);
>   #endif

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

