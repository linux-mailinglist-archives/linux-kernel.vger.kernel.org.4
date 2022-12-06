Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FA6441D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiLFLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiLFLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:08:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3596B86D;
        Tue,  6 Dec 2022 03:08:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525D023A;
        Tue,  6 Dec 2022 03:08:32 -0800 (PST)
Received: from [10.57.7.134] (unknown [10.57.7.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 803593F73D;
        Tue,  6 Dec 2022 03:08:22 -0800 (PST)
Message-ID: <c2dc2ff0-b565-a2da-b3fa-2f50eb2b2e77@arm.com>
Date:   Tue, 6 Dec 2022 11:08:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] cpufreq: schedutil: Optimize operations with single max
 CPU capacity
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
References: <20221206101021.18113-1-lukasz.luba@arm.com>
 <20221206101629.dbcuv3zdso44w3cq@vireshk-i7>
 <2a97cf28-7e47-04c7-edcb-41adbd20ccd9@arm.com>
 <CAJZ5v0hRW2Px4LP9OCgFqyUQUiVr0xZL6dYPrWrmGerGqCq1PQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hRW2Px4LP9OCgFqyUQUiVr0xZL6dYPrWrmGerGqCq1PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/22 11:00, Rafael J. Wysocki wrote:
> On Tue, Dec 6, 2022 at 11:30 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 12/6/22 10:16, Viresh Kumar wrote:
>>> On 06-12-22, 10:10, Lukasz Luba wrote:
>>>> The max CPU capacity is the same for all CPUs sharing frequency domain
>>>> and thus 'policy' object. There is a way to avoid heavy operations
>>>> in a loop for each CPU by leveraging this knowledge. Thus, simplify
>>>> the looping code in the sugov_next_freq_shared() and drop heavy
>>>> multiplications. Instead, use simple max() to get the highest utilization
>>>> from these CPUs. This is useful for platforms with many (4 or 6) little
>>>> CPUs.
>>>>
>>>> The max CPU capacity must be fetched every time we are called, due to
>>>> difficulties during the policy setup, where we are not able to get the
>>>> normalized CPU capacity at the right time.
>>>>
>>>> The stored value in sugov_policy::max is also than used in
>>>> sugov_iowait_apply() to calculate the right boost. Thus, that field is
>>>> useful to have in that sugov_policy struct.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>
>>> Can you please divide this into two patches, one for just moving max
>>> and one for looping optimization ? Else we may end up reverting
>>> everything once again.
>>>
>>
>> OK, I can do that. Thanks for having a look!
> 
> Also, please note that this material is unlikely to go into 6.2, so
> I'd prefer going back to it after 6.2-rc1 is out.

Yes, I understand. Thanks Rafael!
