Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0065091C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiLSJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiLSJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:09:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B3EBBC86;
        Mon, 19 Dec 2022 01:09:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA40CFEC;
        Mon, 19 Dec 2022 01:10:20 -0800 (PST)
Received: from [10.57.10.192] (unknown [10.57.10.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F983F703;
        Mon, 19 Dec 2022 01:09:36 -0800 (PST)
Message-ID: <7f755efd-baad-b5c5-0707-e4adde2d3671@arm.com>
Date:   Mon, 19 Dec 2022 09:09:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] Documentation: sched: Document util clamp feature
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20221216235716.201923-1-qyousef@layalina.io>
 <Y52Ri28ThsM4iU8X@debian.me> <20221217220133.p5wh7drpvkmkups2@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221217220133.p5wh7drpvkmkups2@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/22 22:01, Qais Yousef wrote:
> On 12/17/22 16:53, Bagas Sanjaya wrote:
>> On Fri, Dec 16, 2022 at 11:57:16PM +0000, Qais Yousef wrote:
>>> +Another example is in Android where tasks are classified as background,
>>> +foreground, top-app, etc. Util clamp can be used to constrain how much
>>> +resources background tasks are consuming by capping the performance point they
>>> +can run at. This constraint helps reserve resources for important tasks, like
>>> +the ones belonging to the currently active app (top-app group). Beside this
>>> +helps in limiting how much power they consume. This can be more obvious in
>>> +heterogeneous systems (e.g. Arm big.LITTLE); the constraint will help bias the
>>> +background tasks to stay on the little cores which will ensure that:
>>> +
>>> +        1. The big cores are free to run top-app tasks immediately. top-app
>>> +           tasks are the tasks the user is currently interacting with, hence
>>> +           the most important tasks in the system.
>>> +        2. They don't run on a power hungry core and drain battery even if they
>>> +           are CPU intensive tasks.
>>> +
>>> +.. note::
>>> +  **little cores**:
>>> +    CPUs with capacity < 1024
>>> +
>>> +  **big cores**:
>>> +    CPUs with capacity = 1024
>>
>> Processing capacity (CPU frequency) in MHz? This is the first time I
> 
> This is a scheduler abstraction value from 0-1024. Biggest CPU always has
> a capacity of 1024. On SMP all cpus appear as 1024 CPUs.
> 
>> hear Arm big.LITTLE architecture. CC'ing several Arm folks and
>> linux-arm-kernel list for I'm unsure on this.
> 
> This has my Arm SoB :-)
> 
> This was added based on Lukasz comments. Both Lukasz and Dietmar were my
> colleagues at Arm and are on CC.

Arm big.LITTLE is probably the most popular heterogeneous system in the
world (hundreds of millions of phones run that) :)

Bagas you definitely has to catch up ;) [1] [2]

> 
> I don't think it was necessary to expand the recipients list. But probably more
> is better though all the scheduler people are covered. This has nothing to do
> with Arm but it's the prime example of heterogeneous systems.
> 
>>
>>> +
>>> +By making these uclamp performance requests, or rather hints, user space can
>>> +ensure system resources are used optimally to deliver the best possible user
>>> +experience.
>>> +
>>> +Another use case is to help with **overcoming the ramp up latency inherit in
>>> +how scheduler utilization signal is calculated**.
>>
>> IMO the bold text isn't needed (why did you highlight the phrase above)?
>>
>>> +When task @p is running, **the scheduler should try its best to ensure it
>>> +starts at 40% performance level**. If the task runs for a long enough time so
>>> +that its actual utilization goes above 80%, the utilization, or performance
>>> +level, will be capped.
>>
>> Same here.
>>
>>> +**Generally it is advised to perceive the input as performance level or point
>>> +which will imply both task placement and frequency selection**.
>>
>> Same here too.
> 
> All of these were added based on Lukasz review comments. He thought they're
> important pieces and should be highlighted, I opted to do that by making them
> bold text.

Looks OK to me. This documentation will be read by application
developers. They used to read different type of documentations.
We want to help them to better understand the issues and possible
solution's mechanisms. That's why IMO bold text is OK in this case.

> 
> 
> Thanks!
> 
> --
> Qais Yousef


[1] https://developer.arm.com/documentation/den0024/a/big-LITTLE-Technology
[2] 
https://developer.arm.com/documentation/den0024/a/Multi-core-processors/Multi-processing-systems/Heterogeneous-multi-processing
