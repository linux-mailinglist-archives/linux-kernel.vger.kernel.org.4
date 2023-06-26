Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EB73D594
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFZBnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZBns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:43:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CEA196
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:43:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qq9XL4nh6zMpZD;
        Mon, 26 Jun 2023 09:40:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 09:43:44 +0800
Subject: Re: [PATCH] mm: memory-failure: remove unneeded page state check in
 shake_page()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20230625113430.2310385-1-linmiaohe@huawei.com>
 <20230626005221.GA353339@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2cd57a67-1cb2-83b8-3f73-6da72cd6159d@huawei.com>
Date:   Mon, 26 Jun 2023 09:43:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230626005221.GA353339@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/26 8:52, Naoya Horiguchi wrote:
> On Sun, Jun 25, 2023 at 07:34:30PM +0800, Miaohe Lin wrote:
>> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
>> are not shrunk now. This check can be added back when a lightweight range
>> based shrinker is available.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> This looks to me a good cleanup because the result of
> "if (PageLRU(p) || is_free_buddy_page(p))" check is not used, so the check
> itself is unneeded.
> 
>> ---
>>  mm/memory-failure.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 5b663eca1f29..92f951df3e87 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -373,11 +373,10 @@ void shake_page(struct page *p)
>>  	if (PageHuge(p))
>>  		return;
>>  
>> -	if (!PageSlab(p)) {
>> -		lru_add_drain_all();
>> -		if (PageLRU(p) || is_free_buddy_page(p))
>> -			return;
>> -	}
>> +	if (PageSlab(p))
>> +		return;
>> +
>> +	lru_add_drain_all();
>>  
>>  	/*
>>  	 * TODO: Could shrink slab caches here if a lightweight range-based
> 
> I think that this TODO comment can be put together with "if (PageSlab)" block.

Thanks for your comment and advice. Do you mean something like below?

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b663eca1f29..66e7b3ceaf2d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -372,17 +372,14 @@ void shake_page(struct page *p)
 {
        if (PageHuge(p))
                return;
-
-       if (!PageSlab(p)) {
-               lru_add_drain_all();
-               if (PageLRU(p) || is_free_buddy_page(p))
-                       return;
-       }
-
        /*
         * TODO: Could shrink slab caches here if a lightweight range-based
         * shrinker will be available.
         */
+       if (PageSlab(p))
+               return;
+
+       lru_add_drain_all();
 }
 EXPORT_SYMBOL_GPL(shake_page);

Thanks.
