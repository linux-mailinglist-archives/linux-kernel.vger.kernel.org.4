Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BA774ED2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGKLrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGKLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:47:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385611D;
        Tue, 11 Jul 2023 04:47:17 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0fCg0kY5zMqWb;
        Tue, 11 Jul 2023 19:43:59 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 19:47:15 +0800
Subject: Re: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <yunshenglin0825@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
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
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
 <bc495d87-3968-495f-c672-bf1bab38524a@intel.com>
 <4946b9df-66ea-d184-b97c-0ba687e41df8@gmail.com>
 <95c5ba92-bccd-6a9a-5373-606a482e36a3@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <558849ff-6b68-7547-cf99-36801ff24c25@huawei.com>
Date:   Tue, 11 Jul 2023 19:47:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <95c5ba92-bccd-6a9a-5373-606a482e36a3@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/7/10 21:34, Alexander Lobakin wrote:
> From: Yunsheng Lin <yunshenglin0825@gmail.com>
> Date: Sun, 9 Jul 2023 13:16:39 +0800
> 
>> On 2023/7/7 0:38, Alexander Lobakin wrote:
>>
>> ...
>>  
>>>>
>>>>>  /**
>>>>> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
>>>>>   **/
>>>>>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>>>>>  {
>>>>> -	struct device *dev = rx_ring->dev;
>>>>> -	int bi_size;
>>>>> +	struct page_pool *pool;
>>>>> +
>>>>> +	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
>>>>> +					 rx_ring->count);
>>>>
>>>> If a page is able to be spilt between more than one desc, perhaps the
>>>> prt_ring size does not need to be as big as rx_ring->count.
>>>
>>> But we doesn't know in advance, right? Esp. given that it's hidden in
>>> the lib. But anyway, you can only assume that in regular cases if you
>>> always allocate frags of the same size, PP will split pages when 2+
>>> frags can fit there or return the whole page otherwise, but who knows
>>> what might happen.
>>
>> It seems intel driver is able to know the size of memory it needs when
>> creating the ring/queue/napi/pp, maybe the driver only tell the libie
>> how many descs does it use for queue, and libie can adjust it accordingly?
> 
> But libie can't say for sure how PP will split pages for it, right?
> 
>>
>>> BTW, with recent recycling optimization, most of recycling is done
>>> directly through cache, not ptr_ring. So I'd even say it's safe to start
>>> creating smaller ptr_rings in the drivers.
>>
>> The problem is that we may use more memory than before for certain case
>> if we don't limit the size of ptr_ring, unless we can ensure all of
>> recycling is done directly through cache, not ptr_ring.
> Also not sure I'm following =\

Before adding page pool support, the max memory used in the driver is as
below:
rx_ring->count * PAGE_SIZE;

After adding page pool support, the max memory used in the driver is as
below:

ptr_ring->size * PAGE_SIZE +
PP_ALLOC_CACHE_SIZE * PAGE_SIZE +
rx_ring->count * PAGE_SIZE / pp.init_arg

> 
> [...]
> 
> Thanks,
> Olek
> 
> .
> 
