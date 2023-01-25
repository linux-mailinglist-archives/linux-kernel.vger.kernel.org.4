Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F767BC95
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbjAYUcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjAYUcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:32:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA111679
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:32:49 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id a9so24615167ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XvFYv/3BH+raPc6c7uVVEfo0w2IFIqzn0VV1dKg/DsE=;
        b=hEjHZH+/PXCZbFzm8Gs0mP+gmOpzevnvWEyv2Hb9mrGy/Ia9UViVTW+yMu9OjHZoLn
         dSxNPeVlVzWaU+N8poCzMcay5CHW+Fe4obs71ybwcXc2FrAnQE22Xan4xS1dtd6zx8cN
         H4tKM55AfED9psd8JBKHNMZLRX3LPVwjGN16GzJEoHWdNIbhtDsMnnm5ksH8QOcQVrN0
         Nwe40jKxIajox5lkyZv4fE5CLXLbj4nunWl9CN7Auwv8KWeN3faoj3pEHA2/jQRPSNY+
         iVLzsvsdIvhn6Vpnjq5FvRPl1St52MohTqDKD0PBWe96eVEl0FT+9JcuQOZm+7LgjZYI
         zMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvFYv/3BH+raPc6c7uVVEfo0w2IFIqzn0VV1dKg/DsE=;
        b=sKJU/i1jBIVbLprBiYDylPMT9L1rmn7ae+gIjyoOp077ErtEgOIJ3SAomKFor78r1K
         t89lFvHC/VEajIBgLbK1C+5CvH1l2eIpFAT7ND3h5y1NBtWyzVaTJ67EwasatRCsnadX
         etcN8o9AnMPVe2d4Z81nIQAjIguKwW8bqucGf3ifyTBKiR0i1gtiY1TsaVWqP9xJHPYY
         PEINT/bm+5vy0ItrUq/iC83eTTZLpvzgOcVhY8yUXcqWpTPU1f6ArIXUg+m3v/c0SyxO
         QV6ErIOrWqALki5WcF3dCR1DAR6xz8FL6B23bJkqN1yMndQSBCpMb1ftz5tpmHl+parv
         MgyQ==
X-Gm-Message-State: AFqh2kp7WkBzfcgm0vMjymeLJjGhcLD6eHakBW0bhF43igik7bFQ8DWJ
        atn2Fx9VaUCBwtSVauCowXLo2i+cxVMSQMxurNGY
X-Google-Smtp-Source: AMrXdXuyOxlrSgIihhAPwblUHAnwZUnTmUWtVk/tjYUmRg/ZK9LBUgnOX1tV3qFXnFG1Gw1bFncqV28J3Ba/WA7dGaU=
X-Received: by 2002:a25:dd5:0:b0:801:7846:7e97 with SMTP id
 204-20020a250dd5000000b0080178467e97mr1757953ybn.49.1674678768614; Wed, 25
 Jan 2023 12:32:48 -0800 (PST)
MIME-Version: 1.0
References: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
 <20230117082508.8953-1-jaewon31.kim@samsung.com> <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
 <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
 <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p2>
 <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2> <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
In-Reply-To: <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 25 Jan 2023 12:32:36 -0800
Message-ID: <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
To:     jaewon31.kim@samsung.com
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
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

