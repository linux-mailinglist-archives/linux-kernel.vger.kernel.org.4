Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064467EDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjA0TJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjA0TJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21318A8A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674846547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJCju5rgXBdnxAgG12E9cL8oWFcpBdOlfakROt0zWmo=;
        b=PTtD2wyK2FJMHcASSC0jOSC5wo+OsWGkXrygDZKCn4dNE9/7YMP5dxGq/SjazynVZiRI9z
        HJg6DcDYZzm95H6OX/U4BkuQyW1WukNnxduk2/e7FpCpZRHGf7mwVwae+Lug7S+jkBWhRb
        LoHJjhkYbUQNYbYJTX3+v8v8KKrt2fU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-nFsyH9sWPa2YISSV7UyHXg-1; Fri, 27 Jan 2023 14:09:03 -0500
X-MC-Unique: nFsyH9sWPa2YISSV7UyHXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E76A32802E33;
        Fri, 27 Jan 2023 19:09:02 +0000 (UTC)
Received: from [10.22.18.180] (unknown [10.22.18.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B470A1121318;
        Fri, 27 Jan 2023 19:09:01 +0000 (UTC)
Message-ID: <0f8dec04-db47-d043-694f-601baa2ea615@redhat.com>
Date:   Fri, 27 Jan 2023 14:09:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, qperret@google.com,
        Tejun Heo <tj@kernel.org>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-3-longman@redhat.com>
 <20230117160825.GA17756@willie-the-truck>
 <Y9QZxVPLYpH/srMw@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9QZxVPLYpH/srMw@hirez.programming.kicks-ass.net>
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

On 1/27/23 13:36, Peter Zijlstra wrote:
> On Tue, Jan 17, 2023 at 04:08:26PM +0000, Will Deacon wrote:
>> Hi Waiman,
>>
>> On Thu, Sep 22, 2022 at 02:00:38PM -0400, Waiman Long wrote:
>>> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
>>> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
>>> is currently used only by arm64 arch due to possible asymmetric CPU
>>> setup. This patch extends its usage to save user provided cpumask
>>> when sched_setaffinity() is called for all arches. With this patch
>>> applied, user_cpus_ptr, once allocated after a successful call to
>>> sched_setaffinity(), will only be freed when the task exits.
>>>
>>> Since user_cpus_ptr is supposed to be used for "requested
>>> affinity", there is actually no point to save current cpu affinity in
>>> restrict_cpus_allowed_ptr() if sched_setaffinity() has never been called.
>>> Modify the logic to set user_cpus_ptr only in sched_setaffinity() and use
>>> it in restrict_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
>>> if defined but not changing it.
>>>
>>> This will be some changes in behavior for arm64 systems with asymmetric
>>> CPUs in some corner cases. For instance, if sched_setaffinity()
>>> has never been called and there is a cpuset change before
>>> relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
>>> follow what the cpuset allows but not what the previous cpu affinity
>>> setting allows.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/sched/core.c  | 82 ++++++++++++++++++++------------------------
>>>   kernel/sched/sched.h |  7 ++++
>>>   2 files changed, 44 insertions(+), 45 deletions(-)
>> We've tracked this down as the cause of an arm64 regression in Android and I've
>> reproduced the issue with mainline.
>>
>> Basically, if an arm64 system is booted with "allow_mismatched_32bit_el0" on
>> the command-line, then the arch code will (amongst other things) call
>> force_compatible_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
>> when exec()'ing a 32-bit or a 64-bit task respectively.
>>
>> If you consider a system where everything is 64-bit but the cmdline option
>> above is present, then the call to relax_compatible_cpus_allowed_ptr() isn't
>> expected to do anything in this case, and the old code made sure of that:
>>
>>> @@ -3055,30 +3032,21 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
>>>   
>>>   /*
>>>    * Restore the affinity of a task @p which was previously restricted by a
>>> - * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
>>> - * @p->user_cpus_ptr.
>>> + * call to force_compatible_cpus_allowed_ptr().
>>>    *
>>>    * It is the caller's responsibility to serialise this with any calls to
>>>    * force_compatible_cpus_allowed_ptr(@p).
>>>    */
>>>   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>>>   {
>>> -	struct cpumask *user_mask = p->user_cpus_ptr;
>>> -	unsigned long flags;
>>> +	int ret;
>>>   
>>>   	/*
>>> -	 * Try to restore the old affinity mask. If this fails, then
>>> -	 * we free the mask explicitly to avoid it being inherited across
>>> -	 * a subsequent fork().
>>> +	 * Try to restore the old affinity mask with __sched_setaffinity().
>>> +	 * Cpuset masking will be done there too.
>>>   	 */
>>> -	if (!user_mask || !__sched_setaffinity(p, user_mask))
>>> -		return;
>> ... since it returned early here if '!user_mask' ...
>>
>>> -
>>> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
>>> -	user_mask = clear_user_cpus_ptr(p);
>>> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>>> -
>>> -	kfree(user_mask);
>>> +	ret = __sched_setaffinity(p, task_user_cpus(p));
>>> +	WARN_ON_ONCE(ret);
>> ... however, now we end up going down into __sched_setaffinity() with
>> task_user_cpus(p) giving us the 'cpu_possible_mask'! This can lead to a mixture
>> of WARN_ON()s and incorrect affinity masks (for example, a newly exec'd task
>> ends up with the affinity mask of the online CPUs at the point of exec() and is
>> unable to run on anything onlined later).
>>
>> I've had a crack at fixing the code above to restore the old behaviour, and it
>> seems to work for my basic tests (still pending confirmation from others):
> This seems to cure things... cpuset is insane and insists on limiting
> things to online CPUs for no real reason. It is perfectly fine to have
> offline CPUs in the allowed mask (in fact, that's the default
> behaviour).
>
> With this on and "relax_compatible_cpus_allowed_ptr(current);" added to
> the exec() path things seem to work as expected for me.
>
> I'll clean up and post properly tomorrow (I think there's a simpler
> version hiding in there)...
>
> ---
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a29c0b13706b..7a63416a46f3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -498,19 +498,33 @@ static inline bool partition_is_populated(struct cpuset *cs,
>    *
>    * Call with callback_lock or cpuset_rwsem held.
>    */
> -static void guarantee_online_cpus(struct task_struct *tsk,
> -				  struct cpumask *pmask)
> +static void guarantee_cs_cpus(struct task_struct *tsk, struct cpumask *pmask, bool online)
>   {
> -	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +	const struct cpumask *task_possible_mask = task_cpu_possible_mask(tsk);
> +	const struct cpumask *possible_mask = cpu_possible_mask;
> +	const struct cpumask *cs_cpus;
>   	struct cpuset *cs;
>   
> -	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
> -		cpumask_copy(pmask, cpu_online_mask);
> +	if (online)
> +		possible_mask = cpu_online_mask;
> +
> +	if (WARN_ON(!cpumask_and(pmask, task_possible_mask, possible_mask)))
> +		cpumask_copy(pmask, possible_mask);
>   
>   	rcu_read_lock();
>   	cs = task_cs(tsk);
>   
> -	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
> +	if (!parent_cs(cs)) {
> +		cs_cpus = cpu_possible_mask;
> +		if (online)
> +			cs_cpus = cpu_online_mask;
> +	} else {
> +		cs_cpus = cs->cpus_allowed;
> +		if (online)
> +			cs_cpus = cs->effective_cpus;

This may not be the right thing to do to use cpus_allowed directly in 
the case of cgroup v2. In v2, cpus_allowed starts as empty and 
effective_cpus inherit from its parent. So we may have to go up the 
cpuset hierarchy to arrive at the proper cpus_allowed to use. We may 
need another helper to do that.

Cheers,
Longman

