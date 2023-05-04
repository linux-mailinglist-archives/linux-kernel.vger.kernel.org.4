Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8888A6F6564
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEDHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDHBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:01:47 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B0C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:01:44 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34471MqH022016;
        Thu, 4 May 2023 16:01:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Thu, 04 May 2023 16:01:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34471MtM022012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 May 2023 16:01:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7ea26a76-5c8c-a0d2-5b5e-63e370cdcb99@I-love.SAKURA.ne.jp>
Date:   Thu, 4 May 2023 16:01:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [fs?] INFO: task hung in synchronize_rcu (4)
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+222aa26d0a5dbc2e84fe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <20230504061613.3901-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230504061613.3901-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/04 15:16, Hillf Danton wrote:
>> 4 locks held by syz-executor.2/5077:
>>  #0: ffff8880b993c2d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:539
>>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: mm_cid_get kernel/sched/sched.h:3280 [inline]
>>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: switch_mm_cid kernel/sched/sched.h:3302 [inline]
>>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: prepare_task_switch kernel/sched/core.c:5117 [inline]
>>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: context_switch kernel/sched/core.c:5258 [inline]
>>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: __schedule+0x2802/0x5770 kernel/sched/core.c:6625
>>  #2: ffff8880b9929698 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
>>  #3: ffffffff91fb4ac8 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x134/0x3f0 lib/debugobjects.c:690
> 
> What is hard to understand in this report is, how could acquire the
> timer base lock with the mm cid lock held [1]?

Please be aware that lockdep_print_held_locks() is not an atomic action.
Since synchronous printk() is slow, it can sometimes happen that
task_is_running(p) becomes true after passing the

	if (p != current && task_is_running(p))
		return;

check. I think that this trace is an example where print_lock() by chance hit
hlock_class(p->held_locks + 2) != NULL. If sched_show_task() were also available,
we can know it via mismatch between sched_show_task() and lockdep_print_held_locks().

Linus, I think that "[PATCH v3 (repost)] locking/lockdep: add debug_show_all_lock_holders()"
helps here, but I can't wake up locking people. What can we do?

> 
> static inline int mm_cid_get(struct mm_struct *mm)
> {
> 	int ret;
> 
> 	lockdep_assert_irqs_disabled();
> 	raw_spin_lock(&mm->cid_lock);
> 	ret = __mm_cid_get(mm);
> 	raw_spin_unlock(&mm->cid_lock);
> 	return ret;
> }
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/kernel/sched/sched.h?id=6686317855c6#n3280
> 

