Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ECF5F0F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiI3QEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiI3QDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:03:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371AB1BEA74
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:03:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UA9QXN030796;
        Fri, 30 Sep 2022 16:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5jMW+3Ay/m0YBdYZGwFvJ1e+NtHYBVAOmN5xr+XfiiI=;
 b=WkQFFD87H9pXNzxwKA6gD3PjdBJ+GfBXvtWj9IxPyuAQR4qKWRNLUBJt5/CHllj3mURm
 RcTWg/Nl7+fUfLUyli08u8CGiIY2Zb/PSYnOCyBKTZFvB6/ANGYzeJ0rYziT4JmvWmwM
 rbf9dz1l1vPWaJ/C4W4Aq6kHYBfhESHuSclVd7OyoWNvV31sRtCGl5sbOmAFvzd3d/OI
 6wqxIaLEo4VhHTmaDQF811Ho9+fJZVN+uZ2NaDkyZzuuxwSZLY7LwDf+aNEm+Lesjw8r
 INM9IBTKy1aeyOt8vbRWAUs7S3p4T0L/qrfXlDZ9Fa/Ut6Hn/fm62fSrHwacIpx2lcE0 TA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwx18h72y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 16:03:27 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28UG3RUn027409;
        Fri, 30 Sep 2022 16:03:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jwvbrc4be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 16:03:27 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UG3Q1x027403;
        Fri, 30 Sep 2022 16:03:26 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 28UG3QaE027400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 16:03:26 +0000
Received: from [10.216.24.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 09:03:23 -0700
Message-ID: <eb84aeef-7232-5063-c907-a6810aaba2ea@quicinc.com>
Date:   Fri, 30 Sep 2022 21:33:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        Hillf Danton <hdanton@sina.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <7f204676-501b-4c74-2d44-6abbeca5f53e@quicinc.com>
 <285ba94c-04fc-413f-d16f-d4628caee9f2@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <285ba94c-04fc-413f-d16f-d4628caee9f2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pa7V-XPZGyH9trcyG6Cx2YZluQi4-i6y
X-Proofpoint-GUID: pa7V-XPZGyH9trcyG6Cx2YZluQi4-i6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300101
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/30/2022 7:38 PM, Waiman Long wrote:
> On 9/30/22 01:06, Mukesh Ojha wrote:
>> Hi,
>>
>> On 9/29/2022 11:34 PM, Waiman Long wrote:
>>> A non-first waiter can potentially spin in the for loop of
>>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>>> lock even if the rwsem is free if the following sequence happens:
>>>
>>>    Non-first waiter       First waiter      Lock holder
>>>    ----------------       ------------      -----------
>>>    Acquire wait_lock
>>>    rwsem_try_write_lock():
>>>      Set handoff bit if RT or
>>>        wait too long
>>>      Set waiter->handoff_set
>>>    Release wait_lock
>>>                           Acquire wait_lock
>>>                           Inherit waiter->handoff_set
>>>                           Release wait_lock
>>>                        Clear owner
>>>                                             Release lock
>>>    if (waiter.handoff_set) {
>>>      rwsem_spin_on_owner(();
>>>      if (OWNER_NULL)
>>>        goto trylock_again;
>>>    }
>>>    trylock_again:
>>>    Acquire wait_lock
>>>    rwsem_try_write_lock():
>>>       if (first->handoff_set && (waiter != first))
>>>           return false;
>>>    Release wait_lock
>>>
>>> It is especially problematic if the non-first waiter is an RT task and
>>> it is running on the same CPU as the first waiter as this can lead to
>>> live lock.
>>>
>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>>> consistent")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/locking/rwsem.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>>> index 65f0262f635e..ad676e99e0b3 100644
>>> --- a/kernel/locking/rwsem.c
>>> +++ b/kernel/locking/rwsem.c
>>> @@ -628,6 +628,11 @@ static inline bool rwsem_try_write_lock(struct 
>>> rw_semaphore *sem,
>>>           new = count;
>>>             if (count & RWSEM_LOCK_MASK) {
>>> +            /*
>>> +             * A waiter (first or not) can set the handoff bit
>>> +             * if it is an RT task or wait in the wait queue
>>> +             * for too long.
>>> +             */
>>>               if (has_handoff || (!rt_task(waiter->task) &&
>>>                           !time_after(jiffies, waiter->timeout)))
>>
>> Not related to this issue, however wanted to understand the idea about 
>> this.
>>
>> If RT task comes in any order either come first or later it is setting 
>> the RWSEM_FLAG_HANDOFF bit.
>> So, here we are giving some priority right a way to RT task however it
>> can not get waiter->handoff_set=true since it is not the first 
>> waiter.(after this patch), is it not conflicting ?
> 
> I have thought about moving the RT task forward in the wait queue, but 
> then it will greatly complicate the code to try to do what a PREEMPT_RT 
> kernel does using a rt_mutex variant of rwsem. The reason why HANDOFF 
> bit is set when an RT task is in the wait queue is speed up the 
> progression of the wait queue without the interference of optimistic 
> spinner.
> 

Thanks for taking time to explain the motivation behind it.

It will take sometime to test your patch from our side however, like the 
other patches this patch too seem to fix the issue.

Feel free to add
  Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
  Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>>
>>
>> Why can't we just keep like as below and not set
>> new |= RWSEM_FLAG_HANDOFF; and return false from here.
>>
>> --------------0<------------------------------------
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 65f0262..dbe3e16 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -628,8 +628,8 @@ static inline bool rwsem_try_write_lock(struct
>> rw_semaphore *sem,
>>                  new = count;
>>
>>                  if (count & RWSEM_LOCK_MASK) {
>> -                       if (has_handoff || (!rt_task(waiter->task) &&
>> -                                           !time_after(jiffies,
>> waiter->timeout)))
>> +                       if (has_handoff || (rt_task(waiter->task) &&
>> waiter != first) ||
>> +                          (!rt_task(waiter->task) &&
>> !time_after(jiffies, waiter->timeout)))
>>                                  return false;
>>
> As I said above, we want to make more forward progress in the wait queue 
> if a RT task is waiting there to try to reduce its latency. That is the 
> point of that if statement.
> 
> Cheers,
> Longman
> 
> 
