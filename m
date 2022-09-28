Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416DA5EDE75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiI1OJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiI1OJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:09:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F9C9E0CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:09:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623971595;
        Wed, 28 Sep 2022 07:09:26 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52A833F73D;
        Wed, 28 Sep 2022 07:09:18 -0700 (PDT)
Message-ID: <6c99fe9e-4f7c-8a82-bf43-48449d553172@arm.com>
Date:   Wed, 28 Sep 2022 15:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] x86/resctrl: Clear the staged configs when destroying
 schemata list
Content-Language: en-GB
To:     Shawn Wang <shawnwang@linux.alibaba.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
 <80d6238b-223c-e60a-6930-24a981d9dd0c@arm.com>
 <2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com>
 <e9dc4d2a-e404-990a-3efc-c359799bc986@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <e9dc4d2a-e404-990a-3efc-c359799bc986@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 28/09/2022 14:37, Shawn Wang wrote:
> On 9/28/22 5:21 AM, Reinette Chatre wrote:
>> On 9/27/2022 6:06 AM, James Morse wrote:
>>> On 27/09/2022 03:54, Shawn Wang wrote:
>>>> Array staged_config in struct rdt_domain still maintains the original value when
>>>> resctrl is unmounted. If resctrl is mounted with cdp option and then remounted
>>>> without cdp option, field have_new_ctrl in staged_config[CDP_CODE] and
>>>> staged_config[CDP_DATA] will still be true.
>>>
>>> staged_config[CDP_DATA] is an array - its always 'true'. I think you mean
>>> staged_config[CDP_DATA].have_new_ctrl, which will still be true because it is only
>>> memset() when the schemata file is written to.
>>>
>>>
>>>> Since resctrl_arch_update_domains()
>>>> traverses all resctrl_conf_type, it will continue to update CDP_CODE and
>>>> CDP_DATA configurations, which can cause overflow problem.
>>>
>>> Only if its called with a stale staged config, and it should only be called when the
>>> schemata file is written to, which would memset() the staged config first.
>>>
>>>
>>>> The problem can be reproduced by the following commands:
>>>>      # A system with 16 usable closids and mba disabled
>>>>      mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>>>>      mkdir /sys/fs/resctrl/p{1..7}
>>>>      umount /sys/fs/resctrl/
>>>>      mount -t resctrl resctrl /sys/fs/resctrl
>>>>      mkdir /sys/fs/resctrl/p{1..8}
>>>
>>> Thanks for the reproducer - but I don't see what could set have_new_ctrl in this sequence.
>>> You can't call apply_config() to set CPUs in the mask without that being set.
>>>
>>> Creating a new control group, (your mkdir step) shouldn't touch the hardware at all, as it
>>> should be left in its reset state from the last umount(), or setup.
>>
>> There is an attempt to configure the hardware in the mkdir path:
>> rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
>>
>>
>> This is required in support of the different resource group modes. When a new
>> resource group is created via mkdir the configuration should respect any
>> exclusive resource groups that exist at that point.
>>
>>>
>>> I can't reproduce this on v6.0-rc7.
>>> Even if I dirty the configuration by writing to the schemata file, I can't reproduce this.
>>>
>>
>>  From what I can tell the reproducer is dependent on (a) whether hardware
>> supports CDP, and (b) the number of CLOSIDs supported by the system. The reproducer
>> works for hardware that has 16 CLOSIDs (see later).
>>
>>> (I have mba enabled, but all this should affect is the number of closid available)

> I reproduce this on v6.0-rc6. The key to reproduction is to ensure that the number of
> usable groups is different between CDP enabled and CDP disabled.
> 
> The system I use has 16 CLOSIDs for L3 CAT and 8 CLOSIDs for MBA. MBA limits the max
> number of groups to 8, even if CDP is disabled. This is the reason why I disable MBA.

bingo - could that detail be included in the commit message?

[..]

>> What do you think about clearing the staged config within resctrl_arch_update_domains()
>> after the configuration is complete and there is no more need for it? That may reduce
>> complexity where each caller no longer need to remember to do so.
>> I see "staged_config" as a temporary storage and it my help to understand the code better
>> if it is treated as such.
>>
> 
> I think this is better. I have tested it and will give a new version.

Great, thanks!

Could you mention have_new_ctrl in the commit message, and this path via
rdtgroup_init_alloc().

I think you also need:
Fixes: 75408e43509ed ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
Cc: <stable@vger.kernel.org>


Thanks,

James
