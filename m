Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20E73CE09
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFYC1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFYC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:27:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031AD3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 19:27:20 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35P2RIF6015937;
        Sun, 25 Jun 2023 11:27:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 25 Jun 2023 11:27:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35P2RHIb015934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Jun 2023 11:27:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3120e8b4-a3e9-3612-f232-b89afe56532f@I-love.SAKURA.ne.jp>
Date:   Sun, 25 Jun 2023 11:27:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] seqlock,mm: lockdep annotation +
 write_seqlock_irqsave()
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230623171232.892937-1-bigeasy@linutronix.de>
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

On 2023/06/24 2:12, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this has been a single patch (2/2) but then it was pointed out that the
> lockdep annotation in seqlock needs to be adjusted to fully close the
> printk window so that there is no printing after the seq-lock has been
> acquired and before printk_deferred_enter() takes effect.
> 
> I'm sending both patches in this series so both sides (locking and mm)
> are aware of the situation. 
> I hope that both patches can be applied independently via their subsystem
> tree (the lockdep splat + deadlock is low risk).
> 
> The original thread starts at
> 	https://lore.kernel.org/20230621104034.HT6QnNkQ@linutronix.de
> 
> Sebastian

The original thread is too long to read. Below is a full summary for locking
maintainers to accept [PATCH 1/2].



When commit 1ca7d67cf5d5 ("seqcount: Add lockdep functionality to
seqcount/seqlock structures") added seqcount_acquire(&s->dep_map) check to
write_seqcount_begin_nested() and seqcount_release(&s->dep_map) check to
write_seqcount_end(), the ordering of updating s->sequence and doing lockdep
annotation was not important.

But since commit 3d36424b3b58 ("mm/page_alloc: fix race condition between
build_all_zonelists and page allocation") started calling
read_seqbegin(&zonelist_update_seq)/read_seqretry(&zonelist_update_seq) from
kmalloc(GFP_ATOMIC) path, commit 1007843a9190 ("mm/page_alloc: fix potential
deadlock on zonelist_update_seq seqlock") tried to close the race window using

 __build_all_zonelists() {
+    local_irq_save(flags);
+    printk_deferred_enter();
     write_seqlock(&zonelist_update_seq);
     (...snipped...)
     write_sequnlock(&zonelist_update_seq);
+    printk_deferred_exit();
+    local_irq_restore(flags);
 }

pattern. The reason behind this ordering was to

  satisfy "printk_deferred_enter() depends on local IRQs being disabled"

and

  make sure that "no synchronous printk() (for whatever reasons, not only
  printk() from build_zonelists() from __build_all_zonelists(), but also
  including printk() from lockdep, soft-lockup, KCSAN etc.) happens between
  write_seqlock() and write_sequnlock()

. However, Sebastian Andrzej Siewior mentioned that this ordering is
problematic if CONFIG_PREEMPT_RT=y, for disabling local IRQs conflicts with
"spin_lock(&zonelist_update_seq.lock) from write_seqlock(&zonelist_update_seq)
needs to be able to sleep", and Sebastian is proposing

 __build_all_zonelists() {
-    local_irq_save(flags);
-    printk_deferred_enter();
-    write_seqlock(&zonelist_update_seq);
+    write_seqlock_irqsave(&zonelist_update_seq, flags);
+    printk_deferred_enter();
     (...snipped...)
+    printk_deferred_exit();
+    write_sequnlock_irqrestore(&zonelist_update_seq, flags);
-    write_sequnlock(&zonelist_update_seq);
-    printk_deferred_exit();
-    local_irq_restore(flags);
 }

change as [PATCH 2/2]. Since write_seqlock_irqsave() becomes write_seqlock()
if CONFIG_PREEMPT_RT=y, this change can solve the conflict.

In order to accept this proposal, we need to make sure that

  no synchronous printk() happens between

    write_seqlock_irqsave(&zonelist_update_seq, flags) made
    zonelist_update_seq.seqcount odd

  and

    printk_deferred_enter() takes effect

and

  no synchronous printk() happens between

    printk_deferred_exit() took effect

  and

    write_sequnlock_irqrestore(&zonelist_update_seq, flags) makes
    zonelist_update_seq.seqcount even

, and Sebastian is proposing

 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-    do_raw_write_seqcount_begin(s);
     seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+    do_raw_write_seqcount_begin(s);
 }

 static inline void do_write_seqcount_end(seqcount_t *s)
 {
-    seqcount_release(&s->dep_map, _RET_IP_);
     do_raw_write_seqcount_end(s);
+    seqcount_release(&s->dep_map, _RET_IP_);
 }

as [PATCH 1/2].

With [PATCH 1/2] and [PATCH 2/2], possibility of synchronous printk() changes like below.

__build_all_zonelists() {
  write_seqlock_irqsave(&zonelist_update_seq, flags) {
    __write_seqlock_irqsave(&zonelist_update_seq) {
      spin_lock_irqsave(&zonelist_update_seq.lock, flags); // local IRQs disabled = synchronous printk() from IRQs is disabled here
      do_write_seqcount_begin(&zonelist_update_seq.seqcount.seqcount) {
        do_write_seqcount_begin_nested(&zonelist_update_seq.seqcount.seqcount, 0) {
          seqcount_acquire(&zonelist_update_seq.seqcount.seqcount.dep_map, 0, 0, _RET_IP_); // synchronous printk() from lockdep might happen here
          do_raw_write_seqcount_begin(&zonelist_update_seq.seqcount.seqcount) {
            seqcount_acquire(&zonelist_update_seq.seqcount.seqcount.dep_map, 0, 0, _RET_IP_); // zonelist_update_seq.seqcount.seqcount.sequence is guaranteed to be even = kmalloc(GFP_ATOMIC) with port lock held is safe = synchronous printk() is safe
            kcsan_nestable_atomic_begin(); // KCSAN is diabled = synchronous printk() from KCSAN is disabled here
            zonelist_update_seq.seqcount.seqcount.sequence++; // zonelist_update_seq.seqcount.seqcount.sequence is now odd = kmalloc(GFP_ATOMIC) with port lock held is not safe = synchronous printk() is not safe
          }
        }
      }
    }
  }
  printk_deferred_enter(); // synchronous printk() from whatever reason is disabled here
  (...snipped...)
  printk_deferred_exit(); // synchronous printk() from whatever reason is enabled here
  write_sequnlock_irqrestore(&zonelist_update_seq, flags) {
    do_write_seqcount_end(&zonelist_update_seq.seqcount.seqcount) {
      do_raw_write_seqcount_end(&zonelist_update_seq.seqcount.seqcount) {
        zonelist_update_seq.seqcount.seqcount.sequence++; // zonelist_update_seq.seqcount.seqcount.sequence is now even = kmalloc(GFP_ATOMIC) with port lock held is safe = synchronous printk() is safe
        kcsan_nestable_atomic_end(); // KCSAN is enabled = synchronous printk() from KCSAN is enabled here
      }
      seqcount_release(&zonelist_update_seq.seqcount.seqcount.dep_map, _RET_IP_); // synchronous printk() from lockdep might happen here
    }
    spin_unlock_irqrestore(&zonelist_update_seq.lock, flags); // local IRQs enabled = synchronous printk() from IRQs is enabled here
  }
}

