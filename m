Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9E6831DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjAaPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjAaPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:51:31 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F3457C0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:51:16 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VFLcnU020662;
        Tue, 31 Jan 2023 15:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qjXXVK0zkU1ANWo0rs8zm6gUVBVlTWW6LHxz1BED2Eg=;
 b=U4/134DeLvtIKwpKhJbtk5IlZxjuOdQdf64yVixrR44mb/vg/mMla9AqOsrKPfQC4UDx
 w0t3a2xq8jeJxxVe7xAcZm9fz4pQMZoprsPN0W6ZBhrEn/qAf2YZ89pHsS+l3cvNo/Xv
 HbcIKzy7aGQoykMUjBCX02bqKpYHk7FVvNgniUI7LeeIgE9/RR4XnfTmT1iHMa7GwcAe
 N/azgkKRlATEe5+f8TC5J22Dj4eHTalb1r5szliK7KSizYJ0TjXqrgE59/Q54+rqAO30
 Lf5oTv2fvNep5dJnc5FUCz5NjFMFAfRzNabSXUeRfd3TuQVsz7vAr4x7Dc917gwrHaJ7 8w== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf44tkgfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:51:01 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VFo37w004994;
        Tue, 31 Jan 2023 15:51:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ncvv1rryy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:51:00 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFoxQt62849304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:51:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC0D758063;
        Tue, 31 Jan 2023 15:50:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C83F5805F;
        Tue, 31 Jan 2023 15:50:56 +0000 (GMT)
Received: from [9.160.34.223] (unknown [9.160.34.223])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:50:55 +0000 (GMT)
Message-ID: <adb4042b-4fd9-4a64-5904-b00c4ae8d473@linux.vnet.ibm.com>
Date:   Tue, 31 Jan 2023 21:20:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] hrtimer: interleave timers for improved single thread
 performance at low utilization
Content-Language: en-US
To:     Arjan van de Ven <arjan@linux.intel.com>, tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
References: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
 <c6c106a2-b180-d3fd-5904-44f9b4949ddc@linux.intel.com>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <c6c106a2-b180-d3fd-5904-44f9b4949ddc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h-3fOSmkEDVFN1llDFbOuxg9VbsdIbVo
X-Proofpoint-GUID: h-3fOSmkEDVFN1llDFbOuxg9VbsdIbVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 8:25 PM, Arjan van de Ven wrote:
> 
>>   kernel/time/hrtimer.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
>> index 3ae661ab6260..d160f49f0cce 100644
>> --- a/kernel/time/hrtimer.c
>> +++ b/kernel/time/hrtimer.c
>> @@ -1055,6 +1055,17 @@ u64 hrtimer_forward(struct hrtimer *timer,
>> ktime_t now, ktime_t interval)
>>
>>           orun = ktime_divns(delta, incr);
>>           hrtimer_add_expires_ns(timer, incr * orun);
>> +        /*
>> +         * Avoid timer round-off, so that all cfs bandwidth timers
>> +         * don't start at the same time
> 
> so while I applaud the final objective, I am sort of wondering if
> hrtimer.c is the right place in the kernel to fix a CFS/cgroup issue...
> wouldn't it be better to solve such issues at the place we want this to
> happen, rather than for all timers in the whole system?
> 
Agree. It was an initial approach to the problem. This can be fixed in scheduler 
code itself as suggested by Ingo. Will send out that patch soon. 
> (also while for performance it might be better to spread out a bit, for
> power consumption it's obviously the other way around)
> 
This would be performance vs power comparison. Would get both the 
numbers next time for fairer comparison. 

