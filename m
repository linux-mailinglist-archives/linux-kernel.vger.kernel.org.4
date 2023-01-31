Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC666832D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjAaQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjAaQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:36:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F5E73598;
        Tue, 31 Jan 2023 08:36:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A743113E;
        Tue, 31 Jan 2023 08:36:51 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646273F64C;
        Tue, 31 Jan 2023 08:36:07 -0800 (PST)
Message-ID: <a5ac2767-6b15-23a2-9ebf-1aa02ee9c4f1@arm.com>
Date:   Tue, 31 Jan 2023 17:36:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
References: <20230119174244.2059628-1-vincent.guittot@linaro.org>
 <d5012cdf-ad5b-adf8-11f6-8ac2c3a89f0b@arm.com>
 <20230129162120.ynzgsxsdjwluucmk@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230129162120.ynzgsxsdjwluucmk@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2023 17:21, Qais Yousef wrote:
> On 01/26/23 12:42, Dietmar Eggemann wrote:
>> On 19/01/2023 17:42, Vincent Guittot wrote:

[...]

>> We had already this discussion whether this patch can also remove
>> Capacity Inversion (CapInv).
>>
>> After studying the code again, I'm not so sure anymore.
>>
>> This patch:
>>
>> (1) adds a dedicated return value (-1) to util_fits_cpu() when:
>>
>> `util fits 80% capacity_of() && util < uclamp_min && uclamp_min >
>> capacity_orig_thermal (region c)`
>>
>> (2) Enhancements to the CPU selection in sic() and feec() to cater for
>> this new return value.
> 
> -1 means that the task fits, but only uclamp_min hint fails. ie: the task util
> is small enough to run on this cpu, but it would like to run faster and this
> cpu can't satisfy this request at the moment.

Agreed.

>> IMHO this doesn't make the intention of CapInv in util_fits_cpu()
>> obsolete, which is using:
>>
>> in CapInv:
>>
>>   capacity_orig         = capacity_orig_of() - thermal_load_avg
>>   capacity_orig_thermal = capacity_orig_of() - thermal_load_avg
>>
>> not in CapInv:
>>
>>   capacity_orig         = capacity_orig_of()
>>   capacity_orig_thermal = capacity_orig_of() - th_pressure
>>
>> Maybe I still miss a bit of the story?
> 
> Vincent approach is different to mine. I tried to hide all the complexity in
> util_fits_cpu() so all users don't care.
> 
> But with Vincent changes, now the decision is delegated to the caller to decide
> what to do if thermal pressure is causing trouble.
> 
> IOW, I expect this line only stay after Vincent patch
> 
> 	capacity_orig_thermal = capacity_orig_of() - th_pressure

OK, makes sense (for now - rework of what capacity_orig_thermal should
really be still ahead of us).

Thanks!

-- Dietmar

[...]
