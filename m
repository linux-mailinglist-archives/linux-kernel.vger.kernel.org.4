Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5525EAAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiIZPYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiIZPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:22:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71B85ABC;
        Mon, 26 Sep 2022 07:08:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mbl1n24drzl8dq;
        Mon, 26 Sep 2022 22:07:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXN0sjFjULa4BQ--.33013S3;
        Mon, 26 Sep 2022 22:08:54 +0800 (CST)
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
To:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
 <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
 <20220921164012.s7lvklp2qk6occcg@quack3>
 <20220923144303.fywkmgnkg6eken4x@quack3>
 <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
 <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
 <20220926114416.t7t65u66ze76aiz7@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fbb83171-4069-09d3-a119-68055c86797a@huaweicloud.com>
Date:   Mon, 26 Sep 2022 22:08:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220926114416.t7t65u66ze76aiz7@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXN0sjFjULa4BQ--.33013S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw17CFWUuF1DZFW7WF45ZFb_yoW5ZF4kpr
        WUK3ZYka1ktryIyw4ktw1Utw1Yk3yFkr9xCrs5Aay7Arn8KFyfXr1xKFZ8ZF18ZFZ3G3yU
        tr4SqrZIg3y5t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/09/26 19:44, Jan Kara 写道:
> On Fri 23-09-22 16:15:29, Hugh Dickins wrote:
>> On Fri, 23 Sep 2022, Hugh Dickins wrote:
>>> On Fri, 23 Sep 2022, Keith Busch wrote:
>>>
>>>> Does the following fix the observation? Rational being that there's no reason
>>>> to spin on the current wait state that is already under handling; let
>>>> subsequent clearings proceed to the next inevitable wait state immediately.
>>>
>>> It's running fine without lockup so far; but doesn't this change merely
>>> narrow the window?  If this is interrupted in between atomic_try_cmpxchg()
>>> setting wait_cnt to 0 and sbq_index_atomic_inc() advancing wake_index,
>>> don't we run the same risk as before, of sbitmap_queue_wake_up() from
>>> the interrupt handler getting stuck on that wait_cnt 0?
>>
>> Yes, it ran successfully for 50 minutes, then an interrupt came in
>> immediately after the cmpxchg, and it locked up just as before.
>>
>> Easily dealt with by disabling interrupts, no doubt, but I assume it's a
>> badge of honour not to disable interrupts here (except perhaps in waking).
> 
> I don't think any magic with sbq_index_atomic_inc() is going to reliably
> fix this. After all the current waitqueue may be the only one that has active
> waiters so sbq_wake_ptr() will always end up returning this waitqueue
> regardless of the current value of sbq->wake_index.
> 
> Honestly, this whole code needs a serious redesign. I have some
> simplifications in mind but it will take some thinking and benchmarking so
> we need some fix for the interim. I was pondering for quite some time about
> some band aid to the problem you've found but didn't find anything
> satisfactory.
> 
> In the end I see two options:
> 
> 1) Take your patch (as wrong as it is ;). Yes, it can lead to lost wakeups
> but we were living with those for a relatively long time so probably we can
> live with them for some longer.
> 
> 2) Revert Yu Kuai's original fix 040b83fcecfb8 ("sbitmap: fix possible io
> hung due to lost wakeup") and my fixup 48c033314f37 ("sbitmap: Avoid leaving
> waitqueue in invalid state in __sbq_wake_up()"). But then Keith would have
> to redo his batched accounting patches on top.
> 
>> Some clever way to make the wait_cnt and wake_index adjustments atomic?

I'm thinking about a hacky way to make the update of wake_cnt and
wake_index atomic, however, redesign of sbitmap_queue is probably
better. 🤣

There are only 8 wait queues and wake_batch is 8 at most, thus
only need 3 * 9 = 27 bit, and a single atomic value is enough:

- 0-2 represents ws[0].wake_cnt
- 3-5 represents ws[1].wake_cnt
- ...
- 21-24 represents ws[7].wake_cnt
- 25-27 represents sbq->wake_index

for example, assume the atomic value is:

0B 111 111 111 111 111 111 111 111 111 000,

which means wake_index is 7 and ws[0].wake_cnt is 0,
if we try to inc wake_index and reset wake_cnt together:

atomic_add(..., 0B 001 000 000 000 000 000 000 000 000 111)

Thanks,
Kuai

>>
>> Or is this sbitmap_queue_wake_up() interrupting sbitmap_queue_wake_up()
>> just supposed never to happen, the counts preventing it: but some
>> misaccounting letting it happen by mistake?
> 
> No, I think that is in principle a situation that we have to accommodate.
> 
> 								Honza
> 

