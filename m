Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340796A9EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCCSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCCSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:34:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B50B0BDE8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:34:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBD32143D;
        Fri,  3 Mar 2023 10:34:50 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E5683F93E;
        Fri,  3 Mar 2023 10:34:03 -0800 (PST)
Message-ID: <c2a40b7a-4931-efc4-facd-ac930ac155fc@arm.com>
Date:   Fri, 3 Mar 2023 18:33:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
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
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-5-james.morse@arm.com>
 <052a8700-bae1-a945-c8d0-df658697142f@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <052a8700-bae1-a945-c8d0-df658697142f@intel.com>
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

Hi Reinette,

On 02/02/2023 23:45, Reinette Chatre wrote:
> On 1/13/2023 9:54 AM, James Morse wrote:
>> RMID are allocated for each monitor or control group directory, because
>> each of these needs its own RMID. For control groups,
>> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>>
>> MPAM's equivalent of RMID are not an independent number, so can't be
>> allocated until the closid is known. An RMID allocation for one CLOSID

> Could you please be consistent with CLOSID vs closid (also RMID vs rmid)?
> When reading through the series and seeing the switch it is not clear if
> text refers to same concept.

Yup, I'm trying, but there will be some that slip through.


>> may fail, whereas another may succeed depending on how many monitor
>> groups a control group has.
>>
>> The RMID allocation needs to move to be after the CLOSID has been
>> allocated.
>>
>> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
>> after the mkdir_rdt_prepare() call. This allows the RMID allocator to
>> know the CLOSID.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 841294ad6263..c67083a8a5f5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -2957,10 +2963,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  		goto out_destroy;
>>  	}
>>  
>> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
>> -	if (ret)
>> -		goto out_destroy;
>> -
>>  	kernfs_activate(kn);
>>  
> 
> This moves the creation of the monitoring related files/directories to later, but leaves
> the kernfs_activate() that activates the node and make it visible to user space. Should
> this activation be moved?

I hadn't properly grasped what that was doing Yes, I've moved it to after the
mkdir_rdt_prepare_rmid_alloc() calls in the two callers.


Thanks,

James
