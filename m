Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DD6E748F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjDSIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjDSIB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:01:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E959DE;
        Wed, 19 Apr 2023 01:01:25 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q1Y9P2rwDzsRT3;
        Wed, 19 Apr 2023 15:59:53 +0800 (CST)
Received: from [10.67.101.98] (10.67.101.98) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Apr
 2023 16:01:23 +0800
Message-ID: <4266f5da-13e5-7732-8ee2-5f231baee0a2@hisilicon.com>
Date:   Wed, 19 Apr 2023 16:01:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH v1 0/4] HiSilicon Performance Monitor Control Unit
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <zhangshaokun@hisilicon.com>,
        <shenyang39@huawei.com>, <hejunhao3@huawei.com>,
        <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, Rob Herring <robh@kernel.org>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
 <75a1b477-5325-bec9-5750-b09bf0e5dfb0@hisilicon.com>
 <20230317131131.00005817@Huawei.com>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230317131131.00005817@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.98]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2023 21:11, Jonathan Cameron wrote:
> On Mon, 27 Feb 2023 16:49:46 +0800
> Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>> Please can anyone have a look at this PMCU patchset and provide some
>> comments?
>>
>> It is much related to the ARM PMU.
>>
>> We are looking forward to the feedback.
>>
>> Any relevant comments/questions, with respect to software or hardware
>> design, use cases, coding, are welcome.
>>
>> Kind regards,
>>
>> Jie
>>
>>
>> On 06/02/2023 14:51, Jie Zhan wrote:
>>> HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
>>> PMU accesses from CPUs, handling the configuration, event switching, and
>>> counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
>>> and multi-PMU-event CPU profiling, in which scenario the current 'perf'
>>> scheme may lose events or drop sampling frequency. With PMCU, users can
>>> reliably obtain the data of up to 240 PMU events with the sample interval
>>> of events down to 1ms, while the software overhead of accessing PMUs, as
>>> well as its impact on target workloads, is reduced.
>>>
>>> This patchset contains the documentation, driver, and user perf tool
>>> support to enable using PMCU with the 'perf_event' framework.
>>>
>>> Here are two key questions requested for comments:
>>>
>>> - How do we make it compatible with arm_pmu drivers?
>>>
>>>     Hardware-wise, PMCU uses the existing core PMUs, so PMUs can be accessed
>>>     from CPU and PMCU simultaneously. The current hardware can't guarantee
>>>     mutual exclusive accesses. Hence, scheduling arm_pmu and PMCU events at
>>>     the same time may mess up the operation of PMUs, delivering incorrect
>>>     data for both events, e.g. unexpected events or sample periods.
>>>     Software-wise, we probably need to prevent the two types of events from
>>>     running at the same time, but currently there isn't a clear solution.
Hi Jonathan,

Sorry for a late reply on this, but I have thought a bit more on this 
issue recently.
> I've been thinking about this a bit and don't have a good answer yet.
>
> So some thoughts that might get some discussion going (some are here
> mostly to be shot down ;)
>
> 1. I suspect adding a hook into the specific pmu driver to reserve a counter is going
>     to be controversial for this usecase.  But maybe there is a more generic
>     way...  There are lock up detectors that use PMU counters and ensure the counters
>     aren't also used for other purposes and that leads me to wonder if you can use
> https://elixir.bootlin.com/linux/latest/source/kernel/events/core.c#L12700
> perf_event_create_kernel_counter()
> to do the same as opening a counter from userspace but then not use it.
> I have no idea if this will work though or if enabling the event would be necessary
> to prevent it being used elsewhere.
KVM is actually doing a similar thing. KVM inserts a call in 
armpmu_register() to save
a reference to struct arm_pmu, so as to get some information of arm_pmu, 
e.g. its pmu
type. With the pmu type, it can issue arm_pmu events through 
perf_event_create_kernel_counter().
Now we can make a general interface of this (supposed to be read-only), 
enabling other
kernel code to get the data of arm_pmu, not just for kvm.

In addition, PMCU needs to occupy certain counters, while the arm_pmu 
driver currently
gets the first free counter it finds in the counter bitmap (see 
armv8pmu_get_event_idx()).
Thus, we may have to add a mechanism to optionally specify a counter 
index that an event
wants to use. Adding a config field and adapting 
armv8pmu_get_event_idx() should work.

