Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400EE6A1695
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBXGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 01:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:25:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F94DBC3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:25:44 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O6NuqR005767;
        Fri, 24 Feb 2023 06:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dUsi2PYpNXkeWSuAKCGpm+wwkFewMWEzA3bwsg8WyoQ=;
 b=bCeREzb6RL1xW5a5MVWiTsYB3VCbOnEzwxbNTCI+TEDsS6CzSEeZMeU21Jf+HymS12hK
 JcalKz/B97snRKnI7ic2yKKrve8Wg6TGBQTBGyP32rGN1R8tttzMYXFh2++nE6dySLCB
 W+AlXpdvBGlnj21tV664gkmZm4FZ4n69MsBPGYM5fjSy0nntZVEzhUbGrodHy8WEHlp5
 sWcyZ3yegiAW3xNGbP+UalEjXUkHo0T0zzcd/yHk678HON5aTJvt/acvwg9H+b/h1Mv0
 ZigeuwtbU8Dj+cOopsPhmHLKzy7DABdDET1tKAiOthFtLFngiowKk1U4L1YpJEubNnf6 rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxqxe80yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 06:25:32 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31O6O52l006633;
        Fri, 24 Feb 2023 06:25:31 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxqxe80y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 06:25:31 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31O5rUZt014115;
        Fri, 24 Feb 2023 06:25:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa7j842-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 06:25:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31O6PTFq10682990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 06:25:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96985805D;
        Fri, 24 Feb 2023 06:25:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1611E58043;
        Fri, 24 Feb 2023 06:25:25 +0000 (GMT)
Received: from [9.43.73.248] (unknown [9.43.73.248])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Feb 2023 06:25:24 +0000 (GMT)
Message-ID: <df3c173b-977c-0d45-bfb0-5ffc02f5dac4@linux.vnet.ibm.com>
Date:   Fri, 24 Feb 2023 11:55:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20230224014922.2883-1-hdanton@sina.com>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230224014922.2883-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W3lslY_AIlvhsH5MFPgQvzGxMsTbQ4JC
X-Proofpoint-ORIG-GUID: sWQm24i2YWTg-P1-Z3jcsnHVY-S8nijS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_02,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302240049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 7:19 AM, Hillf Danton wrote:
> On Fri, 24 Feb 2023 00:29:18 +0530 Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> @@ -5923,6 +5923,10 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
>>  	cfs_b->period_timer.function = sched_cfs_period_timer;
>> +
>> +	/* Add a random offset so that timers interleave */
>> +	hrtimer_set_expires(&cfs_b->period_timer,
>> +			    get_random_u32_below(cfs_b->period));
>>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>>  	cfs_b->slack_started = false;
>> --
>> 2.31.1
> 
> Could you specify what sense this makes, given hrtimer_forward_now() in
> start_cfs_bandwidth() and sched_cfs_period_timer(), which makes the
> timer expire after now? Why does the randomness at init time play a role
> at start time and run time?

Currently, Initial value is not set for period_timer. Expiry is calculated as 
expiry = $INITIAL_EXPIRYVALUE + $N * $PERIOD

Hence, when there are two or more CPU cgroup's using bandwidth controller, 
two period_timers would align at expiry. 

Adding a random offset play a role only at the start time, and no impact on the 
run time. By adding offset, the different period_timer interleave, and we would get
the benefit of SMT folding, less context switch's and less hypervisor preemptions.

More details are in RFC PATCH:
https://lore.kernel.org/lkml/9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com/
