Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98136F072E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbjD0OVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbjD0OVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:21:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE80C4C12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:20:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FDDC2F4;
        Thu, 27 Apr 2023 07:21:19 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C653F64C;
        Thu, 27 Apr 2023 07:20:32 -0700 (PDT)
Message-ID: <9282d346-80eb-88bd-b9d0-0c3dd16d51db@arm.com>
Date:   Thu, 27 Apr 2023 15:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 18/19] x86/resctrl: Add cpu offline callback for
 resctrl work
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
 <20230320172620.18254-19-james.morse@arm.com>
 <50a87b32-282e-e4d5-8fb4-a4a99d1b0ed5@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <50a87b32-282e-e4d5-8fb4-a4a99d1b0ed5@intel.com>
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

On 06/04/2023 00:48, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
> 
>> -static int resctrl_offline_cpu(unsigned int cpu)
>> -{
>> -	struct rdtgroup *rdtgrp;
>>  	struct rdt_resource *r;
>>  
>>  	mutex_lock(&rdtgroup_mutex);
>> +	resctrl_offline_cpu(cpu);
>> +
>>  	for_each_capable_rdt_resource(r)
>>  		domain_remove_cpu(cpu, r);
>> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
>> -		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
>> -			clear_childcpus(rdtgrp, cpu);
>> -			break;
>> -		}
>> -	}
>>  	clear_closid_rmid(cpu);
>>  	mutex_unlock(&rdtgroup_mutex);
>>  
> 
> I find this and the previous patch to be very complicated.

It consolidates the parts of this that have nothing to do with the architecture specific code.
The extra work is because the semantics are: "this CPU is going away", the callee needs to
to not pick 'this CPU' again when updating any structures.

Ensuring the structures have not yet been modified by the architecture code is the
cleanest interface as there is nothing special about what the arch code provides to the
filesystem here.

I agree it looks like a special case, but only because the existing code is being called
halfway through the tear down, and depends on what the arch code has already done.

Having a single call, where nothing has been changed yet is the most maintainable option
as it avoids extra hooks, or an incomplete list of what has been torn down, and what
hasn't - some of which may be architecture specific.

It also avoids any interaction with how the architecture code chooses to prevent multiple
writers to the domain list - I don't want any of the filesystem code to depend on a lock
held by the architecture specific code.


> It is not clear
> to me why resctrl_offline_cpu(cpu) is required to be before offline of domain.
> Previous patch would not be needed if the existing order of operations
> is maintained.

The existing order is a bit of a soup.

You'd need a resctrl_domain_rebalance_helpers() to move the limbo and mbm workers, but
this would run after the CPU had been removed from the domain. Hopefully the name conveys
that it doesn't always run when a CPU is going offline.
resctrl_offline_cpu() would potentially run after the CPUs domains have been free()d,
depending on what gets added in the future this might be a problem, leading to a
resctrl_pre_offline_cpu() hook.

I worry this strange state leads to extra special-case'd filesystem code, and extra hooks.


I can split the consolidation of the filesystem code up in this patch, the
clear_childcpus() and limbo/mbm stuff can be done in separate patches, which might make it
easier on the eye.


Thanks,

James
