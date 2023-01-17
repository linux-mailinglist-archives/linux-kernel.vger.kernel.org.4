Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E321A66E66A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjAQSsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjAQSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED12568B9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673979217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HufvuJj0PnCt4I7SANdySEcEJEXB3rZxA1StQp+0Rnc=;
        b=cVpmDfehKJ4S7H+XxR2BlK69jGSduFIK6bCcm63TkF0OeLtfM8yqYjUvoIL3X+EAB9LlyK
        U81+OQQ+Eo4pBrr851PkZcCtiICSYuzsnLyQs3hOEUEm8JMj5HLLFa1zkmDoA6BkIicic9
        iPic48gxl0wJXprLJYEz1fSYiY63vGQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-W3XY9xpoMwyQlpnFrT1cIQ-1; Tue, 17 Jan 2023 13:13:33 -0500
X-MC-Unique: W3XY9xpoMwyQlpnFrT1cIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BDF529AA3B1;
        Tue, 17 Jan 2023 18:13:32 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8246A175A2;
        Tue, 17 Jan 2023 18:13:31 +0000 (UTC)
Message-ID: <2bb8c031-03a9-ef93-1505-6e7fbcc6d847@redhat.com>
Date:   Tue, 17 Jan 2023 13:13:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Lai Jiangshan <jiangshanlai@gmail.com>, qperret@google.com
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-3-longman@redhat.com>
 <20230117160825.GA17756@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230117160825.GA17756@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 11:08, Will Deacon wrote:
> Hi Waiman,
>
> On Thu, Sep 22, 2022 at 02:00:38PM -0400, Waiman Long wrote:
>> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
>> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
>> is currently used only by arm64 arch due to possible asymmetric CPU
>> setup. This patch extends its usage to save user provided cpumask
>> when sched_setaffinity() is called for all arches. With this patch
>> applied, user_cpus_ptr, once allocated after a successful call to
>> sched_setaffinity(), will only be freed when the task exits.
>>
>> Since user_cpus_ptr is supposed to be used for "requested
>> affinity", there is actually no point to save current cpu affinity in
>> restrict_cpus_allowed_ptr() if sched_setaffinity() has never been called.
>> Modify the logic to set user_cpus_ptr only in sched_setaffinity() and use
>> it in restrict_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
>> if defined but not changing it.
>>
>> This will be some changes in behavior for arm64 systems with asymmetric
>> CPUs in some corner cases. For instance, if sched_setaffinity()
>> has never been called and there is a cpuset change before
>> relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
>> follow what the cpuset allows but not what the previous cpu affinity
>> setting allows.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/core.c  | 82 ++++++++++++++++++++------------------------
>>   kernel/sched/sched.h |  7 ++++
>>   2 files changed, 44 insertions(+), 45 deletions(-)
> We've tracked this down as the cause of an arm64 regression in Android and I've
> reproduced the issue with mainline.
>
> Basically, if an arm64 system is booted with "allow_mismatched_32bit_el0" on
> the command-line, then the arch code will (amongst other things) call
> force_compatible_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
> when exec()'ing a 32-bit or a 64-bit task respectively.

IOW, relax_compatible_cpus_allowed_ptr() can be called without a 
previous force_compatible_cpus_allowed_ptr(). Right?

A possible optimization in this case is to add a bit flag in the 
task_struct to indicate a previous call to 
force_compatible_cpus_allowed_ptr(). Without that flag set, 
relax_compatible_cpus_allowed_ptr() can return immediately.

>
> If you consider a system where everything is 64-bit but the cmdline option
> above is present, then the call to relax_compatible_cpus_allowed_ptr() isn't
> expected to do anything in this case, and the old code made sure of that:
>
>> @@ -3055,30 +3032,21 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
>>   
>>   /*
>>    * Restore the affinity of a task @p which was previously restricted by a
>> - * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
>> - * @p->user_cpus_ptr.
>> + * call to force_compatible_cpus_allowed_ptr().
>>    *
>>    * It is the caller's responsibility to serialise this with any calls to
>>    * force_compatible_cpus_allowed_ptr(@p).
>>    */
>>   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>>   {
>> -	struct cpumask *user_mask = p->user_cpus_ptr;
>> -	unsigned long flags;
>> +	int ret;
>>   
>>   	/*
>> -	 * Try to restore the old affinity mask. If this fails, then
>> -	 * we free the mask explicitly to avoid it being inherited across
>> -	 * a subsequent fork().
>> +	 * Try to restore the old affinity mask with __sched_setaffinity().
>> +	 * Cpuset masking will be done there too.
>>   	 */
>> -	if (!user_mask || !__sched_setaffinity(p, user_mask))
>> -		return;
> ... since it returned early here if '!user_mask' ...
The flag bit will work like the user_mask check here.
>
>> -
>> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
>> -	user_mask = clear_user_cpus_ptr(p);
>> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>> -
>> -	kfree(user_mask);
>> +	ret = __sched_setaffinity(p, task_user_cpus(p));
>> +	WARN_ON_ONCE(ret);
> ... however, now we end up going down into __sched_setaffinity() with
> task_user_cpus(p) giving us the 'cpu_possible_mask'! This can lead to a mixture
> of WARN_ON()s and incorrect affinity masks (for example, a newly exec'd task
> ends up with the affinity mask of the online CPUs at the point of exec() and is
> unable to run on anything onlined later).

CPU hotplug should update the cpumask of existing running application as 
allowed by cpuset.


>
> I've had a crack at fixing the code above to restore the old behaviour, and it
> seems to work for my basic tests (still pending confirmation from others):
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bb1ee6d7bdde..0d4a11384648 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3125,17 +3125,16 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
>   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>   {
>          struct affinity_context ac = {
> -               .new_mask  = task_user_cpus(p),
> +               .new_mask  = p->user_cpus_ptr,
>                  .flags     = 0,
>          };
> -       int ret;
>   
>          /*
>           * Try to restore the old affinity mask with __sched_setaffinity().
>           * Cpuset masking will be done there too.
>           */
> -       ret = __sched_setaffinity(p, &ac);
> -       WARN_ON_ONCE(ret);
> +       if (ac.new_mask)
> +               WARN_ON_ONCE(__sched_setaffinity(p, &ac));
>   }
>   
>   void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>
>
> With this change, task_user_cpus() is only used by restrict_cpus_allowed_ptr()
> so I'd be inclined to remove it altogether tbh.
>
> What do you think?

The problem here is that force_compatible_cpus_allowed_ptr() can be 
called without a matching relax_compatible_cpus_allowed_ptr() at the 
end. So we may end up artificially restrict the number of cpus that can 
be used when running a 64-bit binary.

What do you think about the idea of having a bit flag to track that?

Cheers,
Longman

