Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6F6CD04F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC2Cq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjC2Cq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:46:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D82D7F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 19:46:24 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230329024620epoutp020bcaf020062178fbb494fa30a47af150~Qw9Tg4ska0706507065epoutp02P
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:46:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230329024620epoutp020bcaf020062178fbb494fa30a47af150~Qw9Tg4ska0706507065epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680057980;
        bh=kjjYVEOGZcv9UX/THsps8c19Fgzn0ur8ENOOfxKfTu8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=KklhK7bE2lUsP/hW1UW9ftOzGWzTP2bPVSbmwqL12lKnjIlss2JDHj/+OVI6nnutk
         8fQ21+rMTB1QOsg9sLxwsLfWjcrO/FTul2u1GboPh67srEz7i07PAaxppL3PKlrfI9
         iFK2lP/9H9BHCn1daCP1v1qvtITYkjTQuOyTV35c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230329024619epcas1p131e8aebec5086d0aefd050dec86cdd4c~Qw9TCt-4Y2296622966epcas1p1d;
        Wed, 29 Mar 2023 02:46:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PmWCH1Vhsz4x9Ps; Wed, 29 Mar
        2023 02:46:19 +0000 (GMT)
X-AuditID: b6c32a39-29ffca800000d627-40-6423a67b6343
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.4D.54823.B76A3246; Wed, 29 Mar 2023 11:46:19 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     John Stultz <jstultz@google.com>
CC:     "tjmercier@google.com" <tjmercier@google.com>,
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
In-Reply-To: <CANDhNCpNDvK3uKvamNwrxpsaqFZH24BBLrdFUo0Uucu1ic0WdA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230329024618epcms1p7cfbe08918398104667ef0b7859a6ffa4@epcms1p7>
Date:   Wed, 29 Mar 2023 11:46:18 +0900
X-CMS-MailID: 20230329024618epcms1p7cfbe08918398104667ef0b7859a6ffa4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmnm71MuUUg58HWC3mrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4s+JjWwWl3fNYbO4t+Y/q8Xrb8uYLU7d/cxu8W79FzYHbo/Db94z
        e+z9toDFY+esu+weCzaVemxa1cnmsenTJHaPO9f2sHmcmPGbxaNvyypGj8+b5AK4orJtMlIT
        U1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVlIoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ7yc3sZe
        8E2gYuWhSSwNjLd4uxg5OSQETCQ+nV/P2MXIxSEksINRYvGLTSxdjBwcvAKCEn93CIOYwgLZ
        EgtbU0DKhQSUJM7+uMIOYgsLWEvsXzSDCcRmE7CU2H5zIiOILSKgIvFw7k82kJHMAheZJV69
        nc0MsYtXYkb7UxYIW1pi+/KtYA2cAoESJ28cYYSIi0rcXP2WHcZ+f2w+VFxEovXeWag5ghIP
        fu5mhJnz5/hzNgi7WGJZ5wMmCLtGYsW5VVBxc4mGtyvBbF4BX4lFF2aD1bAIqEo8u/YXqsZF
        oufQXrDbmAXkJba/ncMM8juzgKbE+l36ECWKEjt/z2WEKOGTePe1hxXmrR3znkCtVZNoefYV
        Ki4j8fffMyjbQ2L2tfOskGA+zSjx/GkP2wRGhVmIkJ6FZPMshM0LGJlXMYqlFhTnpqcWGxaY
        wiM3OT93EyM48WpZ7mCc/vaD3iFGJg7GQ4wSHMxKIry/rymlCPGmJFZWpRblxxeV5qQWH2I0
        Bfp5IrOUaHI+MPXnlcQbmlgamJgZmVgYWxqbKYnzitueTBYSSE8sSc1OTS1ILYLpY+LglGpg
        Et4caHrmXpLIn/8lb8/Mv7yj6M9RqZAXEgqrH9yuWHW1uXfCfNVPuqu3+t/oTXZl+pf5NieT
        od24tCAsP6r7aLi61e3zHV92TDe83/InV2CuRnjWbsV/haffs/Bsuqwwae/SrfOmn2KXCeH+
        ZLzhSKyPWUix5oZp9yYZW3+cr/pISObq5lqniCtOIY+sxJojNkz0+nhp/8JtFhVMh02ezbO+
        YBjEbb9XnOu0ey/zfcVKrpnsZ5af2PSo1SU5d5VOgJiA3v6U8PAi2ehuxTrTHZeTIjIN98Zt
        8d94aK9vfuY03lNdDJOUTqws+e+trOezT/jFSZMO+Zvuq21WP/BzW9O8yzHnaIfoz2XrDqrO
        UGIpzkg01GIuKk4EAIOUpixFBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2
References: <CANDhNCpNDvK3uKvamNwrxpsaqFZH24BBLrdFUo0Uucu1ic0WdA@mail.gmail.com>
        <20230328125818.5574-1-jaewon31.kim@samsung.com>
        <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcms1p7>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>--------- Original Message ---------
>Sender : John Stultz <jstultz@google.com>
>Date : 2023-03-29 03:26 (GMT+9)
>Title : Re: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow and list bugs in system heap:
> 
>On Tue, Mar 28, 2023 at 5:58 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>
>> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>>   free_cma:200844kB
>> Out of memory and no killable processes...
>> Kernel panic - not syncing: System is deadlocked on memory
>>
>> An OoM panic was reported, there were only native processes which are
>> non-killable as OOM_SCORE_ADJ_MIN.
>>
>> After looking into the dump, I've found the dma-buf system heap was
>> trying to allocate a huge size. It seems to be a signed negative value.
>>
>> dma_heap_ioctl_allocate(inline)
>>     |  heap_allocation = 0xFFFFFFC02247BD38 -> (
>>     |    len = 0xFFFFFFFFE7225100,
>>
>> Actually the old ion system heap had policy which does not allow that
>> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
>> bugs in system heap"). We need this change again. Single allocation
>> should not be bigger than half of all memory.
>>
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>
>Hey,
>  Thanks so much for sending this out! Looks reasonable to me, the
>only issue is the commit subject line could be a bit better.
>
>Maybe instead:
>  "dma-buf/heaps: system_heap: Avoid DoS by limiting single
>allocations to half of all memory"
>
>Otherwise,
>Acked-by: John Stultz <jstultz@google.com>
>
>thanks
>-john
>

Hello John

Thank you for your Acked. and the subject thing.
Maybe I was in a hurry, I did not check it.

I am going to take yours

"dma-buf/heaps: system_heap: Avoid DoS by limiting single
allocations to half of all memory"

By the way let me talk with T.J.

Thank you
Jaewon Kim
