Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E1618726
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKCSLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKCSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:11:26 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E09E44
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:11:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e19so1476886ili.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SLvo2f2Rw9+xRpi0a0qfY4olfu9z2e3VeeMwCg3OIo=;
        b=Uw0KXfvbmXkAElAF34cXeTPLauuF1a2yvgRbyP/YiTMQNQPlYmVUrjGppo1AoyKNjh
         QQXy79C9ujeFzAyNSjPl/DUl61VK3TkwNB3SW7ahbFkFuCaUC3hVLYxKCmOx0li+XfaH
         4eF89xNten4WFKb85q+UphkLYlgdGufTJFkReNYTzjQNotnmoi8zH53TZFXi+nGcDXD8
         CezyWu6gCTE/NrC4Le+lrkXa3PFBtHXWms4+hVB9AZvtXXxTERC7Aznm4aFifDUQZDuq
         Q4w2EC75NwVmbXkCQ8JtKfPGZsm64qsW5T92bpeSG9zZUYanD7LbF3UQjeyDLdoV9kw9
         8zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SLvo2f2Rw9+xRpi0a0qfY4olfu9z2e3VeeMwCg3OIo=;
        b=2LsLH4NjJiNe6tuRLO0I2NWWfZc5jkC1Fa62adytnJcF1KByPmAInnCUqLcFKJTkqX
         ZshS3csY21KTGaNxMTj8QiGjGLeJ3IWGT+7cTpeLk/GPlMpIUT9X6gEngosK4MyOwnD6
         +ZaYFd0v5OD30m4QX8zLfVJuUIaIwaumFCjj4yvjqi0aPhOYbLqS1gbIt4ExRIIgEAoh
         l3bwElrLtfbTvEZwYP1gpwVDTp6NTOcFdWrDAm2bzJ+DkZ/P+QbOw3CTgIom0rXicnXf
         G2wOgNgv1z106f3WtwdOLjaOFwnOzkxJ941UGhc0nRPyN0zom8y+6tN5b1nMp2eHXrVC
         sCWA==
X-Gm-Message-State: ACrzQf1Cp/q5np/y0xCYNSOkZc1rD2SfEIzu6IxO9J0JNvYE8ISQD7xF
        EqnrrP7bdVBQLTkfey52U7eFvptANu8moUeGX0imlA==
X-Google-Smtp-Source: AMsMyM6GvU21+E0SGmMkijVOZ88+ndQO8GgW7Jjr4+76O1WuISGJeAf0M1qY2hu73KtrLeS4a1kBaukB3Hea3OGYXyk=
X-Received: by 2002:a92:2009:0:b0:300:ad31:581a with SMTP id
 j9-20020a922009000000b00300ad31581amr15224995ile.172.1667499084005; Thu, 03
 Nov 2022 11:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221026200613.1031261-1-nphamcs@gmail.com> <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com> <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org> <Y2Pj+fuON8lTMcmn@google.com> <Y2QDgSAc7FcIaNBh@cmpxchg.org>
