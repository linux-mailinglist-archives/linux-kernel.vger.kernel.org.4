Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91270F023
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjEXIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjEXIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:05:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A0C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:05:32 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QR3c21DlzzLmPw;
        Wed, 24 May 2023 16:04:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 16:05:29 +0800
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        <tim.c.chen@intel.com>
Subject: Re: [RESEND PATCH v7 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
To:     Chen Yu <yu.c.chen@intel.com>
References: <20220915073423.25535-1-yangyicong@huawei.com>
 <20220915073423.25535-3-yangyicong@huawei.com>
 <ZGsLy83wPIpamy6x@chenyu5-mobl1>
 <46e8d4fc-993b-e1d6-5e4c-cb33513d7888@huawei.com>
 <ZGzDLuVaHR1PAYDt@chenyu5-mobl1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <9b3bdf37-2551-871c-1f68-ceddf4e933c3@huawei.com>
Date:   Wed, 24 May 2023 16:05:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZGzDLuVaHR1PAYDt@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/23 21:44, Chen Yu wrote:
> On 2023-05-22 at 20:42:19 +0800, Yicong Yang wrote:
>> Hi Chen,
>>
>> On 2023/5/22 14:29, Chen Yu wrote:
>>> Hi Yicong,
>>> On 2022-09-15 at 15:34:23 +0800, Yicong Yang wrote:
>>>> From: Barry Song <song.bao.hua@hisilicon.com>
>>>>
> [snip...]
>>
>> Thanks for the further information. The result of netperf/tbench looks good as we
>> image, the cluster wakeup expects to gain more benefit when the system is under
>> loaded or well-loaded. May I know how many CPUs sharing cluster on Jacobsvilla?
>>
> There are 4 CPUs per cluster on Jacobsville.
> [snip...]
>>>> @@ -6550,7 +6574,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>  	/*
>>>>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>>>>  	 */
>>>> -	if (prev != target && cpus_share_cache(prev, target) &&
>>>> +	if (prev != target && cpus_share_lowest_cache(prev, target) &&
>>> This change impacts hackbench in socket mode a bit. It seems that for hackbench even
>>> putting the wakee on its previous CPU in the same LLC is better than putting it on
>>> current cluster. But it seems to be hackbench specific.
>>>
>>
>> ...without this do you still see the same improvement at under-loaded case (threads less-equal the CPU
>> numbers) for tbench/netperf? 
>> The idea here is to always try to wakeup in the same cluster of the
>> target to benefit from the cluster cache but the early test for the prev and recent used cpu may break
>> that. Keep it as is, at low load the prev cpu or recent used cpu get more chance to be idle so we take
>> less chance to benefit from the cluster and gain less performance improvement.
>>
> Right. Without above change I saw lower improvement at lightly load case for netperf/tbench.
>> In the hackbench case as you noticed, the utilization can reach 100% ideally so the SIS_UTIL
>> will regulate the scanning number to 4 or around. If the prev/recent used CPU is not in the same
>> cluster with target, we're about to scanning the cluster and when found no idle CPU and has
>> run out of the scanning number, we'll fallback to wakeup on the target. That maybe the reason
>> why observed more wakeups on target rather than previous CPU.
>>
> Looks reasonable. When the budget of scanning number is low, we can not find an idle target
> on local cluster and terminates scanning for an idle prev on remote cluster, although that
> prev could be a better choice than target cpu.
>> In this case I wondering choosing prev cpu or recent used cpu after scanning the cluster can help
>> the situation here, like the snippet below (kinds of messy though).
>>
> This change makes sense to me. I only modified it a little bit to only give prev a second
> chance. With your patch applied, the improvement of netperf/tbench remains while the
> hackbench big regress was gone.
> 

Thanks for the test, it looks justified to have this. Will include this change in next version.

> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1-groups	 1.00 (  2.35)	 -0.65 (  1.81)
> process-pipe    	2-groups	 1.00 (  0.42)	 -2.16 (  1.12)
> process-pipe    	4-groups	 1.00 (  1.84)	 +0.72 (  1.34)
> process-pipe    	8-groups	 1.00 (  2.81)	 +1.12 (  3.88)
> process-sockets 	1-groups	 1.00 (  1.88)	 -0.99 (  4.84)
> process-sockets 	2-groups	 1.00 (  5.49)	 -4.50 (  4.09)
> process-sockets 	4-groups	 1.00 (  3.54)	 +2.28 (  3.13)
> process-sockets 	8-groups	 1.00 (  0.79)	 -0.13 (  1.28)
> threads-pipe    	1-groups	 1.00 (  1.73)	 -2.39 (  0.40)
> threads-pipe    	2-groups	 1.00 (  0.73)	 +2.88 (  1.94)
> threads-pipe    	4-groups	 1.00 (  0.64)	 +1.12 (  1.82)
> threads-pipe    	8-groups	 1.00 (  1.55)	 -1.59 (  1.20)
> threads-sockets 	1-groups	 1.00 (  3.76)	 +3.21 (  3.56)
> threads-sockets 	2-groups	 1.00 (  1.20)	 -5.56 (  2.64)
> threads-sockets 	4-groups	 1.00 (  2.65)	 +1.48 (  4.91)
> threads-sockets 	8-groups	 1.00 (  0.08)	 +0.18 (  0.15)
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	6-threads	 1.00 (  0.91)	 +2.87 (  0.83)
> TCP_RR          	12-threads	 1.00 (  0.22)	 +3.48 (  0.31)
> TCP_RR          	18-threads	 1.00 (  0.41)	 +7.81 (  0.48)
> TCP_RR          	24-threads	 1.00 (  1.02)	 -0.32 (  1.25)
> TCP_RR          	30-threads	 1.00 (  4.67)	 -0.04 (  5.14)
> TCP_RR          	36-threads	 1.00 (  4.53)	 -0.13 (  4.37)
> TCP_RR          	42-threads	 1.00 (  3.92)	 -0.15 (  3.07)
> TCP_RR          	48-threads	 1.00 (  2.07)	 -0.17 (  1.52)
> UDP_RR          	6-threads	 1.00 (  0.98)	 +4.50 (  2.38)
> UDP_RR          	12-threads	 1.00 (  0.26)	 +3.64 (  0.25)
> UDP_RR          	18-threads	 1.00 (  0.27)	 +9.93 (  0.55)
> UDP_RR          	24-threads	 1.00 (  1.22)	 +0.13 (  1.33)
> UDP_RR          	30-threads	 1.00 (  3.86)	 -0.03 (  5.05)
> UDP_RR          	36-threads	 1.00 (  2.81)	 +0.10 (  3.37)
> UDP_RR          	42-threads	 1.00 (  3.51)	 -0.26 (  2.94)
> UDP_RR          	48-threads	 1.00 ( 12.54)	 +0.74 (  9.44)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	6-threads	 1.00 (  0.04)	 +2.94 (  0.26)
> loopback        	12-threads	 1.00 (  0.30)	 +4.58 (  0.12)
> loopback        	18-threads	 1.00 (  0.37)	+12.38 (  0.10)
> loopback        	24-threads	 1.00 (  0.56)	 -0.27 (  0.50)
> loopback        	30-threads	 1.00 (  0.17)	 -0.18 (  0.06)
> loopback        	36-threads	 1.00 (  0.25)	 -0.73 (  0.44)
> loopback        	42-threads	 1.00 (  0.10)	 -0.22 (  0.18)
> loopback        	48-threads	 1.00 (  0.29)	 -0.48 (  0.19)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
> normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
> normal          	4-mthreads	 1.00 (  6.80)	 +2.78 (  8.08)
> normal          	8-mthreads	 1.00 (  3.65)	 -0.23 (  4.30)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0989116b0796..07495b44c68f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7127,7 +7127,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	bool has_idle_core = false;
>  	struct sched_domain *sd;
>  	unsigned long task_util, util_min, util_max;
> -	int i, recent_used_cpu;
> +	int i, recent_used_cpu, prev_aff = -1;
>  
>  	/*
>  	 * On asymmetric system, update task utilization because we will check
> @@ -7152,10 +7152,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	/*
>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>  	 */
> -	if (prev != target && cpus_share_lowest_cache(prev, target) &&
> +	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> -		return prev;
> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +		if (cpus_share_lowest_cache(prev, target))
> +			return prev;
> +		prev_aff = prev;
> +	}
>  
>  	/*
>  	 * Allow a per-cpu kthread to stack with the wakee if the
> @@ -7223,6 +7226,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> +	/*
> +	 * Give prev another chance, in case prev has not been
> +	 * scanned in select_idle_cpu() due to nr constrain.
> +	 */
> +	if (prev_aff != -1)
> +		return prev_aff;
> +

It looks neater. We should also give recent_used_cpu a chance based on the current implementation
if it does no harm.

Thanks,
Yicong