A more tricky work would be preventing the "occupying" events from being 
scheduled out.
I don't think this is a friendly action, and the perf_event framework 
doesn't seem to
support so (even if we add the "pinned" attribute, the event would also 
be switched out
when there comes another "pinned" event). However, any "occupying" 
events being scheduled
out should cause PMCU to stop, and I think this would undermine the 
advantage of PMCU.
> 2. It might be possible to reuse any of the infrastructure that exists
>     for userspace PMU counter access or maybe Rob Herring (+CC) has a suggestion based on
>     his work on that feature.
>
> 3. It's not nice, but maybe could enforce this constraint just in userspace?
>     We'd have to make sure that both drivers didn't do anything beyond not working
>     correctly if the other driver is messing with the hardware.
I actually think this is fine? So far, we haven't identified or found 
any problem from
running PMCU and ARM_PMU simultaneously beyond getting wrong readings. 
PMCU is designed
for system administrative use only. PMCU can also use a subset of PMU 
counters with higher
indices, and the reset of counters with lower indices can still be 
exposed to EL0 or EL1.
Thus, this approach should also work, providing that: a) EL0 or EL1 can 
only access a subset
of counters with the lower indices, and b) system administrative 
programs don't use ARM_PMU
and PMCU at the same time, or don't do anything harmful when getting 
abnormal PMU readings.
>
> 4. We can't do the nasty trick of providing a second driver that binds to the
>     PMU hardware to prevent it being used because I think the main arm PMU
>     driver has suppress_bind_attrs = true.  Maybe we can make remove work?
>     (original patch for this in 2018 added that line because of a crash on remove
>      - not sure anyone looked at fixing the crash).
We still prefer to keep at least part of ARM PMU counters in service 
while running PMCU
in some scenarios. Unbinding the ARM PMU driver would go against that.

Thanks!
Jie Zhan

>>> - Currently we reply on a sysfs file for users to input event numbers. Is
>>>     there a better way to pass many events?
>>>
>>>     The perf framework only allows three 64-bit config fields for custom PMU
>>>     configs. Obviously, this can't satisfy our need for passing many events
>>>     at a time. As an event number is 16-bit wide, the config fields can only
>>>     take up to 12 events at a time, or up to 192 events even if we do a
>>>     bitmap of events (and there are more than 192 available event numbers).
>>>     Hence, the current design takes an array of event numbers from a sysfs
>>>     file before starting profiling. However, this may go against the common
>>>     way to schedule perf events through perf commands.
>>>
>>> Jie Zhan (4):
>>>     docs: perf: Add documentation for HiSilicon PMCU
>>>     drivers/perf: hisi: Add driver support for HiSilicon PMCU
>>>     perf tool: Add HiSilicon PMCU data recording support
>>>     perf tool: Add HiSilicon PMCU data decoding support
>>>
>>>    Documentation/admin-guide/perf/hisi-pmcu.rst |  183 +++
>>>    Documentation/admin-guide/perf/index.rst     |    1 +
>>>    drivers/perf/hisilicon/Kconfig               |   15 +
>>>    drivers/perf/hisilicon/Makefile              |    1 +
>>>    drivers/perf/hisilicon/hisi_pmcu.c           | 1096 ++++++++++++++++++
>>>    tools/perf/arch/arm/util/auxtrace.c          |   61 +
>>>    tools/perf/arch/arm64/util/Build             |    2 +-
>>>    tools/perf/arch/arm64/util/hisi-pmcu.c       |  145 +++
>>>    tools/perf/util/Build                        |    1 +
>>>    tools/perf/util/auxtrace.c                   |    4 +
>>>    tools/perf/util/auxtrace.h                   |    1 +
>>>    tools/perf/util/hisi-pmcu.c                  |  305 +++++
>>>    tools/perf/util/hisi-pmcu.h                  |   19 +
>>>    13 files changed, 1833 insertions(+), 1 deletion(-)
>>>    create mode 100644 Documentation/admin-guide/perf/hisi-pmcu.rst
>>>    create mode 100644 drivers/perf/hisilicon/hisi_pmcu.c
>>>    create mode 100644 tools/perf/arch/arm64/util/hisi-pmcu.c
>>>    create mode 100644 tools/perf/util/hisi-pmcu.c
>>>    create mode 100644 tools/perf/util/hisi-pmcu.h
>>>
>>>
>>> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476

