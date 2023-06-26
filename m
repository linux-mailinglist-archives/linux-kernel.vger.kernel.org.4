Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61B73DD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFZL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:26:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB4B5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:26:04 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35QBQ2ex016478;
        Mon, 26 Jun 2023 20:26:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 26 Jun 2023 20:26:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35QBQ2KY016473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Jun 2023 20:26:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3a4ad958-a9a5-c367-a16d-bd89a173a628@I-love.SAKURA.ne.jp>
Date:   Mon, 26 Jun 2023 20:26:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
 <20230626104831.GT4253@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230626104831.GT4253@hirez.programming.kicks-ass.net>
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

On 2023/06/26 19:48, Peter Zijlstra wrote:
> On Mon, Jun 26, 2023 at 06:25:56PM +0900, Tetsuo Handa wrote:
>> On 2023/06/26 17:12, Sebastian Andrzej Siewior wrote:
>>> On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
>>>> Why not to do the same on the end side?
>>>>
>>>>  static inline void do_write_seqcount_end(seqcount_t *s)
>>>>  {
>>>> - 	seqcount_release(&s->dep_map, _RET_IP_);
>>>>  	do_raw_write_seqcount_end(s);
>>>> +	seqcount_release(&s->dep_map, _RET_IP_);
>>>>  }
>>>
>>> I don't have a compelling argument for doing it. It is probably better
>>> to release the lock from lockdep's point of view and then really release
>>> it (so it can't be acquired before it is released).
>>
>> We must do it because this is a source of possible printk() deadlock.
>> Otherwise, I will nack on PATCH 2/2.
> 
> Don't be like that... just hate on prink like the rest of us. In fact,
> i've been patching out the actual printk code for years because its
> unusable garbage.
> 
> Will this actually still be a problem once all the fancy printk stuff
> lands? That shouldn't do synchronous prints except to 'atomic' consoles
> by default IIRC.

Commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq
seqlock") was applied to 4.14-stable trees, and CONFIG_PREEMPT_RT is available
since 5.3. Thus, we want a fix which can be applied to 5.4-stable and later.
This means that we can't count on all the fancy printk stuff being available.

