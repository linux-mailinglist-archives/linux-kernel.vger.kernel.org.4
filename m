Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9B5E587B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIVCT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIVCTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:19:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A1D29AFE1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:19:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2snxitjj9cfAA--.52061S3;
        Thu, 22 Sep 2022 10:19:21 +0800 (CST)
Subject: Re: [PATCH 1/4] LoongArch: Add kprobe support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
 <1663645034-967-2-git-send-email-yangtiezhu@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jinyang He <hejinyang@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <8c54706f-4e5e-bab9-9382-f4195093996b@loongson.cn>
Date:   Thu, 22 Sep 2022 10:19:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1663645034-967-2-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx_2snxitjj9cfAA--.52061S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uw1ruFyDJF4DAF13Kr47CFg_yoW8CF1Uuo
        W3tF1q9r4rGry3CF45Jr9rXayUW3W0gFZ5AFWUZFs8Zr17Ar15Xr4UCr4kJ3WagF4ktw4x
        Ca47ua4rAa1S93Z3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xF
        o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2022 11:37 AM, Tiezhu Yang wrote:

> Kprobes allows you to trap at almost any kernel address and
> execute a callback function, this commit adds kprobe support
> for LoongArch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/Kconfig               |   1 +
>   arch/loongarch/include/asm/inst.h    |  31 ++++
>   arch/loongarch/include/asm/kprobes.h |  44 +++++
>   arch/loongarch/include/asm/ptrace.h  |   1 +
>   arch/loongarch/kernel/Makefile       |   2 +
>   arch/loongarch/kernel/inst.c         | 107 ++++++++++++
>   arch/loongarch/kernel/kprobes.c      | 309 +++++++++++++++++++++++++++++++++++
>   7 files changed, 495 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/kprobes.h
>   create mode 100644 arch/loongarch/kernel/kprobes.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 5b5fc94..6b01073 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -94,6 +94,7 @@ config LOONGARCH
>   	select HAVE_IOREMAP_PROT
>   	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>   	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_KPROBES
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_NMI
>   	select HAVE_PCI
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index fce1843..fc8879b 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -7,6 +7,7 @@
>   
>   #include <linux/types.h>
>   #include <asm/asm.h>
> +#include <asm/ptrace.h>
>   
>   #define INSN_BREAK		0x002a0000
>   
> @@ -20,6 +21,10 @@
>   
>   #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
>   
> +enum reg0i15_op {
> +	break_op	= 0x54,
> +};
> +
>   enum reg0i26_op {
>   	b_op		= 0x14,
>   	bl_op		= 0x15,
> @@ -28,6 +33,8 @@ enum reg0i26_op {
>   enum reg1i20_op {
>   	lu12iw_op	= 0x0a,
>   	lu32id_op	= 0x0b,
> +	pcaddi_op	= 0x0c,
> +	pcalau12i_op	= 0x0d,
>   	pcaddu12i_op	= 0x0e,
>   	pcaddu18i_op	= 0x0f,
>   };
> @@ -35,6 +42,8 @@ enum reg1i20_op {
>   enum reg1i21_op {
>   	beqz_op		= 0x10,
>   	bnez_op		= 0x11,
> +	bceqz_op	= 0x48000000,
> +	bcnez_op	= 0x48000100,
>   };
>   
>   enum reg2_op {
> @@ -164,6 +173,11 @@ enum reg3sa2_op {
>   	alsld_op	= 0x16,
>   };
>   
> +struct reg0i15_format {
> +	unsigned int immediate : 15;
> +	unsigned int opcode : 17;
> +};
> +
>   struct reg0i26_format {
>   	unsigned int immediate_h : 10;
>   	unsigned int immediate_l : 16;
> @@ -249,6 +263,7 @@ struct reg3sa2_format {
>   
>   union loongarch_instruction {
>   	unsigned int word;
> +	struct reg0i15_format	reg0i15_format;
>   	struct reg0i26_format	reg0i26_format;
>   	struct reg1i20_format	reg1i20_format;
>   	struct reg1i21_format	reg1i21_format;
> @@ -313,6 +328,12 @@ static inline bool is_branch_ins(union loongarch_instruction *ip)
>   		ip->reg1i21_format.opcode <= bgeu_op;
>   }
>   
> +static inline bool is_pc_ins(union loongarch_instruction *ip)
> +{
> +	return ip->reg1i20_format.opcode >= pcaddi_op &&
> +		ip->reg1i20_format.opcode <= pcaddu18i_op;
> +}
> +
>   static inline bool is_ra_save_ins(union loongarch_instruction *ip)
>   {
>   	/* st.d $ra, $sp, offset */
> @@ -334,6 +355,16 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
>   u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>   u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
>   u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn);
> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn);
> +
> +static inline unsigned long sign_extended(unsigned long val, unsigned int idx)
> +{
> +	if (val & (1UL << idx))
> +		return ~((1UL << (idx + 1)) - 1) | val;
> +	else
> +		return ((1UL << (idx + 1)) - 1) & val;
> +}
>   
>   static inline bool signed_imm_check(long val, unsigned int bit)
>   {
> diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
> new file mode 100644
> index 0000000..afcf254
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kprobes.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_LOONGARCH_KPROBES_H
> +#define __ASM_LOONGARCH_KPROBES_H
> +
> +#include <asm-generic/kprobes.h>
> +
> +#ifdef CONFIG_KPROBES
> +
> +#include <asm/inst.h>
> +
> +#define __ARCH_WANT_KPROBES_INSN_SLOT
> +#define MAX_INSN_SIZE			2
> +
> +#define flush_insn_slot(p)		do { } while (0)
> +#define kretprobe_blacklist_size	0
> +
> +typedef union loongarch_instruction kprobe_opcode_t;
> +
> +/* Architecture specific copy of original instruction */
> +struct arch_specific_insn {
> +	/* copy of the original instruction */
> +	kprobe_opcode_t *insn;
> +};
> +
> +struct prev_kprobe {
> +	struct kprobe *kp;
> +	unsigned long status;
> +	unsigned long saved_irq;
> +	unsigned long saved_era;
> +};
> +
> +/* per-cpu kprobe control block */
> +struct kprobe_ctlblk {
> +	unsigned long kprobe_status;
> +	unsigned long kprobe_saved_irq;
> +	unsigned long kprobe_saved_era;
> +	struct prev_kprobe prev_kprobe;
> +};
> +
> +void arch_remove_kprobe(struct kprobe *p);
> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> +
> +#endif /* CONFIG_KPROBES */
> +#endif /* __ASM_LOONGARCH_KPROBES_H */
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 17838c6..eb9538a 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -6,6 +6,7 @@
>   #define _ASM_PTRACE_H
>   
>   #include <asm/page.h>
> +#include <asm/irqflags.h>
>   #include <asm/thread_info.h>
>   #include <uapi/asm/ptrace.h>
>   
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 5358144..ff98d8a 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -33,4 +33,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>   
>   obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
>   
> +obj-$(CONFIG_KPROBES)		+= kprobes.o
> +
>   CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index b1df0ec..143acb6 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -38,3 +38,110 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
>   
>   	return insn.word;
>   }
> +
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +	unsigned int imm, imm_l, imm_h, rd, rj;
> +	unsigned long pc = regs->csr_era;
> +
> +	imm_l = insn.reg0i26_format.immediate_l;
> +	imm_h = insn.reg0i26_format.immediate_h;
> +	switch (insn.reg0i26_format.opcode) {
> +	case b_op:
> +		regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 27);
> +		return;
> +	case bl_op:
> +		regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 27);
> +		regs->regs[1] = pc + LOONGARCH_INSN_SIZE;
> +		return;
> +	}
> +
> +	imm_l = insn.reg1i21_format.immediate_l;
> +	imm_h = insn.reg1i21_format.immediate_h;
> +	rj = insn.reg1i21_format.rj;
> +	switch (insn.reg1i21_format.opcode) {
> +	case beqz_op:
> +		if (regs->regs[rj] == 0)
> +			regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 22);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		return;
> +	case bnez_op:
> +		if (regs->regs[rj] != 0)
> +			regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 22);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		return;
> +	}
> +
> +	imm = insn.reg2i16_format.immediate;
> +	rj = insn.reg2i16_format.rj;
> +	rd = insn.reg2i16_format.rd;
> +	switch (insn.reg2i16_format.opcode) {
> +	case beq_op:
> +		if (regs->regs[rj] == regs->regs[rd])
> +			regs->csr_era = pc + sign_extended(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bne_op:
> +		if (regs->regs[rj] != regs->regs[rd])
> +			regs->csr_era = pc + sign_extended(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case blt_op:
> +		if ((long)regs->regs[rj] < (long)regs->regs[rd])
> +			regs->csr_era = pc + sign_extended(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bge_op:
> +		if ((long)regs->regs[rj] >= (long)regs->regs[rd])
> +			regs->csr_era = pc + sign_extended(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bltu_op:
> +		if (regs->regs[rj] < regs->regs[rd])
> +			regs->csr_era = pc + sign_extended(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bgeu_op:
> +		if (regs->regs[rj] >= regs->regs[rd])
> +			regs->csr_era = pc + sign_extended(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case jirl_op:
> +		regs->csr_era = regs->regs[rj] + sign_extended(imm << 2, 17);
> +		regs->regs[rd] = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	}
> +}
> +
> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +	unsigned long pc = regs->csr_era;
> +	unsigned int rd = insn.reg1i20_format.rd;
> +	unsigned int imm = insn.reg1i20_format.immediate;
> +
> +	switch (insn.reg1i20_format.opcode) {
> +	case pcaddi_op:
> +		regs->regs[rd] = pc + sign_extended(imm << 2, 21);
> +		break;
> +	case pcaddu12i_op:
> +		regs->regs[rd] = pc + sign_extended(imm << 12, 31);
> +		break;
> +	case pcaddu18i_op:
> +		regs->regs[rd] = pc + sign_extended(imm << 18, 37);
> +		break;
> +	case pcalau12i_op:
> +		regs->regs[rd] = pc + sign_extended(imm << 12, 31);
> +		regs->regs[rd] &= ~((1 << 12) - 1);
> +		break;
> +	}
> +
> +	regs->csr_era += LOONGARCH_INSN_SIZE;
> +}
Hi, Tiezhu,

The simu_pc and the simu_branch should make sure the instruction op is 
excepted.
I think returning with errno or adding notes to explain that is needed.

BTW, I honored these arch-specific simulation work I used to contribute
in the old world, although the codes has been optimized. Could you add
my sign-off?

> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
> new file mode 100644
> index 0000000..b2c73a5
> --- /dev/null
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/kprobes.h>
> +#include <linux/kdebug.h>
> +#include <asm/break.h>
> +
> +static const union loongarch_instruction breakpoint_insn = {
> +	.reg0i15_format = {
> +		.opcode = break_op,
> +		.immediate = BRK_KPROBE_BP,
> +	}
> +};
> +
> +static const union loongarch_instruction singlestep_insn = {
> +	.reg0i15_format = {
> +		.opcode = break_op,
> +		.immediate = BRK_KPROBE_SSTEPBP,
> +	}
> +};
> +
> +DEFINE_PER_CPU(struct kprobe *, current_kprobe);
> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> +
> +static bool insns_are_not_supported(union loongarch_instruction insn)
> +{
> +	switch (insn.reg2i14_format.opcode) {
> +	case llw_op:
> +	case lld_op:
> +	case scw_op:
> +	case scd_op:
> +		pr_notice("kprobe: ll or sc instructions are not supported\n");
> +		return true;
> +	}
> +
> +	switch (insn.reg1i21_format.opcode) {
> +	case bceqz_op:
> +	case bcnez_op:
> +		pr_notice("kprobe: bceqz or bcnez instructions are not supported\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(insns_are_not_supported);
> +
> +int arch_prepare_kprobe(struct kprobe *p)
> +{
> +	union loongarch_instruction insn;
> +
> +	insn = p->addr[0];
> +	if (insns_are_not_supported(insn))
> +		return -EINVAL;
> +
> +	p->ainsn.insn = get_insn_slot();
> +	if (!p->ainsn.insn)
> +		return -ENOMEM;
> +
> +	p->ainsn.insn[0] = *p->addr;
> +	p->ainsn.insn[1] = singlestep_insn;
> +
> +	p->opcode = *p->addr;
> +
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(arch_prepare_kprobe);
> +
> +/* Install breakpoint in text */
> +void arch_arm_kprobe(struct kprobe *p)
> +{
> +	*p->addr = breakpoint_insn;
> +}
> +NOKPROBE_SYMBOL(arch_arm_kprobe);
> +
> +/* Remove breakpoint from text */
> +void arch_disarm_kprobe(struct kprobe *p)
> +{
> +	*p->addr = p->opcode;
> +}
> +NOKPROBE_SYMBOL(arch_disarm_kprobe);
> +
> +void arch_remove_kprobe(struct kprobe *p)
> +{
> +	if (p->ainsn.insn) {
> +		free_insn_slot(p->ainsn.insn, 0);
> +		p->ainsn.insn = NULL;
> +	}
> +}
> +NOKPROBE_SYMBOL(arch_remove_kprobe);
> +
> +static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	kcb->prev_kprobe.kp = kprobe_running();
> +	kcb->prev_kprobe.status = kcb->kprobe_status;
> +	kcb->prev_kprobe.saved_irq = kcb->kprobe_saved_irq;
> +	kcb->prev_kprobe.saved_era = kcb->kprobe_saved_era;
> +}
> +NOKPROBE_SYMBOL(save_previous_kprobe);
> +
> +static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
> +	kcb->kprobe_status = kcb->prev_kprobe.status;
> +	kcb->kprobe_saved_irq = kcb->prev_kprobe.saved_irq;
> +	kcb->kprobe_saved_era = kcb->prev_kprobe.saved_era;
> +}
> +NOKPROBE_SYMBOL(restore_previous_kprobe);
> +
> +static void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
> +			       struct kprobe_ctlblk *kcb)
> +{
> +	__this_cpu_write(current_kprobe, p);
> +	kcb->kprobe_saved_irq = regs->csr_prmd & CSR_PRMD_PIE;
> +	kcb->kprobe_saved_era = regs->csr_era;
> +}
> +NOKPROBE_SYMBOL(set_current_kprobe);
> +
> +static bool insns_are_not_simulated(struct kprobe *p, struct pt_regs *regs)
> +{
> +	if (is_branch_ins(&p->opcode)) {
> +		simu_branch(regs, p->opcode);
> +		return false;
> +	} else if (is_pc_ins(&p->opcode)) {
> +		simu_pc(regs, p->opcode);
> +		return false;
> +	} else {
> +		return true;
> +	}
> +}
> +NOKPROBE_SYMBOL(insns_are_not_simulated);
> +
> +static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> +			     struct kprobe_ctlblk *kcb, int reenter)
> +{
> +	if (reenter) {
> +		save_previous_kprobe(kcb);
> +		set_current_kprobe(p, regs, kcb);
> +		kcb->kprobe_status = KPROBE_REENTER;
> +	} else {
> +		kcb->kprobe_status = KPROBE_HIT_SS;
> +	}
> +
> +	if (p->ainsn.insn->word == breakpoint_insn.word) {
> +		regs->csr_prmd &= ~CSR_PRMD_PIE;
> +		regs->csr_prmd |= kcb->kprobe_saved_irq;
> +		return;
> +	}
> +
> +	regs->csr_prmd &= ~CSR_PRMD_PIE;
> +
> +	if (insns_are_not_simulated(p, regs)) {
> +		kcb->kprobe_status = KPROBE_HIT_SS;
> +		regs->csr_era = (unsigned long)&p->ainsn.insn[0];
> +	} else {
> +		kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +		if (p->post_handler)
> +			p->post_handler(p, regs, 0);
> +		reset_current_kprobe();
> +	}
> +}
> +NOKPROBE_SYMBOL(setup_singlestep);
> +
> +static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
> +			  struct kprobe_ctlblk *kcb)
> +{
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SSDONE:
> +	case KPROBE_HIT_ACTIVE:
> +		kprobes_inc_nmissed_count(p);
> +		setup_singlestep(p, regs, kcb, 1);
> +		break;
> +	case KPROBE_HIT_SS:
> +	case KPROBE_REENTER:
> +		pr_warn("Failed to recover from reentered kprobes.\n");
> +		dump_kprobe(p);
> +		BUG();
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +NOKPROBE_SYMBOL(reenter_kprobe);
> +
> +static bool kprobe_pre_handler(struct pt_regs *regs)
> +{
> +	struct kprobe *p, *cur_kprobe;
> +	struct kprobe_ctlblk *kcb;
> +	unsigned long addr = instruction_pointer(regs);
> +
> +	kcb = get_kprobe_ctlblk();
> +	cur_kprobe = kprobe_running();
> +
> +	p = get_kprobe((kprobe_opcode_t *) addr);
> +	if (p) {
> +		if (cur_kprobe) {
> +			if (reenter_kprobe(p, regs, kcb))
> +				return true;
> +		} else {
> +			/* Probe hit */
> +			set_current_kprobe(p, regs, kcb);
> +			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +
> +			/*
> +			 * If we have no pre-handler or it returned 0, we
> +			 * continue with normal processing.  If we have a
> +			 * pre-handler and it returned non-zero, it will
> +			 * modify the execution path and no need to single
> +			 * stepping. Let's just reset current kprobe and exit.
> +			 *
> +			 * pre_handler can hit a breakpoint and can step thru
> +			 * before return.
> +			 */
> +			if (!p->pre_handler || !p->pre_handler(p, regs))
> +				setup_singlestep(p, regs, kcb, 0);
> +			else
> +				reset_current_kprobe();
> +		}
> +		return true;
> +	}
> +
> +	/*
> +	 * The breakpoint instruction was removed right
> +	 * after we hit it.  Another cpu has removed
> +	 * either a probepoint or a debugger breakpoint
> +	 * at this address.  In either case, no further
> +	 * handling of this interrupt is appropriate.
> +	 * Return back to original instruction, and continue.
> +	 */
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_pre_handler);
> +
> +static inline bool kprobe_post_handler(struct pt_regs *regs)
> +{
> +	struct kprobe *cur = kprobe_running();
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	if (!cur)
> +		return false;
> +
> +	/* Restore back the original saved kprobes variables and continue */
> +	if (kcb->kprobe_status == KPROBE_REENTER) {
> +		restore_previous_kprobe(kcb);
> +		return true;
> +	}
> +
> +	/* Call post handler */
> +	kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +	if (cur->post_handler)
> +		cur->post_handler(cur, regs, 0);
> +
> +	regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
> +	regs->csr_prmd |= kcb->kprobe_saved_irq;
> +
> +	reset_current_kprobe();
> +
> +	return true;
> +}
> +NOKPROBE_SYMBOL(kprobe_post_handler);
> +
> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> +{
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	if (kcb->kprobe_status & KPROBE_HIT_SS) {
> +		regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
> +		regs->csr_prmd |= kcb->kprobe_saved_irq;
> +		reset_current_kprobe();
> +	}
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_fault_handler);
> +
> +int kprobe_exceptions_notify(struct notifier_block *self,
> +			     unsigned long val, void *data)
> +{
> +	struct die_args *args = (struct die_args *)data;
> +	int ret = NOTIFY_DONE;
> +
> +	switch (val) {
> +	case DIE_BREAK:
> +		if (kprobe_pre_handler(args->regs))
> +			ret = NOTIFY_STOP;
> +		break;
> +	case DIE_SSTEPBP:
> +		if (kprobe_post_handler(args->regs))
> +			ret = NOTIFY_STOP;
> +		break;
> +	case DIE_PAGE_FAULT:
> +		preempt_disable();
> +		if (kprobe_running()
> +		    && kprobe_fault_handler(args->regs, args->trapnr))
> +			ret = NOTIFY_STOP;
> +		preempt_enable();
> +		break;
The DIE_PAGE_FAULT not be notified in do_page_fault() now, and the newly
version to call kprobe_fault_handler is do_page_fault()->kprobe_page_fault()
->kprobe_fault_handler().

Thanks,
Jinyang
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(kprobe_exceptions_notify);
> +
> +int __init arch_init_kprobes(void)
> +{
> +	return 0;
> +}

