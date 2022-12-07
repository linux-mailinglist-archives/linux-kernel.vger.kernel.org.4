Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5DA64526C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLGDId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLGDIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:08:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3643AEE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:08:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 845D5617E5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7005C433D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670382507;
        bh=43uBuWi9r5M8qkR+08j2e1tktRgH78/bg0wlbEQqOO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBxKihadfYYvXw46lcOISg/Zn/8/Bimx3QUffj6yCXov5umccIvbvknB5KPWyHEI1
         5whRYxSHaJpWrupxixLxDnGHHDDcXxxX5oWT6Hh/8kI7qaFXBDyzINZMTxvSbtdkjE
         HUy04qpnQjz8yMSthQssgXxyEvFE+g2R8LaZ/DN9xhR7OmSNPE2YXEjM06MC2TgxbF
         7Eh3p38X88Zcb6f72jGfCGYwFmkPqbxRKpLxedNh8hmLnBpmRsMMM/fx4cgPRtisuU
         1nTkko1uXnFtKwcRSIJa0aYAznLZ+z7/2SWoV9kWrGJpnzVBD/zSpyOJzrZG3IH/yg
         rVLlRjXynHowA==
Received: by mail-ej1-f52.google.com with SMTP id t17so10952713eju.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 19:08:27 -0800 (PST)
X-Gm-Message-State: ANoB5pmx3WmWyyyBZEsLq7z+kPFftK75Crj22AZ6Yu1wj5FPWWEJzpUh
        wPdgaa3KBH+TOKc7HWlPSZ7bEfK0Y+QqHyRBF6w=
X-Google-Smtp-Source: AA0mqf4MXP6ik2e9Hd7SX+oZs3XcQkWZoZ1jowmyorygItJ+5TRKFUjDoxUHQuomWPTylTkuS65ypY03lycLQ66VcH4=
X-Received: by 2002:a17:906:dfe1:b0:7c1:bb5:7757 with SMTP id
 lc1-20020a170906dfe100b007c10bb57757mr4334996ejc.633.1670382505915; Tue, 06
 Dec 2022 19:08:25 -0800 (PST)
