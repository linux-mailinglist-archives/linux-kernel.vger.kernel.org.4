Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0A637B25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKXONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKXONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:13:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB275B59F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BA22B82700
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6336CC433D7;
        Thu, 24 Nov 2022 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669299195;
        bh=sAjPZp8wv2HviezFUER0ekHxvyvzY9DUcvyHCLyzQOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GihYxup7A5uxxhIR1VktvfA03bkAVT2V5q2y9DP07TRU1j7eEodXhH9lwEsi/qJUy
         iVDaf813GrLOJvMNamYGr/D/TwkmBwP8tIZUYJCH4NipDbH0R/3gfdRQiKHyy7CliJ
         Q8BalgNkX0nOB6s42kIKWvmasHHAxbO9bPZJX4vsG1bjFDEy0Z+ZtIIZ7fhuW3lzEX
         MDt1k2V7EV+lvW2y0r3tf4dlQRfhGM8WK+gllUA3c1VnsyJh2qPYzcq7ywBstw2IZz
         rNZewF2XNz9yT9mYBrLRcJklTUIHie/irSpXJQy1k+8NC+R3C7DN9RiYCLLjqSDpvv
         vYXkeD1+hwz0w==
Date:   Thu, 24 Nov 2022 23:13:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Questions about kprobe handler
Message-Id: <20221124231312.88fa1a1010c461391c3262ed@kernel.org>
In-Reply-To: <7e4143dc-c444-e497-43bb-ac0ba18b6691@loongson.cn>
References: <9b6eb4db-83fe-e6d9-a580-1a11aace84b0@loongson.cn>
        <20221117220915.8b233ec82dc10a84753150b4@kernel.org>
        <7e4143dc-c444-e497-43bb-ac0ba18b6691@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 23:24:36 +0800
Jinyang He <hejinyang@loongson.cn> wrote:

