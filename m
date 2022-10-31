Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B71613BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiJaRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiJaRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:13:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22CAE13CC1;
        Mon, 31 Oct 2022 10:13:00 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id B603520B9F80;
        Mon, 31 Oct 2022 10:12:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B603520B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667236379;
        bh=7MYtgTpOImErUqFx21Cq556DodRed9oAoc6DfdN8n6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EW/SlfWYNXaAyxFtqWbE/G2/bvCQa5h76EnSH84EVsIncfyhYn73NxdkE+9z/WyLy
         0kIiUnGicmN9HPPC6oavMXy2sDaq4DDQyfT4f/jop3iJPj/uKZzWHmEtre+tUCmDH+
         5CItstX6bs2AMP5G+saDJUH9vC5W4cyidPdhEfRw=
Date:   Mon, 31 Oct 2022 10:12:57 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Message-ID: <20221031171257.GB149@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-3-beaub@linux.microsoft.com>
 <a18e940d-8423-0294-23b4-f2702313f3eb@efficios.com>
 <20221028224256.GA202@W11-BEAU-MD.localdomain>
 <f66cdb16-8a3b-35c1-9c24-c32c5c7b19fb@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66cdb16-8a3b-35c1-9c24-c32c5c7b19fb@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 10:40:02AM -0400, Mathieu Desnoyers wrote:
> On 2022-10-28 18:42, Beau Belgrave wrote:
> > On Fri, Oct 28, 2022 at 06:19:10PM -0400, Mathieu Desnoyers wrote:
> > > On 2022-10-27 18:40, Beau Belgrave wrote:
> > > > When events are enabled within the various tracing facilities, such as
> > > > ftrace/perf, the event_mutex is held. As events are enabled pages are
> > > > accessed. We do not want page faults to occur under this lock. Instead
> > > > queue the fault to a workqueue to be handled in a process context safe
> > > > way without the lock.
> > > > 
> > > > The enable address is disabled while the async fault-in occurs. This
> > > > ensures that we don't attempt fault-in more than is necessary. Once the
> > > > page has been faulted in, the address write is attempted again. If the
> > > > page couldn't fault-in, then we wait until the next time the event is
> > > > enabled to prevent any potential infinite loops.
> > > 
> > > I'm also unclear about how the system call initiating the enabled state
> > > change is delayed (or not) when a page fault is queued.
> > > 
> > 
> > It's not, if needed we could call schedule_delayed_work(). However, I
> > don't think we need it. When pin_user_pages_remote is invoked, it's with
> > FOLL_NOFAULT. This will tell us if we need to fault pages in, we then
> > call fixup_user_fault with unlocked value passed. This will cause the
> > fixup to retry and get the page in.
> > 
> > It's called out in the comments for this exact purpose (lucked out
> > here):
> > mm/gup.c
> >   * This is meant to be called in the specific scenario where for locking reasons
> >   * we try to access user memory in atomic context (within a pagefault_disable()
> >   * section), this returns -EFAULT, and we want to resolve the user fault before
> >   * trying again.
> > 
> > The fault in happens in a workqueue, this is the same way KVM does it's
> > async page fault logic, so it's not a new pattern. As soon as the
> > fault-in is done, we have a page we should be able to use, so we
> > re-attempt the write immediately. If the write fails, another queue
> > happens and we could loop, but not like the unmap() case I replied with
> > earlier.
> > 
> > > I would expect that when a page fault is needed, after enqueuing work to the
> > > worker thread, the system call initiating the state change would somehow
> > > wait for a completion (after releasing the user events mutex). That
> > > completion would be signaled by the worker thread either if the page fault
> > > fails, or if the state change is done.
> > > 
> > 
> > I didn't see a generic fault-in + notify anywhere, do you know of one I
> > could use? Otherwise, it seems the pattern used is check fault, fault-in
> > via workqueue, re-attempt.
> 
> I don't think we're talking about the same thing. I'll try stating my
> concern in a different way.
> 
> user_event_enabler_write() calls user_event_enabler_queue_fault() when it
> cannot perform the enabled state update immediately (because a page fault is
> needed).
> 
> But then AFAIU it returns immediately to the caller. The caller could very
> well expect that the event has been enabled, as requested, immediately when
> the enabler write returns. The fact that enabling the event can be delayed
> for an arbitrary amount of time due to page faults means that we have no
> hard guarantee that the event is enabled as requested upon return to the
> caller.
> 

Yeah, sorry, I misread your statement.

If the user registers an event and user_event_enabler_write() is invoked
at that point the enabler is registered and will update the event as it
changes, even though the initial write fails (it will try again
repeatedly until a terminal state of faulting is reached).

I agree though, if the initial data is faulted out at that point, and it
has an error faulting in, the user doesn't know that (although it
appears the only time this would fail is if someone did something silly,
malicous, or the device is out of memory). They likely want to know if
it's the silly/forgetful case.

> I'd like to add a completion there, to be waited for after
> user_event_enabler_queue_fault(), but before returning from
> user_event_enabler_create(). Waiting for the completion should be done
> without any mutexes held, so after releasing event_mutex.
> 
> The completion would be placed on the stack of user_event_enabler_create(),
> and a reference to the completion would be placed in the queued fault
> request. The completion notification would be emitted by the worker thread
> either when enabling is done, or if a page fault fails.
> 
> See include/linux/completion.h
> 
> Thoughts ?
> 

If the case you are worried about is just the initial register, then I
can do this synchronously outside of the lock. I believe you had the
same thought later in the day.

The main scenario I am worried about is that we have say 20 processes
that share the same event. They have already been registered and they
are running. Then a few of them have page faults when perf/ftrace
enable the event and the register callback is invoked (which triggers
a user write to the enablement address/bit). If most of these
processes don't page fault, I don't want them to wait on the account of
1 or 2 bad apples. If they all page fault, I don't want them to hold up
the other parts the system that require event_mutex (since it is held by
the register callback caller). So these should be as fast as possible
while the event_mutex is being held.

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > > Thoughts ?
> > > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > 
> > Thanks,
> > -Beau
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

Thanks,
-Beau
