Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659066803E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjA3Cus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA3Cuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0DA199F6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675046997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ua0a+7FLRjiYvvWmSYrY3NETYCBxmwh5dh1sUQ6IfFk=;
        b=eeBjtRPVbsDe0uASM7+a6BUZXBtHE8tqUR04kvvgSmb3ddiiNwTylxpj60XKRF6cgm0F84
        T+p1IcRpxsgT1YkQXrBj1Q9gH4UEQSmKAX7YZbRyyNAczBRojv2zz/U1GZxQULboiIspjR
        ufKchN6BB49wXRC78Tjr1uw+GFvWRrQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-Soe931cYPFiLKmuHSo2ZOw-1; Sun, 29 Jan 2023 21:49:52 -0500
X-MC-Unique: Soe931cYPFiLKmuHSo2ZOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 984431C05146;
        Mon, 30 Jan 2023 02:49:51 +0000 (UTC)
Received: from [10.22.16.9] (unknown [10.22.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1482614171BE;
        Mon, 30 Jan 2023 02:49:50 +0000 (UTC)
Message-ID: <45e0f8ea-d229-1ae7-5c12-7f0a64c6767a@redhat.com>
Date:   Sun, 29 Jan 2023 21:49:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: cpuset: Don't rebuild sched domains on
 suspend-resume
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
 <20230125163546.pspvigh4groiwjy7@airbuntu>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230125163546.pspvigh4groiwjy7@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 11:35, Qais Yousef wrote:
> On 01/20/23 17:16, Waiman Long wrote:
>> On 1/20/23 14:48, Qais Yousef wrote:
>>> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
>>> enabled rebuilding sched domain on cpuset and hotplug operations to
>>> correct deadline accounting.
>>>
>>> Rebuilding sched domain is a slow operation and we see 10+ ms delay on
>>> suspend-resume because of that.
>>>
>>> Since nothing is expected to change on suspend-resume operation; skip
>>> rebuilding the sched domains to regain the time lost.
>>>
>>> Debugged-by: Rick Yiu <rickyiu@google.com>
>>> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
>>> ---
>>>
>>>       Changes in v2:
>>>       	* Remove redundant check in update_tasks_root_domain() (Thanks Waiman)
>>>       v1 link:
>>>       	https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/
>>>
>>>    kernel/cgroup/cpuset.c  | 3 +++
>>>    kernel/sched/deadline.c | 3 +++
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index a29c0b13706b..9a45f083459c 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1088,6 +1088,9 @@ static void rebuild_root_domains(void)
>>>    	lockdep_assert_cpus_held();
>>>    	lockdep_assert_held(&sched_domains_mutex);
>>> +	if (cpuhp_tasks_frozen)
>>> +		return;
>>> +
>>>    	rcu_read_lock();
>>>    	/*
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index 0d97d54276cc..42c1143a3956 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
>>>    {
>>>    	unsigned long flags;
>>> +	if (cpuhp_tasks_frozen)
>>> +		return;
>>> +
>>>    	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
>>>    	rd->dl_bw.total_bw = 0;
>>>    	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
>> cpuhp_tasks_frozen is set when thaw_secondary_cpus() or
>> freeze_secondary_cpus() is called. I don't know the exact suspend/resume
>> calling sequences, will cpuhp_tasks_frozen be cleared at the end of resume
>> sequence? Maybe we should make sure that rebuild_root_domain() is called at
>> least once at the end of resume operation.
> Very good questions. It made me look at the logic again and I realize now that
> the way force_build behaves is causing this issue.
>
> I *think* we should just make the call rebuild_root_domains() only if
> cpus_updated in cpuset_hotplug_workfn().
>
> cpuset_cpu_active() seems to be the source of force_rebuild in my case; which
> seems to be called only after the last cpu is back online (what you suggest).
> In this case we can end up with cpus_updated = false, but force_rebuild = true.
>
> Now you added a couple of new users to force_rebuild in 4b842da276a8a; I'm
> trying to figure out what the conditions would be there. It seems we can have
> corner cases for cpus_update might not trigger correctly?
>
> Could the below be a good cure?
>
> AFAICT we must rebuild the root domains if something has changed in cpuset.
> Which should be captured by either having:
>
> 	* cpus_updated = true
> 	* force_rebuild && !cpuhp_tasks_frozen
>
> /me goes to test the patch
>
> --->8---
>
> 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> 	index a29c0b13706b..363e4459559f 100644
> 	--- a/kernel/cgroup/cpuset.c
> 	+++ b/kernel/cgroup/cpuset.c
> 	@@ -1079,6 +1079,8 @@ static void update_tasks_root_domain(struct cpuset *cs)
> 		css_task_iter_end(&it);
> 	 }
>
> 	+static bool need_rebuild_rd = true;
> 	+
> 	 static void rebuild_root_domains(void)
> 	 {
> 		struct cpuset *cs = NULL;
> 	@@ -1088,6 +1090,9 @@ static void rebuild_root_domains(void)
> 		lockdep_assert_cpus_held();
> 		lockdep_assert_held(&sched_domains_mutex);
>
> 	+       if (!need_rebuild_rd)
> 	+               return;
> 	+
> 		rcu_read_lock();
>
> 		/*
> 	@@ -3627,7 +3632,9 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
> 		/* rebuild sched domains if cpus_allowed has changed */
> 		if (cpus_updated || force_rebuild) {
> 			force_rebuild = false;
> 	+               need_rebuild_rd = cpus_updated || (force_rebuild && !cpuhp_tasks_frozen);
> 			rebuild_sched_domains();
> 	+               need_rebuild_rd = true;

You do the force_check check after it is set to false in the previous 
statement which is definitely not correct. So it will be false whenever 
cpus_updated is false.

If you just want to skip rebuild_sched_domains() call for hotplug, why 
don't just skip the call here if the condition is right? Like

         /* rebuild sched domains if cpus_allowed has changed */
         if (cpus_updated || (force_rebuild && !cpuhp_tasks_frozen)) {
                 force_rebuild = false;
                 rebuild_sched_domains();
         }

Still, we will need to confirm that cpuhp_tasks_frozen will be cleared 
outside of the suspend/resume cycle.

Cheers,
Longman

