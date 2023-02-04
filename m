Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBA68AC37
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjBDUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBDUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:01:46 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1FDF92686E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 12:01:45 -0800 (PST)
Received: (qmail 604113 invoked by uid 1000); 4 Feb 2023 15:01:44 -0500
Date:   Sat, 4 Feb 2023 15:01:44 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 02:09:40AM +0900, Tetsuo Handa wrote:
> On 2023/02/05 1:27, Alan Stern wrote:
> > On Sun, Feb 05, 2023 at 01:12:12AM +0900, Tetsuo Handa wrote:
> >> On 2023/02/05 0:34, Alan Stern wrote:
> >> Lockdep validation on dev->mutex being disabled is really annoying, and
> >> I want to make lockdep validation on dev->mutex enabled; that is the
> >> "drivers/core: Remove lockdep_set_novalidate_class() usage" patch.
> > 
> >> Even if it is always safe to acquire a child device's lock while holding
> >> the parent's lock, disabling lockdep checks completely on device's lock is
> >> not safe.
> > 
> > I understand the problem you want to solve, and I understand that it
> > can be frustrating.  However, I do not believe you will be able to
> > solve this problem.
> 
> That is a declaration that driver developers are allowed to take it for granted
> that driver callback functions can behave as if dev->mutex is not held. 

No it isn't.  It is a declaration that driver developers must be extra 
careful because lockdep is unable to detect locking errors involving 
dev->mutex.

> Some developers test their changes with lockdep enabled, and believe that their
> changes are correct because lockdep did not complain.
> https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174 is an example.

How do you know developers are making this mistake?  That example 
doesn't show anything of the sort; the commit which introduced the bug 
says nothing about lockdep.

> We should somehow update driver core code to make it possible to keep lockdep
> checks enabled on dev->mutex.

I'm sorry, but that simply is not feasible.  It doesn't matter how much 
you want to do it or feel it is needed; there is no reasonable way to do 
it.  To take just one example, what you are saying implies that when a 
driver is probed for a device, it would not be allowed to register a 
child device.  That's a ridiculous restriction.

(I might also mention that dev->mutex is used by drivers in places 
outside of the driver core.  So even if you did magically manage to fix 
the driver core, the problem would still remain.)

Alan Stern
