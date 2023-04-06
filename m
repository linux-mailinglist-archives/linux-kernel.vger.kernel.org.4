Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6196D8D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjDFCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:17:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35556EAF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:17:16 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230406021713epoutp0297bb5c0a00ebe1c2fb4b24d758de66b0~TNuLgNsUJ2536425364epoutp02b
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:17:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230406021713epoutp0297bb5c0a00ebe1c2fb4b24d758de66b0~TNuLgNsUJ2536425364epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680747434;
        bh=Gsn8ZXMRUAgEYhGAlwHvevdvZrEdTSi0OLncrBxsoqc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ERw/QcACtytT5nW9YauCxJqsQEzfYFBKu5suQOrdOUe5CHMGbUT0QzcxrqlNIBCOU
         s80Gj9U65JaFRP6kgz2gv9jESTq2TBl/9usw8FmuJ97vy44W2AY7PerJup0zW6PW/y
         0d06YVAwA3a+IZuLbl//cdTLn/6QwTiFuEhgibbI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230406021713epcas1p3b52018f8c71cc0e70c4b9507959d95f7~TNuKw_K6h2553625536epcas1p3O;
        Thu,  6 Apr 2023 02:17:13 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.242]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PsQB05wJSz4x9QG; Thu,  6 Apr
        2023 02:17:12 +0000 (GMT)
X-AuditID: b6c32a35-00ffd7000000d8eb-e3-642e2ba8cb6d
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.66.55531.8AB2E246; Thu,  6 Apr 2023 11:17:12 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
Date:   Thu, 06 Apr 2023 11:17:12 +0900
X-CMS-MailID: 20230406021712epcms1p216f274040d25d18380668ffbfa809c48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmnu4Kbb0Ug3dfdCzmrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wWr78tY7Y4dfczu8W79V/YHHg8
        Dr95z+yx99sCFo+ds+6yeyzYVOqxaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IrK
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulpJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ1x
        7eYV1oIm2YqVfVoNjA3iXYycHBICJhI7TrxnBbGFBHYwSuw9Vt/FyMHBKyAo8XeHMIgpLFAi
        MXm3AkSFksTZH1fYQWxhAV2Jpu7VLCA2m4C2xPsFk8CmiADFVz3fxdzFyMXBLHCQWeLktclM
        EKt4JWa0P2WBsKUlti/fyghicwp4S8z5cYYRIi4qcXP1W3YY+/2x+VBxEYnWe2eZIWxBiQc/
        dzPCzPlz/DkbhF0ssazzAdSuGokV51ZBxc0lGt6uBLN5BXwlmv/9BJvDIqAq0XzrPVS9i8Tp
        n9vAHmAWkJfY/nYOM8jvzAKaEut36UOUKErs/D2XEeaVho2/2dHZzAJ8Eu++9rDCxHfMewI1
        Xk2i5dlXqLiMxN9/z1gnMCrNQgT0LCSLZyEsXsDIvIpRLLWgODc9tdiwwBAes8n5uZsYwalX
        y3QH48S3H/QOMTJxMB5ilOBgVhLhVe3SShHiTUmsrEotyo8vKs1JLT7EaAr08kRmKdHkfGDy
        zyuJNzSxNDAxMzKxMLY0NlMS5/3yVDtFSCA9sSQ1OzW1ILUIpo+Jg1OqgameoSKZRy7GaIOF
        quGjCwGm/406Cj0fLVny/rrKpKADkfO+av+Vdzx8tbJkYzy3wYZNHO7brbb/3PBe2/r9fJ/k
        u37x7cyVEifqMnKCt4VtmF+dl9Kwe8eGmey/35heXi7Ec6Bg/93k0kuMSa13C/umbO/haPWa
        xlB0qeGNwyUNl4Mqh7vKfrs9uy2yPOo0o9unGSfDJP2q3ZY+ULEIeuQ4N0SB9cSRCdayIfU3
        8nfJHKxz3qKy8Yt7pIhw1vacS9nnOeUOtU6Ylz2hX/Dcr6dXXV9GnVlyxO7/tw063fs9q4tr
        epav7Hk61/XZNtUPnifctxxgn2rntmef6VvjV+dKN7q4vT+5gcFl48S9Ya5KLMUZiYZazEXF
        iQATvuQNRgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
        <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 06 Apr 2023 10:44:19 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> >> ...
