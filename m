Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E416228D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiKIKoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiKIKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:44:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BC99AE72
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:44:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AAE01FB;
        Wed,  9 Nov 2022 02:44:22 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297063F534;
        Wed,  9 Nov 2022 02:44:14 -0800 (PST)
Message-ID: <107bf66d-8924-c287-125f-10a648c7b701@arm.com>
Date:   Wed, 9 Nov 2022 11:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 9/9] sched/fair: Consider capacity inversion in
 util_fits_cpu()
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-10-qais.yousef@arm.com>
 <xhsmhwn8avd07.mognet@vschneid.remote.csb>
 <20221105204141.3tno6fzuh536ye4e@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221105204141.3tno6fzuh536ye4e@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Qais Yousef <qais.yousef@arm.com>

On 05/11/2022 21:41, Qais Yousef wrote:
> On 11/04/22 17:35, Valentin Schneider wrote:
>> On 04/08/22 15:36, Qais Yousef wrote:

[...]

>> IIUC the rq->cpu_capacity_inverted computation in update_cpu_capacity() can be
>> summarised as:
>>
>> - If there is a PD with equal cap_orig, but higher effective (orig - thermal)
>>   capacity
>>   OR
>>   there is a PD with pd_cap_orig > cpu_effective_cap:
>>   rq->cpu_capacity_inverted = capacity_orig - thermal_load_avg(rq)
>>
>> - Else:
>>   rq->cpu_capacity_inverted = 0
>>
>> Then, the code above uses either rq->cpu_capacity_inverted if it is
>> non-zero, otherwise:
>>
>>   capacity_orig - arch_scale_thermal_pressure(cpu);
>>
>> Why use average thermal pressure in one case, and use instantaneous
>> thermal pressure in the other?
> 
> There was a big debate on [1] about using avg vs instantaneous.
> 
> I used avg for detecting inversion to be consistent with using average in in
> scale_rt_capacity(). I didn't want the inversion state to be flipping too
> quickly too.
> 
> I used the instantaneous in the other check based on that discussion. It seemed
> using the average is hurtful when for example the medium drops an OPP and by
> not reacting quickly at wake up we lose the chance to place it on a big; which
> if my memory didn't fail me is what Xuewen was seeing.
> 
> [1] https://lore.kernel.org/lkml/24631a27-42d9-229f-d9b0-040ac993b749@arm.com/
> 
>>
>> Can't we get rid of rq->cpu_capacity_inverted and replace this whole thing
>> with an unconditional
>>
>>   capacity_orig_thermal = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
>>
>> ?
> 
> I can't see how we end up with equivalent behavior then. Or address the
> concerns raised by Xuewen and Lukasz on the RT thread in regards to avg vs
> instantaneous.
> 
> Specifically, if we don't use the new rq->cpu_capacity_inverted we can't handle
> the case where the task is requesting to run at maximum performance but a small
> drop in thermal pressure means it won't fit anywhere. That PD is the best fit
> until it hits an inversion.
> 
> Originally I wanted to defer handling thermal pressure into a different series.
> But Vincent thought it's better to handle it now. We want more data points from
> more systems tbh. But I think what we have now is still a good improvement over
> what we had before.

I can't see the rationale in using:

!inversion: `cap_orig - instantaneous thermal pressure`

 inversion: `cap_orig - PELT thermal pressure`

I can see that there was a lot of discussion on this topic but hardly
any agreement IMHO.

AFAICS, the 2 capacity inversion patches just appeared in v2 and haven't
seen any review yet I'm afraid.


[...]
