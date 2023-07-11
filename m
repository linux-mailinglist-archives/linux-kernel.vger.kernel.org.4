Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EF74E71F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGKGVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGKGV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:21:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD54E4B;
        Mon, 10 Jul 2023 23:21:26 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0Vzd5N9WzMqVh;
        Tue, 11 Jul 2023 14:18:05 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 14:21:22 +0800
Message-ID: <d18f553b-079f-e0a8-4127-ae55e8cd0e42@huawei.com>
Date:   Tue, 11 Jul 2023 14:21:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ftrace: Fix possible warning on checking all pages used
 in ftrace_process_locs()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230710212958.274126-1-zhengyejian1@huawei.com>
 <20230710104625.421c851a@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230710104625.421c851a@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
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

On 2023/7/10 22:46, Steven Rostedt wrote:
> On Tue, 11 Jul 2023 05:29:58 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> As comments in ftrace_process_locs(), there may be NULL pointers in
>> mcount_loc section:
>>   > Some architecture linkers will pad between
>>   > the different mcount_loc sections of different
>>   > object files to satisfy alignments.
>>   > Skip any NULL pointers.
>>
>> After 20e5227e9f55 ("ftrace: allow NULL pointers in mcount_loc"),
>> NULL pointers will be accounted when allocating ftrace pages but
>> skipped before adding into ftrace pages, this may result in some
>> pages not being used. Then after 706c81f87f84 ("ftrace: Remove extra
>> helper functions"), warning may occur at:
>>    WARN_ON(pg->next);
>>
>> So we may need to skip NULL pointers before allocating ftrace pages.
>>
>> Fixes: 706c81f87f84 ("ftrace: Remove extra helper functions")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/trace/ftrace.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 3740aca79fe7..5b474165df31 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6485,6 +6485,16 @@ static int ftrace_process_locs(struct module *mod,
>>   	if (!count)
>>   		return 0;
>>   
>> +	p = start;
>> +	while (p < end) {
>> +		/*
>> +		 * Refer to conments below, there may be NULL pointers,
>> +		 * skip them before allocating pages
>> +		 */
>> +		addr = ftrace_call_adjust(*p++);
>> +		if (!addr)
>> +			count--;
>> +	}
> 
> My main concern about this is the added overhead during boot to process
> this. There's 10s of thousands of functions, so this loop will be 10s of
> thousands. I also don't like that this is an unconditional loop (meaning it
> executes even when it is unnecessary to do so).
> 

Agreed! The added overhead probably superfluousin in most cases.

> 
>>   	/*
>>   	 * Sorting mcount in vmlinux at build time depend on
>>   	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
> 
> How about something like this?
> 
> -- Steve
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b24c573934af..acd033371721 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6474,6 +6474,7 @@ static int ftrace_process_locs(struct module *mod,
>   	struct ftrace_page *start_pg;
>   	struct ftrace_page *pg;
>   	struct dyn_ftrace *rec;
> +	unsigned long skipped = 0;
>   	unsigned long count;
>   	unsigned long *p;
>   	unsigned long addr;
> @@ -6536,8 +6537,10 @@ static int ftrace_process_locs(struct module *mod,
>   		 * object files to satisfy alignments.
>   		 * Skip any NULL pointers.
>   		 */
> -		if (!addr)
> +		if (!addr) {
> +			skipped++;
>   			continue;
> +		}
>   
>   		end_offset = (pg->index+1) * sizeof(pg->records[0]);
>   		if (end_offset > PAGE_SIZE << pg->order) {
> @@ -6551,12 +6554,24 @@ static int ftrace_process_locs(struct module *mod,
>   		rec->ip = addr;
>   	}
>   
> -	/* We should have used all pages */
> -	WARN_ON(pg->next);
> -
>   	/* Assign the last page to ftrace_pages */
>   	ftrace_pages = pg;
>   
> +	/* We should have used all pages unless we skipped some */
> +	if (pg->next) {
> +		WARN_ON(!skipped);
> +		while (ftrace_pages->next) {
> +			pg = ftrace_pages->next;
> +			ftrace_pages->next = pg->next;
> +			if (pg->records) {
> +				free_pages((unsigned long)pg->records, pg->order);
> +				ftrace_number_of_pages -= 1 << pg->order;
> +			}
> +			kfree(pg);
> +			ftrace_number_of_groups--;
> +		}

Do we only need to free the pages that not being used?

> +	}
> +
>   	/*
>   	 * We only need to disable interrupts on start up
>   	 * because we are modifying code that an interrupt
> 

