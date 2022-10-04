Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA15F4A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJDU2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:28:02 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A96053D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:28:00 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c2so1943654qvo.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ysll484p4SU1zTXkqdEYlW/dtHXWJDIuC7mSyBkpK0Q=;
        b=RXM3dLS/ziV+HeoR/hogv5CxHQz4lTJz5DH75JRMlmaH6m+UWsC7eKrO5goC3g8SJm
         N9lic88KmLU6XDCwdEXLvECJITLPO/ZmIPsLR6LdPCymk87QIcIasRPU2u6uH6XI3TWd
         K8bcfcd/IBMXDy7CPo3uj3FlMKIobdlt9NT+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ysll484p4SU1zTXkqdEYlW/dtHXWJDIuC7mSyBkpK0Q=;
        b=5JFvnSvAKwrF7h+WroPif8RLmi8lUua23iZjKCIHema0MYCJAdX9llAzDj8h4hSn/q
         stNr6EmS13/HoNpMRRzkKGa9SiiD5MDMZjsCDBn94Wh1yQGlImvCgMRWgT9HbowB7kss
         0eGyJO/PU4j1S5o2G8EJK75CNCtWARMl0N2TMi7uhzf6tqqNucbMRNmFvRQtzqOIO1L4
         ArLisV9gLDgJy90zvtjRD1W4gRoFGHQjy+FghVh7hTv6z695NaoeGLdx5nNB//CgvW9i
         mTYIlXoIintAiJB7vSeDbdrP6X432sOS/29LugiGnb8a/ArnxwUWA0LEYMFs3fbo4yxc
         1DwQ==
X-Gm-Message-State: ACrzQf2Zo9MesMJnqagDDgHMYGIQYCyNB5/N3Q4whStNXZ4I4tAKejSK
        aQdGK05npRK/FtrJsd/4ocNkesurpzkocg==
X-Google-Smtp-Source: AMsMyM6GPJCt3AGol5W9kKNG4mDcqw+dp/CZy4CR45+PNjU28tkTRu0RUgHnWgKj953nsI981TEyUA==
X-Received: by 2002:a05:6214:62b:b0:4aa:af9d:df2 with SMTP id a11-20020a056214062b00b004aaaf9d0df2mr20919928qvx.123.1664915279780;
        Tue, 04 Oct 2022 13:27:59 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a448400b006ceda7a9283sm15169239qkp.48.2022.10.04.13.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 13:27:59 -0700 (PDT)
