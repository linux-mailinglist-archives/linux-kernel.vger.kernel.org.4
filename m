Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D824664803
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjAJSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjAJR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0615E22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:57:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A2E82F4;
        Tue, 10 Jan 2023 09:58:31 -0800 (PST)
Received: from [10.1.196.46] (eglon.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9C23F67D;
        Tue, 10 Jan 2023 09:57:46 -0800 (PST)
Message-ID: <ec5516e2-521b-084a-ce86-5c371eda2b75@arm.com>
Date:   Tue, 10 Jan 2023 17:57:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 03/18] x86/resctrl: Create helper for RMID allocation and
 mondata dir creation
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
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-4-james.morse@arm.com>
 <IA1PR11MB6097DBE28137579B89FD23739BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB6097DBE28137579B89FD23739BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
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

Hi Fenghua,

On 06/01/2023 03:23, Yu, Fenghua wrote:
>> James Morse <james.morse@arm.com> writes:
>>
>> RMID are allocated for each monitor or control group directory, because each
>> of these needs its own RMID. For control groups,
>> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>>
>> MPAM's equivalent of RMID are not an independent number, so can't be
>> allocated until the CLOSID is known. An RMID allocation for one CLOSID may fail,
>> whereas another may succeed depending on how many monitor groups a
>> control group has.
>>
>> The RMID allocation needs to move to be after the CLOSID has been allocated.
>>
>> To make a subsequent change that does this easier to read, move the RMID
>> allocation and mondata dir creation to a helper.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 9ce4746778f4..841294ad6263 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2868,6 +2868,30 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>>  	return 0;
>>  }
>>
>> +static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp) {
>> +	int ret;
>> +
>> +	if (!rdt_mon_capable)
>> +		return 0;
>> +
>> +	ret = alloc_rmid();
>> +	if (ret < 0) {
>> +		rdt_last_cmd_puts("Out of RMIDs\n");
>> +		return ret;
>> +	}
>> +	rdtgrp->mon.rmid = ret;
>> +
>> +	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp-
>>> mon.mon_data_kn);
>> +	if (ret) {
>> +		rdt_last_cmd_puts("kernfs subdir error\n");


>> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);

                ^^^^^^^^^

>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  			     const char *name, umode_t mode,
>>  			     enum rdt_group_type rtype, struct rdtgroup **r)
>> @@ -2933,20 +2957,10 @@ static int mkdir_rdt_prepare(struct kernfs_node
>> *parent_kn,
>>  		goto out_destroy;
>>  	}
>>
>> -	if (rdt_mon_capable) {
>> -		ret = alloc_rmid();
>> -		if (ret < 0) {
>> -			rdt_last_cmd_puts("Out of RMIDs\n");
>> -			goto out_destroy;
>> -		}
>> -		rdtgrp->mon.rmid = ret;
>> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
>> +	if (ret)
>> +		goto out_destroy;
>>
>> -		ret = mkdir_mondata_all(kn, rdtgrp, &rdtgrp-
>>> mon.mon_data_kn);
>> -		if (ret) {
>> -			rdt_last_cmd_puts("kernfs subdir error\n");
>> -			goto out_idfree;
>> -		}
>> -	}
>>  	kernfs_activate(kn);
>>
>>  	/*
>> @@ -2954,8 +2968,6 @@ static int mkdir_rdt_prepare(struct kernfs_node
>> *parent_kn,
>>  	 */
>>  	return 0;
>>
>> -out_idfree:
>> -	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>  out_destroy:
>>  	kernfs_put(rdtgrp->kn);
>>  	kernfs_remove(rdtgrp->kn);

> Why not free allocated rmid? Rmid leak without freed.

It's just moved into the helper.

This free_rmid() is here because this function used to allocate the rmid and the mondata
as separate steps. Now a helper does that in one go - and cleans up after itself.

If mkdir_rdt_prepare_rmid_alloc() fails, it didn't allocate an rmid .. if it secretly did,
it free()s it itself, see the ^-lighted code above.


Thanks,

James
