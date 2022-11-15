Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C140629E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiKOPtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:48:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED0E32E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:48:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A80BD13D5;
        Tue, 15 Nov 2022 07:49:02 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.33.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54E6A3F587;
        Tue, 15 Nov 2022 07:48:55 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:48:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, will@kernel.org
Subject: Re: [PATCH v2 0/4] arm64/ftrace: move to DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <Y3O04U1NydlIOddW@FVFF77S0Q05N.cambridge.arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
 <20221115100148.08475da0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115100148.08475da0@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:01:48AM -0500, Steven Rostedt wrote:
> On Thu,  3 Nov 2022 17:05:16 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > This series replaces arm64's support for FTRACE_WITH_REGS with support
> > for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> > removes some latent issues with inconsistent presentation of struct
> > pt_regs (which can only be reliably saved/restored at exception
> > boundaries).
> > 
> > The existing FTRACE_WITH_REGS support was added for two major reasons:
> > 
> > (1) To make it possible to use the ftrace graph tracer with pointer
> >     authentication, where it's necessary to snapshot/manipulate the LR
> >     before it is signed by the instrumented function.
> > 
> > (2) To make it possible to implement LIVEPATCH in future, where we need
> >     to hook function entry before an instrumented function manipulates
> >     the stack or argument registers. Practically speaking, we need to
> >     preserve the argument/return registers, PC, LR, and SP.
> > 
> > Neither of these requires the full set of pt_regs, and only requires us
> > to save/restore a subset of registers used for passing
> > arguments/return-values and context/return information (which is the
> > minimum set we always need to save/restore today).
> > 
> > As there is no longer a need to save different sets of registers for
> > different features, we no longer need distinct `ftrace_caller` and
> > `ftrace_regs_caller` trampolines. This allows the trampoline assembly to
> > be simpler, and simplifies code which previously had to handle the two
> > trampolines.
> > 
> > I've tested this with the ftrace selftests, where there are no
> > unexpected failures.
> 
> Were there any "expected" failures?

Ah; sorry, I had meant to include the results here.

With this series applied atop v6.1-rc4 and using the ftrace selftests from that
tree, my results were the same as with baseline v6.1-rc4:

| # of passed:  104
| # of failed:  0
| # of unresolved:  7
| # of untested:  0
| # of unsupported:  2
| # of xfailed:  1
| # of undefined(test bug):  0

Where the non-passing tests were:

| [8] Test ftrace direct functions against tracers        [UNRESOLVED]
| [9] Test ftrace direct functions against kprobes        [UNRESOLVED]

... as direct functions aren't supported on arm64 (both before and after this
series).

| [16] Generic dynamic event - check if duplicate events are caught       [UNSUPPORTED]
| [74] event trigger - test inter-event histogram trigger eprobe on synthetic event       [UNSUPPORTED]

... which are due to a bug in the tests fixed by:

  https://lore.kernel.org/all/20221010074207.714077-1-svens@linux.ibm.com/

... and they both pass with that applied.

| [22] Test trace_printk from module      [UNRESOLVED]
| [31] ftrace - function trace on module  [UNRESOLVED]
| [51] Kprobe dynamic event - probing module      [UNRESOLVED]
| [61] test for the preemptirqsoff tracer [UNRESOLVED]

... which are because my test environment didn't have modules.

| [62] Meta-selftest: Checkbashisms       [UNRESOLVED]

... which is irrelevant for this series.

| [65] event trigger - test inter-event histogram trigger expected fail actions   [XFAIL]

... which is expected.

[...]

> So I ran this on top of my code through all my ftrace tests (for x86) and
> it didn't cause any regressions.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

Mark.
