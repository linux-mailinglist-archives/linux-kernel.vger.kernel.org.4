Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8F647F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiLIITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLIIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E011D311
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:18:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 899BDB827D4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AB5C433F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670573932;
        bh=MrfjWtM4+uwL5QOTyWWMxJWx4aHO227oylLgFH3r0so=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OleEGFPsXs/ufMeTJfSeq5M3SBqF2V3Lc5MoyR97UwBYd+25L0e3ujp7JV4Pj3HVY
         XJzOGQvITb8Fxq06+mRD35DfN9iZjcjSfQNauESpQ9GSq2FdzeV0pVFnx/l5QwDFNI
         8BRo3DeLGLHLfRL61uP30ASz3IGm0ogfeSEwYbxSuNtsHwqVXfXfCLBSjY/RniuUCL
         YBig4ch6om3LcBMPxT61kWy1z9ShtY9zNm075tkgOg5ccfi4182f1OMYinxkYk+4kE
         0FdVxJ7a4mC2BqwBchMPGlWcrF17TWA2xVFBm5/kcX81h0s5Rp1NuHoSa33nLuzcqD
         bFNKTvEBj8Plw==
Received: by mail-ej1-f52.google.com with SMTP id fc4so9688368ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 00:18:51 -0800 (PST)
X-Gm-Message-State: ANoB5pk0nUokQOJCLKEmxjw/yAOVV+lEY93/rOQicbhIIBXoKC1EFcWy
        q73knl4vLpWgWrjb5Tx1onIySY1K3/dC+s3em8E=
X-Google-Smtp-Source: AA0mqf7bqBIcCUgYVLUIpPtdbm9SSP4Nnr/dz4X2bcm4rLDTgIEOaV9IUDTmP2fX4mswjmLWD6RQwuiuiaaTVUN5XMc=
X-Received: by 2002:a17:906:cc8f:b0:78b:8ce7:fe3c with SMTP id
 oq15-20020a170906cc8f00b0078b8ce7fe3cmr79645257ejb.557.1670573929982; Fri, 09
 Dec 2022 00:18:49 -0800 (PST)
MIME-Version: 1.0
References: <1670506868-15771-1-git-send-email-yangtiezhu@loongson.cn>
 <1670506868-15771-3-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H54yruHAe7ey8L9hHPonryEWEd8nt-iS6s7-odrDdrutw@mail.gmail.com>
 <b1b4614c-7d7f-0773-dced-9182a510a80a@loongson.cn> <039cf92d-ec36-1d4c-e191-1d31a7d11bd3@loongson.cn>
 <4bc302bb-e064-f05c-ecc2-7e32ca910ab6@loongson.cn> <56241cbe-228b-9e7d-82c8-5578fa9ee3eb@loongson.cn>
In-Reply-To: <56241cbe-228b-9e7d-82c8-5578fa9ee3eb@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Dec 2022 16:18:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ncOAOfDaeHFnWbdb+M3nGEqfPfDs8BWaNH67rjNqABg@mail.gmail.com>
Message-ID: <CAAhV-H6ncOAOfDaeHFnWbdb+M3nGEqfPfDs8BWaNH67rjNqABg@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] LoongArch: Add kprobe support
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
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

