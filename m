Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0D6979F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjBOKdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBOKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:33:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD1D186;
        Wed, 15 Feb 2023 02:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Eof4phdzg0sVPR1E2iDoi4OzJcyEI7Sur+1QspzK5I=; b=LCWAXdK1dYhry4jZhKLy6rQmC2
        OpJcSYakbeunDdt8HS/PCtBl5/MLLfRk7WUAfkVJK8m1S2neUNL9aJ6/MVgl4Y5I8kbK/VbZrirsa
        qMJJbFhnm89CrjdBkxVaR8eGhqG4qur01OodEvWNgh8DDnppYn/aPnZi5OeEaPbEVRAQwP23+m+PE
        X0NDeFUKO3U1dHxH6qK2bcG943vCDPXw501Frlu6nsRKbtAS5TT/JRABkNrEr214J9y267pmN15mM
        VpufD/jdSY1YTD5mMMcQJd0C1qY4G5zKVDPe2NzCCwtgAIg4l3sw6OZS1OExX5KiqNyEsLs4IqbQ/
        F2IHfd2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pSF5d-009uqX-0h;
        Wed, 15 Feb 2023 10:33:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67FBF3001E7;
        Wed, 15 Feb 2023 11:33:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4407B23884781; Wed, 15 Feb 2023 11:33:20 +0100 (CET)
Date:   Wed, 15 Feb 2023 11:33:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <Y+y08ObKvxqRrAsA@hirez.programming.kicks-ass.net>
References: <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+qFc7Q2NfXERwYT@moria.home.lan>
 <Y+tq9/pUQL5bv/zC@hirez.programming.kicks-ass.net>
 <Y+vplu7H8k4OjlL5@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+vplu7H8k4OjlL5@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:05:42PM -0500, Alan Stern wrote:
> On Tue, Feb 14, 2023 at 12:05:27PM +0100, Peter Zijlstra wrote:
> > Every class gets a fixed 8 subclasses (0-7) given by the unique byte
> > addresses inside the actual key object.
> > 
> > Subclasses will let you create nesting order of the same class that are
> > acceptable. Typically lock/1 nests inside lock/0, but that's not
> > hard-coded, simply convention.
> 
> Can you explain in more detail how this works in the lockdep checking 
> algorithm?  (For simplicity, let's leave out issues of interrupt status 
> and other environmental things.)
> 
> I've been assuming that lockdep builds up a set of links between the 
> classes -- namely, a link is created from A to B whenever a thread holds 
> a lock of class A while acquiring a lock of class B.  The checking part 
> would then amount to just making sure that these links don't form any 
> cycles.
> 
> So then how do subclasses fit into the picture?  Is it just that now the 
> links are between subclasses rather than classes, so it's not 
> automatically wrong to hold a lock while acquiring another lock of the 
> same class as long as the two acquisitions are in different subclasses?  
> But you can still provoke a violation if there's a cycle among the 
> subclasses?

For all intents and purposes the subclasses are fully distinct classes
from the validation pov.

	mutex_lock(L);
	mutex_lock_nested(L, 0);

are equivalent (ignoring lockdep_set_subclass()), and

	mutex_lock_nested(L, 1);

is a distinct class, validation wise. So if you write:

	mutex_lock(L1);
	mutex_lock_nested(L2, 1);

you explicitly create a lock order between the distinct validation
classes: L/0,  L/1

> > Then there's that nesting lock, that requires two classes and at least 3
> > locks to make sense:
> > 
> >   P, C1, C2
> > 
> > Where we posit that any multi-lock of Cn is fully serialized by P
> 
> Assuming the speculations above are correct, how does the algorithm take 
> lockdep nesting into account?  Does it simply avoid creating a link from 
> subclass C to itself if both C1 and C2 were acquired while holding a 
> lock of the parent subclass and both acquisitions were annotated with 
> mutex_lock_next_lock()?

Basically this; it will explicitly ignore the nesting.

Given:

	mutex_lock(P);
	mutex_lock_nest_lock(C1, P);
	mutex_lock_nest_lock(C2, P);

mutex_lock_nest_lock() basically does:

 - validate that the instance of P is actually held.
   (as such, mutex_lock_nest_lock(C1, P1); mutex_lock_nest_lock(C2, P2);
   will cause objections).

 - either:

   * establish P->C in the held-lock stack
     and update the graph if so required

   * find the existing C in the held-lock stack
     and instead of complaining about class recursion, increment a
     refcount, and leave the held-stack and thus the graph unmodified.

subsequent mutex_unlock() will decrement the refcount and only when 0
'pop' the actual entry from the held stack.


