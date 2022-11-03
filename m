Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F655618AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKCVnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKCVnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:43:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE41B9DE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:43:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b62so2838780pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYs5YjcsxCiVwmCqgPu7OxKpxfz22xdOHzRYJ25e2UI=;
        b=JQ5luRfnCdIYIb+xp0kkSkGiSwEdz36DSN1Ac1SnFm51yAKbSaw1F4c2kIxAV0Feu6
         O7wRNYvL2F1N+ulaKuQtGJ6QgmJibgR1ha+hdRiuDSqKktj3ayeZhC/4TP1/zr8OzvIx
         jM4zZ7v2MS/DJHkQID0bDetgMkcm+qUww2NPTLYpMm/clztfAOYrF9KKiPcX3bfk1x7x
         eoD3sT7M/4XyY1aTy9bM5BpmXeAoZO4D7dNm9+bhn9KkdT8M14Hd6anjWnnomaYJoaHf
         xAtiTgWdv9VX9O93JokvG3krUMDrwotzJz4diY9SnTYhsZ8c2j+CqkbGIRRzsRQ7YnUL
         UwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYs5YjcsxCiVwmCqgPu7OxKpxfz22xdOHzRYJ25e2UI=;
        b=2GauSHtyHdBBpPyTJRuYktmCM3TmfIYeWHMeSrMreae0CEU1fIgD6gAa/lDbmt4ZrH
         FmpS6oGSAR1vtO3VH5I6f5eIDvtmiFmeU7e2DZ5iAwNFqYvaBWis8A/HIJavTmfobsDV
         ozLewTRIzAdcwCBrYjFCqOjNq77/ZZYnO71Olr6+77sPqsUsJCip4Nv+Q8gop9u1bbyV
         f70x6ENMTlua6Jmro2CG2VF36/5u4TZJsQqLZXm3BIERjh/ixafxRpNmRZcvcS9f+yOY
         e0LaegoZBY0p9HsEE/GyuDmWpTJTehlGyYItgWGwwqw7SVfGUE9bT8jN256RO1zLJJGu
         9WVQ==
X-Gm-Message-State: ACrzQf0j3Bwlq1OlEFVq2hv8qf6JkHvOpXy/Iu7iYZpN0n7JiyCs83rF
        KHV15FSmPR5+M4bhyaBTGcs=
X-Google-Smtp-Source: AMsMyM6ATdu/CmhX+zKioxa9XGCmS3AsKh51pv/aoWNVfLfM4A3Xh3ajbFsaEL/QgWoqYjWZE25V3A==
X-Received: by 2002:a65:49c9:0:b0:462:9ce1:3f58 with SMTP id t9-20020a6549c9000000b004629ce13f58mr27570519pgs.200.1667511789465;
        Thu, 03 Nov 2022 14:43:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016d5b7fb02esm1176987plg.60.2022.11.03.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:43:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 14:43:06 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2Q16sjnZSgOYHd9@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org>
 <Y2Pj+fuON8lTMcmn@google.com>
 <Y2QDgSAc7FcIaNBh@cmpxchg.org>
 <CAJD7tkZ6VDnX3ACVS-iKCJfS4CrLdnZWzLD9T1-yqqDDhMrk_Q@mail.gmail.com>
 <Y2QmcdEJXB50TnQF@google.com>
 <CAJD7tkYFTQHn4vgNVt8k-aNsXE2Ahi82yprHU=nAZqRpLqQSNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYFTQHn4vgNVt8k-aNsXE2Ahi82yprHU=nAZqRpLqQSNg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:46:56PM -0700, Yosry Ahmed wrote:
