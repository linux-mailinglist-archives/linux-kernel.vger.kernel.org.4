Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF563D8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiK3PBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK3PBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:01:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1989C72082;
        Wed, 30 Nov 2022 07:00:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F59D6E;
        Wed, 30 Nov 2022 07:01:03 -0800 (PST)
Received: from [10.57.6.100] (unknown [10.57.6.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A9133F73D;
        Wed, 30 Nov 2022 07:00:53 -0800 (PST)
Message-ID: <3ad43913-00f2-49cb-ad3a-b0e12347389f@arm.com>
Date:   Wed, 30 Nov 2022 15:00:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Wu <wusamuel@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
 <97af1300-541d-a79c-404c-92886f10b220@arm.com>
 <CAKfTPtAPniqQyDzh=Yu8Z9R9+H2PzBKkHT0SJgHZiUOdNdw3Mg@mail.gmail.com>
 <75bba88a-0516-a6a2-d4e6-8cedabadf413@arm.com>
 <CAKfTPtA=7DkjADnNijLPDm_6hh9XkFjC9ZUVQ_5_NSU2Fn5pHQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtA=7DkjADnNijLPDm_6hh9XkFjC9ZUVQ_5_NSU2Fn5pHQ@mail.gmail.com>
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



On 11/30/22 14:29, Vincent Guittot wrote:
> On Wed, 30 Nov 2022 at 15:04, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 11/30/22 10:42, Vincent Guittot wrote:
>>> Hi All
>>>
>>> Just for the log and because it took me a while to figure out the root
>>> cause of the problem: This patch also creates a regression for
>>> snapdragon845 based systems and probably on any QC chipsets that use a
>>> LUT to update the OPP table at boot. The behavior is the same as
>>> described by Sam with a staled value in sugov_policy.max field.
>>
>> Thanks for sharing this info and apologies that you spent cycles
>> on it.
>>
>> I have checked that whole setup code (capacity + cpufreq policy and
>> governor). It looks like to have a proper capacity of CPUs, we need
>> to wait till the last policy is created. It's due to the arch_topology.c
>> mechanism which is only triggered after all CPUs' got the policy.
>> Unfortunately, this leads to a chicken & egg situation for this
>> schedutil setup of max capacity.
>>
>> I have experimented with this code, which triggers an update in
>> the schedutil, when all CPUs got the policy and sugov gov
>> (with trace_printk() to mach the output below)
> 
> Your proposal below looks similar to what is done in arch_topology.c.

Yes, even the name 'cpus_to_visit' looks similar ;)

> arch_topology.c triggers a rebuild of sched_domain and removes its
> cpufreq notifier cb once it has visited all CPUs, could it also
> trigger an update of CPU's policy with cpufreq_update_policy() ?
> 
> At this point you will be sure that the normalization has happened and
> the max capacity will not change.

True, they are done under that blocking notification chain, for the
last policy init. This is before the last time we call the
schedutil sugov_start with that last policy. That's why this code
is able to see that properly normalized max capacity under the:
trace_printk("schedutil the visit cpu mask is empty now\n");


> 
> I don't know if it's a global problem or only for systems using arch_topology
> 

It would only be for those with arch_topology, so only our asymmetric
systems AFAICS.
