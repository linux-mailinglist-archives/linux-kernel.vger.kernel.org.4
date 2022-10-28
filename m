Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDC611D54
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJ1WRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ1WRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:17:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D439249D2D;
        Fri, 28 Oct 2022 15:17:35 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 27D3420B929B;
        Fri, 28 Oct 2022 15:17:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27D3420B929B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666995455;
        bh=+pV23nWckVn/wTOHqMgILAsrEga2k7t0NAINVBKLQvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/HzSKmvDWuOorx9xaNrLRK0MO5cbHPveqqmKw167gbhdQvCsZAcxFiiWqPx4/r1n
         c0yu0xwIGctBQR2dg5FE6ShTpc1c9zMV6KGAsjOix+ijEoYlC8T23GbEOUGfdG7n/f
         kblL/lUo1wR/gKwdD8mHHTWJxXVXk/7EcfwTdhzc=
Date:   Fri, 28 Oct 2022 15:17:28 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Message-ID: <20221028221728.GA162@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <96d9f066-2f39-78e6-9be7-f9c69235615e@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d9f066-2f39-78e6-9be7-f9c69235615e@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:50:04PM -0400, Mathieu Desnoyers wrote:
> On 2022-10-27 18:40, Beau Belgrave wrote:
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
> Nice!
> 
> > 
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
> 
> I'll have a close look at this workqueue page fault scheme, probably next
> week.
> 

Excellent.

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
> 
> This seems rather odd. I would expect that if a parent process registers
> some instrumentation using private mappings for enabled state through the
> user events ioctl, and then forks, the child process would seamlessly be
> traced by the user events ABI while being able to also change the enabled
> state from the userspace tracer libraries (which would trigger COW).
> Requiring the child to re-register to user events is rather odd.
> 

It's the COW that is the problem, see below.

> What is preventing us from tracing the child without re-registration in this
> scenario ?
> 

Largely knowing when the COW occurs on a specific page. We don't make
the mappings, so I'm unsure if we can ask to be notified easily during
these times or not. If we could, that would solve this. I'm glad you are
thinking about this. The note here was exactly to trigger this
discussion :)

I believe this is the same as a Futex, I'll take another look at that
code to see if they've come up with anything regarding this.

Any ideas?

Thanks,
-Beau
