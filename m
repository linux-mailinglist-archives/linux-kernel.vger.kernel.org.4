Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BF5F110B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiI3RmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiI3RmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:42:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA916DDC1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:42:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f26so3090556qto.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4oUJatHFdKZQwK1z1wWJnLxCQH7/R/Xv/qD6jxyBOAI=;
        b=MGmkQC3bU1eF4xVURE5uCKLoDYvycI0uqwXcfUuAqX/PPwfIX0gKPVDeJXVHQYo4oI
         0JoRKpmEKoi68LRfrWteDIexir60h6yuPTfqvujnnbEJMKXNs6SAWGfzs6JEEYU5eyA7
         KA3m29ATKl0IT4IzLa9uXARVpHpB1AcUFykDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4oUJatHFdKZQwK1z1wWJnLxCQH7/R/Xv/qD6jxyBOAI=;
        b=1ZPx1TKVeEnCOulwZ0EWT6mWCHaQ4Q/8MNn0KIdL+Au0CqCvPv555C4UhseTbgFs0g
         tioVB+NAVrIwSAT8hptrtnj9PGzoQxItiilRJZ3u91Deer94WpSjkmLioE2xSJXzWueB
         5tdw0avrEo7+4VQDkmH5+6JstIwVCaUkqTlo6uU0zWbYw+FEnmyQqg2hDbq2pAIcvEJn
         93Et4BEEzM3nRXvCetJjS+GdnLieoJd2YZvihRlcA99aKx57nAz8bph0Z4VOOIILOnW0
         mAHw8YcoavxLMPGNtApEVhN6VC44VDo9xUFnY4Gg9/SBNA8qDYtqucRBHadNayTK5xca
         4FFQ==
X-Gm-Message-State: ACrzQf2t9jCWjtQSQaXajiH0+QCUJ+2UfVXM5frsYbA8jHZW20fO4bau
        NJ9541GOqeQIDBzLJSI6BCIr+g==
X-Google-Smtp-Source: AMsMyM7zFuE6P3gbQ9loiwAN8mHq3TPL7ejYhoNwr2E43Imgw0e1HTlmV9M9cgTssP0U5SCNcXpfmA==
X-Received: by 2002:ac8:4e89:0:b0:35d:5856:919a with SMTP id 9-20020ac84e89000000b0035d5856919amr7711573qtp.647.1664559727304;
        Fri, 30 Sep 2022 10:42:07 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id dm25-20020a05620a1d5900b006b8e63dfffbsm3390056qkb.58.2022.09.30.10.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 10:42:06 -0700 (PDT)
Message-ID: <a4a7a4de-c58d-d667-a4b3-0f7bfb2b09f1@joelfernandes.org>
Date:   Fri, 30 Sep 2022 13:42:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Sum of weights idea for CFS PI
Content-Language: en-US
To:     Youssef Esmat <youssefesmat@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <CALUeGD0yEimCRS2TQfZTUD2kwamyTZwM9Y9D7C=Xsd9t9mWsaw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CALUeGD0yEimCRS2TQfZTUD2kwamyTZwM9Y9D7C=Xsd9t9mWsaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2022 11:44 AM, Youssef Esmat wrote:
> Hi Everyone!

Hi Youssef,

(Youssef is new to LKML though in no way new to OS or software development. I
gave him the usual 'dont-top-post' chat already - fyi).

> I am not sure we should care about A's sleeping pattern. The case we
> care about is when A is running or wants to run but can't because it
> is blocked on C. In that case C should get the weight of A as if A was
> running.

