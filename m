Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48AD6573D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiL1IRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1IRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:17:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E3F43
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:17:36 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nhkqz6sm9zmWMm;
        Wed, 28 Dec 2022 16:16:15 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 16:17:32 +0800
Message-ID: <5cb83ada-a1a4-b52f-3254-0e6536ab4315@huawei.com>
Date:   Wed, 28 Dec 2022 16:17:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] cma:tracing: Print alloc result in trace_cma_alloc_finish
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <20221208142130.1501195-1-haowenchao@huawei.com>
 <20221218102030.94b44e62608f20fd9decf9a0@kernel.org>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <20221218102030.94b44e62608f20fd9decf9a0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100018.china.huawei.com (7.185.36.133) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/18 9:20, Masami Hiramatsu (Google) wrote:
> On Thu, 8 Dec 2022 22:21:30 +0800
> Wenchao Hao <haowenchao@huawei.com> wrote:
> 
>> The result of allocation is not printed in trace_cma_alloc_finish
>> now, while it's important to do it so we can set filters to catch
>> specific error on allocation or trigger some operations on specific
>> error.
>>
>> Although we have printed the result in log, but the log is
>> conditional and could not be filtered by tracing event.
>>
>> What's more, it introduce little overhead to print this result.
>> The result of allocation is named as errorno in trace.
> 
> This looks good to me. BTW, with this change, cma_alloc_class has only
> one event - cma_alloc_busy_retry. If so, can we remove the cma_alloc_class?
> 
> Thank you,
> 

Sorry, I got COVID-19 and just recovered, so did not response your email in time.

The cma_alloc_class should be removed. Since Andrew has applied this patch,
I would send another one to remove it.

>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  include/trace/events/cma.h | 32 +++++++++++++++++++++++++++++---
>>  mm/cma.c                   |  2 +-
>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
>> index 3d708dae1542..ef75ea606ab2 100644
>> --- a/include/trace/events/cma.h
>> +++ b/include/trace/events/cma.h
>> @@ -91,12 +91,38 @@ TRACE_EVENT(cma_alloc_start,
>>  		  __entry->align)
>>  );
>>  
>> -DEFINE_EVENT(cma_alloc_class, cma_alloc_finish,
>> +TRACE_EVENT(cma_alloc_finish,
>>  
>>  	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
>> -		 unsigned long count, unsigned int align),
>> +		 unsigned long count, unsigned int align, int errorno),
>>  
>> -	TP_ARGS(name, pfn, page, count, align)
>> +	TP_ARGS(name, pfn, page, count, align, errorno),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(unsigned long, pfn)
>> +		__field(const struct page *, page)
>> +		__field(unsigned long, count)
>> +		__field(unsigned int, align)
>> +		__field(int, errorno)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->pfn = pfn;
>> +		__entry->page = page;
>> +		__entry->count = count;
>> +		__entry->align = align;
>> +		__entry->errorno = errorno;
>> +	),
>> +
>> +	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u errorno=%d",
>> +		  __get_str(name),
>> +		  __entry->pfn,
>> +		  __entry->page,
>> +		  __entry->count,
>> +		  __entry->align,
>> +		  __entry->errorno)
>>  );
>>  
>>  DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 4a978e09547a..a75b17b03b66 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -491,7 +491,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>>  		start = bitmap_no + mask + 1;
>>  	}
>>  
>> -	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
>> +	trace_cma_alloc_finish(cma->name, pfn, page, count, align, ret);
>>  
>>  	/*
>>  	 * CMA can allocate multiple page blocks, which results in different
>> -- 
>> 2.32.0
>>
> 
> 

