Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36185FB335
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJKNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJKNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:19:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE2595AD6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:17:15 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B6fDGN013696;
        Tue, 11 Oct 2022 13:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Qr9divMoNOS/Jb/k6HOevJMKwg1i2fVhs5g/kqvxtJw=;
 b=ck0lUA1cZ5VrSXUJ7LhB3MFM3h3E99DGyaWf/zDn6ztuV9lCJQZJ8EBPI40I4Ul1RJLR
 FVFMkmiEsx1ZlntY8O+c+T+fT6snNC5/gyyiz8HPvWUp+gWOjNavXb30f5JyLZaXzCDw
 SvBM/Zi5nSFnyp73LYhNTNw0990D2hL00OiOiAmsyShPKiPPdaLbdIght4b5Wv+Lrw+m
 zFOeeON7q1SJFmxFNaVWaj1QYwTSkma58HnNKuuT5Bz71o+E0UEPkgN/N1i/y1HLcIG3
 oC62rtoWgpgMF453FyND/vekY623+RdzEetxTzWsb4VYIY0uoNW+ZWZawAffs7URgvjd mQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx1akvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 13:16:27 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29BDGQQk023332;
        Tue, 11 Oct 2022 13:16:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jmasu3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 13:16:26 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29BDGQ89023324;
        Tue, 11 Oct 2022 13:16:26 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 29BDGQkW023323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 13:16:26 +0000
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 06:16:23 -0700
Message-ID: <3967aca6-3403-655d-d8eb-34312c2bb1b9@quicinc.com>
Date:   Tue, 11 Oct 2022 18:46:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        <linux-mm@kvack.org>, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221011104621.231-1-hdanton@sina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221011104621.231-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jGmngMsHltsLaHvw7_0cqQE2ZajrbRHG
X-Proofpoint-GUID: jGmngMsHltsLaHvw7_0cqQE2ZajrbRHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=502 clxscore=1011 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110076
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @Hilf,

Thanks for looking into this issue.

On 10/11/2022 4:16 PM, Hillf Danton wrote:
> On 10/10/22 06:24 Mukesh Ojha <quic_mojha@quicinc.com>
>> Hi Waiman,
>>
>> On 9/29/2022 11:36 PM, Waiman Long wrote:
>>> On 9/29/22 14:04, Waiman Long wrote:
>>>> A non-first waiter can potentially spin in the for loop of
>>>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>>>> lock even if the rwsem is free if the following sequence happens:
>>>>
>>>>     Non-first waiter       First waiter      Lock holder
>>>>     ----------------       ------------      -----------
>>>>     Acquire wait_lock
>>>>     rwsem_try_write_lock():
>>>>       Set handoff bit if RT or
>>>>         wait too long
>>>>       Set waiter->handoff_set
>>>>     Release wait_lock
>>>>                            Acquire wait_lock
>>>>                            Inherit waiter->handoff_set
>>>>                            Release wait_lock
>>>>                         Clear owner
>>>>                                              Release lock
>>>>     if (waiter.handoff_set) {
>>>>       rwsem_spin_on_owner(();
>>>>       if (OWNER_NULL)
>>>>         goto trylock_again;
>>>>     }
>>>>     trylock_again:
>>>>     Acquire wait_lock
>>>>     rwsem_try_write_lock():
>>>>        if (first->handoff_set && (waiter != first))
>>>>            return false;
>>>>     Release wait_lock
>>>>
>>>> It is especially problematic if the non-first waiter is an RT task and
>>>> it is running on the same CPU as the first waiter as this can lead to
>>>> live lock.
>>>>
>>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>>>> consistent")
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    kernel/locking/rwsem.c | 13 ++++++++++---
>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> Mukesh, can you test if this patch can fix the RT task lockup problem?
>>>
>>
>> Looks like, There is still a window for a race.
>>
>> There is a chance when a reader who came first added it's BIAS and
>> goes to slowpath and before it gets added to wait list it got
>> preempted by RT task which  goes to slowpath as well and being the
>> first waiter gets its hand-off bit set and not able to get the lock
>> due to following condition in rwsem_try_write_lock()

[]

>>
>>   630                 if (count & RWSEM_LOCK_MASK) {  ==> reader has
>> sets its bias
>> ..
>> ...
>>
>>   634
>>   635                         new |= RWSEM_FLAG_HANDOFF;
>>   636                 } else {
>>   637                         new |= RWSEM_WRITER_LOCKED;
>>
>>
>> ---------------------->----------------------->-------------------------
>>
>> First reader (1)          writer(2) RT task             Lock holder(3)
>>
>> It sets
>> RWSEM_READER_BIAS.
>> while it is going to
>> slowpath(as the lock
>> was held by (3)) and
>> before it got added
>> to the waiters list
>> it got preempted
>> by (2).
>>                         RT task also takes
>>                          the slowpath and add              release the
>>                          itself into waiting list          rwsem lock
>>              and since it is the first         clear the
>>                          it is the next one to get         owner.
>>                          the lock but it can not
>>                          get the lock as (count &
>>                          RWSEM_LOCK_MASK) is set
>>                          as (1) has added it but
>>                          not able to remove its
>>              adjustment.

[]

>>
> Hey Mukesh,
> 
> Can you test the diff if it makes sense to you?
> 
> It simply prevents the first waiter from spinning any longer after detecting
> it barely makes any progress to spin without lock owner.
> 
> Hillf
> 
> --- mainline/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -611,26 +611,15 @@ static inline bool rwsem_try_write_lock(
>   	long count, new;
>   
>   	lockdep_assert_held(&sem->wait_lock);
> +	waiter->handoff_set = false;
>   
>   	count = atomic_long_read(&sem->count);
>   	do {
>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>   
>   		if (has_handoff) {
> -			/*
> -			 * Honor handoff bit and yield only when the first
> -			 * waiter is the one that set it. Otherwisee, we
> -			 * still try to acquire the rwsem.
> -			 */
> -			if (first->handoff_set && (waiter != first))
> +			if (waiter != first)
>   				return false;

you mean, you want to check and change waiter->handoff_set on every run 
rwsem_try_write_lock().

But does it break optimistic spinning ? @waiman ?

-Mukesh

> -
> -			/*
> -			 * First waiter can inherit a previously set handoff
> -			 * bit and spin on rwsem if lock acquisition fails.
> -			 */
> -			if (waiter == first)
> -				waiter->handoff_set = true;
>   		}
>   
>   		new = count;
