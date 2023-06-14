Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82A72FD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbjFNLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244496AbjFNLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:55:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053961BF3;
        Wed, 14 Jun 2023 04:55:23 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qh3hM3SHRztQq3;
        Wed, 14 Jun 2023 19:52:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:55:20 +0800
Subject: Re: [PATCH net-next v4 2/5] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
 <20230612130256.4572-3-linyunsheng@huawei.com>
 <20230613213317.4eb4be7c@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <84100dd1-b005-5b03-fe3e-838a08640b8e@huawei.com>
Date:   Wed, 14 Jun 2023 19:55:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230613213317.4eb4be7c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/6/14 12:33, Jakub Kicinski wrote:
> On Mon, 12 Jun 2023 21:02:53 +0800 Yunsheng Lin wrote:
>>  static inline void page_pool_fragment_page(struct page *page, long nr)
>>  {
>> -	atomic_long_set(&page->pp_frag_count, nr);
>> +	if (!PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
>> +		atomic_long_set(&page->pp_frag_count, nr);
> 
> why not let the driver take references on the page count in this case?
> I'm not saying it's worth the effort, but a comment may be useful?

I suppose page count refers to page->_refcount, right?
Page pool can only hold one reference for page->_refcount, so that
it can use that to decide if the netstack or other subsystem have
taken additional reference on that page in __page_pool_put_page():

https://elixir.bootlin.com/linux/v6.4-rc6/source/net/core/page_pool.c#L591

> 
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 9c4118c62997..69e3c5175236 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -352,6 +352,14 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>>  {
>>  	page->pp = pool;
>>  	page->pp_magic |= PP_SIGNATURE;
>> +
>> +	/* Ensuring all pages have been split into one big frag initially:
> 
> Again, I find the "one big frag" slightly confusing.
> Maybe we should rename pp_frag_cnt into pp_refcnt?
> After this series is looks even more like a page pool reference
> count rather than some form of number of fragments.

It depends on how you look at it, perhaps we can see page->pp_frag_count
being one as the page being split into one frag?

Using pp_refcnt may cause confusing for cases in page_pool_alloc_frag().

> 
>> +	 * page_pool_set_pp_info() is only called once for every page when it
>> +	 * is allocated from the page allocator and page_pool_fragment_page()
>> +	 * is dirtying the same cache line as the page->pp_magic above, so
>> +	 * the overhead is negligible.
>> +	 */
>> +	page_pool_fragment_page(page, 1);
>>  	if (pool->p.init_callback)
>>  		pool->p.init_callback(page, pool->p.init_arg);
>>  }
> 
> 
> .
> 
