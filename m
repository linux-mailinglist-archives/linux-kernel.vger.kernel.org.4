Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7862D060
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiKQBHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiKQBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:07:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 895CF6A745
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:07:42 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxfbddiXVj5BsIAA--.18180S3;
        Thu, 17 Nov 2022 09:07:41 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZ1dZiXVjzYMVAA--.38751S3;
        Thu, 17 Nov 2022 09:07:38 +0800 (CST)
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Questions about kprobe handler
Message-ID: <9b6eb4db-83fe-e6d9-a580-1a11aace84b0@loongson.cn>
Date:   Thu, 17 Nov 2022 09:07:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxZ1dZiXVjzYMVAA--.38751S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jr4UKw4UuF45AryxCFWkCrg_yoW3ZFW3pF
        sakw1rKr48GFy8CFZrZa1jyr1Syr4rZrWUGFn7Ga4Syw1UXr45WF1xuw47ZFs8Cryv9a1a
        vrWxtry5uF9xArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KPROBES maintainers,

There are some differences of kprobe handler implementations on various
archs, the implementations are almost same on arm64, riscv, csky, the
code logic is clear and understandable. But on mips and loongarch (not
upstreamed yet), if get_kprobe() returns NULL, what is the purpose of
the check "if (addr->word != breakpoint_insn.word)", is it necessary?
Can we just return directly? Please take a look, thank you.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n323
		p = get_kprobe(addr);
		if (p) {
			...
		} else if (addr->word != breakpoint_insn.word) {
			/*
			 * The breakpoint instruction was removed by
			 * another cpu right after we hit, no further
			 * handling of this interrupt is appropriate
			 */
			ret = 1;
		}
https://github.com/loongson/linux/blob/loongarch-next-generic-stub/arch/loongarch/kernel/kprobes.c#L262
	p = get_kprobe(addr);
	if (p) {
		...
	} else {
		if (addr->word != breakpoint_insn.word) {
			/*
			 * The breakpoint instruction was removed right
			 * after we hit it.  Another cpu has removed
			 * either a probepoint or a debugger breakpoint
			 * at this address.  In either case, no further
			 * handling of this interrupt is appropriate.
			 */
			preempt_enable_no_resched();
			return 1;
		}
	}

(1) arm64
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/probes/kprobes.c#n309
static void __kprobes kprobe_handler(struct pt_regs *regs)
{
	struct kprobe *p, *cur_kprobe;
	struct kprobe_ctlblk *kcb;
	unsigned long addr = instruction_pointer(regs);

	kcb = get_kprobe_ctlblk();
	cur_kprobe = kprobe_running();

	p = get_kprobe((kprobe_opcode_t *) addr);

	if (p) {
		if (cur_kprobe) {
			if (reenter_kprobe(p, regs, kcb))
				return;
		} else {
			/* Probe hit */
			set_current_kprobe(p);
			kcb->kprobe_status = KPROBE_HIT_ACTIVE;

			/*
			 * If we have no pre-handler or it returned 0, we
			 * continue with normal processing.  If we have a
			 * pre-handler and it returned non-zero, it will
			 * modify the execution path and no need to single
			 * stepping. Let's just reset current kprobe and exit.
			 */
			if (!p->pre_handler || !p->pre_handler(p, regs)) {
				setup_singlestep(p, regs, kcb, 0);
			} else
				reset_current_kprobe();
		}
	}
	/*
	 * The breakpoint instruction was removed right
	 * after we hit it.  Another cpu has removed
	 * either a probepoint or a debugger breakpoint
	 * at this address.  In either case, no further
	 * handling of this interrupt is appropriate.
	 * Return back to original instruction, and continue.
	 */
}

(2) riscv
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/probes/kprobes.c#n269
bool __kprobes
kprobe_breakpoint_handler(struct pt_regs *regs)
{
	struct kprobe *p, *cur_kprobe;
	struct kprobe_ctlblk *kcb;
	unsigned long addr = instruction_pointer(regs);

	kcb = get_kprobe_ctlblk();
	cur_kprobe = kprobe_running();

	p = get_kprobe((kprobe_opcode_t *) addr);

	if (p) {
		if (cur_kprobe) {
			if (reenter_kprobe(p, regs, kcb))
				return true;
		} else {
			/* Probe hit */
			set_current_kprobe(p);
			kcb->kprobe_status = KPROBE_HIT_ACTIVE;

			/*
			 * If we have no pre-handler or it returned 0, we
			 * continue with normal processing.  If we have a
			 * pre-handler and it returned non-zero, it will
			 * modify the execution path and no need to single
			 * stepping. Let's just reset current kprobe and exit.
			 *
			 * pre_handler can hit a breakpoint and can step thru
			 * before return.
			 */
			if (!p->pre_handler || !p->pre_handler(p, regs))
				setup_singlestep(p, regs, kcb, 0);
			else
				reset_current_kprobe();
		}
		return true;
	}

	/*
	 * The breakpoint instruction was removed right
	 * after we hit it.  Another cpu has removed
	 * either a probepoint or a debugger breakpoint
	 * at this address.  In either case, no further
	 * handling of this interrupt is appropriate.
	 * Return back to original instruction, and continue.
	 */
	return false;
}

