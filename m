Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327786944A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBMLfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjBMLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:34:59 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0882118
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:34:57 -0800 (PST)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31DBYtCg068448;
        Mon, 13 Feb 2023 20:34:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Mon, 13 Feb 2023 20:34:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31DBYtUX068445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Feb 2023 20:34:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <274adab4-9922-1586-7593-08d9db5479a1@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Feb 2023 20:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
 <Y+oY3Xd43nNnkDSB@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y+oY3Xd43nNnkDSB@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/13 20:02, Peter Zijlstra wrote:
>> @@ -213,7 +213,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>>   unlock:
>>  	rcu_read_unlock();
>>  	if (hung_task_show_lock)
>> -		debug_show_all_locks();
>> +		debug_show_all_lock_holders();
>>  
>>  	if (hung_task_show_all_bt) {
>>  		hung_task_show_all_bt = false;
> 
> This being the hung-task detector, which is mostly about sleeping locks.

Yes, the intent of this patch is to report tasks sleeping with locks held,
for the cause of hung task is sometimes a deadlock.

>> +	rcu_read_lock();
>> +	for_each_process_thread(g, p) {
>> +		if (!p->lockdep_depth)
>> +			continue;
>> +		if (p == current && p->lockdep_depth == 1)
>> +			continue;
>> +		sched_show_task(p);
> 
> And sched_show_task() being an utter piece of crap that will basically
> print garbage for anything that's running (it doesn't have much
> options).
> 
> Should we try and do better? dump_cpu_task() prefers
> trigger_single_cpu_backtrace(), which sends an interrupt in order to get
> active registers for the CPU.

What is the intent of using trigger_single_cpu_backtrace() here?
check_hung_uninterruptible_tasks() is calling trigger_all_cpu_backtrace()
if sysctl_hung_task_all_cpu_backtrace is set. 

Locks held and kernel backtrace are helpful for describing deadlock
situation, but registers values are not. What is important is that
tasks which are not on CPUs are reported, for when a task is reported as
hung, that task must be sleeping. Therefore, I think sched_show_task()
is fine.

