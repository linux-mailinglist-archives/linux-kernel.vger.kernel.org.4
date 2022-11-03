Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7E6189A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKCUhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:37:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA010AF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:37:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2905114pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3rQUgLm8fBWl2kuinK6VEZwttob14gVREydxcGaYLE=;
        b=n7dpLZsp9QsfpKft5JtDmRudTBmPlymTDKtL73g/Z6i+84E2LG0wmnkG0F2xD57aAo
         6siPmc4STIiGlRb31n6Urifgom7bAEVJkGL2v8WLvGEZ9qjqsmKJbQtWXNZMN0C3KlbU
         HxAOgYoLImlAWdg3/tbTPObFlHXwrZ0SRCH73s0rt/9O9mbV1sctwKs3pmtz9JrG2hlX
         sSfvjqWbSRauteqg1h5pRkrSfu8+XbQvoxLspG4M10LqaHg//ODoj7l0T62JlI+xbI/q
         EVeS9nBZAgxuWHiEqvtcfXDf9QImghEaA6JNaO2AIbQG9aYKkqCUEcvKDlxGX2NG9aOT
         JPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3rQUgLm8fBWl2kuinK6VEZwttob14gVREydxcGaYLE=;
        b=UFWN6bmN1PGxeAwOm808KjX9GKkrORdreDhbu62mYZijabIN6kp6Zn9kEvy5kesjO8
         /xPMSZydrmUlD9Q8doW046Jw1b99k1+5CgYAoC3XvnenqcIZpDRCUwH4A9curp3K2LTr
         Gl885vliKa7oDD3oAAj47zwMJM2cOqZ51aVMHmB4NQ89Cf+Pte77k7F2A8AUAeLBB1wz
         pkNt2KODjWcjzEs413bPZ5dOjb/6jlMy2HVavksCfa4L2kfWH2zlrSL+GZtrd4Hyo8ZT
         euwz+6Tzc+HgcaZQEZqOPjUWnrV/erMGQF5CxQ/jXcFqtZ66X1b6Sszbpzv6lJDFyFy7
         0JxA==
X-Gm-Message-State: ACrzQf397RFz3blm9jsyKkMVr3ZWNymz3wijYtrHpNkg0NrNrSVLsoEE
        P8ZMl6xU1HqfTYD0NTDIOBE=
X-Google-Smtp-Source: AMsMyM4oez8H1wGMXberIcFEq6joXWDqvXDYVvoLDsMSLZ2Fh7IY2ZQKV6MT7qcYmZP+MVWM+DNVLw==
X-Received: by 2002:a17:902:ef47:b0:179:d18e:4262 with SMTP id e7-20020a170902ef4700b00179d18e4262mr31259428plx.22.1667507828142;
        Thu, 03 Nov 2022 13:37:08 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id ep6-20020a17090ae64600b0020de216d0f7sm413754pjb.18.2022.11.03.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:37:07 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 13:37:05 -0700
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
Message-ID: <Y2QmcdEJXB50TnQF@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org>
 <Y2Pj+fuON8lTMcmn@google.com>
 <Y2QDgSAc7FcIaNBh@cmpxchg.org>
 <CAJD7tkZ6VDnX3ACVS-iKCJfS4CrLdnZWzLD9T1-yqqDDhMrk_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZ6VDnX3ACVS-iKCJfS4CrLdnZWzLD9T1-yqqDDhMrk_Q@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:10:47AM -0700, Yosry Ahmed wrote:
< snip >

> > > > > I am also worry about that LRU stuff should be part of allocator
> > > > > instead of higher level.
> > > >
> > > > I'm sorry, but that's not a reasonable objection.
> > > >
> > > > These patches implement a core feature of being a zswap backend, using
> > > > standard LRU and locking techniques established by the other backends.
> > > >
> > > > I don't disagree that it would nicer if zswap had a strong abstraction
> > > > for backend pages and a generalized LRU. But that is major surgery on
> > > > a codebase of over 6,500 lines. It's not a reasonable ask to change
> > > > all that first before implementing a basic feature that's useful now.
> > >
> > > With same logic, folks added the LRU logic into their allocators
> > > without the effort considering moving the LRU into upper layer.
> > >
> > > And then trend is still going on since I have seen multiple times
> > > people are trying to add more allocators. So if it's not a reasonable
> > > ask to consier, we couldn't stop the trend in the end.
> >
> > So there is actually an ongoing effort to do that. Yosry and I have
> > spent quite some time on coming up with an LRU design that's
> > independent from compression policy over email and at Plumbers.
> >
> > My concern is more about the order of doing things:
> >
> > 1. The missing writeback support is a gaping hole in zsmalloc, which
> >    affects production systems. A generalized LRU list is a good idea,
> >    but it's a huge task that from a user pov really is not
> >    critical. Even from a kernel dev / maintainer POV, there are bigger
> >    fish to fry in the zswap code base and the backends than this.
> >
> > 2. Refactoring existing functionality is much easier than writing
> >    generalized code that simultaneously enables new behavior. zsmalloc
> >    is the most complex of our backends. To make its LRU writeback work
> >    we had to patch zswap's ->map ordering to accomodate it, e.g. Such
> >    tricky changes are easier to make and test incrementally.
> >
> >    The generalized LRU project will hugely benefit from already having
> >    a proven writeback implementation in zsmalloc, because then all the
> >    requirements in zswap and zsmalloc will be in black and white.
> >
> > > > I get that your main interest is zram, and so this feature isn't of
> > > > interest to you. But zram isn't the only user, nor is it the primary
> > >
> > > I am interest to the feature but my interest is more of general swap
> > > layer to manage the LRU so that it could support any hierarchy among
> > > swap devices, not only zswap.
> >
> > I think we're on the same page about the longer term goals.
> >
> 
> Yeah. As Johannes said, I was also recently looking into this. This
> can also help solve other problems than consolidating implementations.
> Currently if zswap rejects a page, it goes into swap, which is
> more-or-less a violation of page LRUs since hotter pages that are more
> recently reclaimed end up in swap (slow), while colder pages that were
> reclaimed before are in zswap. Having a separate layer managing the
> LRU of swap pages can also make sure this doesn't happen.

True.

> 
> More broadly, making zswap a separate layer from swap enables other
> improvements such as using zswap regardless of the presence of a
> backend swapfile and not consuming space in swapfiles if a page is in
> zswap. Of course, this is a much larger surgery.

If we could decouple the LRU writeback from zswap and supports
compression without backing swapfile, sounds like becoming more of
zram. ;-)

> 
> I am intending to spend more time looking further into this, but other
> things keep popping up :)

Same with me. Thanks for looking it, Yosry!
