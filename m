Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73860D09F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiJYPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJYPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:30:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483D25052A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC341B81D94
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B201C433C1;
        Tue, 25 Oct 2022 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666711837;
        bh=4k3YE8n1SaaXDjmleJSNYOAgwx9Sx1R0WhjV9aCQEXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mkXk2Cqid30mON80/nrN6ginqIULgZR1e4H3k3iBYwmbieGrx/3+F68nQKd5DlRTv
         cNGMhhHywPxKkgY2rLBTg1cMap/ReS4YqmUC1DlYPp4bHhJ56x22t5KYpj4DZ2ROPe
         yo8IzKO7Ez3WD3aCL9z2grSQCN30WofT9fAa1HQNCptSMJlP3+jxpdRRjIESnsEBZC
         HTGI8tQ+nuMwGJVC0fA1QM+4/YojWADBoyHXGqt6cK5g4PqhuDPZC+9F0CDtIaHUWl
         Sxplc3XHzprKaZz1/AOpxowxEBwEXZ6UTgf7/oBhlVVhdbM5+MSy4+xbefDRgoB4q/
         vIeUu8tL3wKGg==
Date:   Wed, 26 Oct 2022 00:30:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        will@kernel.org
Subject: Re: [PATCH 3/4] ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
Message-Id: <20221026003032.0549ce35913985fde16750d4@kernel.org>
In-Reply-To: <CABRcYm+JREGhH+S+it0XQ8qWfa3Px68=LDZCf9vT=roZpztsXg@mail.gmail.com>
References: <20221024140846.3555435-1-mark.rutland@arm.com>
        <20221024140846.3555435-4-mark.rutland@arm.com>
        <20221025174001.cf5a189a23aaeadc2c8887a2@kernel.org>
        <Y1e6znjOHCFGvLND@FVFF77S0Q05N>
        <CABRcYm+JREGhH+S+it0XQ8qWfa3Px68=LDZCf9vT=roZpztsXg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 15:20:57 +0200
Florent Revest <revest@chromium.org> wrote:

> On Tue, Oct 25, 2022 at 12:30 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Oct 25, 2022 at 05:40:01PM +0900, Masami Hiramatsu wrote:
> > > Hi Mark,
> > >
> > > On Mon, 24 Oct 2022 15:08:45 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > > In subsequent patches we'll arrange for architectures to have an
> > > > ftrace_regs which is entirely distinct from pt_regs. In preparation for
> > > > this, we need to minimize the use of pt_regs to where strictly necessary
> > > > in the core ftrace code.
> > > >
> > > > This patch adds new ftrace_regs_{get,set}_*() helpers which can be used
> > > > to manipulate ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y,
> > > > these can always be used on any ftrace_regs, and when
> > > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n these can be used when regs are
> > > > available. A new ftrace_regs_has_args(fregs) helper is added which code
> > > > can use to check when these are usable.
> > >
> > > Can you also add the ftrace_regs_query_register_offset() as a wrapper of
> > > regs_query_register_offset()? I would like to use it for fprobe_events.
> >
> > Sure!
> >
> > Just to check, with FTRACE_WITH_REGS, does fprobe always sample the full
> > pt_regs, or do callers also need to check ftrace_regs_has_args(fregs)?

No, if the register is NOT saved, just return -ENOENT.

> 
> Currently, we have:
> config FPROBE
>     depends on DYNAMIC_FTRACE_WITH_REGS
> 
> Because fprobe registers its ftrace ops with FTRACE_OPS_FL_SAVE_REGS
> and calls ftrace_get_regs() to give pt_regs to registered fprobe
> callbacks.
> 
> We'll need to refactor fprobe a bit to support ||
> DYNAMIC_FTRACE_WITH_ARGS and therefore work on arm64.

Yeah, that is what I will do.

> > I ask because if neither of those are the case, with FTRACE_WITH_REGS,
> > ftrace_regs_query_register_offset() would accept names of registers which might
> > not have been sampled, and could give offsets to uninitialized memory.
> 
> Indeed, if one were to call the regs_query_register_offset() on a
> pt_regs that comes out of a ftrace trampoline with FTRACE_WITH_REGS,
> for example in a fprobe callback, one could get offsets to
> uninitialized memory already (for the registers we can't get outside
> of an exception handler on arm64 for example iiuc)
> 
> And it'd get way worse with FTRACE_WITH_ARGS if we implement
> ftrace_regs_query_register_offset() by calling
> regs_query_register_offset() for ftrace_regs that contain sparse
> pt_regs.

Ah, I got what you meant. If you consider that case, it can return
-ENOTSUPPORT for FTRACE_WITH_ARGS case at this moment. I'll fill it
afterwards.

> 
> > Atop that, I'm not exactly sure what to implement for powerpc/s390/x86 here. If
> > those might be used without a full pt_regs, I think
> > ftrace_regs_query_register_offset() should also take the fregs as a parameter
> > and use that to check which registers are available.
> 
> I think it would make sense for a ftrace_regs_query_register_offset()
> to only return offsets to the registers that are actually saved by the
> arch in a ftrace_regs (whether that's WITH_ARGS or WITH_REGS).
> 
> But that also means that if we introduce "fprobe_events" in the
> tracing sysfs interface, we can't have it support a %REG syntax
> compatible with the one in "kprobe_events" anyway.
> 
> Masami, how about having "fprobe_events" only support $argN, $retval
> etc but no %REG, from the beginning ? Then it would be clear to users
> that fprobe can not guarantee registers and we'd never have to fake
> registers when we don't have them. Users would have to make a decision
> between using fprobe which is fast but only has arguments and return
> value and kprobe which is slow but has all registers.

Hmm, for the first implementation, it is OK. But later I need to
implement the register access, because, debuginfo maps it differently.
I would like to arrow perf-probe to set it up eventually.

> I realize this has consequences for the kretprobe and rethook
> unification plan but if we have fprobe_events support %REG at the
> beginning, we'd have to break it at some point down the line anyway
> right ?

No, because %REG support doesn't mean we guarantee to access
all registers. We can just use %REG as alias of $argN :)

Thank you,

> 
> > ... does that make sense to you?
> >
> > Thanks,
> > Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
