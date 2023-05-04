Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B436F62BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEDBt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDBt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:49:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF711A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:49:53 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QBcDD1CZHzkXwG;
        Thu,  4 May 2023 09:48:44 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 09:49:50 +0800
Message-ID: <5a334292-3e2d-9926-57ec-d52f88e1e324@huawei.com>
Date:   Thu, 4 May 2023 09:49:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Question] softlockup in run_timer_softirq
To:     John Stultz <jstultz@google.com>, Frank Woo <frankwoo@google.com>,
        Rhine Wu <Rhinewuwu@google.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com>
 <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
 <f2b7fdba4ead429bb4dd38a9ccb3735a@huawei.com>
 <CANDhNCoaMPj-aa1VKJoVawBgZWOiZpvZ5cnvVJq4F_d-miTNcA@mail.gmail.com>
From:   "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <CANDhNCoaMPj-aa1VKJoVawBgZWOiZpvZ5cnvVJq4F_d-miTNcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/2 11:06, John Stultz wrote:
> On Wed, Feb 15, 2023 at 12:34 AM liujian (CE) <liujian56@huawei.com> wrote:
>>> On Fri, Feb 10, 2023 at 1:51 AM liujian (CE) <liujian56@huawei.com> wrote:
>>>>
>>>> During the syz test, we encountered many problems with various timer
>>>> handler functions softlockup.
>>>>
>>>> We analyze __run_timers() and find the following problem.
>>>>
>>>> In the while loop of __run_timers(), because there are too many timers
>>>> or improper timer handler functions, if the processing time of the
>>>> expired timers is always greater than the time wheel's next_expiry,
>>>> the function will loop infinitely.
>>>>
>>>> The following extreme test case can be used to reproduce the problem.
>>>> An extreme test case[1] is constructed to reproduce the problem.
>>>
>>> Thanks for reporting and sending out this data:
>>>
>>> First, any chance you might submit this as a in-kernel-stress test?
>>> Maybe utilizing the kernel/torture.c framework?
>>>
>> Okay,   I'll learn this framework and do this thing.
>>> (Though the test may need to occasionally take a break so the system can
>>> eventually catch up)
>>>
>>>> Is this a problem or an unreasonable use?
>>>>
>>>> Can we limit the running time of __run_timers() [2]?
>>>>
>>>> Does anyone have a good idea to solve this problem?
>>>
>>> So your patch reminds me of Peter's softirq_needs_break() logic:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=co
>>> re/softirq
>>>
>>> Maybe it could extend that series for the timer softirq as well?
>>>
>> Thank you. Yes.
>> Base on the patchset and the extended patch for timer [1], the soft lockup problem does not occur.
>>
>> By the way, I see this is a very old patchset?  Will this patchset push the main line? @John @Peter
>>
>>
>>   [1]
>> Author: Liu Jian <liujian56@huawei.com>
>> Date:   Tue Feb 14 09:53:46 2023 +0800
>>
>>      softirq, timer: Use softirq_needs_break()
>>
>>      In the while loop of __run_timers(), because there are too many timers or
>>      improper timer handler functions, if the processing time of the expired
>>      timers is always greater than the time wheel's next_expiry, the function
>>      will loop infinitely.
>>
>>      To prevent this, use the timeout/break logic provided by SoftIRQs.If the
>>      running time exceeds the limit, break the loop and an additional
>>      TIMER_SOFTIRQ is triggered.
>>
>>      Signed-off-by: Liu Jian <liujian56@huawei.com>
>>
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 63a8ce7177dd..70744a469a39 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1992,7 +1992,7 @@ void timer_clear_idle(void)
>>    * __run_timers - run all expired timers (if any) on this CPU.
>>    * @base: the timer vector to be processed.
>>    */
>> -static inline void __run_timers(struct timer_base *base)
>> +static inline void __run_timers(struct timer_base *base, struct softirq_action *h)
>>   {
>>          struct hlist_head heads[LVL_DEPTH];
>>          int levels;
>> @@ -2020,6 +2020,12 @@ static inline void __run_timers(struct timer_base *base)
>>
>>                  while (levels--)
>>                          expire_timers(base, heads + levels);
>> +
>> +               if (softirq_needs_break(h)) {
>> +                       if (time_after_eq(jiffies, base->next_expiry))
>> +                               __raise_softirq_irqoff(TIMER_SOFTIRQ);
>> +                       break;
>> +               }
>>          }
>>          raw_spin_unlock_irq(&base->lock);
>>          timer_base_unlock_expiry(base);
>> @@ -2032,9 +2038,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>>   {
>>          struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>>
>> -       __run_timers(base);
>> +       __run_timers(base, h);
>>          if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
>> -               __run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
>> +               __run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]), h);
>>   }
>>
>>   /*
> 
> So I wanted to revive this old thread, as Frank Woo mentioned his team
> has seen a similar issue as well.
> 
> Liujian: I'm curious if you've made any further progress with your
> adapted patch ontop of PeterZ's softirq_needs_break patch series?
> 
Hi John,
   Only the commit ("softirq, timer: Use softirq_needs_break()") is 
added to the patchset of Peter, and no other modification is made.
> Might it be worth re-submitting the whole series for consideration upstream?
> 
I agree very much and expect, because we often encounter similar 
problems when doing fuzzy tests (especially when the test machine is poor).
> thanks
> -john
