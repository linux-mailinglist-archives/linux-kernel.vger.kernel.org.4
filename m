Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6037680BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjA3LSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjA3LRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:17:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AABA661B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:17:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B29516F2;
        Mon, 30 Jan 2023 03:18:01 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51EA3F71E;
        Mon, 30 Jan 2023 03:17:16 -0800 (PST)
Date:   Mon, 30 Jan 2023 11:17:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next V6 1/7] riscv: ftrace: Fixup panic by disabling
 preemption
Message-ID: <Y9enOQUDsMbY1Y/f@FVFF77S0Q05N>
References: <20230107133549.4192639-1-guoren@kernel.org>
 <20230107133549.4192639-2-guoren@kernel.org>
 <Y7xMvAJXjHaus0Bm@FVFF77S0Q05N>
 <CAJF2gTRzS0hBdqBUNbijvKKx3Kf_mY55XSkUyPJsfOK8p15_Mw@mail.gmail.com>
 <Y7/3hoFjS49yy52W@FVFF77S0Q05N>
 <CAJF2gTQXRt-mmuA=kKKdQojgLG-eQm6PqTuwf0ccw4cdYdbYfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQXRt-mmuA=kKKdQojgLG-eQm6PqTuwf0ccw4cdYdbYfQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 06:00:20PM +0800, Guo Ren wrote:
> On Thu, Jan 12, 2023 at 8:05 PM Mark Rutland <mark.rutland@arm.com> wrote:

> > Ignoring things which require HW changes, you could consider doing something
> > like what I'm doing for arm64 with DYNAMIC_FTRACE_WITH_CALL_OPS:
> >
> >   https://lore.kernel.org/lkml/20230109135828.879136-1-mark.rutland@arm.com/
> The idea of DYNAMIC_FTRACE_WITH_CALL_OPS (Using data load/store +
> indirect jump instead of auipc+jalr) is similar to Andy's solution
> (See youtube link, last page of ppt).

Sure; I was present in that room and I spoke with Andy at the time.

The solutions are similar, but the important detail with
DYNAMIC_FTRACE_WITH_CALL_OPS is that the load and indirect branch is moved into
a common trampoline so that each call-site can be smaller. The ops pointer is
placed *before* the function entry point and doesn't need to be skipped with a
direct branch (which Andy's approach could also do if he aligned functions
similarly).

> But the key problem is you also expand the size of the prologue of the
> function. 64BIT is already expensive, and we can't afford more of it. I would
> change to seek a new atomic auipc+jalr ISA extension to solve this problem.

Sure, and that's nice for *new* hardware, but I'm talking about a solution
which works on *current* hardware.

> DYNAMIC_FTRACE_WITH_CALL_OPS  would speed up ftrace_(regs)_caller (Mostly for
> kernel debug), but it won't help DYNAMIC_FTRACE_WITH_DIRECT_CALLS. So I do
> not so care about the ftrace_(regs)_caller performance gain.

Actually, the plan is that it *will* help DYNAMIC_FTRACE_WITH_DIRECT_CALLS; we
just didn't make all the necessary changes in one go.

Florent Revest is looking at implementing that by placing the direct call
pointer into the ops, so the common trampoline can load that directly.

He has an older draft available at:

  https://github.com/FlorentRevest/linux/commits/indirect-direct-calls-3

... and since then, having spoken to Steven, we came up with a plan to make all
direct calls require an ops (which is the case for DIRECT_CALLS_MULTI), and
place a trampoline pointer in the ops.

That way, the common trampoline can do something like (in arm64 asm):

| 	LDR	<tmp>, [<ops>, #OPS_TRAMP_PTR]
| 	CBNZ	<tmp>, __call_tramp_directly
| 
| 	// ... regular regs trampoline logic here 
| 
| __call_tramp_directly:
| 
| 	// ... shuffle registers here
| 	
| 	BR	<tmp>

... and I believe the same should work for riscv.

Thanks,
Mark.
