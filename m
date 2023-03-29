Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A666CD088
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC2DNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2DNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:13:09 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039961991
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:13:07 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230329031303epoutp04c3467e4b854c05be54d38e23dfd73a07~QxUpPy7Ab2167721677epoutp04D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230329031303epoutp04c3467e4b854c05be54d38e23dfd73a07~QxUpPy7Ab2167721677epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680059584;
        bh=q5f1q78gmgBWqHYO0lFrQ850wXFnqMYPwTbcYcC4Ht4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=F4SmY+ueZy1nDNFBfxCgDv/1R3ghBe0jhHEoBn4EstIq6KDjsOJZnZmw5jVakla1P
         dRgLfKN3gt5mqVNjoYKLUey9c5ur7kztaONoUrl1kubMNIzxyNsLyMUwUr8jziDL/V
         k1iJORe7GT8JjNksyL98IBq8EX9u9jWXcqh78Gt8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230329031303epcas1p39f2b4899c15e93331f3efe12979350d3~QxUoaffmF1703917039epcas1p3l;
        Wed, 29 Mar 2023 03:13:03 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.224]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PmWp654hkz4x9Px; Wed, 29 Mar
        2023 03:13:02 +0000 (GMT)
X-AuditID: b6c32a38-39fff70000029402-31-6423acbe5b4a
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.B2.37890.EBCA3246; Wed, 29 Mar 2023 12:13:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "T.J. Mercier" <tjmercier@google.com>
CC:     "jstultz@google.com" <jstultz@google.com>,
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
In-Reply-To: <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc@epcms1p6>
Date:   Wed, 29 Mar 2023 12:13:02 +0900
X-CMS-MailID: 20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmge6+NcopBnMuqFjMWb+GzeLlIU2L
        hQ/vMlus3uRr0b15JqNF7/tXTBZ/Tmxks7i8aw6bxb01/1ktXn9bxmxx6u5ndot367+wOfB4
        HH7zntlj77cFLB47Z91l91iwqdRj06pONo9Nnyaxe9y5tofN48SM3ywefVtWMXp83iQXwBWV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLWSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj
        ++7TTAX3xCtubvrB3sC4R7iLkZNDQsBEomHHZcYuRi4OIYEdjBI7Nu5n62Lk4OAVEJT4u0MY
        xBQWyJZY2JoCUi4koCRx9scVdhBbWEBXoql7NQuIzSagLfF+wSRWEFtEQFPi2vPNLCAjmQXO
        MkusXvqDCWIXr8SM9qcsELa0xPblWxlBbE6BQIll/ZehakQlbq5+yw5jvz82nxHCFpFovXeW
        GcIWlHjwczcjzJw/x5+zQdjFEss6H0DNqZFYcW4VVNxcouHtSjCbV8BX4tid+2A2i4CqxMof
        U6HqXSRePV0DNp9ZQF5i+9s5zCC/MwM9s36XPkSJosTO33MZYV5p2PibHZ3NLMAn8e5rDytM
        fMe8J1Dj1SRann2FistI/P33jHUCo9IsREDPQrJ4FsLiBYzMqxjFUguKc9NTiw0LTOBxm5yf
        u4kRnH61LHYwzn37Qe8QIxMH4yFGCQ5mJRHe39eUUoR4UxIrq1KL8uOLSnNSiw8xmgK9PJFZ
        SjQ5H5gB8kriDU0sDUzMjEwsjC2NzZTEecVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MOnlGW5/
        eE2z6J4xz2K/B9XRS65v9etcc5DR1SVbcA6Xh2N/y+xvH82K+6axPvi34qNk0C3RvQwPhH27
        nHy63hadrg478iZvxsIla0yn7TeXCn2wuOTTDL78TJsM1T06nz4Vrrl9+Z1r8nW9ylOnLWc4
        /zNRq596L6rMRiv2i9kdw2kbxbzm/tU1nhvtc8hb9fHuDwkZYlfDp0yaIa8coVcmU/P92t+7
        4cE/A5LP54lI6L4tDJm7j0F0g+6cfebeiWlCHJnBx55qndxWV2aiLdh27aiJl/CsUt/VXJPN
        192WeqL2Q802PmipQnzPfdPujm0zlYMMAjks475m+6QLq9r/Fiu/bbzK3FDk9FY7JZbijERD
        Leai4kQA83/+7EgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2
References: <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com>
        <20230328125818.5574-1-jaewon31.kim@samsung.com>
        <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcms1p6>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Mar 28, 2023 at 5:58?AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
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
>> ---
>>  drivers/dma-buf/heaps/system_heap.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>> index e8bd10e60998..4c1ef2ecfb0f 100644
>> --- a/drivers/dma-buf/heaps/system_heap.c
>> +++ b/drivers/dma-buf/heaps/system_heap.c
>> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>>         struct page *page, *tmp_page;
>>         int i, ret = -ENOMEM;
>>
>> +       if (len / PAGE_SIZE > totalram_pages() / 2)
>> +               return ERR_PTR(-ENOMEM);
>> +
>
>Instead of policy like that, would __GFP_RETRY_MAYFAIL on the system
>heap's LOW_ORDER_GFP flags also avoid the panic, and eventually fail
>the allocation request?

Hello T.J.

Thank you for your opinion.
The __GFP_RETRY_MAYFAIL on LOW_ORDER_GFP seems to work.

page allocation failure: order:0, mode:0x144dc2(GFP_HIGHUSER|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_ZERO)
Node 0 active_anon:120kB inactive_anon:43012kB active_file:36kB inactive_file:788kB 

I tried to test it, and the allocation stopped at very low file cache situation without OoM panic
as we expected. The phone device was freezing for few seconds though.

We can avoid OoM panic through either totalram_pages() / 2 check or __GFP_RETRY_MAYFAIL.

But I think we still need the totalram_pages() / 2 check so that we don't have to suffer
the freezing in UX perspective. We may kill some critical processes or users' recent apps.

Regarding __GFP_RETRY_MAYFAIL, I think it will help us avoid OoM panic. But I'm worried
about low memory devices which still need OoM kill to get memory like in camera scenarios.

So what do you think?

Thank you
Jaewon Kim
