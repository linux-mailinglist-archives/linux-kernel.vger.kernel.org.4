Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC13626180
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiKKSir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiKKSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:38:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5ABF8293C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:36:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F621FB;
        Fri, 11 Nov 2022 10:36:58 -0800 (PST)
Received: from [10.1.197.38] (unknown [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBDE03F703;
        Fri, 11 Nov 2022 10:36:50 -0800 (PST)
Message-ID: <ed63ba30-2d7f-e1dd-4019-bc7441086dbb@arm.com>
Date:   Fri, 11 Nov 2022 18:36:44 +0000
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
 <8325a442-92c1-4170-1862-3bc891a8d6af@arm.com>
 <eb1a0949-dbd0-482f-d19a-738cf8842b96@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <eb1a0949-dbd0-482f-d19a-738cf8842b96@intel.com>
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

On 09/11/2022 19:12, Reinette Chatre wrote:
> On 11/9/2022 9:59 AM, James Morse wrote:
>> On 08/11/2022 21:28, Reinette Chatre wrote:
>>> On 11/3/2022 10:06 AM, James Morse wrote:
>>>> (I've not got to the last message in this part of the thread yes - I'm out of time this
>>>> week, back Monday!)
>>>>
>>>> On 21/10/2022 21:09, Reinette Chatre wrote:
>>>>> On 10/19/2022 6:57 AM, James Morse wrote:
>>>>>> On 17/10/2022 11:15, Peter Newman wrote:
>>>>>>> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
>>>
>>> ...
>>>
>>>>>>> If there are a lot more PARTIDs than PMGs, then it would fit well with a
>>>>>>> user who never creates child MON groups. In case the number of MON
>>>>>>> groups gets ahead of the number of CTRL_MON groups and you've run out of
>>>>>>> PMGs, perhaps you would just try to allocate another PARTID and program
>>>>>>> the same partitioning configuration before giving up.
>>>>>>
>>>>>> User-space can choose to do this.
>>>>>> If the kernel tries to be clever and do this behind user-space's back, it needs to
>>>>>> allocate two monitors for this secretly-two-control-groups, and always sum the counters
>>>>>> before reporting them to user-space.
>>>>
>>>>> If I understand this scenario correctly, the kernel is already doing this.
>>>>> As implemented in mon_event_count() the monitor data of a CTRL_MON group is
>>>>> the sum of the parent CTRL_MON group and all its child MON groups.
>>>>
>>>> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
>>>> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
>>>> then MPAM can export the counter files in the same way RDT does.
>>>>
>>>> While there are systems that have enough monitors, I don't think this is going to be the
>>>> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
>>>> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)
>>
>>> This sounds related to the way monitoring was done in earlier kernels. This was
>>> long before I become involved with this work. Unfortunately I am not familiar with
>>> all the history involved that ended in it being removed from the kernel.
>>
>> Yup, I'm aware there is some history to this. It's not appropriate for the llc_occupancy
>> counter as that reports state, instead of events.

> Perf counts events while a process is running

It's hooked up as an uncore PMU driver and it rejects attempts to attach it to a task.
Some useful background is it has to be told which of the existing resctrl control/monitor
groups to monitor. On x86 its just returning the the increase in events from the mbm files
in resctrl via resctrl_arch_rmid_read().
Unless you're curious [0], the details can come if/when I post it!


> so memory bandwidth monitoring may
> also be impacted by the caveats Peter mentioned for the upcoming AMD changes:
> 
> https://lore.kernel.org/lkml/CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com/
> ("This has the caveats that evictions while one task is running could have
> resulted from a previous task on the current CPU, but will be counted
> against the new task's software-RMID, ...")

If the logic to implement that is hidden entirely behind resctrl_arch_rmid_read(), then
there should be no problem. (the values will be noisy, but that is the best that can be
done on that platform)


Thanks,

James

[0] Beware, the changes to x86 to make resctrl_arch_rmid_read() irq safe aren't quite right.
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.0&id=b8ae575bd17e1d56db0f84dc456b964a23d252d6
