Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D4733055
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbjFPLr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbjFPLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:47:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3B2D67;
        Fri, 16 Jun 2023 04:47:19 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QjHPQ4jc5zGpkt;
        Fri, 16 Jun 2023 19:44:10 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 19:47:16 +0800
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230609131740.7496-1-linyunsheng@huawei.com>
 <20230609131740.7496-4-linyunsheng@huawei.com>
 <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
 <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com>
 <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0345b6c4-18da-66d8-71a0-02620f9abe9e@huawei.com>
Date:   Fri, 16 Jun 2023 19:47:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/15 22:45, Alexander Duyck wrote:
>>
>> It seems that there are already some drivers which using the page pool
>> API with different frag size for almost every calling, the virtio_net
>> and veth are the obvious ones.
>>
>> When reviewing the page frag support for virtio_net, I found that it
>> was manipulating the page_pool->frag_offset directly to do something
>> as this patch does, see:
>>
>> https://lore.kernel.org/lkml/CAKhg4tL9PrUebqQHL+s7A6-xqNnju3erNQejMr7UFjwTaOduZw@mail.gmail.com/
>>
>> I am not sure we are both agreed that drivers should not be manipulating
>> the page_pool->frag_offset directly unless it is really necessary?
> 
> Agreed, they are doing something similar to this. The difference is
> though that they have chosen to do that. With your change you are
> forcing driver writers into a setup that will likely not work for
> most.
> 
>> For the specific case for virtio_net, it seems we have the below options:
>> 1. both the driver and page pool do not handle it.
>> 2. the driver handles it by manipulating the page_pool->frag_offset
>>    directly.
> 
> I view 2 as being the only acceptable approach. Otherwise we are
> forcing drivers into a solution that may not fit and forcing yet
> another fork of allocation setups. There is a reason vendors have

I respectly disagree with driver manipulating the page_pool->frag_offset
directly.

It is a implemenation detail which should be hiden from the driver:
For page_pool_alloc_frag() API, page_pool->frag_offset is not even
useful for arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true,
similar cases for page_pool_alloc() returning mono-frag if I understand
'mono-frag ' correctly.

IMHO, if the driver try to do the their own page spilting, it should
use it's own offset, not messing with the offset the page pool is using.
Yes, that may mean driver doing it's own page splitting and page pool
doing it's own page splitting for the same page if we really like to
make the best out of a page.

That way I see the page splitting in page pool as a way to share a
page between different desc, and page splitting in driver as way to
reclaim some memory for small packet, something like ena driver is
doing:
https://lore.kernel.org/netdev/20230612121448.28829-1-darinzon@amazon.com/T/

And hns3 driver has already done something similar for old per-desc
page flipping with 64K page size:

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c#L3737

As we have done the page splitting to share a page between different desc
in the page pool, I really double that the benefit will justify the
complexity of the page splitting in the driver.

> already taken the approach of manipulating frag_offset directly. In
> many cases trying to pre-allocate things just isn't going to work.

As above, I think the driver trying to do it's own splitting should use
it's own offset instead of page pool's frag_offset.

If the mlx5 way of doing page splitting in the driver is proved to be
useful, we should really provide some API to allow that to work in
arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true and make the page
splitting in the driver play along with the page splitting in the page
pool.

I am not sure if there is any other 'trying to pre-allocate things just
isn't going to work' case that I missed, it will be very appreciatived
if you can provide the complete cases here, so that we can discuss it
throughly.

> 
>> 3. the page pool handles it as this patch does.
> 
> The problem is the page pool isn't handling it. It is forcing the
> allocations larger without reporting them as of this patch. It is
> trying to forecast what the next request is going to be which is
> problematic since it doesn't have enough info to necessarily be making
> such assumptions.

We are talking about rx for networking, right? I think the driver
does not have that kind of enough info too, Or I am missing something
here?

> 
>> Is there any other options I missed for the specific case for virtio_net?
>> What is your perfer option? And why?
> 
> My advice would be to leave it to the driver.
> 
> What concerns me is that you seem to be taking the page pool API in a
> direction other than what it was really intended for. For any physical
> device you aren't going to necessarily know what size fragment you are
> working with until you have already allocated the page and DMA has
> been performed. That is why drivers such as the Mellanox driver are
> fragmenting in the driver instead of allocated pre-fragmented pages.

Why do you think using the page pool API to do the fragmenting in the
driver is the direction that page pool was intended for?

I thought page pool API was not intended for any fragmenting in the
first place by the disscusion in the maillist, I think we should be
more open about what direction the page pool API is heading to
considering the emerging use case:)

> 
>>>
>>> If you are going to go down this path then you should have a consumer
>>> for the API and fully implement it instead of taking half measures and
>>> making truesize underreporting worse by evicting pages earlier.
>>
>> I am not sure I understand what do you mean by "a consumer for the API",
>> Do you mean adding a new API something like page_pool_free() to do
>> something ligthweight, such as decrementing the frag user and adjusting
>> the frag_offset, which is corresponding to the page_pool_alloc() API
>> introduced in this patch?
> 
> What I was getting at is that if you are going to add an API you have
> to have a consumer for the API. That is rule #1 for kernel API
> development. You don't add API without a consumer for it. The changes
> you are making are to support some future implementation, and I see it
> breaking most of the existing implementation. That is my concern.

The patch is extending a new api, the behavior of current api is preserved
as much as possible, so I am not sure which implementation is broken by
this patch? How and why?

As for the '#1 for kernel API development', I think I had mention the
usecase it is intended for in the coverletter, and if I recall correctly,
the page_pool_fragment_page() API you added also do not come with a
actual consumer, I was overloaded at that time, so just toke a glance
and wonder why there was no user with a API added.

Anyway, as jesper was offering to help out, will add veth as a consumer
for the new api:)

> .
> 
