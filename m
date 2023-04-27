Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A16F0722
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbjD0OUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbjD0OTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:19:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8164E10DD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:19:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A5CDC14;
        Thu, 27 Apr 2023 07:20:35 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F9C53F7D8;
        Thu, 27 Apr 2023 07:19:44 -0700 (PDT)
Message-ID: <24d3616a-7800-ba91-deed-8bcc639ce6ba@arm.com>
Date:   Thu, 27 Apr 2023 15:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <36af82d5-0d48-f899-9e95-1ec89be20581@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/04/2023 00:27, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
>> Depending on the number of monitors available, Arm's MPAM may need to
>> allocate a monitor prior to reading the counter value. Allocating a
>> contended resource may involve sleeping.
>>
>> All callers of resctrl_arch_rmid_read() read the counter on more than
>> one domain. If the monitor is allocated globally, there is no need to
> 
> This does not seem accurate considering the __check_limbo() call that
> is called for a single domain.

True, it was add_rmid_to_limbo() that motivated this being global, but its conflated with
holding the allocation for multiple invocations of resctrl_arch_rmid_read() for the
multiple groups that __check_limbo() walks over, and the calls for each monitor group that
mon_event_count() makes.


>> allocate and free it for each call to resctrl_arch_rmid_read().
>>
>> Add arch hooks for this allocation, which need calling before
>> resctrl_arch_rmid_read(). The allocated monitor is passed to
>> resctrl_arch_rmid_read(), then freed again afterwards. The helper
>> can be called on any CPU, and can sleep.


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index de72df06b37b..f38cd2f12285 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -15,6 +15,7 @@
>>   * Software Developer Manual June 2016, volume 3, section 17.17.
>>   */
>>  
>> +#include <linux/cpu.h>
> 
> Why is this needed?

lockdep_assert_cpus_held(), but that got folded out to a latter patch. I've moved it there.


>>  #include <linux/module.h>
>>  #include <linux/sizes.h>
>>  #include <linux/slab.h>
>> @@ -271,7 +272,7 @@ static void smp_call_rmid_read(void *_arg)
>>  
>>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>> -			   u64 *val)
>> +			   u64 *val, int ignored)
>>  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> @@ -317,9 +318,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>  	struct rmid_entry *entry;
>>  	u32 idx, cur_idx = 1;
>> +	int arch_mon_ctx;
>>  	bool rmid_dirty;
>>  	u64 val = 0;
>>  
>> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
>> +	if (arch_mon_ctx < 0)
>> +		return;

> The vision for this is not clear to me. When I read that context needs to be allocated
> I expect it to return a pointer to some new context, not an int. What would the
> "context" consist of?

It might just need a different name.

For MPAM, this is allocating a monitor, which is the hardware that does the counting in
the cache or the memory controller. The number of monitors is an implementation choice,
and may not match the number of CLOSID/RMID that are in use. There aren't guaranteed to be
enough to allocate one for every control or monitor group up front.

The int being returned is the allocated monitor's index. It identifies which monitor needs
programming to read the provided CLOSID/RMID, and the counter register to read with the value.

I can allocate memory for an int if you think that is clearer.
(I was hoping to leave that for whoever needs something bigger than a pointer)


>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index ff7452f644e4..03e4f41cd336 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -233,6 +233,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>>   * @rmid:		rmid of the counter to read.
>>   * @eventid:		eventid to read, e.g. L3 occupancy.
>>   * @val:		result of the counter read in bytes.
>> + * @arch_mon_ctx:	An allocated context from resctrl_arch_mon_ctx_alloc().
>>   *

> Could this description be expanded to indicate what this context is used for?

Sure,
"An architecture specific value from resctrl_arch_mon_ctx_alloc(), for MPAM this
identifies the hardware monitor allocated for this read request".



Thanks,

James
