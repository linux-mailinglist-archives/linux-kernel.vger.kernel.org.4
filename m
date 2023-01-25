Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18867AEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjAYJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjAYJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:56:53 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254D2726
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:56:50 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230125095648epoutp02e1cf8a1fd045654d3276d1e022c8d67a~9hMK4taK43169931699epoutp02b
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:56:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230125095648epoutp02e1cf8a1fd045654d3276d1e022c8d67a~9hMK4taK43169931699epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674640608;
        bh=Dq3Gs80vpXHYVePlHXzFEhSYh9nwER7eIy5vkiUmkvc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Nx47mNumsDoUBdaRcA1MxUGzASLjyEG7ewelkQxJXVGdOS8XNu6u339Uh6vHMC0vC
         c/0rLig8Js4Qn8IC8LC8M3Mx0090zXp/JFfsqejaQ6D674sfkQc+te2cBV1pU+6skT
         JmXDz6NQtLTqe6ZGD5iT6rEUjDh/B2Vxj03mBqME=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230125095647epcas1p27bf66bf496dabea5bf132daa9ca22b18~9hMKMH5Ik2705127051epcas1p2p;
        Wed, 25 Jan 2023 09:56:47 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4P1zl319tnz4x9Pq; Wed, 25 Jan
        2023 09:56:47 +0000 (GMT)
X-AuditID: b6c32a38-39fff70000029402-f8-63d0fcde4c81
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.62.37890.EDCF0D36; Wed, 25 Jan 2023 18:56:47 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "T.J. Mercier" <tjmercier@google.com>,
        John Stultz <jstultz@google.com>
CC:     Jaewon Kim <jaewon31.kim@samsung.com>,
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
In-Reply-To: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
Date:   Wed, 25 Jan 2023 18:56:46 +0900
X-CMS-MailID: 20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmnu79PxeSDU5PYLKYs34Nm8XCh3eZ
        LVZv8rXo3jyT0aL3/Ssmiz8nNrJZXN41h83i3pr/rBavvy1jtjh19zO7xbv1X9gcuD0Ov3nP
        7LH32wIWj52z7rJ7LNhU6rFpVSebx6ZPk9g97lzbw+ZxYsZvFo++LasYPT5vkgvgisq2yUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6WEmhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQndGxuoe5
        YIFwxdvV9g2M//i6GDk5JARMJBZf2s/cxcjFISSwg1HiwoJeli5GDg5eAUGJvzuEQWqEBVwk
        bq/uYwaxhQSUJM7+uMIOEdeVaOpezQJiswloS7xfMIkVxBYR8JbY0bCKEWQms8BJZolHM3cy
        QSzjlZjR/pQFwpaW2L58KyOIzSkQKHFt5hmoGlGJm6vfssPY74/NZ4SwRSRa751lhrAFJR78
        3A0Vl5I4130cqrdcYsec/WwQdoXE7/5lUHP0Ja70zwSr4RXwleheswZsDouAqkRX2yyoXheJ
        mz8+g8WZBeQltr+dwwwKB2YBTYn1u/QhShQldv6eywhRwifx7msPK8xbO+Y9gRqjJtHy7CtU
        XEbi779nULaHRPOaJhZIOF9jkpjxcQrLBEaFWYignoVk8yyEzQsYmVcxiqUWFOempxYbFpjA
        Izc5P3cTIzjxalnsYJz79oPeIUYmDsZDjBIczEoivD2zzycL8aYkVlalFuXHF5XmpBYfYjQF
        +nkis5Rocj4w9eeVxBuaWBqYmBmZWBhbGpspifOK255MFhJITyxJzU5NLUgtgulj4uCUamDy
        SuCP32VYdMOu18Ai+Leu+DGdZTJz/wneaHSssUjdd39m349vXA2mrEcc7oZcM9+4WH7qtZUX
        Gf9vWpm18OJXu/R733Ye4H28t/f75xQ746Na79X3aTc6ver3+zdnz899J09IzZy5qDj8wjIB
        NoG0jaYftu+2dQoo2bzpvs7cb7Hf1Geo3nUuXVL4rGH31vuHTLxY6u4yPZggdHMGz35ug08S
        954dEuezWKzwfPlZ3/u2l36kOd9ZtyI7/U/Mp51PJZ1X6W3/8kz81/8p7HfvHX7AzP3z9eQy
        XavJO1PWTHm3+8rZxe3/uVaEGti/+T1tL+PVrRrXqhsX73kUcDhM6TXP6hNRD/Qs80Q3+l/f
        +FhFiaU4I9FQi7moOBEASAq2tUUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
        <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
        <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 17, 2023 at 10:54 PM John Stultz <jstultz@google.com> wrote:
> >
> > On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > > Using order 4 pages would be helpful for many IOMMUs, but it could spend
> > > > quite much time in page allocation perspective.
> > > >
> > > > The order 4 allocation with __GFP_RECLAIM may spend much time in
> > > > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> > > > unpredictable delay.
> > > >
> > > > To get reasonable allocation speed from dma-buf system heap, use
> > > > HIGH_ORDER_GFP for order 4 to avoid reclaim.
> >
> > Thanks for sharing this!
> > The case where the allocation gets stuck behind reclaim under pressure
> > does sound undesirable, but I'd be a bit hesitant to tweak numbers
> > that have been used for a long while (going back to ion) without a bit
> > more data.
> >
> > It might be good to also better understand the tradeoff of potential
> > on-going impact to performance from using low order pages when the
> > buffer is used.  Do you have any details like or tests that you could
> > share to help ensure this won't impact other users?
> >
> > TJ: Do you have any additional thoughts on this?
> >
> I don't have any data on how often we hit reclaim for mid order
> allocations. That would be interesting to know. However the 70th
> percentile of system-wide buffer sizes while running the camera on my
> phone is still only 1 page, so it looks like this change would affect
> a subset of use-cases.
> 
> Wouldn't this change make it less likely to get an order 4 allocation
> (under memory pressure)? The commit message makes me think the goal of
> the change is to get more of them.

Hello John Stultz

I've been waiting for your next reply.

With my commit, we may gather less number of order 4 pages and fill the 
requested size with more number of order 0 pages. I think, howerver, stable
allocation speed is quite important so that corresponding user space
context can move on within a specific time.

Not only compaction but reclaim also, I think, would be invoked more if the 
__GFP_RECLAIM is added on order 4. I expect the reclaim could be decreased
if we move to order 0.

Thank you
Jaewon Kim

> 
> Actually with the low order being 0, I don't think __GFP_COMP makes
> sense in LOW_ORDER_GFP. But I guess that flag isn't harmful there.
> 
> > thanks
> > -john

