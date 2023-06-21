Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016DC7391BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFUVks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjFUVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:40:45 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891B9B;
        Wed, 21 Jun 2023 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1687383641;
        bh=GUeHkGtf9nzKrZD4hHfYzOmgJL1jqPJdAb6wT2YUUmU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=g7A/DN2dbHIPkxVezXDuLOErqKiha4atpZdARKcsWbJzrg3PuiMIfiUOV+57riJSS
         POuX3r0Uv6elLvDQqYR1sRGcC/eyoqUHi5CjHv+7c8TrXhe7VQGeEJPZc4Kp4Sf8gr
         0WedRVB8gzkbBQzx4/+szjNTLb0Dod3i0OpEMNJaqfgu+0/BeSOlJyvp0eerzlOg8P
         7QM+o1mcJB5Is9R5TPIOTpqPDfvPiUJjEaW0rL8r2uX3n2pcHreFBO+PFMUN6XomRC
         hTjd++6EAFsW1c6+Lx8XczUpnV6mWe+lLKDxARfuEoV9nCdQTZTzqgGVtDXGJhlc1A
         OQSvUNK9yF5jw==
Received: from [192.168.18.28] (unknown [198.16.185.171])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QmcPP35RSz19KJ;
        Wed, 21 Jun 2023 17:40:41 -0400 (EDT)
Message-ID: <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
Date:   Wed, 21 Jun 2023 17:41:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Johansen <john.johansen@canonical.com>
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
In-Reply-To: <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
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

