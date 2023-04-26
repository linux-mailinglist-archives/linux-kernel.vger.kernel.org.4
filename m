Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BA6EF5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjDZNoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjDZNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:44:04 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A94C21
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:44:02 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33QDi08O070604;
        Wed, 26 Apr 2023 22:44:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Wed, 26 Apr 2023 22:44:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33QDi0Km070600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Apr 2023 22:44:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a11a2d1e-c74f-c6a2-fa8f-c5a06aa9ce4d@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Apr 2023 22:43:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
References: <20230404090132.611-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230404090132.611-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo or Peter, can we make progress on this patch?
Linus wants this patch be handled by locking people, if this patch is acceptable.

https://lkml.kernel.org/r/CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com

On 2023/04/04 18:01, Hillf Danton wrote:
>> When check_hung_uninterruptible_tasks() reports a thread waiting for a
>> lock, it is important to report backtrace of threads which already held
>> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
>> the exact location of threads which is holding any lock.
> 
> Yeah more info should have been printed for udevd/5109 to help work out
> the cause of task hung [1].
> 
> [1] https://lore.kernel.org/lkml/000000000000ac91f005f5eec2e5@google.com/
>>
>> debug_show_all_lock_holders() skips current thread if the caller is
>> holding no lock, for reporting RCU lock taken inside that function is
>> generally useless.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
> 
> Acked-by: Hillf Danton <hdanton@sina.com>
> 
>> I couldn't catch Peter's question at
>> https://lkml.kernel.org/r/Y+oY3Xd43nNnkDSB@hirez.programming.kicks-ass.net .
>> I consider that this patch as-is is helpful, for not all TASK_RUNNING threads
>> are actually running on some CPU, aren't they? If we show backtrace of only
>> TASK_RUNNING threads which are running on some CPU, we fail to get hints for
>> TASK_RUNNING threads which are not running on some CPU. Therefore, I consider
>> that showing backtrace of TASK_RUNNING threads which are not running on some
>> CPU is better than not showing.

