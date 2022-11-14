Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B47627A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiKNKHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiKNKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:06:37 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98131FCE7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:05:54 -0800 (PST)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2AEA5qxR057220;
        Mon, 14 Nov 2022 19:05:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Mon, 14 Nov 2022 19:05:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2AEA5qBH057211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Nov 2022 19:05:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <523ea5ef-8b2f-ddc5-1e52-4bcc2aad698d@I-love.SAKURA.ne.jp>
Date:   Mon, 14 Nov 2022 19:05:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <d5393b0e-a296-3296-d376-c9178669747b@I-love.SAKURA.ne.jp>
 <3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com>
 <9f42e8a5-f809-3f2c-0fda-b7657bc94eb3@I-love.SAKURA.ne.jp>
 <1fd381e0-03e7-df2a-4865-d157714ce9b2@redhat.com>
 <1f71cfbf-7bee-6a06-dca1-ac94bf542cd7@I-love.SAKURA.ne.jp>
 <5f853677-874a-2a38-4253-95b2795eb7a8@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <5f853677-874a-2a38-4253-95b2795eb7a8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter or Ingo, can you take this patch?

On 2022/10/05 3:09, Waiman Long wrote:
> On 10/3/22 18:18, Tetsuo Handa wrote:
>> Can this patch go to linux.git ?
> 
> It is now up to Peter or Ingo to take it  to tip.
> 
> Cheers,
> Longman
> 
>>
>> On 2022/09/17 3:41, Waiman Long wrote:
>>> On 9/16/22 11:57, Tetsuo Handa wrote:
>>>> Currently, check_hung_uninterruptible_tasks() reports details of locks
>>>> held in the system. Also, lockdep_print_held_locks() does not report
>>>> details of locks held by a thread if that thread is in TASK_RUNNING state.
>>>> Several years of experience of debugging without vmcore tells me that
>>>> these limitations have been a barrier for understanding what went wrong
>>>> in syzbot's "INFO: task hung in" reports.
>>>>
>>>> I initially thought that the cause of "INFO: task hung in" reports is
>>>> due to over-stressing. But I understood that over-stressing is unlikely.
>>>> I now consider that there likely is a deadlock/livelock bug where lockdep
>>>> cannot report as a deadlock when "INFO: task hung in" is reported.
>>>>
>>>> A typical case is that thread-1 is waiting for something to happen (e.g.
>>>> wait_event_*()) with a lock held. When thread-2 tries to hold that lock
>>>> using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
>>>> thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
>>>> to hold. But currently check_hung_uninterruptible_tasks() cannot report
>>>> the exact location of thread-1 which gives us an important hint for
>>>> understanding why thread-1 is holding that lock for so long period.
>>>>
>>>> When check_hung_uninterruptible_tasks() reports a thread waiting for a
>>>> lock, it is important to report backtrace of threads which already held
>>>> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
>>>> the exact location of threads which is holding any lock.
>>>>
>>>> To deduplicate code, share debug_show_all_{locks,lock_holders}() using
>>>> a flag. As a side effect of sharing, __debug_show_all_locks() skips
>>>> current thread if the caller is holding no lock, for reporting RCU lock
>>>> taken inside __debug_show_all_locks() is generally useless.
>>>>
>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> Acked-by: Waiman Long <longman@redhat.com>
> 

