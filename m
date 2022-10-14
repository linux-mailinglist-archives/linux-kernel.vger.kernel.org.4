Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06C5FEE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJNM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:56:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A67EE9862
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:56:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D54713D5;
        Fri, 14 Oct 2022 05:56:59 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024163F792;
        Fri, 14 Oct 2022 05:56:51 -0700 (PDT)
Message-ID: <830cc435-b197-4fb2-0666-771ceaf6cfad@arm.com>
Date:   Fri, 14 Oct 2022 13:56:46 +0100
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/10/2022 18:23, Reinette Chatre wrote:
> On 10/12/2022 4:21 AM, Peter Newman wrote:
>> On Tue, Oct 11, 2022 at 1:35 AM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> On 10/7/2022 10:28 AM, Tony Luck wrote:
>>>> I don't know how complex it would for the kernel to implement this. Or
>>>> whether it would meet Google's needs.
>>>>
>>>
>>> How about moving monitor groups from one control group to another?
>>>
>>> Based on the initial description I got the impression that there is
>>> already a monitor group for every container. (Please correct me if I am
>>> wrong). If this is the case then it may be possible to create an interface
>>> that could move an entire monitor group to another control group. This would
>>> keep the benefit of usage counts remaining intact, tasks get a new closid, but
>>> keep their rmid. There would be no need for the user to specify process-ids.
>>
>> Yes, Stephane also pointed out the importance of maintaining RMID assignments
>> as well and I don't believe I put enough emphasis on it during my
>> original email.
>>
>> We need to maintain accurate memory bandwidth usage counts on all
>> containers, so it's important to be able to maintain an RMID assignment
>> and its event counts across a CoS downgrade. The solutions Tony
>> suggested do solve the races in moving the tasks, but the container
>> would need to temporarily join the default MON group in the new CTRL_MON
>> group before it can be moved to its replacement MON group.
>>
>> Being able to re-parent a MON group would allow us to change the CLOSID
>> independently of the RMID in a container and would address the issue.

> What if resctrl adds support to rdtgroup_kf_syscall_ops for
> the .rename callback?
> 
> It seems like doing so could enable users to do something like:
> mv /sys/fs/resctrl/groupA/mon_groups/containerA /sys/fs/resctrl/groupB/mon_groups/
> 
> Such a user request would trigger the "containerA" monitor group
> to be moved to another control group. All tasks within it could be moved to
> the new control group (their CLOSIDs are changed) while their RMIDs
> remain intact.
> 
> I just read James's response and I do not know how this could be made to
> work with the Arm monitoring when it arrives. Potentially there
> could be an architecture specific "move monitor group" call.

If its just moving tasks between groups - this should be fine. You'll get some noise, but
this already exists. User-space should understand that what it is monitoring has changed
in this case.

My comments were about having the kernel transparently change the closid in response to a
schema change. This is where user-space can't know that it is now monitoring something
else. (maybe I should have replied to the top of the thread).



Thanks,

James
