Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08565EF3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiI2LHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiI2LHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:07:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18F781928D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:07:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061A315BF;
        Thu, 29 Sep 2022 04:07:47 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB363F73B;
        Thu, 29 Sep 2022 04:07:36 -0700 (PDT)
Message-ID: <b9caf0c7-8f61-f5e3-b299-3ae5b76d8b63@arm.com>
Date:   Thu, 29 Sep 2022 13:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Jian-Min Liu <jian-min.liu@mediatek.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 11:47, Peter Zijlstra wrote:

[...]

>> ---------------------------------------------------------------------
>> --|                      | PELT
>> halflife                                |
>> |                      |----------------------------------------------|
>> |                      |       32      |       16      |       8      |
>> |                      |----------------------------------------------|
>> |                      | avg  min  avg | avg  min  avg | avg  min  avg|
>> | Scenarios            | fps  fps  pwr | fps  fps  pwr | fps  fps  pwr|
>> |---------------------------------------------------------------------|
>> | HOK game 60fps       | 100  100  100 | 105 *134* 102 | 104 *152* 106|
>> | HOK game 90fps       | 100  100  100 | 101 *114* 101 | 103 *129* 105|
>> | HOK game 120fps      | 100  100  100 | 102 *124* 102 | 105 *134* 105|
> 
> You have your min and avg fps columns mixed up, your min cannot be larger
> than avg.
> 
> Also, with min fps mostly above the actual screen fps, who cares. And
> seriously 120fps on a phone !?!? for worse power usage! you gotta be
> kidding me.

I agree that since we don't know what 100% at 32 means its unclear what
problem gets actually solved here by running with 16 or 8.

> And I googled this game; it is some top-down tactical thing with
> real-time combat (as opposed to turn-based) (DOTA like I suppose),
> 60 fps locked should be plenty fine.
> 
>> | FHD video rec. 60fps | 100  100  100 | n/a  n/a  n/a | 100  100  103|
>> | Camera snapshot      | 100  100  100 | n/a  n/a  n/a | 100  100  102|
> 
> Mostly I think you've demonstrated that none of this is worth it.

I assume Jian-Min added those two lines to demonstrate that they would
need the run-time switch.

>> -----------------------------------------------------------------------
>>
>> HOK ... Honour Of Kings, Video game
>> FHD ... Full High Definition
>> fps ... frame per second
>> pwr ... power consumption
>>
>> table values are in %
> 
> Oh... that's bloody insane; that's why none of it makes sense.
> 
> 
> How is any of that an answer to:
> 
>   "They want; I want an explanation of what exact problem is fixed how ;-)"
> 
> This is just random numbers showing poking the number has some effect;
> it has zero explaination of why poking the number changes the workload
> and if that is in fact the right way to go about solving that particular
> issue.

Jian-Min, would you be able to show real numbers in comparison to the
chosen fps here? And explain what the problem is which gets solved. What
is the effect of this higher min fps values when running 16 or 8? And
why is the default 32 not sufficient here?