Just to clarify - Youssef did mean sum of weights of different things in the
chain, and not just weights (he confirmed on chat that that's what he meant).

> Ideally this is also a temporary boost since critical sections should
> be relatively small, so erring on the side of giving C slightly more
> runtime would be safe I think.

True. But I would not hold my breath too much on user space not holding a lock
for very long periods of time. But I agree that generally should be true.

thanks,

 - Joel


> 
> Thanks,
> Youssef
> 
> On Fri, Sep 30, 2022 at 8:49 AM Qais Yousef <qais.yousef@arm.com> wrote:
>>
>> Hi Joel
>>
>> I'm interested in the topic, if I can be CCed in any future discussions I'd
>> appreciate it :)
>>
>> On 09/29/22 16:38, Joel Fernandes wrote:
>>> Hi Peter, all,
>>>
>>> Just following-up about the idea Peter suggested at LPC22 about sum of weights
>>> to solve the CFS priority inversion issues using priority inheritance. I am not
>>> sure if a straight forward summation of the weights of dependencies in the
>>> chain, is sufficient (or may cause too much unfairness).
>>>
>>> I think it will work if all the tasks on CPU are 100% in utilization:
>>>
>>> Say if you have 4 tasks (A, B, C, D) running and each one has equal
>>> weight (W) except for A which has twice the weight (2W).
>>> So the CPU bandwidth distribution is (assuming all are running):
>>> A:   2 / 5
>>> B, C. D:  1 / 5
>>>
>>> Say out of the 4 tasks, 3 of them are a part of a classical priority
>>> inversion scenario (A, B and C).
>>>
>>> Say now A blocks on a lock and that lock's owner C is running, however now
>>> because A has blocked, B gets 1/3 bandwidth, where as it should have been
>>> limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
>>> bandwidth - still not fair since B is eating away CPU bandwidth causing the
>>> priority inversion we want to remedy.
>>>
>>> The correct bandwidth distribution should be (B and D should be unchanged):
>>> B = 1/5
>>> D = 1/5
>>>
>>> C = 3/5
>>>
>>> This means that C's weight should be 3W , and B and D should be W each
>>> as before. So indeed, C's new weight is its original weight PLUS the
>>> weight of the A - that's needed to keep the CPU usage of the other
>>> tasks (B, D) in check so that C makes forward progress on behalf of A and the
>>> other tasks don't eat into the CPU utilization.
>>>
>>> However, I think this will kinda fall apart if A is asleep 50% of the time
>>> (assume the sleep is because of I/O and unrelated to the PI chain).
>>>
>>> Because now if all were running (and assume no PI dependencies), with A being
>>> 50%, the bandwidth of B, C and D each would be divided into 2 components:
>>>
>>> a.  when A is running, it would be as above.
>>> b.  but if A was sleeping, B, C, and D would get 1/3.
>>>
>>> So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
>>> or 1/5 bandwidth.
>>
>> The average metric is interesting one. It can be confusing to reason about too.
>>
>> I think we have 3 events to take into account here, not 2:
>>
>> a. when A is running and NOT blocked on C.
>> b. when A is running and BLOCKED on C.
>> c. A is sleeping.
>>
>> This means A, B, C and D's shares will be:
>>
>>     A ,  B ,  C ,  D
>> a. 2/5, 1/5, 1/5, 1/5
>> b. -  , 3/5, 1/5, 1/5
>> c. -  , 1/3, 1/3, 1/3
>>
>> Since A is sleeping for 50%, I don't think we can assume equal distribution for
>> the 3 events (can't just divide by 3).
>>
>> I believe we can assume that
>>
>> a. occurs 25% of the time
>> b. occurs 25% of the time
>> c. occurs 50% of the time
>>
>> I *think* this should provide something more representative.
>>
>>>
>>> But now say A happen to block on a lock that C is holding. You would boost C to
>>> weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
>>> C should actually get.
>>>
>>> C should get (8/30 + 6/30 = 14/30) AFAICS.
>>>
>>> Hopefully one can see that a straight summation of weights is not enough. It
>>> needs to be something like:
>>>
>>> C's new weight = C's original weight + (A's weight) * (A's utilization)
>>>
>>> Or something, otherwise the inherited weight may be too much to properly solve it.
>>>
>>> Any thoughts on this? You mentioned you had some notes on this and/or proxy
>>> execution, could you share it?
>>
>> I assume we'll be using rt-mutex inheritance property to handle this? If this
>> was discussed during a talk, I'd appreciate a link to that.
>>
>> In the past in OSPM conference we brought up an issue with performance
>> inversion where a task running on a smaller (slower to be more generic) CPU is
>> holding the lock and causing massive delays for waiters. This is an artefact of
>> DVFS. For HMP, there's an additional cause due to the unequal capacities of the
>> CPUs.
>>
>> Proxy execution seems to be the nice solution to all of these problems, but
>> it's a long way away. I'm interested to learn how this inheritance will be
>> implemented. And whether there are any userspace conversion issues. i.e: do
>> we need to convert all locks to rt-mutex locks?
>>
>>
>> Thanks
>>
>> --
>> Qais Yousef