On 6/21/23 14:51, Mathieu Desnoyers wrote:
> On 6/21/23 12:36, Swapnil Sapkal wrote:
>> Hello Mathieu,
>>
> [...]
>>>
>>> I suspect the regression is caused by the mm_count cache line bouncing.
>>>
>>> Please try with this additional patch applied:
>>>
>>> https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/
>>
>> Thanks for the suggestion. I tried out with the patch you suggested. I 
>> am seeing
>> improvement in hackbench numbers with mm_count padding. But this is 
>> not matching
>> with what we achieved through reverting the new mm_cid patch.
>>
>> Below are the results on the 1 Socket 4th Generation EPYC Processor (1 
>> x 96C/192T):
>>
>> Threads:
>>
>> Test:              Base (v6.4-rc1)   Base + new_mmcid_reverted  Base + 
>> mm_count_padding
>>   1-groups:         5.23 (0.00 pct)         4.61 (11.85 pct)        
>> 5.11 (2.29 pct)
>>   2-groups:         4.99 (0.00 pct)         4.72 (5.41 pct)         
>> 5.00 (-0.20 pct)
>>   4-groups:         5.96 (0.00 pct)         4.87 (18.28 pct)        
>> 5.86 (1.67 pct)
>>   8-groups:         6.58 (0.00 pct)         5.44 (17.32 pct)        
>> 6.20 (5.77 pct)
>> 16-groups:        11.48 (0.00 pct)         8.07 (29.70 pct)       
>> 10.68 (6.96 pct)
>>
>> Processes:
>>
>> Test:              Base (v6.4-rc1)  Base + new_mmcid_reverted   Base + 
>> mm_count_padding
>>   1-groups:         5.19 (0.00 pct)         4.90 (5.58 pct)         
>> 5.19 (0.00 pct)
>>   2-groups:         5.44 (0.00 pct)         5.39 (0.91 pct)         
>> 5.39 (0.91 pct)
>>   4-groups:         5.69 (0.00 pct)         5.64 (0.87 pct)         
>> 5.64 (0.87 pct)
>>   8-groups:         6.08 (0.00 pct)         6.01 (1.15 pct)         
>> 6.04 (0.65 pct)
>> 16-groups:        10.87 (0.00 pct)        10.83 (0.36 pct)        
>> 10.93 (-0.55 pct)
>>
>> The ibs profile shows that function __switch_to_asm() is coming at top 
>> in baseline
>> run and is not seen with mm_count padding patch. Will be attaching 
>> full ibs profile
>> data for all the 3 runs:
>>
>> # Base (v6.4-rc1)
>> Threads:
>> Total time: 11.486 [sec]
>>
>>     5.15%  sched-messaging  [kernel.vmlinux]      [k] __switch_to_asm
>>     4.31%  sched-messaging  [kernel.vmlinux]      [k] copyout
>>     4.29%  sched-messaging  [kernel.vmlinux]      [k] 
>> native_queued_spin_lock_slowpath
>>     4.22%  sched-messaging  [kernel.vmlinux]      [k] copyin
>>     3.92%  sched-messaging  [kernel.vmlinux]      [k] 
>> apparmor_file_permission
>>     2.91%  sched-messaging  [kernel.vmlinux]      [k] __schedule
>>     2.34%  swapper          [kernel.vmlinux]      [k] __switch_to_asm
>>     2.10%  sched-messaging  [kernel.vmlinux]      [k] 
>> prepare_to_wait_event
>>     2.10%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
>>     2.07%  sched-messaging  [kernel.vmlinux]      [k] 
>> finish_task_switch.isra.0
>>     2.00%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
>>     1.82%  sched-messaging  [kernel.vmlinux]      [k] 
>> check_preemption_disabled
>>     1.73%  sched-messaging  [kernel.vmlinux]      [k] 
>> exit_to_user_mode_prepare
>>     1.52%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
>>     1.49%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>     1.45%  sched-messaging  libc.so.6             [.] write
>>     1.44%  swapper          [kernel.vmlinux]      [k] native_sched_clock
>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] psi_group_change
>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
>>     1.37%  sched-messaging  libc.so.6             [.] read
>>     1.06%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
>>     1.01%  swapper          [kernel.vmlinux]      [k] psi_group_change
>>     1.00%  sched-messaging  [kernel.vmlinux]      [k] update_curr
>>
>> # Base + mm_count_padding
>> Threads:
>> Total time: 11.384 [sec]
>>
>>     4.43%  sched-messaging  [kernel.vmlinux]         [k] copyin
>>     4.39%  sched-messaging  [kernel.vmlinux]         [k] 
>> native_queued_spin_lock_slowpath
>>     4.07%  sched-messaging  [kernel.vmlinux]         [k] 
>> apparmor_file_permission
>>     4.07%  sched-messaging  [kernel.vmlinux]         [k] copyout
>>     2.49%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSCALL_64
>>     2.37%  sched-messaging  [kernel.vmlinux]         [k] update_cfs_group
>>     2.19%  sched-messaging  [kernel.vmlinux]         [k] pipe_write
>>     2.00%  sched-messaging  [kernel.vmlinux]         [k] 
>> check_preemption_disabled
>>     1.93%  swapper          [kernel.vmlinux]         [k] update_load_avg
>>     1.81%  sched-messaging  [kernel.vmlinux]         [k] 
>> exit_to_user_mode_prepare
>>     1.69%  sched-messaging  [kernel.vmlinux]         [k] try_to_wake_up
>>     1.58%  sched-messaging  libc.so.6                [.] write
>>     1.53%  sched-messaging  [kernel.vmlinux]         [k] psi_group_change
>>     1.50%  sched-messaging  libc.so.6                [.] read
>>     1.50%  sched-messaging  [kernel.vmlinux]         [k] pipe_read
>>     1.39%  sched-messaging  [kernel.vmlinux]         [k] update_load_avg
>>     1.39%  sched-messaging  [kernel.vmlinux]         [k] osq_lock
>>     1.30%  sched-messaging  [kernel.vmlinux]         [k] update_curr
>>     1.28%  swapper          [kernel.vmlinux]         [k] psi_group_change
>>     1.16%  sched-messaging  [kernel.vmlinux]         [k] vfs_read
>>     1.12%  sched-messaging  [kernel.vmlinux]         [k] vfs_write
>>     1.10%  sched-messaging  [kernel.vmlinux]         [k] 
>> entry_SYSRETQ_unsafe_stack
>>     1.09%  sched-messaging  [kernel.vmlinux]         [k] __switch_to_asm
>>     1.08%  sched-messaging  [kernel.vmlinux]         [k] do_syscall_64
>>     1.06%  sched-messaging  [kernel.vmlinux]         [k] 
>> select_task_rq_fair
>>     1.03%  swapper          [kernel.vmlinux]         [k] update_cfs_group
>>     1.00%  swapper          [kernel.vmlinux]         [k] rb_insert_color
>>
>> # Base + reverted_new_mm_cid
>> Threads:
>> Total time: 7.847 [sec]
>>
>>    12.14%  sched-messaging  [kernel.vmlinux]      [k] 
>> native_queued_spin_lock_slowpath
>>     8.86%  swapper          [kernel.vmlinux]      [k] 
>> native_queued_spin_lock_slowpath
>>     6.13%  sched-messaging  [kernel.vmlinux]      [k] copyin
>>     5.54%  sched-messaging  [kernel.vmlinux]      [k] 
>> apparmor_file_permission
>>     3.59%  sched-messaging  [kernel.vmlinux]      [k] copyout
>>     2.61%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>     2.48%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
>>     2.33%  sched-messaging  [kernel.vmlinux]      [k] 
>> exit_to_user_mode_prepare
>>     2.01%  sched-messaging  [kernel.vmlinux]      [k] 
>> check_preemption_disabled
>>     1.96%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
>>     1.91%  sched-messaging  libc.so.6             [.] write
>>     1.77%  sched-messaging  libc.so.6             [.] read
>>     1.64%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
>>     1.58%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
>>     1.52%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] 
>> ktime_get_coarse_real_ts64
>>     1.35%  sched-messaging  [kernel.vmlinux]      [k] vfs_write
>>     1.28%  sched-messaging  [kernel.vmlinux]      [k] 
>> entry_SYSRETQ_unsafe_stack
>>     1.28%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
>>     1.25%  sched-messaging  [kernel.vmlinux]      [k] do_syscall_64
>>     1.22%  sched-messaging  [kernel.vmlinux]      [k] __fget_light
>>     1.18%  sched-messaging  [kernel.vmlinux]      [k] mutex_lock
>>     1.12%  sched-messaging  [kernel.vmlinux]      [k] file_update_time
>>     1.04%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter
>>     1.01%  sched-messaging  [kernel.vmlinux]      [k] current_time
>>
>> So with the reverted new_mm_cid patch, we are seeing a lot of time 
>> being spent in
>> native_queued_spin_lock_slowpath and yet, hackbench finishes faster.
>>
>> I keep further digging into this please let me know if you have any 
>> pointers for me.
> 
> Do you have CONFIG_SECURITY_APPARMOR=y ? Can you try without ?
> 
> I notice that apparmor_file_permission appears near the top of your
> profiles, and apparmor uses an internal aa_buffers_lock spinlock,
> which could possibly explain the top hits for
> native_queued_spin_lock_slowpath. My current suspicion is that
> the raw spinlock that was taken by "Base + reverted_new_mm_cid"
> changed the contention pattern on the apparmor lock enough to
> speed things up by pure accident.

If apparmor happens to be the culprit here, we should have a hard look 
at this commit:

commit df323337e50 "apparmor: Use a memory pool instead per-CPU caches"

Which turned a per-cpu cache into a global memory pool protected by a 
spinlock. It may benefit RT, but it does not appear to be so great at 
scaling.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

