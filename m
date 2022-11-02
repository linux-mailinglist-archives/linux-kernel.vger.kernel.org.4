Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C53616A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKBRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:18:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2487D18382;
        Wed,  2 Nov 2022 10:18:17 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id E93AC20C28B1;
        Wed,  2 Nov 2022 10:18:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E93AC20C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667409496;
        bh=PijDPxC99EGe4UfAODPhh1O0gXNCRVakwzvHbnK/s2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKKMnV8PE86oIcyuLYPtV4rwN8IL9wgzRNcGrCCJVS0axmNSGlu3QoelJj4xQRn6N
         fu/+qh6eybHLEV0I3WOL+byedunFcoCQuwOxhURW3lzPxr00Vi16FQb+OT/PZ2SoYP
         OgrN921e/ssk14OcShO7sT4hbDM4gsWLGuELSzsk=
Date:   Wed, 2 Nov 2022 10:18:09 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Message-ID: <20221102171809.GA69@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <96d9f066-2f39-78e6-9be7-f9c69235615e@efficios.com>
 <20221028221728.GA162@W11-BEAU-MD.localdomain>
 <01d10e59-0ea6-e60f-8561-84aa5dee40d3@efficios.com>
 <20221031165314.GA129@W11-BEAU-MD.localdomain>
 <3ff4d759-307e-31a2-4124-98de9e423d7e@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff4d759-307e-31a2-4124-98de9e423d7e@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:46:31AM -0400, Mathieu Desnoyers wrote:
> On 2022-10-31 12:53, Beau Belgrave wrote:
> > On Sat, Oct 29, 2022 at 09:58:26AM -0400, Mathieu Desnoyers wrote:
> > > On 2022-10-28 18:17, Beau Belgrave wrote:
> > > > On Fri, Oct 28, 2022 at 05:50:04PM -0400, Mathieu Desnoyers wrote:
> > > > > On 2022-10-27 18:40, Beau Belgrave wrote:
> > > 
> > > [...]
> > > > 
> > > > > > 
> > > > > > NOTE:
> > > > > > User programs that wish to have the enable bit shared across forks
> > > > > > either need to use a MAP_SHARED allocated address or register a new
> > > > > > address and file descriptor. If MAP_SHARED cannot be used or new
> > > > > > registrations cannot be done, then it's allowable to use MAP_PRIVATE
> > > > > > as long as the forked children never update the page themselves. Once
> > > > > > the page has been updated, the page from the parent will be copied over
> > > > > > to the child. This new copy-on-write page will not receive updates from
> > > > > > the kernel until another registration has been performed with this new
> > > > > > address.
> > > > > 
> > > > > This seems rather odd. I would expect that if a parent process registers
> > > > > some instrumentation using private mappings for enabled state through the
> > > > > user events ioctl, and then forks, the child process would seamlessly be
> > > > > traced by the user events ABI while being able to also change the enabled
> > > > > state from the userspace tracer libraries (which would trigger COW).
> > > > > Requiring the child to re-register to user events is rather odd.
> > > > > 
> > > > 
> > > > It's the COW that is the problem, see below.
> > > > 
> > > > > What is preventing us from tracing the child without re-registration in this
> > > > > scenario ?
> > > > > 
> > > > 
> > > > Largely knowing when the COW occurs on a specific page. We don't make
> > > > the mappings, so I'm unsure if we can ask to be notified easily during
> > > > these times or not. If we could, that would solve this. I'm glad you are
> > > > thinking about this. The note here was exactly to trigger this
> > > > discussion :)
> > > > 
> > > > I believe this is the same as a Futex, I'll take another look at that
> > > > code to see if they've come up with anything regarding this.
> > > > 
> > > > Any ideas?
> > > 
> > > Based on your description of the symptoms, AFAIU, upon registration of a
> > > given user event associated with a mm_struct, the user events ioctl appears
> > > to translates the virtual address into a page pointer immediately, and keeps
> > > track of that page afterwards. This means it loses track of the page when
> > > COW occurs.
> > > 
> > 
> > No, we keep the memory descriptor and virtual address so we can properly
> > resolve to page per-process.
> > 
> > > Why not keep track of the registered virtual address and struct_mm
> > > associated with the event rather than the page ? Whenever a state change is
> > > needed, the virtual-address-to-page translation will be performed again. If
> > > it follows a COW, it will get the new copied page. If it happens that no COW
> > > was done, it should map to the original page. If the mapping is shared, the
> > > kernel would update that shared page. If the mapping is private, then the
> > > kernel would COW the page before updating it.
> > > 
> > > Thoughts ?
> > > 
> > 
> > I think you are forgetting about page table entries. My understanding is
> > the process will have the VMAs copied on fork, but the page table
> > entries will be marked read-only. Then when the write access occurs, the
> > COW is created (since the PTE says readonly, but the VMA says writable).
> > However, that COW page is now only mapped within that forked process
> > page table.
> > 
> > This requires tracking the child memory descriptors in addition to the
> > parent. The most straightforward way I see this happening is requiring
> > user side to mmap the user_event_data fd that is used for write. This
> > way when fork occurs in dup_mm() / dup_mmap() that mmap'd
> > user_event_data will get open() / close() called per-fork. I could then
> > copy the enablers from the parent but with the child's memory descriptor
> > to allow proper lookup.
> > 
> > This is like fork before COW, it's a bummer I cannot see a way to do
> > this per-page. Doing the above would work, but it requires copying all
> > the enablers, not just the one that changed after the fork.
> 
> This brings an overall design concern I have with user-events: AFAIU, the
> lifetime of the user event registration appears to be linked to the lifetime
> of a file descriptor.
> 

