Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D46231F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKISC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKISCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:02:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF1B61F638
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:59:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C772C1FB;
        Wed,  9 Nov 2022 09:59:32 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790773F703;
        Wed,  9 Nov 2022 09:59:25 -0800 (PST)
Message-ID: <8325a442-92c1-4170-1862-3bc891a8d6af@arm.com>
Date:   Wed, 9 Nov 2022 17:59:03 +0000
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
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

Hi Reinette,

On 08/11/2022 21:28, Reinette Chatre wrote:
> On 11/3/2022 10:06 AM, James Morse wrote:
>> (I've not got to the last message in this part of the thread yes - I'm out of time this
>> week, back Monday!)
>>
>> On 21/10/2022 21:09, Reinette Chatre wrote:
>>> On 10/19/2022 6:57 AM, James Morse wrote:
>>>> On 17/10/2022 11:15, Peter Newman wrote:
>>>>> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
> 
> ...
> 
>>>>> If there are a lot more PARTIDs than PMGs, then it would fit well with a
>>>>> user who never creates child MON groups. In case the number of MON
>>>>> groups gets ahead of the number of CTRL_MON groups and you've run out of
>>>>> PMGs, perhaps you would just try to allocate another PARTID and program
>>>>> the same partitioning configuration before giving up.
>>>>
>>>> User-space can choose to do this.
>>>> If the kernel tries to be clever and do this behind user-space's back, it needs to
>>>> allocate two monitors for this secretly-two-control-groups, and always sum the counters
>>>> before reporting them to user-space.
>>
>>> If I understand this scenario correctly, the kernel is already doing this.
>>> As implemented in mon_event_count() the monitor data of a CTRL_MON group is
>>> the sum of the parent CTRL_MON group and all its child MON groups.
>>
>> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
>> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
>> then MPAM can export the counter files in the same way RDT does.
>>
>> While there are systems that have enough monitors, I don't think this is going to be the
>> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
>> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)

> This sounds related to the way monitoring was done in earlier kernels. This was
> long before I become involved with this work. Unfortunately I am not familiar with
> all the history involved that ended in it being removed from the kernel.

Yup, I'm aware there is some history to this. It's not appropriate for the llc_occupancy
counter as that reports state, instead of events.


> Looks like
> this was around v4.6, here is a sample commit that may help point to what was done:
> 
> commit 33c3cc7acfd95968d74247f1a4e1b0727a07ed43
> Author: Vikas Shivappa <vikas.shivappa@linux.intel.com>
> Date:   Thu Mar 10 15:32:09 2016 -0800
> 
>     perf/x86/mbm: Add Intel Memory B/W Monitoring enumeration and init
> 
> 
> Looking at some history there even seems to have been some work surrounding
> "rotating" of RMIDs that seem related to what you mention above:
> 
> commit bff671dba7981195a644a5dc210d65de8ae2d251
> Author: Matt Fleming <matt.fleming@intel.com>
> Date:   Fri Jan 23 18:45:47 2015 +0000
> 
>     perf/x86/intel: Perform rotation on Intel CQM RMIDs
> 
>     There are many use cases where people will want to monitor more tasks
>     than there exist RMIDs in the hardware, meaning that we have to perform
>     some kind of multiplexing.
> ...
> 

