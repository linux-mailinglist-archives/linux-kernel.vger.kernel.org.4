Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDD6547A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiLVVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLVVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737B62D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671743026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ca7RtVrfBttvEfo0Dey0zo7Bc2FGIoXKEOF4CglYshY=;
        b=gByfpOj4AVK+yzR4GksI8gloEJzLQ6z8uH7jdis8IaOHZUzNarHwbIq6w1BwlGhnxSal+H
        1eWmZqfn/cyQtQVpW244ULRoUpeuz+PPmnkeehO0TS+b6Ew5/X976aEKK2d/R478qp3DP3
        lFUlTYu4tKJ4Y2i042i74N1OWuWpoGI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-8JGH_AotPMCYlG51piAZVA-1; Thu, 22 Dec 2022 16:03:33 -0500
X-MC-Unique: 8JGH_AotPMCYlG51piAZVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5ADE8F6E85;
        Thu, 22 Dec 2022 21:03:32 +0000 (UTC)
Received: from [10.22.33.48] (unknown [10.22.33.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1589951EF;
        Thu, 22 Dec 2022 21:03:32 +0000 (UTC)
Message-ID: <828245eb-66ee-a2e3-c9ab-7cbc90044de3@redhat.com>
Date:   Thu, 22 Dec 2022 16:03:31 -0500
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
 <56792f82-951e-04c5-f7ea-fbf9ab375eec@redhat.com>
 <Y6S9KBYQbbFIQFWa@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y6S9KBYQbbFIQFWa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/22/22 15:25, Peter Zijlstra wrote:
> On Thu, Dec 22, 2022 at 03:18:29PM -0500, Waiman Long wrote:
>
>>>> @@ -8220,7 +8230,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>>>>    	struct affinity_context ac;
>>>>    	struct cpumask *user_mask;
>>>>    	struct task_struct *p;
>>>> -	int retval;
>>>> +	int retval, size;
>>>>    	rcu_read_lock();
>>>> @@ -8253,7 +8263,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>>>>    	if (retval)
>>>>    		goto out_put_task;
>>>> -	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
>>>> +	/*
>>>> +	 * See do_set_cpus_allowed() for the rcu_head usage.
>>>> +	 */
>>>> +	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
>>>> +	user_mask = kmalloc(size, GFP_KERNEL);
>>>>    	if (!user_mask) {
>>>>    		retval = -ENOMEM;
>>>>    		goto out_put_task;
>>> AFAICT you forgot dup_user_cpus_ptr().
>> I haven't received any response from you for a while. So it is just a ping.
> I was out sick :/

I am sorry to hear that. Hope you are all right now.


>
>> Of course, I am aware that there is another dup_user_cpus_ptr() patch
>> ouststanding. I will of course talk about that when you respond. I also have
>> a pending rwsem patch series waiting for your review:-)
> The point was that dup_user_cpus_ptr() also does an allocation and needs
> to allocate the possibly bigger size too, no?

Oh, yes. I missed that. I will combine the two patches into a patch series.

Thanks,
Longman

