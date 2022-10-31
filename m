Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4584613BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiJaQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiJaQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:53:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E28011155;
        Mon, 31 Oct 2022 09:53:37 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id A0F7320B929F;
        Mon, 31 Oct 2022 09:53:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0F7320B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667235216;
        bh=+glsQfGhk6eNgBZppwMjZpIflDHfxbcQBUZcP0HKr0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIY4641xDeLa+QUmIfFsMjRWpxJF8gmyNnfDOs9PwIMGMuG9aqMvr0sW/JB2+fMvJ
         kz1fg93ke+BGeunaY3SQykYf4pdcUVV0q5RPb8KdjKQk5ao7yf8dwBqdxaQnImaquZ
         9/ynVuHxw8z4tOuUlFi24Util0NlT9x3uSYlEhbI=
Date:   Mon, 31 Oct 2022 09:53:25 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Message-ID: <20221031165314.GA129@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <96d9f066-2f39-78e6-9be7-f9c69235615e@efficios.com>
 <20221028221728.GA162@W11-BEAU-MD.localdomain>
 <01d10e59-0ea6-e60f-8561-84aa5dee40d3@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d10e59-0ea6-e60f-8561-84aa5dee40d3@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 09:58:26AM -0400, Mathieu Desnoyers wrote:
> On 2022-10-28 18:17, Beau Belgrave wrote:
> > On Fri, Oct 28, 2022 at 05:50:04PM -0400, Mathieu Desnoyers wrote:
> > > On 2022-10-27 18:40, Beau Belgrave wrote:
> 
> [...]
> > 
> > > > 
> > > > NOTE:
> > > > User programs that wish to have the enable bit shared across forks
> > > > either need to use a MAP_SHARED allocated address or register a new
> > > > address and file descriptor. If MAP_SHARED cannot be used or new
> > > > registrations cannot be done, then it's allowable to use MAP_PRIVATE
> > > > as long as the forked children never update the page themselves. Once
> > > > the page has been updated, the page from the parent will be copied over
> > > > to the child. This new copy-on-write page will not receive updates from
> > > > the kernel until another registration has been performed with this new
> > > > address.
> > > 
> > > This seems rather odd. I would expect that if a parent process registers
> > > some instrumentation using private mappings for enabled state through the
> > > user events ioctl, and then forks, the child process would seamlessly be
> > > traced by the user events ABI while being able to also change the enabled
> > > state from the userspace tracer libraries (which would trigger COW).
> > > Requiring the child to re-register to user events is rather odd.
> > > 
> > 
> > It's the COW that is the problem, see below.
> > 
> > > What is preventing us from tracing the child without re-registration in this
> > > scenario ?
> > > 
> > 
> > Largely knowing when the COW occurs on a specific page. We don't make
> > the mappings, so I'm unsure if we can ask to be notified easily during
> > these times or not. If we could, that would solve this. I'm glad you are
> > thinking about this. The note here was exactly to trigger this
> > discussion :)
> > 
> > I believe this is the same as a Futex, I'll take another look at that
> > code to see if they've come up with anything regarding this.
> > 
> > Any ideas?
> 
> Based on your description of the symptoms, AFAIU, upon registration of a
> given user event associated with a mm_struct, the user events ioctl appears
> to translates the virtual address into a page pointer immediately, and keeps
> track of that page afterwards. This means it loses track of the page when
> COW occurs.
> 

No, we keep the memory descriptor and virtual address so we can properly
resolve to page per-process.

> Why not keep track of the registered virtual address and struct_mm
> associated with the event rather than the page ? Whenever a state change is
> needed, the virtual-address-to-page translation will be performed again. If
> it follows a COW, it will get the new copied page. If it happens that no COW
> was done, it should map to the original page. If the mapping is shared, the
> kernel would update that shared page. If the mapping is private, then the
> kernel would COW the page before updating it.
> 
> Thoughts ?
> 

I think you are forgetting about page table entries. My understanding is
the process will have the VMAs copied on fork, but the page table
entries will be marked read-only. Then when the write access occurs, the
COW is created (since the PTE says readonly, but the VMA says writable).
However, that COW page is now only mapped within that forked process
page table.

This requires tracking the child memory descriptors in addition to the
parent. The most straightforward way I see this happening is requiring
user side to mmap the user_event_data fd that is used for write. This
way when fork occurs in dup_mm() / dup_mmap() that mmap'd
user_event_data will get open() / close() called per-fork. I could then
copy the enablers from the parent but with the child's memory descriptor
to allow proper lookup.

This is like fork before COW, it's a bummer I cannot see a way to do
this per-page. Doing the above would work, but it requires copying all
the enablers, not just the one that changed after the fork.

> Thanks,
> 
> Mathieu
> 
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
