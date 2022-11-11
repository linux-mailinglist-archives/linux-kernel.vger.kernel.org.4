Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C7626183
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiKKSky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiKKSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:40:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A14DD8BA82
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:38:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E891FB;
        Fri, 11 Nov 2022 10:38:15 -0800 (PST)
Received: from [10.1.197.38] (unknown [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8143F703;
        Fri, 11 Nov 2022 10:38:07 -0800 (PST)
Message-ID: <39fe80dc-713d-9ed2-a5aa-5c84376917f3@arm.com>
Date:   Fri, 11 Nov 2022 18:38:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
 <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
 <CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com>
 <bd52ec90-52e4-32c5-132a-5d82304650a4@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <bd52ec90-52e4-32c5-132a-5d82304650a4@intel.com>
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

Hi Reinette, Peter,

On 09/11/2022 19:11, Reinette Chatre wrote:
> On 11/9/2022 1:50 AM, Peter Newman wrote:
>> On Tue, Nov 8, 2022 at 10:28 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>> On 11/3/2022 10:06 AM, James Morse wrote:
>>>> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
>>>> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
>>>> then MPAM can export the counter files in the same way RDT does.
>>>>
>>>> While there are systems that have enough monitors, I don't think this is going to be the
>>>> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
>>>> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)
>>>
>>> This sounds related to the way monitoring was done in earlier kernels. This was
>>> long before I become involved with this work. Unfortunately I am not familiar with
>>> all the history involved that ended in it being removed from the kernel. Looks like
>>> this was around v4.6, here is a sample commit that may help point to what was done:
>>
>> Sort of related, this is a problem we have to work around on AMD
>> implementations that I will be sharing a patch for soon.
>>
>> Note the second paragraph at the top of page 13:
>>
>> https://developer.amd.com/wp-content/resources/56375_1.00.pdf

>> AMD QoS often provides less counters than RMIDs, but the architecture
>> promises there will be at least as many counters in a QoS domain as
>> CPUs.

How do you know which RMIDs the hardware is tracking?

This reads like the counters are unreliable unless the task is running, and even then they
might lose values when the task is switched out.


>> Using this we can permanently pin RMIDs to CPUs and read the
>> counters on every task switch to implement MBM RMIDs in software.

>> This has the caveats that evictions while one task is running could have
>> resulted from a previous task on the current CPU, but will be counted
>> against the new task's software-RMID, and that CMT doesn't work.

(Sounds like the best thing to do in a bad situation)


>> I will propose making this available as a mount option for cloud container
>> use cases which need to monitor a large number of tasks on B/W counter-poor
>> systems, and of course don't need CMT.

Why does it need to be a mount option?

If this is the only way of using the counters on this platform, then the skid from the
counters is just a property of the platform. It can be advertised to user-space via some
file in 'info'.

Architecture specific mount options are a bad idea, platform specific ones are even worse!


>>> [...]
>>>
>>>> I think the solution to all this is:
>>>>  * Add rename support to move a monitor group between two control groups.
>>>>  ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
>>>> unaffected.
>>>>  ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
>>>> continue to count.
>>>
>>> This looks like the solution to me also.
>>>
>>> The details of the arm64 support is not clear to me though. The destination
>>> group may not have enough PMG to host the new group so failures need to be
>>> handled. As you mention also, the old counters will continue to count.
>>> I assume that you mean the hardware will still have a record of the occupancy
>>> and that needs some time to dissipate? I assume this would fall under the
>>> limbo handling so in some scenarios (for example the just moved monitor
>>> group used the last PMG) it may take some time for the source control
>>> group to allow a new monitor group? The new counters will also not
>>> reflect the task's history.
>>>
>>> Moving an arm64  monitor group may thus have a few surprises for user
>>> space while sounding complex to support. Would adding all this additional
>>> support be worth it if the guidance to user space is to instead create many
>>> control groups in such a control-group-rich environment?
>>>
>>>> Whether this old counters keep counting needs exposing to user-space so that it is aware.
>>>
>>> Could you please elaborate? Do old counters not always keep counting?
>>
>> Based on this, is it even worth it to allocate PMGs given that the
>> systems James has seen so far only have a single PMG bit? All this will
>> get us is the ability to create a single child mon_group in each control
>> group. This seems too limiting for the feature to be useful.

It lets you exclude tasks, or only monitor a specific task. Its evidently enough for the
markets those parts are manufactured for!


> I'll mostly defer to James here. From my side I do not see motivation to
> not support environments in which only one monitor group can be created.
> My concern was the additional complexity involved to support
> "mv" of monitor groups in such a constrained environment but I understand
> from James (re. https://lore.kernel.org/lkml/8325a442-92c1-4170-1862-3bc891a8d6af@arm.com/)
> that it is worth it.

I'm strongly against having parts of this interface work differently on different
architectures or platforms. If it does, we may as well have completely different
interfaces as user-space has to be architecture/platform aware.

Its perfectly possible for the filesystem bits of resctrl to support renaming monitor
groups between control groups, with only a minimum of 'swap the RMID' that can be skipped
if an architecture doesn't support it.

'mv' should be supported on all architectures/platforms, and we should expose enough
information to user-space for it to work out if its going to build a control/monitor group
structure that relies on that.


Thanks,

James