In-Reply-To: <Y2QDgSAc7FcIaNBh@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 3 Nov 2022 11:10:47 -0700
Message-ID: <CAJD7tkZ6VDnX3ACVS-iKCJfS4CrLdnZWzLD9T1-yqqDDhMrk_Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 11:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Nov 03, 2022 at 08:53:29AM -0700, Minchan Kim wrote:
> > On Thu, Nov 03, 2022 at 11:18:04AM -0400, Johannes Weiner wrote:
> > > On Wed, Nov 02, 2022 at 02:36:35PM -0700, Minchan Kim wrote:
> > > > On Wed, Nov 02, 2022 at 12:28:56PM +0900, Sergey Senozhatsky wrote:
> > > > > On (22/10/26 13:06), Nhat Pham wrote:
> > > > > >  struct size_class {
> > > > > > -     spinlock_t lock;
> > > > > >       struct list_head fullness_list[NR_ZS_FULLNESS];
> > > > > >       /*
> > > > > >        * Size of objects stored in this class. Must be multiple
> > > > > > @@ -247,8 +245,7 @@ struct zs_pool {
> > > > > >  #ifdef CONFIG_COMPACTION
> > > > > >       struct work_struct free_work;
> > > > > >  #endif
> > > > > > -     /* protect page/zspage migration */
> > > > > > -     rwlock_t migrate_lock;
> > > > > > +     spinlock_t lock;
> > > > > >  };
> > > > >
> > > > > I'm not in love with this, to be honest. One big pool lock instead
> > > > > of 255 per-class locks doesn't look attractive, as one big pool lock
> > > > > is going to be hammered quite a lot when zram is used, e.g. as a regular
> > > > > block device with a file system and is under heavy parallel writes/reads.
> > >
> > > TBH the class always struck me as an odd scope to split the lock. Lock
> > > contention depends on how variable the compression rate is of the
> > > hottest incoming data, which is unpredictable from a user POV.
> > >
> > > My understanding is that the primary usecase for zram is swapping, and
> > > the pool lock is the same granularity as the swap locking.
> >
> > People uses the zram to store caching object files in build server.
>
> Oh, interesting. We can try with a kernel build directory on zram.
>
> > > Do you have a particular one in mind? (I'm thinking journaled ones are
> > > not of much interest, since their IO tends to be fairly serialized.)
> > >
> > > btrfs?
> >
> > I am not sure what FSes others are using but at least for me, just
> > plain ext4.
>
> Okay, we can test with both.
>
> > > > I am also worry about that LRU stuff should be part of allocator
> > > > instead of higher level.
> > >
> > > I'm sorry, but that's not a reasonable objection.
> > >
> > > These patches implement a core feature of being a zswap backend, using
> > > standard LRU and locking techniques established by the other backends.
> > >
> > > I don't disagree that it would nicer if zswap had a strong abstraction
> > > for backend pages and a generalized LRU. But that is major surgery on
> > > a codebase of over 6,500 lines. It's not a reasonable ask to change
> > > all that first before implementing a basic feature that's useful now.
> >
> > With same logic, folks added the LRU logic into their allocators
> > without the effort considering moving the LRU into upper layer.
> >
> > And then trend is still going on since I have seen multiple times
> > people are trying to add more allocators. So if it's not a reasonable
> > ask to consier, we couldn't stop the trend in the end.
>
> So there is actually an ongoing effort to do that. Yosry and I have
> spent quite some time on coming up with an LRU design that's
> independent from compression policy over email and at Plumbers.
>
> My concern is more about the order of doing things:
>
> 1. The missing writeback support is a gaping hole in zsmalloc, which
>    affects production systems. A generalized LRU list is a good idea,
>    but it's a huge task that from a user pov really is not
>    critical. Even from a kernel dev / maintainer POV, there are bigger
>    fish to fry in the zswap code base and the backends than this.
>
> 2. Refactoring existing functionality is much easier than writing
>    generalized code that simultaneously enables new behavior. zsmalloc
>    is the most complex of our backends. To make its LRU writeback work
>    we had to patch zswap's ->map ordering to accomodate it, e.g. Such
>    tricky changes are easier to make and test incrementally.
>
>    The generalized LRU project will hugely benefit from already having
>    a proven writeback implementation in zsmalloc, because then all the
>    requirements in zswap and zsmalloc will be in black and white.
>
> > > I get that your main interest is zram, and so this feature isn't of
> > > interest to you. But zram isn't the only user, nor is it the primary
> >
> > I am interest to the feature but my interest is more of general swap
> > layer to manage the LRU so that it could support any hierarchy among
> > swap devices, not only zswap.
>
> I think we're on the same page about the longer term goals.
>

Yeah. As Johannes said, I was also recently looking into this. This
can also help solve other problems than consolidating implementations.
Currently if zswap rejects a page, it goes into swap, which is
more-or-less a violation of page LRUs since hotter pages that are more
recently reclaimed end up in swap (slow), while colder pages that were
reclaimed before are in zswap. Having a separate layer managing the
LRU of swap pages can also make sure this doesn't happen.

More broadly, making zswap a separate layer from swap enables other
improvements such as using zswap regardless of the presence of a
backend swapfile and not consuming space in swapfiles if a page is in
zswap. Of course, this is a much larger surgery.

I am intending to spend more time looking further into this, but other
things keep popping up :)
