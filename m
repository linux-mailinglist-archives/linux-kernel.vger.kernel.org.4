Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983472F2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbjFNDRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjFNDRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:17:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FB196;
        Tue, 13 Jun 2023 20:17:40 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QgrC13tSJztQlW;
        Wed, 14 Jun 2023 11:15:09 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 11:17:38 +0800
Subject: Re: [PATCH net-next v4 3/5] page_pool: introduce page_pool_alloc()
 API
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
 <20230612130256.4572-4-linyunsheng@huawei.com>
 <d4424b60-9a9c-a741-86e3-e712960cdf44@intel.com>
 <9f861b07-78e4-c18c-d1a5-d61f3cf42e3f@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a1bb6b16-9f56-a8e8-0720-780cd1d87111@huawei.com>
Date:   Wed, 14 Jun 2023 11:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <9f861b07-78e4-c18c-d1a5-d61f3cf42e3f@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 21:11, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Tue, 13 Jun 2023 15:08:41 +0200
> 
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Date: Mon, 12 Jun 2023 21:02:54 +0800
>>
>>> Currently page pool supports the below use cases:
>>> use case 1: allocate page without page splitting using
>>>             page_pool_alloc_pages() API if the driver knows
>>>             that the memory it need is always bigger than
>>>             half of the page allocated from page pool.
>>> use case 2: allocate page frag with page splitting using
>>>             page_pool_alloc_frag() API if the driver knows
>>>             that the memory it need is always smaller than
>>>             or equal to the half of the page allocated from
>>>             page pool.
>>>
>>> There is emerging use case [1] & [2] that is a mix of the
>>> above two case: the driver doesn't know the size of memory it
>>> need beforehand, so the driver may use something like below to
>>> allocate memory with least memory utilization and performance
>>> penalty:
>>>
>>> if (size << 1 > max_size)
>>> 	page = page_pool_alloc_pages();
>>> else
>>> 	page = page_pool_alloc_frag();
>>>
>>> To avoid the driver doing something like above, add the
>>> page_pool_alloc() API to support the above use case, and update
>>> the true size of memory that is acctually allocated by updating
>>> '*size' back to the driver in order to avoid the truesize
>>> underestimate problem.
>>>
>>> 1. https://lore.kernel.org/all/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/
>>> 2. https://lore.kernel.org/all/20230526054621.18371-3-liangchen.linux@gmail.com/
>>>
>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>> CC: Lorenzo Bianconi <lorenzo@kernel.org>
>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>> ---
>>>  include/net/page_pool.h | 43 +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 43 insertions(+)
>>>
>>> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
>>> index 0b8cd2acc1d7..c135cd157cea 100644
>>> --- a/include/net/page_pool.h
>>> +++ b/include/net/page_pool.h
>>> @@ -260,6 +260,49 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
>>>  	return page_pool_alloc_frag(pool, offset, size, gfp);
>>>  }
>>>  
>>> +static inline struct page *page_pool_alloc(struct page_pool *pool,
>>> +					   unsigned int *offset,
>>> +					   unsigned int *size, gfp_t gfp)
>>
>> Oh, really nice. Wouldn't you mind if I base my series on top of this? :)

No, I wouldn't mind. I am glad that if using the new API can both save memory
and improve performance for your case:)

>>
>> Also, with %PAGE_SIZE of 32k+ and default MTU, there is truesize
>> underestimation. I haven't looked at the latest conversations as I had a
>> small vacation, sowwy :s What's the current opinion on this?
> 
> Please ignore this, seems like I didn't manage to read 2 lines below,
> you explicitly mention in the comment that you already handle this >_<
> 
> Thanks,
> Olek
> 
> .
> 
