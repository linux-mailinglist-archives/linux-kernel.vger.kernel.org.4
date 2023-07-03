Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0EE746074
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGCQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGCQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:09:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53A51138;
        Mon,  3 Jul 2023 09:09:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F6172F4;
        Mon,  3 Jul 2023 09:10:14 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6DFF3F663;
        Mon,  3 Jul 2023 09:09:28 -0700 (PDT)
Message-ID: <a43ce55d-371f-28a0-eb72-3a839df59168@arm.com>
Date:   Mon, 3 Jul 2023 17:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/17] Documentation: EM: Add a new section about the
 design
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-15-lukasz.luba@arm.com>
 <0968c915-0344-b08f-7117-5b1ff6b126fd@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <0968c915-0344-b08f-7117-5b1ff6b126fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/23 11:33, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> Add a new section 'Design' which covers the information about Energy
>> Model. It contains the design decisions, describes models and how they
>> reflect the reality. Add description of the basic const. EM. Change the
>> other section IDs.
> 
> I would vote for coalescing the 4 doc patches into 1.

OK, I can make that. I will be a big one patch, though.

> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   Documentation/power/energy-model.rst | 36 +++++++++++++++++++++-------
>>   1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
>> index ef341be2882b..e97c7f18d8bd 100644
>> --- a/Documentation/power/energy-model.rst
>> +++ b/Documentation/power/energy-model.rst
>> @@ -72,16 +72,34 @@ required to have the same micro-architecture. CPUs in different performance
>>   domains can have different micro-architectures.
>>   
>>   
>> -2. Core APIs
>> +2. Design
>> +-----------------
>> +
>> +2.1 Basic EM
>> +^^^^^^^^^^^^
> 
> Can we make sure that people get the relation between 'basic' and
> 'default' easier?
> 
> It should be obvious that `pd->default_table->state` refers to this
> `basic (const.) EM. Using the same identifier always helps in this
> situation.

OK, how about adding this:
"The basic EM is built around const. power information for each
performance state, which is accessible in:
'dev->em_pd->default_table->state'. This model can be derived based..."

> 
>> +
>> +The basic EM is built around const. power information for each performance
>> +state. This model can be derived based on power measurements of the device
>> +e.g. CPU while running some benchmark. The benchmark might be integer heavy
>> +or floating point computation with a data set fitting into the CPU cache or
>> +registers. Bare in mind that this model might not be covering all possible
>> +workloads running on CPUs. Thus, please run a few different benchmarks and
>> +verify with some real workloads your power model values. The power variation
>> +due to the workload instruction mix and data set is not modeled.
>> +Also static power which can change during runtime due to variation of SOC
>> +temperature is not modeled in EM.
>> +
>> +
