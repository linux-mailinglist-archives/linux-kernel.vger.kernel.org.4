Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4128635F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiKWNJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiKWNJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645D7AF59
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669207838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmkRRGcXAcDg3cxXJIVPHUumCtKX0jyoDLpWrHlvFQc=;
        b=HskIkvjKBqmgZcIYrClrpm91w9RB7fYWXsKX4Kvyn62S68saST+TvX/E4NkPM4zNQ5ScEl
        mjppmRJwDyO5dFYOF53jQrhgjS3SnWaZpUr1E+iZMT4HffgpsINZwixsD3VTGuU39sqRQ3
        7rUBopVgLnbraHY+X+LvqYu3iGECVa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-BBT5_GSNP0-wb3qKcPn5Nw-1; Wed, 23 Nov 2022 07:50:34 -0500
X-MC-Unique: BBT5_GSNP0-wb3qKcPn5Nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4961C101A528;
        Wed, 23 Nov 2022 12:50:34 +0000 (UTC)
Received: from [10.22.8.230] (unknown [10.22.8.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB9764EA4A;
        Wed, 23 Nov 2022 12:50:33 +0000 (UTC)
Message-ID: <54ceafae-1882-8243-f169-c8c965e2af12@redhat.com>
Date:   Wed, 23 Nov 2022 07:50:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
References: <20221122190653.818506-1-longman@redhat.com>
 <Y34B4N7fzWylFV94@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y34B4N7fzWylFV94@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/22 06:20, Peter Zijlstra wrote:
> On Tue, Nov 22, 2022 at 02:06:53PM -0500, Waiman Long wrote:
>> In general, a non-null user_cpus_ptr will remain set until the task dies.
>> A possible exception to this is the fact that do_set_cpus_allowed()
>> will clear a non-null user_cpus_ptr. To allow this possible racing
>> condition, we need to check for NULL user_cpus_ptr under the pi_lock
>> before duping the user mask.
>>
>> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/core.c | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 8df51b08bb38..f447a6285ea2 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2625,7 +2625,14 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>>   		      int node)
>>   {
>>   	unsigned long flags;
>> +	cpumask_t *user_mask = NULL;
> The inverse xmas tree is sad :-(
Right. The inverse xmas tree rule. Will fix that.
>
>>   
>> +	/*
>> +	 * If there is a concurrent sched_setaffinity(), we may miss the
>> +	 * newly updated user_cpus_ptr. However, a non-NULL user_cpus_ptr
>> +	 * is relatively unlikely and it is not worth the extra overhead
>> +	 * of taking the pi_lock on every fork/clone.
>> +	 */
> I think the correct argument is saying the thing is racy and loosing the
> race is a valid situation. IOW, this is the same as if the concurrent
> sched_setaffinity() happens after fork().
Good point, will update the comment.
>>   	if (!src->user_cpus_ptr)
>>   		return 0;
>>   
>> @@ -2633,10 +2640,22 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>>   	if (!dst->user_cpus_ptr)
>>   		return -ENOMEM;
>>   
>> -	/* Use pi_lock to protect content of user_cpus_ptr */
>> +	/*
>> +	 * Use pi_lock to protect content of user_cpus_ptr
>> +	 *
>> +	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
>> +	 * do_set_cpus_allowed().
>> +	 */
>>   	raw_spin_lock_irqsave(&src->pi_lock, flags);
>> +	if (src->user_cpus_ptr)
>> +		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
>> +	else
>> +		swap(dst->user_cpus_ptr, user_mask);
> Uhhhh, did you mean to write:
>
> 	if (src->user_cpus_ptr) {
> 		cpumask_copy(user_mask, src->user_cpus_ptr);
> 		swap(dst->user_cpus_ptr, user_mask);
> 	}
>
> ?

Not really. The point is that dst->user_cpus_ptr has been allocated. If 
src->user_cpus_ptr turns out to be NULL, we need to clear 
dst->user_cpus_ptr which is what the swap() does and then free that 
memory after unlock. Will add a comment to make this point clear.

Cheers,
Longman

