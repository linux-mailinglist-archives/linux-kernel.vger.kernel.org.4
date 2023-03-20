Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C116C1E83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCTRts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCTRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:49:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D691977A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:43:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F1C21424;
        Mon, 20 Mar 2023 10:13:26 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619313F67D;
        Mon, 20 Mar 2023 10:12:39 -0700 (PDT)
Message-ID: <546a2513-fbfb-da1b-d34b-6c7a2024a861@arm.com>
Date:   Mon, 20 Mar 2023 17:12:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Stephane Eranian <eranian@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
 <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com>
 <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
 <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com>
 <CALPaoCgEaT2oax35ezRydUZwL9bMmMFFr2wRqPe4VYAnEQ-GGg@mail.gmail.com>
 <f8a25b5f-4a7d-0891-1152-33f349059b5d@arm.com>
 <CALPaoCim-QkHbm=dXzpfh1N5mx-4u=d21SUrjnBk2OU=R4apbA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCim-QkHbm=dXzpfh1N5mx-4u=d21SUrjnBk2OU=R4apbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/03/2023 09:28, Peter Newman wrote:
> On Thu, Mar 9, 2023 at 6:35 PM James Morse <james.morse@arm.com> wrote:
>> On 09/03/2023 13:41, Peter Newman wrote:
>>> However, I do want to be sure that MBWU counters will never be silently
>>> deallocated because we will never be able to trust the data unless we
>>> know that the counter has been watching the group's tasks for the
>>> entirety of the measurement window.
>>
>> Absolutely.
>>
>> The MPAM driver requires the number of monitors to match the value of
>> resctrl_arch_system_num_rmid_idx(), otherwise 'mbm_local' won't be offered via resctrl.
>> (see class_has_usable_mbwu() in [0])
>>
>> If the files exist in resctrl, then a monitor was reserved for this PARTID+PMG, and won't
>> get allocated for anything else.
>>
>>
>> [0]
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.2&id=f28d3fefdcf7022a49f62752acbecf180ea7d32f
>>
>>
>>> Unlike on AMD, MPAM allows software to control which PARTID+PMG the
>>> monitoring hardware is watching. Could we instead make the user
>>> explicitly request the mbm_{total,local}_bytes events be allocated to
>>> monitoring groups after creating them? Or even just allocating the
>>> events on monitoring group creation only when they're available could
>>> also be marginably usable if a single user agent is managing rdtgroups.
>>
>> Hmmmm, what would that look like to user-space?
>>
>> I'm against inventing anything new here until there is feature-parity where possible
>> upstream. It's a walk, then run kind of thing.
>>
>> I worry that extra steps to setup the monitoring on MPAM:resctrl will be missing or broken
>> in many (all?) software projects if they're not also required on Intel:resctrl.
>>
>> My plan for hardware with insufficient counters is to make the counters accessible via
>> perf, and do that in a way that works on Intel and AMD too.

> In the interest of enabling MPAM functionality, I think the low-effort
> approach is to only allocate an MBWU monitor to a newly-created MON or
> CTRL_MON group if one is available. On Intel and AMD, the resources are
> simply always available.

I agree its low-effort, but I think the result is not worth having.

What does user-space get when it reads 'mbm_total_bytes'? Returning an error here sucks.
How is user-space supposed to identify the groups it wants to monitor, and those it
doesn't care about?

Taking "the only way to win is not to play" means the MPAM driver will only offer those
'mbm_total_bytes' files if they are going to work in the same way they do today. (as you
said, on Intel and AMD the resources are simply always available).

I agree those files have always been able to return errors - but I've never managed to
make the Intel system I have do it... so I bet user-space doesn't expect errors here.
(let alone persistent errors)


My fix for those systems that don't have enough monitors is to expose the counters via
perf, which lets user-space say which groups it wants to monitor (and when!). To make it
easier to use I've done it so the perf stuff works on Intel and AMD too.


> The downside on monitor-poor (or PARTID-rich) hardware is the user gets
> maximually-featureful monitoring groups first, whether they want them or
> not, but I think it's workable.

Really? Depending on the order groups are created in is a terrible user-space interface!
If someone needing to be monitored comes along later, you have do delete the existing
groups ... wait for limbo to do its thing ... then re-create them in some new order.


> Perhaps in a later change we can make an
> interface to prevent monitors from being allocated to new groups or one
> to release them when they're not needed after group creation.
> 
> At least in this approach there's still a way to use MBWU with resctrl
> when systems have more PARTIDs than monitors.
> 
> This also seems like less work than making resctrl able to interface
> with the perf subsystem.

Not correctly supporting resctrl (the mbm_total_files exist, but persistently return an
error) means some user-space users of this thing are broken on those systems.
Adding extra knobs to indicate when the underlying monitor hardware needs to be allocated
is in practice going to be missing if its only needed for MPAM, and is most likely to
bit-rot as codebases that do use it don't regularly test it.


This patch to allow resctrl_arch_rmid_read() to sleep is about MPAM's CSU NRDY and the
high likelyhood that folk build systems where MSCs are sliced up and private to something
smaller than the resctrl:domain. Without the perf support, this would still be necessary.

The changes needed for perf support are to make resctrl_arch_rmid_read() re-entrant, and
for the domain list to be protected by RCU. Neither of these are as onerous as changes to
the user-space interface, and the associated risk of breaking programs that work on other
platforms.


Thanks,

James
