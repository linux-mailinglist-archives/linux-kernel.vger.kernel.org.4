Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998068AADA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjBDPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjBDPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:12:18 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id ADF9334C04
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:12:16 -0800 (PST)
Received: (qmail 597641 invoked by uid 1000); 4 Feb 2023 10:12:15 -0500
Date:   Sat, 4 Feb 2023 10:12:15 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y951z0Au9MlP1GxX@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 10:32:11PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> There is a long-standing deadlock problem in driver core code caused by
> "struct device"->mutex being marked as "do not apply lockdep checks".

What exactly is the deadlock problem?  Furthermore, how can skipping 
some lockdep checks _cause_ a problem?

> We can make this deadlock visible by applying [1], and we can confirm that
> there is a deadlock problem that I think needs to be addressed in core code [2].

I don't understand why you think there is a deadlock problem.  The splat 
in [2] says "WARNING: possible recursive locking detected".  This is 
only a warning; it doesn't mean there really is a problem.

> Also, since driver developers are taking it for granted that driver callback
> functions can behave as if dev->mutex is not held (because possibility of deadlock
> was never reported),

What?  I have no idea what developers you're talking about.  I have 
never heard of anyone taking this for granted.  Certainly developers 
working on the USB subsystem's core are well aware of dev->mutex 
locking.

>  it would solve many deadlocks in driver code if you can update

What deadlocks?  If there are so many deadlocks floating around in 
driver code, why haven't we heard about them before now?

> driver core code to avoid calling driver callback functions with dev->mutex held

We most definitely cannot do that.  The driver core relies on mutual 
exclusion.

> (by e.g. replacing dev->mutex with dev->spinlock and dev->atomic_flags).
> But I'm not familiar enough to propose such change...

Such a change cannot be made.  Consider this: Driver callbacks often
need to sleep.  But when a thread holds a spinlock, it is not allowed to 
sleep.  Therefore driver callbacks must not be invoked while a spinlock 
is held.

Besides, how will replacing a mutex with a spinlock prevent any deadlock 
problems?  If the new locks get held at the same time as the old mutexes 
were held, won't the same deadlocks occur?

Alan Stern

> [1] https://lkml.kernel.org/r/8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp
> [2] https://lkml.kernel.org/r/b7bc63c8-bb28-d21d-7c3f-97e4e79a9292@I-love.SAKURA.ne.jp
