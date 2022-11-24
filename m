Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3718B637B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKXOWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiKXOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:21:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F264D238
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:21:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F9E106F;
        Thu, 24 Nov 2022 06:22:02 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CFAF3F73B;
        Thu, 24 Nov 2022 06:21:53 -0800 (PST)
Message-ID: <ced8f472-c719-d604-5f43-9b3316ec0a95@arm.com>
Date:   Thu, 24 Nov 2022 14:21:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
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
 <20221021131204.5581-7-james.morse@arm.com>
 <TYAPR01MB633047FDDF32B4A2CB5431B18B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <TYAPR01MB633047FDDF32B4A2CB5431B18B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
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

Hello,

On 10/11/2022 10:50, Shaopeng Tan (Fujitsu) wrote:
> Hi James
> 
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can
>> be used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be dirty,
>> and held in limbo.
>>
>> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty RMID
>> values. This behaviour is enabled by a kconfig option selected by the
>> architecture, which avoids a pointless search for x86.
>>


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 59da256a77fe..99854ef4dee4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -320,6 +320,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32

>> +bool resctrl_closid_is_dirty(u32 closid) {
>> +	struct rmid_entry *entry;
>> +	int i;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +		return false;


>> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ac88610a6946..59f33adcf6f8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -119,14 +119,18 @@ static void closid_init(void)
>>
>>  static int closid_alloc(void)
>>  {
>> -	u32 closid = ffs(closid_free_map);
>> +	u32 closid;
>>
>> -	if (closid == 0)
>> -		return -ENOSPC;
>> -	closid--;
>> -	closid_free_map &= ~(1 << closid);
>> +	for_each_set_bit(closid, &closid_free_map, closid_free_map_len) {
>> +		if
>> (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
>> +		    resctrl_closid_is_dirty(closid))


> IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) is redundant here,
> since it is also at the beginning of function resctrl_closid_is_dirty(closid).

This is true. I included it because resctrl_closid_is_dirty() is in a different
compilation unit, so the compiler can't know it does nothing if that config option isn't
enabled. This avoided a pointless call to a function that does nothing. But you're right
it would be more readable without it, and creating a control group is hardly a performance
critical path. I'll remove it.


Thanks,

James
