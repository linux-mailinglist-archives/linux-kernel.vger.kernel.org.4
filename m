Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9955FC72E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJLOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:23:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48968CAE61
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:23:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CD0muc017279;
        Wed, 12 Oct 2022 14:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PRW/2/fRIv7d03QR537k/skVaguWmvCr4VxXjGui+SQ=;
 b=KADJvVFyyDNFaCpjvxOa/l17neNdBVMmxeiXc48ulA9XjlcoN+rr1LSbvve91usLh+gO
 mVmoxGlyl6rbhHds6un6r6f4nTSBY9oDbOolXspKDYGomXE41ceonCONG8zVzBMjHgPY
 vIYJlwhfX10/G9cKpflkOq9h1i+0tlkLLLQHWz4BmZjA9XE9FU+DVkt59J63zIiNm5b2
 99FnHc9wH4QCcYQ2hrm3q/fLPL/waERW2lunxO6BG4Zs2PQcsJpa/uM0w+KE//M8HOsh
 e3B2TJUrM3wZxbVTIygyMtaBpTdw5jtuVLB7ayL9oMOiZ2jkyn0gSZH1tsxLLM5w3pyu 1A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5kar206p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:23:13 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29CELTFq010923;
        Wed, 12 Oct 2022 14:23:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jmb3ex4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:23:13 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CEND8a014269;
        Wed, 12 Oct 2022 14:23:13 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 29CENCLd014264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:23:12 +0000
Received: from [10.216.35.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 07:23:09 -0700
Message-ID: <d85422c0-9124-309e-e854-2ac228f5b792@quicinc.com>
Date:   Wed, 12 Oct 2022 19:53:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] locking/rwsem: Prevent non-first waiter from
 spinning in down_write() slowpath
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221012133333.1265281-1-longman@redhat.com>
 <20221012133333.1265281-2-longman@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221012133333.1265281-2-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MX2b5TFpKBJX8zq3ZYDc7gsoHw_oxz1V
X-Proofpoint-GUID: MX2b5TFpKBJX8zq3ZYDc7gsoHw_oxz1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=816 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120094
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 10/12/2022 7:03 PM, Waiman Long wrote:
> A non-first waiter can potentially spin in the for loop of
> rwsem_down_write_slowpath() without sleeping but fail to acquire the
> lock even if the rwsem is free if the following sequence happens:
> 
>    Non-first waiter       First waiter      Lock holder
>    ----------------       ------------      -----------
>    Acquire wait_lock
>    rwsem_try_write_lock():
>      Set handoff bit if RT or
>        wait too long
>      Set waiter->handoff_set
>    Release wait_lock
>                           Acquire wait_lock
>                           Inherit waiter->handoff_set
>                           Release wait_lock
> 					   Clear owner
>                                             Release lock
>    if (waiter.handoff_set) {
>      rwsem_spin_on_owner(();
>      if (OWNER_NULL)
>        goto trylock_again;
>    }
>    trylock_again:
>    Acquire wait_lock
>    rwsem_try_write_lock():
>       if (first->handoff_set && (waiter != first))
>       	return false;
>    Release wait_lock
> 
> It is especially problematic if the non-first waiter is an RT task and
> it is running on the same CPU as the first waiter as this can lead to
> live lock.
> 
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
> Signed-off-by: Waiman Long <longman@redhat.com>

Since this patch is tested and it covers the mentioned scenario.

Reviewed-and-Tested-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   kernel/locking/rwsem.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 44873594de03..3839b38608da 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -636,6 +636,11 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   		new = count;
>   
>   		if (count & RWSEM_LOCK_MASK) {
> +			/*
> +			 * A waiter (first or not) can set the handoff bit
> +			 * if it is an RT task or wait in the wait queue
> +			 * for too long.
> +			 */
>   			if (has_handoff || (!rt_task(waiter->task) &&
>   					    !time_after(jiffies, waiter->timeout)))
>   				return false;
> @@ -651,11 +656,13 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>   
>   	/*
> -	 * We have either acquired the lock with handoff bit cleared or
> -	 * set the handoff bit.
> +	 * We have either acquired the lock with handoff bit cleared or set
> +	 * the handoff bit. Only the first waiter can have its handoff_set
> +	 * set here to enable optimistic spinning in slowpath loop.
>   	 */
>   	if (new & RWSEM_FLAG_HANDOFF) {
> -		waiter->handoff_set = true;
> +		if (waiter == first)
> +			waiter->handoff_set = true;
>   		lockevent_inc(rwsem_wlock_handoff);
>   		return false
>   	}
