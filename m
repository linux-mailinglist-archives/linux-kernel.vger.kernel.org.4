Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962B5652BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiLUDvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLUDvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:51:51 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FF1CFDE;
        Tue, 20 Dec 2022 19:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671594709;
        bh=AJdVhqN3gg7ANzTOKJ6n8INFL0UmXnPWOux3e6+8cwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hzKv3bgTs3+oE+9YYqC3poj9l6mcQ0vMmcY7AmglRGR48ztgtRWIApMV2se3pJd+7
         cg7VrWSs0OA+wm760g5oWERjRJ0HohBpTb2VL8Z1DsU6U0QozAqSEK/jQaOn3mz85i
         3HbRPB4Ns2J9LHv7Qqqu3vz8CxePOjI40AQj/DBB5Bs3QNL5QLOVo8khNjGQIOL4/Z
         f6Ii2Lpus53UVffEWqLfqFPGWt9/N4pXc8turspKCiR/ftKp5A0W+t0Y9+jLWVh1QN
         ZTnVKioyEg3hrie9EpNAolJsks3iyuV8HwM+gcZ+C0WTaokrn1O4gnoFerpV4r3u4u
         99cpEsWcj8LNw==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NcKJ52zp1zc07;
        Tue, 20 Dec 2022 22:51:49 -0500 (EST)
Message-ID: <d010a8ca-79a4-bd25-dff1-cb7dee627365@efficios.com>
Date:   Tue, 20 Dec 2022 22:52:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <B9B73CDE-4C2C-4BC6-A23C-A59C22AD2EB1@joelfernandes.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <B9B73CDE-4C2C-4BC6-A23C-A59C22AD2EB1@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 15:55, Joel Fernandes wrote:
> 
> 
>> On Dec 20, 2022, at 1:29 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> ﻿
>>
>>>> On Dec 20, 2022, at 1:13 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> ﻿On 2022-12-20 13:05, Joel Fernandes wrote:
>>>> Hi Mathieu,
>>>>> On Tue, Dec 20, 2022 at 5:00 PM Mathieu Desnoyers
>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> On 2022-12-19 20:04, Joel Fernandes wrote:
>>>>>>> On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>> [...]
>>>>>>>> On a 64-bit system, where 64-bit counters are used, AFAIU this need to
>>>>>>>> be exactly 2^64 read-side critical sections.
>>>>>>>
>>>>>>> Yes, but what about 32-bit systems?
>>>>>
>>>>> The overflow indeed happens after 2^32 increments, just like seqlock.
>>>>> The question we need to ask is therefore: if 2^32 is good enough for
>>>>> seqlock, why isn't it good enough for SRCU ?
>>>> I think Paul said wrap around does happen with SRCU on 32-bit but I'll
>>>> let him talk more about it. If 32-bit is good enough, let us also drop
>>>> the size of the counters for 64-bit then?
>>>>>>>> There are other synchronization algorithms such as seqlocks which are
>>>>>>>> quite happy with much less protection against overflow (using a 32-bit
>>>>>>>> counter even on 64-bit architectures).
>>>>>>>
>>>>>>> The seqlock is an interesting point.
>>>>>>>
>>>>>>>> For practical purposes, I suspect this issue is really just theoretical.
>>>>>>>
>>>>>>> I have to ask, what is the benefit of avoiding a flip and scanning
>>>>>>> active readers? Is the issue about grace period delay or performance?
>>>>>>> If so, it might be worth prototyping that approach and measuring using
>>>>>>> rcutorture/rcuscale. If there is significant benefit to current
>>>>>>> approach, then IMO it is worth exploring.
>>>>>
>>>>> The main benefit I expect is improved performance of the grace period
>>>>> implementation in common cases where there are few or no readers
>>>>> present, especially on machines with many cpus.
>>>>>
>>>>> It allows scanning both periods (0/1) for each cpu within the same pass,
>>>>> therefore loading both period's unlock counters sitting in the same
>>>>> cache line at once (improved locality), and then loading both period's
>>>>> lock counters, also sitting in the same cache line.
>>>>>
>>>>> It also allows skipping the period flip entirely if there are no readers
>>>>> present, which is an -arguably- tiny performance improvement as well.
>>>> The issue of counter wrap aside, what if a new reader always shows up
>>>> in the active index being scanned, then can you not delay the GP
>>>> indefinitely? It seems like writer-starvation is possible then (sure
>>>> it is possible also with preemption after reader-index-sampling, but
>>>> scanning active index deliberately will make that worse). Seqlock does
>>>> not have such writer starvation just because the writer does not care
>>>> about what the readers are doing.
>>>
>>> No, it's not possible for "current index" readers to starve the g.p. with the side-rcu scheme, because the initial pass (sampling both periods) only opportunistically skips flipping the period if there happens to be no readers in both periods.
>>>
>>> If there are readers in the "non-current" period, the grace period waits for them.
>>>
>>> If there are readers in the "current" period, it flips the period and then waits for them.
>>
>> Ok glad you already do that, this is what I was sort of leaning at in my previous email as well, that is doing a hybrid approach. Sorry I did not know the details of your side-RCU to know you were already doing something like that.
>>
>>>
>>>> That said, the approach of scanning both counters does seem attractive
>>>> for when there are no readers, for the reasons you mentioned. Maybe a
>>>> heuristic to count the number of readers might help? If we are not
>>>> reader-heavy, then scan both. Otherwise, just scan the inactive ones,
>>>> and also couple that heuristic with the number of CPUs. I am
>>>> interested in working on such a design with you! Let us do it and
>>>> prototype/measure. ;-)
>>>
>>> Considering that it would add extra complexity, I'm unsure what that extra heuristic would improve over just scanning both periods in the first pass.
>>
>> Makes sense, I think you indirectly implement a form of heuristic already by flipping in case scanning both was not fruitful.
>>
>>> I'll be happy to work with you on such a design :) I think we can borrow quite a few concepts from side-rcu for this. Please be aware that my time is limited though, as I'm currently supposed to be on vacation. :)
>>
>> Oh, I was more referring to after the holidays. I am also starting vacation soon and limited In cycles ;-). It is probably better to enjoy the holidays and come back to this after.
>>
>> I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…
> 
> In my view,  the mb between the totaling of unlocks and totaling of locks serves as the mb that is required to enforce the GP guarantee, which I think is what Mathieu is referring to.
> 

No, AFAIU you also need barriers at the beginning and end of synchronize_srcu to provide those guarantees:

  * There are memory-ordering constraints implied by synchronize_srcu().

Need for a barrier at the end of synchronize_srcu():

  * On systems with more than one CPU, when synchronize_srcu() returns,
  * each CPU is guaranteed to have executed a full memory barrier since
  * the end of its last corresponding SRCU read-side critical section
  * whose beginning preceded the call to synchronize_srcu().

Need for a barrier at the beginning of synchronize_srcu():

  * In addition,
  * each CPU having an SRCU read-side critical section that extends beyond
  * the return from synchronize_srcu() is guaranteed to have executed a
  * full memory barrier after the beginning of synchronize_srcu() and before
  * the beginning of that SRCU read-side critical section.  Note that these
  * guarantees include CPUs that are offline, idle, or executing in user mode,
  * as well as CPUs that are executing in the kernel.

Thanks,

Mathieu

> Neeraj, do you agree?
> 
> Thanks.
> 
> 
> 
> 
> 
>>
>> Cheers,
>>
>> - Joel
>>
>>
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>> -- 
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> https://www.efficios.com
>>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

