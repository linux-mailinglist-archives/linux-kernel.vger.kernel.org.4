Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E87505AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGLLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjGLLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:13:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F610FC;
        Wed, 12 Jul 2023 04:13:04 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1FSq5H8yz1JCVD;
        Wed, 12 Jul 2023 19:12:27 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 12 Jul
 2023 19:13:02 +0800
Subject: Re: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via
 Page Pool)
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     Yunsheng Lin <yunshenglin0825@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-6-aleksander.lobakin@intel.com>
 <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
 <09a9a9ef-cf77-3b60-2845-94595a42cf3e@intel.com>
 <71a8bab4-1a1d-cb1a-d75c-585a14c6fb2e@gmail.com>
 <b05d1a35-5bc5-b65d-b57d-5cc1b0f898cb@intel.com>
 <2ebd75df-51ff-4c62-2a68-d258dbf32b49@huawei.com>
 <89dc48ab-0800-b12f-7124-cecc709364d7@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <cf7dafbe-decc-623c-6322-d14dd8daee95@huawei.com>
Date:   Wed, 12 Jul 2023 19:13:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <89dc48ab-0800-b12f-7124-cecc709364d7@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/12 0:37, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Tue, 11 Jul 2023 19:39:28 +0800
> 
>> On 2023/7/10 21:25, Alexander Lobakin wrote:
>>> From: Yunsheng Lin <yunshenglin0825@gmail.com>
>>> Date: Sun, 9 Jul 2023 13:16:33 +0800
>>>
>>>> On 2023/7/7 0:28, Alexander Lobakin wrote:
>>>>> From: Yunsheng Lin <linyunsheng@huawei.com>
>>>>> Date: Thu, 6 Jul 2023 20:47:28 +0800
>>>>>
>>>>>> On 2023/7/5 23:55, Alexander Lobakin wrote:
>>>>>>
>>>>>>> +/**
>>>>>>> + * libie_rx_page_pool_create - create a PP with the default libie settings
>>>>>>> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
>>>>>>> + * @size: size of the PP, usually simply Rx queue len
>>>>>>> + *
>>>>>>> + * Returns &page_pool on success, casted -errno on failure.
>>>>>>> + */
>>>>>>> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
>>>>>>> +					    u32 size)
>>>>>>> +{
>>>>>>> +	struct page_pool_params pp = {
>>>>>>> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>>>>>> +		.order		= LIBIE_RX_PAGE_ORDER,
>>>>>>> +		.pool_size	= size,
>>>>>>> +		.nid		= NUMA_NO_NODE,
>>>>>>> +		.dev		= napi->dev->dev.parent,
>>>>>>> +		.napi		= napi,
>>>>>>> +		.dma_dir	= DMA_FROM_DEVICE,
>>>>>>> +		.offset		= LIBIE_SKB_HEADROOM,
>>>>>>
>>>>>> I think it worth mentioning that the '.offset' is not really accurate
>>>>>> when the page is split, as we do not really know what is the offset of
>>>>>> the frag of a page except for the first frag.
>>>>>
>>>>> Yeah, this is read as "offset from the start of the page or frag to the
>>>>> actual frame start, i.e. its Ethernet header" or "this is just
>>>>> xdp->data - xdp->data_hard_start".
>>>>
>>>> So the problem seems to be if most of drivers have a similar reading as
>>>> libie does here, as .offset seems to have a clear semantics which is used
>>>> to skip dma sync operation for buffer range that is not touched by the
>>>> dma operation. Even if it happens to have the same value of "offset from
>>>> the start of the page or frag to the actual frame start", I am not sure
>>>> it is future-proofing to reuse it.
>>>
>>> Not sure I'm following :s
>>
>> It would be better to avoid accessing the internal data of the page pool
>> directly as much as possible, as that may be changed to different meaning
>> or removed if the implememtation is changed.
>>
>> If it is common enough that most drivers are using it the same way, adding
>> a helper for that would be great.
> 
> How comes page_pool_params is internal if it's defined purely by the
> driver and then exists read-only :D I even got warned in the adjacent
> thread that the Page Pool core code shouldn't change it anyhow.

Personally I am not one hundred percent convinced that page_pool_params
will not be changed considering the discussion about improving/replacing
the page pool to support P2P case.

> 
>>
>>>
>>>>
>>>> When page frag is added, I didn't really give much thought about that as
>>>> we use it in a cache coherent system.
>>>> It seems we might need to extend or update that semantics if we really want
>>>> to skip dma sync operation for all the buffer ranges that are not touched
>>>> by the dma operation for page split case.
>>>> Or Skipping dma sync operation for all untouched ranges might not be worth
>>>> the effort, because it might need a per frag dma sync operation, which is
>>>> more costly than a batched per page dma sync operation. If it is true, page
>>>> pool already support that currently as my understanding, because the dma
>>>> sync operation is only done when the last frag is released/freed.
>>>>
>>>>>
>>>>>>
>>>>>>> +	};
>>>>>>> +	size_t truesize;
>>>>>>> +
>>>>>>> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
>>>>
>>>> As mentioned above, if we depend on the last released/freed frag to do the
>>>> dma sync, the pp.max_len might need to cover all the frag.
>>>
>>>                                                ^^^^^^^^^^^^
>>>
>>> You mean the whole page or...?
>>
>> If we don't care about the accurate dma syncing, "cover all the frag" means
>> the whole page here, as page pool doesn't have enough info to do accurate
>> dma sync for now.
>>
>>> I think it's not the driver's duty to track all this. We always set
>>> .offset to `data - data_hard_start` and .max_len to the maximum
>>> HW-writeable length for one frame. We don't know whether PP will give us
>>> a whole page or just a piece. DMA sync for device is performed in the PP
>>> core code as well. Driver just creates a PP and don't care about the
>>> internals.
>>
>> There problem is that when page_pool_put_page() is called with a split
>> page, the page pool does not know which frag is freeing too.
>>
>> setting 'maximum HW-writeable length for one frame' only sync the first
>> frag of a page as below:
> 
> Maybe Page Pool should synchronize DMA even when !last_frag then?
> Setting .max_len to anything bigger than the maximum frame size you're
> planning to receive is counter-intuitive.

This is simplest way to support dma sync for page frag case, the question
is if the batching of the dma sync for all frag of a page can even out the
additional cost of dma sync for dma untouched range of a page.

> All three xdp_buff, xdp_frame and skb always have all info needed to
> determine which piece of the page we're recycling, it should be possible
> to do with no complications. Hypothetical forcing drivers to do DMA
> syncs on their own when they use frags is counter-intuitive as well,
> Page Pool should be able to handle this itself.
> 
> Alternatively, Page Pool may do as follows:
> 
> 1. !last_frag -- do nothing, same as today.
> 2. last_frag -- sync, but not [offset, offset + max_len), but
>    [offset, PAGE_SIZE).

When a frag is free, we don't know if it is the last frag or not for
now yet.

> 
> This would also cover non-HW-writeable pieces like 2th-nth frame's
> headroom and each frame's skb_shared_info, but it's the only alternative
> to syncing each frag separately.
> Yes, it's almost the same as to set .max_len to %PAGE_SIZE, but as I
> said, it feels weird to set .max_len to 4k when you allocate 2k frags.
> You don't know anyway how much of a page will be used.

In that that case, we may need to make it more generic for the case when
a page is spilt into more than two frags, especially for system with 64K
page size.

