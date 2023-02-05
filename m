Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F368B104
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBEQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBEQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:46:12 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 51C5D13D50
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 08:46:06 -0800 (PST)
Received: (qmail 627686 invoked by uid 1000); 5 Feb 2023 11:46:06 -0500
Date:   Sun, 5 Feb 2023 11:46:06 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y9/dTp/hQ5btWTEH@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <c7fb01a9-3e12-77ed-5c4c-db7deb64dc73@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fb01a9-3e12-77ed-5c4c-db7deb64dc73@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 10:31:56AM +0900, Tetsuo Handa wrote:
> On 2023/02/05 5:01, Alan Stern wrote:
> > On Sun, Feb 05, 2023 at 02:09:40AM +0900, Tetsuo Handa wrote:
> >> That is a declaration that driver developers are allowed to take it for granted
> >> that driver callback functions can behave as if dev->mutex is not held. 
> > 
> > No it isn't.  It is a declaration that driver developers must be extra 
> > careful because lockdep is unable to detect locking errors involving 
> > dev->mutex.
> 
> Driver developers are not always familiar with locks used by driver core,
> like your
> 
>   It's hard to figure out what's wrong from looking at the syzbot report.
>   What makes you think it is connected with dev->mutex?

You didn't answer this question.

>   At first glance, it seems that the ath6kl driver is trying to flush a
>   workqueue while holding a lock or mutex that is needed by one of the
>   jobs in the workqueue.  That's obviously never going to work, no matter
>   what sort of lockdep validation gets used.
> 
> comment indicates that you did not notice that dev->mutex was connected to
> this problem which involved ath6kl driver code and ath9k driver code and
> driver core code.

Of course I didn't.  There isn't enough information in the syzbot log 
for someone to recognize the connection if they aren't already familiar 
with the code in question.

> Core developers can't assume that driver developers are extra careful, as
> well as driver developers can't assume that core developers are familiar
> with locks used by individual drivers. We need to fill the gap.

Agreed.

> >> Some developers test their changes with lockdep enabled, and believe that their
> >> changes are correct because lockdep did not complain.
> >> https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174 is an example.
> > 
> > How do you know developers are making this mistake?  That example 
> > doesn't show anything of the sort; the commit which introduced the bug 
> > says nothing about lockdep.
> 
> The commit which introduced the bug cannot say something about lockdep, for
> lockdep validation is disabled and nobody noticed the possibility of deadlock
> until syzbot reports it as hung. Since the possibility of deadlock cannot be
> noticed until syzbot reports it as hung,

That isn't true at all.  There are lots of occasions when people realize 
that a deadlock might occur without seeing a report from lockdep or 
syzbot.  You just aren't aware of these occasions because the developer 
then fixes the code before submitting it.  But if you search through the 
mailing list archives, I'm sure you'll find plenty of examples where 
somebody criticizes a proposed patch on the grounds that it can cause a 
deadlock.

>  I assume that there are many similar
> deadlocks in the kernel that involves dev->mutex. How do you teach developers
> that they are making this mistake, without keeping lockdep validation enabled?

There probably are many similar deadlocks in the kernel.  There probably 
also are deadlocks (not involving dev->mutex) which lockdep could catch, 
but hasn't because the right combination of conditions hasn't occurred.

You teach developers about this the same way you teach them about 
anything else: Publishing information, talking to people, and putting 
comments in the kernel source code.

> By keeping lockdep validation disabled, you are declaring that driver developers
> need not to worry about dev->mutex rather than declaring that driver developers
> need to worry about dev->mutex.

That is a very peculiar thing to say.  How do you think people managed 
to deal with deadlocks in the kernel before lockdep was developed?  Do 
you think they said: "My testing didn't reveal any deadlocks, so the 
code must be perfect"?

Of course they didn't.  And now people simply need to realize that 
lockdep isn't perfect either.

And by the way, by disabling lockdep validation I am declaraing that 
enabling it would cause an overwhelming number of false positives, 
rendering lockdep useless (as you found out when you tried).  Not that 
driver developers don't have to worry about dev->mutex.

Alan Stern
