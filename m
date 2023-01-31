Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C888682C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjAaMJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjAaMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:09:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAD14615A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:09:37 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VBq2vI024659;
        Tue, 31 Jan 2023 12:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=//ohG+qx1hafpckQC0F6KtxoLi9BJVlsVGFAjiaO7a8=;
 b=VKvIwLIRvD8LbMu180Nz98+wumbnd11siUlykrXtZvYAbQeXpoSSv2+ONORaAj+gGvme
 3Y7qG+JzD95YLuyn2yuN3VJhrMSZD9SsPnvxkxyE1k8LWsUcylN4nW5FwliI7bXc/gje
 UzztEp3C+2lZd3AfnvYULyECvijFEuwZ3Ni3glYW5VxO9RgEGQz07hFR7WwBUg+gn4aq
 SwO7Vt8bDpaWhq+9dHpJp2+sPZoEataCugpcpve//BASHRWs7TaiNqy5Dmmc6iWQ2iuR
 4CEUjPv5qsnvGwnyGa/vddqlputxjQtavBaGXKWltWdFRRlpfjv5gFjOMbHZAGSyqwBt ZA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf05g3wx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 12:09:19 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VAaW62006681;
        Tue, 31 Jan 2023 12:09:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtmbsvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 12:09:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VC9GO56619682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 12:09:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 821BD5805F;
        Tue, 31 Jan 2023 12:09:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2287B58053;
        Tue, 31 Jan 2023 12:09:13 +0000 (GMT)
Received: from [9.160.34.223] (unknown [9.160.34.223])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 12:09:12 +0000 (GMT)
Message-ID: <711dc967-b4cf-807b-6c74-5c9d914ab619@linux.vnet.ibm.com>
Date:   Tue, 31 Jan 2023 17:39:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] hrtimer: interleave timers for improved single thread
 performance at low utilization
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, arjan@linux.intel.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
References: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
 <Y9jvWCGGICsKGPFt@gmail.com>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <Y9jvWCGGICsKGPFt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZLbiY8v0lMRYxSBKGHlxZitCTkUtIywS
X-Proofpoint-GUID: ZLbiY8v0lMRYxSBKGHlxZitCTkUtIywS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=922 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 4:07 PM, Ingo Molnar wrote:
> 
> * shrikanth hegde <sshegde@linux.vnet.ibm.com> wrote:
> 
>> ---
>>  kernel/time/hrtimer.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
>> index 3ae661ab6260..d160f49f0cce 100644
>> --- a/kernel/time/hrtimer.c
>> +++ b/kernel/time/hrtimer.c
>> @@ -1055,6 +1055,17 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
>>
>>  		orun = ktime_divns(delta, incr);
>>  		hrtimer_add_expires_ns(timer, incr * orun);
>> +		/*
>> +		 * Avoid timer round-off, so that all cfs bandwidth timers
>> +		 * don't start at the same time
>> +		 */
>> +		if (incr >= 100000000ULL) {
>> +			s64 interleave = 0;
>> +			interleave = ktime_sub_ns(delta,  incr * orun);
>> +			interleave = interleave - (ktime_to_ns(delta) % (incr/10));
>> +			if (interleave > 0)
>> +				hrtimer_add_expires_ns(timer, interleave);
>> +		}
> 
> Any reason why you did this in the hrtimer code, instead of the 
> (sched_cfs_period_timer?) hrtimer handler itself?
> 
> Thanks,
> 
> 	Ingo


Yes. Thanks for making me think in that way.                                       
This can be done in start_cfs_bandwidth by setting an initial expiry value.     
Tried that change. it works in interleaving the timers.                         
                                                                                
Will do bit more testing and send out the patch.
