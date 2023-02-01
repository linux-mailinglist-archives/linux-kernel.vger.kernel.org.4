Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918D67A39B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAXUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAXUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:09:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6942DFD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674590903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4KVYNPvkP145/CKGoPDMz+6Nv29JHPEPCKgPsjx58g=;
        b=FnBIM8H437MS71wPLfde5K7Jmj+rtGg9TeVwZrSdzKjijWuhWQpn3h+HsuX6NCZqmR3mno
        sjiQ54K5/LXlNZxd9RV/opsD2dtD+JOG+jO/Z73KtVZL7X/amZSlHIyF9kOU/DzzRzkYKy
        lw60NXDRWnJgZduxDhjIEya164Gcod8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-bvdrvDDeP3i5ShdadmQeWA-1; Tue, 24 Jan 2023 15:08:19 -0500
X-MC-Unique: bvdrvDDeP3i5ShdadmQeWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0333329AA2C8;
        Tue, 24 Jan 2023 20:08:11 +0000 (UTC)
Received: from [10.22.10.191] (unknown [10.22.10.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3136753A0;
        Tue, 24 Jan 2023 20:08:10 +0000 (UTC)
Message-ID: <70cf3890-efb1-cf35-2f94-f2b09092231f@redhat.com>
Date:   Tue, 24 Jan 2023 15:08:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
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
        Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <20230121021749.55313-1-longman@redhat.com>
 <20230124194805.GA27257@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230124194805.GA27257@willie-the-truck>
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

On 1/24/23 14:48, Will Deacon wrote:
> Hi Waiman,
>
> [+Thorsten given where we are in the release cycle]
>
> On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
>> The user_cpus_ptr field was originally added by commit b90ca8badbd1
>> ("sched: Introduce task_struct::user_cpus_ptr to track requested
>> affinity"). It was used only by arm64 arch due to possible asymmetric
>> CPU setup.
>>
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
>> requested cpu affinity specified in the sched_setaffinity().
>>
>> This results in a performance regression in an arm64 system when booted
>> with "allow_mismatched_32bit_el0" on the command-line. The arch code will
>> (amongst other things) calls force_compatible_cpus_allowed_ptr() and
>> relax_compatible_cpus_allowed_ptr() when exec()'ing a 32-bit or a 64-bit
>> task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
>> will always result in a __sched_setaffinity() call whether there is a
>> previous force_compatible_cpus_allowed_ptr() call or not.
> I'd argue it's more than just a performance regression -- the affinity
> masks are set incorrectly, which is a user visible thing
> (i.e. sched_getaffinity() gives unexpected values).
>
>> In order to fix this regression, a new scheduler flag
>> task_struct::cpus_allowed_restricted is now added to track if
>> force_compatible_cpus_allowed_ptr() has been called before or not. This
>> patch also updates the comments in force_compatible_cpus_allowed_ptr()
>> and relax_compatible_cpus_allowed_ptr() and handles their interaction
>> with sched_setaffinity().
>>
>> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
>> Reported-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/sched.h |  3 +++
>>   kernel/sched/core.c   | 46 ++++++++++++++++++++++++++++++++++---------
>>   kernel/sched/sched.h  |  2 ++
>>   3 files changed, 42 insertions(+), 9 deletions(-)
> I find this pretty invasive, but I guess it's up to Peter and Ingo.
> It also doesn't the whole problem for me; see below.
>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 853d08f7562b..f93f62a1f858 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -886,6 +886,9 @@ struct task_struct {
>>   	unsigned			sched_contributes_to_load:1;
>>   	unsigned			sched_migrated:1;
>>   
>> +	/* restrict_cpus_allowed_ptr() bit, serialized by scheduler locks */
>> +	unsigned			cpus_allowed_restricted:1;
>> +
>>   	/* Force alignment to the next boundary: */
>>   	unsigned			:0;
>>   
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bb1ee6d7bdde..48234dc9005b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2999,15 +2999,40 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>>   	struct rq *rq;
>>   
>>   	rq = task_rq_lock(p, &rf);
>> +
>> +	if (ctx->flags & (SCA_CLR_RESTRICT | SCA_SET_RESTRICT)) {
>> +		p->cpus_allowed_restricted = 0;
> I don't think this is ever called on the SCA_SET_RESTRICT path, as
> restrict_cpus_allowed_ptr() calls __set_cpus_allowed_ptr_locked() directly.
> In my testing, we see a failure in the following sequence:
>
>    1. A 64-bit task has an affinity of 0xf
>    2. It exec()s a 32-bit program and is forcefully restricted to the set
>       of 32-bit-capable cores. Let's say that new mask is 0xc
>    3. The 32-bit task now exec()s a 64-bit program again
>
> And now we're still stuck with 0xc after step 3 whereas we should restore
> 0xf.
I am sorry that missed it. You are right. For setting the 
cpus_allowed_restricted bit, it should be done directly in 
restrict_cpus_allowed_ptr().
>> +	} else if (p->cpus_allowed_restricted) {
>> +		/*
>> +		 * If force_compatible_cpus_allowed_ptr() has been called,
>> +		 * we can't extend cpumask to beyond what is in cpus_mask.
>> +		 */
>> +		if (!cpumask_and(rq->scratch_mask, ctx->new_mask,
>> +				 &p->cpus_mask)) {
>> +			task_rq_unlock(rq, p, &rf);
>> +			return -EINVAL;
>> +		}
> Why is this masking actually needed? __sched_setaffinity() already
> takes into account the task_cpu_possible_mask(), which is why I asked you
> before [1] about cases where the saved affinity is not simply a superset
> of the effective affinity.

I kind of overlook the use of task_cpu_possible_mask() in 
__set_cpus_allowed_ptr_locked. So we don't really need that masking. 
That make the patch even simpler then. I will send out a v3.

Cheers,
Longman

