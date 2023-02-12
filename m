Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851796935A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 03:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBLClC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 21:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBLClB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 21:41:01 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 219951449E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 18:40:58 -0800 (PST)
Received: (qmail 864277 invoked by uid 1000); 11 Feb 2023 21:40:58 -0500
Date:   Sat, 11 Feb 2023 21:40:58 -0500
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
Message-ID: <Y+hRurRwm//1+IcK@rowland.harvard.edu>
References: <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+gjuqJ5RFxwLmht@moria.home.lan>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 06:24:42PM -0500, Kent Overstreet wrote:
> After scanning the rest of the thread: I don't think you want to create
> separate lockdep classes for each bus and device type, that's defeating
> how lockdep works.

Not at all.  In fact, exactly the opposite: lockdep works by creating a 
class for each lock-inside-a-data-structure-type combination.  A struct 
device-bus_type/device_type combination is pretty much the same kind of 
thing.

>  Maybe if it was only a small, _static_ number of new
> classes,

The collection of bus_types and device_types _is_ static, in the sense 
that each one is a structure defined in a driver source file.  Whether 
the number is "small" depends on your tolerance for large numbers; the 
kernel has a lot of source files.  :-)

Mind you, I'm not saying that having lockdep classes for each bus_type 
or device_type is always the right thing to do.  There definitely are 
cases where it wouldn't do what we want.  But perhaps in some cases it 
would work.

> but the basic premesis of lockdep is that there are static
> human understandable lock ordering rules, so lockdep figures out what
> they are and checks them: if you create a bunch of dynamic classes, the
> classes are going to be different for everyone in practice and won't
> have any real bearing on the structure of the code

As a rule, bus_type's and device_type's aren't dynamic.  Maybe Greg KH 
once published an example of such a thing; IIRC it was more like a 
proof-of-principle rather than a serious recommendation on how to write 
drivers.  (Or else I'm misremembering and it was actually an example of 
creating dynamic sysfs attributes.)

Or maybe you're referring to what this patch does?  It does indeed 
create a bunch of dynamic classes -- one for each struct device.  The 
ordering rules derived by lockdep will be somewhat arbitrary, as you 
say.  But some of them certainly will be related to the structure of the 
source code.

For instance, there's a rule that you must not acquire a device's lock 
if you're already holding the lock of one of its descendants, and this 
is related to how device discovery works (the driver for a device is 
responsible for discovering the device's children).  But that rule alone 
isn't enough to prevent deadlocks.

>  that is, given a
> lockdep splat, you won't be able to do anything with it.

Nonsense.  Even if you don't know what the locking rules are, given a 
splat you can see what the cycle is and try to figure out which of the 
links should be invalid.  Without the splat you'd be a lot worse off.

> If static lock ordering rules aren't working (say, because the lock
> ordering rules are determined by hardware relationships or what
> userspace is doing), then you have to do something more sophisticated.
> 
> Wait/wound mutexes would be the next thing to look at, and DRM ended up
> needing them for similar reasons as what you're running up against so I
> think they bear serious consideration.
> 
> ww mutexes are the simple version of dynamic deadlock avoidance -
> instead of doing full cycle detection they just compare transaction
> start times, so they come at the cost of more frequent aborts. If this
> is an issue for you, here's what full cycle detection looks like:
> 
> https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/btree_locking.c#n53

I'm not at all sure that w/w mutexes are the answer to device locking.  
Not to mention that converting over to use them would require a huge 
effort.

A typical kind of issue that seems to pop up a lot is a task trying to 
flush a work queue while holding a lock that's needed by one of the 
items on the queue.  (This isn't particularly limited to dev->mutex 
locks, of course.  It can crop up anywhere, but it seems to happen with 
some regularity in this setting.  Perhaps the fact that lockdep is 
unable to warn about these things is a contributing factor.  Can w/w 
mutexes can handle this sort of thing?  I'm not sufficiently familiar 
with them to know.)  Apparently people write this sort of code because 
they aren't aware of or don't pay attention to the context in which 
their functions run -- that is, the locks that have automatically been 
acquired by the callers.

Alan Stern
