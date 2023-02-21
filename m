Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04F69E7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBUSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBUSxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:53:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE313D65
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:53:37 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LIHMQ6003421;
        Tue, 21 Feb 2023 18:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DlLZf304xK4dppGNxnERjFixbeS44SNmT7Z/AkRJH9U=;
 b=GYWxG16Bumifxnx8cZGm56t4FCqFBX63KdrvGqk8bVBEv97nCqMqXqwCGm4bKiImGWrW
 r8TF/Fj0z//9apr8WAPgiCUoSblKPav77bmXxvTyKALCu+eh/7E5dHSKpgUPqTztKANR
 Wou8niP/BFbK9rxtq+HZpkYLeF1SKTqjq5+KuS52Rzllstgih4pPOhL7euTurssGGDGk
 6JL7LCzSRlWPuaZc01Np2mn37bEusX+8/vHLOdTeEFQrooiQ2ddCS+25f4IaURiPVBOx
 p3Uk/iOtcBukhw0lLTeWLFfgFjm7sdiz9HWxvQLiMGZAld5RYrGpvmqkc0vNPHVwTXsJ qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw33t0rdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 18:53:13 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LIopQo029116;
        Tue, 21 Feb 2023 18:53:12 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw33t0rd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 18:53:12 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LHLOFa015814;
        Tue, 21 Feb 2023 18:53:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6v7w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 18:53:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LIrAor29950302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 18:53:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91C3E5805A;
        Tue, 21 Feb 2023 18:53:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0E15803F;
        Tue, 21 Feb 2023 18:53:07 +0000 (GMT)
Received: from [9.43.27.178] (unknown [9.43.27.178])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 18:53:06 +0000 (GMT)
Message-ID: <0c4d7bbb-3fef-031e-e9a1-a678ab68ade7@linux.vnet.ibm.com>
Date:   Wed, 22 Feb 2023 00:23:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, bsegall@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
References: <9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com>
 <Y/Ov+DzOtA0iHfFO@hirez.programming.kicks-ass.net>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <Y/Ov+DzOtA0iHfFO@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JnQaBpqFzLwVvXJRXJRrksozvY9v6DnN
X-Proofpoint-ORIG-GUID: aQrK8iRf3Bh079OsjEk7x-P0IKVk14lF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_11,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/23 11:08 PM, Peter Zijlstra wrote:
> On Tue, Feb 14, 2023 at 08:54:09PM +0530, shrikanth hegde wrote:
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ff4dbbae3b10..7b69c329e05d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5939,14 +5939,25 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>
>>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>  {
>> -	lockdep_assert_held(&cfs_b->lock);
>> +	struct hrtimer *period_timer = &cfs_b->period_timer;
>> +	s64 incr = ktime_to_ns(cfs_b->period) / 10;
>> +	ktime_t delta;
>> +	u64 orun = 1;
>>
>> +	lockdep_assert_held(&cfs_b->lock);
>>  	if (cfs_b->period_active)
>>  		return;
>>
>>  	cfs_b->period_active = 1;
>> -	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>> -	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>> +	delta = ktime_sub(period_timer->base->get_time(),
>> +			hrtimer_get_expires(period_timer));
>> +	if (unlikely(delta >= cfs_b->period)) {
>> +		orun = ktime_divns(delta, incr);
>> +		hrtimer_add_expires_ns(period_timer, incr * orun);
>> +	}
>> +
>> +	hrtimer_forward_now(period_timer, cfs_b->period);
>> +	hrtimer_start_expires(period_timer, HRTIMER_MODE_ABS_PINNED);
>>  }
> 
> What kind of mad hackery is this? Why can't you do the sane thing and
> initialize the timer at !0 in init_cfs_bandwidth(), then any of the
> forwards will stay in period -- as they should.
> 
> Please, go re-read Thomas's email.

Thank you Peter for taking a look and review.
we can scrap this implementation and switch to the one you suggested.
All we need is to initialize the offset. 

Only reason was the way i had implemented. This implementation couldn't be
fit into init_cfs_bandwidth as timers would align if the cgroups are 
created together and continue to align forever. 

> 
> *completely* untested...
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7c46485d65d7..4d6ea76096dc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5915,6 +5915,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> 
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> +	cfs_b->period_timer.node.expires = get_random_u32_below(cfs_b->period);

This approach/implementation is better as the random function provides uniform  
distribution. Had to modify this a bit to make it work.  Along with setting     
setting node.expires, we need to set _softexpires as well. Which is what        
hrtimer_set_expires does.

Here are the similar numbers again.
8 Core system with SMT=8. Total of 64 CPU                                       
Workload: stress-ng --cpu=32 --cpu-ops=50000                                    
                                                                                
           6.2-rc6                     |   with patch                           
8Core   1CG    power    2CG     power  |  1CG    power  2CG    power           
        27.5    80.6    40      90     |  27.3    82    32.3    104             
        27.5    81      40.2    91     |  27.5    81    38.7     96             
        27.7    80      40.1    89     |  27.6    80    29.7    115             
        27.7    80.1    40.3    94     |  27.6    80    31.5    105   

Will collect some more benchmarks numbers w.r.t to performance.


>  	cfs_b->period_timer.function = sched_cfs_period_timer;
>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;

This below patch worked. 
Does the below patch look okay? shall i send the [PATCH V1] with this change? 

Question. 
Should we skip this adding the offset for root_task_group? 


---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff4dbbae3b10..6448533178af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5923,6 +5923,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
+	/* Add a random offset so that timers interleave */
+	hrtimer_set_expires(&cfs_b->period_timer, get_random_u32_below(cfs_b->period));
+
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->slack_started = false;
-- 
2.31.1

