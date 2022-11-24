Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB911637B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKXOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKXOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:21:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2885126C2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:21:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6962423A;
        Thu, 24 Nov 2022 06:21:55 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFD9B3F73B;
        Thu, 24 Nov 2022 06:21:45 -0800 (PST)
Message-ID: <f18fc728-de30-8d2a-3ecc-6896f6559ab1@arm.com>
Date:   Thu, 24 Nov 2022 14:21:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Content-Language: en-GB
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-5-james.morse@arm.com>
 <TYAPR01MB6330FB646459F4D48D6BA4C88B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <TYAPR01MB6330FB646459F4D48D6BA4C88B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
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

Hello!

On 10/11/2022 10:50, Shaopeng Tan (Fujitsu) wrote:
>> RMID are allocated for each monitor or control group directory, because each of
>> these needs its own RMID. For control groups,
>> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>>
>> MPAM's equivalent of RMID are not an independent number, so can't be
>> allocated until the closid is known. An RMID allocation for one CLOSID may fail,
>> whereas another may succeed depending on how many monitor groups a
>> control group has.
>>
>> The RMID allocation needs to move to be after the CLOSID has been allocated.
>>
>> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller, after
>> the mkdir_rdt_prepare() call. This allows the RMID allocator to know the
>> CLOSID.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 841294ad6263..c67083a8a5f5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -3003,12 +3004,19 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
>> *parent_kn,
>>  	prgrp = rdtgrp->mon.parent;
>>  	rdtgrp->closid = prgrp->closid;
>>
>> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
>> +	if (ret) {
>> +		mkdir_rdt_prepare_clean(rdtgrp);
>> +		goto out_unlock;
>> +	}
>> +
>>  	/*
>>  	 * Add the rdtgrp to the list of rdtgrps the parent
>>  	 * ctrl_mon group has to track.
>>  	 */
>>  	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
>>
>> +out_unlock:
>>  	rdtgroup_kn_unlock(parent_kn);

> Is there any case that a lock is not unlocked here?

If you've found an example - please share!

The unlock is necessary because mkdir_rdt_prepare() calls rdtgroup_kn_lock_live(),
but expects its caller to do the unlock.

This patch allows the rmid allocation to fail separately to mkdir_rdt_prepare(), so
rdtgroup_mkdir_mon() needs to ensure the unlock() happens when it returns an error, this
work was previously done by 'out_unlock' in mkdir_rdt_prepare().

I hope this helps,

Thanks,

James
