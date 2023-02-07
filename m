Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2D68D262
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjBGJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjBGJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:17:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A793C1EFCD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:17:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71FD81063;
        Tue,  7 Feb 2023 01:17:46 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F5BB3F71E;
        Tue,  7 Feb 2023 01:17:01 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:16:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Evgenii Shatokhin <e.shatokhin@yadro.com>, suagrfillet@gmail.com,
        andy.chiu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, linux@yadro.com
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
Message-ID: <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
 <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 11:57:06AM +0800, Guo Ren wrote:
> On Mon, Feb 6, 2023 at 5:56 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > The DYNAMIC_FTRACE_WITH_CALL_OPS patches should be in v6.3. They're currently
> > queued in the arm64 tree in the for-next/ftrace branch:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/ftrace
> >   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/
> >
> > ... and those *should* be in v6.3.
> Glade to hear that. Great!
> 
> >
> > Patches to imeplement DIRECT_CALLS atop that are in review at the moment:
> >
> >   https://lore.kernel.org/linux-arm-kernel/20230201163420.1579014-1-revest@chromium.org/
> Good reference. Thx for sharing.
> 
> >
> > ... and if riscv uses the CALL_OPS approach, I believe it can do much the same
> > there.
> >
> > If riscv wants to do a single atomic patch to each patch-site (to avoid
> > stop_machine()), then direct calls would always needs to bounce through the
> > ftrace_caller trampoline (and acquire the direct call from the ftrace_ops), but
> > that might not be as bad as it sounds -- from benchmarking on arm64, the bulk
> > of the overhead seen with direct calls is when using the list_ops or having to
> > do a hash lookup, and both of those are avoided with the CALL_OPS approach.
> > Calling directly from the patch-site is a minor optimization relative to
> > skipping that work.
> Yes, CALL_OPS could solve the PREEMPTION & stop_machine problems. I
> would follow up.
> 
> The difference from arm64 is that RISC-V is 16bit/32bit mixed
> instruction ISA, so we must keep ftrace_caller & ftrace_regs_caller in
> 2048 aligned. Then:

Where does the 2048-bit alignment requirement come from?

Note that I'm assuming you will *always* go through a common ftrace_caller
trampoline (even for direct calls), with the trampoline responsible for
recovering the direct trampoline (or ops->func) from the ops pointer.

That would only require 64-bit alignment on 64-bit (or 32-bit alignment on
32-bit) to keep the literal naturally-aligned; the rest of the instructions
wouldn't require additional alignment.

For example, I would expect that (for 64-bit) you'd use:

  # place 2 NOPs *immediately before* the function, and 3 NOPs at the start
  -fpatchable-function-entry=5,2

  # Align the function to 8-bytes
  -falign=functions=8

... and your trampoline in each function could be initialized to:

  # Note: aligned to 8 bytes
  addr-08		// Literal (first 32-bits)	// set to ftrace_nop_ops
  addr-04		// Literal (last 32-bits)	// set to ftrace_nop_ops
  addr+00	func:	mv	t0, ra
  addr+04		auipc	t1, ftrace_caller
  addr+08		nop

... and when enabled can be set to:

  # Note: aligned to 8 bytes
  addr-08		// Literal (first 32-bits)	// patched to ops ptr
  addr-04		// Literal (last 32-bits)	// patched to ops ptr
  addr+00	func:	mv	t0, ra
  addr+04		auipc	t1, ftrace_caller
  addr+08		jalr	ftrace_caller(t1)

Note: this *only* requires patching the literal and NOP<->JALR; the MV and
AUIPC aren't harmful and can always be there. This way, you won't need to use
stop_machine().

With that, the ftrace_caller trampoline can recover the `ops` pointer at a
negative offset from `ra`, and can recover the instrumented function's return
address in `t0`. Using the `ops` pointer, it can figure out whether to branch
to a direct trampoline or whether to save/restore the regs around invoking
ops->func.

For 32-bit it would be exactly the same, except you'd only need a single nop
before the function, and the offset would be -0x10.

That's what arm64 does; the only difference is that riscv would *always* need
to go via the trampoline in order to make direct calls.

Thanks,
Mark.
