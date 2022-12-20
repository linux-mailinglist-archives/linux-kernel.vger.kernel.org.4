Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F1652516
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLTRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiLTRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:00:36 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D672186F2;
        Tue, 20 Dec 2022 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671555633;
        bh=KHnjxMK7PefH8VFRsh3Ja4HLDbLno+j0FUqpkmX8Wsc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tMB18aBWdAfBmoRE8kNyVshK864YvE7rtarXEt2b77/7opfByNHsOP3FTVqtrmCo8
         h91X+ec62xRNYYfMdJhiIDDkJha9Mxdr7kMQoy7z4U4JLpR7U0kzAaNzdOY2k4B99q
         2hym8bO65ZW6ic2e6rbuWKhZ4mK0Zrp+aRq0q73A9E1y6EynwV+oQlNKzgXlRGXukW
         SCJgcjFoa+gqfYtLWGLgEMA6+owwvz+8/GNQ0fIDj+16G1YYcO5wCirJRrzuMLZXxr
         J+0R4bbyzij/3lw8Fox1JxsF4ivuWnjlhQYrHx26v4dukC0a6oK15JDDkSE4+t+35d
         Xef4jMRGqYE2A==
Received: from [10.1.0.203] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nc2rd3jcDzc7W;
        Tue, 20 Dec 2022 12:00:33 -0500 (EST)
Message-ID: <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
Date:   Tue, 20 Dec 2022 12:00:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
 <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
 <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
 <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com>
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

On 2022-12-19 20:04, Joel Fernandes wrote:
> On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> On Sun, Dec 18, 2022 at 8:49 PM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> [...]
>>>>>>>>
>>>>>>>> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
[...]

>>>>>
>>>>> I think this is a bit dangerous. Yes there is the preemption thing you
>>>>> mentioned above, but that is bounded since you can only have a fixed
>>>>> number of tasks that underwent that preemption, and it is quite rare
>>>>> in the sense, each reader should get preempted just after sampling idx
>>>>> but not incrementing lock count.
>>>>>
>>>>> However, if we scan while new readers appear (outside of the above
>>>>> preemption problem), we can have counter wrap causing a false match
>>>>> much quicker.
>>>>> The scan loop is:
>>>>> check_readers(idx) {
>>>>>      count_all_unlocks(idx);
>>>>>      smp_mb();
>>>>>      count_all_locks(idx);
>>>>>      bool done = (locks == unlocks)
>>>>>      if (done) {
>>>>>            // readers are done, end scan for this idx.
>>>>>      } else {
>>>>>            // try again later
>>>>>      }
>>>>> }
>>>>>
>>>>> So if check_readers() got preempted just after the smp_mb(), then you
>>>>> can have lots of tasks enter and exit the read-side critical section
>>>>> and increment the locks count. Eventually locks == unlocks will
>>>>> happen, and it is screwed. Sure this is also theoretical, but yeah
>>>>> that issue can be made "worse" by scanning active readers
>>>>> deliberately, especially when such readers can also nest arbitrarily.
>>>>>
>>>>>> As a result, flipping between periods 0/1 is just relevant for forward
>>>>>> progress, not for correctness.
>>>>>
>>>>> Sure, agreed, forward progress.
>>>>
>>>> Adding to the last statement "But also correctness as described above".
>>>
>>> Exactly how many entry/exit of the read-side critical section while the
>>> grace period is preempted do you need to trigger this ?
>>
>> It depends on how many readers are active during the preemption of the
>> scan code. Say the preemption happened after per-CPU unlock counts
>> were totalled. Then AFAICS, if there are N active readers which need
>> the grace period to wait, you need (2^sizeof(int) - N) number of
>> lock+unlock to happen.
> 
> Sorry, here I meant (2^(sizeof(unsigned long) * 8) - N) which is 2^32
> on 32-bit systems.

And 2^64 on 64-bit systems.

> 
> thanks,
> 
>   - Joel
> 
> 
>>> On a 64-bit system, where 64-bit counters are used, AFAIU this need to
>>> be exactly 2^64 read-side critical sections.
>>
>> Yes, but what about 32-bit systems?

The overflow indeed happens after 2^32 increments, just like seqlock.
The question we need to ask is therefore: if 2^32 is good enough for 
seqlock, why isn't it good enough for SRCU ?

>>
>>> There are other synchronization algorithms such as seqlocks which are
>>> quite happy with much less protection against overflow (using a 32-bit
>>> counter even on 64-bit architectures).
>>
>> The seqlock is an interesting point.
>>
>>> For practical purposes, I suspect this issue is really just theoretical.
>>
>> I have to ask, what is the benefit of avoiding a flip and scanning
>> active readers? Is the issue about grace period delay or performance?
>> If so, it might be worth prototyping that approach and measuring using
>> rcutorture/rcuscale. If there is significant benefit to current
>> approach, then IMO it is worth exploring.

The main benefit I expect is improved performance of the grace period 
implementation in common cases where there are few or no readers 
present, especially on machines with many cpus.

It allows scanning both periods (0/1) for each cpu within the same pass, 
therefore loading both period's unlock counters sitting in the same 
cache line at once (improved locality), and then loading both period's 
lock counters, also sitting in the same cache line.

It also allows skipping the period flip entirely if there are no readers 
present, which is an -arguably- tiny performance improvement as well.

Thanks,

Mathieu

>>
>>> Or am I missing your point ?
>>
>> No, I think you are not. Let me know if I missed something.
>>
>> Thanks,
>>
>>   - Joel
>>
>>
>>>
>>>
>>>>
>>>> thanks,
>>>>
>>>>    - Joel
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

