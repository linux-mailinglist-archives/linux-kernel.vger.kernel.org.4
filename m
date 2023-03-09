Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C46B1BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCIGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCIGr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:47:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011A497E6;
        Wed,  8 Mar 2023 22:47:26 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PXKSG6B2TzKq35;
        Thu,  9 Mar 2023 14:45:18 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 9 Mar
 2023 14:47:24 +0800
Message-ID: <c817ca87-1961-ffc2-cc40-8dc4932e0afc@huawei.com>
Date:   Thu, 9 Mar 2023 14:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ftrace: Add ftrace_page to list after the index is
 calculated
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>
References: <20230308070844.58180-1-chenzhongjin@huawei.com>
 <20230308095336.67f9368a@gandalf.local.home>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20230308095336.67f9368a@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/8 22:53, Steven Rostedt wrote:
>
>> -	} else {
>> -		if (!ftrace_pages)
>> -			goto out;
>> -
>> -		if (WARN_ON(ftrace_pages->next)) {
>> -			/* Hmm, we have free pages? */
>> -			while (ftrace_pages->next)
>> -				ftrace_pages = ftrace_pages->next;
>> -		}
>> -
>> -		ftrace_pages->next = start_pg;
> Basically, what you are saying is that once we add ftrace_pages->next to
> point to the new start_pg, it becomes visible to others and that could be a
> problem. And moving this code around is not really going to solve that, as
> then we would need to add memory barriers.
>
>> -	}
>> -
>>   	p = start;
>>   	pg = start_pg;
>>   	while (p < end) {
>> @@ -6855,6 +6841,21 @@ static int ftrace_process_locs(struct module *mod,
>>   	/* We should have used all pages */
>>   	WARN_ON(pg->next);
>>   
>> +	/* Add pages to ftrace_pages list */
>> +	if (!mod) {
>> +		WARN_ON(ftrace_pages || ftrace_pages_start);
>> +		/* First initialization */
>> +		ftrace_pages_start = start_pg;
>> +	} else {
>> +		if (WARN_ON(ftrace_pages->next)) {
>> +			/* Hmm, we have free pages? */
>> +			while (ftrace_pages->next)
>> +				ftrace_pages = ftrace_pages->next;
>> +		}
>> +
>> +		ftrace_pages->next = start_pg;
>> +	}
>> +
>>   	/* Assign the last page to ftrace_pages */
>>   	ftrace_pages = pg;
>>   
> Why not just test for it?
>
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 29baa97d0d53..9b2803c7a18f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1564,7 +1564,8 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>   	key.flags = end;	/* overload flags, as it is unsigned long */
>   
>   	for (pg = ftrace_pages_start; pg; pg = pg->next) {
> -		if (end < pg->records[0].ip ||
> +		if (pg->index == 0 ||
> +		    end < pg->records[0].ip ||
>   		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
>   			continue;
>   		rec = bsearch(&key, pg->records, pg->index,
>
>
> -- Steve
Thanks for review!

At first I'm worried that it will cause lookup_rec to return an 
incorrect result
if it issearching a module address going to be added.
But now I found that records are added at MODULE_STATE_UNFORMED, the module
address won't  be searched at this point in any case.

Let's do it this way. I'll send another patch.
