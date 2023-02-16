Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60D699D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBPT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:58:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6186B50370
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:58:25 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GJl2Qn010011;
        Thu, 16 Feb 2023 19:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mgckVes69yuCbTDlHpNm0ysPRQ0NeCMuDv49FW64lTI=;
 b=quK5/3mWN/nr8Us1+YdiIhPt7htSUDWS+ffAv7Ggn0FhYVldgyNlQh4R9rJELQ4tL/Hg
 c3QtoLxosm0+wtFEXJYKcLJRPDG8uQLuC3DXcScJakChaP1MBZyfAVo2/seWK2LPBmhe
 Sl5hbH0aZPpv/Ht3Qm4KF/BTnaVcVUKWYuozQe43KruL9RvpdhvYLU96h8Je29gbI5ue
 y5fHGJa6w2+ERpETF3dEUIOdUOnaOErJOcBkYbGpmejuZR2QsUOBIvYeXlYhzYi9cPXO
 +VRAuqnk3osA81SIVxBu0dS9riTMbC36E5BUldcqSjCxJUieF0BvR9Ajk3s/CK5o3PbS Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nstnbgssy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 19:57:57 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GJlxvV016036;
        Thu, 16 Feb 2023 19:57:57 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nstnbgssn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 19:57:57 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GJHQZD024107;
        Thu, 16 Feb 2023 19:57:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3np2n7u6b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 19:57:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31GJvtGX8192762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 19:57:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030CC58053;
        Thu, 16 Feb 2023 19:57:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89BAD58059;
        Thu, 16 Feb 2023 19:57:50 +0000 (GMT)
Received: from [9.43.85.231] (unknown [9.43.85.231])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 19:57:50 +0000 (GMT)
Message-ID: <95f4ac27-490f-9189-8a3f-dace38153222@linux.vnet.ibm.com>
Date:   Fri, 17 Feb 2023 01:27:48 +0530
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
 <cd37483e-bf11-ec74-c240-74935bb44809@linux.vnet.ibm.com>
 <xm26bklu4ntv.fsf@google.com>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <xm26bklu4ntv.fsf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UJX6txYydrCW9iMQEA4reBYZyJQHGvMg
X-Proofpoint-GUID: 7UZJIjhk8kDYRos61ZUAAAKfWAFk5xV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_16,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302160168
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/23 3:02 AM, Benjamin Segall wrote:
> shrikanth hegde <sshegde@linux.vnet.ibm.com> writes:
> 
>>>>
>>>>              6.2.rc5                           with patch
>>>>         1CG    power   2CG    power   | 1CG  power     2CG        power
>>>> 1Core   218     44     315      46    | 219    45    277(+12%)    47(-2%)
>>>>         219     43     315      45    | 219    44    244(+22%)    48(-6%)
>>>> 	                              |
>>>> 2Core   108     48     158      52    | 109    50    114(+26%)    59(-13%)
>>>>         109     49     157      52    | 109    49    136(+13%)    56(-7%)
>>>>                                       |
>>>> 4Core    60     59      89      65    |  62    58     72(+19%)    68(-5%)
>>>>          61     61      90      65    |  62    60     68(+24%)    73(-12%)
>>>>                                       |
>>>> 8Core    33     77      48      83    |  33    77     37(+23%)    91(-10%)
>>>>          33     77      48      84    |  33    77     38(+21%)    90(-7%)
>>>>
>>>> There is no benefit at higher utilization of 50% or more. There is no
>>>> degradation also.
>>>>
>>>> This is RFC PATCH V2, where the code has been shifted from hrtimer to
>>>> sched. This patch sets an initial value as multiple of period/10.
>>>> Here timers can still align if the time started the cgroup is within the
>>>> period/10 interval. On a real life workload, time gives sufficient
>>>> randomness. There can be a better interleaving by being more
>>>> deterministic. For example, when there are 2 cgroups, they should
>>>> have initial value of 0/50ms or 10/60ms so on. When there are 3 cgroups,
>>>> 0/3/6ms or 1/4/7ms etc. That is more complicated as it has to account
>>>> for cgroup addition/deletion and accuracy w.r.t to period/quota.
>>>> If that approach is better here, then will come up with that patch.
>>>
>>> This does seem vaguely reasonable, though the power argument of
>>> consolidating wakeups and such is something that we intentionally do in
>>> other situations.
>>>
>> Thank you Benjamin for taking a look and spending time in reviewing this.
>>> How reasonable do you think it is to just say (and what do the
>>> equivalent numbers look like on your particular benchmark) "put some
>>> variance on your period config if you want variance"?
>>> Run to run variance is expected with this patch as the patch depends
>> on time upto last period/10 as the basis for interleaving. 
>> What i could infer from this comment about variance. Please correct if not.
> 
> My question is what the numbers look like if you instead prepare the
> cgroups with periods that are something like 97 ms and 103ms instead of
> both 100ms (keeping the quota as the same proportion as the original).

oh ok. If the cgroups are prepared with slightly different timer values, then
timers does interleave. That is expected as the difference would be small at
the beginning, goes to max at some point, then again would align later. Like
below

	  	|    /\
	  	|   /  \
        timer   |  /    \
   	delta	| /      \
		|/________\____

	           time -->

Did a set of experiments with the these three timer values. Here in all the
cases, each cgroup is allocated 25% of the runtime. There are 8 Core with SMT=8
(64 CPU). Values of 100ms/100ms not same as before, since this is run on
different machine as the previous one was not available. Hence kept 100/100
numbers as well.

                       6.2.rc6                    6.2.rc6 + with patch
Period    1CG    power  2CG    power   |  1CG     power   2CG        power
97/103    27.8     78   32.9     98    |  27.5    75      33.4        102
97/103    27.3     78   33      101    |  27.9    71      32.8         97

100/100   27.5     82   40.2     93    |  27.5    80      34.2        105
100/100   28       86   40.1     94    |  27.7    78      30.1        110

75/125    27.3     89   32.7    102    |  27.3    84      33          106
75/125    27.1     87   33      105    |  27.1    90      33.1        100

Few observations.
1. We get improved performance when the timers are slightly different from
   100ms.
2. If the timers have slight variance, there is no difference with patch.
3. power numbers vary bit more, when the timers have variance. This maybe
   because the idle/exit aren't aligning.
4. The best interleaving is still not possible if the timers have variance.
   that can happen only with deterministic interleaving. patch can hope to
   achieve that. But not always.
