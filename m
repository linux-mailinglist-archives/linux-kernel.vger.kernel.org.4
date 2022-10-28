Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9B7610B05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJ1HIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJ1HIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:08:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F3911A7A1B;
        Fri, 28 Oct 2022 00:08:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071FD1FB;
        Fri, 28 Oct 2022 00:08:41 -0700 (PDT)
Received: from [10.57.1.225] (unknown [10.57.1.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 455D73F445;
        Fri, 28 Oct 2022 00:08:33 -0700 (PDT)
Message-ID: <2e02056b-24ef-6262-03bd-63fd6f3a5754@arm.com>
Date:   Fri, 28 Oct 2022 08:08:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com>
 <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/22 20:52, Daniel Lezcano wrote:
> 
> Hi Kajetan,
> 
> On 20/10/2022 18:20, Kajetan Puchalski wrote:
>> Hi Rafael,
>>
>>> The avg_util value tells us nothing about how much the CPU is going to
>>> be idle this time and it also tells us nothing about the
>>> latency-sensitivity of the workload.
>>>
>>> Yes, it tells us how much idle time there was on the given CPU in the
>>> past, on the average, but there is zero information about the
>>> distribution of that idle time in it.
>>>
>>> So in the first place please tell me why it fundamentally makes sense
>>> to use avg_util in CPU idle time management at all.
>>
>> I have an alternative suggestion that could be a reasonable way forward
>> here. Instead of applying util-awareness on top of TEO where it would
>> have to be reconciled with how TEO is currently expected to work, I just
>> wrote a simple completely new governor which operates only on timer
>> events alongside util values.
> 
> I second the idea. I took a long time to investigate how to improve the 
> governor and reached the conclusion having a dedicated governor for 
> mobile platform makes sense. Also the behavior is very platform dependent.
> 
> Regarding the utilization, one of the issue is the kernel threads 
> preventing a task to wake up on the same CPU and forcing its migration 
> at wake up time. So the prediction is screwed up at that time.
> 
> There is a paper talking this issue [1]
> 
> I've done a 'mobile' governor, including the next interrupt prediction 
> [2]. It is very simple and almost has the same results as the teo on my 
> platform (rock960).
> 
> I'm not planning to upstream it because I don't have spare time to 
> improve the results and take care of the IPIs. part.
> 
> Also the paradigm is radically different and you may be interested in 
> the approach.
> 
> So if you want to rework, improve, test, upstream it, feel free to reuse 
> the code.
> 
>    -- Daniel
> 
> [1] Dynamic workload characterization for power efficient scheduling on 
> CMP systems : https://cseweb.ucsd.edu//~tullsen/islped10.pdf
> 
> [2] 
> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=cpuidle/mobile-governor-v5.1&id=de1edb05e3c342f0738b414aa84263d6555b7462 
> 
> 
> 

Thanks Daniel! I forgot about your work in this area. As I have
responded in some other email in this thread, we might start
from a new small governor and than others can contribute.

Even this small governor that Kajetan showed me performs really
good on pixel6.

Regards,
Lukasz

