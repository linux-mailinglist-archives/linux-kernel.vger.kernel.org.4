Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27FE696E43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBNUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBNUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:05:44 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D76EC5FC5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:05:42 -0800 (PST)
Received: (qmail 958461 invoked by uid 1000); 14 Feb 2023 15:05:42 -0500
Date:   Tue, 14 Feb 2023 15:05:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+vplu7H8k4OjlL5@rowland.harvard.edu>
References: <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+qFc7Q2NfXERwYT@moria.home.lan>
 <Y+tq9/pUQL5bv/zC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tq9/pUQL5bv/zC@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:05:27PM +0100, Peter Zijlstra wrote:
> Every class gets a fixed 8 subclasses (0-7) given by the unique byte
> addresses inside the actual key object.
> 
> Subclasses will let you create nesting order of the same class that are
> acceptable. Typically lock/1 nests inside lock/0, but that's not
> hard-coded, simply convention.

Can you explain in more detail how this works in the lockdep checking 
algorithm?  (For simplicity, let's leave out issues of interrupt status 
and other environmental things.)

I've been assuming that lockdep builds up a set of links between the 
classes -- namely, a link is created from A to B whenever a thread holds 
a lock of class A while acquiring a lock of class B.  The checking part 
would then amount to just making sure that these links don't form any 
cycles.

So then how do subclasses fit into the picture?  Is it just that now the 
links are between subclasses rather than classes, so it's not 
automatically wrong to hold a lock while acquiring another lock of the 
same class as long as the two acquisitions are in different subclasses?  
But you can still provoke a violation if there's a cycle among the 
subclasses?

> Then there's that nesting lock, that requires two classes and at least 3
> locks to make sense:
> 
>   P, C1, C2
> 
> Where we posit that any multi-lock of Cn is fully serialized by P

Assuming the speculations above are correct, how does the algorithm take 
lockdep nesting into account?  Does it simply avoid creating a link from 
subclass C to itself if both C1 and C2 were acquired while holding a 
lock of the parent subclass and both acquisitions were annotated with 
mutex_lock_next_lock()?  Or is there more to it than that?  (And should 
I have written class rather than subclass?)

And Kent, how does your proposed lockdep_set_no_check_recursion() work?  
Does it just prevent lockdep from creating a link between any two 
subclasses of the specified class?  Does it do anything more?

Alan
