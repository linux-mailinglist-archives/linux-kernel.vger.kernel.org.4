Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65A472DB66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbjFMHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbjFMHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:44:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3BAA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:44:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QgLD55Y9fzTl0q;
        Tue, 13 Jun 2023 15:44:21 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:44:50 +0800
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Chen Yu <yu.c.chen@intel.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
 <ZIams6s+qShFWhfQ@BLR-5CG11610CF.amd.com>
 <ZIariDV8sztoPbv0@chenyu5-mobl2.ccr.corp.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <c98baaab-aee6-6983-bc29-836488f73d8d@huawei.com>
Date:   Tue, 13 Jun 2023 15:44:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZIariDV8sztoPbv0@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/12 13:22, Chen Yu wrote:
> On 2023-06-12 at 10:31:39 +0530, Gautham R. Shenoy wrote:
>> Hello Yicong,
>>
>>
>> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
>>> From: Barry Song <song.bao.hua@hisilicon.com>
>> [..snip..]
>>
>>> @@ -7103,7 +7127,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>  	bool has_idle_core = false;
>>>  	struct sched_domain *sd;
>>>  	unsigned long task_util, util_min, util_max;
>>> -	int i, recent_used_cpu;
>>> +	int i, recent_used_cpu, prev_aff = -1;
>>>  
>>>  	/*
>>>  	 * On asymmetric system, update task utilization because we will check
>>> @@ -7130,8 +7154,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>  	 */
>>>  	if (prev != target && cpus_share_cache(prev, target) &&
>>>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>>> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
>>> -		return prev;
>>> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
>>> +		if (cpus_share_lowest_cache(prev, target))
>>
>> For platforms without the cluster domain, the cpus_share_lowest_cache
>> check is a repetition of the cpus_share_cache(prev, target) check. Can
>> we avoid this using a static branch check for cluster ?
>>
>>
> Sounds good. 
>>> +			return prev;
>>> +		prev_aff = prev;
>>> +	}
>>>  
>>>  	/*
>>>  	 * Allow a per-cpu kthread to stack with the wakee if the
>>> @@ -7158,7 +7185,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>>>  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
>>>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
>>> -		return recent_used_cpu;
>>> +		if (cpus_share_lowest_cache(recent_used_cpu, target))
>>
>> Same here.
>>
>>> +			return recent_used_cpu;
>>> +	} else {
>>> +		recent_used_cpu = -1;
>>>  	}
>>>  
>>>  	/*
>>> @@ -7199,6 +7229,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>  	if ((unsigned)i < nr_cpumask_bits)
>>>  		return i;
>>>  
>>> +	/*
>>> +	 * For cluster machines which have lower sharing cache like L2 or
>>> +	 * LLC Tag, we tend to find an idle CPU in the target's cluster
>>> +	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
>>> +	 * use them if possible when no idle CPU found in select_idle_cpu().
>>> +	 */
>>> +	if ((unsigned int)prev_aff < nr_cpumask_bits)
>>> +		return prev_aff;
>>
>> Shouldn't we check if prev_aff (and the recent_used_cpu below) is
>> still idle ?
>>
>>
> When we reach here, the target is non-idle, and the prev_aff is idle.
> Although there is a race condition that prev_aff becomes non-idle
> and target becomes idle after select_idle_cpu(), this window might be
> small IMO.
> 

Yes. Races here but adding a check won't cost much, so it's ok for me
to check it or not.

Thanks.