The lifetime of the user_event is linked to the lifetime of the
tracepoint. The tracepoint stays alive until someone explicitly
tries to delete it via the del IOCTL.

If the delete is attempted and there are references out to that
user_event, either via perf/ftrace or any open files or mm_stucts it
will not be allowed to go away.

The user_event does not go away automatically upon file release (last
close). However, when that file goes away, obviously the caller no
longer can write to it. This is why there are user_events within the
group, and then there are per-file user_event_refs. It allows for
tracking these lifetimes and writes in isolation.

> What happens when that file descriptor is duplicated and send over to
> another process through unix sockets credentials ? Does it mean that the
> kernel have a handle on the wrong process to update the "enabled" state?
> 

You'll have to expand upon this more, if the FD is duplicated and
installed into another process, then the "enabled" state is still at
whatever mm_struct registered it. If that new process wants to have an
enabled state, it must register in it's own process if it wasn't from a
fork. The mm_struct can only change pages in that process, it cannot
jump across to another process. This is why the fork case needs an
enabler clone with a new mm_struct, and why if it gets duplicated in an
odd way into another process, that process must register it's own
enabler states.

> Also, what happens on execve system call if the file descriptor representing
> the user event is not marked as close-on-exec ? Does it mean the kernel can
> corrupt user-space memory of the after-exec loaded binary when it attempts
> to update the "enabled" state ?
> 

I believe it could if the memory descriptor remains, callers should
mark it close-on-exec to prevent this. None of this was a problem
with the old ABI :)

For clarity, since I cannot tell:
Are you advocating for a different approach here or just calling out
we need to add guidance to user space programs to do the right thing?

> If I get this right, I suspect we might want to move the lifetime of the
> user event registration to the memory space (mm_struct).
> 

If that file or mmap I proposed stays open, the enablers will stay open.
The enabler keeps the mm_struct alive, not the other way around.

I'm not sure I follow under what condition you'd have an enabler /
user_event around with a mm_struct that has gone away. The enabler keeps
the mm_struct alive until the enabler goes away to prevent any funny
business. That appears to fit more inline with what others have done in
the kernel than trying to tie the enabler to the mm_struct lifetime.

If a memory descriptor goes away, then it's FD's should close (Is there
ever a case this is not true?). If the FD's go away, the enablers close
down, if the enablers close down, the user_event ref's drop to 0. The
user_event can then be deleted via an explicit IOCTL, and will only work
if at that point in time the ref count is still 0.

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

Thanks,
-Beau
