Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0922D67C3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjAZEmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZEm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:42:28 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E22B091
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 20:42:25 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230126044220epoutp013dbc98149ecd8da64d537f1d6718c269~9wi5Ez3zT2471024710epoutp01H
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:42:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230126044220epoutp013dbc98149ecd8da64d537f1d6718c269~9wi5Ez3zT2471024710epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674708140;
        bh=7lDN2+fTV0lZSoHxJGXzSMIMGZo84ZvuL8MBg+RRh9I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=tVxRu2E+PZ0mPHv0sO4tgQCrk6zVgJZ5ogsv9qqAPth7pcYMuj0CIMOKlHNT0iol0
         wlgm2xHo82eOcB5Q0iLsGPsNG5HrjsVnLVnS9VueiXvUnfOvy0rRTXW9DkVbkJ6AO/
         WOV4Y7T54Jy+SRCxHGTrxKDgTZPEZBvFkdtduujc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230126044219epcas1p154503707da31ac0842415a005dd8e29c~9wi4cs1Ce0057700577epcas1p1N;
        Thu, 26 Jan 2023 04:42:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4P2Sjl2nbQz4x9Q5; Thu, 26 Jan
        2023 04:42:19 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-07-63d204ab06ca
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.E3.54823.BA402D36; Thu, 26 Jan 2023 13:42:19 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     John Stultz <jstultz@google.com>
CC:     "T.J. Mercier" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
Date:   Thu, 26 Jan 2023 13:42:18 +0900
X-CMS-MailID: 20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmru5qlkvJBn/+CVrMWb+GzWLhw7vM
        Fqs3+Vp0b57JaNH7/hWTxZ8TG9ksLu+aw2Zxb81/VovX35YxW5y6+5nd4t36L2wO3B6H37xn
        9tj7bQGLx85Zd9k9Fmwq9di0qpPNY9OnSewed67tYfM4MeM3i0ffllWMHp83yQVwRWXbZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdrKRQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzrj1/zBT
        wQOzihWz97A0MB7T7GLk4JAQMJHYcEu6i5GLQ0hgB6PE/S07mUHivAKCEn93CHcxcnIIC7hL
        bPv6hhnEFhJQkjj74wo7RNxaYv+iGUwgNpuApcT2mxMZQWwRARWJh3N/soHMZBY4ySxx5cUL
        sGYJAV6JGe1PWSBsaYnty7eCNXAKBEp0/37BCBEXlbi5+i07jP3+2HyouIhE672zUHMEJR78
        3A0Vl5I4132cCcIul9gxZz8bhF0h8bt/GdQcfYkr/TPBangFfCXmNP8Hm8MioCrR8GAVMyQc
        XCSOPDIGCTMLyEtsfzsHLMwsoCmxfpc+xBRFiZ2/5zJClPBJvPvawwrz1Y55T6AuUJNoefYV
        Ki4j8fffMyjbQ6J5TRMLJJiXskg0L77JNoFRYRYipGch2TwLYfMCRuZVjGKpBcW56anFhgWm
        8LhNzs/dxAhOu1qWOxinv/2gd4iRiYPxEKMEB7OSCG/P7PPJQrwpiZVVqUX58UWlOanFhxhN
        gV6eyCwlmpwPTPx5JfGGJpYGJmZGJhbGlsZmSuK84rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqY
        GOw6QyZOvN928+eiTy6ZDhvdJLcxXnG29Pi9cXebhlN4hP41IculC543W0nHaLu2L+IxUNwh
        8fnwKWUD/vNK6zgqdCTv8U7eE5ktuHtlte3xn3+KhA0uftP76ZPx9fAPTvuVnPGcHGoLdYpP
        8jHGaJUsVdndyZ7o5a3N8e930uleF+/vvgGzxJ8r1T1b5/r6Zq9la4ZBMz+j/NWzuvIvM41M
        P00zDZo8M0x6dsyO0oUNmlLPbizf4aW/uO/1IvPV7WvXGxksOHYkX96r/4l/5Ae38MAlCddm
        W75uX/XiS3kmMwf/zDDhgpDjf089vr3yS0Je9KZQIRu+vcGcSm2R1Rt3pyjbWJcFRfWntiix
        FGckGmoxFxUnAgBGCDC3RAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
        <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
        <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
        <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
        <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
        <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 25, 2023 at 2:20 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > > On Tue, Jan 17, 2023 at 10:54 PM John Stultz <jstultz@google.com> wrote:
