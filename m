Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44212694194
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBMJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBMJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:44:03 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A9C6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:44:02 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31D9i09j042887;
        Mon, 13 Feb 2023 18:44:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 13 Feb 2023 18:44:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31D9hxnI042872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Feb 2023 18:43:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f62b6a26-5c8c-91d5-efda-47b508879c58@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Feb 2023 18:43:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
In-Reply-To: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo or Peter, are you there?

Linus is expecting that this patch (if acceptable) is sent from the locking people.

https://lkml.kernel.org/r/CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com

On 2023/02/02 22:59, Tetsuo Handa wrote:
> Currently, check_hung_uninterruptible_tasks() reports details of locks
> held in the system. Also, lockdep_print_held_locks() does not report
> details of locks held by a thread if that thread is in TASK_RUNNING state.
> Several years of experience of debugging without vmcore tells me that
> these limitations have been a barrier for understanding what went wrong
> in syzbot's "INFO: task hung in" reports.
> 
> I initially thought that the cause of "INFO: task hung in" reports is
> due to over-stressing. But I understood that over-stressing is unlikely.
> I now consider that there likely is a deadlock/livelock bug where lockdep
> cannot report as a deadlock when "INFO: task hung in" is reported.
> 
> A typical case is that thread-1 is waiting for something to happen (e.g.
> wait_event_*()) with a lock held. When thread-2 tries to hold that lock
> using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
> thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
> to hold. But currently check_hung_uninterruptible_tasks() cannot report
> the exact location of thread-1 which gives us an important hint for
> understanding why thread-1 is holding that lock for so long period.
> 
> When check_hung_uninterruptible_tasks() reports a thread waiting for a
> lock, it is important to report backtrace of threads which already held
> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
> the exact location of threads which is holding any lock.
> 
> debug_show_all_lock_holders() skips current thread if the caller is
> holding no lock, for reporting RCU lock taken inside that function is
> generally useless.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v3:
>   Unshare debug_show_all_lock_holders() and debug_show_all_locks(),
>   suggested by Ingo Molnar <mingo@kernel.org>.
> 
> Changes in v2:
>   Share debug_show_all_lock_holders() and debug_show_all_locks(),
>   suggested by Waiman Long <longman@redhat.com>.
> 
>  include/linux/debug_locks.h |  5 +++++
>  kernel/hung_task.c          |  2 +-
>  kernel/locking/lockdep.c    | 28 ++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 

