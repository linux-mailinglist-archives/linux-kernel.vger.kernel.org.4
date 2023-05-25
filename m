Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF73E71126B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbjEYRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:32:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36856B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:32:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E83815BF;
        Thu, 25 May 2023 10:32:46 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342543F840;
        Thu, 25 May 2023 10:31:58 -0700 (PDT)
Message-ID: <50775fa5-2da5-90fa-5f6c-9a12b8364e9b@arm.com>
Date:   Thu, 25 May 2023 18:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 12/19] x86/resctrl: Make resctrl_mounted checks
 explicit
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-13-james.morse@arm.com>
 <94b54f42-a70b-498b-ca05-62528a98cea8@intel.com>
 <b1b9225f-caa3-a868-6333-b7dadf17c5e7@arm.com>
 <4b6bd7b9-4701-6344-9a3c-6c7ef25ec6b7@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <4b6bd7b9-4701-6344-9a3c-6c7ef25ec6b7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 28/04/2023 00:37, Reinette Chatre wrote:
> On 4/27/2023 7:19 AM, James Morse wrote:
>> On 01/04/2023 00:28, Reinette Chatre wrote:
>>> On 3/20/2023 10:26 AM, James Morse wrote:
>>>> The rdt_enable_key is switched when resctrl is mounted, and used to
>>>> prevent a second mount of the filesystem. It also enables the
>>>> architecture's context switch code.
>>>>
>>>> This requires another architecture to have the same set of static-keys,
>>>> as resctrl depends on them too.
>>>>
>>>> Make the resctrl_mounted checks explicit: resctrl can keep track of
>>>> whether it has been mounted once. This doesn't need to be combined with
>>>> whether the arch code is context switching the CLOSID.
>>>> Tests against the rdt_mon_enable_key become a test that resctrl is
>>>> mounted and that monitoring is enabled.
>>>
>>> The last sentence above makes the code change hard to follow ...
>>> (see below)
>>>
>>>> This will allow the static-key changing to be moved behind resctrl_arch_
>>>> calls.
>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index f38cd2f12285..6279f5c98b39 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -834,7 +834,7 @@ void mbm_handle_overflow(struct work_struct *work)
>>>>  
>>>>  	mutex_lock(&rdtgroup_mutex);
>>>>  
>>>> -	if (!static_branch_likely(&rdt_mon_enable_key))
>>>> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
>>>
>>> ... considering the text in the changelog the "resctrl_mounted" check seems
>>> unnecessary. Looking ahead I wonder if this check would not be more
>>> appropriate in patch 15?
>>
>> How so?
>>
>> This is secretly relying on rdt_mon_enable_key being cleared in rdt_kill_sb() when the
>> filesystem is unmounted, otherwise the overflow thread keeps running once the filesystem
>> is unmounted.
> 
> hmmm ... I do not think my feedback was clear. I understand that this is done
> as a prep patch but that was only clear when I read patch 15 because as the
> work is presented here it seems unnecessary. 
> 
>>
>> I thought it simpler to add all these checks explicitly in one go.
>> That makes it simpler to thin out the static keys as their 'and its mounted' behaviour is
>> no longer relied on.
> 
> Understood. If you want to keep this as a prep patch, could you please update the
> changelog to reflect this? The following sentence in the changelog makes this patch
> hard to follow since it essentially claims that what this patch does is unnecessary:
> "Tests against the rdt_mon_enable_key become a test that resctrl is mounted
> and that monitoring is enabled."

"Because of the implicit mount test" ... the text immediately before this.

We're probably going to keep talking past each other on this - I'll rephrase that
paragraph as:
| rdt_mon_enable_key is never used just to test that resctrl is mounted,
| but does also have this implication. Add a resctrl_mounted to all uses
| of rdt_mon_enable_key. This will allow rdt_mon_enable_key to be swapped
| with a helper in a subsequent patch.


> I also do still wonder why these resctrl_mounted checks cannot move to patch
> 15 when they are needed. Adding them there makes it obvious that rdt_mon_enable_key
> had a dual purpose that patch 15 splits into two separate checks. 

That is happening in this patch too, rdt_mon_enable_key becomes
(resctrl_mounted && rdt_mon_enable_key), the implicit property is now explicit, so a later
patch can modify rdt_mon_enable_key without breaking this behaviour.

I think its easier to review if patch 15 is making a set of 1:1 mappings instead of
splitting some static-keys but not others. Let me know what you think of the new version.


Thanks,

James
