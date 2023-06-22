Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4073A59D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFVQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjFVQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:09:27 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149B1BFA;
        Thu, 22 Jun 2023 09:09:18 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C19C33F16E;
        Thu, 22 Jun 2023 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687450154;
        bh=jKoFXgBt2Fojq7y7my8p/BcGrQBw7pFsepOtpG3ws7Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rxLnO6of4wLQXlaPYq8qRS5kj2cQNcTFrjEtX8RcbKLaayRcrxVp4Dk6tG3Up2GG+
         4Hkaz/sJsI2SKQZCbPU8aVfY08yYKfEHDjNhAQQYCj8VRbXHrqbSmkCjmudFtenXig
         MBoGiTZAJjaeXl+xBhHH1MaQSQPKUfheJjKnhGJDk+V1Czbn8Tw6BmhNGlzD5W4t6f
         1L3K2AbzRQ6cNkTCwVukt1zVHcvrnQ0KQ2ZNFugnaz2LrnbgCXbHHYAGTuDIAXkCsH
         /5K7SXJPxf00PVmKshjMcmolWNI8Z2pUr0AK0zjhclGGd02UH5KxgXY4hDaouEKR5H
         V1RA6Kz06OUog==
Message-ID: <b09ea058-e780-5dd4-651e-548b65ebeb50@canonical.com>
Date:   Thu, 22 Jun 2023 09:09:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
 <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
 <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
 <287c33e1-acb7-62db-7267-227cbcc54707@efficios.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <287c33e1-acb7-62db-7267-227cbcc54707@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 07:33, Mathieu Desnoyers wrote:
