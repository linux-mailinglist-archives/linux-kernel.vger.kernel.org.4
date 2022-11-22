Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD163449C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiKVTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiKVTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D739059A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8+x4HFMgKVQiIewvzOcUwH9fGkEhAphZqeCEWP1TS0=;
        b=RZR2Ov4WYS3fWZN0WTklFTaOcYFlb5XYqpGVpH8kjkJArLaSuHbWAoql/emt2jkEbgZ/CR
        KrdB7GSEeJZyodDbNAN7Qh3EN2Em3SIu4Ri0ntCNBsptMDwD2lw5xN1K0qiwSCUrlxluLh
        H4KkfrTa1DsWntuOMX2Mji9C0rkmg2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-StfdAcZWNyuxr8eujlSypg-1; Tue, 22 Nov 2022 14:30:42 -0500
X-MC-Unique: StfdAcZWNyuxr8eujlSypg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A3A486E923;
        Tue, 22 Nov 2022 19:30:41 +0000 (UTC)
Received: from [10.22.17.223] (unknown [10.22.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7B89492B17;
        Tue, 22 Nov 2022 19:30:40 +0000 (UTC)
Message-ID: <542be8a5-f374-0245-ca22-4033708b6469@redhat.com>
Date:   Tue, 22 Nov 2022 14:30:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
References: <20221118193302.522399-1-longman@redhat.com>
 <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
 <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
 <Y3zCfQCpBu8aBy6O@hirez.programming.kicks-ass.net>
 <70b65b5b-385d-1c47-f003-1e42de290e86@redhat.com>
 <Y30h1NXFmDrHAXcy@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y30h1NXFmDrHAXcy@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 14:24, Peter Zijlstra wrote:
> On Tue, Nov 22, 2022 at 10:23:43AM -0500, Waiman Long wrote:
>> index 78b2d5cabcc5..5fac4aa6ac7f 100644
>> --- a/kernel/sched/core.c
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 78b2d5cabcc5..5fac4aa6ac7f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2593,6 +2593,11 @@ __do_set_cpus_allowed(struct task_struct *p, struct
>> affinity_context *ctx)
>>                  set_next_task(rq, p);
>>   }
>>
>> +union cpumask_rcuhead {
>> +       void *cpumask;
>> +       struct rcu_head rcu;
>> +};
>> +
> Hehe; I had this union too; I just figured it'd be nice to not have to
> spend these 4 lines to express this. Esp. since we're casting pointers
> *anyway*.
Well, that is true. As long as the NULL check is there, I am OK with 
calling kvfree_call_rcu() directly if Paul doesn't object.
>>   /*
>>    * Used for kthread_bind() and select_fallback_rq(), in both cases the user
>>    * affinity (if any) should be destroyed too.
>> @@ -2606,7 +2611,12 @@ void do_set_cpus_allowed(struct task_struct *p, const
>> struct cpumask *new_mask)
>>          };
>>
>>          __do_set_cpus_allowed(p, &ac);
>> -       kfree(ac.user_mask);
>> +       /*
>> +        * Because this is called with p->pi_lock held, it is not possible
>> +        * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
>> +        * kfree_rcu().
>> +        */
>> +       kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
>>   }
>>
>>   int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>> @@ -8196,7 +8206,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask
>> *in_mask)
>>          struct affinity_context ac;
>>          struct cpumask *user_mask;
>>          struct task_struct *p;
>> -       int retval;
>> +       int retval, size;
>>
>>          rcu_read_lock();
>>
>> @@ -8229,7 +8239,11 @@ long sched_setaffinity(pid_t pid, const struct
>> cpumask *in_mask)
>>          if (retval)
>>                  goto out_put_task;
>>
>> -       user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
>> +       /*
>> +        * See do_set_cpus_allowed() for the rcu_head usage.
>> +        */
>> +       size = max_t(int, cpumask_size(), sizeof(union cpumask_rcuhead));
>> +       user_mask = kmalloc(size, GFP_KERNEL);
>>          if (!user_mask) {
>>                  retval = -ENOMEM;
>>                  goto out_put_task;
>>
> We also should fix the allocation in dup_user_cpus_ptr() -- perhaps pull
> the thing into a helper.
>
I have just sent out a new patch to fix that before I saw your email. I 
do forgot to put -tip in the subject line.

Cheers,
Longman

