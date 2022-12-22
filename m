Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9F65470B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLVUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVUTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE99112A88
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671740316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkgT/rx+rJzPLcB9hasQHzxYWnSSI0xemioCpjMf6Jg=;
        b=TkjYmXtHZ/M7QFtAJY9JdjgLVzPihMQTBrux1yvdWNS/4dVhDtCPNIubvsrhlMy1PuCZUF
        BIHZcma7/4codlQt+8+hLc0z1JUfnSLmy8DQD39Xs640rd6v0T5k27wefVEl4AF0UW+JZO
        2neLQITLRMdD0Bu5L1gVSq4Lg0OHAPM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-orCGrTcfP6S2CxRVfCvOWA-1; Thu, 22 Dec 2022 15:18:30 -0500
X-MC-Unique: orCGrTcfP6S2CxRVfCvOWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 116D71C0CE6B;
        Thu, 22 Dec 2022 20:18:30 +0000 (UTC)
Received: from [10.22.33.48] (unknown [10.22.33.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82D2D112132C;
        Thu, 22 Dec 2022 20:18:29 +0000 (UTC)
Message-ID: <56792f82-951e-04c5-f7ea-fbf9ab375eec@redhat.com>
Date:   Thu, 22 Dec 2022 15:18:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-tip v3] sched: Use kfree_rcu() in do_set_cpus_allowed()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
References: <20221205163936.2149640-1-longman@redhat.com>
 <Y6SwwNy2OMSjUlbT@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y6SwwNy2OMSjUlbT@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 14:32, Peter Zijlstra wrote:
> On Mon, Dec 05, 2022 at 11:39:36AM -0500, Waiman Long wrote:
>> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
>> do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
>> set. Unfortunately, some of the callers of do_set_cpus_allowed()
>> may have pi_lock held when calling it. So the following splats may be
>> printed especially when running with a PREEMPT_RT kernel:
>>
>>     WARNING: possible circular locking dependency detected
>>     BUG: sleeping function called from invalid context
>>
>> To avoid these problems, kfree_rcu() is used instead. An internal
>> cpumask_rcuhead union is created for the sole purpose of facilitating
>> the use of kfree_rcu() to free the cpumask.
>>
>> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/core.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>>   [v3: Fix build problem reported by kernel test robot]
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 57e5932f81a9..155b6cfe119a 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2604,9 +2604,19 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>>   		.user_mask = NULL,
>>   		.flags     = SCA_USER,	/* clear the user requested mask */
>>   	};
>> +	union cpumask_rcuhead {
>> +		cpumask_t cpumask;
>> +		struct rcu_head rcu;
>> +	};
>>   
>>   	__do_set_cpus_allowed(p, &ac);
>> -	kfree(ac.user_mask);
>> +
>> +	/*
>> +	 * Because this is called with p->pi_lock held, it is not possible
>> +	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
>> +	 * kfree_rcu().
>> +	 */
>> +	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
>>   }
>>   
>>   int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>> @@ -8220,7 +8230,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>>   	struct affinity_context ac;
>>   	struct cpumask *user_mask;
>>   	struct task_struct *p;
>> -	int retval;
>> +	int retval, size;
>>   
>>   	rcu_read_lock();
>>   
>> @@ -8253,7 +8263,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>>   	if (retval)
>>   		goto out_put_task;
>>   
>> -	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
>> +	/*
>> +	 * See do_set_cpus_allowed() for the rcu_head usage.
>> +	 */
>> +	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
>> +	user_mask = kmalloc(size, GFP_KERNEL);
>>   	if (!user_mask) {
>>   		retval = -ENOMEM;
>>   		goto out_put_task;
> AFAICT you forgot dup_user_cpus_ptr().

I haven't received any response from you for a while. So it is just a 
ping. Of course, I am aware that there is another dup_user_cpus_ptr() 
patch ouststanding. I will of course talk about that when you respond. I 
also have a pending rwsem patch series waiting for your review:-)

Cheers,
Longman