MIME-Version: 1.0
References: <1669986505-11322-1-git-send-email-yangtiezhu@loongson.cn> <1669986505-11322-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1669986505-11322-3-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 7 Dec 2022 11:08:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7nVtZRMpqpK6bi9-OqH+_pHxB=qPb5fTisb+EnaKKPAw@mail.gmail.com>
Message-ID: <CAAhV-H7nVtZRMpqpK6bi9-OqH+_pHxB=qPb5fTisb+EnaKKPAw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] LoongArch: Add kprobe support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Fri, Dec 2, 2022 at 9:08 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Kprobes allows you to trap at almost any kernel address and
> execute a callback function, this commit adds kprobe support
> for LoongArch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig               |   1 +
>  arch/loongarch/include/asm/inst.h    |  15 ++
>  arch/loongarch/include/asm/kprobes.h |  59 +++++++
>  arch/loongarch/kernel/Makefile       |   2 +
>  arch/loongarch/kernel/kprobes.c      | 311 +++++++++++++++++++++++++++++++++++
>  arch/loongarch/kernel/traps.c        |  13 +-
>  arch/loongarch/mm/fault.c            |   4 +
>  7 files changed, 401 insertions(+), 4 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kprobes.h
>  create mode 100644 arch/loongarch/kernel/kprobes.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 16bf1b6..f6fc156 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -102,6 +102,7 @@ config LOONGARCH
>         select HAVE_IOREMAP_PROT
>         select HAVE_IRQ_EXIT_ON_IRQ_STACK
>         select HAVE_IRQ_TIME_ACCOUNTING
> +       select HAVE_KPROBES
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
>         select HAVE_PCI
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index a91798b..42984d5 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -24,6 +24,10 @@
>
>  #define ADDR_IMM(addr, INSN)   ((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
>
> +enum reg0i15_op {
> +       break_op        = 0x54,
> +};
> +
>  enum reg0i26_op {
>         b_op            = 0x14,
>         bl_op           = 0x15,
> @@ -180,6 +184,11 @@ enum reg3sa2_op {
>         alsld_op        = 0x16,
>  };
>
> +struct reg0i15_format {
> +       unsigned int immediate : 15;
> +       unsigned int opcode : 17;
> +};
> +
>  struct reg0i26_format {
>         unsigned int immediate_h : 10;
>         unsigned int immediate_l : 16;
> @@ -265,6 +274,7 @@ struct reg3sa2_format {
>
>  union loongarch_instruction {
>         unsigned int word;
> +       struct reg0i15_format   reg0i15_format;
>         struct reg0i26_format   reg0i26_format;
>         struct reg1i20_format   reg1i20_format;
>         struct reg1i21_format   reg1i21_format;
> @@ -335,6 +345,11 @@ static inline bool is_branch_ins(union loongarch_instruction *ip)
>                 ip->reg1i21_format.opcode <= bgeu_op;
>  }
>
> +static inline bool is_break_ins(union loongarch_instruction *ip)
> +{
> +       return ip->reg0i15_format.opcode == break_op;
> +}
> +
>  static inline bool is_ra_save_ins(union loongarch_instruction *ip)
>  {
>         /* st.d $ra, $sp, offset */
> diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
> new file mode 100644
> index 0000000..d3903f3
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kprobes.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_LOONGARCH_KPROBES_H
> +#define __ASM_LOONGARCH_KPROBES_H
> +
> +#include <asm-generic/kprobes.h>
> +#include <asm/cacheflush.h>
> +
> +#ifdef CONFIG_KPROBES
> +
> +#include <asm/inst.h>
> +
> +#define __ARCH_WANT_KPROBES_INSN_SLOT
> +#define MAX_INSN_SIZE                  2
> +
> +#define flush_insn_slot(p)                                             \
> +do {                                                                   \
> +       if (p->addr)                                                    \
> +               flush_icache_range((unsigned long)p->addr,              \
> +                          (unsigned long)p->addr +                     \
> +                          (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));  \
> +} while (0)
> +
> +#define kretprobe_blacklist_size       0
> +
> +typedef union loongarch_instruction kprobe_opcode_t;
> +
> +/* Architecture specific copy of original instruction */
> +struct arch_specific_insn {
> +       /* copy of the original instruction */
> +       kprobe_opcode_t *insn;
> +};
> +
> +struct prev_kprobe {
> +       struct kprobe *kp;
> +       unsigned long status;
> +       unsigned long saved_irq;
> +       unsigned long saved_era;
> +};
> +
> +/* per-cpu kprobe control block */
> +struct kprobe_ctlblk {
> +       unsigned long kprobe_status;
> +       unsigned long kprobe_saved_irq;
> +       unsigned long kprobe_saved_era;
> +       struct prev_kprobe prev_kprobe;
> +};
> +
> +void arch_remove_kprobe(struct kprobe *p);
> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> +bool kprobe_breakpoint_handler(struct pt_regs *regs);
> +bool kprobe_singlestep_handler(struct pt_regs *regs);
> +
> +#else /* !CONFIG_KPROBES */
> +
> +static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) { return 0; }
> +static inline bool kprobe_singlestep_handler(struct pt_regs *regs) { return 0; }
> +
> +#endif /* CONFIG_KPROBES */
> +#endif /* __ASM_LOONGARCH_KPROBES_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index fcaa024..6fe4a4e 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -47,4 +47,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>
>  obj-$(CONFIG_PERF_EVENTS)      += perf_event.o perf_regs.o
>
> +obj-$(CONFIG_KPROBES)          += kprobes.o
> +
>  CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
> new file mode 100644
> index 0000000..820a633
> --- /dev/null
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/kprobes.h>
> +#include <linux/kdebug.h>
> +#include <linux/preempt.h>
> +#include <asm/break.h>
> +
> +static const union loongarch_instruction breakpoint_insn = {
> +       .reg0i15_format = {
> +               .opcode = break_op,
> +               .immediate = BRK_KPROBE_BP,
> +       }
> +};
> +
> +static const union loongarch_instruction singlestep_insn = {
> +       .reg0i15_format = {
> +               .opcode = break_op,
> +               .immediate = BRK_KPROBE_SSTEPBP,
> +       }
> +};
> +
> +DEFINE_PER_CPU(struct kprobe *, current_kprobe);
> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> +
> +static bool insns_are_not_supported(union loongarch_instruction insn)
> +{
> +       switch (insn.reg2i14_format.opcode) {
> +       case llw_op:
> +       case lld_op:
> +       case scw_op:
> +       case scd_op:
> +               pr_notice("kprobe: ll and sc instructions are not supported\n");
> +               return true;
> +       }
> +
> +       switch (insn.reg1i21_format.opcode) {
> +       case bceqz_op:
> +               pr_notice("kprobe: bceqz and bcnez instructions are not supported\n");
> +               return true;
> +       }
> +
> +       return false;
> +}
> +NOKPROBE_SYMBOL(insns_are_not_supported);
> +
> +int arch_prepare_kprobe(struct kprobe *p)
> +{
> +       union loongarch_instruction insn;
> +
> +       insn = p->addr[0];
> +       if (insns_are_not_supported(insn))
> +               return -EINVAL;
> +
> +       p->ainsn.insn = get_insn_slot();
> +       if (!p->ainsn.insn)
> +               return -ENOMEM;
> +
> +       p->ainsn.insn[0] = *p->addr;
> +       p->ainsn.insn[1] = singlestep_insn;
> +
> +       p->opcode = *p->addr;
> +
> +       return 0;
> +}
> +NOKPROBE_SYMBOL(arch_prepare_kprobe);
> +
> +/* Install breakpoint in text */
> +void arch_arm_kprobe(struct kprobe *p)
> +{
> +       *p->addr = breakpoint_insn;
> +       flush_insn_slot(p);
> +}
> +NOKPROBE_SYMBOL(arch_arm_kprobe);
> +
> +/* Remove breakpoint from text */
> +void arch_disarm_kprobe(struct kprobe *p)
> +{
> +       *p->addr = p->opcode;
> +       flush_insn_slot(p);
> +}
> +NOKPROBE_SYMBOL(arch_disarm_kprobe);
> +
> +void arch_remove_kprobe(struct kprobe *p)
> +{
> +       if (p->ainsn.insn) {
> +               free_insn_slot(p->ainsn.insn, 0);
> +               p->ainsn.insn = NULL;
> +       }
> +}
> +NOKPROBE_SYMBOL(arch_remove_kprobe);
> +
> +static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +       kcb->prev_kprobe.kp = kprobe_running();
> +       kcb->prev_kprobe.status = kcb->kprobe_status;
> +       kcb->prev_kprobe.saved_irq = kcb->kprobe_saved_irq;
> +       kcb->prev_kprobe.saved_era = kcb->kprobe_saved_era;
> +}
> +NOKPROBE_SYMBOL(save_previous_kprobe);
> +
> +static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +       __this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
> +       kcb->kprobe_status = kcb->prev_kprobe.status;
> +       kcb->kprobe_saved_irq = kcb->prev_kprobe.saved_irq;
> +       kcb->kprobe_saved_era = kcb->prev_kprobe.saved_era;
> +}
> +NOKPROBE_SYMBOL(restore_previous_kprobe);
> +
> +static void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
> +                              struct kprobe_ctlblk *kcb)
> +{
> +       __this_cpu_write(current_kprobe, p);
> +       kcb->kprobe_saved_irq = regs->csr_prmd & CSR_PRMD_PIE;
> +       kcb->kprobe_saved_era = regs->csr_era;
> +}
> +NOKPROBE_SYMBOL(set_current_kprobe);
> +
> +static bool insns_are_not_simulated(struct kprobe *p, struct pt_regs *regs)
> +{
> +       if (is_branch_ins(&p->opcode)) {
> +               simu_branch(regs, p->opcode);
> +               return false;
> +       } else if (is_pc_ins(&p->opcode)) {
> +               simu_pc(regs, p->opcode);
> +               return false;
> +       } else {
> +               return true;
> +       }
> +}
> +NOKPROBE_SYMBOL(insns_are_not_simulated);
> +
> +static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> +                            struct kprobe_ctlblk *kcb, int reenter)
> +{
> +       if (reenter) {
> +               save_previous_kprobe(kcb);
> +               set_current_kprobe(p, regs, kcb);
> +               kcb->kprobe_status = KPROBE_REENTER;
> +       } else {
> +               kcb->kprobe_status = KPROBE_HIT_SS;
> +       }
> +
> +       if (p->ainsn.insn->word == breakpoint_insn.word) {
> +               regs->csr_prmd &= ~CSR_PRMD_PIE;
> +               regs->csr_prmd |= kcb->kprobe_saved_irq;
> +               preempt_enable_no_resched();
> +               return;
> +       }
> +
> +       regs->csr_prmd &= ~CSR_PRMD_PIE;
You can put this line before the previous if, then the line in the if
can be removed.

> +
> +       if (insns_are_not_simulated(p, regs)) {
> +               kcb->kprobe_status = KPROBE_HIT_SS;
> +               regs->csr_era = (unsigned long)&p->ainsn.insn[0];
> +       } else {
> +               kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +               if (p->post_handler)
> +                       p->post_handler(p, regs, 0);
> +               reset_current_kprobe();
> +               preempt_enable_no_resched();
> +       }
> +}
> +NOKPROBE_SYMBOL(setup_singlestep);
> +
> +static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
> +                         struct kprobe_ctlblk *kcb)
> +{
> +       switch (kcb->kprobe_status) {
> +       case KPROBE_HIT_SSDONE:
> +       case KPROBE_HIT_ACTIVE:
> +               kprobes_inc_nmissed_count(p);
> +               setup_singlestep(p, regs, kcb, 1);
> +               break;
> +       case KPROBE_HIT_SS:
> +       case KPROBE_REENTER:
> +               pr_warn("Failed to recover from reentered kprobes.\n");
> +               dump_kprobe(p);
> +               BUG();
> +               break;
> +       default:
> +               WARN_ON(1);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +NOKPROBE_SYMBOL(reenter_kprobe);
> +
> +bool kprobe_breakpoint_handler(struct pt_regs *regs)
> +{
> +       struct kprobe_ctlblk *kcb;
> +       struct kprobe *p, *cur_kprobe;
> +       kprobe_opcode_t *addr = (kprobe_opcode_t *)regs->csr_era;
> +
> +       preempt_disable();
> +       kcb = get_kprobe_ctlblk();
> +       cur_kprobe = kprobe_running();
> +
> +       p = get_kprobe(addr);
> +       if (p) {
> +               if (cur_kprobe) {
> +                       if (reenter_kprobe(p, regs, kcb))
> +                               return true;
> +               } else {
> +                       /* Probe hit */
> +                       set_current_kprobe(p, regs, kcb);
> +                       kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +
> +                       /*
> +                        * If we have no pre-handler or it returned 0, we
> +                        * continue with normal processing.  If we have a
> +                        * pre-handler and it returned non-zero, it will
> +                        * modify the execution path and no need to single
> +                        * stepping. Let's just reset current kprobe and exit.
> +                        *
> +                        * pre_handler can hit a breakpoint and can step thru
> +                        * before return.
> +                        */
> +                       if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +                               setup_singlestep(p, regs, kcb, 0);
> +                               return true;
> +                       } else {
> +                               reset_current_kprobe();
> +                               preempt_enable_no_resched();
> +                               return true;
> +                       }
> +               }
> +       }
> +
> +       if (addr->word != breakpoint_insn.word) {
> +               /* Handle the original "break" instruction. */
> +               if (is_break_ins(addr))
> +                       goto out;
> +
> +               /*
> +                * The breakpoint instruction was removed right
> +                * after we hit it.  Another cpu has removed
> +                * either a probepoint or a debugger breakpoint
> +                * at this address.  In either case, no further
> +                * handling of this interrupt is appropriate.
> +                * Return back to original instruction, and continue.
> +                */
> +               preempt_enable_no_resched();
> +               return true;
> +       }
> +
> +out:
> +       preempt_enable_no_resched();
> +       return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_breakpoint_handler);
> +
> +bool kprobe_singlestep_handler(struct pt_regs *regs)
> +{
> +       struct kprobe *cur = kprobe_running();
> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +       if (!cur)
> +               return false;
> +
> +       /* Restore back the original saved kprobes variables and continue */
> +       if (kcb->kprobe_status == KPROBE_REENTER) {
> +               restore_previous_kprobe(kcb);
> +               goto out;
> +       }
> +
> +       /* Call post handler */
> +       kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +       if (cur->post_handler)
> +               cur->post_handler(cur, regs, 0);
> +
> +       regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
> +       regs->csr_prmd |= kcb->kprobe_saved_irq;
> +
> +       reset_current_kprobe();
> +out:
> +       preempt_enable_no_resched();
You didn't disable preemption, why enable preemption here? I think you
should do similar things like kprobe_breakpoint_handler().

> +       return true;
> +}
> +NOKPROBE_SYMBOL(kprobe_singlestep_handler);
> +
> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> +{
> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +       if (kcb->kprobe_status & KPROBE_HIT_SS) {
> +               regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
> +               regs->csr_prmd |= kcb->kprobe_saved_irq;
> +
> +               reset_current_kprobe();
> +               preempt_enable_no_resched();
Here has the same problem as before, I doubt you haven't tested your
code (at least insufficient), and this is completely unacceptable for
me.

> +       }
> +
> +       return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_fault_handler);
> +
> +/*
> + * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
> + * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
> + */
> +int __init arch_populate_kprobe_blacklist(void)
> +{
> +       return kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
> +                                        (unsigned long)__irqentry_text_end);
> +}
> +
> +int __init arch_init_kprobes(void)
> +{
> +       return 0;
> +}
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index a19bb32..4d9f775 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -448,14 +448,12 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>          */
>         switch (bcode) {
>         case BRK_KPROBE_BP:
> -               if (notify_die(DIE_BREAK, "Kprobe", regs, bcode,
> -                              current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
> +               if (kprobe_breakpoint_handler(regs))
>                         goto out;
>                 else
>                         break;
>         case BRK_KPROBE_SSTEPBP:
> -               if (notify_die(DIE_SSTEPBP, "Kprobe_SingleStep", regs, bcode,
> -                              current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
> +               if (kprobe_singlestep_handler(regs))
>                         goto out;
>                 else
>                         break;
> @@ -479,6 +477,13 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>                         break;
>         }
>
> +       if (bcode == BRK_KPROBE_BP) {
> +               if (__get_inst(&opcode, (u32 *)era, user))
> +                       goto out_sigsegv;
> +
> +               bcode = (opcode & 0x7fff);
> +       }
> +
>         switch (bcode) {
>         case BRK_BUG:
>                 bug_handler(regs);
> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> index 1ccd536..fc9225a 100644
> --- a/arch/loongarch/mm/fault.c
> +++ b/arch/loongarch/mm/fault.c
> @@ -253,12 +253,16 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  {
>         irqentry_state_t state = irqentry_enter(regs);
>
> +       if (kprobe_page_fault(regs, current->thread.trap_nr))
> +               goto out;
> +
This should be after the conditional local_irq_enable(), I think.


Huacai
>         /* Enable interrupt if enabled in parent context */
>         if (likely(regs->csr_prmd & CSR_PRMD_PIE))
>                 local_irq_enable();
>
>         __do_page_fault(regs, write, address);
>
> +out:
>         local_irq_disable();
>
>         irqentry_exit(regs, state);
> --
> 2.1.0
>