> On 6/21/23 19:59, John Johansen wrote:
>> On 6/21/23 14:41, Mathieu Desnoyers wrote:
>>> On 6/21/23 14:51, Mathieu Desnoyers wrote:
>>>> On 6/21/23 12:36, Swapnil Sapkal wrote:
>>>>> Hello Mathieu,
>>>>>
>>>> [...]
>>>>>>
>>>>>> I suspect the regression is caused by the mm_count cache line bouncing.
>>>>>>
>>>>>> Please try with this additional patch applied:
>>>>>>
>>>>>> https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/
>>>>>
>>>>> Thanks for the suggestion. I tried out with the patch you suggested. I am seeing
>>>>> improvement in hackbench numbers with mm_count padding. But this is not matching
>>>>> with what we achieved through reverting the new mm_cid patch.
>>>>>
>>>>> Below are the results on the 1 Socket 4th Generation EPYC Processor (1 x 96C/192T):
>>>>>
>>>>> Threads:
>>>>>
>>>>> Test:              Base (v6.4-rc1)   Base + new_mmcid_reverted  Base + mm_count_padding
>>>>>   1-groups:         5.23 (0.00 pct)         4.61 (11.85 pct) 5.11 (2.29 pct)
>>>>>   2-groups:         4.99 (0.00 pct)         4.72 (5.41 pct) 5.00 (-0.20 pct)
>>>>>   4-groups:         5.96 (0.00 pct)         4.87 (18.28 pct) 5.86 (1.67 pct)
>>>>>   8-groups:         6.58 (0.00 pct)         5.44 (17.32 pct) 6.20 (5.77 pct)
>>>>> 16-groups:        11.48 (0.00 pct)         8.07 (29.70 pct) 10.68 (6.96 pct)
>>>>>
>>>>> Processes:
>>>>>
>>>>> Test:              Base (v6.4-rc1)  Base + new_mmcid_reverted   Base + mm_count_padding
>>>>>   1-groups:         5.19 (0.00 pct)         4.90 (5.58 pct) 5.19 (0.00 pct)
>>>>>   2-groups:         5.44 (0.00 pct)         5.39 (0.91 pct) 5.39 (0.91 pct)
>>>>>   4-groups:         5.69 (0.00 pct)         5.64 (0.87 pct) 5.64 (0.87 pct)
>>>>>   8-groups:         6.08 (0.00 pct)         6.01 (1.15 pct) 6.04 (0.65 pct)
>>>>> 16-groups:        10.87 (0.00 pct)        10.83 (0.36 pct) 10.93 (-0.55 pct)
>>>>>
>>>>> The ibs profile shows that function __switch_to_asm() is coming at top in baseline
>>>>> run and is not seen with mm_count padding patch. Will be attaching full ibs profile
>>>>> data for all the 3 runs:
>>>>>
>>>>> # Base (v6.4-rc1)
>>>>> Threads:
>>>>> Total time: 11.486 [sec]
>>>>>
>>>>>     5.15%  sched-messaging  [kernel.vmlinux]      [k] __switch_to_asm
>>>>>     4.31%  sched-messaging  [kernel.vmlinux]      [k] copyout
>>>>>     4.29%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>>>>     4.22%  sched-messaging  [kernel.vmlinux]      [k] copyin
>>>>>     3.92%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
>>>>>     2.91%  sched-messaging  [kernel.vmlinux]      [k] __schedule
>>>>>     2.34%  swapper          [kernel.vmlinux]      [k] __switch_to_asm
>>>>>     2.10%  sched-messaging  [kernel.vmlinux]      [k] prepare_to_wait_event
>>>>>     2.10%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
>>>>>     2.07%  sched-messaging  [kernel.vmlinux]      [k] finish_task_switch.isra.0
>>>>>     2.00%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
>>>>>     1.82%  sched-messaging  [kernel.vmlinux]      [k] check_preemption_disabled
>>>>>     1.73%  sched-messaging  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
>>>>>     1.52%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
>>>>>     1.49%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>>>>     1.45%  sched-messaging  libc.so.6             [.] write
>>>>>     1.44%  swapper          [kernel.vmlinux]      [k] native_sched_clock
>>>>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] psi_group_change
>>>>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
>>>>>     1.37%  sched-messaging  libc.so.6             [.] read
>>>>>     1.06%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
>>>>>     1.01%  swapper          [kernel.vmlinux]      [k] psi_group_change
>>>>>     1.00%  sched-messaging  [kernel.vmlinux]      [k] update_curr
>>>>>
>>>>> # Base + mm_count_padding
>>>>> Threads:
>>>>> Total time: 11.384 [sec]
>>>>>
>>>>>     4.43%  sched-messaging  [kernel.vmlinux]         [k] copyin
>>>>>     4.39%  sched-messaging  [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>>>>>     4.07%  sched-messaging  [kernel.vmlinux]         [k] apparmor_file_permission
>>>>>     4.07%  sched-messaging  [kernel.vmlinux]         [k] copyout
>>>>>     2.49%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSCALL_64
>>>>>     2.37%  sched-messaging  [kernel.vmlinux]         [k] update_cfs_group
>>>>>     2.19%  sched-messaging  [kernel.vmlinux]         [k] pipe_write
>>>>>     2.00%  sched-messaging  [kernel.vmlinux]         [k] check_preemption_disabled
>>>>>     1.93%  swapper          [kernel.vmlinux]         [k] update_load_avg
>>>>>     1.81%  sched-messaging  [kernel.vmlinux]         [k] exit_to_user_mode_prepare
>>>>>     1.69%  sched-messaging  [kernel.vmlinux]         [k] try_to_wake_up
>>>>>     1.58%  sched-messaging  libc.so.6                [.] write
>>>>>     1.53%  sched-messaging  [kernel.vmlinux]         [k] psi_group_change
>>>>>     1.50%  sched-messaging  libc.so.6                [.] read
>>>>>     1.50%  sched-messaging  [kernel.vmlinux]         [k] pipe_read
>>>>>     1.39%  sched-messaging  [kernel.vmlinux]         [k] update_load_avg
>>>>>     1.39%  sched-messaging  [kernel.vmlinux]         [k] osq_lock
>>>>>     1.30%  sched-messaging  [kernel.vmlinux]         [k] update_curr
>>>>>     1.28%  swapper          [kernel.vmlinux]         [k] psi_group_change
>>>>>     1.16%  sched-messaging  [kernel.vmlinux]         [k] vfs_read
>>>>>     1.12%  sched-messaging  [kernel.vmlinux]         [k] vfs_write
>>>>>     1.10%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSRETQ_unsafe_stack
>>>>>     1.09%  sched-messaging  [kernel.vmlinux]         [k] __switch_to_asm
>>>>>     1.08%  sched-messaging  [kernel.vmlinux]         [k] do_syscall_64
>>>>>     1.06%  sched-messaging  [kernel.vmlinux]         [k] select_task_rq_fair
>>>>>     1.03%  swapper          [kernel.vmlinux]         [k] update_cfs_group
>>>>>     1.00%  swapper          [kernel.vmlinux]         [k] rb_insert_color
>>>>>
>>>>> # Base + reverted_new_mm_cid
>>>>> Threads:
>>>>> Total time: 7.847 [sec]
>>>>>
>>>>>    12.14%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>>>>     8.86%  swapper          [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>>>>     6.13%  sched-messaging  [kernel.vmlinux]      [k] copyin
>>>>>     5.54%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
>>>>>     3.59%  sched-messaging  [kernel.vmlinux]      [k] copyout
>>>>>     2.61%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>>>>     2.48%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
>>>>>     2.33%  sched-messaging  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
>>>>>     2.01%  sched-messaging  [kernel.vmlinux]      [k] check_preemption_disabled
>>>>>     1.96%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
>>>>>     1.91%  sched-messaging  libc.so.6             [.] write
>>>>>     1.77%  sched-messaging  libc.so.6             [.] read
>>>>>     1.64%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
>>>>>     1.58%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
>>>>>     1.52%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
>>>>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] ktime_get_coarse_real_ts64
>>>>>     1.35%  sched-messaging  [kernel.vmlinux]      [k] vfs_write
>>>>>     1.28%  sched-messaging  [kernel.vmlinux]      [k] entry_SYSRETQ_unsafe_stack
>>>>>     1.28%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
>>>>>     1.25%  sched-messaging  [kernel.vmlinux]      [k] do_syscall_64
>>>>>     1.22%  sched-messaging  [kernel.vmlinux]      [k] __fget_light
>>>>>     1.18%  sched-messaging  [kernel.vmlinux]      [k] mutex_lock
>>>>>     1.12%  sched-messaging  [kernel.vmlinux]      [k] file_update_time
>>>>>     1.04%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter
>>>>>     1.01%  sched-messaging  [kernel.vmlinux]      [k] current_time
>>>>>
>>>>> So with the reverted new_mm_cid patch, we are seeing a lot of time being spent in
>>>>> native_queued_spin_lock_slowpath and yet, hackbench finishes faster.
>>>>>
>>>>> I keep further digging into this please let me know if you have any pointers for me.
>>>>
>>>> Do you have CONFIG_SECURITY_APPARMOR=y ? Can you try without ?
>>>>
>>>> I notice that apparmor_file_permission appears near the top of your
>>>> profiles, and apparmor uses an internal aa_buffers_lock spinlock,
>>>> which could possibly explain the top hits for
>>>> native_queued_spin_lock_slowpath. My current suspicion is that
>>>> the raw spinlock that was taken by "Base + reverted_new_mm_cid"
>>>> changed the contention pattern on the apparmor lock enough to
>>>> speed things up by pure accident.
>>>
>>> If apparmor happens to be the culprit here, we should have a hard look at this commit:
>>>
>>> commit df323337e50 "apparmor: Use a memory pool instead per-CPU caches"
>>>
>>> Which turned a per-cpu cache into a global memory pool protected by a spinlock. It may benefit RT, but it does not appear to be so great at scaling.
>>>
>> it is not. And I have a patch that needs some more formal testing for some stats.
>> Ubuntu pulled it in last cycle so it has gotten a fair bit of use and is looking good
>> on that end. There are probably some tweaks that can be done to improve it. The
>> backoff in particular is something that has mostly been adjusted in response to some
>> basic benchmarking.
>>
>> anyways patch below
> 
> I don't understand why all these heuristics are needed at all ?
> 
it can be simplified. The scaling heuristic came out of playing with it, doing some testing to reduce lock contention. Like I said it needs work. There is a reason its not landed anywhere yet. And yes it may not even be the right approach

> What was fundamentally wrong with the per-cpu caches before commit df323337e50 other than being non-RT friendly ? Was the only purpose of that commit to reduce the duration of preempt-off critical sections, or is there a bigger picture concern it was taking care of by introducing a global pool ?
> 
- reducing preempt critical sections for rt.
- need to use GFP_ATOMIC within those large critical sections, there are audit allocations, etc.
- those large critical sections also introduce other locking constraints, that we wanted/needed to get rid of. There are places now that might sleep within the bounds of the old large critical section.
- reduce memory overhead on large multi-core systems

> Introducing per-cpu memory pools, dealing with migration by giving entries back to the right cpu's pool, taking into account the cpu the entry belongs to, and use a per-cpu/lock-free data structure allowing lock-free push to give back an entry on a remote cpu should do the trick without locking, and without long preempt-off critical sections.
I am not opposed to doing that, but we will need to be able to deal with preemption making it so we might need additional buffers for a given cpu, which either means allocating them, or having an even larger per cpu pool preallocated.

The other issue is the overhead on large multi-core systems, which makes going with a large preallocated set.

> 
> The only downside I see for per-cpu memory pools is a slightly larger memory overhead on large multi-core systems. But is that really a concern ?
> 
I was told it is

> What am I missing here ?
> 
different people/groups having conflicting constraints.
- make it work with RT
- reduce large system overhead
- make it fast
...

> Thanks,
> 
> Mathieu
> 
>>
>> commit e057e9b47f1749882ea0efb4427d6b9671c761ab
>> Author: John Johansen <john.johansen@canonical.com>
>> Date:   Tue Oct 25 01:18:41 2022 -0700
>>
>>      apparmor: cache buffers on percpu list if there is lock contention
>>      df323337e507 ("apparmor: Use a memory pool instead per-CPU caches")
>>      changed buffer allocation to use a memory pool, however on a heavily
>>      loaded machine there can be lock contention on the global buffers
>>      lock. Add a percpu list to cache buffers on when lock contention is
>>      encountered.
>>      When allocating buffers attempt to use cached buffers first,
>>      before taking the global buffers lock. When freeing buffers
>>      try to put them back to the global list but if contention is
>>      encountered, put the buffer on the percpu list.
>>      The length of time a buffer is held on the percpu list is dynamically
>>      adjusted based on lock contention.  The amount of hold time is rapidly
>>      increased and slow ramped down.
>>      v4:
>>      - fix percpu ->count buffer count which had been spliced across a
>>        debug patch.
>>      - introduce define for MAX_LOCAL_COUNT
>>      - rework count check and locking around it.
>>      - update commit message to reference commit that introduced the
>>        memory pool.
>>      v3:
>>      - limit number of buffers that can be pushed onto the percpu
>>        list. This avoids a problem on some kernels where one percpu
>>        list can inherit buffers from another cpu after a reschedule,
>>        causing more kernel memory to used than is necessary. Under
>>        normal conditions this should eventually return to normal
>>        but under pathelogical conditions the extra memory consumption
>>        may have been unbouanded
>>      v2:
>>      - dynamically adjust buffer hold time on percpu list based on
>>        lock contention.
>>      v1:
>>      - cache buffers on percpu list on lock contention
>>      Signed-off-by: John Johansen <john.johansen@canonical.com>
>>
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index e6671a4a89c4..ea3af769af5a 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -55,12 +55,21 @@ union aa_buffer {
>>       char buffer[1];
>>   };
>>
>> +struct aa_local_cache {
>> +    unsigned int contention;
>> +    unsigned int hold;
>> +    unsigned int count;
>> +    struct list_head head;
>> +};
>> +
>> +#define MAX_LOCAL_COUNT 2
>>   #define RESERVE_COUNT 2
>>   static int reserve_count = RESERVE_COUNT;
>>   static int buffer_count;
>>
>>   static LIST_HEAD(aa_global_buffers);
>>   static DEFINE_SPINLOCK(aa_buffers_lock);
>> +static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
>>
>>   struct kmem_cache *aa_audit_slab;
>>
>> @@ -2029,14 +2038,45 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>>       return 0;
>>   }
>>
>> +static void update_contention(struct aa_local_cache *cache)
>> +{
>> +    cache->contention += 3;
>> +    if (cache->contention > 9)
>> +        cache->contention = 9;
>> +    cache->hold += 1 << cache->contention;        /* 8, 64, 512 */
>> +}
>> +
>>   char *aa_get_buffer(bool in_atomic)
>>   {
>>       union aa_buffer *aa_buf;
>> +    struct aa_local_cache *cache;
>>       bool try_again = true;
>>       gfp_t flags = (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>>
>> +    /* use per cpu cached buffers first */
>> +    cache = get_cpu_ptr(&aa_local_buffers);
>> +    if (!list_empty(&cache->head)) {
>> +        aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
>> +        list_del(&aa_buf->list);
>> +        cache->hold--;
>> +        cache->count--;
>> +        put_cpu_ptr(&aa_local_buffers);
>> +        return &aa_buf->buffer[0];
>> +    }
>> +    put_cpu_ptr(&aa_local_buffers);
>> +
>> +    if (!spin_trylock(&aa_buffers_lock)) {
>> +        cache = get_cpu_ptr(&aa_local_buffers);
>> +        update_contention(cache);
>> +        put_cpu_ptr(&aa_local_buffers);
>> +        spin_lock(&aa_buffers_lock);
>> +    } else {
>> +        cache = get_cpu_ptr(&aa_local_buffers);
>> +        if (cache->contention)
>> +            cache->contention--;
>> +        put_cpu_ptr(&aa_local_buffers);
>> +    }
>>   retry:
>> -    spin_lock(&aa_buffers_lock);
>>       if (buffer_count > reserve_count ||
>>           (in_atomic && !list_empty(&aa_global_buffers))) {
>>           aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
>> @@ -2062,6 +2102,7 @@ char *aa_get_buffer(bool in_atomic)
>>       if (!aa_buf) {
>>           if (try_again) {
>>               try_again = false;
>> +            spin_lock(&aa_buffers_lock);
>>               goto retry;
>>           }
>>           pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
>> @@ -2073,15 +2114,42 @@ char *aa_get_buffer(bool in_atomic)
>>   void aa_put_buffer(char *buf)
>>   {
>>       union aa_buffer *aa_buf;
>> +    struct aa_local_cache *cache;
>>
>>       if (!buf)
>>           return;
>>       aa_buf = container_of(buf, union aa_buffer, buffer[0]);
>>
>> -    spin_lock(&aa_buffers_lock);
>> -    list_add(&aa_buf->list, &aa_global_buffers);
>> -    buffer_count++;
>> -    spin_unlock(&aa_buffers_lock);
>> +    cache = get_cpu_ptr(&aa_local_buffers);
>> +    if (!cache->hold) {
>> +        bool must_lock = cache->count >= MAX_LOCAL_COUNT;
>> +
>> +        put_cpu_ptr(&aa_local_buffers);
>> +
>> +        if (must_lock) {
>> +            spin_lock(&aa_buffers_lock);
>> +            goto locked;
>> +        } else if (spin_trylock(&aa_buffers_lock)) {
>> +        locked:
>> +            /* put back on global list */
>> +            list_add(&aa_buf->list, &aa_global_buffers);
>> +            buffer_count++;
>> +            spin_unlock(&aa_buffers_lock);
>> +            cache = get_cpu_ptr(&aa_local_buffers);
>> +            if (cache->contention)
>> +                cache->contention--;
>> +            put_cpu_ptr(&aa_local_buffers);
>> +            return;
>> +        }
>> +        /* contention on global list, fallback to percpu */
>> +        cache = get_cpu_ptr(&aa_local_buffers);
>> +        update_contention(cache);
>> +    }
>> +
>> +    /* cache in percpu list */
>> +    list_add(&aa_buf->list, &cache->head);
>> +    cache->count++;
>> +    put_cpu_ptr(&aa_local_buffers);
>>   }
>>
>>   /*
>> @@ -2123,6 +2191,16 @@ static int __init alloc_buffers(void)
>>       union aa_buffer *aa_buf;
>>       int i, num;
>>
>> +    /*
>> +     * per cpu set of cached allocated buffers used to help reduce
>> +     * lock contention
>> +     */
>> +    for_each_possible_cpu(i) {
>> +        per_cpu(aa_local_buffers, i).contention = 0;
>> +        per_cpu(aa_local_buffers, i).hold = 0;
>> +        per_cpu(aa_local_buffers, i).count = 0;
>> +        INIT_LIST_HEAD(&per_cpu(aa_local_buffers, i).head);
>> +    }
>>       /*
>>        * A function may require two buffers at once. Usually the buffers are
>>        * used for a short period of time and are shared. On UP kernel buffers
>>
>>
>>
>>
> 