> On Thu, Nov 3, 2022 at 1:37 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:10:47AM -0700, Yosry Ahmed wrote:
> > < snip >
> >
> > > > > > > I am also worry about that LRU stuff should be part of allocator
> > > > > > > instead of higher level.
> > > > > >
> > > > > > I'm sorry, but that's not a reasonable objection.
> > > > > >
> > > > > > These patches implement a core feature of being a zswap backend, using
> > > > > > standard LRU and locking techniques established by the other backends.
> > > > > >
> > > > > > I don't disagree that it would nicer if zswap had a strong abstraction
> > > > > > for backend pages and a generalized LRU. But that is major surgery on
> > > > > > a codebase of over 6,500 lines. It's not a reasonable ask to change
> > > > > > all that first before implementing a basic feature that's useful now.
> > > > >
> > > > > With same logic, folks added the LRU logic into their allocators
> > > > > without the effort considering moving the LRU into upper layer.
> > > > >
> > > > > And then trend is still going on since I have seen multiple times
> > > > > people are trying to add more allocators. So if it's not a reasonable
> > > > > ask to consier, we couldn't stop the trend in the end.
> > > >
> > > > So there is actually an ongoing effort to do that. Yosry and I have
> > > > spent quite some time on coming up with an LRU design that's
> > > > independent from compression policy over email and at Plumbers.
> > > >
> > > > My concern is more about the order of doing things:
> > > >
> > > > 1. The missing writeback support is a gaping hole in zsmalloc, which
> > > >    affects production systems. A generalized LRU list is a good idea,
> > > >    but it's a huge task that from a user pov really is not
> > > >    critical. Even from a kernel dev / maintainer POV, there are bigger
> > > >    fish to fry in the zswap code base and the backends than this.
> > > >
> > > > 2. Refactoring existing functionality is much easier than writing
> > > >    generalized code that simultaneously enables new behavior. zsmalloc
> > > >    is the most complex of our backends. To make its LRU writeback work
> > > >    we had to patch zswap's ->map ordering to accomodate it, e.g. Such
> > > >    tricky changes are easier to make and test incrementally.
> > > >
> > > >    The generalized LRU project will hugely benefit from already having
> > > >    a proven writeback implementation in zsmalloc, because then all the
> > > >    requirements in zswap and zsmalloc will be in black and white.
> > > >
> > > > > > I get that your main interest is zram, and so this feature isn't of
> > > > > > interest to you. But zram isn't the only user, nor is it the primary
> > > > >
> > > > > I am interest to the feature but my interest is more of general swap
> > > > > layer to manage the LRU so that it could support any hierarchy among
> > > > > swap devices, not only zswap.
> > > >
> > > > I think we're on the same page about the longer term goals.
> > > >
> > >
> > > Yeah. As Johannes said, I was also recently looking into this. This
> > > can also help solve other problems than consolidating implementations.
> > > Currently if zswap rejects a page, it goes into swap, which is
> > > more-or-less a violation of page LRUs since hotter pages that are more
> > > recently reclaimed end up in swap (slow), while colder pages that were
> > > reclaimed before are in zswap. Having a separate layer managing the
> > > LRU of swap pages can also make sure this doesn't happen.
> >
> > True.
> >
> > >
> > > More broadly, making zswap a separate layer from swap enables other
> > > improvements such as using zswap regardless of the presence of a
> > > backend swapfile and not consuming space in swapfiles if a page is in
> > > zswap. Of course, this is a much larger surgery.
> >
> > If we could decouple the LRU writeback from zswap and supports
> > compression without backing swapfile, sounds like becoming more of
> > zram. ;-)
> 
> That's a little bit grey. Maybe we can consolidate them one day :)
> 
> We have been using zswap without swapfile at Google for a while, this
> gives us the ability to reject pages that do not compress well enough
> for us, which I suspect zram would not support given that it is
> designed to be the final destination of the page. Also, having the

zRAM could do with little change but at current implmentation, it will
print swapout failure message(it's not a big deal since we could
suppress) but I have thought rather than that, we needs to move the
page unevictable LRU list with marking the page CoW to catch a time
to move the page into evictable LRU list o provide second chance to
be compressed. Just off-topic.

> same configuration and code running on machines whether or not they
> have a swapfile is nice, otherwise one would need to use zram if there
> is no swapfile and switch to zswap if there is one.
