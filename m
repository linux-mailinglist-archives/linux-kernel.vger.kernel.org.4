Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C375FC991
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJLQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJLQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:55:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 316D2DED0F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:55:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28771165C;
        Wed, 12 Oct 2022 09:55:54 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D03A3F766;
        Wed, 12 Oct 2022 09:55:46 -0700 (PDT)
Message-ID: <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
Date:   Wed, 12 Oct 2022 17:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 12/10/2022 12:21, Peter Newman wrote:
> On Tue, Oct 11, 2022 at 1:35 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 10/7/2022 10:28 AM, Tony Luck wrote:
>>> I don't know how complex it would for the kernel to implement this. Or
>>> whether it would meet Google's needs.
>>>
>>
>> How about moving monitor groups from one control group to another?
>>
>> Based on the initial description I got the impression that there is
>> already a monitor group for every container. (Please correct me if I am
>> wrong). If this is the case then it may be possible to create an interface
>> that could move an entire monitor group to another control group. This would
>> keep the benefit of usage counts remaining intact, tasks get a new closid, but
>> keep their rmid. There would be no need for the user to specify process-ids.

> Yes, Stephane also pointed out the importance of maintaining RMID assignments
> as well and I don't believe I put enough emphasis on it during my
> original email.
> 
> We need to maintain accurate memory bandwidth usage counts on all
> containers, so it's important to be able to maintain an RMID assignment
> and its event counts across a CoS downgrade. The solutions Tony
> suggested do solve the races in moving the tasks, but the container
> would need to temporarily join the default MON group in the new CTRL_MON
> group before it can be moved to its replacement MON group.
> 
> Being able to re-parent a MON group would allow us to change the CLOSID
> independently of the RMID in a container and would address the issue.
> 
> The only other point I can think of to differentiate it from the
> automatic CLOSID management solution is whether the 1:1 CTRL_MON:CLOSID
> approach will become too limiting going forward. For example, if there
> are configurations where one resource has far fewer CLOSIDs than others
> and we want to start assigning CLOSIDs on-demand, per-resource to avoid
> wasting other resources' available CLOSID spaces. If we can foresee this
> becoming a concern, then automatic CLOSID management would be
> inevitable.

You originally asked:
| Any concerns about the CLOSID-reusing behavior?

I don't think this will work well with MPAM ... I expect it will mess up the bandwidth
counters.

MPAM's equivalent to RMID is PMG. While on x86 CLOSID and RMID are independent numbers,
this isn't true for PARTID (MPAM's version of CLOSID) and PMG. The PMG bits effectively
extended the PARTID with bits that aren't used to look up the configuration.

x86's monitors match only on RMID, and there are 'enough' RMID... MPAMs monitors are more
complicated. I've seen details of a system that only has 1 bit of PMG space.

While MPAM's bandwidth monitors can match just the PMG, there aren't expected to be enough
unique PMG for every control/monitor group to have a unique value. Instead, MPAM's
monitors are expected to be used with both the PARTID and PMG.

('bandwidth monitors' is relevant here, MPAM's 'cache storage utilisation' monitors can't
match on just PMG at all - they have to be told the PARTID too)


If you're re-using CLOSID like this, I think you'll end up with noisy measurements on MPAM
systems as the caches hold PARTID/PMG values from before the re-use pattern changed, and
the monitors have to match on both.


I have half-finished patches that add a 'resctrl' cgroup controller that can be used to
group tasks and assign them to control or monitor groups. (the creation and configuration
of control and monitor groups stays in resctrl - it effectively makes the tasks file
read-only). I think this might help, as a group of processes can be moved between two
control/monitor groups with one syscall. New processes that are created inherit from the
cgroup setting instead of their parent task.

If want to take a look, its here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.0&id=4e5987d8ecbc8647dee0aebfb73c3890843ef5dd

I've not worked the cgroup thread stuff out yet ... it doesn't appear to hook thread
creation, only fork().


Thanks,

James

