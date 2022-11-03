Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA086185C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKCRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiKCRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92146FE1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:06:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976351FB;
        Thu,  3 Nov 2022 10:06:40 -0700 (PDT)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D613F5A1;
        Thu,  3 Nov 2022 10:06:32 -0700 (PDT)
Message-ID: <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
Date:   Thu, 3 Nov 2022 17:06:25 +0000
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
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

(I've not got to the last message in this part of the thread yes - I'm out of time this
week, back Monday!)

On 21/10/2022 21:09, Reinette Chatre wrote:
> On 10/19/2022 6:57 AM, James Morse wrote:
>> On 17/10/2022 11:15, Peter Newman wrote:
>>> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
>>>> You originally asked:
>>>> | Any concerns about the CLOSID-reusing behavior?
>>>>
>>>> I don't think this will work well with MPAM ... I expect it will mess up the bandwidth
>>>> counters.
>>>>
>>>> MPAM's equivalent to RMID is PMG. While on x86 CLOSID and RMID are independent numbers,
>>>> this isn't true for PARTID (MPAM's version of CLOSID) and PMG. The PMG bits effectively
>>>> extended the PARTID with bits that aren't used to look up the configuration.
>>>>
>>>> x86's monitors match only on RMID, and there are 'enough' RMID... MPAMs monitors are more
>>>> complicated. I've seen details of a system that only has 1 bit of PMG space.
>>>>
>>>> While MPAM's bandwidth monitors can match just the PMG, there aren't expected to be enough
>>>> unique PMG for every control/monitor group to have a unique value. Instead, MPAM's
>>>> monitors are expected to be used with both the PARTID and PMG.
>>>>
>>>> ('bandwidth monitors' is relevant here, MPAM's 'cache storage utilisation' monitors can't
>>>> match on just PMG at all - they have to be told the PARTID too)
>>>>
>>>>
>>>> If you're re-using CLOSID like this, I think you'll end up with noisy measurements on MPAM
>>>> systems as the caches hold PARTID/PMG values from before the re-use pattern changed, and
>>>> the monitors have to match on both.
>>
>>> Yes, that sounds like it would be an issue.
>>>
>>> Following your refactoring changes, hopefully the MPAM driver could
>>> offer alternative methods for managing PARTIDs and PMGs depending on the
>>> available hardware resources.
>>
>> Mmmm, I don't think anything other than one-partid per control group and one-pmg per
>> monitor group makes much sense.
>>
>>
>>> If there are a lot more PARTIDs than PMGs, then it would fit well with a
>>> user who never creates child MON groups. In case the number of MON
>>> groups gets ahead of the number of CTRL_MON groups and you've run out of
>>> PMGs, perhaps you would just try to allocate another PARTID and program
>>> the same partitioning configuration before giving up.
>>
>> User-space can choose to do this.
>> If the kernel tries to be clever and do this behind user-space's back, it needs to
>> allocate two monitors for this secretly-two-control-groups, and always sum the counters
>> before reporting them to user-space.

> If I understand this scenario correctly, the kernel is already doing this.
> As implemented in mon_event_count() the monitor data of a CTRL_MON group is
> the sum of the parent CTRL_MON group and all its child MON groups.

That is true. MPAM has an additional headache here as it needs to allocate a monitor in
order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
then MPAM can export the counter files in the same way RDT does.

While there are systems that have enough monitors, I don't think this is going to be the
norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)

The problem is moving a group of tasks around N groups requires N monitors to be
allocated, and stay allocated until those groups pass through limbo. The perf stuff can't
allocate more monitors once its started.

Even without perf, the only thing that limits the list of other counters that have to be
read is the number of PARTID*PMG. It doesn't look like a very sensible design.


>> If monitors are a contended resource, then you may be unable to monitor the
>> secretly-two-control-groups group once the kernel has done this.
> 
> I am not viewing this as "secretly-two-control-groups" - there would still be
> only one parent CTRL_MON group that dictates all the allocations. MON groups already
> have a CLOSID (PARTID) property but at this time it is always identical to the parent
> CTRL_MON group. The difference introduced is that some of the child MON groups
> may have a different CLOSID (PARTID) from the parent.
> 
>>
>> I don't think the kernel should try to be too clever here.

> That is a fair concern but it may be worth exploring as it seems to address
> a few ABI concerns and user space seems to be eyeing using a future "num_closid"
> info as a check of "RDT/PQoS" vs "MPAM".

I think the solution to all this is:
 * Add rename support to move a monitor group between two control groups.
 ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
unaffected.
 ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
continue to count.

Whether this old counters keep counting needs exposing to user-space so that it is aware.

To solve Peter's use-case, we also need:
 * to expose how many new groups can be created at each level.
   This is because MPAM doesn't have a property like num_rmid.


Combined, these should solve the cases Peter describes. User-space can determine if the
platform is control-group-rich or monitor-group-rich, and build the corresponding
structure to make best use of the resources.


Thanks,

James