On Wed, Jan 25, 2023 at 2:20 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > On Tue, Jan 17, 2023 at 10:54 PM John Stultz <jstultz@google.com> wrote:
> > > >
> > > > On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > > > > Using order 4 pages would be helpful for many IOMMUs, but it could spend
> > > > > > quite much time in page allocation perspective.
> > > > > >
> > > > > > The order 4 allocation with __GFP_RECLAIM may spend much time in
> > > > > > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> > > > > > unpredictable delay.
> > > > > >
> > > > > > To get reasonable allocation speed from dma-buf system heap, use
> > > > > > HIGH_ORDER_GFP for order 4 to avoid reclaim.
> > > >
> > > > Thanks for sharing this!
> > > > The case where the allocation gets stuck behind reclaim under pressure
> > > > does sound undesirable, but I'd be a bit hesitant to tweak numbers
> > > > that have been used for a long while (going back to ion) without a bit
> > > > more data.
> > > >
> > > > It might be good to also better understand the tradeoff of potential
> > > > on-going impact to performance from using low order pages when the
> > > > buffer is used.  Do you have any details like or tests that you could
> > > > share to help ensure this won't impact other users?
> > > >
> > > > TJ: Do you have any additional thoughts on this?
> > > >
> > > I don't have any data on how often we hit reclaim for mid order
> > > allocations. That would be interesting to know. However the 70th
> > > percentile of system-wide buffer sizes while running the camera on my
> > > phone is still only 1 page, so it looks like this change would affect
> > > a subset of use-cases.
> > >
> > > Wouldn't this change make it less likely to get an order 4 allocation
> > > (under memory pressure)? The commit message makes me think the goal of
> > > the change is to get more of them.
> >
> > Hello John Stultz
> >
> > I've been waiting for your next reply.

Sorry, I was thinking you were gathering data on the tradeoffs. Sorry
for my confusion.

> > With my commit, we may gather less number of order 4 pages and fill the
> > requested size with more number of order 0 pages. I think, howerver, stable
> > allocation speed is quite important so that corresponding user space
> > context can move on within a specific time.
> >
> > Not only compaction but reclaim also, I think, would be invoked more if the
> > __GFP_RECLAIM is added on order 4. I expect the reclaim could be decreased
> > if we move to order 0.
> >
>
> Additionally I'd like to say the old legacy ion system heap also used the
> __GFP_RECLAIM only for order 8, not for order 4.
>
> drivers/staging/android/ion/ion_system_heap.c
>
> static gfp_t high_order_gfp_flags = (GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN |
>                                     __GFP_NORETRY) & ~__GFP_RECLAIM;
> static gfp_t low_order_gfp_flags  = GFP_HIGHUSER | __GFP_ZERO;
> static const unsigned int orders[] = {8, 4, 0};
>
> static int ion_system_heap_create_pools(struct ion_page_pool **pools)
> {
>        int i;
>
>        for (i = 0; i < NUM_ORDERS; i++) {
>                struct ion_page_pool *pool;
>                gfp_t gfp_flags = low_order_gfp_flags;
>
>                if (orders[i] > 4)
>                        gfp_flags = high_order_gfp_flags;


This seems a bit backwards from your statement. It's only removing
__GFP_RECLAIM on order 8 (high_order_gfp_flags).

So apologies again, but how is that different from the existing code?

#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
                                | __GFP_NORETRY) & ~__GFP_RECLAIM) \
                                | __GFP_COMP)
static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};

Where the main reason we introduced the mid-order flags is to avoid
the warnings on order 4 allocation failures when we'll fall back to
order 0

The only substantial difference I see between the old ion code and
what we have now is the GFP_COMP addition, which is a bit hazy in my
memory. I unfortunately don't have a record of why it was added (don't
have access to my old mail box), so I suspect it was something brought
up in private review.  Dropping that from the low order flags probably
makes sense as TJ pointed out, but this isn't what your patch is
changing.

Your patch is changing that for mid-order allocations we'll use the
high order flags, so we'll not retry and not reclaim, so there will be
more failing and falling back to single page allocations.
This makes sense to make allocation time faster and more deterministic
(I like it!), but potentially has the tradeoff of losing the
performance benefit of using mid order page sizes.

I suspect your change is a net win overall, as the cumulative effect
of using larger pages probably won't benefit more than the large
indeterministic allocation time, particularly under pressure.

But because your change is different from what the old ion code did, I
want to be a little cautious. So it would be nice to see some
evaluation of not just the benefits the patch provides you but also of
what negative impact it might have.  And so far you haven't provided
any details there.

A quick example might be for the use case where mid-order allocations
are causing you trouble, you could see how the performance changes if
you force all mid-order allocations to be single page allocations (so
orders[] = {8, 0, 0};) and compare it with the current code when
there's no memory pressure (right after reboot when pages haven't been
fragmented) so the mid-order allocations will succeed.  That will let
us know the potential downside if we have brief / transient pressure
at allocation time that forces small pages.

Does that make sense?

thanks
-john
