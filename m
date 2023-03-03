Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD376A9EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjCCSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCCSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:34:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53D408699
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:34:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CEEB143D;
        Fri,  3 Mar 2023 10:35:08 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97D5C3F93E;
        Fri,  3 Mar 2023 10:34:22 -0800 (PST)
Message-ID: <c687537e-8809-70ce-09ed-8130d6918c39@arm.com>
Date:   Fri, 3 Mar 2023 18:34:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
Content-Language: en-GB
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-6-james.morse@arm.com>
 <IA1PR11MB609709D870E9B379840592FD9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB609709D870E9B379840592FD9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 17/01/2023 18:53, Yu, Fenghua wrote:
>> MPAMs RMID values are not unique unless the CLOSID is considered as well.
>>
>> alloc_rmid() expects the RMID to be an independent number.
>>
>> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when allocating.
>> If the CLOSID is not relevant to the index, this ends up comparing the free RMID
>> with itself, and the first free entry will be used. With MPAM the CLOSID is
>> included in the index, so this becomes a walk of the free RMID entries, until one
>> that matches the supplied CLOSID is found.


>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index dbae380e3d1c..347be3767241 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -301,25 +301,51 @@ bool has_busy_rmid(struct rdt_resource *r, struct
>> rdt_domain *d)
>>  	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;  }
>>
>> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid) {
>> +	struct rmid_entry *itr;
>> +	u32 itr_idx, cmp_idx;
>> +
>> +	if (list_empty(&rmid_free_lru))
>> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-
>> ENOSPC);
>> +
>> +	list_for_each_entry(itr, &rmid_free_lru, list) {
>> +		/*
>> +		 * get the index of this free RMID, and the index it would need
>> +		 * to be if it were used with this CLOSID.
>> +		 * If the CLOSID is irrelevant on this architecture, these will
>> +		 * always be the same. Otherwise they will only match if this
>> +		 * RMID can be used with this CLOSID.
>> +		 */
>> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
>> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
>> +
>> +		if (itr_idx == cmp_idx)
>> +			return itr;
> 
> Finding free rmid may be called frequently depending on usage.
> 
> It would be better to have a simpler and faster arch helper that finds the itr on x86.
> Something like:
> struct rmid_entry *resctrl_arch_rmid_matchd(u32 ignored, u32 ignored)
> {
> 	return list_entry_first(resctrl_free_lru, itr, list);
> }
> 
> Arm64 implements the complex case going through the rmid_free_lru list in the patch.

The trick here is that one degenerates into the other:

>> +	list_for_each_entry(itr, &rmid_free_lru, list) {

The first time round the loop, this is equivalent to:
| itr = list_entry_first(&rmid_free_lru, itr, list);


>> +		/*
>> +		 * get the index of this free RMID, and the index it would need
>> +		 * to be if it were used with this CLOSID.
>> +		 * If the CLOSID is irrelevant on this architecture, these will
>> +		 * always be the same. Otherwise they will only match if this
>> +		 * RMID can be used with this CLOSID.
>> +		 */
>> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);

On x86, after inline-ing this is:
| itr_idx = itr->rmid

>> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);

and this is:
| cmp_idx = itr->rmid

>> +		if (itr_idx == cmp_idx)
>> +			return itr;

So now any half decent compiler can spot that this condition is always true and the loop
only ever runs once, and the whole thing reduces to what you wanted it to be.

This saves exposing things that should be private to the filesystem code and having
per-arch helpers to mess with it.

The commit message described this, I'll expand the comment in the loop to be:
|		 * If the CLOSID is irrelevant on this architecture, these will
|		 * always be the same meaning the compiler can reduce this loop
|		 * to a single list_entry_first() call.


Thanks,

James
