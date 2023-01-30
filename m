Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E2680B58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjA3Kys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjA3Kyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:54:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B48E617CC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:54:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FD316A3;
        Mon, 30 Jan 2023 02:55:27 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89D93F71E;
        Mon, 30 Jan 2023 02:54:42 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:54:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next V7 1/7] riscv: ftrace: Fixup panic by disabling
 preemption
Message-ID: <Y9eh8DpjrmcLIQb5@FVFF77S0Q05N>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <20230112090603.1295340-2-guoren@kernel.org>
 <Y7/6AtX5X0+5qF6Y@FVFF77S0Q05N>
 <CAJF2gTTqW5A8qS5CQEr=kakxKw5FaFRDswet6CnBGUDasNJnbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTqW5A8qS5CQEr=kakxKw5FaFRDswet6CnBGUDasNJnbQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 05:37:46PM +0800, Guo Ren wrote:
> On Thu, Jan 12, 2023 at 8:16 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Guo,
> >
> > On Thu, Jan 12, 2023 at 04:05:57AM -0500, guoren@kernel.org wrote:
> > > From: Andy Chiu <andy.chiu@sifive.com>
> > >
> > > In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> > > forming a jump that jumps to an address over 4K. This may cause errors
> > > if we want to enable kernel preemption and remove dependency from
> > > patching code with stop_machine(). For example, if a task was switched
> > > out on auipc. And, if we changed the ftrace function before it was
> > > switched back, then it would jump to an address that has updated 11:0
> > > bits mixing with previous XLEN:12 part.
> > >
> > > p: patched area performed by dynamic ftrace
> > > ftrace_prologue:
> > > p|      REG_S   ra, -SZREG(sp)
> > > p|      auipc   ra, 0x? ------------> preempted
> > >                                       ...
> > >                               change ftrace function
> > >                                       ...
> > > p|      jalr    -?(ra) <------------- switched back
> > > p|      REG_L   ra, -SZREG(sp)
> > > func:
> > >       xxx
> > >       ret
> >
> > As mentioned on the last posting, I don't think this is sufficient to fix the
> > issue. I've replied with more detail there:
> >
> >   https://lore.kernel.org/lkml/Y7%2F3hoFjS49yy52W@FVFF77S0Q05N/
> >
> > Even in a non-preemptible SMP kernel, if one CPU can be in the middle of
> > executing the ftrace_prologue while another CPU is patching the
> > ftrace_prologue, you have the exact same issue.
> >
> > For example, if CPU X is in the prologue fetches the old AUIPC and the new
> > JALR (because it races with CPU Y modifying those), CPU X will branch to the
> > wrong address. The race window is much smaller in the absence of preemption,
> > but it's still there (and will be exacerbated in virtual machines since the
> > hypervisor can preempt a vCPU at any time).
> >
> > Note that the above is even assuming that instruction fetches are atomic, which
> > I'm not sure is the case; for example arm64 has special CMODX / "Concurrent
> > MODification and eXecutuion of instructions" rules which mean only certain
> > instructions can be patched atomically.
> >
> > Either I'm missing something that provides mutual exclusion between the
> > patching and execution of the ftrace_prologue, or this patch is not sufficient.
> This patch is sufficient because riscv isn't the same as arm64. It
> uses default arch_ftrace_update_code, which uses stop_machine.
> See kernel/trace/ftrace.c:
> void __weak arch_ftrace_update_code(int command)
> {
>         ftrace_run_stop_machine(command);
> }

Ah; sorry, I had misunderstood here, since the commit message spoke in terms of
removing that.

As long as stop_machine() is used I agree this is safe; sorry for the noise.

> ps:
>  Yes, it's not good, and it's expensive.

We can't have everything! :)

Thanks,
Mark.
