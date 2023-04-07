Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A86DAD19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjDGNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjDGNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:04:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43351A5CE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:03:56 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230407130351epoutp0200c8d93fbe485a244dbb5bac902ca643~TqMDLSauf0697106971epoutp02C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:03:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230407130351epoutp0200c8d93fbe485a244dbb5bac902ca643~TqMDLSauf0697106971epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680872631;
        bh=tksbkX3By7/XTnABv6FgP8lSwaNFKHFLXmUC0bAQNpU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ipO5l3I1TFf/BUs6Ou92hvGVqhX/1xGWDSnu2H7K52mv8Ls8Ncz2cCLX76nCZm8xx
         v8uK6yMwvG/9nANjSoh9QS3vPwRB2R3CYrH+C+T3zTALHuvRXtkFE++dJdzw4cpEBf
         N9pS6WPa3nJFG75t8IoXGvV9SW9JBO84l4AxD4d8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230407130351epcas1p1baa5a6687004ab2f973e0cab58f19bbd~TqMCunFuy1949919499epcas1p1y;
        Fri,  7 Apr 2023 13:03:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PtJTg0cGwz4x9Pq; Fri,  7 Apr
        2023 13:03:51 +0000 (GMT)
X-AuditID: b6c32a37-55fff7000001cb45-e1-643014b64d98
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.F4.52037.6B410346; Fri,  7 Apr 2023 22:03:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "T.J. Mercier" <tjmercier@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CABdmKX3qBrOU6K=JXZhU8=oi=quxBqBnVaKiV5p=4uCTLLsRPA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230407130349epcms1p27a39fe169e693a61278140eba8724048@epcms1p2>
Date:   Fri, 07 Apr 2023 22:03:49 +0900
X-CMS-MailID: 20230407130349epcms1p27a39fe169e693a61278140eba8724048
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmnu42EYMUg6mrLS3mrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wWr78tY7Y4dfczu8W79V/YHHg8
        Dr95z+yx99sCFo+ds+6yeyzYVOqxaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IrK
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulpJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ3R
        tO0OY0GvbMW76+vZGxhniXcxcnJICJhIPN77mLGLkYtDSGAHo8TCR2dYuhg5OHgFBCX+7hAG
        MYUFSiQm71YAKRcSUJI4++MKO4gtLKAr0dS9mgXEZhPQlni/YBIriC0ioClx7flmFpCRzAJb
        mCVWT/rIBrGLV2JG+1MWCFtaYvvyrYwg8zkFAiV29odAhEUlbq5+yw5jvz82nxHCFpFovXeW
        GcIWlHjwczcjzJg/x59DjS+WWNb5gAnCrpFYcW4VVNxcouHtSjCbV8BXom3XRLAaFgFVibd/
        PkLNcZGYeHc5mM0sIC+x/e0cZpDTmIF+Wb9LH6JEUWLn77mMMJ80bPzNjs5mFuCTePe1hxUm
        vmPeE6hz1CRann2FistI/P33jHUCo9IsRDjPQrJ4FsLiBYzMqxjFUguKc9NTiw0LjOFRm5yf
        u4kRnHy1zHcwTnv7Qe8QIxMH4yFGCQ5mJRFeG26DFCHelMTKqtSi/Pii0pzU4kOMpkAvT2SW
        Ek3OB6b/vJJ4QxNLAxMzIxMLY0tjMyVx3i9PtVOEBNITS1KzU1MLUotg+pg4OKUamGL9N269
        29c/+YTeF+kLW1dHPOKvfbn6R92VzZLsJy+rfdXTYV8Ws6B04eZc3pVznkxj1i0XOH99c8eS
        8Cu959dlTKpmTfIXYE4S4xIt+3iKe+rBie1LaivDIiU4v7j3ZNj9sV4wP9R7vUfFocKcv8c6
        nXQnJbpzBfyVm3o8aWeO+LYpD6wPbWk9Ivbm+7U50p5PZmuJCc8MTPqkuPf/Rdff5+41WvxM
        +SlofuqjvZx8Q4DQcpvrG38d4itlPVE2Zf5/2w3O02akrYvKyJesP+YQfur9FOfoNyyzclM0
        t0uE7D9Z+OvBgoSX31ZMutER71oicP3iBtvsJeobXepdpu9m/VfDH8ma/dLs85ldHIVKLMUZ
        iYZazEXFiQCPqkb2RwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
