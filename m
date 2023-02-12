Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF8693A00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBLUvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBLUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:51:17 -0500
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043EF757
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:51:15 -0800 (PST)
Date:   Sun, 12 Feb 2023 15:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676235072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNfkbIa/T9NybrdKfgYpOraAwp+xX3TUEvNnbtMgabA=;
        b=nQuq/0AdnR3DerKpTIiaV1pRCkxBTGGlUZKYJpKa+9c3H2a8n/gfnDSUKI7Qc1qmdV4oXh
        fxGR9ITBtRsFjZEGOyCX+d+4TBIuwN7WIFKK7Q8li/NpaxgXZrzy3Yqhe9xgbmcMnCLali
        khE4bFgkO/ppKTSSOgUzNYmqW+1PleQ=
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
Message-ID: <Y+lROV3Ii+WbmZCh@moria.home.lan>
References: <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
 <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 03:19:16PM -0500, Alan Stern wrote:
> Maybe I didn't understand your suggestion.  Did you mean that all 
> callers of device_initialize() (or whatever) should be able to specify 
> their own lock_class_key?  Or were you just trying to avoid the single 
> static allocation of a lock_class_key in device_initialize() done as a 
> side-effect of the mutex_init() call?
> 
> > And whatever effect
> > would only be when lockdep is enabled, so not a concern.
> 
> Not if a new function is created (i.e., __device_initialize()).

Follow the same pattern as mutex_init() - have a look over that code.

> > But consider that the name of a lock as registered with lockdep really
> > should correspond to a source code location - i.e. it should be
> > something you can grep for. (We should probably consider adding file and
> > line number to that string, since current names are not unambiguous).
> > 
> > Whereas in your pass, you're calling lockdep_set_class(), which
> > generates a class name via stringifcation - with the same name every
> > time.
> > 
> > Definitely _don't_ do that. With your patch, the generated lockdep
> > traces will be useless.
> 
> I'll revise the patch to use the device's name for the class.  While it 
> may not be globally unique, it should be sufficiently specific.
> 
> (Device names are often set after the device is initialized.  Does 
> lockdep mind if a lock_class_key's name is changed after it has been 
> registered?)

The device name should _not_ be something dynamic, it should be
something easily tied back to a source code location - i.e. related to
the driver name, not the device name.

That's how people read and use lockdep reports!

Do it exactly the same way mutex_init() does it, just lift it up a level
to a wrapper around device_initialize() - stringify the pointer to the
mutex (embedded in struct device, embedded in what-have-you driver code)
and use that.

> You're right.  There are no explicitly documented rules for device 
> locking as far as I'm aware.  Each subsystem handles its own locking 
> independently (but self-consistently, we hope).  That's one of the 
> reasons that creating lockdep rules for devices is so difficult.
> 
> The business about not locking a parent if you already own the child's 
> lock is perhaps the only universal -- and I don't know that it's written 
> down anywhere.

Yeah that's sketchy; if the rules are too complicated to be written
down, they're too complicated.

One thing that could be contemplated is adding support for user-defined
comparison functions to lockdep, to define a lock ordering within a
class when subclass isn't sufficient.

That would work for bcache - for bcache the lock ordering is parent
nodes before children, and if multiple nodes are locked at the same
level they have to be locked in natural key order.

But, this would add a lot of complexity to lockdep, and this is the sort
of situation where if you have a bug in the comparison function (i.e. it
doesn't define a total ordering) it'll break things in terribly fun
ways.

> > The patch I posted would be an improvement over the current situation,
> > because it'd get you checking w.r.t. other lock types - but with that
> > you would still have to have your own deadlock avoidance strategy, and
> > you'd have to be _really_ clear on what it is and how you know that
> > you're getting it right - you're still opting out of checking.
> 
> Same with the patch I posted, except that it opts back into checking.
> 
> > I think you should really be investigating wait/wound mutexes here.
> 
> At this stage, converting would be most impractical.  And I don't think 
> it's really needed.

They do make you deal with lock restarts; unwinding typical stateful
kernel code is not necessarily super practical :)

Anyways, it sounds like the lockdep-class-per-driver approach will get
you more information, that's certainly a reasonable approach for now.

Cheers,
-Kent
