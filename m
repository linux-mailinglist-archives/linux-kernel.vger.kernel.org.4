Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF4D613C08
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiJaRSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiJaRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:18:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F7F1FAF1;
        Mon, 31 Oct 2022 10:18:40 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id DE0D120B9F80;
        Mon, 31 Oct 2022 10:18:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE0D120B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667236720;
        bh=wpXtJJZ2oedHqRb8gLEeF+oUhEMWxbEDuVORpohKvfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO6VHlayvkoucntu6yrjigDgLlrqOzrelqI1vq+128nzUtOs6EIpMTYZA0KhAaivW
         PG/6ip437Pjoo/c4RPTdkY4iMsbXYjaO/vzvW8TyxePXGNCiy1WpKynmSR/UnacbsQ
         pxI5BfUoSoXSJa9kS6AhJIA8C0t2N4kTChir8S/A=
Date:   Mon, 31 Oct 2022 10:18:20 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Message-ID: <20221031171820.GA175@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-3-beaub@linux.microsoft.com>
 <a18e940d-8423-0294-23b4-f2702313f3eb@efficios.com>
 <20221028224256.GA202@W11-BEAU-MD.localdomain>
 <f66cdb16-8a3b-35c1-9c24-c32c5c7b19fb@efficios.com>
 <d955ff39-8823-d80f-e60f-9aafecc5708c@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d955ff39-8823-d80f-e60f-9aafecc5708c@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 07:45:33AM -0400, Mathieu Desnoyers wrote:
> On 2022-10-29 10:40, Mathieu Desnoyers wrote:
> > On 2022-10-28 18:42, Beau Belgrave wrote:
> > > On Fri, Oct 28, 2022 at 06:19:10PM -0400, Mathieu Desnoyers wrote:
> > > > On 2022-10-27 18:40, Beau Belgrave wrote:
> > > > > When events are enabled within the various tracing facilities, such as
> > > > > ftrace/perf, the event_mutex is held. As events are enabled pages are
> > > > > accessed. We do not want page faults to occur under this lock. Instead
> > > > > queue the fault to a workqueue to be handled in a process context safe
> > > > > way without the lock.
> > > > > 
> > > > > The enable address is disabled while the async fault-in occurs. This
> > > > > ensures that we don't attempt fault-in more than is necessary. Once the
> > > > > page has been faulted in, the address write is attempted again. If the
> > > > > page couldn't fault-in, then we wait until the next time the event is
> > > > > enabled to prevent any potential infinite loops.
> > > > 
> > > > I'm also unclear about how the system call initiating the enabled state
> > > > change is delayed (or not) when a page fault is queued.
> > > > 
> > > 
> > > It's not, if needed we could call schedule_delayed_work(). However, I
> > > don't think we need it. When pin_user_pages_remote is invoked, it's with
> > > FOLL_NOFAULT. This will tell us if we need to fault pages in, we then
> > > call fixup_user_fault with unlocked value passed. This will cause the
> > > fixup to retry and get the page in.
> > > 
> > > It's called out in the comments for this exact purpose (lucked out
> > > here):
> > > mm/gup.c
> > >   * This is meant to be called in the specific scenario where for
> > > locking reasons
> > >   * we try to access user memory in atomic context (within a
> > > pagefault_disable()
> > >   * section), this returns -EFAULT, and we want to resolve the user
> > > fault before
> > >   * trying again.
> > > 
> > > The fault in happens in a workqueue, this is the same way KVM does it's
> > > async page fault logic, so it's not a new pattern. As soon as the
> > > fault-in is done, we have a page we should be able to use, so we
> > > re-attempt the write immediately. If the write fails, another queue
> > > happens and we could loop, but not like the unmap() case I replied with
> > > earlier.
> > > 
> > > > I would expect that when a page fault is needed, after enqueuing
> > > > work to the
> > > > worker thread, the system call initiating the state change would somehow
> > > > wait for a completion (after releasing the user events mutex). That
> > > > completion would be signaled by the worker thread either if the
> > > > page fault
> > > > fails, or if the state change is done.
> > > > 
> > > 
> > > I didn't see a generic fault-in + notify anywhere, do you know of one I
> > > could use? Otherwise, it seems the pattern used is check fault, fault-in
> > > via workqueue, re-attempt.
> > 
> > I don't think we're talking about the same thing. I'll try stating my
> > concern in a different way.
> > 
> > user_event_enabler_write() calls user_event_enabler_queue_fault() when
> > it cannot perform the enabled state update immediately (because a page
> > fault is needed).
> > 
> > But then AFAIU it returns immediately to the caller. The caller could
> > very well expect that the event has been enabled, as requested,
> > immediately when the enabler write returns. The fact that enabling the
> > event can be delayed for an arbitrary amount of time due to page faults
> > means that we have no hard guarantee that the event is enabled as
> > requested upon return to the caller.
> > 
> > I'd like to add a completion there, to be waited for after
> > user_event_enabler_queue_fault(), but before returning from
> > user_event_enabler_create(). Waiting for the completion should be done
> > without any mutexes held, so after releasing event_mutex.
> > 
> > The completion would be placed on the stack of
> > user_event_enabler_create(), and a reference to the completion would be
> > placed in the queued fault request. The completion notification would be
> > emitted by the worker thread either when enabling is done, or if a page
> > fault fails.
> > 
> > See include/linux/completion.h
> > 
> > Thoughts ?
> 
> Actually, after further thinking, I wonder if we need a worker thread at all
> to perform the page faults.
> 
> Could we simply handle the page faults from user_event_enabler_create() by
> releasing the mutex and re-trying ? From what contexts is
> user_event_enabler_create() called ? (any locks taken ? system call context
> ? irqs and preemption enabled or disabled ?)
> 

The create case is in process context, via the reg IOCTL on the
user_events_data file. The only lock is the register lock, the
event_mutex is taken within the user_event_enabler_create() call to ensure
the enabler can safely be added to the shared user_event within the
group.

Shouldn't be a problem running it synchronously again or reporting back
a fault happened and letting the user call decide what to do.

> Thanks,
> 
> Mathieu
> 

[..]

> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

Thanks,
-Beau
