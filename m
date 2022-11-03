Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685AA61871C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiKCSJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:08:49 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF581139
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:07:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e15so1677932qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHWzePCnywgOXV+O/5+ROU9THC1c+N7y7y85crqqww4=;
        b=SdoLiKAvEI0X3ZKrhFAvn+VBz0+Uq4XIm0h9Q+Ov3GjeBG2TIlyxeIDv0ZgIj4qnan
         m9bQJApX2h7WTueOIyqCTcHSMcQxa4u1RwfqnmJDUv6bAK8YCateqqCV3ZxTR6Voyg4C
         1wICqpbS5oEQZ6CZZYm9q9HOVKnffRTU4HuCHG3KyEGK7p9D+YjfkeIiO7ssK0ZrWyBM
         SIan8t066bwC4oLGuzHoYIxKUqDkgazoomJYrOAQMhnrLjDTTDjOB9DYBH0Z5iEOmNM4
         9flCmzuE05+4qcZ90FYEd/hHfpfMKWXjJiEMCgq6pspxiT91yfulUGhT/gvzm2INRA8a
         MSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHWzePCnywgOXV+O/5+ROU9THC1c+N7y7y85crqqww4=;
        b=TPwtDTFwjFXgM1PEVVL97kb7+3lz4X20rKaqLg2y9mEw0FaIsPUfQ2lW4F8oicilji
         30RmrT1jDFloG9VEEMD9atjkIYyGNg7MdtG5C7BqraT7V74yXfq2Dw6KOFNQYFDcnrwB
         givFinhEt3DutGouHRXIghF6NCWk4UiYWFi5oiujmeg1x4mzx/fHWJMo9ZOTvuJaR8EL
         R10g7bHT38oNRSt/zvdWy15ZsbzKFxqJJyZnpm1PwC5qed7wjXo7pn1Vu6ZicKlMqrQL
         llOZ08yirWAe7jnVgTlo1Wi4awFc39ZoA8OKfCXUXurVyQGZdyRUc3r7iXFfjSBWOE67
         EOhw==
X-Gm-Message-State: ACrzQf0t/5xEcjkPYDQ2vNG240UMksd9he/XF1B79RQANkcHCvl5pIFi
        XP8vIpkdJbeD5nzch+FhmYNnQA==
X-Google-Smtp-Source: AMsMyM75f2VqFwcj+WFltf8V+3IqGmreE/xNvmEpZD5E+Zw3mupbx0mxDw+9RzHN4+5/dKs4+O7/ww==
X-Received: by 2002:a0c:f0d4:0:b0:4bb:6583:66e6 with SMTP id d20-20020a0cf0d4000000b004bb658366e6mr28609051qvl.123.1667498879108;
        Thu, 03 Nov 2022 11:07:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id v25-20020ac87499000000b003a530a32f67sm880713qtq.65.2022.11.03.11.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:07:58 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:08:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2QDgSAc7FcIaNBh@cmpxchg.org>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org>
 <Y2Pj+fuON8lTMcmn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Pj+fuON8lTMcmn@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:53:29AM -0700, Minchan Kim wrote:
> On Thu, Nov 03, 2022 at 11:18:04AM -0400, Johannes Weiner wrote:
> > On Wed, Nov 02, 2022 at 02:36:35PM -0700, Minchan Kim wrote:
> > > On Wed, Nov 02, 2022 at 12:28:56PM +0900, Sergey Senozhatsky wrote:
> > > > On (22/10/26 13:06), Nhat Pham wrote:
> > > > >  struct size_class {
> > > > > -	spinlock_t lock;
> > > > >  	struct list_head fullness_list[NR_ZS_FULLNESS];
> > > > >  	/*
> > > > >  	 * Size of objects stored in this class. Must be multiple
> > > > > @@ -247,8 +245,7 @@ struct zs_pool {
> > > > >  #ifdef CONFIG_COMPACTION
> > > > >  	struct work_struct free_work;
> > > > >  #endif
> > > > > -	/* protect page/zspage migration */
> > > > > -	rwlock_t migrate_lock;
> > > > > +	spinlock_t lock;
> > > > >  };
> > > > 
> > > > I'm not in love with this, to be honest. One big pool lock instead
> > > > of 255 per-class locks doesn't look attractive, as one big pool lock
> > > > is going to be hammered quite a lot when zram is used, e.g. as a regular
> > > > block device with a file system and is under heavy parallel writes/reads.
> > 
> > TBH the class always struck me as an odd scope to split the lock. Lock
> > contention depends on how variable the compression rate is of the
> > hottest incoming data, which is unpredictable from a user POV.
> > 
> > My understanding is that the primary usecase for zram is swapping, and
> > the pool lock is the same granularity as the swap locking.
> 
> People uses the zram to store caching object files in build server.

Oh, interesting. We can try with a kernel build directory on zram.

> > Do you have a particular one in mind? (I'm thinking journaled ones are
> > not of much interest, since their IO tends to be fairly serialized.)
> > 
> > btrfs?
> 
> I am not sure what FSes others are using but at least for me, just
> plain ext4.

Okay, we can test with both.

> > > I am also worry about that LRU stuff should be part of allocator
> > > instead of higher level.
> > 
> > I'm sorry, but that's not a reasonable objection.
> > 
> > These patches implement a core feature of being a zswap backend, using
> > standard LRU and locking techniques established by the other backends.
> > 
> > I don't disagree that it would nicer if zswap had a strong abstraction
> > for backend pages and a generalized LRU. But that is major surgery on
> > a codebase of over 6,500 lines. It's not a reasonable ask to change
> > all that first before implementing a basic feature that's useful now.
> 
> With same logic, folks added the LRU logic into their allocators
> without the effort considering moving the LRU into upper layer.
> 
> And then trend is still going on since I have seen multiple times
> people are trying to add more allocators. So if it's not a reasonable
> ask to consier, we couldn't stop the trend in the end.

So there is actually an ongoing effort to do that. Yosry and I have
spent quite some time on coming up with an LRU design that's
independent from compression policy over email and at Plumbers.

My concern is more about the order of doing things:

1. The missing writeback support is a gaping hole in zsmalloc, which
   affects production systems. A generalized LRU list is a good idea,
   but it's a huge task that from a user pov really is not
   critical. Even from a kernel dev / maintainer POV, there are bigger
   fish to fry in the zswap code base and the backends than this.

2. Refactoring existing functionality is much easier than writing
   generalized code that simultaneously enables new behavior. zsmalloc
   is the most complex of our backends. To make its LRU writeback work
   we had to patch zswap's ->map ordering to accomodate it, e.g. Such
   tricky changes are easier to make and test incrementally.

   The generalized LRU project will hugely benefit from already having
   a proven writeback implementation in zsmalloc, because then all the
   requirements in zswap and zsmalloc will be in black and white.

> > I get that your main interest is zram, and so this feature isn't of
> > interest to you. But zram isn't the only user, nor is it the primary
> 
> I am interest to the feature but my interest is more of general swap
> layer to manage the LRU so that it could support any hierarchy among
> swap devices, not only zswap.

I think we're on the same page about the longer term goals.