>> >>
>> >> --- a/drivers/dma-buf/heaps/system_heap.c
>> >> +++ b/drivers/dma-buf/heaps/system_heap.c
>> >> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>> >>  	struct page *page, *tmp_page;
>> >>  	int i, ret = -ENOMEM;
>> >>  
>> >> +	if (len / PAGE_SIZE > totalram_pages() / 2)
>> >> +		return ERR_PTR(-ENOMEM);
>> >> +
>> >
>> >This seems so random.  Why ram/2 rather than ram/3 or 17*ram/35?
>> 
>> Hello
>> 
>> Thank you for your comment.
>> 
>> I just took the change from the old ion driver code, and actually I thought the
>> half of all memory is unrealistic. It could be unwanted size like negative,
>> or too big size which incurs slowness or OoM panic.
>> 
>> >
>> >Better behavior would be to try to allocate what the caller asked
>> >for and if that doesn't work out, fail gracefully after freeing the
>> >partial allocations which have been performed thus far.  If dma_buf
>> >is changed to do this then that change is useful in many scenarios other
>> >than this crazy corner case.
>> 
>> I think you would like __GFP_RETRY_MAYFAIL. Actually T.J. Mercier recommended
>> earlier, here's what we discussed.
>> https://lore.kernel.org/linux-mm/20230331005140epcms1p1ac5241f02f645e9dbc29626309a53b24@epcms1p1/
>> 
>> I just worried about a case in which we need oom kill to get more memory but
>> let me change my mind. That case seems to be rare. I think now it's time when
>> we need to make a decision and not to allow oom kill for dma-buf system heap
>> allocations.
>> 
>> But I still want to block that huge size over ram. For an unavailabe size,
>> I think, we don't have to do memory reclaim or killing processes, and we can
>> avoid freezing screen in user perspecitve.
>> 
>> This is eventually what I want. Can we check totalram_pages and and apply
>> __GFP_RETRY_MAYFAIL?
>> 
>> --- a/drivers/dma-buf/heaps/system_heap.c
>> +++ b/drivers/dma-buf/heaps/system_heap.c
>> @@ -41,7 +41,7 @@ struct dma_heap_attachment {
>>         bool mapped;
>>  };
>>  
>> -#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
>> +#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP | __GFP_RETRY_MAYFAIL)
>>  #define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
>>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>>         struct page *page, *tmp_page;
>>         int i, ret = -ENOMEM;
>>  
>> +       if (len / PAGE_SIZE > totalram_pages())
>> +               return ERR_PTR(-ENOMEM);
>
>We're catering for a buggy caller here, aren't we?  Are such large
>requests ever reasonable?
>
>How about we decide what's the largest reasonable size and do a
>WARN_ON(larger-than-that), so the buggy caller gets fixed?

Yes we're considering a buggy caller. I thought even totalram_pages() / 2 in
the old ion system is also unreasonable. To avoid the /2, I changed it to
totalram_pages() though.

Because userspace can request that size repeately, I think WARN_ON() may be
called to too often, so that it would fill the kernel log buffer.

Even we think WARN_ON_ONCE rather than WARN_ON, the buggy point is not kernel
layer. Unlike page fault mechanism, this dma-buf system heap gets the size from 
userspace, and it is allowing unlimited size. I think we can't fix the buggy
user space with the kernel warning log. So I think warning is not enough,
and we need a safeguard in kernel layer.
