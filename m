Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3060CB40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiJYLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiJYLuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:50:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781B2CDCE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:50:01 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxVXC2mSdzpVX8;
        Tue, 25 Oct 2022 19:46:35 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:50:00 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:49:59 +0800
Message-ID: <f189c530-1576-21fa-4c12-caa62739bbd0@huawei.com>
Date:   Tue, 25 Oct 2022 19:49:59 +0800
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
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20221024145555.oaoisy6m723h4axc@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/10/24 22:55, Mel Gorman wrote:
> On Mon, Oct 24, 2022 at 09:41:46PM +0800, Chen Wandun wrote:
>> Nowadays there are several orders in pcplist, Function __rmqueue_pcplist
>> would alloc pcp batch pages to refill pcplist, when list of target order
>> if empty meanwhile other lists is not all empty, that result in pcp count
>> beyond pcp high after allocation. This behaviour can be easily observed by
>> adding debugging information in __rmqueue_pcplist.
>>
>> Fix this by recalculate the batch pages to be allocated.
> Are any problems observed other than the PCP lists temporarily exceed
> pcp->high?
It will result frequently refill pcp page from buddy and release pcp 
page to buddy.
>   As is, the patch could result in a batch request of 0 and
  I foget this, the patch need some improve, thanks.
> fall through to allocating from the zone list anyway defeating the
> purpose of the PCP allocator and probably regressing performance in some
> csaes.
Same as I understand，how about set high/batch for each order in pcplist，
or just share pcp batch value only set high for each order?  It looks like
strange for pcp count beyond pcp high in common case.

If each order has it's own pcp high value, that behaviour is same as 
pcplist which
only contains order 0.

Thanks
Wandun.
>
> The intention was to allow high to be briefly exceeded on the refill side,
> particularly for THP pages and to always refill by at least two pages. In
> the THP case, one would be allocated and maybe one in the near future
> without acquiring the zone lock. If the limits are exceeded, it's only
> exceeded until the next free.
>

