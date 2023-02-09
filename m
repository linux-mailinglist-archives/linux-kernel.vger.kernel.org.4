Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7860868FE1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjBIDvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjBIDvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:51:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744FE3A94;
        Wed,  8 Feb 2023 19:51:05 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PC2vn2qX6zbnkV;
        Thu,  9 Feb 2023 11:50:45 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 11:51:03 +0800
Message-ID: <9ceea6aa-b07c-fb10-0954-5e3d188bfd7e@huawei.com>
Date:   Thu, 9 Feb 2023 11:50:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing/ring-buffer: Remove integrity check at end of
 iter read
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <wanghai38@huawei.com>
References: <20230208090814.869242-1-zhengyejian1@huawei.com>
 <20230208173601.710888d3@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230208173601.710888d3@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/2/9 06:36, Steven Rostedt wrote:
> On Wed, 8 Feb 2023 17:08:14 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> Concurrently closing "trace" file and writing into ring buffer [1] can
>> cause WARNINGs [2]. It has been reported in
>> Link: https://lore.kernel.org/all/20230203035608.2336906-1-zhengyejian1@huawei.com/
>>
>> It seems a data race between ring_buffer writing and integrity check.
>> That is, RB_FLAG of head_page is been updating, while at same time RB_FLAG
>> was cleared when doing integrity check:
>>    rb_check_pages()            rb_handle_head_page():
>>    --------                    --------
>>    rb_head_page_deactivate()
>>                                rb_head_page_set_normal()
>>    rb_head_page_activate()
>>
> 
> Good catch!

Thanks!

> 
>> Integrity check at end of iter read was added since commit 659f451ff213
>> ("ring-buffer: Add integrity check at end of iter read"). As it's commit
>> message said:
>>    > As reading via an iterator requires disabling the ring buffer, it
>>    > is a perfect place to have it.
>> However, since commit 1039221cc278 ("ring-buffer: Do not disable recording
>> when there is an iterator"), ring buffer was not disabled at that place,
>> so that integrity check should be removed.
>>
>> 1:
>> ``` read_trace.sh
>>    while true;
>>    do
>>      # the "trace" file is closed after read
>>      head -1 /sys/kernel/tracing/trace > /dev/null
>>    done
>> ```
>> ``` repro.sh
>>    sysctl -w kernel.panic_on_warn=1
>>    # function tracer will writing enough data into ring_buffer
>>    echo function > /sys/kernel/tracing/current_tracer
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>>    ./read_trace.sh &
>> ```
>>
> 
> 
>> Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/trace/ring_buffer.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index c366a0a9ddba..34e955bd1e59 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -5203,17 +5203,6 @@ void
>>   ring_buffer_read_finish(struct ring_buffer_iter *iter)
>>   {
>>   	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
>> -	unsigned long flags;
>> -
>> -	/*
>> -	 * Ring buffer is disabled from recording, here's a good place
>> -	 * to check the integrity of the ring buffer.
>> -	 * Must prevent readers from trying to read, as the check
>> -	 * clears the HEAD page and readers require it.
>> -	 */
>> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>> -	rb_check_pages(cpu_buffer);
>> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> 
> I would rather find a way to make this still work than just removing it.

Yes, we can try to find the way.

> 
> Perhaps there's no reason to clear the flags, and change rb_check_pages()
> to mask them out before testing. Something like:
> 
> static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
> {
> 	struct list_head *head = cpu_buffer->pages;
> 	struct buffer_page *bpage, *tmp;
> 
> 	if (RB_WARN_ON(cpu_buffer, rb_list_head(rb_list_head(head->next)->prev) != head))
> 		return -1;
> 	if (RB_WARN_ON(cpu_buffer, rb_list_head(rb_list_head(head->prev)->next) != head))
> 		return -1;
> 
> 	if (rb_check_list(cpu_buffer, head))

rb_check_list() expect to check a page with RB_FLAG being cleared,
but in this solution, rb_head_page_deactivate() is not called before,
so we may not call it directly? The same problem with below check for
"bpage->list".

> 		return -1;
> 
> 	list_for_each_entry_safe(bpage, tmp, head, list) {

I'd like to know if there is a case that "head" happens to be a
"reader_page", and the ring buffer is not exactly being traversed?

> 		if (RB_WARN_ON(cpu_buffer,
> 		     rb_list_head(rb_list_head(bpage->list.next)->prev) != &bpage->list))
> 			return -1;
> 		if (RB_WARN_ON(cpu_buffer,
> 		     rb_list_head(rb_list_head(bpage->list.prev)->next) != &bpage->list))
> 			return -1;
> 		if (rb_check_list(cpu_buffer, &bpage->list))
> 			return -1;
> 	}
> 
> 	return 0;
> }
> 
> I haven't tested the above.
> 
> ?
> 
> -- Steve
> 
> 
>>   
>>   	atomic_dec(&cpu_buffer->resize_disabled);
>>   	kfree(iter->event);
> 
