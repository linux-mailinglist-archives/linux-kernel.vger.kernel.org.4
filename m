Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787C60D111
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiJYP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiJYP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:56:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F288172B62
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:56:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40CC4ED1;
        Tue, 25 Oct 2022 08:56:06 -0700 (PDT)
Received: from [10.1.197.78] (unknown [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646853F71A;
        Tue, 25 Oct 2022 08:55:58 -0700 (PDT)
Message-ID: <a4def722-aa98-6bf9-6e77-65a9fd9bd8ca@arm.com>
Date:   Tue, 25 Oct 2022 16:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
 <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
 <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
 <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
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

On 20/10/2022 20:08, Reinette Chatre wrote:
> On 10/20/2022 1:48 AM, Peter Newman wrote:
>> On Thu, Oct 20, 2022 at 1:54 AM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>> It is still not clear to me how palatable this will be on Arm systems.
>>> This solution also involves changing the CLOSID/PARTID like your original
>>> proposal and James highlighted that it would "mess up the bandwidth counters"
>>> because of the way PARTID.PMG is used for monitoring. Perhaps even a new
>>> PMG would need to be assigned during such a monitor group move. One requirement
>>> for this RFD was to keep usage counts intact and from what I understand
>>> this will not be possible on Arm systems.  There could be software mechanisms
>>> to help reduce the noise during the transition. For example, some new limbo
>>> mechanism that avoids re-assigning the old PARTID.PMG, while perhaps still
>>> using the old PARTID.PMG to read usage counts for a while? Or would the
>>> guidance just be that the counters will have some noise after the move?
>>
>> I'm going to have to follow up on the details of this in James's thread.
>> It sounded like we probably won't be able to create enough mon_groups
>> under a single control group for the rename feature to even be useful.
>> Rather, we expect the PARTID counts to be so much larger than the PMG
>> counts that creating more mon_groups to reduce the number of control
>> groups wouldn't make sense.
>>
>> At least in our use case, we're literally creating "classes of service"
>> to prioritize memory traffic, so we want a small number of control
>> groups to represent the small number of priority levels, but enough
>> RMIDs to count every job's traffic independently. For MPAM to support
>> this MBM/MBA use case in exactly this fashion, we'd have to develop the
>> monitors-not-matching-on-PARTID use case better in the MPAM
>> architecture. But before putting much effort into that, I'd want to know
>> if there's any payoff beyond being able to use resctrl the same way on
>> both implementations.

> If the expectation is that PARTID counts are very high then how about
> a solution where multiple PARTIDs are associated with the same CTRL_MON group?
> A CTRL_MON group presents a resource allocation to user space, CLOSIDs/PARTIDs
> are not exposed. So using multiple PARTIDs for a resource group (all with the
> same allocation) seems conceptually ok to me. (Please note, I did not do an
> audit to see if there are any hidden assumption or look into lifting required
> to support his.)

This would work when systems are built to look like RDT, but MPAM has other control types
where this would have interesting behaviours.

'CPOR' is equivalent to CBM as they are both a bitmap of portions. MPAM also has 'CMAX'
where a fraction of the cache is specified. If you create two control groups with
different PARTIDs but the same configuration, their two 50%s of the cache could become
100%. CPOR can be used like this, CMAX can't.


> So, if a user moves a MON group to a new CTRL_MON group, if there are no
> PARTID.PMG available in the destination CTRL_MON group to support the move
> then one of the free PARTID can be used, automatically assigned with the
> allocation of the destination CTRL_MON, and a new monitor group created using
> the new PMG range brought with the new PARTID.

This would be transparent on some hardware, but not on others. It depends what controls
are supported.

Even when the controls behave in the same way, a different PARTID with the same control
values could be regulated differently, resulting in weirdness.


> There may also be a way to guide resctrl to do something like this (use
> available PARTID) when a user creates a new MON group. This may be a way
> to address the earlier concern of how applications can decide to create
> lots of MON groups vs CTRL_MON groups.

I think we should keep this intelligence in user-space.

Exposing a way to indicate how many groups can be created 'at this level', allows
user-space to determine if its on an RMID-rich machine or a PARTID-rich machine.
If there is a way of moving a group of tasks between control groups, then we'd also need
to expose some indication as to whether the monitors at the old location keep counting
after the move. (which I think is the best way of explaining the difference to user-space)

With these, user-space can change the structure it creates to better fit the resources of
the machine.


Thanks,

James
