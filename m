Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748897172D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEaBGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjEaBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63DC9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728CF635BA
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F08C433D2;
        Wed, 31 May 2023 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685495200;
        bh=cIUz6fVeRhVKCmvPBvZJh6mfPlzIro+3fTmeKE1vVQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWx7LkvOy///Dtnw40aqCRG+YIwOdLTbCXHUV7eRRcbKWGwnGl1uQlr/xoqwS84S9
         jKAEH38FVfDc44Dth7bU32aw7TocDAyWQLuxpKkki8g8vkZ6uh9lYvAn+tJJiOkETx
         lrAKh38u996iyY4TuTQKoCnh2Dgvp2TI43UDzVJ0i+3GLlhFVgn2tWP2elqfBqVsTN
         DWz3kElxSOakSKqh8nWm9Aa3NwGl58BmeeK7BBKRZmG28is3b+FstNLSuVoH7A5SLA
         E3Y/KjsXTv+yKOwySSz0H+0VhmKH9XamFfS/zLwGu4AR89YdmfkphR2maKsoJyjMdy
         5WBaHUsL8Q5BQ==
Date:   Tue, 30 May 2023 18:06:38 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <ZHadno3POk05o82x@google.com>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
 <20230530041341.GB84971@cmpxchg.org>
 <ZHYNaxgcKs7PSp9I@google.com>
 <20230530155519.GB97194@cmpxchg.org>
 <ZHY+C0ICTah8/+V3@google.com>
 <20230530185451.GA101722@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530185451.GA101722@cmpxchg.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:54:51PM -0400, Johannes Weiner wrote:
> > Maybe ENOMEM is a bad example. How about if the swap device
> > just went bad and can't complete new IO writes?
> 
> This is actually outside the scope of zswap, and handled by the
> swapcache (end_swap_bio_write).
> 
> Once the IO is submitted, zswap will ax its copy and leave the rest to
> the swapcache. It behaves the same way as if zswap had never been
> involved to begin with when the swap out fails on IO errors.
> 
> From a zswap perspective, there are no persistent errors in moving a
> zswap entry back into the swapcache. Not just currently, but generally.
Again, you are right that this zswap writeback is async.
So the writeback error is NOT going to propagate to the
shrink function.

With the current three pool backends that I looked at{zbud,
z3fold,zsmalloc} they all have internal retry 8 times.
Adding more retry did not fundamentally change the existing
behavior.

I look at all the possible error codes generated inside
the reclaim code, the only noticeable errors are ENOMEM
and concurrent swap invalidation or a racing swapin fault.

BTW, zswap reclaim consumes memory. Keep on looping ENOMEM
might cause more OOM. But that can exist in current code
as well.

> > > Aside from -ENOMEM, writeback_entry will fail on concurrent swap
> > > invalidation or a racing swapin fault. In both cases we should
> > > absolutely keep trying other entries until the goal is met.
> > 
> > How about a narrower fix recognizing those error cases and making
> > the inner loop continue in those errors?
> 
> Right, I just I don't really see the value proposition of this
> complication, and I see some downsides (see below). No single entry
> error should ever cause us to stop the wider reclaim loop.

That is until the current LRU list has been through once.
I expect repeating the same list yields less reclaimed pages.

> 
> > > > > extreme case where it's the only page left on the list, I again don't
> > > > > see how retrying a few times will make the situation worse.
> > > > > 
> > > > > In practice, IMO there is little upside in trying to be more
> > > > > discerning about the error codes. Simple seems better here.
> > > > 
> > > > Just trying to think about what should be the precise loop termination
> > > > condition here.
> > > > 
> > > > I still feel blindly trying a few times is a very imprecise condition.
> > > 
> > > The precise termination condition is when can_accept() returns true
> > > again. The safety cap is only added as precaution to avoid infinite
> > > loops if something goes wrong or unexpected, now or in the future.
> > 
> > In my mind, that statement already suggests can_accept() is not
> > *precise*, considering the avoid infinite loop.
> > e.g. Do we know what is the optimal cap value and why that value
> > is optical?
> 
> Oh but it is precise. That's the goal we want to accomplish.

I understand it is the goal, the precise condition I am
talking about is the loop termination condition, can_accept()
is not the only one. Anyway, let's move on.
> 
> The cap is just so that in case something unexpectedly goes wrong (a
> bug), we fail gracefully and don't lock up the machine. The same
> reason we prefer WARN_ONs over BUG_ONs if we can, to avoid
> crashes. That's really all there is too it, and it strikes me as
> reasonable and robust design choice. It's fine to limp along or be
> suboptimal after such a bug happens; the bar is avoiding an infinite
> loop, nothing else.
> 
> Your suggestion of whitelisting certain errors is more complicated,
> but also less robust: in case an entry error does by some accident
> become persistent for the whole LRU, we're locking up the host. We'd
> rather catch a bug like this by seeing spikes in the reclaim failure
> rate than by losing production machines.
> 
> > Putting the definition of precise aside, I do see the unconditional
> > retry can have unwanted effects.
> 
> I hope I could address this above. But if not, please share your
> concerns.
Thanks for the discussion. I am less concerned about the retry now.
Retry on EAGAIN might be the simplest way to proceed.

Outside of the scope of this patch, I am still surprised to see
such a high number of retries caused by race conditions. There are
8 inner loop retry already. The actual pages retried need to
times 8.

If there is a reproducer script, I want to local repo this
to understand better. Wish there are ways to reduce the retry.

Another idea is that we can start the shrinking once the
pool max was reached. Try to reduce to the threshold earlier.

Chris
