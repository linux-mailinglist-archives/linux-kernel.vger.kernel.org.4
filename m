Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E690366BA29
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjAPJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjAPJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:21:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAA0F44B6;
        Mon, 16 Jan 2023 01:21:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAF4EAD7;
        Mon, 16 Jan 2023 01:22:07 -0800 (PST)
Received: from [10.12.3.201] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FCD03F67D;
        Mon, 16 Jan 2023 01:21:22 -0800 (PST)
Message-ID: <487f0252-c697-eb62-989d-57ee731691a2@arm.com>
Date:   Mon, 16 Jan 2023 09:21:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
 <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
 <20230114211854.nmvmhtd5yz5wgh2a@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230114211854.nmvmhtd5yz5wgh2a@airbuntu>
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

On 14/01/2023 22:18, Qais Yousef wrote:
> On 01/13/23 15:28, Vincent Guittot wrote:
>> Hi Kajetan,
>>
>> On Fri, 13 Jan 2023 at 14:50, Kajetan Puchalski
>> <kajetan.puchalski@arm.com> wrote:

[...]

>>> sched/uclamp: Fix a uninitialized variable warnings
>>> (baseline_ufc) sched/fair: Check if prev_cpu has highest spare cap in feec()
>>> sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
>>> sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
>>> sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
>>> sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
>>> sched/uclamp: Fix fits_capacity() check in feec()
>>> sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
>>> sched/uclamp: Fix relationship between uclamp and migration margin
>>> (previous 'baseline' was here)
>>>
>>> I omitted the 3 patches relating directly to capacity_inversion but in
> 
> This could lead to confusion. Was there a specific reason for this omission?
> Did you hit some problem?

I thought Vincent's 'split MF from CPU OU' should replace 'CapInv'?

https://lkml.kernel.org/r/20221209164739.GA24368@vingu-book

... I have reverted patches:
Revert "sched/fair: Detect capacity inversion"
Revert "sched/fair: Consider capacity inversion in util_fits_cpu()"
Revert "sched/uclamp: Make cpu_overutilized() use util_fits_cpu()" ...

You also mentioned this in
https://lkml.kernel.org/r/<20230115001906.v7uq4ddodrbvye7d@airbuntu

[...]
