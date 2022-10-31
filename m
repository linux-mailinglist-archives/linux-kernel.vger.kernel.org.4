Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620BF612F56
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 04:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJaDhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 23:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaDhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:37:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9195A0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 20:37:38 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N0zKx0pf5zJnM2;
        Mon, 31 Oct 2022 11:34:45 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 11:37:36 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 11:37:36 +0800
Message-ID: <316bc0a2-34d9-e485-11d2-f3dffd0fdea4@huawei.com>
Date:   Mon, 31 Oct 2022 11:37:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm: fix pcp count beyond pcp high in pcplist allocation
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
References: <20221024134146.3442393-1-chenwandun@huawei.com>
 <20221024145555.oaoisy6m723h4axc@techsingularity.net>
 <f189c530-1576-21fa-4c12-caa62739bbd0@huawei.com>
 <20221025131959.sd47fipimhehf76i@techsingularity.net>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20221025131959.sd47fipimhehf76i@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/25 21:19, Mel Gorman 写道:
> On Tue, Oct 25, 2022 at 07:49:59PM +0800, Chen Wandun wrote:
>>
>> On 2022/10/24 22:55, Mel Gorman wrote:
>>> On Mon, Oct 24, 2022 at 09:41:46PM +0800, Chen Wandun wrote:
>>>> Nowadays there are several orders in pcplist, Function __rmqueue_pcplist
>>>> would alloc pcp batch pages to refill pcplist, when list of target order
>>>> if empty meanwhile other lists is not all empty, that result in pcp count
>>>> beyond pcp high after allocation. This behaviour can be easily observed by
>>>> adding debugging information in __rmqueue_pcplist.
>>>>
>>>> Fix this by recalculate the batch pages to be allocated.
>>> Are any problems observed other than the PCP lists temporarily exceed
>>> pcp->high?
>> It will result frequently refill pcp page from buddy and release pcp page to
>> buddy.
> Under what circumstances does this causes a problem? I 100% accept that it
Sorry for long time no reply.

It is hard to say this phenomenon would cause functional problem, I just 
found
this phenomenon and wonder if something can be improve.

> could happen but one downside of the patch is that it simply changes the
> shape of the problem. If the batch refill is clamped then potentially the
> PCP list is depleted quicker and needs to be refilled sooner and so zone
> lock acquisitions are still required potentially higher frequency due to
> clamped refill sizes. All that changes is the timing.
Agree,  the contention of zone-lock need more consideration.
>
>>>    As is, the patch could result in a batch request of 0 and
>>   I foget this, the patch need some improve, thanks.
>>
>>> fall through to allocating from the zone list anyway defeating the
>>> purpose of the PCP allocator and probably regressing performance in some
>>> csaes.
>> Same as I understand???how about set high/batch for each order in pcplist???
> Using anything would than (X >> order) consumes storage. Even if storage
> was to be used, selecting a value per-order would be impossible because
> the correct value would depend on frequency of requests for each order.
> That can only be determined at runtime and the cost of determining the
> value would likely exceed the benefit.
Can we set a experience value for pcp batch for each order during init 
stage?
If so we can make accurately control for pcp size. Nowdays, the size of each
order in pcp list is full of randomness. I dont konw which scheme is better
for performance.

>
> At most, you could state that the batch refill should at least be 1 but
> otherwise not exceed high. The downside is that zone->lock contention will
> increase for a stream of THP pages which is a common allocation size.
> The intent behind batch-2 was to reduce contention by 50% when multiple
> processes are faulting large anonymous regions at the same time. THP
> allocations are ones most likely to exceed pcp->high by a noticeable amount.
>
>> or just share pcp batch value only set high for each order? It looks like
>> strange for pcp count beyond pcp high in common case.
>>
>> If each order has it's own pcp high value, that behaviour is same as pcplist
>> which
>> only contains order 0.
>>
> Specify in the changelog how a workload is improved. That may be in terms
> of memory usage, performance, zone lock contention or cases where pcp->high
> being exceeded causes a functional problem on a particular class of
> system.
Got it, thanks.
>

