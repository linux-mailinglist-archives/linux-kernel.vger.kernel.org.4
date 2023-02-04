Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1568AAF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjBDPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjBDPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:34:58 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6A51D166EC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:34:50 -0800 (PST)
Received: (qmail 597950 invoked by uid 1000); 4 Feb 2023 10:34:49 -0500
Date:   Sat, 4 Feb 2023 10:34:49 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 11:21:27PM +0900, Tetsuo Handa wrote:
> On 2023/02/04 22:47, Greg Kroah-Hartman wrote:
> > On Sat, Feb 04, 2023 at 10:32:11PM +0900, Tetsuo Handa wrote:
> >> Hello.
> >>
> >> There is a long-standing deadlock problem in driver core code caused by
> >> "struct device"->mutex being marked as "do not apply lockdep checks".
> > 
> > The marking of a lock does not cause a deadlock problem, so what do you
> > mean exactly by this?  Where is the actual deadlock?
> 
> A few of examples:
> 
>   https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101

It's hard to figure out what's wrong from looking at the syzbot report.  
What makes you think it is connected with dev->mutex?

At first glance, it seems that the ath6kl driver is trying to flush a 
workqueue while holding a lock or mutex that is needed by one of the 
jobs in the workqueue.  That's obviously never going to work, no matter 
what sort of lockdep validation gets used.

>   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
>   https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
> 
> > 
> >> We can make this deadlock visible by applying [1], and we can confirm that
> >> there is a deadlock problem that I think needs to be addressed in core code [2].
> > 
> > Any reason why you didn't cc: us on these patches?
> 
> We can't apply this "drivers/core: Remove lockdep_set_novalidate_class() usage" patch
> until we fix all lockdep warnings that happen during the boot stage; otherwise syzbot
> testing can't work which is more painful than applying this patch now.
> 
> Therefore, I locally tested this patch (in order not to be applied now). And I got
> a lockdep warning on the perf_event code. I got next lockdep warning on the driver core
> code when I tried a fix for the perf_event code suggested by Peter Zijlstra. Since Peter
> confirmed that this is a problem that led to commit 1704f47b50b5 ("lockdep: Add novalidate
> class for dev->mutex conversion"), this time I'm reporting this problem to you (so that
> you can propose a fix for the driver core code).

There is no fix.  This problem is inherent to the way that lockdep 
works.

Lockdep classifies locks into classes, and it reports a problem if there 
is a locking cycle (for example, if someone tries to acquire a lock in 
class B while holding a lock in class A, someone else tries to acquire a 
lock in class C while holding a lock in class B, and someone else tries 
to acquire a lock in class A while holding a lock in class C).

But this sort of approach doesn't work when you're dealing with a 
recursive locking structure such as the device tree.  Here all the 
dev->mutex locks belong to the same class, so lockdep thinks there's a 
problem whenever someone tries to lock a device while holding another 
device's lock.

However, it is always safe to acquire a child device's lock while 
holding the parent's lock.  Lockdep isn't aware of this because it 
doesn't understand the hierarchical device tree.  That's why lockdep 
checking has to be disabled for dev->mutex; if it weren't disabled then 
it would constantly report false positives.

Alan Stern
