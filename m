Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3F5EB617
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiI0AE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiI0AE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:04:56 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234272250F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:04:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQpHHcN_1664237089;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQpHHcN_1664237089)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 08:04:51 +0800
Message-ID: <0ebd4493-4de2-b862-10d1-09cee40a9d7b@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 08:04:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] mm/damon: rename sz_damon_region to
 damon_region_size
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220926161653.48710-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220926161653.48710-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/27 上午12:16, SeongJae Park 写道:
> On Mon, 26 Sep 2022 15:10:59 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Here, i rename sz_damon_region() to damon_region_size(), and move it to
>> "include/linux/damon.h", because in many places, we can to use this func.
> Good idea.
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h | 1 +
>>   mm/damon/core.c       | 6 +++---
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index ed5470f50bab..21f4bfd0f41f 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -524,6 +524,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
>>   void damon_destroy_region(struct damon_region *r, struct damon_target *t);
>>   int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>>   		unsigned int nr_ranges);
>> +unsigned long damon_region_size(struct damon_region *r);
> This name looks good enough, but I'd like to suggest damon_sz_region().  What
> do you think?
Yes,  the fisrt  i named damon_sz_region, but later i changed it to 
damon_region_size, so i will change it back.
>
> Also, I'd like to keep this function 'static inline' and put the definition
> just after that of 'damon_first_region()'.
Ok, thanks
>
>
> Thanks,
> SJ
>
>>   struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>>   			enum damos_action action, struct damos_quota *quota,
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 4de8c7c52979..74ab45b2c2f1 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -864,7 +864,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>>   	}
>>   }
>>
>> -static inline unsigned long sz_damon_region(struct damon_region *r)
>> +unsigned long damon_region_size(struct damon_region *r)
>>   {
>>   	return r->ar.end - r->ar.start;
>>   }
>> @@ -875,7 +875,7 @@ static inline unsigned long sz_damon_region(struct damon_region *r)
>>   static void damon_merge_two_regions(struct damon_target *t,
>>   		struct damon_region *l, struct damon_region *r)
>>   {
>> -	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
>> +	unsigned long sz_l = damon_region_size(l), sz_r = damon_region_size(r);
>>
>>   	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>>   			(sz_l + sz_r);
>> @@ -904,7 +904,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
>>
>>   		if (prev && prev->ar.end == r->ar.start &&
>>   		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
>> -		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
>> +		    damon_region_size(prev) + damon_region_size(r) <= sz_limit)
>>   			damon_merge_two_regions(t, prev, r);
>>   		else
>>   			prev = r;
>> --
>> 2.31.0
>>
