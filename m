Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B45F03E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiI3EvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiI3EvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:51:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7615AC6D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:50:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U4EutM005382;
        Fri, 30 Sep 2022 04:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sP6UpacFkFm5je8CGJngdCieTza/ZwdDyOCryyC7wmk=;
 b=D8ok5QWvJ0CqOzK1B0DwaOlf8Ei0etOJaEVBCgea2pkWmF5mE3GLl6QLLirnHb5b+y4M
 897yrkiquIsR7yTD9wHOXthMVIqAjKUGg5rcG7fkNTETHsq2WUDNQWLflpmNrQ2py/tR
 wNPx1DEK6lHC8wqccNNiDait10zTga9ANM4UcdHTLt+GcX7cNO3vzLXBgIqC7WYs+cVx
 XWoWtiQNRUTUjLPf5Ff6tjrxJumujytE5RQOXcxTIfbVgdBi6rPHuCDoNrdpMrpG2N5g
 egNNvKL7GlXRWgA35Hg7HyaDC92xpnTrdx0v31kr/Ch0UQsNpBLq0QHykWYq12D6adJz ww== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jw4xqc2qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 04:47:39 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28U4lcpF018647;
        Fri, 30 Sep 2022 04:47:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jv2thp7ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 04:47:38 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28U4lcLA018642;
        Fri, 30 Sep 2022 04:47:38 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 28U4lc5F018639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 04:47:38 +0000
Received: from [10.216.24.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 21:47:35 -0700
Message-ID: <4e1697d7-9c13-12c9-74bc-dcb97ee2a659@quicinc.com>
Date:   Fri, 30 Sep 2022 10:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IDsng0IyPjJ5PfkVBNzW5Tirhro_Zy65
X-Proofpoint-ORIG-GUID: IDsng0IyPjJ5PfkVBNzW5Tirhro_Zy65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_03,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=434
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300027
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

I will come back with the result.

Thank you.

> 
> Thanks,
> Longman
> 