Message-ID: <bb28d85a-c50f-a25f-aeb4-672eecb75b55@joelfernandes.org>
Date:   Tue, 4 Oct 2022 16:27:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Sum of weights idea for CFS PI
Content-Language: en-US
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2022 12:14 PM, Qais Yousef wrote:
> On 09/30/22 13:34, Joel Fernandes wrote:
>>
>>
>> On 9/30/2022 9:49 AM, Qais Yousef wrote:
>>> Hi Joel
>>>
>>> I'm interested in the topic, if I can be CCed in any future discussions I'd
>>> appreciate it :)
>>
>> Yes, surely! Will do :)
>>
>>> On 09/29/22 16:38, Joel Fernandes wrote:
>>>> Hi Peter, all,
>>>>
>>>> Just following-up about the idea Peter suggested at LPC22 about sum of weights
>>>> to solve the CFS priority inversion issues using priority inheritance. I am not
>>>> sure if a straight forward summation of the weights of dependencies in the
>>>> chain, is sufficient (or may cause too much unfairness).
>>>>
>>>> I think it will work if all the tasks on CPU are 100% in utilization:
>>>>
>>>> Say if you have 4 tasks (A, B, C, D) running and each one has equal
>>>> weight (W) except for A which has twice the weight (2W).
>>>> So the CPU bandwidth distribution is (assuming all are running):
>>>> A:   2 / 5
>>>> B, C. D:  1 / 5
>>>>
>>>> Say out of the 4 tasks, 3 of them are a part of a classical priority
>>>> inversion scenario (A, B and C).
>>>>
>>>> Say now A blocks on a lock and that lock's owner C is running, however now
>>>> because A has blocked, B gets 1/3 bandwidth, where as it should have been
>>>> limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
>>>> bandwidth - still not fair since B is eating away CPU bandwidth causing the
>>>> priority inversion we want to remedy.
>>>>
>>>> The correct bandwidth distribution should be (B and D should be unchanged):
>>>> B = 1/5
>>>> D = 1/5
>>>>
>>>> C = 3/5
>>>>
>>>> This means that C's weight should be 3W , and B and D should be W each
>>>> as before. So indeed, C's new weight is its original weight PLUS the
>>>> weight of the A - that's needed to keep the CPU usage of the other
>>>> tasks (B, D) in check so that C makes forward progress on behalf of A and the
>>>> other tasks don't eat into the CPU utilization.
>>>>
>>>> However, I think this will kinda fall apart if A is asleep 50% of the time
>>>> (assume the sleep is because of I/O and unrelated to the PI chain).
>>>>
>>>> Because now if all were running (and assume no PI dependencies), with A being
>>>> 50%, the bandwidth of B, C and D each would be divided into 2 components:
>>>>
>>>> a.  when A is running, it would be as above.
>>>> b.  but if A was sleeping, B, C, and D would get 1/3.
>>>>
>>>> So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
>>>> or 1/5 bandwidth.
>>>
>>> The average metric is interesting one. It can be confusing to reason about too.
>>>
>>> I think we have 3 events to take into account here, not 2:
>>>
>>> a. when A is running and NOT blocked on C.
>>> b. when A is running and BLOCKED on C.
>>> c. A is sleeping.
>>>
>>> This means A, B, C and D's shares will be:
>>>
>>>     A ,  B ,  C ,  D
>>> a. 2/5, 1/5, 1/5, 1/5
>>> b. -  , 3/5, 1/5, 1/5
>>
>> Here did you mean:
>> b.  -, 1/5, 3/5, 1/5 ?
> 
> Yes! Sorry a typo.
> 
>>
>> A blocked on C means, C should get A's weight (on top of its own).
>>
>>> c. -  , 1/3, 1/3, 1/3
>>>
>>> Since A is sleeping for 50%, I don't think we can assume equal distribution for
>>> the 3 events (can't just divide by 3).
>>
>> Oh yeah, I did not get to _that_ part of the story yet at this point of the
>> email, I brought it up later below where I say "But now say A happen to block"..
> 
> Hmm, but that's my point, I think you need to take _that_ part here or we're
> not be doing an apple to apple comparison.
> 
>>
>>>
>>> I believe we can assume that
>>>
>>> a. occurs 25% of the time
>>> b. occurs 25% of the time
>>> c. occurs 50% of the time
>>>
>>> I *think* this should provide something more representative.
>>
>> Yes possible. My basic idea was I was trying to *not* change the distribution of
>> B based on whether A blocks on C, or whether it does not. In my view, B's
>> distribution should not change just because A and C have a lock dependency,
>> because otherwise C can get too much or too little time. If C gets too much
>> time, then its hurting B. If C gets too little time, then its hurting A.
> 
> Maybe I am getting confused. But AFAICT you're treating
> 
> 
> 	a.  when A is running, it would be as above.
> 	b.  but if A was sleeping, B, C, and D would get 1/3.
> 
> similar to
> 
> 	a.  when A is running *and blocked on C for all its runtime*
> 	b.  but if A was sleeping, B, C, and D would get 1/3.


I am treating the following the same:

 	a.  when A is running, it would be as above.
 	b.  but if A was sleeping, B, C, and D would get 1/3.

 similar to

 	a.  when A is running *and blocked on C for all its runtime*
		^^ -- in this case, B and D should not have their distributions
		      changed at all because they are not participating in the
		      lock acquire and release. So they should neither be hurt
		      any more, nor be boosted. They should simply stay same [1]

 	b.  but if A was sleeping, B, C, and D would get 1/3.


[1] Why? Consider 3 tasks in the all-RT case, A high, B medium and C low prio.

If all are running 100% and A does not block on C, B is blocked by A
indefinitely. So the prio of A and B are inverted. We seek to rectify this, that
is we need make changes such that, B is returned back to the blocked state. We
do this by boosting C.

In other words, the prio inheritance will cause B's distribution to not be
changed (it was supposed to be blocked before and it is now going to be blocked
state again).

CFS should not behave any differently, B's distribution should not be changed
before/after the priority inhertiance of A by C. That's just my opinion - and
that's how I calculated to distribution. With that mind, could you go back to
seeing if my math was originally correct or did I mess something up?

I do think though that Youssef's point of not worrying about being too accurate
is reasonable if the critical sections are short lived but I'm not sure.

> 
> I don't think this is valid. If A is blocked on C for 50% of the time, and
> sleeping for 50% of the time, when did it get blocked/unblocked?
> 
> This will have an impact on the average share for C and skew it, no?
> 
> Unless I missed something, the average share of C being (3/5 + 1/3) is an
> impossible state. You need to consider the portion of time when C runs as 1/5,
> when A is actually not blocked on anything, too.
> 
> Hmm actually I just re-read your statement below and you just say 3/5 (18/30)
> is too much. You didn't consider the average. I'll leave the above in hope to
> help me understand what am I missing and where I went wrong :-)
> 
> Generally IMHO looking at the average will not help. I think if the share
> values make sense in each state individually (and I believe they are), that
> would be enough. AFAICS, B and D are still taking the right amount of time when
> C inherits the bandwidth. And C by definition will run longer when A is blocked
> on it for the whole duration of this blocked time.

