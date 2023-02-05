Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7D68ADEC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjBEBYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBEBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:24:01 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B47A71F5CA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:23:59 -0800 (PST)
Received: (qmail 609844 invoked by uid 1000); 4 Feb 2023 20:23:58 -0500
Date:   Sat, 4 Feb 2023 20:23:58 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 12:14:54PM -0800, Linus Torvalds wrote:
> On Sat, Feb 4, 2023 at 12:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > I'm sorry, but that simply is not feasible.  It doesn't matter how much
> > you want to do it or feel it is needed; there is no reasonable way to do
> > it.  To take just one example, what you are saying implies that when a
> > driver is probed for a device, it would not be allowed to register a
> > child device.  That's a ridiculous restriction.
> 
> Well, we've worked around that in other places by making the lockdep
> classes for different locks of the same type be different.
> 
> So this *could* possibly be solved by lockdep being smarter about
> dev->mutex than just "disable checking entirely".
> 
> So maybe the lock_set_novalidate_class() could be something better. It
> _is_ kind of disgusting.
> 
> That said, maybe people tried to subclass the locks and failed, and
> that "no validation" is the best that can be done.
> 
> But other areas *do* end up spending extra effort to separate out the
> locks (and the different uses of the locks), and I think the
> dev->mutex is one of the few cases that just gives up and says "no
> validation at all".
> 
> The other case seems to be the md bcache code.

I suppose we could create separate lockdep classes for every bus_type 
and device_type combination, as well as for the different sorts of 
devices -- treat things like class devices separately from normal 
devices, and so on.  But even then there would be trouble.

For example, consider PCI devices and PCI bridges (this sort of thing 
happens on other buses too).  I don't know the details of how the PCI 
subsystem works, but presumably when a bridge is probed, the driver then 
probes all the devices on the other side of the bridge while holding the 
bridge's lock.  Then if one of those devices is another bridge, the same 
thing happens recursively, and so on.  How would drivers cope with that?  
How deep will this nesting go?  I doubt that the driver core could take 
care of these issues all by itself.

I don't know if the following situation ever happens anywhere, but it 
could: Suppose a driver wants to lock several children of some device A.  
Providing it already holds A's lock, this is perfectly safe.  But how 
can we tell lockdep?  Even if A belongs to a different lockdep class 
from its children, the children would all be in the same class.

What happens when a driver wants to lock both a regular device and its 
corresponding class device?  Some drivers might acquire the locks in one 
order and some drivers in another.  Again it's safe, because separate 
drivers will never try to lock the same devices, but how do you tell 
lockdep about this?

No doubt there are other examples of potential problems.  Somebody could 
try to implement this kind of approach, but almost certainly it would 
lead to tons of false positives.

Alan Stern
