Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB569399A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBLTOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBLTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:14:13 -0500
Received: from out-125.mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE1C14C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:14:12 -0800 (PST)
Date:   Sun, 12 Feb 2023 14:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676229249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/L2y4IO6AN8Kk5g+/yl0ATcvx7ZyrTaXQL3/EkoOOEc=;
        b=EsU4aVD8ayzq7Cdx9LxP921m0BZGCGTb2CY+HYt9kdv/i+7O198EaSzU0SbztuCylq0mQz
        roOtyaEROrKF/2J9uLNGWjDTBbTG844i6XYda1kSIv8k8n02IBBo5szI1gEb6jhV9xZ7QZ
        C2c8AVsT6PaPAFvPqwfjer9krg6njls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+k6ehYLWa0cmbvb@moria.home.lan>
References: <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> On Sat, Feb 11, 2023 at 10:10:23PM -0500, Kent Overstreet wrote:
> > So IMO the more correct way to do this would be to change
> > device_initialize() to __device_initialize(), have it take a
> > lock_class_key as a parameter, and then use __mutex_init() instead of
> > mutex_init().
> 
> Yes, maybe.  The increase in code size might outweigh the space saved.

Where would the increase in code size come from? And whatever effect
would only be when lockdep is enabled, so not a concern.

But consider that the name of a lock as registered with lockdep really
should correspond to a source code location - i.e. it should be
something you can grep for. (We should probably consider adding file and
line number to that string, since current names are not unambiguous).

Whereas in your pass, you're calling lockdep_set_class(), which
generates a class name via stringifcation - with the same name every
time.

Definitely _don't_ do that. With your patch, the generated lockdep
traces will be useless.

> > But let's think about this more. Will there ever be situations where
> > lock ordering is dependent on what hardware is plugged into what, or
> > what hardware is plugged in first?
> 
> Device lock ordering is always dependent on what hardware is plugged 
> into what.  However, I'm not aware of any situations where, given two 
> different kinds of hardware, either one could be plugged into the other.
> Such things may exist but I can't think of any examples.

Different brands of hubs?

Lots of things have hubs embedded into them these days. 15 years ago I
had an Apple keyboard with an embedded hub.

> On the other hand, there are obvious cases where two pieces of the 
> _same_ kind of hardware can be plugged together in either order.  USB 
> hubs are a good example.
> 
> Consider the possibility that a driver might want to lock all of a 
> device's children at once.  (I don't know if this ever happens, but it 
> might.)  Provided it acquires the parent device's lock first, this is 
> utterly safe no matter what order the children are locked in.  Try 
> telling that to lockdep!  In the end, we'd probably have to enforce a 
> single fixed ordering.

The way you speak of hypotheticals and possibilities makes me think that
the actual locking rules are not ironed out at all :)

The patch I posted would be an improvement over the current situation,
because it'd get you checking w.r.t. other lock types - but with that
you would still have to have your own deadlock avoidance strategy, and
you'd have to be _really_ clear on what it is and how you know that
you're getting it right - you're still opting out of checking.

I think you should really be investigating wait/wound mutexes here.
