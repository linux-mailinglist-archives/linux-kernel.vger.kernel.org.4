Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5C6A8EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCCBnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjCCBm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:42:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E0559C3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:42:38 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PSW10095hzrS80;
        Fri,  3 Mar 2023 09:41:56 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 09:42:04 +0800
Message-ID: <927fbb66-ee80-2ec4-60d1-1cda23b3cb19@huawei.com>
Date:   Fri, 3 Mar 2023 09:42:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm/damon/paddr: minor refactor of
 damon_pa_pageout()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>
References: <20230302164706.85999-1-sj@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230302164706.85999-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/3 0:47, SeongJae Park wrote:
> Hi Kefeng,
> 
> On Thu, 2 Mar 2023 22:49:26 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Omit two lines by converting if(!folio_isolate_lru()) to
>> if(folio_isolate_lru()).
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/damon/paddr.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 6c655d9b5639..a557f3c9300f 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -246,14 +246,12 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>>   
>>   		folio_clear_referenced(folio);
>>   		folio_test_clear_young(folio);
>> -		if (!folio_isolate_lru(folio)) {
>> -			folio_put(folio);
>> -			continue;
>> +		if (folio_isolate_lru(folio)) {
>> +			if (folio_test_unevictable(folio))
>> +				folio_putback_lru(folio);
>> +			else
>> +				list_add(&folio->lru, &folio_list);
>>   		}
>> -		if (folio_test_unevictable(folio))
>> -			folio_putback_lru(folio);
>> -		else
>> -			list_add(&folio->lru, &folio_list);
>>   		folio_put(folio);
>>   	}
> 
> This looks ok to me, thank you for your effort!  Nevertheless, I don't like
> increasing depth as much as number of lines.  The
> more-than-3-levels-of-indentation[1] warning is not always right, but this 4
> levels of indentation is not making me so exciting.
> 
> What do you think about adding put_continue label and using it, not only here,
> but also above part?  For example:
> 
>      --- a/mm/damon/paddr.c
>      +++ b/mm/damon/paddr.c
>      @@ -239,21 +239,18 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>                      if (!folio)
>                              continue;
>      
>      -               if (damos_pa_filter_out(s, folio)) {
>      -                       folio_put(folio);
>      -                       continue;
>      -               }
>      +               if (damos_pa_filter_out(s, folio))
>      +                       goto put_continue;
>      
>                      folio_clear_referenced(folio);
>                      folio_test_clear_young(folio);
>      -               if (!folio_isolate_lru(folio)) {
>      -                       folio_put(folio);
>      -                       continue;
>      -               }
>      +               if (!folio_isolate_lru(folio))
>      +                       goto put_continue;
>                      if (folio_test_unevictable(folio))
>                              folio_putback_lru(folio);
>                      else
>                              list_add(&folio->lru, &folio_list);
>      +put_continue:
>                      folio_put(folio);
>              }
>              applied = reclaim_pages(&folio_list);
> 
> It omits three lines.

It looks good, will update, thanks

> 
>      $ git diff --stat
>       mm/damon/paddr.c | 13 +++++--------
>       1 file changed, 5 insertions(+), 8 deletions(-)
> 
> [1] https://docs.kernel.org/process/coding-style.html#indentation
> 
> 
> Thanks,
> SJ
> 
>>   	applied = reclaim_pages(&folio_list);
>> -- 
>> 2.35.3
>>
>>
