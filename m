Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ADC6048EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiJSORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiJSORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:17:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21C95DEF27
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:59:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EDAF1424;
        Wed, 19 Oct 2022 06:58:34 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 788CB3F7D8;
        Wed, 19 Oct 2022 06:58:26 -0700 (PDT)
Message-ID: <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
Date:   Wed, 19 Oct 2022 14:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 17/10/2022 11:15, Peter Newman wrote:
> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
>> You originally asked:
>> | Any concerns about the CLOSID-reusing behavior?
>>
>> I don't think this will work well with MPAM ... I expect it will mess up the bandwidth
>> counters.
>>
>> MPAM's equivalent to RMID is PMG. While on x86 CLOSID and RMID are independent numbers,
>> this isn't true for PARTID (MPAM's version of CLOSID) and PMG. The PMG bits effectively
>> extended the PARTID with bits that aren't used to look up the configuration.
>>
>> x86's monitors match only on RMID, and there are 'enough' RMID... MPAMs monitors are more
>> complicated. I've seen details of a system that only has 1 bit of PMG space.
>>
>> While MPAM's bandwidth monitors can match just the PMG, there aren't expected to be enough
>> unique PMG for every control/monitor group to have a unique value. Instead, MPAM's
>> monitors are expected to be used with both the PARTID and PMG.
>>
>> ('bandwidth monitors' is relevant here, MPAM's 'cache storage utilisation' monitors can't
>> match on just PMG at all - they have to be told the PARTID too)
>>
>>
>> If you're re-using CLOSID like this, I think you'll end up with noisy measurements on MPAM
>> systems as the caches hold PARTID/PMG values from before the re-use pattern changed, and
>> the monitors have to match on both.

> Yes, that sounds like it would be an issue.
> 
> Following your refactoring changes, hopefully the MPAM driver could
> offer alternative methods for managing PARTIDs and PMGs depending on the
> available hardware resources.

Mmmm, I don't think anything other than one-partid per control group and one-pmg per
monitor group makes much sense.


> If there are a lot more PARTIDs than PMGs, then it would fit well with a
> user who never creates child MON groups. In case the number of MON
> groups gets ahead of the number of CTRL_MON groups and you've run out of
> PMGs, perhaps you would just try to allocate another PARTID and program
> the same partitioning configuration before giving up.

User-space can choose to do this.
If the kernel tries to be clever and do this behind user-space's back, it needs to
allocate two monitors for this secretly-two-control-groups, and always sum the counters
before reporting them to user-space.
If monitors are a contended resource, then you may be unable to monitor the
secretly-two-control-groups group once the kernel has done this.

I don't think the kernel should try to be too clever here.

> Of course, there
> wouldn't be much point in reusing PARTIDs in such a configuration
> either.

> If we used the child MON groups as the primary vehicle for moving a
> container's tasks between a small number of CTRL_MON groups like in
> Reinette's proposal, then it seems like it would be a better use of
> hardware to have many PMGs and few PARTIDs.

> In that case, the monitors would only match on PMGs.

This isn't how MPAM is designed to be used. You'll hit nasty corners.
The big one is the Cache Storage Utilisation counters.

See 11.5.2 of the MPAM spec, "MSMON_CFG_CSU_CTL, MPAM Memory System Monitor Configure
Cache Storage Usage Monitor Control Register". Not setting the MATCH_PARTID bit has this
warning:
| If MATCH_PMG is 1 and MATCH_PARTID is 0, it is CONSTRAINED UNPREDICTABLE whether the
| monitor instance:
| • Measures the storage used with matching PMG and with any PARTID.
| • Measures no storage usage, that is, MSMON_CSU.VALUE is zero.
| • Measures the storage used with matching PMG and PARTID, that is, treats
| MATCH_PARTID as = 1

'constrained unpredictable' is arm's term for "portable software can't rely on this".
The folk that designed MPAM don't believe "monitors would only match on PMGs" makes any
sense. A PMG is not an RMID. A case in point is the system with only 1 PMG bit.

I'm afraid this approach would preclude support for the llc_occupancy counter, and would
artificially reduce the number of control groups that can be created as each control group
needs an 'RMID'. On the machine with 1 PMG bit - you get 2 control groups, even though it
has many more PARTID.


> Provided that there are sufficient monitor
> instances, there would never be any need to reprogram a monitor's
> PMG.

It sounds like this moves the problem to "make everything a monitor group because only
monitor groups can be batch moved".

If the tasks file could be moved between control and monitor groups, causing resctrl to
relabel the tasks - would that solve more of the problem? (it eliminates the need to make
everything a monitor group)

The devil is in the detail, I'm not sure how it serialises with a fork()ing process, I'd
hope to do better than relying on the kernel walking the list of processes a lot quicker
than user-space can.


>> I have half-finished patches that add a 'resctrl' cgroup controller that can be used to
>> group tasks and assign them to control or monitor groups. (the creation and configuration
>> of control and monitor groups stays in resctrl - it effectively makes the tasks file
>> read-only). I think this might help, as a group of processes can be moved between two
>> control/monitor groups with one syscall. New processes that are created inherit from the
>> cgroup setting instead of their parent task.
>>
>> If want to take a look, its here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.0&id=4e5987d8ecbc8647dee0aebfb73c3890843ef5dd
> 
>> I've not worked the cgroup thread stuff out yet ... it doesn't appear to hook thread
>> creation, only fork().

> This looks very promising for our use case, as it would be very easy to
> use for a container manager. I'm glad you're looking into this.

Let me know if it solves this problem - I assume the resctrl topology is a subset of the
cgroup topology.

(apparently android needed cgroup support, but now its more complicated)


Thanks,

James