I was degenerating the case where A sleeps (say I/O) vs A blocks, to simplify
the math, and then taking average of that. I think that's reasonable?

> 
>>
>>>> But now say A happen to block on a lock that C is holding. You would boost C to
>>>> weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
>>>> C should actually get.
>>>>
>>>> C should get (8/30 + 6/30 = 14/30) AFAICS.
>>>>
>>>> Hopefully one can see that a straight summation of weights is not enough. It
>>>> needs to be something like:
>>>>
>>>> C's new weight = C's original weight + (A's weight) * (A's utilization)
>>>>
>>>> Or something, otherwise the inherited weight may be too much to properly solve it.
>>>>
>>>> Any thoughts on this? You mentioned you had some notes on this and/or proxy
>>>> execution, could you share it?
>>>
>>> I assume we'll be using rt-mutex inheritance property to handle this? If this
>>> was discussed during a talk, I'd appreciate a link to that.
>>
>> Yes that's the idea but I am also aware that 'other' kinds of dependencies in
>> userspace that cannot benefit from a kernel-only boost.
>>
>> So if we consider a bounded-buffer producer/consumer. We can consider the
>> producer as A, and the consumer as C, with B being a random mid-priority task.
>> Once the bounded buffer gets full, A is waiting on a signal from C that it
>> filled the buffer for which C needs to run in the first place to queue its
>> payload into the buffer. However, trouble-maker B is determined to eat away's
>> C's time and develop a prio inversion between itself and A. This pattern should
>> also generalize to a worker pool consuming work.
> 
> Will proxy-execution be able to handle these other cases? I think it is tied to
> rt-mutex to be able to detect the dependency chain too. Looks a generic
> extension of the problem that all potential solutions will need to deal with.

Yeah, in theory if the producer and consumer can "mark" themselves as
potentially have someone waiting for them, then the kernel has that info and any
implementation may capitalize on that. I am not sure if this is already possible
by some command in the futex API.

>>> In the past in OSPM conference we brought up an issue with performance
>>> inversion where a task running on a smaller (slower to be more generic) CPU is
>>> holding the lock and causing massive delays for waiters. This is an artefact of
>>> DVFS. For HMP, there's an additional cause due to the unequal capacities of the
>>> CPUs.
>>>
>>> Proxy execution seems to be the nice solution to all of these problems, but
>>> it's a long way away. I'm interested to learn how this inheritance will be
>>> implemented. And whether there are any userspace conversion issues. i.e: do
>>> we need to convert all locks to rt-mutex locks?
>>
>> I am not an expert on FUTEX_LOCK_PI and this could be a good time for tglx to
>> weigh in, but I think converting all userspace locks to use FUTEX_LOCK_PI sounds
>> reasonable to me.
> 
> I realized whether we need to worry about in-kernel kthreads users too..

Possibly.

> pthreads requires users to specify if they want PTHREAD_PRIO_{INHERIT, PROTECT}
> when initializing their mutex.

PTHREAD_PRIO_PROTECT seems like an interesting approach! Thanks for mentioning.
> AFAICS from glibc, PTHREAD_PRIO_INHERIT maps to FUTEX_LOCK_PI.

Ok.
> But PTHREAD_PRIO_PROTOTECT uses a different algorithm that is implemented in
> glibc. This makes me think how much this makes sense in linux as for CFS
> priorities are transalted into weights and not actual priorites like in RT :-/
> 
> I need to dig more..

Ah same here, more reading/digging to do ;).


- Joel
