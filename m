Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC49C67295E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjARUcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjARUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:31:33 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B230611C0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:31:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nxxz50dybz9v7Gk
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:23:13 +0800 (CST)
Received: from [10.48.135.81] (unknown [10.48.135.81])
        by APP2 (Coremail) with SMTP id GxC2BwA3CmHqVshjR2WoAA--.1190S2;
        Wed, 18 Jan 2023 21:30:45 +0100 (CET)
Message-ID: <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
Date:   Wed, 18 Jan 2023 21:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA3CmHqVshjR2WoAA--.1190S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1Utr4UuF4UZFykCFyUWrg_yoW3KFWUpF
        ZYgFy3Kw1DJr1fZw1I9w1rWryjy3yrJFWUXrn5GFW8W3sYqrn3KF4xKa4Y9F9xCr4fCr4j
        qF1vq3s7Z34UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 9:19 PM, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 08:42:36PM +0100, Jonas Oberhauser wrote:
>> On 1/18/2023 5:50 PM, Alan Stern wrote:
>>> On Tue, Jan 17, 2023 at 07:50:41PM -0800, Paul E. McKenney wrote:
>>>> On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
>>>>> On Tue, Jan 17, 2023 at 09
>>>>>> Given an Srcu-down and an Srcu-up:
>>>>>>
>>>>>> let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
>>>>>> 		  parameter(Srcu-unlock, 2) ) |
>>>>>> 		( return_value(Srcu-down) ; (dep | rf)* ;
>>>>>> 		  parameter(Srcu-up, 2) )
>>>>>>
>>>>>> Seem reasonable, or am I missing yet something else?
>>>>> Not at all reasonable.
>>>>>
>>>>> For one thing, consider this question: Which statements lie inside a
>>>>> read-side critical section?
>>>> Here srcu_down_read() and srcu_up_read() are to srcu_read_lock() and
>>>> srcu_read_unlock() as down_read() and up_read() are to mutex_lock()
>>>> and mutex_unlock().  Not that this should be all that much comfort
>>>> given that I have no idea how one would go about modeling down_read()
>>>> and up_read() in LKMM.
>>> It might make sense to work on that first, before trying to do
>>> srcu_down_read() and srcu_up_read().
>>>
>>>>> With srcu_read_lock() and a matching srcu_read_unlock(), the answer is
>>>>> clear: All statements po-between the two.  With srcu_down_read() and
>>>>> srcu_up_read(), the answer is cloudy in the extreme.
>>>> And I agree that it must be clearly specified, and my that previous try
>>>> was completely lacking.  Here is a second attempt:
>>>>
>>>> let srcu-rscs = (([Srcu-lock] ; data ; [Srcu-unlock]) & loc) |
>>>> 		(([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc)
>>>>
>>>> (And I see your proposal and will try it.)
>>>>
>>>>> Also, bear in mind that the Fundamental Law of RCU is formulated in
>>>>> terms of stores propagating to a critical section's CPU.  What are we to
>>>>> make of this when a single critical section can belong to more than one
>>>>> CPU?
>>>> One way of answering this question is by analogy with down() and up()
>>>> when used as a cross-task mutex.  Another is by mechanically applying
>>>> some of current LKMM.  Let's start with this second option.
>>>>
>>>> LKMM works mostly with critical sections, but we also discussed ordering
>>>> based on the set of events po-after an srcu_read_lock() on the one hand
>>>> and the set of events po-before an srcu_read_unlock() on the other.
>>>> Starting here, the critical section is the intersection of these two sets.
>>>>
>>>> In the case of srcu_down_read() and srcu_up_read(), as you say, whatever
>>>> might be a critical section must span processes.  So what if instead of
>>>> po, we used (say) xbstar?  Then given a set of A such that ([Srcu-down ;
>>>> xbstar ; A) and B such that (B ; xbstar ; [Srcu-up]), then the critical
>>>> section is the intersection of A and B.
>>>>
>>>> One objection to this approach is that a bunch of unrelated events could
>>>> end up being defined as part of the critical section.  Except that this
>>>> happens already anyway in real critical sections in the Linux kernel.
>>>>
>>>> So what about down() and up() when used as cross-task mutexes?
>>>> These often do have conceptual critical sections that protect some
>>>> combination of resource, but these critical sections might span tasks
>>>> and/or workqueue handlers.  And any reasonable definition of these
>>>> critical sections would be just as likely to pull in unrelated accesses as
>>>> the above intersection approach for srcu_down_read() and srcu_up_read().
>>>>
>>>> But I am just now making all this up, so thoughts?
>>> Maybe we don't really need to talk about read-side critical sections at
>>> all.  Once again, here's what explanation.txt currently says:
>>>
>>> 	For any critical section C and any grace period G, at least
>>> 	one of the following statements must hold:
>>>
>>> (1)	C ends before G does, and in addition, every store that
>>> 	propagates to C's CPU before the end of C must propagate to
>>> 	every CPU before G ends.
>>>
>>> (2)	G starts before C does, and in addition, every store that
>>> 	propagates to G's CPU before the start of G must propagate
>>> 	to every CPU before C starts.
>>>
>>> Suppose we change this to:
>>>
>>> 	For any RCU lock operation L and matching unlock operation U,
>>> 	and any matching grace period G, at least one of the following
>>> 	statements must hold:
>>>
>>> (1)	U executes before G ends, and in addition, every store that
>>> 	propagates to U's CPU before U executes must propagate to
>>> 	every CPU before G ends.
>>>
>>> (2)	G starts before L executes, and in addition, every store that
>>> 	propagates to G's CPU before the start of G must propagate
>>> 	to every CPU before L executes.
>>>
>>> (For SRCU, G matches L and U if it operates on the same srcu structure.)
>> I think for the formalization, the definition of "critical section" is
>> hidden inside the word "matching" here.
>> You will still need to define what matching means for up and down.
>> Can I understand down and up to create a large read-side critical section
>> that is shared between multiple threads, analogously to a semaphore? With
>> the restriction that for srcu, there are really multiple (two) such critical
>> sections that can be open in parallel, which are indexed by the return value
>> of down/the input of up?
>>
>> If so I suspect that every down matches with every up within a "critical
>> section"?
>> maybe you can define balancing along the co analous to the balancing along
>> po currently used for matching rcu_lock() and rcu_unlock(). I.e.,
>>
>> down ------------- up
>>     \down--------up/
>>         \down-up/
>>            \_/
>> where diagonal links are co links and the straight links are "balanced
>> match" links.
> The SRCU read-side critical sections are fundamentally different than
> those of RCU. [...]
> In contrast, SRCU read-side critical sections are defined by the
> return value of srcu_read_lock() being passed into the matching
> srcu_read_unlock().

I'm a bit confused. I previously thought that there is 
srcu_lock/srcu_unlock and srcu_down/srcu_up and that these are different 
things.

Your explanation matches how I understood srcu_read_lock after reading 
the paper and pretending that there wasn't a single counter, while my 
understanding of srcu_read_down would be closer to the original 
implementation in the 2009 paper where there was a single counter, and 
thus srcu_read_down and srcu_read_up could open a multi-thread critical 
section.

Is there only one thing and read_down *is* read_lock?
If they are not the same, is my understand of read_down correct?

And isn't it also true that the srcu_lock() needs to be on the same CPU 
as the matching srcu_unlock()?

I think for matching srcu_lock to srcu_unlock, you can just use the data 
dependency (following the "hack" of defining them as reads and writes).

What I was suggesting below is how to redefine "match" between read_down 
and read_up that work more like a cross-thread semaphore.


>> Then everything that is enclosed within a pair of "balanced match" is
>> linked:
>>
>> match-down-up = co^-1?; balanced-srcu-updown ; co^-1?
>>
>> Since multiple critical sections can be in-flight, maybe you can use co &
>> same-value (or whatever the relation is) to define this?
>>
>>
>> let balanced-srcu-updown = let rec
>>          unmatched-locks = Srcu-down \ domain(matched)
>>      and unmatched-unlocks = Srcu-up \ range(matched)
>>      and unmatched = unmatched-locks | unmatched-unlocks
>>      and unmatched-co = [unmatched] ; co & same-value ; [unmatched]
>>      and unmatched-locks-to-unlocks =
>>          [unmatched-locks] ;  co & same-value ; [unmatched-unlocks]
>>      and matched = matched | (unmatched-locks-to-unlocks \
>>          (unmatched-co ; unmatched-co))
>>      in matched
>> let match-down-up = (co & same-value)^-1?; balanced-srcu-updown ; (co &
>> same-value)^-1?



>> Is the implementation of srcu-lock and srcu-unlock still anything like the
>> implementation in the 2009 paper?
> The interaction between readers and grace period is now mediated by a
> per-CPU pair of lock counters and of unlock counters, so the 2009 paper is
> not the best guide.  But yes, you would likely need three or four pairwise
> overlapping critical sections for the current SRCU implementation to end
> "early".

That makes sense.

Have fun, jonas

