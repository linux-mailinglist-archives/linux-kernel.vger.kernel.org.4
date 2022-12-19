Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC43650622
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 02:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLSBts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 20:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSBtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 20:49:45 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E2B7D2;
        Sun, 18 Dec 2022 17:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671414581;
        bh=GkQ/F06qnipVISLnha8w8PWBHQp+eZ021fsAg2v1i7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ib5Ma9EHrgkB2r6wBsv01jkmTzxnubdgauyZmzesBZFic0QdDEfZP5lm4KHn4gEmN
         hNZkWng7NsvChAeKsmPCwYrdeiRHSc0z3cTb6WyxftP9sJMA0+ynXmT+W9hsW9w0AF
         Mm84mXMgJk8kLTsHU4bU3xF51hC3VOHpxL34qYfpxNTjBEysQauHicO165py86KICS
         sYdMDn5ZWEJ7B1V0DBWvLmKayzEW5xS9mgVb4kqhvhkrK7QnDzuKY6PLvMab5iN2tH
         w6rUFc+BgPeYmUdEDS7kZG4PZiPn/VcLL4tdm3kpF6BUPe7obj/EuLmuceaW1yavtM
         EKRirXPEzAm+w==
Received: from [10.1.0.203] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nb2h55Sw5zbT1;
        Sun, 18 Dec 2022 20:49:41 -0500 (EST)
Message-ID: <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
Date:   Sun, 18 Dec 2022 20:50:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
 <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
 <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-18 19:24, Joel Fernandes wrote:
> On Sun, Dec 18, 2022 at 7:04 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> Hi Mathieu,
>>
>> On Sun, Dec 18, 2022 at 6:38 PM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> On 2022-12-18 16:30, Joel Fernandes wrote:
>>>> Hi Mathieu,
>>>>
>>>> On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
>>>>>> Hello, I believe the pre-flip memory barrier is not required. The only reason I
>>>>>> can say to remove it, other than the possibility that it is unnecessary, is to
>>>>>> not have extra code that does not help. However, since we are issuing a fully
>>>>>> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
>>>>>>
>>>>>> For this reason, please consider these patches as "informational", than a
>>>>>> "please merge". :-) Though, feel free to consider merging if you agree!
>>>>>>
>>>>>> All SRCU scenarios pass with these, with 6 hours of testing.
>>>>>
>>>>> Hi Joel,
>>>>>
>>>>> Please have a look at the comments in my side-rcu implementation [1, 2].
>>>>> It is similar to what SRCU does (per-cpu counter based grace period
>>>>> tracking), but implemented for userspace. The comments explain why this
>>>>> works without the memory barrier you identify as useless in SRCU.
>>>>>
>>>>> Following my implementation of side-rcu, I reviewed the SRCU comments
>>>>> and identified that the barrier "/* E */" appears to be useless. I even
>>>>> discussed this privately with Paul E. McKenney.
>>>>>
>>>>> My implementation and comments go further though, and skip the period
>>>>> "flip" entirely if the first pass observes that all readers (in both
>>>>> periods) are quiescent.
>>>>
>>>> Actually in SRCU, the first pass scans only 1 index, then does the
>>>> flip, and the second pass scans the second index. Without doing a
>>>> flip, an index cannot be scanned for forward progress reasons because
>>>> it is still "active". So I am curious how you can skip flip and still
>>>> scan both indexes? I will dig more into your implementation to learn more.
>>>
>>> If we look at SRCU read-side:
>>>
>>> int __srcu_read_lock(struct srcu_struct *ssp)
>>> {
>>>           int idx;
>>>
>>>           idx = READ_ONCE(ssp->srcu_idx) & 0x1;
>>>           this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
>>>           smp_mb(); /* B */  /* Avoid leaking the critical section. */
>>>           return idx;
>>> }
>>>
>>> If the thread is preempted for a long period of time between load of
>>> ssp->srcu_idx and increment of srcu_lock_count[idx], this means this
>>> thread can appear as a "new reader" for the idx period at any arbitrary
>>> time in the future, independently of which period is the current one
>>> within a future grace period.
>>>
>>> As a result, the grace period algorithm needs to inherently support the
>>> fact that a "new reader" can appear in any of the two periods,
>>> independently of the current period state.
>>>
>>> As a result, this means that while within period "0", we _need_ to allow
>>> newly coming readers to appear as we scan period "0".
>>
>> Sure, it already does handle it but that is I believe it is a corner
>> case, not the norm.
>>
>>> As a result, we can simply scan both periods 0/1 for reader quiescence,
>>> even while new readers appear within those periods.
>>
>> I think this is a bit dangerous. Yes there is the preemption thing you
>> mentioned above, but that is bounded since you can only have a fixed
>> number of tasks that underwent that preemption, and it is quite rare
>> in the sense, each reader should get preempted just after sampling idx
>> but not incrementing lock count.
>>
>> However, if we scan while new readers appear (outside of the above
>> preemption problem), we can have counter wrap causing a false match
>> much quicker.
>> The scan loop is:
>> check_readers(idx) {
>>     count_all_unlocks(idx);
>>     smp_mb();
>>     count_all_locks(idx);
>>     bool done = (locks == unlocks)
>>     if (done) {
>>           // readers are done, end scan for this idx.
>>     } else {
>>           // try again later
>>     }
>> }
>>
>> So if check_readers() got preempted just after the smp_mb(), then you
>> can have lots of tasks enter and exit the read-side critical section
>> and increment the locks count. Eventually locks == unlocks will
>> happen, and it is screwed. Sure this is also theoretical, but yeah
>> that issue can be made "worse" by scanning active readers
>> deliberately, especially when such readers can also nest arbitrarily.
>>
>>> As a result, flipping between periods 0/1 is just relevant for forward
>>> progress, not for correctness.
>>
>> Sure, agreed, forward progress.
> 
> Adding to the last statement "But also correctness as described above".

Exactly how many entry/exit of the read-side critical section while the 
grace period is preempted do you need to trigger this ?

On a 64-bit system, where 64-bit counters are used, AFAIU this need to 
be exactly 2^64 read-side critical sections.

There are other synchronization algorithms such as seqlocks which are 
quite happy with much less protection against overflow (using a 32-bit 
counter even on 64-bit architectures).

For practical purposes, I suspect this issue is really just theoretical.

Or am I missing your point ?

Thanks,

Mathieu


> 
> thanks,
> 
>   - Joel

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

