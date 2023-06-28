Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F257410CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF1MOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:14:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56474 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjF1MOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:14:18 -0400
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35SCEHJP077978;
        Wed, 28 Jun 2023 21:14:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Wed, 28 Jun 2023 21:14:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35SCEG6P077973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Jun 2023 21:14:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
Date:   Wed, 28 Jun 2023 21:14:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de> <ZJmkPuqpW-wQAyNz@alley>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZJmkPuqpW-wQAyNz@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/06/26 23:44, Petr Mladek wrote:
> On Mon 2023-06-26 10:12:54, Sebastian Andrzej Siewior wrote:
>> On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
>>> Why not to do the same on the end side?
>>>
>>>  static inline void do_write_seqcount_end(seqcount_t *s)
>>>  {
>>> - 	seqcount_release(&s->dep_map, _RET_IP_);
>>>  	do_raw_write_seqcount_end(s);
>>> +	seqcount_release(&s->dep_map, _RET_IP_);
>>>  }
>>
>> I don't have a compelling argument for doing it. It is probably better
>> to release the lock from lockdep's point of view and then really release
>> it (so it can't be acquired before it is released).
> 
> If this is true then we should not change the ordering on the _begin
> side either. I mean that we should call the lockdep code only
> after the lock is taken. Anyway, both sides should be symmetric.
> 
> That said, lockdep is about chains of locks and not about timing.
> We must not call lockdep annotation when the lock is still available
> for a nested context. So the ordering is probably important only when
> the lock might be taken from both normal and interrupt context.
> 
> Anyway, please do not do this change only because of printk().
> IMHO, the current ordering is more logical and the printk() problem
> should be solved another way.

Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
rejected.



I found

  /*
   * Locking a pcp requires a PCP lookup followed by a spinlock. To avoid
   * a migration causing the wrong PCP to be locked and remote memory being
   * potentially allocated, pin the task to the CPU for the lookup+lock.
   * preempt_disable is used on !RT because it is faster than migrate_disable.
   * migrate_disable is used on RT because otherwise RT spinlock usage is
   * interfered with and a high priority task cannot preempt the allocator.
   */
  #ifndef CONFIG_PREEMPT_RT
  #define pcpu_task_pin()         preempt_disable()
  #define pcpu_task_unpin()       preempt_enable()
  #else
  #define pcpu_task_pin()         migrate_disable()
  #define pcpu_task_unpin()       migrate_enable()
  #endif

in mm/page_alloc.c . Thus, I think that calling migrate_disable() if CONFIG_PREEMPT_RT=y
and calling local_irq_save() if CONFIG_PREEMPT_RT=n (i.e. Alternative 3) will work.

But thinking again, since CONFIG_PREEMPT_RT=y uses special printk() approach where messages
are printed from a dedicated kernel thread, do we need to call printk_deferred_enter() if
CONFIG_PREEMPT_RT=y ? That is, isn't the fix as straightforward as below?

----------------------------------------
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..a2a3bfa69a12 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5805,6 +5805,7 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
+#ifndef CONFIG_PREEMPT_RT
 	unsigned long flags;
 
 	/*
@@ -5820,6 +5821,7 @@ static void __build_all_zonelists(void *data)
 	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
 	 */
 	printk_deferred_enter();
+#endif
 	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
@@ -5858,8 +5860,10 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
+#ifndef CONFIG_PREEMPT_RT
 	printk_deferred_exit();
 	local_irq_restore(flags);
+#endif
 }
 
 static noinline void __init
----------------------------------------

