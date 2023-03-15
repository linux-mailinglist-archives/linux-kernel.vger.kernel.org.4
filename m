Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DCD6BBBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCOSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCOSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23383241FD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678903285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBiQ3XO+Qb2i77OWvAAs2c/gyVV3pgLDyM6xc9xNwds=;
        b=bC6xKfNWYK0+AVqmV5MEVEwAvc/W5VwzusRPXJullQcAufyOkLNkdIDDwThV6sWxbj3HqH
        xFLgnNHEoJw6kTa4KiIVr92J5aYG5wAmNQhdd8duIt75RR2WmcuXu8aPuEJKEdOld2dmzA
        9QDkZLNvY0ZO8N1lhWANAodwOV1rUBY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-lndFVY6dPvK_RwNcNMh06g-1; Wed, 15 Mar 2023 14:01:17 -0400
X-MC-Unique: lndFVY6dPvK_RwNcNMh06g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB8351C07552;
        Wed, 15 Mar 2023 18:01:13 +0000 (UTC)
Received: from [10.22.34.146] (unknown [10.22.34.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4A07202701F;
        Wed, 15 Mar 2023 18:01:11 +0000 (UTC)
Message-ID: <2739c3ec-1e97-fc4d-8001-50283c94f4ff@redhat.com>
Date:   Wed, 15 Mar 2023 14:01:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315121812.206079-3-juri.lelli@redhat.com>
 <7a3b31bf-4f6a-6525-9c6a-2bae44d7b0af@redhat.com>
 <ZBH9E7lCEXcFDBG4@localhost.localdomain>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZBH9E7lCEXcFDBG4@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/23 13:14, Juri Lelli wrote:
> On 15/03/23 11:46, Waiman Long wrote:
>> On 3/15/23 08:18, Juri Lelli wrote:
>>> Qais reported that iterating over all tasks when rebuilding root domains
>>> for finding out which ones are DEADLINE and need their bandwidth
>>> correctly restored on such root domains can be a costly operation (10+
>>> ms delays on suspend-resume).
>>>
>>> To fix the problem keep track of the number of DEADLINE tasks belonging
>>> to each cpuset and then use this information (followup patch) to only
>>> perform the above iteration if DEADLINE tasks are actually present in
>>> the cpuset for which a corresponding root domain is being rebuilt.
>>>
>>> Reported-by: Qais Yousef <qyousef@layalina.io>
>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>>> ---
>>>    include/linux/cpuset.h |  4 ++++
>>>    kernel/cgroup/cgroup.c |  4 ++++
>>>    kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
>>>    kernel/sched/core.c    | 10 ++++++++++
>>>    4 files changed, 43 insertions(+)
>>>
>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>> index 355f796c5f07..0348dba5680e 100644
>>> --- a/include/linux/cpuset.h
>>> +++ b/include/linux/cpuset.h
>>> @@ -71,6 +71,8 @@ extern void cpuset_init_smp(void);
>>>    extern void cpuset_force_rebuild(void);
>>>    extern void cpuset_update_active_cpus(void);
>>>    extern void cpuset_wait_for_hotplug(void);
>>> +extern void inc_dl_tasks_cs(struct task_struct *task);
>>> +extern void dec_dl_tasks_cs(struct task_struct *task);
>>>    extern void cpuset_lock(void);
>>>    extern void cpuset_unlock(void);
>>>    extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>>> @@ -196,6 +198,8 @@ static inline void cpuset_update_active_cpus(void)
>>>    static inline void cpuset_wait_for_hotplug(void) { }
>>> +static inline void inc_dl_tasks_cs(struct task_struct *task) { }
>>> +static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>>>    static inline void cpuset_lock(void) { }
>>>    static inline void cpuset_unlock(void) { }
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index c099cf3fa02d..357925e1e4af 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -57,6 +57,7 @@
>>>    #include <linux/file.h>
>>>    #include <linux/fs_parser.h>
>>>    #include <linux/sched/cputime.h>
>>> +#include <linux/sched/deadline.h>
>>>    #include <linux/psi.h>
>>>    #include <net/sock.h>
>>> @@ -6673,6 +6674,9 @@ void cgroup_exit(struct task_struct *tsk)
>>>    	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>>>    	cset->nr_tasks--;
>>> +	if (dl_task(tsk))
>>> +		dec_dl_tasks_cs(tsk);
>>> +
>>>    	WARN_ON_ONCE(cgroup_task_frozen(tsk));
>>>    	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
>>>    		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 8d82d66d432b..57bc60112618 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -193,6 +193,12 @@ struct cpuset {
>>>    	int use_parent_ecpus;
>>>    	int child_ecpus_count;
>>> +	/*
>>> +	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
>>> +	 * know when to rebuild associated root domain bandwidth information.
>>> +	 */
>>> +	int nr_deadline_tasks;
>>> +
>>>    	/* Invalid partition error code, not lock protected */
>>>    	enum prs_errcode prs_err;
>>> @@ -245,6 +251,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>>>    	return css_cs(cs->css.parent);
>>>    }
>>> +void inc_dl_tasks_cs(struct task_struct *p)
>>> +{
>>> +	struct cpuset *cs = task_cs(p);
>>> +
>>> +	cs->nr_deadline_tasks++;
>>> +}
>>> +
>>> +void dec_dl_tasks_cs(struct task_struct *p)
>>> +{
>>> +	struct cpuset *cs = task_cs(p);
>>> +
>>> +	cs->nr_deadline_tasks--;
>>> +}
>>> +
>>>    /* bits in struct cpuset flags field */
>>>    typedef enum {
>>>    	CS_ONLINE,
>>> @@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>    		ret = security_task_setscheduler(task);
>>>    		if (ret)
>>>    			goto out_unlock;
>>> +
>>> +		if (dl_task(task)) {
>>> +			cs->nr_deadline_tasks++;
>>> +			cpuset_attach_old_cs->nr_deadline_tasks--;
>>> +		}
>>>    	}
>> Any one of the tasks in the cpuset can cause the test to fail and abort the
>> attachment. I would suggest that you keep a deadline task transfer count in
>> the loop and then update cs and cpouset_attach_old_cs only after all the
>> tasks have been iterated successfully.
> Right, Dietmar I think commented pointing out something along these
> lines. Think though we already have this problem with current
> task_can_attach -> dl_cpu_busy which reserves bandwidth for each tasks
> in the destination cs. Will need to look into that. Do you know which
> sort of operation would move multiple tasks at once?

Actually, what I said previously may not be enough. There can be 
multiple controllers attached to a cgroup. If any of thier can_attach() 
calls fails, the whole transaction is aborted and cancel_attach() will 
be called. My new suggestion is to add a new deadline task transfer 
count into the cpuset structure and store the information there 
temporarily. If cpuset_attach() is called, it means all the can_attach 
calls succeed. You can then update the dl task count accordingly and 
clear the temporary transfer count.

I guess you may have to do something similar with dl_cpu_busy().

My 2 cents.

Cheers,
Longman