On Fri, Dec 9, 2022 at 2:10 PM Youling Tang <tangyouling@loongson.cn> wrote:
>
>
>
> On 12/09/2022 01:53 PM, Jinyang He wrote:
> > On 2022-12-09 11:44, Youling Tang wrote:
> >
> >> Hi, Jinyang
> >>
> >> On 12/09/2022 11:31 AM, Jinyang He wrote:
> >>> On 2022-12-09 10:22, Huacai Chen wrote:
> >>>
> >>>>    cas
> >>>>
> >>>> On Thu, Dec 8, 2022 at 9:41 PM Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>> wrote:
> >>>>> Kprobes allows you to trap at almost any kernel address and
> >>>>> execute a callback function, this commit adds kprobe support
> >>>>> for LoongArch.
> >>>>>
> >>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>>> ---
> >>>>>   arch/loongarch/Kconfig               |   1 +
> >>>>>   arch/loongarch/include/asm/inst.h    |  15 ++
> >>>>>   arch/loongarch/include/asm/kprobes.h |  59 +++++++
> >>>>>   arch/loongarch/kernel/Makefile       |   2 +
> >>>>>   arch/loongarch/kernel/kprobes.c      | 332
> >>>>> +++++++++++++++++++++++++++++++++++
> >>>>>   arch/loongarch/kernel/traps.c        |  13 +-
> >>>>>   arch/loongarch/mm/fault.c            |   3 +
> >>>>>   7 files changed, 421 insertions(+), 4 deletions(-)
> >>>>>   create mode 100644 arch/loongarch/include/asm/kprobes.h
> >>>>>   create mode 100644 arch/loongarch/kernel/kprobes.c
> >>>>>
> >>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >>>>> index 16bf1b6..f6fc156 100644
> >>>>> --- a/arch/loongarch/Kconfig
> >>>>> +++ b/arch/loongarch/Kconfig
> >>>>> @@ -102,6 +102,7 @@ config LOONGARCH
> >>>>>          select HAVE_IOREMAP_PROT
> >>>>>          select HAVE_IRQ_EXIT_ON_IRQ_STACK
> >>>>>          select HAVE_IRQ_TIME_ACCOUNTING
> >>>>> +       select HAVE_KPROBES
> >>>>>          select HAVE_MOD_ARCH_SPECIFIC
> >>>>>          select HAVE_NMI
> >>>>>          select HAVE_PCI
> >>>>> diff --git a/arch/loongarch/include/asm/inst.h
> >>>>> b/arch/loongarch/include/asm/inst.h
> >>>>> index 19cf692..e3f2378 100644
> >>>>> --- a/arch/loongarch/include/asm/inst.h
> >>>>> +++ b/arch/loongarch/include/asm/inst.h
> >>>>> @@ -24,6 +24,10 @@
> >>>>>
> >>>>>   #define ADDR_IMM(addr, INSN)   ((addr & ADDR_IMMMASK_##INSN) >>
> >>>>> ADDR_IMMSHIFT_##INSN)
> >>>>>
> >>>>> +enum reg0i15_op {
> >>>>> +       break_op        = 0x54,
> >>>>> +};
> >>>>> +
> >>>>>   enum reg0i26_op {
> >>>>>          b_op            = 0x14,
> >>>>>          bl_op           = 0x15,
> >>>>> @@ -180,6 +184,11 @@ enum reg3sa2_op {
> >>>>>          alsld_op        = 0x16,
> >>>>>   };
> >>>>>
> >>>>> +struct reg0i15_format {
> >>>>> +       unsigned int immediate : 15;
> >>>>> +       unsigned int opcode : 17;
> >>>>> +};
> >>>>> +
> >>>>>   struct reg0i26_format {
> >>>>>          unsigned int immediate_h : 10;
> >>>>>          unsigned int immediate_l : 16;
> >>>>> @@ -265,6 +274,7 @@ struct reg3sa2_format {
> >>>>>
> >>>>>   union loongarch_instruction {
> >>>>>          unsigned int word;
> >>>>> +       struct reg0i15_format   reg0i15_format;
> >>>>>          struct reg0i26_format   reg0i26_format;
> >>>>>          struct reg1i20_format   reg1i20_format;
> >>>>>          struct reg1i21_format   reg1i21_format;
> >>>>> @@ -335,6 +345,11 @@ static inline bool is_branch_ins(union
> >>>>> loongarch_instruction *ip)
> >>>>>                  ip->reg1i21_format.opcode <= bgeu_op;
> >>>>>   }
> >>>>>
> >>>>> +static inline bool is_break_ins(union loongarch_instruction *ip)
> >>>>> +{
> >>>>> +       return ip->reg0i15_format.opcode == break_op;
> >>>>> +}
> >>>>> +
> >>>>>   static inline bool is_ra_save_ins(union loongarch_instruction *ip)
> >>>>>   {
> >>>>>          /* st.d $ra, $sp, offset */
> >>>>> diff --git a/arch/loongarch/include/asm/kprobes.h
> >>>>> b/arch/loongarch/include/asm/kprobes.h
> >>>>> new file mode 100644
> >>>>> index 0000000..d3903f3
> >>>>> --- /dev/null
> >>>>> +++ b/arch/loongarch/include/asm/kprobes.h
> >>>>> @@ -0,0 +1,59 @@
> >>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>>>> +#ifndef __ASM_LOONGARCH_KPROBES_H
> >>>>> +#define __ASM_LOONGARCH_KPROBES_H
> >>>>> +
> >>>>> +#include <asm-generic/kprobes.h>
> >>>>> +#include <asm/cacheflush.h>
> >>>>> +
> >>>>> +#ifdef CONFIG_KPROBES
> >>>>> +
> >>>>> +#include <asm/inst.h>
> >>>>> +
> >>>>> +#define __ARCH_WANT_KPROBES_INSN_SLOT
> >>>>> +#define MAX_INSN_SIZE                  2
> >>>>> +
> >>>>> +#define
> >>>>> flush_insn_slot(p)                                             \
> >>>>> +do
> >>>>> {                                                                   \
> >>>>> +       if
> >>>>> (p->addr)                                                    \
> >>>>> +               flush_icache_range((unsigned
> >>>>> long)p->addr,              \
> >>>>> +                          (unsigned long)p->addr
> >>>>> +                     \
> >>>>> +                          (MAX_INSN_SIZE *
> >>>>> sizeof(kprobe_opcode_t)));  \
> >>>>> +} while (0)
> >>>>> +
> >>>>> +#define kretprobe_blacklist_size       0
> >>>>> +
> >>>>> +typedef union loongarch_instruction kprobe_opcode_t;
> >>>>> +
> >>>>> +/* Architecture specific copy of original instruction */
> >>>>> +struct arch_specific_insn {
> >>>>> +       /* copy of the original instruction */
> >>>>> +       kprobe_opcode_t *insn;
> >>>>> +};
> >>>>> +
> >>>>> +struct prev_kprobe {
> >>>>> +       struct kprobe *kp;
> >>>>> +       unsigned long status;
> >>>>> +       unsigned long saved_irq;
> >>>>> +       unsigned long saved_era;
> >>>>> +};
> >>>>> +
> >>>>> +/* per-cpu kprobe control block */
> >>>>> +struct kprobe_ctlblk {
> >>>>> +       unsigned long kprobe_status;
> >>>>> +       unsigned long kprobe_saved_irq;
> >>>>> +       unsigned long kprobe_saved_era;
> >>>>> +       struct prev_kprobe prev_kprobe;
> >>>>> +};
> >>>>> +
> >>>>> +void arch_remove_kprobe(struct kprobe *p);
> >>>>> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> >>>>> +bool kprobe_breakpoint_handler(struct pt_regs *regs);
> >>>>> +bool kprobe_singlestep_handler(struct pt_regs *regs);
> >>>>> +
> >>>>> +#else /* !CONFIG_KPROBES */
> >>>>> +
> >>>>> +static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) {
> >>>>> return 0; }
> >>>>> +static inline bool kprobe_singlestep_handler(struct pt_regs *regs) {
> >>>>> return 0; }
> >>>>> +
> >>>>> +#endif /* CONFIG_KPROBES */
> >>>>> +#endif /* __ASM_LOONGARCH_KPROBES_H */
> >>>>> diff --git a/arch/loongarch/kernel/Makefile
> >>>>> b/arch/loongarch/kernel/Makefile
> >>>>> index fcaa024..6fe4a4e 100644
> >>>>> --- a/arch/loongarch/kernel/Makefile
> >>>>> +++ b/arch/loongarch/kernel/Makefile
> >>>>> @@ -47,4 +47,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
> >>>>>
> >>>>>   obj-$(CONFIG_PERF_EVENTS)      += perf_event.o perf_regs.o
> >>>>>
> >>>>> +obj-$(CONFIG_KPROBES)          += kprobes.o
> >>>>> +
> >>>>>   CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
> >>>>> diff --git a/arch/loongarch/kernel/kprobes.c
> >>>>> b/arch/loongarch/kernel/kprobes.c
> >>>>> new file mode 100644
> >>>>> index 0000000..aadfc9ae
> >>>>> --- /dev/null
> >>>>> +++ b/arch/loongarch/kernel/kprobes.c
> >>>>> @@ -0,0 +1,332 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>> +#include <linux/kprobes.h>
> >>>>> +#include <linux/kdebug.h>
> >>>>> +#include <linux/preempt.h>
> >>>>> +#include <asm/break.h>
> >>>>> +
> >>>>> +static const union loongarch_instruction breakpoint_insn = {
> >>>>> +       .reg0i15_format = {
> >>>>> +               .opcode = break_op,
> >>>>> +               .immediate = BRK_KPROBE_BP,
> >>>>> +       }
> >>>>> +};
> >>>>> +
> >>>>> +static const union loongarch_instruction singlestep_insn = {
> >>>>> +       .reg0i15_format = {
> >>>>> +               .opcode = break_op,
> >>>>> +               .immediate = BRK_KPROBE_SSTEPBP,
> >>>>> +       }
> >>>>> +};
> >>>>> +
> >>>>> +DEFINE_PER_CPU(struct kprobe *, current_kprobe);
> >>>>> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> >>>>> +
> >>>>> +static bool insns_are_not_supported(union loongarch_instruction insn)
> >>>> Use  insns_not_supported for short.
> >>>>
> >>>>> +{
> >>>>> +       switch (insn.reg2i14_format.opcode) {
> >>>>> +       case llw_op:
> >>>>> +       case lld_op:
> >>>>> +       case scw_op:
> >>>>> +       case scd_op:
> >>>>> +               pr_notice("kprobe: ll and sc instructions are not
> >>>>> supported\n");
> >>>>> +               return true;
> >>>>> +       }
> >>>>> +
> >>>>> +       switch (insn.reg1i21_format.opcode) {
> >>>>> +       case bceqz_op:
> >>>>> +               pr_notice("kprobe: bceqz and bcnez instructions are
> >>>>> not supported\n");
> >>>>> +               return true;
> >>>>> +       }
> >>>>> +
> >>>>> +       return false;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(insns_are_not_supported);
> >>>>> +
> >>>>> +int arch_prepare_kprobe(struct kprobe *p)
> >>>>> +{
> >>>>> +       union loongarch_instruction insn;
> >>>>> +
> >>>>> +       insn = p->addr[0];
> >>>>> +       if (insns_are_not_supported(insn))
> >>>>> +               return -EINVAL;
> >>>>> +
> >>>>> +       p->ainsn.insn = get_insn_slot();
> >>>>> +       if (!p->ainsn.insn)
> >>>>> +               return -ENOMEM;
> >>>>> +
> >>>>> +       p->ainsn.insn[0] = *p->addr;
> >>>>> +       p->ainsn.insn[1] = singlestep_insn;
> >>>>> +
> >>>>> +       p->opcode = *p->addr;
> >>>>> +
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(arch_prepare_kprobe);
> >>>>> +
> >>>>> +/* Install breakpoint in text */
> >>>>> +void arch_arm_kprobe(struct kprobe *p)
> >>>>> +{
> >>>>> +       *p->addr = breakpoint_insn;
> >>>>> +       flush_insn_slot(p);
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(arch_arm_kprobe);
> >>>>> +
> >>>>> +/* Remove breakpoint from text */
> >>>>> +void arch_disarm_kprobe(struct kprobe *p)
> >>>>> +{
> >>>>> +       *p->addr = p->opcode;
> >>>>> +       flush_insn_slot(p);
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(arch_disarm_kprobe);
> >>>>> +
> >>>>> +void arch_remove_kprobe(struct kprobe *p)
> >>>>> +{
> >>>>> +       if (p->ainsn.insn) {
> >>>>> +               free_insn_slot(p->ainsn.insn, 0);
> >>>>> +               p->ainsn.insn = NULL;
> >>>>> +       }
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(arch_remove_kprobe);
> >>>>> +
> >>>>> +static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
> >>>>> +{
> >>>>> +       kcb->prev_kprobe.kp = kprobe_running();
> >>>>> +       kcb->prev_kprobe.status = kcb->kprobe_status;
> >>>>> +       kcb->prev_kprobe.saved_irq = kcb->kprobe_saved_irq;
> >>>>> +       kcb->prev_kprobe.saved_era = kcb->kprobe_saved_era;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(save_previous_kprobe);
> >>>>> +
> >>>>> +static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
> >>>>> +{
> >>>>> +       __this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
> >>>>> +       kcb->kprobe_status = kcb->prev_kprobe.status;
> >>>>> +       kcb->kprobe_saved_irq = kcb->prev_kprobe.saved_irq;
> >>>>> +       kcb->kprobe_saved_era = kcb->prev_kprobe.saved_era;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(restore_previous_kprobe);
> >>>>> +
> >>>>> +static void set_current_kprobe(struct kprobe *p, struct pt_regs
> >>>>> *regs,
> >>>>> +                              struct kprobe_ctlblk *kcb)
> >>>>> +{
> >>>>> +       __this_cpu_write(current_kprobe, p);
> >>>>> +       kcb->kprobe_saved_irq = regs->csr_prmd & CSR_PRMD_PIE;
> >>>>> +       kcb->kprobe_saved_era = regs->csr_era;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(set_current_kprobe);
> >>>>> +
> >>>>> +static bool insns_are_not_simulated(struct kprobe *p, struct pt_regs
> >>>>> *regs)
> >>>> Use  insns_not_simulated for short.
> >>>>> +{
> >>>>> +       if (is_branch_ins(&p->opcode)) {
> >>>>> +               simu_branch(regs, p->opcode);
> >>>>> +               return false;
> >>>>> +       } else if (is_pc_ins(&p->opcode)) {
> >>>>> +               simu_pc(regs, p->opcode);
> >>>>> +               return false;
> >>>>> +       } else {
> >>>>> +               return true;
> >>>>> +       }
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(insns_are_not_simulated);
> >>>>> +
> >>>>> +static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> >>>>> +                            struct kprobe_ctlblk *kcb, int reenter)
> >>>>> +{
> >>>>> +       if (reenter) {
> >>>>> +               save_previous_kprobe(kcb);
> >>>>> +               set_current_kprobe(p, regs, kcb);
> >>>>> +               kcb->kprobe_status = KPROBE_REENTER;
> >>>>> +       } else {
> >>>>> +               kcb->kprobe_status = KPROBE_HIT_SS;
> >>>>> +       }
> >>>>> +
> >>>>> +       regs->csr_prmd &= ~CSR_PRMD_PIE;
> >>>>> +
> >>>>> +       if (p->ainsn.insn->word == breakpoint_insn.word) {
> >>>>> +               regs->csr_prmd |= kcb->kprobe_saved_irq;
> >>>>> +               preempt_enable_no_resched();
> >>>>> +               return;
> >>>>> +       }
> >>>>> +
> >>>>> +       if (insns_are_not_simulated(p, regs)) {
> >>>>> +               kcb->kprobe_status = KPROBE_HIT_SS;
> >>>>> +               regs->csr_era = (unsigned long)&p->ainsn.insn[0];
> >>>>> +       } else {
> >>>>> +               kcb->kprobe_status = KPROBE_HIT_SSDONE;
> >>>>> +               if (p->post_handler)
> >>>>> +                       p->post_handler(p, regs, 0);
> >>>>> +               reset_current_kprobe();
> >>>>> +               preempt_enable_no_resched();
> >>>>> +       }
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(setup_singlestep);
> >>>>> +
> >>>>> +static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
> >>>>> +                         struct kprobe_ctlblk *kcb)
> >>>>> +{
> >>>>> +       switch (kcb->kprobe_status) {
> >>>>> +       case KPROBE_HIT_SSDONE:
> >>>>> +       case KPROBE_HIT_ACTIVE:
> >>>>> +               kprobes_inc_nmissed_count(p);
> >>>>> +               setup_singlestep(p, regs, kcb, 1);
> >>>>> +               break;
> >>>>> +       case KPROBE_HIT_SS:
> >>>>> +       case KPROBE_REENTER:
> >>>>> +               pr_warn("Failed to recover from reentered
> >>>>> kprobes.\n");
> >>>>> +               dump_kprobe(p);
> >>>>> +               BUG();
> >>>>> +               break;
> >>>>> +       default:
> >>>>> +               WARN_ON(1);
> >>>>> +               return false;
> >>>>> +       }
> >>>>> +
> >>>>> +       return true;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(reenter_kprobe);
> >>>>> +
> >>>>> +bool kprobe_breakpoint_handler(struct pt_regs *regs)
> >>>>> +{
> >>>>> +       struct kprobe_ctlblk *kcb;
> >>>>> +       struct kprobe *p, *cur_kprobe;
> >>>>> +       kprobe_opcode_t *addr = (kprobe_opcode_t *)regs->csr_era;
> >>>>> +
> >>>>> +       /*
> >>>>> +        * We don't want to be preempted for the entire
> >>>>> +        * duration of kprobe processing.
> >>>>> +        */
> >>>>> +       preempt_disable();
> >>>>> +       kcb = get_kprobe_ctlblk();
> >>>>> +       cur_kprobe = kprobe_running();
> >>>>> +
> >>>>> +       p = get_kprobe(addr);
> >>>>> +       if (p) {
> >>>>> +               if (cur_kprobe) {
> >>>>> +                       if (reenter_kprobe(p, regs, kcb))
> >>>>> +                               return true;
> >>>>> +               } else {
> >>>>> +                       /* Probe hit */
> >>>>> +                       set_current_kprobe(p, regs, kcb);
> >>>>> +                       kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >>>>> +
> >>>>> +                       /*
> >>>>> +                        * If we have no pre-handler or it returned
> >>>>> 0, we
> >>>>> +                        * continue with normal processing. If we
> >>>>> have a
> >>>>> +                        * pre-handler and it returned non-zero, it
> >>>>> will
> >>>>> +                        * modify the execution path and no need to
> >>>>> single
> >>>>> +                        * stepping. Let's just reset current kprobe
> >>>>> and exit.
> >>>>> +                        *
> >>>>> +                        * pre_handler can hit a breakpoint and can
> >>>>> step thru
> >>>>> +                        * before return.
> >>>>> +                        */
> >>>>> +                       if (!p->pre_handler || !p->pre_handler(p,
> >>>>> regs)) {
> >>>>> +                               setup_singlestep(p, regs, kcb, 0);
> >>>>> +                       } else {
> >>>>> +                               reset_current_kprobe();
> >>>>> +                               preempt_enable_no_resched();
> >>>>> +                       }
> >>>>> +               }
> >>>>> +               return true;
> >>>>> +       }
> >>>>> +
> >>>>> +       if (!is_break_ins(addr)) {
> >>>>> +               /*
> >>>>> +                * The breakpoint instruction was removed right
> >>>>> +                * after we hit it.  Another cpu has removed
> >>>>> +                * either a probepoint or a debugger breakpoint
> >>>>> +                * at this address.  In either case, no further
> >>>>> +                * handling of this interrupt is appropriate.
> >>>>> +                * Return back to original instruction, and continue.
> >>>>> +                */
> >>>>> +               preempt_enable_no_resched();
> >>>>> +               return true;
> >>>>> +       }
> >>>>> +
> >>>>> +       preempt_enable_no_resched();
> >>>>> +       return false;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(kprobe_breakpoint_handler);
> >>>>> +
> >>>>> +bool kprobe_singlestep_handler(struct pt_regs *regs)
> >>>>> +{
> >>>>> +       struct kprobe *cur = kprobe_running();
> >>>>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >>>>> +
> >>>>> +       if (!cur)
> >>>>> +               return false;
> >>>>> +
> >>>>> +       /* Restore back the original saved kprobes variables and
> >>>>> continue */
> >>>>> +       if (kcb->kprobe_status == KPROBE_REENTER) {
> >>>>> +               restore_previous_kprobe(kcb);
> >>>>> +               goto out;
> >>>>> +       }
> >>>>> +
> >>>>> +       /* Call post handler */
> >>>>> +       kcb->kprobe_status = KPROBE_HIT_SSDONE;
> >>>>> +       if (cur->post_handler)
> >>>>> +               cur->post_handler(cur, regs, 0);
> >>>> I'm not very familiar, but I think you should set KPROBE_HIT_SSDONE
> >>>> only when post_handler is not NULL.
> >>>>
> >>>>> +
> >>>>> +       regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
> >>>>> +       regs->csr_prmd |= kcb->kprobe_saved_irq;
> >>>>> +
> >>>>> +       reset_current_kprobe();
> >>>>> +out:
> >>>>> +       preempt_enable_no_resched();
> >>>>> +       return true;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(kprobe_singlestep_handler);
> >>>>> +
> >>>>> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> >>>>> +{
> >>>>> +       struct kprobe *cur = kprobe_running();
> >>>>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >>>>> +
> >>>>> +       switch (kcb->kprobe_status) {
> >>>>> +       case KPROBE_HIT_SS:
> >>>>> +       case KPROBE_REENTER:
> >>>>> +               /*
> >>>>> +                * We are here because the instruction being single
> >>>>> +                * stepped caused a page fault. We reset the current
> >>>>> +                * kprobe and the ip points back to the probe address
> >>>>> +                * and allow the page fault handler to continue as a
> >>>>> +                * normal page fault.
> >>>>> +                */
> >>>>> +               regs->csr_era = (unsigned long) cur->addr;
> >>>>> +               BUG_ON(!instruction_pointer(regs));
> >>>>> +
> >>>>> +               if (kcb->kprobe_status == KPROBE_REENTER) {
> >>>>> +                       restore_previous_kprobe(kcb);
> >>>>> +               } else {
> >>>>> +                       regs->csr_prmd |= kcb->kprobe_saved_irq;
> >>>>> +                       reset_current_kprobe();
> >>>>> +                       preempt_enable_no_resched();
> >>>>> +               }
> >>>> I think the KPROBE_REENTER case also needs to enable preemption.
> >>>>
> >>>>> +
> >>>>> +               break;
> >>>>> +       case KPROBE_HIT_ACTIVE:
> >>>>> +       case KPROBE_HIT_SSDONE:
> >>>>> +               /*
> >>>>> +                * In case the user-specified fault handler returned
> >>>>> +                * zero, try to fix up.
> >>>>> +                */
> >>>>> +               if (fixup_exception(regs))
> >>>>> +                       return true;
> >>>> Does here need to enable preemption too?
> >>>>
> >>>>> +       }
> >>>>> +       return false;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(kprobe_fault_handler);
> >>>>> +
> >>>>> +/*
> >>>>> + * Provide a blacklist of symbols identifying ranges which cannot be
> >>>>> kprobed.
> >>>>> + * This blacklist is exposed to userspace via debugfs
> >>>>> (kprobes/blacklist).
> >>>>> + */
> >>>>> +int __init arch_populate_kprobe_blacklist(void)
> >>>>> +{
> >>>>> +       return kprobe_add_area_blacklist((unsigned
> >>>>> long)__irqentry_text_start,
> >>>>> +                                        (unsigned
> >>>>> long)__irqentry_text_end);
> >>>>> +}
> >>>>> +
> >>>>> +int __init arch_init_kprobes(void)
> >>>>> +{
> >>>>> +       return 0;
> >>>>> +}
> >>>>> diff --git a/arch/loongarch/kernel/traps.c
> >>>>> b/arch/loongarch/kernel/traps.c
> >>>>> index a19bb32..4d9f775 100644
> >>>>> --- a/arch/loongarch/kernel/traps.c
> >>>>> +++ b/arch/loongarch/kernel/traps.c
> >>>>> @@ -448,14 +448,12 @@ asmlinkage void noinstr do_bp(struct pt_regs
> >>>>> *regs)
> >>>>>           */
> >>>>>          switch (bcode) {
> >>>>>          case BRK_KPROBE_BP:
> >>>>> -               if (notify_die(DIE_BREAK, "Kprobe", regs, bcode,
> >>>>> -                              current->thread.trap_nr, SIGTRAP) ==
> >>>>> NOTIFY_STOP)
> >>>>> +               if (kprobe_breakpoint_handler(regs))
> >>>>>                          goto out;
> >>>>>                  else
> >>>>>                          break;
> >>>>>          case BRK_KPROBE_SSTEPBP:
> >>>>> -               if (notify_die(DIE_SSTEPBP, "Kprobe_SingleStep",
> >>>>> regs, bcode,
> >>>>> -                              current->thread.trap_nr, SIGTRAP) ==
> >>>>> NOTIFY_STOP)
> >>>>> +               if (kprobe_singlestep_handler(regs))
> >>>>>                          goto out;
> >>>>>                  else
> >>>>>                          break;
> >>>>> @@ -479,6 +477,13 @@ asmlinkage void noinstr do_bp(struct pt_regs
> >>>>> *regs)
> >>>>>                          break;
> >>>>>          }
> >>>>>
> >>>>> +       if (bcode == BRK_KPROBE_BP) {
> >>>>> +               if (__get_inst(&opcode, (u32 *)era, user))
> >>>>> +                       goto out_sigsegv;
> >>>>> +
> >>>>> +               bcode = (opcode & 0x7fff);
> >>>>> +       }
> >>>>> +
> >>>> Why? we already got bcode at the beginning.
> >>>
> >>> Hi, Huacai,
> >>>
> >>>
> >>> I think it is because kprobe_breakpoint_handler() may deal with that
> >>> case other cpu may remove its breakpoint. In that case, normally we can
> >>> exit this break exception and go on. But if
> >>> the orignal instruction is_break_ins(), we will trigger trap aggain. So
> >>> it is better to avoid double traps and let it go ahead when
> >>> kprobe_breakpoint_handler() returns.
> >> Perhaps it is not described here as avoiding the trap twice,
> >
> > That due to the implementation in the last branch, is_break_ins(), in
> > kprobe_breakpoint_handler(). We can indirectly return true for all
> > instructions to indicate we can stop kprobe now.
> > And then it returns the normal code flow. If the instruction at ERA is a
> > "break xxx", it would traps again. I call it as "trap twice" because at
> > here we are in the fisrt time trap.
> Mmm, it can be understood that way.
I think we should construct a test program to prove it is actually
necessary to get bcode again.

Huacai
>
> Thanks.
> > To avoid the second trap, we add the judgment named is_break_ins() and
> > return false to indicate we should go another break handler. Of course,
> > with the instruction being restored, we should re-get the bcode.
> >
> >
> >> but rather
> >> that if we don't re-fetch the bcode when the original instruction
> >> `break` will go to the default branch regardless of what the bcode of
> >> the original instruction is (since the bcode is BRK_KPROBE_BP at this
> >> point). IMHO, so we re-get the bcode to get the original instruction
> >> `break` is the correct bcode to ensure that it goes to the appropriate
> >> case branch.
> >>
> >> Thanks,
> >> Youling.
> >>
> >>> Differnt from many other archs, e.g. riscv, we switch bcode to decide
> >>> which handlers should go on. Thus, we need get bcode again.
> >>>
> >>> Thanks,
> >>>
> >>> Jinyang
> >>>
> >>>
> >>>>>          switch (bcode) {
> >>>>>          case BRK_BUG:
> >>>>>                  bug_handler(regs);
> >>>>> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> >>>>> index 1ccd536..449087b 100644
> >>>>> --- a/arch/loongarch/mm/fault.c
> >>>>> +++ b/arch/loongarch/mm/fault.c
> >>>>> @@ -135,6 +135,9 @@ static void __kprobes __do_page_fault(struct
> >>>>> pt_regs *regs,
> >>>>>          struct vm_area_struct *vma = NULL;
> >>>>>          vm_fault_t fault;
> >>>>>
> >>>>> +       if (kprobe_page_fault(regs, current->thread.trap_nr))
> >>>>> +               return;
> >>>>> +
> >>>>>          /*
> >>>>>           * We fault-in kernel-space virtual memory on-demand. The
> >>>>>           * 'reference' page table is init_mm.pgd.
> >>>>> --
> >>>>> 2.1.0
> >>>>>
> >>>>>
> >>>
> >
>
