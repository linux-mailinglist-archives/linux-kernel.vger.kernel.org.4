Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921446ABE3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCFLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCFLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:34:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E547322DED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:34:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDDD12FC;
        Mon,  6 Mar 2023 03:35:05 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B7B03F5A1;
        Mon,  6 Mar 2023 03:34:19 -0800 (PST)
Message-ID: <cdabc034-1365-d254-8ce5-b5a70d45a28e@arm.com>
Date:   Mon, 6 Mar 2023 11:34:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 16/18] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
 <20230113175459.14825-17-james.morse@arm.com>
 <ab71c33e-f1e3-63be-ac83-685d11c8b4eb@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <ab71c33e-f1e3-63be-ac83-685d11c8b4eb@intel.com>
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

Hi Reinette,

On 02/02/2023 23:49, Reinette Chatre wrote:
> On 1/13/2023 9:54 AM, James Morse wrote:
>> When a cpu is taken offline resctrl may need to move the overflow or
>> limbo handlers to run on a different CPU.
>> Once the offline callbacks have been split, cqm_setup_limbo_handler()
>> will be called while the CPU that is going offline is still present
>> in the cpu_mask.
>>
>> Pass the CPU to exclude to cqm_setup_limbo_handler() and
>> mbm_setup_overflow_handler(). These functions can use cpumask_any_but()
>> when selecting the CPU. -1 is used to indicate no CPUs need excluding.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 1a214bd32ed4..334fb3f1c6e2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>> @@ -773,15 +773,27 @@ void cqm_handle_limbo(struct work_struct *work)
>>  	mutex_unlock(&rdtgroup_mutex);
>>  }
>>  
>> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>> +/**
>> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
>> + *                             domain.
>> + * @delay_ms:      How far in the future the handler should run.
>> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.
>> + */
>> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
>> +			     int exclude_cpu)
>>  {
>>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>>  	int cpu;
>>  
>> -	cpu = cpumask_any(&dom->cpu_mask);
>> +	if (exclude_cpu == -1)
>> +		cpu = cpumask_any(&dom->cpu_mask);
>> +	else
>> +		cpu = cpumask_any_but(&dom->cpu_mask, exclude_cpu);
>> +
>>  	dom->cqm_work_cpu = cpu;
>>  
> 
> This assignment is unexpected considering the error handling that follows.
> cqm_work_cpu can thus be >= nr_cpu_ids. I assume it is to help during
> domain remove where the CPU being removed is checked against this value?
> If indeed this invalid CPU assignment is done in support of future code
> path, could you please add a comment to help explain this assignment?

Looks like I ignored it because in the last-man-standing case, the domain is going to get
free()d anyway ... but I couldn't find a 'cpu >= nr_cpu_ids' check under
schedule_delayed_work_on() hence the error handling.

I'll move the dom->mbm_work_cpu under the nr_cpu_ids check too so that it doesn't look funny.


Thanks,

James
