Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F143470061D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjELK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbjELK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:57:36 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B163592
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:57:33 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34CAv7ww070055;
        Fri, 12 May 2023 19:57:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 12 May 2023 19:57:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34CAv6iv070050
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 May 2023 19:57:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
Date:   Fri, 12 May 2023 19:57:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/12 12:44, Andrew Morton wrote:
> On Thu, 11 May 2023 22:47:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
>> syzbot is reporting lockdep warning in fill_pool(), for GFP_ATOMIC is
>> (__GFP_HIGH | __GFP_KSWAPD_RECLAIM) which wakes up kswapd.
>> Since fill_pool() might be called with arbitrary locks held,
>> fill_pool() should not assume that holding pgdat->kswapd_wait is safe.
> 
> hm.  But many GFP_ATOMIC allocation attempts are made with locks held. 
> Why aren't all such callers buggy, by trying to wake kswapd with locks
> held?  What's special about this one?

Because debugobject cannot know what locks are held when fill_pool() does
GFP_ATOMIC allocation.

syzbot is reporting base->lock => pgdat->kswapd_wait dependency

  add_timer() {
    __mod_timer() {
      base = lock_timer_base(timer, &flags);
      new_base = get_target_base(base, timer->flags);
      if (base != new_base) {
        raw_spin_unlock(&base->lock);
        base = new_base;
        raw_spin_lock(&base->lock);
      }
      debug_timer_activate(timer) {
        debug_object_activate(timer, &timer_debug_descr) {
          debug_objects_fill_pool() {
            fill_pool() {
              kmem_cache_zalloc(GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN) {
                // wakes kswapd
              }
            }
          }
        }
      }
      raw_spin_unlock_irqrestore(&base->lock, flags);
    }
  }

when pgdat->kswapd_wait => p->pi_lock dependency

  __alloc_pages() {
    get_page_from_freelist() {
      rmqueue() {
        wakeup_kswapd() {
          wake_up_interruptible(&pgdat->kswapd_wait) {
            __wake_up_common_lock() {
              spin_lock_irqsave(&pgdat->kswapd_wait.lock, flags);
              __wake_up_common() {
                autoremove_wake_function() {
                  try_to_wake_up() {
                    raw_spin_lock_irqsave(&p->pi_lock, flags);
                    raw_spin_unlock_irqrestore(&p->pi_lock, flags);
                  }
                }
              }
              spin_unlock_irqrestore(&pgdat->kswapd_wait.lock, flags);
            }
          }
        }
      }
    }
  }

and p->pi_lock => rq->__lock => base->lock dependency

  wake_up_new_task() {
    raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
    rq = __task_rq_lock(p, &rf); // acquires rq->lock
    activate_task(rq, p, ENQUEUE_NOCLOCK) {
      enqueue_task() {
        psi_enqueue() {
          psi_task_change() {
            queue_delayed_work_on() {
              __queue_delayed_work() {
                add_timer() {
                  __mod_timer() {
                    base = lock_timer_base(timer, &flags); // acquires base->lock
                    debug_timer_activate(timer); // possible base->lock => pgdat->kswapd_wait => p->pi_lock dependency
                    raw_spin_unlock_irqrestore(&base->lock, flags);
                  }
                }
              }
            }
          }
        }
      }
    }
    task_rq_unlock(rq, p, &rf);
  }

exists.

All GFP_ATOMIC allocation users are supposed to be aware of what locks
are held, and are supposed to explicitly remove __GFP_KSWAPD_RECLAIM
if waking up kswapd can cause deadlock. But reality is that we can't be
careful enough to error-free. Who would imagine GFP_ATOMIC allocation
while base->lock is held can form circular locking dependency?

> 
>> Also, __GFP_NORETRY is pointless for !__GFP_DIRECT_RECLAIM allocation

__GFP_NORETRY is not checked by !__GFP_DIRECT_RECLAIM allocation.
GFP_ATOMIC - __GFP_KSWAPD_RECLAIM is __GFP_HIGH.

>>
>> @@ -126,7 +126,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
>>  
>>  static void fill_pool(void)
>>  {
>> -	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
>> +	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
> 
> Does this weaken fill_pool()'s allocation attempt more than necessary? 
> We can still pass __GFP_HIGH?

What do you mean? I think that killing base->lock => pgdat->kswapd_wait
by removing __GFP_KSWAPD_RECLAIM is the right fix. This weakening is
needed for avoiding base->lock => pgdat->kswapd_wait dependency from
debugobject code.

For locking dependency safety, I wish that GFP_ATOMIC / GFP_NOWAIT do not imply
__GFP_KSWAPD_RECLAIM. Such allocations should not try to allocate as many pages
as even __GFP_HIGH fails. And if such allocations try to allocate as many pages
as even __GFP_HIGH fails, they likely already failed before background kswapd
reclaim finds some reusable pages....

