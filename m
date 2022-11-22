Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0226337BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiKVI7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiKVI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:58:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5847193F2;
        Tue, 22 Nov 2022 00:58:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 920E31FB;
        Tue, 22 Nov 2022 00:58:24 -0800 (PST)
Received: from [10.57.5.144] (unknown [10.57.5.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBA103F587;
        Tue, 22 Nov 2022 00:58:14 -0800 (PST)
Message-ID: <97af1300-541d-a79c-404c-92886f10b220@arm.com>
Date:   Tue, 22 Nov 2022 08:58:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Wu <wusamuel@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
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
 <880b7332-562c-4934-4e92-493b112568c9@arm.com>
 <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
 <CAJZ5v0iNjPAAn0-uygpJe0ya_LW7pfF4C8OHd+8EMLg+Ws=02Q@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iNjPAAn0-uygpJe0ya_LW7pfF4C8OHd+8EMLg+Ws=02Q@mail.gmail.com>
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

Hi Rafael and Sam

On 11/21/22 19:18, Rafael J. Wysocki wrote:
> On Fri, Nov 18, 2022 at 2:00 AM Sam Wu <wusamuel@google.com> wrote:
>>
>> On Wed, Nov 16, 2022 at 3:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>> Which mainline kernel version you use in pixel6?
>> I am using kernel version 6.1-rc5.
>>>
>>> Could you elaborate a bit how is it possible?
>>> Do you have the sg_policy setup properly (and at right time)?
>>> Do you have the cpu capacity from arch_scale_cpu_capacity()
>>> set correctly and at the right time during this cpufreq
>>> governor setup?
>>>
>>> IIRC in Android there is a different code for setting up the
>>> cpufreq sched governor clones. In mainline we don't have to do
>>> those tricks, so this might be the main difference.
>> This behavior is seen on the mainline kernel. There isn't any vendor code
>> modifying the behavior, and the schedutil governor is being used.
>>>
>>> Could you trace the value that is read from
>>> arch_scale_cpu_capacity() and share it with us?
>>> I suspect this value changes in time in your kernel.
>> There's an additional CPU capacity normalization step during
>> init_cpu_capacity_callback() that does not happen until all the CPUs come
>> online. However, the sugov_start() function can be called for a subset of
>> CPUs before all the CPUs are brought up and before the normalization of
>> the CPU capacity values, so there could be a stale value stored
>> in sugov_policy.max field.
> 
> OK, the revert has been applied as 6.1-rc material, thanks!

I was on a business trip last week so couldn't check this.
Now I'm back and I've checked the booting sequence.
Yes, there is some race condition and the mechanism
using blocking_notifier_call_chain() in the cpufreq_online()
doesn't help while we are registering that schedutil
new policy.

I will have to go through those mechanisms and check them.
I agree, for now the best option is to revert the patch.

My apologies for introducing this issues.
Thanks Sam for capturing it.

Regards,
Lukasz