Thanks - this one was new. (I can't see how that would work reliably!)

The perf stuff is a way off, but it is an influence on how some of the MPAM monitoring
stuff has been done.

Initial support will only be for systems that have enough hardware monitors for each
control/monitor group to have one. This is the simplest to support in software, but is
costly for the hardware.


>> The problem is moving a group of tasks around N groups requires N monitors to be
>> allocated, and stay allocated until those groups pass through limbo. The perf stuff can't
>> allocate more monitors once its started.
>>
>> Even without perf, the only thing that limits the list of other counters that have to be
>> read is the number of PARTID*PMG. It doesn't look like a very sensible design.
>>
>>
>>>> If monitors are a contended resource, then you may be unable to monitor the
>>>> secretly-two-control-groups group once the kernel has done this.
>>>
>>> I am not viewing this as "secretly-two-control-groups" - there would still be
>>> only one parent CTRL_MON group that dictates all the allocations. MON groups already
>>> have a CLOSID (PARTID) property but at this time it is always identical to the parent
>>> CTRL_MON group. The difference introduced is that some of the child MON groups
>>> may have a different CLOSID (PARTID) from the parent.
>>>
>>>>
>>>> I don't think the kernel should try to be too clever here.
>>
>>> That is a fair concern but it may be worth exploring as it seems to address
>>> a few ABI concerns and user space seems to be eyeing using a future "num_closid"
>>> info as a check of "RDT/PQoS" vs "MPAM".
>>
>> I think the solution to all this is:
>>  * Add rename support to move a monitor group between two control groups.
>>  ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
>> unaffected.
>>  ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
>> continue to count.

> This looks like the solution to me also.

Great. I've had a stab at implementing it so we can have a more concrete discussion.


> The details of the arm64 support is not clear to me though. The destination
> group may not have enough PMG to host the new group so failures need to be
> handled.

> As you mention also, the old counters will continue to count.
> I assume that you mean the hardware will still have a record of the occupancy
> and that needs some time to dissipate?

Yes,


> I assume this would fall under the
> limbo handling so in some scenarios (for example the just moved monitor
> group used the last PMG) it may take some time for the source control
> group to allow a new monitor group?

Yup!


> The new counters will also not reflect the task's history.

Indeed. I anticipate user-space is sampling this file periodically, otherwise it can't
calculate a MB/s from the raw byte-count. I don't think losing the history is problem.

The state before the change being lost could be a problem, but this is a difference with
the way MPAM works. I think its best to just expose this property to user-space, as I
don't think its feasible to work around.

User-space would probably ignore the counter for a period of time after the move, as
depending on where the regulation is happening, it may take a little while for the CLOSID
change to take effect.


> Moving an arm64  monitor group may thus have a few surprises for user
> space while sounding complex to support. Would adding all this additional
> support be worth it if the guidance to user space is to instead create many
> control groups in such a control-group-rich environment?

I'd prefer it didn't exist at all, but if there are reasons to support it on x86, I'd like
the MPAM support to be as similar as possible. I'm willing to accept (advertised!) noise
in the counters, but a whole missing syscall is a harder sell.


>> Whether this old counters keep counting needs exposing to user-space so that it is aware.
> 
> Could you please elaborate? Do old counters not always keep counting?

Its not new - but the expectation is the mv/rename support does this atomically without
glitching/resetting the counters. Because of that new expectation, I think it needs
exposing to user-space.

Something should be indicated to user-space so it knows it can move monitor groups around,
otherwise its another 'try it and see'.


>> To solve Peter's use-case, we also need:
>>  * to expose how many new groups can be created at each level.
>>    This is because MPAM doesn't have a property like num_rmid.

> Unfortunately num_rmid is part of the user space interface. While MPAM
> does not have "RMIDs" it seems that num_rmid can still be relevant
> based on what it is described to represent in Documentation/x86/resctrl.rst:
> "This is the upper bound for how many "CTRL_MON" + "MON" groups can
> be created." 

I agree it can't be removed, and MPAM systems will need to put a value there.
The problem is 'rmid' has a well known definition, even if the kernel documentation is
nuanced.

This might be contentious, but ideally I'd 'deprecate' num_rmid, and split it into two
properties that don't reference an architecture. (Obviously the files have to stay for at
least the next 10 years!)


>> Combined, these should solve the cases Peter describes. User-space can determine if the
>> platform is control-group-rich or monitor-group-rich, and build the corresponding
>> structure to make best use of the resources.
> 
> Sounds good to me.


Thanks,

James
