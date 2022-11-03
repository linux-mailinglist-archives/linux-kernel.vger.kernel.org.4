Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2308161897C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKCUWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:22:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E621F2D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:22:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2851087pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEPi06UgKprQnUM8Zfxe+0RaYyxeoCxUMy8+FyU8lNQ=;
        b=RLKl3RRCVOU7T+04We+GPkeg1MV7TVfa1A5pCUTe62eVzkeqSRZ14bbUPPKHGpvEHN
         fFKDMKK5lJzDbyDVuSaCkp2S5SNelBWvc13FcdFUSdpQkRkpQes5UkdxR5gTd/RMfez6
         8EH06nkH29bLKXDDUh6L7YFItGjAO0Etoy/9DYZ/YMWuTfds96NZqgthvdWPm0b5dhsL
         AMddYYfh0ETFAIThd43v0wF1vplvY9D8iC1J9hF8YB8JVOcju4WnfMg+dgsb9dPqVaib
         JME03sotYrLf7jtqgHSVxqbKCabvTUj1uHH0B+rn4Mbwf0r6/NpUIzTg/gvQ1AqR0J2t
         tC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEPi06UgKprQnUM8Zfxe+0RaYyxeoCxUMy8+FyU8lNQ=;
        b=GNO5AyL1CQ2phbnFvEoIVAWG68uKyr7dvVOjlElcY2iv4h2NlaUhGK0iCAfItCw8rz
         84DWzHDQgs2jjOdFKY/q8JE7oxzqmNYEDjyuVsjRJ3HxhVMR/jFCdThmQu7BUpr1f2Lx
         EFo/+yCPDb+fxdQbEpfHYcVT81OVHN7TAvwjgvRlZM8g0MK4ME1Or9bkSV9rvNvgniHh
         kitTpauyJhvaodqnF9JvU2I4B5/dh99lYB9fMO4oG0snwf8AnDxrl0IJf+c34wauiFEq
         quslrICx+PVlzEZI8niFrBpSE4FpqWHxPpD3tG3IaJYT1hhqy6CTnuHoE16WN+sEA5rV
         DUEA==
X-Gm-Message-State: ACrzQf2+lkJOkqHRP1MCB5FiAgnIaW7zxPXccx13AWPViEr2Rnsl/o8p
        GPNUAmyOLY4q8DFBaIKfB8Q=
X-Google-Smtp-Source: AMsMyM6WUL6vr+Xs7PtCW0Yz1RJilmg91uXuCh7hjHHqZ/JRI/3uDwJQA1gl5rqZdFuDXmNMyfpD+A==
X-Received: by 2002:a17:902:ec01:b0:186:748f:e8b6 with SMTP id l1-20020a170902ec0100b00186748fe8b6mr31485122pld.131.1667506964704;
        Thu, 03 Nov 2022 13:22:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id 123-20020a621781000000b00562784609fbsm1111632pfx.209.2022.11.03.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:22:44 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 13:22:42 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2QjEpBtgQDkFZ6y@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org>
 <Y2Pj+fuON8lTMcmn@google.com>
 <Y2QDgSAc7FcIaNBh@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2QDgSAc7FcIaNBh@cmpxchg.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:08:01PM -0400, Johannes Weiner wrote:
< snip >

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

I am really glad to hear somebody is working toward right direction.

> 
> My concern is more about the order of doing things:
> 
> 1. The missing writeback support is a gaping hole in zsmalloc, which
>    affects production systems. A generalized LRU list is a good idea,
>    but it's a huge task that from a user pov really is not
>    critical. Even from a kernel dev / maintainer POV, there are bigger
>    fish to fry in the zswap code base and the backends than this.

Even though I believe the general LRU in the swap subsystem is way to go,
I was about to suggesting putting the LRU logic in the zswap layer 
to stop this trend since it's not too difficult at my first glance(Sure,
I might miss something clear there). However, if you guys are working
toward the generalized direction, I am totally in favor of the approach
and looking forward to seeing the project under expectation that we will
clean up all the duplicated logic, fixing the weird layering and then
finally supports hierarchical swap writeback for any combinations of swap
devices.

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

Agreed if we are working toward the right direction and this work could
help to fill the gap of the hole until we can see all the requirements
and achieve it.


> 
> > > I get that your main interest is zram, and so this feature isn't of
> > > interest to you. But zram isn't the only user, nor is it the primary
> > 
> > I am interest to the feature but my interest is more of general swap
> > layer to manage the LRU so that it could support any hierarchy among
> > swap devices, not only zswap.
> 
> I think we're on the same page about the longer term goals.

Fingers crossed.
