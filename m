Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94468DF33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjBGRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjBGRqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:46:34 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4E90572B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:46:33 -0800 (PST)
Received: (qmail 703452 invoked by uid 1000); 7 Feb 2023 12:46:32 -0500
Date:   Tue, 7 Feb 2023 12:46:32 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
References: <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:07:18PM +0900, Tetsuo Handa wrote:
> On 2023/02/07 0:45, Alan Stern wrote:
> > On Mon, Feb 06, 2023 at 11:13:38PM +0900, Tetsuo Handa wrote:
> >> On 2023/02/05 10:23, Alan Stern wrote:
> >>> I suppose we could create separate lockdep classes for every bus_type 
> >>> and device_type combination, as well as for the different sorts of 
> >>> devices -- treat things like class devices separately from normal 
> >>> devices, and so on.  But even then there would be trouble.
> >>
> >> Sorry, since I'm not familiar with devices, I can't interpret what you
> >> are talking about in this response. But why don't you try test5() approach
> >> in an example module shown below (i.e. treat all dev->mutex instances
> >> independent to each other) ?
> >>
> >> Sharing mutex_init() (like test2() approach) causes false positives,
> >> but allocating a key on each dev->mutex (like test5() approach) should
> >> avoid false positives.
> > 
> > Interesting idea.  I'm doubtful that it will accomplish all that you 
> > want.  After all, one of lockdep's biggest advantages is that it can 
> > detect the potential for deadlocks without a deadlock actually 
> > occurring.  By putting each mutex into its own class, you lose much of 
> > this ability.
> > 
> > But who knows?  Maybe it will be a big help.
> > 
> > Anyway, below is a patch you can try, based on the code for your test5.  
> > Let me know what happens.
> > 
> 
> It boots, except lockdep_register_key() hit WARN_ON_ONCE() at
> device_register(&platform_bus) from platform_bus_init(), for
> platform_bus is a static object.
> 
>   struct device platform_bus = {
>   	.init_name	= "platform",
>   };
> 
> We need to skip lockdep_register_key()/lockdep_unregister_key() on
> static "struct device" instances...

Okay, no doubt you can modify the patch to handle that.

The real question is what will happen in your syzbot test scenarios.  
Lockdep certainly ought to be able to detect a real deadlock when one 
occurs.  It will be more interesting to find out if it can warn about 
potential deadlocks _without_ them occurring.

Alan Stern
