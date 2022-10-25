Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A028660D112
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiJYP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiJYP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:56:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9882E17F283
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:56:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41E7CD6E;
        Tue, 25 Oct 2022 08:56:15 -0700 (PDT)
Received: from [10.1.197.78] (unknown [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D7D3F71A;
        Tue, 25 Oct 2022 08:56:07 -0700 (PDT)
Message-ID: <384cd4c1-8b8f-93f8-1756-6e5ccf1752f5@arm.com>
Date:   Tue, 25 Oct 2022 16:56:01 +0100
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
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
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

On 20/10/2022 11:39, Peter Newman wrote:
> On Wed, Oct 19, 2022 at 3:58 PM James Morse <james.morse@arm.com> wrote:
>> This isn't how MPAM is designed to be used. You'll hit nasty corners.
>> The big one is the Cache Storage Utilisation counters.
>>
>> See 11.5.2 of the MPAM spec, "MSMON_CFG_CSU_CTL, MPAM Memory System Monitor Configure
>> Cache Storage Usage Monitor Control Register". Not setting the MATCH_PARTID bit has this
>> warning:
>> | If MATCH_PMG is 1 and MATCH_PARTID is 0, it is CONSTRAINED UNPREDICTABLE whether the
>> | monitor instance:
>> | • Measures the storage used with matching PMG and with any PARTID.
>> | • Measures no storage usage, that is, MSMON_CSU.VALUE is zero.
>> | • Measures the storage used with matching PMG and PARTID, that is, treats
>> | MATCH_PARTID as = 1
>>
>> 'constrained unpredictable' is arm's term for "portable software can't rely on this".
>> The folk that designed MPAM don't believe "monitors would only match on PMGs" makes any
>> sense. A PMG is not an RMID. A case in point is the system with only 1 PMG bit.
>>
>> I'm afraid this approach would preclude support for the llc_occupancy counter, and would
>> artificially reduce the number of control groups that can be created as each control group
>> needs an 'RMID'. On the machine with 1 PMG bit - you get 2 control groups, even though it
>> has many more PARTID.
> 
> The first sentence of the Resource Monitoring chapter is also quite an
> obstacle to my challenging to the PARTID-PMG hierarchy:
> 
> | Software environments may be labeled as belonging to a Performance
> | Monitoring Group (PMG) within a partition.
> 
> It seems like the only real issue is that the user is responsible for
> figuring out how best to make use of the available resources. But I seem
> to recall that was the expectation with resctrl, so I should probably
> stop trying to argue for expecting MPAM configurations which resemble
> RDT.
> 
> 
>> On 17/10/2022 11:15, Peter Newman wrote:
>>> Provided that there are sufficient monitor
>>> instances, there would never be any need to reprogram a monitor's
>>> PMG.
>>
>> It sounds like this moves the problem to "make everything a monitor group because only
>> monitor groups can be batch moved".
>>
>> If the tasks file could be moved between control and monitor groups, causing resctrl to
>> relabel the tasks - would that solve more of the problem? (it eliminates the need to make
>> everything a monitor group)
> 
> This was about preserving the RMID and memory bandwidth counts across a
> CLOSID change. If the user is forced to conserve CTRL_MON groups due to
> a limited number of CLOSIDs, keeping the various containers' tasks
> separate is also a concern.

Ah, of course.


> But if there's no need to conserve CTRL_MON groups, then there's no real
> issue.

Yup. I think part of this is exposing the information user-space needs to make the right
decision.

I don't think we should merge 'task group moving' and 'old monitors keep counting', they
each make sense independently.


>> The devil is in the detail, I'm not sure how it serialises with a fork()ing process, I'd
>> hope to do better than relying on the kernel walking the list of processes a lot quicker
>> than user-space can.
> 
> I wasn't planning to do it any more optimally than the rmdir
> implementation today when looking for all tasks impacted by a
> CLOSID/RMID deletion.

Aha - that is the use of for_each_process_thread() which takes the read-lock, instead of
relying on RCU, so it should be safe for processes fork()ing and exit()ing.


Thanks,

James
