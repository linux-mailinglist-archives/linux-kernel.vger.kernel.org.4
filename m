Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597E562DC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiKQNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKQNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:09:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D246F60682
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:09:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90AC1B8204A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D1EC433D6;
        Thu, 17 Nov 2022 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668690558;
        bh=fy8vxwuGs3/MO7CNWSuFSWSgxyBXvxwXHXo0mlpzkmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MQpRK4d+u9RMRW9Ho9uedpWdQmczARp+A0pxI7xh+j4bWwqhGAZ2iFkkUIxMryCtR
         AVPXULCmQk3INVrQgnxp4nfvCw839OLhRq5s6XFJhQMvgUjQS/y6LoOsvFB2fWPuGJ
         gK96/c1xZ01ASEyF2UNH34Hz1aUVk0wzPZn5hITesMvuwz6C1uNXD5/1swsND64wyX
         /1ZiUF4FXvQLPNmKnUx1oAEgwfVRBAA+vzLrJKgWnwit0BH4cakN/7aIzvU5dsAS6U
         Zox7XfaPsw+4z/+PZDw7M9djANLBJG12zI4JbHhvcR541yiI+bVAvefH4PtY5VDxm3
         DyMzmM674SOfw==
Date:   Thu, 17 Nov 2022 22:09:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Questions about kprobe handler
Message-Id: <20221117220915.8b233ec82dc10a84753150b4@kernel.org>
In-Reply-To: <9b6eb4db-83fe-e6d9-a580-1a11aace84b0@loongson.cn>
References: <9b6eb4db-83fe-e6d9-a580-1a11aace84b0@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 09:07:37 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Hi KPROBES maintainers,
> 
> There are some differences of kprobe handler implementations on various
> archs, the implementations are almost same on arm64, riscv, csky, the
> code logic is clear and understandable. But on mips and loongarch (not
> upstreamed yet), if get_kprobe() returns NULL, what is the purpose of
> the check "if (addr->word != breakpoint_insn.word)", is it necessary?
> Can we just return directly? Please take a look, thank you.

Good question!

This means that when the software breakpoint was hit on that CPU, but
before calling kprobe handler function, the other CPU can remove that
kprobe from hash table, becahse the hash table is not locked.
In that case, the get_kprobe(addr) will return NULL, and the software
breakpoint instruction is already removed (replaced with the original
instruction). Thus it is safe to go back. But this is originally
implemented for x86, which doesn't need stop_machine() to modify the
code. On the other hand, if an architecture which needs stop_machine()
to modify code, the above scenario never happen. In that case, you
don't need this "if" case.