> 在 2022/11/17 21:09, Masami Hiramatsu (Google) 写道:
> 
> > On Thu, 17 Nov 2022 09:07:37 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >> Hi KPROBES maintainers,
> >>
> >> There are some differences of kprobe handler implementations on various
> >> archs, the implementations are almost same on arm64, riscv, csky, the
> >> code logic is clear and understandable. But on mips and loongarch (not
> >> upstreamed yet), if get_kprobe() returns NULL, what is the purpose of
> >> the check "if (addr->word != breakpoint_insn.word)", is it necessary?
> >> Can we just return directly? Please take a look, thank you.
> > Good question!
> >
> > This means that when the software breakpoint was hit on that CPU, but
> > before calling kprobe handler function, the other CPU can remove that
> > kprobe from hash table, becahse the hash table is not locked.
> > In that case, the get_kprobe(addr) will return NULL, and the software
> > breakpoint instruction is already removed (replaced with the original
> > instruction). Thus it is safe to go back. But this is originally
> > implemented for x86, which doesn't need stop_machine() to modify the
> > code. On the other hand, if an architecture which needs stop_machine()
> > to modify code, the above scenario never happen. In that case, you
> > don't need this "if" case.
> >
> > Thank you,
> >
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n323
> >> 		p = get_kprobe(addr);
> >> 		if (p) {
> >> 			...
> >> 		} else if (addr->word != breakpoint_insn.word) {
> 
> Hi,
> 
> 
> Sorry for the late reply, but I think there should be some public
> comments so that I can get the authoritative response, as offline
> communication with Tiezhu is always one-sided.
> 
> I think the branch you answered here is " if (p)... " rather than
> "else if (addr->word != breakpoint_insn.word)". It is right if we
> not use stop_machine here we need this branch. In fact, Tiezhu
> and Huacai, the maintainer of LoongArch are more concerned
> about the latter why we need compare with the breakpoint_insn.
> 
> The reason I gave as follows, and I show mips code here,
> 
>      p = get_kprobe(addr);
>      if (!p) {
>          if (addr->word != breakpoint_insn.word) {
>              /*
>               * The breakpoint instruction was removed right
>               * after we hit it.  Another cpu has removed
>               * either a probepoint or a debugger breakpoint
>               * at this address.  In either case, no further
>               * handling of this interrupt is appropriate.
>               */
>              ret = 1;
>          }
>          /* Not one of ours: let kernel handle it */
>          goto no_kprobe;
>      }
> 
> ...
> int kprobe_exceptions_notify(struct notifier_block *self,
>                         unsigned long val, void *data)
> {
>      struct die_args *args = (struct die_args *)data;
>      int ret = NOTIFY_DONE;
> 
>      switch (val) {
>      case DIE_BREAK:
>          if (kprobe_handler(args->regs))
>              ret = NOTIFY_STOP;
>          break;
> ...
> 
> The !p means this insn has been moved, and then in most cases the COND
> "addr->word != breakpoint_insn.word" is true, we return 1 so that the return
> value in kprobe_exceptions_notify will be changed to NOTIFY_STOP.
> The mips use soft breakpoint like "break hint". How if the original insn
> is same as breakpoint_insn? That is a few case when COND is false. In that
> case, it means we should handle it by other handlers and doesn't change 
> ret to
> keep NOTIFY_DONE as kprobe_exceptions_notify return value.
> 
> Is this idea reasonable? Thanks!

Ah, in that case, yes, you should not return 1. Since the original code is
based on x86, which only has "int3" which is a unique instruction, it is
reasonable to check the breakpoint instruction. But it depends on the
architecture implementation.
BTW, even on x86, I think this case should not be checked by the kprobes.
It should be checked in the arch dependent software break handler code
right before detecting "stray software breakpoint", because this can happen
in other cases.

Thanks for reporting. The condition must be removed on MIPS.


> 
> 
> Jinyang
> 
> >> 			/*
> >> 			 * The breakpoint instruction was removed by
> >> 			 * another cpu right after we hit, no further
> >> 			 * handling of this interrupt is appropriate
> >> 			 */
> >> 			ret = 1;
> >> 		}
> >> https://github.com/loongson/linux/blob/loongarch-next-generic-stub/arch/loongarch/kernel/kprobes.c#L262
> >> 	p = get_kprobe(addr);
> >> 	if (p) {
> >> 		...
> >> 	} else {
> >> 		if (addr->word != breakpoint_insn.word) {
> >> 			/*
> >> 			 * The breakpoint instruction was removed right
> >> 			 * after we hit it.  Another cpu has removed
> >> 			 * either a probepoint or a debugger breakpoint
> >> 			 * at this address.  In either case, no further
> >> 			 * handling of this interrupt is appropriate.
> >> 			 */
> >> 			preempt_enable_no_resched();
> >> 			return 1;
> >> 		}
> >> 	}
> >>
> >> (1) arm64
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/probes/kprobes.c#n309
> >> static void __kprobes kprobe_handler(struct pt_regs *regs)
> >> {
> >> 	struct kprobe *p, *cur_kprobe;
> >> 	struct kprobe_ctlblk *kcb;
> >> 	unsigned long addr = instruction_pointer(regs);
> >>
> >> 	kcb = get_kprobe_ctlblk();
> >> 	cur_kprobe = kprobe_running();
> >>
> >> 	p = get_kprobe((kprobe_opcode_t *) addr);
> >>
> >> 	if (p) {
> >> 		if (cur_kprobe) {
> >> 			if (reenter_kprobe(p, regs, kcb))
> >> 				return;
> >> 		} else {
> >> 			/* Probe hit */
> >> 			set_current_kprobe(p);
> >> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >>
> >> 			/*
> >> 			 * If we have no pre-handler or it returned 0, we
> >> 			 * continue with normal processing.  If we have a
> >> 			 * pre-handler and it returned non-zero, it will
> >> 			 * modify the execution path and no need to single
> >> 			 * stepping. Let's just reset current kprobe and exit.
> >> 			 */
> >> 			if (!p->pre_handler || !p->pre_handler(p, regs)) {
> >> 				setup_singlestep(p, regs, kcb, 0);
> >> 			} else
> >> 				reset_current_kprobe();
> >> 		}
> >> 	}
> >> 	/*
> >> 	 * The breakpoint instruction was removed right
> >> 	 * after we hit it.  Another cpu has removed
> >> 	 * either a probepoint or a debugger breakpoint
> >> 	 * at this address.  In either case, no further
> >> 	 * handling of this interrupt is appropriate.
> >> 	 * Return back to original instruction, and continue.
> >> 	 */
> >> }
> >>
> >> (2) riscv
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/probes/kprobes.c#n269
> >> bool __kprobes
> >> kprobe_breakpoint_handler(struct pt_regs *regs)
> >> {
> >> 	struct kprobe *p, *cur_kprobe;
> >> 	struct kprobe_ctlblk *kcb;
> >> 	unsigned long addr = instruction_pointer(regs);
> >>
> >> 	kcb = get_kprobe_ctlblk();
> >> 	cur_kprobe = kprobe_running();
> >>
> >> 	p = get_kprobe((kprobe_opcode_t *) addr);
> >>
> >> 	if (p) {
> >> 		if (cur_kprobe) {
> >> 			if (reenter_kprobe(p, regs, kcb))
> >> 				return true;
> >> 		} else {
> >> 			/* Probe hit */
> >> 			set_current_kprobe(p);
> >> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >>
> >> 			/*
> >> 			 * If we have no pre-handler or it returned 0, we
> >> 			 * continue with normal processing.  If we have a
> >> 			 * pre-handler and it returned non-zero, it will
> >> 			 * modify the execution path and no need to single
> >> 			 * stepping. Let's just reset current kprobe and exit.
> >> 			 *
> >> 			 * pre_handler can hit a breakpoint and can step thru
> >> 			 * before return.
> >> 			 */
> >> 			if (!p->pre_handler || !p->pre_handler(p, regs))
> >> 				setup_singlestep(p, regs, kcb, 0);
> >> 			else
> >> 				reset_current_kprobe();
> >> 		}
> >> 		return true;
> >> 	}
> >>
> >> 	/*
> >> 	 * The breakpoint instruction was removed right
> >> 	 * after we hit it.  Another cpu has removed
> >> 	 * either a probepoint or a debugger breakpoint
> >> 	 * at this address.  In either case, no further
> >> 	 * handling of this interrupt is appropriate.
> >> 	 * Return back to original instruction, and continue.
> >> 	 */
> >> 	return false;
> >> }
> >>
> >> (3) csky
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/csky/kernel/probes/kprobes.c#n311
> >> int __kprobes
> >> kprobe_breakpoint_handler(struct pt_regs *regs)
> >> {
> >> 	struct kprobe *p, *cur_kprobe;
> >> 	struct kprobe_ctlblk *kcb;
> >> 	unsigned long addr = instruction_pointer(regs);
> >>
> >> 	kcb = get_kprobe_ctlblk();
> >> 	cur_kprobe = kprobe_running();
> >>
> >> 	p = get_kprobe((kprobe_opcode_t *) addr);
> >>
> >> 	if (p) {
> >> 		if (cur_kprobe) {
> >> 			if (reenter_kprobe(p, regs, kcb))
> >> 				return 1;
> >> 		} else {
> >> 			/* Probe hit */
> >> 			set_current_kprobe(p);
> >> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >>
> >> 			/*
> >> 			 * If we have no pre-handler or it returned 0, we
> >> 			 * continue with normal processing.  If we have a
> >> 			 * pre-handler and it returned non-zero, it will
> >> 			 * modify the execution path and no need to single
> >> 			 * stepping. Let's just reset current kprobe and exit.
> >> 			 *
> >> 			 * pre_handler can hit a breakpoint and can step thru
> >> 			 * before return.
> >> 			 */
> >> 			if (!p->pre_handler || !p->pre_handler(p, regs))
> >> 				setup_singlestep(p, regs, kcb, 0);
> >> 			else
> >> 				reset_current_kprobe();
> >> 		}
> >> 		return 1;
> >> 	}
> >>
> >> 	/*
> >> 	 * The breakpoint instruction was removed right
> >> 	 * after we hit it.  Another cpu has removed
> >> 	 * either a probepoint or a debugger breakpoint
> >> 	 * at this address.  In either case, no further
> >> 	 * handling of this interrupt is appropriate.
> >> 	 * Return back to original instruction, and continue.
> >> 	 */
> >> 	return 0;
> >> }
> >>
> >> (4) mips
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n279
> >> static int kprobe_handler(struct pt_regs *regs)
> >> {
> >> 	struct kprobe *p;
> >> 	int ret = 0;
> >> 	kprobe_opcode_t *addr;
> >> 	struct kprobe_ctlblk *kcb;
> >>
> >> 	addr = (kprobe_opcode_t *) regs->cp0_epc;
> >>
> >> 	/*
> >> 	 * We don't want to be preempted for the entire
> >> 	 * duration of kprobe processing
> >> 	 */
> >> 	preempt_disable();
> >> 	kcb = get_kprobe_ctlblk();
> >>
> >> 	/* Check we're not actually recursing */
> >> 	if (kprobe_running()) {
> >> 		p = get_kprobe(addr);
> >> 		if (p) {
> >> 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
> >> 			    p->ainsn.insn->word == breakpoint_insn.word) {
> >> 				regs->cp0_status &= ~ST0_IE;
> >> 				regs->cp0_status |= kcb->kprobe_saved_SR;
> >> 				goto no_kprobe;
> >> 			}
> >> 			/*
> >> 			 * We have reentered the kprobe_handler(), since
> >> 			 * another probe was hit while within the handler.
> >> 			 * We here save the original kprobes variables and
> >> 			 * just single step on the instruction of the new probe
> >> 			 * without calling any user handlers.
> >> 			 */
> >> 			save_previous_kprobe(kcb);
> >> 			set_current_kprobe(p, regs, kcb);
> >> 			kprobes_inc_nmissed_count(p);
> >> 			prepare_singlestep(p, regs, kcb);
> >> 			kcb->kprobe_status = KPROBE_REENTER;
> >> 			if (kcb->flags & SKIP_DELAYSLOT) {
> >> 				resume_execution(p, regs, kcb);
> >> 				restore_previous_kprobe(kcb);
> >> 				preempt_enable_no_resched();
> >> 			}
> >> 			return 1;
> >> 		} else if (addr->word != breakpoint_insn.word) {
> >> 			/*
> >> 			 * The breakpoint instruction was removed by
> >> 			 * another cpu right after we hit, no further
> >> 			 * handling of this interrupt is appropriate
> >> 			 */
> >> 			ret = 1;
> >> 		}
> >> 		goto no_kprobe;
> >> 	}
> >> ...
> >> }
> >>
> >> (5) loongarch
> >> https://github.com/loongson/linux/blob/loongarch-next-generic-stub/arch/loongarch/kernel/kprobes.c#L228
> >> static int __kprobes kprobe_handler(struct pt_regs *regs)
> >> {
> >> 	struct kprobe *p;
> >> 	kprobe_opcode_t *addr;
> >> 	struct kprobe_ctlblk *kcb;
> >>
> >> 	addr = (kprobe_opcode_t *) regs->csr_era;
> >>
> >> 	/*
> >> 	 * We don't want to be preempted for the entire
> >> 	 * duration of kprobe processing
> >> 	 */
> >> 	preempt_disable();
> >> 	kcb = get_kprobe_ctlblk();
> >>
> >> 	p = get_kprobe(addr);
> >> 	if (p) {
> >> 		if (kprobe_running()) {
> >> 			if (reenter_kprobe(p, regs, kcb))
> >> 				return 1;
> >> 		} else {
> >> 			set_current_kprobe(p, regs, kcb);
> >> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >> 			if (p->pre_handler && p->pre_handler(p, regs)) {
> >> 			/* handler has already set things up, so skip ss setup */
> >> 				reset_current_kprobe();
> >> 				preempt_enable_no_resched();
> >> 				return 1;
> >> 			} else {
> >> 				setup_singlestep(p, regs, kcb, 0);
> >> 				return 1;
> >> 			}
> >> 		}
> >> 	} else {
> >> 		if (addr->word != breakpoint_insn.word) {
> >> 			/*
> >> 			 * The breakpoint instruction was removed right
> >> 			 * after we hit it.  Another cpu has removed
> >> 			 * either a probepoint or a debugger breakpoint
> >> 			 * at this address.  In either case, no further
> >> 			 * handling of this interrupt is appropriate.
> >> 			 */
> >> 			preempt_enable_no_resched();
> >> 			return 1;
> >> 		}
> >> 	}
> >>
> >> 	preempt_enable_no_resched();
> >>
> >> 	return 0;
> >> }
> >>
> >> Thanks,
> >> Tiezhu
> >>
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
