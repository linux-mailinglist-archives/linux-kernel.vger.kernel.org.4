Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E36E0F55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDMN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:56:41 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F810F0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681394198;
        bh=i+uzu8XrKcyazWATT0CfrDhS/QyUxvBfSAP/0uwmr+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rZ0VW3Pjwvp3zfQ0i6cZllS0FiqQHawF2T4e67zTu1XkdOOjntQlKxnk162G3MHN8
         FDe3UtTKvgI41S+9ujuYcYd8I6DaNg0NgTgUTi/ieaL5/1d6Lnfe74HDogNQwfs9YC
         iSWeK/KTDvECK0dyoAXb46Z+Y2Wddbt83ZWwpp4WqhefMSE2RlYFrkcjd2PfG3xnOy
         6eXTGNmYbWzpMd51LRu3cY/hkLVD9kd4cOeFumumagDmNlrjfsXEVx17aZi7c/4ZY0
         QbJuoqUpdhJfsitj5bKf2/717sjvAVKUJTKNeHrnrNfCEf1oNzIUogJaVuSBuQDWR3
         zmopm3FkQ+GLg==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Py1Mp4n4WzvVM;
        Thu, 13 Apr 2023 09:56:38 -0400 (EDT)
Message-ID: <6b8e63ab-e81e-470c-e03f-f3860c83bdb1@efficios.com>
Date:   Thu, 13 Apr 2023 09:56:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Aaron Lu <aaron.lu@intel.com>
Cc:     linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2> <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
 <20230412114240.GA155547@ziqianlu-desk2>
 <20230412142616.GI628377@hirez.programming.kicks-ass.net>
 <20230412143934.GB162902@ziqianlu-desk2>
 <20230413111047.GB83892@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230413111047.GB83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 07:10, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 10:39:34PM +0800, Aaron Lu wrote:
>> On Wed, Apr 12, 2023 at 04:26:16PM +0200, Peter Zijlstra wrote:
>>> On Wed, Apr 12, 2023 at 07:42:40PM +0800, Aaron Lu wrote:
>>>
>>>> I *guess* you might be able to see some contention with hackbench on
>>>> that HSW-EX system with v4.
>>>
>>> Indeed! Notably it seems to be the wakeup from idle that trips it
>>> hardest:
>>
>> Could it because for idle cpus, the per-cpu/mm cid is no longer valid for
>> the sake of compacting and when task wakes there, it will have to
>> re-allocate a new cid through mm_get_cid() which needs to acquire
>> mm->cid_lock?
> 
> Yup. And I'm thinking it is futile (and counter productive) to strive
> for compactness in this (nr_threads >= nr_cpus) case.
> 
> The below on v4 solves the contention I see with hackbench (which runs
> 400 threads which is well above the 144 cpu count on that machine).
> 
> This obviously leaves a problem with the nr_threads = nr_cpus - 1 case,
> but I'm thinking we can add some fuzz (nr_cpu_ids - ilog2(nr_cpus_ids+1)
> perhaps). Also, I would be thinking that's not something that typically
> happens.
> 
> Mathieu, WDYT? -- other than that the patch is an obvious hack :-)

I hate it with passion :-)

It is quite specific to your workload/configuration.

If we take for instance a process with a large mm_users count which is 
eventually affined to a subset of the cpus with cpusets or 
sched_setaffinity, your patch will prevent compaction of the concurrency 
ids when it really should not.

I'm working on a lock-free cid-get, hopefully my next version will 
eliminate the performance regression.

Thanks,

Mathieu

> 
> ---
>   include/linux/mm_types.h | 8 ++++++++
>   kernel/fork.c            | 4 +++-
>   kernel/sched/core.c      | 9 +++++++++
>   kernel/sched/sched.h     | 2 ++
>   4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4160ff5c6ebd..598d1b657afa 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -609,6 +609,7 @@ struct mm_struct {
>   		 * were being concurrently updated by the updaters.
>   		 */
>   		raw_spinlock_t cid_lock;
> +		int cid_saturated;
>   		/**
>   		 * @pcpu_cid: Per-cpu current cid.
>   		 *
> @@ -912,6 +913,12 @@ static inline int mm_cid_clear_lazy_put(int cid)
>   	return cid & ~MM_CID_LAZY_PUT;
>   }
>   
> +static inline void mm_cid_desaturate(struct mm_struct *mm)
> +{
> +	if (mm->cid_saturated && atomic_read(&mm->mm_users) < nr_cpu_ids)
> +		mm->cid_saturated = 0;
> +}
> +
>   /* Accessor for struct mm_struct's cidmask. */
>   static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
>   {
> @@ -928,6 +935,7 @@ static inline void mm_init_cid(struct mm_struct *mm)
>   	int i;
>   
>   	raw_spin_lock_init(&mm->cid_lock);
> +	mm->cid_saturated = 0;
>   	for_each_possible_cpu(i)
>   		*per_cpu_ptr(mm->pcpu_cid, i) = MM_CID_UNSET;
>   	cpumask_clear(mm_cidmask(mm));
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3832bea713c4..a5233e450435 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1233,7 +1233,9 @@ void mmput(struct mm_struct *mm)
>   	might_sleep();
>   
>   	if (atomic_dec_and_test(&mm->mm_users))
> -		__mmput(mm);
> +		return __mmput(mm);
> +
> +	mm_cid_desaturate(mm);
>   }
>   EXPORT_SYMBOL_GPL(mmput);
>   
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 425766cc1300..d5004d179531 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11550,6 +11550,15 @@ void sched_mm_cid_migrate_from(struct task_struct *t)
>   	if (last_mm_cid == -1)
>   		return;
>   
> +	/*
> +	 * When nr_threads > nr_cpus, there is no point in moving anything
> +	 * around to keep it compact.
> +	 */
> +	if (mm->cid_saturated) {
> +		t->last_mm_cid = -1;
> +		return;
> +	}
> +
>   	src_rq = task_rq(t);
>   	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
>   	src_cid = READ_ONCE(*src_pcpu_cid);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f3e7dc2cd1cc..6c4af2992e79 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3347,6 +3347,8 @@ static inline int mm_cid_get(struct mm_struct *mm)
>   	}
>   	raw_spin_lock(&mm->cid_lock);
>   	cid = __mm_cid_get_locked(mm);
> +	if (cid == nr_cpu_ids - 1)
> +		mm->cid_saturated = 1;
>   	raw_spin_unlock(&mm->cid_lock);
>   	WRITE_ONCE(*pcpu_cid, cid);
>   	return cid;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

