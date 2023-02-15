Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50769697A60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjBOLCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBOLCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:02:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB5F728B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:02:21 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FAqtr2031029;
        Wed, 15 Feb 2023 11:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GvEaY5bydKZJn+QAN1BQnQGlNZ/fZLboxdbW/XHAYOk=;
 b=FaJC3ovOpdUofks/1iPT1/CvWWZUXfnNtGOpsVu+4JCW3/GaE2KvX9q2llCZ5wJq6gtY
 Zc4iYRwqXXnRw2OtRnAnV1dF2F96tZ9JlLEvcnasSS8+QYoEH6tuggIfouetF5HQ7PBg
 M88HsIKRUUpRERDhpI+3RyHLOmda4LBzhRe96q67+Ab7H5EQf0qxerACH/d5iifT1I28
 aq6um08ABHZ0AK6ERH4b+iVDKDa5vXHQStBfTzNebjR8SSryszTqhWWpYFTnzwS3z+Qy
 DSpVxseiwSyGzhiRacaryyimfJu8eg4yKSorNHe1p7QHnjUOQZEo041cmQC/ne5QbFNH vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrx1gr6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 11:02:07 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FAuGdg012078;
        Wed, 15 Feb 2023 11:01:50 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrx1gr6cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 11:01:49 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31F9Wb6O021425;
        Wed, 15 Feb 2023 11:01:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3np2n7cext-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 11:01:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FB1YiB34669220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 11:01:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885FF58065;
        Wed, 15 Feb 2023 11:01:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2476758071;
        Wed, 15 Feb 2023 11:01:31 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 11:01:30 +0000 (GMT)
Message-ID: <cd37483e-bf11-ec74-c240-74935bb44809@linux.vnet.ibm.com>
Date:   Wed, 15 Feb 2023 16:31:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20230214120502.934324-1-sshegde@linux.vnet.ibm.com>
 <xm268rh06i97.fsf@google.com>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <xm268rh06i97.fsf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WLD8C-Aymj7zj5MsBAkHSQC9FLJd5wFy
X-Proofpoint-ORIG-GUID: EJ9tTDSza_RTiEcLTAmZ9hWpXjcRT5tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150097
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>              6.2.rc5                           with patch
>>         1CG    power   2CG    power   | 1CG  power     2CG        power
>> 1Core   218     44     315      46    | 219    45    277(+12%)    47(-2%)
>>         219     43     315      45    | 219    44    244(+22%)    48(-6%)
>> 	                              |
>> 2Core   108     48     158      52    | 109    50    114(+26%)    59(-13%)
>>         109     49     157      52    | 109    49    136(+13%)    56(-7%)
>>                                       |
>> 4Core    60     59      89      65    |  62    58     72(+19%)    68(-5%)
>>          61     61      90      65    |  62    60     68(+24%)    73(-12%)
>>                                       |
>> 8Core    33     77      48      83    |  33    77     37(+23%)    91(-10%)
>>          33     77      48      84    |  33    77     38(+21%)    90(-7%)
>>
>> There is no benefit at higher utilization of 50% or more. There is no
>> degradation also.
>>
>> This is RFC PATCH V2, where the code has been shifted from hrtimer to
>> sched. This patch sets an initial value as multiple of period/10.
>> Here timers can still align if the time started the cgroup is within the
>> period/10 interval. On a real life workload, time gives sufficient
>> randomness. There can be a better interleaving by being more
>> deterministic. For example, when there are 2 cgroups, they should
>> have initial value of 0/50ms or 10/60ms so on. When there are 3 cgroups,
>> 0/3/6ms or 1/4/7ms etc. That is more complicated as it has to account
>> for cgroup addition/deletion and accuracy w.r.t to period/quota.
>> If that approach is better here, then will come up with that patch.
> 
> This does seem vaguely reasonable, though the power argument of
> consolidating wakeups and such is something that we intentionally do in
> other situations.
> 
Thank you Benjamin for taking a look and spending time in reviewing this.
> How reasonable do you think it is to just say (and what do the
> equivalent numbers look like on your particular benchmark) "put some
> variance on your period config if you want variance"?
>Run to run variance is expected with this patch as the patch depends
on time upto last period/10 as the basis for interleaving. 
What i could infer from this comment about variance. Please correct if not.

>>
>> Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
>> ---
>>  kernel/sched/fair.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
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
> 
> Probably could have a short comment here that's something like "forward
> the hrtimer by period / 10 to reduce synchronized wakeups"
> 
Sure. Will do in the next version of this patch. 

>> +		orun = ktime_divns(delta, incr);
>> +		hrtimer_add_expires_ns(period_timer, incr * orun);
>> +	}
>> +
>> +	hrtimer_forward_now(period_timer, cfs_b->period);
>> +	hrtimer_start_expires(period_timer, HRTIMER_MODE_ABS_PINNED);
>>  }
>>
>>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>> --
>> 2.31.1
