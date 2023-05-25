Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12B71126C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbjEYRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbjEYRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:32:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78A5EB6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:32:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607381650;
        Thu, 25 May 2023 10:32:49 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035243F6C4;
        Thu, 25 May 2023 10:32:00 -0700 (PDT)
Message-ID: <329e0e44-c7f0-a602-640c-585530e9c665@arm.com>
Date:   Thu, 25 May 2023 18:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 11/19] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
 <20230320172620.18254-12-james.morse@arm.com>
 <36af82d5-0d48-f899-9e95-1ec89be20581@intel.com>
 <24d3616a-7800-ba91-deed-8bcc639ce6ba@arm.com>
 <28845d8b-cf7a-b5b7-d5ae-1284e33d063c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <28845d8b-cf7a-b5b7-d5ae-1284e33d063c@intel.com>
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

On 28/04/2023 00:40, Reinette Chatre wrote:
> On 4/27/2023 7:19 AM, James Morse wrote:
>> On 01/04/2023 00:27, Reinette Chatre wrote:
>>> On 3/20/2023 10:26 AM, James Morse wrote:

>>>> @@ -317,9 +318,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>>>  	struct rmid_entry *entry;
>>>>  	u32 idx, cur_idx = 1;
>>>> +	int arch_mon_ctx;
>>>>  	bool rmid_dirty;
>>>>  	u64 val = 0;
>>>>  
>>>> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
>>>> +	if (arch_mon_ctx < 0)
>>>> +		return;
>>
>>> The vision for this is not clear to me. When I read that context needs to be allocated
>>> I expect it to return a pointer to some new context, not an int. What would the
>>> "context" consist of?
>>
>> It might just need a different name.
>>
>> For MPAM, this is allocating a monitor, which is the hardware that does the counting in
>> the cache or the memory controller. The number of monitors is an implementation choice,
>> and may not match the number of CLOSID/RMID that are in use. There aren't guaranteed to be
>> enough to allocate one for every control or monitor group up front.
>>
>> The int being returned is the allocated monitor's index. It identifies which monitor needs
>> programming to read the provided CLOSID/RMID, and the counter register to read with the value.
> 
> I see.
> 
>>
>> I can allocate memory for an int if you think that is clearer.
>> (I was hoping to leave that for whoever needs something bigger than a pointer)

> I'd rather not complicate it in this way.

It's a no-op for x86 as these calls get optimised out, but more annoying for MPAM (I've
done it now). I think the result is more intuitive, but see what you think.


Thanks,

James
