Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D101D68F117
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBHOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBHOqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:46:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D3A3303E7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:46:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B5F11042;
        Wed,  8 Feb 2023 06:46:49 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9E13F8C6;
        Wed,  8 Feb 2023 06:46:04 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:46:01 +0000
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
Message-ID: <Y+O1qY453BnhqgQZ@FVFF77S0Q05N.cambridge.arm.com>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
 <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
 <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:30:56AM +0800, Guo Ren wrote:
> Hi Mark,
> 
> Thx for the thoughtful reply.
> 
> On Tue, Feb 7, 2023 at 5:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Note that I'm assuming you will *always* go through a common ftrace_caller
> > trampoline (even for direct calls), with the trampoline responsible for
> > recovering the direct trampoline (or ops->func) from the ops pointer.
> >
> > That would only require 64-bit alignment on 64-bit (or 32-bit alignment on
> > 32-bit) to keep the literal naturally-aligned; the rest of the instructions
> > wouldn't require additional alignment.
> >
> > For example, I would expect that (for 64-bit) you'd use:
> >
> >   # place 2 NOPs *immediately before* the function, and 3 NOPs at the start
> >   -fpatchable-function-entry=5,2
> >
> >   # Align the function to 8-bytes
> >   -falign=functions=8
> >
> > ... and your trampoline in each function could be initialized to:
> >
> >   # Note: aligned to 8 bytes
> >   addr-08               // Literal (first 32-bits)      // set to ftrace_nop_ops
> >   addr-04               // Literal (last 32-bits)       // set to ftrace_nop_ops
> >   addr+00       func:   mv      t0, ra
> >   addr+04               auipc   t1, ftrace_caller
> >   addr+08               nop
> >
> > ... and when enabled can be set to:
> >
> >   # Note: aligned to 8 bytes
> >   addr-08               // Literal (first 32-bits)      // patched to ops ptr
> >   addr-04               // Literal (last 32-bits)       // patched to ops ptr
> >   addr+00       func:   mv      t0, ra
> We needn't "mv t0, ra" here because our "jalr" could work with t0 and
> won't affect ra. Let's do it in the trampoline code, and then we can
> save another word here.

Ah; I thought JALR always clobbered ra? Or can that specify the register to
save the link address to?

I'm not that familiar with riscv asm, so I've probably just got that wrong.

> >   addr+04               auipc   t1, ftrace_caller
> >   addr+08               jalr    ftrace_caller(t1)
> 
> Here is the call-site:
>    # Note: aligned to 8 bytes
>    addr-08               // Literal (first 32-bits)      // patched to ops ptr
>    addr-04               // Literal (last 32-bits)       // patched to ops ptr
>    addr+00               auipc   t0, ftrace_caller
>    addr+04               jalr    ftrace_caller(t0)

I'm a bit confused there; I thought that the `symbol(reg)` addressing mode was
generating additional bits that the AUPIC didn't -- have I got that wrong?

What specifies which register the JALR will write the link address to?

> > Note: this *only* requires patching the literal and NOP<->JALR; the MV and
> > AUIPC aren't harmful and can always be there. This way, you won't need to use
> > stop_machine().
> Yes, simplest nop is better than c.j. I confused.
> 
> >
> > With that, the ftrace_caller trampoline can recover the `ops` pointer at a
> > negative offset from `ra`, and can recover the instrumented function's return
> > address in `t0`. Using the `ops` pointer, it can figure out whether to branch
> > to a direct trampoline or whether to save/restore the regs around invoking
> > ops->func.
> >
> > For 32-bit it would be exactly the same, except you'd only need a single nop
> > before the function, and the offset would be -0x10.
> Yes, we reduced another 4 bytes & a smaller alignment for better code
> size when 32-bit.
>    # Note: aligned to 4 bytes
>    addr-04               // Literal (last 32-bits)       // patched to ops ptr
>    addr+00               auipc   t0, ftrace_caller
>    addr+04               jalr    ftrace_caller(t0)
> >

> > That's what arm64 does; the only difference is that riscv would *always* need
> > to go via the trampoline in order to make direct calls.
> We need one more trampoline here beside ftrace_caller &
> ftrace_regs_caller: It's "direct_caller".
> 
> addr+04         nop -> direct_caller/ftrace_caller/ftrace_regs_caller

I'd strongly recommend that you instead implement FTRACE_WITH_ARGS and
deprecate FTRACE_WITH_REGS, like arm64 has done, then you only need a single
ftrace_caller, as I mentioned above. That way there's no risk that you need to
patch the AUIPC after initialization.

The arm64 FTRACE_WITH_ARGS conversion is in mainline, and arm64's
FTRACE_WITH_CALL_OPS is based upon that. Florent's DIRECT_CALLS patches add the
direct call logic to the same ftrace_caller trampoline.

Thanks,
Mark.
