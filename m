Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212B8696AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjBNRDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjBNRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:02:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949015564;
        Tue, 14 Feb 2023 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VylEd9RKlkdidbQurGJjXyPN4+dUPLNOHGIn/hG9/60=; b=j8Y4XiFaB881NqsW53U/ahJRnc
        jKeYPtWd4gKk1aCYvsbZiIRrUuyq8CJ4M1gSu2Yt8noqvjRHsfbXhhCVi6QxJAU7T6fpnNmUv9fUe
        Ug05oGe8ux9sihOcQ6aqDMKEifGs0s7arA6Q9wv6sWcFJy+v71MV5cuNuVNge57oSHQQPLJ6hyJtY
        6EwDkcEW2eHE56FHLpgVkNbjYXkDJYA5d3EriSJMiAY3ShAZgRmpE2jvcOmgDG8RxGcwHkNmz7k85
        xvx9ueWxYQDOJftIsuoLGvsJG42XqfysWkEs87Hry62rwPFy3SOfHC8YqV2Zh3AmdZ+BOMaiVNY+U
        ZUWIKxLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRygf-006fYd-Iz; Tue, 14 Feb 2023 17:01:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20E4D302E55;
        Tue, 14 Feb 2023 12:05:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AB802007E430; Tue, 14 Feb 2023 12:05:28 +0100 (CET)
Date:   Tue, 14 Feb 2023 12:05:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <Y+tq9/pUQL5bv/zC@hirez.programming.kicks-ass.net>
References: <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+qFc7Q2NfXERwYT@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+qFc7Q2NfXERwYT@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:46:11PM -0500, Kent Overstreet wrote:
> On Mon, Feb 13, 2023 at 10:24:13AM +0100, Peter Zijlstra wrote:
> > On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > > Provided it acquires the parent device's lock first, this is 
> > > utterly safe no matter what order the children are locked in.  Try 
> > > telling that to lockdep! 
> > 
> > mutex_lock_next_lock(child->lock, parent->lock) is there to express this
> > exact pattern, it allows taking multiple child->lock class locks (in any
> > order) provided parent->lock is held.
> 
> Perhaps I'm stupid, but I've never understood how subclasses - or this -
> are supposed to work.
> 
> Locks don't get a fixed subclass, so what's to prevent some code from
> going

So there's two annotations here, the nest_lock thing and subclasses,
they're distinct things.

Every class gets a fixed 8 subclasses (0-7) given by the unique byte
addresses inside the actual key object.

Subclasses will let you create nesting order of the same class that are
acceptable. Typically lock/1 nests inside lock/0, but that's not
hard-coded, simply convention.

The way it is used is given an external lock order, say the CPU number
for the runqueue locks, you do things like:

void double_rq_lock(struct rq *rq1, struct rq *r2)
{
	lockdep_assert_irqs_disabled();

	if (rq_order_less(r2, rq1))
		swap(rq1, rq2);

	raw_spin_rq_lock(rq1);
	if (__rq_lockp(rq1) != __rq_lock(rq2))
		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);

	...
}

(which is more complicated than it needs to be due to the whole
core-scheduling mess, but should still be readable I suppose).

Basically we make sure rq1 and rq2 are in the correct order and acquire
them with subclass 0 (the default) and subcless 1 (SINGLE_DEPTH_NESTING)
resp. dictating the subclass order.

This is lock order per decree, if you get the order function wrong
lockdep will not see the inversion but you *will* deadlock.


Then there's that nesting lock, that requires two classes and at least 3
locks to make sense:

  P, C1, C2

Where we posit that any multi-lock of Cn is fully serialized by P and it
is used like:

	mutex_lock(P);
	mutex_lock_nest_lock(C1, P);
	mutex_lock_nest_lock(C2, P);

Where any order of Cn is acceptable, because fully ordered by P.

If you were to combine this with subclass on Cn to allow multi-lock
instances not order by P, you get to keep the pieces :-)