(3) csky
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/csky/kernel/probes/kprobes.c#n311
int __kprobes
kprobe_breakpoint_handler(struct pt_regs *regs)
{
	struct kprobe *p, *cur_kprobe;
	struct kprobe_ctlblk *kcb;
	unsigned long addr = instruction_pointer(regs);

	kcb = get_kprobe_ctlblk();
	cur_kprobe = kprobe_running();

	p = get_kprobe((kprobe_opcode_t *) addr);

	if (p) {
		if (cur_kprobe) {
			if (reenter_kprobe(p, regs, kcb))
				return 1;
		} else {
			/* Probe hit */
			set_current_kprobe(p);
			kcb->kprobe_status = KPROBE_HIT_ACTIVE;

			/*
			 * If we have no pre-handler or it returned 0, we
			 * continue with normal processing.  If we have a
			 * pre-handler and it returned non-zero, it will
			 * modify the execution path and no need to single
			 * stepping. Let's just reset current kprobe and exit.
			 *
			 * pre_handler can hit a breakpoint and can step thru
			 * before return.
			 */
			if (!p->pre_handler || !p->pre_handler(p, regs))
				setup_singlestep(p, regs, kcb, 0);
			else
				reset_current_kprobe();
		}
		return 1;
	}

	/*
	 * The breakpoint instruction was removed right
	 * after we hit it.  Another cpu has removed
	 * either a probepoint or a debugger breakpoint
	 * at this address.  In either case, no further
	 * handling of this interrupt is appropriate.
	 * Return back to original instruction, and continue.
	 */
	return 0;
}

(4) mips
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n279
static int kprobe_handler(struct pt_regs *regs)
{
	struct kprobe *p;
	int ret = 0;
	kprobe_opcode_t *addr;
	struct kprobe_ctlblk *kcb;

	addr = (kprobe_opcode_t *) regs->cp0_epc;

	/*
	 * We don't want to be preempted for the entire
	 * duration of kprobe processing
	 */
	preempt_disable();
	kcb = get_kprobe_ctlblk();

	/* Check we're not actually recursing */
	if (kprobe_running()) {
		p = get_kprobe(addr);
		if (p) {
			if (kcb->kprobe_status == KPROBE_HIT_SS &&
			    p->ainsn.insn->word == breakpoint_insn.word) {
				regs->cp0_status &= ~ST0_IE;
				regs->cp0_status |= kcb->kprobe_saved_SR;
				goto no_kprobe;
			}
			/*
			 * We have reentered the kprobe_handler(), since
			 * another probe was hit while within the handler.
			 * We here save the original kprobes variables and
			 * just single step on the instruction of the new probe
			 * without calling any user handlers.
			 */
			save_previous_kprobe(kcb);
			set_current_kprobe(p, regs, kcb);
			kprobes_inc_nmissed_count(p);
			prepare_singlestep(p, regs, kcb);
			kcb->kprobe_status = KPROBE_REENTER;
			if (kcb->flags & SKIP_DELAYSLOT) {
				resume_execution(p, regs, kcb);
				restore_previous_kprobe(kcb);
				preempt_enable_no_resched();
			}
			return 1;
		} else if (addr->word != breakpoint_insn.word) {
			/*
			 * The breakpoint instruction was removed by
			 * another cpu right after we hit, no further
			 * handling of this interrupt is appropriate
			 */
			ret = 1;
		}
		goto no_kprobe;
	}
...
}

(5) loongarch
https://github.com/loongson/linux/blob/loongarch-next-generic-stub/arch/loongarch/kernel/kprobes.c#L228
static int __kprobes kprobe_handler(struct pt_regs *regs)
{
	struct kprobe *p;
	kprobe_opcode_t *addr;
	struct kprobe_ctlblk *kcb;

	addr = (kprobe_opcode_t *) regs->csr_era;

	/*
	 * We don't want to be preempted for the entire
	 * duration of kprobe processing
	 */
	preempt_disable();
	kcb = get_kprobe_ctlblk();

	p = get_kprobe(addr);
	if (p) {
		if (kprobe_running()) {
			if (reenter_kprobe(p, regs, kcb))
				return 1;
		} else {
			set_current_kprobe(p, regs, kcb);
			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
			if (p->pre_handler && p->pre_handler(p, regs)) {
			/* handler has already set things up, so skip ss setup */
				reset_current_kprobe();
				preempt_enable_no_resched();
				return 1;
			} else {
				setup_singlestep(p, regs, kcb, 0);
				return 1;
			}
		}
	} else {
		if (addr->word != breakpoint_insn.word) {
			/*
			 * The breakpoint instruction was removed right
			 * after we hit it.  Another cpu has removed
			 * either a probepoint or a debugger breakpoint
			 * at this address.  In either case, no further
			 * handling of this interrupt is appropriate.
			 */
			preempt_enable_no_resched();
			return 1;
		}
	}

	preempt_enable_no_resched();

	return 0;
}

Thanks,
Tiezhu

