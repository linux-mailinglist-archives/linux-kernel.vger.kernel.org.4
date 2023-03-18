Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39B86BF98B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCRLPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:15:13 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87630B0E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:11 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32IBF9T1031716;
        Sat, 18 Mar 2023 20:15:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 18 Mar 2023 20:15:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32IBF9eW031712
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Mar 2023 20:15:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1f41d750-d885-55e8-77a3-7bd9a95979e2@I-love.SAKURA.ne.jp>
Date:   Sat, 18 Mar 2023 20:15:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
References: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
 <Y+oY3Xd43nNnkDSB@hirez.programming.kicks-ass.net>
 <274adab4-9922-1586-7593-08d9db5479a1@I-love.SAKURA.ne.jp>
 <Y+ox39WhgY/iaVsG@hirez.programming.kicks-ass.net>
 <393a440f-5f82-432c-bc24-e8de33e29d75@I-love.SAKURA.ne.jp>
In-Reply-To: <393a440f-5f82-432c-bc24-e8de33e29d75@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter?

On 2023/02/13 22:49, Tetsuo Handa wrote:
> On 2023/02/13 21:49, Peter Zijlstra wrote:
>>>> And sched_show_task() being an utter piece of crap that will basically
>>>> print garbage for anything that's running (it doesn't have much
>>>> options).
>>>>
>>>> Should we try and do better? dump_cpu_task() prefers
>>>> trigger_single_cpu_backtrace(), which sends an interrupt in order to get
>>>> active registers for the CPU.
>>>
>>> What is the intent of using trigger_single_cpu_backtrace() here?
>>> check_hung_uninterruptible_tasks() is calling trigger_all_cpu_backtrace()
>>> if sysctl_hung_task_all_cpu_backtrace is set.
>>
>> Then have that also print the held locks for those tasks. And skip over
>> them again later.
>>
>>> Locks held and kernel backtrace are helpful for describing deadlock
>>> situation, but registers values are not.
>>
>> Register state is required to start the unwind. You can't unwind a
>> running task out of thin-air.
> 
> Excuse me. There are two types of TASK_RUNNING tasks, one is that a thread
> is actually running on some CPU, and the other is that a thread is waiting
> for CPU to become available for that thread, aren't there?
> 
> lockdep_print_held_locks() does not show locks held even if a thread is
> waiting for CPU to become available for that thread, does it?
> 
> But sched_show_task() can show backtrace even if a thread is waiting for
> CPU to become available for that thread, can't it?
> 
> Therefore, calling sched_show_task() helps understanding what that thread
> is doing when lockdep_print_held_locks() did not show locks held.
> 
>>
>>> What is important is that tasks which are not on CPUs are reported,
>>> for when a task is reported as hung, that task must be sleeping.
>>> Therefore, I think sched_show_task() is fine.
>>
>> The backtraces generated by sched_show_task() for a running task are
>> absolutely worthless, might as well not print them.
> 
> "a thread actually running on some CPU" or
> "a thread waiting for CPU to become available for that thread",
> which does this "running task" mean?
> 
>>
>> And if I read your Changelog right, you explicitly wanted useful
>> backtraces for the running tasks -- such that you could see what they
>> were doing while holding the lock the other tasks were blocked on.
> 
> Yes, we can get useful backtraces for threads that are waiting for CPU
> to become available for that thread. That's why sched_show_task() is chosen.
> 
>>
>> The only way to do that is to send an interrupt, the interrupt will have
>> the register state for the interrupted task -- including the stack
>> pointer. By virtue of running the interrupt handler we know the stack
>> won't shrink, so we can then safely traverse the stack starting from the
>> given stack pointer.
> 
> But trigger_single_cpu_backtrace() is for a thread actually running on some CPU,
> isn't it? While it would be helpful to get backtrace of a thread that is actually
> running on some CPU, it would be helpless not getting backtrace of a thread
> that is waiting for CPU to become available for that thread.
> 
> We can later get backtrace of threads actually running on some CPU using
> trigger_all_cpu_backtrace() via sysctl_hung_task_all_cpu_backtrace setting,
> though I seldom find useful backtraces via trigger_all_cpu_backtrace(); it is
> likely that khungtaskd thread and some random workqueue thread (which are
> irrelevant to hung task) are reported via trigger_all_cpu_backtrace()...
> 

