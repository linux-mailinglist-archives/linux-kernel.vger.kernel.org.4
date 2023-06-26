Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942CE73DF25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFZM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFZM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:27:58 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715FC26AF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:27:08 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35QCR6rY029034;
        Mon, 26 Jun 2023 21:27:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Mon, 26 Jun 2023 21:27:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35QCR6Mp029030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Jun 2023 21:27:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c6ad3e8f-cccf-fede-de1b-7a9c56594f36@I-love.SAKURA.ne.jp>
Date:   Mon, 26 Jun 2023 21:27:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
 <20230626104831.GT4253@hirez.programming.kicks-ass.net>
 <3a4ad958-a9a5-c367-a16d-bd89a173a628@I-love.SAKURA.ne.jp>
 <ZJl4C7aVk3gLLyMs@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZJl4C7aVk3gLLyMs@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/06/26 20:35, Michal Hocko wrote:
> On Mon 26-06-23 20:26:02, Tetsuo Handa wrote:
>> On 2023/06/26 19:48, Peter Zijlstra wrote:
>>> On Mon, Jun 26, 2023 at 06:25:56PM +0900, Tetsuo Handa wrote:
>>>> On 2023/06/26 17:12, Sebastian Andrzej Siewior wrote:
>>>>> On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
>>>>>> Why not to do the same on the end side?
>>>>>>
>>>>>>  static inline void do_write_seqcount_end(seqcount_t *s)
>>>>>>  {
>>>>>> - 	seqcount_release(&s->dep_map, _RET_IP_);
>>>>>>  	do_raw_write_seqcount_end(s);
>>>>>> +	seqcount_release(&s->dep_map, _RET_IP_);
>>>>>>  }
>>>>>
>>>>> I don't have a compelling argument for doing it. It is probably better
>>>>> to release the lock from lockdep's point of view and then really release
>>>>> it (so it can't be acquired before it is released).
>>>>
>>>> We must do it because this is a source of possible printk() deadlock.
>>>> Otherwise, I will nack on PATCH 2/2.
>>>
>>> Don't be like that... just hate on prink like the rest of us. In fact,
>>> i've been patching out the actual printk code for years because its
>>> unusable garbage.
>>>
>>> Will this actually still be a problem once all the fancy printk stuff
>>> lands? That shouldn't do synchronous prints except to 'atomic' consoles
>>> by default IIRC.
>>
>> Commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq
>> seqlock") was applied to 4.14-stable trees, and CONFIG_PREEMPT_RT is available
>> since 5.3. Thus, we want a fix which can be applied to 5.4-stable and later.
>> This means that we can't count on all the fancy printk stuff being available.
> 
> Is there any reason to backport RT specific fixup to stable trees? I
> mean seriously, is there any actual memory hotplug user using
> PREEMPT_RT? I would be more than curious to hear the usecase.

Even if we don't backport RT specific fixup to stable trees, [PATCH 2/2] requires
that [PATCH 1/2] guarantees that synchronous printk() never happens (for whatever
reasons) between write_seqlock_irqsave(&zonelist_update_seq, flags) and
write_sequnlock_irqrestore(&zonelist_update_seq, flags).

If [PATCH 1/2] cannot guarantee it, [PATCH 2/2] will be automatically rejected.

If [PATCH 2/2] cannot be applied, we have several alternatives.

Alternative 1:

  Revert both commit 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
  and commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock").
  I don't think this will happen, for nobody will be happy.

Alternative 2:

  Revert commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
  and apply "mm/page_alloc: don't check zonelist_update_seq from atomic allocations" at
  https://lkml.kernel.org/r/dfdb9da6-ca8f-7a81-bfdd-d74b4c401f11@I-love.SAKURA.ne.jp .
  I think this is reasonable, for this reduces locking dependency. But Michal Hocko did not like it.

Alternative 3:

  Somehow preserve printk_deferred_enter() => write_seqlock(&zonelist_update_seq) and
  write_sequnlock(&zonelist_update_seq) => printk_deferred_exit() pattern. Something like below?

----------------------------------------
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..ded3ac3856e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5805,6 +5805,7 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
+#ifndef CONFIG_PREEMPT_RT
 	unsigned long flags;
 
 	/*
@@ -5813,6 +5814,9 @@ static void __build_all_zonelists(void *data)
 	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
 	 */
 	local_irq_save(flags);
+#else
+	migrate_disable();
+#endif
 	/*
 	 * Explicitly disable this CPU's synchronous printk() before taking
 	 * seqlock to prevent any printk() from trying to hold port->lock, for
@@ -5859,7 +5863,11 @@ static void __build_all_zonelists(void *data)
 
 	write_sequnlock(&zonelist_update_seq);
 	printk_deferred_exit();
+#ifndef CONFIG_PREEMPT_RT
 	local_irq_restore(flags);
+#else
+	migrate_enable();
+#endif
 }
 
 static noinline void __init
----------------------------------------

