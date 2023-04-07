Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE96DA7AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjDGCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDGCY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:24:29 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D04480
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:24:26 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230407022421epoutp02dcbbdcc6320e7e70bc821b84fe5ab224~ThdrwdGG10769207692epoutp02J
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:24:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230407022421epoutp02dcbbdcc6320e7e70bc821b84fe5ab224~ThdrwdGG10769207692epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680834261;
        bh=Yw6Lk1+TBtc4UyWyZCEUZwXQrCDTyX75toVgvvbCtW8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gbNnpOCC3p7dpslWMfoXxFRiFH66lJloS6UqybuxStG/L1xYcXJsAhX+L/TWsSBXE
         xRwdPXNX8xaUrehr3onweaALpcAurc/OqCDZeG3Znu9cTb4sL3pSucWFHPg7T1IZq/
         dw03s5A5yoJAtaFtYT0lY0z0pOQzRY1kdRNjcBw8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230407022420epcas1p3b77a3576c3962cd705bb5f686a37b6e5~ThdrP0r_m0936609366epcas1p3l;
        Fri,  7 Apr 2023 02:24:20 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.241]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pt2Hm29f6z4x9Pv; Fri,  7 Apr
        2023 02:24:20 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-68-642f7ed4303e
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.E3.12562.4DE7F246; Fri,  7 Apr 2023 11:24:20 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "T.J. Mercier" <tjmercier@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     John Stultz <jstultz@google.com>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CABdmKX3NzTWHa3K_rna1iY+UERUrYK1Rq9WqUt9VQRaAKZsWwg@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230407022419epcms1p424f1f8a7100aeccac62651ce25cd6140@epcms1p4>
Date:   Fri, 07 Apr 2023 11:24:19 +0900
X-CMS-MailID: 20230407022419epcms1p424f1f8a7100aeccac62651ce25cd6140
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmge6VOv0Ug4ePeSzmrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wWr78tY7Y4dfczu8W79V/YHHg8
        Dr95z+yx99sCFo+ds+6yeyzYVOqxaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IrK
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulpJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ1x
        sHEva8FDiYoZ+z+zNzC+F+5i5OSQEDCRaD86nw3EFhLYwSixbHZMFyMHB6+AoMTfHcIgprBA
        icTk3QoQFUoSZ39cYQexhQV0JZq6V7OA2GwC2hLvF0xiBbFFBMIk1vZ8BZrIxcEssIFZYs/B
        CWwQq3glZrQ/ZYGwpSW2L9/KCGJzCgRKrH22EqpGVOLm6rfsMPb7Y/MZIWwRidZ7Z5khbEGJ
        Bz93M8LM+XP8OVRvscSyzgdMEHaNxIpzq6Di5hINbyHm8wr4Stzdcxysl0VAVaJn/wuoXS4S
        LdNugNnMAvIS29/OYQb5nVlAU2L9Ln2IEkWJnb/nMsK80rDxNzs6m1mAT+Ld1x5WmPiOeU+g
        zlGTaHn2FSouI/H33zPWCYxKsxABPQvJ4lkIixcwMq9iFEstKM5NTy02LDCCR21yfu4mRnDy
        1TLbwTjp7Qe9Q4xMHIyHGCU4mJVEeC/X6aUI8aYkVlalFuXHF5XmpBYfYjQFenkis5Rocj4w
        /eeVxBuaWBqYmBmZWBhbGpspifN+eaqdIiSQnliSmp2aWpBaBNPHxMEp1cA00eT0uo+eGmuq
        hOSsZjsXFqycEWJoFDrHerWyi5dYaL26w7oObYnFN8QLjD0nnudzN/CJdamesCf9wjo9Feni
        Bcb9SaX3e97Os5i7p7MnJZ7vrElVyt2Kz80XZOTlPt2Y/njm1kT+w82ejD5lpRqOIo1HbnR7
        zbj6KGKD4sTi6G+PlSNbn34+lrLlSL7J0T0KT7Pui5jYVG6+kBOt9+v2/s9bPBMDjW5xyT+J
        yr9RlbidcYfW882/Mk7f6fcRPfWF6eZmlnP3l95rfnluy5GdkYrJma+Wh749GebPOHPjMxMx
        u8h/b+5eDw7XqLjZlh48SzYjWrJ3Y3DuIa+D5uYeEzpY/0rpCdlPiToWmaHEUpyRaKjFXFSc
        CAAMOeu9RwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
References: <CABdmKX3NzTWHa3K_rna1iY+UERUrYK1Rq9WqUt9VQRaAKZsWwg@mail.gmail.com>
        <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
        <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
        <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
        <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
        <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
        <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com>
        <20230406163822.faae6a90b3aa4942df6e7442@linux-foundation.org>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p4>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Apr 6, 2023 at 4:38?PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Thu, 6 Apr 2023 16:27:28 -0700 "T.J. Mercier" <tjmercier@google.com> wrote:
>>
>> > > When you say "decide what's the largest reasonable size", I think it
>> > > is difficult as with the variety of RAM sizes and buffer sizes I don't
>> > > think there's a fixed limit. Systems with more ram will use larger
>> > > buffers for image/video capture buffers.  And yes, you're right that
>> > > ram/2-1 in a single allocation is just as broken, but I'm not sure how
>> > > to establish a better guard rail.
>> > >
>> > > thanks
>> > > -john
>> >
>> > I like ENOMEM with the len / PAGE_SIZE > totalram_pages() check and
>> > WARN_ON. We know for sure that's an invalid request, and it's pretty
>> > cheap to check as opposed to trying a bunch of reclaim before failing.
>>
>> Well, if some buggy caller has gone and requested eleventy bigabytes of
>:)
>> memory, doing a lot of reclaiming before failing isn't really a problem
>> - we don't want to optimize for this case!
>>
>The issue I see is that it could delay other non-buggy callers, or
>cause reclaim that wouldn't have happened if we just outright rejected
>a known-bad allocation request from the beginning.
>
>> > For buffers smaller than that I agree with John in that I'm not sure
>> > there's a definitive threshold.
>>
>> Well...  why do we want to do _anything_ here?  Why cater for buggy
>> callers?  I think it's because "dma-buf behaves really badly with very
>> large allocation requests".  Again, can we fix that instead?
>>
>There are a variety of different allocation strategies used by
>different exporters so I don't think there's one dma-buf thing we
>could fix for slow, large allocations in general. For the system_heap
>in this patch it's really just alloc_pages. I'm saying I don't think
>the kernel should ever ask alloc_pages for more memory than exists on
>the system, which seems like a pretty reasonable sanity check to me.
>Given that, I don't think we should do anything for buffers smaller
>than totalram_pages() (except maybe to prevent OOM panics via
>__GFP_RETRY_MAYFAIL when we attempt to exhaust system memory on any
>request - valid or otherwise).

I think T. J. also agree with me on what I shared.
  if (len / PAGE_SIZE > totalram_pages()) return ERR_PTR(-ENOMEM);
  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP | __GFP_RETRY_MAYFAIL)

Regarding the dma-buf behavior, I also would like to say that the dma-buf
system heap seems to be designed to allocate that large memory. In mobile
devices, we need that large memory for camera buffers or grahpics
rendendering buffers. So that large memory should be allowed but the invalid
huge size over ram should be avoided.

I agree on that mm should reclaim even for the large size. But that reclaim
process may affect system performance or user convenience. In that perspective
I thought ram / 2 was reasonable, but yes not a golden value. I hope to use
just ram size as sanity check.

Additionally if all agree, we may be able to apply __GFP_RETRY_MAYFAIL too.

BR
