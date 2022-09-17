Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8785BB891
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIQNw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIQNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:52:54 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28032ED56
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:52:51 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d1so18747777qvs.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vJ4O/hkyjCrA6oI/bSVDyEwRWGxm+Xl7wHs+Z6en8zg=;
        b=WoBbJckgowb1qrD/G16dHIjy39E8oRTV1ZHmRb/eLTe9b9sCxh0EB3mGAKnf6i1Im3
         /MmHZ+mJZYevUli/EgwTbPZP3eTAhJPYSbg7uxCuB7pjjMhZOyfX55T9NrowdU/TR4H+
         /3epKbMvjLMseQ2tLyx8jsOju3DPuI0vhr1D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vJ4O/hkyjCrA6oI/bSVDyEwRWGxm+Xl7wHs+Z6en8zg=;
        b=dxU8/fFmB4Zs/w2oOAxPLI9Vs3Yb7grXe22kSMjdDMtvn33WtgM39UM9XJ4KPPxTZ3
         aSM+7lEiRlTb2YnmZv8GFAeEOSxAtKa6k6ZWYk1fTs4VufCiwtcYyMOo9atajr+QTLTg
         Lw2kFfVpedPuxzvTP97fhZSoqCqrS6ivpcdegR69cgy4PgzOepL415tE35DfJGYjRWhC
         F1k+xIW9Xwp2SUJDfLoDo1PNVuoaCABUugzO80il2+1JCSlJ6Zz6pUT8Fqdx2HaJmHhu
         l2YEaQe7Ry3CX1guVaoJUdBkRaJATWXLi08sEyRMSN/VRN0e3RWNRxpB8yUPh8U/t5rP
         Ibfw==
X-Gm-Message-State: ACrzQf0VdzoiUvT7+qwq373FmxWshcfGrBtIY1m9IjNufO9/QnZ6y+zx
        K2yCA6l304qaZ+sgaWM9ZsLqLg==
X-Google-Smtp-Source: AMsMyM6l5RhWnd0SsHnkcN7yisFnYUECzoPY/SJ4OZBbcX7ZAmenY9cbQKEO8risZBREb6jBcYPMXw==
X-Received: by 2002:a05:6214:5609:b0:4ac:aa5e:5425 with SMTP id mg9-20020a056214560900b004acaa5e5425mr8165924qvb.81.1663422770866;
        Sat, 17 Sep 2022 06:52:50 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id v4-20020a05620a090400b006bbf85cad0fsm8147786qkv.20.2022.09.17.06.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 06:52:50 -0700 (PDT)
Message-ID: <82a58d5c-73e7-6e78-e72e-3e46a1a3afbc@joelfernandes.org>
Date:   Sat, 17 Sep 2022 09:52:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: RCU vs NOHZ
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <CAEXW_YTN7mnQSN2eJCysLsZOq+8JEOV6pvgw3LDTT=0mnkC2SA@mail.gmail.com>
 <YyXNJEH6xafOcp39@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YyXNJEH6xafOcp39@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2022 9:35 AM, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 02:11:10PM -0400, Joel Fernandes wrote:
>> Hi Peter,
>>
>> On Fri, Sep 16, 2022 at 5:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> [...]
>>>> It wasn't enabled for ChromeOS.
>>>>
>>>> When fully enabled, it gave them the energy-efficiency advantages Joel
>>>> described.  And then Joel described some additional call_rcu_lazy()
>>>> changes that provided even better energy efficiency.  Though I believe
>>>> that the application should also be changed to avoid incessantly opening
>>>> and closing that file while the device is idle, as this would remove
>>>> -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
>>>> use cases would likely remain.
>>>
>>> So I'm thinking the scheme I outlined gets you most if not all of what
>>> lazy would get you without having to add the lazy thing. A CPU is never
>>> refused deep idle when it passes off the callbacks.
>>>
>>> The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
>>> and do our utmost bestest to move work away from it. You *want* to break
>>> affinity at this point.
>>>
>>> If you hate on the global, push it to a per rcu_node offload list until
>>> the whole node is idle and then push it up the next rcu_node level until
>>> you reach the top.
>>>
>>> Then when the top rcu_node is full idle; you can insta progress the QS
>>> state and run the callbacks and go idle.
>>
>> In my opinion the speed brakes have to be applied before the GP and
>> other threads are even awakened. The issue Android and ChromeOS
>> observe is that even a single CB queued every few jiffies can cause
>> work that can be otherwise delayed / batched, to be scheduled in. I am
>> not sure if your suggestions above address that. Does it?
> 
> Scheduled how? Is this callbacks doing queue_work() or something?

Way before the callback is even ready to execute, you can rcuog, rcuop,
rcu_preempt threads running to go through the grace period state machine.

> Anyway; the thinking is that by passing off the callbacks on NOHZ, the
> idle CPUs stay idle. By running the callbacks before going full idle,
> all work is done and you can stay idle longer.

But all CPUs idle does not mean grace period is over, you can have a task (at
least on PREEMPT_RT) block in the middle of an RCU read-side critical section
and then all CPUs go idle.

Other than that, a typical flow could look like:

1. CPU queues a callback.
2. CPU then goes idle.
3. Another CPU is running the RCU threads waking up otherwise idle CPUs.
4. Grace period completes and an RCU thread runs a callback.

>> Try this experiment on your ADL system (for fun). Boot to the login
>> screen on any distro,
> 
> All my dev boxes are headless :-) I don't thinkt he ADL even has X or
> wayland installed.

Ah, ok. Maybe what you have (like daemons) are already requesting RCU for
something. Android folks had some logger requesting RCU all the time.

>> and before logging in, run turbostat over ssh
>> and observe PC8 percent residencies. Now increase
>> jiffies_till_first_fqs boot parameter value to 64 or so and try again.
>> You may be surprised how much PC8 percent increases by delaying RCU
>> and batching callbacks (via jiffies boot option) Admittedly this is
>> more amplified on ADL because of package-C-states, firmware and what
>> not, and isn’t as much a problem on Android; but still gives a nice
>> power improvement there.
> 
> I can try; but as of now turbostat doesn't seem to work on that thing at
> all. I think localyesconfig might've stripped a required bit. I'll poke
> at it later.

Cool! I believe Len Brown can help on that , or maybe there is another way you
can read the counters to figure out the PC8% and RAPL power.

thanks,

 - Joel


