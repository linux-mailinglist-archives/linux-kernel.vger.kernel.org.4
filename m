Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBB69354C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 00:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBKXgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 18:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKXgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 18:36:20 -0500
X-Greylist: delayed 690 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Feb 2023 15:36:19 PST
Received: from out-250.mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB96F15552
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 15:36:19 -0800 (PST)
Date:   Sat, 11 Feb 2023 18:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676157887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sF17/Q4eBOKYKqU4TSrogsUixE7QUMHWKHgophK4mEs=;
        b=waW6j+oiUR+ZKBXA8h22amOLp1ilh779eW+H7nNVQtPa9I7LglyH45p8do62V9ec3taCmF
        WqOFC5DhBrBCaOGdsGIudJO2TABvrS/2AAl2ZHNN4VwCFsQs5ZDX/S5V+k551Mm1Jmxw+w
        wwYvPZPDguq151Yv/109PE1tqLcIouA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <Y+gjuqJ5RFxwLmht@moria.home.lan>
References: <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 06:06:28PM -0500, Kent Overstreet wrote:
> On 2/11/23 16:51, Linus Torvalds wrote:
> > On Sat, Feb 11, 2023 at 1:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > 
> > > @@ -2941,7 +2944,10 @@ void device_initialize(struct device *de
> > >          kobject_init(&dev->kobj, &device_ktype);
> > >          INIT_LIST_HEAD(&dev->dma_pools);
> > >          mutex_init(&dev->mutex);
> > > -       lockdep_set_novalidate_class(&dev->mutex);
> > > +       if (!lockdep_static_obj(dev)) {
> > > +               lockdep_register_key(&dev->mutex_key);
> > > +               lockdep_set_class(&dev->mutex, &dev->mutex_key);
> > > +       }
> > >          spin_lock_init(&dev->devres_lock);
> > >          INIT_LIST_HEAD(&dev->devres_head);
> > >          device_pm_init(dev);
> > 
> > So I think this is the right thing to do, but I note that while that
> > lockdep_set_novalidate_class() was "documented" to only be for
> > 'dev->mutex' by scripts/checkpatch.pl, that horrific thing is also
> > used by md/bcache/btree.c for the mca_bucket_alloc().
> > 
> > Can we *please* get rid of it there too (it was added by the initial
> > code, and never had any explicit excuse for it), possibly by using the
> > same model.
> > 
> > And then we could get rid of lockdep_set_novalidate_class() entirely.
> > That would be a good thing.
> 
> Yeah, what bcache really needs (and presumably dev->mutex as well) is just
> to disable lockdep checking for self-deadlock of that lock type, since it's
> got its own deadlock avoidance and the subclass thing isn't good enough.
> 
> I've got a patch that should do what we want, replying from my other account
> with it.

After scanning the rest of the thread: I don't think you want to create
separate lockdep classes for each bus and device type, that's defeating
how lockdep works. Maybe if it was only a small, _static_ number of new
classes, but the basic premesis of lockdep is that there are static
human understandable lock ordering rules, so lockdep figures out what
they are and checks them: if you create a bunch of dynamic classes, the
classes are going to be different for everyone in practice and won't
have any real bearing on the structure of the code - that is, given a
lockdep splat, you won't be able to do anything with it.

If static lock ordering rules aren't working (say, because the lock
ordering rules are determined by hardware relationships or what
userspace is doing), then you have to do something more sophisticated.

Wait/wound mutexes would be the next thing to look at, and DRM ended up
needing them for similar reasons as what you're running up against so I
think they bear serious consideration.

ww mutexes are the simple version of dynamic deadlock avoidance -
instead of doing full cycle detection they just compare transaction
start times, so they come at the cost of more frequent aborts. If this
is an issue for you, here's what full cycle detection looks like:

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/btree_locking.c#n53
