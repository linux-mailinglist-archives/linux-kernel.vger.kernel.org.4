Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2A6505B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 00:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiLRXil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 18:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRXij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:38:39 -0500
X-Greylist: delayed 9054 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Dec 2022 15:38:34 PST
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C466354;
        Sun, 18 Dec 2022 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671406713;
        bh=3FDS/6KoYp5E84TDvpPY+jtYpp7eQlSuIRrF8vQtNUY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fLgsL7+Ja4lCR455/KR60nLBhLrFGk3ZLotcNZWDYECRFpqQ+wMa31dWlbDKqKLm0
         W3UaB348v2jR7+ghGslj99nTxbmHWqNCYogVAlN0sTgsq209P7ZeyzmNxFvo9kA8cE
         dPxqfKxx0h48yyvjkxX3O+r2wWV6YbmwrDDZZMsq7ZcF0YDNX8tqB/xyQYMJPQ26YY
         D5fStfbxpBqbTXMgE8KuCAPMjLB5znHPn3NkcLc5oJTtU9BejQJNUmASuMuIOMZ5Mt
         JOodIz4dwJlEq4nPSBmVeePyGK7oO6k0pFIm7l+nvX+DiqmMZHUB59r909DOmEMXDq
         Xn6sSkm3FuJxA==
Received: from [10.1.0.203] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NZzmn3LZxzbT0;
        Sun, 18 Dec 2022 18:38:33 -0500 (EST)
Message-ID: <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
Date:   Sun, 18 Dec 2022 18:38:56 -0500
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-18 16:30, Joel Fernandes wrote:
> Hi Mathieu,
> 
> On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
>>> Hello, I believe the pre-flip memory barrier is not required. The only reason I
>>> can say to remove it, other than the possibility that it is unnecessary, is to
>>> not have extra code that does not help. However, since we are issuing a fully
>>> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
>>>
>>> For this reason, please consider these patches as "informational", than a
>>> "please merge". :-) Though, feel free to consider merging if you agree!
>>>
>>> All SRCU scenarios pass with these, with 6 hours of testing.
>>
>> Hi Joel,
>>
>> Please have a look at the comments in my side-rcu implementation [1, 2].
>> It is similar to what SRCU does (per-cpu counter based grace period
>> tracking), but implemented for userspace. The comments explain why this
>> works without the memory barrier you identify as useless in SRCU.
>>
>> Following my implementation of side-rcu, I reviewed the SRCU comments
>> and identified that the barrier "/* E */" appears to be useless. I even
>> discussed this privately with Paul E. McKenney.
>>
>> My implementation and comments go further though, and skip the period
>> "flip" entirely if the first pass observes that all readers (in both
>> periods) are quiescent.
> 
> Actually in SRCU, the first pass scans only 1 index, then does the
> flip, and the second pass scans the second index. Without doing a
> flip, an index cannot be scanned for forward progress reasons because
> it is still "active". So I am curious how you can skip flip and still
> scan both indexes? I will dig more into your implementation to learn more.

If we look at SRCU read-side:

int __srcu_read_lock(struct srcu_struct *ssp)
{
         int idx;

         idx = READ_ONCE(ssp->srcu_idx) & 0x1;
         this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
         smp_mb(); /* B */  /* Avoid leaking the critical section. */
         return idx;
}

If the thread is preempted for a long period of time between load of 
ssp->srcu_idx and increment of srcu_lock_count[idx], this means this
thread can appear as a "new reader" for the idx period at any arbitrary 
time in the future, independently of which period is the current one 
within a future grace period.

As a result, the grace period algorithm needs to inherently support the 
fact that a "new reader" can appear in any of the two periods, 
independently of the current period state.

As a result, this means that while within period "0", we _need_ to allow 
newly coming readers to appear as we scan period "0".

As a result, we can simply scan both periods 0/1 for reader quiescence, 
even while new readers appear within those periods.

As a result, flipping between periods 0/1 is just relevant for forward 
progress, not for correctness.

As a result, we can remove barrier /* E */.

Thoughts ?

Thanks,

Mathieu


> 
>> The most relevant comment in side-rcu is:
>>
>>    * The grace period completes when it observes that there are no active
>>    * readers within each of the periods.
>>    *
>>    * The active_readers state is initially true for each period, until the
>>    * grace period observes that no readers are present for each given
>>    * period, at which point the active_readers state becomes false.
>>
>> So I agree with the clarifications you propose here, but I think we can
>> improve the grace period implementation further by clarifying the SRCU
>> grace period model.
> 
> Thanks a lot, I am curious how you do the "detection of no new
> readers" part without globally doing some kind of synchronization. I
> will dig more into your implementation to learn more.
> 
> Thanks,
> 
>   - Joel
> 
> 
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>> [1] https://github.com/efficios/libside/blob/master/src/rcu.h
>> [2] https://github.com/efficios/libside/blob/master/src/rcu.c
>>
>>>
>>> thanks,
>>>
>>>    - Joel
>>>
>>> Joel Fernandes (Google) (2):
>>> srcu: Remove comment about prior read lock counts
>>> srcu: Remove memory barrier "E" as it is not required
>>>
>>> kernel/rcu/srcutree.c | 10 ----------
>>> 1 file changed, 10 deletions(-)
>>>
>>> --
>>> 2.39.0.314.g84b9a713c41-goog
>>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

