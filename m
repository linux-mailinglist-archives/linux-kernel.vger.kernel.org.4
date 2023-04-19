Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302906E7A59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjDSNLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjDSNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:10:58 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A330E0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681909851;
        bh=iKvH5na+Ap1e1+1gaSu1DIMm+FRnAfPebLyU7LXlS/4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CvuQn6llPHgenVWUr0qaQ/r+eb11jaKpQdeWTrwTiK9z7uh+FoPkwPCapo4DY0ueA
         /bmUwcOSV0m5scOTibPogGAfj9hZCvmHxoAallp0Bp/APj4KOKSdXRGubBj/YH1NJz
         QCwmgo69hLW7KVYYDFJ5ab16JUG443gPNScmqmBd6iJXGniyBRXovYi6geX8+HrieC
         cclXrdB0CfyDL4YjjA2g82W0ssWIo2WTI+kB081vowm6gMm0HkoDOdL88Mv/ePlBzU
         IMwzmoLyLb0zA1SxSW8naV4cQXfCVM0aAw5ngbaDyOxqqw7PicZKydS6faeZ2Rtako
         br1jffbGdKqyQ==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q1h4C4DSGzw71;
        Wed, 19 Apr 2023 09:10:51 -0400 (EDT)
Message-ID: <60a8b86d-de59-b34e-71ba-3dfd2cce7f02@efficios.com>
Date:   Wed, 19 Apr 2023 09:10:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v8] sched: Fix performance regression introduced by
 mm_cid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
 <20230418112151.GA565498@ziqianlu-desk2>
 <40689cd1-af60-542d-2245-c6362c73a365@efficios.com>
 <20230419080606.GA4247@ziqianlu-desk2>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230419080606.GA4247@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-19 04:06, Aaron Lu wrote:
> On Tue, Apr 18, 2023 at 12:01:09PM -0400, Mathieu Desnoyers wrote:
>> On 2023-04-18 07:21, Aaron Lu wrote:
>>> On Mon, Apr 17, 2023 at 11:08:31AM -0400, Mathieu Desnoyers wrote:
>>>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>>>> sysbench regression reported by Aaron Lu.
>>>
>>> For postgres_sysbench on SPR:
>>> sched_mm_cid_migrate_to() is in the range of 0.1x% - 0.4x%, mm_cid_get()
>>> is in the range of 0.1x% - 0.3x%. Other cid functions are pretty minor.
>>>
>>> For hackbench on SPR:
>>> ched_mm_cid_migrate_to() is about 3%-4%, mm_cid_get() is about 7%-8%,
>>> other cid functions are pretty minor.
>>
>> It's a bit higher than I would have expected for hackbench.
>>
>> Can you run with the attached schedstats patch applied and boot
>> with schedstats=enable ? Let me know how the counters behave please,
>> because I cannot reproduce anything unexpected on my machine.
> 
> Only event that stood out is mm_cid_get_cached, other events are very
> few in a 5s window. I think these numbers are expected and indicate the
> optimization worked well. Please see attachment for details, the number
> are got by doing the following after 20s the test was started:
> 	touch schedstat
> 	cat /proc/schedstat >> schedstat
> 	sleep 5
> 	cat /proc/schedstat >> schedstat
> 
> However, mm_cid_get() still shows as having 7.x% in perf cycles.
> Annotate shows the cycles are mostly spent on accessing mm->pcpu_cid:
> 
>         │
>         │     lockdep_assert_rq_held(rq);
>         │     cpumask = mm_cidmask(mm);
>         │     pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
>   64.50 │       mov   0x60(%r14),%r12
>         │     struct rq *rq = this_rq();
>    9.80 │       mov   %rbx,-0x30(%rbp)
>         │     pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
>    0.11 │     → call  debug_smp_processor_id

^ this call to debug_smp_processor_id is odd. Do you happen to have CONFIG_DEBUG_PREEMPT=y
in your kernel config ? This likely adds unwelcome overhead in those benchmarks.

>         │       mov   %eax,%ebx
>         │       cmp   $0x1fff,%eax
> 
> 
>         │     raw_spin_unlock(&cid_lock);
>         │       mov   $0xffffffff8474ca84,%rdi
>         │     WRITE_ONCE(use_cid_lock, 0);
>         │       movl  $0x0,use_cid_lock
>         │     raw_spin_unlock(&cid_lock);
>         │     → call  _raw_spin_unlock
>         │     ↑ jmp   fe
>         │     arch_static_branch():
>    0.02 │236:   xchg  %ax,%ax
>         │     mm_cid_snapshot_time():
>         │     struct rq *rq = this_rq();
>         │238: → call  debug_smp_processor_id
>         │       mov   $0x33340,%r13
>         │       mov   %eax,%ebx
>         │       cmp   $0x1fff,%eax
>         │     ↓ ja    2b3
>         │24d:   add   -0x7d5ce500(,%rbx,8),%r13
>         │     pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
>   21.23 │       mov   0x60(%r14),%rbx
>    4.11 │     → call  debug_smp_processor_id
>         │       mov   %eax,%r12d
>         │       cmp   $0x1fff,%eax
>         │     ↓ ja    2c4
>         │     WRITE_ONCE(pcpu_cid->time, rq->clock);
> 
> Initially I thought it might be due to some false sharing between
> pcpu_cid field and other fields of mm_struct, but after I placed pcpu_cid
> into a separate cacheline, it still didn't make a difference.
> 
> For sched_mm_cid_migrate_to(), its cycle percent is 2.97% and most cycles
> are also spent on accessing mm->pcpu_cid according to perf annotate:
> 
>         │     dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
>   64.22 │       mov     0x60(%r15),%r13
>    9.53 │       movslq  0xaf0(%rdi),%r14
> 
> No idea why accesing mm->pcpu_cid is so expensive, surely after
> initial allocation, nobody would change its value? Without a write
> side, I don't see how this can happen...

I'm also considering using __this_cpu* operations, such as this on mm_cid_get():


static inline int mm_cid_get(struct mm_struct *mm)
{
         struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
         struct rq *rq = this_rq();
         struct cpumask *cpumask;
         int cid;

         lockdep_assert_rq_held(rq);
         cpumask = mm_cidmask(mm);
         cid = __this_cpu_read(pcpu_cid->cid);
         if (mm_cid_is_valid(cid)) {
                 schedstat_inc(rq->mm_cid_get_cached);
                 mm_cid_snapshot_time(mm);
                 return cid;
         }
         if (mm_cid_is_lazy_put(cid)) {
                 if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET)) {
                         schedstat_inc(rq->mm_cid_get_put_lazy);
                         __mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
                 }
         }
         cid = __mm_cid_get(mm);
         schedstat_inc(rq->mm_cid_get_alloc);
         __this_cpu_write(pcpu_cid->cid, cid);
         return cid;
}

Would this help ?

Thanks,

Mathieu





-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