Thank you,

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n323
> 		p = get_kprobe(addr);
> 		if (p) {
> 			...
> 		} else if (addr->word != breakpoint_insn.word) {
> 			/*
> 			 * The breakpoint instruction was removed by
> 			 * another cpu right after we hit, no further
> 			 * handling of this interrupt is appropriate
> 			 */
> 			ret = 1;
> 		}
> https://github.com/loongson/linux/blob/loongarch-next-generic-stub/arch/loongarch/kernel/kprobes.c#L262
> 	p = get_kprobe(addr);
> 	if (p) {
> 		...
> 	} else {
> 		if (addr->word != breakpoint_insn.word) {
> 			/*
> 			 * The breakpoint instruction was removed right
> 			 * after we hit it.  Another cpu has removed
> 			 * either a probepoint or a debugger breakpoint
> 			 * at this address.  In either case, no further
> 			 * handling of this interrupt is appropriate.
> 			 */
> 			preempt_enable_no_resched();
> 			return 1;
> 		}
> 	}
> 
> (1) arm64
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/probes/kprobes.c#n309
> static void __kprobes kprobe_handler(struct pt_regs *regs)
> {
> 	struct kprobe *p, *cur_kprobe;
> 	struct kprobe_ctlblk *kcb;
> 	unsigned long addr = instruction_pointer(regs);
> 
> 	kcb = get_kprobe_ctlblk();
> 	cur_kprobe = kprobe_running();
> 
> 	p = get_kprobe((kprobe_opcode_t *) addr);
> 
> 	if (p) {
> 		if (cur_kprobe) {
> 			if (reenter_kprobe(p, regs, kcb))
> 				return;
> 		} else {
> 			/* Probe hit */
> 			set_current_kprobe(p);
> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 
> 			/*
> 			 * If we have no pre-handler or it returned 0, we
> 			 * continue with normal processing.  If we have a
> 			 * pre-handler and it returned non-zero, it will
> 			 * modify the execution path and no need to single
> 			 * stepping. Let's just reset current kprobe and exit.
> 			 */
> 			if (!p->pre_handler || !p->pre_handler(p, regs)) {
> 				setup_singlestep(p, regs, kcb, 0);
> 			} else
> 				reset_current_kprobe();
> 		}
> 	}
> 	/*
> 	 * The breakpoint instruction was removed right
> 	 * after we hit it.  Another cpu has removed
> 	 * either a probepoint or a debugger breakpoint
> 	 * at this address.  In either case, no further
> 	 * handling of this interrupt is appropriate.
> 	 * Return back to original instruction, and continue.
> 	 */
> }
> 
> (2) riscv
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/probes/kprobes.c#n269
> bool __kprobes
> kprobe_breakpoint_handler(struct pt_regs *regs)
> {
> 	struct kprobe *p, *cur_kprobe;
> 	struct kprobe_ctlblk *kcb;
> 	unsigned long addr = instruction_pointer(regs);
> 
> 	kcb = get_kprobe_ctlblk();
> 	cur_kprobe = kprobe_running();
> 
> 	p = get_kprobe((kprobe_opcode_t *) addr);
> 
> 	if (p) {
> 		if (cur_kprobe) {
> 			if (reenter_kprobe(p, regs, kcb))
> 				return true;
> 		} else {
> 			/* Probe hit */
> 			set_current_kprobe(p);
> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 
> 			/*
> 			 * If we have no pre-handler or it returned 0, we
> 			 * continue with normal processing.  If we have a
> 			 * pre-handler and it returned non-zero, it will
> 			 * modify the execution path and no need to single
> 			 * stepping. Let's just reset current kprobe and exit.
> 			 *
> 			 * pre_handler can hit a breakpoint and can step thru
> 			 * before return.
> 			 */
> 			if (!p->pre_handler || !p->pre_handler(p, regs))
> 				setup_singlestep(p, regs, kcb, 0);
> 			else
> 				reset_current_kprobe();
> 		}
> 		return true;
> 	}
> 
> 	/*
> 	 * The breakpoint instruction was removed right
> 	 * after we hit it.  Another cpu has removed
> 	 * either a probepoint or a debugger breakpoint
> 	 * at this address.  In either case, no further
> 	 * handling of this interrupt is appropriate.
> 	 * Return back to original instruction, and continue.
> 	 */
> 	return false;
> }
> 
> (3) csky
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/csky/kernel/probes/kprobes.c#n311
> int __kprobes
> kprobe_breakpoint_handler(struct pt_regs *regs)
> {
> 	struct kprobe *p, *cur_kprobe;
> 	struct kprobe_ctlblk *kcb;
> 	unsigned long addr = instruction_pointer(regs);
> 
> 	kcb = get_kprobe_ctlblk();
> 	cur_kprobe = kprobe_running();
> 
> 	p = get_kprobe((kprobe_opcode_t *) addr);
> 
> 	if (p) {
> 		if (cur_kprobe) {
> 			if (reenter_kprobe(p, regs, kcb))
> 				return 1;
> 		} else {
> 			/* Probe hit */
> 			set_current_kprobe(p);
> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 
> 			/*
> 			 * If we have no pre-handler or it returned 0, we
> 			 * continue with normal processing.  If we have a
> 			 * pre-handler and it returned non-zero, it will
> 			 * modify the execution path and no need to single
> 			 * stepping. Let's just reset current kprobe and exit.
> 			 *
> 			 * pre_handler can hit a breakpoint and can step thru
> 			 * before return.
> 			 */
> 			if (!p->pre_handler || !p->pre_handler(p, regs))
> 				setup_singlestep(p, regs, kcb, 0);
> 			else
> 				reset_current_kprobe();
> 		}
> 		return 1;
> 	}
> 
> 	/*
> 	 * The breakpoint instruction was removed right
> 	 * after we hit it.  Another cpu has removed
> 	 * either a probepoint or a debugger breakpoint
> 	 * at this address.  In either case, no further
> 	 * handling of this interrupt is appropriate.
> 	 * Return back to original instruction, and continue.
> 	 */
> 	return 0;
> }
> 
> (4) mips
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n279
> static int kprobe_handler(struct pt_regs *regs)
> {
> 	struct kprobe *p;
> 	int ret = 0;
> 	kprobe_opcode_t *addr;
> 	struct kprobe_ctlblk *kcb;
> 
> 	addr = (kprobe_opcode_t *) regs->cp0_epc;
> 
> 	/*
> 	 * We don't want to be preempted for the entire
> 	 * duration of kprobe processing
> 	 */
> 	preempt_disable();
> 	kcb = get_kprobe_ctlblk();
> 
> 	/* Check we're not actually recursing */
> 	if (kprobe_running()) {
> 		p = get_kprobe(addr);
> 		if (p) {
> 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
> 			    p->ainsn.insn->word == breakpoint_insn.word) {
> 				regs->cp0_status &= ~ST0_IE;
> 				regs->cp0_status |= kcb->kprobe_saved_SR;
> 				goto no_kprobe;
> 			}
> 			/*
> 			 * We have reentered the kprobe_handler(), since
> 			 * another probe was hit while within the handler.
> 			 * We here save the original kprobes variables and
> 			 * just single step on the instruction of the new probe
> 			 * without calling any user handlers.
> 			 */
> 			save_previous_kprobe(kcb);
> 			set_current_kprobe(p, regs, kcb);
> 			kprobes_inc_nmissed_count(p);
> 			prepare_singlestep(p, regs, kcb);
> 			kcb->kprobe_status = KPROBE_REENTER;
> 			if (kcb->flags & SKIP_DELAYSLOT) {
> 				resume_execution(p, regs, kcb);
> 				restore_previous_kprobe(kcb);
> 				preempt_enable_no_resched();
> 			}
> 			return 1;
> 		} else if (addr->word != breakpoint_insn.word) {
> 			/*
> 			 * The breakpoint instruction was removed by
> 			 * another cpu right after we hit, no further
> 			 * handling of this interrupt is appropriate
> 			 */
> 			ret = 1;
> 		}
> 		goto no_kprobe;
> 	}
> ...
> }
> 
> (5) loongarch
> https://github.com/loongson/linux/blob/loongarch-next-generic-stub/arch/loongarch/kernel/kprobes.c#L228
> static int __kprobes kprobe_handler(struct pt_regs *regs)
> {
> 	struct kprobe *p;
> 	kprobe_opcode_t *addr;
> 	struct kprobe_ctlblk *kcb;
> 
> 	addr = (kprobe_opcode_t *) regs->csr_era;
> 
> 	/*
> 	 * We don't want to be preempted for the entire
> 	 * duration of kprobe processing
> 	 */
> 	preempt_disable();
> 	kcb = get_kprobe_ctlblk();
> 
> 	p = get_kprobe(addr);
> 	if (p) {
> 		if (kprobe_running()) {
> 			if (reenter_kprobe(p, regs, kcb))
> 				return 1;
> 		} else {
> 			set_current_kprobe(p, regs, kcb);
> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 			if (p->pre_handler && p->pre_handler(p, regs)) {
> 			/* handler has already set things up, so skip ss setup */
> 				reset_current_kprobe();
> 				preempt_enable_no_resched();
> 				return 1;
> 			} else {
> 				setup_singlestep(p, regs, kcb, 0);
> 				return 1;
> 			}
> 		}
> 	} else {
> 		if (addr->word != breakpoint_insn.word) {
> 			/*
> 			 * The breakpoint instruction was removed right
> 			 * after we hit it.  Another cpu has removed
> 			 * either a probepoint or a debugger breakpoint
> 			 * at this address.  In either case, no further
> 			 * handling of this interrupt is appropriate.
> 			 */
> 			preempt_enable_no_resched();
> 			return 1;
> 		}
> 	}
> 
> 	preempt_enable_no_resched();
> 
> 	return 0;
> }
> 
> Thanks,
> Tiezhu
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
