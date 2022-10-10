Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D65F9CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJJK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiJJKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:25:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9511C0A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:25:50 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AACZAf005156;
        Mon, 10 Oct 2022 10:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vOwX8r6ScLfGOUCmdZnw2ho6CygR/ZS4NM5v9dQn99c=;
 b=C5Qsg9FPNFkuIr5FJiKhHluoSyNxkIoCoGGOt9TBF3Q21ijbj2Yda/KgDRRqAn+fniOS
 /YULuyXO3FsStVGLXSFc44FZQcNPA9CKSZw/KYD52dZtpLOLHl7bHd66TwOvvKYzlq3/
 Tisj9mNT9zQEl9eSQ/TS93lzMXESlayh6KT7y5MG4LyWbF8CUC36HuU0AgILnIGt/Jw5
 AvrAEx7cMXPQLIVEXuRtpJ0IM9AirGfj6EhUd9OHb6jwLP2WMmACLq4l5GaTiZzbsJ8Y
 b00JXjNWYteOwUuexosibiqGeRTTDxNKLUbNMg9QSYyAtz+ka0PIiJnYuua9oMJMVznN Gg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31ghbka2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 10:25:07 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29AAKZcf020407;
        Mon, 10 Oct 2022 10:25:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jmagcm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 10:25:06 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29AAKYB4020399;
        Mon, 10 Oct 2022 10:25:05 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 29AAP5cc025855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 10:25:05 +0000
Received: from [10.216.39.143] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 03:25:02 -0700
Message-ID: <7cbf49c9-d122-30e6-68b3-c61eca63e5dc@quicinc.com>
Date:   Mon, 10 Oct 2022 15:54:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <6530f135-e8ac-bb6c-4715-1ea8f76cf4c4@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <6530f135-e8ac-bb6c-4715-1ea8f76cf4c4@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pY_mDzgPn8g2cY7-BfVEofWMuzlZUh9f
X-Proofpoint-ORIG-GUID: pY_mDzgPn8g2cY7-BfVEofWMuzlZUh9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_05,2022-10-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=557 priorityscore=1501
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100062
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,


On 9/29/2022 11:36 PM, Waiman Long wrote:
> On 9/29/22 14:04, Waiman Long wrote:
>> A non-first waiter can potentially spin in the for loop of
>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>> lock even if the rwsem is free if the following sequence happens:
>>
>>    Non-first waiter       First waiter      Lock holder
>>    ----------------       ------------      -----------
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>      Set handoff bit if RT or
>>        wait too long
>>      Set waiter->handoff_set
>>    Release wait_lock
>>                           Acquire wait_lock
>>                           Inherit waiter->handoff_set
>>                           Release wait_lock
>>                        Clear owner
>>                                             Release lock
>>    if (waiter.handoff_set) {
>>      rwsem_spin_on_owner(();
>>      if (OWNER_NULL)
>>        goto trylock_again;
>>    }
>>    trylock_again:
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>       if (first->handoff_set && (waiter != first))
>>           return false;
>>    Release wait_lock
>>
>> It is especially problematic if the non-first waiter is an RT task and
>> it is running on the same CPU as the first waiter as this can lead to
>> live lock.
>>
>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>> consistent")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/locking/rwsem.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Mukesh, can you test if this patch can fix the RT task lockup problem?
>

Looks like, There is still a window for a race.

There is a chance when a reader who came first added it's BIAS and goes 
to slowpath and before it gets added to wait list it got preempted by RT 
task which  goes to slowpath as well and being the first waiter gets its 
hand-off bit set and not able to get the lock due to following condition 
in rwsem_try_write_lock()

  630                 if (count & RWSEM_LOCK_MASK) {  ==> reader has 
sets its bias
..
...

  634
  635                         new |= RWSEM_FLAG_HANDOFF;
  636                 } else {
  637                         new |= RWSEM_WRITER_LOCKED;


---------------------->----------------------->-------------------------

First reader (1)    	  writer(2) RT task             Lock holder(3)

It sets
RWSEM_READER_BIAS.
while it is going to
slowpath(as the lock
was held by (3)) and
before it got added
to the waiters list
it got preempted
by (2).
                         RT task also takes
                         the slowpath and add              release the 

                         itself into waiting list          rwsem lock 

			and since it is the first         clear the
                         it is the next one to get         owner.
                         the lock but it can not
                         get the lock as (count &
                         RWSEM_LOCK_MASK) is set
                         as (1) has added it but
                         not able to remove its
			adjustment.


-Mukesh


> Thanks,
> Longman
> 
