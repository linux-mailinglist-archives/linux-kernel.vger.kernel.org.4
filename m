Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623EC62BC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiKPLxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiKPLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:53:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F1953F056;
        Wed, 16 Nov 2022 03:43:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876AC1477;
        Wed, 16 Nov 2022 03:44:02 -0800 (PST)
Received: from [10.57.6.51] (unknown [10.57.6.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA443F663;
        Wed, 16 Nov 2022 03:43:52 -0800 (PST)
Message-ID: <880b7332-562c-4934-4e92-493b112568c9@arm.com>
Date:   Wed, 16 Nov 2022 11:43:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Sam Wu <wusamuel@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110195732.1382314-1-wusamuel@google.com>
 <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 22:35, Saravana Kannan wrote:
> On Thu, Nov 10, 2022 at 11:57 AM Sam Wu <wusamuel@google.com> wrote:
>>
>> This reverts commit 6d5afdc97ea71958287364a1f1d07e59ef151b11.
>>
>> On a Pixel 6 device, it is observed that this commit increases
>> latency by approximately 50ms, or 20%, in migrating a task
>> that requires full CPU utilization from a LITTLE CPU to Fmax
>> on a big CPU. Reverting this change restores the latency back
>> to its original baseline value.
>>
>> Fixes: 6d5afdc97ea7 ("cpufreq: schedutil: Move max CPU capacity to sugov_policy")
>> Cc: Lukasz Luba <lukasz.luba@arm.com>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: Isaac J. Manjarres <isaacmanjarres@google.com>
>> Signed-off-by: Sam Wu <wusamuel@google.com>
> 
> Rafael, can we pick this up please?
> 
> Lukasz, no objections to the idea itself, but it's causing regression
> and we'd like to revert and then fix it.

If you see this in mainline kernel, then I'm fine with reverting it.
Then I will have to trace why this CPU capacity value can change over
time in mainline kernel (while it shouldn't, because we register the
cpufreq policy and the governor later, after we calculate the capacity
in arch_topology.c). Maybe something has changed in mainline in the
meantime in this CPU capacity setup code, which caused this side effect.

I know that android-mainline has some different setup code for those
custom vendor governors. I just want to eliminate this bit and be on the
same page.

Regards,
Lukasz

> 
> -Saravana
> 

