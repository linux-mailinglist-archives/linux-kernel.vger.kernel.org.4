Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21AE682AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjAaKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAaKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:51:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E2E922A22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:50:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26EA32F4;
        Tue, 31 Jan 2023 02:33:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FC3A3F64C;
        Tue, 31 Jan 2023 02:33:08 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:33:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
Message-ID: <Y9juYX8Bt1Z55lv0@FVFF77S0Q05N>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
 <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:48:29AM +0800, Guo Ren wrote:
> On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Bjorn,
> >
> > On Mon, Jan 30, 2023 at 04:28:15PM +0100, Björn Töpel wrote:
> > > Guo Ren <guoren@kernel.org> writes:
> > >
> > > >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructions pair
> > > >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not execute
> > > >> in the instructions that will be modified, it is still need to stop other CPUs
> > > >> via patch_text API, or you have any better solution to achieve the purpose?
> > > >  - The stop_machine is an expensive way all architectures should
> > > > avoid, and you could keep that in your OPTPROBES implementation files
> > > > with static functions.
> > > >  - The stop_machine couldn't work with PREEMPTION, so your
> > > > implementation needs to work with !PREEMPTION.
> > >
> > > ...and stop_machine() with !PREEMPTION is broken as well, when you're
> > > replacing multiple instructions (see Mark's post at [1]). The
> > > stop_machine() dance might work when you're replacing *one* instruction,
> > > not multiple as in the RISC-V case. I'll expand on this in a comment in
> > > the OPTPROBES v6 series.
> >
> > Just to clarify, my comments in [1] were assuming that stop_machine() was not
> > used, in which case there is a problem with or without PREEMPTION.
> >
> > I believe that when using stop_machine(), the !PREEMPTION case is fine, since
> > stop_machine() schedules work rather than running work in IRQ context on the
> > back of an IPI, so no CPUs should be mid-sequnce during the patching, and it's
> > not possible for there to be threads which are preempted mid-sequence.
> >
> > That all said, IIUC optprobes is going to disappear once fprobe is ready
> > everywhere, so that might be moot.
> The optprobes could be in the middle of a function, but fprobe must be
> the entry of a function, right?
> 
> Does your fprobe here mean: ?
> 
> The Linux kernel configuration item CONFIG_FPROBE:
> 
> prompt: Kernel Function Probe (fprobe)
> type: bool
> depends on: ( CONFIG_FUNCTION_TRACER ) && (
> CONFIG_DYNAMIC_FTRACE_WITH_REGS ) && ( CONFIG_HAVE_RETHOOK )
> defined in kernel/trace/Kconfig

Yes.

Masami, Steve, and I had a chat at the tracing summit late last year (which
unfortunately, was not recorded), and what we'd like to do is get each
architecture to have FPROBE (and FTRACE_WITH_ARGS), at which point OPTPROBE
and KRETPROBE become redundant and could be removed.

i.e. we'd keep KPROBES as a "you can trace any instruction" feature, but in the
few cases where OPTPROBES can make things fater by using FTRACE, you should
just use that directly via FPROBE.

Thanks,
Mark.
