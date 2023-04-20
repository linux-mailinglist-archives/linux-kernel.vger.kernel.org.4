Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC476E94C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjDTMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjDTMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:41:28 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F57461B4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681994464;
        bh=CFhS3Ksa+9qxFtaXWWkLkLlUyHN4H12BVfLXvB/9zRc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VyvLyTvIE/P4FQ4zp+Iaf+VyRwSRkWfg2/Lsr/KriU1wzvbRuyks3Gx5olp1kjPwL
         YPHS+VYsdfUnEZy8cTE8LPpAKfIvqJt0INivYodbLl5QdBK/xUWQroIlZCwEgxZK+O
         DyN7BSlN2Oflin0Y3rNQ9YBTf1FB8BqQ8FaVPs+HnvltRVDSbCG6vmhU8TnEDbMb/Y
         xXvc0vbgBpHQG2aKl5laC/BhaEAcdy4EzW5NGAO3vHQcFUcVVmffttpFCJvyfaHw6+
         71YfiT4Pvq3lJZVdd5kwJM1JPLNeZo3R79RM4C1cY03h2krwvUo3HPxbLt/HNWthBR
         bZO3FCa+BUkRQ==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q2HMN3Ks1zw7T;
        Thu, 20 Apr 2023 08:41:04 -0400 (EDT)
Message-ID: <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
Date:   Thu, 20 Apr 2023 08:41:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230420095610.GA153295@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 05:56, Aaron Lu wrote:
> On Wed, Apr 19, 2023 at 11:50:12AM -0400, Mathieu Desnoyers wrote:
>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>> sysbench regression reported by Aaron Lu.
> 
> mm_cid_get() dropped to 5.x% after I disable CONFIG_DEBUG_PREEMPT, using
> __this_cpu_X() doesn't help, I suppose that is because __this_cpu_X()
> still needs to fetch mm->pcpu_cid.
> 
> Annotate mm_cid_get():
> 
>         │     static inline int mm_cid_get(struct mm_struct *mm)
>         │     {
>    0.05 │       push   %rbp
>    0.02 │       mov    %rsp,%rbp
>         │       push   %r15
>         │       push   %r14
>         │       push   %r13
>         │       push   %r12
>         │       push   %rbx
>    0.02 │       sub    $0x10,%rsp
>         │     struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
>   71.30 │       mov    0x60(%rdi),%r12
>         │     struct cpumask *cpumask;
>         │     int cid;
>         │
>         │     lockdep_assert_rq_held(rq);
>         │     cpumask = mm_cidmask(mm);
>         │     cid = __this_cpu_read(pcpu_cid->cid);
>   28.44 │       mov    %gs:0x8(%r12),%edx
>         │     if (mm_cid_is_valid(cid)) {
> 
> 
> sched_mm_cid_migrate_to() is 4.x% and its annotation :
> 
>         │     dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
>         │       mov     -0x30(%rbp),%rax
>   54.53 │       mov     0x60(%r13),%rbx
>   19.61 │       movslq  0xaf0(%rax),%r15
> 
> The reason why accessing mm->pcpu_cid is so costly is still a myth to
> me...

Then we clearly have another member of mm_struct on the same cache line 
as pcpu_cid which is bouncing all over the place and causing 
false-sharing. Any idea which field(s) are causing this ?


> 
> BTW, I used below diff to mitigate the incorrect rq lock issue I
> described in my reply to v8:

Yes, I'll do something similar in my next version, thanks ! I'll also 
drop my patch 1/2 from my patchset because clearly I was looking in the 
wrong place.

Thanks,

Mathieu

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c6e2dd8f4ee3..f16418731866 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11662,7 +11662,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
>   		return;
>   	}
>   	/* Move src_cid to dst cpu. */
> -	mm_cid_snapshot_time(mm);
> +	mm_cid_snapshot_time(mm, cpu_of(dst_rq));
>   	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
>   }
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d1d470441422..8b6a0c8ed3d1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3348,12 +3348,13 @@ static inline int __mm_cid_try_get(struct mm_struct *mm)
>    * Save a snapshot of the current runqueue time of this cpu
>    * with the per-cpu cid value, allowing to estimate how recently it was used.
>    */
> -static inline void mm_cid_snapshot_time(struct mm_struct *mm)
> +static inline void mm_cid_snapshot_time(struct mm_struct *mm, int cpu)
>   {
> -	struct rq *rq = this_rq();
> +	struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
> +	struct rq *rq = cpu_rq(cpu);
>   
>   	lockdep_assert_rq_held(rq);
> -	__this_cpu_write(mm->pcpu_cid->time, rq->clock);
> +	WRITE_ONCE(pcpu_cid->time, rq->clock);
>   }
>   
>   static inline int __mm_cid_get(struct mm_struct *mm)
> @@ -3404,7 +3405,7 @@ static inline int __mm_cid_get(struct mm_struct *mm)
>   unlock:
>   	raw_spin_unlock(&cid_lock);
>   end:
> -	mm_cid_snapshot_time(mm);
> +	mm_cid_snapshot_time(mm, raw_smp_processor_id());
>   	return cid;
>   }
>   
> @@ -3419,7 +3420,7 @@ static inline int mm_cid_get(struct mm_struct *mm)
>   	cpumask = mm_cidmask(mm);
>   	cid = __this_cpu_read(pcpu_cid->cid);
>   	if (mm_cid_is_valid(cid)) {
> -		mm_cid_snapshot_time(mm);
> +		mm_cid_snapshot_time(mm, raw_smp_processor_id());
>   		return cid;
>   	}
>   	if (mm_cid_is_lazy_put(cid)) {
> @@ -3467,7 +3468,7 @@ static inline void switch_mm_cid(struct task_struct *prev,
>   		 */
>   	}
>   	if (prev->mm_cid_active) {
> -		mm_cid_snapshot_time(prev->mm);
> +		mm_cid_snapshot_time(prev->mm, raw_smp_processor_id());
>   		mm_cid_put_lazy(prev);
>   		prev->mm_cid = -1;
>   	}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

