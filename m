Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3A7369E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFTKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFTKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:50:46 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE1DB;
        Tue, 20 Jun 2023 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1687258241;
        bh=23RT6RtZKvvnvUCQtE/sFUYZKbZaC+odctzLJUb05D0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XZSvI0WO7TcaPHgqseIjOc99tO0KfHNEvaCFLKYZevVGmsnAJQNrLUSPo6RC/EyWE
         8Zt0aRFqsInw7nKsVhTNSNX6fcLuL/NAgpUYJtUkII6T51LBIDHU8eow9cj0M7xV6R
         lZRjS4c2ciu58OoPt/vEqIcqq9OE0K1nauPDVCRf89LjwnaM0//m86/1nF87DGwR5Y
         pK6ZtbilZUOiayMHF3o4Q/fYNiYwxAFEgWM1ZaTSYcIo8dGGvhwWT2ajlijfvaggU0
         Ad3Hm3mYwEbSPlGct3Ozj++tiz3wJRDslNy0XrGxtYRMW9wB4JBnSWbrRBWxDn7Igl
         H8f3oB6chNy+w==
Received: from [192.168.18.28] (unknown [198.16.185.171])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qlk1s3YrHz194q;
        Tue, 20 Jun 2023 06:50:41 -0400 (EDT)
Message-ID: <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
Date:   Tue, 20 Jun 2023 06:51:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 06:35, Swapnil Sapkal wrote:
> Hello Peter,
> 
> On 6/20/2023 2:41 PM, Peter Zijlstra wrote:
>> On Tue, Jun 20, 2023 at 01:44:32PM +0530, Swapnil Sapkal wrote:
>>> Hello Mathieu,
>>>
>>> On 4/22/2023 1:13 PM, tip-bot2 for Mathieu Desnoyers wrote:
>>>> The following commit has been merged into the sched/core branch of tip:
>>>>
>>>> Commit-ID:     223baf9d17f25e2608dbdff7232c095c1e612268
>>>> Gitweb:        
>>>> https://git.kernel.org/tip/223baf9d17f25e2608dbdff7232c095c1e612268
>>>> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> AuthorDate:    Thu, 20 Apr 2023 10:55:48 -04:00
>>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>>> CommitterDate: Fri, 21 Apr 2023 13:24:20 +02:00
>>>>
>>>> sched: Fix performance regression introduced by mm_cid
>>>>
>>>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a 
>>>> PostgreSQL
>>>> sysbench regression reported by Aaron Lu.
>>>>
>>>> Keep track of the currently allocated mm_cid for each mm/cpu rather 
>>>> than
>>>> freeing them immediately on context switch. This eliminates most atomic
>>>> operations when context switching back and forth between threads
>>>> belonging to different memory spaces in multi-threaded scenarios (many
>>>> processes, each with many threads). The per-mm/per-cpu mm_cid values 
>>>> are
>>>> serialized by their respective runqueue locks.
>>>>
>>>> Thread migration is handled by introducing invocation to
>>>> sched_mm_cid_migrate_to() (with destination runqueue lock held) in
>>>> activate_task() for migrating tasks. If the destination cpu's mm_cid is
>>>> unset, and if the source runqueue is not actively using its mm_cid, 
>>>> then
>>>> the source cpu's mm_cid is moved to the destination cpu on migration.
>>>>
>>>> Introduce a task-work executed periodically, similarly to NUMA work,
>>>> which delays reclaim of cid values when they are unused for a period of
>>>> time.
>>>>
>>>> Keep track of the allocation time for each per-cpu cid, and let the 
>>>> task
>>>> work clear them when they are observed to be older than
>>>> SCHED_MM_CID_PERIOD_NS and unused. This task work also clears all
>>>> mm_cids which are greater or equal to the Hamming weight of the mm
>>>> cidmask to keep concurrency ids compact.
>>>>
>>>> Because we want to ensure the mm_cid converges towards the smaller
>>>> values as migrations happen, the prior optimization that was done when
>>>> context switching between threads belonging to the same mm is removed,
>>>> because it could delay the lazy release of the destination runqueue
>>>> mm_cid after it has been replaced by a migration. Removing this prior
>>>> optimization is not an issue performance-wise because the introduced
>>>> per-mm/per-cpu mm_cid tracking also covers this more specific case.
>>>>
>>>> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
>>>> Reported-by: Aaron Lu <aaron.lu@intel.com>
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Tested-by: Aaron Lu <aaron.lu@intel.com>
>>>> Link: 
>>>> https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
>>>
>>> I run standard benchmarks as a part of kernel performance regression
>>> testing. When I run these benchmarks against v6.3.0 to v6.4-rc1,
>>> I have seen performance regression in hackbench running with threads. 
>>> When I did
>>> git bisect it pointed to this commit and reverting this commit helps 
>>> regains
>>> the performance. This regression is not seen with hackbench processes.
>>
>> Well, *this* commit was supposed to help fix the horrible contention on
>> cid_lock that was introduced with af7f588d8f73.
> 
> I went back and tested the commit that introduced mm_cid and I found 
> that the
> original implementation actually helped hackbench. Following are numbers 
> from
> 2 Socket Zen3 Server (2 X 64C/128T):
> 
> Test:           base (v6.2-rc1)      base + orig_mm_cid
>   1-groups:     4.29 (0.00 pct)     4.32 (-0.69 pct)
>   2-groups:     4.96 (0.00 pct)     4.94 (0.40 pct)
>   4-groups:     5.21 (0.00 pct)     4.10 (21.30 pct)
>   8-groups:     5.44 (0.00 pct)     4.50 (17.27 pct)
> 16-groups:     7.09 (0.00 pct)     5.28 (25.52 pct)
> 
> I see following IBS traces in this case:
> 
> Base:
> 
>     6.69%  sched-messaging  [kernel.vmlinux]          [k] 
> copy_user_generic_string
>     5.38%  sched-messaging  [kernel.vmlinux]          [k] 
> native_queued_spin_lock_slowpath
>     3.73%  swapper          [kernel.vmlinux]          [k] __switch_to_asm
>     3.23%  sched-messaging  [kernel.vmlinux]          [k] __calc_delta
>     2.93%  sched-messaging  [kernel.vmlinux]          [k] try_to_wake_up
>     2.63%  sched-messaging  [kernel.vmlinux]          [k] dequeue_task_fair
>     2.56%  sched-messaging  [kernel.vmlinux]          [k] osq_lock
> 
> Base + orig_mm_cid:
> 
>    13.70%  sched-messaging  [kernel.vmlinux]      [k] 
> native_queued_spin_lock_slowpath
>    11.87%  swapper          [kernel.vmlinux]      [k] 
> native_queued_spin_lock_slowpath
>     8.99%  sched-messaging  [kernel.vmlinux]      [k] 
> copy_user_generic_string
>     6.08%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>     4.79%  sched-messaging  [kernel.vmlinux]      [k] 
> apparmor_file_permission
>     3.71%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
>     3.66%  sched-messaging  [kernel.vmlinux]      [k] 
> ktime_get_coarse_real_ts64
>     3.11%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter
> 
>>
>>> Following are the results from 1 Socket 4th generation EPYC
>>> Processor(1 X 96C/192T) configured in NPS1 mode. This regression
>>> becomes more severe as the number of core count increases.
>>>
>>> The numbers on a 1 Socket Bergamo (1 X 128 cores/256 threads) is 
>>> significantly worse.
>>>
>>> Threads:
>>>
>>> Test:             With-mmcid-patch        Without-mmcid-patch
>>>   1-groups:         5.23 (0.00 pct)         4.61 (+11.85 pct)
>>>   2-groups:         4.99 (0.00 pct)         4.72 (+5.41 pct)
>>>   4-groups:         5.96 (0.00 pct)         4.87 (+18.28 pct)
>>>   8-groups:         6.58 (0.00 pct)         5.44 (+17.32 pct)
>>> 16-groups:        11.48 (0.00 pct)         8.07 (+29.70 pct)
>>
>> I'm really confused, so you're saying that having a process wide
>> spinlock is better than what this patch does? Or are you testing against
>> something without mm-cid entirely?
> 
> It does look like the lock contention introduced by the original mm_cid 
> patch helped
> hackbench in this case. In that case, I see hackbench threads run for 
> longer on average (avg_atom)
> and total idle entries are down significantly. Even on disabling C1 and 
> C2, I see
> similar behavior. With the new mm_cid patch that gets rid of the lock 
> contention, we see a drop
> in the hackbench performance.
> 
> I will go dig into this further meanwhile if you have any pointers 
> please do let me know.

I suspect the baseline don't have spinlock contention because the test-case
schedules between threads belonging to the same process, for which the initial
mm_cid patch had an optimization which skips the spinlock entirely.

This optimization for inter-thread scheduling had to be removed in the following
patch to address the performance issue more generally, covering the inter-process
scheduling.

I suspect the regression is caused by the mm_count cache line bouncing.

Please try with this additional patch applied:

https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/

This patch has recently been merged into the mm tree.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

