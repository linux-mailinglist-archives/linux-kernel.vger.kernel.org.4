Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961AC70125C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjELXPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjELXPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:15:18 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE936EA1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:15:16 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34CNEgSO017364;
        Sat, 13 May 2023 08:14:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 13 May 2023 08:14:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34CNDROl017213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 May 2023 08:13:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <61d7ac52-3352-b7cd-8908-890a29a007d9@I-love.SAKURA.ne.jp>
Date:   Sat, 13 May 2023 08:13:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
 <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
 <87v8gxbthf.ffs@tglx>
 <39c79d27-73ea-06a8-62fe-2b64d0fd8db5@I-love.SAKURA.ne.jp>
 <87bkipbeyr.ffs@tglx>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87bkipbeyr.ffs@tglx>
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

On 2023/05/13 3:07, Thomas Gleixner wrote:
> On Fri, May 12 2023 at 22:09, Tetsuo Handa wrote:
>> On 2023/05/12 21:54, Thomas Gleixner wrote:
>>> On Fri, May 12 2023 at 19:57, Tetsuo Handa wrote:
>>>> On 2023/05/12 12:44, Andrew Morton wrote:
>>>>> On Thu, 11 May 2023 22:47:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>>>>
>>>>>> syzbot is reporting lockdep warning in fill_pool(), for GFP_ATOMIC is
>>>>>> (__GFP_HIGH | __GFP_KSWAPD_RECLAIM) which wakes up kswapd.
>>>>>> Since fill_pool() might be called with arbitrary locks held,
>>>>>> fill_pool() should not assume that holding pgdat->kswapd_wait is safe.
>>>
>>> https://lore.kernel.org/lkml/871qjldbes.ffs@tglx/
>>
>> .config says IS_ENABLED(CONFIG_PREEMPT_RT) == false, and lockdep says about
>> base->lock => pgdat->kswapd_wait => p->pi_lock => rq->__lock => base->lock
>> dependency but does not say about db->lock.
>>
>> How can your patch fix this problem?
> 
> It's described in the changelog, no?

I can't find a proof that lookup_object() never returns NULL
when debug_object_activate() is called.

> 
> The main change is to make the refill invocation conditional when the
> lookup fails. That's how that code has been from day one.

Making refill conditional helps reducing frequency of doing allocations.
I want a proof that allocations never happens in the worst scenario.

Are you saying that some debugobject function other than debug_object_activate()
guarantees that memory for that object was already allocated before
debug_object_activate() is called for the first time for that object,
_and_ such debugobject function is called without locks held?

> 
> The patch which closed the race recently wreckaged those refill
> oportunities and the fix for that introduced this problem.
> 
> Thanks,
> 
>         tglx

