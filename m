Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E08681584
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjA3Ptm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjA3PtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:49:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6EC86A54
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:49:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AD5C19F0;
        Mon, 30 Jan 2023 07:50:04 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.10.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B45653F882;
        Mon, 30 Jan 2023 07:49:20 -0800 (PST)
Date:   Mon, 30 Jan 2023 15:49:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
Message-ID: <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Jan 30, 2023 at 04:28:15PM +0100, Björn Töpel wrote:
> Guo Ren <guoren@kernel.org> writes:
> 
> >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructions pair
> >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not execute
> >> in the instructions that will be modified, it is still need to stop other CPUs
> >> via patch_text API, or you have any better solution to achieve the purpose?
> >  - The stop_machine is an expensive way all architectures should
> > avoid, and you could keep that in your OPTPROBES implementation files
> > with static functions.
> >  - The stop_machine couldn't work with PREEMPTION, so your
> > implementation needs to work with !PREEMPTION.
> 
> ...and stop_machine() with !PREEMPTION is broken as well, when you're
> replacing multiple instructions (see Mark's post at [1]). The
> stop_machine() dance might work when you're replacing *one* instruction,
> not multiple as in the RISC-V case. I'll expand on this in a comment in
> the OPTPROBES v6 series.

Just to clarify, my comments in [1] were assuming that stop_machine() was not
used, in which case there is a problem with or without PREEMPTION.

I believe that when using stop_machine(), the !PREEMPTION case is fine, since
stop_machine() schedules work rather than running work in IRQ context on the
back of an IPI, so no CPUs should be mid-sequnce during the patching, and it's
not possible for there to be threads which are preempted mid-sequence.

That all said, IIUC optprobes is going to disappear once fprobe is ready
everywhere, so that might be moot.

Thanks,
Mark.

> >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> >> >  /* install breakpoint in text */
> >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> >> >  {
> >> > -     if ((p->opcode & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
> >> > -             patch_text(p->addr, __BUG_INSN_32);
> >> > -     else
> >> > -             patch_text(p->addr, __BUG_INSN_16);
> >> > +#ifdef CONFIG_RISCV_ISA_C
> >> > +     u32 opcode = __BUG_INSN_16;
> >> > +#else
> >> > +     u32 opcode = __BUG_INSN_32;
> >> > +#endif
> >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));
> >>
> >> Sounds good, but it will leave some RVI instruction truncated in kernel text,
> >> i doubt kernel behavior depends on the rest of the truncated instruction, well,
> >> it needs more strict testing to prove my concern :)
> > I do this on purpose, and it doesn't cause any problems. Don't worry;
> > IFU hw must enforce the fetch sequence, and there is no way to execute
> > broken instructions even in the speculative execution path.
> 
> This is stretching reality a bit much. ARMv8, e.g., has a chapter in the
> Arm ARM [2] Appendix B "Concurrent modification and execution of
> instructions" (CMODX). *Some* instructions can be replaced concurrently,
> and others cannot without caution. Assuming that that all RISC-V
> implementations can, is a stretch. RISC-V hasn't even specified the
> behavior of CMODX (which is problematic).
> 
> If anything it would be more likely that the existing
> "stop_machine()-to-replace-with-ebreak" works (again, replacing one
> instruction does not have the !PREEMPTION issues). Then again, no spec,
> so mostly guessing from my side. :-(
> 
> Oh, but the existing "ebreak replace" might be broken like [3].
> 
> 
> Björn
> 
> 
> [1] https://lore.kernel.org/linux-riscv/Y7%2F6AtX5X0+5qF6Y@FVFF77S0Q05N/
> [2] https://developer.arm.com/documentation/ddi0487/latest
> [3] https://lore.kernel.org/linux-riscv/20230126170607.1489141-2-guoren@kernel.org/