References: <CABdmKX3qBrOU6K=JXZhU8=oi=quxBqBnVaKiV5p=4uCTLLsRPA@mail.gmail.com>
        <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
        <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
        <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
        <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
        <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
        <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com>
        <20230406163822.faae6a90b3aa4942df6e7442@linux-foundation.org>
        <CABdmKX3NzTWHa3K_rna1iY+UERUrYK1Rq9WqUt9VQRaAKZsWwg@mail.gmail.com>
        <20230407022419epcms1p424f1f8a7100aeccac62651ce25cd6140@epcms1p4>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Apr 6, 2023 at 7:24?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>
>> >On Thu, Apr 6, 2023 at 4:38?PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> >>
>> >> On Thu, 6 Apr 2023 16:27:28 -0700 "T.J. Mercier" <tjmercier@google.com> wrote:
>> >>
>> >> > > When you say "decide what's the largest reasonable size", I think it
>> >> > > is difficult as with the variety of RAM sizes and buffer sizes I don't
>> >> > > think there's a fixed limit. Systems with more ram will use larger
>> >> > > buffers for image/video capture buffers.  And yes, you're right that
>> >> > > ram/2-1 in a single allocation is just as broken, but I'm not sure how
>> >> > > to establish a better guard rail.
>> >> > >
>> >> > > thanks
>> >> > > -john
>> >> >
>> >> > I like ENOMEM with the len / PAGE_SIZE > totalram_pages() check and
>> >> > WARN_ON. We know for sure that's an invalid request, and it's pretty
>> >> > cheap to check as opposed to trying a bunch of reclaim before failing.
>> >>
>> >> Well, if some buggy caller has gone and requested eleventy bigabytes of
>> >:)
>> >> memory, doing a lot of reclaiming before failing isn't really a problem
>> >> - we don't want to optimize for this case!
>> >>
>> >The issue I see is that it could delay other non-buggy callers, or
>> >cause reclaim that wouldn't have happened if we just outright rejected
>> >a known-bad allocation request from the beginning.
>> >
>> >> > For buffers smaller than that I agree with John in that I'm not sure
>> >> > there's a definitive threshold.
>> >>
>> >> Well...  why do we want to do _anything_ here?  Why cater for buggy
>> >> callers?  I think it's because "dma-buf behaves really badly with very
>> >> large allocation requests".  Again, can we fix that instead?
>> >>
>> >There are a variety of different allocation strategies used by
>> >different exporters so I don't think there's one dma-buf thing we
>> >could fix for slow, large allocations in general. For the system_heap
>> >in this patch it's really just alloc_pages. I'm saying I don't think
>> >the kernel should ever ask alloc_pages for more memory than exists on
>> >the system, which seems like a pretty reasonable sanity check to me.
>> >Given that, I don't think we should do anything for buffers smaller
>> >than totalram_pages() (except maybe to prevent OOM panics via
>> >__GFP_RETRY_MAYFAIL when we attempt to exhaust system memory on any
>> >request - valid or otherwise).
>>
>> I think T. J. also agree with me on what I shared.
>>   if (len / PAGE_SIZE > totalram_pages()) return ERR_PTR(-ENOMEM);
>>   #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP | __GFP_RETRY_MAYFAIL)
>>
>Oh yeah, sorry if that wasn't clear. I was referring to your updated
>check for just totalram_pages() above, not totalram_pages() / 2.
>

Yes I thought you meant that. Thank you.
If there is no objection, I will resend with that, totalram_pages (not / 2) and
__GFP_RETRY_MAYFAIL.

>> Regarding the dma-buf behavior, I also would like to say that the dma-buf
>> system heap seems to be designed to allocate that large memory. In mobile
>> devices, we need that large memory for camera buffers or grahpics
>> rendendering buffers. So that large memory should be allowed but the invalid
>> huge size over ram should be avoided.
>>
>> I agree on that mm should reclaim even for the large size. But that reclaim
>> process may affect system performance or user convenience. In that perspective
>> I thought ram / 2 was reasonable, but yes not a golden value. I hope to use
>> just ram size as sanity check.
>>
>> Additionally if all agree, we may be able to apply __GFP_RETRY_MAYFAIL too.
>>
>> BR
