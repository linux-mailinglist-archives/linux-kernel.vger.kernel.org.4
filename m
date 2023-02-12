Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A56935BF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 04:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBLDKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 22:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 22:10:30 -0500
Received: from out-166.mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416931556C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 19:10:29 -0800 (PST)
Date:   Sat, 11 Feb 2023 22:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676171427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jf1H3d/In5/77lbYnmu+P0Ph1nV7stwLY9WuFch+4JA=;
        b=xfPf/5bYKSccJHE8x9RrnX3GkjgbEsam3IwYmOxSSNgx9Htaqi60HYx0YggXCGTJe4Bm+Y
        R9wM02p+U29iuRlH8UEDDEviYT+i+qP1B0SXoEK9nxQZmhYocLhdlvh99OJCYa2bsRw6Rh
        DiayDhtxKt36HOxAKuZuR8/cTXHzb9I=
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
Message-ID: <Y+hYn6uzIUBaxDdV@moria.home.lan>
References: <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 10:03:11PM -0500, Alan Stern wrote:
> On Sat, Feb 11, 2023 at 09:46:42PM -0500, Kent Overstreet wrote:
> > On Sat, Feb 11, 2023 at 09:40:58PM -0500, Alan Stern wrote:
> > > Or maybe you're referring to what this patch does?  It does indeed 
> > > create a bunch of dynamic classes -- one for each struct device.  The 
> > > ordering rules derived by lockdep will be somewhat arbitrary, as you 
> > > say.  But some of them certainly will be related to the structure of the 
> > > source code.
> > 
> > I could be :) I haven't been able to find the patch in question - have a
> > link?
> 
> It was earlier in this email thread.  Here's a link:
> 
> https://lore.kernel.org/r/Y+gLd78vChQERZ6A@rowland.harvard.edu/
> 
> > If you're talking about making lock_class_key dynamic, I think I stand
> > by what I said though - OTOH, if all you're doing is lifting that to the
> > caller of the device object init function, so it'll still be a static
> > object in the driver, that would be totally fine.
> 
> The patch does the first, not the second.  Feel free to object some 
> more...  :-)

So IMO the more correct way to do this would be to change
device_initialize() to __device_initialize(), have it take a
lock_class_key as a parameter, and then use __mutex_init() instead of
mutex_init().

But let's think about this more. Will there ever be situations where
lock ordering is dependent on what hardware is plugged into what, or
what hardware is plugged in first?
