Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F272D613C20
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiJaR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiJaR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:27:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FEC313CEF;
        Mon, 31 Oct 2022 10:27:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id B11FF20B9F80;
        Mon, 31 Oct 2022 10:27:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B11FF20B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667237234;
        bh=L4bcpwHfvSCyNSoIiW3sfiEU7KvCeBel420vDpIzx7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLvO/EijXBb8yr9IPgjsOOirRr1jqXh/el0POirCQY4K5yn/sZ2NPxZEP5kZKcj3D
         EJzYlxyNeoykWcsD2Z9Vfteg1smWtj83X4gHHuzHRfHq/7Nv+oTUT93SqO778m21Xy
         ggl6qpaVKmoG/6aRx21d3r9dSOjHb9yLbyKMUN+I=
Date:   Mon, 31 Oct 2022 10:27:06 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Message-ID: <20221031172706.GA196@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221031231556.a15846fd3513641d48820d5b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031231556.a15846fd3513641d48820d5b@kernel.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:15:56PM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Thu, 27 Oct 2022 15:40:09 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > As part of the discussions for user_events aligned with user space
> > tracers, it was determined that user programs should register a 32-bit
> > value to set or clear a bit when an event becomes enabled. Currently a
> > shared page is being used that requires mmap().
> > 
> > In this new model during the event registration from user programs 2 new
> > values are specified. The first is the address to update when the event
> > is either enabled or disabled. The second is the bit to set/clear to
> > reflect the event being enabled. This allows for a local 32-bit value in
> > user programs to support both kernel and user tracers. As an example,
> > setting bit 31 for kernel tracers when the event becomes enabled allows
> > for user tracers to use the other bits for ref counts or other flags.
> > The kernel side updates the bit atomically, user programs need to also
> > update these values atomically.
> 
> I think you means the kernel tracer (ftrace/perf) and user tracers (e.g. 
> LTTng) use the same 32bit data so that traced user-application only checks
> that data for checking an event is enabled, right?
> 

Yes, exactly, user code can just check a single uint32 or uint64 to tell
if anything is enabled (kernel or user tracer).

> If so, who the user tracer threads updates the data bit? Is that thread
> safe to update both kernel tracer and user tracers at the same time?
> 

This is why atomics are used to set the bit on the kernel side. The user
side should do the same. This is like the futex code. Do you see a
problem with atomics being used between user and kernel space on a
shared 32/64-bit address?

> And what is the actual advantage of this change? Are there any issue
> to use mmaped page? I would like to know more background of this
> change.
> 

Without this change user tracers like LTTng will have to check 2 values
instead of 1 to tell if the kernel tracer is enabled or not. Mathieu is
working on a user side tracing library in an effort to align writing
tracing code in user processes that works well for both kernel and user
tracers without much effort.

See here:
https://github.com/compudj/side

Are you proposing we keep the bitmap approach and have side library just
hook another branch? Mathieu had issues with that approach during our
talks.

> Could you also provide any sample program which I can play it? :)
> 

When I make the next patch version, I will update the user_events sample
so you'll have something to try out.

> > User provided addresses must be aligned on a 32-bit boundary, this
> > allows for single page checking and prevents odd behaviors such as a
> > 32-bit value straddling 2 pages instead of a single page.
> > 
> > When page faults are encountered they are done asyncly via a workqueue.
> > If the page faults back in, the write update is attempted again. If the
> > page cannot fault-in, then we log and wait until the next time the event
> > is enabled/disabled. This is to prevent possible infinite loops resulting
> > from bad user processes unmapping or changing protection values after
> > registering the address.
> > 
> > NOTE:
> > User programs that wish to have the enable bit shared across forks
> > either need to use a MAP_SHARED allocated address or register a new
> > address and file descriptor. If MAP_SHARED cannot be used or new
> > registrations cannot be done, then it's allowable to use MAP_PRIVATE
> > as long as the forked children never update the page themselves. Once
> > the page has been updated, the page from the parent will be copied over
> > to the child. This new copy-on-write page will not receive updates from
> > the kernel until another registration has been performed with this new
> > address.
> > 
> > Beau Belgrave (2):
> >   tracing/user_events: Use remote writes for event enablement
> >   tracing/user_events: Fixup enable faults asyncly
> > 
> >  include/linux/user_events.h      |  10 +-
> >  kernel/trace/trace_events_user.c | 396 ++++++++++++++++++++-----------
> >  2 files changed, 270 insertions(+), 136 deletions(-)
> > 
> > 
> > base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
> > -- 
> > 2.25.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
-Beau
