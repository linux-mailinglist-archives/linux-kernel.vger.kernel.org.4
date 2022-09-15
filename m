Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838655B9271
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIOB5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIOB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:57:45 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6568E4F5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:57:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPqW6wP_1663207057;
Received: from 30.240.97.215(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPqW6wP_1663207057)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 09:57:38 +0800
Message-ID: <fd50c65c-728d-d561-afc1-6c1e2c73f252@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 09:57:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V2] mm/damon: simplify scheme create in lru_sort.c
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220914142250.1269-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220914142250.1269-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/14 下午10:22, SeongJae Park 写道:
> Hi Xin,
>
> On Wed, 14 Sep 2022 19:38:59 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
>> they have so much in common, so we can combine them into a single
>> function, and we just need to distinguish their differences.
> Thank you again for patiently waiting for my changes and reworking on this!
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/lru_sort.c | 57 ++++++++++++++++++++++-----------------------
>>   1 file changed, 28 insertions(+), 29 deletions(-)
>>
>> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
>> index 07a0908963fd..2eac907e866d 100644
>> --- a/mm/damon/lru_sort.c
>> +++ b/mm/damon/lru_sort.c
>> @@ -135,17 +135,40 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
>>   static struct damon_ctx *ctx;
>>   static struct damon_target *target;
>>   
>> -static struct damos *damon_lru_sort_new_scheme(
>> -		struct damos_access_pattern *pattern, enum damos_action action)
>> +static struct damos *damon_lru_sort_new_scheme(unsigned int thres,
>> +					       enum damos_action action)
>>   {
>> +	struct damos_access_pattern pattern = {
>> +		/* Find regions having PAGE_SIZE or larger size */
>> +		.min_sz_region = PAGE_SIZE,
>> +		.max_sz_region = ULONG_MAX,
>> +		/* and accessed for more than the threshold */
> This comment would be better to be written again?
>
>> +		.min_nr_accesses = 0,
>> +		.max_nr_accesses = 0,
> If we're gonna set above two fields anyway later, we could simply remove above
> three lines.
>
>> +		/* no matter its age */
>> +		.min_age_region = 0,
>> +		.max_age_region = UINT_MAX,
>> +	};
>>   	struct damos_quota quota = damon_lru_sort_quota;
>>   
>>   	/* Use half of total quota for hot/cold pages sorting */
>>   	quota.ms = quota.ms / 2;
>>   
>> +	switch (action) {
>> +	case DAMOS_LRU_PRIO:
>> +		pattern.min_nr_accesses = thres;
>> +		pattern.max_nr_accesses = UINT_MAX;
>> +		break;
>> +	case DAMOS_LRU_DEPRIO:
>> +		pattern.min_age_region = thres;
>> +		break;
>> +	default:
>> +		return NULL;
>> +	}
>> +
> This switch-case makes me wondering if the 'default' case really possible case.
> I think it would be clearer to set these from caller.
>
> IMHO, it might be clearer and shorter to define a static global 'struct
> damos_access_pattern' stub variable, and make the
> damon_lru_sort_new_{hot,cold}_scheme() copies it to their local variable,
> update the relevant fields, and pass that to 'damon_new_scheme()'.  What do you
> think?
>
>>   	return damon_new_scheme(
>>   			/* find the pattern, and */
>> -			pattern,
>> +			&pattern,
>>   			/* (de)prioritize on LRU-lists */
>>   			action,
>>   			/* under the quota. */
>> @@ -157,37 +180,13 @@ static struct damos *damon_lru_sort_new_scheme(
>>   /* Create a DAMON-based operation scheme for hot memory regions */
>>   static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>>   {
>> -	struct damos_access_pattern pattern = {
>> -		/* Find regions having PAGE_SIZE or larger size */
>> -		.min_sz_region = PAGE_SIZE,
>> -		.max_sz_region = ULONG_MAX,
>> -		/* and accessed for more than the threshold */
>> -		.min_nr_accesses = hot_thres,
>> -		.max_nr_accesses = UINT_MAX,
>> -		/* no matter its age */
>> -		.min_age_region = 0,
>> -		.max_age_region = UINT_MAX,
>> -	};
>> -
>> -	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
>> +	return damon_lru_sort_new_scheme(hot_thres, DAMOS_LRU_PRIO);
> If we follow what I suggested above, we could make this like below:
>
> 	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;
>
> 	pattern.min_nr_accesses = hot_thres;
> 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
Agree totally,  i will fix it in the next patch.
>>   }
>>   
>>   /* Create a DAMON-based operation scheme for cold memory regions */
>>   static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>>   {
>> -	struct damos_access_pattern pattern = {
>> -		/* Find regions having PAGE_SIZE or larger size */
>> -		.min_sz_region = PAGE_SIZE,
>> -		.max_sz_region = ULONG_MAX,
>> -		/* and not accessed at all */
>> -		.min_nr_accesses = 0,
>> -		.max_nr_accesses = 0,
>> -		/* for min_age or more micro-seconds */
>> -		.min_age_region = cold_thres,
>> -		.max_age_region = UINT_MAX,
>> -	};
>> -
>> -	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
>> +	return damon_lru_sort_new_scheme(cold_thres, DAMOS_LRU_DEPRIO);
> And similarly here.
>
>>   }
>>   
>>   static int damon_lru_sort_apply_parameters(void)
>> -- 
>> 2.31.0
>>
>>
>
> Thanks,
> SJ