> > > > >
> > > > > On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > > > > > Using order 4 pages would be helpful for many IOMMUs, but it could spend
> > > > > > > quite much time in page allocation perspective.
> > > > > > >
> > > > > > > The order 4 allocation with __GFP_RECLAIM may spend much time in
> > > > > > > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> > > > > > > unpredictable delay.
> > > > > > >
> > > > > > > To get reasonable allocation speed from dma-buf system heap, use
> > > > > > > HIGH_ORDER_GFP for order 4 to avoid reclaim.
> > > > >
> > > > > Thanks for sharing this!
> > > > > The case where the allocation gets stuck behind reclaim under pressure
> > > > > does sound undesirable, but I'd be a bit hesitant to tweak numbers
> > > > > that have been used for a long while (going back to ion) without a bit
> > > > > more data.
> > > > >
> > > > > It might be good to also better understand the tradeoff of potential
> > > > > on-going impact to performance from using low order pages when the
> > > > > buffer is used.  Do you have any details like or tests that you could
> > > > > share to help ensure this won't impact other users?
> > > > >
> > > > > TJ: Do you have any additional thoughts on this?
> > > > >
> > > > I don't have any data on how often we hit reclaim for mid order
> > > > allocations. That would be interesting to know. However the 70th
> > > > percentile of system-wide buffer sizes while running the camera on my
> > > > phone is still only 1 page, so it looks like this change would affect
> > > > a subset of use-cases.
> > > >
> > > > Wouldn't this change make it less likely to get an order 4 allocation
> > > > (under memory pressure)? The commit message makes me think the goal of
> > > > the change is to get more of them.
> > >
> > > Hello John Stultz
> > >
> > > I've been waiting for your next reply.
> 
> Sorry, I was thinking you were gathering data on the tradeoffs. Sorry
> for my confusion.
> 
> > > With my commit, we may gather less number of order 4 pages and fill the
> > > requested size with more number of order 0 pages. I think, howerver, stable
> > > allocation speed is quite important so that corresponding user space
> > > context can move on within a specific time.
> > >
> > > Not only compaction but reclaim also, I think, would be invoked more if the
> > > __GFP_RECLAIM is added on order 4. I expect the reclaim could be decreased
> > > if we move to order 0.
> > >
> >
> > Additionally I'd like to say the old legacy ion system heap also used the
> > __GFP_RECLAIM only for order 8, not for order 4.
> >
> > drivers/staging/android/ion/ion_system_heap.c
> >
> > static gfp_t high_order_gfp_flags = (GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN |
> >                                     __GFP_NORETRY) & ~__GFP_RECLAIM;
> > static gfp_t low_order_gfp_flags  = GFP_HIGHUSER | __GFP_ZERO;
> > static const unsigned int orders[] = {8, 4, 0};
> >
> > static int ion_system_heap_create_pools(struct ion_page_pool **pools)
> > {
> >        int i;
> >
> >        for (i = 0; i < NUM_ORDERS; i++) {
> >                struct ion_page_pool *pool;
> >                gfp_t gfp_flags = low_order_gfp_flags;
> >
> >                if (orders[i] > 4)
> >                        gfp_flags = high_order_gfp_flags;
> 
> 
> This seems a bit backwards from your statement. It's only removing
> __GFP_RECLAIM on order 8 (high_order_gfp_flags).

Oh sorry, my fault. I also read wrongly. But as far as I know, most of
AP chipset vendors have been using __GFP_RECLAIM only for order 0.
I can't say in detail though.

> 
> So apologies again, but how is that different from the existing code?
> 
> #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> #define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
> #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
> static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
> 
> Where the main reason we introduced the mid-order flags is to avoid
> the warnings on order 4 allocation failures when we'll fall back to
> order 0
> 
> The only substantial difference I see between the old ion code and
> what we have now is the GFP_COMP addition, which is a bit hazy in my
> memory. I unfortunately don't have a record of why it was added (don't
> have access to my old mail box), so I suspect it was something brought
> up in private review.  Dropping that from the low order flags probably
> makes sense as TJ pointed out, but this isn't what your patch is
> changing.
> 
> Your patch is changing that for mid-order allocations we'll use the
> high order flags, so we'll not retry and not reclaim, so there will be
> more failing and falling back to single page allocations.
> This makes sense to make allocation time faster and more deterministic
> (I like it!), but potentially has the tradeoff of losing the
> performance benefit of using mid order page sizes.
> 
> I suspect your change is a net win overall, as the cumulative effect
> of using larger pages probably won't benefit more than the large
> indeterministic allocation time, particularly under pressure.
> 
> But because your change is different from what the old ion code did, I
> want to be a little cautious. So it would be nice to see some
> evaluation of not just the benefits the patch provides you but also of
> what negative impact it might have.  And so far you haven't provided
> any details there.
> 
> A quick example might be for the use case where mid-order allocations
> are causing you trouble, you could see how the performance changes if
> you force all mid-order allocations to be single page allocations (so
> orders[] = {8, 0, 0};) and compare it with the current code when
> there's no memory pressure (right after reboot when pages haven't been
> fragmented) so the mid-order allocations will succeed.  That will let
> us know the potential downside if we have brief / transient pressure
> at allocation time that forces small pages.
> 
> Does that make sense?

Let me try this. It make take some days. But I guess it depends on memory
status as you said. If there were quite many order 4 pages, then 8 4 0
should be faster than 8 0 0.

I don't know this is a right approach. In my opinion, except the specific
cases like right after reboot, there are not many order 4 pages. And
in determinisitic allocation time perspective, I think avoiding too long
allocations is more important than making faster with already existing
free order 4 pages.

BR
Jaewon Kim

> 
> thanks
> -john
