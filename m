Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD96935AD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 03:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBLCqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 21:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLCqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 21:46:50 -0500
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14C35B0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 18:46:48 -0800 (PST)
Date:   Sat, 11 Feb 2023 21:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676170006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqdhYtgkVAcGkIQ75yHgZna184M943pqypxQSlc3u3c=;
        b=XknR+0K+coEIwVeXcrhh0eZg0HLSZJdxRyUKU5UxCe0ta+xPocW6dZCKJRXEw2ClF/0urg
        6TrmWH3Kelt93Fa8yINib9+M3h21xkBhCh8y/EzZOkKPPzewXl5SBO1owz72so0lsljN4b
        JMne/CtF0iyNhDX3Zaq/mU0NhmmxWXQ=
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
Message-ID: <Y+hTEtCKPuO0zGIt@moria.home.lan>
References: <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+hRurRwm//1+IcK@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 09:40:58PM -0500, Alan Stern wrote:
> On Sat, Feb 11, 2023 at 06:24:42PM -0500, Kent Overstreet wrote:
> > After scanning the rest of the thread: I don't think you want to create
> > separate lockdep classes for each bus and device type, that's defeating
> > how lockdep works.
> 
> Not at all.  In fact, exactly the opposite: lockdep works by creating a 
> class for each lock-inside-a-data-structure-type combination.  A struct 
> device-bus_type/device_type combination is pretty much the same kind of 
> thing.
> 
> >  Maybe if it was only a small, _static_ number of new
> > classes,
> 
> The collection of bus_types and device_types _is_ static, in the sense 
> that each one is a structure defined in a driver source file.  Whether 
> the number is "small" depends on your tolerance for large numbers; the 
> kernel has a lot of source files.  :-)
> 
> Mind you, I'm not saying that having lockdep classes for each bus_type 
> or device_type is always the right thing to do.  There definitely are 
> cases where it wouldn't do what we want.  But perhaps in some cases it 
> would work.
> 
> > but the basic premesis of lockdep is that there are static
> > human understandable lock ordering rules, so lockdep figures out what
> > they are and checks them: if you create a bunch of dynamic classes, the
> > classes are going to be different for everyone in practice and won't
> > have any real bearing on the structure of the code
> 
> As a rule, bus_type's and device_type's aren't dynamic.  Maybe Greg KH 
> once published an example of such a thing; IIRC it was more like a 
> proof-of-principle rather than a serious recommendation on how to write 
> drivers.  (Or else I'm misremembering and it was actually an example of 
> creating dynamic sysfs attributes.)
> 
> Or maybe you're referring to what this patch does?  It does indeed 
> create a bunch of dynamic classes -- one for each struct device.  The 
> ordering rules derived by lockdep will be somewhat arbitrary, as you 
> say.  But some of them certainly will be related to the structure of the 
> source code.

I could be :) I haven't been able to find the patch in question - have a
link?

If you're talking about making lock_class_key dynamic, I think I stand
by what I said though - OTOH, if all you're doing is lifting that to the
caller of the device object init function, so it'll still be a static
object in the driver, that would be totally fine.

I probably should've found the patch before commenting :)
