Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB36939CB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBLUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:19:18 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 12EB1BB83
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:19:16 -0800 (PST)
Received: (qmail 886235 invoked by uid 1000); 12 Feb 2023 15:19:16 -0500
Date:   Sun, 12 Feb 2023 15:19:16 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
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
Message-ID: <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
References: <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+k6ehYLWa0cmbvb@moria.home.lan>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 02:14:02PM -0500, Kent Overstreet wrote:
> On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > On Sat, Feb 11, 2023 at 10:10:23PM -0500, Kent Overstreet wrote:
> > > So IMO the more correct way to do this would be to change
> > > device_initialize() to __device_initialize(), have it take a
> > > lock_class_key as a parameter, and then use __mutex_init() instead of
> > > mutex_init().
> > 
> > Yes, maybe.  The increase in code size might outweigh the space saved.
> 
> Where would the increase in code size come from?

Maybe I didn't understand your suggestion.  Did you mean that all 
callers of device_initialize() (or whatever) should be able to specify 
their own lock_class_key?  Or were you just trying to avoid the single 
static allocation of a lock_class_key in device_initialize() done as a 
side-effect of the mutex_init() call?

> And whatever effect
> would only be when lockdep is enabled, so not a concern.

Not if a new function is created (i.e., __device_initialize()).

> But consider that the name of a lock as registered with lockdep really
> should correspond to a source code location - i.e. it should be
> something you can grep for. (We should probably consider adding file and
> line number to that string, since current names are not unambiguous).
> 
> Whereas in your pass, you're calling lockdep_set_class(), which
> generates a class name via stringifcation - with the same name every
> time.
> 
> Definitely _don't_ do that. With your patch, the generated lockdep
> traces will be useless.

I'll revise the patch to use the device's name for the class.  While it 
may not be globally unique, it should be sufficiently specific.

(Device names are often set after the device is initialized.  Does 
lockdep mind if a lock_class_key's name is changed after it has been 
registered?)

> > > But let's think about this more. Will there ever be situations where
> > > lock ordering is dependent on what hardware is plugged into what, or
> > > what hardware is plugged in first?
> > 
> > Device lock ordering is always dependent on what hardware is plugged 
> > into what.  However, I'm not aware of any situations where, given two 
> > different kinds of hardware, either one could be plugged into the other.
> > Such things may exist but I can't think of any examples.
> 
> Different brands of hubs?

As far as the kernel is concerned they wouldn't be _different kinds_ of 
hardware; they would both be hubs.

> Lots of things have hubs embedded into them these days. 15 years ago I
> had an Apple keyboard with an embedded hub.

Apple keyboards get treated as two logically separate pieces of 
hardware: a hub and a keyboard.  The fact that they are packaged as a 
single unit is irrelevant.

> > On the other hand, there are obvious cases where two pieces of the 
> > _same_ kind of hardware can be plugged together in either order.  USB 
> > hubs are a good example.
> > 
> > Consider the possibility that a driver might want to lock all of a 
> > device's children at once.  (I don't know if this ever happens, but it 
> > might.)  Provided it acquires the parent device's lock first, this is 
> > utterly safe no matter what order the children are locked in.  Try 
> > telling that to lockdep!  In the end, we'd probably have to enforce a 
> > single fixed ordering.
> 
> The way you speak of hypotheticals and possibilities makes me think that
> the actual locking rules are not ironed out at all :)

You're right.  There are no explicitly documented rules for device 
locking as far as I'm aware.  Each subsystem handles its own locking 
independently (but self-consistently, we hope).  That's one of the 
reasons that creating lockdep rules for devices is so difficult.

The business about not locking a parent if you already own the child's 
lock is perhaps the only universal -- and I don't know that it's written 
down anywhere.

> The patch I posted would be an improvement over the current situation,
> because it'd get you checking w.r.t. other lock types - but with that
> you would still have to have your own deadlock avoidance strategy, and
> you'd have to be _really_ clear on what it is and how you know that
> you're getting it right - you're still opting out of checking.

Same with the patch I posted, except that it opts back into checking.

> I think you should really be investigating wait/wound mutexes here.

At this stage, converting would be most impractical.  And I don't think 
it's really needed.

Alan Stern
